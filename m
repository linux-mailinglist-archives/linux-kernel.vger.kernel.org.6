Return-Path: <linux-kernel+bounces-397201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 523619BD7E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84AA1F24F82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1DE217335;
	Tue,  5 Nov 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cDX31ZrN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161222170A7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843738; cv=fail; b=YKxQTrBcj9oXXhaLqJaeCow7zTUuJu44tZyI1FCjW3P1LHQQ6PxFt77f0DMHQyokErOSmwv550CdwTHYJie7PpelGOSTWjbLKc7FxYLlyAW1q9DKqBI69s5kzdOKIWc6H1jkmx0nWt/YHH8OEYsMtNWS0yB1REk6f18dc4nLs80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843738; c=relaxed/simple;
	bh=GyLkMamLb4p5cUdEl1gDyA5TkJWrSaAofEQKXBoUOzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgb+ZWWpk8fVho9WmA3b0ByAm12AE3zJBx67rfwEB+f4uVXIXhePogr4Leq+g+NAqtFbWCKepgrZ2uRmgSpesjPMqas9yPZp7Kl3C6g092PjY2p20IhbQWczoMzTH26/qGEa2ZpMOYuo1A46R6uoY2VfsjBJDypwLctFdz0ZsbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cDX31ZrN; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9H0UMBnokKOANNL1JlW4C80MBKK6nTB4EDdmK3pD7eIq6FnOx32XVSmGc6RSq6ha+XvnfPgYfNs5KJg0hie2j6T1y6FNOmZe/cIsuaUfSTi6Zeda2aDOMs4S4LhqHxj01KHWKuf6fJdPGzun9+MEH8c31F0qbkP71F4xo/ONdpyFquZeYnPehF7e+07FyTFNoiQWXRckb8FM7Q2pKHAdccy09E5pMCxDqmCzUwxshZMlpcOvT/9CXIrJyfNx6X/Db0v/L2ZDepas10ogpRB/PH2mettZ9tAmBlFYdV0xnUjZp+b/DhjpIfdzjry3+XdIZ1OrvB5oIAGyCmvEEPNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqFW+hmP1IFhZVgSJ5M3P+lRpaa2CcO+eBGeuCHCMH0=;
 b=mNY+RKmimdMPhrs79StaNW6lvycg1f7pmLwxg04ctnz40gtO0jhPIEGoDtHHJynW8JP1ZMtsvMQ7s1bJJJ7+vRQJRGz7KUUziI9GD79ccO4sIjZxpeBQiY+teVlQC4QEPWUZ1C+L8lnSqBOTwS3qrkURQ9KnBSDNkKNV3/AKo26ONZg0igYm53j2Ad2/OFyNg9oGo4B4UlQsixDMLtpfqV7H/gjxg06f6r0wOgwH0XLm7wlMEeIhaaH4Y0x8Q652RgnlQF2BKnhV+oO5my3M6NsRx8YvhnZcbPF1R2KzG1MfYQDQj5RLVw0ZA6/HYdyFF8QnzVn4N1YEQkexPE8YRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqFW+hmP1IFhZVgSJ5M3P+lRpaa2CcO+eBGeuCHCMH0=;
 b=cDX31ZrNFh4RTKbiJfG9jWFNu8RAJ593j9tj28i3ybNrIVZA75Sfea7Kqum2TkmLtEmOUsXD3W2K8gghOCwquWwohfYtMjZO2B9GNcPSa0wszp6vQQoa4i08EAYNa0TvRucpbyrAenbQUgY5qDr96uBGvEBR6GdkXKBsRh00Adk=
Received: from MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 21:55:32 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::d5) by MN2PR15CA0041.outlook.office365.com
 (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:32 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:28 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 15/35] x86/bugs: Restructure spectre_v2 mitigation
