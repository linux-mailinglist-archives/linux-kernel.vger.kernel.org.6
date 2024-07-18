Return-Path: <linux-kernel+bounces-255807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFA934567
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9650FB2193B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FB0AD5F;
	Thu, 18 Jul 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3qpoZNc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC02C1AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262658; cv=none; b=fRkmaP9kKNL0Fcx9GggLHVwlP0cUhCTeEP9m0tJBo7QbEU/yxTql2qm3GVlf1NF6rfwxB3ujXVeeQfS/8e3j7kWX7FUNkjzFbW06tGEWLbRJfMBFXC8SuLRPeGRaZecsDidEKnfWxUh9e4EQVFA0+q+oz57HEfeZpx6TMnSYXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262658; c=relaxed/simple;
	bh=hPkdKtcjtneGae/p2zsac1oTD4YZxfkLQ8/rw90njuE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VrxRZYCItn79HIwer/G9Nw3915GQ7ZX1Chtq7H2I2GLhS0SVlTHrTWKjc0KzzIWI09eVLtzcNJvVzUwvFKfFYTe4Tc5RYL92PPxe+1eZLWoHKLLAhJgrnID9LH+3Eg7al/b4tbJUvIbBxYVNJG+PMT6STkfwg4phy/aSLEyUsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3qpoZNc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so785009276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262654; x=1721867454; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZjSoS5cuNlc22m8gTceQLlRpYZr/ZrrOH8zAIvi2p0=;
        b=g3qpoZNcf8djVOEiXW7m4y+e9BWG5v3HtpvgnAwSQHJQbVl7pkwrzpL92kkO7kZzPz
         clT/iWfIaQ8h2jJQ9zIuz5QPJMDBdulGUMvh5IkZZwjIFYePAatTRP4kwv+P/u1QESPi
         NnNDFDIu9fWbKv7jkDIykiU6VEY/9Ghz++NZTBfo6rVHsiRax5Y1MQl51dEm0T4mfvl0
         Y03fmtK7Y94QWc1plJYFnHVvEvZWePscyefKTMVGluf83L1hbnH7200e/sLPi6rDfolt
         ix5o/5VVrIfOHSX0zshZ9fMjbMhItYRoLcfWzTdHlJpJuvunBc6u27XDYMbXUXFBZRxl
         rl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262654; x=1721867454;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZjSoS5cuNlc22m8gTceQLlRpYZr/ZrrOH8zAIvi2p0=;
        b=fYtIrBhm0eooCpLbxJMZ5faHb5wlm3YEhIVS4XVepj5r4u+allZUibWQNsoMiwViBa
         PYbXVnd3bIwHafBlt/vTiDYwBHatPSb+p63RuodaoNMcgNkaCFmXlthtZNzR7ECmxUFi
         fABOoaFvS0cb/JgdNsfnQM9YE3cK3J2anVhQG54vLM+q/Vq+BMvwg1DMliGyqT6YmwKY
         i5fKNFbAKGA3pmX5sW3G1V5knI2jEeCHP+DV6hn/+BfTpZf6UPrs5P7t3AygKX4wEzBE
         8c5zKQrpnCRhRkzhADH6mOVO1hPS9yyHoEU5PdnCJ2eEklNO2ukU+waUf/k328GXB5dE
         Bjaw==
X-Forwarded-Encrypted: i=1; AJvYcCVyAu9p4VIgPQWcY/QRa//tXfQ+YfaJKQ9+THSnXRimVDLYrHKFNTdulDYdIXGEZTzEMyqvLz+w0P2k9h8YSjUnZjxUPVRB9e0F1gZE
X-Gm-Message-State: AOJu0YwD3XbnQnUZNJgiv/n/ajb7fvO1E1XP4tCcB5BIsKzrrS6yj1Lf
	WF8r/hWx9AyG9iOr76cryKFiRVEf89UbZ+PiiNTBEWv0K/2h4VZOf6OSvWZ7u8sncloGughQOSG
	7hbfJhg==
X-Google-Smtp-Source: AGHT+IGmu+Pp+xArAtOQV1L+0b9ATmdm8Fwrw7sscfQGWXRtOe90IqU7rKc8l/2wpefyr2wxMtHzRKi3itfz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:72f:b0:e05:ec8f:b497 with SMTP id
 3f1490d57ef6-e05feac7896mr45202276.4.1721262654564; Wed, 17 Jul 2024 17:30:54
 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:25 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU an
 event is recorded on
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

The -C option allows the CPUs for a list of events to be specified but
its not possible to set the CPU for a single event. Add a term to
allow this. The term isn't a general CPU list due to ',' already being
a special character in event parsing instead multiple cpu= terms may
be provided and they will be merged/unioned together.

