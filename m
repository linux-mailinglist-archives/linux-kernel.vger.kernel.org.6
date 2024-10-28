Return-Path: <linux-kernel+bounces-385700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE669B3A85
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECBA1C211F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D061DFE11;
	Mon, 28 Oct 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A/nWdpB9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56191DFE29
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144036; cv=fail; b=sj3X0ZBPHY/LGKYL1RHXiRyb+dYkB/r+yV9So4YUCSrexm9i/n4dUeINtWZeH+9KYzhtl0yMrEDiHqrAh9Vti/jH1t0/a22fKL9sKFCHNoPHZrQRipnRcWrzj4g2AT8OZ5NxcEv5XzpfrQYCr5c8G9b5PdyHOC0U0DZrbDE3UqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144036; c=relaxed/simple;
	bh=OxrMk8ws3tMIuRhzLAJK1uXbtekGSTbC3orT2MR4t7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPM6i/TnHVVTSEQj6e1jZQO+FlAkcxIOybAIG7bUDgQU/XGDmg61rI6gIRyk6gh0gS4WSkCd9T0YtzMDKSwHbaWzI35gjMwjQx9pdtLEiYiXcXCBuqteYRMcENYWPbybcDdAP/3K2rWVHuxN/SMi2spFBKJKuPCxMD4N0NDUv0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A/nWdpB9; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOJdXfSxDxLw5j/g/6y3R0xJcTQixwDxBn4tbYKrl0tzXh/zHFkuk2+QYMVhH0Di7kTtBXPv+/5OljocQWP3D9FrNtkaFUTknGuHKbliJ6h6T286hxR5+AzAlOlbhGHr5UisgPHc/+pPlMI3vwhQwVKl67SurvhWi3f0BfYXB5dqWmCCc6yZuLXx7IVITQklo4AbsjhDgFxKU6Bz3GOELV8jxsc/16oA9ZuXz7elfN0JxYA29Nr6rboTig6buoooYbA4/PpQGw03IpyfeUidGErPfb1w88wMx0r6b+RW7jBWRZ25WCoQhdDyDv2FLjzpw7YaYCf/ikzVmDDiqtjU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA7vaalh1/LgqkQGsyQKBymXv0g5u5MoNxB6kCpNTvM=;
 b=MOF2tMTyhWknHFfgqq10Xhh8C/0Ur/uTZbLyT1TqwOWeiB0lfjmtUhS7XescwWEQS+VFm0MAK+4VrujulAXuZc0iU9ewUkbktayKacxWETWjxyinEaDXM9P7GjWhnPf2zwgsHiV9E4uw3B0yMrEEksTEjo3qJ8rWYmjwVoim89IU1z+sp8P7didtUYhu7W0MzSBpxR8JCKhlYrmUHXphVyxJKHakJwK1Bwf1ghTdofhrb3ipo/1IizlONaaweMPCehYldTOdyjHxdyiWW6qqAwtTUgQvS/dey87yBibFGR8U//uS4g43/5FkaiXgNFDZZ7cB+jrcBG2BRZsHbcnTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA7vaalh1/LgqkQGsyQKBymXv0g5u5MoNxB6kCpNTvM=;
 b=A/nWdpB93QEG2Poyh4QSuDpJNDRCiJANzi3swJwzCqxugGaS060KR9Rdi9DCKeqoylD8AT+TOQVy5vWpVdlXuy1x0vlabX4uaCCT+vpysRA/GsT9KilvhiiJ5tGC638CBAdn7zf5yuEHQ+WIsfDbNTMTReUN+JJsYo18MWqRKa4=
Received: from BN6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:405:75::25)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:33:50 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::1c) by BN6PR17CA0036.outlook.office365.com
 (2603:10b6:405:75::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 19:33:49 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:48 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 7/8] x86/sev: Add full support for a segmented RMP table
