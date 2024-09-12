Return-Path: <linux-kernel+bounces-327140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D1977132
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5001C203BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F31C4634;
	Thu, 12 Sep 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4yyZjmMY"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F41C32EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168169; cv=fail; b=PVWfGcysrC1uN1D/uAlRxLtu12hlNuAJjAQfoCDBO3pZ8+TunwKrhBbzLuSl+xvO7UcM4ZLxJotUvzIxgXqZPz54cCWhEd5ohjC8FoNqXRHAdA/chejBxQOR4AeKm+g/OSqfjnU7z9XG50MZk7RVDvEE1YckCqdWoYjKfr7b4M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168169; c=relaxed/simple;
	bh=y9w7qxdLMC0D2njyQsp5C5ODM7m1znnc5uNB2LnA8iU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuobn6tTqZBJSseBj5tQy/qJRxy5NSNlHE1/gVjytHO8ixcqEHEWS7ht6Yw63zvjoUgMLHrP09fRFQpFojS+dVCU3bs2kAyWq0Xmp37DTCEqJakthOSqkHVjXdVjNQbCHML94Hm4TaSOCw+7ZbT/OARDFlFUFt34fHV07FU/ZGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4yyZjmMY; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7xu0FGoRoG6UIt+Cqph46MfIRTdpFg1AjK45PWomfPIRus+nVTroGB1IKXy4GQkeFtlJ+ZAC02PR6xkk+era0PH1ezmoytMQ7i0ba4N3UQWOM9SA4m89QXTaWti3Qkbb5/kewl1U8WOfdeO+r2uBUWlftuED4o7Bmtb1GWJmhaDcgxCubweDcVcqm0MHpZGVvKRXcNYGr9REJkMetcGHoRsh6RYFZOE9jIzq1Xq295THtxK0aWgeLPksSR1kfb7yD0x4C8lkNWZvwy7h8t2uC21cJkErtd7cCe49qfeSsk8hMOa3wVs+p0CyfKFqhqcpfmlJtNSR5+d/ZZQnvZBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb1unM+MBdaZ5HUaQc44O+m+QQrs4RphyDUhXJbVX4I=;
 b=iBr58GZ328tZvg2ktN9aRMVo8rJI59MStNFN10wRiE7fMQvLMVfebGPvqnJGSGUGfNakiccwH/RWrE/EunZ0jjJb16ciOBDQdYcPLHMsW9da7uQHbPgPEkGW3rAx1u6/7rLYHNev+IIID6PfXoKG7UjwtRE77BmXmgqJHtN+86enIlq39qa3yt8+al4gV1nv1+RjK3d5Zy+EVYU/eJ86UNUOWd0OBdtxQkX71vx4/Nwt0SVCESLbjtUxkNY1KrtmiXhU1CW643taq9BiWLn7qecgEarFWFx7baE6QCVE+igc+H3fGYpTsLn5gcXKBKLts+tIoX0GC8twqeEWBql9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb1unM+MBdaZ5HUaQc44O+m+QQrs4RphyDUhXJbVX4I=;
 b=4yyZjmMY7TxPeua08ZMsZZKclcJ/ffDD3TsOZd/ZhO1cxYcTLJfnD5k9dDDcZm79gO8EViGd726TbE6Z2Q7/CGu6gpe4U/3++nnO2tIpNVEelYNocAr6o+7p7Uc6Xi/dclIR6ghcV59HzfpkiOxDVuvln7t/kry2qI5wlvW1P9I=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:19 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::ae) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:18 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:14 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 13/34] x86/bugs: Restructure bhi mitigation
