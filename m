Return-Path: <linux-kernel+bounces-327121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF51977119
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35D61F22841
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B211BFE02;
	Thu, 12 Sep 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lSkqOTv3"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B851BDA90
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168157; cv=fail; b=g+sbI+9FiCRehwep8Rh2/MyOcYzbDaki1Gli6oiEDUhhhsrJc+VeazFsecrWJI1XmbtqD7i621oB1VSvWJGtRZcjEniEwQanheTU2KGxaUQS9imeK015rZD9ep7Um7pzpg5EK7vEmpjcOFMJKmyUQ03eeXl3NdNnXNCIjw50ZbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168157; c=relaxed/simple;
	bh=d0nJG4uWYKFfBerN+EFf0Lavown86xSo35kM5rI6CQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRI/B3fbE/uuDn7OVI8uvLSIwKVdCdz0kkEgKAi/1+cWTdMgTjs07EQtChcfXFe7cldUdX194NcxADlamSpKVQQ7+WEY62UXCSZBRbKYgQv87qyuJnHo1kIc2JbxRwT1rWAXrykHWxzFv8Ogxpsn08KV+9sBOS0h0uyJbHzEhRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lSkqOTv3; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ3LvwtUqCF1GBs/iVe28JWLiPHdhujwKhoI3Ssj8zrx7iR5uyM3Lo+7B9z7f8s2XJc56T43q1gkF7PWr/hUtshRsK2xTYoTB1nmmNeWPlqRWbHiLNcSLWNxI1yMjnK+G70md0YOByg2aI0K8l/2k9YWwhqYNugTpq78I9ibjyE+lWa5V9oWs7Yai/Lvnt+DYj5zBsqJK2X65wHLm/2XyGeMD/KfofnAFGSaP/F+z/jT2ILc4N+EIbg1uB5Tpcv1p7ofHIglQ6+nCO30zZj2PvDM9x2Ji9pJyqxC22diBSzdFqVdMY4vxE1l9egGsLJbWPMhWOOi7baDr0739afaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8KKc2P/woy42IaZh5WOg9T41qdA4FCvdAkOvOb5isg=;
 b=jyChM7aDgEu7tciRVH2B1Is7deBFYYcrGwQJggPXBTLH+gxCtMvJ2LdvziBvFfV8BgSe7PjRYBtCLDCfZ1mLR8XLPOxNoIUsCEWKsTnDK/TI6CK0QIfz8Kxk2UCMOEeFzsdjRE/OBsT9Z7H3Cuyrn9Au2yE0JpjbY8BsHgBoO6aunUspPIWpMZZ/ekfHsyV08DiMZbCDDdDbn70gxg86jH7a5p94WV1h16vykoHGKdihmAEcqNsdYj/IVrircb5zaFaaRatN3PRHGv4j5PEqDenmbT0bGQnvKtAO9p6zIdrqhWJ1G8pS79OwcYIfz7mMjmePGJJY9K4dUsJifwB6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8KKc2P/woy42IaZh5WOg9T41qdA4FCvdAkOvOb5isg=;
 b=lSkqOTv3j1/95jlba2N6rpm/7zy93IVAsC7A4A2s5JyVv5oamNVuQfZaHWeItW59eokuq7phvCO9FsdAGkxdSxGM4rtxOnotp5M3VwL7lX1py77eTyfAHAxSfL4TWZ7eBg0RZFc0V0HpwixaYURsbKiGlFdPVfGjXO4EQCoEuq8=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.31; Thu, 12 Sep
 2024 19:09:11 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::32) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:11 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:09 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 01/34] x86/bugs: Relocate mds/taa/mmio/rfds defines
