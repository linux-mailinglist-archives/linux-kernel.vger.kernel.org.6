Return-Path: <linux-kernel+bounces-554682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD632A59BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32987A6EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24D233D91;
	Mon, 10 Mar 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3mmJ84BM"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B8230BE8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624846; cv=fail; b=O1vRtWe0PyM4wARIELxgWCv1v5K6jsOb92cxFXDe3qcOJ6XoHtPTHu4V7469mp5/kZFczy3hzc8qWilNzp20lhwZLsIHVUZQe+erLFXk2uRO4hN2hXsVwdNM8B7TeIK58w2QzBCcdAtEFNEe7sZ4I34+EP65V/wYLzMkrRvg0gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624846; c=relaxed/simple;
	bh=K/R5ohaNXdkPjkThBQqNxs00pqn2hDeU3pNVwFBBiuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLt34jEF6siZe28QGSNYGrR0yZuzNbHrdgdhYnEmXDUAH6yUhfmnJYDdtJJVyO/Lo08hF+yllvKxiIum5nG6vmcB+qG6KQVEK83Y/KzGG3+QZXL8W1amRrDhmDlgqFoWo7bdV6EsZXuQSPwL0xRKs6RTL46wnnP+UKmms5rcktE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3mmJ84BM; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxDBf24LlwacncFCF7hpkwwHPIxocweNXwaEOmew+UWRgvyG15+1FMqJiiH78ZJ+OwtVe6G/y2kg46uLBswf6ljDpbK/B9l0iBK5EaOhDqeQIUUPCTTeKcjB509i0RV88mP/T5UNMEABM7s86LmhPiZivWdNjdySXSwHSfLUg6Mx7mqm8i3wBUzFvRLwXLjjgx7P7V6TliESFfaFudKXd2j5g8U69ef0v4LvAI/nb2PTZYPIm8jgneyilEIRXsSSaGvd60bam1Boy5Z7Ba+K1V6SL8mdYyZkDPQNIbCMm1Nuvdtbe46TwmFhat4DgXSt4BHy3XEQ0wNtReW0nKKo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPX4iPMWpZ9tQxdI80+NhpCjEl385hHaPLRR/UxDHwE=;
 b=SAm/5cwsjoDwa2CIgWu9+OlBVHq1OqtdIO2nAshLaib/TtVy09lBYXcVF5nO7DghpB3URptvLXBYobT2KKLd6JygGbbwqryBXpcZgLQvlsV+tXFvKCbiQlS5qjA2TYxRkuBSQOs6Vyettc6bTAdqmnlwQ/zd6SEde2DbciEZmQKcIOyQkro/pj1WgsIuCcAa05B71lqWPZBnrbk8Xvfl9rBk4oI+1PZstTinXFsTcW2aVBySTo2MiO/KrPWfJtNyexaApBDrlk+ZHVIYBkqtquxXqP2iNVV2UcejAP6ffWC/6sB+ZWVg83dlSsMzczvH6oHPyYy0wX/3kN75nzLCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPX4iPMWpZ9tQxdI80+NhpCjEl385hHaPLRR/UxDHwE=;
 b=3mmJ84BMVb9sS/9pc4bt8DOgqQcwKZni/Y0Eh+3hCI7eCA0a61BNKkxBlarm6KLUgeQgu6NsFku1I5x1oFQA3SukcbBfSblxQnBqlSibrbSl34JXDjhzKt2mRF6YtLeTpLBzUMzskCCpsTT+jIR3uVHfEw+d8txpNkr1l+NWD70=
Received: from MN2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:208:234::21)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:37 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::f2) by MN2PR16CA0052.outlook.office365.com
 (2603:10b6:208:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:36 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:35 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 03/36] x86/bugs: Restructure mmio mitigation
