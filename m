Return-Path: <linux-kernel+bounces-268142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF099420CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444DB1F251FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C718DF98;
	Tue, 30 Jul 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A3/pGbtI"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF818CC01
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368460; cv=fail; b=Oo40nf7ujnI2ruCS+GXxgulydfQl4Nouw28T1OyWQgBa7wxQ8WzNepdWX1RZF0WTt0sQsmPu0zNrJAWkMwp5DTBygImv4ewlMxrUZpjayZYxFrLZ58KUUWE4OG85zNOAVneu0mx56JAuZOXe2fOgW9u+AOY4fqcSauKhAfvkJSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368460; c=relaxed/simple;
	bh=3jBNdQuOnPDungJ/P9wT4zRL7z3ao26B4dmZqfQJDBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTpHhRtuGly4/2e1BP2aclunSAPig9XFYyMbEvvl89vuS2qc8t32G3tyvqQugY412HG0aCUdxzI6z3blZPSyn3cwZspuV4w9dxuSMAOSI6bJnrORdUxfawCX0ANHWOkKYq0+ChegrOWGX1/XzowRkTWsa8Eb5P9T7F+vcr56YuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A3/pGbtI; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNgMcHi1j+lm8VSFampFW7qFxJsfnDNOni6RK01jjFkN23IEHL2n5vrlIvAQOgso9l415PXE4h67DHkumGIPwBwUEtpvowiaBZ5T3VQq/hQvdm9JMxmckR/oj/6Z3gpgdfO6xS5dVZtB82dztqRMfI8No6tCR3mlKCC61G33+Mmq/kPcp9G9Wi+waMyobE9gwFUoiWw+6FiV8rAjHce0as3fAEXh1zVeEvbu/LrIWubB9cfFSPL1tZ4XkFeUdEbsVJCAmIg/JQDrSGXJcWiExDlzP/2FF3mn9HmBCIBmHF6Xn07UKK4TetmNlpTlqpt4W842bJNyfQcigoPsFnITfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T6OLVACWHgZ1LYo7hE/mdJpXwj2bJ21of8Mu2wqhdk=;
 b=EUV4l4jUJHB25WL4+cDzmowpng5CY22uGkI8TrG/mUBExcc9rAfPM8NTOY2XWuepmINy/pLA0ttzlPVGJMYECuR7cPT3gaRxdZ53fr7MvR9T4FRJwLWKKiVfJBphCGTJXRFlI0OfLOlKgkQZpjoIikR2Til9OuQbbUFlUtDQ08pMl0AF4wzp50zBpr2ijHaId2evfvmCH03Wit/31FQhT7WcFhAECWOxfHqdAd4z9dTh8Xf4eXcjutGD+8VFuX2OPKUxbH81NDyrOiThLa/yMqEAwpWpnBh550MZBRZVqvtbjWm51tBmKmUOSiGYSWSvgc/FZXBXrUoi1TCoVSBTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T6OLVACWHgZ1LYo7hE/mdJpXwj2bJ21of8Mu2wqhdk=;
 b=A3/pGbtI1vdzr63keMH0vAKXRf1Bz6NfSymSjCbaTLjnXSX58G7UEjFseL6humS3vD4X1eQAgFZUTckgS48sjA1HyEubdnSfzQgj8x63KBF7unXeVmIAQVSYO8qR+zQSbv+qK/FCusm0DlPAEyPaFtuFnUmfe145jqny83pvyhE=
Received: from PH7P220CA0116.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::19)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 19:40:56 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:32d:cafe::97) by PH7P220CA0116.outlook.office365.com
 (2603:10b6:510:32d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:40:55 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:40:54 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 5/7] x86/sev: Map only the RMP table entries instead of the full RMP range
