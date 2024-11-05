Return-Path: <linux-kernel+bounces-397208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748829BD7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9864B1C2268C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE02178FE;
	Tue,  5 Nov 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QV0n+ToH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0A21642E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843740; cv=fail; b=B6BrXyrbAWLmo8xMIlnMPYVRx2BgPIH9I0PR7pp04YAWaibCmY8tvdrjAeMlyCTGQLjO+su42MhbZx8w7G2GBfXLXdNvtAExaZbXPcMZd42ACmnvuDItQcnuHsHe1O+ZqLbvq+B2O1xAn9e35F4AkXF13yAPXg4nDth2ZXnjzB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843740; c=relaxed/simple;
	bh=AUzLYYBe3qel9nifWUejuAMi9qXiOxX2y4s0ebxlvuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbPjFcnVTdIyeSHu1GgRxhnU74DbRRtNcxnGL1pkLZwNqkyQ+qC/gty002ndW0iJr/UO7vDgEx8lebbC0GCDxKi2xJZW4o2yn7esVJ9gPPQjqgFa52tTxvWpi5T02TvRr9MdW+2W4iO9XLcw/tSuNUiLJIDzX2+XXQCmafUdoRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QV0n+ToH; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8vBRaPttq9gQx5NBDQcWlfVrubuZfF7j/DNiiinkvQgcFNtMj/HyupgfYs9zeQsu6RZ46hW8do0UfHSk6spioyaKcqxpp/mWIcbaUsP29U4OsJsXIfMnd6sWcnONxA5jW68ZYYYa9XJfvWEaZgu0YLE0EDCtk6DrJXAc9lb3yMAo3TNO0gmP4PpxpqNzyRogWyoRH1E1PVT9+WHv5MzNwt+qZs33xFER+8PgjMDHGLpPd8s5lD2sC2FiuU21m3PvbC6ERTXJTSV6qjNyddl/3xvJ/T4N9mbffXhi8udc2dBIVovOrOR56J2E8suNiGHg6ZHOakjlCP/U03EHZQS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNLtBIMS6NPbj0Py6qS5UjdDXkeW74QY/0aBVLhfxW8=;
 b=XaRS1YspbaQD3snor/sDaDzqiPtfyi1yrw6ArU2p/8PY4hTdwhmiFhOkpbtXA6Q8yVE7Mr/BSxqKELIJBD1UphDDUPCMKDutb2DCiNG6CuVjpdv0TDpuRye090S7Piv9reckeTZZvMTFqNB0sH+pXZ/gsV4H4y8HPNXga3vYnvlTFcg4mvsf8wUuN+QMfXsxA6Hhc8Wr4y3E9kRFEoEnu4nrvq372QV8/0wEQHxpo6tennw5EmARDckZz5BiRZZxnUkqyQTH4DTAs4VnejqNzbVIztaBecWGQwW6rbEQlUCZtdDJ1wMPkUFILvUOJF3E0+PFLL7C26n7/MOE7TZvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNLtBIMS6NPbj0Py6qS5UjdDXkeW74QY/0aBVLhfxW8=;
 b=QV0n+ToHVDm4Qsk1Qed5Cn+MT81vh1ffpQzqYyiXVR3ohjXGBT738rfVPEQl06X0x+ksiUvKYsFwVBv9neqiIM3zt9ZKNahFV0AjZxBiihJvefMWaDFcdm5OnuK9T2tX2+4/mD9+Gf5YhTi2neBkndQwWr8DmTwEUAj4HvOjNik=
Received: from MN2PR15CA0059.namprd15.prod.outlook.com (2603:10b6:208:237::28)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:31 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::4e) by MN2PR15CA0059.outlook.office365.com
 (2603:10b6:208:237::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:30 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:27 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/35] x86/bugs: Restructure spectre_v2_user mitigation
