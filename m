Return-Path: <linux-kernel+bounces-278713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB6A94B3F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A047C1C20F75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5933BBE0;
	Thu,  8 Aug 2024 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="StF8rwwY"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9FC8C0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075368; cv=none; b=U7/3tEzk8l9lU/PkJrn8D5LyCWJH/izPvKC7+/9993Piysa7DISq49VzP2YxbYCRKsA+t4s/WEgsPrppMs1RNf4HZCTD0IVARPQ6HwQFLXi4/lURY4GD0PZ2saIKWjQqgLO2LX1SkDSB3vue1c96eLfdGyh3wTAEaniHk7X0DBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075368; c=relaxed/simple;
	bh=PLec4BWlWUsM/t9o8cJqaayRfPM3UGKocb1ebQzR44c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Au1nOBidh+7HAm6Tqc1llmXqPgXYC3W+vAB/EeeXZ07dfYKHwoBQ+fFWzN4kc2Y7Wag+v6GQ/YYR7JNN+73cFBWGWBylny4WLWFpacOZ6A3NZKieTECv/yebv2Tt7OkgcTX8sF7SMNg2pCFgYjjaflgqTWFQDIUfU0wyhDVuGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=StF8rwwY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso335715a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723075366; x=1723680166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxNS3a4ltAskNvEMrzz4GNQwPwNhtM7sueZi805L88w=;
        b=StF8rwwYjLiPxEZlZcLhg1H/RG8ijKxZwUCVxuVAcO/xTy30lf+0XvFSukHiihCajP
         8RqAEs9jHMJwfuZEBGxh3hmZZdPHV98m4TM8H8RkUqc8T4r2BHlFWt5IEESvttMrL7qc
         f9aUkAH7g07izhWBxOpA1SOazHo9ityiAjyrRpnldS/XXLEzKNTXs10GOdR3whgUwt0D
         eVGGq41LPMujMdGoSy0RMLXJz5A4DpMrGtJ09zgKOxSegoHHo2Y2Or/xWp8EUSnAKbjf
         XrdGP1f7oEMCR3m+FjEdb3tGLFKiWQi2fw3uFU05UjuyRPbEL8BWhppJH6PSiuZCZwhl
         AnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075366; x=1723680166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxNS3a4ltAskNvEMrzz4GNQwPwNhtM7sueZi805L88w=;
        b=C/QtvvOJnLIiEEkotO9H4K5cgjomxAF8+Eel2OylJu4UiP7h+9Ebse88Y9V6RVLLRK
         b9l3K0AowuVqlGTFWbnOyor1QIBNJ8Dsg5LKKMWZuW5gOXnm/DYhaL4TGm4dmrV+n+Y7
         hSDWuz2WQl4eXfY4Z4n+wGmFl3QbjUMd0e/Tb39cVtPvN4pQUzktMQB0U07dz4lfbsbM
         hHo+470UoUYbQ+bFI7GexfQVJ89ATrfQ2e56FpSR8ZDceAgyms6PL8AlyN3Gu3A+9SUE
         1iuzrT0tq6bmoVC9dkyuqqgpBJSVddiLLtUSQceEVjzFrILrSnAiJ4XDpNYLTuy/C5uy
         m3nA==
X-Forwarded-Encrypted: i=1; AJvYcCWNzrbGvyUK20l0iE3QinyXpNVpeW8I0XBqcH3JbUoR57PXDv72+WPH5V8yjzyOBRVI54OpCff6XHzKtqQ8wMu6IGte92JjB9lQahqI
X-Gm-Message-State: AOJu0YzfQAgVdN6WHx/RMb0fMmEYvw6i4v6V5UpRxXGiSTgsxVEieZOd
	NbFpMxHvpplphfp+2Dts1nG4KQEv2l2byYXb831p0VoU+G1MhbOPp95Mei8eUxI=
X-Google-Smtp-Source: AGHT+IHmY7jw5RPrhhkeTFYtNulkLVfNeKpreQMsWh2pSTjIaEQbmV03fRSpB1FH63AQYQl496TJug==
X-Received: by 2002:a17:903:41ca:b0:200:8c4d:9120 with SMTP id d9443c01a7336-2009527d669mr3253175ad.39.1723075366476;
        Wed, 07 Aug 2024 17:02:46 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f586f7sm112867015ad.90.2024.08.07.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:02:45 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 07 Aug 2024 17:02:42 -0700
Subject: [PATCH v2 3/3] libperf: Add perf_evsel__refresh() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-perf_set_event_limit-v2-3-823b78d04c76@rivosinc.com>
References: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
In-Reply-To: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723075360; l=6556;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=PLec4BWlWUsM/t9o8cJqaayRfPM3UGKocb1ebQzR44c=;
 b=ZqA/4Nnzj0RoCv5FaSNncMVmhDEIvj6ivD4GQoB11G2GhUBeLI2+tN75ypxQGbeqUPfk5KLr1
 /VmiGfR+3cPCy5RJtC8+IJvAmswfJbRi2yEjtFcMf4GMywYmEAnRjeI
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce perf_evsel__refresh() to increment the overflow limit. Can
optionally enable the event immediately.

Co-developed-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 49 ++++++++++++++++++++++++++------
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..a6c3bab5c995 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -147,6 +147,8 @@ SYNOPSIS
   int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh, bool enable);
+  int perf_evsel__period(struct perf_evsel *evsel, int period);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..2b7ca7fa4998 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -18,6 +18,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
+#include "internal.h"
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -412,7 +413,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 	return 0;
 }
 
-static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
+static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, unsigned long arg,
 			     int cpu_map_idx, int thread)
 {
 	int *fd = FD(evsel, cpu_map_idx, thread);
@@ -424,7 +425,7 @@ static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
+				 int ioc, unsigned long arg,
 				 int cpu_map_idx)
 {
 	int thread;
@@ -441,7 +442,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
@@ -451,7 +452,7 @@ int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
 	int err;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
-		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, idx, thread);
 		if (err)
 			return err;
 	}
@@ -465,13 +466,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
 	return err;
 }
 
 int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
@@ -480,7 +481,39 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__refresh(struct perf_evsel *evsel, int refresh, bool enable)
+{
+	int i, ioc;
+	int err = 0;
+
+	ioc = enable ? PERF_EVENT_IOC_REFRESH : PERF_EVENT_IOC_INC_EVENT_LIMIT;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, ioc, refresh, i);
+	return err;
+}
+
+int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
+{
+	struct perf_event_attr *attr;
+	int i;
+	int err = 0;
+
+	attr = perf_evsel__attr(evsel);
+
+	for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
+					    (unsigned long)&period, i);
+		if (err)
+			return err;
+	}
+
+	attr->sample_period = period;
+
 	return err;
 }
 
@@ -491,7 +524,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
+				     (unsigned long)filter, i);
 	return err;
 }
 
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 6f92204075c2..e562dd9f39e0 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -40,6 +40,8 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh, bool enable);
+LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 2aa79b696032..bb7a48befdd5 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -34,6 +34,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__munmap;
 		perf_evsel__mmap_base;
 		perf_evsel__read;
+		perf_evsel__refresh;
+		perf_evsel__period;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;

-- 
2.45.0


