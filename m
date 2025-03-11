Return-Path: <linux-kernel+bounces-556530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13FFA5CB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719B03B8AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADB260A33;
	Tue, 11 Mar 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvc+4+0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF325E818;
	Tue, 11 Mar 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712027; cv=none; b=RzxHUqeLy128cWjRvMN0hC0mtkf8sVAV06dLhSHhwr+eg/5+LvQBHEgr9gHH40dcMnx1lkJDdDNtDVtmRheKYehtmg3rSReqZilK7bnjitjF9QW7el3Ec9VD2Nc+bQ1sCew9sREfPCXWocE8+rMqGpZOnjVERi6+6YzJ4GJwYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712027; c=relaxed/simple;
	bh=PwmyiwWj5CkqBXwksTcHrCsjtGwDUXY0Pqgb7toQ+Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QCc2mZKK9TFCfHvxhP8IWGD83PojjwMNQ7Tf7Oc/RLxxboMcVOT+uX1YSTQV/vTe26u6PcOoqbMW+BXf1nBMj+kjAR3yhJmoSWkYWa0k1P7uO1eMNZayNhh+GMCvBt5QF0dJPYhVVFuU5PlNMpbH3PcPNhIAQ1PBfvwzPx5UvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvc+4+0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE75C4CEE9;
	Tue, 11 Mar 2025 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741712026;
	bh=PwmyiwWj5CkqBXwksTcHrCsjtGwDUXY0Pqgb7toQ+Xk=;
	h=From:To:Cc:Subject:Date:From;
	b=Uvc+4+0zHeg34G0Bav2KvqLvdnpjNChvBmmvWb3bMm2aUubh6KD65CWHcYyTbx/ay
	 0D0FMQ4lCcb5+MbFZrepvTRH+UnbnUc8Hhnq0CwHzgDBeXvvN6s69vTmA/vIBFeysG
	 9ebDiBajMg2ihEq42Ot1k7YOnyPZiux0R6ZMn5iAaExxTPF8JdNuEeaUSgKWVu2E8A
	 uiTxz3Ofw53b9ab2rbLzcrQOWPhF/dDVdEX2H5Ebfficwtnp8EHL/m9eb9QGoHgDfd
	 47vWOleDdHaQZwn0RqtAEu8+3er6iLM8QGH/5BkXjIBzReqz5x+OjE60ybRKu+BfQF
	 vat7Jw36agkjQ==
From: Sasha Levin <sashal@kernel.org>
To: workflows@vger.kernel.org
Cc: apw@canonical.com,
	conor@kernel.org,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	geert+renesas@glider.be,
	gitster@pobox.com,
	horms@kernel.org,
	joe@perches.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	lukas.bulwahn@gmail.com,
	miguel.ojeda.sandonis@gmail.com,
	niklas.soderlund@corigine.com,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] scripts: Add git-resolve tool for full SHA-1 resolution
Date: Tue, 11 Mar 2025 12:53:36 -0400
Message-Id: <20250311165336.248120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce git-resolve.sh, a tool that resolves short git commit IDs to their
full SHA-1 hash. This is particularly useful for navigating references in commit
messages and verifying Fixes tags.

When faced with ambiguous commit IDs or imprecise references in messages,
this tool can help by resolving commit hashes based on not just the ID
itself but also the commit subject, making it more robust than standard
git rev-parse.

This is especially valuable for maintainers who need to verify Fixes tags
or cross-reference commits. Unlike proposals to add dates to Fixes tags
(which would break existing tooling), this script provides a way to
disambiguate commits without changing the established tag format.

The script includes several features:
- Resolves short commit IDs to full SHA-1 hashes
- Uses commit subjects to disambiguate between multiple potential matches
- Supports wildcard patterns in subjects with ellipsis (...)
- Provides a force mode to attempt resolution by subject when ID lookup fails
- Includes comprehensive self-tests

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/git-resolve.sh | 199 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100755 scripts/git-resolve.sh

