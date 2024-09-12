Return-Path: <linux-kernel+bounces-327143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45D977135
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F553B2540B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D61C5795;
	Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="no5XdH49"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685591C330F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168170; cv=fail; b=c5XjPH+HnRAuW3ZGEUbWN3//JSGv0iMQBL+E6uidynC2gw42roBEQQe1lJ3ieT+H2J9PbOMwvs+4jcDOTjKgYGWGPh2W43pAh3Olx0k4RqmuhqUaY7QCUJ3SlJLf8qE6SZ4GxCzNGzOcIUdKxGjCrqLEfyTbL9gET3jShKY689M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168170; c=relaxed/simple;
	bh=5Qty7If8nFoP186MZ1CO9sJl3ethDfppeRaoSPMuswc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xia1mJ1hHGlops79ixgOZWtwsgVLSDbEv2jED/16yy10Smp6iPZC6o1xQF5ze+EnfsPebmaAWoB4n9AvJxeaD/suUq06oVLn6s54g4CsTmwOuXux6mmk5IHv+FYdi8QA4Bee77DkVIp6K+dwZlBpkNyjQximqYiT7RBp9tzkEsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=no5XdH49; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/nAqrLAMVfWUAngX2+GnkEKjlEJLEbu5C045uM8stZOcKVAiM/NpNrh9nUqjGMlabWlDKasHrsc8hxIuA091yDDLApbBkydfETRBBDvdsbBRdp2cnGs3OHQXl8lCrn2HvHm2Bl/vHj4jQMfCOe/Y7Fktz1NAOS0plWx3lYF5MUCgbqswPZNBOo3ZnQEG7FtlMPxlSDBeURUcATe6/NLY63oGQauhFrurhiIqLw02t4HKpVLn+PXl3NVw+B5PKQJ4OtUO1XkKGWjbVhVdMTGpvnK3lWnKt9cG4Ov3oDWPhXmuDTfWPW0IZHHEVRrxfglRBwUw+0miLRe5ctZR+0UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr200QYKz8MmMWBwnWo3akqIlh4JaWqPzmXkvBo+7t4=;
 b=clt6oJt6lLaTHFpBWvbta1+X8l7QHdTCewufHeM0KgRSm9HYnYy33M3M7d1Kqb0PXoj6yjaWjR9SAeljWDUDINF02HV1i6EcmkcrvlHMgEmSPk4/MucjiDg4dR/E9/+S5lLwytkHeGPINVxGbe8Grl7JaXxD7mtJxgMlDbX4ZR0xOk4GFxAVIulxRNx0vpChkanDCrBdFPHXrqekq7QruFZJbPTaRfcbLX9ho6UHzgGYNe1k9yg4qE6yzP4m5nPRkARaKPwX2E3q4NmzZSxsdp6ch5Gyk5p9BwxRiwS6MgPkDgtMLx6T3FfONbLHAgGJVfH78hp/nyBg6fvT32yGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr200QYKz8MmMWBwnWo3akqIlh4JaWqPzmXkvBo+7t4=;
 b=no5XdH49Vq0950iMWZRqzJnKBtDfQbwuR8KympG7xOrtQLfUcZFFV3rlKaAq2CsDq38M6vEJuO34FD3pVR/rMCxr3WMl0dtmtOQeehFJW2ANbWQOwrEorJesgb9+vumq/kbdWkZMob5ZC0w3Z4bCzWoeiL1Aw6P0DSVLjgBKEGc=
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27; Thu, 12 Sep
 2024 19:09:19 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::e1) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:19 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:15 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 14/34] x86/bugs: Restructure spectre_v2 mitigation
