Return-Path: <linux-kernel+bounces-327126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A556F97711F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9401C23686
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CC13D530;
	Thu, 12 Sep 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pd3tKEUV"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D381C1755
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168162; cv=fail; b=OfeA7Pivo37LDRy+5y1xN9B2tB7rvldqSzIx/140iOmZuFtXY7Na6fNfwZFHhN94JlaLwSI1SfIsuTcbuZkGsoLpoXgctcGWDE/P+n6sVi0OlnM4jt3WWcjCennV9qZNwGijciUNE/2O0CLFw/iuCIVwbU8A+Ipo35ffavxXpso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168162; c=relaxed/simple;
	bh=AAqBz+/JpUJ/Tn0zBrm18Sv5bWwEk4XYDgq9DaQENvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt3/3AY09Iy1ky5Jy21fWfguZHeiGO82/RXty3AAhGaM+pTZp27AJPdR0+7F8dmQBffN75d4dCXJUuMSJH234IWJV0hQV52uEETx/FawZXn61e/t72SWyrN0fsZSZga/DtmBUgRAvoBpE//yBn5OPITUph19YTkC1QNiJCX5L54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pd3tKEUV; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3m/yrI3oB1couBmr/umq+l+QZepVA1MHSLGY7de3BFljUO+Dj5SvnXyL0mN6DShyx8RFXsjlOF11x3zc9cJiJ7+vh4RLCqaOYZuQcF3QNZpohYY0Wzw56/qPlyYZQw/0i9dvjT8Jvy1uAFn25pXvlbEvM1oLqE1CvvKprguh3MTbCjJOg5MlvoDO9d3C9g+rWVZT4OAW10QHg6onTExvD+/WVrLVICB5wAmpcK6XyJIRbJdXtz6VsmaUW7ZZvsnkxzaQpK3P0bpKOwxLkSW0qH9j740Z/WNkD7zzl/OX0hRQaL+AdWI2KlBDIDtiBTs6r+y5lk5W5HZHwrNyLdjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PN7cG0zo5y/9+Gfu9G4um1So66CFCbVl4LtrqNall4=;
 b=mYYJKqDf4LiyCcZ4OVEJynGTDf5GOsBxB2IND2jQOOSTnNT4eHqNRuJPgdtKmg84R+NFoden1QUskWqS9AFosnE+W8Gx5vEmzGLVE8ErC9v96GfwmjJESwSMIlZSV4R6oVSNX7YbIx877TFykaVkNsZGxJCLWvEFyhjJUVlPuWU5hu+rUCQXt6EKMwdJldh5IE5npNTVoZKzc7PXLml2V9qwpVGHGxRy4J1ASHRr4qvwwgkxsQ46NcBetUjBRNJ9TfxGDjXqgaH69IxPlfU04963sigigZvYn1Pj5SPQ1zkdwehnEqvckbxwx1DW8HPjQlvXGIDAV4jGySjF5usV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PN7cG0zo5y/9+Gfu9G4um1So66CFCbVl4LtrqNall4=;
 b=pd3tKEUVTu9l3cUbxkd1VAc7rbtAWp3tko+axP667AF8FzyoE1ugqtPgX+67EcSc85LI0BC3agsO0H2NxOc3x3THIdGoAdTn2SmQ/PNDf2aPD43z1nLEghno6SzXm19kcNnavdb4G4hXXjZJ9eKjMJu6w2lGmY1eKP36PlGLGyk=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:09:16 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::8b) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:15 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:12 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 07/34] x86/bugs: Remove md_clear_*_mitigation()
