Return-Path: <linux-kernel+bounces-340621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D619875F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6918D1C2468C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1214AD0E;
	Thu, 26 Sep 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlJZsGCf"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742F14884F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362222; cv=none; b=ikB5Lbi/9luj9hpLZZCzuHKOtt0p5HrTniKzYgiKZYKHNt5Qdxq4dId6wpL1NvKXmQztwOm8r7d1bF2K0o/ZstRty0fNygmIcoKSpmcZE81H4hlU2pqc61fz+toZQp9u9gc8VIORkgYd94XRP/E2ZUeXVzWj4d/P076F5BbpDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362222; c=relaxed/simple;
	bh=zsbhin7qH/+OegtlGnCEJ8ZsxunfFeElrKWcIpdrONs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7BGLtsCSWpFsQVpzjoWSmparCuZCjdaX6vFddYxLCwXU1tlTSAmzDTeBCzN6OH9PIPKUcM2MeA6TK+7miMgdqLvDI6cYIbtKKy/e7+2Udndf/G22h7ylQD9pepx4Yxhgq7giJB/CweeMrG+8XP8bDZHuotnKn6cLg055zgaq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PlJZsGCf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53659867cbdso1780053e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362218; x=1727967018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp213y54GN91pnOwFQAxUfYd+2v8V8CzcBUreVn10hc=;
        b=PlJZsGCf7gpsGS5qWAAcuXqIxfT5pXLyR5g5I/mObG0mNc4G/Sgw/xU1Iiwc4A6Ord
         EAd5VBDkDKdDnrB/YdH6fPgq/93HPnKtw3BioniubmSlmTvliYyCgOjHtuvnhzVpTRGw
         adnPvEaTT5s9dn4IP7j3LP3eMIGrtSmuI43Twx6cwPIpQiXiQEo0Fs5Lyl2q2JpCIgX0
         rjAptLs78fNQAw6MQxfa+Q6M5i34OTRvIgU2kiJkY5vio57V+WJ75W55aZTJw++40EdL
         wpJEMn5KXYKdZqYKwQeQvB+Y5ZeLo7BA9+PStGnYwLVP5QnOXw88TVtdDh+rfI5TiF2U
         eUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362218; x=1727967018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp213y54GN91pnOwFQAxUfYd+2v8V8CzcBUreVn10hc=;
        b=RWm3pAx9zkIayCEtkSqyk7UKjThZf6GvRcNY1sxjJ2bM+LqgQICOlmInUsGZyNOw/t
         SylRdCWajxgOjYmIV4hlKfi0iRDDaZlZXcaDwIxcmVxHo3O7qR7rnYqChLKx0dMJVqnE
         C4B+siaKp1zvW8svRNK6V7co3w1HRovIP1mJ8XSlwc9wGJfT3kUD1dof8A4x6liPqmaq
         d0ceR0W1lZeDNoKOQktwrjikfvyEi+urNm0Tdv3THC5XVQZcqzqheTPckgUiKwwUpKEL
         HfZUblSRVM7zcy10QjtuLKqezol3bwnke2PWbxTXZIC8FSAgZLYrILn+OhPwudvVs2Ev
         q6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUVzrajzLXNz+8L2XZKaCbfbGM8CgVlbLDYnCelTCkWVwoowNbIQXbXNS280CcbhC4t4huCoJBkLIxrxJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vwcirVbFGSuXqISm0jIwqA+GsfFJqsS9I40sIYyn6m3M/eKK
	MRv7lrFMLrZpjj8WJLVZI8aUfAaniRaYqwq1V6XuITIkPGwYIEMQR/S+bCwadus=
X-Google-Smtp-Source: AGHT+IG+DAUJo2pn2BJB0TGl+/A9x8WGEWnV2tuFf/gEyli81cL41CJgfK4r+z5lVCT/xKvYFOGJRQ==
X-Received: by 2002:a05:6512:ace:b0:52c:76ac:329b with SMTP id 2adb3069b0e04-53877538b62mr6848029e87.35.1727362217510;
        Thu, 26 Sep 2024 07:50:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:50:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/7] perf evsel: Remove pmu_name
Date: Thu, 26 Sep 2024 15:48:36 +0100
Message-Id: <20240926144851.245903-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926144851.245903-1-james.clark@linaro.org>
References: <20240926144851.245903-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

"evsel->pmu_name" is only ever assigned a strdup of "pmu->name", a
strdup of "evsel->pmu_name" or NULL. As such, prefer to use
"pmu->name" directly and even to directly compare PMUs than PMU
names. For safety, add some additional NULL tests.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
[ Fix arm-spe.c usage of pmu_name and empty PMU name ]
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c |  4 ++--
 tools/perf/arch/x86/util/evsel.c     |  4 ++--
 tools/perf/tests/parse-events.c      |  2 +-
 tools/perf/util/evlist.c             |  3 ++-
 tools/perf/util/evsel.c              |  7 -------
 tools/perf/util/evsel.h              |  3 +--
 tools/perf/util/metricgroup.c        |  4 ++--
 tools/perf/util/parse-events.c       |  1 -
 tools/perf/util/stat-shadow.c        | 10 +++++-----
 tools/perf/util/stat.c               |  2 +-
 10 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 2be99fdf997d..59a85e6f3aa3 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -188,9 +188,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu_name, ARM_SPE_PMU_NAME)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
 				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu_name);
