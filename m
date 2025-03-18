Return-Path: <linux-kernel+bounces-566498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63498A678D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB03883589
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B47210192;
	Tue, 18 Mar 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jz4eTga4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E120E6FA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314491; cv=none; b=dcXwvY8UNHfaqc32hLnl9YAhf610vGW7xDsI+Fn7xvHavo2xUWtwnt8/3tN/u3G6M0etGfMdmw60Iz/HR2/lYKKalleF+LXd4B0jF1jWBcffUiL6c4qgucPnnZXFBeI6oEiHKME5eCseBzAntsAvtkauKr+txNmoFod/X9hSswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314491; c=relaxed/simple;
	bh=JtrCwaIemaIH1wZYdeXf6+kSx9FT6E+fy6V6+KJ4oWs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=VwkSW088gHoighdUSodxrEWavUdHkQpqYf5IVqTuCXy02m7Uw6cTb3H9xrGwMO4+1sP9kHgYKAWXhN2232VDPDZGJr3CXoHQ8zdUK1RqbFaise3bkVRUGdqeDCjRmax3LJ9pe+qVcHBukPQ01rWHkm9tdWnbkhjrnjuvabQopW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jz4eTga4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2c7746509so88260037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742314485; x=1742919285; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpgqd99OouJUfZ9Z0+GeFS3Ytd7aZfW80L/d4uD4fxM=;
        b=jz4eTga4UbIlqwoxgWMNRIbmwAyNMtVE9UXykwIfvkHyl8BkfSDFCL2SeME4C6Koh6
         wB6ZcyYeRhK7SEhmAgKz1DTUvHKcZYqcC8wsVSgZRqMzm41D+B6BTXIsQUQ4/1o5GNHm
         CDDSQ3Q/TNvy/HjJmVKhyM0BIS5YL8phPY0zsMKMseQs3t8yK2iE3NC/xxQE/ubIPeNK
         ks9EMkEN1c9ia7tiy0cDVRx+Se/b0AhgZIXjRLzXonx6FzUA1fpKyo1LByeqBz88pBlG
         Byov5V84l9I7ztbXym/v+D/ayMNwMSAp3INu/x7vQf7L0pBi0C7dJzaGTJ6WediqLdqi
         bh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314485; x=1742919285;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpgqd99OouJUfZ9Z0+GeFS3Ytd7aZfW80L/d4uD4fxM=;
        b=m/lzQ5GdVXMKFt8fYjazEli/z1E+OmhD71CH3sqOJbMVK2XEeDCpSF2/p8AO8RTioa
         oz9tImyiq6sq8UF574a3jZgU6/V5/WKqqp/6W5GdOuBw45MD8W1VQHzMVij+81XkFh61
         nrjdqN0Pu/HbnDBeNG5L67PFV+A0woyT2F7bjV7i+g+wLJSQmJxcRM90MqGSr9y3Kz3G
         KLx0Pyctus5uXDulEIHxViB9huwTqH0M86oY/UbRwz4zClr6Ssv38ZvLFsWEN4dRFLaz
         laeIRuJyknm/IJ4ccY3jn+/OBHcpyj0rnbRCNqYXCgq9SPgAoAzWjSaiKwQlSGrsfjt/
         Pkrg==
X-Forwarded-Encrypted: i=1; AJvYcCVnHXrs7nK/f22DY3QdGfpjsu/eLahL2+b/CggIZTkA1GazvTaYxj9nxLqgcJrShhhw0sX+P7rzRQFxEKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFP3/yxNd1hvLb7E36dTiEqyDPn+Fh69MB+9L+Hzfv8aV3zGX
	sSOmS/Q4Wfzjzq2BWpcc2asKQa9aXY/pt56JI3ogllCMdEhi/nZat2JOOq4bqtjlBopCuLPQJhN
	HpWpkfA==
X-Google-Smtp-Source: AGHT+IFMHV+fm3kiosS3IB2rFuBikoLWu/hZvCgG6GBzQmNlz+pOHPFPlzhct5SwsMpPJf/ljpE2F+wzWGZz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a05:690c:450f:b0:6fe:d1b3:850a with SMTP
 id 00721157ae682-6ff460541d9mr76807b3.5.1742314485145; Tue, 18 Mar 2025
 09:14:45 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:14:32 -0700
Message-Id: <20250318161432.33732-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v2] perf tests: Harden branch stack sampling test
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
v2: Change skips to errors Leo Yan.
---
 tools/perf/tests/shell/test_brstack.sh | 73 +++++++++++++++++++-------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index e01df7581393..a7c13a22397e 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check branch stack sampling
 
 # SPDX-License-Identifier: GPL-2.0
@@ -17,35 +17,51 @@ fi
 
 skip_test_missing_symbol brstack_bench
 
+set -x
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
@@ -57,14 +73,28 @@ test_filter() {
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
 
@@ -80,3 +110,6 @@ test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
 test_filter "call,cond"		"CALL|SYSCALL|COND"
 test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
 test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
+
+cleanup
+exit $err
-- 
2.49.0.rc1.451.g8f38331e32-goog


