Return-Path: <linux-kernel+bounces-234622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0219B91C8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DAB1C21303
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9F13AD04;
	Fri, 28 Jun 2024 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWS2Lfay"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244884FAD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611796; cv=none; b=ZDsR7Dq7GllWIx42oWNEZxz2DpCIPshOI7SAOqKJfYcanM8Q+WmcRRN9Lm4q576MZoDWLh7MmBziujqb/u8REPPrWd9Gn7HgyBtYzDksYDXBirPULi4Mkn8aQnSRPMv+xKL8umZtL6ALKihSWQzPRlXbjRVxquMcBqpeM9pXOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611796; c=relaxed/simple;
	bh=Furc6t8HDNdOr+Vqn7XeiivEWdd2/Lb1p01l7EFsXv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeHOW+tjV1dimVkMrpuB8IPkjDo3IuTX4jkJ9rE128vyi5FnE0cePsojI40wUrASTCfCQUsKfIXMSf5rFb+2lt39JEOnc1BGFsoFKMeJonFBssUZ3GZjIWnpn2jyq4JSiJJ1wi2IAIYhlbWryxsPDKj6RMH2UFjC0TsGbB9O/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWS2Lfay; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611795; x=1751147795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Furc6t8HDNdOr+Vqn7XeiivEWdd2/Lb1p01l7EFsXv4=;
  b=VWS2Lfay0NTcsmqBYH2HehGqNedGq3YpeHo7ySRbCO5+7ekytDDh63xD
   hBZDe95z7oYOIep+E28vzNdU4IJ6/rgOieYsrCQ8xtBBL3vEjP0RaZmfd
   deOCSb1jiTne3k3PSLf0Lo/c1bEHIQWrJ5ylZ3K0nhidaMq1qizIhwHaB
   y2LUzzW4MjOkL9j8k/6RmuoVYIfijKF4ZwFmG7GBImogWWQA+HA1qM1Pt
   iiXJ0nMyFbwLORS75FQPThQ0rwEtbp++LrzUKtITwMMu/R3Ubemen6wZM
   EWcMIKkX87W2gPMPcxscTkT36qI40VLeVXcVqbgRQAwv9Gs06YHJRZhz0
   Q==;
X-CSE-ConnectionGUID: iNtX/D0yQbuxRSf/hC/GBQ==
X-CSE-MsgGUID: Kqn82jHETwS40UPHAQSxpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762577"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762577"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
X-CSE-ConnectionGUID: KBdONxdWTd2QpsIjLWJqBg==
X-CSE-MsgGUID: zGmrPBTpRsGnBWpzOPP3kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065657"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
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
Subject: [PATCH v23 08/19] x86/resctrl: Prepare for new Sub-NUMA Cluster (SNC) monitor files
Date: Fri, 28 Jun 2024 14:56:08 -0700
Message-ID: <20240628215619.76401-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When SNC is enabled monitoring data is collected at the SNC node
granularity, but must be reported at L3-cache granularity for
backwards compatibility in addition to reporting at the node
level.

Add a "ci" field to the rdt_mon_domain structure to save the
cache information about the enclosing L3 cache for the domain.
This provides:

1) The cache id which is needed to compose the name of the legacy
monitoring directory, and to determine which domains should be
summed to provide L3-scoped data.

2) The shared_cpu_map which is needed to determine which CPUs can
be used to read the RMID counters with the MSR interface.

This is the first step to an eventual goal of monitor reporting files
like this (for a system with two SNC nodes per L3):

$ cd /sys/fs/resctrl/mon_data
$ tree mon_L3_00
mon_L3_00			<- 00 here is L3 cache id
├── llc_occupancy		\  These files provide legacy support
├── mbm_local_bytes		 > for non-SNC aware monitor apps
├── mbm_total_bytes		/  that expect data at L3 cache level
├── mon_sub_L3_00		<- 00 here is SNC node id
│   ├── llc_occupancy		\  These files are finer grained
│   ├── mbm_local_bytes		 > data from each SNC node
│   └── mbm_total_bytes		/
└── mon_sub_L3_01
    ├── llc_occupancy		\
    ├── mbm_local_bytes		 > As above, but for node 1.
    └── mbm_total_bytes		/

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/resctrl.h                   | 3 +++
 arch/x86/kernel/cpu/resctrl/core.c        | 7 ++++++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 1 -
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 64b6ad1b22a1..b0875b99e811 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,7 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/cacheinfo.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
@@ -96,6 +97,7 @@ struct rdt_ctrl_domain {
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
+ * @ci:			cache info for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -106,6 +108,7 @@ struct rdt_ctrl_domain {
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
+	struct cacheinfo		*ci;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b86c525d0620..95ef8fe3cb50 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -19,7 +19,6 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
 
 #include <asm/cpu_device_id.h>
@@ -608,6 +607,12 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
 	d->hdr.type = RESCTRL_MON_DOMAIN;
+	d->ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
+	if (!d->ci) {
+		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
+		mon_domain_free(hw_dom);
+		return;
+	}
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
 	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 70f0069b87d8..e69489d48625 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -11,7 +11,6 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d3b0fa958266..70d41a8fd788 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -12,7 +12,6 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
-- 
2.45.2


