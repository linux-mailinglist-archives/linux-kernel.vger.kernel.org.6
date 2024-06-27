Return-Path: <linux-kernel+bounces-232979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6991B0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C01C21998
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB151AB526;
	Thu, 27 Jun 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8BcyJ6Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F01A38E1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520762; cv=none; b=F4xQ6F81UzL0U4P8NEjZubmtK47WSmuRg9hPza9XxOrnQw+VZ8B0743DDKBXymKP6U+vAvtGd6IC0MQy1XmeQA7SMRhx9sJ174XpdO0ocD0030+FJsKeZBqkcfV8lUxPBnjDPVoFRRRCAyLDdvE50oivennrnVIAmA9AKEtEi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520762; c=relaxed/simple;
	bh=vM+3tzSSnqnmtLQ7I5Kq1E3nWSgcu98rwL7vm2afEB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkI/D7FumC7zP2TvvuP6D9c9tzzld7WsCBCL0pvzNxVP/NTnKDarPpMo14PkvLrWl2yRDeTjntFJOaM5c2EzpDx1mXEgcXey+9+cyA2c1kVlOp05vlc8GBxYX0/bYewquGdw84SXMjtWaS3qpuAbg59jU6vA8KrVkHWMcKKbmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8BcyJ6Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719520761; x=1751056761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vM+3tzSSnqnmtLQ7I5Kq1E3nWSgcu98rwL7vm2afEB0=;
  b=Q8BcyJ6QblBpY6tSnZGKwLPm2R3zR+9szIlmEHUBgTUUcW2T5T5GtuWm
   ztiMPgxAmfhIx153pMXed8EtTh6DNz5cLstrAOEgWvCHNk+O0HZCC49T0
   ANsZRlDbp7XVYM48J81+NGGbILOTDd7gDUkJ4ZXMjAPeAK8K2XFoHWf/C
   BQRSE2QUbwfDlMeeFcfNHD6ZJfJZYcX11UzkOQG2Qa2MtYQWLh2KHi1ng
   ASpTLg8H1zkGC/VdCWqj3qjGZ6XndeTyGRfBnwCtF/zlOD7pHU4xPHOGX
   gzfRnqMpDEItLK3WhOdHeQDlNDhlOk+pFr8sEaLtPjOGNxH4m04wSjaSr
   g==;
X-CSE-ConnectionGUID: qzcXzUyhT9uxR/GOCtrWfQ==
X-CSE-MsgGUID: Ki8MrG79RuGjrZRnH9L6jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16809857"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16809857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:11 -0700
X-CSE-ConnectionGUID: wS085McKTgSLLW5jSA4S2Q==
X-CSE-MsgGUID: +DQpOxQdQdCBL60aMhTX0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="82052929"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:11 -0700
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
Subject: [PATCH v22 17/18] x86/resctrl: Sub-NUMA Cluster (SNC) detection
Date: Thu, 27 Jun 2024 13:38:55 -0700
Message-ID: <20240627203856.66628-18-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627203856.66628-1-tony.luck@intel.com>
References: <20240627203856.66628-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There isn't a simple hardware bit that indicates whether a CPU is
running in Sub-NUMA Cluster (SNC) mode. Infer the state by comparing
the number of CPUs sharing the L3 cache with CPU0 to the number of CPUs in
the same NUMA node as CPU0.

If SNC mode is detected, print a single informational message to the
console.

Add the missing definition of pr_fmt() to monitor.c. This wasn't
noticed before as there are only "can't happen" console messages
from this file.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2d9b0bad678d..00e5c0e5424f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -15,6 +15,8 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
 
+#define pr_fmt(fmt)	"resctrl: " fmt
+
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
@@ -1116,6 +1118,68 @@ void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d)
 	wrmsrl(MSR_RMID_SNC_CONFIG, val);
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
+ * in Sub-NUMA Cluster (SNC) mode. Infer the state by comparing the
+ * number of CPUs sharing the L3 cache with CPU0 to the number of CPUs in
+ * the same NUMA node as CPU0.
+ * It is not possible to accurately determine SNC state if the system is
+ * booted with a maxcpus=N parameter. That distorts the ratio of SNC nodes
+ * to L3 caches. It will be OK if system is booted with hyperthreading
+ * disabled (since this doesn't affect the ratio).
+ */
+static __init int snc_get_config(void)
+{
+	struct cacheinfo *ci = get_cpu_cacheinfo_level(0, RESCTRL_L3_CACHE);
+	const cpumask_t *node0_cpumask;
+	int cpus_per_node, cpus_per_l3;
+	int ret;
+
+	if (!x86_match_cpu(snc_cpu_ids) || !ci)
+		return 1;
+
+	cpus_read_lock();
+	if (num_online_cpus() != num_present_cpus())
+		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
+	cpus_read_unlock();
+
+	node0_cpumask = cpumask_of_node(cpu_to_node(0));
+
+	cpus_per_node = cpumask_weight(node0_cpumask);
+	cpus_per_l3 = cpumask_weight(&ci->shared_cpu_map);
+
+	if (!cpus_per_node || !cpus_per_l3)
+		return 1;
+
+	ret = cpus_per_l3 / cpus_per_node;
+
+	/* sanity check: Only valid results are 1, 2, 3, 4 */
+	switch (ret) {
+	case 1:
+		break;
+	case 2 ... 4:
+		pr_info("Sub-NUMA Cluster mode detected with %d nodes per L3 cache\n", ret);
+		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_L3_NODE;
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
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
@@ -1123,6 +1187,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	unsigned int threshold;
 	int ret;
 
+	snc_nodes_per_l3_cache = snc_get_config();
+
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
 	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
-- 
2.45.2


