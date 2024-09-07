Return-Path: <linux-kernel+bounces-319640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8B970018
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7A9284F32
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71654D8C6;
	Sat,  7 Sep 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtHnvi7b"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46716146000
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685729; cv=none; b=eD/fjl0ElsQa3vjIhRoFtL9Awr6QQQ5clqiKaEuc1dd+xKkbmz8qi42r6LnMDVqhogII7/OUVbK1K04sEgWB6vNnVau1/63Pewl+REMaGXsv3prdE3s8E8zZ0RD61D9rk6Nfgm/CuSU47kL4hg7bLD99KO/umfZzZyAoxaalv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685729; c=relaxed/simple;
	bh=WFu+5y8QRKtMZSfoRCTOTpmMOyl9HcFrp2FvXFrJg7w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gX9hwALFVuGn7QEvvMZCw/S45y7IaA4Ut2UZH66JtSOpN1eCCH7erTd49IGw9D1sUQ2k7YZMWGFDPNE/6mOxfOYwbvLWoSvTlGS2DOKXDvEgD24KP4iTrxW3jWgDCJYgIn4MdcarRaicuVExYHRro0sSUvHeKd05vgc+KaSUb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtHnvi7b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d475205628so89781067b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685727; x=1726290527; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnJ5bQcxWcBEjqFa4fDewaQZBBcymf58nuYFxDuPtGE=;
        b=BtHnvi7byvG0m5YvfCvhNiJ+IUTTS8ba6CDz2Zw/W5EjlUAeVZBpwXafnXMKJFNgv0
         NrD1IwiS1WKqQr3zRu/sCgZnYgPeK4PmknvXi9w7XGYXkbWM+Nrh4O62v627yscDkO0Y
         LGWelmL+OEMyjnoQKN9pXGxfMBE8ZLH5CrkmFHhaa8q4jOZWoq65PVioxzbdR8fZTRti
         lribxgDsdCZHV9rJ5aRccrLCk4Q+3cmZw5InfiwJRcyQ42YE3HDVBzWqWnKW9VQiU1C0
         qRAGEo03/o3RDx53GxHCtM2Z0Q6N8HTPor0fMkGmVxxvVHMAk4/tXhHn4IDRrheKu9/s
         XMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685727; x=1726290527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnJ5bQcxWcBEjqFa4fDewaQZBBcymf58nuYFxDuPtGE=;
        b=nu3EE3FI2gP/N2xCo26er70cq8zwLIBH3qGqb4ISdIFaG1PtfpC6wL+iTd9iATg7Yo
         OXA9nzGnGdRm1wjjo9FCcyssUT7PRrWh/wqmCAYpWSIpJ9+GaQIZwKHBe8IrJggfbkOT
         Eh9wjqkyhUjHReMu+vuyGQ7alV/Hh9v9v5ruTstNhDVEmIKt+pyGXYl6UuWIs7/+jNIn
         ty+TGjMRSuovMhrj5Qq1yH022eUM6l3HdFlXXCXpY7nJ9CYaub/3zNnIsFWSd+LtgjI7
         rSktWDnsOzVs6MP+MG3JSBtKz7Yn8wnUViTwu5MzNkIBbl+xYksVjXhSWMRTSTTO/Wd8
         OsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkycXZ0bepGKlXK4PYelQ+K0Ug9MQgiXVnfj7YfIaIxH6sktELYKxxRn4dD7XOyabImAZf8HajKqqTL3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7AkLJURkfIh4Th4zHKfn8Xt878L/1TlmgEgW5sP0biHMiRyKf
	ZPohGg9hWK5vf+D0UImcvNtnyT0VXjIRnC2623z46D0J3K6QL4EEZLbfBbsBrvJU8KSHsN/w0Jf
	YYyX0dg==
X-Google-Smtp-Source: AGHT+IFTJ0A52z3gMmDUeSdc9NNKQBO5uzT/5BCT5fI3Wi24F4j+wnthp1Ie8Bb6r90x5y4Inys9YsFccWPt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c81:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6db4526c2c0mr1787397b3.7.1725685727310; Fri, 06 Sep 2024
 22:08:47 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:18 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 03/15] perf evsel: Add accessor for tool_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently tool events use a dedicated variable within the evsel. Later
