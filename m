Return-Path: <linux-kernel+bounces-327132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D6977126
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628001C2383D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51421C2DC7;
	Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mdl6cWMa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243601C1AD7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168165; cv=fail; b=SIU+ISIBEfvvoljp9WPP+GYNMIePhKDNsTZP910dfPaX93szzYIRT0gMTXToiS/pd5X/kbHKedFcY9TUUFrIYkM1HV4+1BGyTSvS3TeUBdDjLC8dJD3MH9hupdC8le6jsHmozb1ehWHPYdxPR3PtpExw2ar+wcLrBHFJDO4GnTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168165; c=relaxed/simple;
	bh=cGzDdTNxTnEEy98myKWeww8JYywxZofqbQR4dT+Q3ZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ryy6TfvoAsdDX1c/CcoF85aUlI1EfqBSSch0Np6Somszy/AvM1mFBN7jyWbXxEay+NssukDcWJRqwwMd3YBOzREbQVlE8Ge4wW7lkUDGce0gKrJsy4Z5MUEqWH0vizh+Rc6pIWLxM6hxFjXN1akmH9qhXMnNMYQj8lAWRbPtcZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mdl6cWMa; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYLyxZ4JzsfE49VCDzuClzOJ8hVtlqvUdXxSAQHNwvtJk/+yNQaLL0vSTVVo6M3YssbE5Pz+y5wD41sWOMQ+wjzRBSy3OzlfW8DP8Si3uvRrPdGut6Wy7SV5C60+6W6YLFgK5twOFp69Uclb6YWmEUZGU2YWlZ6Kn8vIZw8+GNWEJu7PR/1MhGZfgBU/+zFi5H17sfgtxUbtl4khWP4yBg8LasjYYcMr9iTXZwO7tSi5SgFuz+o5Ss7cnk47WxOPcs71fmfWU5CxWh8re7I9kze2HvFAqVLiZnhBDrFitv+t+66WlshpRC7BM4V0THffJC86ayxqgm8wTjQNZyP0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiU+l1p3HXD/Nc4zv0lckg0Uyp799ad/jSlLUCn2kDM=;
 b=TCR60J4MSsEIVYJImm/KNmUwZsP3krQSnEHkK7R7WXh3xE+BmngRffRUDbgpJm5iiviFZRqpNl6ct8C8qW9QNcynfH1VoIWVcoRISh4oZ3toBeGpchmUbrhhMmW3+idQFvvXS2/rRTEg/Oc0FYh13YpDMYJgAFQ/AaigvqD3RD78gEhJQeA8aPVylYu5qFRbCJENG3/Iw/ErOawYRj3CGZKsK0i90SWoFQf8mhy28jID0XMX3mLp7e3TnzzEpDZh/HRwDWW3QrPbwGy0ZxL/MLpVIQr4K9+5ke/2KxV0cPWFkShzgq1ktiQmn5EtSN+7GfRupHPXopsYAcGJwclZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiU+l1p3HXD/Nc4zv0lckg0Uyp799ad/jSlLUCn2kDM=;
 b=mdl6cWMaHmzO1LzbTHiL0s4fkueYw/NB7hXlPCgMVFT5Qp25YKYXXcARm4ErxbpQUrnz2ejeJc8qkBuhvcO63FsfM6XYWHvAGyo2L2blQx9Ts7kwONah4aj6F0JH7v5W0mmyWPhV0NOLz5tX/eu7u5s0ncqbopJJiTVhjg395SQ=
