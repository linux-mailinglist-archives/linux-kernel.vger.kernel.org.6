Return-Path: <linux-kernel+bounces-399446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D69BFEF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF1A283B40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464E19A298;
	Thu,  7 Nov 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SbfZgFO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED361E0090
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963779; cv=none; b=atohV2oksqW41V98xV1GfNay/tU5E8PkucU/epE9deulAWUqjSAM0760qzWDdrifGjCVe8PWwHF1qQN3AHSYPIzS3fLaSzgTDejYNoAoPTyQEPBgG41HSCCaZSbJfc8k44xupFepfqF8xDX5voiPJYQlNj+rDSuUOsM5S8oS4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963779; c=relaxed/simple;
	bh=621nA8jfddmRAyxLcB0DU3OLEEfVq/wb6tXRw65bXDo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=b+ZLSzmwAPeacQiS5UIp8H/TCq1TFF1uFuC6LSL0yQ77YoWk9gIrWSMr4C/7pU6JeHPcwG/zT4XSHJG+vBVZOZmCP5ccOW4HGMeYDeSiPFnsAsFB1yhir6wpDSAi0JIr8KAVj+AHiylnN9FDuTNsKy8XDsWq1IwDpm4kBw4BPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SbfZgFO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e59dc7df64so8863667b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963777; x=1731568577; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYK64IbVI+oTr67YzD9eKbuyvUN57DhW3er38c63SVk=;
        b=0SbfZgFOwrcdUHbgH+xbR3fcXdQ4N108Uzf6Mi4F4UQjrjd2UTwtHjdptf411s4vcq
         pwm7yEARlGkA58G22DlUWKlfZTfnyiLib+iydJdCB7jQca42GzWi+dTwvnI5EZ6uRyT0
         IhRuuhYyE/TKdlkIQ7lYtgQyPyF9Fi/x0jkVPWkve1wGRVE2OjirEM90d5c6bryx9o9o
         7AqaNoSm7QmpEahVaZRitsOVp7Lkltl+ICX/7TSN17zXcxwgCoptQ11w3kW69+jV09Uk
         n2l0thVVUlYs3PQ2NKgbhmndGofD6bb6MvJJFetlwTafIg2VyRgIgWNOzxUcuuVizLEw
         2fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963777; x=1731568577;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYK64IbVI+oTr67YzD9eKbuyvUN57DhW3er38c63SVk=;
        b=NCKTQYAel6SWouFon1UQEjKpY00Gb9QO5/hcpf1hSJS8TPchKAZoNZ0faDAU74vvg9
         t7TjwBA+ymdwawxcZoe13ZdSxbIcccIord/kjaLT9b+i/7NNW6An8ZKNpaw+ywobH1eb
         m2rVkxLjaNJ/1NVPNQCZzLHJAY1h+6XlXHNDD8a5Zp8XNhTV+HkT4ByBMAbSMzh3kDeY
         NS5zfMZkc96Sme1mp5WmCwCxSWqR3jIXhSRadR3uKjjAm3p3dKl3avcXikTQJgpZhV1d
         oiY9vbpw9thgOfsXOnhgF8LMuWmHkOvRbf9xjO3G9tJzFgHzIPNJzMI2azQymZ2ilEa+
         UXsw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOyV8hGE6GjgUccfwYgXUs2zjHPhiGo/eLRO9i5cP2DpM0o4zxgRSfnDuDXIuSIAFKZLUeSuIMMuSQFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++hqmkbcbfsg6hKlBc188GMPI+GKIl3Aj0JRcRH/UUIJQF8yj
	ixIubZBjnzdmDH+e4MS7uSvPfY+WJGqJ9khn3upviEqVI7xfc6Majx06/wyydzl4tRuBUa7klBR
	f+rYM/w==
X-Google-Smtp-Source: AGHT+IEE1yqKHgqlv5intPfLwYeQKNT3vieLxoXotrZ7qIt8KVtU6GVAtqxkz210BAUWXZlbW1ErAef+mNNv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a81:b512:0:b0:6ea:881b:b545 with SMTP id
 00721157ae682-6ead646907emr707b3.4.1730963776837; Wed, 06 Nov 2024 23:16:16
 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:59 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 6/7] perf jevents: Add map_for_cpu
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
index 1f7f39a89ffd..2151e8a43f16 100644
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
index 17cd1b1c6b66..6d6780ca0889 100755
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


