Return-Path: <linux-kernel+bounces-554687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A386CA59B50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884151889B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFA236A7C;
	Mon, 10 Mar 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41k2B+CJ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7162327A3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624852; cv=fail; b=RlHwMfoZ30GfNMoDfe4NZQyRNgRDZ6OObKBbM2sVIandKcu2g9dwiQo6gzZDYa9usbYNw0QeHW/XC80G73e1h52uApoCXN+8bZvbuzvp9wN7GBjIuiMaNAcpc7G4aDMiuBXIyzUBPgUPR6xDp+pNmWTWaDZzNGLZEUI9joyNg60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624852; c=relaxed/simple;
	bh=K+C9pFOyPXiom1spo9M1vbjkCijPof2zjIDDOVYmBIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9ut8clM/ABxEwL4l6GKkb4D5rdfHc3BCbFkdGgkythRXAWlhYU7zNRRPyrtjuWa8W/uG0hFRl701cdVOxF6YJtoJRjaGhj2gcAMq2t1YMUYNLKy8FEkQWdAHbQgG7Z5mn9J0LviR4rymYZE6mCyg+NnFHN4vmJqv/D1x7Gt0DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41k2B+CJ; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBdHC/7Mlc51ClSyBvR0CABs/77FpHnZwpXvFW40OM6V2B14LVsYid8/cWW/5H/+sRfbLaOUUMQp5VE8L/F65EU3N+qIuHwp29U4N6zGAibUUf4nv6b5k/zw+7sDsvY8D/Iuw0sK7gZCdWPt+8zLr+Npt4CUHFCGmc9Sws9lCQdM23QwqUPugXw3DifFhj0F+LA0MxmrUGyMhVfqF0WBma7HwVnSdyF8dZMANVtb8jUALgSyTNaeKz9GkhOwlS2Hqz6nVGZ6hNzRYdbHU6+f+8NLAA+6YvZGEwWjab5cjg4/3BAh5D3RKC9tMQW/aZE4WPHPCXx3Gqr1szxtbH4Z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AP8inCusnZBj5jaZR+5reAtfSpdI8HjvSc5qr4S1Fo=;
 b=DWJ1yEP9+f/byYomgfkUo00mO2x5jdzEho+7+zDW8eaLliCj7REVMB8Vz8SWGqylrJQMe0jVYOav+J8DHefn8Dqe9BT104BQDV7Uc1NHoaNMpJ6v4rnrpOPIZgjcgD4jPiY7vTyf2ZrMtAq6KMczHn2bxbsc+RufXzvG54clrkoboMsxRJLfcFDwRt3WfxeZtVz+wWb2oTasKwFbGSVP0hRXr5aneGmjIqKedSXUWAqiyxO9aWTyF3pQ/uMsc+gS/fsKkUbVi3eG+nDZAQUZyLkTGAe1YRlTWLZf2UZzTH7vCCv7QPHzIdHhas7jF9pC4sZQFo84ImSy5A+sjSbCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AP8inCusnZBj5jaZR+5reAtfSpdI8HjvSc5qr4S1Fo=;
 b=41k2B+CJ35O8rpk+Fbc87IiRfvb9WAA3NtW55N7ajbsSbcLTwjA1A3lcDK4ipgOwprV5wFoHrKe3xAg0HvJg6V3rqOe+7OmwTK4fvUi7Qt7QGdhK5bH0G5vZgHidV1JZ1O4EG2MFuSvcsevmA4SQIT3zqaSHQNud/jelyzoh2n8=
Received: from BL1PR13CA0065.namprd13.prod.outlook.com (2603:10b6:208:2b8::10)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:47 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::51) by BL1PR13CA0065.outlook.office365.com
 (2603:10b6:208:2b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Mon,
 10 Mar 2025 16:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:47 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:45 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 12/36] x86/bugs: Restructure bhi mitigation
