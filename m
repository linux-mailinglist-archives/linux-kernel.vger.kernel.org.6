Return-Path: <linux-kernel+bounces-370358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D2D9A2B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C4A1F260EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B801E0B91;
	Thu, 17 Oct 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYCaWgqL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6411E0B86
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187655; cv=none; b=hdUKIZTrtX5PCHXjO+uyJqrwt8c2ddCelzUoN2YTmUrFWgTYf8y+D7TAOB+V6pIMBxbBzMpClmwWtYAFqE9gTukeBCSkweMdEM/MpMb7pGBz/P589mbORcGXlbxwRD6be1wCw0+0Q0uDnSYqa4NplDv/dkbrCi/+p85A6GEyBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187655; c=relaxed/simple;
	bh=RVW6wkDVKjRG51bYEhA4x0xQ+lNpEYTqs22+cLMthkA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qk8Hotc9oSgigXj0fePxXYHAOXoyewh/7SiiQu/GoiCd7MgbOVkh1gHMdMth9FGC7s+QWmr1nBlpvHTbBkzp24gO4S8KOHZ1xnvmd8YpiV/pSiKOM3KUKTTi4yYaSSoG8FkdL1JQPX99zjjq9//AbKWmQfvdexea0lEXL5JH9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYCaWgqL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so30809267b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187652; x=1729792452; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGfOVTovWxk2hP7JLrRDPs7H1ZDJlZRA8sfvnLLeCQY=;
        b=hYCaWgqLBNNgkxjhE3UaTwn/yLYo7u8yI/qKDITjTNiYTahc6tpSDtwNgLcLm4MO9H
         RaR4iPAnWfv7PWK8qYofJTIqkbenvsu6u84sPvDeQnVpBw1GhhGXAgX9NUJSExo4E7b/
         DFRtDcDwylAoc9oPovQ9/F5niySeY5TmKafsDo4pbCdMKbiz2m+RUnb7XKXKkGAU5VhD
         J6xpIYulr8SISFRiL5x9WSjX7TiWnGjhuGOmC3sdgRAByub/43R6dWe1ktfeUK4t8Fgh
         z9j7lOzismmBnQm1a9ibAXhopswqhAuWPfYtXF0f2Vp6fElhsRWGKWQIGGyQOK6Oqx7g
         PAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187652; x=1729792452;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGfOVTovWxk2hP7JLrRDPs7H1ZDJlZRA8sfvnLLeCQY=;
        b=fB6mXMa8nSwqN8e8HMH1zoy2fCYffgZ/TY4YzpbFEJYjBPRCuM8ZW5ZR3UxruM4U6l
         Sak3KF2cf/kOnv05IGi30Z8S3b6BgG7z11dp7FYKKvocPY6l7rBdcR5u0SQ+LZMdbCba
         2kVQIV03n7fstOSzA9Tr5L2g0xCtpXOQmebVyzR91CMuUOPmq7Mu56N5lYK6gvcPS6OO
         dQfG+f8OBT7yFi4O5lkEv+xAOT+csRU45EaTLhEfVqONzLMUE4WDyE5oMOp1LVr4iYkM
         636Z3lfb9/dqk/4Rwm9HWbLW+Rzoj7N+v782MCvSHxRqq/uRp0Wg2lz6tnz2/3SvqFfk
         OArQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3GITxdm2ihRy6hrRK5TJPpIiTj6V9v0mZ87LnNTPbwzEpvELKawIQwHDKBxFurCFUWAbICC+/71MCEsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrhy2Y6c2jNwSsXC1NTuhB1vo4+g/32yd7NqwgMNKogaNL49I8
	uOVYaYhdBKWXyx3kXru9hpU2dizOtbvxlm3c9dGLmeGGLIVg50nV5NEFSoO98qp+wTa6w4u7Ji2
	hg7H4kw==
X-Google-Smtp-Source: AGHT+IFoZMHDMn6AMV5fhVkttYOF6CVW6VkH2HB6bY2Y7c+Qq9+Ya9kmJR9Hjd6uiVVH8rNeDRyRgKUFqoba
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:9a92:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e3d41ca705mr1411897b3.5.1729187652710; Thu, 17 Oct 2024
 10:54:12 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:54 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 5/7] perf stat: Change color to threshold in print_metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Colors don't mean things in CSV and JSON output, switch to a threshold
