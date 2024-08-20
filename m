Return-Path: <linux-kernel+bounces-294485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C06958E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A6A1C21D30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0B516728B;
	Tue, 20 Aug 2024 18:48:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA07166F05;
	Tue, 20 Aug 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179680; cv=none; b=WeV+c2/ugoYfyXPtgmacuOdHyZfA0ytuJL0dPjhCv4tyfoTK3jHaIPN69O+u986bcwDKBu5zeJNgo/Hl9aSj3UY29ZRm/DnlLXWX9dsA2yMo5Fe8FKzJHxNnZkZ/xd3XG37q1Tk+kDMt5PrmOuptlxyTSLuVimTdCE7Rccx8jvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179680; c=relaxed/simple;
	bh=H6w10jYTrJ+KZDCrCKg26+egc1UhDEhCUqlEYNIWxOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPj9zRnvD1orYkB69uoo8BTkpht1TaAAKqqNUcfyU4zd8y9nZYqTDf27oOkh6RdokwLhivhB6W+K35FgwOLRnlvVyEMWTvDqLmJsgvcFXKuPFatrM+ylYFEHHd7/MJQeJWYimcF2U0dXhRfEkkFvQbReZgpGQlUiYgnpPyIg3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C09FEC;
	Tue, 20 Aug 2024 11:48:24 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA1EB3F58B;
	Tue, 20 Aug 2024 11:47:55 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 4/8] perf auxtrace: Introduce auxtrace_record__validate_events()
Date: Tue, 20 Aug 2024 19:47:27 +0100
Message-Id: <20240820184731.2937551-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820184731.2937551-1-leo.yan@arm.com>
References: <20240820184731.2937551-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A prerequisite for multiple AUX events is that the AUX events cannot
overlap CPU maps. The reason is that every CPU has only one AUX trace
buffer and maps it to an unique buffer index for CPU and system tracing
mode.

To prevent the case of CPU maps overlapping occurring within multiple
AUX events, the auxtrace_record__validate_events() function is
introduced. It iterates through all AUX events and returns failure if
it detects CPU maps overlapping.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-record.c |  4 +++
 tools/perf/util/auxtrace.c  | 64 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h  |  7 ++++
 3 files changed, 75 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..2c618efba97d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -862,6 +862,10 @@ static int record__auxtrace_init(struct record *rec)
 
 	auxtrace_regroup_aux_output(rec->evlist);
 
+	err = auxtrace_validate_events(rec->evlist);
+	if (err)
+		return err;
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ca8682966fae..87e4f21b6edf 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2828,6 +2828,70 @@ int auxtrace_parse_filters(struct evlist *evlist)
 	return 0;
 }
 
+int auxtrace_validate_events(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	struct perf_cpu_map *cpu_map = NULL;
+	struct perf_cpu_map *cpu_map_intersect = NULL;
+	struct perf_cpu_map *cpu_map_merged = NULL;
+	int ret = 0;
+
+	if (!evlist)
+		return 0;
+
+	/*
+	 * Currently the tool only supports multiple AUX events without
+	 * overlapping CPU maps and every CPU has its unique AUX buffer
+	 * for CPU or system mode tracing.
+	 *
+	 * Returns failure if detects CPU maps overlapping.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel__is_aux_event(evsel))
+			continue;
+
+		if (perf_cpu_map__is_empty(evsel->pmu->cpus))
+			continue;
+
+		cpu_map_intersect = perf_cpu_map__intersect(cpu_map, evsel->pmu->cpus);
+		if (cpu_map_intersect) {
+			perf_cpu_map__put(cpu_map_intersect);
+			pr_err("Doesn't support AUX events with overlapping CPU masks\n");
+			ret = -EINVAL;
+			break;
+		}
+		perf_cpu_map__put(cpu_map_intersect);
+
+		cpu_map_merged = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);
+		if (!cpu_map_merged) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		/* Update the CPU maps after merging */
+		perf_cpu_map__put(cpu_map);
+		cpu_map = cpu_map_merged;
+	}
+
+	if (!ret)
+		goto out;
+
+	/* If fails, dump CPU maps for debugging */
+	evlist__for_each_entry(evlist, evsel) {
+		char buf[200];
+
+		if (!evsel__is_aux_event(evsel))
+			continue;
+
+		cpu_map__snprint(evsel->pmu->cpus, buf, sizeof(buf));
+		pr_debug("AUX event [%s]'s cpu map is: %s\n", evsel->pmu->name, buf);
+	}
+
+out:
+	perf_cpu_map__put(cpu_map);
+	return ret;
+}
+
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, const struct perf_tool *tool)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a1895a4f530b..67a74ad0c383 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -636,6 +636,7 @@ void addr_filters__exit(struct addr_filters *filts);
 int addr_filters__parse_bare_filter(struct addr_filters *filts,
 				    const char *filter);
 int auxtrace_parse_filters(struct evlist *evlist);
+int auxtrace_validate_events(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, const struct perf_tool *tool);
@@ -875,6 +876,12 @@ int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
 	return 0;
 }
 
+static inline
+int auxtrace_validate_events(struct evlist *evlist __maybe_unused)
+{
+	return 0;
+}
+
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 			struct auxtrace_mmap_params *mp,
 			void *userpg, int fd);
-- 
2.34.1