Date: Mon, 10 Mar 2025 11:39:59 -0500
Message-ID: <20250310164023.779191-13-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdd7e81-ac9e-4bbf-e7c5-08dd5ff24f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JRnmutUYEfNHSKGX/7bbg3CwCWaTHkN+C9zvmhLyfP5iaIe1ESdvqwIyYH2U?=
 =?us-ascii?Q?MgvEaGs+c444+5671tNSVYB+1j5uS5Fe3ue6ZMDzoMstJAFKnyhivmohNvbF?=
 =?us-ascii?Q?p1mjBQFhU6WFF1GS52mj3tNLp8wdvRA+HNAmpz2zEUjmfjiQd/yZIO+LoeHq?=
 =?us-ascii?Q?J+iPVaiSNbHuHRR9bUnl/TxWEnaPB1EJUR+dHTYBdzi2UqUXHKSIlpoACxyW?=
 =?us-ascii?Q?iSycJVxh7T1+lzBVBN0oyzL9C2NgU216hnBX+ZKsCVexUzGeiUZD30XABfHY?=
 =?us-ascii?Q?CHPp/EGu1UA5TveJfOc7PAi+iApo45MS7/8x4EZs0cuzZULNaSD+UjX8/hhn?=
 =?us-ascii?Q?v3u8sr30QFbTSTwKthQRTqQXpr4WC1rKrVT8E7WLYqMqhYSfIYaV+q80oJEJ?=
 =?us-ascii?Q?aTag4HNzqzK6LK8ZWIHyRw1Tfu5BccjPJhJn7DZfYz+C00tG6KIYUcSDpRdX?=
 =?us-ascii?Q?RnfAMdp9juI86ILfXOVUGD1+1C6kPDHDIiuQSgQ/Y0vPn1DC+Djy2biH7mtg?=
 =?us-ascii?Q?dRyIhsydNb99+LdH7Bbp7B0Hq/Fkx5yOvA4TV1juPF25omzHX06J3Lz2MtVh?=
 =?us-ascii?Q?1rQLJPf1loYhE8/ZT6o0ZPE2sNqOeT38wn031NS6A9Hb2L9leX9okoN+7PQ8?=
 =?us-ascii?Q?GLLcreKdKlvdQ4lZB5EfU5J9rKr/zLlV9AUDzGLSHcg9SDbv3etwSZn4hj6+?=
 =?us-ascii?Q?DwlxeLJd04JMJfJqyQNi0znpN8+4bhP1u26rGEFcYtZXivRsyT1tUwaJ4WLe?=
 =?us-ascii?Q?2YNFyRDowD3WZPOtkfsvwEqbPXek123qfKVpY/CJoH3Nv/t4LhrPq42dqa4S?=
 =?us-ascii?Q?U21DsuzSYAcfJyHxRBUP0mAZfkZRn8ATmnqAbMh4cILE3hmagtnzcrK2OfPG?=
 =?us-ascii?Q?4jUSkJAG91vMnXK7ONqTCGT68ST/GXR4yO+NSXR9dxCPNy9MCs43zdFHrNdL?=
 =?us-ascii?Q?Av8dOW+LjPH3hSCIKGfRzliZsSxGb6E02Tk6qYxEUlA9Rhj7hZjw0zT4bzoj?=
 =?us-ascii?Q?xnJ7np56A73TQrmjnaQ3c5a2xe5tPpboHsmOqM/XGBypsk++IVW/kBmuh5JT?=
 =?us-ascii?Q?DTamu3UD9CfmPJZEojXP+P9RUz4vQo8uPLfNY+EneDzHotF43pm1HVpbaETe?=
 =?us-ascii?Q?IUQ3wYVDGMI6TlBL9yqMqyYjPZ/uxGWFW2TYNLHQ3zqvfCz/6UY9+RtQqCYx?=
 =?us-ascii?Q?ik3ZpnjgqYELLNlBkZwD4uOsjHE3m1u4Wr32b+aPZ4s2L/iWV7n5sjfl+pbR?=
 =?us-ascii?Q?3aBxdLq5qguIpBNmx4lTHmfgmJkAhuDxXqShGvc2cQD0ilr2cXpqDpk8WTC1?=
 =?us-ascii?Q?rVnl9Pfw7lzKgkGtGwwWK8BcDsCi5e0wEipgu1BplbZBrtHsPi6x37NIs6FC?=
 =?us-ascii?Q?8S+Em6Y2PH7sXI8YxTjLfUofjMQHYVy4XLb0WBhCFUcP/kUMofhpvGqlLGK+?=
 =?us-ascii?Q?DEusJnc14TTQpHv2fHd75SBKsOQee0KRKymGVOVp1uWyga8IaZ7bpH3FcDHe?=
 =?us-ascii?Q?/W3fS6WukGpSBK4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:47.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdd7e81-ac9e-4bbf-e7c5-08dd5ff24f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125

Restructure bhi mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for bhi.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 623a3a3d3008..96cb2ac70245 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -82,6 +82,8 @@ static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init gds_apply_mitigation(void);
+static void __init bhi_select_mitigation(void);
+static void __init bhi_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -205,6 +207,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	bhi_select_mitigation();
 
 	/*
 	 * After mitigations are selected, some may need to update their
@@ -227,6 +230,7 @@ void __init cpu_select_mitigations(void)
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
 	gds_apply_mitigation();
+	bhi_apply_mitigation();
 }
 
 /*
@@ -1775,12 +1779,13 @@ static bool __init spec_ctrl_bhi_dis(void)
 
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
+	BHI_MITIGATION_AUTO,
 	BHI_MITIGATION_ON,
 	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
@@ -1801,6 +1806,15 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
+{
+	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+		bhi_mitigation = BHI_MITIGATION_OFF;
+
+	if (bhi_mitigation == BHI_MITIGATION_AUTO)
+		bhi_mitigation = BHI_MITIGATION_ON;
+}
+
+static void __init bhi_apply_mitigation(void)
 {
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
@@ -1942,9 +1956,6 @@ static void __init spectre_v2_select_mitigation(void)
 	    mode == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	if (boot_cpu_has(X86_BUG_BHI))
-		bhi_select_mitigation();
-
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
-- 
2.34.1


