Return-Path: <linux-kernel+bounces-445026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241999F1012
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CD216A679
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6D1E3DEC;
	Fri, 13 Dec 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xvDhYeAx"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD41DF759
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101761; cv=fail; b=VuGHdLDs3YTbWLOWjPepqzyDumZRdhS2OpgbAQiV+jO3KmxganoWgv5F6s7EXxHHdPZEWUX8lydmovlyUmWJeXKnYqBMyxTX6Lo60k+64y0NtaP5/kNr5MO/FgVRqcYHpDWURMQhIvrq4kfY5YMNWhmDSJ5gg0ugYS03nnrhZQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101761; c=relaxed/simple;
	bh=Wrqacmigud7fis7uII4f5XZC7/s3Mym9ZkmaaRGXmD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROAgT3n4lN9Qk1l5R5OUxFZGIgCgL8HxLrPnDuH2j/FvULBbUGDl+CPFU3OomZPj+KXXMqqJ7TAuryeDhErbO23we6AlJkXpldB5+4LkGbIgQXEMeKoTMl7IBBdHD0NDVKFwxQtX+3BOlx6Dd5OZdn8aRzPR4MET97tXJwk86EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xvDhYeAx; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWQWWPfuPfw9JoYtby6j+A+nDQU36rS8uFfT8J6YVLBEDdbPrCNPUsOYsXk4mlqW2k68GO+hFVM/llum3M2WgkQrD5EpB6A49M4b23lbMZucO1RNQlKAua3LXp5HSKZIPfq8BQTCdZ1wT16WRHXpuYiq0h0Gf04p8QjrilezyxaA/NN+HIbf+IliybZNTXck12LYQ6SrIDv/ubvhOIFNd7owggAGBkVkPrfCF7rgMa423UN/X3P8nOouv792vJWAUgOsDQJXV7W0O+y4M8eVr0nEIiUXw8rTamSFNgYjr5Qahbp3BbS3XlBHGZgcQN8vBh8L99KHbYOJiBjfdObT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONcDfZdJf8jv5js+y5QT9bHmiGJtEAEYS53dKL7kjME=;
 b=jAbWypJ7nf6WrIS/vD1KyfHWpxmiIfRKbx4IXEzupvdvzfv6ShCN1+EYTUJjdtsEkBhI1d+yYZSekH4MPqKoCG5+m1rVeBrLmo0uULrC8+0ZR9qNoucvWqZg2+T0GvNQvayIxwJ66CQtKn+jlnpyd2uJCgWc8JbMWsqq2EzmGjC4GBew9IJhWnUtApcwTni4mPborALxF9tstbwcZPcvQR5Pfxn4SjrSdZocLj7JUJ6v6r1akWlXZeVHbD2B0rrJ9xeRRmjM+3idVKPloJn8VM5XcgBgwfWlnUd3CoDGX3O+VCeV1qQlgl7ls212dU6XEMlTD1na7vNACiPp9wG7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONcDfZdJf8jv5js+y5QT9bHmiGJtEAEYS53dKL7kjME=;
 b=xvDhYeAxHpFPc0aIB6yr2TXiQFVKY3WzjgGGIBRsFCFB4Gh1YOdx4Th1pm5GGftLOoELS9cNd8oxnsx5hX6TcqG3zw5AH0BwQ+1r7Zen86/rBe+ToWF148sfDewBCUKJfZ8sxmS9GarbqgqPxS3F0g303D9nQPbXT4vGrUy5uT8=
Received: from BN9PR03CA0421.namprd03.prod.outlook.com (2603:10b6:408:113::6)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 13 Dec
 2024 14:55:54 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::65) by BN9PR03CA0421.outlook.office365.com
 (2603:10b6:408:113::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 14:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 14:55:54 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 08:55:53 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6.1 7/8] x86/sev: Add full support for a segmented RMP table
