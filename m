Return-Path: <linux-kernel+bounces-278904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97EE94B655
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F3A1C22F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB318452E;
	Thu,  8 Aug 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGpda7uX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474F1836D9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096013; cv=none; b=A9IYGU3Vs/+gB8JFD44fekAyFhZad2P941pOOsDDbA36Rn26rORoCODx4kCOgdJ/Seyp2wbwr2jahXCBY0CDKFfUkUF5vyu1GbJrXToERWeKbIx4Wd1IbbNIKkv/PSeZ3Btj+Fhl3wvxXgS32sF7PuAQ99qxC75GR7lsteJy3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096013; c=relaxed/simple;
	bh=1xM/obalM1Zz/Qgs0+hW+TUUWAOW2S/SDCArn56ZLuY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MgXNPIZklU+n44877oHUeqpOcG9Rx+X93tyC8sOchq6+4nMHE0C2cOwkNWLOIK09nAFx44BqYE9URJ0PE8QNLStf7knalry6iwuuAeryAagmYmj4pWC1BFwCYMjLLVxbjB110OlEyc9JvJ/EquZ8pKLY2ke7/k1bxC2RWw3YNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGpda7uX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-665a6dd38c8so13830427b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 22:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723096011; x=1723700811; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhM04XOuy0Npad0DaVUlBDWgqhxXjCFufiJExS1b808=;
        b=zGpda7uXm02C6mBL72Yau0EccRjGzwuq17ZFTVy7EZzMO1ImFAIAxXqehlbYqxSb8Q
         ly6DHF4zxavfCta/6WZSJKsIgJcYf73ev5JkG02mTbcM6iTcGMazI1FDUfhgDUfQGlUw
         2iE1pg3wl3UppCjj27NECxuiskil8HzOZHYsElL3LAUhDxJc+sLuzxGVJhFYkQMw8xfg
         P8rvHQ0k5UDx6xfOrBGCzPkZRlZpKUk2CELVKPO0qenAQyOX4FwGGpVtyX90lYGwlY4V
         wJ1VsYl/IGGTr3cYBNsumDgGpwwGOxsylNPCdtqE9s+lJV/6MMJWfpyx9HwVniNI0Kob
         1PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723096011; x=1723700811;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhM04XOuy0Npad0DaVUlBDWgqhxXjCFufiJExS1b808=;
        b=pXKLHVAppD6C6uzKtzFf0wE/l6zMvkCvQDFfkV4cTru8sTFUmsi47fWNyrCMDSqnDE
         RTgzs5Y451WW4bP/EEX8Rp+XHSw29WqzWPs3KBwRWB20/vWl2eTR11oUypp7QKcH8fKK
         Fqgw+/u7jEEdOP+u0WsscI2HrY/izo8FBKhj1aFGnxz+44zCfFEB1XRG6uYItz+2BF5j
         NwFfZvkUZ/ElVdx3uFCu77SMiNZPisNaAHn/Kd1QJIn0jL8fhBu5DshmEhmOErF1cKPQ
         r87SH7yffbukAPejsJFp/tStzAUc5WdLpVOrAfSJSRRSA4U34ewYoDvZnCdYxjyFxe9E
         P8ig==
X-Forwarded-Encrypted: i=1; AJvYcCVHKuX5EspkEr8Z66+3ex2TxQWAzqJ3qHO0HmlLMXhJoe5m4Pvy8PPxu8uAD4LQGnuNVffcGsXTWR1eSBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFR3aYkYylVK6S4QAG45u00ujHTQhUB6pc2aZPb1GjVpUHZ5hd
	uj7qIRO5dHr7L3/zbY3LOXRjgbsVtSwE5I7b63D9NmEduerubxnVGMr5/fEky/R2NJAUnt9rp0j
	oYuqGGg==
X-Google-Smtp-Source: AGHT+IE7F+fXcgGfS593aciFSAJIuK69gAAk1Ygg943wWj2kCII1jjYfAXNtT1xgN7qTAer0RD197wqazTeK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b5fd:72d8:6b88:65f6])
 (user=irogers job=sendgmr) by 2002:a81:ae25:0:b0:64a:8adc:f95c with SMTP id
 00721157ae682-69bfbf958bcmr230557b3.8.1723096011145; Wed, 07 Aug 2024
 22:46:51 -0700 (PDT)