Date: Tue, 5 Nov 2024 15:54:33 -0600
Message-ID: <20241105215455.359471-14-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: ab17a87a-a0cb-4f24-a416-08dcfde49132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdjm8lStjcUurQUrAuqqHZdjUJl2WDitc7plZfMg6RjP7k1xA58f3FMwNpBd?=
 =?us-ascii?Q?Xp7Yz0/nZG4ee1Ae0ShtnI34acCnVRRvqHZcFfCS6G0pYf8t+m+8synvvj7t?=
 =?us-ascii?Q?7bylYmvrViuZEFAohHrvhKgawMjSUEXtTtD/UtCemjTv/DHTH/rn87EdLwGJ?=
 =?us-ascii?Q?b4ZSe6icUnCgjBEqfeFXleIh+k0wLUIX458X28OqobYBwPfsWzQ/lwK/rV1j?=
 =?us-ascii?Q?Oe38oeAYDlU8kL+Jbpl7v3lDCPcBlBhNdqFYTt+ROEr8CrxUMUVqZqLGJ8jk?=
 =?us-ascii?Q?xsB98cijAieJ/2H4CsxRDyvklDtWCNTe9A4cgSiUnf5SfC1MVWHZpC82G46C?=
 =?us-ascii?Q?8SwQA/85vwOqsan/EoXdvpWnn6UlU3uHWmwKDHloWjl4S+A1qamBNOMK6vur?=
 =?us-ascii?Q?cAOLuiDALLpEk4wrxG0N+/Ojv13nLlb9PeKlV3gxhlB/pOMLu7exVv5LdnRB?=
 =?us-ascii?Q?mS0/FmPsmK17JV62abyOP7ge0eMqQ+7HoZdPkCYct0UCnFLkUD4isasrL1JR?=
 =?us-ascii?Q?t/n0exp0aYuTOH3C1uZG0xpVFrOFGA0XY7ZFkIP9GCm5KUTWB9ZpwBF1u1cR?=
 =?us-ascii?Q?+w1j3JEPxlf0AJmTl94zYolTS1h6CnbLrIalJ5dm5dKUzeZNXcLNrIsVsNQQ?=
 =?us-ascii?Q?ST22W3choDxNw+iKypOzMhdD9g0wPyCRzRsJlKGfls/5wkBiSCCW0do67ll7?=
 =?us-ascii?Q?SYrkwC6zZ42WHH6EDcgGxY9u9iu0bOgq7au/XTBLZUIjQy7P2KehtHjRxcPU?=
 =?us-ascii?Q?OCGhQeNlDLQ6caDgC4OxzF+T27os1vtzcmrAeY19LQ14mlJVuK4QzdPFhLNB?=
 =?us-ascii?Q?GfYea+Q2Up+uKMte7W37I7R4EJ/TRmptpvhX0l9lxRmVkaLutVQEoPQuK8P1?=
 =?us-ascii?Q?3e2MRlzP9WLAnFVoM91YcefugyFxqm8Zc6kZQg36Qc7toVwrQvsI1jIfuCHH?=
 =?us-ascii?Q?sxSeYyIN44gvF3m9pO8Bcd12IFw5yD1AVcDSECENf0BWnl3n1YuiFp4EywcJ?=
 =?us-ascii?Q?WTk4kkpIT8rtDIr4aqmdhddDetbWPQnsCvgMpzwnK7g6wfaFZ79w9ctzCV+k?=
 =?us-ascii?Q?4iW9X1V+NbHl3MhhgskDUTrz+NT9Zj8hP02kkJLjSsfiGEjkEYeyc/46MjPx?=
 =?us-ascii?Q?ibpHugB4ow1c2YTc7Tm86nlo/3ZctULKRXoZJ9s9BwOC3Bnj29/SRcoaynl0?=
 =?us-ascii?Q?l8yUCu9At214ga9U9zlugZDL7KdBRa/vhy9n67+KHYl/6S9EiSj7qrkOjSup?=
 =?us-ascii?Q?VOPqa+0j1bIn3nqZDNTOUx+rW99uvN7v3PHqO98SK4piUXqAbky1hGWJSooN?=
 =?us-ascii?Q?Tkq+b3GhoGbarixGBbTtx1Lu88R/4Rkej8L7oGXaV8kwEE2je2n+fRFQf+y0?=
 =?us-ascii?Q?fGH0/9pNtKyCOEoKVkT8ORuZOp83ZL04NIWIWdj5MIm2nOq0Jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:30.9528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab17a87a-a0cb-4f24-a416-08dcfde49132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472

Restructure spectre_v2_user to use select/update/apply functions to
create consistent vulnerability handling.

The ibpb/stibp choices are first decided based on the spectre_v2_user
command line but can be modified by the spectre_v2 command line option
as well.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 147 ++++++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 66 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 36657bd7143b..9a41fd121b71 100644
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
@@ -1335,6 +1334,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
+enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+
 enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
@@ -1373,22 +1374,14 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
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
@@ -1412,65 +1405,70 @@ static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
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
@@ -1488,30 +1486,47 @@ spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !smt_possible ||
 	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
-	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
+	     !boot_cpu_has(X86_FEATURE_AUTOIBRS))) {
+		spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
 		return;
+	}
 
-	/*
-	 * At this point, an STIBP mode other than "off" has been set.
-	 * If STIBP support is not being forced, check if STIBP always-on
-	 * is preferred.
-	 */
-	if (mode != SPECTRE_V2_USER_STRICT &&
-	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
-		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
-
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
-	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (mode != SPECTRE_V2_USER_STRICT &&
-		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
+	if (spectre_v2_user_stibp != SPECTRE_V2_USER_NONE &&
+	    (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB)) {
+		if (spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT &&
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
+
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
 
-set_mode:
-	pr_info("%s\n", spectre_v2_user_strings[mode]);
+		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
+			static_key_enabled(&switch_mm_always_ibpb) ?
+			"always-on" : "conditional");
+	}
 }
 
 static const char * const spectre_v2_strings[] = {
-- 
2.34.1


