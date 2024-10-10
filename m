Return-Path: <linux-kernel+bounces-358037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F62C99797F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4140B1C21B66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD9EAC7;
	Thu, 10 Oct 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/iUFZVi"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007F28F1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518856; cv=none; b=qbWSSlphBRgFRvjuu/7VtrwMhknGTz1b/D8uR/hWGWSBGdeZmH3yY2QVY83bpcS63Z5XiJMpehNSVBw/qt9NObWCBW93WmZcrRHZvRqCVzWMLigg7C0Yow9c5wtq0+N/ZingP8sMd1LRaOPqrMC/j3mlxTgh9VQGUDZIeuW7Sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518856; c=relaxed/simple;
	bh=9mfIJcC0HJSEWZzG9Ykal5rxE97ZbtmZRtRyHou+jpQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=coq3KJmuN4mYbkc9kpxdtEqdHAOVgT6GjO5GrxyUHHRLQEsFN5mHfuO6tMzxsCwgXAVofPvp835bJexvQuat3+VxhB6PRo9i5/uYJUeaaFpBMuf/N4ep/Cp7pwY271UbzyZY55HSRis+EhQk/8hvq9CjEYLcMo64O6kRvelo6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/iUFZVi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e24b43799e9so363901276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518854; x=1729123654; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vk61ddLBPHHKenKN2gCI30GmxdQHp5UrYWcIorCWcs=;
        b=q/iUFZViaF7ScEsZHbttY910KmyE5MRY0pnVtmM0sVE9UHSbZGUACWOk1xdV9UfvDZ
         PQz/8cwfWQSUxe2+pULmQyodnIzl/Auz8pI1rxmHRsNjjtwOjqUKCIUeKvQBHMm28tHR
         eeKzolz53mMXWR2dG4bEG9CxMf6TbY27VuBtfEhxDVaitsuWpvIusBQTGLGUpwKpYdWp
         m/f8PzPVpUH3TlUsGrwg9ppLX1rGTrbLtkOy1a+3/0fiKTO4xpo+K0ZIWvWvD8/pMw1w
         nzJ5pntzTnwrefmnkbxumRwpA9Sc/aEy6Y6dTOG5k9eK1plk8I1da9bL2jPvAF4Sxk+I
         nTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518854; x=1729123654;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vk61ddLBPHHKenKN2gCI30GmxdQHp5UrYWcIorCWcs=;
        b=OIVL5CMRlMXWPm3oO97x8sn7Jyvornn3ztCA0/9LpcTP8wq+osuN5C2qRsQacXeQih
         VF8NvTwaA5ZCD0weKYpIjGzaX6ZsALnLItP7jra67Rt7H6DQ5l1ugdIr10euqH+W4npl
         GYWwdy6DMJkK/84b/HJaHFb3807+Yl9HzxjK9e99U2H5ux3EXu6DtyUQLxv2M8POut93
         FYw84ZbRx3Sknj/LJ2SbkuKEyS1xd/H6p/AMmyFNXRQRwE9EsejGThdJljqZnbhi8XUq
         DJ8iC9Cf4Itg0UVAjpgUSz4cwyes5SLtyEXVTkFfNPBEiwq9s/1b3Eqjh4wT0BMjrBmw
         AMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYIoFfYx13j6a7zIpnjSDyCQukYNuB//hyIxfoL+29tdiQavZ2m+/QNmauvHVwsjLTUZ6GAVX1lYQgGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK12aFq8noZvCAdxADHFNxrukiO5sc37Tkp1xXJsxBpcpeI5xc
	uxdqLAgdsOxH63xu0+Pu8vvCulpdjjWgmLRjHSOIhChynF3qp7vDmrsV94t9HacjgOkXkMci2F8
	bGyoHtQ==
X-Google-Smtp-Source: AGHT+IFohDycXvtDVabvurcURhYvAlfePzMY+eWC2icqpO339cPPAWQsac0qIvoYTf6d8DRH5WpGKWCz5t1Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:ce11:0:b0:e28:fb96:d0f4 with SMTP id
 3f1490d57ef6-e28fe33505emr27689276.2.1728518853790; Wed, 09 Oct 2024 17:07:33
 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:07:15 -0700
