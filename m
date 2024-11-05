Return-Path: <linux-kernel+bounces-397198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E449BD7E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899851F2470C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85CA216E1C;
	Tue,  5 Nov 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dje8/i2N"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FA216A02
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843733; cv=fail; b=uWMf3JBVLb6Q3w/t4wzsxJF7/IW18hdHvupoc2MtiHiLc7Dfc7SU5jWOs03Xa9cLZUQbRVmuWVjjJNPw4O4ArQYocPLOeX6wKOU5B8tnq2V147e7CINkSUQgxjn4ID6TnUsSpaT9JU3bycxnlmAxu4qCGxOde6+iUymIwZMmF5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843733; c=relaxed/simple;
	bh=eF2qGs/x5mPS6vMvQ++RYnUyl+EGpL2+dCo6UC0rP8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhULwk39wEXpZTeArji7pV0bpjhV0yBu7/k4VGg450Oc3sGFpLK8C9c6vcKIkKMtfX/ZNp6w6gBuzsAu2kycGef9JuHbkGyP5lEOzErKI5eGtQEd2HRPWpp93metUqBF7LmHOY5Emc8hCSsuZq474cdv3C2blrNdklPNqpPNZHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dje8/i2N; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsJygN92ZHW0FjPa0cTFA8aVCWxS8TqBBB8Hk2MQbFUx3p2EaGSCQlTcb3E88LHeZCl6OcrVTAVdOLk6mI2w4iNoMHviFk78hBpYcLamsRhlQS2G+5/tvDmLOr0zPSnVA54ThxsqbnbJk7MyPfAFnkxZe4ydjc+AKYALGU5ZMCjhsm4kN9fxXW4bSKttIcM1YoIe0Us0HsiVgpf5ZwcfzitBP69Eg5wBHTfuK+Up0BBQGsFFnOjLzNiXzB3FYC7H7qfWKkYpUkXh0BjhoGA2e2vqB7AIfc8RfKubX6GwjNudodrYGXBsCJMXIwZoSKjrgz4kmB51ywTPcdU9dD0saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfrtubeXU+x14zoauGuZY8QL4fmLcZGrL5yDSr7sTME=;
 b=OSvEW9ZjZQSZ0nZuMNSvWiu4CKY96mXHchYctWztNV6oAbM//D6CJ6Y6i/pNuGc2ZfwbY93VQD79z6heNU5LM8c/vVho+0hDgmVMQN3p3oJf7EPM32eBYUgjHbKQS1aCac8wlP6xgrPIWK3r9rzhyB7cgQL2v71uWXHdWx+FzWc/aBC8A9cvV0DREXHe7T0+ItU20CwG3swlSW1galGO/QWKBGW+i/+EkCCHipQiOmFmi7APftDOyK+6RSplotKWs1oM5a56psuofA1jupyGETDqzW+IO9+/hWYVndzhv/Ftgs7UUb9TxYxyl2hYaTbzyddUmF9JtW5JKGp/BLF/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfrtubeXU+x14zoauGuZY8QL4fmLcZGrL5yDSr7sTME=;
 b=dje8/i2NynHm4mobt49MdwReT2WaLvZE8FFyL/SZ0vMRwkal124k9nVLJKT9QUDSSK4HEUO0ujqPexpbZEwI9hsaqX9TIshxBCqOIS67sUqQsgbP8IzqyMyylu4EUbGC98LKns4WfPtJmc0xEbz0uDzUEHtBYX5gS8PGQnff8FE=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 21:55:25 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::70) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:25 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:23 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/35] x86/bugs: Restructure taa mitigation
