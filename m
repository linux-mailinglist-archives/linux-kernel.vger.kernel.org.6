Return-Path: <linux-kernel+bounces-357633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA0F997385
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB0B263F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F61E7C35;
	Wed,  9 Oct 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EerjHQTO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A81E5707;
	Wed,  9 Oct 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495766; cv=fail; b=gVawc6EpuHFbSnv+iY6vrFvoRNhnuuYx9OleqVkMoyB14d+DpYzwFYWkbMa5fOsd/3tZewD/GuOwJUwyV0YsOhz91lU39ZkbwDTXncLQhN4Gz9yH+UTQLLIyffa0V2JDxf+tFGgEV9fy17BZUukpSSzG/YvokXeKz+c3nlWN3cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495766; c=relaxed/simple;
	bh=xsuQf+Xi1K7w10llE8EEZC0QAvDtxRBPe/pw/ipoUFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7A86kSzZSgr7IUwxa4Uz7s3fDjzZlSR5HGZjbjp2LlR8BtMaKQLMq2NccwRMzA7MZ/MyDkgnFgJqBjYsEQcetG3RCIOIFKsbB5Y0GxgAmLC6Hxqh5FZHUfoOszOwPK4UW1l7X4jGfu+tj9hn8t+cvur7NjeOjLFVgP1T0UBRcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EerjHQTO; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPnQ1Y3OJsByQtOsPc9Eje1g/KOiEmlUxJlr8Qsd9hIYA2gEkTpuUCk5cCbTMR98OksOgBmULZ3bXHAWGus6cVTDNO7KJ1BrElgKxKboC6/FosnZDYxcD9EBveVdZgIxmjy/rOYVxC5z6PTnUb5zCRuxaM9w5Xu2jTiCbqG4eZdar2q93NUla6TrxiwvKnTKxrYZ3XpYBTJ9H/sU7/kEGQUpa4+fPEFwAMSfK3QvK+HutJCwElCU8iKJKgvwDgULlhrG757tAKwXpGAXqE8X+R3E3jnV+Y5zM+UIngmpivj+CPIhS2aJHrL6eMABFRed/crKRjtWB1ElWKNbxhUpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc+0AADQMoosJ61LZmhV+p940KckAOkrBzNETg+Iwqs=;
 b=X8NbfbXXMHle/sDE+tL96ucPPbmorNNYVU9GJU3IQb8APw3Mqd04KLg2TRhSeOkLxU9dbmYpesrqeU+/ucXq3yluS03WTFRtuqpLUlAfv8sFL0MNmSW23o5WW75A40eP7cBBcnfZtgbfFpmzD66HmzqBlq0rEIhSAVz29yxr//z0QvYZUsZBBCoNAV7X4a+MB8HigwkMaNHThgLcMSt2++CO+HK83+Y3IR4baCKnkF9jdN6NvQ0X/VOZik5syyJXTYNwqgbzp/ZCgrhLQnoYCuQwM26mPVsn4x5zOhBIDXo8sm2UBs1/s1hDlA6TDiWhr16az431aeG2s6+ScIvHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc+0AADQMoosJ61LZmhV+p940KckAOkrBzNETg+Iwqs=;
 b=EerjHQTOEebLpIrvjyO/WgKurhB/a73BzoQArOG3VPcccaYySEZyr5DVuEf7COGlRqDL49GZvqYEsEwGqec5NIJMpGQ1i328vTLnrHqvxXQq1p2fDXTJZbg0AqYO68bYVMo7SvBduX9qNlfciZxSyXVXO7rCFKWuuC2NfHweVls=