Date: Fri, 13 Dec 2024 08:55:42 -0600
Message-ID: <02afd0ffd097a19cb6e5fb1bb76eb110496c5b11.1734101742.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241212154143.GDZ1sEN_ANTQrd1GAW@fat_crate.local>
References: <20241212154143.GDZ1sEN_ANTQrd1GAW@fat_crate.local>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc43db3-7d01-4d03-1400-08dd1b863e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ys+L88DIHylub0H/HYL/V488oK4Ht/t6zTLRUNpMfSnlVN3IzVHvDw8OruXl?=
 =?us-ascii?Q?kIgrSZ23Wc2arTPDyOxXDb8iFpYAkKbYpkQ2+R0mKPwTSUdcNFUu5Bc59qKl?=
 =?us-ascii?Q?D7hYLNXLXmwZpTP5Ns8wXGIybXtlTx5Y14dfBxJWPqyakyg3Uo+zv/YUwx5f?=
 =?us-ascii?Q?9k7mvPg4V6ezl7wT7Y/7X9Jm9oLL02kGXxi68l0Jf4cVUKb4jPknZwV/EgWb?=
 =?us-ascii?Q?Cg725FDylWyesM9N6vaHigRc+bqYqfHg37MIO/nbm5TYgXPTkJsbkkmte5qH?=
 =?us-ascii?Q?tSUnXyePQ8FjuxKx0JCZYjhN+v9ILSWAkHOqKc0yXOtgASjCUcQrITNzKFU/?=
 =?us-ascii?Q?tBjxo4B+rpRgAEA9xieyUbw8BVVke88HASsXRZ0LHjphLCnZlSEbIEQNUBvr?=
 =?us-ascii?Q?EyMgGqruSC8tFWc546AJk1z4ZNVWiEhNqoLAFj2MbZ7DH1+2QIEjTxERVaS7?=
 =?us-ascii?Q?eg7Ko85/8XhYo1p6qDF5zz1K+GuTvtu7OTPkWv0voSUFANnJSX9EdegUFuEu?=
 =?us-ascii?Q?gz+iJWY4fXF65htRMuodb+HWHVSlIyfdlwOIS19vlnd2dUtFwJhjWXpBIcBr?=
 =?us-ascii?Q?Gh8WLUBu+2fbi8SV76oWRAZHtwsDHlUWmeYIFy8IqyMtR9mIz63wcyXY2sNu?=
 =?us-ascii?Q?lYn2cnqNUc0TMYhWBnZ/J4KjLymJxG136sbyJx+eKALs5sDOCF9Fu1VrD37r?=
 =?us-ascii?Q?dTkgPCp/7N4JIWr6HJNUrFFFyPBe7u7x23p1LVWrxmyr2aNN3kQDcWOR9uwb?=
 =?us-ascii?Q?Sb3sJxdUBHFiyw7nRMPXa/FMu/Hzwx1f7WmYK5j3V+eUpaxUQVvIS03dnGZY?=
 =?us-ascii?Q?i4Wr4DI38rDV3k4qDgir76FC22fFMCmSuPVIJYHsEKaLLPe6vbKCbxZj2vQi?=
 =?us-ascii?Q?MD5G9dH0eYcxh0IZZjXwCqbl5QS+7O4nYaGwG+XL6R8eWCAG5+srPzexgd0b?=
 =?us-ascii?Q?AA7Ia63mWDeNBnR10VEeo83GgTBmyrCaEPI/RXdTSIZHiJaGmxb0NEyloWeL?=
 =?us-ascii?Q?vM2pEG6OOGKl3Jsx6SceIWnb3GyeT1MGlX6AcVcC1tOyuwS1Cy/G8NtEFrso?=
 =?us-ascii?Q?jw8/YSJqFwJzUQuZMs4KnLCCF6ZFeaDNnc+InS34NfUA3xlocZYUX6ViexFz?=
 =?us-ascii?Q?iDyo6+VNhECauReAfce3zwW1OaJQYRHTxOR9AtP0lEq8cngbA2CWY5YrCMbz?=
 =?us-ascii?Q?MnWOJiGNi/CvwIh3X55QSK0DZ6NO8zZ8Rwwy9jp7oSHwUpgXg5RDvu9ubC+H?=
 =?us-ascii?Q?86eIVMMJI5uiNG2agR8DqUrFZrK2TB0RZizZ9K1lcjkaUdHkmgTy7rUiIMuU?=
 =?us-ascii?Q?KLZrTtQK/wAG7nInKe8DKdFRrSA7c6eXFa12Mo7oX9nclUbIMffUZoUl/cGo?=
 =?us-ascii?Q?PW1rPc6caSBQNHHYMPe6+9HO0+8BqPqGQw1ZuQWetoOeyYZAn3jv6YBrootS?=
 =?us-ascii?Q?d4Nty4qEND+ymtIk/Oh2rWxOPY+SDJLY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:55:54.4329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc43db3-7d01-4d03-1400-08dd1b863e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

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
 arch/x86/virt/svm/sev.c            | 260 ++++++++++++++++++++++++++---
 3 files changed, 245 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 364e28fb98cb..935d44cc4db8 100644
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
index 3272a73d3594..cf345dbb99fb 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -100,6 +100,10 @@ struct rmp_segment_desc {
  *     a specific portion of memory. There can be up to 512 8-byte entries,
  *     one pages worth.
  */
+#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
+#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
+
+#define RST_SIZE SZ_4K
 static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
 static unsigned int rst_max_index __ro_after_init = 512;
 
@@ -109,6 +113,8 @@ static u64 rmp_segment_mask;
 #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
 #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
 
+static u64 rmp_cfg;
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
@@ -197,12 +203,62 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 	}
 }
 
