Return-Path: <linux-kernel+bounces-327129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5471977122
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39241F2447D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FC31C2422;
	Thu, 12 Sep 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ZZAYvUJ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856741C1AB5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168163; cv=fail; b=ssAJX4Q0FZmC9aMbaLZIH7/ds2fmWjce3hEpiVYKm6Ph5IPR9WRaOcJ+mnQaYtTzH6zRSC8VtEkIeqSWYMQKRPEqjlp2cPQyWc55tXI2qfjLcM2cQ5U/nOz4kcmQWqGi55+OEiM/1GiSqBZGbWB7jECUMD1PNG4WtDK8NEKBdKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168163; c=relaxed/simple;
	bh=9sODqp3ArXApdZavbl9h4W6nhZYHxBxJatX2CdeXsEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6F/41+XR08JttgffUyWU4lnCsCZDoa6p3cFGsbYY/nqX2ozGBJRkZS+YaOHXriewI4oaoLm5rbOt6cR9pQ6PRY062MZqx5MkcaZgSGXJg2FVpcH2OoJ+Hf5qzWv9JBhG9h/WUpB9CL18YIlFuvxcbjERgdcatGdd4PfEp/zPIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ZZAYvUJ; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcznI9goACuNCLMJ/qkC0r9lImGPCqpVgwCQUpfHzuQ60oecICiLJkPE2IIygmLWMQk0ds4AgpNABsgv6IlO09EoXqFik2nz4R5+Nd94d0CCQRCIQtyxhuP1cR1ABhRG7KX/58RmUvKpBFAR6W5Jinbn5aoY0jEOvAI/ULqBZF9pvYdkST/KAgcc7Wyx+1n+Wja+UqltCutPcl9X5Otd3aL4oKpKqiKfsV01Nh7cSZqiR1l89H87L7IKuCMvpPzmaJWhUf1NpRfuff/dJctNyDE4HFYYCydsTiVw46zViaUwEvHA3XHEF+AXTiEucLAMlHoEumN/3kIpEznSMhFY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIbbiT5T31dKrM++l5FCs3Vl37sTmFy+hVVVnQiKHcY=;
 b=iaTEoRmLDcyhS2X9h7tMP0rZpuNa6fiOaKLKpIsgAZ9HLkjI05xdcVzZVs0O96rYRTQTsb2oJMNqzI2DbrXsDvKywM4gkB1eAGKcPT0+J/JykoLq6kPb8zlFMTjM61m9u3FdTaOHiHxj03O8gppIeiNgmU1Lz9XWPWbEF4b1YR1TAeCCVXBHk3ceXL0oV7qxCDj0+TF2Jh8dlpwczCEooO1gSp0PrtqUXNNClWt7HQh1U3Ccci8bKITe+Tln8ZLmqHo76nKIRChbcfNMhINl++jJRARg5sQyv4OCY0JlCICxLaNPE10YnkZ6FfQt/Spcv5mTYi4pJQ7kAQU9GWpYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIbbiT5T31dKrM++l5FCs3Vl37sTmFy+hVVVnQiKHcY=;
 b=2ZZAYvUJ09uZT4ZTDBNJ2nQa8JOgv3cwJtgnV9aO7VUfCJ2+eSGPaHObkscqNHurbPOAmABTunFzNMpEX9t+/+L73lfl3hjrXyZu9NrTL3EVEypXo0HM0cX5toseeCd4ySuQ85IMnniRic54FtuVt7XcyrO/vPwk4zTqAxgYM14=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:09:15 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::e0) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:14 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:11 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 05/34] x86/bugs: Restructure mmio mitigation