Date: Wed,  7 Aug 2024 22:46:44 -0700
In-Reply-To: <20240808054644.1286065-1-irogers@google.com>
Message-Id: <20240808054644.1286065-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808054644.1286065-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds coverage for LBR operations and LBR callgraph.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_lbr.sh | 161 +++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_lbr.sh

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
new file mode 100755
index 000000000000..baf168d0ddbb
--- /dev/null
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -0,0 +1,161 @@
+#!/bin/bash
+# perf record LBR tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [ ! -f /sys/devices/cpu/caps/branches ]
+then
+  echo "Skip: only x86 CPUs support LBR"
+  exit 2
+fi
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+  rm -rf "${perfdata}"
+  rm -rf "${perfdata}".old
+  rm -rf "${perfdata}".txt
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+
+lbr_callgraph_test() {
+  test="LBR callgraph"
+
+  echo "$test"
+  if ! perf record -e cycles --call-graph lbr -o "${perfdata}" perf test -w thloop
+  then
+    echo "$test [Failed support missing]"
+    if [ $err -eq 0 ]
+    then
+      err=2
+    fi
+    return
+  fi
+
+  if ! perf report --stitch-lbr -i "${perfdata}" > "${perfdata}".txt
+  then
+    cat "${perfdata}".txt
+    echo "$test [Failed in perf report]"
+    err=1
+    return
+  fi
+
+  echo "$test [Success]"
+}
+
+lbr_test() {
+  local branch_flags=$1
+  local test="LBR $2 test"
+  local threshold=$3
+  local out
+  local sam_nr
+  local bs_nr
+  local zero_nr
+  local r
+
+  echo "$test"
+  if ! perf record -e cycles $branch_flags -o "${perfdata}" perf test -w thloop
+  then
+    echo "$test [Failed support missing]"
+    perf record -e cycles $branch_flags -o "${perfdata}" perf test -w thloop || true
+    if [ $err -eq 0 ]
+    then
+      err=2
+    fi
+    return
+  fi
+
+  out=$(perf report -D -i "${perfdata}" 2> /dev/null | grep -A1 'PERF_RECORD_SAMPLE')
+  sam_nr=$(echo "$out" | grep -c 'PERF_RECORD_SAMPLE' || true)
+  if [ $sam_nr -eq 0 ]
+  then
+    echo "$test [Failed no samples captured]"
+    err=1
+    return
+  fi
+  echo "$test: $sam_nr samples"
+
+  bs_nr=$(echo "$out" | grep -c 'branch stack: nr:' || true)
+  if [ $sam_nr -ne $bs_nr ]
+  then
+    echo "$test [Failed samples missing branch stacks]"
+    err=1
+    return
+  fi
+
+  zero_nr=$(echo "$out" | grep -c 'branch stack: nr:0' || true)
+  r=$(($zero_nr * 100 / $bs_nr))
+  if [ $r -gt $threshold ]; then
+    echo "$test [Failed empty br stack ratio exceed $threshold%: $r%]"
+    err=1
+    return
+  fi
+
+  echo "$test [Success]"
+}
+
+parallel_lbr_test() {
+  err=0
+  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+  lbr_test "$1" "$2" "$3"
+  cleanup
+  exit $err
+}
+
+lbr_callgraph_test
+
+# Sequential
+lbr_test "-b" "any branch" 2
+lbr_test "-j any_call" "any call" 2
+lbr_test "-j any_ret" "any ret" 2
+lbr_test "-j ind_call" "any indirect call" 2
+lbr_test "-j ind_jmp" "any indirect jump" 100
+lbr_test "-j call" "direct calls" 2
+lbr_test "-j ind_call,u" "any indirect user call" 100
+lbr_test "-a -b" "system wide any branch" 2
+lbr_test "-a -j any_call" "system wide any call" 2
+
+# Parallel
+parallel_lbr_test "-b" "parallel any branch" 100 &
+pid1=$!
+parallel_lbr_test "-j any_call" "parallel any call" 100 &
+pid2=$!
+parallel_lbr_test "-j any_ret" "parallel any ret" 100 &
+pid3=$!
+parallel_lbr_test "-j ind_call" "parallel any indirect call" 100 &
+pid4=$!
+parallel_lbr_test "-j ind_jmp" "parallel any indirect jump" 100 &
+pid5=$!
+parallel_lbr_test "-j call" "parallel direct calls" 100 &
+pid6=$!
+parallel_lbr_test "-j ind_call,u" "parallel any indirect user call" 100 &
+pid7=$!
+parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
+pid8=$!
+parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
+pid9=$!
+
+for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9
+do
+  set +e
+  wait $pid
+  child_err=$?
+  set -e
+  if ([ $err -eq 2 ] && [ $child_err -eq 1 ]) || [ $err -eq 0 ]
+  then
+    err=$child_err
+  fi
+done
+
+cleanup
+exit $err
-- 
2.46.0.rc2.264.g509ed76dc8-goog


