Return-Path: <linux-kernel+bounces-290568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2189555D4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B964B22B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27013B780;
	Sat, 17 Aug 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7F4B4a7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33F14533F
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877117; cv=none; b=DiPJsPFtw6VtLzkiwBfYNSAQdQIuxnWt+mw5yZ2dzgyQ5JaEy2TSAVLdEmVvhWzXJkElMWaD/QcPmmVNSmxhk9Y7b97nHm/ByMmY4Ex4b+KmaoGuKksbgwrcyv0C8OPBMHvd9TB8uKG5fdBYYiZDHmTWrIC7ICvvpDVSSgo0J7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877117; c=relaxed/simple;
	bh=svsXcTMaRqZcv7GQdX5SDwbX/PNPLJVnzNXlCv1HOwg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OIaiYAd/D5CquVhnn4IwAQQPuMWkxZSne6S+1ZAg7JCiGjr9a+TFEmVF0tedjrWGsLd9H6vZyBT7KmbBNqX7AJBMK99IuNaxdnLsPP5ZHNozyPj5u6nziKzsqQ0oeevg5sva7988yh8GjO3g280gyWsDCfURY1A5FKscXICZtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7F4B4a7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so49592527b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877115; x=1724481915; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiIb0LHFpPGuH8DbvZrhFnBLb6AIQ7thHhf5YFck8Ko=;
        b=o7F4B4a72LTF0ZtAZDSYFB+3PzHhy77VR9b9FUa0cGmPfKIU1iIk0Q6Pjt3IVk0oo+
         8wVCO6ZtlzbUh7gO93+SA3XsBMTaPBzliuHi6NJJFh0GiUnRfRaXy249BiFYo5Jkw6UO
         9h/a6/5E3PBS6hqH2f/x93+yoPKqi6FfvgQGVoiVVBEF+oZ4cjygUyMNiHVHwazWWtDZ
         TO4uzD4Zov4gKgJTYqrBpSf0c0uBgO4zILHyTtbWMOogZ/k9+oj2Wzg9bd/awnTWoYyv
         baKuHGAjDKyYPlWJEHYWX85UB+BFjkVMpUqN1OX5qNxse89Iihrd+Nr3izoxfdWITSAy
         hSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877115; x=1724481915;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiIb0LHFpPGuH8DbvZrhFnBLb6AIQ7thHhf5YFck8Ko=;
        b=P+VdfCz6pfXv1r15qwj3VjTRJV3u6aHtUl5obHfXkgxrSINDAcjoddYpgklonppn4r
         tWYWCx2dFwxq568kueiEo4ZM7C2ErJ2dlpUNiN6BMx4FSyHu64gOK79WKBSEolJ2Ty42
         pHafTqmMUQuK60VStrsI2oAKVc0OOn6fI8Vhb5ZQBs9I9Xf/KaBQyyuahY0x4qRHLopi
         yPR2suEV+5qc8RG/UwoeFb8Ok0T4BVcG1OuI7ewR6Glh0du6kkG6J1dB+hrXge9E2ks6
         3toDhxcrJs/ZC0w20/W+UI65ecE13SLUMmQxmTATytJbYYzYhtE+7ljhxvjPPRvpK65P
         IoKA==
X-Forwarded-Encrypted: i=1; AJvYcCXsPvN5Ql2dnd96XCsm54c6UOpNWTn74puzx28tnROgjrjYfwuE4BqLB9kscIi5fH7XZ9UJWAki735y3ECt5KtkR0ph/mGBCe/a/ypX
X-Gm-Message-State: AOJu0Yx13HYhlx1Uw+waiRyliH4Lh8+1pMgKppBYUZ1Vqg8+dH6sZJNU
	CJ10mcpUQj1Xb2x1/MtYJZwZ1GNYsVOk8WmtjpnK14i5zL1YPdRpgxoOJXvXho9fyv79xKNc6f3
	jngWisQ==
