Return-Path: <linux-kernel+bounces-284086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F170694FCC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5281F23F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084B224FA;
	Tue, 13 Aug 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06UxS35D"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B8D2033A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523688; cv=none; b=IxofLdI+Sh6Lgi5TMI6lx9V/j7KSgaVGFs5B0DuUXJV9+/SYpfCTCuWpstqyg5+1qoiKqfQvw7Vwk1OwvOaVkFz4pzYDk02FnB1jd9z0irB16V60uR0OEEXXJXXu8CPK5ipdNt731i8bhlSQYZjJq3P5SnZIFSG2qkqUSsptcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523688; c=relaxed/simple;
	bh=V7zIrmXduTvwySQgP3NPs81ZIEBXM6hl1xeB/wggVEM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CMt9UY5rrCBo6ZOLhsRNd+5t+K+M20/2uZBmnGyGGr23EKc3HVA/5IAeyuDh8ymJBqAHSKxZ9LFIHs535wpyrpwoPGVDEy5crfCVw+AmJr5tYxSxxJgdrTXtaIRuia/yWKCd1cuozRQflqciGU/suMnZxVPJ54PcxtW4zLmgrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06UxS35D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6698f11853aso102299057b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723523685; x=1724128485; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzulAZWrkiRYuYXZRjZp4Z5PKMQIBFjaVOdvBrI39h8=;
        b=06UxS35D2E7WavR59aEnermhYO5MQ+1Ntia3Bs1c6Y7vD7wS9qPijwlaSgTAO/zsWC
         4fsi5mjgfnjZp8QWE+0bil3amutKRrWqPpBcwSGnQfY8KqE4eLOHcFl/Eag8TGBI2Wyp
         +iAdMa01RAyaCxBG4bq7m41btBrUj/R+t0Jjl5Ud62/8hFocn5B/U6fvuKFAoTQH9Uvy
         /EzTk/gxMNLIOvDo2PErTcM5khPjhAaTfyg7ws84VUXa/Yo7/AKaaIMb7XxPsrrax/9g
         SQVwPnttsjjY7L/g+wDpcOVPYK2adVP7pcKglnmF/3MYLITdyWcK6jB5n1mnfLJ0qcB8
         Yh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723523685; x=1724128485;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzulAZWrkiRYuYXZRjZp4Z5PKMQIBFjaVOdvBrI39h8=;
        b=FIUxwzymdnLzjNRryHXZIRE9as1fV50U0MY2xTSTAALin4eZfzQE+ZjmNC/jdoSUFM
         CXFLUc+giyZI/2vOpVLUYejB3yTX5TQt1qTtHrDo5NYx2h+WZykX9eBKrD58lGfDn3p3
         1HS6sU0qR86G+PAyLo1S1GGabi76OoaUcs6eq2fVzOIxJFGp7Nb5a1vcTPOy1ttaINc5
         A8SsTrMdLaC3Vh4G32xZAxEI+5mpwbtAVDS2LUkblCgU8kX1HB1MBIcrBWkKkApLGwIc
         N+0m6fbU+DlLSpD54YmF7wQ++uRQZyg5CVOR//fzj9VeEdOxwaKBFxC3jGBqpBNnLlQt
         Q9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX3JOnu3BAUU9L1ja4Udq0C1qQup8gha6xNYaNKjqaxj1uUkI+l5MnH0PFtO4kPdoLVINUtC8W3gf7txLdnbTKOMirkGA12b88AjjEf
X-Gm-Message-State: AOJu0YxlPxybpxPg5vXnwkht4bdLi2Y3MEGpmYTAtvOin6yHzAE107ZQ
	+2NwA1jLZMPqEMyBewKpQrm7xFV82WhSSt3sehjbslqoMx0s4zCgBdZ2nl0YiZ9zYwMO5mMUjLh
	vD7+WvQ==
X-Google-Smtp-Source: AGHT+IFTUnHH6pLdMnWRmJbelcR59QPwqasb9rduLP8Np5HwtWk45Easx6EqI4EzwoDT0HTYp0tt0SIx7TGB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a81:5b82:0:b0:697:9aae:1490 with SMTP id
 00721157ae682-6a971cccec2mr1013097b3.1.1723523685645; Mon, 12 Aug 2024
 21:34:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:34:39 -0700
In-Reply-To: <20240813043439.933329-1-irogers@google.com>
Message-Id: <20240813043439.933329-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813043439.933329-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1 2/2] perf test: Expand pipe/inject test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
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
2.46.0.76.ge559c4bf1a-goog


