Return-Path: <linux-kernel+bounces-400300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2C9C0B87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5830D28224C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4321A4B3;
	Thu,  7 Nov 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7yQO+Re"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA91219CA3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996461; cv=none; b=lQDH9GMkqR60d69cPmftywB51OLhzJMF7WBxpgpAGw+Oo52GUrObJyJjzGjVT/BWjGKYxDchRyzkznKHS5/VIxzw1jTFky5DPxFfe6Sqofth1ahb2lU+mnBOryqGJtzB0VDsFmInx9O/Bdaq1qvXM8/k6oERre1TTBM4ih1CJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996461; c=relaxed/simple;
	bh=yZE5usv7POpAFkWXsWAe3Jof3/secgiiDH647AJzosE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Hwfh64GnJsit7e1hVONIBk1RcfWjf0EpJtuC/FKZ2+EnKheaLnp1DFiAVkqdq725IjFvC1x/GASyYDbUsTkUFq0WCWwR1DI8LkEzNbtTQ2XmU1C7LWfec/6Da1YxTlr28C2eQFCQ805sqrPAED7ZpabUUgMsbHJ1YW4qFeLN2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7yQO+Re; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso1705686276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996459; x=1731601259; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW9+CPTVwMKZIVurnVHCFx7TIdR/e/ydt61yKCEQTG0=;
        b=R7yQO+ReOWcwDT7SKiA2vlfmB2fzWyeqivDUjPzqUXtnkR1732jWoKBlOho1J6hZTV
         NbQGpNt6rQ12yvZltZY54/bwRwrYIfduRD24huPhvxFCKMELozDMZ8rdwijLDh6TmM1h
         O7z8oMTzqrbPC8kNRLppVBaNR4GgL3auJ7e0BrfibhX5yTnPDzGf7glO+ZNDhimT46o4
         23OK7VwMzE75gNK4UhtLCIlQWAaCYM367pIMmjreAumwDrnV5t3fiTl67IhDJXyJfnod
         AeVX7TrtIgsVu5Olv3XOrUQ+ty65RpUTCDVH/QlV2Z2iQXMMU+pYR175M4b0+UFTYFZh
         OwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996459; x=1731601259;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gW9+CPTVwMKZIVurnVHCFx7TIdR/e/ydt61yKCEQTG0=;
        b=HsIAZCD91TvRwY/dy3C8zMs3Txn2q6g2WQ8jm7MEFRICsDrU+e3HaYwL8j2A0ogTPj
         DLTgsL4g7bEh0L948LVjapxvICR/WEAYWnlIR4qjfK566Mi6YKxZsq5/lyXzk+RJGQqJ
         aSKl1tRuFph3xjv++LWgzJXSw8o67zO1LdVimFJuduITdvt2xNC0yLfXhyL8C/u6Hy1u
         Q7K8qDrtJXok/j3iPo3Cp8Vvjihl/80Pgyi6/xI8keWPc4L7wzFR/virAUeJ+5uZuIMr
         PGRT1Nln7T4GYbgD0IoQveEpRtY4wDOoBLJOleULAGKha3kS/oapGuSW463RvRN6U2vv
         gkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCULLcQz/ArzjsJJirylSKfbsmhk1h2FBDJEYPM2l4l0kdUzzTQj6tzjNtLfJ0PwRkKDqqMn55Mhdb4s5gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LL35dpocnLXuQ+8cBtIfCq3ClNKQfE/SlB/7M8TvNnMlum2y
	LZ4d2aD2jnCcxzzMhjI6BS0acFl6FQU7Eq2+iR0HQBHf651pWZmVXwwAQ05qLV3bkbyEtjWtMtr
	9h3zr7w==
X-Google-Smtp-Source: AGHT+IEYlgs/V2F/Aoj+pbdeOvGuquRFfNPybrBK44Ua6MKMX5mUoZiZ1vNXICCo8jUP4hj+0QFM6lTQ0dhC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:acd7:0:b0:e24:a28e:9399 with SMTP id
 3f1490d57ef6-e337e3878cfmr1276.4.1730996458511; Thu, 07 Nov 2024 08:20:58
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:35 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 8/8] perf pmu: Move pmu_metrics_table__find and remove ARM override
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Move pmu_metrics_table__find to the jevents.py generated pmu-events.c
and remove indirection override for ARM. The movement removes
perf_pmu__find_metrics_table that exists to enable the ARM
override. The ARM override isn't necessary as just the CPUID, not PMU,
is used in the metric table lookup. On non-ARM the CPU argument is
just ignored for the CPUID, for ARM -1 is passed so that the CPUID for
the first logical CPU is read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c         | 20 --------------------
 tools/perf/pmu-events/empty-pmu-events.c | 10 ++++------
 tools/perf/pmu-events/jevents.py         | 10 ++++------
 tools/perf/pmu-events/pmu-events.h       |  2 +-
 tools/perf/util/pmu.c                    |  5 -----
 tools/perf/util/pmu.h                    |  1 -
 6 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index a0964b191fcb..895fb0d0610c 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -1,29 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <internal/cpumap.h>
-#include "../../../util/cpumap.h"
-#include "../../../util/header.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 #include "../../../util/tool_pmu.h"
 #include <api/fs/fs.h>
-#include <math.h>
-
-const struct pmu_metrics_table *pmu_metrics_table__find(void)
-{
-	struct perf_pmu *pmu;
-
-	/* Metrics aren't currently supported on heterogeneous Arm systems */
-	if (perf_pmus__num_core_pmus() > 1)
-		return NULL;
-
-	/* Doesn't matter which one here because they'll all be the same */
-	pmu = perf_pmus__find_core_pmu();
-	if (pmu)
-		return perf_pmu__find_metrics_table(pmu);
-
-	return NULL;
-}
 
 u64 tool_pmu__cpu_slots_per_cycle(void)
 {
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 17306e316a3c..1c7a2cfa321f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -587,14 +587,12 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
-const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
+const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-        const struct pmu_events_map *map = map_for_pmu(pmu);
-
-        if (!map)
-                return NULL;
+        struct perf_cpu cpu = {-1};
+        const struct pmu_events_map *map = map_for_cpu(cpu);
 
-	return &map->metric_table;
+        return map ? &map->metric_table : NULL;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e44b72e56ac3..d781a377757a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1103,14 +1103,12 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
-const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
+const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-        const struct pmu_events_map *map = map_for_pmu(pmu);
-
-        if (!map)
-                return NULL;
+        struct perf_cpu cpu = {-1};
+        const struct pmu_events_map *map = map_for_cpu(cpu);
 
-	return &map->metric_table;
+        return map ? &map->metric_table : NULL;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 5435ad92180c..675562e6f770 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -103,7 +103,7 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pm
 				     void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
-const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu);
+const struct pmu_metrics_table *pmu_metrics_table__find(void);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 514cb865f57b..45838651b361 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -818,11 +818,6 @@ static int is_sysfs_pmu_core(const char *name)
 	return file_available(path);
 }
 
-__weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
-{
-	return perf_pmu__find_metrics_table(NULL);
-}
-
 /**
  * Return the length of the PMU name not including the suffix for uncore PMUs.
  *
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index fba3fc608b64..7b3e71194e49 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -260,7 +260,6 @@ void perf_pmu__arch_init(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 			       const struct pmu_events_table *table);
 
-const struct pmu_metrics_table *pmu_metrics_table__find(void);
 bool pmu_uncore_identifier_match(const char *compat, const char *id);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
-- 
2.47.0.199.ga7371fff76-goog


