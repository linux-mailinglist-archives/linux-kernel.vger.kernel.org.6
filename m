Return-Path: <linux-kernel+bounces-268144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393C9420CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96D5286D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA918CBF3;
	Tue, 30 Jul 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEhzupgn"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC118E02C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368477; cv=fail; b=IvPBKtMSnafXHijRpacazdPcS9pC91gcPo8ugenwoSFuGrgJelShVIH5Je7+GyG81a6+OeE0Fi+LIeJY2hHZzwPwNvXKKV1koDJeeC0/y6VHHEVHOlIEDgxuoG0NjsmHHi+1zC9czxwuS1se1dAU06z2prEKxkm0ytTIpAPWTZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368477; c=relaxed/simple;
	bh=dKCwXJaOHdpdOlrLHeP1HFi3oUba/kO3uC5UrqY3Q2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYjZ7ErlHCXXe/lvP9ZdCysaZUe+V1x5ae7Xtykde/rZl+geTi0Nrlg7PFtcZ1LYLb5YjlZqqXKo5DGo4YZBUqEc0fiUdUxiOiFlz9OlXw88/796FI9uar+vqyev221a4peo75JzyF0O4adgKQwfrxJE1oab+LrZV9LndQn/JBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEhzupgn; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=by4QfOzlhHNV8UA62vXkSBD1hy9Y5vix0qZ8dC5rKTYZ/j+bd80DyY+2OHaHSqWwuHqTzkHTB/vGQNOMfkE+lG6CLwzJe59Y6mP/stKGpNt3/wufKNV45VW6gcDE1CFDngntTcG+yl3McfFMIE7uqVIwdOddOFnfGTScCpnfbeLutPj3wFKYGyeT2bJ6K4szsTeCENLOoelGY/c95XfnOomAcCwx7VnG2cSgulvbgtndAy18zPMhL/nNUy/wwQru4PKOfQQeQc2lwZWXmw44L//Wu1T8EmF8YcmFDnVhEk6Jk2Q5zIm3OMa3oTOoYkromTo1OpDF9F+H8Qc7QYW1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROlBM8oCwfrGwJAw0Zjjk2uBTMwffwqNQgs0Qt8sPmE=;
 b=f8SvyDKZssmMcyNHLidWI69TROgcNbRG9LGjcgvPdS5ncHsjTBEtCJ1YWgvttFvKvVn7T4y6O8kI3+8hCK09hnHtqi+q9HGyj6BuvFLIp9e5zMQl2Nu5hg2xGRNukEFScWyfQto5fSL4xOdyhIj2Uilj6tIYPBAHxFEDgLULlfbygVvh9gvAhF65qYYc7YsVmQ3O837eZASP1SLV9VK8aelmJBY718qprmTp+Lg8Q66QOT6P4fRr4qArkv616nXMPBi7cKlrYjJQ/XTfkN9YkXcgop+7VhyNROqZ4cg98i7U6wmJcZ/qMCLv7GBBEod8HHNctheSmPC99NR+EbBV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROlBM8oCwfrGwJAw0Zjjk2uBTMwffwqNQgs0Qt8sPmE=;
 b=eEhzupgn2FPCR7U6fF3ZSpbYvM5c3c3dINYOb4theYb8scwBgWG8BlswiaPD/ENEigHejGsi7UEVnDcbRysbRZ53P+xSqO2qZQRFSigiWrKLkCoECUhVEiYJiNdXqY/DNERiD/Wha8RZNgyAIM+JRh7e7G7eTcS8Aasxwp0ogsk=
Received: from PH0PR07CA0043.namprd07.prod.outlook.com (2603:10b6:510:e::18)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:41:10 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::b8) by PH0PR07CA0043.outlook.office365.com
 (2603:10b6:510:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:41:10 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:41:08 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 7/7] x86/sev: Add full support for a segmented RMP table
