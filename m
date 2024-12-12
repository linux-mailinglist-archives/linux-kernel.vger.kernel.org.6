Return-Path: <linux-kernel+bounces-443889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C289EFD30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E15F28B939
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB11DB34E;
	Thu, 12 Dec 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X031K9Ni"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769D1D95A3;
	Thu, 12 Dec 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034642; cv=fail; b=ulja84Bk1+jsoM5UhrCl0b4QkgzrAPhvt3qFQnC+8L1XNZoVZX2loL5l1cuGfLIVnwSXDycjc09zK2YEjqH/zczLYZnRpq2IfH+kXwXlkcLyW1bOsLOM3EyXoQfvdiAUyLYuIXgrsoGNbZImZjPz9qR80ByZck94bOwQ8SnS330=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034642; c=relaxed/simple;
	bh=gUibFcROvCiPWAAIMuFgGFdO60K8ytZsypuAThBXG2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSG/lY5bXOQyMW5gxAm3bL8Lq+6CGqDjsyKpv1PyZZBS2D8dPDRNM8vU+Atf2dTQOHORwhbzDnvuNYITqzc6f198pH4T7d413sWCAEy3p4JOn0fwNhcBSkGvVQ/r5qsi2ldI2lIT3adZup4gC5Z+PJivOaYSooWoujkxpO5njTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X031K9Ni; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggDAl+LMAaDgAbnxSQd1ehcUuefk+MyWMDop46vP4H6Ks3XwJFpDDx8EHYyVAvHrjRNMBnkNP46hnt17uGvTtcviSA+a1n4XNA7Y/UCaomHIa75QUcksN4CQCuIL19+FAaDSTKmc8wxZjWnKXWtfMeAlS4UcgM85JnEpeZLFe1RQzSL2qqeNMdDSoWiDRinFXJA11PQMzqkQAQb9SyAgZIwxXgV/GhCCd0nFXNLp/kGeRq+DIdjoKpBiDV+x8VOxnPY0LC/gPA8qs1EQIV+4HRBewd3pBveVY5QRlRUcjRIwiUHQgw0Msv7/3JygwRKa9QlhFeFGAKNkR8qDy7cwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oACPJYVWp4G4Sukrtg/LLFUjTnIvsWaYawWJXsunEdA=;
 b=mVq+Z43pJPTLzqkg9LM1p9hbC58V9XWtfjHE8XbnZY0sWRUeC2wI0dT/kz2WenAith/jh327hR/yOkkhogilhUdzRt9gFphjvn84hy59hXCqS1kTrx1StaEdJ0R3ICoSIipjcwcjFC6sM+dsV5V6O9ABdjYsXTiotiRwMfCB0qm/JJTfmU5xtjOWZl4hdG86xCiQJ7XL8MYG4jGcYr9v/1EEdK3iW2WuKTX8OR93K2JVx5VKx0C0XF3BF8Hi29Je/XrCWVa45gn6t4C+Q1MQHOBjGxEaA4BvqT4cmLUPDft60rej+bCAsRAPmHbULVdLp1UBlIw4zlwmhtdaCgDdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oACPJYVWp4G4Sukrtg/LLFUjTnIvsWaYawWJXsunEdA=;
 b=X031K9Nij7SQ2hRIiMhH+DpOL+sxT379Hpb38lbQbkSya7WobXEBcArB1aQAR4FtomumrjjJUEzkeK3BwGb/41J3IDIcD2OSSmGxz6IQFqqoOrKbTMwhIsS2cZmxznnCfJpXJceMMesXG24/wf6c1F2MDznirLWPPlFpEG/vhJs=
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:17:17 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::7e) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:15 -0600
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
Subject: [PATCH v10 09/24] x86/resctrl: Introduce interface to display number of monitoring counters
Date: Thu, 12 Dec 2024 14:15:12 -0600
Message-ID: <5aead3f35b7799239b8f9952675b4435f6e7644a.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: da96ce8f-92e0-4dd4-07a8-08dd1ae9f975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEEC2+DEvWlMdeq/S0C4Eamju6kxYHdV7z4OVetuwZu+qMjT3Eu0uPoH5766?=
 =?us-ascii?Q?/xMj6Aao9tPYq0LXpLJtvwlxtHTKTAVDszDGJPCjBRcmHmVUih3OWYKMiSme?=
 =?us-ascii?Q?UZPeG4qQOKxyZDUALLx5QQd+8CqRHYYh7/lkGQq3IfepM5+aRY5p2q4sofUb?=
 =?us-ascii?Q?0befSy6skMTrsYzf0BNGqtFxEz1h6Dhr6wTr02XTBy+oIALj4UGzI/OnUVi2?=
 =?us-ascii?Q?cha3JRAURMSrNvexiHobYKIQwUeCoe8SuOc6DXxCxkIgEsjGuWvw7NqcumEg?=
 =?us-ascii?Q?5dIYczsLwGtttYAS3LaR/ZQaDQHbHwRfyF1tfui7GHVCgus2/ZqUAz6LRXD8?=
 =?us-ascii?Q?KakEEgdfoh1/4rJYLQ6ezIBEpHp86Un2XYxpmICRALZ0KcshMOhp9K1UtqpD?=
 =?us-ascii?Q?vyAA5xfni/LkBZxFX1BtUqaHujuMUyxZgUzMC8w60BAvtFsKtAhDHwoL0i8C?=
 =?us-ascii?Q?ROlMDTlKBzJWIYyg7GX5iKdNlpOnAtzCq4gZXhbLWPmkPjVJkqhcqSBOesHL?=
 =?us-ascii?Q?LkAVPbQR4z1pOQrv+D/QsFBBG+WrhITvl1I+WJjDkwSA9ZUkr1SOtyWyq0FF?=
 =?us-ascii?Q?z6Va1hVgDq5gOaEMUXi85jzLMbGiQRArj5QD2+bCg/4x01KGyG6LiW/WjNRE?=
 =?us-ascii?Q?mY4GyVkNpz5vslzaFRaTSbuLCQ9M/OihVYcBld/Fh6ff6jl5Zl/ckwz4mfw0?=
 =?us-ascii?Q?eqHdmNN2T2qChO6dXMXCQ1++cM0YFgc46EYMZvINJrLV2J0Mwpqb5Cl1nlxm?=
 =?us-ascii?Q?CQKDO73qSpem70yc82wnj+K/dw11Gv1NyQiEGafemBO+wAx9Gr3CdGJ/eBPx?=
 =?us-ascii?Q?W8mrhq6j438tBPpjj9euGLRZgPtKKJ7XC5q/MiPCc1KCfylLUm5EpPoGGx8a?=
 =?us-ascii?Q?XUF+5X2w+IRzScvo1G/zuryuCJqXJkWWi0Wf6GdiNb0eBd+SIZze5sMcJ/BC?=
 =?us-ascii?Q?pKKSc9RSXjw2dzCG7XrHmuUwIZlWosuijVOSvm6T5JN8uroBB+ETiO0KhD+w?=
 =?us-ascii?Q?1eSoStSl+NY/Jyf1UT8q5Rl0YQbxKhdMPqtbTOIJ2hIxqAgylyPwcqLd/nkM?=
 =?us-ascii?Q?unPvSDW2wyEY67uDhMYYlT9jV+0jxSQC4fppw1IinzfztbwUscmVv1KtA/yD?=
 =?us-ascii?Q?o3y6Ss0gUy497uFaP8SLpLuGIyrfKcGLmyvO1r1PmsV4aVLIvbTvtVuiVx5+?=
 =?us-ascii?Q?Rq6yz0iAGhHCcKh8rD8rTHt7+NGINx9jjepM8zLzrkFkPCbG64fu7SBhQ0oR?=
 =?us-ascii?Q?0PGcxKju28udku96hvHuuBQvp5zLKPcR2RTSzxf15kHgx4jRpWpwcg3nmE7A?=
 =?us-ascii?Q?x6S03WSb4p1+9KQT3OsobelG1cIcSR6sEmFJcRl/Es94WdGG86q2tAaLa678?=
 =?us-ascii?Q?mT+1djsIQwpx+Kmo4KZf1hhrmPBeQKtn7VfVYPKOqUst2W+k+JRMBzDgmB8X?=
 =?us-ascii?Q?rw2xVlXKBgaOzAnVDhedmFsak5iWZF3K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:17.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da96ce8f-92e0-4dd4-07a8-08dd1ae9f975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046

