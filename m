Return-Path: <linux-kernel+bounces-316047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EF96CA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0B428BF2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C7188A11;
	Wed,  4 Sep 2024 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bWOxYqy0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D018179967;
	Wed,  4 Sep 2024 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488655; cv=fail; b=e05wFBwDUDyaRWMjxic2TGQabe5jszL1LHctfbmMhvCjNkNBPyyO5J82Uf0gBolOYQ2juO9+yCpsqlStvZGKHO3cjbCXza9HOWFFKf3TShm+BNBFji8x6zHTN4K6kXHToa8XXoSCQGXM/KvzPc4MWCRRzdSka8qxQB7QqoQp6kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488655; c=relaxed/simple;
	bh=HoYZ2l6//7hWVD2eVyvGthL0tHwVnNiRS4AeoaLCyRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce8FuhGVBmHClrFcwsV+6J24FzG2F+0Bjh8fhXY4KDUjZvXoSKRPrUsEoX1GrEr6MxO+aSnACvHnbQ0ri9THcMmG9soNPyewHSxgdhNiLeTe4tvPF9dNNXaM+xFzadKTIhkyMWm2QeWzXRZNn7lGCZ+VK0lNDmCjAI5yHoiaIdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bWOxYqy0; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8PyZZDHrEmVg9z1DnaO/qclEgDPOmb43Drlw3lrtJ6rosahLfDV+XPoH2vz2+RD89hFDEhaw1Rmq1jXI1EguMj2FhVW+79U3HCz6mtX1f+5AIOsfZ80AQFYczzqJtZNs1GOTflUcbaeBxDKFiH3y58h/cg6+FmBd7D4UCoKx/tK+Um9Ilm0/+bmeOixZC3+WSZ64666ndMQSm0yuLedY2XTHRMdGCrlgFO83TRezamfRYLONt1f8wEDgcKjgxVeuPERG4PRUL2ofiuBQyZ7dMW/lTWIIU9P2RhryKPMHr54Rxf4oRLZag0E/V41mO2eVlmDipeBSbULfQ3u8qqXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRa7ltoiNNRPbLJg0M2XFlqRYQ/nYu+XdwufALuYdQc=;
 b=CbqkYLGGjl+eIcJDhNsuKn7u6OuNeNm9vTYuc4r056iHLaRo4FkD74kCKMxSyJ+wjOKTQjSDbgDy4vI/GzwisRHwMmqoe3/TrJWHRtu3ew6m9VrYQUAzxu5EVOPfyIfCONQnwOaT7/jPHtBEj8Md0M4sLUZ61R/mfRsgXdlf+cr5MYSXvMt7yTivfOJ/AYATgWcEGMKw8sL2opFGFxKKyzoqScD005mSUleLF1GPdijHdWnkoUvIso3mC/ZP0AmRVrDwK9F2czyLAcHhbg0jYJc23DhAch+ZsDMRvoi6pwxtE4O7t0SIPgJcdC3hPqUS+IzMueRB0DFaLmkDO92vww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRa7ltoiNNRPbLJg0M2XFlqRYQ/nYu+XdwufALuYdQc=;
 b=bWOxYqy0zTUQeriNiCFKUrQkvbhipMAY5vaieYPi3V0I0pnKwRbzpo/16BcSiWB0PvFiAWyeAJ9Rd2WBCay3HFyz6YRwYcI12HvK7sP9TWsy1XciZojR3ZszuProZkhuxURCaR2dxeLy4K2s3Kqw2qsTWFRq9SA3I+CQm9hAGMs=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 22:24:11 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::75) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:09 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v7 18/24] x86/resctrl: Auto Assign/unassign counters when mbm_cntr_assign is enabled
