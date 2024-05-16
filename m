Return-Path: <linux-kernel+bounces-180440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C038C6E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CA7282C81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2916FF43;
	Wed, 15 May 2024 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxsjNzfh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C7168AEF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811827; cv=none; b=ZVvNfYqPgaDB3sj68QAUr3D/fei3oFQD3syE++bH4IvgIvDe2EUUQPa4964QPpA/eaOJM3gZ70sBz5M5/3wv7Qh9S3qTFcCIBNgnKq5on93o6vKTKVJ/CvHVl25+dBlgBxmpv431HBY8tgANoDIE2mgalGrDwtsqxU+JDOeNxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811827; c=relaxed/simple;
	bh=fSU/IhXgpOJyls/QfarkH0rpp8nRrImmpe8npptKC9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8dBePt++fTv0I3j7Ae48/yQQygipN1XjjALAgav4cio3V/v8Iq59JXUDYJRBdlXFM0/eSzRRQwXuN5MsR97hHVHhEsjb4Dze4C+Hu6H66DfgIM/YucRQgiN4P0e6fp38jj1gEhny/FGuP5qI//aXzIVxSJMXBbFB5zuXWzPg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxsjNzfh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811825; x=1747347825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSU/IhXgpOJyls/QfarkH0rpp8nRrImmpe8npptKC9I=;
  b=WxsjNzfhhBfcjRd3kXLGEpKKsipL/y98b1uRVr110YXD+xIbkLBY2nNZ
   bCBNzLVIzx4q4CrPZMeL84bR4SF7BKcDCebSWrwmPYv3jCbt2BlYfdx5T
   ukirpLGF3hE2C7rIzHn0QGCtqb9O/FP27isM/qGfINPh674DdJbvAoUAJ
   h2IbQHwaYiThm4S1oBnNUNZpL4SpPPElCvbHSeVYQjv2tT0Xh7s75cXVc
   ULueeVcdpiu9Iljgc7VW+tXgR2wvABMoNaokOO/rIPSObOsGQ/CE/Tg9L
   wN7cR5nsmIcObkyFK5gw+g0AER2gcHmGy5VbGKxZoYfClPwQlXasM6nxP
   A==;
X-CSE-ConnectionGUID: +rMQcfZNQG2P28DIOUctww==
X-CSE-MsgGUID: QUm9XoSRQdGUXAK+Gcf7TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671741"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671741"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:37 -0700
X-CSE-ConnectionGUID: Ut65i30pRe238KXJ7w528w==
X-CSE-MsgGUID: 7MygVZGnQfiSxrisEbeodw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989199"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:37 -0700
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
Subject: [PATCH v18 16/17] x86/resctrl: Sub NUMA Cluster detection and enable
Date: Wed, 15 May 2024 15:23:24 -0700
Message-ID: <20240515222326.74166-17-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515222326.74166-1-tony.luck@intel.com>
References: <20240515222326.74166-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There isn't a simple hardware bit that indicates whether a CPU is
running in Sub NUMA Cluster (SNC) mode. Infer the state by comparing
number CPUs sharing the L3 cache with CPU0 to the number of CPUs in
the same NUMA node as CPU0.

When SNC mode is detected, reconfigure the RMID counters by updating
the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.

Clearing bit zero of the MSR divides the RMIDs and renumbers the ones
on the second SNC node to start from zero.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/msr-index.h   |   1 +
 arch/x86/kernel/cpu/resctrl/core.c | 104 +++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..3cb8dd6311c3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1164,6 +1164,7 @@
 #define MSR_IA32_QM_CTR			0xc8e
 #define MSR_IA32_PQR_ASSOC		0xc8f
 #define MSR_IA32_L3_CBM_BASE		0xc90
+#define MSR_RMID_SNC_CONFIG		0xca0
 #define MSR_IA32_L2_CBM_BASE		0xd10
 #define MSR_IA32_MBA_THRTL_BASE		0xd50
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index dd40c998df72..195f9e29c553 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/resctrl.h>
@@ -753,11 +754,42 @@ static void clear_closid_rmid(int cpu)
 	      RESCTRL_RESERVED_CLOSID);
 }
 
