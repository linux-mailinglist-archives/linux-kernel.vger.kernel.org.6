Return-Path: <linux-kernel+bounces-339214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93381986418
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B531B2730F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A86184555;
	Wed, 25 Sep 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWrbUyJ2"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241B181B87
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273722; cv=none; b=M0XWyDWv+zi38VXwMsDlVzzuniYKSbBveGtHXebWOyECSU0t8cDFiA+ApsY/zk3+UqvtMYUGk+ZBhVTPCKflTD5ziV4exkcFu/j92en04Td0cJqoh/yDJ0WlrEj7b1ha6dOuY7SUV6s1UOpReNq5nr6OP4D0VIR49SeqValGzi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273722; c=relaxed/simple;
	bh=7bH55AtzDDvrgdScJ0/zLYbggvv/3DW4lwZHwa0zpqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTwK78t93rHmIWPtyTk7MCPJIQMZiet3/2r/bAoWEs9Buig4T6z7MfwAgQFxwW3vTi23V9wcSjp7EW5xO3JQC7FPNq5pGdvz2QXrtDeh4eMA8376STWphYFMDijsuy6o4e1czDlBn+2qrQXYx4ZPcJZTJD//+GKL5hchLiA6Fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWrbUyJ2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c5cc65a8abso3033851a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273718; x=1727878518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f05PQzvOEJplO/uvLn+IJgwf9BEDklxbAmP9za94pBU=;
        b=FWrbUyJ22JcTdz0R0pL3VgVZHL5gpnCvN1AXfolHo+b9wB5Mp20aCBsjRVRBMux8U1
         5JtNCyq7m7TxWi9dksG+TfueaL5GgS2+EYDsfAMBzz8kqBVppLeT/6I8QUrUxqC+EJFd
         661Jfi5rHGff54/+Il2DEkcvsGVZYnOfJBvDiUFE0zKkORxOBXAWf2Dm6bFluZcl4gnK
         9lfHV9dpYO8wYkj8J1uu6zWnfBfoudqZosjR7EtqbdTMqu17FGqR5Em0+qY70wiO6MVV
         u2/GNA+H+3VvknZeELkTr9Ol2kf05ULIB/tNVqUetG+SkV7Z5/et3hZ1VzXmso9+7dY4
         Aj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273718; x=1727878518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f05PQzvOEJplO/uvLn+IJgwf9BEDklxbAmP9za94pBU=;
        b=DML8csVEFY//honr7Lgj57mDaoEXhcbOK/0uMb7exxPABHQNU4PRyAwHV7ZRiHKe+U
         PP1HuUu2MA3gppZWnrgqeN8gGg8iEmlZqufFxVa2qFkqmW1FMOrOrI+J80o9pEMSeO40
         8MQ/gwwxoRPCtkkHwMUaFnYbctbXyZ3ymaLTl6GFn7mgk4Y4iWvSstPUTnXGqlnx7fNw
         yjPHdqYncroVTMbCJNSi0DOhtDhSe2iox9jvhHzbFCkugACGSJBnsGZkwURjLYN7Pz94
         yre4sde+HZVUGWMltMUJdpiIPk2+LzZalEsC7typXT4uJ0XVJjVLO2wtbeGEjmhG2zk5
         8zew==
X-Forwarded-Encrypted: i=1; AJvYcCWB+/f6UFWy58sXcmEVCB97x8O5Or0nFbQA2Z+ztLNIHyh+w54U0tUD1wT/tkW8bDWNSMGjPAUVLMCueVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlG2yjrCm8ngxpPYRy9gxQ8ZVUa1PjmmiTgXnPArOrtmJpQmUS
	dBYrmFdIAkHV1LA65CqEpv78x53eRBIJq21kFbki6BAc3gCj0HiAaDe3/yfPEC8=
X-Google-Smtp-Source: AGHT+IGn5t5q9btzAWZqrfmL7nzz9qyc99A9GauTqbDs9OFSvZg19ppadeYkW00VIHhQFHCN+xDIFw==
X-Received: by 2002:a05:6402:d0b:b0:5c4:14fe:971e with SMTP id 4fb4d7f45d1cf-5c72073e23bmr2347614a12.23.1727273717534;
        Wed, 25 Sep 2024 07:15:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:15:16 -0700 (PDT)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/7] perf stat: Uniquify event name improvements
Date: Wed, 25 Sep 2024 15:13:40 +0100
Message-Id: <20240925141357.1033087-3-james.clark@linaro.org>
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

Without aggregation on Intel:
```
$ perf stat -e instructions,cycles ...
```
Will use "cycles" for the name of the legacy cycles event but as
"instructions" has a sysfs name it will and a "[cpu]" PMU suffix. This
often breaks things as the space between the event and the PMU name
look like an extra column. The existing uniquify logic was also
uniquifying in cases when all events are core and not with uncore
events, it was not correctly handling modifiers, etc.

