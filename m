Return-Path: <linux-kernel+bounces-359909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08C99924B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C372852FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A331CFEC4;
	Thu, 10 Oct 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="go5iZFeL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C021CDA31
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588456; cv=none; b=qyQZtW4qBH3bkHoHolTl2WWHtBgzAYytTgIF2HBsDk7+xfbBxSE229HNBc6N0JUIWa0J6okGUP6xG3vrT7M2fhVOqCf4gx6PvgX5J1wCYGEAAsjC4JCO5YkndryMi/Ds2Mi+WnVWhNhP6A8+kU8cxS2ECL5o06LRLBs4TMUIF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588456; c=relaxed/simple;
	bh=lNTkdB1PAh6XUX6/HZeAOmeklFsqdPTTVfSlVDiMCvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0smw1Latk6UUa9IgIH9DQgsvRxn/HitVlCiCdjPF5Y6MDSg/vdoBsir4vPizSoshXeREqRqv8sCNpKzWdoe+Hm/v5im6I95B4+VepqgiQan3vPpwhF5vvGRL1uCw7itvVBn+x4mMI/oSQE1l8KoTfpX/GfKvuVB+nEFfA3ud/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=go5iZFeL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728588454; x=1760124454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNTkdB1PAh6XUX6/HZeAOmeklFsqdPTTVfSlVDiMCvk=;
  b=go5iZFeLhTixe6U1TZmpuG6UlKpZNfiNUUS+WsCNmWXRDa0JJQO2+aJo
   G87ATBHVca+7fwP7uhpHNr1Q2XIkyPfUtWBOwTtg/1GE1iTHBcxa1gt8P
   GyvJsJrmIqX7ik3LUXdHMAX3KIrvO/DfeoD7XHpSXtErICDxuBJvNngiM
   jwa47MfWGqac376kmty+R+eBCIDqj9Qr4QrSO6LgmrFh7qwSDOoWwTR3G
   KyyyrA717QMY+zLu6lWo34283v0cuJ2R2539cppELfGPH3JzGeUwxP0/M
   1td5N3XnsjzwqbPkoZ4NnP1DH9rmPDUCYp0VSqmvqZlVCtEz7Rc4+MQgM
   g==;
X-CSE-ConnectionGUID: DFQ7CdCVQI2bFix9+38/Yw==
X-CSE-MsgGUID: dSI6SdrJQlakEKqPl6rh/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31870241"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31870241"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 12:27:31 -0700
X-CSE-ConnectionGUID: 62Kyv+WESn6v4zx2slFEgA==
X-CSE-MsgGUID: PkTZf3N9RPy/GDlD5Hat9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76614761"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2024 12:27:31 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	ak@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/3] perf/x86/intel: Add the enumeration and flag for the auto counter reload
Date: Thu, 10 Oct 2024 12:28:43 -0700
Message-Id: <20241010192844.1006990-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241010192844.1006990-1-kan.liang@linux.intel.com>
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
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
index 2f3bf3bbbd77..726ef13c2c81 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4775,7 +4775,8 @@ static struct intel_excl_cntrs *allocate_excl_cntrs(int cpu)
 	return c;
 }
 
-
+#define PMU_FL_DYN_MASK		(PMU_FL_EXCL_CNTRS | PMU_FL_TFA |	\
+				 PMU_FL_BR_CNTR | PMU_FL_ACR)
 int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
@@ -4786,7 +4787,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_BR_CNTR)) {
+	if (x86_pmu.flags & PMU_FL_DYN_MASK) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
@@ -4893,6 +4894,18 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
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
index 82c6f45ce975..1ee6d7bb10a3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -718,6 +718,12 @@ struct x86_hybrid_pmu {
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
@@ -815,6 +821,11 @@ struct x86_pmu {
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
@@ -1059,6 +1070,7 @@ do {									\
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
+#define PMU_FL_ACR		0x800 /* Support auto-counter reload */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 41ace8431e01..19af3d857db3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -191,6 +191,8 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
+#define ARCH_PERFMON_ACR_LEAF_BIT		0x2
+#define ARCH_PERFMON_ACR_LEAF			BIT(ARCH_PERFMON_ACR_LEAF_BIT)
 
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
-- 
2.38.1