diff --git a/scripts/git-resolve.sh b/scripts/git-resolve.sh
new file mode 100755
index 0000000000000..204a8c9bd4ea8
--- /dev/null
+++ b/scripts/git-resolve.sh
@@ -0,0 +1,199 @@
+#!/bin/bash
+
+usage() {
+	echo "Usage: $(basename "$0") [--selftest] [--force] <commit-id> [commit-subject]"
+	echo "Resolves a short git commit ID to its full SHA-1 hash, particularly useful for fixing references in commit messages."
+	echo ""
+	echo "Arguments:"
+	echo "  --selftest      Run self-tests"
+	echo "  --force         Try to find commit by subject if ID lookup fails"
+	echo "  commit-id       Short git commit ID to resolve"
+	echo "  commit-subject  Optional commit subject to help resolve between multiple matches"
+	exit 1
+}
+
+# Convert subject with ellipsis to grep pattern
+convert_to_grep_pattern() {
+	local subject="$1"
+	# First escape ALL regex special characters
+	local escaped_subject
+	escaped_subject=$(printf '%s\n' "$subject" | sed 's/[[\.*^$()+?{}|]/\\&/g')
+	# Also escape colons, parentheses, and hyphens as they are special in our context
+	escaped_subject=$(echo "$escaped_subject" | sed 's/[:-]/\\&/g')
+	# Then convert escaped ... sequence to .*?
+	escaped_subject=$(echo "$escaped_subject" | sed 's/\\\.\\\.\\\./.*?/g')
+	echo "^${escaped_subject}$"
+}
+
+git_resolve_commit() {
+	local force=0
+	if [ "$1" = "--force" ]; then
+		force=1
+		shift
+	fi
+
+	# Split input into commit ID and subject
+	local input="$*"
+	local commit_id="${input%% *}"
+	local subject=""
+
+	# Extract subject if present (everything after the first space)
+	if [[ "$input" == *" "* ]]; then
+		subject="${input#* }"
+		# Strip the ("...") quotes if present
+		subject="${subject#*(\"}"
+		subject="${subject%\")*}"
+	fi
+
+	# Get all possible matching commit IDs
+	local matches
+	readarray -t matches < <(git rev-parse --disambiguate="$commit_id" 2>/dev/null)
+
+	# Return immediately if we have exactly one match
+	if [ ${#matches[@]} -eq 1 ]; then
+		echo "${matches[0]}"
+		return 0
+	fi
+
+	# If no matches and not in force mode, return failure
+	if [ ${#matches[@]} -eq 0 ] && [ $force -eq 0 ]; then
+		return 1
+	fi
+
+	# If we have a subject, try to find a match with that subject
+	if [ -n "$subject" ]; then
+		# Convert subject with possible ellipsis to grep pattern
+		local grep_pattern
+		grep_pattern=$(convert_to_grep_pattern "$subject")
+
+		# In force mode with no ID matches, use git log --grep directly
+		if [ ${#matches[@]} -eq 0 ] && [ $force -eq 1 ]; then
+			# Use git log to search, but filter to ensure subject matches exactly
+			local match
+			match=$(git log --format="%H %s" --grep="$grep_pattern" --perl-regexp -10 | \
+					while read -r hash subject; do
+						if echo "$subject" | grep -qP "$grep_pattern"; then
+							echo "$hash"
+							break
+						fi
+					done)
+			if [ -n "$match" ]; then
+				echo "$match"
+				return 0
+			fi
+		else
+			# Normal subject matching for existing matches
+			for match in "${matches[@]}"; do
+				if git log -1 --format="%s" "$match" | grep -qP "$grep_pattern"; then
+					echo "$match"
+					return 0
+				fi
+			done
+		fi
+	fi
+
+	# No match found
+	return 1
+}
+
+run_selftest() {
+	local test_cases=(
+		'00250b5 ("MAINTAINERS: add new Rockchip SoC list")'
+		'0037727 ("KVM: selftests: Convert xen_shinfo_test away from VCPU_ID")'
+		'ffef737 ("net/tls: Fix skb memory leak when running kTLS traffic")'
+		'd3d7 ("cifs: Improve guard for excluding $LXDEV xattr")'
+		'dbef ("Rename .data.once to .data..once to fix resetting WARN*_ONCE")'
+		'12345678'  # Non-existent commit
+		'12345 ("I'\''m a dummy commit")'  # Valid prefix but wrong subject
+		'--force 99999999 ("net/tls: Fix skb memory leak when running kTLS traffic")'  # Force mode with non-existent ID but valid subject
+		'83be ("firmware: ... auto-update: fix poll_complete() ... errors")'  # Wildcard test
+		'--force 999999999999 ("firmware: ... auto-update: fix poll_complete() ... errors")'  # Force mode wildcard test
+	)
+
+	local expected=(
+		"00250b529313d6262bb0ebbd6bdf0a88c809f6f0"
+		"0037727b3989c3fe1929c89a9a1dfe289ad86f58"
+		"ffef737fd0372ca462b5be3e7a592a8929a82752"
+		"d3d797e326533794c3f707ce1761da7a8895458c"
+		"dbefa1f31a91670c9e7dac9b559625336206466f"
+		""  # Expect empty output for non-existent commit
+		""  # Expect empty output for wrong subject
+		"ffef737fd0372ca462b5be3e7a592a8929a82752"  # Should find commit by subject in force mode
+		"83beece5aff75879bdfc6df8ba84ea88fd93050e"  # Wildcard test
+		"83beece5aff75879bdfc6df8ba84ea88fd93050e"  # Force mode wildcard test
+	)
+
+	local expected_exit_codes=(
+		0
+		0
+		0
+		0
+		0
+		1  # Expect failure for non-existent commit
+		1  # Expect failure for wrong subject
+		0  # Should succeed in force mode
+		0  # Should succeed with wildcard
+		0  # Should succeed with force mode and wildcard
+	)
+
+	local failed=0
+
+	echo "Running self-tests..."
+	for i in "${!test_cases[@]}"; do
+		# Capture both output and exit code
+		local result
+		result=$(git_resolve_commit ${test_cases[$i]})  # Removed quotes to allow --force to be parsed
+		local exit_code=$?
+
+		# Check both output and exit code
+		if [ "$result" != "${expected[$i]}" ] || [ $exit_code != ${expected_exit_codes[$i]} ]; then
+			echo "Test case $((i+1)) FAILED"
+			echo "Input: ${test_cases[$i]}"
+			echo "Expected output: '${expected[$i]}'"
+			echo "Got output: '$result'"
+			echo "Expected exit code: ${expected_exit_codes[$i]}"
+			echo "Got exit code: $exit_code"
+			failed=1
+		else
+			echo "Test case $((i+1)) PASSED"
+		fi
+	done
+
+	if [ $failed -eq 0 ]; then
+		echo "All tests passed!"
+		exit 0
+	else
+		echo "Some tests failed!"
+		exit 1
+	fi
+}
+
+# Check for selftest
+if [ "$1" = "--selftest" ]; then
+	run_selftest
+	exit $?
+fi
+
+# Handle --force flag
+force=""
+if [ "$1" = "--force" ]; then
+	force="--force"
+	shift
+fi
+
+# Verify arguments
+if [ $# -eq 0 ]; then
+	usage
+fi
+
+# Skip validation in force mode
+if [ -z "$force" ]; then
+	# Validate that the first argument matches at least one git commit
+	if [ "$(git rev-parse --disambiguate="$1" 2>/dev/null | wc -l)" -eq 0 ]; then
+		echo "Error: '$1' does not match any git commit"
+		exit 1
+	fi
+fi
+
+git_resolve_commit $force "$@"
+exit $?
-- 
2.39.5


