Return-Path: <linux-kernel+bounces-577187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBFA7199E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2323BFA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAE1F540F;
	Wed, 26 Mar 2025 14:55:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF01F4194
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000918; cv=none; b=FqRp4MUfRxpcbjuQ597MeuX3+/JTpGX7lbYQdpx7l4tKxcOVLq/C87bKZC4/g/1Dv+sVcBLQjGF9/FJs5eAOaZv+7T7LTb2LB9CasI3cHcIh0DoiYZR1BGYezun4O/CKktiBrAqXq6VOYzsGG6roJdS5VXrp7Qu6NfPe5iRN5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000918; c=relaxed/simple;
	bh=f8Go/Lf6eKTKK3ZOLvtfyqYnJK+Xb1Uz/4HbbTR++Tw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iOnYKPdjRP/mJEQeFdzLDoBs0OzD50DWqjQx19bkqY7jbAAKn5BHQ4KQj3DeUY6G/x3kXQGDPetl7z3JGEmvAI6Wq9j4CAyVjZjRvbUo8ph61EZeOqXyIRMsmuaZyXSw08fdWgnjJq/nzfB9bqh/l+teJHkKtUmaBjXg37e9cHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2034CC4CEF6;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAm-00000002kFY-45d0;
	Wed, 26 Mar 2025 10:56:04 -0400
Message-ID: <20250326145604.825747992@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 7/9] rtla/tests: Reset osnoise options before check
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Remove any dangling tracing instances from previous improperly exited
runs of rtla, and reset osnoise options to default before running a test
case.

This ensures that the test results are deterministic. Specific test
cases checked that rtla behaves correctly even when the tracer state is
not clean will be added later.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250320092500.101385-6-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/engine.sh | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 64d0446dc28e..5db8aa4bc031 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -8,12 +8,44 @@ test_begin() {
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
 }
 
+reset_osnoise() {
+	# Reset osnoise options to default and remove any dangling instances created
+	# by improperly exited rtla runs.
+	pushd /sys/kernel/tracing || return 1
+
+	# Remove dangling instances created by previous rtla run
+	echo 0 > tracing_thresh
+	cd instances
+	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist
+	do
+		[ ! -d "$i" ] && continue
+		rmdir "$i"
+	done
+
+	# Reset options to default
+	# Note: those are copied from the default values of osnoise_data
+	# in kernel/trace/trace_osnoise.c
+	cd ../osnoise
+	echo all > cpus
+	echo DEFAULTS > options
+	echo 1000000 > period_us
+	echo 0 > print_stack
+	echo 1000000 > runtime_us
+	echo 0 > stop_tracing_total_us
+	echo 0 > stop_tracing_us
+	echo 1000 > timerlat_period_us
+
+	popd
+}
+
 check() {
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
 	if [ -n "$TEST_COUNT" ]
 	then
+		# Reset osnoise options before running test.
+		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
@@ -37,6 +69,14 @@ unset_timeout() {
 	unset TIMEOUT
 }
 
+set_no_reset_osnoise() {
+	NO_RESET_OSNOISE=1
+}
+
+unset_no_reset_osnoise() {
+	unset NO_RESET_OSNOISE
+}
+
 test_end() {
 	# If running without TEST_COUNT, tests are not actually run, just
 	# counted. In that case, re-run the test with the correct count.
-- 
2.47.2



