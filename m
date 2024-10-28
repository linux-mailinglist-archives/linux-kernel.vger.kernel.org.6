Return-Path: <linux-kernel+bounces-385702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E59B3A88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6592628107F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BCD1E0095;
	Mon, 28 Oct 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YcPTFIl5"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A431E0090
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144044; cv=fail; b=gQ0GojUfyeBUQajPcNQJd3FnusVO0VO2Pnk8YuJVErlguezTDJvBBPqxOKx0CVtBLWov7GfaTxAzUHSHHiq8PXNaPbuivtxBobYaihP+pG8no5ifbMmoAjPfu2LdfjIH/5uxSjfjE+Bwwk7MKQpmPYYjF0pK3OZGjiEK4iKbLXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144044; c=relaxed/simple;
	bh=Y2de6lUTpW1n177PS5GTnDQxROoZ6p4Hsl+aQ2YuLt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEtLqgvZjdP4bxyF8Pk79utilfvMWzFrUCVgftIJF9HmER34QGtgSub9R5S5oAj2BU/IPit+xwDjktMT1Opyt4Xqw5wuk+hqYFqvGqWvAzsEoZV0XmkJ8HdGLY42IBuZ/osD3HPskxOZyjImffInFE6hHLAQSaj2OYHqCWyRoaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YcPTFIl5; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc1UtuGW7KBL2AybNX0iARZktPjMy3Je5VyzQ61qdRxnbDwjS2kyggqW98z9UIz5h0pOhkLbdjWsgRxLPDApfF8oZaM4xOXkGyjypmClWt4G8foc8gcqbfipM93YnV975MtqJL0Dg/CE8EwZLj3REmKSOXRTCJ+1TM0KGZBaF28eQ+d67DvuqtOiiaoA2ObgaEkCLydlpxpFMLbYZJL7IMEg33z/QfHJON9OIGiZIBuPb6dUBFckwOL/k9ko7Mc46EblXkjjiL68NPa0Zo4yb/0zPZTEQhzbHDwIIeVRnOEt60YYHC/129L16j/myzOSENEs++Is0H/V4GnDJz1xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oKOCBMG11rkMNSBoVSobw7unon/+5oViYqKWvwSeNE=;
 b=RDI74ovp4841a0gW2K0b/f4EY/1RTyeITqe1/zkwRbDi9rwDn6HXKIq/KMfLIUOPU7b9yEZ2OwyEphewOfllE0w7wo1l0XXULnnJck1Oijm85GcT+BTHeRjkpKvLIKcoc7bydBF96+0MESSZVxUiZuhYGPbX0+BaGmAZzGj5ThfHnOlXRw2f/dAZITilaQjcyhwc4/YskS+cxOaww0knTOc9EtkUB8+18AFVL6TpQwIWnKcL5PScWRzu0bG3s3vdVBk1RoDXH1Gg1Lt8bXJA+/qJjWYmT2nirMZ/01v1hxPdEXyYwsiEod4a3N/lgPUiBMtk0AFIk4jG8Bu9fR5YHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oKOCBMG11rkMNSBoVSobw7unon/+5oViYqKWvwSeNE=;
 b=YcPTFIl5ULZfIMLa9+zlY6uueJNsjyRmaLkMZOR2YPP1enOh9sWns4OMmCr0X0zlU/MXOEBWzLQooI8kdPO+bA4JTSp/+TZbb4gFhx4COZks/Kq+ijPWaQgmx8KLhlAYPCZogmz0LSkB9rQQI0QUwbLbAi7LmJaJO/iQlIXCcr8=
Received: from BLAPR03CA0054.namprd03.prod.outlook.com (2603:10b6:208:32d::29)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 19:33:56 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::69) by BLAPR03CA0054.outlook.office365.com
 (2603:10b6:208:32d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:33:56 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:55 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 8/8] x86/sev/docs: Document the SNP Reverse Map Table (RMP)
