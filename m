Return-Path: <linux-kernel+bounces-232978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D491B0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89A91C22269
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB071AAE38;
	Thu, 27 Jun 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abTwcZ6g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8F1A2FDA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520761; cv=none; b=EHCZNs2CnKfD+fJnJqR20va3w/3skeCTv1wpYiuug7fDFv8QCzmRRqL3iRpj6yXCWvgc47PoKAfSyP7AN646Ee6caulv9LCcB/JudzlAoJ7ZMEBgZYSbLzlxgzLE4Os2n5XWSMOXpbNMrFAZLMjbAHftWOBn8xeLwr29HnZp7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520761; c=relaxed/simple;
	bh=CfUd13hXUBp211uAieRQ2S7KiADlmpT8AQ2V+AKCddE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9/rgJOija6o8+AdkfsKuzvIqBx9HCuJPrsqqNZQX32K3A90EJ1BJdt+mOpDdeksleGWUGyKjij3Q9bxAweagtbQqCto75b/1D5zpLZ9UsEagD21KFDM4ZWxBBcWFzjoU3iRzmX7Gf9IEYNuQy4Y9MMLh+xsoBQJ9S7fvVqiqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abTwcZ6g; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719520760; x=1751056760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CfUd13hXUBp211uAieRQ2S7KiADlmpT8AQ2V+AKCddE=;
  b=abTwcZ6g/hBgVl+JzmqDGekBFurEdxSfB7wgGsBWnKorCj13oYFvOieA
   xxrYcGTgQFumb289S26MiaS9KHlMaxjWSbVnBFEHkMtxe+LEOQbhGFzTQ
   Gwkzl5NINQx5hJTKOYVcRIkwLO5PvbzoBL2H5Tocl41LcJKymcoUjhUf+
   aUBaYBx7W84H3KlHvkzXI30/yb6O++BdX8M501gOH9+OCEsMe7o8S0Bt7
   Z8rDlKPZzqaFGnIIMgjxWPeJF6RDFe5KF7I0H444h+LRp1VK+1/K8YijR
   vzFcVa6f1EDdnV2DUmyEd8RGIOoosy8J0Nb6G4Xfjev3RTsNor2z/TTPh
   g==;
X-CSE-ConnectionGUID: d6pMchmGTdWvndO3cBnFPA==
X-CSE-MsgGUID: PUhDufdoQyqATdVZjnFEBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16809850"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16809850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:11 -0700
X-CSE-ConnectionGUID: LpXVDhnbSqe60lUXsGgMgA==
X-CSE-MsgGUID: gpfejimFSqq420VVan0R4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="82052925"
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
Subject: [PATCH v22 16/18] x86/resctrl: Enable shared RMID mode on Sub-NUMA Cluster (SNC) systems
Date: Thu, 27 Jun 2024 13:38:54 -0700
Message-ID: <20240627203856.66628-17-tony.luck@intel.com>
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

Hardware has two RMID configuration options for SNC systems. The default
mode divides RMID counters between SNC nodes. E.g. with 200 RMIDs and
two SNC nodes per L3 cache RMIDs 0..99 are used on node 0, and 100..199
on node 1. This isn't compatible with Linux resctrl usage. On this
example system a process using RMID 5 would only update monitor counters
while running on SNC node 0.

The other mode is "RMID Sharing Mode". This is enabled by clearing bit
0 of the RMID_SNC_CONFIG (0xCA0) model specific register. In this mode
the number of logical RMIDs is the number of physical RMIDs (from CPUID
leaf 0xF) divided by the number of SNC nodes per L3 cache instance. A
process can use the same RMID across different SNC nodes.

See the "Intel Resource Director Technology Architecture Specification"
for additional details.

When SNC is enabled, update the MSR when a monitor domain is marked
online. Technically this is overkill. It only needs to be done once
per L3 cache instance rather than per SNC domain. But there is no harm
in doing it more than once, and this is not in a critical path.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 26 ++++++++++++++++++++++++++
 4 files changed, 31 insertions(+)

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
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 16982d1baf99..955999aecfca 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -534,6 +534,8 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
+void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 95ef8fe3cb50..1930fce9dfe9 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -615,6 +615,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	}
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
+	arch_mon_domain_online(r, d);
+
 	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ca486d00541e..2d9b0bad678d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1090,6 +1090,32 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
+/*
+ * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
+ * which indicates that RMIDs are configured in legacy mode.
+ * This mode is incompatible with Linux resctrl semantics
+ * as RMIDs are partitioned between SNC nodes, which requires
+ * a user to know which RMID is allocated to a task.
+ * Clearing bit 0 reconfigures the RMID counters for use
+ * in RMID sharing mode. This mode is better for Linux.
+ * The RMID space is divided between all SNC nodes with the
+ * RMIDs renumbered to start from zero in each node when
+ * counting operations from tasks. Code to read the counters
+ * must adjust RMID counter numbers based on SNC node. See
+ * logical_rmid_to_physical_rmid() for code that does this.
+ */
+void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d)
+{
+	u64 val;
+
+	if (snc_nodes_per_l3_cache == 1)
+		return;
+
+	rdmsrl(MSR_RMID_SNC_CONFIG, val);
+	val &= ~BIT_ULL(0);
+	wrmsrl(MSR_RMID_SNC_CONFIG, val);
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
-- 
2.45.2


