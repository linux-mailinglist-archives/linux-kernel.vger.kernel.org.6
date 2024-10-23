Return-Path: <linux-kernel+bounces-378704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C589AD434
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DEA1C22203
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4F1FAC42;
	Wed, 23 Oct 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mwOMnxZ0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1261EBFE0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708993; cv=fail; b=HB59x3Pk0DLqtA6qyMaaKVOp7tFDkqfN1merjg0s7L5o0+vYgsF3ptjcU5WWVh7uHjkCpCJT6i46t7xN1ZdYkcvuZ0Md4kH5vLxJq32q3yMP54JwoPixY+xZXIjWDQ/fowTTC9p5NH0wi9jlbnXAdVFs7uRT2ILmuTxzk60jQTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708993; c=relaxed/simple;
	bh=oZxJtc/O+ETHSF69UlEAU+/rE5D+oyqeTyTG6jEi2RQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbCr42qXUHQZk1qh9EY3YufFx1U/w8PNowqXVw3xvhNQFuyqXUd5iRzOfPAg3jppfMa+Yb3XiPPVr6UiBp1+Q7/JxXGurKmK1K+Z7lu0gPaxMllrA3Ebr9IrPP/LFPKvOd4I50WY1pKxL2fgwHvFkYV95GGsIsyHik1XFC9hJxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mwOMnxZ0; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDhXBU0A/jbeqwcwnyhXFNHeQXHlqMmgjrTEztXIm5/6QgfdVfT9z7mTyyh/+anko51tjgWgXsvamGZJYQw395dYb+vcS6I0yASGpU4D8/Pas23SEmw/ogYga+XGLSFyvGZumUnA0rF3XO+9ptBOe5Jxci63LqS6+QzHn+ecVQI3BWV3H06L+qM1Qt0I5FCmGp1oerHWRqzJ82URIRHopllD4/WpQ66ZYv8Xr9I2Ao5SLiIshsgXaRsV0rqZBQWcbCp9i3wgisqtpYs5usNJizerp9sJADtBE5TaSPMAgWHkX5nrw9SYlPLTVQsS/EIaGTASmBeJHscZPT7Jtmye0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zZm/Ufow4hkw7u2w47fVq9kzqVyuuoCAs6f19JYV5E=;
 b=M+59Ez1IadXb/7+t2UovmgrRkNv7YwMRRNkQ7b7/ajextIxLbLv/nnQtdnObL3KBZq5Ddwp+OKMU1tSMUSxiHxG7Wdd1nksIIKK1hgBKBxMar3IJMGaWsG70Ei7SfZdEZ5+Q+EPOkK8Y8pbnGxRN8RSMF+TIk3x0CoxnZ9SmNScthAY91ZAbE2VRR5a7Cnrhd5Lnur+OB34CCbZPOWcckLZze7X+h6PjjgvG4N3J0E/Z+RYlz9EpFu1X4Xubu2DpbEVVlAJ/aR0RtCODy+84LELm9pJzFBw6UXD/7FCPVdVbhn50Qpad+ZwJwssPhsw7GUNpVPx9Io2QA118E+3Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zZm/Ufow4hkw7u2w47fVq9kzqVyuuoCAs6f19JYV5E=;
 b=mwOMnxZ04nNdFh/4a6GPjUZH6WNrn4BBOYwtF7FPqGHdRXFkdVBhemmXyDTV9vjO92aooJJB5ue/dY84x1eRfHO5jAWgbnTBqQdH5nON+5AlYciU6nqR80xdyh0pPFmSdW9I91j1xxG6QPCxfP6Q4+TbeX2yfNr7qiMx+PnNMlM=
Received: from CY5PR18CA0028.namprd18.prod.outlook.com (2603:10b6:930:5::33)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 18:43:05 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::3a) by CY5PR18CA0028.outlook.office365.com
 (2603:10b6:930:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 18:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:43:04 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:43:03 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 7/8] x86/sev: Add full support for a segmented RMP table
