Return-Path: <linux-kernel+bounces-387841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA69B56C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3102128300F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CF20C302;
	Tue, 29 Oct 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XP1yVebi"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2E209675;
	Tue, 29 Oct 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244259; cv=fail; b=gQb1uur0NIRhPxMz+EA+Y8t/Pf7JCPPBgiMB6PEgnE8AdhO1QQQxKjmubBCehtNW1PzmqJ7yzfUBUv83UTCzZgPNGTp0E/N5BLe6bLc+HMCvcB2EIkWMEOGpf1iawM8Wby34oJKXLMkzJ8zRyW30dIOGsZcJFM6e2d/9Eptv34A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244259; c=relaxed/simple;
	bh=XwZpZpM8kdLmgBRdTsCG+djMMTpPXEvNf6sHZhRMAxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puxwGWiwDJDR/qIsFRE9RTmAf/wA7azmt0V3WjWVnZF0+DS8bN8286m5vZGAeaxpjFI5G/WiQFV/amwoShFxD+/MHT8IQvT9j8J8HuSDx72OfHzJAU4KuUC4nFoDPqnNiOEmGHg9fu9KQNstZ05qGTg8HuihxA4mtnCFw1aCFjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XP1yVebi; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSQqwd/QHVcNXFotusewS1ItzM+doaoIm3CO+HENRxfiEonhIew8bbXYEECyBUxNg9GwSi1Q2HRSvmBQx620Ja6NGnuXrEerCHGu5HUReujsrDusFaJ7SD47QuF3tfBqQxEgob1TdzWZ3AJfOKDQgxRj1QKXOREmk6Y92LP3sXYhKY+1UH8f09p9z7QJXzTKKJJyZUkFyxLnwJ2NgT46fjKOcarWoI6WsYj1wyW/AtsjFC5ftceecauG8lOqLr6GGjBxf1AJETpKagkmlwESRceg4AKnLGJGsCl406nv12zS3Canrzm6V8oSr9NBMhQaNq1qNYrNOPB0vIeX6d14Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHMet9remyTgxk4reXcnkLvXEc7cV51IyQyH2DHDTLE=;
 b=JeMV59KZPL2J3Mt9i7MEg3+lc8a/XADKkm8TgfMXw7BcLA4bl9SuMwGlKuExkwgu3nIKw4E4YfnruIw/j7R1I5kAvzUOwWJ9OhJ27uqn3b28z4MIB3FXfRIv4TWJ8DfAKJ59vNfcc1LNd1GbFvd0LVoSlZK4L8fkqZpHyiESxrgfDal1hEXEMnrVl7aTpYr59qDQuHGZQzo1Q0EdnT+iikPt1FhrvXO6nlhSM5Min7nJBUq8u/Dr70uRX66i9ZDZcWzolIW7LRhD7XJNTFwyfXfBCe6HoUxpz65g9jCDn5DPUisgdHir+VVhucaJymgBWSkEBB2DbFeKdSLhS1YeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHMet9remyTgxk4reXcnkLvXEc7cV51IyQyH2DHDTLE=;
 b=XP1yVebi7VP4m0qQltevz3M5n22jGXN7dRb5WfiroJnWi/NihaLSGH3yl7MQTQGK1VqIMAUa/+Lmtouizn8gy7qbtnwfTjAmT9xcyOg6Xt0mEVDWlUUg2AamukuG90Iwsd+4nJEWTQsq0ZROuBUsD09dtvuTcWOoNrhwnYHr59k=
