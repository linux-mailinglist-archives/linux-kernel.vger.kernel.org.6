Return-Path: <linux-kernel+bounces-351577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8399133C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228332850F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B101B4F39;
	Fri,  4 Oct 2024 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgUQP1I6"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDB1AAE12
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085303; cv=none; b=qWGyAA9KY4odTzCvvPR9NxvyS4Ffi0jK+/HJs64AY5BW4nfzzFeWi4XgeEPHlMirmdBeSjxfufoYNavt5LfErkNW307MEIO0JxujikpCZgwpd+WiHKpntEI+czYUFYYTcBy7SYgMXzoROCLJ5hOkoWUA9aDAmMjLcCA8pvwrj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085303; c=relaxed/simple;
	bh=zyem4zsBz6hP9z2Df4l7Ur/puwpyMUn8774w+lYc8C4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QbaEJ7vNwqk6M4ezJQqmSV3uxV8pftYpE/FOZ8hZ6WTZXb7kBqvf4lOxp7ryV8KvcTsQY+RVJeQAugEyWVMZCP6ChAnekF4075nF24akzBYcVxPNf/uyX/jZmEEUaBrHdExzRxN2keZlZpAYLL4P0DXPzPgWl1B/mFhYbHg2s1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgUQP1I6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso4078885276.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085300; x=1728690100; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpgTzV/OIl7XVMupREkrhGZ4QI9t8yNiTS28L2B3qXg=;
        b=sgUQP1I664MAxnVFjQ8aHQciIH9578pA1lQSIMnoF6/xMrhprRuk2UzlevfcgH4zR1
         zaeXa6hE9A/3Il8mEtti1+12mphJFVJW3ciIMidUI1qurh9p4F6/7vLtPVZN711ilJVs
         jXdRwXUeh6ayThH7fiViZjycJxBNsz7ETHnJrdtHjI+OoO7JbHzxlnUsdz8VI6a2gSXF
         /oU+hnUzlues4hVIcAeawcPa7OQiUySDQXNdH32LVj2Y7NXgnSEwAN/uP3hr/l9STFum
         8TS8LjRiy9WZ9CgfPRdrC198fTNBm6DVlGnOvz8cmDC3tpSm+KStZWFQs/IEufWkElLY
         meBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085300; x=1728690100;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpgTzV/OIl7XVMupREkrhGZ4QI9t8yNiTS28L2B3qXg=;
        b=oqqNB27c4d2scTLTdUS2kShyzxprou4q1XLSmDEXO5kdl/KQQyW6rgR65nFGKQ2PYg
         z5RZg69XAl6dZ5J7meyvn4LGZ5sPEmhEan8U4oJcFM4aM0NFwu++jzKUkGYZopZ7TpWp
         RqgeABHNK2Rw4NzapY8hC8QqYVMDWMKPNQtJRiSRmSy3g++bdhm8Vmyl84e7YPge4eGq
         bbtRnb3nFBfic8OmVpVVohcNGOIj+OX7fuXlKSwAw6i3Lsixg1WX0oQHfOV2C8eHIKzy
         NqJtlIdHRzQeBWKDcUiTlmrIBtDHBXNNs3fRAEsSji0/TIaaj7sYsnXiEKXj3zUvUbxK
         HLRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsgPiQw6WIZebxZcwSvcMTp1qaJJddg1+cIfGsKSn3ifAvY3xzvfKV8jfnwsq14uX3uytt8uz8rgDFetU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQIrAQmWHE7rYJAGmH7t0ibELJwNoIhYuu3cBZaB4HaWahGGU
	zD5OJYRwva/Uo4HoEwkQ2dU5FxrH11EUg6cIr/j/sT3skY1SMW2P3SG3DwN55HkYupv8+7JAdJ3
	CUkxAbQ==
X-Google-Smtp-Source: AGHT+IEkxqe6hc8Mhd+9jCgeyt5gzoKBHKTkvCZ4fqNrqsrjKfHSSRa/LYFnHpibk62DVvEx9cChl/EmA60l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:7488:0:b0:e16:51f9:59da with SMTP id
 3f1490d57ef6-e289391f800mr7051276.6.1728085300022; Fri, 04 Oct 2024 16:41:40
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:19 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 7/8] perf stat: Add metric-threshold to json output
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
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 5 ++++-
 tools/perf/util/stat-display.c                      | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

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
index c8f3f5a30542..b897dc3c54d3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -496,7 +496,7 @@ static void print_metric_csv(struct perf_stat_config *config,
 
 static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     enum metric_threshold_classify thresh __maybe_unused,
+			     enum metric_threshold_classify thresh,
 			     const char *fmt __maybe_unused,
 			     const char *unit, double val)
 {
@@ -506,6 +506,10 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	fprintf(out, "\"metric-value\" : \"%f\"", val);
 	if (unit)
 		fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
+	if (thresh != METRIC_THRESHOLD_UNKNOWN) {
+		fprintf(out, ", \"metric-threshold\" : \"%s\"",
+			metric_threshold_classify__str(thresh));
+	}
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


