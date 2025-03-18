Return-Path: <linux-kernel+bounces-566507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C9A678F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6862A189253F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144E210F6D;
	Tue, 18 Mar 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnX/jZQy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FDE20B81F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314605; cv=none; b=Px1zgm3nefe4d9MUQ117k1F4FXLczmVsyIdPcOueIqIw7tZ/K7ByTFO5fg+fEn+AQRiOu2WqBKiu/usSc2Ts50D3EP7BMGOE6V9v6zPGggNhm2AxtNuNoSuOfvhNQdaMDi7HQNfFLI2l9LgWUVeHqJ4zKekr4Rcf5Y9Op7q6dW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314605; c=relaxed/simple;
	bh=rFZRno4D57G8sQhaSQYhCE3pJnIZ41lDTeZnqQF1khE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZFvj1V6bVShuzoBXplCCJ2pz1ZCSmCxGkhRnPDyDWzU2X2Uv9YF8yfZpwqXk2c6E50OYnWQMa/dJPlpv8wm8i8uoPlXk+Us77D9mOF5n3+6H0et9PqhffVe33kY387b6Zdn1OBvnOCXLVmB4N3gwojhnPnFJ/M6CA+NdgxsFzaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnX/jZQy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fed889e353so92925877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742314602; x=1742919402; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgZoelN/CSZE28lWFMDK6Fgb0NKV8wQtQfqMgFFcUF4=;
        b=BnX/jZQyVS4eFUYiK011/Vnl320A6b1t6t65xMbuRiCcjUhLu5K7BzhmVxzURCRWBs
         uEFMCif5hj2zCAiKyiKKCr5hUUaurCT0JzY+rp3UPUyCwOCUrOu7CO/4jJo8FSinhOvv
         0imPYjCMjWOAWF9z/adCp69fETrlRJNobU7s7OvPyTj3xWxuUHpGalJ2Xp5lOlJfFs27
         FodYWllYJvdMbJ6+A+GfUA72weB3idZMoCv2W6tW19iYWP/onjn3tTEA/VJbFUBaIB0s
         gVGvEOsCqKa3NwIr0oZvsjQDQ7ujIPr9F+LYHLsMi5KF3Hn63g3qmCA9is5MAPpmzaUa
         /zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314602; x=1742919402;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgZoelN/CSZE28lWFMDK6Fgb0NKV8wQtQfqMgFFcUF4=;
        b=FvCbv1Ps7OnPQVTwYOx6ismnCbJnUkTzJtlq1vXXrve/ToSQBYMPyJbHkxgEBZkkAP
         vpdV5XP9iwG43TskQfWLbyk6F2sD7vBZAIEUA0+jReOHdkn/wwG/5l5uZS1VoM4fHqTj
         n8W950w0+0BD57wpQAb6oED7XEuTqTtJ/fyOUEaocNbBVkZGsCIST7V3zydaYSaNWZ8+
         GMRmJ2b49BiXnDd3DSeatMONR9W2BkiMV+ibty5RDws10UK8BwIbXBbE61VvV+1UfmhY
         vLG1X8i/V2uD8qhlkPXL3upz7qGJURBf6NQySoEgLfkNWCYikuWQZbmsd7kfwtDE68ha
         6aLw==
X-Forwarded-Encrypted: i=1; AJvYcCXnj7vqX0b0kOhWLz3C6TetxTKRgIZq7rYOYx2HEMDwCQ43wrBYRSvnEX4f0WG76SN5bI8amvkIaJI4MHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdo2wYR8kMN8Cc9sKeJOtjlnIwul9QYx/p5A0i96fcgrCzxxm
	r4qfaUv3sx5xDTbd1yFVfj1jh5FT6hXF+ds8hXWyIpNgV2TpMbmznPOB6xay7WDIsmW78FcEniR
	GYLY6qQ==
X-Google-Smtp-Source: AGHT+IFD2VPtzXDi+HvMBlqNdDwg9+sNmUXhyahSsw4OEePKDKBj1JYCQEDW8oi84DxDa6xZeVSwhaUFyUtq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a05:690c:ecc:b0:6fd:a1fa:9d58 with SMTP id
 00721157ae682-6ff460a7846mr74217b3.8.1742314602497; Tue, 18 Mar 2025 09:16:42
 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:16:39 -0700
Message-Id: <20250318161639.34446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v3] perf tests: Harden branch stack sampling test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, German Gomez <german.gomez@arm.com>
Content-Type: text/plain; charset="UTF-8"

On continuous testing the perf script output can be empty, or nearly
empty, causing tr/grep to exit and due to "set -e" the test traps and
fails. Add some empty file handling that sets the test to skip and
make grep and other text rewriting failures non-fatal by adding
"|| true".

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Drop set -x
v2: Change skips to errors Leo Yan.
---
 tools/perf/tests/shell/test_brstack.sh | 72 +++++++++++++++++++-------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index e01df7581393..9138fa83bf36 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check branch stack sampling
 
 # SPDX-License-Identifier: GPL-2.0
@@ -17,35 +17,50 @@ fi
 
 skip_test_missing_symbol brstack_bench
 
+err=0
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
 TESTPROG="perf test -w brstack"
 
 cleanup() {
 	rm -rf $TMPDIR
+	trap - EXIT TERM INT
 }
 
-trap cleanup EXIT TERM INT
+trap_cleanup() {
+	set +e
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
-	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
+	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
+	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
 
 	# example of branch entries:
 	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
 
-	set -x
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"		$TMPDIR/perf.script
-	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
-	set +x
-
+	expected=(
+		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
+		"^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
+		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
+		"^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
+		"^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
+		"^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
+		"^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
+		"^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
+	)
+	for x in "${expected[@]}"
+	do
+		if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$x"
+		then
+			echo "Branches missing $x"
+			err=1
+		fi
+	done
 	# some branch types are still not being tested:
 	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
 }
@@ -57,14 +72,28 @@ test_filter() {
 	test_filter_expect=$2
 
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
-
-	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
+	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
+	perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/perf.script"
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-	if grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" $TMPDIR/perf.script; then
-		return 1
+	if [ ! -s "$TMPDIR/perf.script" ]
+	then
+		echo "Empty script output"
+		err=1
+		return
+	fi
+	# Look for lines not matching test_filter_expect ignoring issues caused
+	# by empty output
+	tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep '.' | \
+	  grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" \
+	  > "$TMPDIR/perf.script-filtered" || true
+	if [ -s "$TMPDIR/perf.script-filtered" ]
+	then
+		echo "Unexpected branch filter in script output"
+		cat "$TMPDIR/perf.script"
+		err=1
+		return
 	fi
 }
 
@@ -80,3 +109,6 @@ test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
 test_filter "call,cond"		"CALL|SYSCALL|COND"
 test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
 test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
+
+cleanup
+exit $err
-- 
2.49.0.rc1.451.g8f38331e32-goog


