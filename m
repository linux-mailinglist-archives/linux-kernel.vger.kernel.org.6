Return-Path: <linux-kernel+bounces-554697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E8A59B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB691887B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36523AE95;
	Mon, 10 Mar 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="glumMu0T"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8BA239579
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624866; cv=fail; b=Cp/qHSc+z3S/UstJ/5WnZj9lGCZovilC9nqCSPj27dFUK5/gfkdGQLRr9X5np+YX/slnSpGP9zz6HFdfcS8NzNgQRnLA+rODn0/1oUdX/teh3OpqnGr6zj9UVMA1VCWEHmisTXI2B86Oj8XgMFsLd7WdTs9xs5ru1P7y4woW31E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624866; c=relaxed/simple;
	bh=OEDSGxHT7g/0Yi/rfls5CjwZMgfZbqEb5v8ReDL49yQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRHKR2GM65UEGKduec7Aw2IAKUNJU+aBjJBq6iTmzhLGi3RjXJf1jrIvfv2iqFe6fA7feZuzFgiocaVhRRpLLeFnrTJGyEVB1mlNy+XicPTyiGeOD6FBpHAbJxt0261WU64sDFOEMulS5N6RA5Jt+P9zk1cqXtBua7FJwDr46Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=glumMu0T; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7VwuUN7/LKarXGBGoEJ8FUF3Op/91h1+BgMh3K/IassLX/JCwUDxiKnTyqJ6vD1QPT4IWohm1KB6rV12mbfNmnwEmJjTgX+qZ10ef6XeWgo+CEmXE8eYPW3kgpcQ+iCV4DVnrghp7obHpB/IRwMdNJrs9yb4HunhZ83pXdCBO6hSPy3Mc9vxx9/y567al+sKCQBDRUqqbOIP0kgU4mVYwzZNMm86NLZMdpbcGrIk7Uo+WGq2BUPqUcBzColsGUfc4LLVd1Y9tgFEOYXC0hQnvdy6AytotC2WSs2hvRKA07I7IgFSQL3MFBBhWwv4oIfVrVwA2V4ddu2zTZrgN5V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7S5v4wHBRmo8k807WVoxXQUpD3Qutlypvm8cJqZbLM=;
 b=QRJ80pMDgH6hjImBULGRm3CYwwuuNpkv0mA2DcDcVZ1yrujy0ntP4VetXkvZxH/ItmpWCYPtGjn7T2CsWX/W6qV2+OzXx1/Mi0COoKVv1cE5w22sHbMNJTkjBy1Dcx1Tn/V+M/IkxpO9yWEX2nGB2NLQGnu4GC1CBlTKfJaPoitoTRTS8sxs8FyhgG+HzrJFGJmO+fpa57JjhZTBlrXkCtOtegPdBxNFMmdtkNoq4lwobQ49zRnwV0lun8kVF4LyHv8TlEQin4j661zEF6PEbAR9IPQ2fATjTW2A1U2VyEt3LKdETyVW1mhI1tXUbdhPF6wDK/DJPwydfNnIESVWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7S5v4wHBRmo8k807WVoxXQUpD3Qutlypvm8cJqZbLM=;
 b=glumMu0TIgGuiWgjCs3kkGx64f6mx4ZmeFUAeBpciSbOALAZ595+adArwrKYa+yaYYm5xQwI+gU/6IjNLF0U8t9XzD4QamSxbPNyJSi7ndqIkhlyH9vAUZt0xhCOxiZCOawyItpo913pm88ttxCu+7CnKdR+HeG1KBQ34tHTFYg=
Received: from BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:54 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::18) by BN9PR03CA0067.outlook.office365.com
 (2603:10b6:408:fc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:53 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:49 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 16/36] x86/bugs: Restructure srso mitigation