+/*
+ * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
+ * which indicates that RMIDs are configured in legacy mode.
+ * This mode is incompatible with Linux resctrl semantics
+ * as RMIDs are partitioned between SNC nodes, which requires
+ * a user to know which RMID is allocated to a task.
+ * Clearing bit 0 reconfigures the RMID counters for use
+ * in Sub NUMA Cluster mode. This mode is better for Linux.
+ * The RMID space is divided between all SNC nodes with the
+ * RMIDs renumbered to start from zero in each node when
+ * couning operations from tasks. Code to read the counters
+ * must adjust RMID counter numbers based on SNC node. See
+ * __rmid_read() for code that does this.
+ */
+static void snc_remap_rmids(int cpu)
+{
+	u64 val;
+
+	/* Only need to enable once per package. */
+	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
+		return;
+
+	rdmsrl(MSR_RMID_SNC_CONFIG, val);
+	val &= ~BIT_ULL(0);
+	wrmsrl(MSR_RMID_SNC_CONFIG, val);
+}
+
 static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
 	mutex_lock(&domain_list_lock);
+
+	if (snc_nodes_per_l3_cache > 1)
+		snc_remap_rmids(cpu);
+
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
 	mutex_unlock(&domain_list_lock);
@@ -997,11 +1029,83 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+/* CPU models that support MSR_RMID_SNC_CONFIG */
+static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
+	X86_MATCH_VFM(INTEL_ICELAKE_X, 0),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, 0),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, 0),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, 0),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, 0),
+	{}
+};
+
+/*
+ * There isn't a simple hardware bit that indicates whether a CPU is running
+ * in Sub NUMA Cluster (SNC) mode. Infer the state by comparing the
+ * number CPUs sharing the L3 cache with CPU0 to the number of CPUs in
+ * the same NUMA node as CPU0.
+ * It is not possible to accurately determine SNC state if the system is
+ * booted with a maxcpus=N parameter. That distorts the ratio of SNC nodes
+ * to L3 caches. It will be OK if system is booted with hyperthreading
+ * disabled (since this doesn't affect the ratio).
+ */
+static __init int snc_get_config(void)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(0);
+	const cpumask_t	*node0_cpumask;
+	cpumask_t *l3_cpumask = NULL;
+	int i, ret;
+
+	if (!x86_match_cpu(snc_cpu_ids))
+		return 1;
+
+	cpus_read_lock();
+	if (num_online_cpus() != num_present_cpus())
+		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
+	cpus_read_unlock();
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == 3) {
+			if (ci->info_list[i].attributes & CACHE_ID) {
+				l3_cpumask = &ci->info_list[i].shared_cpu_map;
+				break;
+			}
+		}
+	}
+	if (!l3_cpumask) {
+		pr_info("can't get CPU0 L3 mask\n");
+		return 1;
+	}
+
+	node0_cpumask = cpumask_of_node(cpu_to_node(0));
+
+	ret = bitmap_weight(cpumask_bits(l3_cpumask), nr_cpu_ids) /
+	       bitmap_weight(cpumask_bits(node0_cpumask), nr_cpu_ids);
+
+	/* sanity check: Only valid results are 1, 2, 3, 4 */
+	switch (ret) {
+	case 1:
+		break;
+	case 2 ... 4:
+		pr_info("Sub-NUMA cluster detected with %d nodes per L3 cache\n", ret);
+		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
+		break;
+	default:
+		pr_warn("Ignore improbable SNC node count %d\n", ret);
+		ret = 1;
+		break;
+	}
+
+	return ret;
+}
+
 static __init void rdt_init_res_defs_intel(void)
 {
 	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 
+	snc_nodes_per_l3_cache = snc_get_config();
+
 	for_each_rdt_resource(r) {
 		hw_res = resctrl_to_arch_res(r);
 
-- 
2.44.0


