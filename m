Return-Path: <linux-kernel+bounces-397207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBD9BD7ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9710C2841CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B545217675;
	Tue,  5 Nov 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BmurYv3U"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C22170CE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843740; cv=fail; b=K8e2udT6AfWPhucRfUuxqxCS+8uG4KzSe+lEFWezM/MiC3DsSw13ni0oddJApZBrMOI9p7qLFVuuBw4M1HhdxoVkLlOPgWiwR9hfGFbdYbRmX1Z4xxFE5Uc9nJD5gnQJm1mCxG2Ia8Xp0rdBanZhqsGazEz7SG21rgkGV1VZFLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843740; c=relaxed/simple;
	bh=Q0TVtakTOeZNHp+Y5aZ7E7a+J6uQpARB2DRD9kidytQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXYHKi3812AZeAodAAeF7BfjA5lrO0w2axmoufGox8vhW7gqebFJZXiqnsjWgUNib/4vnaKyVgNxi9yhR8jxMSGnpybxU2ojC14qAvwJsyBT91W2ENhf+2QSOfh4biZop6xIQ0fQEWyeJBzGq8YKpU0hoP9E2CqWgIwCpGFPgaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BmurYv3U; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ho6t63QMZLmnITWJKehcEHxQukn3+meQtPHtb+VQwMapw4FZCTEZMhGJUqdaYR/eXzQYQ9L5UeDJS0nGsH95TIAKi74wZV9ZnPHx225tCz00XmI+vRM+i5D5EkvdKnS00cdBE1BmgowhkqLriAdgRA/z/Rn88Ix7FdNTs/ZIXTSpuBV6dt7MosYsSsnkw/ZzkK7H3kQJQv/UYeEzhsZPt4Xj3HyYGNkWI/+ywVZ1IpLyu7oyeUs+flIDsz+xz2r5bbRLUGhlqHSa44PLd9wpnbamZuzc7ddEdpTqFql5FhIGN5mxPOneJ69DUBwxcBs0cp8AjcF9lIfPE56U5U3e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKKNqIHpsxjZxJ3iuU7qBcRJ70trhqSv73qS24qwBUg=;
 b=OclMR7X8JbL86Dk7CNTIcorKgGQ47dehpEl7i618XG7h3dab0FaIvEWg1Qva0omUH6EfSB16+OFhxJlbzqchCrJbbE8Ry14VPcVGHv6O9NLnFtPF922x3066a6OfBrSnAGqVB+y3TF8/T3Ozw3E6GRbH3U2SSGRLR9mg3Jw6xdq0Or6POakWuyGlzYZ8Bz+WX1wFVQc3ryho/JrWBKB4VPQ+wuN1BP9Rnvd5Zud0Hj5AHmYHLpLpnwPVlG+IUnlJVaeEWz9SMstgUo3ABHsdXos/Dp08EthyKx6/M6FL9DPDqYDFP/oNmQqphha1Efd4NT1Zwl8oo2jxqFTYEcaF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKKNqIHpsxjZxJ3iuU7qBcRJ70trhqSv73qS24qwBUg=;
 b=BmurYv3U/S9JQjxeAOQBPhqQ2C1csnNq6SiibEW1eM6elvn8T4y5CW/7kBCorBZ5n4ioPAvCNfMuM6rZ7VqQFcWwdaAeu9DU65kvb3ePRTxix7jRgOwnldWavahtIl/GCzpu+jsPadZsNz34jr/ZQBcuK7DAK/aOUjADfQZgfx8=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:28 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::ce) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:28 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:26 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/35] x86/bugs: Restructure gds mitigation