Date: Mon, 10 Mar 2025 11:40:03 -0500
Message-ID: <20250310164023.779191-17-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 16612539-c8b3-468e-8b9b-08dd5ff2531b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JvOI2eV46CfzuFNAdaC6QbTdTuqkjlhodTQ/hBWX//Qok4N29QMrnptPIA/x?=
 =?us-ascii?Q?Ztaxi+vgnUl4dbU0qQ07zWv0MSAvD3pKoFbHtWj7zy0ucrIjepete/kOT7qx?=
 =?us-ascii?Q?z+mr9TVW8yiNHXWIzP192DvmGORbepGzamnJoCqxAYYw4PrRzzRTOcdg2NeW?=
 =?us-ascii?Q?LjjVwmFdqr5cjjItCo1E86ohdZGR66k4wc1qdZfVUB/drc/AELHZEgyP4NIs?=
 =?us-ascii?Q?J+5PpRRU+QVce0rG/vdpl9awm5OxG5g3weCzUvDpdpKhWE1C/zadB55cvs/j?=
 =?us-ascii?Q?csMZUUZ8TRIOn7N3NH4/ubLjCqhEhILR/D+3EkKgjF9xdbIVqog4xibNfVdH?=
 =?us-ascii?Q?eMql/Lh/Djye+REwMys7hduOAdAp3SUpNolUP3b7VcYIh0daDgs1CND5TklM?=
 =?us-ascii?Q?flsY4EYpVsGUI9QlBZqvUgzi+V5LT5i23Cxd3/ipV7ooeVS4gftb2ZAdQFvP?=
 =?us-ascii?Q?vxDhRMZ87E7GJ/wDoUJjTURMTUQgNTycJN2eVyg7kQCGkaYswFSzk5tyWa9R?=
 =?us-ascii?Q?F5FkVeCLjtLzkbX+bR/wB84v/RvEd+lesTGoOyZEvnLoA90JEHANmcGrdTnG?=
 =?us-ascii?Q?18xoJnmY11FUldMhoj9HWcc/+U6MgNO7MG/YxuaIA3bJhrqKZEQoiL5QUC1u?=
 =?us-ascii?Q?0XFlZg/8mFHTd0akS+aao/8Dn+00NyN9WXIDAmuZVMZLQTkJV3v7SwI1OeXM?=
 =?us-ascii?Q?F3SngMFQRuGUf6ZMrAiOYOJhMvbCMutHY3zGaT9fbvKxfHiCsP6OB2O6yFLk?=
 =?us-ascii?Q?sE/iw3Xi1JtmJQyFs2k6KrwtIFg8JBP8CXViNu/Znz4d9ZqHPBbQMlzN33bg?=
 =?us-ascii?Q?yu55hdxkmAZJPAkFx4+aA6zhg6l5xpqoHdvKkIwzMrfPAfktoYE698zXStdh?=
 =?us-ascii?Q?57R2r8Rvx9JPMa2nNdsgm2M9bAmARX1USdueUpeKOZUNLd5n0HF+H9mBhv4R?=
 =?us-ascii?Q?XHLIjM0Srk+tIvW09TkC/0ADsk2OiLWeNZoQduS4G5s/RuMITFnUeOKSendF?=
 =?us-ascii?Q?Kbp1Lrx2JXVQ0lRUL86Y8E2MzZL8vRWKzHY1lodUNDQ3BW7gSip1IW9EQoH0?=
 =?us-ascii?Q?w4xU1WzhIrG/yOK44XOf9Wh5mIbK4rHTK594jclHuhDIFJpDHWkQYi6BhyJi?=
 =?us-ascii?Q?AOlE/GxnmXsT7i9pstMUszl7sesa/WNXqtVeuX1nklSIaL7g23qxk8LVFNxR?=
 =?us-ascii?Q?mFiB8DboqvCAL7t35eMXx7sbhuRckCLq9bvj29s2o07wQ5zY8pRs84aDQkon?=
 =?us-ascii?Q?S+MUefBar0Z3/KPyR+r5sct1eC2lh+BrPVRFtbhwzkWMHv7wiWiWoRsHQr2n?=
 =?us-ascii?Q?ZkvR54DdNMjYRMBWmXXY0poQvIlAX9vQ8GwiCnxlrzBnUu9KdV8zU7edYeRo?=
 =?us-ascii?Q?qM8Oatlzx/EEbSzcckHC5PbRzbQTH3anLqFmfyFOh2S+NKTEv4DG6f4XTpRU?=
 =?us-ascii?Q?O793uBxf+1urqou62N8sMcA1YXUAo0j8gMsqARWhXKNIp+uAORVe4sLXk6z4?=
 =?us-ascii?Q?jnWgUodM+ltCYco=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:53.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16612539-c8b3-468e-8b9b-08dd5ff2531b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

Restructure srso to use select/update/apply functions to create
consistent vulnerability handling.  Like with retbleed, the command line
options directly select mitigations which can later be modified.

