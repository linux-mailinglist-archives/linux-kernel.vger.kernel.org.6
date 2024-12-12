Return-Path: <linux-kernel+bounces-443898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C479EFD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E83163825
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF31DC07D;
	Thu, 12 Dec 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ljNQhLeF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AE1DE4D9;
	Thu, 12 Dec 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034717; cv=fail; b=cYA8bxw2DDrtjwGaOVjYG3pV0pafpLufNk+jowXJTEKMR4CVDQi5gIdvy/87frjIij3KvKS+DvNPVGpbkIR2swQDFKR0fSKHAqV2muJxUvji8vkrXY1YwwZX71ek3vZZdQCWg4/rRDzgGd2b25c+vBeG75kD7LrVOBZmh+p2x+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034717; c=relaxed/simple;
	bh=nZTFMu9RDezcDYOoTPrFUT3fwEwv+kDjfI4Qya+l2gI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmgKC9iNbODAxIC2o4iwIqe3e38lLvHuqjGfr8E5crEV79BZgHxHOpPANQYVuSy5BJ6/vy1qI/u9usDWjihRvDyx/SsutmK+5zdnEj8OYTePc6wb+b1m3OD9ymW03XHSvS+ZLjhgCFgLeu4RfHAYVmq+6VH1jGIAJNE0a6zqh7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ljNQhLeF; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXDf9CFd51aqs0tP2UmgrzgNpP3NLh3UN+jDxrH5II12r/UWeYNaCRTQdPgpZT4fQFeMyxHjHNC7CjuvH2o2k8vTxM57pXBn+r7P2cnQ5WPMvulYLSizZQxOubFvHB/UZnTcV9ql4/2nv0qkZ1cTMU1IVV/Lig98MwgwPdpr8J3VOgRBNPBhC3tu1O3rnyflvbgbpUzBq0gWyiMOEXKv3rS+hpKU1cC1e52t0MTHEv8cZUyEylBO7ZGzkR1CV1/4k+Uf5UiWLZX1h8aE0m8IIysKrnqpq5z51s73hCfNtogIx9I5xbIzzyi1eFhKrjVRQ/ltWBw6ooB1lMrRnWoR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXJviTYCUYp+VR5Inv8HCbSYeZjzHQ1mTPCHYkzyM+k=;
 b=NBKzmZculaELx4bNNBcfxvAGT1PWWsTVLQkVOQ7QWtmyUg0H76zQZcG9zbBlPct/deZmGbD3joWUDY7PBQKQO5w4LGAXC19UvXOpCbd+8bIVuDbX4eadTx4Z2pAfCKK+i1Dmx1sJtgQqNZ2LoEWSM+nfb5igbfruvhhG2LlgRccTaoCIuScxk5xnaQeaSVLXLL3b4sQWtwEWghJuVf4Xu3q0D//YStrNUELJbDBvDk0F/7pDoJzMNU/jU0obbl0qJ+wY+pyvDw8rtpcN4YZIglejemPyDGOWoJUB+aDDK3G2ai222t2w40RPw6LAT+ILKIseLTagV6toDHTvOJSF9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXJviTYCUYp+VR5Inv8HCbSYeZjzHQ1mTPCHYkzyM+k=;
 b=ljNQhLeFhzelIdtKOzCfpBwzK+/OaH9GOMLvQLGFUb1rSZQq3E+SYw54rJS7frIlVLQKH6xZvW+KWA4e/b81zRIhL1TjT97+wnoHE1RxBdl5Vz0ypeaKTN9ZCbCBi+604FxQdRi/q2+L3xjO1oHsVXWUMbzf/oooSLxHwUZKlQQ=
Received: from BN9PR03CA0753.namprd03.prod.outlook.com (2603:10b6:408:13a::8)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:18:28 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::d7) by BN9PR03CA0753.outlook.office365.com
 (2603:10b6:408:13a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:25 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 18/24] x86/resctrl: Auto assign/unassign counters when mbm_cntr_assign is enabled
