Return-Path: <linux-kernel+bounces-327123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B800D97711C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3251C21921
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC71C1AA8;
	Thu, 12 Sep 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UbFlNGzB"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790A1C0DF3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168160; cv=fail; b=f03HYMu9VmBhmyPRv3adJ9llshLMvV5e6kDRbn+xgGpbxBOjn3DCFTQXNwRDWgv8p0eq7KYTZXYTb5l889xLcjxrUmJKfEvhSXzSEZ9Ir6ATD4facbsLQdRMUIn+3lOiOX6AOHlK2gOByGBLbjFY7wGr5uQRxphScMRzoVFHmBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168160; c=relaxed/simple;
	bh=bi/DyGc/MrwOBI0L6AZJWr9QJOKyMUXNfunJxnnyJO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAr8HByDuRJp0/r1U8Vr/DJZ9ryXeEWK+ryPZbhzWUjx5V90hDzOzgziHjvaVSo07xkpVCriBMCQy5OsnGQntQ5W2bRuc5ziMOIhZhzXBJPPWC7BWxSo5ng3VTRTM/SUpxT73UlGtNSbPGFth9xTw0w6hSErNfTIPbjs1gdO/oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UbFlNGzB; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuS4++MU8wJ/7DDJabDFpH0LAR5puEG4L6ekoSjzYg/LBey+kDq8TTRdRjk0FuraCk1eQUERhyBy2hNlFm7wzLPY4xU5VhAAb9MMz3N2wX+c/CqtklMEdISLl8MzWNY6G5SQL8vTGPhl9pmQtTycaPrkAvkND+yjacMh3hGIxFY2SQDCQcXZZqPv0bKHjUzrK+cw3mCPXK+4QyFyye+dI7B9FwHDQc/hkxh3PKGUPy/uGossNu9k0PkuMTazpjQUZGkXLzcn4gbGHeRtTnOeWxiQ5ZVLulvcvDOepBCQlm5+qmg9CNYneK/gnjiWkbGwgngKfKoceF3y+/gYDSKFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9EOqbvhI4FeOandDz6h30TgayF2faM5fR6pb5la3Gk=;
 b=oAFUlxJKkvlwAzc8FVBVrscRd26fz8l5pDCj/dmKKrio4b7E1voGe/ofSqZxoq5dCxQnNebGY171hNnaPjrq0GLqua7emE/qgx30iIni+7udWIO5pEvq/j/HcnlZ+zbY7nRhBfWsZfYvpD01E/B9cQrnquAlTr9C74HIpdj58MUa50W+1+nTJ4qNOel/7YKoPXzOb8hAF/LihqGghX0g1Fgw4rg6Qw/8TQOxxb+kZ8Hyv5w05kPN/XSKqqHAL9OzzoxaQ2U4iKV458fN9MuytzsaTXqk0tS+iUA4Lb8820pN/5gtwEVIWGj3fMBWYZrdIilZ9t8Ju04RaXq+p71yfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9EOqbvhI4FeOandDz6h30TgayF2faM5fR6pb5la3Gk=;
 b=UbFlNGzBMseumaOmlBqqOY18NpPqakAHd6giqw9xkm2hg68F4DFF3W0X71thpHFXv84mk2A09YDrO1nn/qP30qkmxMA2mDZK97x5rdGHtI/LuaINQk54O2JcOPMQgKxWJ0pw3fzfUBXno+3YHmhU/JiuStFxoe6FPmoiz5AV7G4=
Received: from MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::29)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:13 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::73) by MW4P222CA0024.outlook.office365.com
 (2603:10b6:303:114::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:13 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:10 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 04/34] x86/bugs: Restructure taa mitigation