Also fix the ibpb-vmexit case to look at CONFIG_MITIGATION_IBPB_ENTRY
instead of CONFIG_MITIGATION_SRSO.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 213 +++++++++++++++++--------------------
 1 file changed, 97 insertions(+), 116 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b9b7f5967f1e..d48b0a941b2d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -84,6 +84,8 @@ static void __init srbds_select_mitigation(void);
 static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
+static void __init srso_update_mitigation(void);
+static void __init srso_apply_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init gds_apply_mitigation(void);
 static void __init bhi_select_mitigation(void);
@@ -204,11 +206,6 @@ void __init cpu_select_mitigations(void)
 	rfds_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-
-	/*
-	 * srso_select_mitigation() depends and must run after
-	 * retbleed_select_mitigation().
-	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
 	bhi_select_mitigation();
@@ -229,6 +226,8 @@ void __init cpu_select_mitigations(void)
 	taa_update_mitigation();
 	mmio_update_mitigation();
 	rfds_update_mitigation();
+	/* srso_update_mitigation() relies on retbleed_mitigation. */
+	srso_update_mitigation();
 
 	spectre_v1_apply_mitigation();
 	spectre_v2_apply_mitigation();
@@ -241,6 +240,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	srso_apply_mitigation();
 	gds_apply_mitigation();
 	bhi_apply_mitigation();
 }
@@ -2690,6 +2690,7 @@ early_param("l1tf", l1tf_cmdline);
 
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_AUTO,
 	SRSO_MITIGATION_UCODE_NEEDED,
 	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
 	SRSO_MITIGATION_MICROCODE,
@@ -2699,14 +2700,6 @@ enum srso_mitigation {
 	SRSO_MITIGATION_BP_SPEC_REDUCE,
 };
 
-enum srso_mitigation_cmd {
-	SRSO_CMD_OFF,
-	SRSO_CMD_MICROCODE,
-	SRSO_CMD_SAFE_RET,
-	SRSO_CMD_IBPB,
-	SRSO_CMD_IBPB_ON_VMEXIT,
-};
-
 static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_NONE]			= "Vulnerable",
 	[SRSO_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
@@ -2718,8 +2711,7 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
 };
 
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
-static enum srso_mitigation_cmd srso_cmd __ro_after_init = SRSO_CMD_SAFE_RET;
+static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
 
 static int __init srso_parse_cmdline(char *str)
 {
@@ -2727,15 +2719,15 @@ static int __init srso_parse_cmdline(char *str)
 		return -EINVAL;
 
 	if (!strcmp(str, "off"))
-		srso_cmd = SRSO_CMD_OFF;
+		srso_mitigation = SRSO_MITIGATION_NONE;
 	else if (!strcmp(str, "microcode"))
-		srso_cmd = SRSO_CMD_MICROCODE;
+		srso_mitigation = SRSO_MITIGATION_MICROCODE;
 	else if (!strcmp(str, "safe-ret"))
-		srso_cmd = SRSO_CMD_SAFE_RET;
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 	else if (!strcmp(str, "ibpb"))
-		srso_cmd = SRSO_CMD_IBPB;
+		srso_mitigation = SRSO_MITIGATION_IBPB;
 	else if (!strcmp(str, "ibpb-vmexit"))
-		srso_cmd = SRSO_CMD_IBPB_ON_VMEXIT;
+		srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 	else
 		pr_err("Ignoring unknown SRSO option (%s).", str);
 
@@ -2749,130 +2741,75 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
-	    cpu_mitigations_off() ||
-	    srso_cmd == SRSO_CMD_OFF) {
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		goto out;
-	}
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+		srso_mitigation = SRSO_MITIGATION_NONE;
+
+	if (srso_mitigation == SRSO_MITIGATION_NONE)
+		return;
+
+	if (srso_mitigation == SRSO_MITIGATION_AUTO)
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 
 	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
-		 *
-		 * Zen1/2 don't have SBPB, no need to try to enable it here.
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-			goto out;
-		}
-
-		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto out;
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
 		}
 	} else {
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
-
-		/* may be overwritten by SRSO_CMD_SAFE_RET below */
-		srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 	}
 
