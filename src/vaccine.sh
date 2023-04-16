#!/bin/bash

api="https://vaccine-api.skyreglis.com"
sign=null
vk_user_id=null
vk_ts=null
vk_ref=null
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"

function authenticate() {
	# 1 - sign: (string): <sign>
	# 2 - vk_user_id: (integer): <vk_user_id>
	# 3 - vk_ts: (integer): <vk_ts>
	# 4 - vk_ref: (string): <vk_ref>
	# 5 - access_token_settings: (string): <access_token_settings - default: >
	# 6 - are_notifications_enabled: (integer): <are_notifications_enabled: default: 0>
	# 7 - is_app_user: (integer): <is_app_user - default: 0>
	# 8 - is_favorite: (integer): <is_favorite - default: 0>
	# 9 - language: (string): <language - default: ru>
	# 10 - platform: (string): <platform - default: desktop_web>
	sign=$1
	vk_user_id=$2
	vk_ts=$3
	vk_ref=$4
	params="vk_access_token_settings=${5:-}&vk_app_id=51457526&vk_are_notifications_enabled=${6:-0}&vk_is_app_user=${7:-0}&vk_is_favorite=${8:-0}&vk_language=${9:-ru}&vk_platform=${10:-desktop_web}&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$vk_user_id&sign=$sign"
	echo $params
}

function get_account_info() {
	curl --request GET \
		--url "$api/v1/user" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params"
}

function get_account_profile() {
	curl --request GET \
		--url "$api/v2/profile" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params"
}

function get_rating() {
	# 1 - type: (string): <type>
	curl --request GET \
		--url "$api/v1/rating?type=$1" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params"
}

function get_levels() {
	curl --request GET \
		--url "$api/v1/levels" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params"
}

function get_improvement() {
	curl --request GET \
		--url "$api/v1/improvement" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params"
}

function buy_improvement() {
	# 1 - type: (string): <type>
	# 2 - count: (integer): <count - default: 1>
	# 2 - index: (integer): <index - default: 0>
	curl --request POST \
		--url "$api/v1/improvement/buy" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params" \
		--data '{
			"type": "'$1'",
			"count": '${2:-1}',
			"index": '${3:-0}'
		}'
}

function get_tasks() {
	curl --request GET \
		--url "$api/v1/task" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params"
}

function complete_task() {
	# 1 - type: (string): <type>
	curl --request POST \
		--url "$api/v1/task/complete" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "user: https://vaccine.skyreglis.com/master/?reglis_type=vk&reglis_platform=web&$params" \
		--data '{
			"type": "'$1'"
		}'
}