Date: Wed, 4 Sep 2024 17:21:33 -0500
Message-ID: <5b02b069cfd7fc3ca30b1e17644d0ec73df7cef1.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 519fd201-5132-42cd-74f7-08dccd304cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0c2HKE17cDJu87LK8hwDTX3GtWy/6eSx0t010oUNtYuToHyV8sYPEaZUeIFO?=
 =?us-ascii?Q?WQjWGgid3MgaToZvxagvJZThowW7pbh0BDuh+zLyzrJGZwSSVq/cDRR0fAfl?=
 =?us-ascii?Q?PZiWb/Sn8L2gp1lcaWqTfy0ai2CEFWnOnf+KW4hKYUJuN9yZJ5kS/XfxFJ1A?=
 =?us-ascii?Q?GZ2DFbVenXHym64Ek4IFSz40gDLzBOcqnTggXtQWTFn9/1ruj1l+8ZASiDA5?=
 =?us-ascii?Q?W5k3lETHoGIUe/kQC+s0DlQfhTc7OGPKDk4Rj2KOTpXYd/SsxUZePK64Gxok?=
 =?us-ascii?Q?FNHvh/z4FfDZjOXzmq5fiY0IvLCm7W+Z1efBXl4PKNsz07EHH/gEp613PuBP?=
 =?us-ascii?Q?1OhJMliSNbZW3iO8idM9QXr7WeX+0xjXYGyxHuBvh0NRpYgI6k7b7bGvDeUz?=
 =?us-ascii?Q?KKqwJCCCfbQF4iuWPgj32rte7KqjSs+imOrJWZCugi4EKuwxwX371X24GaMT?=
 =?us-ascii?Q?BTEXcsmhnjk8bDbB3rbCh9zQhVRGZryRxVwTWb00kykWMRQkoM7c8+D2eQip?=
 =?us-ascii?Q?JFPtIzCQmSRBt9iPS7JDXpu2d1WBKKSRJM3KNE5EeLWrI/LvrMy6IEJmGpo7?=
 =?us-ascii?Q?s2DiHuTt4jC9TuJhd+ckfYBlcd59r4EeKzIiAjxcRXnwPAC+GAnVKSZLNk5x?=
 =?us-ascii?Q?w6bsUzGR2ZNpifyUKCDE5OWRa9Pvz4wLAE0oUeJS6OqT14FELXL0vM9K3J96?=
 =?us-ascii?Q?BEKKUuF/Ryre7B35HmYKJK32WT8midt+1mw9BEjWnUYpge0iXpjrT9ilj/nx?=
 =?us-ascii?Q?W3y3QhvYJM/KloJ8N+bybUL/pNTiYDpALCf145u0jGKmaejqtIBClpZfOxDn?=
 =?us-ascii?Q?TNvGPyd9SkVqOEZdZv+WoS9XFNA5YUrNbNXfwEmIAoSUNidNelFWRkYz43pc?=
 =?us-ascii?Q?IE0eceycih75TnkbXa/qcOXPXsRecCam44JbM3Sjvm+zczVK9NXUQl33ZbVn?=
 =?us-ascii?Q?z/9FhAoNv3wG0PokA2Vr0oISKvcmasXBfWI4T4xSC4KyCKEwYRGqDefHXq7P?=
 =?us-ascii?Q?uidSyhBTXisrDr5KFKVxB/QWLzkedsL/sfz0fOKwty1IQyWjzKsZZjDathQw?=
 =?us-ascii?Q?y0dMU+bnHEDRnToLqlDXHz8QTnX8pjooxvDVjlbH0kW9nCoffKRfolrlBKqo?=
 =?us-ascii?Q?nsUGM5nVSVR8AoxKXvzagKOpSRMOvuENAMZ+MZ6eI6yStXDMmPSq7CRwElDQ?=
 =?us-ascii?Q?q7bbV+zXiZDHLH6OTSm7jFfeDrSoZ861+whaqYq4n3l+K70WZs0q5ld1Ebq+?=
 =?us-ascii?Q?xA/UAGmeWagJ7LNk3A8RwKhK8MR3vwUpz/sIqDvqFslT2clzdHEOlqCyCdCN?=
 =?us-ascii?Q?lJvvkGUop089xu7vBZL8ayD9bhyBVHEuZprXXXmw5x/VUWcOv7vpEqi7h9yx?=
 =?us-ascii?Q?3o+lfBrrx4aGurCHO9pmMBHk4IJKFkH0Ssd1hMbt8ohIVOy1NqIyBY9nT5nG?=
 =?us-ascii?Q?qeA+YrRu6Bn6JTLuvcKuy8Jt+4Sqzy0V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:11.0208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519fd201-5132-42cd-74f7-08dccd304cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

Assign/unassign counters on resctrl group creation/deletion. Two counters
are required per group, one for MBM total event and one for MBM local
event.

There are a limited number of counters available for assignment. If these
counters are exhausted, the kernel will display the error message: "Out of
MBM assignable counters". However, it is not necessary to fail the
creation of a group due to assignment failures. Users have the flexibility
to modify the assignments at a later time.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Reworded the commit message.
    Removed the reference of ABMC with mbm_cntr_assign.
    Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.

v6: Removed the redundant comments on all the calls of
    rdtgroup_assign_cntrs. Updated the commit message.
    Dropped printing error message on every call of rdtgroup_assign_cntrs.

v5: Removed the code to enable/disable ABMC during the mount.
    That will be another patch.
    Added arch callers to get the arch specific data.
    Renamed fuctions to match the other abmc function.
    Added code comments for assignment failures.

v4: Few name changes based on the upstream discussion.
    Commit message update.

v3: This is a new patch. Patch addresses the upstream comment to enable
    ABMC feature by default if the feature is available.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 21b9ca4ce493..bf94e4e05540 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2866,6 +2866,52 @@ static void schemata_list_destroy(void)
 	}
 }
 
+/*
+ * Called when a new group is created. If `mbm_cntr_assign` mode is enabled,
+ * counters are automatically assigned. Each group requires two counters:
+ * one for the total event and one for the local event. Due to the limited
+ * number of counters, assignments may fail in some cases. However, it is
+ * not necessary to fail the group creation. Users have the option to
+ * modify the assignments after the group has been created.
+ */
+static int rdtgroup_assign_grp(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int ret = 0;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_assign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_assign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
+/*
+ * Called when a group is deleted. Counters are unassigned if it was in
+ * assigned state.
+ */
+static int rdtgroup_unassign_grp(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int ret = 0;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_unassign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_unassign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2925,6 +2971,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		rdtgroup_assign_grp(&rdtgroup_default);
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -2955,6 +3003,7 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
+	rdtgroup_unassign_grp(&rdtgroup_default);
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
@@ -3214,6 +3263,8 @@ static void rdt_kill_sb(struct super_block *sb)
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
+
+	rdtgroup_unassign_grp(&rdtgroup_default);
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
@@ -3805,6 +3856,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	rdtgroup_assign_grp(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3849,6 +3902,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	rdtgroup_assign_grp(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3874,6 +3929,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
 out_rmid_free:
+	rdtgroup_unassign_grp(rdtgrp);
 	mkdir_rdt_prepare_rmid_free(rdtgrp);
 out_closid_free:
 	closid_free(closid);
@@ -3944,6 +4000,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_grp(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -3990,6 +4049,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_grp(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


