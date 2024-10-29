Return-Path: <linux-kernel+bounces-387844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5CD9B56D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF75282CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953A20B219;
	Tue, 29 Oct 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jf9g485N"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DF20ADFF;
	Tue, 29 Oct 2024 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244297; cv=fail; b=QM/KLUJ0ebBScsU5ihBjTQHroBZSluFb0LwRabQgqfyz1LQ56xT0rfWKDkFPXglL64GjxloTC/Dr7b5umjPHxYQgPaozVtKGeYWObcD2L40tKDKDlJehjPVO+V+Y0+Hz/jvBzkfrnNOpY1gzPOvI3JgWYrs+hYMdvfgstP++WMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244297; c=relaxed/simple;
	bh=mJgjoTVeYZiXyASUq46ilYdGUCDXvDZdb66qXm9MeUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp/5M1yhseNYH+KUkjAC1J9Ka7gtZ9IE5qMqVp+IDGdGNMgwPfQUjipE7OSka9WmQlowWcoUeB1UeqvlQgJvG9SRcIvsAat+rPVdAaNcPctlYTYjFSBEzyAYCTFMUjqLJ0jziOiPx42Qd9sG8nivMP3vtj9smEV5T65pc3uyIAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jf9g485N; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVtzXMM+5LUjLlTYeyycYK6Kt02DhdicOEvMEi4ySSV64EazhHDTFNcTyQO/hDtgaHYy1SHllS2k7ScakmBFtpVKDCG8FCshVd44Kd464ri+K8b4Ew8qRT8m8SXykYrZUvNHovtlwdECvGRRfdZnO8FlHqEyQtzefa+70cjEdjD2vshRffa3Vz5UwRf26apOqOw66Y3guuBaDE+7tRye76QCdVm1W8dci+Rwp0jnRvbeeqs+sm0vy5QbgCcwG0rSdFs6IW4yToDTxiV4O/F8an+WVBwCVXnjD3C0bVal2zcRo9tN+6fAHRVGqgf+pL04XVxqCNrbMU1wrIlsBYtpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQT+x6G+HqqBv8T85RQ1uNkuWADklLVvHgv4fIKxfZw=;
 b=c6m0ZDuQbFQHi4eMrASbMLwMIwAN2bOWtUL5DOj7PmbYTqKqQWeVv6pUKoR0aLqlL0HPsRT/quZcepeXEM6hZM+RHowxhYckWkyQqaSZPC8TccdpUaOtxWDXmSvoShjmD97G7KYCXtLINhuYcgyRNgpqlHWnDlaYiVk1re5uRWdJg/Atn3Fy2ubAPp3upytPm3dFSoKvF7uvPA5vnIPtlxZACsVa6Iok8BH0TJEmNLjzbcalNL3L1mKZdzKocLdiXUWAf5GGEaENZIHJOsaAaPI72IhfmY9Ue7KL8TfQoOD3Upim+sLXhUrldd1ewsIAV0CY+vGlDkk0l4RdoEMmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQT+x6G+HqqBv8T85RQ1uNkuWADklLVvHgv4fIKxfZw=;
 b=Jf9g485NuiTSOktvvaC25YQV5jQu9HuRtTIpaW6Mnbxu1pp52e7JcwAPo2b0DpRtEyllg0zNN5ML7JzrqBctwimNRTqJhPkSrn9GAcn6xWBJeQDA9/wEodmKkDWy3Ic7ouZpAW6SHDRAZzAkAG3aPoblwd/ujxRSYQuTRLDft7c=
