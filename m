Return-Path: <linux-kernel+bounces-227375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC7915024
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A890F1F215CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1D19ADB5;
	Mon, 24 Jun 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IfY3fCT8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19F19D08A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239902; cv=fail; b=S/1bfmAlNbf8m6hyXyyBqLz7ixzKcGAqy2/MfetgCTOBwY+5ItkfHBm+254EeemEmuTNhYPsZiY78C6MG6OdGz1dV0slzKP186JqY7MzhyiAIgcPe+xjb429F4Xgf4yJTkBoZrPR5RX5hMduWwE/SMxqxFMUsLEUxta9LpkidRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239902; c=relaxed/simple;
	bh=tnUf1nen/39RX3YPIZxwIHQkoCe18D20cj3H9iNWFbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWrY4KZtb8OgevGX6T0hx7FLsClahJErKJEXB9+v7g5mkg7CcoqUJH4fNRfR/PFrjXmKzi1ROy2y4mOuLPJj02XPW1GKQRwbdgRYF9vM9HxgAmDCWMyP7AMo4MEwtik95925mFV0hEmcBQ0/Z2Oe21fbvo7M4vutpgsIncwFEYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IfY3fCT8; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmletWYlwDKLsHxr1OlK5PoCeBhp4GWGh3bSgNi3FNZvUG0XMVidBus49eUzMpvRCIHZ/Qj1TuHVS3mS/DNv0ma27xnRldNI+pGiLobbkvNipzx3lXdLX0umLUuXq30beyP0bQWu8r0AKaQ2td21dWlX9E51hEL7Ueor+aAVCniQ3fZ6Yr+lHHzuZ2+eSOmgfsJxBe1OfBbHLTJvpp8VVzFt/0HtZT21MY0BP2qs7dnZr6YpBaFLQfKxxWF4o5WIjDi9BUoEINaaarGjQ52Q7ByCA5pqgX3dPdXvy4SceY6xfrifJOqdIksTFxfumpb15F454kJZ/MT/yQ845rPauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IcdWbIj5scg/jrPEJZsL9gNzM1JPV17mgYF2a1IoLM=;
 b=aWDTev8SayAwmLk3FJhIs4PMQs77LIuXLT5ngRxb7BNHGodhimO/HePe+diwjzuFPGecS8E+0TREJTPbCQDuLfOktnxSsFV1X/qAE45JJ2VlfmlDHRGZmnCHSqzhi7bLJLpLNcsNMzg0kmQqxDAIBHEgY6WqpxEm2lOZZT8BQilQAqSdoLIwURUAPtZcU7TF2osYFnlhElEc0l+NH9kznW1ZoReHy3FGJPJBSXf6iKGyT2l2bjiacktQLvXtoWf5Gpntt3PRLgo8rCdt20nMXFtqVNphioYFg1H7EraPweulOLlA+i5K46ueCZihS+8hpNB87FDQHlnZaxjz70UDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IcdWbIj5scg/jrPEJZsL9gNzM1JPV17mgYF2a1IoLM=;
 b=IfY3fCT8D1sstIGkXioUYdVIRes8qd9lkKAbnRAQKkuin7sdxU+CJEKzNsTm220/IrAY8xyfb6v09pJbo7Jcw4UBVOJ3VzPoSzUdRmdWC30Fa3MoKV+iJDEOYuECIdSmUnsU+STGGocCuF3D2UFS+cUIkB7UqaRGiP+LFNK0Hk8=
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:38:16 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::fe) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Mon, 24 Jun 2024 14:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:38:16 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:38:15 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 7/7] x86/sev: Add full support for a segmented RMP table
Date: Mon, 24 Jun 2024 09:37:11 -0500
Message-ID: <e730974372c453e4685d5744da52171f4b934614.1719239831.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1719239831.git.thomas.lendacky@amd.com>
References: <cover.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 770067b8-a96f-4b49-0b12-08dc945b489c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GjONkNGe5hkN0WCuWTAMyI5X7eZ+6Uopu0sFs9P4QJ656DMZwflbuiyo9kL1?=
 =?us-ascii?Q?GSlhGY66RLH191ZPuAhFLV19Dx+tn2Q4ddAuqkK4ka1fwyeDRa4WJo0Sd24E?=
 =?us-ascii?Q?CeMB/u6zNhkTAUeUJB+XnDq0Qk4bQ7obDcMyLJJXZmOYv8Df4rJdkCllLYuh?=
 =?us-ascii?Q?qHxVlq0E7XPMmZzIZTqjkNTlj8AfXuI+4yX7mn6sMdMyqXTmei4KY52xsxkP?=
 =?us-ascii?Q?S60OerNTWH2qu3eMuRyhZae0FxJgXLxWcRDOwB52wUp7sy99ifeAQANTc0He?=
 =?us-ascii?Q?C+Nocrcp25ayi8MPExChh4sFzpc66G4Q4CcMISRb3F+fqjQJtQhSePQ2zc/S?=
 =?us-ascii?Q?CUn94R9ucozbVusOc8P1eq/skI6L/QndrPfEnn0ycjr2J4/sFawHKb8t5y1r?=
 =?us-ascii?Q?UKLCrtWIRcl4kM403Al5dFk3tHAXaj2QMzTkuNNpYMfN/mrs2Pp0JzUS6Ue3?=
 =?us-ascii?Q?qd1g3YQ7n2WlXLSXb+Dth7Lh3oZv41eHMUcjttUbEpIVvOpEAe49lHp9tVAB?=
 =?us-ascii?Q?qRDkjd4/8FyQBzYvgb+aDCFEj1rgvFZZSW7N2PGyu7jGAaYI3j6B5jLPJHZ5?=
 =?us-ascii?Q?fuGOMNFjqEVT2TI1BWfeJaKdrgprSfsKbYmr0RIHKOKnKs7j5pU8/4jlQJ28?=
 =?us-ascii?Q?uQVKpoItEjrV+1PS+q0Xm0XJi8D6IyWJu5JSdZkQjNvyxUYuCtn1PYEgZOdb?=
 =?us-ascii?Q?MS9AM8AD9cjmOwdXWb05/1gK7VuQDkMeqlrRC2IjahuV4A+qLa/pPJ3yKH8p?=
 =?us-ascii?Q?dGbUdopTPJp4zyZnFnkx0Zia9Cw7nOV39sZIwdIxKsC//LfvhaewpwKe6DiX?=
 =?us-ascii?Q?l7TdUWKmWShxgD6ikaAbfPgReuegPZDEgqArynIEqE/QrKw0+KVcIzXDSTNF?=
 =?us-ascii?Q?arrXbZQYmDYNGz58qKnLuHtWihm1iOs4KY2RYjNLBoM3tIXr/fiM44c8w0AM?=
 =?us-ascii?Q?KSBCy2E6yCja3yJXECtDoqjy5odTfxdsIw4ciUul7CWHsXr1Rrg6Ni5MJ83d?=
 =?us-ascii?Q?8vrY0ChLRPtlB2GJM6AhYlraG95lOQcpTkMt/EgccobA50gr3sD9hBvYM5j/?=
 =?us-ascii?Q?GAv6AMfyUfJLR9tB/3kj9ICh+YQo9Qt/hdcHGaR7IAA8Am1LaEmXoWUcKUAz?=
 =?us-ascii?Q?e2DZNA6f0/8anJsRR8iDuM3loIb6t/pszTZR4d5wEqy1W4/PMTYt7CWJQnYy?=
 =?us-ascii?Q?wmqW3NtXjVhFw0fZAZ8D8SQoNeF7cOkHDzVo6xQJcvSjFa6R2amyzKtdCeYK?=
 =?us-ascii?Q?NcF9v29e/KoQIRuHRBNstye4d2adDmCFpErS4n6XqRa0C+nv65gvtBMIsn2p?=
 =?us-ascii?Q?n1OoLq6CahCerp53DI9QLNa1Hf8odZlknlS9KTalPZy2jub28jdjTmBI9TTA?=
 =?us-ascii?Q?W2+/7Em+huLXYV+jSzfCOFI6wfkrauBTvYyZXjl+tM8DQL61ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:38:16.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770067b8-a96f-4b49-0b12-08dc945b489c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114

