Return-Path: <linux-kernel+bounces-402152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC09C2471
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC851F25576
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB11A9B28;
	Fri,  8 Nov 2024 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRk1PJ5B"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B456226B80
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088200; cv=none; b=BmdoxuHffCFGIEAYA7X9RWvWGwbyJiznGhgkEgFvNSXglVTVMsKsXW1lASl1n9FMNlEZtdrGsHYS/6/LXSSaTu6QxL0zwOUA3SXWpdECqtQTP3WTbNXzj+faOK5YvJmvgZJUWkf/q37xUiPhzQdzYh0obmbHUbQK6rZ530avWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088200; c=relaxed/simple;
	bh=ZhWpi/y0IU48IBt0+u5WIP11qQFZYZwVjrYO5lrfaHY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DwAiRnl3YnCtCWEO6hdo/NSpGEMKEwh383kACHQhEFT+2feUN0hdejszfBT+zbgAAImW0JH8wNWEaIQJy8U+ymg8Zoy+9Wuig27RM4Uda7XTQVhzQLc880MphveA4su9acf/ZmSxINyF43dUGkNA/qnLh/FZeNuFxePti1Sg+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRk1PJ5B; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso46019697b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088197; x=1731692997; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3pEKqmDVF94310Lcc6dZMS2bWB1ZbAcb+eC42TYfHQ=;
        b=vRk1PJ5BEtWa8o44dDbq1hkQvpGDo0EcufAyATugMq6BC40e0qNfYHrcHpKTzj1qtM
         bIMi9IcexCvwbq7P+8nzl6aRjJYZv8RzMM3jivTMmt04bf0mVWg3phI2vjnQz6+pWcpj
         yIq2G9hpCOlHwBQycrVy9iivQ9F0ms2Yf03xCGJbpAdGQb2BC+5YVAZNZF9HHPqITlHD
         r3C4XFtmgiZ0z1glmPSzchD/r7kqxgOD2ezbjIk8QFpTyWEab+NXdMFsOIRYi9mVm3y4
         a7jvn3OQau5OxnKHGuaubhtzcrg2QqbqlM23sKCuunS4NSizlPH671fdN1Fe65Tx6/3t
         YKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088197; x=1731692997;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3pEKqmDVF94310Lcc6dZMS2bWB1ZbAcb+eC42TYfHQ=;
        b=aEI/I+m/hp27kWw9QnzbTt14v2T5r5z9Qp6PLlNrrttgO0bBWJ9IJ/ISKqQ0+/GXST
         kb/D/tNbmmWXAZllLLLCGHtEQxI7GThek/eKyRw6BhV4twv8rdPfdNCyxHtDA2wBaURI
         oZ//Or7s3CLDhjcpiwuPFpTbFU2F/h0KjXfpKMYHwNXtVt5wWjYwjwecL20qRMJHE32G
         GImuCbse6CXW7+A59whubz5X2T2k8oB0/dvHN5N9Em7jtnbmGQkW8XMdcRMvniVL+HUB
         /sMI1KgIZ0ICIUAJJcWNTRf8w8xNGKfPfpTYSrEmcnX5L9a9FmTs9vI8+Bp2XWO8L0Yj
         JGow==
X-Forwarded-Encrypted: i=1; AJvYcCXIXAstjWtYGANenRNQn0QbVO+plRSRPnV4citgeeEYCvcBenu5vdTymsKu6t0QO7JL0l4lYqyvlOFexxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkuAcuXI0N/HZeUBTZS4xm4Li3eO7uFGsvRedh1Q4Foctg03J
	8znOk2LnxZbACNgiEADlMbjtbT3JshCp7qw0BaOQz2qeRJjcoEveN1XeMuCoGigf3aoB4/NOIyC
	mI2M+bA==
X-Google-Smtp-Source: AGHT+IHgyZGcnSTisDv17E5Ot3v1HS9C9tYJfBpg8EA9F8hcLuq3qYn5egGfAY02+PbG4HVSjWkzCq3csWXk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:720a:b0:6e9:f188:8638 with SMTP
 id 00721157ae682-6eaddfd6bc1mr355207b3.7.1731088197412; Fri, 08 Nov 2024
 09:49:57 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:34 -0800
In-Reply-To: <20241108174936.262704-1-irogers@google.com>
Message-Id: <20241108174936.262704-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 5/7] perf pmu: Add calls enabling the hwmon_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the base PMU calls necessary for hwmon_pmu(s) to be
created/deleted and events found, listed, opened and read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c |  9 +++++++++
 tools/perf/util/pmu.c   | 20 ++++++++++++++++++++
 tools/perf/util/pmus.c  |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f780e30aa259..fc1bf86c5063 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -56,6 +56,7 @@
 #include "off_cpu.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
@@ -1799,6 +1800,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_hwmon(evsel))
+		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+
 	if (evsel__is_retire_lat(evsel))
 		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
 
@@ -2465,6 +2469,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 					    start_cpu_map_idx,
 					    end_cpu_map_idx);
 	}
+	if (evsel__is_hwmon(evsel)) {
+		return evsel__hwmon_pmu_open(evsel, threads,
+					     start_cpu_map_idx,
+					     end_cpu_map_idx);
+	}
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0789758598c0..a02df2c80f42 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -18,6 +18,7 @@
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
+#include "hwmon_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
 #include <util/pmu-bison.h>
@@ -1529,6 +1530,9 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 {
 	struct parse_events_term *term;
 
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__config_terms(pmu, attr, terms, err);
+
 	list_for_each_entry(term, &terms->terms, list) {
 		if (pmu_config_term(pmu, attr, term, terms, zero, apply_hardcoded, err))
 			return -EINVAL;
@@ -1661,6 +1665,11 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	info->scale    = 0.0;
 	info->snapshot = false;
 
+	if (perf_pmu__is_hwmon(pmu)) {
+		ret = hwmon_pmu__check_alias(head_terms, info, err);
+		goto out;
+	}
+
 	/* Fake PMU doesn't rewrite terms. */
 	if (perf_pmu__is_fake(pmu))
 		goto out;
@@ -1834,6 +1843,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return false;
 	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
 		return false;
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
@@ -1845,6 +1856,9 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__num_events(pmu);
+
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
@@ -1908,6 +1922,9 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	int ret = 0;
 	struct strbuf sb;
 
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__for_each_event(pmu, state, cb);
+
 	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
@@ -2303,6 +2320,9 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 
 void perf_pmu__delete(struct perf_pmu *pmu)
 {
+	if (perf_pmu__is_hwmon(pmu))
+		hwmon_pmu__exit(pmu);
+
 	perf_pmu__del_formats(&pmu->format);
 	perf_pmu__del_aliases(pmu);
 	perf_pmu__del_caps(pmu);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 107de86c2637..5c3e88adb9e6 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -15,6 +15,7 @@
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
+#include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
@@ -234,6 +235,7 @@ static void pmu_read_sysfs(bool core_only)
 	if (!core_only) {
 		tool_pmu = perf_pmus__tool_pmu();
 		list_add_tail(&tool_pmu->list, &other_pmus);
+		perf_pmus__read_hwmon_pmus(&other_pmus);
 	}
 	list_sort(NULL, &other_pmus, pmus_cmp);
 	if (!list_empty(&core_pmus)) {
-- 
2.47.0.277.g8800431eea-goog


