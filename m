Return-Path: <linux-kernel+bounces-574557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA3A6E6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1988173F73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DF1F416A;
	Mon, 24 Mar 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dH/R2PeI"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218A1F3FC8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855717; cv=none; b=Sgtty9gr40TcH6raeqtJy+60EuxHFm2YFL8a1vwjmSUQuYn1mXJqTbWInDdQJooUv4CVU5Jm5uW61k8UzuPYCpISko/O4bFaY0Wf7nlmcdgKx9ZpvO/UgPlKfkJyTkKX36/9z3DW+79qjOohAy2zYJWJcra8kmvDH9zb+addqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855717; c=relaxed/simple;
	bh=rIoxBTutYw9EVXlG55qzB96t9LkfdQ51B8mxe3NCbFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XeWtl+OlSWJyMu8QseL+3/q1MYdUdSNktiq5HT6A/dzjZK5yoiPtdxMKoFDBkTqvWQ/E1w+I4qFvI2tN+kXZHuQZmiB2v7enLIin3UWddHzFCwuXK9L1q7248w8EW3ioE4KWuKMSguFyUi7as9/5RfrYFWe1yhPnlXKcUuBLmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dH/R2PeI; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-601f0dc8663so3779754eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855714; x=1743460514; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82mQ+1IXaR2VMHbas+zrTy9HH/vkv5hKIyVlatfq+jQ=;
        b=dH/R2PeI5smgBy7GOpN11paUmyt3Dxpp0mwElC2ebseOtVoFOnypII2KPj3DMNHJ34
         ng10bWHYKMPjQ/NBYeWCXT0P72edwkgzXGJLGqDnIkdzNuJ3cje1k82/LKVZLEZxAH2n
         DX/zDL5V5mhDxyn5mqond+Y3QliIq173URiXNS5jeT+TvBpeluOJFMOtJGTx8FQHlUx7
         YVvWiiZQj8CW3C308iF5YRtSu8sS3laP32ss8u5Puzg/oiZeRDBvDPdQezZ2tpHHctZD
         lny/m5Q546KLC1m6ZvqvZ/3T/JucnusaYXUeleVWn9SBX/BCwFAfKHwmaMrEvj0Pm6OC
         zElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855714; x=1743460514;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82mQ+1IXaR2VMHbas+zrTy9HH/vkv5hKIyVlatfq+jQ=;
        b=hx8LpPphKYaoUlNsO6DgClhCGXGWinqt0uUENbSwmuuwDAomsK0KWsRBos2pjxwoDZ
         XemIX368Nz5lIhrjwFC5m0DaoqHbd0SgZyKhE/qG61/Xm9/cGUOwbtaKNKXeuMqjAAjU
         G6VFTun+xY5HsVkFgMgK1piSeJ5Uj26r7khXqLzpOksLwer8Yvhm9FbNAk9YP5KSRP6e
         ahKoSO9KEAQuDjupnmrXj8MZz/S2LDJg7yIRCLEi8DUTBT9lwMnke6aVq75/61QAZ85o
         1vpvw7C3SGYEdmDcGAvz2MDiFH6QAQUzuqTiS6JF7seCW+mZp5KSCRAKz9jQQaM02nue
         kTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHnkbe6srU583tAWYzXtenFADj4J8mPv4UUd6RmazKVcHmX+bzllr0Y7plnJi1JJYf8BOcrjHRFMX6V7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdA7e3ET4wdaSBmD9naxjKyg3+vFZ6YwllWB7I2bO5m7nWoQ07
	uQc9R4zMmaK/8elvl30CodtBtzrwx+pyonOBsJ5ANjwB5UMnummdZr65JtMfBy6M3r69hw6fL9O
	OUe2WCw==
X-Google-Smtp-Source: AGHT+IGMonSv07nS2wp2+XCCHzVmYpXNUlojv8r3liVHzTEgZqvcA1ToLi0TGOEDOuu91o5vEOFn9a/03W2i
X-Received: from oabsf6.prod.google.com ([2002:a05:6871:2306:b0:2c4:3490:8790])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:a711:b0:29e:8485:197b
 with SMTP id 586e51a60fabf-2c780243a61mr9913650fac.2.1742855714663; Mon, 24
 Mar 2025 15:35:14 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:47 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-10-irogers@google.com>
