Return-Path: <linux-kernel+bounces-368535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC49A1101
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8630F1C24CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C882144CC;
	Wed, 16 Oct 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSFuQ3zv"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601B2144AC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101245; cv=none; b=egNhuK83WUpmAOLf1tBsNnbX6/NlKFzVZaE1xi5ZOeveUVXYHon3d/2/zSDGn/LBH31sQUZcq5bLEOg8nJl7osICvdyc97ojXKMFsRyzyrGlrATUmtgRNKWxJK9B+tvcgdF9am3IZTMzmNsmJ794cVjsNADPauErYDomDsCnq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101245; c=relaxed/simple;
	bh=tWKJqnfBwSOmrMspZ2sdkDVmtmOQkJadh5Otwb2PTrM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FbDLRgGfYBeqaOrmsOEz6eiZST9O2JNKndFb8y4krh8GKfvDD4FbJ3KOYismmU2kriM1HiLQiqbav51E5EwWOgSC5+NHQ264NoE1tn2ddtBywGBRv3W3S5VsruB2I/wz3IcPOXqY0iePUzfrV80ngaYkPGzZaZtdKSV7Miu/vDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSFuQ3zv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3204db795so2229207b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101243; x=1729706043; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=nSFuQ3zv66b3+ICwOEnquoFChnbGinRg9mzWc9uWveUrqxeAG08VyQFH+EOjj8KESa
         ZBvJQg4TvwynzA882n69dDe3cR3v7shN4Jf+baKR2t9F9mvLXKNj2BRejIyJeTF4NuwX
         qOarH0H2rBEoohjfNdjswKypw0N5Y1hWcVlQINlKNxZ1qEjZ/Zd8Vsv9CR55vCzs1Pdg
         7ei7TP+9jwyOvF++8Eo+zju2MVsHvQogNxaJbIIRfWwpivSkB15pI/z+CSdJfcJDbGiX
         J1E0KM2vdvPUsGjW9yqYDivz3YraLeFfBmy3RZRdgdOeO4WKyOyTS8+tdBRLxWZ1FR8L
         eUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101243; x=1729706043;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=TEHLANbNT3+SCfkWaHlFDXurU2uiofoLxzLOfSJhZZd/Sj3h+L4D5WNIAkRWCBSJM4
         kZe7lPnYjfRDcgFXpFjRrsmHPOe1IYIY2DoI7IdqOFJK7Npu8XnBIFex2X9YLd2uNv83
         eN4vC7OXt5ll/xUuYNPdkZq7ISTm3ZMO5JLUsEM5iKyJxMo2XtmHhQ/q7ZllHGmtgDfH
         7pLd1kXmjFvmgrdvNVkYFmqO7q+ZuTH9/deFIqf+6IG3nQuaj5yBwYoQO62IO86QMp5/
         SghD+VDdY3z+ZwYvfVVltQyEMQ+dMwIXrq7WWM5If6hFgdJjpy2OS9/OagGVv7Vch902
         e3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUHAvN8baSALXGl+SRCJ1vqoPE0t3So6UIvfpGkZDg4RTkrjugXF+AvTLjdBqvCEQUyS+Va1tWtAaeWuJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFcmt4jdgpwhzKQWq1DB6yS4DVgjKtoc6v+4Zuvbgnwja4Pl6J
	F8qMWb+lCGWNWK8b4rtPbEr9LufbiWiK/3Zvmg+TOeAfNIIOn72un36rAHfAIxNbsmkX/oU4NlO
	VwSzuWw==
X-Google-Smtp-Source: AGHT+IHCPG9L9oWbfk5tOWCZkv2tp2sF7rrGkdVUIb+ubd1ZsfFeQQS6KOfWmd9ApJSK1xc5jRsIrFnSeVvf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:dc10:0:b0:e2a:e7e2:60cf with SMTP id
 3f1490d57ef6-e2ae7e2629bmr1152276.10.1729101243038; Wed, 16 Oct 2024 10:54:03
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:46 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 4/8] perf stat: Drop metric-unit if unit is NULL
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

Avoid cases like:
```
$ perf stat -a -M topdownl1 -j -I 1000
...
{"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
...
```

If there is no unit then drop the metric-value too as:
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a137b377efa4..c6d33010ed22 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -471,8 +471,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (unit)
+		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.105.g07ac214952-goog


