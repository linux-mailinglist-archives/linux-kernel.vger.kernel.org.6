Return-Path: <linux-kernel+bounces-188670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D238CE530
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED25D1F22C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135968627E;
	Fri, 24 May 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O3TeNYYt"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3B86267;
	Fri, 24 May 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553451; cv=fail; b=pWa04hNP5L/YeUkUZAQWSMa8fFYkI8u0/7g5TLLXIWAXtKdHW9jct9dmzu9YaaYjgcA54FCU8ELGx0Y56X7q/Kifd2Ewc/sTq+uY88ezSu8jh3jlv4C7pQfFTSXg9oUbptNHvaCrvX9BkwOwbsUNEG2slSJnlGsM5Q4CW87wSHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553451; c=relaxed/simple;
	bh=0gkAXW1F+WkP/hYsNPyT0ESc2TiFocgHGKhEvmStiHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAx0H0rjsmovYIiADbCEt1Y8baPwWtKfI8anQBV+Q39W7/KGXpL30AS/PGmzosAezg00vKsk1n1zLwZ2jo13Bums29GaYf5tsE0A8/qKwbT0FEqMLMj9144WoESYWsAcyGYvaXFPjOyWLNksdVTGgJlGyVzXVartPEHvZ1jM1Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O3TeNYYt; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akTC14HaU2NUTNCf7Xkjd4K/g/lC+pui97YR6EJpGMjkvyEX07dUlBdjZAdWi7RajfbidLskXabE0k4ZfTMTo9d+fFd12WKrRPgtYVXVUp11qsTS1xMwQyNGPM3iYY2YGOL2A2KSIN20f4HFcsQkL/7H59QyGNFVD3AUxgZ1UYu0ULz9uPCWcln0U9NHB67THqnIGAzFyIprjjow5XeCEFJyIqLNRR4ouapF0DxhWXIuWfEZurYpNNIEmJcOIgJypOuRGLGNzZHXV4peQiKUoTuqw+vBSg7xUjbNa+Hy7vFNduWshGNleDteQPjiuUiUGmJzZtCvpl9butIbPWysNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGuMHdE8aOyUL4nA0/4NfPMzIict+AyGtOVRed+lo5I=;
 b=L8EGCOOytAwHwEtI6nVQ+mu/vn1o5Mbj2ZquTNdjydQ4sKZ7XKewFV+KdpEaM7555PQc5CTIeIft7T8h35mXZzKqxIpHdfhqh8Xd2Ds3NGal59EuEoT3gkJO75EVmLYT9Bor9wFv5ew50tEbjbES3hrUS+Ac4r/tKu+E1ZWpafJ7GTCIFnCWO/t7vYpIkLSvMNTuVMDZWxUWhpiJEnhoWWednLui5BqEIPJqd7i4NdYIC3fhjcw1lbwjiZ94IdoAUU9VqDfuJgzsafYAt9TKLmgf6b8mxx5445p26s42skj+ZhXKTyy/fbDLPxd9oFHUuxV6D4z5tsb4GX8L0ekghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGuMHdE8aOyUL4nA0/4NfPMzIict+AyGtOVRed+lo5I=;
 b=O3TeNYYtW6N12ucS92t6XGBbeGohnWKwjEn3VGCD4HwArTvsK5sdkvht8deck5vrf9HIjXIXRPhT7vPFXym3KG8xWK2t3/w8HcCk9uX+H9MrcneeBQ8ZD9QoeK7aZjxEIL2dfiVbjKErKdkeRdnURt5x/0x49YkZ4pEqyxipFw4=
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Fri, 24 May
 2024 12:24:06 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::85) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Fri, 24 May 2024 12:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:02 -0500
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
Subject: [PATCH v4 02/19] x86/resctrl: Add ABMC feature in the command line options
Date: Fri, 24 May 2024 07:23:21 -0500
Message-ID: <d8ecf00a8369ef433fbaa56817a3a1e7d53bb756.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 174a0570-a889-426e-5a69-08dc7bec67f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqYdIxMwv+yFPLKwV3xOFfqVHFVxHQxqM7bqYHzDhEj7J9QY9v9TZul5/C/n?=
 =?us-ascii?Q?dSXr3JUC3gChnSlcAT1TroxJ5YrsvN4iRemWzIAXAeofYfcQgSX8jxtj0kVN?=
 =?us-ascii?Q?BQZJRQuzYMSiTcxhvns/2zOM8D2oRTSA+2kRIAkJVHg0Xh6Wmk1nhShmVswb?=
 =?us-ascii?Q?rW99KKT7cWDKe+S7H6rKK74bQPQ+1twoPhhrVUohnucq9pg+MM33uJESZiyE?=
 =?us-ascii?Q?tLmuFGMKGRSgMr/YaXwXQ6M9M27ZqTrfC+/qU18lmDGhZ6pHvXS/ZNHwUVo+?=
 =?us-ascii?Q?HsNKrJc+Wuw2TENs8p4MGPFDvImEwumNFcB1Kvwn0dKW/uDXKW/dR4fgj2A9?=
 =?us-ascii?Q?82YfBk6VU9+Q4CgYhXX8+gQysCwHbGleFVrXMxnG4+m99wPSE6jmmPtobC7+?=
 =?us-ascii?Q?NHXg/FXTe1drWClMnRmQ9TD/6O9NWkdMPGhPVnYa5EeIw7MJ78NbRAZWpPbB?=
 =?us-ascii?Q?wK7cA+1zLwMDIJ2NAa2oPZjGTmBosqmBAiTPVKoQ+t0DEplLruU54FY5xquT?=
 =?us-ascii?Q?1EJ/z3JQhjyRNDJEIt2mDa+pvTqngf6luFEFsbXaLd9VreAT4gtWOQAtt3cw?=
 =?us-ascii?Q?UR72LaAUxjMtLKg6zVvDLfID60PBHhrHypDTR/L5YIBbSO76dLMZXvpP9tRA?=
 =?us-ascii?Q?AERJfA46J1u5DoJ0D+H0jGMh5KsKgBnp+eKlEGojzbfT7WulZu96WzLL0HTF?=
 =?us-ascii?Q?YXtYI5wY1uq4a5TmHA4ohRFLnf1HPfA0C+nnJRwWIxSPegskQVG/flkKy8Bi?=
 =?us-ascii?Q?5a6RlgsuBffqjMU8U4EO21/WCV0FO73qgijdmysh9t9sMXhaCgAKpbo6ONAe?=
 =?us-ascii?Q?+lBT4xVuXFGNeTde7Fk0t/QmSpbUdTbdtZnBujbntni6oCS+ZnDSRMcfNMiV?=
 =?us-ascii?Q?vbPY01axA0E7wE3X9q57E+es5944BQ7u5biYK6zQkMANuw0iT+xv8wkyAZ9M?=
 =?us-ascii?Q?LJp7m1vfz2AlJ4VxXJv2toeJE8CBTj2c1TewadmCK2IxfrXsug1Qd1m+KESS?=
 =?us-ascii?Q?ZysJWoaMTmB+jcbFTKyeOJRCByhTVY4leccw+N8BKwRrpJS0/53jidPyflLA?=
 =?us-ascii?Q?r3qlblCnSQ0RwOR6hcGtsDPH98mMhVcE2r4A3djOM38NnUdCFKX4FxAgXUWl?=
 =?us-ascii?Q?9rg32ALFvfic/y/RmxnwdS9SH2/BWUc4AoAp8YDGnpMYxEr1Jw6Q4HG1WukS?=
 =?us-ascii?Q?mFI6rlxMP1HoKqE0ddMGAphdAV/8uIGc+ua61WkrxED73LReP0tRCCnKLWDJ?=
 =?us-ascii?Q?UUlKcwnfVFLHfyI7GqLT8yIzZL2+4zGMFNMM8BHgWWDi515BruFC3MFMS9da?=
 =?us-ascii?Q?gF7BWAnG2e7ZJyY9ufPn/Rg2oSYA1i6W42o0KXgzJqdgDaluEULA0VrwXw7Y?=
 =?us-ascii?Q?nBU/yn1t2kChzdGy+0gS9iMvHGQQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:06.4680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174a0570-a889-426e-5a69-08dc7bec67f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

Add the command line option to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: No changes

v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 500cfa776225..66a1be9d0ea6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5602,7 +5602,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 627e23869bca..02790efaabcc 100644
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
index a113d9aba553..df1b43fd9f0e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -651,6 +651,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -676,6 +677,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


