Return-Path: <linux-kernel+bounces-219713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3383890D6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19E9285995
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D73145341;
	Tue, 18 Jun 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vrc7SzD6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608E13D880
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723539; cv=none; b=ey4IbrplxRmfZ4DYgFJKpyDXeNkpx6ggYYVdfYimSUkYmQGeU3REGu1xelh+6RooY2qFE88Vt9VsKkElmwdBbEKubqy2QxGaU9YnZH7zFeL29caordH6+M0kdPtj2d/AGPHZXaETr3xdriGGv/esUTohJ0jislbL9+Sbsb+9cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723539; c=relaxed/simple;
	bh=lreWVwWNk22lva0+Du+kLlBk429avCMcjb4fUzqU4jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rl5FDdO0YEqSTZmlVXv+P7XCOgedB8bKFj1UTbpwvGBrBpXBLVqAIix6VmjoYVxECcXrp9zTo8oITg5jso0eAKcmvC1l5h4QrQBucYFwVZQllEy9HqpPYTtUFMrfmCGAVOTK0qx3mG6BOkv9NxH5dZNyiPwzseVA3nZkqdbPqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vrc7SzD6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718723537; x=1750259537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lreWVwWNk22lva0+Du+kLlBk429avCMcjb4fUzqU4jM=;
  b=Vrc7SzD6xtGaRSAicqINHghOKaarnJ/cLPQpJNhqUD8zlv8YIGVwVcZc
   TFizh3wdHQlZdLTRjnorz1FjMFEOTF0YK2hHoFniVbnVOlhrXyg8+gtyp
   56t1mrAJ0l21BxC8ZyfQ22xBGrU6nQkIghPXzv2sVlCtMos2L12V2bIVy
   x239w4wVNTiqGPu9K1EGLls1maIiAq9AZs3vMk/t8kCESSDcnJfDw4qOB
   UT6FKtNz1lgPEDSxe8NQDIOuNUIlzET0WIUy+YRQCv+PEpH8VJYE5n8Fl
   J+Qi9Ld6PZTkPVvGgxLIwhL8392hKKgc/WO1QEi/X2VyVL6sPKRtZhQp5
   Q==;
X-CSE-ConnectionGUID: fZejfmyGThK0L9CLq27D/Q==
X-CSE-MsgGUID: VJ5KY13STmqotVWq3C2DrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15374197"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15374197"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:12:15 -0700
X-CSE-ConnectionGUID: HEIl5fPZTS6K+OKttbO6Qg==
X-CSE-MsgGUID: QHrYG7UFTVCi7Lip78hp6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41426930"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jun 2024 08:12:15 -0700
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
Subject: [RESEND PATCH 03/12] perf/x86: Add Lunar Lake and Arrow Lake support
Date: Tue, 18 Jun 2024 08:10:35 -0700
Message-Id: <20240618151044.1318612-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240618151044.1318612-1-kan.liang@linux.intel.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, Lunar Lake and Arrow Lake are similar to the
previous generation Meteor Lake. Both are hybrid platforms, with e-core
and p-core.

The key differences include:
- The e-core supports 3 new fixed counters
- The p-core supports an updated PEBS Data Source format
- More GP counters (Updated event constraint table)
- New Architectural performance monitoring V6
  (New Perfmon MSRs aliasing, umask2, eq).
- New PEBS format V6 (Counters Snapshotting group)
- New RDPMC metrics clear mode

The legacy features, the 3 new fixed counters and updated event
constraint table are enabled in this patch.

The new PEBS data source format, the architectural performance
monitoring V6, the PEBS format V6, and the new RDPMC metrics clear mode
are supported in the following patches.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 117 ++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c        |  24 ++++++
 arch/x86/events/perf_event.h      |   2 +
 arch/x86/include/asm/perf_event.h |   4 +
 4 files changed, 147 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b9f2fea84896..42e65fb6f2ff 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -220,6 +220,17 @@ static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
