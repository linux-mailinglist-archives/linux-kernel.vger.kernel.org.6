Return-Path: <linux-kernel+bounces-378702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E509AD432
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329451C21E60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367921D14EE;
	Wed, 23 Oct 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+Wwao2X"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF651FAC42
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708977; cv=fail; b=PH0sBAah5b5kQiG+2k7Wt1HOIjagV1m1mMlowFYtNq7AaSK2+bQAqqgL6hXlRNhn+uURX6/sKmVdqLL/l+/NVrfuxfSOuxyVtzijFMdE30/I2E3/KK5w9DkE5Kng1Mz4Xz5AXUvmZ43Ix9sILuNtJZLR8f+TLdlXBrHjJJX39X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708977; c=relaxed/simple;
	bh=pXyERW28iFfQIMNq1OZym+4o2FxhSmQZJQ+BdbXDeWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG47fzUhsMUpJ6G/D0ZI6ZvRQg/kEhyfVjd+trhgQGQClpziJkSWjHKnAcOBZABruRepil/sO7SaM7jNdWESJ2sKPf2usiv91vviilHPMrf4MuHnRLMRPLC2yiiov+lTahWSA5iZYmp+c6GeVDgPocVdsJI5dCSPXAKOp1vSIYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+Wwao2X; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLcdu9xcfDcMe3cDS1hxi3t2bjQM6X8OYgqqoblOf08p5UFEEe2jM0jiUlY72ay4Y3nrEFfD6kojjw5smifJXPimA+eZvmhDJXKL4I0ZdzGllpjvgfmJuCr2jyI4rM/VBnZDx1cdZnPJnnPXtbZCPIwiF4OtMDqPntLK5J0zI1y3ASeelX6BfRwusof8Cr8m8a1sZWPRovRloLR/Kko4h9RU5gZ64lNILHo8BdBB+jkL0MNRtedF6HcyzpcGJ0RkU9pxaPoyJ6Y0fL0SGpN356Lg6EqIBC5uR0hwVBT/kqu8K1R8hYhDOdBmsWb4Y7ERntWcKEB4Wc0m15J9LA55Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tXIBcENEuPIf4kYwrVDfaofAFQrrirqU65cpPsJOfA=;
 b=OSHDo3xRffaySdKBGTq7dT7AlxO0r+E0CW4T1BfjUXXv0dWSCIgpHxL8/XG5yeysxRFl7qqGxfM2nlJbjHFuuYzLcFBLwgZxQEXCDfSISiS5nVSVPoDpEEMdLTtihDy3K4BEacHP+AhzSDnvpS+YoWWP99Qkwvnizw++ggGQW4Tiyie9OvAkwudf7G69FXQYoDMK8z+C4BNdwLUJggytqOs7X8Fty/62zMx7JPCeT46tBo2kf2pMKmKYfw9b6yVcxyQc7TPsz6YDTe/5jiH6pO2VgrSjmdpzCSkjZn6CE8nCXudn6phvyCzNALzIC5sTY1XaYVTXNdKIlzWOwrbqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tXIBcENEuPIf4kYwrVDfaofAFQrrirqU65cpPsJOfA=;
 b=U+Wwao2XlCCCAnLNqiX/515BSwNg9GUISWCmhND2/1da7KBHWfB5Gr+U3aHMG5p4/RSgSvyuV5cLA5ISXUpDKurezM0pWUGCA96CD81XnIHdxYBN3bX1V2plN4SCi2GYDq4Jf7u1wd6fnQYhWweuKxdQ/Sf9FuSgdEwRPy37I7E=
Received: from CY5P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::31) by
 CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 18:42:50 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::e6) by CY5P221CA0045.outlook.office365.com
 (2603:10b6:930:4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:50 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:49 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 5/8] x86/sev: Map only the RMP table entries instead of the full RMP range