Date: Tue, 5 Nov 2024 15:54:25 -0600
Message-ID: <20241105215455.359471-6-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 88da9bd6-d179-44b8-78ed-08dcfde48e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D44NXf/dnkpI9HMPBGXwKhyN918kMQe8joEbVJbj5yhWw48qx7RayWoulmx3?=
 =?us-ascii?Q?sDwWaZ7HJZF1CZCWsFbY6UETyAn5rDSjFoRRHyKMaiC9bYznznAZROdKWCsg?=
 =?us-ascii?Q?haXa35AZIuKY7YLTm/JoP1j1dbVR5/LUgDwpd4hhLIbF1i/1g7EAhHUeNONG?=
 =?us-ascii?Q?YaQg+j6YJVLmkLEnuZskJv0+glVce2pf4qrGhwLugYXD+UsJyuSo2tHDpLZV?=
 =?us-ascii?Q?VOzBhGOWo89mSH97rexcdsL/bdmV6z9tPZzz/o1ob3qWb921Qe5VrWgUcQRs?=
 =?us-ascii?Q?yIyY8S6rIeotlgxi2UHT9znmyb2b/mWLAyzpYLamAhzeHp+jV567xD0kkPA9?=
 =?us-ascii?Q?zUpKsLlp2qs6lq0g7EJOJQbE3jydGVwjqf4/Zqz9HmO+HHyzRxutP2W8f/xd?=
 =?us-ascii?Q?tzgnLxmBIDf3YHU9SQZbAq175LOluEU5dokFsZS5pKY+BVdmuLQKFVdkEm4o?=
 =?us-ascii?Q?XWHo5LwbO39QfKiTZtOOojWUUv2RXCmk8jaFwgGXraKbbl2280XAwe7V6Oj8?=
 =?us-ascii?Q?Nz7UMWVLqQ8/tbvIjWMrP+Lr078qhCA7NfPy5ofEf6955Vpot5assG6UW7p/?=
 =?us-ascii?Q?wpkVGPDtGRNouU4Qv5mwZlRmKMgD48LoJOWhLwoYcfp0dpe9xC4Z+WT4iDkZ?=
 =?us-ascii?Q?PYKSO0Sib2B56PsZbQDZnKdEXqddnwoA0PeYQUqQfENTD4hYv29xrztCYch7?=
 =?us-ascii?Q?UR+UoFXZMmAoRDs6OeC3EAH69MPS+BE7I7+gRldAIQFBxryInOdsdMEbujxh?=
 =?us-ascii?Q?gOZG5tJaQlkbJORbvVB54r0OfC6Nm1zWul7BMmbAnax/aVeCZDz0oqh5yFxe?=
 =?us-ascii?Q?a2XWVrOyF04xCCULhI0IYZMx7kb2zYfyDwhXqmrXbiVwn4oYbIUC0sKMOyUL?=
 =?us-ascii?Q?yMp5OG5ECYDbktnGVICnDM6KboaQppjoKiwiGQymhonbG8l7HnyifHub5Zs0?=
 =?us-ascii?Q?od+Y8DOdPiWgp+LD3LSMcAdQNhwvKEetp0+qRd746CXPP0JN5acxLRbvZPZ5?=
 =?us-ascii?Q?SLPmSiRiJQRCGWUKpDdrgZo4JPijXUp+6e1pZnrXG+NjFnUi/4Oy+85gVp7v?=
 =?us-ascii?Q?ZCu/PMbyM+V4XLWLldoZlvl6JgHgwFuSDoqRV7n6hvs4FGRo8BLuT/rHvXWj?=
 =?us-ascii?Q?IOnc50xu4/IzUPaSTyuQEkXZuxoTraADWAKxzI2levULitX7VUd1/IURsNMw?=
 =?us-ascii?Q?szOAXn1IbG/YaTCy744SxqXnZAqlBhS0wwTiQUS3pulkt/4lQfb0WC/sRlrA?=
 =?us-ascii?Q?QNVucerefNv3w5SCX8Q4fitNGfs3E23ltuhv/PI5dIsJqZjn1lsuWijvWw0N?=
 =?us-ascii?Q?nXYDbrNBGe+XoQkozlU61x7Zdc+/zfWS3CWENCTtvLBOp8Ehaaml/Pj1qtWr?=
 =?us-ascii?Q?fNp2bvDFQDqr0o1NpFQgxq8fijeRsKN05pIcjSm7bVN3KkvR6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:25.7809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88da9bd6-d179-44b8-78ed-08dcfde48e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

Restructure taa mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 58 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4f35dcd9dee8..c676804dfd84 100644
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
@@ -374,9 +379,6 @@ static int __init mds_cmdline(char *str)
 }
 early_param("mds", mds_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"TAA: " fmt
-
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -399,19 +401,19 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
+	if (cpu_mitigations_off())
 		taa_mitigation = TAA_MITIGATION_OFF;
-		return;
-	}
 
 	/*
 	 * TAA mitigation via VERW is turned off if both
 	 * tsx_async_abort=off and mds=off are specified.
+	 *
+	 * MDS mitigation will be checked in taa_update_mitigation().
 	 */
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    mds_mitigation == MDS_MITIGATION_OFF)
+	if (taa_mitigation == TAA_MITIGATION_OFF)
 		return;
 
+	/* This handles the AUTO case. */
 	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
 		taa_mitigation = TAA_MITIGATION_VERW;
 	else
@@ -430,17 +432,36 @@ static void __init taa_select_mitigation(void)
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
+	if (mitigate_any_verw())
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
@@ -649,7 +670,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
 
-- 
2.34.1