Received: from SJ0PR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:334::12)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:42:35 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::d3) by SJ0PR05CA0097.outlook.office365.com
 (2603:10b6:a03:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:33 -0500
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
Subject: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when mbm_cntr_assign is enabled
Date: Wed, 9 Oct 2024 12:39:44 -0500
Message-ID: <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 704a02e5-83a7-409a-c807-08dce889c2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhJdLDbrbh5U4xxzyYc1MWthl9NFUBZ+NPis8M6Yn2A7xSr6bi39C2lfgM9X?=
 =?us-ascii?Q?s0Ptp7i1i4pzErg8qjC723layyosvw5wG8njTbhdTWaYswfgDSILkFxAozTI?=
 =?us-ascii?Q?yq6UTprpVmhdsqYI4nvuBZFpVs1hhjnguwX0UIq+zX81ldjNzo0Y6pmvCObF?=
 =?us-ascii?Q?JaHPR8ptTJzqz7SHLOOWl+BrzRnu8wxfIO5qiaLU6YGp8pkIOXrbX851HtTD?=
 =?us-ascii?Q?V2voES6Wauem2vUuPVz0/tGc+Z/o/gjVV3K0mG+F/7hO/0V16q3WInrxgsdh?=
 =?us-ascii?Q?rI+75PsuV74/aTjG534VcpFmB2QfMCoVr5E928eoVHoVe09YxoP0/PI7duVp?=
 =?us-ascii?Q?MZQZu9ta/g4eVqBqSbcIoqD+w01uNoKMuyQv0ICbUMM/vagOHL57uAl8OG1t?=
 =?us-ascii?Q?iVdJgZKgXFOY8pjSXFwcMLbEGAqE5wB5Me5RDQbePMDo78VXAMdvD5vTtpGU?=
 =?us-ascii?Q?r83cmT2UfO4D3Iq8g+0KEpDBGpv0ck2LdmDPattbS6q9oBPyWmlBO8Ajt3gN?=
 =?us-ascii?Q?CKww8KXn5kntGdVh8sXjb9BZZl2gKajc+fVPr0gMFFnsKrZdkWJf823rZhlx?=
 =?us-ascii?Q?aYL1QHm30gxw9dEx1Gfe6kvbZ55WuSQDYFqqfqqGNBzDRGKW1AKHOCTELQY6?=
 =?us-ascii?Q?XAA30z7fgPnzyf7Iv1v/H95FSvdwvQOhUKOUjkZxLjXnfYDahrjjA3kJZA3Z?=
 =?us-ascii?Q?A4kRY404ZruOtjqWP2/c3Yr+kS36qDO5wYNUT5hJZwtDxAUgG6nxSeCakwir?=
 =?us-ascii?Q?uJm+RfCbzGpoM++QG73bNQfXZBibOw9gmHRhmklen+Q2IAJtemdoTA9OTC2h?=
 =?us-ascii?Q?GnpDLBU+5B7s91+t6o5LzKsXPeWw0T9WbUkkZpNndOr+xSWNxbHnSmFIwKu3?=
 =?us-ascii?Q?cvEs7FFERlpOEDnWLtS/BZyjRUqZwPMtZzHyQ6ZJEEuOa/FPSOecz/1FZMVI?=
 =?us-ascii?Q?X0oGBRrxS5g/9TvQXya1Js8csWoorTcWJ3SHeqYElG/PLw4gXfaARbi9dm74?=
 =?us-ascii?Q?C3f+auOtKevSz5ubo0nZdIQKPKPeJBXWw4a53StChdp1UQdz/m4sgQx5tQXa?=
 =?us-ascii?Q?wOYA8uZNV6oQDzBzWGEiv+CTm8HNoOnrkv2P3CLGohg2ym9+musWiVUkafdM?=
 =?us-ascii?Q?V9HHH7zIvQjzkGoTZgEaxGLIOqOvu9bgg/QOZ3Q8+iFvHndi+ETljMK4wuZR?=
 =?us-ascii?Q?0/VrThU/Af+ByhEW6pmTRVl2HVs34yy+tWkzZMYwcBW16dEC9kUxSI9T97pF?=
 =?us-ascii?Q?bNI+I8UytgTgN42+suu4VDOVsCvvlaSyEqLuGtfxkrh4L+CRNQLEj4pNC8Dr?=
 =?us-ascii?Q?hwYRRsklyVVD7LDOabiJo67EU+etV+Ls3p+S4fpDRTBq8DlJ1pCgOSiunMiw?=
 =?us-ascii?Q?SCCmzlmAKnRaRPZC8jaYlvLhcuau?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:35.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704a02e5-83a7-409a-c807-08dce889c2e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 791258adcbda..cb2c60c0319e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2875,6 +2875,52 @@ static void schemata_list_destroy(void)
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
+static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int ret = 0;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
+/*
+ * Called when a group is deleted. Counters are unassigned if it was in
+ * assigned state.
+ */
+static int rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int ret = 0;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2934,6 +2980,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		rdtgroup_assign_cntrs(&rdtgroup_default);
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -2964,6 +3012,7 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
@@ -3144,6 +3193,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
@@ -3184,6 +3234,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
@@ -3223,6 +3275,8 @@ static void rdt_kill_sb(struct super_block *sb)
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
+
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
@@ -3814,6 +3868,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3858,6 +3914,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3883,6 +3941,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
 out_rmid_free:
+	rdtgroup_unassign_cntrs(rdtgrp);
 	mkdir_rdt_prepare_rmid_free(rdtgrp);
 out_closid_free:
 	closid_free(closid);
@@ -3953,6 +4012,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -3999,6 +4061,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


