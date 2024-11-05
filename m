Return-Path: <linux-kernel+bounces-397209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB49BD7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D398284031
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE4217916;
	Tue,  5 Nov 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EF1tYhez"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BB217300
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843741; cv=fail; b=egqNGBJcg0KuFBNSS1+iOjNEjVbTIICEUdZlZhIMu8DKuZWU2/Z/aOmMfb1bcVcC/WJvCd+6zO69yUPTOaArUbE6T+nqoanuKFn0KINGLQsL2b8T4oObaWrcoRi1d5GfGpWwcHfguOO+BfRKVXJ0UdgD6xKoBjbVBDVrcrhYHDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843741; c=relaxed/simple;
	bh=JD/CpBdTY5OL4gp7NFvqwj57VaslbffekCgsg8MWaGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL25MDniBBvUifFmBES+m9lKSH70ltF3vQuO5JIO1AsF16Xj6QtRvC/40jTrdDGSTscjumODuTZbNGVDVgQ7jDrHqH8IRJs7IjmccZg/VVMChIn+UHa+G/8w1BJqzZH0ZUCsHnySMb+gR7tPZMMvTKh2oh8z5xrDvg8dau+16FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EF1tYhez; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGI+nwKSWE2czjToV347Efefm0/uccgk1PB6rNDYhRc975RUeyfKjpVUGdQ+Nktwe7/0uyt6VinE5Y5wSb0JJtsZUHzMnUvnqYHvlTMpYdrX1GWKEsmSZBjUmYvP2KioeP1q+SCMp7FodG6OoIymQQLKn3ZxlLDXexzhf7JTM77sGjW2vZfj8PR/aZRijdKEnT//TCrGKxFVJZ58OIuANBJ+yMvwtwdsjZ5clJwyaACYfaWaleeiC5zSjanNlYMpdOSA6DY8J1Vcf/LhHzycoDxlz+Yj1xN9tUA7eCLMT+VfUri5vituBL8r/QC20jVWsuLaqWJh37dNCLFCsCJwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdFFutyQSEToe421Zb6LJHBAvD4dQXXAB/saARXxJ3g=;
 b=dLhoNJFpf/cjntCgLqXXmKaRlEA6dT3hu8l8ktzB10+4HCCmEV1S+qJopqQqAxYJoqOcG9XoNMgRBlpOEzR91CIcwY/J2lCB9WosHbTmzXUPcSTDdl6PXKoKMZS9y1elLot/9qgEouzC9GD2ysvzPILqTPlOPUslKjBu4ngtxy0rLlOxRhUc9Ke9dD8rDyGiEfdUp7CNVPZRqpfGjjoAoDEZ1O55Wd/VqcKGeO1mIYid5h0FHEAK8lDftuXuVi8MetPP1w6XKlGu74isQNXlhd45YrGnMAbPsCVDppC+xpP1CaFM9BwIdxRRMMmhIOCxUbQhzWQiJRWjeDgYaZi7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdFFutyQSEToe421Zb6LJHBAvD4dQXXAB/saARXxJ3g=;
 b=EF1tYhez/y2kA+0dIP4th/Jzz0ULHh3/WlMXeebmDcMznXe/ngnERx/5Rhc0E9xrslsGYyYW4oZrvLgERca28SFgbZqv2Z9R94U3Y72cTK50wPbDDifv14yA0MO6Xpjrajij7W2ZLmDdyAU87bFYj0k/KMLa4FfqZODY6xIU2RY=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:34 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::3d) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:34 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:30 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 18/35] x86/bugs: Restructure srso mitigation
