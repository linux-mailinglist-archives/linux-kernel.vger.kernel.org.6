Return-Path: <linux-kernel+bounces-201815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF48FC3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE181C22104
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A5019048E;
	Wed,  5 Jun 2024 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PM22uf+S"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E1190475
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569518; cv=none; b=mV/sbs8w/z7DwSWukP9TwtSjSI58uKRyp4JjrcAKmvBpG64Iq++1JI2OZTNmbfmW5ESoS7JMvR16FJAjkic/D0JKe4fYxVLbb/XhWsPkOt5GC8wwNQaA+LgzRCDdWZnpjFwQNAN1rFulqmyO2rjdtwEpyW7AdCnQISauvRcl57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569518; c=relaxed/simple;
	bh=GRplOvv5S/KNq5Tzm9MM8arcebemWz8WZBDUgbNA0wI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aiHE2303D5SrO7IQSgYArMU2Mt1kNA22FUGgh4Hv41ErM/tJutksetd0QZdD+p6yN5Hl4048KuIjgt7677e1IlS5xMdgZcX82gd1EgYZU5kT5PGa2PRMSxg8pmc+8tYSFCq8cn3CF5304/Nop6Z2OTXhvfOQjv9EnZG7y6SiWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PM22uf+S; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e7f0ca54so123570337b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717569516; x=1718174316; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vij4NhRQx/LvxvouIE9cJQ7E8po5AZLz12BoHiTozdE=;
        b=PM22uf+SJlVWzikc+xQT3W4mONkuHAhHe/d5omhCiS0k9dL3/xDXRhizWyM4ixl1Qw
         UCI3H0Ie4F9bZ0D23P47mlSFe0kGlXTOMBR9DwPnTtboWvQwVeF1eGZgsDlJmXck6iQc
         beBOuM/z0qdQpcXbJErkaM0SAAPq6ee/y1DUL9hcP1o4R9VHNPmHdMzvj5twi6J7z2qO
         ExcoUpPPmll93RhvFtI7iRy59hU8B6cSLFyN10jQ8XLf0VMR01hfHMvn1cH+94a2ewxF
         x32NtdxPNkm+PrLSAQpz2TXSkztuTV0CvQXvUt/Uqm0P39Mnzmx3wC9ZUGXHHNisMqkV
         H0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717569516; x=1718174316;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vij4NhRQx/LvxvouIE9cJQ7E8po5AZLz12BoHiTozdE=;
        b=YfPeLa1e5fkD0DrdDqT34rL3GuiqB2HsrUWH2QKNUhXk5tWxhNby8KRb4/XkH5B6Kf
         bJQHOvs7bVfBK2o+NFu9yvCACGUjHXQXHtPxSKqK1yZtkHTLQB4hraaXq2GfHEQACLNb
         dM+j1DXZBebsk1E4/qknwCPWxQD+MMFQ5OUNCycaKMVqLF4pQenkBVXlC5Q25D7VxrvR
         ObhC6N9S11FDSghqBUw5nrNJZ2n4JVpGzQKMM5WSnTO5DTwAty29slmURZ8RNc6oHneU
         HL9fHq/7TRL+STB8oZf63RyZo8PtbYkFszlPHt9b56CaD6J41x0zZsg/Vmg47883rSb5
         oQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXU0Rnis7Fcmn3ZxgQbN6bRSFl+agMMypG2QWi+vn0txjDDX33XCN8TUGV2WemIHh6j1l2Cdy7csBDniactoXLh0CvJq+OPtAnKYCk1
X-Gm-Message-State: AOJu0Yzpo3t8BCNJKRznZwOqibPqfktNGabcPs+EBvOHdAab4pRKfV+v
	9YsP5fUA2OfSFRaV4f2jEt6/jBxH1U3Zlax2u0gYgHHDzw05qJWap1kzHDHBxalQcomSnhOrHwQ
	PLojveA==
X-Google-Smtp-Source: AGHT+IE1ityN4iJs90OZc/3/HOLy8Flj0VbFWz2Ebh3qTkJLwxdmHOo1uo9Wq7vddcUON4kMXGhdz/HNnWkV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:42c2:ffc7:ca9b:501f])
 (user=irogers job=sendgmr) by 2002:a05:690c:385:b0:622:cd7d:febf with SMTP id
 00721157ae682-62cbb592417mr4720357b3.6.1717569516061; Tue, 04 Jun 2024
 23:38:36 -0700 (PDT)
Date: Tue,  4 Jun 2024 23:38:28 -0700
In-Reply-To: <20240605063828.195700-1-irogers@google.com>
Message-Id: <20240605063828.195700-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605063828.195700-1-irogers@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [RFC PATCH v1 2/2] perf stat: Choose the most disaggregate command
 line option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

When multiple aggregation options are passed to perf stat the behavior
isn't clear. Consider "perf stat -A --per-socket .." and "perf stat
--per-socket -A ..", the first won't aggregate at all while the second
will do per-socket aggregation, even though the same options were
passed.

Rather than set an enum value, gather the options in a struct and
process them from most to least aggregate. This ensures the least
aggregate option always applies, so no aggregation if "-A" is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 73 ++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6227b25d1446..603a9684153d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,6 +164,35 @@ static struct perf_stat_config stat_config = {
 	.iostat_run		= false,
 };
 
