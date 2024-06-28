Return-Path: <linux-kernel+bounces-234628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8191C8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B45B25899
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9D1CCCDC;
	Fri, 28 Jun 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpE0RqEB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8A1353FE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611801; cv=none; b=WBDIPAR0SSnoyG/KWy3zq0DsXubqKCcZfMEHOsCCsIeixQgEJyq6Bkk+GHW+owqUWQd5UcxizQtpHB8EiKEzlxtvgyZzYeyyVSehwqNup1/GM2rSA05i+B+rIuOEylvGFPRPwFvXFhMYK6T3M52L72kVmVH9rG+Ng9gfaPJwaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611801; c=relaxed/simple;
	bh=CfUd13hXUBp211uAieRQ2S7KiADlmpT8AQ2V+AKCddE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTm4D8tWsPvuxjBHBA4KQg7wPdapsAXkclZoHM8iCWOtVN11H70jvWPhuUpaGCOveLr7VYmC6uJ/rPx03HPEQQjcP2dVNCeP30ZlaAHFg655Esg4hCF1l/RZiPkp+z6Vq+UjS9WhPPmF+pFyj+Z8WbxHAENfv81jvm/Grgo8RNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpE0RqEB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611799; x=1751147799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CfUd13hXUBp211uAieRQ2S7KiADlmpT8AQ2V+AKCddE=;
  b=fpE0RqEBZe7jVBGswmKN/wv+ikKlqt/bCFvNJw6qmMhGw9yoty0SYOgd
   zhNntXPtEMFFyYBIYImZH8BwW4Jkt1SWtUVHv3oEoWoCohQfyJ6AEG08u
   F46S2nrub9YNr8eJgvKmtFlN9oqzDp6uds51OH9D8mI8FRniBnSC9VkE6
   dEh9KlnYyMHYrhBAk+uwqL0u/FDf7S+6AqC7rTNWjdOi0+Hr3ZAqpsQ3r
   oiVmZ0Ymv5HKWfmElaGnyLYCBgue1wiWw7TJLLvx15sgSQvEkBb8zHLIr
   owQCkhBtfi/7pNl4r97jY5yKYpgyEulC1bpWlOTc0o8nIf5OlfRMF2Mdm
   Q==;
X-CSE-ConnectionGUID: /QUFApHETHi/2W/ojzJpxg==
X-CSE-MsgGUID: MY/VE3v+QPOd5EJjO0WeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762643"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762643"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: DzybmUFFS0iZFhGZKzxiiQ==
X-CSE-MsgGUID: PCitQnJYQcuVyGPREQP4rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065684"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
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
Subject: [PATCH v23 17/19] x86/resctrl: Enable shared RMID mode on Sub-NUMA Cluster (SNC) systems
Date: Fri, 28 Jun 2024 14:56:17 -0700
Message-ID: <20240628215619.76401-18-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
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