Date: Thu, 12 Sep 2024 14:08:37 -0500
Message-ID: <20240912190857.235849-15-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: ea965ad4-883e-4d2e-493e-08dcd35e676c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1nA2BMC/BVOVE525KSzr2n4QgiFSyTA9DiV/uv3bUhkGCoBmFbo9mJ8acv0?=
 =?us-ascii?Q?e8l42PrXECQkab6cpKtLPb+H8gRI4SP3LXEIV1oMGxz3/5Yd1yvVozc1acyL?=
 =?us-ascii?Q?ZAxrDzTAZQWFjeFnmL/N/Fq6RkaMHk2qw+c9pmRlxVV3e4sG2rjTJhvTCAn+?=
 =?us-ascii?Q?Pn+RZlT3hYblqvUOg0DTvphHgwB42Ou38Zdv1NC1iQsU/6vjh1dy/vst6eFS?=
 =?us-ascii?Q?xFvILiPTmA9cW9VJEj5je9VZXAyj428cFpf2sJuE3Dvwmws7wqjy/VxIKEaU?=
 =?us-ascii?Q?zN7FY6t0jlclfu62EOp6h6LMjA/bulxV5Ivz/uQ5NkEUeD6Tb2E+BAYnr06E?=
 =?us-ascii?Q?MWcbc65peEvUXCk+pbDIk2xkaRD36RWUkyL69o5stjrYy6Ayf+Mve97JaoQv?=
 =?us-ascii?Q?lKi7elMwmbTf5WPbuD3aMMFwfM9l+RLLcH1KIFG5EzIue4mqNWo4KbBWVrxd?=
 =?us-ascii?Q?itBQs6N4/WqzP4atHRl+wBti9g6rOowOYUQiygKXOmakXkHqZmSuT1KtHpOD?=
 =?us-ascii?Q?mZuZ3RWs5ndA1dRXgJrzfXjN1rU/ymYPjylWn4vvQ4F3fKfCm4271cklGEaS?=
 =?us-ascii?Q?0gRsJSH2wlsOnQ//1Au40kLMORYVnFSXSUFj/91fk61MK1iUqihEm+2oHlfO?=
 =?us-ascii?Q?tLL0czjLy3ZTrATzPf9FkRZH1kDCDcxLA+L6AUnNnOHgAfvEjJTgB4D1Mr2E?=
 =?us-ascii?Q?Tk+lX0UrFuFwc6x1XMhdsoHIan9Adv38RZPRYJ+ze1LvPnMkxxldBvKkr0Km?=
 =?us-ascii?Q?N8BS/S77RebyCvJOkbEH9pEXq5GHf16lQLMwYk3xRDWxcGaoamimzp+ZvlOh?=
 =?us-ascii?Q?WVFVcSQEnKz94B36p27vnGGoukoBCGYndcGR91uLzCtPS9/yB1vesowC/JPU?=
 =?us-ascii?Q?qD+m1V+OkIu8vpjzcHzAs1yO/AEZ8kvpqF7D98w+ip8qanMNbo0b9S9tGAiF?=
 =?us-ascii?Q?QvpMZjRuD4OG4leWUPkwVVSSX/2i5KlSJOVJHO+GTH27qXAll8ckwC9Db/lG?=
 =?us-ascii?Q?FgYoZ/vE0J5qh4PrE/Sj4sRkEyC6k+hsVD4Oi8wS0GTI+wogf2z3A6PXJqcG?=
 =?us-ascii?Q?izkqgLj0W/TH3a7fiER+m3NC9Lc6Wh9/krnq8lYlAXdnmeL1yzvtYGoRm1vl?=
 =?us-ascii?Q?ReSqPFJ8Imq8wq07VLNU+8UFolJkPswXk0i93HHo3jTUE+1WmmxCysO65Yv0?=
 =?us-ascii?Q?ug7CX3DW17EVivvJkNslePJ5m/56CsCoQGqaGzP37b5xVeaqxcMABacYAuvy?=
 =?us-ascii?Q?p/DfA9BNcmpjaAOS5njLuJH4Fx/C8w1WSy6B5jcPHfqzSn5Blp/Wc/z78tzj?=
 =?us-ascii?Q?tgoKyRSfDxuaux9PXecbHS9LXDl2lfAct5y5XrPrHnwNVi99TQH9jKPS0knS?=
 =?us-ascii?Q?mSYnKyX/xrb5WZVFd8yCOSrNTGNw7GPJDSpmaJAcdcZ1RIaeLk/U0KypMpoG?=
 =?us-ascii?Q?elyWbGXMt/PD0zEOemsSBByT6l5yGlYi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:19.0772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea965ad4-883e-4d2e-493e-08dcd35e676c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

Restructure spectre_v2 to use select/update/apply functions to create
consistent vulnerability handling.

The spectre_v2 mitigation may be updated based on the selected retbleed
mitigation.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 52 ++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index da6ca2fc939d..32ebe9e934fe 100644
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
@@ -1794,18 +1798,18 @@ static void __init bhi_apply_mitigation(void)
 
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
 
@@ -1849,10 +1853,29 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -1861,7 +1884,7 @@ static void __init spectre_v2_select_mitigation(void)
 		}
 	}
 
-	switch (mode) {
+	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
 	case SPECTRE_V2_EIBRS:
 		break;
@@ -1888,13 +1911,12 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -1937,7 +1959,7 @@ static void __init spectre_v2_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	spectre_v2_determine_rsb_fill_type_at_vmexit(spectre_v2_enabled);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
@@ -1960,13 +1982,11 @@ static void __init spectre_v2_select_mitigation(void)
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