changes will move this to the unused struct perf_event_attr config for
these events. Add an accessor to allow the later change to be well
typed and avoid changing all uses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |  6 +++---
 tools/perf/util/evsel.c       | 24 ++++++++++++------------
 tools/perf/util/evsel.h       |  5 +++++
 tools/perf/util/stat-shadow.c |  2 +-
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cf985cdb9a6e..689a3d43c258 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -294,14 +294,14 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
 	 * terminates. Use the wait4 values in that case.
 	 */
 	if (err && cpu_map_idx == 0 &&
-	    (counter->tool_event == PERF_TOOL_USER_TIME ||
-	     counter->tool_event == PERF_TOOL_SYSTEM_TIME)) {
+	    (evsel__tool_event(counter) == PERF_TOOL_USER_TIME ||
+	     evsel__tool_event(counter) == PERF_TOOL_SYSTEM_TIME)) {
 		u64 val, *start_time;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
-		if (counter->tool_event == PERF_TOOL_USER_TIME)
+		if (evsel__tool_event(counter) == PERF_TOOL_USER_TIME)
 			val = ru_stats.ru_utime_usec_stat.mean;
 		else
 			val = ru_stats.ru_stime_usec_stat.mean;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 49cc71511c0c..dbf9c8cee3c5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -773,7 +773,7 @@ const char *evsel__name(struct evsel *evsel)
 
 	case PERF_TYPE_SOFTWARE:
 		if (evsel__is_tool(evsel))
-			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
+			evsel__tool_name(evsel__tool_event(evsel), bf, sizeof(bf));
 		else
 			evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
@@ -811,7 +811,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
 		return evsel->metric_id;
 
 	if (evsel__is_tool(evsel))
-		return perf_tool_event__to_str(evsel->tool_event);
+		return perf_tool_event__to_str(evsel__tool_event(evsel));
 
 	return "unknown";
 }
@@ -1503,8 +1503,8 @@ void evsel__exit(struct evsel *evsel)
 	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
-	if (evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
-	    evsel->tool_event == PERF_TOOL_USER_TIME)
+	if (evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
+	    evsel__tool_event(evsel) == PERF_TOOL_USER_TIME)
 		xyarray__delete(evsel->start_times);
 }
 
@@ -1785,7 +1785,7 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	switch (evsel->tool_event) {
+	switch (evsel__tool_event(evsel)) {
 	case PERF_TOOL_DURATION_TIME:
 		/*
 		 * Pretend duration_time is only on the first CPU and thread, or
@@ -1800,7 +1800,7 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 		break;
 	case PERF_TOOL_USER_TIME:
 	case PERF_TOOL_SYSTEM_TIME: {
-		bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+		bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
 		fd = FD(evsel, cpu_map_idx, thread);
@@ -2072,8 +2072,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
-	if ((evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
-	     evsel->tool_event == PERF_TOOL_USER_TIME) &&
+	if ((evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
+	     evsel__tool_event(evsel) == PERF_TOOL_USER_TIME) &&
 	    !evsel->start_times) {
 		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
 		if (!evsel->start_times)
@@ -2262,7 +2262,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
-	if (evsel->tool_event == PERF_TOOL_DURATION_TIME) {
+	if (evsel__tool_event(evsel) == PERF_TOOL_DURATION_TIME) {
 		if (evsel->core.attr.sample_period) /* no sampling */
 			return -EINVAL;
 		evsel->start_time = rdclock();
@@ -2304,9 +2304,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-			if (evsel->tool_event == PERF_TOOL_USER_TIME ||
-			    evsel->tool_event == PERF_TOOL_SYSTEM_TIME) {
-				bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+			if (evsel__tool_event(evsel) == PERF_TOOL_USER_TIME ||
+			    evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME) {
+				bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
 				__u64 *start_time = NULL;
 
 				if (evsel->core.attr.sample_period) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15acf293e12a..15e745a9a798 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -330,6 +330,11 @@ static inline bool evsel__is_retire_lat(const struct evsel *evsel)
 	return evsel->retire_lat;
 }
 
+static inline enum perf_tool_event evsel__tool_event(const struct evsel *evsel)
+{
+	return evsel->tool_event;
+}
+
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 6bb975e46de3..99376c12dd8e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -380,7 +380,7 @@ static int prepare_metric(const struct metric_expr *mexp,
 			struct stats *stats;
 			double scale;
 
-			switch (metric_events[i]->tool_event) {
+			switch (evsel__tool_event(metric_events[i])) {
 			case PERF_TOOL_DURATION_TIME:
 				stats = &walltime_nsecs_stats;
 				scale = 1e-9;
-- 
2.46.0.469.g59c65b2a67-goog


