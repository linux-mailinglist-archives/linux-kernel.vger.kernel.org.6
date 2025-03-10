Return-Path: <linux-kernel+bounces-554689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355B0A59B52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7868A188622B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843E23716B;
	Mon, 10 Mar 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wFwD/QCZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAA236A74
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624855; cv=fail; b=ON1tu5621iMMa2yETvk4FatziFgxEQgM6ak9+oKrlecH2bQS6W/xELq8f+Ttmax9ga+vAXx4NxgdW540ThAwQC3jW4/uwzs2SmsP7VumE53BGgRuDNmIQ3nKZWkcpe34ML1eNifacN6UzgH6tiQbOpIrR3LkKx2I14xPQrxFxhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624855; c=relaxed/simple;
	bh=/3YMrsYXFPvo9gUBWuPtdtDKY8Z8dYm4F+B4RUAScPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMigT4w6u48NaGLRMXfTYiWYG0Pfm1u/x3NWDnf1xmIgNHdBtB1wyGiVmfLY9ocQTPbh259FNq5dP8ifziBBGVqK2Ar2aArwEqcFUn6s+fk1sOtdt4SZmlgTEQ/qWxo8WbW7Gy1ZP6wI/kRctGiR2J8bKLIvsFv0DVoPid0O2i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wFwD/QCZ; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOUBJZYNzwLfYDdS8d5zYC+KQtju/3+BebNL8RQEHngxC8CaQuHpzWzfY1Ar9He/ZDbp+Fy9+FbnN+0Qg0r9wjI+Ihl6K6el4physiRYyHHbUiAgHO7K4HvUJe4HF1TDkImDzSSSQoa5uof3akAputYSnMG3keEBBTBHm9HesyRu4+TnQGtnH2QKeWaiFEkiYGGZttm88sg0c2VIRa188CanYVTn7yuttRWkkME/BrIyk5Y8Lz68q7ag6ljc8d2iQAcl0sPVO4ubxQwW7mZaoQxqWaZa8+j8xVhrvwA5TR1p3JGnnQfZ0AIplfJNt5gJNFOZGYGNYSBk0wG4OJk+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGaPLSrwlTZrpOxd2lUJppwe8HyLp2KuMg/kifGa1jg=;
 b=de59ABDaqw1xnq/Fl4z/g8gUy+mm+jJ4tQaCllLvEA2KIRAn9nEMqzmi4goKCdgd5TQql9utCQQ3CNGIfXHg8UWslq4gc95sL0QjI0Nry0szJX4kOJ2psffA7hS6sKABTAYhJhqk8X40qm3NItqcm0CMN6gv6s14iub/rU5NZ3flQ3EMtotDEhNbMGOtbtyK8PtucCqttINvA4xCzdj3+uvqHYk9IXNep2nnRQJaLCz0Am9xT3b8/KKclR0cXuJWBoJujfGUcR7cbGJnVCC7JEz03CMfQjWDL7KW42unEifs4tfv3a+ipSXuclyyVX9Hm+ipS+hzpkpFwHh0bzpVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGaPLSrwlTZrpOxd2lUJppwe8HyLp2KuMg/kifGa1jg=;
 b=wFwD/QCZ4x5qIJqm6IDlrimtAq9I9aNto9l4u/rhkPrygdMXCJ+g5MBwj7F3dulIYIV6yQ3BA1yJoIaREHMK5+uBySzCdh6Q9MCxR1MxXBPbWIV3Y0CsSBZ5AdNF5tJFMMSIZChmUmLJZQhrH39QyFwrndPZefSKsLYiF6pvWzc=
Received: from BN9PR03CA0782.namprd03.prod.outlook.com (2603:10b6:408:13f::7)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:49 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::2a) by BN9PR03CA0782.outlook.office365.com
 (2603:10b6:408:13f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:49 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:47 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 14/36] x86/bugs: Restructure ssb mitigation
