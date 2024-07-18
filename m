Return-Path: <linux-kernel+bounces-255771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2559344E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE415283CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52574059;
	Wed, 17 Jul 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SG9xxzy/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4726EB56
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256465; cv=none; b=jr89XZAKff/o79AyPfBc8fm+R/7u7hItBN5KI8WC5i6spGTbRnYmWxQJalgaqmk8JRXDiRBGAu3u4zT2lxj2VDNOZyDYg5DEfS/HtwiLrw1OCxLvMp9jOLS3oXusO2OM/DtZNJlBYyYCKW2ee7O9sdRKvuMrRx63PItXtY9Hxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256465; c=relaxed/simple;
	bh=80YyIwk/8VkjU4yqstE1PlbqioOpSQzgF7vZUjQSVCE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LXAndY0HiWoP4Ux6qEnaVyptt2Kl+BAP+YyvFG0Tk3krO8frKcakJ9VUuKm4xbrQwpYd+vYbIr3P6f+AN9NdGIEU+ZHAR/567DPQNeSS+I3TyRm0WAKplyesmpJleEwP6+W+FLpag2RC+Sn+HDQCJG7AN1WNDLHb0YjnreA0KdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SG9xxzy/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e036440617fso514682276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256463; x=1721861263; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDSkmz2B6LUpQkGELdRI3zhIL2uXO0hylwMkxD4wWcI=;
        b=SG9xxzy/wajQ/YGJQxo3zLVuu+lccfADWcZRXbYCkL/rSXNdVMd1aas6cURTprbX98
         89rPpOyYbaMRJTMtMkn64LvucJjaj2LIld9oQbUPkdOfm7D8WR3bCbuEPNAC+deLRRCx
         +TpL6HS3SPjH3CjrnqSsqQcmYv8m0XN97jc6GnuKtMxeZVzNZ7kWPo71fxhGdZlEwI3v
         +SoS7g26ooI971+5ed8Os586zdEY/aLCC0oZdyC+TkM4K8MzyGlqbdXYiwT0MqyRh9tn
         4UxXPS0UkjEttFFlqCE9ioVfPccG1HYKnLNM6yRIyoUC+C3WLLOz7cmdC7q2lNuOpYwL
         HNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256463; x=1721861263;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDSkmz2B6LUpQkGELdRI3zhIL2uXO0hylwMkxD4wWcI=;
        b=SskmjnNgJSpGh2yULI74Xidr2pc3KuRPkrkRb2DFyXPLTOi0b9j/LtmNf01zLyPDW9
         0tBeZkMvf6GrYzeYNiJWLwfVpwsI62G0jXWdIanpScGUdlc5WJdb4B3pq6wJw0d7N0gS
         hndnkOufa5owbCRksRInaZNnajjaf7u2etmYxVcdxhvAmKBGy8qCRwXcFTUjTvFJ5LUP
         onzFJuyvQOx6UNUI3wAwaPglTFF0wb52In5sPRGV/gL5jVnOGlMFfbiZZegkKQAM38Lj
         hYXo8w2jAynl2RZirBbdPd/mYV+Un1d6WVwDiCkYuafsXTwNIq1Wkcsh0OkGVXyLdlvc
         kXrw==
X-Forwarded-Encrypted: i=1; AJvYcCWO7gl1rcFsvdsbxVeS8u75CLfvGjO67Ft6BOfo7rwmj9XcIQYpkSlXR8k9d9ge/GpH3GFss65ijDSdenux0YFeoBoR7QL1nuFHRyo4
X-Gm-Message-State: AOJu0Ywyq3vMHvqQZXh7PTUcCv43tkOIuwUn3+iK2BsYZZ5uJS6szoZh
	Lo3fTTwAOAzQFKz2V6VQ/MmIAC88Ll+y5AY0e6a2DC1au5M/bVzJRc+niqjaqlZfwBCGagRiBOF
	BCWR0qw==
X-Google-Smtp-Source: AGHT+IGKj/kxykoZFxJ3cI2Bub9eKPyxqwq4bQ8DkCCjCD7+sJhfPBqXbN5/mM1PE2I+5Av1eikzl4svPRF5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d86:b0:e03:6405:7428 with SMTP
 id 3f1490d57ef6-e05febedf75mr2560276.12.1721256462309; Wed, 17 Jul 2024
 15:47:42 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:29 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 3/6] perf pmu: Add support for event.cpus files in sysfs
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

If an event file exists in sysfs, check if a event.cpus file exists
and read a perf_cpu_map from it if it does. This allows particular
events to have a different set of CPUs compared to the PMU.

One scenario where this could be useful is when a PMU is set up with a
cpumask/events per SMT thread but some events record for all SMT
threads. Programming an event on each SMT thread will cause
unnecessary counters to be programmed and the aggregate value to be
too large.

Another scenario where this could be useful if when a PMU has
historically had a cpumask at the package level, but now newer per
die, core or CPU information is available.

Additional context for the motivation is in these patches and
conversation:
https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../sysfs-bus-event_source-devices-events     | 14 ++++++
 tools/perf/util/parse-events.c                | 45 ++++++++++---------
 tools/perf/util/pmu.c                         | 44 +++++++++++++++++-
 tools/perf/util/pmu.h                         |  1 +
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index e7efeab2ee83..d8e3a4dd3ba7 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -70,6 +70,20 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		This is referred to as "event parameterization". Event
 		parameters have the format 'param=?'.
 