Date: Tue, 5 Nov 2024 15:54:30 -0600
Message-ID: <20241105215455.359471-11-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0b8c4b-f3ba-418f-8c4b-08dcfde48fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R2XfvSXDOfDqc44gJheeVWVUuZVhWhRNtDBzwuyyuKT/Tk22kYLZI7la7do/?=
 =?us-ascii?Q?msT9JplnPbCF4qSnwxsmbbxkMCdNUw+lUPHYBkFfVx4BUwCVlBIBRuP7exaX?=
 =?us-ascii?Q?DuFJeFLkVlGq8BtxZZ5ABPEa+ukpn/kRaviVFwILN2TmUcZUVZVXZX7urNiw?=
 =?us-ascii?Q?tZtD1M8/0QA8c5/fO+pNkmUf+Hpv25f2CYzcrt2aDxyHWqU2of+3orBWlPoo?=
 =?us-ascii?Q?I6P5dtC/GAUQzufKBSTndH+93ipLDI5w2kFVfWtKf3qgoxulAmjMthoILzGq?=
 =?us-ascii?Q?5NgLAfcLg9QX5xx5V2uWkSdNHBv/Bh8CYAqCRaS3bljzl3LemGwSgRU9s0LT?=
 =?us-ascii?Q?AekLkTnq5pGWFor7CjipghDM8qJZ6JlLmvgNeBr2UI7AF0iot1LTd9lfDlsp?=
 =?us-ascii?Q?CiE8SAd6Mb4mCWq8A8Msj0DUfcY9GKIC51lkoXyHDfb6DUkamVagpv1upVUQ?=
 =?us-ascii?Q?vN3H0VttLeaIwTVeC4J8kiGhYmNcLuoqmpCKxksWXZn7ASxnWekNXrzu5EeJ?=
 =?us-ascii?Q?6DBmpXZdJKvUdoW25VvnfBN+5Kpw6vIuNEbHMbS3GFidNtjg0WCfUwlwUfkV?=
 =?us-ascii?Q?4O7I1+IwE6RrFM+jJCw9c/gXew9ChLBrIorg0LyI5Dy+BdvNDYk1JcSK80Ab?=
 =?us-ascii?Q?c9ROB8Wr/Mufs/zd+xCU+0D/vKYarc4CqLxJeUcc6eij+AD1V6+/6SiWwm92?=
 =?us-ascii?Q?e89eGY3RxOCtNUWgJLFshVo+beXZzUejbIMtyB26R+l/GmPFYjBIteVzubSu?=
 =?us-ascii?Q?IfdRx3EAlg2yCD3C1/pBLXaTkL+tngQ6Reb08y26XJfMLuOeXQTV0CkSyOAj?=
 =?us-ascii?Q?XFNabBg36rT13dGaYlShXtf2x7CvEeYy2LZmB1NPt0KNfoiGop8kKajS2aOo?=
 =?us-ascii?Q?0OjcPQy9KJ3US8KOw1E/GpTwFYGRsfGK7kBjyUPIOnu6b4CX47qNGd0qrzKc?=
 =?us-ascii?Q?V703bW506h37sPTnwwpTMJEZ75Gd7LiNS/ubEozauL1szz0QP8Jh+s2COlDp?=
 =?us-ascii?Q?vIyXMktnmJ2y8nBUpXgWKT1ZVcOYBmCt3dPSc4JaH015NGlsp1hjRAq2h1df?=
 =?us-ascii?Q?wlQwKMICPCC0xLatYpRXZVyla5PDnuIAKS3dmxK4pEgpfdPD/fswQrXmqdud?=
 =?us-ascii?Q?JRQWE2TF6WfbeEk0vS+2GzVPbAwCqkcpxiTO65G09LB7p1Fgdr7uxL7laKMA?=
 =?us-ascii?Q?ICEdmyQUK6UV1x3T8vijQTQArxPiAUIRLGd6ZbGOTXTZuvKiIgOficpyQmFL?=
 =?us-ascii?Q?7rz+fDAtt0LejxAhXeiBONTK4+PuAnBJDxxY/19SrPl0gR49yIUPdVcAysnG?=
 =?us-ascii?Q?Sc5DGDNBuzql9PQdK/nC4hZ015keRFCgACuN1EW5t3ZTLLPAS1op0zFx2uzU?=
 =?us-ascii?Q?XU6NOPTZuUqClhx+XCFP9A+Lnd/sM9XHM+4lS6+xok3Tuebjdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:28.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b8c4b-f3ba-418f-8c4b-08dcfde48fd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

Restructure gds mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for gds.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 452aa5994aac..37056bdd3a9b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -76,6 +76,7 @@ static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
+static void __init gds_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -220,6 +221,7 @@ void __init cpu_select_mitigations(void)
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
+	gds_apply_mitigation();
 }
 
 /*
@@ -801,6 +803,7 @@ early_param("l1d_flush", l1d_flush_parse_cmdline);
 
 enum gds_mitigations {
 	GDS_MITIGATION_OFF,
+	GDS_MITIGATION_AUTO,
 	GDS_MITIGATION_UCODE_NEEDED,
 	GDS_MITIGATION_FORCE,
 	GDS_MITIGATION_FULL,
@@ -809,7 +812,7 @@ enum gds_mitigations {
 };
 
 static enum gds_mitigations gds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_FULL : GDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_GDS) ? GDS_MITIGATION_AUTO : GDS_MITIGATION_OFF;
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",
@@ -850,6 +853,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_FORCE:
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
+	case GDS_MITIGATION_AUTO:
 		return;
 	}
 
@@ -873,13 +877,16 @@ static void __init gds_select_mitigation(void)
 
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
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
@@ -892,7 +899,7 @@ static void __init gds_select_mitigation(void)
 		} else {
 			gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
 		}
-		goto out;
+		return;
 	}
 
 	/* Microcode has mitigation, use it */
@@ -914,8 +921,14 @@ static void __init gds_select_mitigation(void)
 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
 	}
 
+}
+
+static void __init gds_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_GDS))
+		return;
+
 	update_gds_msr();
-out:
 	pr_info("%s\n", gds_strings[gds_mitigation]);
 }
 
-- 
2.34.1