Date: Mon, 28 Oct 2024 14:32:43 -0500
Message-ID: <93ce1f809af823eb82e557dfa627853d27aa9f4e.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: d02c07ab-d94d-41aa-e276-08dcf78776cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qk07tBCWKKJVEVCff//V5v8Ys7DMVIBLXvHDrfMXC1BUsEtrl+a1KYyeXlwY?=
 =?us-ascii?Q?Uh32p6IFq9tM5z99m2N9zqyvYxVIer3NvOI6yyoGPHvUXEg2gbWnCYqZdBsG?=
 =?us-ascii?Q?k8n32CsZ8Pco8rQECU8k3fkP+eYPaqvUaLr0ojNm14qN1ZFPfRHSS9jrfMGZ?=
 =?us-ascii?Q?z7usnq40CLpJvPhA3aiNUr1BdvxhcWoLzUbpu/CxNUXci1tGmYm9Bjz4L1ZP?=
 =?us-ascii?Q?zj9cvUdgDzVQ4018R5/TVNgeGJHRxaUs2gTfEDkWtfIkKiILQKpFMksXUqC+?=
 =?us-ascii?Q?ftlp72GBXeoncuZfrf60aWEMdBmqlXUqme0mK7nlJuDG3Y5cgt0oQC5fMTVX?=
 =?us-ascii?Q?86EiB0XZPwpSnjV42LpFBmAM0+mUUVDSlONxFt485b3xymQSfGYNlLZriX9s?=
 =?us-ascii?Q?Ij0+WSGk0sjFOR0W4n0xgRDqxwTiLx3qCHwRbomZdTQs77TollHLNRS719jk?=
 =?us-ascii?Q?7JdRVgZ21pLixLBUH0OMBjydekixqWT2TIcShnbn+67FzRIGuHp8z3SHHmWV?=
 =?us-ascii?Q?Ju/5oMVcKD4Us/uDZ7TeBoDPxnydqPHK9SahP1tgsUg0BfiIfyTRxTfqtl7N?=
 =?us-ascii?Q?IAlE9kcPgseQHkCwYdF0vslubh2YFq4n6VN7qSYA4mBkvJrTKtVhfKNevjYO?=
 =?us-ascii?Q?EmZbm2xLXD+PLL963j++NJvgOnJBic+HaczRmxOURaJtF4lDEZYPBv9YMMZK?=
 =?us-ascii?Q?Cx8Ghb1RptWi5Aq4y9A0j+MAWnxedWbp4Bon4OZHQpwIGOK6CyzNjl0OW9Sr?=
 =?us-ascii?Q?Nf3VIQTn7QAQY3eBuLCvdtTxXknu7gCDmSp1mPjCogx3iFrAr5xnhuochwAg?=
 =?us-ascii?Q?0sz7cZ3Z25/apiymTyZnOwcoU27BaJBEkTb2g8ohZyrsQd5U3EbNPv5XrUEq?=
 =?us-ascii?Q?Kl2v6ynNQQC1TfGXoNgTx2fLGMUVIbGmOor68eY9Bb7rQvcIjxfuRewaJoul?=
 =?us-ascii?Q?73kcc89JqlFyBfZqfFPSJeV0TfxLy5+xcwbxFLTO4Qib3coU9KGXxeirqHlI?=
 =?us-ascii?Q?fUWEMF2W+0JwWaCkOniSOz/YHwCY2tyFHvzaztHvsLsSzsalTXsFuHnPWl0k?=
 =?us-ascii?Q?C0Xdx3ZJr4bU9Kt+vXWbczoxKQ2bb/709SbF9ww1EXxxP9pCHMB0qA3UCNCt?=
 =?us-ascii?Q?yiREVbMmjlfWzsTPiXReClwT6THk07K9EgcitdU6zQbg+YNfcMO0WHLgTst3?=
 =?us-ascii?Q?u1N2Q/dT4i9Eybm1Ap9MIdLxtXMnOaqmDPRGIFW77i11xtFp+xPvntfZNG+1?=
 =?us-ascii?Q?/C4RGjOB08/nAHyj6W0tejff3XRDNCmMQmR75j1RGFvQmOnNXrK5cDOMxGmv?=
 =?us-ascii?Q?KwfjOciiE3wmiPLZX8lftJnd4JpbnaNiMDL5QJr9gq5C+3KydkVyZzCyW64o?=
 =?us-ascii?Q?KmX0/0pocVztIBMjbeqzFws+YrQMiaMkd3Cjy0np1itfpjqHHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:56.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02c07ab-d94d-41aa-e276-08dcf78776cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