X-Google-Smtp-Source: AGHT+IHpIQH3Z4+neJvbwuE+BMqXxfg4n05M1ztGFk7NZrFg4BazntZ8QBZQfcIgDAHYHp5Rx83a8q7z27Ab
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f0b:b0:6ad:9825:6a2f with SMTP
 id 00721157ae682-6b1b6cb7a10mr534947b3.1.1723877115221; Fri, 16 Aug 2024
 23:45:15 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:35 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 06/13] perf test: Expand pipe/inject test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Test recording of call-graphs and injecting --build-all. Add/expand
trap handler.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/pipe_test.sh | 101 ++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index a78d35d2cff0..ad10012fdc29 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf pipe recording and injection test
 # SPDX-License-Identifier: GPL-2.0
 
@@ -12,30 +12,87 @@ skip_test_missing_symbol ${sym}
 
 data=$(mktemp /tmp/perf.data.XXXXXX)
 prog="perf test -w noploop"
-task="perf"
+err=0
 
-if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep ${task}; then
-	echo "cannot find the test file in the perf report"
-	exit 1
-fi
+set -e
 
-if ! perf record -e task-clock:u -o - ${prog} | perf inject -b | perf report -i - | grep ${sym}; then
-	echo "cannot find noploop function in pipe #1"
-	exit 1
-fi
+cleanup() {
+  rm -rf "${data}"
+  rm -rf "${data}".old
 
-perf record -e task-clock:u -o - ${prog} | perf inject -b -o ${data}
-if ! perf report -i ${data} | grep ${sym}; then
-	echo "cannot find noploop function in pipe #2"
-	exit 1
-fi
+  trap - EXIT TERM INT
+}
 
-perf record -e task-clock:u -o ${data} ${prog}
-if ! perf inject -b -i ${data} | perf report -i - | grep ${sym}; then
-	echo "cannot find noploop function in pipe #3"
-	exit 1
-fi
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
+test_record_report() {
+  echo
+  echo "Record+report pipe test"
+
+  task="perf"
+  if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep -q ${task}
+  then
+    echo "Record+report pipe test [Failed - cannot find the test file in the perf report #1]"
+    err=1
+    return
+  fi
+
+  if ! perf record -g -e task-clock:u -o - ${prog} | perf report -i - --task | grep -q ${task}
+  then
+    echo "Record+report pipe test [Failed - cannot find the test file in the perf report #2]"
+    err=1
+    return
+  fi
+
+  echo "Record+report pipe test [Success]"
+}
+
+test_inject_bids() {
+  inject_opt=$1
+
+  echo
+  echo "Inject ${inject_opt} build-ids test"
+
+  if ! perf record -e task-clock:u -o - ${prog} | perf inject ${inject_opt}| perf report -i - | grep -q ${sym}
+  then
+    echo "Inject build-ids test [Failed - cannot find noploop function in pipe #1]"
+    err=1
+    return
+  fi
+
+  if ! perf record -g -e task-clock:u -o - ${prog} | perf inject ${inject_opt} | perf report -i - | grep -q ${sym}
+  then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #2]"
+    err=1
+    return
+  fi
+
+  perf record -e task-clock:u -o - ${prog} | perf inject ${inject_opt} -o ${data}
+  if ! perf report -i ${data} | grep -q ${sym}; then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #3]"
+    err=1
+    return
+  fi
+
+  perf record -e task-clock:u -o ${data} ${prog}
+  if ! perf inject ${inject_opt} -i ${data} | perf report -i - | grep -q ${sym}; then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #4]"
+    err=1
+    return
+  fi
+
+  echo "Inject ${inject_opt} build-ids test [Success]"
+}
+
+test_record_report
+test_inject_bids -b
+test_inject_bids --buildid-all
+
+cleanup
+exit $err
 
-rm -f ${data} ${data}.old
-exit 0
-- 
2.46.0.184.g6999bdac58-goog


