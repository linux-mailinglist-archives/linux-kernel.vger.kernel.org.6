Return-Path: <linux-kernel+bounces-434414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426099E6673
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0AD16528D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FB1DACB4;
	Fri,  6 Dec 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6bQjJlF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373D1DA31D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460056; cv=none; b=tTuKX5DQobk32cJpU4sGVq7cSRdYwH+0ePrWNOHBJkDexslrfYcMvQ+l819tnNU8rAmFl1QO81e5uWTlb5R9gKUiiAZwX92E64Ay7cVm6+rj/SiJAby8vdt3RAzW/G3l9P/VTwIFlr/eh7qvoQ54c0pdkppMptBWoz4FUguBpak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460056; c=relaxed/simple;
	bh=6qQMnPoV7toq2InjiyqPN49G1JW//BJ3BW+cL78lXpk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WOhAosyk6iBNYtOOUP2BP5rvXjY21Aryzs+uZWorGrv0s5Yu8jUlEioIexq9GIybhEnpI0w82pYKZaqHVNiJ97o3ETVpeYz8BhJn8FVzNDtdCJlqFikb8+Uff/HmUIFazP9vob3sy+xgstn7Kimc8AIY7cAQoCLkxEuSgmkgZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6bQjJlF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39735ccf1aso2883019276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460054; x=1734064854; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PLDQ9cMJwyt8LLu+m8FYi+OjRqKatCbRkdPuiWR/4w=;
        b=P6bQjJlFbhFZWfQ6XenH1y8deOqZ2RSENJxQ1iYR2F8EA1CEUTaFkyLEft0tg6Akaw
         z14LqzAS25OpLqLjSiw2TsqQJ8dztwjI+qL5e+Yd6jniCH1x6aIgCzDCsWMJFg12wkGs
         GDRh9EoRqFiQmN9isPdFZVCEC6c2jY0Owo5g91Cobxfa4UMwFsWHQut4s0KwOuZZGdjp
         g6MBDxR6sRrlltcbkkb/xmteZt9sJcsEcgDyDhaKNsu3mLSBd3EDWrUg73UAhE8akUqN
         kxZx9cNzqWxnjkZJDNcl8zCRgJMeLoiTY35yDayXlZG8vNzPTqEQWCB6PaertIMVKTII
         amKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460054; x=1734064854;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PLDQ9cMJwyt8LLu+m8FYi+OjRqKatCbRkdPuiWR/4w=;
        b=VABODHKslhrXiieXPZs+MS9bjZ55XqrtrHdN6Ao2EbvwvI3R4/h9YOfvIcvifRVsuC
         teGRWvvrYIHj/ALSHtTy18YbcvPyL8oj3O7Q6oiFCc+p+2OhCHylzq6Z1T9XBEsKhZ3X
         Pv4ZZHcHl6biY8OOY2pffwMWmi6KosHu+JLC1tNWRFJ5qJ8zMMkO1PaRpzoZPB5rYMa6
         q0YIIYToQpQzu1S8j93Q2OdqRlO2g26xxp4jxENATZfLTrYIpFYXsrqS8XJPXjVXOxBh
         HJEvRWVzPEB1yGvZFah9rqPEZ5y2aye63je5Yw1kqu8RdgTYAyq4DinytK4X7pP+dsT3
         XbvA==
X-Forwarded-Encrypted: i=1; AJvYcCXRsa7lSdhBgXKY3e2PgGnBOOS9zRg82qe2xB2usGhFf2diccv2ays2Ipq3VyhdASSk4/tzrvn2brvCAkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyralJvvTFzBHKH2b1Mtq2IqwHVoKKHA/MxEyKC+AUDi2uqhZXV
	h4gzdlIQF8a4am0F9R9ajsXIUgHS6cxCCGikbZMFt1958Ct0fFbeTWbW7pxB9/c7BYitLQe/cPt
	cDv2pjQ==
X-Google-Smtp-Source: AGHT+IGLwIotlj7ZIG269cEmwqa4ILVBPe9NX3i6hHv+wncSepxMVPXgIEEsA2H9UUJWcX9Ob7d2QOTkOVMz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:d352:0:b0:e39:3168:53be with SMTP id
 3f1490d57ef6-e3a0b4a2261mr1162276.9.1733460053972; Thu, 05 Dec 2024 20:40:53
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:34 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 7/8] libperf cpumap: Remove perf_cpu_map__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function is no longer used and duplicates the parsing logic from
perf_cpu_map__new. Remove to allow simplification.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 -
 tools/lib/perf/cpumap.c                  | 56 ------------------------
 tools/lib/perf/include/perf/cpumap.h     |  2 -
 tools/lib/perf/libperf.map               |  1 -
 4 files changed, 60 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..59aabdd3cabf 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -39,7 +39,6 @@ SYNOPSIS
 
   struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
   struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
-  struct perf_cpu_map *perf_cpu_map__read(FILE *file);
   struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
   struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
                                            struct perf_cpu_map *other);
diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 60ef8eea42ee..17413d3a2221 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -161,62 +161,6 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu
 	return cpus;
 }
 
-struct perf_cpu_map *perf_cpu_map__read(FILE *file)
-{
-	struct perf_cpu_map *cpus = NULL;
-	int nr_cpus = 0;
-	struct perf_cpu *tmp_cpus = NULL, *tmp;
-	int max_entries = 0;
-	int n, cpu, prev;
-	char sep;
-
-	sep = 0;
-	prev = -1;
-	for (;;) {
-		n = fscanf(file, "%u%c", &cpu, &sep);
-		if (n <= 0)
-			break;
-		if (prev >= 0) {
-			int new_max = nr_cpus + cpu - prev - 1;
-
-			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
-							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
-
-			if (new_max >= max_entries) {
-				max_entries = new_max + MAX_NR_CPUS / 2;
-				tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
-				if (tmp == NULL)
-					goto out_free_tmp;
-				tmp_cpus = tmp;
-			}
-
-			while (++prev < cpu)
-				tmp_cpus[nr_cpus++].cpu = prev;
-		}
-		if (nr_cpus == max_entries) {
-			max_entries += MAX_NR_CPUS;
-			tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
-			if (tmp == NULL)
-				goto out_free_tmp;
-			tmp_cpus = tmp;
-		}
-
-		tmp_cpus[nr_cpus++].cpu = cpu;
-		if (n == 2 && sep == '-')
-			prev = cpu;
-		else
-			prev = -1;
-		if (n == 1 || sep == '\n')
-			break;
-	}
-
-	if (nr_cpus > 0)
-		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-out_free_tmp:
-	free(tmp_cpus);
-	return cpus;
-}
-
 struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 {
 	struct perf_cpu_map *cpus = NULL;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 90457d17fb2f..cbb65e55fc67 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -3,7 +3,6 @@
 #define __LIBPERF_CPUMAP_H
 
 #include <perf/core.h>
-#include <stdio.h>
 #include <stdbool.h>
 
 /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
@@ -37,7 +36,6 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 						     struct perf_cpu_map *other);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 2aa79b696032..fdd8304fe9d0 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -6,7 +6,6 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__get;
 		perf_cpu_map__put;
 		perf_cpu_map__new;
-		perf_cpu_map__read;
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__has_any_cpu_or_is_empty;
-- 
2.47.0.338.g60cca15819-goog


