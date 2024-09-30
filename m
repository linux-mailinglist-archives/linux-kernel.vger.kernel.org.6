Return-Path: <linux-kernel+bounces-344380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421EB98A8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665201C20C83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF155192D73;
	Mon, 30 Sep 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akiiHeQp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F191925B8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710878; cv=none; b=I2j3vdc6cRrPOB8hEtL7+zBPJGIe2UjCK6spWcMmCKsaSX51KSI45JnP9/6oz61YzIQkLQFHO4YXJaSccIVyo4J1rCinBjG/kIM8k3c32LQ6VQGVtjY1Xv9SRL4qgEhqkAKDrY8ipoTy0zlLZBgP36AUQHY3a5+M8dG00+RIbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710878; c=relaxed/simple;
	bh=vIlrXkYiHs7cpaJVrNPgXxjpvIaLufael44vAFV0iTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgwpG04k5VA/19Cg00WTaJ8pPRlRjmOgHAF0mV38YLWa/qbbO/Y8F4vQmCAurUvQP7uCTq0WkNIjNwXgHWDLKdOZ0ooZfk1sx40DeEJU1VNUbXmX2Hmp7glX41xX1q1UEqcu+M5hLQhHmTMe/v+n0HSIInGiGbfb4jPwsmeDE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akiiHeQp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727710876; x=1759246876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vIlrXkYiHs7cpaJVrNPgXxjpvIaLufael44vAFV0iTY=;
  b=akiiHeQpHbkEQd3fiqdVZXSACvaJGba53egcBpCaJNoxySCBfP1iFbQA
   rBBapAZ+WUG7mflB5vGJI2DxNqXqHx3CJMiuRrRf6+w6wOYYJDG186I8s
   MzsZc/n1V6GS8PD2jAvCoQa5h5/Se3Ak0qqsy+yLJHb03HRrE0XIWssI1
   8StzvjMPOpUpLXcnO6RhjXzkdluTlRqH0zIdiLyszajK5RAI4z+MV2pT5
   KvHh4pleAwAoLzlyTXyT0H9eL0qsm1cPL5BnAaPV5Rc9/9dgNn/BwA1ae
   b+4CmkpQWB7oTj9QAehUmZJjfplU/qT9KUSbG5dAiEufy01k/sKzhTxXt
   Q==;
X-CSE-ConnectionGUID: syL9FAHxSbOqcjw4AOdQNA==
X-CSE-MsgGUID: l45FEbZSQxyLxR7Peq5asw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26272162"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26272162"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 08:41:13 -0700
X-CSE-ConnectionGUID: x9UWJ4WKT9KPCWBNnfvSaw==
X-CSE-MsgGUID: LDtQUVdyTQakDC/mL/tckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78172481"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 30 Sep 2024 08:41:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	ak@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf/x86/intel: Add the enumeration and flag for the auto counter reload
Date: Mon, 30 Sep 2024 08:41:21 -0700
Message-Id: <20240930154122.578924-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240930154122.578924-1-kan.liang@linux.intel.com>
References: <20240930154122.578924-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The counters that support the auto counter reload feature can be
enumerated in the CPUID Leaf 0x23 sub-leaf 0x2.

Add acr_cntr_mask to store the mask of counters which are reloadable.
Add acr_cntr_cause_mask to store the mask of counters which can cause
reload. Since the e-core and p-core may have different numbers of
counters, track the masks in the struct x86_hybrid_pmu as well.

The Auto Counter Reload feature requires a dynamic constraint. Add a PMU
flag to allocate the constraint_list.

There are many existing features which require a dynamic constraint as
well. Add a PMU_FL_DYN_MASK to include the flags of all the features.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 17 +++++++++++++++--
 arch/x86/events/perf_event.h      | 12 ++++++++++++
 arch/x86/include/asm/perf_event.h |  2 ++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 123ed1d60118..57e4dc0a7b23 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4789,7 +4789,8 @@ static struct intel_excl_cntrs *allocate_excl_cntrs(int cpu)
 	return c;
 }
 
-
+#define PMU_FL_DYN_MASK		(PMU_FL_EXCL_CNTRS | PMU_FL_TFA |	\
+				 PMU_FL_BR_CNTR | PMU_FL_ACR)
 int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
@@ -4800,7 +4801,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_BR_CNTR)) {
+	if (x86_pmu.flags & PMU_FL_DYN_MASK) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
@@ -4907,6 +4908,18 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 		pmu->fixed_cntr_mask64 = ebx;
 	}
 
+	if (sub_bitmaps & ARCH_PERFMON_ACR_LEAF) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF_BIT,
+			    &eax, &ebx, &ecx, &edx);
+		/* The mask of the counters which can be reloaded */
+		pmu->acr_cntr_mask64 = eax | ((u64)ebx << INTEL_PMC_IDX_FIXED);
+
+		/* The mask of the counters which can cause a reload of reloadable counters */
+		pmu->acr_cntr_cause_mask = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+
+		x86_pmu.flags |= PMU_FL_ACR;
+	}
+
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 31c2771545a6..c7bde9cee699 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -719,6 +719,12 @@ struct x86_hybrid_pmu {
 			u64		fixed_cntr_mask64;
 			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	};
+
+	union {
+			u64		acr_cntr_mask64;
+			unsigned long	acr_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	u64				acr_cntr_cause_mask;
 	struct event_constraint		unconstrained;
 
 	u64				hw_cache_event_ids
@@ -816,6 +822,11 @@ struct x86_pmu {
 			u64		fixed_cntr_mask64;
 			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	};
+	union {
+			u64		acr_cntr_mask64;
+			unsigned long	acr_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	u64				acr_cntr_cause_mask;
 	int		cntval_bits;
 	u64		cntval_mask;
 	union {
@@ -1060,6 +1071,7 @@ do {									\
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
+#define PMU_FL_ACR		0x800 /* Support auto-counter reload */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1d4ce655aece..814a3ca69452 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -192,6 +192,8 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
+#define ARCH_PERFMON_ACR_LEAF_BIT		0x2
+#define ARCH_PERFMON_ACR_LEAF			BIT(ARCH_PERFMON_ACR_LEAF_BIT)
 
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
-- 
2.38.1


