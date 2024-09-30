Return-Path: <linux-kernel+bounces-344348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87598A898
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9E6B26B66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09E193075;
	Mon, 30 Sep 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0o48C3w"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159D189F5B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710241; cv=fail; b=HLHtLlCNniJOlP+6gJ7dF4g/LvPwgI4v9rsMPwTryv7uLkFfGApdz3B+ay6H5PyFL2/qi645leLuLjvnhQ6FKwnHwplaiBEkvcVYJbEpbh//qv0hSd8pZxwNuLIMIfaZj2K2ED3Y86/r4dwUys54nb2iN++wGZ0XwbPwBLw094A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710241; c=relaxed/simple;
	bh=FqzCiC+N/f9t5k9iYCu5vA8zIZxKVA49l5XtnBLXO2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qbk/v4quUEc8Cf2pbNQ4vwcBvXJ9jWTL5v18Bv9QqrLNdCQ5hnaIZnWYRm738+cueltI8TG0KTWW3Jz573ayeqsFtUKDTmgDFYv1egnAOjQJKy2vJTg8EFQ9TdMzGcuApNNNDCMZ00ERFfdCIUPwmW+3WXk9L/nMIOUHNe9LQTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0o48C3w; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDKtLnD9iOHQ6BHxBWrg6I0OwWhVQ+DODfq1oVqRfkf6F31cljjPZMDxN3vJiNCW56NUO+Myc6FQdtsQSBA6VLZJnStCBJvSQPPKu/mbOQJJJK283MF+RjyznsbiDN3T7dbsnU2nUWQyKe0SUk8MdWudkLqbgeO7eNDd0OTDoeXxL8LcBYsvEOfI+XL74NHCHci3bMRMRXA37WrsydZhx9LAYowapZPvu9Ke6XSKziRtWSRbwHnih1JI2uRAE9pIpv5+zGXRM/UFJzbJJM750KOjqUesQ4+vDDG4GH/mzK9PJZ/Nb8fH+B+s6SCfDuzzcD7fR2Davk8KSTYceEIiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afXyEcvsuoWCd8s0zOotz5dguSOVcmcu/XR5XYSSDmc=;
 b=n22rT3VnwY/oAE/yLmGXh4wdZTq5WAziLI8JYPC6CtIMuO/T0sg7LIdj+ZGTkKZtxCISa98JP1MZDRo4rfN49MSjdzPgxx4OQrtwlMjXy054vYmyAs47hFL36fY+HhmEmAH8ELUqki1nx1J4iKMa7QdQrVxx7sLPfVJRaugIZu0LAaGaSx1Yw92xpVA0UyrNWjs8trjCOWM+PHQHm4pb6zKNPsOkXDbQxQ+lWWsudmEeaU69E0PPgyx9yH5uDRXOSHd9YGq0U/x2zq7Hnc1p26qNMLT7OgkKnIBGhCHmmLGbs8K6UfaOsbNpQoJU4pZv8/rSvUjNTQ4eeLJMMt419g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afXyEcvsuoWCd8s0zOotz5dguSOVcmcu/XR5XYSSDmc=;
 b=b0o48C3wWRMbmw+KZb6BfbagMRN4Vh5GF1qWHG3eLatFPCu/+JYDAi0vwi4M2XVbJ2O/ryRRkIBSrmtz/eMDilD7F/Q201yWYL5QBFqFKHkCxTwDrQA6Hnci8Hb/Xrky6FXaL5n3o6liJapX89IE6SZjwMuo7/3js1ARMFJDvZk=
Received: from CY5PR22CA0017.namprd22.prod.outlook.com (2603:10b6:930:16::18)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:30:35 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::d7) by CY5PR22CA0017.outlook.office365.com
 (2603:10b6:930:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:30:34 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:29:34 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 7/8] x86/sev: Add full support for a segmented RMP table