-	switch (srso_cmd) {
-	case SRSO_CMD_MICROCODE:
-		if (has_microcode) {
-			srso_mitigation = SRSO_MITIGATION_MICROCODE;
-			pr_warn(SRSO_NOTICE);
-		}
-		break;
-
-	case SRSO_CMD_SAFE_RET:
-		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))
-			goto ibpb_on_vmexit;
-
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			/*
-			 * Enable the return thunk for generated code
-			 * like ftrace, static_call, etc.
-			 */
-			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-			setup_force_cpu_cap(X86_FEATURE_UNRET);
-
-			if (boot_cpu_data.x86 == 0x19) {
-				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				x86_return_thunk = srso_alias_return_thunk;
-			} else {
-				setup_force_cpu_cap(X86_FEATURE_SRSO);
-				x86_return_thunk = srso_return_thunk;
-			}
-			if (has_microcode)
-				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
-			else
-				srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
-		} else {
+	switch (srso_mitigation) {
+	case SRSO_MITIGATION_SAFE_RET:
+		if (!IS_ENABLED(CONFIG_MITIGATION_SRSO))
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
+		else if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO)) {
+			srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
+			goto ibpb_on_vmexit;
 		}
-		break;
 
-	case SRSO_CMD_IBPB:
-		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB;
-
-				/*
-				 * IBPB on entry already obviates the need for
-				 * software-based untraining so clear those in case some
-				 * other mitigation like Retbleed has selected them.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_UNRET);
-				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
-
-				/*
-				 * There is no need for RSB filling: entry_ibpb() ensures
-				 * all predictions, including the RSB, are invalidated,
-				 * regardless of IBPB implementation.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-			}
-		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-		}
+		if (!has_microcode)
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
 		break;
-
 ibpb_on_vmexit:
-	case SRSO_CMD_IBPB_ON_VMEXIT:
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
 		if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
 			pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
 			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
 			break;
 		}
-
-		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
-
-				/*
-				 * There is no need for RSB filling: entry_ibpb() ensures
-				 * all predictions, including the RSB, are invalidated,
-				 * regardless of IBPB implementation.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-			}
-		} else {
+		fallthrough;
+	case SRSO_MITIGATION_IBPB:
+		if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY))
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-		}
+
+		if (!has_microcode)
+			srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
 		break;
 	default:
 		break;
 	}
+}
 
-out:
+static void __init srso_update_mitigation(void)
+{
+	/* If retbleed is using IBPB, that works for SRSO as well */
+	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB &&
+	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
+		srso_mitigation = SRSO_MITIGATION_IBPB;
+
+	if (boot_cpu_has_bug(X86_BUG_SRSO) && !cpu_mitigations_off())
+		pr_info("%s\n", srso_strings[srso_mitigation]);
+}
+
+static void __init srso_apply_mitigation(void)
+{
 	/*
 	 * Clear the feature flag if this mitigation is not selected as that
 	 * feature flag controls the BpSpecReduce MSR bit toggling in KVM.
@@ -2880,8 +2817,52 @@ static void __init srso_select_mitigation(void)
 	if (srso_mitigation != SRSO_MITIGATION_BP_SPEC_REDUCE)
 		setup_clear_cpu_cap(X86_FEATURE_SRSO_BP_SPEC_REDUCE);
 
-	if (srso_mitigation != SRSO_MITIGATION_NONE)
-		pr_info("%s\n", srso_strings[srso_mitigation]);
+	if (srso_mitigation == SRSO_MITIGATION_NONE) {
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
+	}
+
+	switch (srso_mitigation) {
+	case SRSO_MITIGATION_SAFE_RET:
+	case SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED:
+		/*
+		 * Enable the return thunk for generated code
+		 * like ftrace, static_call, etc.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_UNRET);
+
+		if (boot_cpu_data.x86 == 0x19) {
+			setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
+			x86_return_thunk = srso_alias_return_thunk;
+		} else {
+			setup_force_cpu_cap(X86_FEATURE_SRSO);
+			x86_return_thunk = srso_return_thunk;
+		}
+		break;
+	case SRSO_MITIGATION_IBPB:
+		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		/*
+		 * IBPB on entry already obviates the need for
+		 * software-based untraining so clear those in case some
+		 * other mitigation like Retbleed has selected them.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_UNRET);
+		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+		fallthrough;
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		/*
+		 * There is no need for RSB filling: entry_ibpb() ensures
+		 * all predictions, including the RSB, are invalidated,
+		 * regardless of IBPB implementation.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
+		break;
+	default:
+		break;
+	}
 }
 
 #undef pr_fmt
-- 
2.34.1


