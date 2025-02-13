Return-Path: <linux-kernel+bounces-513929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E887A35064
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31743ABC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B04269805;
	Thu, 13 Feb 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdoWaMCO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C0245B1B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481423; cv=none; b=gyVUBKcJkcdCqD+UV2N4rQrfPH4N5lyHIK6LJKiB2XLrpxJTBOAPdyZ/GoonyHtrUjmP4qd2MIv4qSjOw/o4x9WL/A9d9evJgZjzczFjVcbDpw1y4dXTnF22zxt71svyosuFXii3zFB02L2JxDqJ4KOQ+334eExBs5inqWXm1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481423; c=relaxed/simple;
	bh=qUoGhuKtGkdmsBm47uTm7j0cp1wYUb11+UQSSJY+ycM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXl97iKQVMiC+RFrMiI1KOgDHqrkEOmzkjbeQRXuWF4zR3HF04hvwKR8iAZ+eonyLcqAgu/9U+AKh1tQoJJMGEpGPX/3QqUqVSb9LHcHtJ7gai1G4gzTD/tLXb04Y59kcpFqBtGDpIxmoIaptAq4IRL4d/OkeN06DHihG33dKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdoWaMCO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739481421; x=1771017421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUoGhuKtGkdmsBm47uTm7j0cp1wYUb11+UQSSJY+ycM=;
  b=AdoWaMCODmD0/w68veWk15b243Qs7MM8DN5XvDjPtHMSp7Gzr0543OM3
   EfZAGBHTP9bcNO03eTrwincr3gnmHTSxcB9YkVLGl28dmAFK+7S+mBEpZ
   XCbeHc9VmWmc9RAN/342Nx92a2AZ4VG+nK2yhS31N1YTqa8WaqmjX2yrZ
   rjwIr5pTToK/tebT+6XziRz2hR6utWW+tdAiXmkKUtcwHojMJ8iQ7+XLt
   mmZsfUeMUFKhcvznJUNnuQdXTMwp+1Z7fh4couME6pa0rT1vegFxk/Xpj
   dx0fYGyXTnRjaK/vSRuoddBQFHcwUDIOqq5jRgdZFaFkWdKIkoHXsGLSH
   w==;
X-CSE-ConnectionGUID: N/v9DkenQqqYuRnV6jC1ww==
X-CSE-MsgGUID: LMNavWWNQeOnouoAgpr+Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44142398"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44142398"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:16:58 -0800
X-CSE-ConnectionGUID: 1OH+nuhuSXuHn/Th5QR8/Q==
X-CSE-MsgGUID: HK53CHRWQ3iNazhSNynrAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118469491"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2025 13:16:59 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/5] perf/x86: Add dynamic constraint
Date: Thu, 13 Feb 2025 13:17:14 -0800
Message-Id: <20250213211718.2406744-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250213211718.2406744-1-kan.liang@linux.intel.com>
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

More and more features require a dynamic event constraint, e.g., branch
counter logging, auto counter reload, Arch PEBS, etc.

Add a generic flag, PMU_FL_DYN_CONSTRAINT, to indicate the case. It
avoids keeping adding the individual flag in intel_cpuc_prepare().

Add a variable dyn_constraint in the struct hw_perf_event to track the
dynamic constraint of the event. Apply it if it's updated.

Apply the generic dynamic constraint for branch counter logging.
Many features on and after V6 require dynamic constraint. So
unconditionally set the flag for V6+.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  1 +
 arch/x86/events/intel/core.c | 21 +++++++++++++++------
 arch/x86/events/intel/lbr.c  |  2 +-
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 20ad5cca6ad2..b56fa6a9d7a4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -675,6 +675,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
 	event->hw.idx = -1;
 	event->hw.last_cpu = -1;
 	event->hw.last_tag = ~0ULL;
+	event->hw.dyn_constraint = ~0ULL;
 
 	/* mark unused */
 	event->hw.extra_reg.idx = EXTRA_REG_NONE;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f728d2cfdf1c..2df05b18ff04 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3736,10 +3736,9 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
-	/* Not all counters support the branch counter feature. */
-	if (branch_sample_counters(event)) {
+	if (event->hw.dyn_constraint != ~0ULL) {
 		c2 = dyn_constraint(cpuc, c2, idx);
-		c2->idxmsk64 &= x86_pmu.lbr_counters;
+		c2->idxmsk64 &= event->hw.dyn_constraint;
 		c2->weight = hweight64(c2->idxmsk64);
 	}
 
@@ -4141,15 +4140,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		leader = event->group_leader;
 		if (branch_sample_call_stack(leader))
 			return -EINVAL;
-		if (branch_sample_counters(leader))
+		if (branch_sample_counters(leader)) {
 			num++;
+			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
+		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
 		for_each_sibling_event(sibling, leader) {
 			if (branch_sample_call_stack(sibling))
 				return -EINVAL;
-			if (branch_sample_counters(sibling))
+			if (branch_sample_counters(sibling)) {
 				num++;
+				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
+			}
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))
@@ -4949,7 +4952,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_BR_CNTR)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_DYN_CONSTRAINT)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
@@ -6667,6 +6670,12 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/*
+	 * Many features on and after V6 require dynamic constraint,
+	 * e.g., Arch PEBS, ACR.
+	 */
+	if (version >= 6)
+		x86_pmu.flags |= PMU_FL_DYN_CONSTRAINT;
 	/*
 	 * Install the hw-cache-events table:
 	 */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dc641b50814e..743dcc322085 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1609,7 +1609,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_nr = lbr_nr;
 
 	if (!!x86_pmu.lbr_counters)
-		x86_pmu.flags |= PMU_FL_BR_CNTR;
+		x86_pmu.flags |= PMU_FL_BR_CNTR | PMU_FL_DYN_CONSTRAINT;
 
 	if (x86_pmu.lbr_mispred)
 		static_branch_enable(&x86_lbr_mispred);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a698e6484b3b..f4693409e191 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1066,6 +1066,7 @@ do {									\
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
+#define PMU_FL_DYN_CONSTRAINT	0x800 /* Needs dynamic constraint */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d07bc1193f3..c381ea7135df 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -158,6 +158,7 @@ struct hw_perf_event {
 		struct { /* hardware */
 			u64		config;
 			u64		last_tag;
+			u64		dyn_constraint;
 			unsigned long	config_base;
 			unsigned long	event_base;
 			int		event_base_rdpmc;
-- 
2.38.1


