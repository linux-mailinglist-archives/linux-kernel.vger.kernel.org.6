Return-Path: <linux-kernel+bounces-368538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564219A1104
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F3E1C256DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9460216A15;
	Wed, 16 Oct 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IfefOmx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E6215F75
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101252; cv=none; b=PP9Mk8gzFXyvFfLsGhrFERCNBKCH7/JkOQqnD5srNGJf0Of1+l3fcJELRE9ZsoX39SHk1OlEXXI6cDRSMYDSnkVIvQGyDf/17Zc4YbSg5FjdadXEr/F6Ar02kXwoDAoXlZUVbYXamXW4160rUuWX17y89KxqzoDTUcWVTCMtep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101252; c=relaxed/simple;
	bh=WKjU1a/lx3TbexW2NN4+1n8Opn4CO4/epvYjmMZ59go=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=APQy4M6VBasZ8o344ajor6mOW9HjfL8GByc3bOi6Jvev5BLMKaSjofQtRi2geSVK69lh8fZtzzH+xSi+jzk0iuq9m2sAHPcds0pJapP4XhSzUnBnQtKCFsYC7whG6nOgo/R/vHZFAoqC7a5EFMqAbb+qeVR643ia0C75sqUC+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IfefOmx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so77291276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101250; x=1729706050; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h17ekCegbTr4famvRlkpL0Qc+dXqqCi6gDChEA388fo=;
        b=1IfefOmx6STIPQ30UFtpuXO8G8zA09MlE/t33IswOJS/XJkTnlw1te982NNx0wNLOt
         wM6+O5c8hakTSpPxZdMNKfy9iGyAoRHE5j7Po99ItHectUoYljiJxQfkCipQ4gPzcfCD
         +vtkvtfCmxqLfB0k9MRah8ca7gB2hTOqVLc2dI85ZMHEGlCIBicQ79rccNeYIrFRyPSN
         JizReRdDlIS3/K82cSTLJ4ctv5CtFn0ILxQE9nSCctHKxESjqxm19mUy4F31/nqGema5
         yErwqZ4hrNmyxanF84tFXO/w0CeCaD9MD1q64RYDUnAq8iJHYFQ9Pr5xIuyWDA1i672X
         Nczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101250; x=1729706050;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h17ekCegbTr4famvRlkpL0Qc+dXqqCi6gDChEA388fo=;
        b=FTYtIxxvdZmE5l/CRUH179CEwlsuIiii4VR4DR4HGqW0AjNwYA3qvZu1PiPRj5zUcp
         2fnUgbTLnYerN2zxBRZt9S4PTtiw7Q0uF5iNIu3zG5qeV/8wQKcWCqD+06vCBrGyPJT5
         e6QL4kPHuDumw3vOLq8kSx7DNnZVjqWLRnm0HI+f9lBVDjczce1QjPSFr3kC1TfsDmTd
         e4jJYzYfXvmqDVuRNt2TReuCz3MjsbenSaovTzaySRpAIWU8A1WI60eSDOd+eghLzaTT
         HnllJKZE0RY8MKAVSmFENABMZzxVYElTHu/OcgXLVS8f3Loz+Q49KCrc5rfP8weWwf4W
         T7xA==
X-Forwarded-Encrypted: i=1; AJvYcCXZMNjJoDWBCKB78nuhgsrkdJhqjNP2ek8n9ORudJ2H9ze8brFsSN0VjLjj1+vg6ze9tFMY5nHpROXwLkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5YvEPpGR1wcZW4zdhxzfN4vave6ZofFLzjeHJXxrnliAR7gr
	ttPzghzIt1FOGwEsLLvtTwzoQmxIIX6wVCjWtyxpZzcsDZ1QevDfP+4ej0xDZdiWl25qTtdCHUa
	D5FgzKA==
X-Google-Smtp-Source: AGHT+IGbtXQuViQyESTsQNdCvj0QvKmS2njrdxDrBpkQZ2WTjfdpex+ZxXZpJMCWC9ztNlNC03yf8ZAvNR1Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:b227:0:b0:e28:ee55:c3d with SMTP id
 3f1490d57ef6-e29782b0251mr3864276.1.1729101249705; Wed, 16 Oct 2024 10:54:09
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:49 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 7/8] perf stat: Add metric-threshold to json output
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
 tools/perf/util/stat-display.c                      | 9 +++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

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
index f2750d1b34aa..5b700b259572 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -497,15 +497,20 @@ static void print_metric_csv(struct perf_stat_config *config,
 
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


