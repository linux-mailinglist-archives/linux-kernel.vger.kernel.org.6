Return-Path: <linux-kernel+bounces-339213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32A98616A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FAD1F29C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCA3192D7B;
	Wed, 25 Sep 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD/IzgF1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FC13D891
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273709; cv=none; b=VPHpC0QjmcpBduFphpQJL50uu0H4kl58D4pAjwEuD7tBTyb780zMWi5VRAfdbB/GZ854ZxPzFKthzV5h38Rd1OrPudXdw/3D4fBqXw9TIPwb92wtbAzcmTdmycR7D1CdcWBOA/cxrHoXZafhIHV05sZA+r5OwZpq315eKrMXUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273709; c=relaxed/simple;
	bh=T59FtaBY86PMiCH7EJYlnBRTlljfRvPixXiEQ8KdFI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKtaZJj6kp3AMdcAY+WiziSvHuD+IAiYHye0XQ/pN7KgIm++VR+3/jvb7LUvPTht7X0hP61sqbtcjp8yFSq+7iMkYSdDjwdDcZbYDrcENFlniTCg87WL46UbiRxVEYMHC5i8vjvGrfYValMaZofabXpBsJ9/wSBhLTdx40RlwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rD/IzgF1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso5552500a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273704; x=1727878504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeDBv7d+GfXWdLno5voRxsTBQAHukEhaW6k0Tlbpnk4=;
        b=rD/IzgF1yOYdH2Oz38BXGDrCEF5CXY7IYRoBkTAArn+OEFg+HZYGTAuM7z1a8soN9x
         HRNsIzWUtBiwqe9p5flDHYv2I28KODUtCBT9KLpLKA1btjIJnW+wi4GYb0Gz2pX64QLi
         +XIR25ASZqFElfIBiIKhyPNQ6n0frcM6R3pnc16gPXJIUzLS/WXOlAf7bLAs6PTh1pWz
         1O5SetU6HZn1KbEfaJAcDZvr1gNlvWwKMR3mSb6byw1GycR9j1xPfz87HMQwuZDPyMAk
         dPBPCcYmeh4MCqE/2OMg0Zv3Ofcw79d+YeHg+ELW19XC90d55OciWCWQ9P+E4+IKeNcb
         9hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273704; x=1727878504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeDBv7d+GfXWdLno5voRxsTBQAHukEhaW6k0Tlbpnk4=;
        b=cdxJ0yTsuYDylq5rs3Bbb2g+7yCaDVvE6uj3bEF5spcByWpT6Vsoue2B7dgQlQeLE7
         RQeF0m7Hwamp2M6mRBaDitb42nOyOWQGYl3ZP1/Jo3+clA3xQ+j1YDoTC3nk0dEfJPEy
         AwywxbMy2Ad3+f0T1zaJqNBG5COaRgmKKxmMNqZlXMQrEdxhPZwKN1lOZX29TxrBLuML
         aL5kBPgDddBw+qb8ulb7LQvpgjTuICWLUQ/IC5sCdUtD2CHRzzK4HBv0rHclsUwrl6Gd
         UkL3r6kh5fmQWaAK7y8f48chfEd3NV7HVL264TTdcVN0pyjV/O9I6b++BUWcCjwsGPaH
         6n4w==
X-Forwarded-Encrypted: i=1; AJvYcCWKyzlR9fHPoO9VQp4osq/6JtG/qmhdJ/xNj+llVH5YsywsXFTmCSaZPvyETdltJ91vyN7+nNNBnZdQP3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qc4l86cNaZI+fteQcrOPL+CMcz91qLS9ab0fzJ1T58OZlFDw
	WB3MPFeQzE7yu6qsrRBqIAatHWBGJ0klM7VBuLS+LdE+Wx8eU16vq8V6EaTj1og=
X-Google-Smtp-Source: AGHT+IG+kNq9JFbU1r8bFPMKWyKooOzrU7ZQ3SiGTB3gD9ZEamJXliCswZokEg11kC48EeEy5BDuCg==
X-Received: by 2002:a05:6402:2115:b0:5c7:227f:3735 with SMTP id 4fb4d7f45d1cf-5c7227f382amr1443652a12.34.1727273703879;
        Wed, 25 Sep 2024 07:15:03 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:15:03 -0700 (PDT)
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
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/7] perf evsel: Add alternate_hw_config and use in evsel__match
Date: Wed, 25 Sep 2024 15:13:39 +0100
Message-Id: <20240925141357.1033087-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925141357.1033087-1-james.clark@linaro.org>
References: <20240925141357.1033087-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

