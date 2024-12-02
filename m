Return-Path: <linux-kernel+bounces-428366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4429E0D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED86282C90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADCE1DF72E;
	Mon,  2 Dec 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hl/zWQhz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC51DE3B0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172730; cv=fail; b=K8D8JRowZkRTxxGwy3WMmcKcumKi0FkHNzS4NZA4R4ziUPGLN9jtuDGNd366Mi7BFDSx9U9dVxOD2hfX/rjYaylCyZxaWLr9qTFlj+lfx1m/8QIH4uf5eJDCrsPKkmSHN7tYQM1Q6nzLaYy3iYSIt4RndYo6EWiPPvQdldqKvZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172730; c=relaxed/simple;
	bh=Y2de6lUTpW1n177PS5GTnDQxROoZ6p4Hsl+aQ2YuLt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyGnqq+0b16tYGQNH0eDN7mRmuJiQ28KSH63RubGilPKsvDb3UFUJOKnzW4tST35NYKtwtthad/eHZK5Wsb8OlkPokCgNgpEnCV906dg1Tr91pBC7E+XU+HzibLbCAbZ7vlTdcrenimi+kO09vscKPQwCqwuxHiPWVVmOG2Uqug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hl/zWQhz; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF7PLLOM/Ut9vxRd3VzH1a5Kn22axyL4rFwq6NE9Gl9OgvYuvbjbmyWwN5+hc1Yav2X2z/etVvIndYXkhFm/ZXOsZgscr1oCrZjnkkw3Dhr+TsDZT4Q/L4ihR2edYKcsQyvDY6WHryA4sYVt9G+s0Zb6FifbbbXv/S5BWB9dVMX1jpSjUMiAe931k2PGb/JZjyP0zzOKmgGAIyweyCTEzi5xEyHB48sjwcaY5zQp6tB9jA9CZBJeUbqrZUFOZLxGWSFbdgbiuMfbxlxUL2jY6zlhT4jYVxUbKgRaYPywuBa43avbaelvmU/DOMzbkXU2UrhMfbf4ru8ZqQd+t4oFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oKOCBMG11rkMNSBoVSobw7unon/+5oViYqKWvwSeNE=;
 b=Rb2ei93jZljGpC4SQaO7Yhc2fsQyL3eN1tClWPaGvAaOZ+zXZqOD8ZyBOW+I1hbGKN+otgxq/MZE77/UUkNgWqy55Cx2QojmQU2fIjHudp6cNyACo44Dls2tNc2DDYKx66M1qN9LpWrxdeq7xMWSCi4sOpKxBQbZ5WafFIy4sdH5IMAgn61XPLQeHViiVdJGR82ftMqbpz1FIUDcrFNeSIGf27YQYzfaf6JGyzV3EuRb4hjaBV50RdL4jMMER5HvrEQS4tHONHZTko0jCq9DV3zpImlJHLQ40HoL/huFjLD+fkWTQMEwg2Uk/jtwk6FMDGWVOBz8j2FbjBNfd4bKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oKOCBMG11rkMNSBoVSobw7unon/+5oViYqKWvwSeNE=;
 b=hl/zWQhzfPkAUYlGI7ykHoz5znn111Ary5zMuOjtSyzkXt2Ipp+58UhqNBqZMINmWIZ6P1Y4Ft7xSrF88l/47dnjFqEgxXpFRBq4L2Cla6IkTDhREftbfX3ZGXUlrFqyUNkO55O1JDxnLUqbX0grO1wGjqGagzFZTH75ZtwoM/I=
Received: from SN7PR18CA0006.namprd18.prod.outlook.com (2603:10b6:806:f3::8)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 20:52:03 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::3b) by SN7PR18CA0006.outlook.office365.com
 (2603:10b6:806:f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 20:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:52:03 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:52:02 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 8/8] x86/sev/docs: Document the SNP Reverse Map Table (RMP)
