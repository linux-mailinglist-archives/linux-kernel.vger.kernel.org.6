Return-Path: <linux-kernel+bounces-554688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F92A59B51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F221889F07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB018237194;
	Mon, 10 Mar 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3EwvE581"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40076235C0F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624853; cv=fail; b=o05O2Tusg7G5aTGK6BxI5TGVYYawo4ybMR3CSuSeylq0EU17n6EYWEDWGq0bRJI+Hd2WHkUjIfjcd5ONhqP4vR/l/FakBb14FPtzyVmT3VbQzfrMocA86btaRVlPL6qi2Xy9JQf33IqYlZZkFWFR/OKjclMxKfmwI1byT9TcF4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624853; c=relaxed/simple;
	bh=j4+08Eewc+sTdYqiW7Vj0/4Xm1mvENuuanjrX68MXJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvkXWoLqGnhT1psWGFHikWapVYdpN6jjA3ge0U8JjOEkOb8bPEL1zdubVA+ooVuCVYgTprBZBMgHR+GmMxwhH6CB0i2QkxzHiMuGsmXysyhVIGFA7e5gQEI/BbXYVnIJrq425hhzcKI88r0rAh/Ut/3rxohU55WrvCoBcQqywqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3EwvE581; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rppOdwlGQ9mDxzyp2T0Kh99tUSkmuCgEcKP0RxQ0HF2vTIzGL+c0xlz1hoMWrBmFtRfZwnRLZWMASpo963bHsvSTnvuYd0/TIcv57lDI0EH1Bkgwk8iUWP1SIMkBJRWI3QqMigmjheWcblkDC0XmvqAjvs4YcmaMz+VlZilmRB9M+mfsRTYm7yDnmENPqOmLxCodMnHd/E5b5iljwyFgdXIimTCL2xbvs8B3HRHyjaXnAOPfy1scsJ0Kfc7v3iEeosgVcN0MKt6dYtxutB7H2CTw/QiAqPqDSRHxqPFyUprtlWZqU04ejnC64YomlBjF/eOKr0iXQ83GKnPpWoukUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4Kr0XbhaXofcAFlXOfNV8seBC3xv6NbagxgoolXHwg=;
 b=K5DbhwZkPIJech9A2P1RUXgDqc2dtw27XhVBM/QT38acJhlD83KqMJCt6ERQlWUMTejaruIZ8kzIl4zplvzjbc+aS1KkRzow4hmodCFmpq9pwbPUJ+aq4lGkojCTmayYidPgo996npa4cfGV5njqTamE3gAMXBaNea6o1BKq7BhOOODM7WfimSaoFxFyJ0D5l/ExX77d9PsnUYVVpEfMzOmnzZzF8mNFXHgJXsGtcdo/2D/OZWoeycAlaWCl36cQ1onrpTbnc+IBIk8XQ4jCqw7wf9jIH+K/DNoD+LwaplU5lKM6ECF3mmGNFCxzhbly5aTjV2KstRmzmQuG1BTJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4Kr0XbhaXofcAFlXOfNV8seBC3xv6NbagxgoolXHwg=;
 b=3EwvE581PtekLmuh38wk8ZN8BynNcDy5vHtzycPupyvkLK6Hi/P2BU2FJjd85z7cDRHwa6LwUhn8TeiGCAdcBkHQ14mbb0K0YITtMi+us25JPIg7XAsJcsDL55rsg1+8Ri3T+4Rt+2EZGnSRMdcwL5mLIPQm4OhaGLgEvP/M1Ds=
Received: from BN9PR03CA0084.namprd03.prod.outlook.com (2603:10b6:408:fc::29)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:46 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::75) by BN9PR03CA0084.outlook.office365.com
 (2603:10b6:408:fc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:45 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:44 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 11/36] x86/bugs: Restructure spectre_v2_user mitigation
