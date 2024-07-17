Return-Path: <linux-kernel+bounces-255770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0219344E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D42E283BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1416BFA5;
	Wed, 17 Jul 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0UJet6E"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267D558BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256462; cv=none; b=HedmYuqJVy6VAQLbMBM6moAlpequOnYQ+c1cmXB7Rd0BjYalWNyNqYWl624YuyTTmRfQcKn0AKd0hd21Jat8lHhLJdRtH6SmFcgoc6J9lG60ScLH1Le38uY9rlM+JtMlhmVDSIreTWHqVsXPMGvkBAkGSPg7s0Bl7N6EgLPhwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256462; c=relaxed/simple;
	bh=vuwys3K/PQPhgggx+tj8r4FNVlkm6yntFgCi4rPb+vk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ro9Mvxl47oXZYv4+1qAd2aT4U3cyKCGspcQ2xjVJtUIosr5teurRInABJ7KI51BbwlZrGqGtMtvQnhl22/t4P8/c8ZZA+HRXnx+IIc/BA+9SFOeL0ko1tYpwBpEqGojNFeGipCyP8BEUwvjHeht+EkLHae4hkVXGMsrzWxBiTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0UJet6E; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a694ba5aso453810276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256460; x=1721861260; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N65oyWVRY7b5fCUl5B9UBHpg82AXZoHzAgm4Amx1vhc=;
        b=g0UJet6EXiUanAGVhXL6Qzhu/5nJ0foWBDyBjEfycXzC0+NB2uYLG43uFVngQiQM0G
         LP2Nw9MWTRH3YwchG+731TGu3Mlk/7wYWazOfrScL5QaT2aVmZ6c1b0IxoZ+CF0842qa
         ScV+ohueBSaGANjONDCYnzi9dCegpG5T/s3TzrLgjOf9sXwCzxpLkRRfvUgjqpKJ4GMN
         nJJuDTgyTZ2NkOh03D/LTx0H3vDJLRbXc98TnUDQBKR7j1W8fSdYFShXVLgKeynTuZ6B
         wrgwQQ31Cylc4ZtPWaUxR+ZSDPj7rJWR8h5TtDUy2w+jsJls+zVOe0l94JOSkWBHmvJz
         TPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256460; x=1721861260;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N65oyWVRY7b5fCUl5B9UBHpg82AXZoHzAgm4Amx1vhc=;
        b=F+uPyPstn7PqgvWTaz3+yAMSiRSDd1yJuRFWUvtQxVnIg16Ww322xlS3T+WIbqBOjd
         8wIAQnLw1QWBnTXGnn3P4zv2ZfomCgEiPitxcWLW7ZICn+1q2kRhoJL5+JsERR3J+PeK
         M89CGpDkXQmjMV2M9KIZxhLRV6WTViivhGcILHYAeYUo9X8Op6wO1K03cHOAPkVq0bVV
         D0C86GR9vvKYrxC4uOJJvXCrFVfTrsYJecwSVFTweilyUTKaVIo3rIEhMjF3zSQMn1+m
         HJTdlnejMg2WXkzr+xjY6hJ7qTkRLRtlHuzNBi31MS7xVMWS6mXEhO5TBgzirxxO0X1o
         HyrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0BA1KUxuBqSVM0auiv2biiA7aNO/6Bfv02fIq0/s306CLQFkJKTPGR1wPLjC2lVu+K8X3paFpoyjQLFVUxYlLlokdvXuhpLwNhNdi
X-Gm-Message-State: AOJu0Yw8iKiG2h+Air030NwqPzWDLcI0FOSInd/JZLF0Cm1iStUhIGW/
	FdvZ6UZXrDhGL2Fno2bkoQicuUgmyK9TXti2Npg97WpieyeXn7BMYZELTDQbVNIj7nxmtvDgkqg
	+/NT9oA==
X-Google-Smtp-Source: AGHT+IH9IZ2oWD57Fb/Y14t3IyFK8/OeCj7X6XeVHQP0ivJbYeNiSH3bPsPnwXLrXgMVdYiwKNmfMxPGD8al
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1024:b0:e02:c84e:61a3 with SMTP
 id 3f1490d57ef6-e05feb31053mr1385276.6.1721256460154; Wed, 17 Jul 2024
 15:47:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:28 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 2/6] perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

Previously the cpu_list is a string and typically no cpu_list is
passed to __add_event. Wanting to make events have their cpus distinct
from the PMU means that in more occassions we want to pass a
cpu_list. If we're reading this from sysfs it is easier to read a
perf_cpu_map than allocate and pass around strings that will later be
parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 321586fb5556..43501eb56336 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -227,12 +227,12 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
-	    const char *cpu_list)
+	    struct perf_cpu_map *cpu_list)
 {
 	struct evsel *evsel;
-	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
-			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
+	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
 
+	cpus = perf_cpu_map__get(cpus);
 	if (pmu)
 		perf_pmu__warn_invalid_formats(pmu);
 
@@ -305,16 +305,17 @@ static int add_event_tool(struct list_head *list, int *idx,
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 	};
-	const char *cpu_list = NULL;
+	struct perf_cpu_map *cpu_list = NULL;
 
 	if (tool_event == PERF_TOOL_DURATION_TIME) {
 		/* Duration time is gathered globally, pretend it is only on CPU0. */
-		cpu_list = "0";
+		cpu_list = perf_cpu_map__new("0");
 	}
 	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
 			    cpu_list);
+	perf_cpu_map__put(cpu_list);
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
-- 
2.45.2.1089.g2a221341d9-goog