Received: from SN6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:805:66::42)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 23:24:52 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::46) by SN6PR08CA0029.outlook.office365.com
 (2603:10b6:805:66::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:22 -0500
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
Subject: [PATCH v9 16/26] x86/resctrl: Introduce cntr_id in mongroup for assignments
Date: Tue, 29 Oct 2024 18:21:48 -0500
Message-ID: <be93dbe464747ef0b6e3158aacbd32499028cfb4.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b16ef3-3926-4844-50c1-08dcf870e40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMxAIqaob3R3RNMhREdgmoAE+KczyIt+iFaWIMRZL4TxO4S0z2lwzXCKEYU/?=
 =?us-ascii?Q?OUjWLb48s/UhVIDCnfHS0YfDjSaESq5W5eFBh/UHtY2FDxXdEpe2OjIP2Yiq?=
 =?us-ascii?Q?nG3/htcFMrkoDYvQ/ZioDxaHuGbi1+TxOnLie9LEKaQBTyW8LJCmWZq3YoMt?=
 =?us-ascii?Q?AQt717ZsXM7uJymaI1U00wVRGHbmmk70ubQ/EpfhT2qDKwTmLSdbe1LNOmY/?=
 =?us-ascii?Q?ATJfaedbZGG48EciDRKOU0/09NEcwjx3R/vDeyO1gACjUD67utYlvy7BXLip?=
 =?us-ascii?Q?T9qilq1LexSnjWf/L5mNQtvSEj8lra21fj8T5BwV61Nc8v3pDUOxnnUJrG7c?=
 =?us-ascii?Q?/H5vIh4M9wVOd1FjcYUsf2xgWxbDj+dDU0bfnvjYG61JuwiVHfuI4NSoBARv?=
 =?us-ascii?Q?25eeZ91sIUa5/iA8oHsSAHv8v7OoSffCDbVSIzNkAKl2+OaHffWpMuQbzh1A?=
 =?us-ascii?Q?NTWxU8344c1P1uB6EQ099xL+UPu9EwbGDutbgO3DdvzNMTTCpV0bbkkQ6Tbs?=
 =?us-ascii?Q?NU7YeOx2h3NpcNx15+Kn0hD1ZCQ88HrFvE+RcgfRzc/krCdGpNNovuHuP/Dd?=
 =?us-ascii?Q?B55O53ephE7C70YDSrGitzNCFS+e7Gtk73w2HbRWH9wxKsQzlejrakMLliAB?=
 =?us-ascii?Q?KYOyGv6XHxEk5AqDlIXA89G0OKAcJOxol9LRKX+jPO2YAdeZzSgPI8ir4M8y?=
 =?us-ascii?Q?sQgSrg438PpPaMnRLXVk0xYFH29PP2HA80ADW49V5hIl/Moro8RnWYOz+1iO?=
 =?us-ascii?Q?qAP9eax0QxtbvV/uVlrOj23VfL231+EMVORmgS4j6+369qUkZmOpnHZubR7l?=
 =?us-ascii?Q?Z/V9ESmuhtVgRae83qmVbwBsHADXTTuurvQDb0W2GK5XnrEKEW1ZXz8zuic8?=
 =?us-ascii?Q?gVU7X3XAb9oYbQFPa/xJ/lZMUdt0OPOOPxlPCZcuQGqpdz7TNBe/paAVhS9O?=
 =?us-ascii?Q?x8lOGgyaF2nrsA3sK9A6LWJlbhWDtZ9I+ArD/rp3NJN7D/f8ZESMqPOThUWf?=
 =?us-ascii?Q?LIhJklkE+gZSFiflGQqzmIW2EVFDa1JfMkOspWU9Xqf92EQ1M3IwXq/q3g9Z?=
 =?us-ascii?Q?3P1JQ5Vw+3COuFv7wDK7E/HXj2leHyGTuU6Os1GidFOcYkuyDaEauWHilt3q?=
 =?us-ascii?Q?SlhW1byXZg1YYMTGTOk40K57wSppvwAJ623QlFQEGZsBkwzdqiSfNGRYsLm0?=
 =?us-ascii?Q?94o6qA5KYRYIXrDKHDnZgWX91xVx7Xm61y2vAuYlkMVUtHDI02vJqC1EVGzh?=
 =?us-ascii?Q?9rFXw2Hwgm0FhOQ1s5rIflLdlsM6jUKjNalf2YDgTiE6Nxx+d0C+mS62700D?=
 =?us-ascii?Q?Z8Eesuro79xJVcpwJMO8n0gqW8EVWaep5BHAXjFVCv51Dci5fUs0EytnJ32J?=
 =?us-ascii?Q?z/uNBKg5oCepNmY1wVLioaIBFsrp3ScTNKHnBnqE/EoOAvyrZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:52.4802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b16ef3-3926-4844-50c1-08dcf870e40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

mbm_cntr_assign feature provides an option to the user to assign a counter
to an RMID, event pair and monitor the bandwidth as long as the counter is
assigned. There can be two counters per monitor group, one for MBM total
event and another for MBM local event.

Introduce cntr_id to manage the assignments.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Used MBM_EVENT_ARRAY_INDEX macro to get the event index.
    Introduced rdtgroup_cntr_id_init() to initialize the cntr_id.

v8: Minor commit message update.

v7: Minor comment update for cntr_id.

v6: New patch.
    Separated FS and arch bits.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5895ea72fc26..d1f3f3ca4df9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -62,6 +62,18 @@
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
+/* Maximum assignable counters per resctrl group */
+#define MAX_CNTRS			2
+
+#define MON_CNTR_UNSET			U32_MAX
+
+/*
+ * Get the counter index for the assignable counter
+ * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+ * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+ */
+#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -231,12 +243,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @cntr_id:			IDs of hardware counters assigned to monitor group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			cntr_id[MAX_CNTRS];
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ef0c1246fa2a..36845e8e400d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -925,6 +925,14 @@ static int rdtgroup_available_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static void rdtgroup_cntr_id_init(struct rdtgroup *rdtgrp,
+				  enum resctrl_event_id evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+
+	rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -3561,6 +3569,9 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	}
 	rdtgrp->mon.rmid = ret;
 
+	rdtgroup_cntr_id_init(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+	rdtgroup_cntr_id_init(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
+
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
@@ -4115,6 +4126,10 @@ static void __init rdtgroup_setup_default(void)
 	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
 	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
 	rdtgroup_default.type = RDTCTRL_GROUP;
+
+	rdtgroup_cntr_id_init(&rdtgroup_default, QOS_L3_MBM_TOTAL_EVENT_ID);
+	rdtgroup_cntr_id_init(&rdtgroup_default, QOS_L3_MBM_LOCAL_EVENT_ID);
+
 	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
-- 
2.34.1