Date: Thu, 12 Dec 2024 14:15:21 -0600
Message-ID: <35e1b0915fe08bb0ef093e23ca3d520fc6aa32ab.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: da5bbdd9-597a-4006-9aa5-08dd1aea23ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ChSjg4Q/ZzdXZKGlnZf+qEQyQO5uerHEIkYVJSi/E2ZnS4rCKqgn3XhU2rt+?=
 =?us-ascii?Q?QeFz9Rs1yGh1dha4VUQWPss1yNdpgIf4q4I8UU5WA3N+/4C+ps2GguTGkKhj?=
 =?us-ascii?Q?Pj1pNCI+PSrvXslhxSTmWeC6xmtxjfkOmYODXITcaydLhLnMJKVSWHAifsMi?=
 =?us-ascii?Q?Hqbwbgba64APNOB274ecHi3moVx1zq2pYaz5HkG0RqMx142Cpb1Ygt1lw5rE?=
 =?us-ascii?Q?yrmB2ZM3wKJrdQPoEqNI1rSl/LrNTcHtm5sfADqMXEHDMxvUAoDDKmbS5gsm?=
 =?us-ascii?Q?Qg4CsdvbmElXZImEUs64X1WBbUgbOUWLbK4EuKPrNnlQ07FGEEXJqLqhDGOg?=
 =?us-ascii?Q?4Q8VYGORM0QV25jU+DaBImulFe0oxWnux+XUiDISZ8JzYizYvCIHFHIDq/0a?=
 =?us-ascii?Q?CJNgv+tDIpfKJ9i1Tr3XADnqol5Jxm0x9VGlYLzqz0sqO4HdecMb3c9UeBrO?=
 =?us-ascii?Q?QDR+FMPIpsPNAKJzNqTNePYlbrhmMhed3fzROzjkxGuAAEf7PmaGVRtix3An?=
 =?us-ascii?Q?XgyJws4IwvZ6msQF96SGDjklBo8gxGTkIYAvEz0am6O84KNgkH8OhUo0+EDb?=
 =?us-ascii?Q?vaysrV385PVJP0JS/nSi1nibf30LrzXk0iwghN0qZZ3HYDy69tVqm19CnHo8?=
 =?us-ascii?Q?B865CItY6FBRDWbrrV/+2rtqIlClg0gBag+e4ZLgyEBTIXBTi5rVsjhccmx/?=
 =?us-ascii?Q?v3W3K10+70MsEUd24HUDpln+U4SP0Eyh7G1nST9M3Ao8IStdU0cSQp2Sujk2?=
 =?us-ascii?Q?yfjpUn+GJWPljoVra0g3aKze5erj0avu2wgCnR/H/qA3iPRYY28N9FEzqIu9?=
 =?us-ascii?Q?ASYn0d5zWqJO1aKDyxmZZYMrSVrXUIGc/Lnf6eATQXj/xPH5VQDuVgKrsmY0?=
 =?us-ascii?Q?EYC8XffrOL9z1Sl2aFLeL6GACdtYWLjO8fBtr/ojN1ZSHhcaw+z6RKojrjsU?=
 =?us-ascii?Q?RLX+ySNXBIk7pxCUMIBrYjCDkOC9sS2q/PYKKe0CX7q/6pCoF/UBEGwJc2CU?=
 =?us-ascii?Q?Xr701S47WjDMaU+K8Qgsc2Qi2+JaCjuf7YHYyFJuUxAuhaHt5K/Dt24G/3yv?=
 =?us-ascii?Q?ROrM6W8QgWOFXls1QKzLRcZODq++iqACjsVzZt07WHiKam5fmbB/cMWPjyxI?=
 =?us-ascii?Q?zy5ITrJIzIz/3ma+gW8xS3UaMgNOtuKolKAfg/DsCajuH13lRRDzseZACi6J?=
 =?us-ascii?Q?dzyb3jTm8rMFD4QEDogBkY9M9GbIeYi6fLGo32n2ZZmy+mnoYvcFxcvsDWBQ?=
 =?us-ascii?Q?ehuZIE35YxkWKQN25ARzl3KSTY53CVmZxh6cefBX0ddN5d0y7g8/gyZRzbI6?=
 =?us-ascii?Q?hjMTjQuK4z+4rO6rdg07vtJYFESLZ5Y9Dq/nNah7MJ1b/AE+No31+u435azm?=
 =?us-ascii?Q?Tr1MY7wEmp7OgutNdwV7qMgBiDml4NDnhJ9AncepRj2MSk0l2YgMyk2fQOWc?=
 =?us-ascii?Q?Kb6yOT2jKCVynH1yG9tw3N1/4K2pKiIx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:27.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5bbdd9-597a-4006-9aa5-08dd1aea23ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

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
v10: Assigned the counter before exposing the event files.
    Moved the call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().
    This is called both CNTR_MON and MON group creation.
    Call mbm_cntr_reset() when unmounted to clear all the assignments.
    Taken care of few other feedback comments.

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 81 +++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a71a8389b649..5acae525881a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -920,6 +920,25 @@ static int rdtgroup_available_mbm_cntrs_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static void mbm_cntr_reset(struct rdt_resource *r)
+{
+	struct rdt_mon_domain *dom;
+
+	/*
+	 * Hardware counters will reset after switching the monitor mode.
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in the next update.
+	 * Also reset the domain counter bitmap.
+	 */
+	if (is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+			memset(dom->cntr_cfg, 0,
+			       sizeof(*dom->cntr_cfg) * r->mon.num_mbm_cntrs);
+			resctrl_arch_reset_rmid_all(r, dom);
+		}
+	}
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2969,6 +2988,46 @@ static void schemata_list_destroy(void)
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
@@ -3023,6 +3082,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_info;
 
+		rdtgroup_assign_cntrs(&rdtgroup_default);
+
 		ret = mkdir_mondata_all(rdtgroup_default.kn,
 					&rdtgroup_default, &kn_mondata);
 		if (ret < 0)
@@ -3058,8 +3119,10 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
 		kernfs_remove(kn_mondata);
+		rdtgroup_unassign_cntrs(&rdtgroup_default);
+	}
 out_mongrp:
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mongrp);
@@ -3238,6 +3301,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
@@ -3278,6 +3342,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
@@ -3309,6 +3375,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
 	rmdir_all_sub();
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
+	mbm_cntr_reset(&rdt_resources_all[RDT_RESOURCE_L3].r_resctrl);
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
@@ -3772,6 +3840,8 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	}
 	rdtgrp->mon.rmid = ret;
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
@@ -3784,8 +3854,10 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(rgrp);
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
+	}
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
@@ -4044,6 +4116,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -4090,6 +4165,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


