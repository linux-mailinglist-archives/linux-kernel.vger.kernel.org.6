Return-Path: <linux-kernel+bounces-385698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265569B3A83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB49B28315F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42711DF96A;
	Mon, 28 Oct 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="giNTYuxn"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FC18FC74
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144025; cv=fail; b=utbImlTnyn9iLATWXfssHMYky3CgX2z6H1zyb1yBeKfI/Sc4IV6NKOUNMr46Rcb0h/+9ssyv5C3HIWiRccVWHheduNgqtxomVuxuySjLpXFwhkfavapGsRgDLrg1CL2IyPb90OYcI5IuKjBNigLX9SSOsKCO7VcEOEz+6yga6oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144025; c=relaxed/simple;
	bh=vG26Fg5VphVZ1N6SrAKhXMhv3mbFduHpoxa/W3EuSjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krFEwYNV5zgZkXub+LfUln0FZGJVxUNNdpPq9v3be3vZxTNW498YjMenWD24frPos6EDnQP3FoTUpaJEZY3KybJmp7AmM+8wxAzKjIOhpmgG5tmqioyct4Gew9OWY9IZ1g2prWJO1QvyFdLVJRV92DNX+H+crJ6R7IGIVGMyLCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=giNTYuxn; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6qKLQKeS+8ESqMZfVjInLW98nMyzkJIwkw7qztNoNgz86PVOeFR0TUTkM+hwVEyTXJS6CXfFDGMayYVUFBckYOghvPj1uSBZvVYCeOz0ellEQb0PEp0rRKEEDhxFbu5w6JN49TB/WPi9TfcgbKXzBjD68srSjMxwtJIOkLKG4+/T4KUUI53FkLlNHCqNfzftUTTlS2UJkI9EUlOnp41hiMg/XL1Z28mHaD6osP968/lYFY9KayuQRQRKcGYvzJ4wYSJjGM0HMSzUSQvcIGZumSRRDUYPG5uodehDHK0n9daThKs1WW7tZcN4gUFyZ6anJEXtg96N2iBUT3W3YElBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFICUFsDFBij6WWSTPDM71sS2G2SAGuuRSFxJQbt66o=;
 b=P9kKB8Kcs1/70bDTSTqlJ8oIdff8vm99y59hFaDzkIQyXwAMPGhJpjcxIePzSypRocVTSabk3cA3BxvYrftIxplL3JpKwoj7aAKd2NVmDmnvi5dMc3xy5Iy32kyYJWiWoZa2+fLEDqx/z31JqEZIK8Ej5BT1bRCm4hrTyM9eNLxQUEqPhQr7O4/7bYDXiW9qJaD59JT1jnhHfE4uuFJgAMn0KP3UVqAW77WXCmqRIkRU7pgnsdkFyB02ZPJLemCMeQ5izvVJC9+HBpCZR1M9ca581z5opQE1ygcbUL9pIQxp1TPi+eNYepGYeMCO9ifARqEv6Gg3QYUfaP5rAUg8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFICUFsDFBij6WWSTPDM71sS2G2SAGuuRSFxJQbt66o=;
 b=giNTYuxnw1stNfynsky5e7cLxlaGJvZDVF1yrj07qvigQDtW0ni6jxGnga34Zom73/zqANIERlliYuAOhhawo4GXdmGNAxWsV0yNMjKbaVTVH/HJ59j3k4LbQg3d96jF+y/b7gfYWIJr1D8nWo0g2ukUJyMeZ/mVOpPFj37adTc=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 19:33:36 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::42) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:33:35 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:34 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 5/8] x86/sev: Map only the RMP table entries instead of the full RMP range
