Return-Path: <linux-kernel+bounces-554960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929ADA5A3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C105917417A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACA2343C1;
	Mon, 10 Mar 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAWXhFBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B6190674;
	Mon, 10 Mar 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635459; cv=none; b=Si5VZSkCzFalf6uBluHMS27G6WcKp3RJw+q6M7bmAMgVrVuyFDZ4k5AYaBh6nEnC1wlM5hNxSUaSsrHWRvt2K8h+YztdU90m2IHe4Vs7hWeLAdFgOCdE2REBqij6rz0Qon9b3W2NuKBZzNepZszHS5rhmXznT9nW3yhDSPWny44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635459; c=relaxed/simple;
	bh=xEMKIHmu+2gRmb+Pyq8ZExCZFMEVj0sSbEuEWp+Z8IY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vz5laV0uGfnPQywuUM77f64t95Ree3Db1x34DxK/ttj/+cAILRC0dTefMSocG12Xs6avuXRRfe0RmrKt2Nx8CjqC80WUNybvDU8e4gbHrfqCMWN6+hCSyXt+sDD6p2Qa0RGo+7g9615gQEOmeV+ILREXYclcZTa3wdhYc/lr604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAWXhFBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51847C4CEE5;
	Mon, 10 Mar 2025 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635459;
	bh=xEMKIHmu+2gRmb+Pyq8ZExCZFMEVj0sSbEuEWp+Z8IY=;
	h=From:To:Cc:Subject:Date:From;
	b=CAWXhFBYg0eAPpW0N6Iz5ggOGP6ziKpVu5fhOXkRZdLaJHS6GWdINyt/9bZaVd9L7
	 RGi5kH3T+iDvU+pDbs7/hMQwJC0SeFmqh8T06pvLyb1tHWCRhWHIVCO18CANxjdwlR
	 H8NjGtfprM2v5cBK6bkEiLL/H0v88E+7N5sxaeh0CV97Qr52pE7L01A0vbVwPmiE+J
	 uHH9oZp+5X6Aj8Ktt4iZpbpcEWdAVUBhMUkQr2jxQnPi3iozHwIXiX/Q2nS1zNYnj+
	 lMyXSu8wLp76HLghp+OD5aeplYGS2wJ56IMEIitKek5/cl44K0VRsAfKOm0mkbw857
	 tylybiztOgm7g==
From: Sasha Levin <sashal@kernel.org>
To: workflows@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC] check_imperative: pull requests should use imperative voice
Date: Mon, 10 Mar 2025 14:26:51 -0400
Message-Id: <20250310182651.174322-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new script that converts pull request descriptions to imperative voic=
e,
directly addressing Linus Torvalds' request regarding preferred writing sty=
le
for pull requests[1]. In that announcement, Linus specifically asked mainta=
iners
to use active voice and preferably imperative style in pull requests, notin=
g:

"I would ask maintainers to please use active voice, and preferably just
imperative [...] Instead write it as 'This fixes a NULL pointer dereference
in ..' or particularly if you just list bullet points, make the bullet point
just be 'Fix NULL pointer dereference in ..'"

This script provides an automated solution to this request, with flexibility
in how it can be deployed:

1. LLM provider options (--llm):
   - While commercial APIs are supported, they are entirely optional:
     * claude: Anthropic's Claude 3.7 Sonnet
     * openai: OpenAI's GPT-4o
     * huggingface: Use Meta's Llama 3.1 70B Instruct
   - Custom script integration (--llm /path/to/script):
     * Allows use of any open-source LLM (Llama3, Mistral, TinyLlama, etc.)
     * Can be used with local LLM runners like Ollama or llama.cpp
     * Custom hooks can implement specialized prompt engineering
     * No dependency on proprietary APIs or external services

2. Pull request processing (--pr):
   - Extracts change descriptions from git pull request emails
   - Supports multiple input formats:
     * Local email files
     * URLs to lore.kernel.org threads
     * Raw message-ids (e.g., 20250122112712.5c992f86@gandalf.local.home)
   - Processes base64-encoded emails
   - Optimizes by combining extraction and conversion in one LLM call

3. Additional features:
   - Debug mode (--debug): Shows full analysis with thinking process
   - Output file support: Saves results to specified file
   - Robust error handling for API calls and file operations

Examples:

* Processing a message-id directly:
  ./check_imperative.sh --pr 20250122112712.5c992f86@gandalf.local.home
  # Automatically converts to lore.kernel.org URL, downloads, and processes

* Using local open-source LLM via a custom script:
  ./check_imperative.sh --pr --llm ./my_ollama_script.sh pull_request.txt
  # Passes content to a script that could use any open-source LLM,
    local or remote.

* Analyzing a pull request URL with debugging enabled:
  ./check_imperative.sh --pr --debug https://lore.kernel.org/all/12345@exam=
ple.com/
  # Shows extraction process and thinking details

* Processing a local file and saving the output:
  ./check_imperative.sh --pr pull_request.txt imperative_output.txt
  # Saves the converted text to imperative_output.txt

The custom LLM script hook (--llm /path/to/script) is particularly valuable
for environments where internet access is limited or for those who prefer
to use open-source models. This ensures the tool remains useful even without
access to commercial APIs, aligning with the open-source nature of the kern=
el.

[1] https://lore.kernel.org/all/CAHk-=3DwgMS-TBfirwuxf+oFA3cTMWVLik=3Dw+mA5=
KdT9dAvcvhTA@mail.gmail.com/

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/check_imperative.sh | 633 ++++++++++++++++++++++++++++++++++++
 1 file changed, 633 insertions(+)
 create mode 100755 scripts/check_imperative.sh

diff --git a/scripts/check_imperative.sh b/scripts/check_imperative.sh
new file mode 100755
index 0000000000000..e0a1d5966c568
--- /dev/null
+++ b/scripts/check_imperative.sh
@@ -0,0 +1,633 @@
+#!/bin/bash
+
+# check_imperative.sh
+# This script checks if text is in imperative voice using various LLM prov=
iders
+# If not, it rewrites the text in imperative voice while preserving all de=
tails
+
+set -e
+
+# Display usage information
+usage()
+{
+	echo "Usage: $0 [--debug] [--pr] [--llm <provider_or_script>] <file_path|=
url|message-id> [output_file]"
+	echo "  --debug                 : Show full analysis including thinking p=
rocess"
+	echo "  --pr                    : Input is a git pull request email; extr=
act changes before converting"
+	echo "                            With --pr, you can provide:"
+	echo "                             - URL to a mailing list (e.g., lore.ke=
rnel.org)"
+	echo "                             - message-id (e.g., 20250122112712.5c9=
92f86@gandalf.local.home)"
+	echo "  --llm <provider_or_script> : LLM provider to use or custom script=
 path:"