Add support to detect and initialize a segmented RMP table with multiple
segments as configured by the system BIOS. While the RMPREAD instruction
will be required to support a segmented RMP, initialization and debugging
capabilities will require the mapping of the segments.

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
 arch/x86/virt/svm/sev.c            | 240 ++++++++++++++++++++++++++---
 3 files changed, 225 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 627bd9b3f1ba..6bf3bf8a6859 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -447,6 +447,7 @@
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
+#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
 #define X86_FEATURE_SVSM		(19*32+28) /* SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 45ffa27569f4..22c807d1c08e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -654,11 +654,14 @@
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
index ebfb924652f8..be63262ef3c6 100644
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
@@ -216,11 +258,12 @@ static bool __init init_rmptable_bookkeeping(void)
 	return true;
 }
 
-static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
+static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa, u64 pa_end)
 {
 	struct rmp_segment_desc *desc;
 	unsigned long rst_index;
 	void *rmp_segment;
+	u64 segment_pa_end;
 
 	/* Validate the RMP segment size */
 	if (segment_size > rmp_segment_size_max) {
@@ -229,6 +272,14 @@ static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64
 		return false;
 	}
 
+	/* Validate the RMP itself is contained in the mapped range */
+	segment_pa_end = segment_pa + segment_size;
+	if (segment_pa < pa || segment_pa_end > pa_end) {
+		pr_err("RMP table itself (%#llx - %#llx) is not covered by the RMP mapping (%#llx - %#llx)\n",
+		       segment_pa, segment_pa_end, pa, pa_end);
+		return false;
+	}
+
 	/* Validate the RMP segment table index */
 	rst_index = RST_ENTRY_INDEX(pa);
 	if (rst_index >= rst_max_index) {
@@ -302,24 +353,12 @@ static bool __init alloc_rmp_segment_table(void)
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
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, pa_end;
 
 	if (!probed_rmp_size)
-		goto nosnp;
+		return false;
 
 	rmp_end = probed_rmp_base + probed_rmp_size - 1;
 
@@ -336,21 +375,124 @@ static int __init snp_rmptable_init(void)
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
 	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
 
-	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
+	pa_end = max_rmp_pfn << PAGE_SHIFT;
+	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0, pa_end)) {
 		free_rmp_segment_table();
-		goto nosnp;
+		return false;
 	}
 
+	return true;
+}
+
+static bool __init segmented_rmptable_setup(void)
+{
+	u64 rst_pa, *rst, pa, pa_end, max_pa;
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
+	/* Process each RMP segment */
+	pa_end = 0;
+	max_index = 0;
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
+		pa_end = pa + mapped_size;
+
+		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa, pa_end))
+			goto e_unmap;
+
+		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
+			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa_end - 1);
+	}
+
+	max_pa = max_pfn << PAGE_SHIFT;
+	if (max_pa > pa_end) {
+		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       max_pa, pa_end);
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
@@ -418,7 +560,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -451,6 +593,60 @@ bool snp_probe_rmptable_info(void)
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


