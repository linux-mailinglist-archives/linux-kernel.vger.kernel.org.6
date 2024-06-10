Return-Path: <linux-kernel+bounces-208746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5099028C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543F7281C37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C37150980;
	Mon, 10 Jun 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOXADsDT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790014D2A3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044544; cv=none; b=r5IKZ1niIYrHOzPcF+YQl/i05pGIetxtr7xvn5vhD2F8oRmVKpX8Y1XK8tCK8yyvjoKsITsevzhEy8n6l7oxdGYUmbpn1SYXxmywM7J3BKkxRM4YRfAvE4xSjUAx8F7vUYH6iW27utrE5OCT3aleho5KqN3n/AAfY9+w46qTfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044544; c=relaxed/simple;
	bh=Hhgj5yfzKFjmJ+85+pZGySs3VBA1Tm4DicoEJDqhFj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXZ2QTwidN3dYnKQcq2VOt5YDD9hJAgR+UZJ7LG0O3K2Wo9xdDSs/7cqpQ1u8aOxtcep4AjaklM9UyHIuw4IpnZR8tx/JPE/kW5+BM2lZ0JWNqU/xOwcWv/+loHQibQLvCK9dvqGX5GUdK8n91NVaq0yVWpi9/ko453881rByZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOXADsDT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044542; x=1749580542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hhgj5yfzKFjmJ+85+pZGySs3VBA1Tm4DicoEJDqhFj8=;
  b=iOXADsDTXVrPaoiieoYiEozmSg+MQ29vTZV4+9YA+OwX1qw0g0pGrgOG
   +GnskPCPFUe72XV40R5/GWWkgMm6L0ifHz1W0/DKpbD2DTw3L9Vozp6gB
   fae5J/VMrbccUXrC1SfyBKGv6p0TBQKYEQKLu7mWIw24QMCN8UL6aqjk3
   5PMCP9DpZAKQdGJm+qL3mZ2Iay5N038s6TBkzATKKP1I/5FRZNvLEizUy
   8IrXxvq+AOXSSPA2Ldx73QljxEYpmIQUqDWI0naV/5VJz2dNroun4FhO3
   bUQGF+v8IuIHU8i++XZXdVZybhzJroS4oIT5bgkfeKrKpPMotgmdOe1gt
   g==;
X-CSE-ConnectionGUID: P3PqppPWQtSgxR6lyGByaA==
X-CSE-MsgGUID: Ocrgr9H1SUOFiTXclToykg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12004815"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12004815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
X-CSE-ConnectionGUID: YuB0TZYaQDWK0tvno1HAPQ==
X-CSE-MsgGUID: QnvRpdKaT+2ay9F8nA96wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43576566"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v20 06/18] x86/resctrl: Introduce snc_nodes_per_l3_cache
Date: Mon, 10 Jun 2024 11:35:16 -0700
Message-ID: <20240610183528.349198-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610183528.349198-1-tony.luck@intel.com>
References: <20240610183528.349198-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
and memory controllers on a socket into two or more groups. These are
presented to the operating system as NUMA nodes.

This may enable some workloads to have slightly lower latency to memory
as the memory controller(s) in an SNC node are electrically closer to the
CPU cores on that SNC node. This cost may be offset by lower bandwidth
since the memory accesses for each core can only be interleaved between
the memory controllers on the same SNC node.

Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
to track L3 cache occupancy and memory bandwidth. There is an MSR that
controls how the RMIDs are shared between SNC nodes.

The default mode divides them numerically. E.g. when there are two SNC
nodes on a socket the lower number half of the RMIDs are given to the
first node, the remainder to the second node. This would be difficult
to use with the Linux resctrl interface as specific RMID values assigned
to resctrl groups are not visible to users.