Date: Mon, 2 Dec 2024 14:50:53 -0600
Message-ID: <d3feea54912ad9ff2fc261223db691ca11fc547f.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4e8e72-2e8f-4ea2-2702-08dd13132d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mwt556X8AxsH1bVytgERJyTEsXGMQlLP3PWMcasvbcwj+VGvSaYGEZVfc/E3?=
 =?us-ascii?Q?GDrE6yMBSf2qTf+PLYJa+/Z4Yqp9NWXBgXYyz1wr2l71K+rBqK4vZ0+UDLbK?=
 =?us-ascii?Q?Gy/LcazlMy7Bq/SEkCxRuFM+U7/gTgK6rVtYc/4o61ZiK/SDR/4e4xFwmm6C?=
 =?us-ascii?Q?dL6gd2Sns3DG+ZezVlLNHzlf1pU5cjen+PgYB/zjwq1oUNVs5Oymmiaagjen?=
 =?us-ascii?Q?mc0PVNIOoPNJDET1sVIOquGiyPGnXbW/QhlwUX0k2RNJudg5ZQ8h5WW8Qfj4?=
 =?us-ascii?Q?pHSq1ygISMfK36GysGQRPBEUHhT14BZ0QlpQX1DzMJWoeWcaS59k18Py9/Oe?=
 =?us-ascii?Q?+BRiEKgw48zz4cHaiI8CDl4ypfLtzRw5ez1ybE8QsHfI5tWFFbnEvPAsKqgz?=
 =?us-ascii?Q?dAuXmsHjJnDweG/OJul6pLnwzvFW5v48o9Cjw5wGza5daE6jRvko4hS/iKmp?=
 =?us-ascii?Q?LpNK4fa7PDSTKJf08Vrg2rsBwFBoHoC5ne3S7MxG5VLMalnw5E/AohuCbnAr?=
 =?us-ascii?Q?JJLR16rPXD8me5eOK8k6THfgLkShVAE6urrpO1YLavztfT225iipjWpUQV+O?=
 =?us-ascii?Q?CKo7fHJOw701RGVkuqzub9972LjiA90kVuLMLmDcCjvXEcODTQs5F3rwmLK5?=
 =?us-ascii?Q?+kzdkpcsVUeat/tdz3izMaKllntXWwttsIEGGeFJUJLMvZJCuECY98TGYlKK?=
 =?us-ascii?Q?wnyoS7KzW/adBYWb0a40QiMQZPyd6FUOs63nGDKUEGjdU4KaDlppSUzupzWN?=
 =?us-ascii?Q?lq/q59DrR1nAIaHMfVwFLaizp39j4s48fgbBXuQSglir6odERCx5sDFNzX9s?=
 =?us-ascii?Q?aNc5c+8XBrEB1T7LmME8etm7lFzDFuTSQc1CT1PA/82hb0DSLv1/mSfRt2XI?=
 =?us-ascii?Q?Aa4zE/DHLAwxTKvu0s9Q2XMjy66WtSwX02SVRgZgnXaiSHhPkHEcV3aiZ7yT?=
 =?us-ascii?Q?KsOtZw6EFdCwWISgccSxQtBzByK4cTGTSZxpUUmevYfkHo1/O754R+nBOuE4?=
 =?us-ascii?Q?QRQ+oHsoMofx1EGvEzwYDZTA9dqKoaS8J19UhBlfYs/j8Vget2Z/yicht1Na?=
 =?us-ascii?Q?YN+4rIbPFkA57sFdYcLnNxZgJqJe7RWFbQHfO3f4Adwgztcuv2Z1QIuKreNX?=
 =?us-ascii?Q?zaagfDsntk/y5TR5Y11+aKP+gCUUuh5wk2B/ZZ96+Lf2h5+2wSdwnVUPQJea?=
 =?us-ascii?Q?WCD13rSENMTiCan+VlvYdS/8TJOIbPEENkNrh6kyIdNWedzwluCVwEBn64fD?=
 =?us-ascii?Q?CKcyyLma2BEjgba7JdC0PbKMkBDABmg96IICzK3+vCERsJvMdq2APEcIFDz6?=
 =?us-ascii?Q?fqztsB1aopBFpiwkkVKMjUvTd3QVtHjSHdLim5OdDseeehX5qGPIi9Co+nDP?=
 =?us-ascii?Q?ZplynTkCYjhS1hs8u44ZbTJNpCrOqzp0FTcq+UmHgxaRYpUslIaReOqwJ4it?=
 =?us-ascii?Q?NmEHET/aJmCCPm6S/03UQXLIaj2Dz2tK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:52:03.6840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e8e72-2e8f-4ea2-2702-08dd13132d0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

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