Date: Tue, 30 Jul 2024 14:40:07 -0500
Message-ID: <1b2f0391ca3b2c66dc6f9d564180cb6709ab9fff.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6a7ddd-dfcf-4bdc-1429-08dcb0cf901c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8jEm6ryBjP11gCRKgXaWi+SmPdy4LdHhnRI3O69/L0i79rgZ9GARs5p3GMD?=
 =?us-ascii?Q?EnbHfrEYOE7396JJML/g2Am1HYjQnAIrlXS5Iuv+Wdf+zGQoHrDWElyiDfFL?=
 =?us-ascii?Q?tEQS6Kxl96KCrsWTxgmF9wHoXkisBeb2O0K7g8HvugOwqmrDFdhZfBQjGlD2?=
 =?us-ascii?Q?+OjVDXP8cZVKu6rGf3rXSEjaTuZu6wTXgz2B93j+JkqsjwGplYq2tM0X3exZ?=
 =?us-ascii?Q?5FYEmLdFcA0SU9MgYh0kT9luKUXAZPBlVyFwVEI1FOavnYO73Ix+fCzDRS96?=
 =?us-ascii?Q?x1jXdGiCGT9bUg9IDostD0vSlSCBa20jP4NXQ0xhsTgKmKwIm1hZtsZCP3G/?=
 =?us-ascii?Q?+kfwdnDaOin2yJVWTOBoUvoL6MHqYb6mmpolkqMVm54LbDYYlLSo+jKHOP5g?=
 =?us-ascii?Q?Y5vpQTpTq07vCKMl9TKkqEDunMGET5rAH1XHoDhHqU0ncf9UzKv+kftC+DO1?=
 =?us-ascii?Q?7+6hpWj70Wqgux8NH2lsBqNPDh2i0uea7LICpZ/DYbYgPxiGk6zQV0k8oqcd?=
 =?us-ascii?Q?sH0THa3P7dmt1B70cWccH/Xk45V3zyCE9ZDAq1OknpVI8K77KMK9Y1uq75ur?=
 =?us-ascii?Q?Iv6GDfUQvHeHEQsZkwzhxhzBlIBcscTwFeR1clLIgNhnfOtDdvLaY2bz6izs?=
 =?us-ascii?Q?zMd0TOP6CBVlcW1ja1flpy3/7Zc/2BbzvAWqCqivCJ+3FVwjQyBery4H4Vdc?=
 =?us-ascii?Q?Jv4YS5yjbDwtkRajarHXYbLXmD6DEi8yRM6Tt7iiO3i/QP+WOeh3dcGbQ4nb?=
 =?us-ascii?Q?xP6g1BW8EB058qDA8gVcRu6Pf9TcdoSfxiLnna35yV+10mSB7rKcH5KYuU1J?=
 =?us-ascii?Q?dKL8ZNPiGYXNvaDPm0qZyMhCoFSOp8v2XPWDmsESLLTRU0IJtwujNl6GeM4C?=
 =?us-ascii?Q?2rgYaWYCTQg90EGVRjRK3m6R1Pzcl2UvzAtt47n3W4am/0kFR+XHh0bIv1jF?=
 =?us-ascii?Q?23l2GHyZ3XuZEPfEcyiHYXrNnnSwDs8RPUD4vkiU5ixz/qjaq3gAlGDViMiI?=
 =?us-ascii?Q?iSbYhhngh0EHA6zqTYBfw6H3m3DpwCo8D4Qsgjq7zp5bafVN5bQSgbZ+eNc+?=
 =?us-ascii?Q?/BYRM8WA7jPrm0dfwPV9cZQQ+98mO3G/LF8rzhKSlJIwAr4cd4del6mVKbVl?=
 =?us-ascii?Q?v4W/J6UqKX5PzbixuMG1qeLetssaOpyrya5HoZSkevmH00KIk/BKgbgH1ZVa?=
 =?us-ascii?Q?9kygMR0LKksxpCXYRD4lYpQ8Ju198Haaby7FuO3AjvZZVerjVcV0g6pOwFYL?=
 =?us-ascii?Q?l47rSNUOxWEMPF9WSZfmAfVd5t5i11kjXEqgNEaaaImJ0rLvxVZc0o9U3g1L?=
 =?us-ascii?Q?SUh5wn377+22lD/jYzqKIN0AYbzNxgnuu76S1yJ7pcujiZAZcCKdsnOhvMDX?=
 =?us-ascii?Q?+q9cSYS7gbUxRaCXS+f8mGndUPCl7uV0tJyjiBtEaLqIIlMiPRevg+wDS/wW?=
 =?us-ascii?Q?3LGdKVivi5X5WhjkYGjY2UGDYnT+DPZi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:41:10.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6a7ddd-dfcf-4bdc-1429-08dcb0cf901c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

A segmented RMP table allows for improved locality of reference between
the memory protected by the RMP and the RMP entries themselves.

Add support to detect and initialize a segmented RMP table with multiple
segments as configured by the system BIOS. While the RMPREAD instruction
will be used to read an RMP entry in a segmented RMP, initialization and
debugging capabilities will require the mapping of the segments.