enum value that the standard output can convert to a color. Updating
the CSV and JSON output will be later changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/iostat.c |   2 +-
 tools/perf/builtin-script.c       |   6 +-
 tools/perf/util/stat-display.c    |  40 ++++++++----
 tools/perf/util/stat-shadow.c     | 105 +++++++++++++++---------------
 tools/perf/util/stat.h            |  12 +++-
 5 files changed, 97 insertions(+), 68 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index df7b5dfcc26a..366b44d0bb7e 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -444,7 +444,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 		iostat_value = (count->val - prev_count_val) /
 			       ((double) count->run / count->ena);
 	}
-	out->print_metric(config, out->ctx, NULL, "%8.0f", iostat_metric,
+	out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.0f", iostat_metric,
 			  iostat_value / (256 * 1024));
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a644787fa9e1..8c5d5cecfba4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2136,11 +2136,11 @@ struct metric_ctx {
 };
 
 static void script_print_metric(struct perf_stat_config *config __maybe_unused,
-				void *ctx, const char *color,
-			        const char *fmt,
-			        const char *unit, double val)
+				void *ctx, enum metric_threshold_classify thresh,
+				const char *fmt, const char *unit, double val)
 {
 	struct metric_ctx *mctx = ctx;
+	const char *color = metric_threshold_classify__color(thresh);
 
 	if (!fmt)
 		return;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index c6d33010ed22..5974aaead95f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -73,6 +73,19 @@ static const char *aggr_header_std[] = {
 	[AGGR_GLOBAL] 	=	""
 };
 
+const char *metric_threshold_classify__color(enum metric_threshold_classify thresh)
+{
+	const char * const colors[] = {
+		"", /* unknown */
+		PERF_COLOR_RED,     /* bad */
+		PERF_COLOR_MAGENTA, /* nearly bad */
+		PERF_COLOR_YELLOW,  /* less good */
+		PERF_COLOR_GREEN,   /* good */
+	};
+	static_assert(ARRAY_SIZE(colors) - 1  == METRIC_THRESHOLD_GOOD, "missing enum value");
+	return colors[thresh];
+}
+
 static void print_running_std(struct perf_stat_config *config, u64 run, u64 ena)
 {
 	if (run != ena)
@@ -405,13 +418,14 @@ static void do_new_line_std(struct perf_stat_config *config,
 }
 
 static void print_metric_std(struct perf_stat_config *config,
-			     void *ctx, const char *color, const char *fmt,
-			     const char *unit, double val)
+			     void *ctx, enum metric_threshold_classify thresh,
+			     const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	int n;
 	bool newline = os->newline;
+	const char *color = metric_threshold_classify__color(thresh);
 
 	os->newline = false;
 
@@ -443,7 +457,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 
 static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     const char *color __maybe_unused,
+			     enum metric_threshold_classify thresh __maybe_unused,
 			     const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
@@ -464,7 +478,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 
 static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     const char *color __maybe_unused,
+			     enum metric_threshold_classify thresh __maybe_unused,
 			     const char *fmt __maybe_unused,
 			     const char *unit, double val)
 {
@@ -559,13 +573,14 @@ static const char *fixunit(char *buf, struct evsel *evsel,
 }
 
 static void print_metric_only(struct perf_stat_config *config,
-			      void *ctx, const char *color, const char *fmt,
-			      const char *unit, double val)
+			      void *ctx, enum metric_threshold_classify thresh,
+			      const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
 	unsigned mlen = config->metric_only_len;
+	const char *color = metric_threshold_classify__color(thresh);
 
 	if (!valid_only_metric(unit))
 		return;
@@ -582,7 +597,8 @@ static void print_metric_only(struct perf_stat_config *config,
 }
 
 static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused,
-				  void *ctx, const char *color __maybe_unused,
+				  void *ctx,
+				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -604,7 +620,8 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 }
 
 static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
-				  void *ctx, const char *color __maybe_unused,
+				  void *ctx,
+				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -636,7 +653,8 @@ static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 }
 
 static void print_metric_header(struct perf_stat_config *config,
-				void *ctx, const char *color __maybe_unused,
+				void *ctx,
+				enum metric_threshold_classify thresh __maybe_unused,
 				const char *fmt __maybe_unused,
 				const char *unit, double val __maybe_unused)
 {
@@ -810,7 +828,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
-			pm(config, os, NULL, "", "", 0);
+			pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);
 			return;
 		}
 
@@ -865,7 +883,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
 						      &out, &config->metric_events);
 	} else {
-		pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
+		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
 
 	if (!config->metric_only) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 512890d50b69..ada787947e16 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -137,18 +137,14 @@ static enum stat_type evsel__stat_type(struct evsel *evsel)
 	return STAT_NONE;
 }
 
