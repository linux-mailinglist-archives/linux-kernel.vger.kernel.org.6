Return-Path: <linux-kernel+bounces-327139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE0977131
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1A61F24ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB71C3307;
	Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oYp7gIuU"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B51C2DC3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168169; cv=fail; b=Nh25lH3pgbFRfk2L8eFTN4zTNI8mBnpEbvdaLTowhMcDntOy1rnsevsJR3dlwbZjwroUEBEmPGvnlk9xuTw9dfQbTIaAv3VIoOgbwiXEXMkvPN7cBAI0s7Lk5uAWAhLCgRooE4lYN50RuAfwRDWYoUxy6B8SF+7SaNokCH4LZto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168169; c=relaxed/simple;
	bh=T+VL+ljamoy7YE1sXKH9gNIJDwnuFNsJuNJgCPorlPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPhf/4xNtFvxsXw0u5jjhoqq0w+rWZ0zSicCJBHm/oorm4pqn9YkjeekKFq1DJUFS48tox58QCgdVZeB8iZKefSAS+cWSRUyefPKcUGaMVOyvezRPQLQaiBwRObV+HGpn1CK6+eg9OlZ2jsLtD7fQDmo+JZhQpMzpcIms56h5C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oYp7gIuU; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY8KVMYUg2Ijfonm83cVHFMUNNPntGfjbHJeEj1J7cDmmluEEtWU5z5dICSinX7OK2iS/4PscKtL3hMEMCDk1I7Oqx84OfLt8xgzEFy57aVea2PSedmfd9p3hr1YM83pnd13ItxAO2dnQu2TgTszO2K2UzA7IYB59qYzo4BmZUidHYI+l4v6dffYolE+ZUI1n6iPSNiN6OW2cJ383fJYJxagB0MdsKN46WPHtl8MDXrhCotqY0tIQ7tXJDbtTT0i5jY0HqbBR/h33jbMLuD2GQrR6g5VVzefDNdv3moR+E/ql6TyeKsvAu1wRTLFQfm6e6+iARPsVP3Hr2Sa8gRGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWSFNn3vnwrNfAAfGapu4lnlBsrHG79DNWoMncBmQIA=;
 b=rJx+TrvxFbEhTRFIGypZTNNxWgxuuJo6sQUwOA6XuVPqFl7D9ZFWhLlnCOYWIDkUZrQNshcT1iUOW4LURLsn8ZytjlEUqfdqZJ0FCH7E8L7dSiPa0rHuLW7CqwLJgWjXE/p7ZpMlTmZAsrLslIhNoNTl2ZkOD/1xwts84Ahx2Ok6CBT798q3LU2Wpl+1VI01wQRsc+d7dv15+dE69MHhMfdPbiT7CDp4lbbAqYaJGS64fJ70NCcRjhchZAvvxrt5eZXpQWDOT+bzc/WqOJxPo+B8WI9Ysn0pG0fxQGThwuraWIvs22fQ4UDdDGilWqa9AO/lzh9RBHW6Cyv53b0tHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWSFNn3vnwrNfAAfGapu4lnlBsrHG79DNWoMncBmQIA=;
 b=oYp7gIuUQXvyXuV9yTKV2t41Bg3tllANs+asY9KgeIiiwWCnpcGSXiK8QdPCF2RgyDqa7qpIzoQtw2vdP+3AtX5akB0Gf82KA3T/nLNrdtmQ+UjHc8bpCKfEthYoP8/cwU9QxYU4wO/tPQc1NCEtnmeWvPgK46xVY97+Sqh1krE=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:21 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::3a) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:20 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:16 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 17/34] x86/bugs: Restructure srso mitigation
