Return-Path: <linux-kernel+bounces-217600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7C90B1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A321F2344C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EC1B1507;
	Mon, 17 Jun 2024 13:44:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67C21B1500;
	Mon, 17 Jun 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631885; cv=none; b=M/eYuPBkwzjUtrz9wS69NQ4aOJF+IN4ZXsmFDtpc5YsZ/MIbjSV0Lhduc2Rt1CDB3y/MbnfUEvyIq/01+IiyXFQpyyZ2S6Vh3sVmRgRvfEQus+uQETIA3eKHEcB6xWwkXBprcQmiBS4ULvNVHjceOXF1yzg+8f1uXh2sZpvtcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631885; c=relaxed/simple;
	bh=Gsnd0zvN4Us9YUc6L20+5iLhVWMkT+Vfavnt0sxap00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4KMd4wLGTBPRQb4BvzEVUiYBFuj9tJ1YIshLMLyFQnC2Ba77FP3uvRmRrzauIw8s1mGoNuDa1ULL2D63avVjzOu8sRgM6EYeT5Jtp/pXvhbSZ+Wx3euMhKnsGcaKYos8WYPFcImn1yIByZNItxw7PjKSBNST7ZyWkeSNbkevyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1E2FDA7;
	Mon, 17 Jun 2024 06:45:07 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA0683F64C;
	Mon, 17 Jun 2024 06:44:40 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	robin.murphy@arm.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf pmu: Don't de-duplicate core PMUs
Date: Mon, 17 Jun 2024 14:43:45 +0100
Message-Id: <20240617134348.208241-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617134348.208241-1-james.clark@arm.com>
References: <20240617134348.208241-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm PMUs have a suffix, either a single decimal (armv8_pmuv3_0) or 3 hex
digits which (armv8_cortex_a53) which Perf assumes are both strippable
suffixes for the purposes of deduplication. S390 "cpum_cf" is a
similarly suffixed core PMU but is only two characters so is not treated
as strippable because the rules are a minimum of 3 hex characters or 1
decimal character.

There are two paths involved in listing PMU events:

 * HW/cache event printing assumes core PMUs don't have suffixes so
   doesn't try to strip.
 * Sysfs PMU events share the printing function with uncore PMUs which
   strips.

This results in slightly inconsistent Perf list behavior if a core PMU
has a suffix:

  # perf list
  ...
  armv8_pmuv3_0/branch-load-misses/
  armv8_pmuv3/l3d_cache_wb/          [Kernel PMU event]
  ...

Fix it by partially reverting back to the old list behavior where
stripping was only done for uncore PMUs. For example commit 8d9f5146f5da
("perf pmus: Sort pmus by name then suffix") mentions that only PMUs
starting 'uncore_' are considered to have a potential suffix. This
change doesn't go back that far, but does only strip PMUs that are
!is_core. This keeps the desirable behavior where the many possibly
duplicated uncore PMUs aren't repeated, but it doesn't break listing for
core PMUs.

Searching for a PMU continues to use the new stripped comparison
functions, meaning that it's still possible to request an event by
specifying the common part of a PMU name, or even open events on
multiple similarly named PMUs. For example:

  # perf stat -e armv8_cortex/inst_retired/

  5777173628      armv8_cortex_a53/inst_retired/          (99.93%)
  7469626951      armv8_cortex_a57/inst_retired/          (49.88%)

Fixes: 3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/pmu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 97d74fe6d816..b73946ba9d05 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -847,6 +847,22 @@ __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
 	return perf_pmu__find_metrics_table(NULL);
 }
 
+/**
+ * Return the length of the PMU name not including the suffix for uncore PMUs.
+ *
+ * We want to deduplicate many similar uncore PMUs by stripping their suffixes,
+ * but there are never going to be too many core PMUs and the suffixes might be
+ * interesting. "arm_cortex_a53" vs "arm_cortex_a57" or "cpum_cf" for example.
+ *
+ * @skip_duplicate_pmus: False in verbose mode so all uncore PMUs are visible
+ */
+static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, bool skip_duplicate_pmus)
+{
+	return skip_duplicate_pmus && !pmu->is_core
+		? pmu_name_len_no_suffix(pmu->name)
+		: strlen(pmu->name);
+}
+
 /**
  * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring any
  *                                   trailing suffix? The Suffix must be in form
@@ -1796,9 +1812,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
 	struct parse_events_term *term;
-	size_t pmu_name_len = skip_duplicate_pmus
-		? pmu_name_len_no_suffix(pmu->name)
-		: strlen(pmu->name);
+	size_t pmu_name_len = pmu_deduped_name_len(pmu, skip_duplicate_pmus);
 	int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms.terms, list) {
@@ -1839,9 +1853,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		size_t buf_used, pmu_name_len;
 
 		info.pmu_name = event->pmu_name ?: pmu->name;
-		pmu_name_len = skip_duplicate_pmus
-			? pmu_name_len_no_suffix(info.pmu_name)
-			: strlen(info.pmu_name);
+		pmu_name_len = pmu_deduped_name_len(pmu, skip_duplicate_pmus);
 		info.alias = NULL;
 		if (event->desc) {
 			info.name = event->name;
-- 
2.34.1