Date: Mon, 10 Mar 2025 11:39:50 -0500
Message-ID: <20250310164023.779191-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f051e2-a205-4efe-be42-08dd5ff24918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRiedIzagcCRkMb64+wnKKJSvhvxAN4NuUpCT1zdKOknK1agr0oHaNwLA104?=
 =?us-ascii?Q?OZi0a2jemI0TfRYGbzzE9lP5VJ82JfOyKt4MropIgtYfvmgUmFHCQfr0Ct/q?=
 =?us-ascii?Q?soZBup9Ru26I2kGXp4Mz0rID2IyUIgntzE/jp9z98loQbDDe/Yb3A7TAHV8m?=
 =?us-ascii?Q?X7IwB6HuKKj0OYq6wwtDnEDAMn2yf4JpBDs896meqeG2g3RLSdvyGRdokeCK?=
 =?us-ascii?Q?qTI3XYgYrrCvT6wNaY/iZN9YYkgon0beotw2B6ViKqgY1UKYhqb7Gzid1qMq?=
 =?us-ascii?Q?GqwcjnM7EwpqGhiJ6H/Z/0aeYdKEXMdCUKAte3cK9LAYSRX0koi0z00J/YjB?=
 =?us-ascii?Q?mtXJ8sXKIGe4BulDTycUJpzhMAv9G5OFYbyy5e9Mt0ebY7d+0AwbTmOzoDn6?=
 =?us-ascii?Q?LJE3PJLOgRNVsCoS0m4gkHjKfjV9k9PfB3AJoxABRFIRUbM/wF9Eent2vZzU?=
 =?us-ascii?Q?zVk4TkqdiFlbNSqcebLDAMqM+5R6tEryKkru9/tskkAbC1EWMoPvhMOljiJG?=
 =?us-ascii?Q?EDYCkxny2kqIKtRh8LXnYXyND18/ym5PigpS/c/9wfghSk/pgvzvYq2IGdvW?=
 =?us-ascii?Q?2LGPXiBbqff4jNK0ZfiarWehq/0HNCq3fqxa4vzLSr+b6A74WCDC5oEWcuh0?=
 =?us-ascii?Q?t/Z9ueOJHCZ7zy+ME450wWrDHmHIGsJDvpPpa+YHOFLMSVwAe5doy9Q0AMKx?=
 =?us-ascii?Q?iPNDeUasW3NrBvwcj5lC7IDDe3iqIau02tcxqNBi73hgI+riZzKC6p0MVHyL?=
 =?us-ascii?Q?g05NSkyIDfi9OgD//yClnDzMX1yYW2XuxGktQHtQsyU1bdXEAmvtkudmfXRO?=
 =?us-ascii?Q?WtAOz0Pn3pjdfyRQ88vyhCernB7ZOjyOwKKXBO2nHpur+n7egZAT3NHIekUt?=
 =?us-ascii?Q?Ke7c8aWn1PXn8aa3Z5ZliTtxYGvkJKoFBCGEZrK050CVtkAYIGYNy+qUJeWD?=
 =?us-ascii?Q?UD5TcmiPfeYXykHHqRGxL+eiPHOBoatQoSydsAlBnu4L2NSyFxWPDhQJ7une?=
 =?us-ascii?Q?dtcqkEdZqa9AwZEj1JXDZ0v95kD0Jmm318pH8Jop5DC5QGYFluo7VX2kNVPt?=
 =?us-ascii?Q?v5ZFL8LZ7OTKwJPJmLiXqx+sGTCqciJVy6RC5SUk+EoX2QRQ9b3nDVfWq+zd?=
 =?us-ascii?Q?wSUkJU/nE20Gp+8b/pn2n7pRtEEd28YjzYx5i/XgSH78NSNF0FCZzoYsvRhR?=
 =?us-ascii?Q?RXoKVMNmBckT6SP3uaynSBVq4trEXCs4hyzYQYXg+IuykdMqlJ55BVN5s12M?=
 =?us-ascii?Q?hcCwq4G4lzDxyf4r2wvNaxHQGsfR8UEbOLrQME11XciCVMnGPx/I7GbeF32G?=
 =?us-ascii?Q?saUdNZsP61xXvBOzRBvpsqTECMUbsQg+y4oqpJynUrg6ghbsxU5JFryQDbec?=
 =?us-ascii?Q?AMHbHOMaE1u4c6zmSKljb8/ww902c3sGR8ArKhfk32hK7INFkxIm9Ep3kUdN?=
 =?us-ascii?Q?5KE86PYM8zcwm+Sj+bTfa9oTgCOe3p1TD1iHenPpoj02yjAaLcVp9Oyrk7JI?=
 =?us-ascii?Q?fBF95TiaBIyS7EM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:36.9092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f051e2-a205-4efe-be42-08dd5ff24918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

Restructure mmio mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 77 +++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2fd58b7089c4..a727f7998bec 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -68,6 +68,8 @@ static void __init taa_select_mitigation(void);
 static void __init taa_update_mitigation(void);
 static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
+static void __init mmio_update_mitigation(void);
+static void __init mmio_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
@@ -194,6 +196,7 @@ void __init cpu_select_mitigations(void)
 	l1tf_select_mitigation();
 	mds_select_mitigation();
 	taa_select_mitigation();
+	mmio_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -211,9 +214,11 @@ void __init cpu_select_mitigations(void)
 	 */
 	mds_update_mitigation();
 	taa_update_mitigation();
+	mmio_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
+	mmio_apply_mitigation();
 }
 
 /*
@@ -511,24 +516,60 @@ static void __init mmio_select_mitigation(void)
 		return;
 	}
 
-	if (mmio_mitigation == MMIO_MITIGATION_OFF)
-		return;
+	/* Microcode will be checked in mmio_update_mitigation(). */
+	if (mmio_mitigation == MMIO_MITIGATION_AUTO)
+		mmio_mitigation = MMIO_MITIGATION_VERW;
 
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
-	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
+	 * by MDS or TAA.
 	 */
-	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
-					      boot_cpu_has(X86_FEATURE_RTM)))
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
+		verw_mitigation_selected = true;
+}
+
+static void __init mmio_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
+		return;
+
+	if (verw_mitigation_selected)
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+
+	if (mmio_mitigation == MMIO_MITIGATION_VERW) {
+		/*
+		 * Check if the system has the right microcode.
+		 *
+		 * CPU Fill buffer clear mitigation is enumerated by either an explicit
+		 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
+		 * affected systems.
+		 */
+		if (!((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
+		      (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
+		       boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
+		     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO))))
+			mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+	}
+
+	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		pr_info("Unknown: No mitigations\n");
+	else
+		pr_info("%s\n", mmio_strings[mmio_mitigation]);
+}
+
+static void __init mmio_apply_mitigation(void)
+{
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return;
 
 	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
-	 * mitigations, disable KVM-only mitigation in that case.
+	 * Only enable the VMM mitigation if the CPU buffer clear mitigation is
+	 * not being used.
 	 */
-	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+	if (verw_mitigation_selected) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		static_branch_disable(&mmio_stale_data_clear);
-	else
+	} else
 		static_branch_enable(&mmio_stale_data_clear);
 
 	/*
@@ -539,21 +580,6 @@ static void __init mmio_select_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	/*
-	 * Check if the system has the right microcode.
-	 *
-	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
-	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
-	 * affected systems.
-	 */
-	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
-	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
-	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-	else
-		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
-
 	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
 }
@@ -676,7 +702,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	mmio_select_mitigation();
 	rfds_select_mitigation();
 
 	/*
-- 
2.34.1