An example of mixing different types of events counted on different CPUs:
```
$ perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0              368,647      instructions/cpu=0/              #    0.26  insn per cycle
CPU4        <not counted>      instructions/cpu=0/
CPU5        <not counted>      instructions/cpu=0/
CPU8        <not counted>      instructions/cpu=0/
CPU0        <not counted>      l1d-misses [cpu]
CPU4              203,377      l1d-misses [cpu]
CPU5              138,231      l1d-misses [cpu]
CPU8        <not counted>      l1d-misses [cpu]
CPU0        <not counted>      cpu/cpu=8/
CPU4        <not counted>      cpu/cpu=8/
CPU5        <not counted>      cpu/cpu=8/
CPU8              943,861      cpu/cpu=8/
CPU0            1,412,071      cycles
CPU4           20,362,900      cycles
CPU5           10,172,725      cycles
CPU8            2,406,081      cycles

       0.102925309 seconds time elapsed
```

Note, the event name of inst_retired.any is missing, reported as
cpu/cpu=8/, as there are unmerged uniquify fixes:
https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/

An example of spreading uncore overhead across two CPUs:
```
$ perf stat -A -e "data_read/cpu=0/,data_write/cpu=1/" -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=0/
CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=0/
CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=1/
CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=1/
CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=1/
CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=1/
```

Manually fixing the output it should be:
```
CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=0/
CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=0/
CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=1/
CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=1/
```

That is data_read from 2 PMUs was counted on CPU0 and data_write was
counted on CPU1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |  9 ++++
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 73 ++++++++++++++++++++++----
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  1 +
 6 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 6bf2468f59d3..15511afe94a1 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -273,6 +273,15 @@ Sums up the event counts for all hardware threads in a core, e.g.:
 
   perf stat -e cpu/event=0,umask=0x3,percore=1/
 
+cpu:
+
+Specifies the CPU to open the event upon. The value may be repeated to
+specify opening the event on multiple CPUs:
+
+
+  perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1,cpu=2/ -a sleep 1
+  perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
+
 
 EVENT GROUPS
 ------------
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index aee6f808b512..9630c4a24721 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -47,6 +47,7 @@ struct evsel_config_term {
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
 		char	      *str;
+		int	      cpu;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8c0c33361c5e..85faef85b8de 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
+#include "cpumap.h"
 #include "term.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -177,6 +178,26 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
 
+static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head_terms)
+{
+	struct parse_events_term *term;
+	struct perf_cpu_map *cpus = NULL;
+
+	if (!head_terms)
+		return NULL;
+
+	list_for_each_entry(term, &head_terms->terms, list) {
+		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
+			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
+
+			cpus = perf_cpu_map__merge(cpus, cpu);
+			perf_cpu_map__put(cpu);
+		}
+	}
+
+	return cpus;
+}
+
 /**
  * fix_raw - For each raw term see if there is an event (aka alias) in pmu that
  *           matches the raw's string value. If the string value matches an
@@ -468,11 +489,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
 	const char *metric_id = get_config_metric_id(parsed_terms);
+	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
+	int ret = 0;
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
-		int ret;
 
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
@@ -486,7 +508,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 						   parsed_terms,
 						   perf_pmu__auto_merge_stats(pmu));
 			if (ret)
-				return ret;
+				goto out_err;
 			continue;
 		}
 
@@ -506,20 +528,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		if (parsed_terms) {
 			if (config_attr(&attr, parsed_terms, parse_state->error,
-					config_term_common))
-				return -EINVAL;
-
-			if (get_config_terms(parsed_terms, &config_terms))
-				return -ENOMEM;
+					config_term_common)) {
+				ret = -EINVAL;
+				goto out_err;
+			}
+			if (get_config_terms(parsed_terms, &config_terms)) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
 		}
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
 				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-				/*cpu_list=*/NULL) == NULL)
-			return -ENOMEM;
+				cpus) == NULL)
+			ret = -ENOMEM;
 
 		free_config_terms(&config_terms);
+		if (ret)
+			goto out_err;
 	}
+out_err:
+	perf_cpu_map__put(cpus);
 	return found_supported ? 0 : -EINVAL;
 }
 
@@ -814,6 +843,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -843,6 +873,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -986,6 +1017,15 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_CPU:
+		CHECK_TYPE_VAL(NUM);
+		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("too big"),
+						NULL);
+			return -EINVAL;
+		}
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1112,6 +1152,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1243,6 +1284,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1296,6 +1338,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1350,6 +1393,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
+	struct perf_cpu_map *cpus;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1371,9 +1415,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
+	cpus = get_config_cpu(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
 			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
+			cpus) ? 0 : -ENOMEM;
+	perf_cpu_map__put(cpus);
 	free_config_terms(&config_terms);
 	return ret;
 }
@@ -1440,6 +1486,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	struct perf_cpu_map *term_cpu = NULL;
 	int ret = 0;
 
 	if (verbose > 1) {
@@ -1531,6 +1578,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		goto out_err;
 	}
 
+	term_cpu = get_config_cpu(&parsed_terms);
+	if (!perf_cpu_map__is_empty(term_cpu)) {
+		perf_cpu_map__put(info.cpus);
+		info.cpus = term_cpu;
+		term_cpu = NULL;
+	}
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e13de2c8b706..b03857499030 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,7 +79,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_CPU,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 16045c383ada..e06097a62796 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -330,6 +330,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 280b2499c861..27e2ff23799e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1767,6 +1767,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"percore",
 		"aux-output",
 		"aux-sample-size=number",
+		"cpu=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.45.2.1089.g2a221341d9-goog