Date: Tue, 30 Jul 2024 14:40:05 -0500
Message-ID: <818439d3507d30d90cb3693a0f3bede8c6230f26.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 508fc314-4ef9-48de-bef1-08dcb0cf878d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MZnrYU6q+rGeQGHm+GAclc3y8BvWcYMDFcWzyvrvhSSvtk1azDSFurPBLDml?=
 =?us-ascii?Q?S66NcJne/QKkD7rbREYZxjNnAdS5DUoTMoTmVc8daJPJ4qazqt0CKPx8PSLq?=
 =?us-ascii?Q?9xsn3bVcpleFOjpFynTOaMlG7E+4Uzz6MmxFrDMyxRkREGtfZZ8hyHg08E7p?=
 =?us-ascii?Q?uVJ1W+YY7bBi4XGzJL7B8fYFDr9ekKU/4r0uHOvr0tN+jhmd5Pkod72KOtCw?=
 =?us-ascii?Q?JF5Dcc/tMZ/JF5LrNtfXDfsOOoDzIGY1UO/cCuECOhJM8mIknQlOVkHdEkTj?=
 =?us-ascii?Q?9M5+SPBTIWc3qc/5qW2Qtz5c+AnCggRvQ2QIkhgimtThzLJP2peNOsSwjcUA?=
 =?us-ascii?Q?pIgXqYMRSDJDfIEEcOD3mQB46K7g0ZLjTubg5mDRLeg832AmAACgDQ2DbTmx?=
 =?us-ascii?Q?S27e3kHJYHOBCWPDOXCqXSDTS104vyMULr1mYkvzXATptL7ldhE9YXJcLH+a?=
 =?us-ascii?Q?NkJLaxAoBYw5B2bI5rtpttu+JM7WqsagqbiJmvW6ueXmag/A+g5EyT8jbjEM?=
 =?us-ascii?Q?g3rJElD7/JSp6oUPeLQqOIzOT7guqEANB43sFp2NrNtW0VhtKxC4t5QIKVz0?=
 =?us-ascii?Q?mxewpDvAXaHSJisR/JW0Tw/U2Fv9EuvEcwtWemSj4iVCwTB4zINa6t+PISUX?=
 =?us-ascii?Q?ZVad9erFhZYO+gLeBc45Pka0dxvu+TML7Jec/Jr4GJnV/w6Cbv1GcaTa0cJL?=
 =?us-ascii?Q?0azsjZ6ZRHp4EWbsiE00TErc0YDhk/ldCbNYPUtvPUsRHMfFWTXdvrV0cnUE?=
 =?us-ascii?Q?I9dp8fHUz4XURU6IGXTCNYQa9LXD2tQlQoqXS/tSX0QfsurGSdTFX1OLZj2z?=
 =?us-ascii?Q?hq1ZVq4C6SP9XVV7kw9CoDIrL1O2/shdbh3iZ2KV5lLdoJSQzzjwxBjBdVwy?=
 =?us-ascii?Q?hcxCEnJgwQ+oB7+B0PC33X1G03SpTeLfboTlg1g4Jy8U/vQKQQOAzR2z9eAF?=
 =?us-ascii?Q?4/pfCZho50uCxZe77esaIz+fKQaGMbS2a7vY3n2m/CP+E/dlfSiP/CHL5y4t?=
 =?us-ascii?Q?ah36QeLO75LD+aAr85PopTPcVrb68aXIjzc05BvURrcqWcfS0Qy3Y89xLXI9?=
 =?us-ascii?Q?FnOPxxLh+wLgsPuZsznc8kchBMQBKPJ6lI17vW4OOtrk4bcHDhhyY0+hO9Ke?=
 =?us-ascii?Q?uQLWmgLeoJn2vTy16Ph1NC5Jm26U5z2SH5saHYBoXF8F5FUK9GNAk604J5nC?=
 =?us-ascii?Q?zvI9gcWGcgTt44M5cBzCdS3I1K+flSfkFT+NXf7tg4EBASNgbJ43fje/GE8c?=
 =?us-ascii?Q?JggRPAdSkDBjzMotONdbDLQG7lIU5Zw/Y5p02oFXlUR2ShmFOu5omlcgjTUI?=
 =?us-ascii?Q?Pc+CHMbuG3H6vo3Q9Qo1bUaVlc3EX4NC8IYbGZPSBXn8lRW2CpL/bEqFe+2c?=
 =?us-ascii?Q?BEvPqXTEpYInkq0DIaMVBsj4WugUWBDxTgxItUgexP95ovk6rxQqjMEMH8PB?=
 =?us-ascii?Q?eVj7mtF/jpe6GVDIh2c0Locg1MSRqTz6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:40:55.6825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508fc314-4ef9-48de-bef1-08dcb0cf878d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449

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
index 31d1510ae119..81e21d833cf0 100644
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
 	rmptable = (struct rmpentry_raw *)rmptable_start;
 	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
-- 
2.43.2


