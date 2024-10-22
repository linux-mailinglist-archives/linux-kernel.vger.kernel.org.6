Return-Path: <linux-kernel+bounces-376774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CB9AB5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B58281841
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5A1CB301;
	Tue, 22 Oct 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOOfNfqo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FF1C2441
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620396; cv=none; b=d84ZjlIO10KOW+N2143DWi8vm5/zVGftX5SvDlxbV6tdU59/f4CeJvoG/7OQAM9S2boN9ORUSwPiPW4G3ttRH/dZYyhVE46NUD733nySFevPi0nkt7MMiGpu7gdRP0C9Pplf4MAn2hF0dMOX50mZbB1AoiEQNzs5w9jNw1Pr8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620396; c=relaxed/simple;
	bh=xehRPFYTnggkY2eaeY+b4M2fmsQACi7v+j8hdB8p4CQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lrhyRgUHVCJbb1JQcKnxhWd5ORrE3lQYaCD9Nxaw7ETkFIR5yMbt1/xjAKoh98gWQy0+sSgY9yRfH7Z0v+f98CZboh5PJ8xKAWOGUaFQOzrbwzkJTgm/BgHUTXtNnQlY3SneXw1MNeWlWjBFZMo2opnp7suDDvzJoS3R4TuDl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOOfNfqo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2e5e376fcso130820697b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729620394; x=1730225194; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjoGlVQtm+/8UkY8rwXUxlTySm4ZBQQTYP82VqdPDrU=;
        b=tOOfNfqojnipJgEfCTAoUG3zLPGsTGMQgpmR599Xc4jmuMDlsDLJB9gPxFE/GOb512
         97CdR7BuZ1ZUl2wnkzfsdUOqcgxisx0hNn/g221fw9JIVJXs1FkD8mgfdHpvGkTJ6WhK
         fSytkZ81MNDpXVPGcRbVzHDprm8bgq9kE/NKC8oH7SeGNSPAqgEYBAkJT7cywdCzFamk
         uvkfHHaV4i9Mr9XZRlYikIAXoLJ0jD1qircW0try20Yf1UroQdHl6QkwsX2EdM7YuV4A
         RFTamE5Dkgw8YAdi8F4aTAaM5xg+UaQBZOpf70AkXEdZDsSTKwUHnb2OqyKhbaEtig6E
         R7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620394; x=1730225194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjoGlVQtm+/8UkY8rwXUxlTySm4ZBQQTYP82VqdPDrU=;
        b=kunkePRCqWPB4AnrZhFL6+AQ0kdkv2tZU0kduRdIgp0rMS8vhDWpwrqOb87QfX8PqJ
         Yd7DWJTxAmXisg3jXW0lAIm98z9Y6f0+gIrqdkZ0mltKc5bxb/YQSogpmCE0S94xgd25
         gR1OLGw2MklR1tnVVvtWNTUmUo8XyNn4LbVlKCsN0pGJkfwiPVJXNlfi5Wzg37WonQJt
         BHoDPKqHE7NVhQA79RkCyLSuLFmjVwjrUfqnt/1XbF3j2FtEGL7aeFQkjtUgHKGbrlMw
         s10V/HKreV/Z5nqrm1x9I30NDBTMAh2M87vfjeAeehTwm5fcHE/dcGCiwAEx0V6I//NH
         30bg==
X-Forwarded-Encrypted: i=1; AJvYcCWnChMysos70wB6aYMp//BLvmvWe/9ifLaoBq5XNAyluV0D3QG/KKDt+HHfAwnwDlmTbmsf1w6IHYLCLvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVmycs7jNWQ3puRXHtJXT54ii80Bi7ZZfWJhIPF8ccXRIcVov
	cNHIAaPDk9YcwUAHEKsqsr1t7AM7ZZ7XME+yJRUtWPZEF/KPB4rieWmD53/LCuJP5ckldX/2uXI
	co/FOOQ==
X-Google-Smtp-Source: AGHT+IE6TbN93twBTBU6fgqNtIhCWLmDzNqlgCN8pJ8EFpZhPjxaiuPC2ppIXeoO0ox+F5ZOn5e2C4FqconB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:9b13:b0:62c:ea0b:a447 with SMTP
 id 00721157ae682-6e5bfb78051mr4833267b3.2.1729620393874; Tue, 22 Oct 2024
 11:06:33 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:06:21 -0700
In-Reply-To: <20241022180623.463131-1-irogers@google.com>
Message-Id: <20241022180623.463131-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v6 3/5] perf pmu: Add calls enabling the hwmon_pmu
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
index 14663ad14c53..a1cbf82a9753 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -55,6 +55,7 @@
 #include "off_cpu.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
@@ -1801,6 +1802,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_hwmon(evsel))
+		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+
 	if (evsel__is_retire_lat(evsel))
 		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
 
@@ -2246,6 +2250,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
2.47.0.163.g1226f6d8fa-goog


