Return-Path: <linux-kernel+bounces-554680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E875A59B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D9A16EB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40816233729;
	Mon, 10 Mar 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ME7eGwKh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76C230BDD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624844; cv=fail; b=QUzgMNouAJ/LTviTXk7gtBkh1jnPiyLO5yC8WTXxf6vbmuwYPhckbzFOrcFbkg2P4wHgRRhGiMxOeu7jWoL+CCfPMIGlhesZRBZM7OHQqF6ArAZV9nDgn9Lzw1Rc1yZ/aDros3HQOnc7rAWOsxnwxcaH0/fBfqHZrl1EiJchjYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624844; c=relaxed/simple;
	bh=Sqaw8UFpYUMzx781NGBzRKHNs1p+8elV4TxLZBGBk4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7rmEy5BoDiDGShIFTvXuqR1lNX8h4Z+ZaaG4d6Z/Ghg6pzEAsQNp70e4+kXoKMfSRyoQwkSEn61hqugYbfy0SWL50LHcoEn/CRZU4XocutaE3n8zEgxrGfUpPDfDhQDxo2gf+xWxcnLgnON1nyL+kDmd7BfhHxsxLdzlyaW8HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ME7eGwKh; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH+MG59hwWE2fkmIabc/xENatC25VGbNYgwvBATMAmza1s7oVcUTtTDopPwxoziLPC9zSoUwvu/LM8gWiwLPtKvyY6dciR/uhguxuGvXukJkN/ejlkE7rEbS5EHrxk/19bqdlKWbH5l7HmwNVMjSl5MW62+kEjoqxPxY9XdsuU6jemfWaSH/fw04X45+1OsRajkEip/Hje2NAQjcn4KBl4hZEPEAYX5LjA8L3Ge106kGnMDSclRjkLhlSS6ERIDcSBEYaG/p53nBXNRttysJjZUO6njlvvJ88TRhy53VdZhBrkObmc8u2Iy0QJPds7MoRohwLk4lVJwm5ZN+fD37OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8fEux3wP8a/V8mnio4UuQkemrlpdH65baMbpZPzPtw=;
 b=g7glQqvrsVNRfY6J7oyXGabUJcMxEEuK5I8aEpn9wdSKcN2FYJsCfRjEnZrwZz9C13vSeCbkjrzIxTI3OCex9jlcWR3CrKu3iro8F63lB2KDU5dguqGShzV7Js2IvAhX51yrnL7fgCteXk/IaSUlcfcyE4JWyvkgCu1y6OtoEOrQ1p/8vqEOyfO2kzaaiD9qV+5LE47ildBz5zfxHv+p2L97e5YMN9ZfghZdxBNEAP/wKhsIofbX/TSfr37Bpt6M+PRmJMX4h6fAoiPDP3aQCxh/j9HD75kGnPKak3uzgqyLsux6eHJ47sExFN6k3b1HSWfCPqSj5gGpeVtlhHLyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8fEux3wP8a/V8mnio4UuQkemrlpdH65baMbpZPzPtw=;
 b=ME7eGwKhhizqNtQ20U4PodV1dhU3GN7LU6Vp1twvoxiyX0JJwQpwitdtn1P91AjgiQfyMT+eweCx71tXkg09M0sUjHLIQQTKYVtGLdh/Oc0/ZexPfXz39OULMZn693vvnJSKZTrx2D5m2yb74OXIB6qEF8Ub946Sz0rnflrlF4E=
Received: from BN1PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:e1::14)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Mon, 10 Mar
 2025 16:40:36 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::87) by BN1PR12CA0009.outlook.office365.com
 (2603:10b6:408:e1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:35 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:34 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 02/36] x86/bugs: Restructure taa mitigation
