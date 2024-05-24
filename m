Return-Path: <linux-kernel+bounces-188686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866BA8CE553
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92011C21293
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B3127B67;
	Fri, 24 May 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PKzNxkCt"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BF86267;
	Fri, 24 May 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553567; cv=fail; b=rF7ituniPj42naczvgAkVNsz0ct+BvaUgewSneftDcVaQngNjIncFyQmjskRnCTkwr7ZTRGByRUaHn7VAUXuGA/QHe/gTaSy5z4vn8yGS0UUvM/lUdVlF4IG4DTmSl/Z8vgEdlw1jZi9hpT1fooxWtlSD2NFb+ZFTbmkSO+alYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553567; c=relaxed/simple;
	bh=OPrrDb67rdXQO9RCvNYIQKvVdgtyutgxZM5PCzAP9t8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTuwuvChcEwSJCP5KXjBMjxcKGe/m0b7aqDp4jgkxIynDGt5rv4zKEE6wRL4/KS3ZYie8AEO1j6wvW+7MGd2uB0IGfMgbTEWNYZ+cmGWh00MeB4+YLQGkGm9NFRbuWWBYN3Miziy6lTBtXqUgAM/MJ+yjbLcD188rQ17wbo3to0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PKzNxkCt; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7i6iqCmNS5jh1IxNO6CXFF1sN03Yi/jsqsHLuRgCnvGCIlpa/REvi8K6VO4Xbv0c3NKkCS+tI8lH3+s0crHoK4dFw4o5gGJDpvGZ1ZXxTwUOuqQ6lMbTanKw1W0u3Eo0dbaVQqF/1lhY4riChm7gawYqcLs252R3NFpe0vHcaIlaxC0MISB0M0G/KO35V/nPy5iW00NZuU3vVpPpaMofPJU1KrTsGr6r0ruOsRpR925HKnSPggjBHrZuAi1Qaxc5NBHl46g74sG88YAqqeewpn5Tw8hzOV6m/AnCVC0JrPxnjZIcY8NOKJVRAhxrz+6TiqSjRIwClweVXUtDv9O0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwg8xobU5MOW/1C6DakGOpW7HbjVzrKtawGLInWTV20=;
 b=O/amuV7DmxAMBTsWEQn7OH44xfLXenHkdPiTaUffj61VUEAVvTln8z77vkFwWWEaov6qXbF0cVSGtuNfdSoUKyJ0EmJz1PnE8ogyjy5gmyYHaDVQRuRlQQ0whzzUOFXio4PtcHJKkzNksn8khnQDh5Bygi1GcJ38UghOrGPvh9KfD64QyqidKDPW+c63lgGY+P1gPmYjcRrkZALgpDYl4m7YhKChl5ImW3s5RXX5YN05yJ2fJ6AFqPppvLL9q26E1r0416cuk3PZWYi7g5Y7ooZrsFtWRYQCHjfHLyAPefiZYvHFKxuggBARrBQrFcmgYt7jhlRFB/hfgRcx0/KnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwg8xobU5MOW/1C6DakGOpW7HbjVzrKtawGLInWTV20=;
 b=PKzNxkCtY7pNl7FHs8+dkk/L1nAfq6FRGCKjeyujJVFfhxO6h7Sf+9xjuTDk4U81cSuQG+ehTlKYOt/oDNq8bBxYgyfS3gVwQtpIX/Q6d3ZPxM5aYvsXGqnD4XI0YjFA8eeUT4969hsQBCJcrQ5lg6StcoEVyW9JxNV6flMqI6g=