Date: Thu, 12 Sep 2024 14:08:28 -0500
Message-ID: <20240912190857.235849-6-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccc18c0-4051-4870-c46e-08dcd35e644f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4kcwYR+8kihbZ8Iyn9vSWzAHGHBY9zLAue6lcuJaFVICXsW4P4zyLnG9sH7?=
 =?us-ascii?Q?Abq9pQ3mHAIVvFUQJ9ONpj/lm5lGzV9Zk9XzZMLor5fb8fnaqWZkkS/zYskM?=
 =?us-ascii?Q?m6IYqV+mRlJ6W+x+boPUOYiZllaBWJT6HN3hvAee0vGaquoFCjxh1bak24uJ?=
 =?us-ascii?Q?imSs3lo+Ut23/wyK2GWKJe5YmxLcoAvi6OW8sEABLgtJx9y88Fn+S2IG55Qz?=
 =?us-ascii?Q?IQIzlcThsLzUMq/C7fLpfYMLZb288vkiz7BdNw4BjDBDTLBOySBLBnjvRvWL?=
 =?us-ascii?Q?CVWJq/FMIPMCbEZDekM8K/F0AoNEFTZXiDRHwsy+IiJJYHqWz3wo4jA1XRz+?=
 =?us-ascii?Q?Padj9+Z/Ebq394/O/5/Axo6SiQsIWkGyDOMtv2BSy5jv20ZhgJLe26+x719R?=
 =?us-ascii?Q?61Xs4yWhue8NWDsLjdtooN0bJXqBV62wmeo9utqRQOTFhWdyM4KV/lNTbX8/?=
 =?us-ascii?Q?u4o8F/nIe+BMK+5emPemw9UtlAsxqRIEqAVWZBXhJJcSp5YcL/oceADic6Ty?=
 =?us-ascii?Q?fCdcjE4oDOTPtM0rWpMRnq76q3p3s6w83iJwsks5yWnvjEolYvyydPORHn49?=
 =?us-ascii?Q?2naSj9UXR1MnbSDXc0smM96E0J+dK8Ij2+qs7thDZXfO7i3h9tZ5WmNJsEKR?=
 =?us-ascii?Q?hYW3j27dv8bnExl5nxQ3NMozQs6fSkVFsJwU4jZafz3hXjyWYfpFBxcbF2Hb?=
 =?us-ascii?Q?MKdarn0nRHvFwQZ51fRwkqnG0TwExbxu4rJbv/yzhJhRe1Xhob9t1gDUuCo9?=
 =?us-ascii?Q?uW1tA2wk6HuLDV7Wfz3XpJTcjqVdPCtZe+xoY1gGDWCcVZbPLSgRxr8Vw9vd?=
 =?us-ascii?Q?8p37A1QKdXcA7sYEb8xczQK6n0JFTj/OSKoP+mb1il3Nb+EdgCyoOF3c8cmO?=
 =?us-ascii?Q?YcRrv/bKeiupsIvzWXFo90xyd4NQ/qrR6a/goa3tDhcHgkgzqxodellXkvVb?=
 =?us-ascii?Q?k9SIXeFbQkxxCKp730Q/O+AMF3olqzTRQKa7hPoRjZujUISN1yypS7Hx4eHk?=
 =?us-ascii?Q?d9peg5cwQocpKsbYPDt3dcL9W0JzWRtQVwcdonTfJcnlQOtxJXJOs4EVW4Lu?=
 =?us-ascii?Q?28piVhijtWYQqjEKvMyBCthEEB9+SymEHWlWDdS+njhHa8ku9s/qAfoko+CJ?=
 =?us-ascii?Q?JJWysPkA9nI/EBBN58SapZ03qHKwBNCO2fzwhBxK74MpN7TYkLhsv5kJP3QN?=
 =?us-ascii?Q?m4eATCgQbV8YNbSsPcx0TulBYIBQxihiMeNvxXZh5PD69EBMxwDcs7F90IeQ?=
 =?us-ascii?Q?vVhGuXpmOTR7/51EELTg3SK0C0+yJgDD/4YEVYpecd4EuJCT8jVSnpw7RNHN?=
 =?us-ascii?Q?CTKWxDCGMRWIX947VQaPy8dk0F798tnkiiUfwbOrbx6JY9Cy8K/h7nAKdZJx?=
 =?us-ascii?Q?8VvmEBdDgE4v++pUfWcjBrXdYUARyK+qrN8SZlihq+m86c3AEs4GEiGxuKUP?=
 =?us-ascii?Q?QRfAFZyPyyPV5tbyr90Pb+lFzZcmk26F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:14.1541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccc18c0-4051-4870-c46e-08dcd35e644f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

Restructure mmio mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 60 ++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3c0a0890d382..0b93a0f030b7 100644
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
@@ -190,6 +192,7 @@ void __init cpu_select_mitigations(void)
 	l1tf_select_mitigation();
 	mds_select_mitigation();
 	taa_select_mitigation();
+	mmio_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -207,9 +210,11 @@ void __init cpu_select_mitigations(void)
 	 */
 	mds_update_mitigation();
 	taa_update_mitigation();
+	mmio_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
+	mmio_apply_mitigation();
 }
 
 /*
@@ -484,9 +489,6 @@ static int __init tsx_async_abort_parse_cmdline(char *str)
 }
 early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"MMIO Stale Data: " fmt
-
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -504,6 +506,42 @@ static void __init mmio_select_mitigation(void)
 		return;
 	}
 
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return;
+
+	/*
+	 * Check if the system has the right microcode.
+	 *
+	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
+	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
+	 * affected systems.
+	 */
+	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
+	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
+	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
+	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+	else
+		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+}
+
+static void __init mmio_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
+		return;
+
+	if (mds_mitigation != MDS_MITIGATION_OFF ||
+	    taa_mitigation != TAA_MITIGATION_OFF ||
+	    rfds_mitigation != RFDS_MITIGATION_OFF)
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+
+	pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
+	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+}
+
+static void __init mmio_apply_mitigation(void)
+{
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
@@ -532,21 +570,6 @@ static void __init mmio_select_mitigation(void)
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
@@ -666,7 +689,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	mmio_select_mitigation();
 	rfds_select_mitigation();
 
 	/*
-- 
2.34.1