Date: Mon, 10 Mar 2025 11:39:49 -0500
Message-ID: <20250310164023.779191-3-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f168a5-83fc-44a1-ecfe-08dd5ff2486d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMr5UE+iAGSmpg8Q9yiGVQ257Kav9+iXlrTzH06ms+EGtlAot0TbcwkPOYb4?=
 =?us-ascii?Q?CzXmEZ7W2lQW4s+qEalARfAVtbwbFrw9XgKBq2bkFfaHuYq+Qqt1Bm69pyPd?=
 =?us-ascii?Q?RyrndVblCGymTEwkh53ippLKtmeqQKn1GrnPRCvrORr75mSIv66cmyLp5Bpk?=
 =?us-ascii?Q?kKybOLelN94fUagSNSzo/3qVCDdvbedBFozD5+WkkrQZN5jer4oy7I9paQ+h?=
 =?us-ascii?Q?BXJ7PnGksXJ3+ovjOJxs8XycamfgM/bf0d9s7iKJPNE1CcT+zeN5ifLPtV/W?=
 =?us-ascii?Q?gqJ2I8TTnhnejnq4SSodpSt6XX0f6oSHF00LryNeP8C5O1vE14wIjrMkBBvG?=
 =?us-ascii?Q?Rq6u8Jo4A4Je4vDRsN1gp9ptWGn2f+NZ+9jDEKi7WHea2nhkdxB2DgCKZPI9?=
 =?us-ascii?Q?w0uodv/jrMCla4fBQwv7V5J3qichJWZz8QEhlHIhtAkUM4rpfNLvAC5L8KP9?=
 =?us-ascii?Q?iwNuQBHvNR42j6uIrKFPuXxqmkSofK2xWvyqzLrIFvZjAvFSY7AZw+cr01Io?=
 =?us-ascii?Q?SrTMqh8mFGp/Ze3cYNWrt828neW273kaW9yfSPxkFy2Ad61oochew67a+n0z?=
 =?us-ascii?Q?Xbt0A2jyzR4OuCRvHx2IcVSRB/AIdZmqkEbgyWHPAOTY/gdcRFiOjsGkMETu?=
 =?us-ascii?Q?8ynWkVT/40u1rPLiLAFTYlYRLOBvIpsstAY1s0ixxH83Bm4csu1/yYh/PD1R?=
 =?us-ascii?Q?XJJDC+sEua18DXUq8ypJaJET5JGmna1b3OUZpK+DEYtd/3Tc9H8rkNQ4Ga5G?=
 =?us-ascii?Q?It1e+kiEammT6ItWkdY4QFFfOCFmnuzPg1fYDe0wEMO+1M6j7wO3bGiqxVS/?=
 =?us-ascii?Q?EcLMCumVt4CkK5PCEqcSehhZHTny6O/SuMISuCihJFxBim17a6HUAQP9Lp46?=
 =?us-ascii?Q?LCaiB8OF4GjfSNS6dDPF3AEPGi7xVRh5euVfnSubT3eFKsn+BCMrmhSJqygD?=
 =?us-ascii?Q?3pShUDt5UcD0Zc1Pke4NAnMK4+SarLMCo8hazOMZHopbS/eQIBjp5TQMgG6W?=
 =?us-ascii?Q?kIA4AMFwbNxd87LGYrZDNUyeO4ha/4YRUZ/sVFm28HLEoAXZdPtfddwJ4ugz?=
 =?us-ascii?Q?PrjAv4yAR1uRpVI/IuVOBLrda5XzxYIgUjVkq+R/z27kqg35QH+GrYIeeery?=
 =?us-ascii?Q?+NXUYSAxFsJPuZueU12/zksExhwhHhq3C1E4tIlomIqQIJXQtv7pq5u9g20X?=
 =?us-ascii?Q?XtpsJzmaGeEiB04I8Mcsm8wIZVlgstsguMhur4YAhyezxrWIMAJrAmoHqWFN?=
 =?us-ascii?Q?nBblGRB6D7nKjVqWLo4tjhxqIWlcDzekNXFeGw+RFBoo6Qe7TQ4U6BTdTQCN?=
 =?us-ascii?Q?YdQk8y80d2MSemC9MZ0wTPaWNUaAAoLPh6iO893oep9qRsCY1JOnKDGpYbAV?=
 =?us-ascii?Q?G30h/4bKqMsuoZsNtF6EKAT8LXzUnS8aRwUBTDV4KGrwSLDCH9e9W+aFPag7?=
 =?us-ascii?Q?3YQfZ2/EHtwE2FAU1lXO6FS8N6o8HiYqrk24jEe6KL1jQ26CieQg018nmFpY?=
 =?us-ascii?Q?lOeLZ4R0eyyW9pI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:35.8053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f168a5-83fc-44a1-ecfe-08dd5ff2486d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

