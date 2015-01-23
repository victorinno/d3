library(DBI)
library(RMySQL)
library(rredis)
library(dplyr)
library(rjson)

function connectMysql(hash){
  params <- rawToChar(base64decode(base64encode(hash)))
  params <- strsplit(params, ",")
  
  con <- dbConnect(RMySQL::MySQL(),database=params[0], user=params[1], password=params[2], host=params[3])
  con
}

function connectRedis(oldHash, newHash, con){
  redisConnect()
  redisSet(oldHash,newHash)
}

function generateSampleData(){
  users <- data.frame(seq(1,100, 1))
  forums <- data.frame(id = seq(1,5,1), name = c("HELP", "INTRODUCTION", "R", "STATISTICAL","MACHINE LEARNING"))
  acesses <- data.frame(user=sample(1:100, 1000, replace=T), forum = sample(1:5, 1000, replace=T))
  result <- group_by(acesses, user) %>% summarise(total = n()) %>% arrange(desc(total))
}