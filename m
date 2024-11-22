Return-Path: <linux-kernel+bounces-418870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9119D6685
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B630161120
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6051DF98E;
	Fri, 22 Nov 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrDkSLMC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71E1D3564;
	Fri, 22 Nov 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319923; cv=none; b=qrwOV9LSXj8CxwD69kVDI/31D/4i/QoL3jcaoPzIrSThCWq0qxV7BMUHQ/DZ3kF/YCyDvUBGq2BoNNaAIILO52bk8ETg8WyWyzNpTy35W3LZKShSa+RB6uUQCP9xfTm8ZSW7/MpaDxW2Be+QFwQVZp1DwVkt2b3W5MoWB58gMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319923; c=relaxed/simple;
	bh=80SJws0Hb0cg3maKZlhIw9vkNKd0N1ngxiJHAJ8H6KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ktfl5bwVFfOUGhIbHLT04KyO8lbnCpVJJNeGCalEJVEAEczyQtPSNqjoXUGyG2YovzisfCa2p62V2LqN1DaH1eY3BGwYWZZGuzY4MuCzlBFl3rPoeLZk7Lr6ceTafsX6aq6NqIk4d5YJ6vv73QHx5siuifusMYxWUUxyIo2hWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrDkSLMC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732319922; x=1763855922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80SJws0Hb0cg3maKZlhIw9vkNKd0N1ngxiJHAJ8H6KI=;
  b=HrDkSLMC1RHk1AGMqJnsDjW/Nryr39MqYHDqs3xqXWDivlwYY7gSZbcu
   7m3F4zfDJZxaTBJTqn7Ec59tSVhmPyD5H2S0yEaIFlveO30f+VkBpjd2o
   zgnH/iL+W7WeDHM6OXC5rsAZ4dVHdMgDg68EMB4/1VaXG5zx65tgd8xmp
   /Go5FMnTdap+1My/GrMR5NLdqHWBDspOGEJMWJ7Iv1oOQdzdtQYAJKuI1
   EOaT55ARXS4JJeR/4wVRKLG2Co6SatDYTxgPqCn06DFLOpDs7TocnFX2B
   o3xWWsdd1QvUhtVqSZMBDlSSEDeKTLWqjq9Rcb7W1qxL7eRwa99qxyBv0
   g==;
X-CSE-ConnectionGUID: 6nFFMwyMR7a2FIxWpgxVsA==
X-CSE-MsgGUID: HWPCAyVGSim6HWJ2q2HGXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32642744"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="32642744"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:40 -0800
X-CSE-ConnectionGUID: ZbB1NTZ/Ty2SwuWufgOqIQ==
X-CSE-MsgGUID: UEdOp2qpQeG88vTRvY+vFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="90850911"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:39 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 6/8] x86/resctrl: Add "mba_MBps_event" file to CTRL_MON directories
Date: Fri, 22 Nov 2024 15:58:30 -0800
Message-ID: <20241122235832.27498-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122235832.27498-1-tony.luck@intel.com>
References: <20241122235832.27498-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "mba_MBps" mount option provides an alternate method to
control memory bandwidth. Instead of specifying allowable
bandwidth as a percentage of maximum possible, the user
provides a MiB/s limit value.

In preparation to allow the user to pick the memory bandwidth
monitoring event used as input to the feedback loop, provide
a file in each CTRL_MON group directory that shows the event
currently in use. Note that this file is only visible when
the "mba_MBps" mount option is in use.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 30 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 10 ++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 485800055a7d..ce10a883ecf8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -609,6 +609,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain *d,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 200d89a64027..5fa37b4ecc7a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -518,6 +518,36 @@ static int smp_mon_event_count(void *arg)
 	return 0;
 }
 
+int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+
+	if (rdtgrp) {
+		switch (rdtgrp->mba_mbps_event) {
+		case QOS_L3_MBM_LOCAL_EVENT_ID:
+			seq_puts(s, "mbm_local_bytes\n");
+			break;
+		case QOS_L3_MBM_TOTAL_EVENT_ID:
+			seq_puts(s, "mbm_total_bytes\n");
+			break;
+		default:
+			pr_warn_once("Bad event %d\n", rdtgrp->mba_mbps_event);
+			ret = -EINVAL;
+			break;
+		}
+	} else {
+		ret = -ENOENT;
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 98d27199c2fe..22265d3e238a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1952,6 +1952,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_schemata_show,
 		.fflags		= RFTYPE_CTRL_BASE,
 	},
+	{
+		.name		= "mba_MBps_event",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mba_mbps_event_show,
+	},
 	{
 		.name		= "mode",
 		.mode		= 0644,
@@ -2357,6 +2363,7 @@ static int set_mba_sc(bool mba_sc)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rdt_ctrl_domain *d;
+	unsigned long fflags;
 	int i;
 
 	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
@@ -2371,6 +2378,9 @@ static int set_mba_sc(bool mba_sc)
 			d->mbps_val[i] = MBA_MAX_MBPS;
 	}
 
+	fflags = mba_sc ? RFTYPE_CTRL_BASE | RFTYPE_MON_BASE : 0;
+	resctrl_file_fflags_init("mba_MBps_event", fflags);
+
 	return 0;
 }
 
-- 
2.47.0


