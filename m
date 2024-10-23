Return-Path: <linux-kernel+bounces-378705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B919AD435
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475761F21DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE01FE0F1;
	Wed, 23 Oct 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f8UU9VZO"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C11E1C08
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708998; cv=fail; b=NlwiYaFtgJEZ+1aXdQyLBWdcQjSt7SKNHjEWL37xMASthFijqhNpAS+zHx7nY0Z9bBQW9mwscavTLhi5CyfNuXZO711PRaAmsNMs85xr+6HMJ+IOuaqCZk6RrKF780w8yEz7aoiK9U0HEveL3fKUtORDyJgjaXcBp7yDYOrZIlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708998; c=relaxed/simple;
	bh=AO4vdkfb4Pv6u+jlnyEtp6Nq37ss/iiA6XNg1AZY+Mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQDIE7XQkPR8Qke5+kmGtENTVlQmXgguz6x7lH6RlaQrqV9D/Kp9j1zCmRZhJzqPGD/MDND2YjPojQv8lOrM/+cMX+JJh+8PX+t9dmbIITVsHuGLsXa7AQTmDGC/1axX+mJ3H3erOoD+kwBt4DukbvQGi2JGQgQXM6jmGD5Xhn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f8UU9VZO; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5yLc0IrE2CGDzTzWoMGy3nQdflQuRThMyVRE8LHfua3jzZyW15OK2M8ZrTjVLYouCNEdKeCANqLsekIXoruXufOC3kxi5mNxH1DdbhpNg6Hn/+iDVH2PDxX1BT1iLhUE49GZv0WwTzWaapcx16ZOf7iWY5jjEBPTfHvkFlOgxwYHeajJdCVPHpeZGxfH41yh7wqHOkHg/5ugU9ENbKFA4++gKX+lbtfUIkJ7S07EVSPUSqc2G29vG6Y4y2qPxlQD5w15YNMK4a3mmbVce61ZQ9c/7IHhGgz6CYMkKczq6XCbSiGFpyeCIpin80eViJaOUD8i8lFkDrhcm5/y1RfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcfVUpXoYUcExuxCmLJTYPphMbKI2rE9fLVUWZaPhmk=;
 b=tu88VL34PQm7LBwKkOlmgVsONhD9BwkdaYiZm9kj0oEvFNfgy2ET/KkxeS9wqYqdzkB2QBvTkAx8FYas3C7X1+Wxv2gIamRXTCBws74DXCyzJWVpt6UcEIse9oVk3vJqQ/V3wtt/7JIIdD+78bhOGF/GhsvqHux83tsFX+GB7/85kvzhxcBm+66zarwDB6RcqEGOLCxFqCfQ1NAIHxq8x7ft4MKs9Yfbm20mxhTXS90ouSKirALZYX0OvQx+J8PveNst4CAoU7agntqdj2AyawWugG5i9xp2OmT0alNHFV87aWgmLWOwg0VyEeqITVXY1znPp7gD22bpPcT+L0hpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcfVUpXoYUcExuxCmLJTYPphMbKI2rE9fLVUWZaPhmk=;
 b=f8UU9VZOYEMsVeTv2A8geRgvSgEyo0mvHB3n9BZFhbyHNgpup1mqtASMMVQNtpLSANcfaZVKFFMxBzJMb1ZXA/OMCAICf9g+gaMIZwpsP6nVBXAHYldnKKkL3VBYJaWKrLAHH5yW0YZ3FBA8U5nyvZdmIVvD8gdzrI0rAZJP/xY=
Received: from PH7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::24)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 18:43:13 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::c5) by PH7P222CA0024.outlook.office365.com
 (2603:10b6:510:33a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 18:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:43:12 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:43:10 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 8/8] x86/sev/docs: Document the SNP Reverse Map Table (RMP)
