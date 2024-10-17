Return-Path: <linux-kernel+bounces-370359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7059A2B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46741C26AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580C1DFE18;
	Thu, 17 Oct 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh/iWkIw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86641E04B8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187657; cv=none; b=haz7Zmy8QxKCoNDKxhR/YxfTMZq1G/xe0Dm9jJ/Qc0GTg/BSwQ+Xnnd/7f/YDGEAW/p83U2lmVbzAA817nHLOw/8UB0vWW08nh8bwww96Sx2r42WQ8NY0bDI2onUzb5HQeR7ALYUDD4JNfwawkckn7KVyDssKOv0R9P6q6ZDpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187657; c=relaxed/simple;
	bh=tWKJqnfBwSOmrMspZ2sdkDVmtmOQkJadh5Otwb2PTrM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iATtY5olF31GDjlpGCjBr81t2vSGvGh/YiKEFls8s/AEyzBV0j98Q0B5iRiz741VAVBq56skIc+2yRcLa4IsRG68H9pNXOupcXs5Quw7UQRzJLIT9YxcVfaPUoIrsiHOFUEXLJL7hmMsxj5lwYNGuj1x/Gze7HBoE8SwARTU31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh/iWkIw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so2397675276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187651; x=1729792451; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=lh/iWkIwsTys6DiiIOyHXtaFeDynTgub0bnsHrqqCCm2YL77fTWcX0qChsa481eJ2U
         Mdm6mv8R77gkzimulNOmt0b3RmxYQZVf/aPx3ag7ykvjxHk/DakcyrWA3XbHsAdacnhC
         u/UuTkoltwnjubpZkSQYW3dYNA8BSIwq29r4RJIkWW3GQkF5OARXDG0XKtrc80kL9YCd
         8mYFivJFGo0jDPikMvUp/2J0C3JyCyDFz8Lwj7puXSRbAgLBq+rMktMGpJ9XI6o78+U2
         agDT2Acsk247kcg6SLo9E8ie07fsrYKQnI/2qkFriUcreDLZM7c+StlG22GGjatX0b16
         V14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187651; x=1729792451;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=o9/bafXWmwnLYTK0lb8uh3OEAU7IbMU8bQ7QXrJrc4oFKB49vjyaEBP2f1puxseM60
         TbzuwKOOrHwcnhi8knsl9pNemQrOA6SE1ZDJxFXi8NkJ9bGB2CtmfJaB/r1cCC9Z14Yd
         Shc8SJKWK6wDf+BAjpUiZpfraSN/c8ANRyPOF2935neWPTRhtdSJ0jfQFtJz7nGCVnLT
         +xWFfA12Wu2Iv8h1JKjwNFoXzuSTdfNjeBevLfdzyyDIMwFfpyorKY4mwWZBxIGWEKzN
         9RsvXYFRFa5sH9z+aOaADQYfBM/vfGxb8gft9tPvECACQFTYB6dSa2ZRyt5uvtgZRpBk
         ZOMw==
X-Forwarded-Encrypted: i=1; AJvYcCW77/r4scwlwWWV4vd8chwwkWFC8VyqkOPy81kfv1KC2qxWPA/ZWNKGhtni+RxZyXLzyzmYaDOEed5rii4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXAzt/l9UUKttTo3Rf6/oH6RYyrSONIvJ2Wv+5nxMPaYUx/iw
	5ozuSR3s1Xs8JMPE0mIiIukZm3fvTHryXrDJY/FNMtu3DcmWWL+yOlhIPmWGBfjWqGRTXXYAXVL
	1TVe5jQ==
X-Google-Smtp-Source: AGHT+IF8ZgJiYZC6Y4MdQnp0pzNBftyhUw/O0yoGc816lrCGCTote0tRmMfBMHmL7XgCp8i4ttUMCJ5vA92g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a25:b204:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e2978594b05mr4017276.9.1729187650384; Thu, 17 Oct 2024 10:54:10
 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:53 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 4/7] perf stat: Drop metric-unit if unit is NULL
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


