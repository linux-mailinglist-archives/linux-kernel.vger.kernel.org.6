Return-Path: <linux-kernel+bounces-387848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880399B56DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6DEB222BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA0F20CCD5;
	Tue, 29 Oct 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UhxUvaRF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A320C017;
	Tue, 29 Oct 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244318; cv=fail; b=Inj1PMesEgO7M/Z0MHufLLB36cnPxSXJRwtSniDfakdBoimEjmwTvy9JHN7puUvKnkpIFjwKaNBlnJKjevasgEsWrf3aLtQA810PK2h/IViy0ynnMmR65oYGwDRGilfvk7Ngwtn/T3gHFkFNMI+t/Yh6yKp32nwG7wsxJUNG8HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244318; c=relaxed/simple;
	bh=/C/2kHRU0+d9XWAhefuEt2DD5Uxx7TfoKUvJC3phkC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjPaNLIg1KFxl/fb00MOn64haCh7I9FUVPhS/A6k0lRUTpNUjwS6zfMa5ljXi4JwG6lickllQsBB8FZOewYknS1i24qBAx3p0fY3X8/c3Bum/flQ0je7iQVMCBn0ppPKgHjriY16N8Vcp/BU6gN4hRpEWnikutW5vInh0+shXR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UhxUvaRF; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIqfv4PqwRxk5GYzk5hmleLw6r7Hk5rnOItVrI5rgjg15dm8RXno4exoghy6OrvVVajMohA83lY6JXzL04txctBNZ2M7MEOA4yy0tDnpEQzd2HHtR1N4lrkhf6ImwPsH1H5bao3s7Z4qa5/hFWz8PdJxel06SWW86hUobb5MCTkVytFBkWyQbmqFWHGG9Ad9yAmbUSplhHVqAlRLX4vE5qoatQ5uiYR3LV57nycalVzJEbvw5fOwelo/ufDAhdLlcFUdIoo4J3IGbSJuYwqJ1Q3uc0hEWu7Yug28sjMKNhbDlbl5qqoKuJFdTl8F3XO3VYdRZZUGzIoySGtBlsSdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX9m6nhwVylvJd06phujkaiFhpD1fHqZRmkMhsZBUyY=;
 b=eSpaEtu5kAlZCAZj8wMqQkXfF78CwfivNHJbXKjClCjtCWO2WOClUBsv5X/N/ZLTLShrJ0xJB53zVNPkKKX0blS6/MMhZXZ4XyispGkBBGJfzWgNKV0Tc7q9227grsDuV4xSnqjN8qkyl0L7OIjNWR55sxts3ooxyjrS8igH6Nlk4ZHtSyglMtpBdoEwjHYDqEpBCgg1XJ2fOZmEUCOX1gNzt0lDQtntg/oSuh+rzTrb2PZnd0IU4IsFMf2htKlNsKrOPllsMFGXyRW4sXG3P0XVMQzaKmzn67z8qdRxuY06c66p0NjbmNN5qBo4uHLrkxT3HNuQj+x1tHXF3H/QfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX9m6nhwVylvJd06phujkaiFhpD1fHqZRmkMhsZBUyY=;
 b=UhxUvaRF626fPyrJrWcnsZ2Z/alTyREE2JnT0mO6XW3rYWUrhXdQxz9pcwfY9Krgys0JBc6yAa+dHPuXjPjR6KmRRZoueCSO8kAF3RX8+brilCTsE7eoT6wq/57mwv6wI5oYMvo2lHA60YoZUAUjzuyCwKY5c02p56krLQCrAN4=