The RMP_CFG MSR indicates if segmented RMP support is enabled and, if
enabled, the amount of memory that an RMP segment covers. When segmented
RMP support is enabled, the RMP_BASE MSR points to the start of the RMP
bookkeeping area, which is 16K in size. The RMP Segment Table (RST) is
located immediately after the bookkeeping area and is 4K in size. The RST
contains up to 512 8-byte entries that identify the location of the RMP
segment and amount of memory mapped by the segment (which must be less
than or equal to the configured segment size). The physical address that
is covered by a segment is based on the segment size and the index of the
segment in the RST. The RMP entry for a physical address is based on the
offset within the segment.

  For example, if the segment size is 64GB (0x1000000000 or 1 << 36), then
  physical address 0x9000800000 is RST entry 9 (0x9000800000 >> 36) and
  RST entry 9 covers physical memory 0x9000000000 to 0x9FFFFFFFFF.

  The RMP entry index within the RMP segment is the physical address
  AND-ed with the segment mask, 64GB - 1 (0xFFFFFFFFF), and then
  right-shifted 12 bits or PHYS_PFN(0x9000800000 & 0xFFFFFFFFF), which
  is 0x800.

CPUID 0x80000025_EBX[9:0] describes the number of RMP segments that can
be cached by the hardware. Additionally, if CPUID 0x80000025_EBX[10] is
set, then the number of actual RMP segments defined cannot exceed the
number of RMP segments that can be cached and can be used as a maximum
RST index.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   9 +-
 arch/x86/virt/svm/sev.c            | 231 ++++++++++++++++++++++++++---
 3 files changed, 218 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 93620a4c5b15..417cdc636a12 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -448,6 +448,7 @@
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
+#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 82c6a4d350e0..0f31b5cc96a3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -660,11 +660,14 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_RESV_BIT		18
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
-
-#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
-
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
+#define MSR_AMD64_RMP_CFG		0xc0010136
+#define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
+#define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
+#define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
+
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
 #define MSR_SVSM_CAA			0xc001f000
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index ebfb924652f8..2f83772d3daa 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -97,6 +97,10 @@ struct rmp_segment_desc {
  *     a specific portion of memory. There can be up to 512 8-byte entries,
  *     one pages worth.
  */
+#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
+#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
+
+#define RMP_SEGMENT_TABLE_SIZE	SZ_4K
 static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
 static unsigned int rst_max_index __ro_after_init = 512;
 
@@ -107,6 +111,9 @@ static unsigned long rmp_segment_coverage_mask;
 #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
 #define RMP_ENTRY_INDEX(x)	PHYS_PFN((x) & rmp_segment_coverage_mask)
 
+static u64 rmp_cfg;
+#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
@@ -196,7 +203,42 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 void __init snp_fixup_e820_tables(void)
 {
 	__snp_fixup_e820_tables(probed_rmp_base);
-	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
+
+	if (RMP_IS_SEGMENTED(rmp_cfg)) {
+		unsigned long size;
+		unsigned int i;
+		u64 pa, *rst;
+
+		pa = probed_rmp_base;
+		pa += RMPTABLE_CPU_BOOKKEEPING_SZ;
+		pa += RMP_SEGMENT_TABLE_SIZE;
+		__snp_fixup_e820_tables(pa);
+
+		pa -= RMP_SEGMENT_TABLE_SIZE;
+		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);
+		if (!rst)
+			return;
+
+		for (i = 0; i < rst_max_index; i++) {
+			pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
+			size = RST_ENTRY_MAPPED_SIZE(rst[i]);
+			if (!size)
+				continue;
+
+			__snp_fixup_e820_tables(pa);
+
+			/* Mapped size in GB */
+			size *= (1UL << 30);
+			if (size > rmp_segment_coverage_size)
+				size = rmp_segment_coverage_size;
+
+			__snp_fixup_e820_tables(pa + size);
+		}
+
+		early_memunmap(rst, RMP_SEGMENT_TABLE_SIZE);
+	} else {
+		__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
+	}
 }
 
 static bool __init init_rmptable_bookkeeping(void)
@@ -302,24 +344,12 @@ static bool __init alloc_rmp_segment_table(void)
 	return true;
 }
 
-/*
- * Do the necessary preparations which are verified by the firmware as
- * described in the SNP_INIT_EX firmware command description in the SNP
- * firmware ABI spec.
- */
-static int __init snp_rmptable_init(void)
+static bool __init contiguous_rmptable_setup(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
-	unsigned int i;
-
-	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
-		return 0;
-
-	if (!amd_iommu_snp_en)
-		goto nosnp;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end;
 
 	if (!probed_rmp_size)
-		goto nosnp;
+		return false;
 
 	rmp_end = probed_rmp_base + probed_rmp_size - 1;
 
@@ -336,11 +366,11 @@ static int __init snp_rmptable_init(void)
 	if (calc_rmp_sz > probed_rmp_size) {
 		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
 		       calc_rmp_sz, probed_rmp_size);
-		goto nosnp;
+		return false;
 	}
 
 	if (!alloc_rmp_segment_table())