Date: Wed, 23 Oct 2024 13:42:02 -0500
Message-ID: <69e573fb0415eba78069ed8098b69a8dcb973592.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 9977ebac-fb24-43af-61fa-08dcf3928c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0W9lJMxssp6q0ruqkuVtFHZ6za7qXGUbqi4FJtMRtebyWV+EZjPmFmNGqTI2?=
 =?us-ascii?Q?80ardR4YmDizbXFfrlpOoK8LSxIHhRpiOrxmlP8/SmYXwe27RWvlPIJdNpoN?=
 =?us-ascii?Q?Y6GIBSxx8W83u0WI+PO3zlrQK1yb5CxepDwi/1q93V2cXs3Z7T51HKWzIMVE?=
 =?us-ascii?Q?G2hyUGWL79moLi4Gblof//QV5joKTbGbfXN00xRs9vVgk1Ge9uF6WwW7fHOX?=
 =?us-ascii?Q?ZyNm9DLcYPbbCktD9q7ihqV9AQIXQ4Oy1LhNbgQ4y1CYcioNkQvTSn6Pz9rk?=
 =?us-ascii?Q?O3hmZn8gckdh0pFAi8CgzlN2qisOUznEKbovxPsk3Zz0aymRdk78UAZFFVPC?=
 =?us-ascii?Q?dAEPuDeZoZ+JVnZbGF5q8AcIF/yg2Ub2i+lYEMAdamF7E65AQhJd281LxdME?=
 =?us-ascii?Q?fGkga+K1ZkxOLwMCgFcJGqjATLDbOKbveqKNWheplywnXU3Yp5hJzSd5fYdR?=
 =?us-ascii?Q?n7693KQmazIpAIHtMxidi0TGGviJSVlEUVfn4Fkmv4tvsmzZVldx7yr69SiE?=
 =?us-ascii?Q?spzG2QwD9gRXZwMn3P6YL6UmllxN/oO36m6kXNmyiEBlzXbNiggtt97gt7T3?=
 =?us-ascii?Q?HqZ5BCfJSBKgNW4zKLsHxeuDjKP3B0o3nQ53eFYYgPvlNluTe2nLy+IUQIxD?=
 =?us-ascii?Q?w6Humufh+5cuJ6T2ZUjDMhIV8tAN31vVuMwTQLbRe2OqjSnDqynHuyqqVNZg?=
 =?us-ascii?Q?bsdnJNz9ALSDj7o49Z+OUWGsUFLo8xrmWmU3lT5ROWx9npboT3yQXeavVM0/?=
 =?us-ascii?Q?DRu2PbwKfVcc1CdT/KZ/JTwod8oQvXeGmTR/3BOGZzZFo52ZDeA0QmerR+t5?=
 =?us-ascii?Q?6fH2adC2eRIdUgzF22jYeKXJP3c4rl1/H/m+q/47u/XUaIWAmnZCtw9+8VHo?=
 =?us-ascii?Q?llMd5QoBggvLPc+rewkIJ0Zby2T+uYLjGRxCnOz0A2pDsw7logb9B9m/umoI?=
 =?us-ascii?Q?bmEQaO8juntsCpPbea/uDiIJyeayBubUrUCZj75IBS4mIm3kAklLOlz0d/NE?=
 =?us-ascii?Q?Ks1Rm5i8Seub7ahlqwPGHuye/I/HhLt7IgGB38y5NBmkGXPA96FBFwIFuwBM?=
 =?us-ascii?Q?D91OSVqZdAr3LUKdJSO/lwB6zrxhIHp/aSW2CR5IMtZR3fYUyhbW/+4yWZz/?=
 =?us-ascii?Q?awIZcQWAiCd7LumQ9x8UsUg/PQ/x80QTWQ6HG+XElFtlVySJER2x9eeQ9BlK?=
 =?us-ascii?Q?vQ9fTFFQB6PlSehE0vkDndEN0k+MrAbVy773HRtR6Qp+O89iEW+rBqJZ9gGU?=
 =?us-ascii?Q?kVPkTdhillViUVThAWASyOAemuOhQvZxkJb1vLJpmCvvQHBxi2gUKQqzRiw+?=
 =?us-ascii?Q?pyWhjzvF1Za3Gt0WVO4S6lxGHYImwsORzIJ2QkqBmJuVusU47OAV2t2xKPkJ?=
 =?us-ascii?Q?xkzIb90MOUS5hG01H+anwc3BG0dODwxy9FIpyxdewowyhd9yHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:43:12.1369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9977ebac-fb24-43af-61fa-08dcf3928c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

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
2.46.2