Date: Thu, 12 Sep 2024 14:08:27 -0500
Message-ID: <20240912190857.235849-5-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: ef58381f-fb88-4013-f114-08dcd35e63da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uncFFsOgiLJ6ABjuURvjzTKhjmYDJ8bulyI6glzRQhqOSIl/CYKDpYivut49?=
 =?us-ascii?Q?q0Bmn7mjFy0tPVCW3nuQqhRDMsiXN+BlepZQWbVlcQ8G7JFhaJStCJ8tiJJU?=
 =?us-ascii?Q?6QSCfYiek46F05th41DP1oDm1pUCjMcDj5XypjB327iUnK+55IgujOsJXt6G?=
 =?us-ascii?Q?2uZDIgfW0E/N09haoSVzYjz+4NblhVzvJJIMFdKn7/yVMi37+3GVpKjx0cJt?=
 =?us-ascii?Q?kXD8fKITWbBtBliA65rLf2rvJQZR2jGHhR6msEGmBhiRiBr1oF5x0lBMHbri?=
 =?us-ascii?Q?VFc4GTKG5Six7YpVFOg7NR2H6yx+tiebhJPzyqbCmLx/F5cNjbY90W9pLEf6?=
 =?us-ascii?Q?93duyHA0V8RGPuIDFCnCBQtbSlhdfOXQEHIKgwXv2RT09VGbz9sW33nhBtxp?=
 =?us-ascii?Q?Mzs6Uww95LrUzVTX3mt83VrRbuC7m3ORe8ERacQvc2Wd53juR1q6WvGFmtWz?=
 =?us-ascii?Q?3QCDQi55Lf9oUJ6QkMf631oKnPHbKDRioN0uWoKuigMvhI1NOBdEjDNgY9RI?=
 =?us-ascii?Q?e8cdmK9eg1P0Hp7+BtpP7cKMk3MNb3vj2696/Zf/YZW3DHeXXivD9qxw177Q?=
 =?us-ascii?Q?L4hfF6ZQ3Mn7TyESnr9pv478GtV18If+A70KZCmVPl+IYm/eRXiAg25mqU0m?=
 =?us-ascii?Q?IEdSWzmiTaIuAK7NDXozyoQebcj+sqeSm0S30Y1TxcIgRhnFSX2SbKHvegIc?=
 =?us-ascii?Q?ISa+HS+f+MSFb2MS9wsU8FD6+0QHMMGvwSxDMIu6pbk5l3pl1oAzw7TwllJX?=
 =?us-ascii?Q?ZSXA+pkwlsIgJRVAtzFFyTCzd5NjDHsfZvDgtHHiTZUgtSIjBKglEDw6laJi?=
 =?us-ascii?Q?t+Do3VUYJH8aOsOU8rKKucx5GkEPAZxLed46rH60s8vU2hwBdCDglZcBOe1e?=
 =?us-ascii?Q?hnOySDYH7pBQitMr4v05E+akre+HhtLUbHgqiD3PBt9p1ySePoLQwRqY0UHL?=
 =?us-ascii?Q?lu6iYdeKJ5oo6S7qRAI1mwSxxKKXf5NcLi/cz37NIiQf/TRoJLDbL1nMfih/?=
 =?us-ascii?Q?C03I7P51im0uDoXx0Z5PbGHNFmn85lcsLHwkK4CYoX+OxYBNnO1lnf9NbHK+?=
 =?us-ascii?Q?B55M665j98xnQXIJxKt61xYOzHyzn7T5CO5tYp65Fcm+g7EaKDrfagtN3bvr?=
 =?us-ascii?Q?/BmDQEXLuLB+Hxvotdy7EwxAbMXLHyGCuCW4NWJtmtMJhVOIOygZC8iYBWt7?=
 =?us-ascii?Q?wWzyk8e8hw21dRiD9yEHz8seM0g3noXXcU9J/K7ZkXM3hVAEWW2ktyEfsW3P?=
 =?us-ascii?Q?AhlPRwZhxnOoUdmfcMx60jDGpWwuR9Fd47noMZWaDTLs1aasNzNuGbK2xrr7?=
 =?us-ascii?Q?Nq4pdL7SYPA/G3ZFy9TjVqtcGPyJb9lomm2RAyh9jw0AicNVHCYcoO3YrFy7?=
 =?us-ascii?Q?T0Fv1nhj7Qwr+YuNPhn25CvSsDRJOsDlqdsZ4ryWLLtu4WQYQRZLNfPmod/e?=
 =?us-ascii?Q?nT1kqS/cHzbMXmF6+uhKMy6+ZChK8871?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:13.4041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef58381f-fb88-4013-f114-08dcd35e63da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

Restructure taa mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 56 +++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0bdd4e5b8fc1..3c0a0890d382 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,8 @@ static void __init mds_apply_mitigation(void);
 static void __init md_clear_update_mitigation(void);
 static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
+static void __init taa_update_mitigation(void);
+static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
@@ -187,6 +189,7 @@ void __init cpu_select_mitigations(void)
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
 	mds_select_mitigation();
+	taa_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -203,8 +206,10 @@ void __init cpu_select_mitigations(void)
 	 * choices.
 	 */
 	mds_update_mitigation();
+	taa_update_mitigation();
 
 	mds_apply_mitigation();
+	taa_apply_mitigation();
 }
 
 /*
@@ -369,9 +374,6 @@ static int __init mds_cmdline(char *str)
 }
 early_param("mds", mds_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"TAA: " fmt
-
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -402,11 +404,13 @@ static void __init taa_select_mitigation(void)
 	/*
 	 * TAA mitigation via VERW is turned off if both
 	 * tsx_async_abort=off and mds=off are specified.
+	 *
+	 * mds mitigation will be checked in taa_update_mitigation()
 	 */
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    mds_mitigation == MDS_MITIGATION_OFF)
+	if (taa_mitigation == TAA_MITIGATION_OFF)
 		return;
 
+	/* This handles the AUTO case. */
 	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
 		taa_mitigation = TAA_MITIGATION_VERW;
 	else
@@ -425,17 +429,38 @@ static void __init taa_select_mitigation(void)
 	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
-	/*
-	 * TSX is enabled, select alternate mitigation for TAA which is
-	 * the same as MDS. Enable MDS static branch to clear CPU buffers.
-	 *
-	 * For guests that can't determine whether the correct microcode is
-	 * present on host, enable the mitigation for UCODE_NEEDED as well.
-	 */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+}
+
+static void __init taa_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_TAA))
+		return;
+
+	if (mds_mitigation != MDS_MITIGATION_OFF ||
+	    mmio_mitigation != MMIO_MITIGATION_OFF ||
+	    rfds_mitigation != RFDS_MITIGATION_OFF)
+		taa_mitigation = TAA_MITIGATION_VERW;
+
+	pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
+}
+
+static void __init taa_apply_mitigation(void)
+{
+	if (taa_mitigation == TAA_MITIGATION_VERW ||
+	    taa_mitigation == TAA_MITIGATION_UCODE_NEEDED) {
+		/*
+		 * TSX is enabled, select alternate mitigation for TAA which is
+		 * the same as MDS. Enable MDS static branch to clear CPU buffers.
+		 *
+		 * For guests that can't determine whether the correct microcode is
+		 * present on host, enable the mitigation for UCODE_NEEDED as well.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+			cpu_smt_disable(false);
+	}
 
-	if (taa_nosmt || cpu_mitigations_auto_nosmt())
-		cpu_smt_disable(false);
 }
 
 static int __init tsx_async_abort_parse_cmdline(char *str)
@@ -641,7 +666,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
 
-- 
2.34.1


