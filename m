Return-Path: <linux-kernel+bounces-370361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A319A2B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D93286714
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6981DFE31;
	Thu, 17 Oct 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FS99niwa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFF1E008D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187662; cv=none; b=CZ5mMms6BIJ+L2OH0UIy2UZOatxyUC8V0+rNdc8tlWSvOETHe+FVsHxqmg0kNwRU4Znk7O3tno/0rBeG+BN35MbUxmtjSAihHzOG0PrjQRdFQcLj1BgURrFtiovcmHywe2jN5sY7t4JiPEWVBLa4MNhOOcWjCO6DqJS1aMfuk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187662; c=relaxed/simple;
	bh=nR/8QLcBCh+39nvfzpZZaCLHNApxIUJpcbhdwvA+Oxk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AklfPx9/AfmUGbyCAikC0GuHnO45tyzlSzwieLuzmuHbq0vj8+6QSkM3XmxJpevG9s0sSV+ix00AuttcMpoTGV3F1CJ6LLAWQYxYH6DkoggiP+lX51GrBaUqRC+x62UI3sAIsCMBgVxT8ZpH5h93K/ApC1mkczSywRsyHOhTELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FS99niwa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2974759f5fso1443657276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187655; x=1729792455; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/n/isiF2Sq7ntpurAmJIm0kx07dBkasA8rH7Du+HlQ=;
        b=FS99niwa82SQSFyWaEOeE3xIN9+mVy6jXkTOgpfUmraIkOe897q9HcFPcFhpttcRqt
         7qAfuGd8IQCqoytpc0/j8EnpNhHrqbJyDOoyAhr3NJ2okjWTf4L47oWZIwtobnpZJ5CU
         J+nmdmro7nX9RtzjqZbt9vsL7PZagsC4OKG//gGSZ9ToTcl/lXl3dpRtjwV+3heIvimx
         JlQzugw4+OrHqBVRGahQrGOl9z+sUG1XbvAmh0QHJtoBdEjxD0VR2GhK4o4y4HWcFaDb
         W+j/pcl8YrldxkV7TlY4Obwhw9Sg77HtTUSK7bD9oP8m+X42xMAxlGlJAXHqfQe17DWx
         Jxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187655; x=1729792455;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/n/isiF2Sq7ntpurAmJIm0kx07dBkasA8rH7Du+HlQ=;
        b=hXULU+add89QvpKcwQAbNVNXtCkftlolpFAzxGnK7RhFoIIvebqmAYZInUdnRTssyH
         rNJL5ctK+23zICRzhu1hYkXSk4IrrrlIp1FAouOIBexq0X9S2Jg1VkH67xA657WCXnwq
         7a+Y24L+ZfWqC7tAqUQ3LvdQsKz77QVZgcDFLg+t4tno6lWBPdL42ARybKS91HPipVyP
         nuzFOu6+rtWFMkCAMNYKAXYo0Y7THlmoECgwzZrgaUHM+LLSgWmeAdwzJgkNfG9+3dSu
         h1KDAMUKD+AhhpxDn5lpjirwbcZBucPuOSL8vEUkp88IUagfkFyQLCCAq2S+iV9Qc+jL
         KpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVIUHma7X2C/YWWvIfI/zMio4I5YrFnVLmB4aUkIFRF/JdfnHnaMsJcOgZi4ZILXu7oDPY8XfUXCqs3z0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8AytjKcMCxcO8EoFtSdFlwUVe8ncWVtjnIBAtwK6Hr1ofKpA
	hmqF9UKwMmvSiPP495Gq742jmXRryhy53oi6xAFbue1+JrnHIkOFUocp21pltvo3gUUHWCxaF7Z
	nHO7h8A==
X-Google-Smtp-Source: AGHT+IFkq//YcMLCTfQVRn0x0a7UIOUag/SxD792fuWu3fhbg1GW7c20XG4ZYGJl76OK+axyzL3R3Opp2pnU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a25:aa0c:0:b0:e1c:ffab:a801 with SMTP id
 3f1490d57ef6-e2b9ce000a9mr7046276.2.1729187654825; Thu, 17 Oct 2024 10:54:14
 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:55 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 6/7] perf stat: Add metric-threshold to json output
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

When the threshold isn't unknown add a value to the json like:
"metric-threshold" : "good"