Date: Mon, 28 Oct 2024 14:32:40 -0500
Message-ID: <f48b9b551abb544fb7f997b9465680637f014dec.1730143962.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730143962.git.thomas.lendacky@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de6db3c-3735-4b36-f25f-08dcf7876a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwBBrpp+YXK83m21C15V73ThqpC8RVBh18No1nsJwhRYnKEIAEbOzGxYMf/m?=
 =?us-ascii?Q?5zRdthalovzEA8HFjoBlCfct0CKI45bA1WHeKZN0Na3uUQtpeZELcg28K3/0?=
 =?us-ascii?Q?Wg0TsyJqyJZU//bh9qNFQCkQjXN9Qc/IQX/x9HHOvOgNRPVPE+//t7QURJRa?=
 =?us-ascii?Q?g47aKvBivZnrHTwcEoKsQW+5mArSc/ctHtiVY/YGOFUWI9yW3FrI8AeERhEp?=
 =?us-ascii?Q?l/Y7RCw7s7s46E7wEG6KPrzSKmwkG/DslNUMc+TQ8JxuZDaWeIWnk404f9BO?=
 =?us-ascii?Q?QlkqQ8QKe47zJEjf7/xMGYLXS/X3o8Omaoq6RwqDgEr68t/5ljxRG2gwi+Fb?=
 =?us-ascii?Q?NL/fDi8zUl0zdHvKsuYvzr7GozudtE7RAG+AvuJEJBhXiylEk7ACXciXX8pN?=
 =?us-ascii?Q?CLRY7iz1BlEGM9U4/8kgG5vnx43qkTmmtsVKkoJDKasnPzUBP1EnQUTnrIJy?=
 =?us-ascii?Q?cNCXyg+g7l7a/Ph4jd02sFE8jD23pLc+3h1cO0SlJqzdsXa39OOjeNHO4oRd?=
 =?us-ascii?Q?Oa/VtuYalx4ZE+bk1aTgQTPGGbe2x0dkHFY64WMIeAcyd82SNtBL7jtXQkUR?=
 =?us-ascii?Q?hj8nvYpQ627VTBuOj4DdyODCp7YgiYPwPq5ds216pavZ9KYBgMrAab+wpTDD?=
 =?us-ascii?Q?hwcRYo9YnODlZ1Md8yTsHuICqShy8bGZZXGEjikfl9S/W5edp7NpSoc+z7fJ?=
 =?us-ascii?Q?EOse3xw5XGcWsdnxPfANojSo6ZNtcgmv8XSgAmq/9JHgcMEKEiiHh79rLXrl?=
 =?us-ascii?Q?MqKenjMdOD1OQnvSXrjeqGEwq5tRsImgn3kDO/BYHNuy7Kayg/rvbzD37D3P?=
 =?us-ascii?Q?zV6PLdHBhljolLn/eG8vgSOEIVtx99IdJ9/Uj2O+XuXMfSM9lxZbfaX+Zf2e?=
 =?us-ascii?Q?LN13IbGXErUQj55YNWd20iym22ima6im+uQToGTgeUXof/DKsCwHgMsIsgBu?=
 =?us-ascii?Q?WBpqXPQNu/kZ3Sr633CiLQhcwNiObcdY9ad3Z43kZi/4BkNAdB1OkFmxfPyt?=
 =?us-ascii?Q?idSqUJ8xQpdb8K6R0Nn8i+c49nRugv1Gwf5jDgNlW2TurpVIyGglbe3SU9sp?=
 =?us-ascii?Q?hr2qLkkYz5u0rrJoGUuD4HL8NRaO5pdJT5kNlhSkXsgBgXylqtR8YTB0W+dW?=
 =?us-ascii?Q?J5UsuB7/Pe9Xzb8ZN73tx8UeuVAIU+F0ZoLYuY5S9wPoS/yD/99eYS7ou8LW?=
 =?us-ascii?Q?mOoQw5Q2yMV8A8w1Ku57IWBGeAHg+f8aveaPP4UVIDysgs4pr0UGDW3kjHES?=
 =?us-ascii?Q?KkJzsdSc1iK44mQTh1Rtyzfi3kmTN1wR5nNVSQp+5p6Rz0du25+GW6bgS7p+?=
 =?us-ascii?Q?FLeYeLQEcnLimLIQ1GmUK/Tf4fkYbEb2SuE5CCqFo7nSDUgpQMDngkex5Pac?=
 =?us-ascii?Q?ICVAMKSSkZWbdz+odO5xNZEbaHVOrj7fuZTzQsNcgynRsJ5WyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:35.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de6db3c-3735-4b36-f25f-08dcf7876a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

In preparation for support of a segmented RMP table, map only the RMP
table entries. The RMP bookkeeping area is only ever accessed when
first enabling SNP and does not need to remain mapped. To accomplish
this, split the initialization of the RMP bookkeeping area and the
initialization of the RMP entry area. The RMP bookkeeping area will be
mapped only while it is being initialized.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/virt/svm/sev.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0b778cf7fa3d..5871c924c0b2 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -173,6 +173,23 @@ void __init snp_fixup_e820_tables(void)
 	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
 }
 
+static bool __init init_rmptable_bookkeeping(void)
+{
+	void *bk;
+
+	bk = memremap(probed_rmp_base, RMPTABLE_CPU_BOOKKEEPING_SZ, MEMREMAP_WB);
+	if (!bk) {
+		pr_err("Failed to map RMP bookkeeping area\n");
+		return false;
+	}
+
+	memset(bk, 0, RMPTABLE_CPU_BOOKKEEPING_SZ);
+
+	memunmap(bk);
+
+	return true;
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
@@ -210,12 +227,17 @@ static int __init snp_rmptable_init(void)
 		goto nosnp;
 	}
 
-	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
+	/* Map only the RMP entries */
+	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
+				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
+				  MEMREMAP_WB);
 	if (!rmptable_start) {
 		pr_err("Failed to map RMP table\n");
 		goto nosnp;
 	}
 
+	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
+
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -224,7 +246,14 @@ static int __init snp_rmptable_init(void)
 	if (val & MSR_AMD64_SYSCFG_SNP_EN)
 		goto skip_enable;
 
-	memset(rmptable_start, 0, probed_rmp_size);
+	/* Zero out the RMP bookkeeping area */
+	if (!init_rmptable_bookkeeping()) {
+		memunmap(rmptable_start);
+		goto nosnp;
+	}
+
+	/* Zero out the RMP entries */
+	memset(rmptable_start, 0, rmptable_size);
 
 	/* Flush the caches to ensure that data is written before SNP is enabled. */
 	wbinvd_on_all_cpus();
@@ -235,9 +264,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	rmptable = (struct rmpentry_raw *)rmptable_start;
 	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
-- 
2.46.2