Date: Mon, 10 Mar 2025 11:39:58 -0500
Message-ID: <20250310164023.779191-12-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c674fcc-51a5-4db0-724b-08dd5ff24e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMiTzv6Dxc/lDuFmdlM9z0woA5B8lH/jIcq0uv0W7VdYYSsc9MHdmNn3zink?=
 =?us-ascii?Q?qcEt8gYxdHdonP1ysUBccxgai3kV1oYIF3glL5f3pcFXSEPWDxmpiGdemw6s?=
 =?us-ascii?Q?M4iACEC34i1HfqjhwzFTI27GzHtsRoghfSpaJGBuuzUXpE3Rq2w2HthqgAoD?=
 =?us-ascii?Q?dm1uOGfeY/WO0Qi/xi+PDGgRXZNZf2ZTunag/LrF6qpF7N1UcyQGNYmbdsbn?=
 =?us-ascii?Q?XrRXAfUnsCVm4ILg2oNSisRF0rAOK+tdJW9PSWTpPcasuvrhtGr09M1TqkUv?=
 =?us-ascii?Q?UU4c4bcqtUbEIpSJIvGgpTJfSIjAnViYPYEeofU69upvSvM6YhVxIydDyZGd?=
 =?us-ascii?Q?QUf4W/HS70aaCdQDeojoPL1lpNV/oD5FGViVo42IFl4kSFm/bo5b3q7NwBop?=
 =?us-ascii?Q?vHq9hAjXpKIRsr7vS7KuykD84WsmZb11yL/UFFoyXrQ3lzmVxlgNajs4wfkT?=
 =?us-ascii?Q?ImlBKYCWErl626dRLS9eSZaAXuGo9s8wCXv5zUbzg7XB5FrftJwf4PZfHHUg?=
 =?us-ascii?Q?bfyuh3TIqULfch3yqoqz+jppGFeYmJh+W/eQLdNvNYAocU/TF7agd2tnA32s?=
 =?us-ascii?Q?6qOeBKSWXitO4Xxh3ZKXFL4h7DKZP9ZE5gEvquh/DTYlCLhii7mEsTyqo0/H?=
 =?us-ascii?Q?5+FNlj5QDM7riU94SKjqqq15Pzo01yQGZixEG435SG/kDZGeiT17jHOTgID5?=
 =?us-ascii?Q?sWnj31Cx7V85KnVRFRoqlwgWq1SEhGpsbcAnd3TCTJquJiciVQPDKGcuyqEh?=
 =?us-ascii?Q?RbKnVi8fva67IJFRPOVgj8pT5hVLXyon9+L5G5B9zWdf4D4HjGCtk4CTQnai?=
 =?us-ascii?Q?/BJlBOUA83Ss92FI2MTYeW6QVJHUhQGcgvnfv4H//Pz9FSkCH2sD8qlG2Mvy?=
 =?us-ascii?Q?1I7GvIV7pqLc/VPHyG0dM0Ldi0nTY9SURuKZmujVdkPzuPLIJ4f8UN+DR3zB?=
 =?us-ascii?Q?BcC3gW5K40Z6cNtBX5+EM7mF/5AP5TU1c8K+a24NOo3rxM/TpeLCsY+xoXQV?=
 =?us-ascii?Q?O1ne04OlJvOiV3ACH2/Rqv2+Yj3BCsMWNVPzsBmtpX4lB9GTdmb6W7n8DXx1?=
 =?us-ascii?Q?RbO6oUL/4lAKi33o8X7tonfXSHFTVLCSAnYKrlOyPGyXtby7Rvn0J7rBpnH2?=
 =?us-ascii?Q?ubGE4gX9Aawnr2U1DPBj4dxwQa0LNWKWavX34NnZeCCVdAa8k30B5Su863n6?=
 =?us-ascii?Q?tyUz+q3hakFWnnwc9EZmkpcUfqTfe6VTZwWcN0L3qSZkicMXiiYKrB5FdZ1l?=
 =?us-ascii?Q?fWJBFefpbhBH45sLhAf4Dp9whmUU3r571PpQXeapRLJ7PjMg3ot8lyWV/o8w?=
 =?us-ascii?Q?3AQeEvlw4qt/lKBSzrX1aIejQHQXFGml3GyHyoL0M/RU1nCfI7X2lH6YnEO0?=
 =?us-ascii?Q?pe756qc4yY9DG2rRujpAoRobrHZgG3Qny4UPc1Slixy70NK8WuAUdABFl6Ha?=
 =?us-ascii?Q?q2vEdN8kADjDQQjRmnnJ+ZwxxC89VsREwFqSoOYSmsoZ7bZWexTSVxs/8ERW?=
 =?us-ascii?Q?59WRZqFZlZKvYD8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:45.8922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c674fcc-51a5-4db0-724b-08dd5ff24e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

Restructure spectre_v2_user to use select/update/apply functions to
create consistent vulnerability handling.

The ibpb/stibp choices are first decided based on the spectre_v2_user
command line but can be modified by the spectre_v2 command line option
as well.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 152 +++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 80b554249d85..623a3a3d3008 100644
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
@@ -187,11 +189,6 @@ void __init cpu_select_mitigations(void)
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
@@ -214,6 +211,8 @@ void __init cpu_select_mitigations(void)
 	 * choices.
 	 */
 	retbleed_update_mitigation();
+	/* spectre_v2_user_update_mitigation() depends on retbleed_mitigation */
+	spectre_v2_user_update_mitigation();
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
@@ -221,6 +220,7 @@ void __init cpu_select_mitigations(void)
 
 	spectre_v1_apply_mitigation();
 	retbleed_apply_mitigation();
+	spectre_v2_user_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1365,6 +1365,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+
 enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
@@ -1403,31 +1405,19 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
 }
 
-static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
-
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
-	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
-	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
-		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
-
-	switch (spectre_v2_cmd) {
-	case SPECTRE_V2_CMD_NONE:
+	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
 		return SPECTRE_V2_USER_CMD_NONE;
-	case SPECTRE_V2_CMD_FORCE:
-		return SPECTRE_V2_USER_CMD_FORCE;
-	default:
-		break;
-	}
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return mode;
+		return SPECTRE_V2_USER_CMD_AUTO;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1438,7 +1428,7 @@ spectre_v2_parse_user_cmdline(void)
 	}
 
 	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return mode;
+	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
@@ -1446,10 +1436,10 @@ static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 	return spectre_v2_in_eibrs_mode(mode) || mode == SPECTRE_V2_IBRS;
 }
 
+
 static void __init
 spectre_v2_user_select_mitigation(void)
 {
-	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
 	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
@@ -1458,48 +1448,61 @@ spectre_v2_user_select_mitigation(void)
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
-		static_branch_enable(&switch_vcpu_ibpb);
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
+	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
+		return;
+
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
@@ -1517,30 +1520,45 @@ spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !cpu_smt_possible() ||
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
+	     retbleed_mitigation == RETBLEED_MITIGATION_IBPB)) {
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
+		static_branch_enable(&switch_vcpu_ibpb);
 
-set_mode:
-	pr_info("%s\n", spectre_v2_user_strings[mode]);
+		switch (spectre_v2_user_ibpb) {
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