There are cases where we want to match events like instructions and
cycles with legacy hardware values, in particular in stat-shadow's
hard coded metrics. An evsel's name isn't a good point of reference as
it gets altered, strstr would be too imprecise and re-parsing the
event from its name is silly. Instead, hold the legacy hardware event
name, determined during parsing, in the evsel for this matching case.

Inline evsel__match2 that is only used in builtin-diff.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-diff.c      |  6 ++--
 tools/perf/util/evsel.c        | 21 ++++++++++++
 tools/perf/util/evsel.h        | 19 ++---------
 tools/perf/util/parse-events.c | 59 +++++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  8 ++++-
 tools/perf/util/parse-events.y |  2 +-
 tools/perf/util/pmu.c          |  6 +++-
 tools/perf/util/pmu.h          |  2 +-
 8 files changed, 77 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 23326dd20333..82fb7773e03e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -469,13 +469,13 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 
 static struct perf_diff pdiff;
 
-static struct evsel *evsel_match(struct evsel *evsel,
-				      struct evlist *evlist)
+static struct evsel *evsel_match(struct evsel *evsel, struct evlist *evlist)
 {
 	struct evsel *e;
 
 	evlist__for_each_entry(evlist, e) {
-		if (evsel__match2(evsel, e))
+		if ((evsel->core.attr.type == e->core.attr.type) &&
+		    (evsel->core.attr.config == e->core.attr.config))
 			return e;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5..00178643b198 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -299,6 +299,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
+	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -445,6 +446,8 @@ struct evsel *evsel__clone(struct evsel *orig)
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
 
+	evsel->alternate_hw_config = orig->alternate_hw_config;
+
 	return evsel;
 
 out_err:
@@ -1845,6 +1848,24 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 	return 0;
 }
 
+bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
+{
+
+	u32 e_type = evsel->core.attr.type;
+	u64 e_config = evsel->core.attr.config;
+
+	if (e_type != type) {
+		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+			evsel->alternate_hw_config == config;
+	}
+
+	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
+	    perf_pmus__supports_extended_type())
+		e_config &= PERF_HW_EVENT_MASK;
+
+	return e_config == config;
+}
+
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	if (evsel__is_tool(evsel))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15e745a9a798..cf6f11fdfd06 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -102,6 +102,7 @@ struct evsel {
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
+		u64			alternate_hw_config;
 	};
 
 	/*
@@ -393,26 +394,10 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
 
-static inline bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
-{
-	if (evsel->core.attr.type != type)
-		return false;
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)  &&
-	    perf_pmus__supports_extended_type())
-		return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == config;
-
-	return evsel->core.attr.config == config;
-}
+bool __evsel__match(const struct evsel *evsel, u32 type, u64 config);
 
 #define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t, PERF_COUNT_##c)
 
-static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
-{
-	return (e1->core.attr.type == e2->core.attr.type) &&
-	       (e1->core.attr.config == e2->core.attr.config);
-}
-
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread);
 
 int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool scale);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9a8be1e46d67..fcc4dab618be 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -228,7 +228,7 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
-	    struct perf_cpu_map *cpu_list)
+	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
@@ -264,6 +264,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
+	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -286,16 +287,19 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 {
 	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
 			   metric_id, pmu, /*config_terms=*/NULL,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL);
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
 static int add_event(struct list_head *list, int *idx,
 		     struct perf_event_attr *attr, const char *name,
-		     const char *metric_id, struct list_head *config_terms)
+		     const char *metric_id, struct list_head *config_terms,
+		     u64 alternate_hw_config)
 {
 	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
 			   /*pmu=*/NULL, config_terms,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   alternate_hw_config) ? 0 : -ENOMEM;
 }
 
 static int add_event_tool(struct list_head *list, int *idx,
@@ -315,7 +319,8 @@ static int add_event_tool(struct list_head *list, int *idx,
 	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
-			    cpu_list);
+			    cpu_list,
+			    /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 	perf_cpu_map__put(cpu_list);
 	if (!evsel)
 		return -ENOMEM;
@@ -450,7 +455,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats);
+				bool auto_merge_stats, u64 alternate_hw_config);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -476,7 +481,8 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 */
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
-						   perf_pmu__auto_merge_stats(pmu));
+						   perf_pmu__auto_merge_stats(pmu),
+						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
 				return ret;
 			continue;
@@ -507,7 +513,8 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
 				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-				/*cpu_list=*/NULL) == NULL)
