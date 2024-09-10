Return-Path: <linux-kernel+bounces-323322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5965973B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681861F261CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D2199923;
	Tue, 10 Sep 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3RfgSuU"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139C188CC1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981505; cv=none; b=aUsExyfQTH3XCl0VXFuN5urMe/dxEQd2e1nPWPbxSp86iVAJNDB2R9etCcvIUR6CcoXcPzv4jcJTOnsQgt6EyWha0swcmco7Xgc4i7spvAEoEV5LErdnHsSQ/R8gBA2cqmQzYuVDXUt9qRM1ZfIyrv+M1nqT7dn5Uqwsbh1KiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981505; c=relaxed/simple;
	bh=uZORX5Z4Hom0H1Rz6xv3ETNi/JNd+24VDkWbazKW1ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HckPkHzAfma8dQUdMYobXFdPUCLYAVXzpIJ1dLOFoiYshQzJH4wdQhkIn3F4ZGAOgSfPHVIImD//rlDK7HdOwSIgNPuiYcJRIOYZn/BkaUKefnXpQ5xQospgeKpsgUByqQgK2CZvLPdEh5YXu7zGLZ8baW1Qzl1jnM21YPJgHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3RfgSuU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374bfc395a5so3405276f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981502; x=1726586302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8NhH4cLyJdMPKno/pyxaINagAni1zbV6XKosaHRnjk=;
        b=r3RfgSuUFqBZcp2Vr5MFD5o7iL+YtmTYbFRysIDLw8x2TMyMtcGGV9PgLSNzUiyYOr
         47jw6aGgiozCcApLwShYCCI0ouj1actD2bR0io1iEKgMQ3LV084y3xlh0iXZ1STEaraP
         qliIjX53vjkxRrqNjhnHMvD1+UFz0jOEs4AvoBqotqc1UMoMfIcbxQC5ik3ODLK2mRVH
         yeZjxPiL9RX1aaG9SWkAECjFMOJr36ZAdmkTPZ0tTAKcXu62/we5AMi+N/kF8GjKRaoZ
         p4Qk0rfp7VT2QrADJh2JK30jgyC2la+Sv02aFPf4b4r5PI6h9kvc9LcEHke/2BGwlhrl
         +HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981502; x=1726586302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8NhH4cLyJdMPKno/pyxaINagAni1zbV6XKosaHRnjk=;
        b=w3awizTygye/RDIODC+ESqTkQLkQYFHFz0/IibLwD8n0tFsymUegZV/UpRlghZIGdO
         2HAtQVffGfyDHB0+pgutdLjiV4/YC0bby1qX0yF01A2PtQCHe6f7vMGqRRZJPE8V4CDv
         Xa4LfDrK3HEBsXlKsS51u0Kt3xY4asTz0f20V/jLKDUXhGLyOQbx7SnzGZTTktQ+8ktC
         5fYvohiO06VT6lT4EYq9BkVnxkvwrKRg7la7dA+6Ln6USDHfavY8iLkFnrE/xY0xhuic
         FxEcATJwbVlbUCYegMoNQAQhJyeko3r+CZxRMAuH1OAvY38jVfL0VT181HP1j0tZqt6R
         O/rA==
X-Forwarded-Encrypted: i=1; AJvYcCVGVgQXp7eTVO0U9w3cPtZE87fzpNw4M17eXqpcWB8mPAV1jVBI3tLKkrIVvO/H5akz7WZIaLWRA6XFFPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPS0J78+2CHB25E2Kw6dWcSP4mubtwPslEbU6FTBZTAbSeFPt
	wwr+WcasextozL7E5gdw8sP1nDb1d9xbYM1g/v0CD7tw+PWRWYpobSjh3iz46c8=
X-Google-Smtp-Source: AGHT+IGVydiv3lO6lRO3jNqvMFWGGUzCe8fr2SCXgIVNrBURyV1JvQv+cbY7YgpL1u+7E3klqY/zlQ==
X-Received: by 2002:a5d:4cc5:0:b0:371:6fc7:d45d with SMTP id ffacd0b85a97d-378a89fd663mr1974341f8f.2.1725981502163;
        Tue, 10 Sep 2024 08:18:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:21 -0700 (PDT)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/7] perf evsel: Remove pmu_name
Date: Tue, 10 Sep 2024 16:16:23 +0100
Message-Id: <20240910151640.907359-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910151640.907359-1-james.clark@linaro.org>
References: <20240910151640.907359-1-james.clark@linaro.org>
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
index 1eaae8819c5e..fe8a817d2061 100644
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
index 639e65a9bf61..dbb80db63184 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -731,7 +731,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 
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
index 2928c1f76dad..082159fb2091 100644
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
index 430441fdfbbc..936aafb046b6 100644
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
index 69f6a46402c3..bbbb2e7eb8db 100644
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
index 3db402f2461a..cf3b37547221 100644
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
index 5548f751e56e..72275806e6e2 100644
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


