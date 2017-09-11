#!/bin/bash

set -ex

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ] || [ "$4" = "" ] || [ "$5" = "" ]; then
  echo $0: usage: $0 concourse-target pipeline.yml config.yml credentials.yml pipeline-name
  exit
fi

concourse_target=$1
pipeline=$2
config=$3
credentials=$4
pipeline_name=$5

if [ ! -e  $pipeline ]; then
  echo $0: Pipeline file does not exist: $pipeline
  exit
fi

if [ ! -e  $config ]; then
  echo $0: Config file does not exist: $config
  exit
fi

if [ ! -e  $credentials ]; then
  echo $0: Credential file does not exist: $credentials
  exit
fi

fly -t $concourse_target set-pipeline -c $pipeline -l $credentials -l $config -p $pipeline_name -n

fly -t $concourse_target unpause-pipeline -p $pipeline_name