Update the AMD memory encryption documentation to include information on
the Reverse Map Table (RMP) and the two table formats.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../arch/x86/amd-memory-encryption.rst        | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 6df3264f23b9..bd840df708ea 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,8 +130,126 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
+Reverse Map Table (RMP)
+=======================
+
+The RMP is a structure in system memory that is used to ensure a one-to-one
+mapping between system physical addresses and guest physical addresses. Each
+page of memory that is potentially assignable to guests has one entry within
+the RMP.
+
+The RMP table can be either contiguous in memory or a collection of segments
+in memory.
+
+Contiguous RMP
+--------------
+
+Support for this form of the RMP is present when support for SEV-SNP is
+present, which can be determined using the CPUID instruction::
+
+	0x8000001f[eax]:
+		Bit[4] indicates support for SEV-SNP
+
+The location of the RMP is identified to the hardware through two MSRs::
+
+        0xc0010132 (RMP_BASE):
+                System physical address of the first byte of the RMP
+
+        0xc0010133 (RMP_END):
+                System physical address of the last byte of the RMP
+
+Hardware requires that RMP_BASE and (RPM_END + 1) be 8KB aligned, but SEV
+firmware increases the alignment requirement to require a 1MB alignment.
+
+The RMP consists of a 16KB region used for processor bookkeeping followed
+by the RMP entries, which are 16 bytes in size. The size of the RMP
+determines the range of physical memory that the hypervisor can assign to
+SEV-SNP guests. The RMP covers the system physical address from::
+
+        0 to ((RMP_END + 1 - RMP_BASE - 16KB) / 16B) x 4KB.
+
+The current Linux support relies on BIOS to allocate/reserve the memory for
+the RMP and to set RMP_BASE and RMP_END appropriately. Linux uses the MSR
+values to locate the RMP and determine the size of the RMP. The RMP must
+cover all of system memory in order for Linux to enable SEV-SNP.
+
+Segmented RMP
+-------------
+
+Segmented RMP support is a new way of representing the layout of an RMP.
+Initial RMP support required the RMP table to be contiguous in memory.
+RMP accesses from a NUMA node on which the RMP doesn't reside
+can take longer than accesses from a NUMA node on which the RMP resides.
+Segmented RMP support allows the RMP entries to be located on the same
+node as the memory the RMP is covering, potentially reducing latency
+associated with accessing an RMP entry associated with the memory. Each
+RMP segment covers a specific range of system physical addresses.
+
+Support for this form of the RMP can be determined using the CPUID
+instruction::
+
+        0x8000001f[eax]:
+                Bit[23] indicates support for segmented RMP
+
+If supported, segmented RMP attributes can be found using the CPUID
+instruction::
+
+        0x80000025[eax]:
+                Bits[5:0]  minimum supported RMP segment size
+                Bits[11:6] maximum supported RMP segment size
+
+        0x80000025[ebx]:
+                Bits[9:0]  number of cacheable RMP segment definitions
+                Bit[10]    indicates if the number of cacheable RMP segments
+                           is a hard limit
+
+To enable a segmented RMP, a new MSR is available::
+
+        0xc0010136 (RMP_CFG):
+                Bit[0]     indicates if segmented RMP is enabled
+                Bits[13:8] contains the size of memory covered by an RMP
+                           segment (expressed as a power of 2)
+
+The RMP segment size defined in the RMP_CFG MSR applies to all segments
+of the RMP. Therefore each RMP segment covers a specific range of system
+physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
+the RMP segment coverage value is 0x24 => 36, meaning the size of memory
+covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
+covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
+covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
+
+When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
+area as it does today (16K in size). However, instead of RMP entries
+beginning immediately after the bookkeeping area, there is a 4K RMP
+segment table (RST). Each entry in the RST is 8-bytes in size and represents
+an RMP segment::
+
+        Bits[19:0]  mapped size (in GB)
+                    The mapped size can be less than the defined segment size.
+                    A value of zero, indicates that no RMP exists for the range
+                    of system physical addresses associated with this segment.
+        Bits[51:20] segment physical address
+                    This address is left shift 20-bits (or just masked when
+                    read) to form the physical address of the segment (1MB
+                    alignment).
+
+The RST can hold 512 segment entries but can be limited in size to the number
+of cacheable RMP segments (CPUID 0x80000025_EBX[9:0]) if the number of cacheable
+RMP segments is a hard limit (CPUID 0x80000025_EBX[10]).
+
+The current Linux support relies on BIOS to allocate/reserve the memory for
+the segmented RMP (the bookkeeping area, RST, and all segments), build the RST
+and to set RMP_BASE, RMP_END, and RMP_CFG appropriately. Linux uses the MSR
+values to locate the RMP and determine the size and location of the RMP
+segments. The RMP must cover all of system memory in order for Linux to enable
+SEV-SNP.
+
+More details in the AMD64 APM Vol 2, section "15.36.3 Reverse Map Table",
+docID: 24593.
+
 Secure VM Service Module (SVSM)
 ===============================
+
 SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
 defines four privilege levels at which guest software can run. The most
 privileged level is 0 and numerically higher numbers have lesser privileges.
-- 
2.46.2


