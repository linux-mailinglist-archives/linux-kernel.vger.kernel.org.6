Return-Path: <linux-kernel+bounces-428365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C09E0E12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF79BB3F4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A11DF25E;
	Mon,  2 Dec 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="26mTZsI1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DC1DF247
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172728; cv=fail; b=sAMHob9j8yDoVDTRth5uSUYaE/sigMtLFKMlqowso0zKH9CGqc/Zr3BcmRPHflWJBsJiSz16u1kIES87KV96GjkckZ9uLUT9adnYPtQ5qtjYnKZJS+l6l4lmup6repC4vuFjI1gx1pEBJc9vn8xWjj2qpcm22Hm00aObwgZ6oLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172728; c=relaxed/simple;
	bh=bT+jYdSv8ptBK7RmSpaPunwKh2YhisbiKP59s+O9uow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdCa0uFFRlggj/LHqLk8+JhHDcV9zcxtMbEcWyerdHtx0zhshRQt/V38NnPu4C5JyEzm2SN/biN75aRdwNHPLq2OLuc4/4euhN8xDXHjqGsL7BTQdjR9q2lqpJ6JOL6KqSjETz5xVBLLXS2CzymUwoO4eKcWhPRO2fqra0VOsYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=26mTZsI1; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUj9T42Fn0h3f2anLMoH1gemBiw7QvM60EMYd/NYNS7MRVuCbdJ6dgwoT66SMO7i5fu2NvZutFqtD8GS8n0PWOBDd1YB6X9STmZ4f/FIk7g7mh9VeB5PjnUu31RNa8yk5eRZZWukisC4D4Qv6SvCGIaF55EnhOKl3opewgf7kN7qMCR6hG8wDy4cukkInu3u/lsq9jAaxLYRBkXUDZ9/oir4fDbgvaXQUL8JwIcDRdg/YjhuOLnn6tHvC4ZaGG1CEa4Hni2d0Yx4C6AunJeOe4IsxodMEp66k5iQ4Y6LCmsb7NyBjZfpUt2LZhLmKK9VQ36YAn70P+YG/9e3Rrx/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G3P+kN20DMYVe8Patr1z0PqKEQE00PHXl6MS+9/a/w=;
 b=Ob2v2FXVMC9mKS0/Ssu8Hnvfi4qoPX3esKZYc1hacXK5eNyYPVwX9qIwh4o8Y1yun4CryaZeCtT5+OqHZUhLwhyLhcU48Hjsipx1n562pvo+01OEAUlMZ0F9IIkSzcSHID4PmUYVzNVcctuJHMXlhe845nLFWas9F+sjN1fqeiVlI2SyVcXfpnIzhPfADjm31YuHtIyKWVkSmqxlvzdmn/JbFS8J0VWg0XZHxggvXZe3AxnQtZQ78eI3TigE63jdwQpTdmr0cJW+vhBtBXPARvF+p5guYzt/0ck15JZTknNVvcu57ENgv9ThJuSOWFxphbEq9L1a9FOC8U7Ac5sb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G3P+kN20DMYVe8Patr1z0PqKEQE00PHXl6MS+9/a/w=;
 b=26mTZsI1+18qub9Si1JsQRv+hxqR7tokcvgYoZIfZOw1XxygitsHTj0RIHdw7141maXIRsV63tptlLs9KOh3FN55VIQyBVXw27QpWmpjAzydtyX8Slsif0RdrSjpYsH1gPabvhHj51zsEZ0/LWEIFw6CSR2zAqzoQSt5vNz1WRY=
Received: from SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:51:56 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::73) by SN7PR04CA0114.outlook.office365.com
 (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 20:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:56 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:55 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 7/8] x86/sev: Add full support for a segmented RMP table
