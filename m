Return-Path: <linux-kernel+bounces-332975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813F97C1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADCA1C223FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63871CA6B9;
	Wed, 18 Sep 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irs3qReJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579751CB521
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696916; cv=none; b=g6RiWPJuk5DZIsss9Zqg0DlhPKH37EjlkyRbqjd6PB7P/v4NU9EwKt+f/O6EsPRRfg1TvMAPYKm3MSOy1YOqB8sUR/zF05t1uYLQuGROt/PLhonpSL+V7Og5iKpUjPzItcqWbaYO72X6eOs3Ff9BzSOglBF+2yObmHQ8TbaCQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696916; c=relaxed/simple;
	bh=KNZCg/KlHW2pgZahTxSnWyKwaWdBPj34Ow4kysaSe4U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i+b5DSWbPt7LoYtxnvtpw0l0MDWC8+Toyri2eONudmDb5jDe+pZalOo9eYz6LvpCmUvatjmNQpt2g2vLDgymTHTzZUy0LqtErtNZbwyDjs50mocv/KygwbsrJ1j0bADRB/nF+2xGmHNyqusEWhlPujE/EjVlemge949f1FOZihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irs3qReJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e201a37e5a4so486126276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726696913; x=1727301713; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpZWSRVuPXgrYeZb3Xyko33SKJqhRbiuBYTdMDSjW/c=;
        b=irs3qReJlakVJZqOFZn4bQ9adoM4/CwQo1J+ODdP3rB2ax61OlFX2RMcO/L8BlI7oL
         RhuL/M4Hj3R82DNM3kv0GbaRqV0YbjIXt38KgQARUwe1eRGrt2960MjI9bochITYzNjw
         51PBwwmpbXLPq9nPXNIIQGXWEA3y6QMQ38F4rhfl5gYC1OaGKs4nWMiwOope6ZKqloi0
         dFmMuC+cZjbiNOyfj19FQjSsGV3QL372+QXI0AwCaL+UCi6YBvhkQDWKGpNj7zGJFOjK
         anf7MZH6C8VK67d2OPMm9EG+Y0p7pxzoapoBtgayVbY85krZ2l0xscRon2irSBFx+pMx
         em0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726696913; x=1727301713;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpZWSRVuPXgrYeZb3Xyko33SKJqhRbiuBYTdMDSjW/c=;
        b=QsAPBI/a4KnBcApDlRtEA2N2L3j+1UE6Cot1E3G++D18jRQeYTnB/TxMahlanzSn/e
         bK7je5tXbpS+5TmPYCDQWgFcuPl6b8LiColXSTzq8j/lRZO0wBhn7eaOY2qhIbmAeO50
         KRAF4+Z0D1V5PSBg52fwE3iJ/YWlNj58x8CGT3JYTQoctc1Rth7nJlmSBfNyXnVnGnVd
         4S82qp0ITHrmquliTr4Y0EGdlcqxiKQdDIiiXUEqMbywukp2lKl6sagQ/J/9H+PR3BLO
         rXuKKrOQVB4np99WcT9KXG8uKRjcvl1AEwXnClUnUVo9spVF1qY9Yo4waeLotFwC8XCt
         GV7A==
X-Forwarded-Encrypted: i=1; AJvYcCXrxzPncldH8jNWGgJbgLXLXIDmh8wV+RYlyyhA0SIXwR95Gj4/EYH58HIBvFcV7Q5e29yi/O7aDnUu3G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QMm84OVIW2gJ3LAUygrHU7IESwkfqJ58Ufwgarfrdk1p3jz5
	5XEAu4lUUyq8AZnC6cYEeTRuUIfwwSFog4+fK0Hdxz+LLeYWURMy4NKIWuxHpowNv63Osk1/zFk
	TdfEwcw==
X-Google-Smtp-Source: AGHT+IGFByyzSTA635/zzy6jqvvjlAYTqDNhOlOJ0fPDLGWE+Yg314bw8BggsXdq+zi3PxvZwZaXMc8KK3os
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a25:ce46:0:b0:e1c:f1a4:8447 with SMTP id
 3f1490d57ef6-e1daff6d4c2mr23764276.4.1726696913317; Wed, 18 Sep 2024 15:01:53
 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:01:32 +0200
In-Reply-To: <20240918220133.102964-1-irogers@google.com>
Message-Id: <20240918220133.102964-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918220133.102964-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v3 2/3] perf parse-events: Set is_pmu_core for legacy hardware events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Also set the CPU map to all online CPU maps. This is done so the
behavior of legacy hardware and hardware cache events better matches
that of sysfs and json events during
__perf_evlist__propagate_maps. Fix missing cpumap put in "Synthesize
attr update" test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c |  1 +
 tools/perf/util/parse-events.c  | 37 ++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index d6b4ce3ef4ee..9301fde11366 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
+	perf_cpu_map__put(evsel->core.own_cpus);
 	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9a8be1e46d67..017d31d51ea4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -231,21 +231,30 @@ __add_event(struct list_head *list, int *idx,
 	    struct perf_cpu_map *cpu_list)
 {
 	struct evsel *evsel;
-	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
+	bool is_pmu_core;
+	struct perf_cpu_map *cpus;
 
-	cpus = perf_cpu_map__get(cpus);
-	if (pmu)
+	if (pmu) {
+		is_pmu_core = pmu->is_core;
+		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
 		perf_pmu__warn_invalid_formats(pmu);
-
-	if (pmu && (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX)) {
-		perf_pmu__warn_invalid_config(pmu, attr->config, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG, "config");
-		perf_pmu__warn_invalid_config(pmu, attr->config1, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
-		perf_pmu__warn_invalid_config(pmu, attr->config2, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
-		perf_pmu__warn_invalid_config(pmu, attr->config3, name,
-					      PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
+		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
+			perf_pmu__warn_invalid_config(pmu, attr->config, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG, "config");
+			perf_pmu__warn_invalid_config(pmu, attr->config1, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
+			perf_pmu__warn_invalid_config(pmu, attr->config2, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
+			perf_pmu__warn_invalid_config(pmu, attr->config3, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
+		}
+	} else {
+		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
+			       attr->type == PERF_TYPE_HW_CACHE);
+		if (perf_cpu_map__is_empty(cpu_list))
+			cpus = is_pmu_core ? perf_cpu_map__new_online_cpus() : NULL;
+		else
+			cpus = perf_cpu_map__get(cpu_list);
 	}
 	if (init_attr)
 		event_attr_init(attr);
@@ -260,7 +269,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
-	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
+	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
-- 
2.46.0.662.g92d0881bb0-goog


