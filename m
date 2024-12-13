Return-Path: <linux-kernel+bounces-445575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7A9F17CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F71885380
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC81EE007;
	Fri, 13 Dec 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvuqtUql"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F8191F77
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123890; cv=none; b=FT67UedCMZS/TjhvlsAKy6/heHsXj2f/Mj/N81/4RBy4pASEwA4zrb9Wn6sGYhFne218oLTfNUsh0hsJHq4H0clcKIgBNa0qBQtcCKbuX6PP8/XNiFeKLqnCIWfcla4lwz2hXkWrlpKPc4JED22OHIeqZDyVnKGVMkYafj8BJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123890; c=relaxed/simple;
	bh=d9YNPgdNgMkETeghBcHzn0sIBvBbcXrmt5TQaVmypKQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AuCy0Cmc+DkNKuYgClOY+6CQ2VDQOpnpNkU+/YtyROPhu4ysTnu+Vpj1RZ9u5Zp+MWMD80+lNS9CLstNxVRxoceKRVYlR27MbE+9LZTUo8aqxOIAf7Uc13erddI62vfCOifm9PgMF7Qe+wTXzJa1u0gG8Th0ipRJD4dgQVRk574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvuqtUql; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef66fd6e78so26784947b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123888; x=1734728688; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roSkHT8n0+uAYrLbv39Z3QAFR3sxRwlfuGzkTHlXRxc=;
        b=lvuqtUqlmgWa7/fzymT90c8I6mBTAEZ2cGa/YA7F5wuIWqrM8D6hTbXc7B/h89Ft3S
         +qUaNv7wFYA/NeB/lav4npWJBio1g8SFCim8Jn3FMMY6FFhtt2HRGeNda2QGSw3gE8Tv
         lVEfdh5dR4HfhhKW//BhU+diuL7Dy8wdmxMq6cAiNKn4PM0WZuiaxa4Q4HFpr9UNvmtL
         d+7F47LnrYPqefHNJIJR+Sco6M6U0F/vfcLH0yYCiq0/NZovIuhmO5He/z/cQbiPSibz
         nQSd+O/K9ZMMz0DDdfl9LJ8Kdj1QZioDDQQByOGk5WF90LQXyj2sR2B6Veh4KgwXUdYP
         hMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123888; x=1734728688;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roSkHT8n0+uAYrLbv39Z3QAFR3sxRwlfuGzkTHlXRxc=;
        b=RZ/8lggcABk+8LZ8226jCNJ6iu7AjaMykmPls5IrcAhR5I9a8dmAgE1wR1t/rrvqud
         zMmvpqnsmzmpOPmsaL5DxrSL7Lh9oPxtbGJrF6tlD+//nGV4P57E64l1cyOYlsGWYMtU
         0MZqsxG1sHYOJZ7VHnVfZQQnMhS0wwvQvYppbKjFxQ2LPiYJ+WqnlYc1vkj5qdjFVsSR
         mSxiQPsTsFFc/aL7x6u55xhWUZEYSTEjzW8CV5bbRamiQmSlGVESaRW2ZMMp23NqfHLr
         ZWypoBvv4yoZsQkoFH3Fn/TsfDzcqxXJEVyN3V8M+gjyqTsVQveukESngtRJloY48Qr5
         2lqA==
X-Forwarded-Encrypted: i=1; AJvYcCXu3gx26NFvQSrxFFiLm6KWHLRT3jIkkVxYo/przrdnn3m6IWcOXq/rHSVhvBvwkb5+XbMa8UdjCtT4G7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LHGZWzLsODUJ7U0UolsARivkPdyI1PfXoIod8VqA6k8dFOI3
	bz4DP1DCFnf+Aqo3XxuE+7aO6/gytt5DdUOg1/f1VY4RAiTdodBA0sJAPlnQVZ4okBAXTBKlf2Q
	1pJUgKg==
X-Google-Smtp-Source: AGHT+IFVRH25Ty7/gcF0OCXM4vzVNYQqfUZNnDO6SypfEDqFwa9uz2AGIDtUMgRBkV7aLsTJ7xtnSYXokZj+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:26ca:b0:6ee:61ea:a40e with SMTP
 id 00721157ae682-6f275c1849amr58517b3.2.1734123887634; Fri, 13 Dec 2024
 13:04:47 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:24 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 7/8] perf test shell lock_contention: Extra debug diagnostics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In test_record_concurrent, as stderr is sent to /dev/null, error
messages are hidden. Change this to gather the error messages and dump
them on failure.

Some minor sh->bash changes to add some more diagnostics in
trap_cleanup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lock_contention.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index c1ec5762215b..43c2438f6153 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # kernel lock contention analysis test
 # SPDX-License-Identifier: GPL-2.0
 
@@ -7,14 +7,17 @@ set -e
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 result=$(mktemp /tmp/__perf_test.result.XXXXX)
+errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
 
 cleanup() {
 	rm -f ${perfdata}
 	rm -f ${result}
+	rm -f ${errout}
 	trap - EXIT TERM INT
 }
 
 trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
 	cleanup
 	exit ${err}
 }
@@ -75,10 +78,12 @@ test_bpf()
 test_record_concurrent()
 {
 	echo "Testing perf lock record and perf lock contention at the same time"
-	perf lock record -o- -- perf bench sched messaging 2> /dev/null | \
+	perf lock record -o- -- perf bench sched messaging 2> ${errout} | \
 	perf lock contention -i- -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] Recorded result count is not 1:" "$(cat "${result}" | wc -l)"
+		cat ${errout}
+		cat ${result}
 		err=1
 		exit
 	fi
-- 
2.47.1.613.gc27f4b7a9f-goog