RMID sharing mode divides the physical RMIDs evenly between SNC nodes
but uses a logical RMID in the IA32_PQR_ASSOC MSR. For example a system
with 200 physical RMIDs (as enumerated by CPUID leaf 0xF) that has two
SNC nodes per L3 cache instance would have 100 logical RMIDs available
for Linux to use. A task running on SNC node 0 with RMID 5 would
accumulate LLC occupancy and MBM bandwidth data in physical RMID 5.
Another task using RMID 5, but running on SNC node 1 would accumulate
data in physical RMID 105.

Even with this renumbering SNC mode requires several changes in resctrl
behavior for correct operation.

Add a static global to arch/x86/kernel/cpu/resctrl/monitor.c to indicate
how many SNC domains share an L3 cache instance.  Initialize this to
"1". Runtime detection of SNC mode will adjust this value.

Update all places to take appropriate action when SNC mode is enabled:
1) The number of logical RMIDs per L3 cache available for use is the
   number of physical RMIDs divided by the number of SNC nodes.
2) Likewise the "mon_scale" value must be divided by the number of SNC
   nodes.
3) Add a function to convert from logical RMID values (assigned to
   tasks and loaded into the IA32_PQR_ASSOC MSR on context switch)
   to physical RMID values to load into IA32_QM_EVTSEL MSR when
   reading counters on each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 56 ++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 89d7e6fcbaa1..f2fd35d294f2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -97,6 +97,8 @@ unsigned int resctrl_rmid_realloc_limit;
 
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
+static int snc_nodes_per_l3_cache = 1;
+
 /*
  * The correction factor table is documented in Documentation/arch/x86/resctrl.rst.
  * If rmid > rmid threshold, MBM total and local values should be multiplied
@@ -185,7 +187,43 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
 	return entry;
 }
 
-static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+/*
+ * When Sub-NUMA Cluster (SNC) mode is not enabled (as indicated by
+ * "snc_nodes_per_l3_cache  == 1") no translation of the RMID value is
+ * needed. The physical RMID is the same as the logical RMID.
+ *
+ * On a platform with SNC mode enabled, Linux enables RMID sharing mode
+ * via MSR 0xCA0 (see the "RMID Sharing Mode" section in the "Intel
+ * Resource Director Technology Architecture Specification" for a full
+ * description of RMID sharing mode).
+ *
+ * In RMID sharing mode there are fewer "logical RMID" values available
+ * to accumulate data ("physical RMIDs" are divided evenly between SNC
+ * nodes that share an L3 cache). Linux creates an rdt_mon_domain for
+ * each SNC node.
+ *
+ * The value loaded into IA32_PQR_ASSOC is the "logical RMID".
+ *
+ * Data is collected independently on each SNC node and can be retrieved
+ * using the "physical RMID" value computed by this function and loaded
+ * into IA32_QM_EVTSEL. @cpu can be any CPU in the SNC node.
+ *
+ * The scope of the IA32_QM_EVTSEL and IA32_QM_CTR MSRs is at the L3
+ * cache.  So a "physical RMID" may be read from any CPU that shares
+ * the L3 cache with the desired SNC node, not just from a CPU in
+ * the specific SNC node.
+ */
+static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	if (snc_nodes_per_l3_cache  == 1)
+		return lrmid;
+
+	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+}
+
+static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *val)
 {
 	u64 msr_val;
 
@@ -197,7 +235,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, prmid);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
@@ -233,14 +271,17 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     enum resctrl_event_id eventid)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
+	u32 prmid;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		memset(am, 0, sizeof(*am));
 
+		prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 		/* Record any initial, non-zero count value. */
-		__rmid_read(rmid, eventid, &am->prev_msr);
+		__rmid_read_phys(prmid, eventid, &am->prev_msr);
 	}
 }
 
@@ -275,8 +316,10 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
+	u32 prmid;
 	int ret;
 
 	resctrl_arch_rmid_read_context_check();
@@ -284,7 +327,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
 		return -EINVAL;
 
-	ret = __rmid_read(rmid, eventid, &msr_val);
+	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
+	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 	if (ret)
 		return ret;
 
@@ -1022,8 +1066,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	int ret;
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
-	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
+	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
-- 
2.45.0