Date: Tue, 5 Nov 2024 15:54:38 -0600
Message-ID: <20241105215455.359471-19-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d47968d-f443-4dd0-dd2c-08dcfde49311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKtVaKZcfz6iouk31xwdochWmHmpAbGS0pMo4CQylzybAmFnAML2r6vYcPIj?=
 =?us-ascii?Q?xdsFAL3p+AjR2egpCDYRRZYj256xYtQZvaYd17U2IZ2FAEyUdx9nZGtM0WIq?=
 =?us-ascii?Q?LrmLR8PWZfYBCJbvSznDzmm4sdo7mN60er9sC/gtKXvZMDGEkL5EdpZRFDdh?=
 =?us-ascii?Q?f+4BOEi04jFIyUI34J91sQjvjkLP8rR1Nn4MAwgXVGxUkNhel92AU8qsP6An?=
 =?us-ascii?Q?ep6rRB3mZj+r41j9YdTTzdANsuYobqoar3bvA3/TpkwNqH9JxpQ+EySRAU6h?=
 =?us-ascii?Q?hmYLhoqITtunI+tzlgRlULvdoqHnYTa6NiLNBNqRhPEUMqWmF7euCLnZOfa4?=
 =?us-ascii?Q?Xu8bskArUX34mgqLkvOKCFdlAh4UuLZyBQHztnZGH3W1kDKrQdvyXeKpm00b?=
 =?us-ascii?Q?iyyLULFsUeaxRXFrVVwu6PLA9YypIYg8OFz68tVljRy/R6unPLYJH4Wy77ns?=
 =?us-ascii?Q?FkdpVXGcRucb95zP9fzQ1Hg147uXKrE9eenShHv+tMtO4DjaNCuj5M36he/4?=
 =?us-ascii?Q?PbHyTa9XQwaLECQQEuPhIw6w5zVNLCPej9G6tKwkmPNhHL+ANY95fGT9T48i?=
 =?us-ascii?Q?Vz6NcQa7Bkv85Bnrw86xSrEfRoUkCm57/ptRtGv0NgkT6wcFXsqUlEouW7Nv?=
 =?us-ascii?Q?Yof5XY7CoFlXB/ePUX4N6dgMVnpP4pi88r7F2ds7DNTb7mujmgAApYCrmd2i?=
 =?us-ascii?Q?JVRNzaAZjLCH9C+pVJ+65tR+mV/42povHeXgnuosEr2pux8r5uiBZ1AWT76d?=
 =?us-ascii?Q?OkEST11ADe31BOjKkEM3vFfYuxyjo5GzORMKsHEdv4dQ6S0XwRaKBELB34I5?=
 =?us-ascii?Q?JWyCkSksnkue1kezoJwz7GyiJo/81+V4uI9tPAk7trE7VSkq1bhMzwLPboG8?=
 =?us-ascii?Q?kqsEMcOpAXMCgZHk3hiOmJHWYRRIA0//D0iAfgk3TDJWYUsm+3YrRcaZWjww?=
 =?us-ascii?Q?nWmbE26GK1QIJDBanp4jZu3H7KLhl1T0kTUgbrsKHRb772RTyIZY94yf4M6e?=
 =?us-ascii?Q?QuLxqL47re9RGesJZsWoQDW338Wziwo4S7wM1qwizn5w6vLtz81K9we3+RqR?=
 =?us-ascii?Q?v4oZPRyPGz3VNu3gZtY2H8mJa7+PIOxJjEEVAA+jrAkbhXyYdB0nK9+zzMSt?=
 =?us-ascii?Q?LdG18qADLRVrSJKCn4YDfTSNhQx5hxfp5OTqO0WhPKtZRDNXYCjZk35Nx8aK?=
 =?us-ascii?Q?j3Ju/WPKFTURCTNFGUvIRIsHBfWWMABR8kx1860bzT5Tt+rmjfybZEMSZheU?=
 =?us-ascii?Q?Swhb/acLDymA+J91ZGrocuSAShzD6OjFW3A+HfwDCP+d0vHuHme78AsQlk2j?=
 =?us-ascii?Q?tVkV0OwhHlxVQ1uBThie2RfpeTntGJW70AIa1k1xHSG9i9DXHtLFWYeevKOF?=
 =?us-ascii?Q?dmh8q1wjhWdU7UAzYBuLQaW4MpExHdM14WLYIn2zpmyRw/oogg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:34.0935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d47968d-f443-4dd0-dd2c-08dcfde49311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809

Restructure srso to use select/update/apply functions to create
consistent vulnerability handling.  Like with retbleed, the command line
options directly select mitigations which can later be modified.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 182 ++++++++++++++++++-------------------
 1 file changed, 89 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 98ef1cbc9e2a..178415d8026a 100644
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
@@ -200,11 +202,6 @@ void __init cpu_select_mitigations(void)
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
@@ -220,6 +217,7 @@ void __init cpu_select_mitigations(void)
 	taa_update_mitigation();
 	mmio_update_mitigation();
 	rfds_update_mitigation();