Received: from MW4PR03CA0347.namprd03.prod.outlook.com (2603:10b6:303:dc::22)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:25:12 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::cd) by MW4PR03CA0347.outlook.office365.com
 (2603:10b6:303:dc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:25:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:56 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when mbm_cntr_assign is enabled
Date: Tue, 29 Oct 2024 18:21:52 -0500
Message-ID: <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 84858472-a70f-49f6-aeaf-08dcf870efd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvZ/og522YSS0ULuESG0aPmGf8szhUhIGGlAAQZh6gGagdjjA+hL9DLWiFhi?=
 =?us-ascii?Q?rcQB+/hyQWG1SEOMfT5uqi6hddobfYNoNCeo3L5uzgDa2noG6+/9Nj7HT+hi?=
 =?us-ascii?Q?9pTAMCyX3Fq7xi6KrGrayO5d+Cm+XnNGfAB+f2W4deLI2xeB653PR9hJSg6v?=
 =?us-ascii?Q?lhhrMAR6Y1wCDvbep5GUZhE1XUahekGXM2PdcTOC6A8ttysjDLMWj+G1InKy?=
 =?us-ascii?Q?jYMR5rorzTA8L0pcFtRCKddKU1KedEpGs/EzWwJOUvN2wmC5kqzNhNoMa4K0?=
 =?us-ascii?Q?Z9/c7a+/Djw88jVUZ0sLg5x+9/1Ib4KHGeRYSjyInDe0suEorFDEmPOoC9wT?=
 =?us-ascii?Q?ZFakWOI8tSHz86yZ1ALXPVDxfOC1yeoeKCB05ZGDXku5CH1pDiFGlbC+IMXw?=
 =?us-ascii?Q?NOo7QILPgz6Sr5KksUwg3dUaEzGTAe2nZyOcEyxuAj2YUBaHS0gRQNVIu9JY?=
 =?us-ascii?Q?S0ECDApN9ow+E8LvgTN4s/Ce5oxmlB84Ieqxfcuw2wpSNEpIzDSXgYT05nj6?=
 =?us-ascii?Q?+8oGpB1mxQqYw0+j0mxgQykafQ03NGB2Flq7HGJIlAai5Jz0iTCi6O2MfoQY?=
 =?us-ascii?Q?4WdT/TRryoTaD/+du5U9/gW2de7o4gptN/JrbIIzMoXHWl44B46HLvulJJQu?=
 =?us-ascii?Q?9ANLKF1mk/fR9wA02PddmsK0ukci5XjT2TMOG3ES/9KHBc+9rf7dxN8l2Ap1?=
 =?us-ascii?Q?gT0yRKlSN7DKGaDB6I8osTF6t3nKlvKIq/wqCD4/3v+K3/Me0cLspwOqXBV8?=
 =?us-ascii?Q?Y0cjgv1tI3DPIWyqE2w5dohwHPYhsJUYu0MFmVnkt2EUzTRRoCx4MBiHB3J3?=
 =?us-ascii?Q?03R3PdXeVexUbGTeFjDwk0C6iDPLQ5UjxXgKk9/6hMBEZh17VFmi+gAd+uFf?=
 =?us-ascii?Q?JLah0mhqBCaQe2WYzDsqpUqGbau7fP2e9ZoXOlQu0JkahzgwCN0FEZtV4Scm?=
 =?us-ascii?Q?aGr/XaKLq6dise9LNhmNVG1Qfg5/4e8M0rTbBU5Sfo+fxmH55wU/wKt+WjcV?=
 =?us-ascii?Q?QxIAggmtnR76HuhMjtHZS0ycWwmUtrSUz5jicJ6e/vYe7utaPzmRwjO9QNdu?=
 =?us-ascii?Q?RdD6fqcgas1S6ryWSKZLggZEbVuUVWwnksl811+whKShR1+Yp3ziqWRTli5G?=
 =?us-ascii?Q?vcxApRnNYjXoJbqnuj8dJo9K62G8CQXoWTQ6xsgbN03GGRZqv5FwtgGGPkFi?=
 =?us-ascii?Q?fUc1QGShdp5+fGM97JoOX2AIE+8ZAzB9sPvOwleuqdzXBkKjo1UNuDZyrTTC?=
 =?us-ascii?Q?+HlNPJIr3QFSRMq7V5bG+gPja1ylZTxyKwhIbvq/PI4Wybft1hErLMJ6eQnN?=
 =?us-ascii?Q?6Il/zGRaSbKMYPSNx0P7ld1+3hXsE3ekldusZjmpci9OyOrhN+h3Lu24b0Rc?=
 =?us-ascii?Q?TpDEU+MhcYKbTFSZ/QMxmrz3K/0twb5MPKXCdMc+frUrhQjVQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:25:12.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84858472-a70f-49f6-aeaf-08dcf870efd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277

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
v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
    Updated couple of rdtgroup_unassign_cntrs() calls properly.
    Updated function comments.

v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
    Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
    Fixed the problem with unassigning the child MON groups of CTRL_MON group.

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b0cce3dfd062..a8d21b0b2054 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
 	}
 }
 
+/*
+ * Called when a new group is created. If "mbm_cntr_assign" mode is enabled,
+ * counters are automatically assigned. Each group can accommodate two counters:
+ * one for the total event and one for the local event. Assignments may fail
+ * due to the limited number of counters. However, it is not necessary to fail
+ * the group creation and thus no failure is returned. Users have the option
+ * to modify the counter assignments after the group has been created.
+ */
+static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (is_mbm_total_enabled())
+		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (is_mbm_local_enabled())
+		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
+/*
+ * Called when a group is deleted. Counters are unassigned if it was in
+ * assigned state.
+ */
+static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (is_mbm_total_enabled())
+		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (is_mbm_local_enabled())
+		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		rdtgroup_assign_cntrs(&rdtgroup_default);
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(&rdtgroup_default);
 		kernfs_remove(kn_mondata);
+	}
 out_mongrp:
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mongrp);
@@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
@@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
@@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
 	rmdir_all_sub();
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
@@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
+
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
@@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
 out_rmid_free:
+	rdtgroup_unassign_cntrs(rdtgrp);
 	mkdir_rdt_prepare_rmid_free(rdtgrp);
 out_closid_free:
 	closid_free(closid);
@@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