-		goto nosnp;
+		return false;
 
 	/* Map only the RMP entries */
 	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
@@ -348,9 +378,116 @@ static int __init snp_rmptable_init(void)
 
 	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
 		free_rmp_segment_table();
-		goto nosnp;
+		return false;
 	}
 
+	return true;
+}
+
+static bool __init segmented_rmptable_setup(void)
+{
+	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
+	unsigned int i, max_index;
+
+	if (!probed_rmp_base)
+		return false;
+
+	if (!alloc_rmp_segment_table())
+		return false;
+
+	/* Map the RMP Segment Table */
+	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
+	if (!rst) {
+		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
+		goto e_free;
+	}
+
+	/* Get the address for the end of system RAM */
+	ram_pa_max = max_pfn << PAGE_SHIFT;
+
+	/* Process each RMP segment */
+	max_index = 0;
+	ram_pa_end = 0;
+	for (i = 0; i < rst_max_index; i++) {
+		u64 rmp_segment, rmp_size, mapped_size;
+
+		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
+		if (!mapped_size)
+			continue;
+
+		max_index = i;
+
+		/* Mapped size in GB */
+		mapped_size *= (1ULL << 30);
+		if (mapped_size > rmp_segment_coverage_size)
+			mapped_size = rmp_segment_coverage_size;
+
+		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
+
+		rmp_size = PHYS_PFN(mapped_size);
+		rmp_size <<= 4;
+
+		pa = (u64)i << rmp_segment_coverage_shift;
+
+		/* Some segments may be for MMIO mapped above system RAM */
+		if (pa < ram_pa_max)
+			ram_pa_end = pa + mapped_size;
+
+		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
+			goto e_unmap;
+
+		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
+			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
+	}
+
+	if (ram_pa_max > ram_pa_end) {
+		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       ram_pa_max, ram_pa_end);
+		goto e_unmap;
+	}
+
+	/* Adjust the maximum index based on the found segments */
+	rst_max_index = max_index + 1;
+
+	memunmap(rst);
+
+	return true;
+
+e_unmap:
+	memunmap(rst);
+
+e_free:
+	free_rmp_segment_table();
+
+	return false;
+}
+
+static bool __init rmptable_setup(void)
+{
+	return RMP_IS_SEGMENTED(rmp_cfg) ? segmented_rmptable_setup()
+					 : contiguous_rmptable_setup();
+}
+
+/*
+ * Do the necessary preparations which are verified by the firmware as
+ * described in the SNP_INIT_EX firmware command description in the SNP
+ * firmware ABI spec.
+ */
+static int __init snp_rmptable_init(void)
+{
+	unsigned int i;
+	u64 val;
+
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return 0;
+
+	if (!amd_iommu_snp_en)
+		goto nosnp;
+
+	if (!rmptable_setup())
+		goto nosnp;
+
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -418,7 +555,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -451,6 +588,60 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+static bool probe_segmented_rmptable_info(void)
+{
+	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
+	u64 rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+
+	if (!(rmp_base & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
+		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
+
+	/* Obtain the min and max supported RMP segment size */
+	eax = cpuid_eax(0x80000025);
+	segment_shift_min = eax & GENMASK(5, 0);
+	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
+
+	/* Verify the segment size is within the supported limits */
+	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
+	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
+		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
+		       segment_shift, segment_shift_min, segment_shift_max);
+		return false;
+	}
+
+	/* Override the max supported RST index if a hardware limit exists */
+	ebx = cpuid_ebx(0x80000025);
+	if (ebx & BIT(10))
+		rst_max_index = ebx & GENMASK(9, 0);
+
+	set_rmp_segment_info(segment_shift);
+
+	probed_rmp_base = rmp_base;
+	probed_rmp_size = 0;
+
+	pr_info("RMP segment table physical address [0x%016llx - 0x%016llx]\n",
+		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);
+
+	return true;
+}
+
+bool snp_probe_rmptable_info(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
+		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
+
+	return RMP_IS_SEGMENTED(rmp_cfg) ? probe_segmented_rmptable_info()
+					 : probe_contiguous_rmptable_info();
+}
+
 static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
 {
 	struct rmp_segment_desc *desc;
-- 
2.43.2