+/* Options set from the command line. */
+struct opt_aggr_mode {
+	bool node, socket, die, cluster, cache, core, thread, no_aggr;
+};
+
+/* Turn command line option into most generic aggregation mode setting. */
+static enum aggr_mode opt_aggr_mode_to_aggr_mode(struct opt_aggr_mode *opt_mode)
+{
+	enum aggr_mode mode = AGGR_GLOBAL;
+
+	if (opt_mode->node)
+		mode = AGGR_NODE;
+	if (opt_mode->socket)
+		mode = AGGR_SOCKET;
+	if (opt_mode->die)
+		mode = AGGR_DIE;
+	if (opt_mode->cluster)
+		mode = AGGR_CLUSTER;
+	if (opt_mode->cache)
+		mode = AGGR_CACHE;
+	if (opt_mode->core)
+		mode = AGGR_CORE;
+	if (opt_mode->thread)
+		mode = AGGR_THREAD;
+	if (opt_mode->no_aggr)
+		mode = AGGR_NONE;
+	return mode;
+}
+
 static void evlist__check_cpu_maps(struct evlist *evlist)
 {
 	struct evsel *evsel, *warned_leader = NULL;
@@ -1096,7 +1125,7 @@ static int parse_cache_level(const struct option *opt,
 			     int unset __maybe_unused)
 {
 	int level;
-	u32 *aggr_mode = (u32 *)opt->value;
+	struct opt_aggr_mode *opt_aggr_mode = (struct opt_aggr_mode *)opt->value;
 	u32 *aggr_level = (u32 *)opt->data;
 
 	/*
@@ -1135,7 +1164,7 @@ static int parse_cache_level(const struct option *opt,
 		return -EINVAL;
 	}
 out:
-	*aggr_mode = AGGR_CACHE;
+	opt_aggr_mode->cache = true;
 	*aggr_level = level;
 	return 0;
 }
@@ -2101,13 +2130,15 @@ static void init_features(struct perf_session *session)
 	perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
 }
 
-static int __cmd_record(const struct option stat_options[], int argc, const char **argv)
+static int __cmd_record(const struct option stat_options[], struct opt_aggr_mode *opt_mode,
+			int argc, const char **argv)
 {
 	struct perf_session *session;
 	struct perf_data *data = &perf_stat.data;
 
 	argc = parse_options(argc, argv, stat_options, stat_record_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	stat_config.aggr_mode = opt_aggr_mode_to_aggr_mode(opt_mode);
 
 	if (output_name)
 		data->path = output_name;
@@ -2350,6 +2381,7 @@ static void setup_system_wide(int forks)
 
 int cmd_stat(int argc, const char **argv)
 {
+	struct opt_aggr_mode opt_mode = {};
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2393,10 +2425,10 @@ int cmd_stat(int argc, const char **argv)
 				stat__set_big_num),
 		OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
 			"list of cpus to monitor in system-wide"),
-		OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
-			"disable aggregation across CPUs or PMUs", AGGR_NONE),
-		OPT_SET_UINT(0, "no-merge", &stat_config.aggr_mode,
-			"disable aggregation the same as -A or -no-aggr", AGGR_NONE),
+		OPT_BOOLEAN('A', "no-aggr", &opt_mode.no_aggr,
+			"disable aggregation across CPUs or PMUs"),
+		OPT_BOOLEAN(0, "no-merge", &opt_mode.no_aggr,
+			"disable aggregation the same as -A or -no-aggr"),
 		OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
 			"Merge identical named hybrid events"),
 		OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
@@ -2424,21 +2456,18 @@ int cmd_stat(int argc, const char **argv)
 			"clear screen in between new interval"),
 		OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 			"stop workload and print counts after a timeout period in ms (>= 10ms)"),
-		OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
-			"aggregate counts per processor socket", AGGR_SOCKET),
-		OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
-			"aggregate counts per processor die", AGGR_DIE),
-		OPT_SET_UINT(0, "per-cluster", &stat_config.aggr_mode,
-			"aggregate counts per processor cluster", AGGR_CLUSTER),
-		OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat_config.aggr_level,
+		OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
+			"aggregate counts per processor socket"),
+		OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
+		OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
+			"aggregate counts per processor cluster"),
+		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode, &stat_config.aggr_level,
 				"cache level", "aggregate count at this cache level (Default: LLC)",
 				parse_cache_level),
-		OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
-			"aggregate counts per physical processor core", AGGR_CORE),
-		OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
-			"aggregate counts per thread", AGGR_THREAD),
-		OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
-			"aggregate counts per numa node", AGGR_NODE),
+		OPT_BOOLEAN(0, "per-core", &opt_mode.core,
+			"aggregate counts per physical processor core"),
+		OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),
+		OPT_BOOLEAN(0, "per-node", &opt_mode.node, "aggregate counts per numa node"),
 		OPT_INTEGER('D', "delay", &target.initial_delay,
 			"ms to wait before starting measurement after program start (-1: start with events disabled)"),
 		OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
@@ -2521,6 +2550,8 @@ int cmd_stat(int argc, const char **argv)
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
 
+	stat_config.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
+
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
 		if (!strcmp(stat_config.csv_sep, "\\t"))
@@ -2529,7 +2560,7 @@ int cmd_stat(int argc, const char **argv)
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		argc = __cmd_record(stat_options, argc, argv);
+		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
 			return -1;
 	} else if (argc && strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-- 
2.45.1.288.g0e0cd299f1-goog