Received: from SN7PR04CA0225.namprd04.prod.outlook.com (2603:10b6:806:127::20)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 23:24:14 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::f1) by SN7PR04CA0225.outlook.office365.com
 (2603:10b6:806:127::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:57 -0500
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
Subject: [PATCH v9 13/26] x86/resctrl: Introduce mbm_cntr_map to track assignable counters at domain
Date: Tue, 29 Oct 2024 18:21:45 -0500
Message-ID: <8efab1cffec722b5dd8f302f7c520bc09a1934dc.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ace1c98-6b5b-44a9-fb43-08dcf870cd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lh+wNxOHkhXigURLZQy4TkIYpwuvzXw8067F1WQM/cbT2de4Z4H4w89qBfJV?=
 =?us-ascii?Q?HvUYpiI56EubH6YO9ODQO5+BZS6XWcH7Dj99xyAHk89YI/9gyYgLhz7O0765?=
 =?us-ascii?Q?6/IXo4U9MmCOOCMR5D3E5vjHjd/sjhn+LSlOaEiEwkjtJnMkU/+Krxb4CC6D?=
 =?us-ascii?Q?FrA9q1oySP2ot0Ah4ex9uY8Y5SjF+6mg5/LxBDkutmN0+zcPnE58sMI60hP5?=
 =?us-ascii?Q?iKn81qF89LbugyrQtN/s26KTCdlX0ugrO8bP/ZO34GO8iQFcNAa1xFgLEIFZ?=
 =?us-ascii?Q?QXHWOY/p//80yWc4CAhh4fQ8plpd+zjz92aT4xCaxB5DpB4UTXSCs2GDtI/K?=
 =?us-ascii?Q?dQeFZd+FK8VwldI5y7Ow1LLobb/w3pfiBdGWRUrqVSDTwRK7dYhrssS+MFmB?=
 =?us-ascii?Q?g4AwRIJU+sGFclAqKw2wzlt7g8mBi9XDdCVMVgOBKvRRIqKiV3j0I1Su6ulp?=
 =?us-ascii?Q?hGGFwoCBFoxLN0c9ogPhSYH0dHeJN+cuPVe7IvYHqjt/7j4kFtTm2IwjLhP0?=
 =?us-ascii?Q?iFGlR1kaZcF9HX14Ds215pIYobOxsS1uepX6NGTy9NaAYBs6hxrMy8gHfq8i?=
 =?us-ascii?Q?FI2/GB+zzAlIjtsd8tfXWB3B+NwervAOjhlRtpml2I7NzDqwxguGz/so4g5i?=
 =?us-ascii?Q?j0+bQSIQo4SwfnuUhG6M87MJKPgjDCwsOdkIPGobRlT4AiG+iQdfg8l5efdl?=
 =?us-ascii?Q?cqfjLbsav+Ceh/hLuqZV5Dc/Mrvc8oQYwkMWfOo+6TDqfhcUUs4KAKZEw5X6?=
 =?us-ascii?Q?Lj1aH8NeinJWSHY7pDSMs0o9cAsW1vBHN7TuOq1DXVv1B4b3eIgAF+vqTYf+?=
 =?us-ascii?Q?K/BXouUg/Ft4VMTjWCkTMcTQ6flEG6onSvpd3J0Y0sKGzRVBzPOWBt5COxal?=
 =?us-ascii?Q?ruYONIX+AnFjCFKwxzOa+X3u7pBNvinnk49Eq5BBoAHxpueG6pB+gpSogSuu?=
 =?us-ascii?Q?CqXBBceg2p0PkViT2LRDlRB5TJZNEO3agEqJGSJCLZiOnC232i9Wi9FCsdvY?=
 =?us-ascii?Q?BJxEXMQgWcNKNVF4o/vvySMj+U7R/Ls2tYNsc8gd7sxAhpyLA3llSDaN05qu?=
 =?us-ascii?Q?QvYXyjjGWBkP85qfIWcotbEqGbuc+fvILg0X0OF1FOx67XBJE1v0aoybXlQk?=
 =?us-ascii?Q?YJADFtIMRfqW2GjHSKIbb99lfzZvV3KaxWQhoJSNjP2n5M0F3R8Ja9abQzyl?=
 =?us-ascii?Q?wc5csdEVSCSNs+iGYQNhq1PRlhSKkjYiXWazcG8sYhnlq9pKJJoc/YrbnEyQ?=
 =?us-ascii?Q?oHRmt4feffoP1wi2yrJpZUf26s/YtjHNGeQ9Rlg2akrykmu89MvoSCMnDuOB?=
 =?us-ascii?Q?Ml2/hac2OejPaYTx/CgqCu0Q7tNPWmi0XT0pZVXzkKBLU0V6Y8ZZKQVr01Z6?=
 =?us-ascii?Q?FKarwRm0cvR3727qcm4TMAUomppw/OrBj6DG317dwiWBOyWZbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:13.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ace1c98-6b5b-44a9-fb43-08dcf870cd13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

The MBM counters are allocated globally and assigned to an RMID, event pair
in a resctrl group. It is tracked by mbm_cntr_free_map. Counters are
assigned to the domain based on the user input. It needs to be tracked
at domain level also.

Add the mbm_cntr_map bitmap in struct rdt_mon_domain to keep track of
assignment at domain level. The global counter at mbm_cntr_free_map can
be released when assignment at all the domains are cleared.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v9: Added Reviewed-by tag. No other changes.

v8: Minor commit message changes.

v7: Added check mbm_cntr_assignable for allocating bitmap mbm_cntr_map

v6: New patch to add domain level assignment.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3a3d98e8ca28..654cdfee1b00 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4091,6 +4091,7 @@ static void __init rdtgroup_setup_default(void)
 
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	bitmap_free(d->mbm_cntr_map);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -4164,6 +4165,15 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			return -ENOMEM;
 		}
 	}
+	if (is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		d->mbm_cntr_map = bitmap_zalloc(r->mon.num_mbm_cntrs, GFP_KERNEL);
+		if (!d->mbm_cntr_map) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			kfree(d->mbm_local);
+			return -ENOMEM;
+		}
+	}
 
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 70885a835acb..0b8eeb8afc68 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -105,6 +105,7 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @mbm_cntr_map:	bitmap to track domain counter assignment
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -116,6 +117,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	unsigned long			*mbm_cntr_map;
 };
 
 /**
-- 
2.34.1