+	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
+	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -370,6 +381,55 @@ static struct extra_reg intel_rwc_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct event_constraint intel_lnc_event_constraints[] = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_HEAVY_OPS, 4),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BR_MISPREDICT, 5),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
+
+	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
+
+	INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff),
+	INTEL_EVENT_CONSTRAINT(0x3c, 0x3ff),
+	/*
+	 * Generally event codes < 0x90 are restricted to counters 0-3.
+	 * The 0x2E and 0x3C are exception, which has no restriction.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x08a3, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
+	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
+
+	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
+	/*
+	 * Generally event codes >= 0x90 are likely to have no restrictions.
+	 * The exception are defined as above.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0x3ff),
+
+	EVENT_CONSTRAINT_END
+};
+
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
@@ -5790,6 +5850,23 @@ static struct attribute *adl_hybrid_events_attrs[] = {
 	NULL,
 };
 
+EVENT_ATTR_STR_HYBRID(topdown-retiring,      td_retiring_lnl,  "event=0xc2,umask=0x02;event=0x00,umask=0x80", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,      td_fe_bound_lnl,  "event=0x9c,umask=0x01;event=0x00,umask=0x82", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,      td_be_bound_lnl,  "event=0xa4,umask=0x02;event=0x00,umask=0x83", hybrid_big_small);
+
+static struct attribute *lnl_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_adl),
+	EVENT_PTR(td_retiring_lnl),
+	EVENT_PTR(td_bad_spec_adl),
+	EVENT_PTR(td_fe_bound_lnl),
+	EVENT_PTR(td_be_bound_lnl),
+	EVENT_PTR(td_heavy_ops_adl),
+	EVENT_PTR(td_br_mis_adl),
+	EVENT_PTR(td_fetch_lat_adl),
+	EVENT_PTR(td_mem_bound_adl),
+	NULL
+};
+
 /* Must be in IDX order */
 EVENT_ATTR_STR_HYBRID(mem-loads,     mem_ld_adl,     "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", hybrid_big_small);
 EVENT_ATTR_STR_HYBRID(mem-stores,    mem_st_adl,     "event=0xd0,umask=0x6;event=0xcd,umask=0x2",                 hybrid_big_small);
@@ -6139,6 +6216,21 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	intel_pmu_ref_cycles_ext();
 }
 
+static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
+{
+	intel_pmu_init_glc(pmu);
+	hybrid(pmu, event_constraints) = intel_lnc_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_lnc_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_rwc_extra_regs;
+}
+
+static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
+{
+	intel_pmu_init_grt(pmu);
+	hybrid(pmu, event_constraints) = intel_skt_event_constraints;
+	hybrid(pmu, extra_regs) = intel_cmt_extra_regs;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -6864,6 +6956,31 @@ __init int intel_pmu_init(void)
 		name = "meteorlake_hybrid";
 		break;
 
+	case INTEL_FAM6_LUNARLAKE_M:
+	case INTEL_FAM6_ARROWLAKE:
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		x86_pmu.get_event_constraints = mtl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+
+		td_attr = lnl_hybrid_events_attrs;
+		mem_attr = mtl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
+
+		pr_cont("Lunarlake Hybrid events, ");
+		name = "lunarlake_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fce06bc24a6a..42a38222c044 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1086,6 +1086,30 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_lnc_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
+
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
+
+	/*
+	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
+	 * need the full constraints from the main table.
+	 */
+
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
 	struct event_constraint *pebs_constraints = hybrid(event->pmu, pebs_constraints);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2fb435fe4970..92df40b8926c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1572,6 +1572,8 @@ extern struct event_constraint intel_icl_pebs_event_constraints[];
 
 extern struct event_constraint intel_glc_pebs_event_constraints[];
 
+extern struct event_constraint intel_lnc_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
 void intel_pmu_pebs_add(struct perf_event *event);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7f1e17250546..400c909b8658 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -307,6 +307,10 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
 #define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
 
+/* TOPDOWN_BAD_SPECULATION.ALL: fixed counter 4 (Atom only) */
+/* TOPDOWN_FE_BOUND.ALL: fixed counter 5 (Atom only) */
+/* TOPDOWN_RETIRING.ALL: fixed counter 6 (Atom only) */
+
 static inline bool use_fixed_pseudo_encoding(u64 code)
 {
 	return !(code & 0xff);
-- 
2.35.1


