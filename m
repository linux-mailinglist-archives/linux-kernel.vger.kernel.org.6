Return-Path: <linux-kernel+bounces-240264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AA926AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0921C20E92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2455D19B3C5;
	Wed,  3 Jul 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJYvkQge"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D9194138;
	Wed,  3 Jul 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043448; cv=fail; b=tXDg3/BiTDpWugAmhwtDgr36RsWds/wMbqbcq3raTA22c61QwuvsaPcY6HQOHbfZZaD8wVAjOw3hamBSkSbnFNdOWdV24EYxUCxNak/uUaThPNW2+G46aVZKymXWbrQ2N2dtR2XkwwwAMHNYsuSh1GFUCkT7CgiWpQdmxcgVWfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043448; c=relaxed/simple;
	bh=ueeR/v17tt2/NF3j/g6m77xrQ7qe+xv1AvBpoL/SCRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry/s63JSHk5LA3uwRhdbtzmXYLfXafmqF66HBm7YmSGzf+L6Xe4X4A9ka5+wyBxiBFNhLIery8KRQC6Ps0TpQlwdpQoACwwlG/uWycWJ02JUE5V+XNkbI/8BPQeY1U/LjK6MSanN8/mhLjhqb1tH97xTFTJ3JDKdXTndTul2RHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QJYvkQge; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjkGDZU5x/BtZvFrx8PJsMypVe8NWAspgBkx75JAiol8j7XvZSKTvMDO17ainnCnumW0c5Y8zQiro7s5VFhg6OCOTYz8+JKpsIrHhoYd/qsgwTCPbC6EbfacsTaun2jQ1jje/vluA9Zp5sasDtdyJgTPNu20H8PjwYC6XMRmb5ZimXtqbVQ79L5oGLgkb6RoqwJyxyp1FF6jZ10LStwJ9zZTiM+01igZqsG+jHKGHXyONNjLUgz5NyVjpYPJBRId8HxRkv63Wae4Y7TemAoS7ERH49JHJaW10mgiroUN05GGDwwtOVbXASNuuALWXlQHLChTQB/yxW4opXLd+2zMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dLfW1g5byqMkzRWdhSp+40r/32qXfjNHpEwsqP8xWs=;
 b=hIHBhraAv3n5WMLueTnOAsfqhOkHFmHPKqpq7eaDScsbnFnkFk3APgp1MpkOfUNfJGnndyPHMCEWY7icx5mEQb60Lez1gEtz3SyNenCYevSrCHjyUSdy/jm/Wna7Zg4V1GyS4e3qp2eWsbvgbZtETsZFikBjOkQujYqBszszciF+JkRgPLlk8o08N+aDbMX4PL43ck0KLdic1AxGlrhvnFI5n2ms2PlbsbtyoF6aqG0P1X6uCWU7e3KhkPDuYGl7F1HpE3PxhDGrOgJEmr+iL7zJoWLir2Y9iSxI4lr91n9jLVrNZ/018Zv98t/NIVOGsnljauxREl4UUtcwqCuVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dLfW1g5byqMkzRWdhSp+40r/32qXfjNHpEwsqP8xWs=;
 b=QJYvkQgeEF0EgG/lehKp30EEsa6OhBH/acw7B2/Oe40nwJSZTwbN02+Wu/RimOXq+lp/YhXzlnOB5QI1eWC9sC6HunnIPo7CgcDrqFjY4Xp/F/P66iUU2mHLft+9YiQVHxN7k69edRu4lRw+M4dKc9feFyaTy/C7zcZWOlsFzps=