Change the logic so that an initial pass that can disable
uniquification is run. For individual counters, disable uniquification
in more cases such as for consistency with legacy events or for
libpfm4 events. Don't use the "[pmu]" style suffix in uniquification,
always use "pmu/.../". Change how modifiers/terms are handled in the
uniquification so that they look like parse-able events.

This fixes "102: perf stat metrics (shadow stat) test:" that has been
failing due to "instructions [cpu]" breaking its column/awk logic when
values aren't aggregated. This started happening when instructions
could match a sysfs rather than a legacy event, so the fixes tag
reflects this.

Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
[ Fix Intel TPEBS counting mode test ]
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/stat-display.c                | 101 ++++++++++++++----
 2 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index c60b29add980..9a11f42d153c 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -8,12 +8,15 @@ grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
 # Use this event for testing because it should exist in all platforms
 event=cache-misses:R
 
+# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
+alt_name=/cache-misses/R
+
 # Without this cmd option, default value or zero is returned
-echo "Testing without --record-tpebs"
-result=$(perf stat -e "$event" true 2>&1)
-[[ "$result" =~ $event ]] || exit 1
+#echo "Testing without --record-tpebs"
+#result=$(perf stat -e "$event" true 2>&1)
+#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
 
 # In platforms that do not support TPEBS, it should execute without error.
 echo "Testing with --record-tpebs"
 result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
-[[ "$result" =~ "perf record" && "$result" =~ $event ]] || exit 1
+[[ "$result" =~ "perf record" && "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea96e4ebad8c..cbff43ff8d0f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -871,38 +871,66 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 static void uniquify_event_name(struct evsel *counter)
 {
-	char *new_name;
-	char *config;
-	int ret = 0;
+	const char *name, *pmu_name;
+	char *new_name, *config;
+	int ret;
 
-	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
-					   strlen(counter->pmu_name)))
+	/* The evsel was already uniquified. */
+	if (counter->uniquified_name)
 		return;
 
-	config = strchr(counter->name, '/');
+	/* Avoid checking to uniquify twice. */
+	counter->uniquified_name = true;
+
+	/* The evsel has a "name=" config term or is from libpfm. */
+	if (counter->use_config_name || counter->is_libpfm_event)
+		return;
+
+	/* Legacy no PMU event, don't uniquify. */
+	if  (!counter->pmu ||
+	     (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW))
+		return;
+
+	/* A sysfs or json event replacing a legacy event, don't uniquify. */
+	if (counter->pmu->is_core && counter->alternate_hw_config != PERF_COUNT_HW_MAX)
+		return;
+
+	name = evsel__name(counter);
+	pmu_name = counter->pmu->name;
+	/* Already prefixed by the PMU name. */
+	if (!strncmp(name, pmu_name, strlen(pmu_name)))
+		return;
+
+	config = strchr(name, '/');
 	if (config) {
-		if (asprintf(&new_name,
-			     "%s%s", counter->pmu_name, config) > 0) {
-			free(counter->name);
-			counter->name = new_name;
-		}
-	} else {
-		if (evsel__is_hybrid(counter)) {
-			ret = asprintf(&new_name, "%s/%s/",
-				       counter->pmu_name, counter->name);
+		int len = config - name;
+
+		if (config[1] == '/') {
+			/* case: event// */
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
 		} else {
-			ret = asprintf(&new_name, "%s [%s]",
-				       counter->name, counter->pmu_name);
+			/* case: event/.../ */
+			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
 		}
+	} else {
+		config = strchr(name, ':');
+		if (config) {
+			/* case: event:.. */
+			int len = config - name;
 
-		if (ret) {
-			free(counter->name);
-			counter->name = new_name;
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
+		} else {
+			/* case: event */
+			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
 		}
 	}
-
-	counter->uniquified_name = true;
+	if (ret > 0) {
+		free(counter->name);
+		counter->name = new_name;
+	} else {
+		/* ENOMEM from asprintf. */
+		counter->uniquified_name = false;
+	}
 }
 
 static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
@@ -1559,6 +1587,31 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
+static void disable_uniquify(struct evlist *evlist)
+{
+	struct evsel *counter;
+	struct perf_pmu *last_pmu = NULL;
+	bool first = true;
+
+	evlist__for_each_entry(evlist, counter) {
+		/* If PMUs vary then uniquify can be useful. */
+		if (!first && counter->pmu != last_pmu)
+			return;
+		first = false;
+		if (counter->pmu) {
+			/* Allow uniquify for uncore PMUs. */
+			if (!counter->pmu->is_core)
+				return;
+			/* Keep hybrid event names uniquified for clarity. */
+			if (perf_pmus__num_core_pmus() > 1)
+				return;
+		}
+	}
+	evlist__for_each_entry_continue(evlist, counter) {
+		counter->uniquified_name = true;
+	}
+}
+
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts,
 			    int argc, const char **argv)
@@ -1572,6 +1625,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
+	disable_uniquify(evlist);
+
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
-- 
2.34.1


