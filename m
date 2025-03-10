Return-Path: <linux-kernel+bounces-554683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A566A59B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4170716EB31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA842356A1;
	Mon, 10 Mar 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nDtK8U0x"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB48231A30
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624848; cv=fail; b=pxQNTqnznOO+ATm/YQPitlx2VVFd73g8NM0RIHdWpjdE3aaVJvNzGS7bOeWycZrqzLkFJqhpuh+gwA3GjJRdRxii4OgfAC1OdzM2nlC1JJg9bGdbam45DDt00D1+HwlCOGE+pCEh/CeUdVYSvqICKhOZjd+XNxZEhrmMdHPigqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624848; c=relaxed/simple;
	bh=E+HOkieAMtB7ajHPOAkLK8fSYAsfPdyJI3vBO5WCw8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C16DKThS1Za5N6ywd7wkno+0/Z6HaNN6taoF6IUDzqCp5/P6Qu/HohR6oRIGA6HKvsyFj2Jw2gRepvAg2CgZc+tooqXf+VrxlSlCohVwP2uYIml+tp3C3g213DNAlFo/TCgrmKGnFfyACltcPKyyer0hbjU6a2PvwwMWl2Gae8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nDtK8U0x; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2om0bmv3A12vYw15QPzfempAEmz4XdstvpRw3KG5cQLPYtnaRBHEqA0w6UUDJG4lrBXgF/G8eDl5KhPOt/D9CUfNin9Isfim92A/PeAJ13PDHMEJCJN9iB1ScAW9PIQUaMZ8urdZ4I01Oby5N7sM4PY+FVWPy9ZzePnjIkJTOnYI5IYf9UPVylGjsxF+EoKzWEChd7qGuQD9mu0ubphmjRwixMOZDZ5z3lxH/FCJ3jA1hLvcno4RSRlFhwzaAlbOzaiabp7Wi/3JjL4q7uubR6jV29upT7N3KIuy3iBj9CtIsTZuTdbBTXJ0NVtb5OosRZu6ObChvYP6JOXrUDr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLDSqywwwezmC96KHRYVeVQUkXVIBgAPLh5vm/E4R3w=;
 b=UPAPznLd3Iwj8cRwJ/THCNgK0ILhR2ynKwudGX12G45h9iOnMEEjLs5B44fcQLokBEC757u+YGOBQl56KXWBWcxMAYjjXPXaRsSxnol5Ymi5SqahHq/Yk8Kr6rRK2Bo45URqyf5Y/cAY8coGqjO+AZMwr6sIPBRaAFFX8i6K4NX2+wBp1mayYKsoQhBAlTTz6koa5OncOvzEs/iRK7aSL/nBE3UOLL6xjqtebPPJoFoUzUJtKrtMdmgGM+WuJZ/Cyio2YV9220jLZTiJ41iWtrtMiy49BFDsnvzddZW/PCXAt2Gygj0HiK2LuQbuEI8tUgqC9F+kdRbugg9loqeNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLDSqywwwezmC96KHRYVeVQUkXVIBgAPLh5vm/E4R3w=;
 b=nDtK8U0xQveqyhCV07n0eo9wpN0LbYdOh5QHjRuLKfDf/xFftsmcS677kWBgWODkMIYwopySmDpqa8sJZbm2DJS5Vj3yDWp2BaXCz1wj04HJ8yi2sVQRpZB6MNxvb1DLDVvYB8PCMp+AT9TVIurUGkoptz5juLdopJsD7JcDB4k=
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:42 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::a7) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 16:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:42 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:39 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 07/36] x86/bugs: Restructure gds mitigation
Date: Mon, 10 Mar 2025 11:39:54 -0500
Message-ID: <20250310164023.779191-8-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: f278c096-15ac-426e-2bd3-08dd5ff24c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9MkyXCCC7+Mk0IatW35GnGeXqYd4xtngMfRoKK+57/S5jFgNL4543TBlE2L?=
 =?us-ascii?Q?2C0jA4ZdoNALb5yI8oF0YhG0Gc6IJprHstzGYkUfCHXbbZYYk4sxh0ZZXN10?=
 =?us-ascii?Q?I3uTVvQVu/BM2D4PoAo09Ori6Ynwf69MHYAKEtdTZU6bRfhzkslT7frelHql?=
 =?us-ascii?Q?coI+wMKDE3VZKtfC9pdi0jMVDiq+esnZXvsHvtHymwrCEq666iYBcSOGQkTT?=
 =?us-ascii?Q?4aI8AbXXqKtRItd6PHTzkd6ciLRGsnQz4jVDsn8XAxq4YR04b9vwRD12n3zM?=
 =?us-ascii?Q?+G2UptlfMkOfecZSMsJowicEao9oGeAoLzB1feFhqfV36I7quJAe6CPd0JLV?=
 =?us-ascii?Q?5pwvitJ4djtzc9rYw6ZJmCI+uvz1P3tbIcYiQB82a+H8k439IdQEF4X3H7f8?=
 =?us-ascii?Q?1Su46P5f2JvRmfyzDyI3ZQ94LyByXsqkpmtCrxzas4F5ZryFlTFNhSrFhIGg?=
 =?us-ascii?Q?/QJHL0h0OfsFDaaK1qu9pF9ru+ei7gM1e6LC/XOr9YLLcrVx59zrytq8U4AW?=
 =?us-ascii?Q?NpyAk4SFyuD8VqTAVulHETyTBSJ6eRTJS5c9NqfZuQvS3JIroAVIKAtaBG/k?=
 =?us-ascii?Q?w41CqV4TyziG7kILGTRp06dbFY6yCMWbTPSW2sVBDG7MjZGg3ZjO48plyWzK?=
 =?us-ascii?Q?TWHicuTBn2EJkV4GnCJZnGfaLHp871xv8XMaHDtVvhqVMlJG57EPEcQi2D57?=
 =?us-ascii?Q?Xa/n+rK9eZFyJkstAkYj3xDrszzDHNMKL3e2aECiMhyDWp4T7cPVYe1+hHK4?=
 =?us-ascii?Q?VBD3NEMqb2P+REinj+qiJ3oEPSpORC1y0/7V2PPsI/FbKBZgATvBqmERxleM?=
 =?us-ascii?Q?iKdw7DvGc8TnWSI208QqkQJ6fOmZ0T3agx9Bz8GWm+3jtzHBlHPgE972gynX?=
 =?us-ascii?Q?xTzvCMQuAo9uffAs3vOL8HTjOD9ndQpNNQKd90GBnrmqWhbeuUrIDGpwB8Bj?=
 =?us-ascii?Q?djlRMECu3M7MdgRVcmYalW9MlFKOb/jUZ05GNTBQlrMygMgs3v3vQQzmbfTJ?=
 =?us-ascii?Q?ad0P9U49SrdG3UZEAjYZqo+kyE6SnjnbQhGHSqubrA/w0iIPleX7Lcoz0jqf?=
 =?us-ascii?Q?x8WXJuKULBkI4k+FJxzqJAsE9H0i1WCuQpxvbdlr9bqC8ps6efPYtOXBFjJ2?=
 =?us-ascii?Q?0riPKhE3rNL5hn7KLl620Y6exmyJxmfnvRbE4vJHxyTHdH0vmKccmaZSwI43?=
 =?us-ascii?Q?qQLKE4Ub5ncEFZwb7qzv6VVH5ysTp9MDVu7pH0By326HScYHrg5XZDS2Gu0l?=
 =?us-ascii?Q?ShJUj9Y0pvQOKdegQUQ3Qev+qT0vvG67zGQqGbVtnpXfx20qI5EJRyMYq8Gs?=
 =?us-ascii?Q?laZO2fFIJNZUC54KCp1ScrMSfhFGpz7Jvw8OBUkaAOqnq2P4iNdtFEgewpz9?=
 =?us-ascii?Q?0tHaqKW804hU38MA3x7+ORn094qKvIz5sC73zjO098ASiokewZDhCSkbPPG0?=
 =?us-ascii?Q?ukydvbBHzRiEUnSp+z4H+YztgXBc2Zi0rmtqYu9mIYCju6FwTkM3jyTxTQ4j?=
 =?us-ascii?Q?DnQx4kAxNBaTxIE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:42.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f278c096-15ac-426e-2bd3-08dd5ff24c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975

