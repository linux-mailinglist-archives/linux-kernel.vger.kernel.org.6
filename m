Return-Path: <linux-kernel+bounces-230975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D4918483
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AA01C208A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34818FC83;
	Wed, 26 Jun 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNPWnHAF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579B187569
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412512; cv=none; b=Px4Cds9Y18Gyl2ZPmxZNd45mVHK0Ub5gIi6aguDBeICypcNAk0Mga/3bkaagHGfSTvCtBUk+ejQN4Gyk60V48SFhvenv/fYXPqLU2UaznimYMHJoIJZvAYvTbxzzP94kFpZxW24d0geC3+tnvjRYu6BvHziT+3FBuwLtzvbJSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412512; c=relaxed/simple;
	bh=0INGDltrUKBi7ASFyKjyNRLw8dzfoyb5WOhCzaJ9g70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zz5r+l5CJQngzLLO6yeeUUC8kMTqRuVdwshWugbu+zmFxQOFIWYsQF9bYbSrOzPFchfJopGFNp4KgsHaF77cVFFXgJhEWkPcRew5qptFnWo7BkdqRHAPxMe4mwEmbm/eLjXEbvq0jazIfKrSdKFQNGL3t6x8/5z+H7mhWt1TsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNPWnHAF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412511; x=1750948511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0INGDltrUKBi7ASFyKjyNRLw8dzfoyb5WOhCzaJ9g70=;
  b=lNPWnHAFsH7tomW+TEKpjlnb/KMPhvxxTnnOZ8mn0uTqfxNgJDkX6W0P
   be4O83/g1Ie8RNNJ7zQso5bkVUISj0MgqAnqn1HwluCVYtYHdohsV5Dar
   kQ1OukBbboF/pDYrvLL5KUWxM+FuBBXidYiZV/nfGg6WBzOmcJZSaJXEf
   9Dr/ezsH1+JAefRC/NaiMSMrR+nnNzbo50NYtZvRGP01cRKryIvWn45FV
   mItxzyor0D1VC+SpaxA29OB6tFFrUdBb7akoMq74fvfIr92QtbN7o+aXW
   l2Nv5i9DPkN4lEz8DWqvBSTWM63dO6ikGE7NACje/aNiqDFxi/y9678qA
   g==;
X-CSE-ConnectionGUID: 1YW+gA/bRym9F01HCZxZBg==
X-CSE-MsgGUID: y0WDC33PSgyWIqN+s9EDOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375551"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375551"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:46 -0700
X-CSE-ConnectionGUID: ihczF5ymTqGvIzTnWbiR0w==
X-CSE-MsgGUID: 0jkFBdafSvKTCPHTVgnNbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911974"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2024 07:34:45 -0700
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
Subject: [PATCH V3 08/13] perf/x86/intel: Support Perfmon MSRs aliasing
Date: Wed, 26 Jun 2024 07:35:40 -0700
Message-Id: <20240626143545.480761-9-kan.liang@linux.intel.com>
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

The architectural performance monitoring V6 supports a new range of
counters' MSRs in the 19xxH address range. They include all the GP
counter MSRs, the GP control MSRs, and the fixed counter MSRs.

The step between each sibling counter is 4. Add intel_pmu_addr_offset()
to calculate the correct offset.

Add fixedctr in struct x86_pmu to store the address of the fixed counter
0. It can be used to calculate the rest of the fixed counters.

The MSR address of the fixed counter control is not changed.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c           |  7 +++----
 arch/x86/events/intel/core.c     | 17 ++++++++++++++++-
 arch/x86/events/perf_event.h     |  7 +++++++
 arch/x86/include/asm/msr-index.h |  6 ++++++
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 842dbf1d706c..12f2a0c14d33 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1236,8 +1236,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		fallthrough;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
-				(idx - INTEL_PMC_IDX_FIXED);
+		hwc->event_base = x86_pmu_fixed_ctr_addr(idx - INTEL_PMC_IDX_FIXED);
 		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) |
 					INTEL_PMC_FIXED_RDPMC_BASE;
 		break;
@@ -1573,7 +1572,7 @@ void perf_event_print_debug(void)
 	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
+		rdmsrl(x86_pmu_fixed_ctr_addr(idx), pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
@@ -2483,7 +2482,7 @@ void perf_clear_dirty_counters(void)
 			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_mask)))
 				continue;
 
-			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+			wrmsrl(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
 		} else {
 			wrmsrl(x86_pmu_event_addr(i), 0);
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9dac918316a6..3cc0f45b9b45 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2953,7 +2953,7 @@ static void intel_pmu_reset(void)
 	for_each_set_bit(idx, fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
+		wrmsrl_safe(x86_pmu_fixed_ctr_addr(idx), 0ull);
 	}
 
 	if (ds)
@@ -5188,6 +5188,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
@@ -5241,6 +5242,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
@@ -6176,6 +6178,11 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
 	}
 }
 
+static inline int intel_pmu_addr_offset(int index, bool eventsel)
+{
+	return MSR_IA32_PMC_V6_STEP * index;
+}
+
 static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
 	{ hybrid_small, "cpu_atom" },
 	{ hybrid_big, "cpu_core" },
@@ -7150,6 +7157,14 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
+	/* Support V6+ MSR Aliasing */
+	if (x86_pmu.version >= 6) {
+		x86_pmu.perfctr = MSR_IA32_PMC_V6_GP0_CTR;
+		x86_pmu.eventsel = MSR_IA32_PMC_V6_GP0_CFG_A;
+		x86_pmu.fixedctr = MSR_IA32_PMC_V6_FX0_CTR;
+		x86_pmu.addr_offset = intel_pmu_addr_offset;
+	}
+
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a226565a9333..8e3f2644a1a3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -787,6 +787,7 @@ struct x86_pmu {
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
 	unsigned	perfctr;
+	unsigned	fixedctr;
 	int		(*addr_offset)(int index, bool eventsel);
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
@@ -1144,6 +1145,12 @@ static inline unsigned int x86_pmu_event_addr(int index)
 				  x86_pmu.addr_offset(index, false) : index);
 }
 
+static inline unsigned int x86_pmu_fixed_ctr_addr(int index)
+{
+	return x86_pmu.fixedctr + (x86_pmu.addr_offset ?
+				   x86_pmu.addr_offset(index, false) : index);
+}
+
 static inline int x86_pmu_rdpmc_index(int index)
 {
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 45ffa27569f4..7eac8f5cea3b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -566,6 +566,12 @@
 #define MSR_RELOAD_PMC0			0x000014c1
 #define MSR_RELOAD_FIXED_CTR0		0x00001309
 
+/* V6 PMON MSR range */
+#define MSR_IA32_PMC_V6_GP0_CTR		0x1900
+#define MSR_IA32_PMC_V6_GP0_CFG_A	0x1901
+#define MSR_IA32_PMC_V6_FX0_CTR		0x1980
+#define MSR_IA32_PMC_V6_STEP		4
+
 /* KeyID partitioning between MKTME and TDX */
 #define MSR_IA32_MKTME_KEYID_PARTITIONING	0x00000087
 
-- 
2.38.1


