Return-Path: <linux-kernel+bounces-344368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56BC98A8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30956B28865
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B982192D74;
	Mon, 30 Sep 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BeLr6b6K"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F6192593
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710422; cv=fail; b=l1RZBvo/jcyn61NA8VE5BFx7lkfWO0MPL2bMjskkQQYLlM76unFT2JVsGGi36isqdoWOKWgcLfPWE9mA7O0/djDrZdMpyJIlIlB4nwvwc90xJhZ3vh/Tk9yZxJ90mPx22x1sdCVgAB83D8ycHVMPPad1zwTYeAChPOQtrMk7JpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710422; c=relaxed/simple;
	bh=exS3C9Kcox2HgBeivQVKd8bigw+5WQNnQMJVz7yznoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2mTgTfQFKFd/6aLLq3LMrV2Xe4xMD84Y3QJfUat1BZIB1834zkpBG1nJdsPJr6ezruhD4C8ySIRA6WFRPuMFiQj3mHvLMopgBj+BGol8zAWRShxSWguLI094Kec5s/dx5lBW0QJ34OsV5dOziwpmG/Gbw4UEBGx0IxJGiBK2pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BeLr6b6K; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIxgEVJTBmeM8qmq6Cl0wSn+UZJkUjuItRb9tjw4ggy+tbi90Jxr0+dezi6R4/8GdpLlY5SpSEFrBN0AA7aAnzyg26kk+OEzaSgZROs4aXkaHA3e+c6Z1L4vyqvThCHk/7kB8LDl4v9OHib4MvfGMerD2+qtHdaTwdVW2m0Yp7qahWLaOWokDwl1RMm6XmvzQUCfb8d6PXwKaDDsA83ZQwgdD9+OtsFpklRXsZqToLAsmW9zyhNJTtiXMInGnx2vw1qVWJkng+YI7TCAXNTkz7xrQB8KxSeNZmhhlcneGebZUANVlCTbQBK9KFgP90W55ef3J4JnlnF7P+H+wFZzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBhIpja98ZqmhMQxfkiHVZI3MuNCTeFhISy+3+R8Cog=;
 b=yQGkKa2WHc+MzRBsBvjEPKjsQXDh3zni6L5BJHFSW1Sp1GSvwk+DfdrW2VpSRXv9kqPQ4GX91E8z+SV1l3ZRdad4fBtAg3MmMZyJj0MGOgqkHn3eB9VNaOglbiVtJ/aKHbuPjzApOBybK4cihRuouYa2j9dzGLH+MwSbXfoLbDdHVMXPgr9R88AuYjui5H903uqe5120aKA7u+5TCo5fyPUuz8ezatZo6sh272cgZ9I6wJ4mEsdcUdHl+Db1kCG0uSqu9yrfjGiFwLMbQn1wlso08fAETAIBwgO5u6KgDA2baiUPFcaIfQ40C33vPx+1zj5Q1u+DlSaD0ix3NYbP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBhIpja98ZqmhMQxfkiHVZI3MuNCTeFhISy+3+R8Cog=;
 b=BeLr6b6KVAN1DSsOSiS7CHpRiSPV2nO7FvHRYsDOUZ/D/jqAi/A6qvy61Ax2ZrSS1OvTYCU6HGa6TaSYhpraGbzilplr4sVTJnssAAPvQ3CtkaZExUh2MQU7mWyYvmUruzl//g5HgoRzu0jN1PfUNf2PTsO/lMJ2nPlJU7AEDv4=
Received: from DM6PR06CA0093.namprd06.prod.outlook.com (2603:10b6:5:336::26)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Mon, 30 Sep
 2024 15:33:36 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::9c) by DM6PR06CA0093.outlook.office365.com
 (2603:10b6:5:336::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:33:36 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:30:39 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 8/8] x86/sev/docs: Document the SNP Reverse Map Table (RMP)