Restructure gds mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for gds.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 43 +++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fd04de518fd0..ee7a8009a188 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -76,6 +76,7 @@ static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
+static void __init gds_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -224,6 +225,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	gds_apply_mitigation();
 }
 
 /*
@@ -818,6 +820,7 @@ early_param("l1d_flush", l1d_flush_parse_cmdline);
 
 enum gds_mitigations {
 	GDS_MITIGATION_OFF,
+	GDS_MITIGATION_AUTO,
 	GDS_MITIGATION_UCODE_NEEDED,
 	GDS_MITIGATION_FORCE,
 	GDS_MITIGATION_FULL,
@@ -826,7 +829,7 @@ enum gds_mitigations {
 };
 
 static enum gds_mitigations gds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_FULL : GDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_AUTO : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
@@ -867,6 +870,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_FORCE:
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
+	case GDS_MITIGATION_AUTO:
 		return;
 	}
 
@@ -890,26 +894,21 @@ static void __init gds_select_mitigation(void)
 
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
-		if (gds_mitigation == GDS_MITIGATION_FORCE) {
-			/*
-			 * This only needs to be done on the boot CPU so do it
-			 * here rather than in update_gds_msr()
-			 */
-			setup_clear_cpu_cap(X86_FEATURE_AVX);
-			pr_warn("Microcode update needed! Disabling AVX as mitigation.\n");
-		} else {
+		if (gds_mitigation != GDS_MITIGATION_FORCE)
 			gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
-		}
-		goto out;
+		return;
 	}
 
 	/* Microcode has mitigation, use it */
@@ -930,9 +929,25 @@ static void __init gds_select_mitigation(void)
 		 */
 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
 	}
+}
+
+static void __init gds_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_GDS))
+		return;
+
+	/* Microcode is present */
+	if (x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)
+		update_gds_msr();
+	else if (gds_mitigation == GDS_MITIGATION_FORCE) {
+		/*
+		 * This only needs to be done on the boot CPU so do it
+		 * here rather than in update_gds_msr()
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_AVX);
+		pr_warn("Microcode update needed! Disabling AVX as mitigation.\n");
+	}
 
-	update_gds_msr();
-out:
 	pr_info("%s\n", gds_strings[gds_mitigation]);
 }
 
-- 
2.34.1