Date: Mon, 30 Sep 2024 10:22:15 -0500
Message-ID: <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1727709735.git.thomas.lendacky@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bf838d-fd8a-4946-61b4-08dce164d3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYouQWz5P+L2K3C7ygi05UsTLTbl6DLnQPQvxcp0C3LV4aiWPyzbxpSz5fgj?=
 =?us-ascii?Q?R9u+gnILIutuHwiEC6aKhpLKx9HkpyFxT0JApH+KXJsFctQZJpkxb8BGdspu?=
 =?us-ascii?Q?rvUBbAZ7GFZQK/HsgZAqgxr6WgYbsDuEiYTeFqg/wOqIUIRMzA7Xgu3Zfb/A?=
 =?us-ascii?Q?myb4BdvDLs+nc1wqw01Qqb7sz3CMm/T+k0pGN339trGX6LqoxaD4xMu/llSX?=
 =?us-ascii?Q?ESibdXjIIfHTuvnW+jlX24MOpGM1t7kADeupVil0UWYEVm2LrVzF/ZAM1NfJ?=
 =?us-ascii?Q?H/FNUWOYcNa9LrcUEOOBNTkRq1EUb3aEB3/L+OzJbvcHyB4NJW1i122E6NY2?=
 =?us-ascii?Q?N8Q6a10ziVfVyKN17mSoXjNV+6vogcEZphkoyBC3IEzTwNv3m+WFfiI5xujH?=
 =?us-ascii?Q?tiYIiJodJNBkneQycXpuFNq+1bzK2wrUwuAc+u81199u0B3/jkRulr+EPiTz?=
 =?us-ascii?Q?xErymKcBL3h7nY46QSvxM6B89ebsKpe74+2bDeiBoz38cFBot6jrYldkjuEy?=
 =?us-ascii?Q?NdTovOT0Pn86gDcX4MV1T6ZdG7SL6ljBPWQYlD7MoMYPNhu4l6e0zlWWT2ub?=
 =?us-ascii?Q?CBwsHHUAhw9+VCNlD2N4NBgLP5LERYkNRnKalg5g73ujIBp/mOyLobgF4f3s?=
 =?us-ascii?Q?wyNblL9cLZVL+o7xui4sAcoX8Fqn3I6fZPggrBeoxdYVo4nvWSET4k2Hc4td?=
 =?us-ascii?Q?FBGAPm2kN8QyhMZdxAED+0b6qlpt22pQEkiBPtfPgpV3E/nG4cdvXkjgDHBp?=
 =?us-ascii?Q?74Qa+ZipldChhOoJm6jI5v7SGdUJY+GV/FMVY5d9Tn5auS94rZeFvxgHlB5g?=
 =?us-ascii?Q?Yiu0h4U64KPFe0MiXKcQwXHjgfz2V6oxK9dzM2o658DWm4Z12JfLlK0UUuI+?=
 =?us-ascii?Q?XEvf33USxBre9Ac3VVyd02LK13Da5gwfZGqQIOJ0MWJvvztkbcSrExnRphrQ?=
 =?us-ascii?Q?/R5ckoSNrnbw45RukI8nKm3+t/xP9Qi3uKnxQNS/4Bg4ZyyFqT0VZK3kidQJ?=
 =?us-ascii?Q?bAxb2EnabLq5Ec2eDCPqaKgQfIRDntS/IPh4em35MIPwvebatySqdyWRV3p/?=
 =?us-ascii?Q?nBk3EGGZvPyH1WcRWHKvOTlLtpNhOTf8MIKnPn2wCYHJmIQ/KrdBlaoPfhbo?=
 =?us-ascii?Q?6ARLjIDJDHxaX9dBHL5zT/ZDUnQ/MywQAYN9uGcZ4c2+yhv/gans6x7vevA9?=
 =?us-ascii?Q?9i/yJ6R5Bnl7ezATgJC0+lYH+5rAIIpRkFw9SDSm2ieCtH3qhkAaOhRHJryb?=
 =?us-ascii?Q?HR7ach2UMpkIOFaBA4IZRZJ/D0GYF/k8zoGqjCIuJD/wQJXwkOLcPTP9DlxQ?=
 =?us-ascii?Q?IPyYIl3v3gB7m7hiR0NAGxDt/g4Nwt1Id83DvXXS7oR99D0OfobDIsQ9yw5e?=
 =?us-ascii?Q?MMY3pvHHAQTBSzoxaylNpBG9UVP7RGm7mz1+pAE9zpjaFKRAQeuTTPt7yHqm?=
 =?us-ascii?Q?XuYJy9seSpWRze0djJO/9R1YR4/oLPhz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:30:34.5645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bf838d-fd8a-4946-61b4-08dce164d3f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

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
index 3ae84c3b8e6d..8b57c4d1098f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -682,11 +682,14 @@
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