Received: from CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::11)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 21:50:44 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::e6) by CH3P220CA0029.outlook.office365.com
 (2603:10b6:610:1e8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:41 -0500
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
Subject: [PATCH v5 15/20] x86/resctrl: Assign/unassign counters by default when ABMC is enabled
Date: Wed, 3 Jul 2024 16:48:26 -0500
Message-ID: <89b7b4c59f3389034337301c1741ce224e19061e.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b2afcd-e5cb-4628-5681-08dc9baa3028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUGIEvoY1UE/M0daVJ2mkelpJ+R0C4bZ0YhvoPF6WVyxdQ9sqzQzMfuZVSjn?=
 =?us-ascii?Q?ZePrkfdEjvSdsBRHJghQjb4s2qzU5ZZFH9ekUaMeNrA4239ExFch5vKGw9L2?=
 =?us-ascii?Q?lM0RX7cxwFFSkzTw0lxtPTECtuc3XOYD4fP1CqaryA+vSCwlYuvJANBiWiPr?=
 =?us-ascii?Q?WUTdd/0M9BtiLvk1U0AdbYfooevy4I1ixyGteZZ5VeqaFRdmeCOrfFfLzA8o?=
 =?us-ascii?Q?7lUZpKlud/mcO/p8dx5EAylizrE4zndDWntPd6QPr4nFxnCAe6TJDadwlqFR?=
 =?us-ascii?Q?I4jWPhBoBg3qHktWJMihd2mNouQtOZd1XMKdYTWIP7phTAHUBzDlLKEo2g2E?=
 =?us-ascii?Q?44nRbmXHfufyhhMZ6l6YznEh6HNw04cZw7CrtkzzfZJ04JRpIBW0jFxwSKM/?=
 =?us-ascii?Q?Vm/gWRzetTbaRFdT3BzP7IBpbD9eBVgJyCA9I+jtY4C4dNFG0UkwYQMdsoT3?=
 =?us-ascii?Q?Nv25vjTLioaZv5+brQwPp1bX0D6LoOVgUwNcZbq4TKGCEjvUTBJs29LI98w8?=
 =?us-ascii?Q?lSvEd0cjAbHwDxr7RltCCypfX/8OoCyklGfOkRay2oMFixJOwBt/i0T2SlT0?=
 =?us-ascii?Q?f1LPaLLWOWRKtH1r5fsKS2BVedJrWJcAKxA/FN6oGUg+1IHdJs1BQukRm2GV?=
 =?us-ascii?Q?UkkS8WunQkpR1aLeRHr9HRjHfcaxkfI1FpEtaOaxEDpUBq/QtSD4JbzUGdBF?=
 =?us-ascii?Q?UKxVntX1C6R0mrsdTj4lFmvSKnuRG4vul09CcGWrQRf32SncCFn2DoJKXgqx?=
 =?us-ascii?Q?RqLdgPGNTS1gmJxSrELFASUyCyUkhIlmZuDdFNKt4W1L6IkqxwJ8zI1AkhD/?=
 =?us-ascii?Q?VUXq1w+4NDkq52zX1OeSlCAOc8TYLMltUb8ycAqB1ysZGT48CAXZjQ77ELBy?=
 =?us-ascii?Q?Xw2esaoOy86SnJ6p2TE8pZmc/2gxJT0OQHZVD+fi0cFqo2NC+55sOoxOiR7W?=
 =?us-ascii?Q?2L//vEPWB+56yDasibcyOyc64sXc96gjjv1c8eiszBp3mmaWEKlXJPKQ9ZKx?=
 =?us-ascii?Q?8jnrtN91Ob2R98mTQPS2rV9kcuJ1MzCOL1DySFGSJdC0f1siR3kIjLUBOty0?=
 =?us-ascii?Q?/7fTza1OE1bTN6pwIL676HmjV1lXmDe4dxMSf8/JquKQ+UFhnCLrZQOibnJV?=
 =?us-ascii?Q?Pe3XaWo9F6//VegzuLwS46amm0jkVTg3kdGM+qcZnwj2nbEDzPolNlmhsaLp?=
 =?us-ascii?Q?/OkeWPrEk5dvF79wA1NtC3oPz/2tNqhCDCxGKwlu1U3QyLg2bMHGFHJ7EGIK?=
 =?us-ascii?Q?PXgP8TPxOYZZxBpjXTRPqFMfWeHLdulXf8I7jUsSj/6H/znu+61TXH9l8lf4?=
 =?us-ascii?Q?zQpS8IB65bDnmyTL/SfgKlYUlCPfJpC39t8Lp3Qh/T5HHPO1lqPuTGToqBnE?=
 =?us-ascii?Q?a+iL6BKCVwz05f23W4ya3JLBji0yiZNoJ7GekhmEkLtdXtImGBPRsrOg9qQi?=
 =?us-ascii?Q?qT3r/Mn3CTQRQek33zT+pvr9mhX171uU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:43.3369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b2afcd-e5cb-4628-5681-08dc9baa3028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938

Assign/unassign counters on resctrl group creation/deletion. If the
counters are exhausted, report the warnings and continue. It is not
required to fail group creation for assignment failures. Users have
the option to modify the assignments later.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ffde30b36c1a..475a0c7b2a25 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2910,6 +2910,46 @@ static void schemata_list_destroy(void)
 	}
 }
 
+/*
+ * Called when new group is created. Assign the counters if ABMC is
+ * already enabled. Two counters are required per group, one for total
+ * event and one for local event. With limited number of counters,
+ * the assignments can fail in some cases. But, it is not required to
+ * fail the group creation. Users have the option to modify the
+ * assignments after the group creation.
+ */
+static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
+{
+	int ret = 0;
+
+	if (!resctrl_arch_get_abmc_enabled())
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
+static int rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
+{
+	int ret = 0;
+
+	if (!resctrl_arch_get_abmc_enabled())
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_unassign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_unassign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return ret;
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2972,6 +3012,16 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		/*
+		 * Assign the counters if ABMC is already enabled.
+		 * With limited number of counters, the assignments can
+		 * fail in some cases. But, it is not required to fail
+		 * the group creation. Users have the option to modify
+		 * the assignments after the group creation.
+		 */
+		if (rdtgroup_assign_cntrs(&rdtgroup_default) < 0)
+			rdt_last_cmd_puts("Monitor assignment failed\n");
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -3246,6 +3296,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
+
 	rdt_disable_ctx();
 
 	/*Put everything back to default values. */
@@ -3850,6 +3902,16 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	/*
+	 * Assign the counters if ABMC is already enabled.
+	 * With the limited number of counters, there can be cases
+	 * only on assignment succeed. It is not required to fail
+	 * here in that case. Users have the option to modify the
+	 * assignments later.
+	 */
+	if (rdtgroup_assign_cntrs(rdtgrp) < 0)
+		rdt_last_cmd_puts("Monitor assignment failed\n");
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3894,6 +3956,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	/*
+	 * Assign the counters if ABMC is already enabled.
+	 * With the limited number of counters, there can be cases
+	 * only on assignment succeed. It is not required to fail
+	 * here in that case. Users have the option to assign the
+	 * counter later.
+	 */
+
+	if (rdtgroup_assign_cntrs(rdtgrp) < 0)
+		rdt_last_cmd_puts("Monitor assignment failed\n");
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3989,6 +4062,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -4035,6 +4111,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