A more complete example:
```
$ perf stat -a -j -I 1000
{"interval" : 1.001089747, "counter-value" : "16045.281449", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 16045355135, "pcnt-running" : 100.00, "metric-value" : "16.045281", "metric-unit" : "CPUs utilized"}
{"interval" : 1.001089747, "counter-value" : "10003.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 16045314844, "pcnt-running" : 100.00, "metric-value" : "623.423156", "metric-unit" : "/sec"}
{"interval" : 1.001089747, "counter-value" : "328.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 16045321403, "pcnt-running" : 100.00, "metric-value" : "20.442147", "metric-unit" : "/sec"}
{"interval" : 1.001089747, "counter-value" : "20114.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 16045355927, "pcnt-running" : 100.00, "metric-value" : "1.253577", "metric-unit" : "K/sec"}
{"interval" : 1.001089747, "counter-value" : "4066679471.000000", "unit" : "", "event" : "instructions", "event-runtime" : 16045369123, "pcnt-running" : 100.00, "metric-value" : "1.628330", "metric-unit" : "insn per cycle"}
{"interval" : 1.001089747, "counter-value" : "2497454658.000000", "unit" : "", "event" : "cycles", "event-runtime" : 16045374810, "pcnt-running" : 100.00, "metric-value" : "0.155650", "metric-unit" : "GHz"}
{"interval" : 1.001089747, "counter-value" : "914974294.000000", "unit" : "", "event" : "branches", "event-runtime" : 16045379877, "pcnt-running" : 100.00, "metric-value" : "57.024509", "metric-unit" : "M/sec"}
{"interval" : 1.001089747, "counter-value" : "9237201.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 16045375017, "pcnt-running" : 100.00, "metric-value" : "1.009559", "metric-unit" : "of all branches", "metric-threshold" : "good"}
{"interval" : 1.001089747, "event-runtime" : 16045397172, "pcnt-running" : 100.00, "metricgroup" : "TopdownL1"}
{"interval" : 1.001089747, "metric-value" : "22.036686", "metric-unit" : "%  tma_backend_bound", "metric-threshold" : "bad"}
{"interval" : 1.001089747, "metric-value" : "7.610161", "metric-unit" : "%  tma_bad_speculation", "metric-threshold" : "good"}
{"interval" : 1.001089747, "metric-value" : "36.729687", "metric-unit" : "%  tma_frontend_bound", "metric-threshold" : "bad"}
{"interval" : 1.001089747, "metric-value" : "33.623465", "metric-unit" : "%  tma_retiring"}
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  5 ++++-
 tools/perf/util/stat-display.c                | 22 +++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index abc1fd737782..8ddb85586131 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -57,6 +57,7 @@ def check_json_output(expected_items):
       'interval': lambda x: isfloat(x),
       'metric-unit': lambda x: True,
       'metric-value': lambda x: isfloat(x),
+      'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
       'pcnt-running': lambda x: isfloat(x),
@@ -68,13 +69,15 @@ def check_json_output(expected_items):
   for item in json.loads(input):
     if expected_items != -1:
       count = len(item)
-      if count != expected_items and count >= 1 and count <= 6 and 'metric-value' in item:
+      if count != expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
         # Events that generate >1 metric may have isolated metric
         # values and possibly other prefixes like interval, core,
         # aggregate-number, or event-runtime/pcnt-running from multiplexing.
         pass
       elif count != expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
         pass
+      elif count == expected_items + 1 and 'metric-threshold' in item:
+          pass
       elif count != expected_items:
         raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                            f' in \'{item}\'')
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5974aaead95f..53dcdf07f5a2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -86,6 +86,19 @@ const char *metric_threshold_classify__color(enum metric_threshold_classify thre
 	return colors[thresh];
 }
 
+static const char *metric_threshold_classify__str(enum metric_threshold_classify thresh)
+{
+	const char * const strs[] = {
+		"unknown",
+		"bad",
+		"nearly bad",
+		"less good",
+		"good",
+	};
+	static_assert(ARRAY_SIZE(strs) - 1  == METRIC_THRESHOLD_GOOD, "missing enum value");
+	return strs[thresh];
+}
+
 static void print_running_std(struct perf_stat_config *config, u64 run, u64 ena)
 {
 	if (run != ena)
@@ -478,15 +491,20 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 
 static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     enum metric_threshold_classify thresh __maybe_unused,
+			     enum metric_threshold_classify thresh,
 			     const char *fmt __maybe_unused,
 			     const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	if (unit)
+	if (unit) {
 		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
+		if (thresh != METRIC_THRESHOLD_UNKNOWN) {
+			fprintf(out, ", \"metric-threshold\" : \"%s\"",
+				metric_threshold_classify__str(thresh));
+		}
+	}
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.105.g07ac214952-goog