+What: /sys/bus/event_source/devices/<pmu>/events/<event>.cpus
+Date: 2024/07/17
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Perf event CPUs
+
+		A list of CPUs on which a the perf event should be
+		opened by default. This is an event specific variant
+		of /sys/bus/event_source/devices/<pmu>/cpumask.
+
+		Examples (each of these lines would be in a separate file):
+
+			0,2,4,6
+			0-7
+
 What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
 Date: 2014/02/24
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 43501eb56336..b181f83c9678 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1425,12 +1425,13 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
-	struct perf_pmu_info info;
+	struct perf_pmu_info info = {};
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	int ret = 0;
 
 	if (verbose > 1) {
 		struct strbuf sb;
@@ -1465,8 +1466,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	parse_events_terms__init(&parsed_terms);
 	if (const_parsed_terms) {
-		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
-
+		ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
 		if (ret)
 			return ret;
 	}
@@ -1474,15 +1474,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
 	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	/* Look for event names in the terms and rewrite into format based terms. */
 	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
 							    &info, &alias_rewrote_terms, err)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	if (verbose > 1) {
@@ -1497,13 +1497,13 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	/* Configure attr/terms again if an alias was expanded. */
 	if (alias_rewrote_terms &&
 	    config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	if (get_config_terms(&parsed_terms, &config_terms)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 
 	/*
@@ -1512,24 +1512,23 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	 */
 	if (pmu->perf_event_attr_init_default &&
 	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 
 	if (!parse_state->fake_pmu &&
 	    perf_pmu__config(pmu, &attr, &parsed_terms, parse_state->error)) {
-		free_config_terms(&config_terms);
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+			    &config_terms, auto_merge_stats, info.cpus);
 	if (!evsel) {
-		parse_events_terms__exit(&parsed_terms);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 
 	if (evsel->name)
@@ -1542,13 +1541,17 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return 0;
 	}
 
-	parse_events_terms__exit(&parsed_terms);
 	free((char *)evsel->unit);
 	evsel->unit = strdup(info.unit);
 	evsel->scale = info.scale;
 	evsel->per_pkg = info.per_pkg;
 	evsel->snapshot = info.snapshot;
-	return 0;
+out_err:
+	parse_events_terms__exit(&parsed_terms);
+	if (ret)
+		free_config_terms(&config_terms);
+	perf_cpu_map__put(info.cpus);
+	return ret;
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5148b6639dd3..280b2499c861 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -73,6 +73,11 @@ struct perf_pmu_alias {
 	 * differ from the PMU name as it won't have suffixes.
 	 */
 	char *pmu_name;
+	/**
+	 * @cpus: A possible per-event cpumap that overrides that given for the
+	 * PMU.
+	 */
+	struct perf_cpu_map *cpus;
 	/** @unit: Units for the event, such as bytes or cache lines. */
 	char unit[UNIT_MAX_LEN+1];
 	/** @scale: Value to scale read counter values by. */
@@ -332,6 +337,32 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *al
 	return ret;
 }
 
+static void perf_pmu__parse_cpus(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	char path[PATH_MAX];
+	size_t len;
+	FILE *file;
+	int fd;
+
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return;
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.cpus", pmu->name, alias->name);
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return; /* Expected common case. */
+
+	file = fdopen(fd, "r");
+	if (!file) {
+		close(fd);
+		return;
+	}
+
+	alias->cpus = perf_cpu_map__read(file);
+	fclose(file);
+}
+
 static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
 	char path[PATH_MAX];
@@ -493,6 +524,7 @@ static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 	/*
 	 * load unit name and scale if available
 	 */
+	perf_pmu__parse_cpus(pmu, alias);
 	perf_pmu__parse_unit(pmu, alias);
 	perf_pmu__parse_scale(pmu, alias);
 	perf_pmu__parse_per_pkg(pmu, alias);
@@ -618,7 +650,7 @@ static inline bool pmu_alias_info_file(const char *name)
 	size_t len;
 
 	len = strlen(name);
-	if (len > 5 && !strcmp(name + len - 5, ".unit"))
+	if (len > 5 && (!strcmp(name + len - 5, ".cpus") || !strcmp(name + len - 5, ".unit")))
 		return true;
 	if (len > 6 && !strcmp(name + len - 6, ".scale"))
 		return true;
@@ -1560,6 +1592,12 @@ static int check_info_data(struct perf_pmu *pmu,
 	 * define unit, scale and snapshot, fail
 	 * if there's more than one.
 	 */
+	if (!perf_cpu_map__is_empty(info->cpus) && !perf_cpu_map__is_empty(alias->cpus)) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event's cpus twice"),
+					NULL);
+		return -EINVAL;
+	}
 	if (info->unit && alias->unit[0]) {
 		parse_events_error__handle(err, column,
 					strdup("Attempt to set event's unit twice"),
@@ -1579,6 +1617,9 @@ static int check_info_data(struct perf_pmu *pmu,
 		return -EINVAL;
 	}
 
+	if (!perf_cpu_map__is_empty(alias->cpus))
+		info->cpus = perf_cpu_map__get(alias->cpus);
+
 	if (alias->unit[0])
 		info->unit = alias->unit;
 
@@ -1610,6 +1651,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	 * Mark unit and scale as not set
 	 * (different from default values, see below)
 	 */
+	info->cpus     = NULL;
 	info->unit     = NULL;
 	info->scale    = 0.0;
 	info->snapshot = false;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b2d3fd291f02..b1ccfe8d3df4 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -177,6 +177,7 @@ struct perf_pmu {
 extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
+	struct perf_cpu_map *cpus;
 	const char *unit;
 	double scale;
 	bool per_pkg;
-- 
2.45.2.1089.g2a221341d9-goog