Date: Mon, 28 Oct 2024 14:32:42 -0500
Message-ID: <f3d398915350f8f71aec6acd3e5c1ff66185b436.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a857878-8ede-4f19-6889-08dcf7877297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swZWg4BybRdY/KjHvp4FEHFhFqhaYIspELNaJDHbDqx191WwwXD2zzQLxUPQ?=
 =?us-ascii?Q?1VY0JYS2eJ6N6mmpYjmy6VRmNLbgoSLA0HsZtOCgjZR4IfIGzQUfOfC7EmBD?=
 =?us-ascii?Q?vw1/WuYC+Mq41nQuG0b3dX5orWmpeetjXWqknASW5AFAZt+ilkzVsRjRbu3t?=
 =?us-ascii?Q?S8A41+5G1ru7ou8/2CjhEJAb8xopBiLEDir05bz88HikqFxXeGVrfBpONzPS?=
 =?us-ascii?Q?ISq1sn4gddgNDK/77k4Zg0A6PtfzbyHaAN1ShRBqNkpcS9B1hO+bfDOYc4tQ?=
 =?us-ascii?Q?YBmJSSGMLebkQ8Pbk/iZkwYNQ4krfY1SgR19qPCt9FOWIjLICqqoHvdQfO4k?=
 =?us-ascii?Q?ato0stYW48U97YQhHL2lPcUyljqsNOxgSuE6F6HHF31vxtrmyiPpP5ljoWOO?=
 =?us-ascii?Q?u9p2nlepJf8EUw93cC/uTe3D35hJBDtLnBVcaavgaxMw2yenZ1BeLu3EXWK2?=
 =?us-ascii?Q?cYKHo92u3kFe2uBZB1FkUwuCr8qHYSd/FbZCti8xOGIS0G0TKk86ztjlXzDP?=
 =?us-ascii?Q?qknE2qg07IoEajBJmIyMH9eRRUQjFtlekWQ8jR21xfqzMa9bDuzxTY0Px2T6?=
 =?us-ascii?Q?7ikES3o+3qOp1Mrdod1RLFAGCCdariHSPwbM7V8Aal80TUNdz1q56cX+XrhY?=
 =?us-ascii?Q?hdlkSPfA6myMW6jWrc3CGDRI3yU3xQSwb/j5Zi8EoQzDaFDNeKOhRmjaQ/P1?=
 =?us-ascii?Q?COLg0aY/1HYc2gNkTy+vBcuL1BxFhfZ1cEaBZv2034P71TZyZoaXy68Iyw0v?=
 =?us-ascii?Q?4dOYWvUgdxo3neExpX9J4MjIVrbVFwmrofGCtFKBY2ywahMMWUAoKeAtFZnh?=
 =?us-ascii?Q?jUCOGq57Nt7JtidBe/W3D65Ubq3c0t09bpxaSxzWwJOpGNFTqfPe5nwgsWOq?=
 =?us-ascii?Q?x69Mult1VouEpOf7c1TXCbjoxe8nqgTTw8C8ve50eyvj2FgyIVcPf3krxBzY?=
 =?us-ascii?Q?Ka4cileDdt2tF0CmhbcNLmtji41VcWj5QQtqH3/vPf+jgkXELQ9SGRX/mQrF?=
 =?us-ascii?Q?hOoei5rI/bz7wApNsF/5iKhI4A3CjiSxkhPy5lRYYMHmN8BC15/de+8mJW9c?=
 =?us-ascii?Q?rNk9hIyfxNXaOAwJz36Za7i6k8dqVj1BKfGik2AhTEpKUkyfIz/GImECf++g?=
 =?us-ascii?Q?9EApm0cfQMXyAV2/XoKW1SJEcT4QrWw1zp1Y7a74+HoX/8a/eHWlV2MNraKT?=
 =?us-ascii?Q?CfiOcUd3+YMhCXJ24QAR09YpgylJYwl+ufVWHH+do4JYxrlz2f55lxfzXIvg?=
 =?us-ascii?Q?M6XQtubOszZv+W7taOF4/vBBl3KwIq9HFijPmaZtNdfCDmbTZg7o1Tm04tB7?=
 =?us-ascii?Q?tnZBfHH4lLOPy5pDefcZK64l8GHqV71zVrP3LrT/exGBai00pNnQKVghM56d?=
 =?us-ascii?Q?FNJHsqGVBL7yx3lHsKPMVB6rEDZ5LQVs3gxGc7dbeRYbSJc8xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:49.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a857878-8ede-4f19-6889-08dcf7877297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

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
index d7395a55c04f..dd5481ee9c7e 100644
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
index 37ff4f98e8d1..2051c527d1e5 100644
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
 
@@ -110,6 +114,9 @@ static u64 rmp_segment_coverage_mask;
 #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
 #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_coverage_mask)))
 
+static u64 rmp_cfg;
+#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
@@ -201,7 +208,49 @@ static void __init __snp_fixup_e820_tables(u64 pa)
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
@@ -307,29 +356,17 @@ static bool __init alloc_rmp_segment_table(void)
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
@@ -341,11 +378,11 @@ static int __init snp_rmptable_init(void)
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
@@ -353,9 +390,127 @@ static int __init snp_rmptable_init(void)
 
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
@@ -423,7 +578,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -456,6 +611,60 @@ bool snp_probe_rmptable_info(void)
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
 	struct rmp_segment_desc *desc;
-- 
2.46.2