+	srso_update_mitigation();
 
 	spectre_v1_apply_mitigation();
 	spectre_v2_apply_mitigation();
@@ -232,6 +230,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	srso_apply_mitigation();
 	gds_apply_mitigation();
 	bhi_apply_mitigation();
 }
@@ -2671,6 +2670,7 @@ early_param("l1tf", l1tf_cmdline);
 
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_AUTO,
 	SRSO_MITIGATION_UCODE_NEEDED,
 	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
 	SRSO_MITIGATION_MICROCODE,
@@ -2679,14 +2679,6 @@ enum srso_mitigation {
 	SRSO_MITIGATION_IBPB_ON_VMEXIT,
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
@@ -2697,8 +2689,7 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only"
 };
 
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
-static enum srso_mitigation_cmd srso_cmd __ro_after_init = SRSO_CMD_SAFE_RET;
+static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
 
 static int __init srso_parse_cmdline(char *str)
 {
@@ -2706,15 +2697,15 @@ static int __init srso_parse_cmdline(char *str)
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
 
@@ -2728,13 +2719,15 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
-	    cpu_mitigations_off() ||
-	    srso_cmd == SRSO_CMD_OFF) {
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+		srso_mitigation = SRSO_MITIGATION_NONE;
+
+	if (srso_mitigation == SRSO_MITIGATION_NONE)
 		return;
-	}
+
+	/* Default mitigation */
+	if (srso_mitigation == SRSO_MITIGATION_AUTO)
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 
 	if (has_microcode) {
 		/*
@@ -2747,94 +2740,97 @@ static void __init srso_select_mitigation(void)
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
-
-		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto out;
-		}
 	} else {
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
 
-		/* may be overwritten by SRSO_CMD_SAFE_RET below */
-		srso_mitigation = SRSO_MITIGATION_UCODE_NEEDED;
+		/* Fall-back to Safe-RET */
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
 	}
 
-	switch (srso_cmd) {
-	case SRSO_CMD_MICROCODE:
-		if (has_microcode) {
-			srso_mitigation = SRSO_MITIGATION_MICROCODE;
-			pr_warn(SRSO_NOTICE);
-		}
+	switch (srso_mitigation) {
+	case SRSO_MITIGATION_MICROCODE:
+		pr_warn(SRSO_NOTICE);
 		break;
 
-	case SRSO_CMD_SAFE_RET:
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
+	case SRSO_MITIGATION_SAFE_RET:
+	case SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED:
+		if (!IS_ENABLED(CONFIG_MITIGATION_SRSO))
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
-		}
 		break;
 
-	case SRSO_CMD_IBPB:
-		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
-				srso_mitigation = SRSO_MITIGATION_IBPB;
-
-				/*
-				 * IBPB on entry already obviates the need for
-				 * software-based untraining so clear those in case some
-				 * other mitigation like Retbleed has selected them.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_UNRET);
-				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
-			}
-		} else {
+	case SRSO_MITIGATION_IBPB:
+		if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY))
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-		}
 		break;
 
-	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
+		if (!IS_ENABLED(CONFIG_MITIGATION_SRSO))
+			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
+		break;
+	default:
+		break;
+	}
+}
+
+static void __init srso_update_mitigation(void)
+{
+	/* If retbleed is using IBPB, that works for SRSO as well */
+	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB)
+		srso_mitigation = SRSO_MITIGATION_IBPB;
+
+	if (srso_mitigation != SRSO_MITIGATION_NONE)
+		pr_info("%s\n", srso_strings[srso_mitigation]);
+}
 
-				/*
-				 * There is no need for RSB filling: entry_ibpb() ensures
-				 * all predictions, including the RSB, are invalidated,
-				 * regardless of IBPB implementation.
-				 */
-				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-			}
+static void __init srso_apply_mitigation(void)
+{
+	if (srso_mitigation == SRSO_MITIGATION_NONE) {
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
+	}
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
 		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
-                }
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
+		break;
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		/*
+		 * There is no need for RSB filling: entry_ibpb() ensures
+		 * all predictions, including the RSB, are invalidated,
+		 * regardless of IBPB implementation.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		break;
 	default:
 		break;
 	}
 
-out:
-	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
 #undef pr_fmt
-- 
2.34.1