Date: Thu, 12 Sep 2024 14:08:36 -0500
Message-ID: <20240912190857.235849-14-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee1e335-0a38-4ee4-e06f-08dcd35e6713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybrwSRcTYDnE3Ef4BptbiJKXvrZnQVCVL2ign44EzF5ub9AGzd6ijFke7qgl?=
 =?us-ascii?Q?5RkkygbvlZrSOxi0ursARnghcacHaEMnPMEnQKn3W/uTsI7+TIsvuB8Bjiov?=
 =?us-ascii?Q?cBAqMFMgQi2C3y6GmV0QFqJwuaESY/RnYRSpzvXp8CvGFJl5yJZARBmalpC7?=
 =?us-ascii?Q?/LVSZEALo2VUimBf80H12zcA9joorgF7C1e6gLxtxRd6aK5Y/HEeTj8HjmxO?=
 =?us-ascii?Q?/t6OMc0qU5DOYy8GWghMR/egkNj7ftpCw57rgb9Kw3fNHAkgmASg6GtZBmew?=
 =?us-ascii?Q?s/o9FJccMn+c2dg9XAW6IVOX3MUF8qFnKWd+7dSIj3UeHoR3G0HxeLBq5/Ju?=
 =?us-ascii?Q?O1WBTgDrZOwLdZPeTUeRasKliWZ1veAx0rPtPTDjgh9NvklMtJBBD9raytp5?=
 =?us-ascii?Q?U9Ndm2pA2OqxQaB4yE4xspuVi54JiJT2TSsnStQJztyqu0xGQF8mhPw4LB+I?=
 =?us-ascii?Q?4VWggmTgcOuch4uq+apsKJMCernbUxfliNvujiIeFR3TY/W5B+TOUuncKSqn?=
 =?us-ascii?Q?RzeelFCHd5Gno8VNBej8OLRdiVOwYH6omX5Ppqn/uyKPpMOun/MD6j7DhozY?=
 =?us-ascii?Q?+jpsMwxXioXx0nNHU6Kg/eJoBs7RrM9doMv0vSa456LyJJrNCBUXCQ2kRCUq?=
 =?us-ascii?Q?vj5htg4VbcOJVOvDydvFYAwQoa/bcJsJSAPLDOwNQiTpgasnf2mrXi8Dr8va?=
 =?us-ascii?Q?JScYc5KEWKCYO1am6W5xThyO62jy+1UCQTDaDiYYzrkyYPcHK0oklL/3a1HH?=
 =?us-ascii?Q?3v77LDtjUMOzE2sckUdYv468OreruOu0lzje18F/uLkS6hkZRblJPh1PHMvE?=
 =?us-ascii?Q?W1CfvgzHRYpaHG5jodhv9uZb33eq/aTrVoAKH2cfX/28cKMFDpedIF37gEv9?=
 =?us-ascii?Q?A0fROUGWqmYPcSDCttin93rhX2jJOeOQZJRwPJiQzT+ICK1f57pzkw02h1ul?=
 =?us-ascii?Q?Vc1Ds5tjU37Y1Kg9c/11Orj4b3eaAtJJack7rd6Bpq73ukDWkwaoTRpWuDcT?=
 =?us-ascii?Q?egLTcoGZHkjk7Prqy5EH6iYOT93dn0Y6C9SM9mgXjBa+d3iAFQMZ4t0l7aFc?=
 =?us-ascii?Q?gUNkIwRIkO5B43DngKRbgTMRtyyguxsDA5C0l7yxfb0Gys6PjqYG4/mt4weY?=
 =?us-ascii?Q?S5wtWVR+a0Iue1VoonSN4erITKiofYnTfRsGryENNH3tQdsa/D55BiWK1eVZ?=
 =?us-ascii?Q?yYrKVrJRiF2hu0b7mONzpng3xuFiOmKui4F9AYbgrUGHFSzxlYwCSS/8TI7v?=
 =?us-ascii?Q?qkup29yhgmTBKnMNz3BbMzo2fYhMkdQ9JZvBF83Ta2Tf3SB7djE9IZujslnV?=
 =?us-ascii?Q?eo02sYfvdxlGjyWJjyDOz+wXLjagml8HVvWq073U64Kf6D1/hDfkAntchLYM?=
 =?us-ascii?Q?91MPSH+9AlMG2vnJMjwgc2Q/N0VP1+HmtCshzlwE5ebmMeVg6M476jYcB6p4?=
 =?us-ascii?Q?b6zJgLEiiiHLGCOAc8lAnAJPhxEM+gNf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:18.7947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee1e335-0a38-4ee4-e06f-08dcd35e6713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169

Restructure bhi mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for bhi.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index eaef5a1cb4a3..da6ca2fc939d 100644
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
@@ -201,6 +203,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	bhi_select_mitigation();
 
 	/*
 	 * After mitigations are selected, some may need to update their
@@ -222,6 +225,7 @@ void __init cpu_select_mitigations(void)
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
 	gds_apply_mitigation();
+	bhi_apply_mitigation();
 }
 
 /*
@@ -1719,12 +1723,13 @@ static bool __init spec_ctrl_bhi_dis(void)
 
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
@@ -1745,6 +1750,18 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
+{
+	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+		return;
+
+	if (bhi_mitigation == BHI_MITIGATION_OFF)
+		return;
+
+	if (bhi_mitigation == BHI_MITIGATION_AUTO)
+		bhi_mitigation = BHI_MITIGATION_ON;
+}
+
+static void __init bhi_apply_mitigation(void)
 {
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
@@ -1876,9 +1893,6 @@ static void __init spectre_v2_select_mitigation(void)
 	    mode == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	if (boot_cpu_has(X86_BUG_BHI))
-		bhi_select_mitigation();
-
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
-- 
2.34.1