+	echo "                           - claude (default): Use Claude 3.7 Sonne=
t"
+	echo "                           - openai: Use OpenAI GPT-4o"
+	echo "                           - huggingface: Use Meta's Llama 3.1 70B =
Instruct"
+	echo "                           - /path/to/script: Use custom script"
+	echo "  <file_path|url|message-id> : Path to the text file to check, URL =
to PR email, or message-id"
+	echo "  [output_file]           : Optional. Path to save the rewritten te=
xt (if needed)"
+	echo
+	echo "Environment variables:"
+	echo "  CLAUDE_API_KEY    : Required for Claude API access"
+	echo "  OPENAI_API_KEY    : Required for OpenAI API access"
+	echo "  HF_API_KEY        : Required for HuggingFace API access"
+	exit 1
+}
+
+# Check if required API key is set
+check_api_key()
+{
+	local provider=3D$1
+	local key_var=3D""
+	local key_name=3D""
+
+	case "$provider" in
+		claude)
+			key_var=3D"CLAUDE_API_KEY"
+			key_name=3D"Claude API key"
+			;;
+		openai)
+			key_var=3D"OPENAI_API_KEY"
+			key_name=3D"OpenAI API key"
+			;;
+		huggingface)
+			key_var=3D"HF_API_KEY"
+			key_name=3D"HuggingFace API key"
+			;;
+		*)
+			return 0 # No check needed for custom LLM
+			;;
+	esac
+
+	if [ -z "${!key_var}" ]; then
+		echo "Error: $key_var environment variable is not set"
+		echo "Please set your $key_name with: export $key_var=3D'your-api-key'"
+		exit 1
+	fi
+}
+
+# Parse command line arguments
+DEBUG_MODE=3Dfalse
+PR_MODE=3Dfalse
+PROVIDER=3D"claude"  # Default to Claude
+CUSTOM_LLM=3D""
+ARGS=3D()
+
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+		--debug)
+			DEBUG_MODE=3Dtrue
+			shift
+			;;
+		--pr)
+			PR_MODE=3Dtrue
+			shift
+			;;
+		--llm)
+			if [ -n "$2" ] && [[ "$2" !=3D -* ]]; then
+				case "$2" in
+					claude|openai|huggingface)
+						PROVIDER=3D"$2"
+						;;
+					*)
+						# Check if it's a file path (custom script)
+						if [ -f "$2" ]; then
+							PROVIDER=3D"custom"
+							CUSTOM_LLM=3D"$2"
+						else
+							echo "Error: Invalid LLM option '$2'. Must be claude, openai, huggi=
ngface, or a valid script path."
+							usage
+						fi
+						;;
+				esac
+				shift 2
+			else
+				echo "Error: --llm requires a provider name or script path"
+				usage
+			fi
+			;;
+		-h|--help)
+			usage
+			;;
+		*)
+			ARGS+=3D("$1")
+			shift
+			;;
+	esac
+done
+
+# Restore positional arguments
+set -- "${ARGS[@]}"
+
+# Check if required arguments are provided
+if [ $# -lt 1 ]; then
+	usage
+fi
+
+# Check if provider is valid
+if [[ ! "$PROVIDER" =3D~ ^(claude|openai|huggingface|custom)$ ]]; then
+	echo "Error: Invalid provider '$PROVIDER'. This is an internal error."
+	exit 1
+fi
+
+# Check if custom LLM script is executable
+if [ "$PROVIDER" =3D "custom" ]; then
+	if [ ! -x "$CUSTOM_LLM" ]; then
+		echo "Error: Custom LLM script '$CUSTOM_LLM' is not executable"
+		echo "Please make it executable with: chmod +x $CUSTOM_LLM"
+		exit 1
+	fi
+fi
+
+# Check if jq is installed
+if ! command -v jq &> /dev/null; then
+	echo "Error: This script requires 'jq' but it's not installed."
+	echo "Please install it using your package manager."
+	echo "For example: sudo apt install jq (Debian/Ubuntu) or brew install jq=
 (macOS)"
+	exit 1
+fi
+
+INPUT_FILE=3D"$1"
+OUTPUT_FILE=3D"${2:-}"
+
+# Handle URLs or message-ids for PR mode
+if [ "$PR_MODE" =3D true ]; then
+	# Check if input looks like a message-id (contains @ symbol but doesn't s=
tart with http)
+	if [[ "$INPUT_FILE" =3D=3D *@* ]] && [[ ! "$INPUT_FILE" =3D~ ^https?:// ]=
]; then
+		if [ "$DEBUG_MODE" =3D true ]; then
+			echo "Detected message-id: $INPUT_FILE"
+			echo "Converting to lore.kernel.org URL..."
+		fi
+
+		# Convert message-id to lore.kernel.org URL
+		INPUT_FILE=3D"https://lore.kernel.org/all/$INPUT_FILE/"
+
+		if [ "$DEBUG_MODE" =3D true ]; then
+			echo "Resolved URL: $INPUT_FILE"
+		fi
+	fi
+
+	# Now handle as URL if it starts with http/https
+	if [[ "$INPUT_FILE" =3D~ ^https?:// ]]; then
+		if [ "$DEBUG_MODE" =3D true ]; then
+			echo "Detected URL: $INPUT_FILE"
+			echo "Downloading email content..."
+		fi
+
+		# Create a temporary file for the URL content
+		TEMP_FILE=3D$(mktemp /tmp/check_imperative.XXXXXX)
+
+		# Download the URL content
+		if ! curl -s -L "$INPUT_FILE" > "$TEMP_FILE"; then
+			echo "Error: Failed to download URL: $INPUT_FILE"
+			rm -f "$TEMP_FILE"
+			exit 1
+		fi
+
+		# Check if the download succeeded and has content
+		if [ ! -s "$TEMP_FILE" ]; then
+			echo "Error: Downloaded file is empty. Please check the URL: $INPUT_FIL=
E"
+			rm -f "$TEMP_FILE"
+			exit 1
+		fi
+
+		if [ "$DEBUG_MODE" =3D true ]; then
+			echo "Downloaded $(wc -l < "$TEMP_FILE") lines from URL"
+		fi
+
+		# Use the downloaded file as input
+		INPUT_FILE=3D"$TEMP_FILE"
+		URL_CLEANUP_NEEDED=3Dtrue
+	else
+		# Check if input file exists (for non-URL inputs)
+		if [ ! -f "$INPUT_FILE" ]; then
+			echo "Error: Input file '$INPUT_FILE' not found"
+			exit 1
+		fi
+		URL_CLEANUP_NEEDED=3Dfalse
+	fi
+else
+	# For non-PR mode, just check if the file exists
+	if [ ! -f "$INPUT_FILE" ]; then
+		echo "Error: Input file '$INPUT_FILE' not found"
+		exit 1
+	fi
+	URL_CLEANUP_NEEDED=3Dfalse
+fi
+
+# Check if appropriate API key is set (not needed for custom LLM)
+if [ "$PROVIDER" !=3D "custom" ]; then
+	check_api_key "$PROVIDER"
+fi
+
+# Read the content of the input file
+FILE_CONTENT=3D$(cat "$INPUT_FILE")
+
+# Clean up temporary URL file if needed
+if [ "$URL_CLEANUP_NEEDED" =3D true ]; then
+	rm -f "$INPUT_FILE"
+fi
+
+# If in PR mode, extract and convert the relevant changes at once
+if [ "$PR_MODE" =3D true ]; then
+	if [ "$DEBUG_MODE" =3D true ]; then
+		echo "Extracting changes from pull request email and converting to imper=
ative voice..."
+	fi
+
+	# Combined prompt that extracts changes and converts to imperative voice =
in one call
+	COMBINED_PROMPT=3D"This is a git pull request email. Please perform two t=
asks:
+
+1. First, extract ONLY the portion that describes the actual code changes.=
 Look for a bulleted list of changes that follows the pull request introduc=
tion. Do not include any other parts of the email such as commit logs, file=
 changes, or metadata.
+
+2. Then, rewrite the extracted text in imperative voice, being EXTREMELY c=
areful not to omit ANY details from the original text. Your rewritten text =
MUST include EVERY SINGLE detail, concept, qualifier, number, and piece of =
information from the original.
+
+Format your response like this:
+<extracted>
+... The extracted text here ...
+</extracted>
+
+<thinking>
+... Your thought process for the imperative voice conversion here ...
+</thinking>
+
+<rewritten>
+... The rewritten text in imperative voice here ...
+</rewritten>"
+
+	case "$PROVIDER" in
+		claude)
+			# Prepare request for Claude
+			PR_BODY=3D$(cat <<EOF
+{
+    "model": "claude-3-sonnet-20240229",
+    "max_tokens": 4000,
+    "system": "You are a helpful assistant that extracts relevant changes =
from Git pull request emails and converts them to imperative voice.",
+    "messages": [
+        {
+            "role": "user",
+            "content": "${COMBINED_PROMPT}\n\n$(echo "$FILE_CONTENT" | jq =
-Rs . | sed 's/^"//;s/"$//')"
+        }
+    ],
+    "temperature": 0.3
+}
+EOF
+)
+
+			PR_RESPONSE=3D$(curl -s -w "\n%{http_code}" https://api.anthropic.com/v=
1/messages \
+				-H "x-api-key: $CLAUDE_API_KEY" \
+				-H "anthropic-version: 2023-06-01" \
+				-H "content-type: application/json" \
+				-d "$PR_BODY")
+
+			# Split response into body and status code
+			PR_HTTP_BODY=3D$(echo "$PR_RESPONSE" | sed '$ d')
+			PR_HTTP_STATUS=3D$(echo "$PR_RESPONSE" | tail -n1)
+
+			# Check if the request was successful
+			if [ "$PR_HTTP_STATUS" -ne 200 ]; then
+				echo "Error from Claude API (Status: $PR_HTTP_STATUS):"
+				echo "$PR_HTTP_BODY" | jq . 2>/dev/null || echo "$PR_HTTP_BODY"
+				exit 1
+			fi
+
+			COMBINED_RESULT=3D$(echo "$PR_HTTP_BODY" | jq -r '.content[0].text' 2>/=
dev/null)
+			;;
+
+		openai)
+			# Prepare request for OpenAI
+			PR_BODY=3D$(cat <<EOF
+{
+    "model": "gpt-4o",
+    "max_tokens": 4000,
+    "temperature": 0.3,
+    "messages": [
+        {
+            "role": "system",
+            "content": "You are a helpful assistant that extracts relevant=
 changes from Git pull request emails and converts them to imperative voice=
."
+        },
+        {
+            "role": "user",
+            "content": "${COMBINED_PROMPT}\n\n$(echo "$FILE_CONTENT" | jq =
-Rs . | sed 's/^"//;s/"$//')"
+        }
+    ]
+}
+EOF
+)
+
+			PR_RESPONSE=3D$(curl -s -w "\n%{http_code}" https://api.openai.com/v1/c=
hat/completions \
+				-H "Authorization: Bearer $OPENAI_API_KEY" \
+				-H "Content-Type: application/json" \
+				-d "$PR_BODY")
+
+			# Split response into body and status code
+			PR_HTTP_BODY=3D$(echo "$PR_RESPONSE" | sed '$ d')
+			PR_HTTP_STATUS=3D$(echo "$PR_RESPONSE" | tail -n1)
+
+			# Check if the request was successful
+			if [ "$PR_HTTP_STATUS" -ne 200 ]; then
+				echo "Error from OpenAI API (Status: $PR_HTTP_STATUS):"
+				echo "$PR_HTTP_BODY" | jq . 2>/dev/null || echo "$PR_HTTP_BODY"
+				exit 1
+			fi
+
+			COMBINED_RESULT=3D$(echo "$PR_HTTP_BODY" | jq -r '.choices[0].message.c=
ontent' 2>/dev/null)
+			;;
+
+		huggingface)
+			# Prepare request for HuggingFace
+			PR_BODY=3D$(cat <<EOF
+{
+    "inputs": "System: You are a helpful assistant that extracts relevant =
changes from Git pull request emails and converts them to imperative voice.=
\n\nUser: ${COMBINED_PROMPT}\n\n$(echo "$FILE_CONTENT" | jq -Rs . | sed 's/=
^"//;s/"$//')\n\nAssistant:",
+    "parameters": {
+        "temperature": 0.3,
+        "max_new_tokens": 4000,
+        "return_full_text": false
+    }
+}
+EOF
+)
+
+			PR_RESPONSE=3D$(curl -s -w "\n%{http_code}" https://api-inference.huggi=
ngface.co/models/meta-llama/Meta-Llama-3.1-70B-Instruct \
+				-H "Authorization: Bearer $HF_API_KEY" \
+				-H "Content-Type: application/json" \
+				-d "$PR_BODY")
+
+			# Split response into body and status code
+			PR_HTTP_BODY=3D$(echo "$PR_RESPONSE" | sed '$ d')
+			PR_HTTP_STATUS=3D$(echo "$PR_RESPONSE" | tail -n1)
+
+			# Check if the request was successful
+			if [ "$PR_HTTP_STATUS" -ne 200 ]; then
+				echo "Error from HuggingFace API (Status: $PR_HTTP_STATUS):"
+				echo "$PR_HTTP_BODY" | jq . 2>/dev/null || echo "$PR_HTTP_BODY"
+				exit 1
+			fi
+
+			COMBINED_RESULT=3D$(echo "$PR_HTTP_BODY" | jq -r '.generated_text' 2>/d=
ev/null)
+			;;
+
+		custom)
+			# Use custom script with combined extraction and conversion
+			COMBINED_RESULT=3D$("$CUSTOM_LLM" "$FILE_CONTENT" "extract_and_convert")
+			;;
+	esac
+
+	# Check if extraction and conversion was successful
+	if [ -z "$COMBINED_RESULT" ]; then
+		echo "Error: Failed to process the pull request email."
+		exit 1
+	fi
+
+	# In debug mode, display both extracted and rewritten text
+	if [ "$DEBUG_MODE" =3D true ]; then
+		# Extract the extracted text
+		EXTRACTED_TEXT=3D$(echo "$COMBINED_RESULT" | sed -n '/<extracted>/,/<\/e=
xtracted>/p' | sed 's/<extracted>//;s/<\/extracted>//')
+
+		echo -e "\nExtracted Changes:"
+		echo "-------------------"
+		echo "$EXTRACTED_TEXT"
+		echo "-------------------"
+
+		echo -e "\nImperative Voice Conversion (Combined Processing):"
+		echo "-------------------"
+		echo "$COMBINED_RESULT"
+		echo "-------------------"
+	fi
+
+	# Extract just the rewritten text for normal mode
+	REWRITTEN_TEXT=3D$(echo "$COMBINED_RESULT" | sed -n '/<rewritten>/,/<\/re=
written>/p' | sed 's/<rewritten>//;s/<\/rewritten>//')
+
+	# If no rewritten text was found, use a fallback
+	if [ -z "$REWRITTEN_TEXT" ]; then
+		# If no rewritten text tags are found, clean and use the whole response
+		CLEANED_RESPONSE=3D$(echo "$COMBINED_RESULT" | sed 's/<[^>]*>//g' | sed =
'/^$/d')
+		echo "$CLEANED_RESPONSE"
+	else
+		# Output only the rewritten text
+		echo -e "$REWRITTEN_TEXT"
+	fi
+
+	# If output file is specified, save the appropriate content
+	if [ -n "$OUTPUT_FILE" ]; then
+		if [ "$DEBUG_MODE" =3D true ]; then
+			# Save the full response in debug mode
+			echo "$COMBINED_RESULT" > "$OUTPUT_FILE"
+			echo -e "\nOutput saved to: $OUTPUT_FILE"
+		else
+			# Save only the rewritten text in normal mode
+			if [ -n "$REWRITTEN_TEXT" ]; then
+				echo "$REWRITTEN_TEXT" > "$OUTPUT_FILE"
+			else
+				echo "$CLEANED_RESPONSE" > "$OUTPUT_FILE"
+			fi
+			echo -e "\nOutput saved to: $OUTPUT_FILE"
+		fi
+	fi
+
+	exit 0  # Exit after PR processing is complete
+else
+	# Original flow for non-PR mode
+	# Show what we're doing, but only in debug mode
+	if [ "$DEBUG_MODE" =3D true ]; then
+		echo "Checking if the text is in imperative voice using $PROVIDER..."
+		echo "This may take a moment..."
+	fi
+
+	# Properly escape the file content for JSON
+	# Convert the file content to a JSON-encoded string using jq
+	ESCAPED_CONTENT=3D$(echo "$FILE_CONTENT" | jq -Rs .)
+
+	# Function to call Claude API
+	call_claude()
+	{
+		# Save the request to a temporary file for debugging
+		REQUEST_BODY=3D$(cat <<EOF
+{
+    "model": "claude-3-sonnet-20240229",
+    "max_tokens": 4000,
+    "system": "You are an expert at identifying writing styles and convert=
ing text to imperative voice. Your task is to determine if the provided tex=
t is written in imperative voice. If not, rewrite it in imperative voice, b=
eing EXTREMELY careful not to omit ANY details from the original. The rewri=
tten text must not lose any information whatsoever - every technical term, =
parameter, implementation detail, number and concept must be preserved. Mak=
e sure to show your thinking process by including a <thinking>...</thinking=
> section and wrap your rewritten text with <rewritten>...</rewritten> tags=
:\n\n${ESCAPED_CONTENT:1:-1}"
+        }
+    ],
+    "temperature": 0.3
+}
+EOF
+)
+
+		RESPONSE=3D$(curl -s -w "\n%{http_code}" https://api.anthropic.com/v1/me=
ssages \
+			-H "x-api-key: $CLAUDE_API_KEY" \
+			-H "anthropic-version: 2023-06-01" \
+			-H "content-type: application/json" \
+			-d "$REQUEST_BODY")
+
+		# Split response into body and status code
+		HTTP_BODY=3D$(echo "$RESPONSE" | sed '$ d')
+		HTTP_STATUS=3D$(echo "$RESPONSE" | tail -n1)
+
+		# Check if the request was successful
+		if [ "$HTTP_STATUS" -ne 200 ]; then
+			echo "Error from Claude API (Status: $HTTP_STATUS):"
+			echo "$HTTP_BODY" | jq . 2>/dev/null || echo "$HTTP_BODY"
+			exit 1
+		fi
+
+		# Extract the assistant's response
+		echo "$HTTP_BODY" | jq -r '.content[0].text' 2>/dev/null
+	}
+
+	# Function to call OpenAI API
+	call_openai()
+	{
+		# Prepare the OpenAI API request
+		REQUEST_BODY=3D$(cat <<EOF
+{
+    "model": "gpt-4o",
+    "max_tokens": 4000,
+    "temperature": 0.3,
+    "messages": [
+        {
+            "role": "system",
+            "content": "You are an expert at identifying writing styles an=
d converting text to imperative voice. Your task is to determine if the pro=
vided text is written in imperative voice. If not, rewrite it in imperative=
 voice, being EXTREMELY careful not to omit ANY details from the original t=
ext. Your rewritten text MUST include EVERY SINGLE detail, concept, qualifi=
er, number, and piece of information from the original. This is CRITICALLY =
important. If the original mentions specific technical terms, parameters, o=
ptions, or implementation details, ALL of these MUST be present in your rew=
ritten version. Explain your thinking thoroughly. IMPORTANT: Before giving =
your final answer, think through your analysis step by step in a section la=
beled \"<thinking>...</thinking>\". After your thinking section, start your=
 rewritten text with \"<rewritten>\" and end it with \"</rewritten>\"."
+        },
+        {
+            "role": "user",
+            "content": "Analyze this text and determine if it is written i=
n imperative voice. If it is not in imperative voice, please rewrite it mai=
ntaining LITERALLY EVERY DETAIL from the original. The rewritten text must =
not lose any information whatsoever - every technical term, parameter, impl=
ementation detail, number and concept must be preserved. Make sure to show =
your thinking process by including a <thinking>...</thinking> section and w=
rap your rewritten text with <rewritten>...</rewritten> tags:\n\n${ESCAPED_=
CONTENT:1:-1}"
+        }
+    ]
+}
+EOF
+)
+
+		# Call the OpenAI API
+		RESPONSE=3D$(curl -s -w "\n%{http_code}" https://api.openai.com/v1/chat/=
completions \
+			-H "Authorization: Bearer $OPENAI_API_KEY" \
+			-H "Content-Type: application/json" \
+			-d "$REQUEST_BODY")
+
+		# Split response into body and status code
+		HTTP_BODY=3D$(echo "$RESPONSE" | sed '$ d')
+		HTTP_STATUS=3D$(echo "$RESPONSE" | tail -n1)
+
+		# Check if the request was successful
+		if [ "$HTTP_STATUS" -ne 200 ]; then
+			echo "Error from OpenAI API (Status: $HTTP_STATUS):"
+			echo "$HTTP_BODY" | jq . 2>/dev/null || echo "$HTTP_BODY"
+			exit 1
+		fi
+
+		# Extract the assistant's response
+		echo "$HTTP_BODY" | jq -r '.choices[0].message.content' 2>/dev/null
+	}
+
+	# Function to call HuggingFace API
+	call_huggingface()
+	{
+		# Prepare the HuggingFace API request - using Llama 3.1 70B Instruct
+		REQUEST_BODY=3D$(cat <<EOF
+{
+    "inputs": "System: You are an expert at identifying writing styles and=
 converting text to imperative voice. Your task is to determine if the prov=
ided text is written in imperative voice. If not, rewrite it in imperative =
voice, being EXTREMELY careful not to omit ANY details from the original te=
xt. Your rewritten text MUST include EVERY SINGLE detail, concept, qualifie=
r, number, and piece of information from the original. This is CRITICALLY i=
mportant. If the original mentions specific technical terms, parameters, op=
tions, or implementation details, ALL of these MUST be present in your rewr=
itten version. Explain your thinking thoroughly. IMPORTANT: Before giving y=
our final answer, think through your analysis step by step in a section lab=
eled \"<thinking>...</thinking>\". After your thinking section, start your =
rewritten text with \"<rewritten>\" and end it with \"</rewritten>\".\n\nUs=
er: Analyze this text and determine if it is written in imperative voice. I=
f it is not in imperative voice, please rewrite it maintaining LITERALLY EV=
ERY DETAIL from the original. The rewritten text must not lose any informat=
ion whatsoever - every technical term, parameter, implementation detail, nu=
mber and concept must be preserved. Make sure to show your thinking process=
 by including a <thinking>...</thinking> section and wrap your rewritten te=
xt with <rewritten>...</rewritten> tags:\n\n${ESCAPED_CONTENT:1:-1}\n\nAssi=
stant:",
+    "parameters": {
+        "temperature": 0.3,
+        "max_new_tokens": 4000,
+        "return_full_text": false
+    }
+}
+EOF
+)
+
+		# Call the HuggingFace API using Llama 3.1 70B Instruct
+		RESPONSE=3D$(curl -s -w "\n%{http_code}" https://api-inference.huggingfa=
ce.co/models/meta-llama/Meta-Llama-3.1-70B-Instruct \
+			-H "Authorization: Bearer $HF_API_KEY" \
+			-H "Content-Type: application/json" \
+			-d "$REQUEST_BODY")
+
+		# Split response into body and status code
+		HTTP_BODY=3D$(echo "$RESPONSE" | sed '$ d')
+		HTTP_STATUS=3D$(echo "$RESPONSE" | tail -n1)
+
+		# Check if the request was successful
+		if [ "$HTTP_STATUS" -ne 200 ]; then
+			echo "Error from HuggingFace API (Status: $HTTP_STATUS):"
+			echo "$HTTP_BODY" | jq . 2>/dev/null || echo "$HTTP_BODY"
+			exit 1
+		fi
+
+		# Extract the generated text
+		echo "$HTTP_BODY" | jq -r '.generated_text' 2>/dev/null
+	}
+
+	# Function to call a custom LLM script
+	call_custom_llm()
+	{
+		# Call the custom script and pass the escaped content
+		# The custom script should handle the API call and return the response
+		"$CUSTOM_LLM" "$FILE_CONTENT"
+
+		# Check if the script execution was successful
+		if [ $? -ne 0 ]; then
+			echo "Error: Custom LLM script failed"
+			exit 1
+		fi
+	}
+
+	# Call the appropriate provider
+	case "$PROVIDER" in
+		claude)
+			ASSISTANT_RESPONSE=3D$(call_claude)
+			;;
+		openai)
+			ASSISTANT_RESPONSE=3D$(call_openai)
+			;;
+		huggingface)
+			ASSISTANT_RESPONSE=3D$(call_huggingface)
+			;;
+		custom)
+			ASSISTANT_RESPONSE=3D$(call_custom_llm)
+			;;
+	esac
+
+	# Process the response based on debug mode
+	if [ "$DEBUG_MODE" =3D true ]; then
+		# Display the full response in debug mode
+		echo -e "\nLLM Analysis (using $PROVIDER):"
+		echo "-------------------"
+		echo "$ASSISTANT_RESPONSE"
+		echo "-------------------"
+	else
+		# Extract only the rewritten text between <rewritten> and </rewritten> t=
ags
+		REWRITTEN_TEXT=3D$(echo "$ASSISTANT_RESPONSE" | sed -n '/<rewritten>/,/<=
\/rewritten>/p' | sed 's/<rewritten>//;s/<\/rewritten>//')
+
+		# If no rewritten text was found, check if the text was already in imper=
ative voice
+		if [ -z "$REWRITTEN_TEXT" ]; then
+			if echo "$ASSISTANT_RESPONSE" | grep -q "already in imperative voice"; =
then
+				echo -e "\nThe text is already in imperative voice. No rewriting neede=
d."
+				echo -e "\nOriginal text:"
+				echo "$FILE_CONTENT"
+			else
+				# If no rewritten text tags are found and it's not already in imperati=
ve voice,
+				# remove all tags and output as a fallback
+				CLEANED_RESPONSE=3D$(echo "$ASSISTANT_RESPONSE" | sed 's/<[^>]*>//g' |=
 sed '/^$/d')
+				echo "$CLEANED_RESPONSE"
+			fi
+		else
+			# Output only the rewritten text
+			echo -e "$REWRITTEN_TEXT"
+		fi
+	fi
+
+	# If output file is specified, save the appropriate content
+	if [ -n "$OUTPUT_FILE" ]; then
+		if [ "$DEBUG_MODE" =3D true ]; then
+			# Save the full response in debug mode
+			echo "$ASSISTANT_RESPONSE" > "$OUTPUT_FILE"
+			echo -e "\nOutput saved to: $OUTPUT_FILE"
+		else
+			# Save only the rewritten text in normal mode
+			if [ -n "$REWRITTEN_TEXT" ]; then
+				echo "$REWRITTEN_TEXT" > "$OUTPUT_FILE"
+			else
+				# If no rewritten text was found, save the original content
+				echo "$FILE_CONTENT" > "$OUTPUT_FILE"
+			fi
+		fi
+	fi
+
+	if [ "$DEBUG_MODE" =3D true ]; then
+		echo -e "\nDone!"
+	fi
+fi
--=20
2.39.5