Restructure taa mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 94 ++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 71da57c4f83b..2fd58b7089c4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,8 @@ static void __init mds_apply_mitigation(void);
 static void __init md_clear_update_mitigation(void);
 static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
+static void __init taa_update_mitigation(void);
+static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
@@ -191,6 +193,7 @@ void __init cpu_select_mitigations(void)
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
 	mds_select_mitigation();
+	taa_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -207,8 +210,10 @@ void __init cpu_select_mitigations(void)
 	 * choices.
 	 */
 	mds_update_mitigation();
+	taa_update_mitigation();
 
 	mds_apply_mitigation();
+	taa_apply_mitigation();
 }
 
 /*
@@ -388,6 +393,11 @@ static const char * const taa_strings[] = {
 	[TAA_MITIGATION_TSX_DISABLED]	= "Mitigation: TSX disabled",
 };
 
+static bool __init taa_vulnerable(void)
+{
+	return boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM);
+}
+
 static void __init taa_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
@@ -401,48 +411,63 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
+	if (cpu_mitigations_off())
 		taa_mitigation = TAA_MITIGATION_OFF;
-		return;
-	}
 
-	/*
-	 * TAA mitigation via VERW is turned off if both
-	 * tsx_async_abort=off and mds=off are specified.
-	 */
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    mds_mitigation == MDS_MITIGATION_OFF)
+	/* Microcode will be checked in taa_update_mitigation(). */
+	if (taa_mitigation == TAA_MITIGATION_AUTO)
+		taa_mitigation = TAA_MITIGATION_VERW;
+
+	if (taa_mitigation != TAA_MITIGATION_OFF)
+		verw_mitigation_selected = true;
+}
+
+static void __init taa_update_mitigation(void)
+{
+	if (!taa_vulnerable() || cpu_mitigations_off())
 		return;
 
-	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+	if (verw_mitigation_selected)
 		taa_mitigation = TAA_MITIGATION_VERW;
-	else
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
-	/*
-	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
-	 * A microcode update fixes this behavior to clear CPU buffers. It also
-	 * adds support for MSR_IA32_TSX_CTRL which is enumerated by the
-	 * ARCH_CAP_TSX_CTRL_MSR bit.
-	 *
-	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
-	 * update is required.
-	 */
-	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
-	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	if (taa_mitigation == TAA_MITIGATION_VERW) {
+		/* Check if the requisite ucode is available. */
+		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
+			taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
-	/*
-	 * TSX is enabled, select alternate mitigation for TAA which is
-	 * the same as MDS. Enable MDS static branch to clear CPU buffers.
-	 *
-	 * For guests that can't determine whether the correct microcode is
-	 * present on host, enable the mitigation for UCODE_NEEDED as well.
-	 */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+		/*
+		 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
+		 * A microcode update fixes this behavior to clear CPU buffers. It also
+		 * adds support for MSR_IA32_TSX_CTRL which is enumerated by the
+		 * ARCH_CAP_TSX_CTRL_MSR bit.
+		 *
+		 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
+		 * update is required.
+		 */
+		if ((x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
+		   !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
+			taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	}
 
-	if (taa_nosmt || cpu_mitigations_auto_nosmt())
-		cpu_smt_disable(false);
+	pr_info("%s\n", taa_strings[taa_mitigation]);
+}
+
+static void __init taa_apply_mitigation(void)
+{
+	if (taa_mitigation == TAA_MITIGATION_VERW ||
+	    taa_mitigation == TAA_MITIGATION_UCODE_NEEDED) {
+		/*
+		 * TSX is enabled, select alternate mitigation for TAA which is
+		 * the same as MDS. Enable MDS static branch to clear CPU buffers.
+		 *
+		 * For guests that can't determine whether the correct microcode is
+		 * present on host, enable the mitigation for UCODE_NEEDED as well.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+			cpu_smt_disable(false);
+	}
 }
 
 static int __init tsx_async_abort_parse_cmdline(char *str)
@@ -651,7 +676,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
 
-- 
2.34.1


