Return-Path: <linux-kernel+bounces-327130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 476EE977123
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C926B1F24908
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284DF1C243E;
	Thu, 12 Sep 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NFXip+q2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1E1C1AC8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168164; cv=fail; b=TOuzUkPSNNqc7rRyCErkSPwmn/VQrj7BLPJlZrzkGHqrcEZz5BM/tzjUxYmOf998dzHv9CiAwIHyuSFcpPFyTkqEZVPLRm/fRgSbe9/E7bgNSCLL/wH6ydbqb9Z2yDQdxid06RLz74BExOpPmncaQ445LQAHYfDIgxfsGgHNqFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168164; c=relaxed/simple;
	bh=al3GEiEmj4A9fgAFa4EDHSe/SUAactCdQuHia1u6XQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSnInCkJVzi3dcUDVq+rLYZ6UVj4o4NXc8dLVkJHJ6+IBAdFvyeySSc34vWioSbjCrdufjXQICLC2H8E6+4/rLQPAzPR2ev7DVlYO300tHKPYvj5V7/mFAmRsVDf8MGpTh/H5t1qu0MjsKfyXnkiuPL7SziTxPyWSp+PZJg7gi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NFXip+q2; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRIfuSv3/XneR/GR31CxpOulpHdgx4su/HXd+1uyX8HK61kZkd7vWL+6+oAnnYF8s89xhNugHXunv9ZcEWTOMax6rnnXTB7dCPUF4u5n1Mht7iTvy5nLDWPa7Q4oZYux3ReAYWt0dFip3HkJ491Z14ghXQvnYE+2dtvh4lMgO7MB43wkg5Xgai0Bk0tZjYmUGaUSy3K9kdXOoT15Dg1xVkECmBC/uDk4c9GxgW0vIK8+CviiVMgMD4megyie+K3Q9fNZWitCahTS+OjvRTOaWA4qp9LVeGQBUqCIIWkWXLi7od3fa6NVebZcREgXslThZOOIZapqhMGqOyjPmJaP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRWipI/tqhLYgu45G390IDooBjk7vE9b9+nEIqwCSOc=;
 b=IvQ8TG115/LLAID3lERRxJgHTCAl/AzvzgTV6SaO4WBmX2A5Q6Lv0cUMfHlslSP26lvt8eBKnDfDIiSU4/5jAwRfgd3jpgCSScj4X+XPmTDRKjVLleZpf9NgqODQ3VPJMwI8jW7h1RWLor1cxDs/rTug6af35bBdHh2YKdtayhXu+B15e1WP0T72UqfdyatGsqyiDIYKgG6kaSdp26dELxRJb40SwZiYpBE+fNBZ3OSsAQoZ15wPGYLAfVANL/7MY7Anq03qeTpQlrnjUcf+PyGjuQhJIIMXi137gKtbfEp9PX7Xc5baAjeo6NL+QP4D2+vf3XxNtA+5pxXOElJDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRWipI/tqhLYgu45G390IDooBjk7vE9b9+nEIqwCSOc=;
 b=NFXip+q28KTmLNmtPwAjPxOAlehReuPNfkU0GiwiE3XTjsCuezqnNRMO4DXlxTx4L7eZVb7U2PnyLTJvLOJyVANz4bg7pSuedMifLVyBqoOFRCFHVqcKeakV8Pi67SKDRydnPrZfAUkOT6MWGGwGGgE4UMiNe+Uxs3xUgUtE4ko=