Date: Mon, 30 Sep 2024 10:22:16 -0500
Message-ID: <de767f29c86b201fa0f778e2cb786f971c155f6e.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 632b9ad9-ae58-4121-7cc2-08dce1654039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9+tPFnBzVDMSvxyQPd6X8Gc5gb7VvdLS38xkeUct1Xk9HPFKOMVpUEMnJ+B?=
 =?us-ascii?Q?mPT3ulQ+2w4NvYqPzWL7Km0XlSxhUkrEaIhx+qrIEXGUd7mrxOwNvzh5dd8j?=
 =?us-ascii?Q?babvtnhqo7JyMLkY/q8lQt0UjAx507Q1yKXZWXfquUCxIN7EiacnWtmb+u5S?=
 =?us-ascii?Q?VuaeBkQM8VQNSO85gRtxRPOvgDdSYFsgxhQM7rfAgGN+hZV28HZNg2HgyNBa?=
 =?us-ascii?Q?3d9CeGlCz4UfLgd3Qupl4E9oJ8QxFCjzynZIAC4AXgXKraTZeYpw88mHl7I4?=
 =?us-ascii?Q?pYNquXzV8zuBuNqXomKfo5C4B4U0bzMNAkSk3I74y1Azr+24prEFCMCtN/qm?=
 =?us-ascii?Q?vmH8KDbSyujoOCLQl/wI1zesQvjUQse4+LpfmTezt6QtUa3LCz9XKqYrosB8?=
 =?us-ascii?Q?SjonoTXKbFuxypTercRQHi808nmi+ll1Ea891QjnnNVe1IANfLu1xTPSEEuF?=
 =?us-ascii?Q?y9oaUN3r+I46tb9Yb9fGjtLshLhFssNQhKSMk+EnNOc6uvOiA1wOF5hne38L?=
 =?us-ascii?Q?eBcYZAvZ3qf8ffRsyhIHW16oVWonRvxuBtBza9PL150a1uWWLOTJiLUmmrfu?=
 =?us-ascii?Q?514gSSqtiv9wmnb1EhXpdMhFek6hSHD0QePdvKRBJbjldYjFX9EAr5guM2eb?=
 =?us-ascii?Q?51FTe+oDNW7xFINo/MQROCzn3+qbwKSExfWAkfH/Cv6tvYZ+cFdLkiY7eB90?=
 =?us-ascii?Q?WT+hXGC25LJ5oszrnpV7YAbHrioY8yhAIXewajdFxteU+I59PQHwN7josUwG?=
 =?us-ascii?Q?hu9ZkhQaEEO/x5DqNxshS3RXyUAsOc1KmUJZ8UXtw9wRqDBHtDyr9jal8G+R?=
 =?us-ascii?Q?8nzQ8a7iNBZcD0BL5jvr/xTWszYXC3Vytt7O+2p2Lfen1VL6FZGFOEVcFb4Z?=
 =?us-ascii?Q?FIfmNEF1ZIRObU3Fr9sV9FO5HEjaY24IgxPjTBwGiT7Hif4x7XcoiSpHhL6j?=
 =?us-ascii?Q?+2OQUXrRba3pzrmWud/IIzhGkAVXkhNbqiqpbNDW2qcZHWarEwX4G02Noi6T?=
 =?us-ascii?Q?KyY1ohUaSQo6WTw+JLGvGNqVJYbL8VncxTQjA5icPuUFxQZxQ3HBDspcMSI5?=
 =?us-ascii?Q?p9A34LpLGYFXOcBJHThQHMyw/89j4yfM56a/g6h9WVSLwxCgnKO4nhpQ6BER?=
 =?us-ascii?Q?PJI1XGi0B9CBZF5q+drcvKTiHRk7rFMV+QM+d+Sa5pw4YnvPbbr0B5wGYwC/?=
 =?us-ascii?Q?5ZhgKErdO/ltz/XHeRnvUNYZo2dFoaCSEIrHy0gvlVQwaT6eBAItb1ea/AC0?=
 =?us-ascii?Q?DLDjOv2R5zZsVb+KUoToh/WDQz0gHck+RHyHV5R+VHXbpyvOnYAZ6sR4fsKM?=
 =?us-ascii?Q?Xd4W0Fog/By/EFVsTZF0j+iDT/jicjePRPYkfK6cwLyrqY5dQ5hEiSZyf/7r?=
 =?us-ascii?Q?iSlTqtjzLa9R75/3/Or1O6/ax5XyQCeRyTHUc5oPZDHqI8o48i7DHltSgeI/?=
 =?us-ascii?Q?fFpoDG2hhUFaL3wHDkvv1v4hz1LD8/5E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:33:36.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632b9ad9-ae58-4121-7cc2-08dce1654039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

Update the AMD memory encryption documentation to include information on
the Reverse Map Table (RMP) and the two table formats.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
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
2.43.2


