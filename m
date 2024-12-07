Return-Path: <linux-kernel+bounces-435891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCB9E7E4D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BFA285BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7503EA83;
	Sat,  7 Dec 2024 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Br+44kLB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1A13C690
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733548899; cv=none; b=Xj5XBkdJ7Wf/7p7LCPVy/9+hqLMQbJqyeI+2dZs+T1SdgKJ1OZVGJ9cKVlO2uQrZc0oIOfuBgKgcbfjc0FnKIRbLCW4cFdfX+RSZjdurFPFrWDElrgreaC2hd6Pk7dGu4maduhA2zcyr2UxFMcstqhDbm3W/6g6c8e4Z4puyHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733548899; c=relaxed/simple;
	bh=59JyblyIutLvUKEhP7mnHqGeq0rntjJy0UC24HCSh6k=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=DmDJtwu2y9GFVmTGW4VXKUWPucyoWtyBrkqNfGiXbkr4TiKWC3UEWBD0kNiJiBZlxswl8NiBAf1L6R2mnTWPXoCN920cw6rjIM3yRJMeYHBiDJnCLgobc9Di/YkWh85l3Gjy0g8e8oYUUbpR73vVxRimsTwa9hCcy4MjxgR0/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Br+44kLB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef7c67eeb8so26373087b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 21:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733548896; x=1734153696; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLon7XSyUPwjTsFm/4gR7+qNav8R9JC1iiVeHS6j/O4=;
        b=Br+44kLBT53VEgLMdksf4pT58D3G0v0GHzrUibJxDn/w8GpS10Z+mhppJ4gmswVN5X
         2XlEGG1g4ccFHOZC+cZfRrccR3h11NSXn92Y3igjD9eSToMTh2YfrdG/TLpwxgcUxYMk
         lHgmONOlLa4D4oAJdN+gh61VZ1B40ArIsZInAwuUgpAiwivebIgx4GAknXIwgZdvHYrt
         xQtAL+24vyJPx0kWyUkIizk7v9FMTQFsk1rqSiKNcTDoE5cswW7pdxXWr8NIa5Zjlev1
         q2xXdAWsLmKcWSLZcczyblpJbkQ9AkNX0EGSwynDnxx50qVuDvkz0nAc9kgZTUoACsB6
         mJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733548896; x=1734153696;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLon7XSyUPwjTsFm/4gR7+qNav8R9JC1iiVeHS6j/O4=;
        b=J9of2d0Fiv2z2ObbEVT/VrSBAiuvzQ3m6ps8BoZwxKrrpez0h2NukILoiW8zSdPreE
         14S7HbFQxulUdlXxMarGuuCBIM6vqv4ijOZFEgPpWAHV9y+sS91h5S+rTbzdjfoe4tZb
         +Bkj6vPguzpPY1XSK/4ygzPHqKSABbwDtGTKY3K+8Bm+6+YAfT2DgPyZQmbwu3F4ldqS
         YlMCp84rgNSP7Wr025iJiUSZaXiKLr17ak9+8XDhCpXfxyGWZzKt97IT6l0NU5v09BhI
         +K+NsohAyjecD8L+lzlle0QNfJXJt+8a/mJISsM97G+jJhkqFHqMkDIcWSx/W5u0V5wU
         CWGA==
X-Forwarded-Encrypted: i=1; AJvYcCVIqckwq4XS4M2jyuei/k5eWe6ipgVpSx991cOLQouGk+amB9lDdrkwvmtTTj9D85Gj+T6msP+gR8a8Vxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2J90HwWJsi5JYkpa0Lm9T2qwbRzsRX0hevIcb2qXo78qsjX7
	1SBOK/XCJJ3i6udmYpvKECsURxJJLunVPXMGoLMvhoQNGmDF/9fsB81X4AVRF+cUW/N7C7RF5Ob
	DuP3slg==
X-Google-Smtp-Source: AGHT+IH+fXx0bYWssoFcE7HUKGApjhCNtZqf2R5ASFIjVo19wS3+ep+HzZKXWN7Pdi49a1J5WOifTWQLXAeq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:dfe4:4b6f:235e:bf6b])
 (user=irogers job=sendgmr) by 2002:a05:690c:3143:b0:6ea:ecc3:ec61 with SMTP
 id 00721157ae682-6efe3bceae7mr82897b3.1.1733548896528; Fri, 06 Dec 2024
 21:21:36 -0800 (PST)
Date: Fri,  6 Dec 2024 21:21:33 -0800
Message-Id: <20241207052133.102829-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] perf cpumap: Reduce cpu size from int to int16_t
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
	Kyle Meyer <kyle.meyer@hpe.com>
Content-Type: text/plain; charset="UTF-8"

Fewer than 32k CPUs are currently supported by perf. A cpumap stores
an int per CPU, so its size is 4 times the number of CPUs in the
cpumap. We can reduce the size of the int to an int16_t, saving 2
bytes per CPU in the map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This change is on top of:
https://lore.kernel.org/lkml/20241206044035.1062032-1-irogers@google.com/
---
 tools/lib/perf/include/perf/cpumap.h |  3 ++-
 tools/perf/util/cpumap.c             | 13 ++++++++-----
 tools/perf/util/env.c                |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index cbb65e55fc67..760a9aae9884 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -4,10 +4,11 @@
 
 #include <perf/core.h>
 #include <stdbool.h>
+#include <stdint.h>
 
 /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
 struct perf_cpu {
-	int cpu;
+	int16_t cpu;
 };
 
 struct perf_cache {
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 27094211edd8..85e224d8631b 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
 {
 	const char *mnt;
 	char path[PATH_MAX];
-	int ret = -1;
+	int max, ret = -1;
 
 	/* set up default */
 	max_cpu_num.cpu = 4096;
@@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_cpu_num.cpu);
+	ret = get_max_num(path, &max);
 	if (ret)
 		goto out;
 
+	max_cpu_num.cpu = max;
+
 	/* get the highest present cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
 	if (ret >= PATH_MAX) {
@@ -455,8 +457,9 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_present_cpu_num.cpu);
-
+	ret = get_max_num(path, &max);
+	if (!ret)
+		max_present_cpu_num.cpu = max;
 out:
 	if (ret)
 		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.cpu);
@@ -606,7 +609,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 #define COMMA first ? "" : ","
 
 	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
-		struct perf_cpu cpu = { .cpu = INT_MAX };
+		struct perf_cpu cpu = { .cpu = INT16_MAX };
 		bool last = i == perf_cpu_map__nr(map);
 
 		if (!last)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index e2843ca2edd9..f1d7d22e7e98 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -531,7 +531,7 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 
 		for (i = 0; i < env->nr_numa_nodes; i++) {
 			nn = &env->numa_nodes[i];
-			nr = max(nr, perf_cpu_map__max(nn->map).cpu);
+			nr = max(nr, (int)perf_cpu_map__max(nn->map).cpu);
 		}
 
 		nr++;
-- 
2.47.0.338.g60cca15819-goog


