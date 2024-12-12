Return-Path: <linux-kernel+bounces-443884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B69EFD25
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8677B1888033
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400A1B0F09;
	Thu, 12 Dec 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+wAl2ef"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF71CF5EA;
	Thu, 12 Dec 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034611; cv=fail; b=BQ+Dw7IXiBJ9SJB8YGEKNNj5GJ+pWYwkiWwCBUcfLz8gaZCwZq8Sj4MpxrsjN2z2Tw0ce/eLjsJQCf/ymw5ZNQZcYiQTsHJIVW7/EpY2FSZy/kGC8vvuM61CcG2WMVKEzGWgN+X+DZR3Xq3BsG7zT0/ZTjtHwfWLoWEnizaXrHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034611; c=relaxed/simple;
	bh=OUqEz3cbxVfjn8fPe697PIUTqXVvHGnwx2YDgJtpeAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjQ2k7l/pglVeDfYFkj8uLjmgNJnEK9Nb10kTnDwxxipaaN+XNHGLgYFm34mnk4f9wsHZRgIptapz0M4Ptpap5m+gGzf/5HmKJYaxOfzFx3YS6Otd1dsuOnTP6PO0CH8L31W4cW2TAVgsJgAE96KO5XAlHtIMhkJO0s1/E0yiuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+wAl2ef; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foY/Xu2xSjlTUIbCg4YyrBdC25JbItPhVy5xUnCO1plZAfPAgsPol4FSziM9pVU7G6/xg7RqeLniU7aJb+KNpFeKrU+oJCYZtnX1QBGzcmu1DLDZUjc48JJ1XBQJ9QwyxUWBM/farlh+Ro4UkF8moBzOkR7bctmTPEXdnopZumzO8uleDKh/M2vjyyjJ6lvcfrnQw1VOt18KDzRUwIfUmF2IFI+ChzJgWdexsrMFogk1896voJSY+zHJRpfgxwEayiEYDWX3bp57Mrd9aL+yvl4CGPDmHWS3PRKNVYBbf9GZ7NJdjAnCX35GVKaQXy0M1LkzkRMG2QWrhZFkSFhsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93SAjDOq0xUmX7qQn/DFwCINc++dycULQ8dN8GXgmb4=;
 b=uSkQLgk+MolJZOtJ/ZVFSRj9jcwMfNn++gRzu0DCT327rtJxlAM+mvdIr6ml4I46hbNycTuFZ+SCY5FrjdRy/3T7RraRNCryAln+ZY0/ILHxZgrS05HV196nBh5dRQj4uJWPx5aL6G+m8Fr44+ZdVhDBfsxqhoGpNFJTuq8a9vKnIUCG7RiKFJevatkLL6UZBpWT/y7bK9IRgP761KYR5BiGskLOiARUexIlrhfvmYp4m1fe5Hb72RuFj7IwcUuZYHE2kxVF4wNKtErm7K0Ilib2Ns+hK/b5lv9ErhMr9ppceKCjMG0DJQGWyq5Y9U3bxZSI9LFMaJ36MZpEQkVzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93SAjDOq0xUmX7qQn/DFwCINc++dycULQ8dN8GXgmb4=;
 b=T+wAl2efIGeT+Z8aUyAPn1yiGrxzE63qrS5tFF89+Qh+fXxAeNIxEfImSMFKLwlXgm6wpoAJ7qqWkoBZFZ3qgF8NaKdFRfocp8v1V4HK0IjvtNPZE7qaTHkZsmzRTnZWYET5o2LYz6ypat5crLh8+D3NHj25CUF3VBOdWVV0MXY=
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:16:46 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::ae) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:44 -0600
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
Subject: [PATCH v10 05/24] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Thu, 12 Dec 2024 14:15:08 -0600
Message-ID: <94e33b82999c2e97d2e3bf23b200a0a1a18a2b07.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: eae7fc71-e834-4646-b4a0-08dd1ae9e6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WgogRVCt13OofzM2L8VzgvXkkbnb4Kv8gDOlym3yVEA0RCop6PqXX7hWYpxj?=
 =?us-ascii?Q?dEluk1o9Q7eShcrGS3SGvWrNvQUypLePCwzh1fIPqZWauR6hsQOji60vulyj?=
 =?us-ascii?Q?tqI/hG5wW4g3x117UMpygh7Nwuze0vcOG+aQ8J2yDaEEJCvmttY0o8e25QP5?=
 =?us-ascii?Q?B47szakQYhsLPSMlGP2yu4ND8wbJ69iyCysuYt8keXSDQSwY2eCKaGoPgHJ8?=
 =?us-ascii?Q?TXSHGShHtN9n7ipPMaHm0U+KqWr4uzNP3lv2ZdBnSS7YlyhYsF2xiqtSMXK/?=
 =?us-ascii?Q?HOR+OaoGYjo2GV5zuPvxlA2kInAtzuLIqFIJHwAzW00DPYr9BGOyijZmgx0V?=
 =?us-ascii?Q?NP4zgdmPHTzndrqe1nd40N3OZsxFB+6WRmRu5KkYwRdYTWQFWv2jnBgR14GR?=
 =?us-ascii?Q?+3M9qCbkeYIGyevndSiS6u2x7x70y+kvAEJQmfFcG/uwDfRiTznfrtcN5OX4?=
 =?us-ascii?Q?hLwnrFcPJBNDR6xt2Co+AWpvyIiCNkk84qiw33R2xwiOwzT4hW4xuOaB5Tao?=
 =?us-ascii?Q?1BNAkNiJqw6qIhj5zZR0Nz2WdXB3Pp44gIsUxWvTCy0sIJ4uFRNzqQKE83y+?=
 =?us-ascii?Q?x7rK4EvWNq/YFW+Uw/bNZNeclRaVHIBoEuZSemzQqSBzITgtyAUZ1K4yhKF7?=
 =?us-ascii?Q?Wk421hBvSewYH5O1wVBCOiFTV2F5lanHWq+YG3iZqvG6ePqpSW+c0SEa0XxQ?=
 =?us-ascii?Q?X2ioVOGo0lVLZUxUuKxrGsPPXpsqLD88KLbgMz2+bdEu51pHjtWeuqrlomHn?=
 =?us-ascii?Q?jeK2GqSiI6oor1TP1eq0aXcXS+43gSptcMazOf7k+rUnSy04n8fihmJgrvIz?=
 =?us-ascii?Q?WKJ27d5LS0ARXnUujQ0aBUgHDfhQZuI3Z3k4uQyCtGG6ptJtMipon1fzWFpo?=
 =?us-ascii?Q?B6rATrIVy19Mp3wCVCeARRu7RYHth6pyJV1zQyz4YBXgueHjvqawHmiKP3zq?=
 =?us-ascii?Q?BjV0pVkZDsEvJqrxk55MIDNB9wnMYOjtpcYtBPqG4yS9DIHIAjH7ymkEkIPD?=
 =?us-ascii?Q?DbQeTbIoTLHFbOG3eLLHave4oCTHxJDkgl8tHKaTEDB0xHG1GQVsMBcF6I+v?=
 =?us-ascii?Q?Scwilb/5Nqk2OxpUmuBv/APh0tvSNPn0dH/x/r99X9tbdmHzkk97S+hea9EG?=
 =?us-ascii?Q?8dQIrkHSzyPhtDnuApRKpFQzz1osJOFQwmsvFZSRDhGO8CyGvGKUIXJ5j4u8?=
 =?us-ascii?Q?8DfkpHPh05LqNCXdafwcbAX0F0WXjIi8Vop1Gyf1mIZGEQjVWnhSh2f+7fNE?=
 =?us-ascii?Q?QsYLjWQ4bTjMyTzsxfm465s3K9DfqJC1im5WFfMIgrPxErkAKQmr1BHzgait?=
 =?us-ascii?Q?fPiOuTe1xIupQSR5w3G8n5K4wdSK0Vl1hrdLu5yAZM1BZEouiABivUSFphMK?=
 =?us-ascii?Q?zDcN2g6G8ZMS0Pcrt1IlAgjquy5pLWxW130X5Wugdp9BXyYS9c4pvDhJjerw?=
 =?us-ascii?Q?yDJCJ/u/7cpAOVyragzadgAl5Xz/Q2P6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:45.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae7fc71-e834-4646-b4a0-08dd1ae9e6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable monitoring counters supported.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v10: No changes.

v9: Added Reviewed-by tag. No code changes

v8: Used GENMASK for the mask.

v7: Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the
    bitmap. WARN_ON is not required anymore.
    Removed redundant comments.

v6: Commit message update.
    Renamed abmc_capable to mbm_cntr_assignable.

v5: Name change num_cntrs to num_mbm_cntrs.
    Moved abmc_capable to resctrl_mon.

v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
    need to separate this as arch code.

v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++++++
 include/linux/resctrl.h               | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ec2a237321dc..36df69da99f2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1230,6 +1230,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->mon.mbm_cntr_assignable = true;
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3c2307c7c106..511cfce8fc21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -185,10 +185,14 @@ enum resctrl_scope {
 /**
  * struct resctrl_mon - Monitoring related data of a resctrl resource
  * @num_rmid:		Number of RMIDs available
+ * @num_mbm_cntrs:	Number of assignable monitoring counters
+ * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
+	int			num_mbm_cntrs;
+	bool			mbm_cntr_assignable;
 	struct list_head	evt_list;
 };
 
-- 
2.34.1