-static const char *get_ratio_color(const double ratios[3], double val)
+static enum metric_threshold_classify get_ratio_thresh(const double ratios[3], double val)
 {
-	const char *color = PERF_COLOR_NORMAL;
+	assert(ratios[0] > ratios[1]);
+	assert(ratios[1] > ratios[2]);
 
-	if (val > ratios[0])
-		color = PERF_COLOR_RED;
-	else if (val > ratios[1])
-		color = PERF_COLOR_MAGENTA;
-	else if (val > ratios[2])
-		color = PERF_COLOR_YELLOW;
-
-	return color;
+	return val > ratios[1]
+		? (val > ratios[0] ? METRIC_THRESHOLD_BAD : METRIC_THRESHOLD_NEARLY_BAD)
+		: (val > ratios[2] ? METRIC_THRESHOLD_LESS_GOOD : METRIC_THRESHOLD_GOOD);
 }
 
 static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type type)
@@ -196,21 +192,21 @@ static void print_ratio(struct perf_stat_config *config,
 			const struct evsel *evsel, int aggr_idx,
 			double numerator, struct perf_stat_output_ctx *out,
 			enum stat_type denominator_type,
-			const double color_ratios[3], const char *_unit)
+			const double thresh_ratios[3], const char *_unit)
 {
 	double denominator = find_stat(evsel, aggr_idx, denominator_type);
 	double ratio = 0;
-	const char *color = NULL;
+	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
 	const char *fmt = NULL;
 	const char *unit = NULL;
 
 	if (numerator && denominator) {
 		ratio = numerator / denominator * 100.0;
-		color = get_ratio_color(color_ratios, ratio);
+		thresh = get_ratio_thresh(thresh_ratios, ratio);
 		fmt = "%7.2f%%";
 		unit = _unit;
 	}
-	out->print_metric(config, out->ctx, color, fmt, unit, ratio);
+	out->print_metric(config, out->ctx, thresh, fmt, unit, ratio);
 }
 
 static void print_stalled_cycles_front(struct perf_stat_config *config,
@@ -218,9 +214,9 @@ static void print_stalled_cycles_front(struct perf_stat_config *config,
 				int aggr_idx, double stalled,
 				struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {50.0, 30.0, 10.0};
+	const double thresh_ratios[3] = {50.0, 30.0, 10.0};
 
-	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, color_ratios,
+	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, thresh_ratios,
 		    "frontend cycles idle");
 }
 
@@ -229,9 +225,9 @@ static void print_stalled_cycles_back(struct perf_stat_config *config,
 				int aggr_idx, double stalled,
 				struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {75.0, 50.0, 20.0};
+	const double thresh_ratios[3] = {75.0, 50.0, 20.0};
 
-	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, color_ratios,
+	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, thresh_ratios,
 		    "backend cycles idle");
 }
 
@@ -240,9 +236,9 @@ static void print_branch_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_BRANCHES, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_BRANCHES, thresh_ratios,
 		    "of all branches");
 }
 
@@ -251,9 +247,9 @@ static void print_l1d_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_DCACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_DCACHE, thresh_ratios,
 		    "of all L1-dcache accesses");
 }
 
@@ -262,9 +258,9 @@ static void print_l1i_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_ICACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_ICACHE, thresh_ratios,
 		    "of all L1-icache accesses");
 }
 
@@ -273,9 +269,9 @@ static void print_ll_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, thresh_ratios,
 		    "of all LL-cache accesses");
 }
 
@@ -284,9 +280,9 @@ static void print_dtlb_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_DTLB_CACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_DTLB_CACHE, thresh_ratios,
 		    "of all dTLB cache accesses");
 }
 
@@ -295,9 +291,9 @@ static void print_itlb_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_ITLB_CACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_ITLB_CACHE, thresh_ratios,
 		    "of all iTLB cache accesses");
 }
 
@@ -306,9 +302,9 @@ static void print_cache_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_CACHE_REFS, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_CACHE_REFS, thresh_ratios,
 		    "of all cache refs");
 }
 
@@ -324,16 +320,16 @@ static void print_instructions(struct perf_stat_config *config,
 				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
 
 	if (cycles) {
-		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "insn per cycle",
-			     instructions / cycles);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
+			     "insn per cycle", instructions / cycles);
 	} else {
-		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "insn per cycle", 0);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
+			     "insn per cycle", 0);
 	}