Date: Thu, 12 Sep 2024 14:08:24 -0500
Message-ID: <20240912190857.235849-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc6fd65-53b5-4c09-2728-08dcd35e628d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8aaLVF65oJJMcldpbNFx+R7VLQzpO7dU9PfxzLpiAsadwgNk9016IDuo/Af3?=
 =?us-ascii?Q?vxl2xYELP4xMym6K+HQ+rLNAi6acqT1AwYbd5FYrCS9fnPqq2NlTp3kyyV6a?=
 =?us-ascii?Q?WcpB29A8AbV7rxj1fszIo7vITDp4Mgg/cq5OeRG9+uZZYK6vVHcG7+tFkGrZ?=
 =?us-ascii?Q?iiko4m2eV0GsCknJZWzAO5UQ8mPCPoqBPHIqq7lIeMvH1xJt8XMO0dyHiOpZ?=
 =?us-ascii?Q?MdcM7hZYPpOmNoRLLxGZ+zasBRQJVNpesh18TNm4rj/65Ggwg2+63Ru/c5MY?=
 =?us-ascii?Q?lE1jv7p3kcKv9PRD9P6wLqMg7saLmR654hNes5qPux+1DTKzv3p/IczHoCMw?=
 =?us-ascii?Q?C9+kCE/ELuUVnqQDZAl+Hjgy/XSVzhSzAePRB7HlIkOwHjf7rbOCHcfQnQZR?=
 =?us-ascii?Q?kv2tgt7JO2GBa0wnyY/mtt51NOF/DCWOz6RE9Zmj4NW6aJjP91qqWM6f2nCB?=
 =?us-ascii?Q?zrCsBo9vF71BBTQxd3gTMOBL7zsEw6JA7Z9UMSLbxooPEWnYy3MC1WN8Z9uM?=
 =?us-ascii?Q?f0SS3SIGIs6cDAxR++fjmSUML65/gwD5zq5dSIMmUEO8L2Fm3ZrNonFbSUNA?=
 =?us-ascii?Q?jGxebU/amwsMo/3BR36tBhJzdv+hgpCnNblPMK9SHZI9nBpBKeNgMCT3Pqd9?=
 =?us-ascii?Q?fc4ZNy3tMST4ub8OqQKdxNRKHHBdWxBf+slRAGMO9CWnFPU7/mNQUDukNu+u?=
 =?us-ascii?Q?h2jxixX5LBCyX8t5pSP58GWplfUuEgcaD7ynDIj0yQK2p5aFv6oTKka70NU9?=
 =?us-ascii?Q?K01XNYvnMDzMiu3uGKXSuc09ntFxYpyumO1MsCmwe7cV4Rm/Dw4yBKW4aKXV?=
 =?us-ascii?Q?m/AaTGQa0jfbPe452vVTCskaQiffjKgvlpljKjZQG7V2uO4uchRERF+053lY?=
 =?us-ascii?Q?ANFazeHwzVJccEQwP8xoVN+o9pIhmsxQnT/y/0vHEkJdfqfhOOuWU5u77lib?=
 =?us-ascii?Q?nGMNFNzIxmTET9voEBRxXGnHWDC8C4MKscrc4/Zgm3B+Wh3VXnlluAwfI4ig?=
 =?us-ascii?Q?l+kRaRgPdIeUXkMtYurgFtVsa712WrygpAP/R82E3g8Qk9nAe3y5ZDiL952c?=
 =?us-ascii?Q?ziDOK9TsVz3yt9TX2JhtG1IrdNKdfb5taan0+YqtZChEnpt59Kw3dZ6pxkwR?=
 =?us-ascii?Q?+zNdUdc16XXpcEHPdOhyHAUf1nRTKEWEu2OKEeXI2aL4Et5VpgKYzy7lnro7?=
 =?us-ascii?Q?UTiwg56/pkXMfsEEgN71omxhlmLkML+ShAJy83UiBRRZS8PD71ruH/+EYX4e?=
 =?us-ascii?Q?XsoercP6hMHpM/FjwiZzitJgJaEWGpH+cPehe59gUtWQJwDGxFbxC84kyFfN?=
 =?us-ascii?Q?/6Ko+FTkeQnxAAr58R0jZX9NSZ0KMhbwzDg8PIjGICtGyH0pkj9SJOLe5kSR?=
 =?us-ascii?Q?6VS0r3iE6b5hK9yS7mnWkrlFOQhqywsMwM9HUDf/5N6TU0DK4ZBkgLHPliEI?=
 =?us-ascii?Q?vEp3/2HWfROm3cQRfqLm9f8Hkz32ufbi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:11.2009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc6fd65-53b5-4c09-2728-08dcd35e628d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

Move the mds, taa, mmio, and rfds mitigation enums earlier in the file
to prepare for restructuring of these mitigations as they are all
inter-related.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 60 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d1915427b4ff..ee89e6676107 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -243,6 +243,37 @@ static const char * const mds_strings[] = {
 	[MDS_MITIGATION_VMWERV]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
 };
 
+enum taa_mitigations {
+	TAA_MITIGATION_OFF,
+	TAA_MITIGATION_UCODE_NEEDED,
+	TAA_MITIGATION_VERW,
+	TAA_MITIGATION_TSX_DISABLED,
+};
+
+/* Default mitigation for TAA-affected CPUs */
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
+
+enum mmio_mitigations {
+	MMIO_MITIGATION_OFF,
+	MMIO_MITIGATION_UCODE_NEEDED,
+	MMIO_MITIGATION_VERW,
+};
+
+/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
 static void __init mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
@@ -286,16 +317,6 @@ early_param("mds", mds_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 
-enum taa_mitigations {
-	TAA_MITIGATION_OFF,
-	TAA_MITIGATION_UCODE_NEEDED,
-	TAA_MITIGATION_VERW,
-	TAA_MITIGATION_TSX_DISABLED,
-};
-
-/* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -386,15 +407,6 @@ early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"MMIO Stale Data: " fmt
 
-enum mmio_mitigations {
-	MMIO_MITIGATION_OFF,
-	MMIO_MITIGATION_UCODE_NEEDED,
-	MMIO_MITIGATION_VERW,
-};
-
-/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -483,16 +495,6 @@ early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"Register File Data Sampling: " fmt
 
-enum rfds_mitigations {
-	RFDS_MITIGATION_OFF,
-	RFDS_MITIGATION_VERW,
-	RFDS_MITIGATION_UCODE_NEEDED,
-};
-
-/* Default mitigation for Register File Data Sampling */
-static enum rfds_mitigations rfds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
-
 static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_OFF]			= "Vulnerable",
 	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
-- 
2.34.1


