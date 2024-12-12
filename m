Return-Path: <linux-kernel+bounces-443882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564B09EFD21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C1C188A63C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D81885B3;
	Thu, 12 Dec 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kh/5SDbn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BE1B395E;
	Thu, 12 Dec 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034599; cv=fail; b=jE89YMxgxMUWdG7Gj1ONvrxZgYRQ3gkt+csslBvo5UU9La3eVd0J2ZqxOgurZYg21h05B0uVkiMEnXJTIpCjBPRw9RttQu14955R/vo7nu3/DoWSzfIP8YZYPjPdGVfMbYZDmUFw4Fl6ZEhHHey4ELn66d9Gx6vUU/p6eEoEjik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034599; c=relaxed/simple;
	bh=1R6H3fgWJjgNC6z5WyJ8pWF2UXeqUT5R+19jYd+8pjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQsw1XdESUPR8O+N+yJZy0l4RPBy7eaQ7kCbY017w4b2o6CZdlgQeG/PbKwff5wteORHRgOaAtCcomDKRta31yFcAnTC82ZJX4kvFDPfssCieTR35nftO4zrsmp7M40UMn0xD/2x24fJfRVMOZJxTrWfEaukEa3CkobnvkgvTZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kh/5SDbn; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVFSgAZkCc6onLVLdoKWJiNlgcLCqoky+z9rkZcnX6WIRRmjkbc65u/f7RNwfy1RmGbMQw5rlakH3dBPziwIrTVdoS5hPJ9dDD9cmtyEwAxGG+7a9rHUn6ptK3NxwA4/YmnO4/SPoVpf8g2VJa+hHDt5hnjDg0PpI5WuApvywzQXLObcRVCzFGPCy1W3ekDkxqM2JQjPM5arPMjdq4xN4juvCQYbmvoGqxA0IJjix9hwMUZ0WYzdgkRd/XYL/9fcjK27EGybx1M+WY9VFhwtW+yFKnhd0AcjvavybqY38JzQl6mrn3xFlwsozfJgoHj7RFV4wyk+jNep+NxGNRAIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nFdvV8c/VistTwS3alyEKLGqWMvSmo2KfwweaGTld8=;
 b=SpgfJ/0sXA8McUSj9n6oTD6l56MJV8e6cdxNFnaq7RaNs6VbuXUKJO5EzfBmb+Va1y81FKt6+UZuAMXQOYO6ii6G6lH0RAL683VLITc+5PAEVEu97EOtvqseLtT/46sAmNrsleshRU2pRSfHxADEhcALtJ5YQcqxLrgS/c8cpDG/XxpiZtYrlfYPbl+weWlnXikzjQd7rEDD5hKqMvAJkt7QmQIEr+aQaAjNa6z5KsvgUPpEsqczOUi1LVQYTnbYWIy9tnBioG29lN816YB9i/p4FxE9+nft7pN6putyUM54jXUuggM4mFz0duRw7bI3ynQQZ24gCRYzwO/NCe79hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nFdvV8c/VistTwS3alyEKLGqWMvSmo2KfwweaGTld8=;
 b=Kh/5SDbn5YNFOX4Cl39lQUPtpSQm9zfGrKcBoVm0FWEzD/KyhU3dEhC/4O54LXBBFryboEhU92AhFcJaCQ+p6NBrXDiBoJMVhzumfEPQZrtwV6/mkM+nIZ13rfxh9nRV3XUWZ7puiIyTLalJpTx6Sy67mF1ec6aWZLELmQtkkFM=
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:16:30 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::8b) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:28 -0600
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
Subject: [PATCH v10 03/24] x86/resctrl: Add ABMC feature in the command line options
Date: Thu, 12 Dec 2024 14:15:06 -0600
Message-ID: <d0102c7a2ecb2094b3ad684247c9283a0c0dbdc8.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: f2824fd5-de92-4665-901a-08dd1ae9dd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eh0ZYdaRR8BlaGswAs67P8R2Xd2CDJMNXVoyglJA9yVIHzSYDjZUHGT16x7c?=
 =?us-ascii?Q?+0iyKxeEfXDiLB3bi8FgjvbkMb4K60JEk7Yen3FJbETBdW7ge1s7+eq211yW?=
 =?us-ascii?Q?pUmfPQoFq51FxTIe/RT3eK+gno/FKjr43BYRL1aEh+ywSZ0KKtrSxvGUrm20?=
 =?us-ascii?Q?FyyqffGUgMjR18QmXSmHBrPMNDh0IJ4nh8XCgtQmclM/B/MupGakmQ4tOy5Q?=
 =?us-ascii?Q?3tIgJPdGh06XPvxHUCDAf49+nIYc3DPSDvLvZRim5xkbxYq+mxTbHov7vXYk?=
 =?us-ascii?Q?VFD+PsBLmZBeu2ot5fzswD03zzbqCHQjgVT6x3MBQIQ1YOS39ypxqOKbgLp5?=
 =?us-ascii?Q?xtMu7oOUDFLzjnx1wO00ARZM2MtOxhmLUt4AqUH2aS76OpBbmrWCjLUh5j0/?=
 =?us-ascii?Q?ONHcF4xFpgHRHoIxSXzx4E1tNP3yX6rDGFLF4ebOQ7elz6q1yPnvu3nxnJ5m?=
 =?us-ascii?Q?z8i+lrfAgJo1d9OHYr4hACjxGPrZfP3WMKAdKyJBD+TGD7Se8Kaze4JhIaFi?=
 =?us-ascii?Q?rS4Hy7bRyfj0LCqGkdsuJkHt2ZFJN77ku/Bqd5uoPrL4WFIWM9MltE75FfDv?=
 =?us-ascii?Q?CimYkyjclbJJJ4t06VL3rbRbhyrKaultX9qAl6Erm6Jwj+2OR5CELBj4dMOx?=
 =?us-ascii?Q?pMqEpcWNv7iInbW3VMq1kBMCH/VUHxK9t6ikxZdftIVbDHeqdHvAIBjq66Ki?=
 =?us-ascii?Q?iYwwWL+nQbxyWDKCxCB0UiKy2+XxaWqIi/etp0u5GG6kn7EBCQG2DWpQW5sY?=
 =?us-ascii?Q?4nKn3oum/FOm8KmjfilcFN9XZYpWO9+89yme4MEC7EbAqOlTXAX3AUOgLXzv?=
 =?us-ascii?Q?xyULzhYvLfpU2hoGBtagBXOwoQypX+quW0g31YgsWPuMV+Cw5ISPIJv8mBAp?=
 =?us-ascii?Q?1THziLNr9vx2Lr/qn4k3BEynd0LWP6bK43eFrfAMTdgiur+AqDauh0X1mXDo?=
 =?us-ascii?Q?mhIlxwfDB3KL141DLpacKu2JN7WlRFHj2F6Yght1DbO+WofkQoH0HjMtAomC?=
 =?us-ascii?Q?CiDoHV8HP7nrt/8OLkBUn0AnSlswjPyGDhv7ukSZtqYriNtsON2cqAiAtfpx?=
 =?us-ascii?Q?Zd2M+qtDhxhYrl0JLMv+g8TtjnyL+B2DW08BUdIreHAo+EOb9+RY+zSaR5Yn?=
 =?us-ascii?Q?wcCPkLlS/I+y4QBVl2IU5hJXox41Z5cY2acXavzJNSPW1232weSoD9vtYhNq?=
 =?us-ascii?Q?85Dk2sdvl1dHmVKT9kleO0DV/MDEqj0HO1QvIlMXLvHylcgjv9zgNOuanbQx?=
 =?us-ascii?Q?Trpc6y17hYPfHTmj8u5oGTjv7boDHpcQpxRFQljoz5xT+OO+5ungg8/CwPxv?=
 =?us-ascii?Q?gj3sOIiBhhwj1Z9I8JLXibsjlv2O5i4lkbBFvvZR3Fc0xMVmSDbc2o+3lnEm?=
 =?us-ascii?Q?1AiMUok/olDCEpUoVV9uRaA9ZFjKn8ne657fyp5Jn2NbcFqeRy89fJMS/g/P?=
 =?us-ascii?Q?PaQwogHVfF/0hcqMzy5fsELsIQwm23ZF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:30.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2824fd5-de92-4665-901a-08dd1ae9dd6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

Add the command line option to enable or disable exposing the ABMC
(Assignable Bandwidth Monitoring Counters) hardware feature to resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v10: No changes.

v9: No code changes. Added Reviewed-by.

v8: Commit message update.

v7: No changes

v6: No changes

v5: No changes

v4: No changes

v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7d427d0a4a1a..f22d367290aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5854,7 +5854,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824affd741d..30586728a4cd 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 62f2c5bbe2c6..b3861f0e5857 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -809,6 +809,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -834,6 +835,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


