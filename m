Return-Path: <linux-kernel+bounces-277000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C883F949AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF8B20E22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896E017B41F;
	Tue,  6 Aug 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FckzXpBB"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800EF1779A4;
	Tue,  6 Aug 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981804; cv=fail; b=lczDyWDa39OpzDXqAMriNWdhmFhZVLAyeYo1YuKvUCPIeWW8B7j8g0VGt5zW6qFMdNi8RJCXxldHZFjUz1NZYA282Rigv2cfXILFx6hEMEpxh5z9tIJ/wogk3tWPFMLoFK3YgkeZ/QkMYHxQ5DsH3hoTwvQk8d74vikDoAXabcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981804; c=relaxed/simple;
	bh=MOuQwSGNFscC86zTzkn80jMumpjdWUb9m1Tnq9hlEoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAgFypTp0DHS4/bOwVsjxIYFGRAHAn3fMulWIt7RPHsvIQtU7E6lqMxL3T+1nd8u5GYb9QQAKLHpvBdEORVTcX8gtMyDREp4Nk1fP9moYPnZRDaz+4/nbs4BmR3t+Pf2rQ3YdLY7ilQymq4+pP5DGJ7F48p/4S4LJwSfkeCIlsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FckzXpBB; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRJ8i1pvR0wqEsFghTOut7HTd4tcdtSUV+Z5pLnH1ZiI61tMLi3JXJIg7lXHclM5Fy9D4eht4M7hPphQLmIxDNnaOF7ja6+e+gFwFSzqhoTnckhqUCoZaaB5rNucFyDtl6NI5bPZW1i56N6l0JTSREe7odaChZ/flZKpLWjgADIMA58YRXR4Aq6J9Hu8jBRGzxJv88N2QmLT8itu6MPY1DH6aGzBr/lCA8MypjdCdK6MfpRqRKs2rYGLKE3MHrpOxZ5nKRc6OLyC6vX+mO217KNlGpSEnrH/YlqkCpLUjpjKXht+MzKTunyNwPiQqzCHRDkyg7z7ogzxB+7LTX76yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXcihIh9y5ASwQh2INcpxsX4hz8BHPj4tnsZYQP9SiM=;
 b=iwqdO/+JR1xsLx7il5pEdDgWpCLvyWdzVNA7Z4sAyml6MR9hqEOTkEoUFonka2TNwUEbhhaXdgTE1KxtfCmENSJHxnHwfHG7PwUDKAxba1gGLAq1BVOiLCdhS8hcuht4wfDxZDgXwVD+mpH8v8zV+RUgcayvHqEkKzb2xdbuPUOV7hh/xDb5T4H9qc7gAvVsh4vJQT8rD13EymsUZrwjdWKt2qwg3h2qPRDc8Gy9hv8Q0MukiTthYT9HW3+aWTKikdFlct1bxZSLW+Kl678HowNL5w8tf1tMSXTw5apax6Gy22W5je3Wt4HIPe48ykDQx8ko5a9+K7/t1LoW+zW5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXcihIh9y5ASwQh2INcpxsX4hz8BHPj4tnsZYQP9SiM=;
 b=FckzXpBB2osuRVcqee257zo8NF7Ef0arY8o55A5T+NHK+/mcLIoLko39OYrs65ilVEutHFD68wg7kS3AWTSZrGiFHUdwpfVIYuQXxSVZ8MAOdihIoq9QYH2R5sI5BtY4RtYdXPIVWuNhUGqFbAxVRPNe5ZrcngUCzaFugN3Pfl0=
