Return-Path: <linux-kernel+bounces-400299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD69C0B86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4491F218E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADE219CA7;
	Thu,  7 Nov 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18y3afOa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DD219C91
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996459; cv=none; b=HayMQlFgc5FQ9OTbx/QkCabUPIitFtndJXOjJRRTxSz4VxwqgFMyOo3LA//Q7WtTbg7/yshEK9HYyd/+PRKOUZH31QkYEdjKIRImzVsjdawOrkmBsFK4Uhjyw/0p4hPhGExLCm7D1KNLNtAxBcd/s+uMYxWRGrRG0xWGxdD/zBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996459; c=relaxed/simple;
	bh=CajUs616qyGppVWZm3vfBDC8+tgu0BtGWij+wkPy5Mo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EQgtA6BB0crn63ltuUB/VS66H+4sMIs8yovH0JLoCv3giPKd2Pfnlz3k+FKmbP+9P3YwQJx99d8XNlPSnGMXoekUA9I3u9zid1zMocqHAxeMFSDeROed2Rdcmj+oERirWY2OmHLsOxdIKCAy7ZdQ8/fwLSfvCgyaukZoGVus1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18y3afOa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea90b6ee2fso20080717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996456; x=1731601256; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmDxOz/jwQKQ9IxxvIQzkp5N2zsrObhsgCU4K9BCHGc=;
        b=18y3afOaEsuDgT2+2V/ctSZfF7MOErusX0gPmmS7dk/dJUuWKWeY+/SEuzQzG3SQVD
         FQlFFsGyu/+qKJ4S+zCA3SeCnidWhMzhg2IHp17TrKt13FWPBv/O10JszKGSSWuH3MyE
         zQcudwDuI5AXsiq/d8hn7tdgeOopHqe+WjZ1U2xbs2yZ3tVQE61N0SXRkP1JA9lDgAbj
         FgG0ifHH6eb3kTdRI6EfvjhMPbsAtWPGRp76hjDbJORywkduLAFZXbhEuUTiDAuWWoYa
         V/ldZY+U/i3S6mTVcbUpERgHnH7bchh+UKKe0CstIPdJv94hZ153EIQqIoHsTrDVpoUh
         JcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996456; x=1731601256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmDxOz/jwQKQ9IxxvIQzkp5N2zsrObhsgCU4K9BCHGc=;
        b=jzpuMvehmgSjdLlwEyzjaBDTAXF96ATEvuXXPoRoUe/lG9q8v9lHVEcpRE1YNdHzyb
         DTckpfhD6Rl9ogBq/TTV1tyVzHUE22TJaWJ7qSKeHTkBAIHfKZrchi3T8Bq8dFhZllbp
         wpOSlnBMIVw65lVgYM+ZyxMp9XDLur4AjRzGUKdBGyvBeI7fryehiB7sBETrB+xt6MY0
         QIJ3vWA4w9ZTXqGmcNBpVVOUXlaMjvh6HJXOtQMwAd6YyPziwm7tSKiE1hRAKVdys5K0
         mR1pJUKYZ6OQtf4yREY0VBCwQpapN78TjrixFu4V++hZvMaT4Poj4u31MgaNUOyE++/N
         /g2A==
X-Forwarded-Encrypted: i=1; AJvYcCV71NsHRA4i/387InAQtKLxsAfmsmx0ZxOjuwJL0hOXu/1TRqNVIq1+EfkVfMbLgsUxqj4EHql6nmcbEc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30Pc46TL64GKND4y5/2YThlPoquvruqamXnFTCfi4CC7eNJBm
	DMReC3yN59lZdofCi3yaRfxzmBwUWU3sV1+3sFluauXDsCjfKLr0gr1ZJlrPYBhKHeVrGH+2Ypx
	A31bWag==
X-Google-Smtp-Source: AGHT+IHCkQtw3cbe4yQXJVnOkaPBqQ3DtdlxV254RMwS9iWgJ8X5235+bgRmL2AfqDh6oANhnB+TqaB5uCbI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a81:de03:0:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6eadaf980f4mr79097b3.3.1730996456017; Thu, 07 Nov 2024 08:20:56
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:34 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 7/8] perf jevents: Add map_for_cpu
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

The PMU is no longer part of the map finding process and for metrics
doesn't make sense as they lack a PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 20 +++++++++++++-------
 tools/perf/pmu-events/jevents.py         | 20 +++++++++++++-------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 51ca8d61c15d..17306e316a3c 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -503,11 +503,11 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
-static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
         static struct {
                 const struct pmu_events_map *map;
-                struct perf_pmu *pmu;
+                struct perf_cpu cpu;
         } last_result;
         static struct {
                 const struct pmu_events_map *map;
@@ -515,15 +515,12 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
         } last_map_search;
         static bool has_last_result, has_last_map_search;
         const struct pmu_events_map *map = NULL;
-        struct perf_cpu cpu = {-1};
         char *cpuid = NULL;
         size_t i;
 
-        if (has_last_result && last_result.pmu == pmu)
+        if (has_last_result && last_result.cpu.cpu == cpu.cpu)
                 return last_result.map;
 
-        if (pmu)
-                cpu = perf_cpu_map__min(pmu->cpus);
         cpuid = get_cpuid_allow_env_override(cpu);
 
         /*
@@ -555,12 +552,21 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
                has_last_map_search = true;
         }
 out_update_last_result:
-        last_result.pmu = pmu;
+        last_result.cpu = cpu;
         last_result.map = map;
         has_last_result = true;
         return map;
 }
 
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+{
+        struct perf_cpu cpu = {-1};
+
+        if (pmu)
+                cpu = perf_cpu_map__min(pmu->cpus);
+        return map_for_cpu(cpu);
+}
+
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_map *map = map_for_pmu(pmu);
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index b5ff872e2beb..e44b72e56ac3 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1019,11 +1019,11 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
-static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
         static struct {
                 const struct pmu_events_map *map;
-                struct perf_pmu *pmu;
+                struct perf_cpu cpu;
         } last_result;
         static struct {
                 const struct pmu_events_map *map;
@@ -1031,15 +1031,12 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
         } last_map_search;
         static bool has_last_result, has_last_map_search;
         const struct pmu_events_map *map = NULL;
-        struct perf_cpu cpu = {-1};
         char *cpuid = NULL;
         size_t i;
 
-        if (has_last_result && last_result.pmu == pmu)
+        if (has_last_result && last_result.cpu.cpu == cpu.cpu)
                 return last_result.map;
 
-        if (pmu)
-                cpu = perf_cpu_map__min(pmu->cpus);
         cpuid = get_cpuid_allow_env_override(cpu);
 
         /*
@@ -1071,12 +1068,21 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
                has_last_map_search = true;
         }
 out_update_last_result:
-        last_result.pmu = pmu;
+        last_result.cpu = cpu;
         last_result.map = map;
         has_last_result = true;
         return map;
 }
 
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+{
+        struct perf_cpu cpu = {-1};
+
+        if (pmu)
+                cpu = perf_cpu_map__min(pmu->cpus);
+        return map_for_cpu(cpu);
+}
+
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_map *map = map_for_pmu(pmu);
-- 
2.47.0.199.ga7371fff76-goog


