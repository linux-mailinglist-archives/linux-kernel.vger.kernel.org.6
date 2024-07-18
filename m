Return-Path: <linux-kernel+bounces-255802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20544934562
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2834282F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C83B1B86DA;
	Thu, 18 Jul 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmQ6Q7kF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52000B66F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262647; cv=none; b=D+sXIUbng0mSHMuGAlANlbJTjc1Ay5MdcrOei52r4mdHxtD85Ib/809WgvESpDJ5OPBzno2PXH5pFvnNGwtlSkNbMJP99Sh0WPbRObdgfUvw8f/muQVz9HqBc/XdgdVxPY/5Dh0fU74izNv8Jnl0p6gZhsxEfG6jinN1jtBSEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262647; c=relaxed/simple;
	bh=vuwys3K/PQPhgggx+tj8r4FNVlkm6yntFgCi4rPb+vk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X8nZYiaH4Xxi87tx/69JtK+4zM2I4FUhpZVIz4k+PFJi7Ea3xf/nwK51ZSK6q6aDzBJaz206CRnYYQXdA1ZdGSdziKztnChF9w9SDP7VRydOh3p2F+a1Y2VgefnosqH0uLBfh4TrRZL5FzrhmKYrItzHNYTfLlXQeVgaWooFMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmQ6Q7kF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664fc7c4e51so4578097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262645; x=1721867445; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N65oyWVRY7b5fCUl5B9UBHpg82AXZoHzAgm4Amx1vhc=;
        b=SmQ6Q7kFybY3+Z1WUdWKVEgmtxoRg6dYVXerQD9MiIDKy5yycR9xaB6LYdR2XYKbZZ
         YQqz0qn1Bbja7YGEAIAKPMp2ZauPMQjL5OrS/BBn+RbOBi/5H1IzRq0BsIFzdnvRtAze
         2pWAsWbDxitOLKl5nsA482gNPtZGuM9QPgluslKOxtXZ74wIjgFG7MFpR1NORP60g+jV
         MdraloXqz8GhqP9EFov6RBTjRBqS+xHLyHQHs3y1plDbyktcIE1NLLrkLYAXahxkM2hI
         io/DTAr6aerNPqK6CRqQ3dmGylDllKSRVeGjWwYCvaXGucEyfd5OaTzsU2n9Dw6ICTVO
         m4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262645; x=1721867445;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N65oyWVRY7b5fCUl5B9UBHpg82AXZoHzAgm4Amx1vhc=;
        b=nVKtoyPdNfojjbbbhyIz3Ov9O4XNlowQyrGDxseMBVei9urX3gnvLgJ83ZhxzXnCjF
         Ov1qmKGyL+b304hOiPWJK38Yei/V17psSQLGR+MBM/TAKq6k2dP9QH+jAowSdaq9mPQd
         fx1Ha8sdjRrOQNnx5AJvKzf9QuwoWHoaNM1Z6GQkoLnM7Z1YNEyiA1t2Z82rTctLoWOp
         QImbWSMQVxCN1m17JaCYF72tJuczTpifnFuedMMZyY4JrtHfJ7nGOtpjb4Xlwhf7+Ja2
         dlGBXc1b8J8I29HZxR2zx8lzYF79uCv60Xpbl4hsuTGQeZh4nFItK0CQjOh+Ar/Syrzn
         swdg==
X-Forwarded-Encrypted: i=1; AJvYcCVraFT/zrk96ZqE5CLhkukodkPSjdhhQjXcuPIydfxU56HnmyG5ZAceZdDYxej/5DwB7SBo6eK/WxV58nAfPLk1qfn6VtZVh1UuVxNI
X-Gm-Message-State: AOJu0Yx+ULPOs7/OVfQoC7HneqWer58lf5UhJ+wRHo99yRFqGFccDtDW
	aO66TVYy8RLOk8HE38Py35DknsAFeCtDQDHvQKpdrNWIe6MXqiP+r4ZK7weAl2qPhBNWUnXBMHN
	hxpYytQ==
X-Google-Smtp-Source: AGHT+IHIMq5cuOtpe99i9/VfABCqMAYjXYL4ce0yS7sypzVC8xSF817NvE8VUA6yYx0BwM0GPvB3U/eqWK0+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:fce:b0:666:e184:4dfe with SMTP id
 00721157ae682-666e1845003mr78227b3.6.1721262645328; Wed, 17 Jul 2024 17:30:45
 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:21 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 2/6] perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
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