-void __init snp_fixup_e820_tables(void)
+static void __init fixup_e820_tables_for_segmented_rmp(void)
+{
+	u64 pa, *rst, size, mapped_size;
+	unsigned int i;
+
+	__snp_fixup_e820_tables(probed_rmp_base);
+
+	pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	__snp_fixup_e820_tables(pa + RST_SIZE);
+
+	rst = early_memremap(pa, RST_SIZE);
+	if (!rst)
+		return;
+
+	for (i = 0; i < rst_max_index; i++) {
+		pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
+		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
+		if (!mapped_size)
+			continue;
+
+		__snp_fixup_e820_tables(pa);
+
+		/*
+		 * Mapped size in GB. Mapped size is allowed to exceed
+		 * the segment coverage size, but gets reduced to the
+		 * segment coverage size.
+		 */
+		mapped_size <<= 30;
+		if (mapped_size > rmp_segment_size)
+			mapped_size = rmp_segment_size;
+
+		/* Calculate the RMP segment size (16 bytes/page mapped) */
+		size = PHYS_PFN(mapped_size) << 4;
+
+		__snp_fixup_e820_tables(pa + size);
+	}
+
+	early_memunmap(rst, RST_SIZE);
+}
+
+static void __init fixup_e820_tables_for_contiguous_rmp(void)
 {
 	__snp_fixup_e820_tables(probed_rmp_base);
 	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
 }
 
+void __init snp_fixup_e820_tables(void)
+{
+	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
+		fixup_e820_tables_for_segmented_rmp();
+	} else {
+		fixup_e820_tables_for_contiguous_rmp();
+	}
+}
+
 static bool __init clear_rmptable_bookkeeping(void)
 {
 	void *bk;
@@ -308,29 +364,17 @@ static bool __init alloc_rmp_segment_table(void)
 	return true;
 }
 
-/*
- * Do the necessary preparations which are verified by the firmware as
- * described in the SNP_INIT_EX firmware command description in the SNP
- * firmware ABI spec.
- */
-static int __init snp_rmptable_init(void)
+static bool __init setup_contiguous_rmptable(void)
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
@@ -342,11 +386,11 @@ static int __init snp_rmptable_init(void)
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
@@ -354,9 +398,128 @@ static int __init snp_rmptable_init(void)
 
 	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
 		free_rmp_segment_table();
-		goto nosnp;
+		return false;
 	}
 
+	return true;
+}
+
+static bool __init setup_segmented_rmptable(void)
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
+	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rst = memremap(rst_pa, RST_SIZE, MEMREMAP_WB);
+	if (!rst) {
+		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
+		goto e_free;
+	}
+
+	pr_info("Segmented RMP using %lluGB segments\n", rmp_segment_size >> 30);
+
+	ram_pa_max = max_pfn << PAGE_SHIFT;
+
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
+		rmp_size = PHYS_PFN(mapped_size) << 4;
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
+static bool __init setup_rmptable(void)
+{
+	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
+		return setup_segmented_rmptable();
+	} else {
+		return setup_contiguous_rmptable();
+	}
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
+	if (!setup_rmptable())
+		goto nosnp;
+
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -420,7 +583,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
-bool snp_probe_rmptable_info(void)
+static bool probe_contiguous_rmptable_info(void)
 {
 	u64 rmp_sz, rmp_base, rmp_end;
 
@@ -453,6 +616,61 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+static bool probe_segmented_rmptable_info(void)
+{
+	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
+	u64 rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	if (!(rmp_base & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
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
+		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RST_SIZE);
+
+	return true;
+}
+
+bool snp_probe_rmptable_info(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
+		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
+
+	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
+		return probe_segmented_rmptable_info();
+	else
+		return probe_contiguous_rmptable_info();
+}
+
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
 	u64 paddr, rst_index, segment_index;
-- 
2.46.2