+				/*cpu_list=*/NULL,
+				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
 			return -ENOMEM;
 
 		free_config_terms(&config_terms);
@@ -772,7 +779,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 
 	return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
-			 &config_terms);
+			&config_terms, /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
 static int check_type_val(struct parse_events_term *term,
@@ -1072,6 +1079,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		if (perf_pmu__have_event(pmu, term->config)) {
 			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
 			term->no_value = true;
+			term->alternate_hw_config = true;
 		} else {
 			attr->type = PERF_TYPE_HARDWARE;
 			attr->config = term->val.num;
@@ -1384,8 +1392,9 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
+			  metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			  /*cpu_list=*/NULL, /*alternate_hw_config=*/PERF_COUNT_HW_MAX
+		) == NULL ? -ENOMEM : 0;
 	free_config_terms(&config_terms);
 	return ret;
 }
@@ -1443,7 +1452,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats)
+				bool auto_merge_stats, u64 alternate_hw_config)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1480,7 +1489,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
-				    /*cpu_list=*/NULL);
+				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
 	}
 
@@ -1501,7 +1510,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Look for event names in the terms and rewrite into format based terms. */
 	if (perf_pmu__check_alias(pmu, &parsed_terms,
-				  &info, &alias_rewrote_terms, err)) {
+				  &info, &alias_rewrote_terms,
+				  &alternate_hw_config, err)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1546,7 +1556,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
+			    alternate_hw_config);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
@@ -1567,7 +1578,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name,
+			       const char *event_name, u64 hw_config,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc_)
 {
@@ -1620,7 +1631,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 		if (!parse_events_add_pmu(parse_state, list, pmu,
-					  &parsed_terms, auto_merge_stats)) {
+					  &parsed_terms, auto_merge_stats, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1633,7 +1644,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, perf_pmus__fake_pmu(), &parsed_terms,
-					  /*auto_merge_stats=*/true)) {
+					  /*auto_merge_stats=*/true, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1674,13 +1685,15 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
 	pmu = perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
-					/*auto_merge_stats=*/false))
+					 /*auto_merge_stats=*/false,
+					 /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
 		return 0;
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, *listp, perf_pmus__fake_pmu(),
 					  const_parsed_terms,
-					  /*auto_merge_stats=*/false))
+					  /*auto_merge_stats=*/false,
+					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
 			return 0;
 	}
 
@@ -1693,7 +1706,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
 						  const_parsed_terms,
-						  auto_merge_stats)) {
+						  auto_merge_stats,
+						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
@@ -1704,7 +1718,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	/* Failure to add, assume event_or_pmu is an event name. */
 	zfree(listp);
-	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, const_parsed_terms, listp, loc))
+	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, PERF_COUNT_HW_MAX,
+					const_parsed_terms, listp, loc))
 		return 0;
 
 	if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", event_or_pmu) < 0)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 10cc9c433116..2b52f8d6aa29 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -127,6 +127,12 @@ struct parse_events_term {
 	 * value is assumed to be 1. An event name also has no value.
 	 */
 	bool no_value;
+	/**
+	 * @alternate_hw_config: config is the event name but num is an
+	 * alternate PERF_TYPE_HARDWARE config value which is often nice for the
+	 * sake of quick matching.
+	 */
+	bool alternate_hw_config;
 };
 
 struct parse_events_error {
@@ -238,7 +244,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name,
+			       const char *event_name, u64 hw_config,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b3c51f06cbdc..dcf47fabdfdd 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -292,7 +292,7 @@ PE_NAME sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list, &@1);
+	err = parse_events_multi_pmu_add(_parse_state, $1, PERF_COUNT_HW_MAX, NULL, &list, &@1);
 	if (err < 0) {
 		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61bdda01a05a..e32d601b48f1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1606,7 +1606,7 @@ static int check_info_data(struct perf_pmu *pmu,
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  struct parse_events_error *err)
+			  u64 *alternate_hw_config, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1638,6 +1638,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 						NULL);
 			return ret;
 		}
+
 		*rewrote_terms = true;
 		ret = check_info_data(pmu, alias, info, err, term->err_term);
 		if (ret)
@@ -1646,6 +1647,9 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
+		if (term->alternate_hw_config)
+			*alternate_hw_config = term->val.num;
+
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 4397c48ad569..f4271395c374 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -215,7 +215,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  struct parse_events_error *err);
+			  u64 *alternate_hw_config, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
-- 
2.34.1