Received: from BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 19:09:18 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::c5) by BY3PR10CA0009.outlook.office365.com
 (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
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
Subject: [RFC PATCH 12/34] x86/bugs: Restructure spectre_v2_user mitigation
Date: Thu, 12 Sep 2024 14:08:35 -0500
Message-ID: <20240912190857.235849-13-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 4829951e-8547-47ed-d7e7-08dcd35e66f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kAMdVAo/ivPYTQYtco2vlP+o6y92Rzef9eiouezBJYumrug+Xnzcr1CKA707?=
 =?us-ascii?Q?Bx/6PEpUcKUiFbcESJDWCzhxMXoxCtb8fzX0V2IuG4UhS6bILhMj/YLV6T+S?=
 =?us-ascii?Q?wDkyRa5p9opRnSbyb4Y1uezNW9yaS94wB2HKxvXhtvkX+wFCeC8KjABhQ3FH?=
 =?us-ascii?Q?CrSItSSj/k/cG4VjsCawe3BIVLRLTvxZ4c0LDhGdRh+M307pizl99x4w4QJr?=
 =?us-ascii?Q?Q/iO4ZQg9suiPyd5zv45G+f8ebb5pTqC2bSXmoZPSgcMASzrprX1wDsb/aU1?=
 =?us-ascii?Q?Bc0MVb04eO40hpP4qBtJtCA5M8XqnVDCxMS1Ki0YY4UBGWT1JETwH65/OFjg?=
 =?us-ascii?Q?GNvrkhDLOrV5MsW1MNPDKs6jLyOa/FsF/974MdWMAGXaHGn47moWvaY7A2hB?=
 =?us-ascii?Q?H/Y5ZvTip2XPUvKNOQjGvL0NCXbdS5bmqK09WoZ7nIx5SBNAVriJV/h6DU2Q?=
 =?us-ascii?Q?T2dSMPZomHfwQHH8sk3iRxbR6WWJfhe7uLZ85Zc4yICU34lMOSCy8mqnN/8e?=
 =?us-ascii?Q?vLBdPsBdXVHVcHDnZIT8WdKeQcQ6YSeWRzVnnP6GJha4dRtEtyjMbbuKPqzi?=
 =?us-ascii?Q?MyKJJ6tfABHeYUbaCBKl9TLc1cSgXAGlq7U/ZPl0MwGXVtak1scZfhMx9/Zy?=
 =?us-ascii?Q?Ls3Y+giWmJspqgmQrT17Iktr5PMcVHYfivq6Vtsmy2KYQc0G5Za4ucL2Lio5?=
 =?us-ascii?Q?oQqrDjY1v0WNX6P3uZ4w95v6bljmrX9PRNKNORIt9H+/nIO9PKhBByVn7zkv?=
 =?us-ascii?Q?DQV3hSLBkL2FwpIu2YxqXtbST9jOb7/fTMKalxY+qrt7DdHTBOR1lzPgrxta?=
 =?us-ascii?Q?WH/+AlWnKOEWSzOna3MsB8FiltsUwUSMW/+gpyJIrOCb/LEDkiY+97OMpY6r?=
 =?us-ascii?Q?SI3jBBUwoNdBdb6CajhYqvPvr/AukJ3jo6i6NGpRQT7RtG3ZjdVfvIxiNaBB?=
 =?us-ascii?Q?gTOh1k94ZRrUYtox8nuBe6XvAuT+d4JN1LyRaIQsoSG6f2mHsZ/j15zWD7Cv?=
 =?us-ascii?Q?CP4avKLAwxwsxo2OBAEpHMYA/Jy7I/CCAwIh/rd9JfrR1HIdvX9o8ZR9oOXN?=
 =?us-ascii?Q?oOW2BWq/FdvQW9x+RL6mFt9WrFYTFm5XjkHJAamEG3oSrZG0Z//H2JuWK+FZ?=
 =?us-ascii?Q?UQTvfZmWU1gr3F+mxYvfm0dde0/s0zoiJB3lQmwQEgtMieCBsClf2oDF8lOS?=
 =?us-ascii?Q?OUVoesg0Ybz+HtqMvSe7RvcgHj56TE8Mx++r97rKbhKmYOEyjPyqMnyjVywt?=
 =?us-ascii?Q?KO3Gu87Ri50psR2BfydmfrWNjoE7MQuw3RVIxcgPJm4a38a8P0I5zz3Zue1d?=
 =?us-ascii?Q?2SnTxkcaqaFN9FZSlOFQHn0+2nMvG9FEHjQVmkiOQBV7F2J5uLMooQaECs+l?=
 =?us-ascii?Q?sgP0ncKqYSK2zgF5EzDtcWgk0sMQnZi1tfj3RWKDJ264ZQeOpz0dT2W1pe7I?=
 =?us-ascii?Q?jgudEHXbRHwrASuj3Hj20m7qqRJUdWof?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:18.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4829951e-8547-47ed-d7e7-08dcd35e66f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

Restructure spectre_v2_user to use select/update/apply functions to
create consistent vulnerability handling.

The ibpb/stibp choices are first decided based on the spectre_v2_user
command line but can be modified by the spectre_v2 command line option
as well.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 143 ++++++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 13143854ca42..eaef5a1cb4a3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -60,6 +60,8 @@ static void __init retbleed_select_mitigation(void);
 static void __init retbleed_update_mitigation(void);
 static void __init retbleed_apply_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
+static void __init spectre_v2_user_update_mitigation(void);
+static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
@@ -183,11 +185,6 @@ void __init cpu_select_mitigations(void)
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
 	retbleed_select_mitigation();
-	/*
-	 * spectre_v2_user_select_mitigation() relies on the state set by
-	 * retbleed_select_mitigation(); specifically the STIBP selection is
-	 * forced for UNRET or IBPB.
-	 */
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
@@ -210,6 +207,7 @@ void __init cpu_select_mitigations(void)
 	 * choices.
 	 */
 	retbleed_update_mitigation();
+	spectre_v2_user_update_mitigation();
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
@@ -217,6 +215,7 @@ void __init cpu_select_mitigations(void)
 
 	spectre_v1_apply_mitigation();
 	retbleed_apply_mitigation();
+	spectre_v2_user_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1311,6 +1310,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
+enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+
 enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
@@ -1349,22 +1350,14 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
 }
 