Date: Mon, 2 Dec 2024 14:50:52 -0600
Message-ID: <c3c5acb445f9cdea6d5c0f16ff961aca65c05528.1733172653.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1733172653.git.thomas.lendacky@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad240e4-9fa5-45f3-ec39-08dd131328b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O1p+KABUnzf4DDkkUp13xqF36SUDWzL9g24PmgLZmXh48aUMT7c4CdB4H/uj?=
 =?us-ascii?Q?7KPpHVJBINiRcKRICn+2FS3NngVQwqvMLno5exgQ/DPXkBNJSKXnwYjHm63B?=
 =?us-ascii?Q?t/cun4uyyg7jB2ZEl8nVkJ91sdb+1v/rooxAWZvby4xorArp8m3znxeWv3Y6?=
 =?us-ascii?Q?6lF1EYhPXtvXzGmI7CMzb+yLdqrryW+XbdgTJff2SwZ9n+x7vNXWgo4DdjE9?=
 =?us-ascii?Q?b1StEK27EJ9Sptd4Tbv2jXHYeAIy1XFrKyqvXtb6bJh7vyx/XhzNDukr2p0O?=
 =?us-ascii?Q?zQCBg8YccJjaZg4xYbrElyWqPh+xy25x6jR+LdhokCnjenpOoLm8McsR2qyX?=
 =?us-ascii?Q?Ko4LVywKiNxWgebmQazD07GFwY8MF1iOoGTSgM19K8HuDD9NArT4kI54IFYw?=
 =?us-ascii?Q?NfbhOl4QUrE2l+76zVB8ddKy+2Buun24JZCwQBsRia3VlT93wMJry0GNatgY?=
 =?us-ascii?Q?mbqxOtS2ddDV/mIhMNcyOH5G0poUdqoxCGFClqweyAtJU61TAl9/FHfMI2Uz?=
 =?us-ascii?Q?As4YJLiu9ZbOfbTfe4n+cF49E1fqtGvSV3kOnTRSLAzjGLRoY8MPQpEGsnj/?=
 =?us-ascii?Q?1ePOIfOfHeewQzmZUfX9uTgPsAymUTXLYYeHhe/qlIe/00OIXihAx4ExPk8X?=
 =?us-ascii?Q?tQrI7O7pEqoIGljxdHwjSnWNOLtofOuZ/Xr9Hl0JpGzLayhMYFbUi2+pUosO?=
 =?us-ascii?Q?aj64igpWjLQBCrQqRMVxdOT+OpJqiZF7zPBlQemFZi4hVJhtN93fUoc6rJL5?=
 =?us-ascii?Q?xyR1lFhba+J4OTfHiYdbTC6q7f7SwBxMLrRbQf7SSUiAfU/1UK1J5QVhEF3g?=
 =?us-ascii?Q?7Li2szUhbjMzaBrWk0XAsonRbB0IlZeIHaXepwOLdJlFglu2qOwsk2gWGQPm?=
 =?us-ascii?Q?WG9sOEJQObDF7Qk0lSohJ+BP/5L30M2V7MZm7dw50a9+tuzOuoDDxfkY/7qW?=
 =?us-ascii?Q?ZJP4qiW0xbxh7be5ElWr6GWIARRMwcFAWTdhvuxApFtzc5zCpNfjvW8gdFhr?=
 =?us-ascii?Q?vvPB9YdifZ1sdz29hlUljcWivEEPjj3soHlcPSEQQGGiMZI/5yvv0kgmwVwl?=
 =?us-ascii?Q?a1P78czNSAdP0ObIAORDOpB/nN4KWLD+SAPMRMtlNmtJwu9dmlGhuClmzp9C?=
 =?us-ascii?Q?w3qcvY4xcj9xXO6qxxLrRXK84OlqhrRrg3RjWIb5/gwEny5uCD4OqQWD/p9x?=
 =?us-ascii?Q?PaS9JP5V2w3/K9TChasBqxYXDzMyNqLxZMYn5Na/+0vf12OYmMOrGNLoTMl0?=
 =?us-ascii?Q?N1XuEygN2PTcEXAE6dOSftlHgcebk9qrgS+svXJ7GO1RJxV9WhTfecT+VlZ8?=
 =?us-ascii?Q?c+2RQuDzscOdfZzq0qRIl6yXh0NpX2ugYT/fqOjjjWGaojq4Re5XIce3pzmP?=
 =?us-ascii?Q?jh7yADMG3ZkXIzAypou6Ln8rQO2uqoY34B0BHxpPw0LP5ZeDS2ATkoiK7qEx?=
 =?us-ascii?Q?zcSjU46A19paSflPdL37yfLNyjnedl1F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:56.4145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad240e4-9fa5-45f3-ec39-08dd131328b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

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
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   8 +-
 arch/x86/virt/svm/sev.c            | 251 ++++++++++++++++++++++++++---
 3 files changed, 236 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5535edc6e8d7..6a6db7cd97cb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -452,6 +452,7 @@
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
index 3272a73d3594..31d653db830a 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -100,6 +100,10 @@ struct rmp_segment_desc {
  *     a specific portion of memory. There can be up to 512 8-byte entries,
  *     one pages worth.
  */
+#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
+#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
+
+#define RMP_SEGMENT_TABLE_SIZE	SZ_4K
 static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
 static unsigned int rst_max_index __ro_after_init = 512;
 
@@ -109,6 +113,9 @@ static u64 rmp_segment_mask;
 #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
 #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
 
+static u64 rmp_cfg;
+#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
@@ -200,7 +207,49 @@ static void __init __snp_fixup_e820_tables(u64 pa)
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
+			if (mapped_size > rmp_segment_size)
+				mapped_size = rmp_segment_size;
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
 
 static bool __init clear_rmptable_bookkeeping(void)
@@ -308,29 +357,17 @@ static bool __init alloc_rmp_segment_table(void)
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
@@ -342,11 +379,11 @@ static int __init snp_rmptable_init(void)
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
@@ -354,9 +391,127 @@ static int __init snp_rmptable_init(void)
 
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
+		if (mapped_size > rmp_segment_size) {
+			pr_info("RMP segment %u mapped size (0x%llx) reduced to 0x%llx\n",
+				i, mapped_size, rmp_segment_size);
+			mapped_size = rmp_segment_size;
+		}
+
+		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
+
+		/* Calculate the RMP segment size (16 bytes/page mapped) */
+		rmp_size = PHYS_PFN(mapped_size);
+		rmp_size <<= 4;
+
+		pa = (u64)i << rmp_segment_shift;
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
@@ -420,7 +575,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -453,6 +608,60 @@ bool snp_probe_rmptable_info(void)
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
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
 	u64 paddr, rst_index, segment_index;
-- 
2.46.2