Date: Wed, 23 Oct 2024 13:41:59 -0500
Message-ID: <915e7d6b2de0c71d8cd9f8902b1ba3ef6ae563cb.1729708922.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 146b3646-1a17-4ed4-cb64-08dcf3927f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u+9pvul0GSJfT9gEL/rC12mVA6Mv6wJCsoCriVhjmopORHEDz+OtPy04FP7u?=
 =?us-ascii?Q?BrX8Nheqmx8YPvSM2zxgHwBGrLIf3mZ40nOWzfTMWjeYZoVeac09iOWPgkv+?=
 =?us-ascii?Q?a/+6vIjx7JVhQJq9na6r8uMVZ+T7Wy2+TJlZx6asaGsFrb9hym6GBosf8pUV?=
 =?us-ascii?Q?rPFrWlB+MyoBcRKYwuhCW0rLU2mDUWk97ViriiZTwQ1ZPpF9NzcC/juB6o60?=
 =?us-ascii?Q?4i2uoKSQ+YnZ5z2qXrHxQt1kNVRBPJnPjfeSGf9NDN0DMUwJoMh7Ya/tbvPG?=
 =?us-ascii?Q?8btx3ZTRPAkFazF/gGGKAFLs6qWgkxTOZ69P87OS1/742B8UJKhexWmGLDxy?=
 =?us-ascii?Q?hCg5SvcQe1RWtVTkbC/4MdZHUOENXQVpmLUcaLrxKK7r8W/tdomg07ySEMfL?=
 =?us-ascii?Q?Iju9OWjY93+g6dQsPUDxs9sNIY+MWVutgxXnwfydqIePRyJ6OXUQFJOpx+Rt?=
 =?us-ascii?Q?Xu5OchLRz6iCptYb5AU2GfbgexyjMe+E3bOGidS4OQGwS0Nnhw9QzVJnEP7B?=
 =?us-ascii?Q?eMP2J+GZ9sfve0AF50NG1OPajhvR2vfISDToUql9Y5whfKTw481iBznhshaU?=
 =?us-ascii?Q?Bo4qzQBQ4/wPRsF+jyzCNeitBDcb2h84sPvqQ8e8SBacEVnekXgT7kvfYox4?=
 =?us-ascii?Q?Zu8NVhYgQWEP0sAXD+E3N9hkc6ZlDKHDSl2TC/0Jz1pjCF5zD30TIJBuPoiv?=
 =?us-ascii?Q?8fBGQWBOgC+mdSJaChSj8wmdCqk6ooNIYvOA6Khc1mPVtIifsnr6zjO0Ys7F?=
 =?us-ascii?Q?zW4KzbAYXQgKl+Du5dNQdD6871zIu/xf/jzKqZrSbbjxp5+qo8Xt6DDJ2UAd?=
 =?us-ascii?Q?onp05nmSGckAFNasQ16AASt22Es1kt5/J3drRwYudd9wcyuKnWTIiNeJw13B?=
 =?us-ascii?Q?akEhg35urJKpQVXvoK5JIXhcEJDhXdoCF77/Lp5NvzSFIk36mEl146TOL2T7?=
 =?us-ascii?Q?7mp1Z53p3ZqlV6aNv5GHR8NEd6J3BVREOSoJ+W3QNrcm7z4r1b/dAQfarsNL?=
 =?us-ascii?Q?6A3yVl2cFtQvuOFoSKV/FU1+DJ+Tp3Wa/6IS54SzTIx1ykhaAy+WJ1euApp6?=
 =?us-ascii?Q?LoMSBqmwP9Kbu2DW+cnVbeq966UVqY2NefypTo4Rbyz4B6SNVPi115zu6oRF?=
 =?us-ascii?Q?xwJ/CXVnUnF4K93rAut5QCsuD6JkUU8JUYD9SsXu36YPnfsgQTTi+oqN5iAT?=
 =?us-ascii?Q?x4+7Ch/dhhBr7BcnLkwGr+bmsjjxVc3OWQdcOVOufPgDxhyUv4cqMoWstlRd?=
 =?us-ascii?Q?3XwbElLTtJdp4CaEPk+HYxPBCByRcTeYQi5AP43avhnY4M9CBd7Cr93U2xn/?=
 =?us-ascii?Q?A3MaTvaY1GO4jEfD5DFErVFSr5QiM7mLONFOgWHeqGezSwe7a95ONrIQzdhs?=
 =?us-ascii?Q?7rclmGt7QlyllPT+Ya21rzTTGV+Nr0AvgSb5qC+nX7hb+QY60Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:50.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b3646-1a17-4ed4-cb64-08dcf3927f63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

In preparation for support of a segmented RMP table, map only the RMP
table entries. The RMP bookkeeping area is only ever accessed when
first enabling SNP and does not need to remain mapped. To accomplish
this, split the initialization of the RMP bookkeeping area and the
initialization of the RMP entry area. The RMP bookkeeping area will be
mapped only while it is being initialized.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index d0fca9bb2e12..dd256e76e443 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -168,6 +168,23 @@ void __init snp_fixup_e820_tables(void)
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
@@ -205,12 +222,17 @@ static int __init snp_rmptable_init(void)
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
@@ -219,7 +241,14 @@ static int __init snp_rmptable_init(void)
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
@@ -230,9 +259,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	rmptable = (struct rmpentry *)rmptable_start;
 	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
 
-- 
2.46.2


