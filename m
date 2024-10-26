Return-Path: <linux-kernel+bounces-383157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DA9B17E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FB41C21014
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D21D6DB9;
	Sat, 26 Oct 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNg5EHSZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B81D61AC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945092; cv=none; b=U/q0j1VxBOmzGv8JTLovnBSeShwQzMl6UJtlfWblgkFt368OCdyTu/VHqkdyMEpmSJYvTtN66J9N/DdW1ZCvRjh7kKWkggRH+m+hxm6LZGiEq1t5y0Su0ebMmPK9AkWvxHmiIkb2oE6SPFBOYVJeVhmK6rEHlnI9mI3mZ6zZ5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945092; c=relaxed/simple;
	bh=QMbvqc11c1t3yQ/Xre0ZQBICf4/YYduHNNtc/69A+Xg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SW+coDKge7LStYo2TY/P4SsDPinbm9iXrTKo/r2B+JMzbox/TaG6w79mV6qN1gUTKSpf81YazdxXyrjNpKUF8AkKkLCfLavexCPlIi+ig2FAhc8koUr1Jb1BTGmnls8d89IN3xOwcQXfI2vFnskK0ImWri679HYgR87FSknH5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNg5EHSZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e389169f92so53897027b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729945089; x=1730549889; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7F7PVEl1yMjHz9vox0k4Hp07MzhtEZCh12BPQyxhhQY=;
        b=yNg5EHSZZCJjhB7Ff/ZK2sqDzcGIxQMNs9d6ONBIG0e2Tg2fd07oMw0E+JYGSJ4dz+
         fZ0I0IAagRgqA5cToMBngKzfODYFS1aJALnoHOvr1Bih7rd3nDnUbu4x8N3ZnwjL5dhd
         89nkSWgQKFHe5UOoXLx97wZTRrw9UT5161N2aLkEyAH+t6AcQm8cxvWsgOPk322XLI5U
         FdNUHwzPBua9e3t27V3QKTrCH9ZkAVE/GFBA0sa0wr9ortr86Cosb4vTPvsKwGv59csa
         lwtmh9TBOF7AGpAMmvjYSK1Zc2MxTGggSIq07QPQKdmH9jmV7twxOV+5CUhPt3vv1okB
         Ghyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945089; x=1730549889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F7PVEl1yMjHz9vox0k4Hp07MzhtEZCh12BPQyxhhQY=;
        b=OBNUymqHHVnZu6FlqBQsnFqh3o+zIMad4J7gbMj8h2cjU8Qp5Yc9vdSBEnN5lQBFJF
         9m2IU3zNKcPnq37VwFTMMKOwU9o2LEWKvshZoyE3jbecbOLvhTlqYsoa1Mp3S6m5zNkN
         dey6xX9FBPrNrWaph1cSK+5vGwxHr1bx71StfnuIm7VqlXr8T4hWhKJQgTEZo4SETdF+
         osMgB2PAXft3Q2ENKkSVUmXD5hLTK/5V4vOWdtCAx4hGdKu0BejD1Zx0K183tLY+X3sL
         ZOAHQHY01IEls6n8CaASCuwlqHPIcsD+CTkkqjYCuf8b1nB7rMjxdN8S6yFSNXOhMZnW
         qhoA==
X-Forwarded-Encrypted: i=1; AJvYcCUABjAslD73u/LWZzgiiR/vRBvFYXDOLwN3kfAj0rPZfA5C3ph9e3ix0Ek/jToIvdcekcGXLJISinWNitw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmMK3oB5i+ZoMHdBHj2W1MUPCuAeMRZyDlw+e7GfuH6ArByI1
	FRGU7P37QqBRcpKxtydxBq/1Bl3uSuw939/jmMCjBzbeUTAcoteieh1SBwXdzbO2wJMimU8U8cZ
	qYXmy4Q==
X-Google-Smtp-Source: AGHT+IGokN+iNYXdGTM/m8jAXY+rBHKDjwssa4ELvzrrAB/oAfWnGPy244qe6dALscEwgMiTq4roYYY/2wDq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a05:690c:3607:b0:68d:52a1:be9 with SMTP id
 00721157ae682-6e9d88b0b4cmr691497b3.1.1729945088518; Sat, 26 Oct 2024
 05:18:08 -0700 (PDT)
Date: Sat, 26 Oct 2024 05:17:56 -0700
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
Message-Id: <20241026121758.143259-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 2/4] perf stat: Fix find_stat for mixed legacy/non-legacy events
From: Ian Rogers <irogers@google.com>
To: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Legacy events typically don't have a PMU when added leading to
mismatched legacy/non-legacy cases in find_stat. Use evsel__find_pmu
to make sure the evsel PMU is looked up. Update the evsel__find_pmu
code to look for the PMU using the extended config type or, for legacy
hardware/hw_cache events on non-hybrid systems, just use the core PMU.

Before:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1
 Performance counter stats for 'system wide':

       215,309,764      cycles
        44,326,491      cpu/instructions/

       1.002555314 seconds time elapsed
```
After:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1

 Performance counter stats for 'system wide':

       990,676,332      cycles
     1,235,762,487      cpu/instructions/                #    1.25  insn per cycle

       1.002667198 seconds time elapsed
```

Fixes: 3612ca8e2935 ("perf stat: Fix the hard-coded metrics
calculation on the hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c        | 20 +++++++++++++++++---
 tools/perf/util/stat-shadow.c |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 107de86c2637..8d8eeeb28868 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -708,11 +708,25 @@ char *perf_pmus__default_pmu_name(void)
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
+	bool legacy_core_type;
 
-	if (!pmu) {
-		pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		((struct evsel *)evsel)->pmu = pmu;
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+	legacy_core_type =
+		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
+		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
+	if (!pmu && legacy_core_type) {
+		if (perf_pmus__supports_extended_type()) {
+			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+
+			pmu = perf_pmus__find_by_type(type);
+		} else {
+			pmu = perf_pmus__find_core_pmu();
+		}
 	}
+	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ada787947e16..f6d34e12e65c 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -151,6 +151,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 {
 	struct evsel *cur;
 	int evsel_ctx = evsel_context(evsel);
+	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
 
 	evlist__for_each_entry(evsel->evlist, cur) {
 		struct perf_stat_aggr *aggr;
@@ -177,7 +178,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		 * Except the SW CLOCK events,
 		 * ignore if not the PMU we're looking for.
 		 */
-		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+		if ((type != STAT_NSECS) && (evsel_pmu != evsel__find_pmu(cur)))
 			continue;
 
 		aggr = &cur->stats->aggr[aggr_idx];
-- 
2.47.0.163.g1226f6d8fa-goog