Received: from BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:17 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::a3) by BY3PR10CA0030.outlook.office365.com
 (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:17 +0000
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
Subject: [RFC PATCH 09/34] x86/bugs: Restructure gds mitigation
Date: Thu, 12 Sep 2024 14:08:32 -0500
Message-ID: <20240912190857.235849-10-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b67ca66-8051-4c07-6aad-08dcd35e662a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKr9CA5+pdQvp8P85qbJrILfwLyFEk80jOZpcerfgz30bQPy5quHGS+WbXt7?=
 =?us-ascii?Q?UYb/JvdgiMIph+tkJkJ50nNVY/Mv5fFydBFivns8hgQsCLihILOp3vTPE001?=
 =?us-ascii?Q?Ard9JGYEYb8J0AY4X59QLHmTSlgn16r82d67s1Zd3gfK3M1RjUi78BAvMFkR?=
 =?us-ascii?Q?k1EgawvQmW9zWbmdOXCF+CAmSKgBv2JkMqM/QyE6DMItWOKojW0+VzbCoz3Q?=
 =?us-ascii?Q?ZDdNpAH5/oQXG4c2hZCk3/PPDGL1yxIVAkat2UPP0su3rPz98S2o4ypaOzgd?=
 =?us-ascii?Q?TXKsbrsh6FJ1nJ5XHEWqHX3KQk1vMTTWUVr7bi1s7jb5ECYJiV92NSpeBTHJ?=
 =?us-ascii?Q?4JU7PVwvkZvwoGuYClrZIHuzI4RtXISoiU2ykHQ7JTJDEMpreVxswKVcV1kU?=
 =?us-ascii?Q?pCljDgICiCurdU2QS3N0xAPg4G3AR99vH3PJTsh2nsULpDvSTKBLLz9ZXUkv?=
 =?us-ascii?Q?H7mTvVrkntqEQAmE+zZo+gclxaMOTtpTapbjIN2izfy7FNjEAtI0Pacjv+u4?=
 =?us-ascii?Q?DoY/s/Syppl8LgWTPePGm+O7tPvQRWaxWZi1WV8qMcRQxUtPVYjMtcIX9LiX?=
 =?us-ascii?Q?2O7F8BdBiP9Jb0U9mvIIpu6Y7Tk9IgPP/3bYPDk8kuOwnSwnSNIi9JKYHaRZ?=
 =?us-ascii?Q?OLvIOAOTI9ZUOCwJKvpkPpV/LyiV+mD95tBR3558PUNh820Kt/E1oLbG77Sp?=
 =?us-ascii?Q?oZAU3UmPgGUhO6DIYbVG7wxBvHvQyw7rQ05UVfWscp71uwJ3XzMyGOVyxwNK?=
 =?us-ascii?Q?BD6HJOtOqaHrvMTEIh7/BnCcLmQifBT2yct24J8XAqzv0I7DVlL8NLRWXseZ?=
 =?us-ascii?Q?ma9tDy0fUGpeURFAU7bjwJkuYqovZfmn63LKLtg8o5wHsJXhu3kaZ65uIq9O?=
 =?us-ascii?Q?Zuf899RGp5DCBDB5/1Y3r3cuQzMAhZjtmF+49GQSebTn66OMrv4r4YK5zCZv?=
 =?us-ascii?Q?5+sM1+Z+DZzkfuGZ0FXiBaO3hXDMRNsAfMaDN4KOXfgZrZM2Y9ZOHZERnwbv?=
 =?us-ascii?Q?LhdD98kvkYiWltIOq+molizqepTaaaI85ei9tdzqhlSoV66rw49HaVikmAGt?=
 =?us-ascii?Q?MdyIlbBbSpxisBXxyGdvDOkzfZEA5ki7U93FEoexk7/QGL7Xm+yNG3vBc/pU?=
 =?us-ascii?Q?QUTmGVc/PkXNZOOIh0SCwTgXv+ztBOhw/NktNgd1+qWrAlNTqpWNNBmNvRP+?=
 =?us-ascii?Q?sQzKeSXJvHNSYvMerlGHTe0pkFLXq4nmMr9ryKSpK0r5DQB5j84tLDK5E4Ld?=
 =?us-ascii?Q?8+8fY1lWbgwSv6FP3QUuxm7x3RV1hV7dxZkaQYr3zz/llau0PSViHtpEMu8I?=
 =?us-ascii?Q?hOqFewKIIdEl2kmdfTN+pexw2hkGDvlMjAimg5zDGdR3RM79DtMjS1yBgLcz?=
 =?us-ascii?Q?1nlASBIhwEgWg5jaNp1YMm1Bi96y2v8zXH/zpoQ69RIEkfqZT7xBj8usDh+M?=
 =?us-ascii?Q?XPDhQkU+PVpYycGoxfjm8uFX71tyJD5D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:17.2647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b67ca66-8051-4c07-6aad-08dcd35e662a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

Restructure gds mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for gds.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0fb97b94f5b9..7fee5c3de135 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -76,6 +76,7 @@ static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
+static void __init gds_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -220,6 +221,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	gds_apply_mitigation();
 }
 
 /*
@@ -801,6 +803,7 @@ early_param("l1d_flush", l1d_flush_parse_cmdline);
 
 enum gds_mitigations {
 	GDS_MITIGATION_OFF,
+	GDS_MITIGATION_AUTO,
 	GDS_MITIGATION_UCODE_NEEDED,
 	GDS_MITIGATION_FORCE,
 	GDS_MITIGATION_FULL,
@@ -809,7 +812,7 @@ enum gds_mitigations {
 };
 
 static enum gds_mitigations gds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_FULL : GDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_AUTO : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
@@ -850,6 +853,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_FORCE:
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
+	case GDS_MITIGATION_AUTO:
 		return;
 	}
 
@@ -873,13 +877,16 @@ static void __init gds_select_mitigation(void)
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		gds_mitigation = GDS_MITIGATION_HYPERVISOR;
-		goto out;
+		return;
 	}
 
 	if (cpu_mitigations_off())
 		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
 
+	if (gds_mitigation == GDS_MITIGATION_AUTO)
+		gds_mitigation = GDS_MITIGATION_FULL;
+
 	/* No microcode */
 	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
@@ -892,7 +899,7 @@ static void __init gds_select_mitigation(void)
 		} else {
 			gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
 		}
-		goto out;
+		return;
 	}
 
 	/* Microcode has mitigation, use it */
@@ -914,8 +921,14 @@ static void __init gds_select_mitigation(void)
 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
 	}
 
+}
+
+static void __init gds_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_GDS))
+		return;
+
 	update_gds_msr();
-out:
 	pr_info("%s\n", gds_strings[gds_mitigation]);
 }
 
-- 
2.34.1