-
 	if (max_stalled && instructions) {
 		out->new_line(config, ctxp);
-		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "stalled cycles per insn",
-			max_stalled / instructions);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
+			     "stalled cycles per insn", max_stalled / instructions);
 	}
 }
 
@@ -347,9 +343,11 @@ static void print_cycles(struct perf_stat_config *config,
 	if (cycles && nsecs) {
 		double ratio = cycles / nsecs;
 
-		out->print_metric(config, out->ctx, /*color=*/NULL, "%8.3f", "GHz", ratio);
+		out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.3f",
+				  "GHz", ratio);
 	} else {
-		out->print_metric(config, out->ctx, /*color=*/NULL, /*fmt=*/NULL, "GHz", 0);
+		out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
+				  "GHz", 0);
 	}
 }
 
@@ -363,10 +361,11 @@ static void print_nsecs(struct perf_stat_config *config,
 	double wall_time = avg_stats(&walltime_nsecs_stats);
 
 	if (wall_time) {
-		print_metric(config, ctxp, /*color=*/NULL, "%8.3f", "CPUs utilized",
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%8.3f", "CPUs utilized",
 			nsecs / (wall_time * evsel->scale));
 	} else {
-		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "CPUs utilized", 0);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
+			     "CPUs utilized", 0);
 	}
 }
 
@@ -500,7 +499,7 @@ static void generic_metric(struct perf_stat_config *config,
 	double ratio, scale, threshold;
 	int i;
 	void *ctxp = out->ctx;
-	const char *color = NULL;
+	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
 
 	pctx = expr__ctx_new();
 	if (!pctx)
@@ -523,8 +522,8 @@ static void generic_metric(struct perf_stat_config *config,
 			if (metric_threshold &&
 			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
 			    !isnan(threshold)) {
-				color = fpclassify(threshold) == FP_ZERO
-					? PERF_COLOR_GREEN : PERF_COLOR_RED;
+				thresh = fpclassify(threshold) == FP_ZERO
+					? METRIC_THRESHOLD_GOOD : METRIC_THRESHOLD_BAD;
 			}
 
 			if (metric_unit && metric_name) {
@@ -539,22 +538,22 @@ static void generic_metric(struct perf_stat_config *config,
 					scnprintf(metric_bf, sizeof(metric_bf),
 					  "%s  %s", unit, metric_name);
 
-				print_metric(config, ctxp, color, "%8.1f",
+				print_metric(config, ctxp, thresh, "%8.1f",
 					     metric_bf, ratio);
 			} else {
-				print_metric(config, ctxp, color, "%8.2f",
+				print_metric(config, ctxp, thresh, "%8.2f",
 					metric_name ?
 					metric_name :
 					out->force_header ?  evsel->name : "",
 					ratio);
 			}
 		} else {
-			print_metric(config, ctxp, color, /*fmt=*/NULL,
+			print_metric(config, ctxp, thresh, /*fmt=*/NULL,
 				     out->force_header ?
 				     (metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
-		print_metric(config, ctxp, color, /*fmt=*/NULL,
+		print_metric(config, ctxp, thresh, /*fmt=*/NULL,
 			     out->force_header ?
 			     (metric_name ?: evsel->name) : "", 0);
 	}
@@ -725,7 +724,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 				if (unit != ' ')
 					snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-				print_metric(config, ctxp, /*color=*/NULL, "%8.3f",
+				print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%8.3f",
 					     unit_buf, ratio);
 			} else {
 				num = 0;
@@ -736,8 +735,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
 						  &num, NULL, out, metric_events);
 
-	if (num == 0)
-		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, /*unit=*/NULL, 0);
+	if (num == 0) {
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN,
+			     /*fmt=*/NULL, /*unit=*/NULL, 0);
+	}
 }
 
 /**
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index a5f3d7d00101..6f8cff3cd39a 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -154,8 +154,18 @@ struct evlist;
 extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
 
+enum metric_threshold_classify {
+	METRIC_THRESHOLD_UNKNOWN,
+	METRIC_THRESHOLD_BAD,
+	METRIC_THRESHOLD_NEARLY_BAD,
+	METRIC_THRESHOLD_LESS_GOOD,
+	METRIC_THRESHOLD_GOOD,
+};
+const char *metric_threshold_classify__color(enum metric_threshold_classify thresh);
+
 typedef void (*print_metric_t)(struct perf_stat_config *config,
-			       void *ctx, const char *color,
+			       void *ctx,
+			       enum metric_threshold_classify thresh,
 			       const char *fmt,
 			       const char *unit,
 			       double val);
-- 
2.47.0.105.g07ac214952-goog