-static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
-
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
 	char arg[20];
 	int ret, i;
 
-	switch (spectre_v2_cmd) {
-	case SPECTRE_V2_CMD_NONE:
+	if (cpu_mitigations_off())
 		return SPECTRE_V2_USER_CMD_NONE;
-	case SPECTRE_V2_CMD_FORCE:
-		return SPECTRE_V2_USER_CMD_FORCE;
-	default:
-		break;
-	}
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
@@ -1388,65 +1381,70 @@ static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 	return spectre_v2_in_eibrs_mode(mode) || mode == SPECTRE_V2_IBRS;
 }
 
+
 static void __init
 spectre_v2_user_select_mitigation(void)
 {
-	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
-	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
-	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		smt_possible = false;
-
 	cmd = spectre_v2_parse_user_cmdline();
 	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
-		goto set_mode;
+		return;
 	case SPECTRE_V2_USER_CMD_FORCE:
-		mode = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_PRCTL:
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
-		mode = SPECTRE_V2_USER_PRCTL;
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
 		break;
 	case SPECTRE_V2_USER_CMD_SECCOMP:
-	case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 		if (IS_ENABLED(CONFIG_SECCOMP))
-			mode = SPECTRE_V2_USER_SECCOMP;
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_SECCOMP;
 		else
-			mode = SPECTRE_V2_USER_PRCTL;
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+		spectre_v2_user_stibp = spectre_v2_user_ibpb;
+		break;
+	case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
 		break;
 	}
 
-	/* Initialize Indirect Branch Prediction Barrier */
-	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
+	/*
+	 * At this point, an STIBP mode other than "off" has been set.
+	 * If STIBP support is not being forced, check if STIBP always-on
+	 * is preferred.
+	 */
+	if (spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT &&
+	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT_PREFERRED;
+}
 
-		spectre_v2_user_ibpb = mode;
-		switch (cmd) {
-		case SPECTRE_V2_USER_CMD_NONE:
-			break;
-		case SPECTRE_V2_USER_CMD_FORCE:
-		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
-		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
-			static_branch_enable(&switch_mm_always_ibpb);
-			spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
-			break;
-		case SPECTRE_V2_USER_CMD_PRCTL:
-		case SPECTRE_V2_USER_CMD_AUTO:
-		case SPECTRE_V2_USER_CMD_SECCOMP:
-			static_branch_enable(&switch_mm_cond_ibpb);
-			break;
-		}
+static void __init spectre_v2_user_update_mitigation(void)
+{
+	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 
-		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
-			static_key_enabled(&switch_mm_always_ibpb) ?
-			"always-on" : "conditional");
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
+	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		smt_possible = false;
+
+	/* The spectre_v2 cmd line can override spectre_v2_user options */
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_NONE) {
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
+	} else if (spectre_v2_cmd == SPECTRE_V2_CMD_FORCE) {
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_STRICT;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 	}
 
 	/*
@@ -1464,30 +1462,47 @@ spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !smt_possible ||
 	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
-	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
+	     !boot_cpu_has(X86_FEATURE_AUTOIBRS))) {
+		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
 		return;
-
-	/*
-	 * At this point, an STIBP mode other than "off" has been set.
-	 * If STIBP support is not being forced, check if STIBP always-on
-	 * is preferred.
-	 */
-	if (mode != SPECTRE_V2_USER_STRICT &&
-	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
-		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
+	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
 	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (mode != SPECTRE_V2_USER_STRICT &&
-		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
+		if (spectre_v2_user_stibp != SPECTRE_V2_USER_NONE &&
+		    spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT &&
+		    spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT_PREFERRED)
 			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
-		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT_PREFERRED;
 	}
+	pr_info("%s\n", spectre_v2_user_strings[spectre_v2_user_stibp]);
+}
 
-	spectre_v2_user_stibp = mode;
+static void __init spectre_v2_user_apply_mitigation(void)
+{
+	/* Initialize Indirect Branch Prediction Barrier */
+	if (boot_cpu_has(X86_FEATURE_IBPB) &&
+	    spectre_v2_user_ibpb != SPECTRE_V2_USER_NONE) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
-set_mode:
-	pr_info("%s\n", spectre_v2_user_strings[mode]);
+		switch (spectre_v2_user_ibpb) {
+		case SPECTRE_V2_USER_NONE:
+			break;
+		case SPECTRE_V2_USER_STRICT:
+			static_branch_enable(&switch_mm_always_ibpb);
+			break;
+		case SPECTRE_V2_USER_PRCTL:
+		case SPECTRE_V2_USER_SECCOMP:
+			static_branch_enable(&switch_mm_cond_ibpb);
+			break;
+		default:
+			break;
+		}
+
+		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
+			static_key_enabled(&switch_mm_always_ibpb) ?
+			"always-on" : "conditional");
+	}
 }
 
 static const char * const spectre_v2_strings[] = {
-- 
2.34.1