+				       evsel->pmu->name);
 				return -EINVAL;
 			}
 			opts->full_auxtrace = true;
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ec2ac3bbb76f..cf7c116eeb8e 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -84,7 +84,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 		return  scnprintf(bf, size, "%s", event_name);
 
 	return scnprintf(bf, size, "%s/%s/",
-			 evsel->pmu_name ? evsel->pmu_name : "cpu",
+			 evsel->pmu ? evsel->pmu->name : "cpu",
 			 event_name);
 }
 
@@ -129,7 +129,7 @@ int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
 		return 0;
 
 	if (!evsel->core.attr.precise_ip &&
-	    !(evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3)))
+	    !(evsel->pmu && !strncmp(evsel->pmu->name, "ibs", 3)))
 		return 0;
 
 	/* More verbose IBS errors. */
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9e3086d02150..78e999f03d2d 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -730,7 +730,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
-				      strcmp(evsel->pmu_name, "cpu"));
+				      strcmp(evsel->pmu->name, "cpu"));
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel",
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index bace277fa77d..4835d5aa5c48 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2576,7 +2576,8 @@ void evlist__uniquify_name(struct evlist *evlist)
 		else
 			attributes = empty_attributes;
 
-		if (asprintf(&new_name, "%s/%s/%s", pos->pmu_name, pos->name, attributes + 1)) {
+		if (asprintf(&new_name, "%s/%s/%s", pos->pmu ? pos->pmu->name : "",
+			     pos->name, attributes + 1)) {
 			free(pos->name);
 			pos->name = new_name;
 		} else {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 00178643b198..56f3c2183437 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -296,7 +296,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->metric_events = NULL;
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
-	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
@@ -394,11 +393,6 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->group_name == NULL)
 			goto out_err;
 	}
-	if (orig->pmu_name) {
-		evsel->pmu_name = strdup(orig->pmu_name);
-		if (evsel->pmu_name == NULL)
-			goto out_err;
-	}
 	if (orig->group_pmu_name) {
 		evsel->group_pmu_name = strdup(orig->group_pmu_name);
 		if (evsel->group_pmu_name == NULL)
@@ -1497,7 +1491,6 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->filter);
-	zfree(&evsel->pmu_name);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cf6f11fdfd06..3e751ea769ac 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -72,7 +72,6 @@ struct evsel {
 	struct {
 		char			*name;
 		char			*group_name;
-		const char		*pmu_name;
 		const char		*group_pmu_name;
 #ifdef HAVE_LIBTRACEEVENT
 		struct tep_event	*tp_format;
@@ -184,7 +183,7 @@ struct evsel {
 	unsigned long		open_flags;
 	int			precise_ip_original;
 
-	/* for missing_features */
+	/* The PMU the event is from. Used for missing_features, PMU name, etc. */
 	struct perf_pmu		*pmu;
 
 	/* For tool events */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4dff3e925a47..9c6fa6b4f628 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -297,8 +297,8 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		struct expr_id_data *val_ptr;
 
 		/* Don't match events for the wrong hybrid PMU. */
-		if (!all_pmus && ev->pmu_name && evsel__is_hybrid(ev) &&
-		    strcmp(ev->pmu_name, pmu))
+		if (!all_pmus && ev->pmu && evsel__is_hybrid(ev) &&
+		    strcmp(ev->pmu->name, pmu))
 			continue;
 		/*
 		 * Check for duplicate events with the same name. For
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fcc4dab618be..e96cf13dc396 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -263,7 +263,6 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
-	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
 	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index dd709a731574..3ce756b8ede5 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -573,7 +573,7 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 {
 	bool need_full_name = perf_pmus__num_core_pmus() > 1;
 	static const char *last_name;
-	static const char *last_pmu;
+	static const struct perf_pmu *last_pmu;
 	char full_name[64];
 
 	/*
@@ -584,21 +584,21 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 	 * different metric events.
 	 */
 	if (last_name && !strcmp(last_name, name)) {
-		if (!need_full_name || !strcmp(last_pmu, evsel->pmu_name)) {
+		if (!need_full_name || last_pmu != evsel->pmu) {
 			out->print_metricgroup_header(config, ctxp, NULL);
 			return;
 		}
 	}
 
-	if (need_full_name)
-		scnprintf(full_name, sizeof(full_name), "%s (%s)", name, evsel->pmu_name);
+	if (need_full_name && evsel->pmu)
+		scnprintf(full_name, sizeof(full_name), "%s (%s)", name, evsel->pmu->name);
 	else
 		scnprintf(full_name, sizeof(full_name), "%s", name);
 
 	out->print_metricgroup_header(config, ctxp, full_name);
 
 	last_name = name;
-	last_pmu = evsel->pmu_name;
+	last_pmu = evsel->pmu;
 }
 
 /**
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0bd5467389e4..7c2ccdcc3fdb 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -553,7 +553,7 @@ static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
 	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
 		return false;
 
-	return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
+	return evsel_a->pmu != evsel_b->pmu;
 }
 
 static void evsel__merge_aliases(struct evsel *evsel)
-- 
2.34.1