Date: Thu, 12 Sep 2024 14:08:30 -0500
Message-ID: <20240912190857.235849-8-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bd5734-0eba-4281-cdf3-08dcd35e653b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTLBUbdaQd/l0zkxRUkQB8GLo9jXwbuOtiRCt4DW1zjvhX29UigCD8pyB9fm?=
 =?us-ascii?Q?crKfXDuIWZn6Jp/rI+hymUNtwtsr7+b9rGhx4mflClrfIxKEiMP989sT5w8Z?=
 =?us-ascii?Q?WUxTCLN53ChpUgbVnkqYcXSrqLxRP7c8kDGwVHOLyxNIA0vf1zEI1LSLZytH?=
 =?us-ascii?Q?zFU+nLmNR8o0LonqSRgYBLGsONDnwM4k76h96CJVJZKTQQBxgNOzHqCUVwpR?=
 =?us-ascii?Q?EnE919DR297kWJQbpBrgCOCu8PtAajoJ77ftjhoSBVuFJPnhYTPnIw7RRcx/?=
 =?us-ascii?Q?aRukOVr82V1wq0LQudPhFEBvmlEYU6qEWlujz+Qvyfv5stXMQjEi3lSPpA0w?=
 =?us-ascii?Q?G8UA/55Uue4alzHXmlzgUlG3KqZjBn56sTodp7oimtlFX/ouNPwDlcQm6XLc?=
 =?us-ascii?Q?Q6h874djgpbcyPfDC0/ymTVOx4U41YVBXNzuJFawGIHyILLrBGhj7JSLaawH?=
 =?us-ascii?Q?3DHlNkL+OMWpx4abW1p4HAyF6ChTcsdtHXhVQ/RN9R1fW21wCBDrvhje2Try?=
 =?us-ascii?Q?jZGsutNRfZ46IhxVDUT4Y3JD4qCIx8zYKu64H9t9dazM7a0Llp8E4/1px9C1?=
 =?us-ascii?Q?vkc4bn6yVdQcdd5iXoatosfPxIt3yi6j9+bC2wZ9XCDxPxzmzN1M0nXxeQOC?=
 =?us-ascii?Q?yKF1QQCW69pM5rzWcVMjO1Kj4QKXOilXsMMiHkLZGLUJw7Tb0D8eob6fEsEN?=
 =?us-ascii?Q?a7oHZzNR5oqWl9XmcCa/2Gu4Z1J86CuoQoG9wnuH37mM8TPTw/3jNUqF8fnp?=
 =?us-ascii?Q?rLnRG+76waJqpSm6a2xC+EQUCbloz6vKSEd9b2JwBQwit0dJ0PljolR2qzbR?=
 =?us-ascii?Q?MPbL9hBG19FqK14skGM2ANFuaVEjzpc0G+uLfzmC88583XEetx3DZUCwL29h?=
 =?us-ascii?Q?6rzds6hMWDLtHd0LRfqG7+T8JMEWWBO7iLlfo+Rht9S2qB7aPGyy2gvaOhVc?=
 =?us-ascii?Q?DhTTT4D9qCZFoRZj4j83KBgWJO9FXVTt5ceNczXB8r5KBr4e0JPy89JGJBJD?=
 =?us-ascii?Q?gx3cEei/4z+kdzsjoKMMv/Tl8PbV8+CEW0gmMhFbTDxi74ApSB6Vp48shu9F?=
 =?us-ascii?Q?vwdvuBic5Xndn5O1h2o21Y3+O9we2SuMalCVY8jR1pnnIzahZt0XpswMBPFD?=
 =?us-ascii?Q?g8GHgXur+olm1V5b/6FCv5V9SGt2L6j6omcAjmW2VypgjRRhyt6mcCdw70zE?=
 =?us-ascii?Q?L/1h3KX/5HrfSniRdouik03WcRrf7XsONCpBuVeVfXenXWpdyugkcAtxGkBd?=
 =?us-ascii?Q?j1+0Zhaw5WYsjT8fMtEIJMc3dHg3dU4ymLHW4+V4XIKh0CjEeahzEvx7L+P3?=
 =?us-ascii?Q?AK4qgOJjVlhj0eRr+Of5ruosonv2cTBRD09L7yTNVRY+EC1ckV6va7+XKkVk?=
 =?us-ascii?Q?eZe76e/PAJNW9sUdmpkO2EquXvJ8Xh0O7Gz7OZ9g0V0b36RmGZde3tDslpeH?=
 =?us-ascii?Q?jjQw7IrLdJUUjEq8lytmRDYxackjAgO2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:15.7166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bd5734-0eba-4281-cdf3-08dcd35e653b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

The functionality in md_clear_update_mitigation() and
md_clear_select_mitigation() is now integrated into the select/update
functions for the MDS, TAA, MMIO, and RFDS vulnerabilities.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 65 --------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3e6ce7238e4..df41572c5d10 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -62,8 +62,6 @@ static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
 static void __init mds_apply_mitigation(void);
-static void __init md_clear_update_mitigation(void);
-static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init taa_update_mitigation(void);
 static void __init taa_apply_mitigation(void);
@@ -197,7 +195,6 @@ void __init cpu_select_mitigations(void)
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
 
@@ -661,68 +658,6 @@ static __init int rfds_parse_cmdline(char *str)
 }
 early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)     "" fmt
-
-static void __init md_clear_update_mitigation(void)
-{
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
-		goto out;
-
-	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
-	 * Stale Data mitigation, if necessary.
-	 */
-	if (mds_mitigation == MDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MDS)) {
-		mds_mitigation = MDS_MITIGATION_FULL;
-		mds_select_mitigation();
-	}
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_TAA)) {
-		taa_mitigation = TAA_MITIGATION_VERW;
-		taa_select_mitigation();
-	}
-	/*
-	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
-	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-		mmio_select_mitigation();
-	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_RFDS)) {
-		rfds_mitigation = RFDS_MITIGATION_VERW;
-		rfds_select_mitigation();
-	}
-out:
-	if (boot_cpu_has_bug(X86_BUG_MDS))
-		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_TAA))
-		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
-		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
-	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
-	if (boot_cpu_has_bug(X86_BUG_RFDS))
-		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
-}
-
-static void __init md_clear_select_mitigation(void)
-{
-
-	/*
-	 * As these mitigations are inter-related and rely on VERW instruction
-	 * to clear the microarchitural buffers, update and print their status
-	 * after mitigation selection is done for each of these vulnerabilities.
-	 */
-	md_clear_update_mitigation();
-}
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"SRBDS: " fmt
 
-- 
2.34.1