Subject: [PATCH v1 09/14] perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename to reflect evsel argument and for consistency with other tpebs
functions. Update count from prev_raw_counts when
available. Eventually this will allow inteval mode support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       | 11 ++------
 tools/perf/util/intel-tpebs.c | 52 ++++++++++++++---------------------
 tools/perf/util/intel-tpebs.h |  8 +++---
 3 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 554252ed1aab..1d343f51225b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1718,11 +1718,6 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
-static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
-{
-	return tpebs_set_evsel(evsel, cpu_map_idx, thread);
-}
-
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 			     u64 val, u64 ena, u64 run, u64 lost)
 {
@@ -1730,8 +1725,8 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
 	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
-	if (counter->retire_lat) {
-		evsel__read_retire_lat(counter, cpu_map_idx, thread);
+	if (evsel__is_retire_lat(counter)) {
+		evsel__tpebs_read(counter, cpu_map_idx, thread);
 		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 		return;
 	}
@@ -1889,7 +1884,7 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_retire_lat(evsel))
-		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
+		return evsel__tpebs_read(evsel, cpu_map_idx, thread);
 
 	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 500c472f7059..486218757872 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -409,49 +409,39 @@ int evsel__tpebs_open(struct evsel *evsel)
 	return ret;
 }
 
-
-int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
+int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	__u64 val;
+	struct perf_counts_values *count, *old_count = NULL;
 	struct tpebs_retire_lat *t;
-	struct perf_counts_values *count;
+	uint64_t val;
+
+	/* Only set retire_latency value to the first CPU and thread. */
+	if (cpu_map_idx != 0 || thread != 0)
+		return 0;
+
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 
-	/* Non reitre_latency evsel should never enter this function. */
-	if (!evsel__is_retire_lat(evsel))
-		return -1;
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
 	/*
 	 * Need to stop the forked record to ensure get sampled data from the
 	 * PIPE to process and get non-zero retire_lat value for hybrid.
 	 */
 	tpebs_stop();
-	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
 	t = tpebs_retire_lat__find(evsel);
-
-	/* Set ena and run to non-zero */
-	count->ena = count->run = 1;
-	count->lost = 0;
-
-	if (!t) {
-		/*
-		 * Set default value or 0 when retire_latency for this event is
-		 * not found from sampling data (record_tpebs not set or 0
-		 * sample recorded).
-		 */
-		count->val = 0;
-		return 0;
+	val = rint(t->val);
+
+	if (old_count) {
+		count->val = old_count->val + val;
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+	} else {
+		count->val = val;
+		count->run++;
+		count->ena++;
 	}
-
-	/*
-	 * Only set retire_latency value to the first CPU and thread.
-	 */
-	if (cpu_map_idx == 0 && thread == 0)
-		val = rint(t->val);
-	else
-		val = 0;
-
-	count->val = val;
 	return 0;
 }
 
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 6ff92f5de9b4..fa9e4b047e8d 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -12,7 +12,7 @@ struct evsel;
 extern bool tpebs_recording;
 int evsel__tpebs_open(struct evsel *evsel);
 void evsel__tpebs_close(struct evsel *evsel);
-int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
+int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
 #else
 
@@ -23,9 +23,9 @@ static inline int evsel__tpebs_open(struct evsel *evsel __maybe_unused)
 
 static inline void evsel__tpebs_close(struct evsel *evsed __maybe_unused) {};
 
-static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
-				int cpu_map_idx  __maybe_unused,
-				int thread  __maybe_unused)
+static inline int evsel__tpebs_read(struct evsel *evsel  __maybe_unused,
+				    int cpu_map_idx  __maybe_unused,
+				    int thread  __maybe_unused)
 {
 	return 0;
 }
-- 
2.49.0.395.g12beb8f557-goog