Date: Thu, 12 Sep 2024 14:08:40 -0500
Message-ID: <20240912190857.235849-18-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 428a0f20-7e8a-4098-e854-08dcd35e681e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cn21mzChDELdJMOcAfa/SKfZqOIo+n8Zj2L0ywc1u4HnhdvEo6aPpSf20Cl8?=
 =?us-ascii?Q?vCIM7Yt3xFSgE1v2IA5oni7pMz/YB0vkIgrXJW5+/0sZQnBOxOtY3mwzr4z9?=
 =?us-ascii?Q?u13VIVhaz3iKn+g+Zd1yhv7YO7Uj6ehpHJhj/CBBGCHysBUl7D/AyAbgURHB?=
 =?us-ascii?Q?BmXmCQE3rTSQCSaKALmXGGFl+IoBPS728vgjaQwSKAmbmfCw8VNF2659Fn0m?=
 =?us-ascii?Q?/bFKxrpfZdzf/it9ORqGTZwknYHFApr5NzBj24GhwLbhIxsVC78eCEW/miqX?=
 =?us-ascii?Q?w+h1kRIvb5MnqRsCEEyTcF5XtqW0kqzr+l+PCLywmHJDnf8KzwIr4TGLmOBF?=
 =?us-ascii?Q?4W/PlH+T2JdOREsYuRJXvixHotnymAlWjYlc0KjPTTKulSCCl8r866ASpZJs?=
 =?us-ascii?Q?7KaM7kmatSs3Ztoo8vWiH7TdwifCivLolOo7GT3Ado9SiMymMjLi2BFbbqHP?=
 =?us-ascii?Q?GMHwO8QF9jYLxEOiKkYTncSFqbA13FjtUT3Umr7toOPJMXg86D0bJd9J2GBO?=
 =?us-ascii?Q?V+yHPw3STd9WxhxAPX5klK2PxOBfwQ67/Uk/eh0YG8S2uQpMEm8aq7/76Iuo?=
 =?us-ascii?Q?xlBG1PBrwMJ5c3uW4FgHB8Z23iN/YunkQUag31l3Mww/CM9BEqUS0toqyn5z?=
 =?us-ascii?Q?m5EI/8Jc5ZzGQNXksRZOpQTRr7LRb2RPTZhsWL/vViYD/XE9XvL+zWh7z7wV?=
 =?us-ascii?Q?XptLRoRk9NkpfXQZTWJxmFtPHaedwQlWFhntpEg7Q7FWunZcLwIpKVIFhBdA?=
 =?us-ascii?Q?KWKFAJhOv6t1sQmKuxkADmdLx5Or4mboHgBA77kYbA+0pJ4ORMjEYa25goSU?=
 =?us-ascii?Q?ejSrJD386RnK1FhA8E5muAuLbgCt/QQEwo7M1LCXr/txlj0XSHmms4sNFCUI?=
 =?us-ascii?Q?Vm+DouHMxrGhcyvkq69yT0nDCxbysvpmHAgdh0YeOXxsk78G9rf5JrMOhjYg?=
 =?us-ascii?Q?XSS741rQdYjMtjLKIprMUFHJk49Up1VhmJkRaLvhvwyQyVkjGJgYIUVbt2iI?=
 =?us-ascii?Q?AVR8vBbPFLIyng2Gy58LdjpPObk6VfreprEezYAq0yS7C3c6mA3PxYCMcc72?=
 =?us-ascii?Q?v6/VHkN2bszFPMRIljuPisgSQE7y49KUfTHbc0Re38x9ClxVpZyPNfOWN0Z7?=
 =?us-ascii?Q?4LglponqFLgAcQLEM9gijHiNfx0hDjzrB0FxHO2F8tKf+N+yixVQR6inPP0U?=
 =?us-ascii?Q?BfzU5fsrnJC/c5FIq8bPKkdWXe24mzwdt2b+/DW2/BsBM76RUbUw9qn+B+0D?=
 =?us-ascii?Q?Rl+2IyafJMzth53Jnrrz34TArCTCx1QKpwerL4LYHYtuozy2uanaQgqK5laO?=
 =?us-ascii?Q?0BNQ2u3O1D2b7tP9ozGAtF6R3SsKHF7kNQQ5cqxKT+qrJ87aOlhKCbX0/Zy9?=
 =?us-ascii?Q?AW3Arw4lxOg6kZ9vUthj7v8VYEslIG/AnyB7nbhQ5qoK8URvNb6cYZ3ONLm2?=
 =?us-ascii?Q?BLWZEBdHi6NkS/q4Vjcq7RYj1n9UOTds?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:20.5447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428a0f20-7e8a-4098-e854-08dcd35e681e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

Restructure srso to use select/update/apply functions to create
consistent vulnerability handling.  Like with retbleed, the command line
options directly select mitigations which can later be modified.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 136 ++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ba10aa37d949..334fd2c5251d 100644
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
@@ -2637,6 +2636,7 @@ early_param("l1tf", l1tf_cmdline);
 
 enum srso_mitigation {
 	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_AUTO,
 	SRSO_MITIGATION_UCODE_NEEDED,
 	SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED,
 	SRSO_MITIGATION_MICROCODE,
@@ -2645,14 +2645,6 @@ enum srso_mitigation {
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
@@ -2663,8 +2655,7 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only"
 };
 
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
-static enum srso_mitigation_cmd srso_cmd __ro_after_init = SRSO_CMD_SAFE_RET;
+static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
 
 static int __init srso_parse_cmdline(char *str)
 {
@@ -2672,15 +2663,15 @@ static int __init srso_parse_cmdline(char *str)
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
 
@@ -2696,12 +2687,16 @@ static void __init srso_select_mitigation(void)
 
 	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
 	    cpu_mitigations_off() ||
-	    srso_cmd == SRSO_CMD_OFF) {
+	    srso_mitigation == SRSO_MITIGATION_NONE) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
 		return;
 	}
 
+	/* Default mitigation */
+	if (srso_mitigation == SRSO_MITIGATION_AUTO)
+		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+
 	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
@@ -2713,29 +2708,59 @@ static void __init srso_select_mitigation(void)
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
+		break;
+
+	case SRSO_MITIGATION_SAFE_RET:
+	case SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED:
+		if (!IS_ENABLED(CONFIG_MITIGATION_SRSO))
+			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
 		break;
 
-	case SRSO_CMD_SAFE_RET:
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
+	case SRSO_MITIGATION_IBPB:
+		if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY))
+			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
+		break;
+
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
+	pr_info("%s\n", srso_strings[srso_mitigation]);
+}
+
+static void __init srso_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
+	     srso_mitigation == SRSO_MITIGATION_NONE) {
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
+	}
+	switch (srso_mitigation) {
+	case SRSO_MITIGATION_SAFE_RET:
+	case SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED:
 			/*
 			 * Enable the return thunk for generated code
 			 * like ftrace, static_call, etc.
@@ -2750,42 +2775,17 @@ static void __init srso_select_mitigation(void)
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
 				x86_return_thunk = srso_return_thunk;
 			}
-			if (has_microcode)
-				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
-			else
-				srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
-		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
-		}
-		break;
-
-	case SRSO_CMD_IBPB:
-		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			if (has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
-				srso_mitigation = SRSO_MITIGATION_IBPB;
-			}
-		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-		}
-		break;
-
-	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
-			}
-		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
-                }
 		break;
+	case SRSO_MITIGATION_IBPB:
+			setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+			break;
+	case SRSO_MITIGATION_IBPB_ON_VMEXIT:
+			setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+			break;
 	default:
-		break;
+			break;
 	}
 
-out:
-	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
 #undef pr_fmt
-- 
2.34.1


