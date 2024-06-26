Return-Path: <linux-kernel+bounces-230968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5836E918479
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5161C22CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A7186288;
	Wed, 26 Jun 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUIFB43t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB01850A9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412506; cv=none; b=OXiRmmWTB7b1S0iTK4CD3NMmX8ECeLXF7ut6iPQpXET8ua7Av4Di3YNHsiQXFvphf0ABT65t++k3xU3pKA668qGA3jmbZ/cLq3wE0czUN2PDmBT6n+1W5zPAXG75LSpna64Srhy2HeSJZoa98Nc/DdFnQSdFYHKywhoi/k4+Dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412506; c=relaxed/simple;
	bh=pEFVoLXCBUr0+TUG7ZxtIYThmtfKZBkGznApMscpDZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtQj6LiXMN0LKOTHgqdvOdsO+MwF6DCVpJRCgm7K+1W5xfCUsn4vlH32QaZPG8Vt3ta7T9clCm0+8T38nGe1jEYVWB/qpueYqEoSZXqt2tJRSp15kaVjzBSLY63DNY4C6y8gDHtjcyFwb9oWaTwFP8YZrz5X1GNUJIB7vPwF0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUIFB43t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412505; x=1750948505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEFVoLXCBUr0+TUG7ZxtIYThmtfKZBkGznApMscpDZs=;
  b=AUIFB43t4QMTP9iIEdWeLFwlo4B48kU5lxN79cwzo1UwE4WwE+e+y4r7
   7jRR0t7yb/Q1TwKdFP5skvnOLzg89cn/T+0BWOCsNkx4Qh3idO+KpA/X9
   iN9g0AxdiQf+g/49kK5+wXeqhVNof9MVT+dYx227Ur3anWy2x5h3UKkdu
   dTONZgExBOParCH1aV2IAwxeCstc8vSVEs49CgFnAp7b0Nr0zA2LjWpiR
   qVGe0L5jfoiRkn1ArLjXslTcYtKc1m/nyzLY9du23XwduZr7ug+MCyAX+
   H0R1cIZOHQgElk7qCn+eLBHcXm1nF3fWRWCg23ybi/8CohcHSYaZw7gfw
   Q==;
X-CSE-ConnectionGUID: W42238L7SFqJ2sR58WIq6A==
X-CSE-MsgGUID: tugvzaxWRgal27fkQP1LdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375518"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375518"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:45 -0700
X-CSE-ConnectionGUID: nnahtfMpRNmjB4j2gKXGXA==
X-CSE-MsgGUID: OixOj1BxRS6D+0tbcGBLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911950"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2024 07:34:44 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 01/13] perf/x86/intel: Support the PEBS event mask
Date: Wed, 26 Jun 2024 07:35:33 -0700
Message-Id: <20240626143545.480761-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240626143545.480761-1-kan.liang@linux.intel.com>
References: <20240626143545.480761-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current perf assumes that the counters that support PEBS are
contiguous. But it's not guaranteed with the new leaf 0x23 introduced.
The counters are enumerated with a counter mask. There may be holes in
the counter mask for future platforms or in a virtualization
environment.

Store the PEBS event mask rather than the maximum number of PEBS
counters in the x86 PMU structures.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c    |  8 ++++----
 arch/x86/events/intel/ds.c      | 15 ++++++++-------
 arch/x86/events/perf_event.h    | 14 ++++++++++++--
 arch/x86/include/asm/intel_ds.h |  1 +
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0e835dc134a5..6e2e3638a690 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4728,7 +4728,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 {
 	intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
 				     &pmu->intel_ctrl, (1ULL << pmu->num_counters_fixed) - 1);
-	pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+	pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 	pmu->unconstrained = (struct event_constraint)
 			     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 						0, pmu->num_counters, 0, 0);
@@ -6070,7 +6070,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 
 		pmu->num_counters = x86_pmu.num_counters;
 		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 		pmu->unconstrained = (struct event_constraint)
 				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							0, pmu->num_counters, 0, 0);
@@ -6193,7 +6193,7 @@ __init int intel_pmu_init(void)
 	x86_pmu.events_maskl		= ebx.full;
 	x86_pmu.events_mask_len		= eax.split.mask_length;
 
-	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
+	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(GENMASK_ULL(x86_pmu.num_counters - 1, 0));
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
 
 	/*
@@ -6822,7 +6822,7 @@ __init int intel_pmu_init(void)
 			pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
 		}
 
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 		pmu->unconstrained = (struct event_constraint)
 					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							   0, pmu->num_counters, 0, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e010bfed8417..f6105b8dcf87 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1137,7 +1137,7 @@ void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sche
 static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
-	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int max_pebs_events = intel_pmu_max_num_pebs(cpuc->pmu);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	u64 threshold;
 	int reserved;
@@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	void *base, *at, *top;
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	int max_pebs_events = intel_pmu_max_num_pebs(NULL);
 	int bit, i, size;
 	u64 mask;
 
@@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
-	size = x86_pmu.max_pebs_events;
+	mask = x86_pmu.pebs_events_mask;
+	size = max_pebs_events;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
 		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
 		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
@@ -2208,8 +2209,9 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 			pebs_status = p->status = cpuc->pebs_enabled;
 
 		bit = find_first_bit((unsigned long *)&pebs_status,
-					x86_pmu.max_pebs_events);
-		if (bit >= x86_pmu.max_pebs_events)
+				     max_pebs_events);
+
+		if (!(x86_pmu.pebs_events_mask & (1 << bit)))
 			continue;
 
 		/*
@@ -2267,7 +2269,6 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
@@ -2283,7 +2284,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = ((1ULL << max_pebs_events) - 1) |
+	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (((1ULL << num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
 	size = INTEL_PMC_IDX_FIXED + num_counters_fixed;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 72b022a1e16c..0e411539f88a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -684,7 +684,7 @@ struct x86_hybrid_pmu {
 	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
-	int				max_pebs_events;
+	u64				pebs_events_mask;
 	int				num_counters;
 	int				num_counters_fixed;
 	struct event_constraint		unconstrained;
@@ -852,7 +852,7 @@ struct x86_pmu {
 			pebs_ept		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
-	int		max_pebs_events;
+	u64		pebs_events_mask;
 	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
@@ -1661,6 +1661,16 @@ static inline int is_ht_workaround_enabled(void)
 	return !!(x86_pmu.flags & PMU_FL_EXCL_ENABLED);
 }
 
+static inline u64 intel_pmu_pebs_mask(u64 cntr_mask)
+{
+	return MAX_PEBS_EVENTS_MASK & cntr_mask;
+}
+
+static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
+{
+	return find_last_bit((unsigned long *)&hybrid(pmu, pebs_events_mask), MAX_PEBS_EVENTS) + 1;
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
 
 static inline void reserve_ds_buffers(void)
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 2f9eeb5c3069..5dbeac48a5b9 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -9,6 +9,7 @@
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
 #define MAX_PEBS_EVENTS		32
+#define MAX_PEBS_EVENTS_MASK	GENMASK_ULL(MAX_PEBS_EVENTS - 1, 0)
 #define MAX_FIXED_PEBS_EVENTS	16
 
 /*
-- 
2.38.1