Received: from PH8PR20CA0015.namprd20.prod.outlook.com (2603:10b6:510:23c::8)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 22:03:18 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::36) by PH8PR20CA0015.outlook.office365.com
 (2603:10b6:510:23c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:14 -0500
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
Subject: [PATCH v6 17/22] x86/resctrl: Assign/unassign counters by default when ABMC is enabled
Date: Tue, 6 Aug 2024 17:00:54 -0500
Message-ID: <48e7516ccc04715d4fd6678cf00a99ccf43fba10.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bdae0d-6009-4e3e-5e3c-08dcb6639400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFJRfx3i6T6caiCQ+s7a2Tn0XCCNIv1cUUPmfC408YLI7vw17p9pKiTlbrKw?=
 =?us-ascii?Q?K7LcfQhEo9pJxnjdhsobUyw9cBtJFkN90WYalrVhukGypyXwVQmn/sbZI8o6?=
 =?us-ascii?Q?9e3RwVpHdyt2FM1s5qvyje84IiuGGu+1cP692CULjA7jWU1r+VzXQh7pfv0C?=
 =?us-ascii?Q?JR8p9knzpa/FxM7kJVuyddNfCtPP8kYnUbd5tduS70zlEO6qyPHSNvbrz3P0?=
 =?us-ascii?Q?hvdJPPirUTzBQqV1/E1MfSbwkJCYmp2r0zDCav9dJ2s7K2KolsVgWjxB6n1N?=
 =?us-ascii?Q?YChp7OF3ROATFPcglBOMjhTL0vjfuE8riP3o19faCU4OCddkh5owaAm2T2vt?=
 =?us-ascii?Q?UWImeqfIpqtNIoyAguXUdml+82bf1oxO10sVyk4hK+WYP4Ox+QKGP5ZLgfch?=
 =?us-ascii?Q?YwDpBLkPr8xz/DHHHsDvaPdAvoJRDC59EuLK9hxsOe+vIDBFDvsCNCAcEiWk?=
 =?us-ascii?Q?5s7kk/CdAKE8YzdeJeMmxdSzso/oPeWQXw+xB+H3FutNKyrLQxJ/5d+x7Y/X?=
 =?us-ascii?Q?ZK3Zo3AHxO6nZqsio1dxSmw4z9XhJFXi4wT5IF/zmp1SvyZpXWplOP6yk2zz?=
 =?us-ascii?Q?AzAvAiX6dPfKUyFx+RvwVU8zWKJ6id2VvZMZFQX2Mg/GcHRl78TWYNXHFlUA?=
 =?us-ascii?Q?6U+Yqi3lpwLUWHN0zvUJOfMwKQPmFLk8r1gYWn4lOo34JxfH9kO8ZPc7ufGH?=
 =?us-ascii?Q?OqC8Ef8fGoiQgEkbdwMLzuzcKYmdNniGmuPkp/4LEwvrieKuaP1XAXZkgF9N?=
 =?us-ascii?Q?2IHJ+TC3JjUNSoMyVmPqqLiFDkq2hWgqgF1rTmoz4oIA7hlmHIdudQ9aaXgd?=
 =?us-ascii?Q?nE/L+u4HP/g6z+7iQdU2s0UkawWyo5HFUWtDHliVX7yrUw8dsSKILI44U7vq?=
 =?us-ascii?Q?Tr1BsBv6jqxDy+BMDdPJPnZtWxtCs2SmcNkcqXGtNRGi8oJZ3r6Xqdwue+xh?=
 =?us-ascii?Q?jYTnQvykmAGe656f+59e/K9rmQ/VLrhiQovd5i50ZaQSHWj/kPtxkixeNJUf?=
 =?us-ascii?Q?Wg0Pe+sq7CrEbDE+2+GIcfZRVShihvqwtcxKTWa5B/uGQxNwrVDsrjLGWqk8?=
 =?us-ascii?Q?MNZwPewBdZipFHGuS/Sq8lQyAWp18eWJZ98lyDpPS4rR+6MlloczRAte+bLs?=
 =?us-ascii?Q?aO9BXqIRZflf4346AQzbP7e4afsOasZr8jdJ14azH5dyZ1fHtpYbRdD43aSI?=
 =?us-ascii?Q?HbTcydeaC2+xhFynxbQ+bf8+FiRmU8dLqjjjbN3IdKBBXhJaXYbCqZOBbD3M?=
 =?us-ascii?Q?zoegn5UCwSpJd6N/J9EWxPjQjhE5MoxZGTVsD73PchvOvME9ttBD9JPi42bH?=
 =?us-ascii?Q?iSk93FFf8yVMq2E8Gveltj8MrPPWap/n1h/lScJxNdiFMnnNPyIMU8V1/W2Z?=
 =?us-ascii?Q?cEu87UYUrwjba5wXBY6xnuHxTUZ0WZCvb12/kQIn+LI6MJLAW550A52J18iZ?=
 =?us-ascii?Q?YW1/5GuV/qT7rYYkUdfJc9pRSDpDRe5w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:17.9587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bdae0d-6009-4e3e-5e3c-08dcb6639400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

Assign/unassign counters on resctrl group creation/deletion. Two counters
are required per group, one for total event and one for local event.

There are only limited number of counters for assignment. If the counters
are exhausted, report the warnings and continue. It is not required to
fail group creation for assignment failures. Users have the option to
modify the assignments later.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0c2215dbd497..d93c1d784b91 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2908,6 +2908,46 @@ static void schemata_list_destroy(void)
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
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2969,6 +3009,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		rdtgroup_assign_cntrs(&rdtgroup_default);
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -2999,6 +3041,7 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
@@ -3258,6 +3301,8 @@ static void rdt_kill_sb(struct super_block *sb)
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
+
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
@@ -3849,6 +3894,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3893,6 +3940,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3918,6 +3967,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
 out_rmid_free:
+	rdtgroup_unassign_cntrs(rdtgrp);
 	mkdir_rdt_prepare_rmid_free(rdtgrp);
 out_closid_free:
 	closid_free(closid);
@@ -3988,6 +4038,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -4034,6 +4087,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