Date: Tue, 5 Nov 2024 15:54:35 -0600
Message-ID: <20241105215455.359471-16-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105215455.359471-1-david.kaplan@amd.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 082b9fb6-29a4-4072-afd6-08dcfde491e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qj835Pq6TpQY8pgRDtcYK2jj0o8d2ix54TqqS/b/Pztqxd9KUyNR0g7LBdTS?=
 =?us-ascii?Q?7YoE3fcLUqS+AcUHdfUpIW+QtsWkO6guJo6vQLUyB3mU43FZuDAV017dZbe9?=
 =?us-ascii?Q?fpp+wpymkdPyAEJ9CEXNYvcdNjJ68inuSKROKNLhtOvmnxEQsjG/Ddbh3ZKP?=
 =?us-ascii?Q?Ijsu7JQHZiGUZDIspytIA/7kXtz1Cdd4CXSAQpZJYBkxwSqrhE5zoN0f+HDy?=
 =?us-ascii?Q?rEJ6OeX0J08Fc2eV3UQh3Q5U9JV1y1EShHDBm34D9AgdpXpB0FqUnsck15fy?=
 =?us-ascii?Q?6Yml5u1ry+5DkbVX3MjvqiSkwlabdMGoJjIqgaxHOs2Z8O0ELFbVnNn2ktTW?=
 =?us-ascii?Q?0uMR+2jcd9pnHI4G0teKYdz419ddir0PE3QyxwNFeVJXAmTz1nb5G604ihPJ?=
 =?us-ascii?Q?bwSTuEHHvIhGvlG60WpOANHT4vRpwoBOwiOsFyoqca8YRFCXSZDC4x21Ywkt?=
 =?us-ascii?Q?CGlorfyKUIjELakE8LyufL7en5dEN9Rl70KsbMK0mQsnO1T56DyaIg9TW7Ir?=
 =?us-ascii?Q?G9BKXC1j1rdSkQew/2114ylC56G3CwvnI9vJw04KMxxMgzmH8cXsVPHKMubM?=
 =?us-ascii?Q?HvI0FeZt1v7LErlwP/OVa4mrKZ3MQKTpLSGeiKLEV+w2bciKS2trEKOVJnGW?=
 =?us-ascii?Q?NHFga+X1isXrohw7TQoTv00cdIqAoL51640ef7mjFYuEcwtJ2tIp9meSuOuY?=
 =?us-ascii?Q?JOU9KveLBliDIUqXnkhaLAr2ioVFZGkyq9xfCQxDOOsAPA2E66A26JD2mrI+?=
 =?us-ascii?Q?btrlo7FOFYenbqrVfjHTF7KVfslX8/b+YJUHKyu36M2y4ZfLnCYhFwgravvB?=
 =?us-ascii?Q?bR8sCo10sIPvLXOWI5iQQ3eXqKc309ZTeCdM6elK5yg0kqexg5flTnRsLJpa?=
 =?us-ascii?Q?4LR/+0WEcakBYWQ+NIvAPtQRLOEMxsKTFQobmanfdQW+FNY5U701laYu1oBX?=
 =?us-ascii?Q?4Is/FxQwfxqJrVpPZzUGRi5Y1iqhPMRIDdWVxaur2nzJUS0W9pSFvqZqa+vF?=
 =?us-ascii?Q?z73VfE9btdWKTQLtWFgxxrhJhPMYVBVdYIIOFtvEqcjvveHElumrF+f5wrw8?=
 =?us-ascii?Q?nTDoSMfKh3YS7rlPJRAqAvMCj37sQpAX7wBff2jsKMSHWv9SORbiVo6MXYIT?=
 =?us-ascii?Q?LyU4LICZjHbY5cagsWyJig26mEfFYyU4YnzaS+iCgODDZCF25uofUR79b+Sm?=
 =?us-ascii?Q?zbshU01uhHxUCMWFWzjE0UD9b+m0uEmr6qC9O8yZbpOhmMgMuTXw84B7E0aw?=
 =?us-ascii?Q?wUgg9757M/YClruJDrY8tX5ettTk04P70w78ySkaRJp2+lMWNg6nB3REJ6V7?=
 =?us-ascii?Q?mzxw6jT86qjd0lK6ti1IWqUv9RwhwSfaveP5mdbOrQsXQp6u3eVJoDJFepv6?=
 =?us-ascii?Q?548Cl6eNYqDq4kbkUvoBulvShFbwhHef6mj0fSNO0aHIRKLmsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:32.0778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082b9fb6-29a4-4072-afd6-08dcfde491e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

Restructure spectre_v2 to use select/update/apply functions to create
consistent vulnerability handling.

The spectre_v2 mitigation may be updated based on the selected retbleed
mitigation.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 62 ++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 62ba49062182..ec5cc66513bd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,6 +56,8 @@
 static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