Date: Wed, 23 Oct 2024 13:42:01 -0500
Message-ID: <3b9392041def5f870965693053431b18e53b50d4.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: e272dca2-3916-4804-a73d-08dcf39287e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZAntSbk7308R0ECzHwNSWtuUGAc5ikGMgglXog5Vjg2EScIkSnVobC/XPHz?=
 =?us-ascii?Q?wvcydI94uf/Hbg+ZT5mDAJDv0/ap+LN0m3j6N+y5Cx3z3A/WXbmWsVG9lTUL?=
 =?us-ascii?Q?9hO0cRMxVdZ1nXuUypzOY0ugdz/0Ht5i81AcsPq/JhLvUf/DY5+sLynOfSUR?=
 =?us-ascii?Q?M/Rs747eRRnfKnyazCH86VXv79KnjvtBR9PnmaPb8DUZo6dNE/PKYWfdhsP1?=
 =?us-ascii?Q?+pooltKz836fWehGZQcje+WqTDbjBX0H+KfwJZYzT3kNFlTIzm4ISCRj2JY7?=
 =?us-ascii?Q?cp67ZFmidfCCbgnsbo51YhaSwjiJHtBo9BY4OOlY0/Uv/ZD23snoMiK3gZZd?=
 =?us-ascii?Q?3LFqAVz+lgqh4907xusrt/3fdWsX8hi0/NraPB+i7Oa3eFnnVF27RKyqz53I?=
 =?us-ascii?Q?rk66obJ4UBjtIRBv8wAeQxWIfO6CAEU6dbJx3PIlF36XPZP8gqIw9j63Y0th?=
 =?us-ascii?Q?STXhFhNf20uz5eSKZDqoue9W6CRuhdugLhv/D+QaeSWcBC5uvH/vIC0Xs/dE?=
 =?us-ascii?Q?/o8UGijn7biE6Dbq2ilkrGAeGw2zOCOhPZaboyuStZ1ItV4qGJydCTF0zdzE?=
 =?us-ascii?Q?S0AH1ixN9L3dsLsCJa4wrwYfUkRMf9gpsCP7JMuuOkXrMWPLJI4NjFZPv5/P?=
 =?us-ascii?Q?rOcy6TspRaYvP0DDGzFoccGhQBoIRsP8XuMYlXroTGMBjMeA7rdBC2BOPlJs?=
 =?us-ascii?Q?hWgyQMx9PmZzG6D+CCkLuDQxBZT1fgxoTIbwmLXKJ4VgjqTYWPTutkXLGy4E?=
 =?us-ascii?Q?AhagvyGdl8/uQAwC0vO4AZZjqDHjjXW+KcTd92Ep47yQlknnD+xIrtEm3ZkK?=
 =?us-ascii?Q?cL+HoH1cwe/e8LgXD9tTT5kvs08IeGhJIDfhFEr0SiCOgz0mM/+6jDJCABs/?=
 =?us-ascii?Q?szjLsS1FeUvejf8lPQfLVbPwSnLpe7XPY5CErlMqcrbvjkU+U3PAndQS0eNW?=
 =?us-ascii?Q?Q+cZHbedWx+peo7FcCX4vBxIb1xpgsZSr5aPImDkB+aOWAyhbvKafglqfy9H?=
 =?us-ascii?Q?l/c3f4OjP8LXSsuwbRRusRjhkwNyNt9egqGkaHyGd6FI9ASvIa+ivLnW8pmb?=
 =?us-ascii?Q?SermIfOreGTqT8EggcDXTui/HgsS9YicwQ7ySuqcBGjbXyx789sB6cZcCZrh?=
 =?us-ascii?Q?4VjALEE7+4PGskkRdcQd2Z779TQ8DjnVUqurgmsrqatfcbgpJZ6aF/MjncOr?=
 =?us-ascii?Q?6BQmbQOqepaMdGB0D8geMX2a9VPKadh2xNPqav6KYiAUG469Mp9mjHiXjM2O?=
 =?us-ascii?Q?nqBHlpMcRaNxGLfIzRRXkgdJCrnBJLYF/ef0FfSyVgDnOTgmCez/BZsYHUdA?=
 =?us-ascii?Q?Z0bt533v6hsplFUvfSAchoLWD4pwAVBQo970c0ZsyJuklVJxn8N41g5t3TZ9?=
 =?us-ascii?Q?fg1VUtSq62mZ14HHRwPoArXzRKzWpWPudGOeMYY1hX+lFgHLrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:43:04.8470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e272dca2-3916-4804-a73d-08dcf39287e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943

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
 arch/x86/include/asm/msr-index.h   |   8 +-
 arch/x86/virt/svm/sev.c            | 251 ++++++++++++++++++++++++++---
 3 files changed, 236 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 89c1308cdf54..bf2485bbe184 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -449,6 +449,7 @@
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
+#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..3f3e2bc99162 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -644,6 +644,7 @@
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
@@ -682,11 +683,12 @@
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
 
 #define MSR_SVSM_CAA			0xc001f000
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 043b2582e10e..f4f801f1c328 100644
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
 