The mbm_cntr_assign mode provides an option to the user to assign a
counter to an RMID, event pair and monitor the bandwidth as long as
the counter is assigned. Number of assignments depend on number of
monitoring counters available.

Provide the interface to display the number of monitoring counters
supported. The interface file 'num_mbm_cntrs' is available when an
architecture supports mbm_cntr_assign mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: No changes.

v9: Updated user document based on the comments.
    Will add a new file available_mbm_cntrs later in the series.

v8: Commit message update and documentation update.

v7: Minor commit log text changes.

v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counter.
---
---
 Documentation/arch/x86/resctrl.rst     | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 1e4a1f615496..43a861adeada 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -290,6 +290,18 @@ with the following files:
 	"mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable' if
 	there is no counter associated with that event.
 
+"num_mbm_cntrs":
+	The number of monitoring counters available for assignment when the
+	architecture supports mbm_cntr_assign mode.
+
+	The resctrl file system supports tracking up to two memory bandwidth
+	events per monitoring group: mbm_total_bytes and/or mbm_local_bytes.
+	Up to two counters can be assigned per monitoring group, one for each
+	memory bandwidth event. More monitoring groups can be tracked by
+	assigning one counter per monitoring group. However, doing so limits
+	memory bandwidth tracking to a single memory bandwidth event per
+	monitoring group.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 80be91671dc1..c23e94fa6852 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1237,6 +1237,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.mbm_cntr_assignable = true;
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f25ff1430014..339bb0b09a82 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -869,6 +869,16 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	seq_printf(s, "%d\n", r->mon.num_mbm_cntrs);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1940,6 +1950,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_cpus_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "num_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_num_mbm_cntrs_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