In-Reply-To: <20241010000719.1172854-1-irogers@google.com>
Message-Id: <20241010000719.1172854-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010000719.1172854-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 2/6] perf stat: Fix/add parameter names for print_metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The print_metric parameter names were rearranged, fix and add comments
in the stat-shadow callers to ensure they are correct.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 55 ++++++++++++++++++++---------------
 tools/perf/util/stat.h        |  6 ++--
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3ce756b8ede5..1e6ba6bf244a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -195,17 +195,21 @@ static void print_ratio(struct perf_stat_config *config,
 			const struct evsel *evsel, int aggr_idx,
 			double numerator, struct perf_stat_output_ctx *out,
 			enum stat_type denominator_type,
-			const double color_ratios[3], const char *unit)
+			const double color_ratios[3], const char *_unit)
 {
 	double denominator = find_stat(evsel, aggr_idx, denominator_type);
+	double ratio = 0;
+	const char *color = NULL;
+	const char *fmt = NULL;
+	const char *unit = NULL;
 
 	if (numerator && denominator) {
-		double ratio = numerator / denominator * 100.0;
-		const char *color = get_ratio_color(color_ratios, ratio);
-
-		out->print_metric(config, out->ctx, color, "%7.2f%%", unit, ratio);
-	} else
-		out->print_metric(config, out->ctx, NULL, NULL, unit, 0);
+		ratio = numerator / denominator * 100.0;
+		color = get_ratio_color(color_ratios, ratio);
+		fmt = "%7.2f%%";
+		unit = _unit;
+	}
+	out->print_metric(config, out->ctx, color, fmt, unit, ratio);
 }
 
 static void print_stalled_cycles_front(struct perf_stat_config *config,
@@ -319,14 +323,15 @@ static void print_instructions(struct perf_stat_config *config,
 				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
 
 	if (cycles) {
-		print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle",
-			instructions / cycles);
-	} else
-		print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
+		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "insn per cycle",
+			     instructions / cycles);
+	} else {
+		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "insn per cycle", 0);
+	}
 
 	if (max_stalled && instructions) {
 		out->new_line(config, ctxp);
-		print_metric(config, ctxp, NULL, "%7.2f ", "stalled cycles per insn",
+		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "stalled cycles per insn",
 			max_stalled / instructions);
 	}
 }
@@ -341,9 +346,10 @@ static void print_cycles(struct perf_stat_config *config,
 	if (cycles && nsecs) {
 		double ratio = cycles / nsecs;
 
-		out->print_metric(config, out->ctx, NULL, "%8.3f", "GHz", ratio);
-	} else
-		out->print_metric(config, out->ctx, NULL, NULL, "GHz", 0);
+		out->print_metric(config, out->ctx, /*color=*/NULL, "%8.3f", "GHz", ratio);
+	} else {
+		out->print_metric(config, out->ctx, /*color=*/NULL, /*fmt=*/NULL, "GHz", 0);
+	}
 }
 
 static void print_nsecs(struct perf_stat_config *config,
@@ -356,10 +362,11 @@ static void print_nsecs(struct perf_stat_config *config,
 	double wall_time = avg_stats(&walltime_nsecs_stats);
 
 	if (wall_time) {
-		print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
+		print_metric(config, ctxp, /*color=*/NULL, "%8.3f", "CPUs utilized",
 			nsecs / (wall_time * evsel->scale));
-	} else
-		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
+	} else {
+		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "CPUs utilized", 0);
+	}
 }
 
 static int prepare_metric(const struct metric_expr *mexp,
@@ -532,12 +539,12 @@ static void generic_metric(struct perf_stat_config *config,
 					ratio);
 			}
 		} else {
-			print_metric(config, ctxp, color, /*unit=*/NULL,
+			print_metric(config, ctxp, color, /*fmt=*/NULL,
 				     out->force_header ?
 				     (metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
-		print_metric(config, ctxp, color, /*unit=*/NULL,
+		print_metric(config, ctxp, color, /*fmt=*/NULL,
 			     out->force_header ?
 			     (metric_name ?: evsel->name) : "", 0);
 	}
@@ -708,9 +715,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 				if (unit != ' ')
 					snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-				print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
-			} else
+				print_metric(config, ctxp, /*color=*/NULL, "%8.3f",
+					     unit_buf, ratio);
+			} else {
 				num = 0;
+			}
 		}
 	}
 
@@ -718,7 +727,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 						  &num, NULL, out, metric_events);
 
 	if (num == 0)
-		print_metric(config, ctxp, NULL, NULL, NULL, 0);
+		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, /*unit=*/NULL, 0);
 }
 
 /**
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index fd7a187551bd..a5f3d7d00101 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -155,8 +155,10 @@ extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
 
 typedef void (*print_metric_t)(struct perf_stat_config *config,
-			       void *ctx, const char *color, const char *unit,
-			       const char *fmt, double val);
+			       void *ctx, const char *color,
+			       const char *fmt,
+			       const char *unit,
+			       double val);
 typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 
 /* Used to print the display name of the Default metricgroup for now. */
-- 
2.47.0.rc1.288.g06298d1525-goog