@@ -107,6 +111,9 @@ static u64 rmp_segment_coverage_mask;
 #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
 #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_coverage_mask)))
 
+static u64 rmp_cfg;
+#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
@@ -196,7 +203,49 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 void __init snp_fixup_e820_tables(void)
 {
 	__snp_fixup_e820_tables(probed_rmp_base);
-	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
+
+	if (RMP_IS_SEGMENTED(rmp_cfg)) {
+		u64 pa, *rst, size, mapped_size;
+		unsigned int i;
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
+			mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
+			if (!mapped_size)
+				continue;
+
+			__snp_fixup_e820_tables(pa);
+
+			/*
+			 * Mapped size in GB. Mapped size is allowed to exceed
+			 * the segment coverage size, but gets reduced to the
+			 * segment coverage size.
+			 */
+			mapped_size <<= 30;
+			if (mapped_size > rmp_segment_coverage_size)
+				mapped_size = rmp_segment_coverage_size;
+
+			/* Calculate the RMP segment size (16 bytes/page mapped) */
+			size = PHYS_PFN(mapped_size);
+			size <<= 4;
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
@@ -302,29 +351,17 @@ static bool __init alloc_rmp_segment_table(void)
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
 
 	/*
-	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * Calculate the amount of memory that must be reserved by the BIOS to
 	 * address the whole RAM, including the bookkeeping area. The RMP itself
 	 * must also be covered.
 	 */
@@ -336,11 +373,11 @@ static int __init snp_rmptable_init(void)
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
@@ -348,9 +385,127 @@ static int __init snp_rmptable_init(void)
 
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
+		/*
+		 * Mapped size in GB. Mapped size is allowed to exceed the
+		 * segment coverage size, but gets reduced to the segment
+		 * coverage size.
+		 */
+		mapped_size <<= 30;
+		if (mapped_size > rmp_segment_coverage_size) {
+			pr_info("RMP segment %u mapped size (0x%llx) reduced to 0x%llx\n",
+				i, mapped_size, rmp_segment_coverage_size);
+			mapped_size = rmp_segment_coverage_size;
+		}
+
+		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
+
+		/* Calculate the RMP segment size (16 bytes/page mapped) */
+		rmp_size = PHYS_PFN(mapped_size);
+		rmp_size <<= 4;
+
+		pa = (u64)i << rmp_segment_coverage_shift;
+
+		/*
+		 * Some segments may be for MMIO mapped above system RAM. These
+		 * segments are used for Trusted I/O.
+		 */
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
@@ -418,7 +573,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -451,6 +606,60 @@ bool snp_probe_rmptable_info(void)
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
+	pr_info("Segmented RMP base table physical range [0x%016llx - 0x%016llx]\n",
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
 static struct rmpentry *__get_rmpentry(u64 pfn)
 {
 	struct rmp_segment_desc *desc;
-- 
2.46.2