Received: from CH2PR14CA0060.namprd14.prod.outlook.com (2603:10b6:610:56::40)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 12:26:00 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::bd) by CH2PR14CA0060.outlook.office365.com
 (2603:10b6:610:56::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Fri, 24 May 2024 12:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:57 -0500
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
Subject: [PATCH v4 16/19] x86/resctrl: Enable ABMC by default on resctrl mount
Date: Fri, 24 May 2024 07:23:35 -0500
Message-ID: <74f014062885d707701873527c1b12268603a525.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b6f3ce-6f94-4cf1-4182-08dc7becab8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5PcLANmuMrlGnpEYdt/nInCUsqHx633yGt23TxRPd12t1uaozasHCLn3rCRp?=
 =?us-ascii?Q?fhko3T406oDgrIey44YCY3R1yYa9os9DIzy5dNXqtfeXLWxhVOlgciTQHLoA?=
 =?us-ascii?Q?F3caQJEzV56F1K4eEjw3JMPHCAKEsLqYn2wzyz/Ujwr8aK9w1QjkW1lxu+F4?=
 =?us-ascii?Q?EYoBulkSA2eVoy/f69B5n6C7eo5ZGCImOqFbqaAjMksjWUP47AnDXd2oYzOL?=
 =?us-ascii?Q?bnSu8fyf7aT9UU1xKwzX33fZhqTyiB11AOH/VKORpW8T8FkaKSIet79IZ7AR?=
 =?us-ascii?Q?gJoR0XPUqjttQ0Ye9DidJ3Oubk1Zyxpx+bEh4VQpPfHqe8xaTvEXJ7xr8nD7?=
 =?us-ascii?Q?wwum+/LhnBNYRibgEb/jSNzE6EC6eTSgCF9ILheSqd5S9CBxXB+srAEmDEaf?=
 =?us-ascii?Q?mZAF/NTisopPvgd8C0cpAakl4hInvrKXypRSOJap4jrouYUsZCLGpuKVmU1x?=
 =?us-ascii?Q?RWEEt5YtG2chiwcFfcuX1HdBLh2JD7VIMS2fjCNiprwtmUiwFXeEA5xy1msW?=
 =?us-ascii?Q?hFs6EDYx/sOMgwuWFoI8NNUWmMWJ2N28sZomLfx0vrclgKGm9z05HIvjr1m/?=
 =?us-ascii?Q?0QLL9J/FJBos/ccsbx5UfjOIjTnvr9Ef2hKmMLTOawljuqTznvttOeqaGYjS?=
 =?us-ascii?Q?PLGtnWdqZHxo2aHqmN+98cikdBDy6tGrS1Edcxj8J9D+NZUDDgXKXqwkTi2h?=
 =?us-ascii?Q?keBvVJRSro1pvrlU0MmrGPcYk61MF9WVfNnxDlUmiUdXryT1SycLLTKlmDFH?=
 =?us-ascii?Q?pu6yAOFzppbUm2BVjKd768xF1rFEj+olN+exs9Dneawz+a/6Mot4DZl54iAK?=
 =?us-ascii?Q?XLfK/D775sftfRsOPVy3NHes2Lc4UGeguosBcV98mROd6AzvwBlwb/4fwwIU?=
 =?us-ascii?Q?w/BfbsK0IiJGQiAPQx2lMe09Hz6lEeAvzNt0OJhTUclx9QZGxveltGsph2TD?=
 =?us-ascii?Q?E2/DmLhpwK7Ujz/7JPd4fxXKGDSGp6XwZB2HE36pGuENS1aGvun1GurFExo0?=
 =?us-ascii?Q?NN9KjZx4yCFiywfTTJn8wS75PAQFyEzLp2djrgkyTfjPHioB9EoQUxGyR5qP?=
 =?us-ascii?Q?9RWIbl4WOoL5Q3Yg4zpbjPaP7mZuPMy3esMmNIc7x6A04JjfkINTkgdsLGwO?=
 =?us-ascii?Q?aFjf8YnGVacBWhNmGW7uo/wyYxLncU4AMYNko9bDJuIv0+jVe+Ua/1n3VooM?=
 =?us-ascii?Q?8x29ox+aoCagcIpQ7J4OZ6gmq6KxUg2A8xqIuETr0rHpnZOdYkvlCk/RlOQ8?=
 =?us-ascii?Q?2Qg1ss50VTnOzwIUACgJfOYRkMRhG8HBHadkzawchTJXyScXYs2lmPmRikHM?=
 =?us-ascii?Q?jHf7Dl0EAZl1h6z3TUfI5CjdV8S2pqx9ELKUYjsil2rw0acnx0bUSmuCCNrA?=
 =?us-ascii?Q?eVoj4WE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:59.9933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b6f3ce-6f94-4cf1-4182-08dc7becab8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

Enable ABMC by default when feature is supported.

Counters are assigned automatically on group creation. If the counters
are exhausted, report the warnings and continue. It is not required to
fail group creation for assignment failures. Users will have the option
to modify the assignments.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Few name changes based on the upstream discussion.
    Commit message update.

v3: This is a new patch. Patch addresses the upstream comment to enable
    ABMC feature by default if the feature is available.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5ea1e58c7201..f452b6d9bb99 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2756,6 +2756,7 @@ static void rdt_disable_ctx(void)
 {
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+	resctrl_abmc_disable(RDT_RESOURCE_L3);
 	set_mba_sc(false);
 
 	resctrl_debug = false;
@@ -2786,6 +2787,8 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	if (ctx->enable_debug)
 		resctrl_debug = true;
 
+	resctrl_abmc_enable(RDT_RESOURCE_L3);
+
 	return 0;
 
 out_cdpl3:
@@ -2882,6 +2885,41 @@ static void schemata_list_destroy(void)
 	}
 }
 
+static int resctrl_assign_events(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled)
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = resctrl_grp_assign(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = resctrl_grp_assign(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
+static int resctrl_unassign_events(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled)
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = resctrl_grp_unassign(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = resctrl_grp_unassign(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
+	return ret;
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2941,6 +2979,14 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		/*
+		 * Assign the monitor counters if it is available. If it fails,
+		 * report the warnings and continue. It is not nessaccery to
+		 * fail here.
+		 */
+		if (resctrl_assign_events(&rdtgroup_default) < 0)
+			rdt_last_cmd_puts("Monitor assignment failed\n");
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -3214,6 +3260,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	resctrl_unassign_events(&rdtgroup_default);
+
 	rdt_disable_ctx();
 
 	/*Put everything back to default values. */
@@ -3752,6 +3800,14 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	/*
+	 * Assign the monitor counters if it is available. If it fails,
+	 * report the warnings and continue. It is not nessaccery to
+	 * fail here.
+	 */
+	if (resctrl_assign_events(rdtgrp) < 0)
+		rdt_last_cmd_puts("Monitor assignment failed\n");
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3796,6 +3852,14 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	/*
+	 * Assign the monitor counters if it is available. If it fails,
+	 * report the warnings and continue. It is not nessaccery to
+	 * fail here.
+	 */
+	if (resctrl_assign_events(rdtgrp) < 0)
+		rdt_last_cmd_puts("Monitor assignment failed\n");
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3891,6 +3955,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	resctrl_unassign_events(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -3937,6 +4004,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	resctrl_unassign_events(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