+static void __init spectre_v2_update_mitigation(void);
+static void __init spectre_v2_apply_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init retbleed_update_mitigation(void);
 static void __init retbleed_apply_mitigation(void);
@@ -209,6 +211,7 @@ void __init cpu_select_mitigations(void)
 	 * After mitigations are selected, some may need to update their
 	 * choices.
 	 */
+	spectre_v2_update_mitigation();
 	retbleed_update_mitigation();
 	spectre_v2_user_update_mitigation();
 	mds_update_mitigation();
@@ -217,6 +220,7 @@ void __init cpu_select_mitigations(void)
 	rfds_update_mitigation();
 
 	spectre_v1_apply_mitigation();
+	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	mds_apply_mitigation();
@@ -1818,18 +1822,18 @@ static void __init bhi_apply_mitigation(void)
 
 static void __init spectre_v2_select_mitigation(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	spectre_v2_cmd = spectre_v2_parse_cmdline();
 
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
 	 * then nothing to do.
 	 */
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	    (cmd == SPECTRE_V2_CMD_NONE || cmd == SPECTRE_V2_CMD_AUTO))
+	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
 		return;
 
-	switch (cmd) {
+	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
@@ -1873,10 +1877,29 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 	}
 
-	if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
+	spectre_v2_enabled = mode;
+}
+
+static void __init spectre_v2_update_mitigation(void)
+{
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
+		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
+		    boot_cpu_has(X86_FEATURE_IBRS) &&
+		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+			spectre_v2_enabled = SPECTRE_V2_IBRS;
+		}
+	}
+}
+
+static void __init spectre_v2_apply_mitigation(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
-	if (spectre_v2_in_ibrs_mode(mode)) {
+	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
 		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
 			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
 		} else {
@@ -1885,8 +1908,10 @@ static void __init spectre_v2_select_mitigation(void)
 		}
 	}
 
-	switch (mode) {
+	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
+		return;
+
 	case SPECTRE_V2_EIBRS:
 		break;
 
@@ -1912,13 +1937,12 @@ static void __init spectre_v2_select_mitigation(void)
 	 * JMPs gets protection against BHI and Intramode-BTI, but RET
 	 * prediction from a non-RSB predictor is still a risk.
 	 */
-	if (mode == SPECTRE_V2_EIBRS_LFENCE ||
-	    mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	    mode == SPECTRE_V2_RETPOLINE)
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE ||
+	    spectre_v2_enabled == SPECTRE_V2_EIBRS_RETPOLINE ||
+	    spectre_v2_enabled == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	spectre_v2_enabled = mode;
-	pr_info("%s\n", spectre_v2_strings[mode]);
+	pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 
 	/*
 	 * If Spectre v2 protection has been enabled, fill the RSB during a
@@ -1973,7 +1997,7 @@ static void __init spectre_v2_select_mitigation(void)
 		 * the host nor the guest have to clear or fill RSB entries to
 		 * avoid poisoning, skip RSB filling at VMEXIT in that case.
 		 */
-		spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+		spectre_v2_determine_rsb_fill_type_at_vmexit(spectre_v2_enabled);
 	}
 
 	/*
@@ -1982,10 +2006,10 @@ static void __init spectre_v2_select_mitigation(void)
 	 * firmware calls only when IBRS / Enhanced / Automatic IBRS aren't
 	 * otherwise enabled.
 	 *
-	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
-	 * the user might select retpoline on the kernel command line and if
-	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
-	 * enable IBRS around firmware calls.
+	 * Use "spectre_v2_enabled" to check Enhanced IBRS instead of
+	 * boot_cpu_has(), because the user might select retpoline on the kernel
+	 * command line and if the CPU supports Enhanced IBRS, kernel might
+	 * un-intentionally not enable IBRS around firmware calls.
 	 */
 	if (boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 	    boot_cpu_has(X86_FEATURE_IBPB) &&
@@ -1997,13 +2021,11 @@ static void __init spectre_v2_select_mitigation(void)
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}
 
-	} else if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
+	} else if (boot_cpu_has(X86_FEATURE_IBRS) &&
+		   !spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
-
-	/* Set up IBPB and STIBP depending on the general spectre V2 command */
-	spectre_v2_cmd = cmd;
 }
 
 static void update_stibp_msr(void * __unused)
-- 
2.34.1