Date: Mon, 10 Mar 2025 11:40:01 -0500
Message-ID: <20250310164023.779191-15-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 135816dd-3d15-4bd0-4de3-08dd5ff2506d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Or3/jHcm+qwaNys0fM42TkzPGbZ+n//CuSJcn/5xeRvw5GBkeH2Tf4yd2RE7?=
 =?us-ascii?Q?3K26L2C7+QNDWkILrnNP48YmipjGds8b1BqXWyc/EPH+Tebjg4+kaSg6VCe6?=
 =?us-ascii?Q?Pbk4o3eXxLOT89SBmFLJcowH0okEythG0Q3yMD+HqzKFp7iTVKgiVx4TMLi8?=
 =?us-ascii?Q?W2pmbtsizdZIF0gxm74+yCIr9uQ/3j94OrDUefEd4KfigQPFamAcuYc8s+Q4?=
 =?us-ascii?Q?KAk0KZLEEoqko3yP47Zd96ihIsXiMGzD9lRnMxHRL9tA/22oRF0JuxFxlPD/?=
 =?us-ascii?Q?YbcnxdWmujXpPMGAIgsFNkiNKAdUUDHuHJqvgDCddCXcsmsK0hvIFNl2BcAc?=
 =?us-ascii?Q?Uzt98Uhv4b7jX12j27I7yhX0cKhUnaHpRggJeU6zW4g2LHc2uxzSNvY9luib?=
 =?us-ascii?Q?ZbQtAw3VC7eOzXmQwnt3dzVS7YLrsnYtUqZH+Az3EIx1jBhAAdV/mm7uabZ2?=
 =?us-ascii?Q?mmPoazT7ioMontfxEQZdUy/1aL7Xl39K/uOH/SuccupJtfi+HwDiFz3/Bi0W?=
 =?us-ascii?Q?RYHN8/wparHopErXKkUDw0eiRuokJTknIwaimBFRJ5gRO2dfVzcQKjPJdADC?=
 =?us-ascii?Q?PRLANtNtIeZNzaTVDqvGcg04v7dXA3UEQAOAW9d7EVxpuZURmt5DZC4ZgAGE?=
 =?us-ascii?Q?4Ex/V34TmpWScNERWWT8ndzpD67qHvVEZlFzzvc+O4VggiubzcmhNVA1SSYo?=
 =?us-ascii?Q?/qf/rN+/bXMm1JMx+LjYPHPCBnwtkLNYJomVFoYhq+gwh0mkEN6ExJcN4eIs?=
 =?us-ascii?Q?3CgjyXQ0yxsv83TwQeaQSuIKEl9EYpz9QKGjCJBPQRd7qYYxvCnAeIdtKOiO?=
 =?us-ascii?Q?VdAK0dNAI/BVntpbZlFL1V8M1B4IflgreTItuIRoRd2fKTTvQXeCmce1uYJp?=
 =?us-ascii?Q?uK+T5l+S16v8qpEx1v6eUY50sUuqzjucKpRkHM90/io1z9FD51RGEGm6X6Ji?=
 =?us-ascii?Q?QMCEIOd3BTjhIEcwta/IsPfseQkC4inC9yYb7oKRGbqmNqwG2DmqUz+mGtej?=
 =?us-ascii?Q?AKmqB7Xbg1KegX0NGiv0RaNrH5p21bApRoWfE034Ln+WCusfNtJx3xz2L9Sf?=
 =?us-ascii?Q?xbUunZiZhHS1hdCvrzGTNamEHg2VKqXZE5yUdXLBI4GtizhfDnhA2jilNGxh?=
 =?us-ascii?Q?wINc1r3GqbeK+/qgNLVin7TAmNHsV/1icamcJgiB9szC66LLWWIptO2VvaMC?=
 =?us-ascii?Q?knvK80bZ9FZOPgOXbm/mMgUJ0eDwgvOUt2OwAGuzW/pqveXKFllPiSI4i6/P?=
 =?us-ascii?Q?L4t9fO3FxOApkbRUHrCqTiR2TaKJJyglrALPXqDFnRiWTF8tTdGSQyxhSzxB?=
 =?us-ascii?Q?2kGN95S+cgeQgz16i2f6vnB8zJJVedhZcuO0SmtejKOenI18+7rlQsGyPJGw?=
 =?us-ascii?Q?mlNFEt2VAEWWckMRdXz7pEelxgr99teCelVAfBpLO8wjD+kl4yHsKq3f2ZaD?=
 =?us-ascii?Q?k9WUzljg2SrTbcN3ibH/5DIfns5ekks4Yh2cZddPPjabF9Khpv6MBsjfBnpt?=
 =?us-ascii?Q?g6tnARKQbieRGlM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:49.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135816dd-3d15-4bd0-4de3-08dd5ff2506d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

Restructure ssb to use select/apply functions to create consistent
vulnerability handling.

Remove __ssb_select_mitigation() and split the functionality between the
select/apply functions.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b4a72ddf159c..1d77747e0f74 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,7 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init spectre_v2_user_update_mitigation(void);
 static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
+static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
@@ -232,6 +233,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
+	ssb_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2235,19 +2237,18 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	return cmd;
 }
 
-static enum ssb_mitigation __init __ssb_select_mitigation(void)
+static void ssb_select_mitigation(void)
 {
-	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_SSBD))
-		return mode;
+		goto out;
 
 	cmd = ssb_parse_cmdline();
 	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
 	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
 	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
-		return mode;
+		return;
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_SECCOMP:
@@ -2256,28 +2257,35 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * enabled.
 		 */
 		if (IS_ENABLED(CONFIG_SECCOMP))
-			mode = SPEC_STORE_BYPASS_SECCOMP;
+			ssb_mode = SPEC_STORE_BYPASS_SECCOMP;
 		else
-			mode = SPEC_STORE_BYPASS_PRCTL;
+			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
-		mode = SPEC_STORE_BYPASS_DISABLE;
+		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
 	case SPEC_STORE_BYPASS_CMD_AUTO:
 	case SPEC_STORE_BYPASS_CMD_PRCTL:
-		mode = SPEC_STORE_BYPASS_PRCTL;
+		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_NONE:
 		break;
 	}
 
+out:
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+static void __init ssb_apply_mitigation(void)
+{
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
 	 *  - X86_FEATURE_SSBD - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
-	if (mode == SPEC_STORE_BYPASS_DISABLE) {
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
@@ -2291,16 +2299,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 			update_spec_ctrl(x86_spec_ctrl_base);
 		}
 	}
-
-	return mode;
-}
-
-static void ssb_select_mitigation(void)
-{
-	ssb_mode = __ssb_select_mitigation();
-
-	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
 #undef pr_fmt
-- 
2.34.1


