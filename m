Return-Path: <linux-kernel+bounces-344332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9598A867
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB60F1C22777
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAE1925A0;
	Mon, 30 Sep 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ajtIbr3c"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44E191F8A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709841; cv=fail; b=Tg/YbmHdeWPyHIjUmoRjD9y3p+OElHbsdBcLsmczNU4y3dD6W4fRdB1D672N4yUS0k1D53YUYcEsW+DDyXi8Izg20D9vIyo2NGy2JliaQPIkKPpzsbgP0aMTCv8aNBU8+HccvP45Gdb2k4zzvoraEGNNkxn9zFjIoJL46wR8Dsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709841; c=relaxed/simple;
	bh=3pyXhZkrHUYMBVyMGk3MKmHF1bvXksOyAMITxe8GiN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/hzx5C+Ku1M8khutDz9lofKc+zYMCkkMcluAU4UDXsPdi0vd5sC9xYl6Fl3QiZ9D0Gl3+E+4s8gCiFm4jcLT1FgoBi8kulfBES1e+yte9jFT3EMSKp9zwLw/qVXAZY3ChYVWkSUe/uxqaTPzQOugfwe3puFmuEeR5b2dwjz6Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ajtIbr3c; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ4XmjMZQEhkzYJoVDL0F+T8F75u+qCgg3dVj4HbRgLLwEvYrtlprLqxFBnCmyvK5xA9l5Q6rIv4Fa+xwyMw6UzGKHiOYi8tTtduZuUODbXKAQWFiRI6kANrlPrzYlVcDSy55XofqkZxmMgRR7W7Anb5YsmlROiR8paBLXdXwComEv/FL8uViLugLqnDKUuMFN1+uaKkxLn3Fh5x8vg8RmG6h7SIZSBjMg8SMPiYIeq0YYkMT9Y60aDIC4+Z3EQFgUb+bozfTv5Il5jwtUm4l6is/+/GoTZ84nf/447PYwQu1SPHM3fPXvtR+Vf5D/zGigDlmSxLVgBxvp/rITzaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrX2yVbwYXeCF+BTZ6JIfqugH6Rr2+d2b9XAcbfioek=;
 b=tkzCDXiBuHsMlKYw01NcuFZqdfVc5ok9QU5H2LTLx8uazM6semxgQkOlJYfHoMP1wpDPLOyZGkq7kadAvpvxAtB4IjiK7kNrrktXGjICLD0akUgOomacxLwZ8ZiPMEs8eHT1os61qlcoDLFNl2IbEA4TmWUZzhriagNydW5DHARFEZs81KYtS4o3/tExnLpZa+kVPyiIRcM8e5MR/C5OMGarn8nq2nknhBhOZXatNbYmnGuUjhWI2hkxLSqdN9Cr13coUMyJQLfkAhnkaGPnTFfUQEQarDVGkFYyFoTWcsj3fNsRc8qd90i/lGmUjtWlzzFs5c79C/Kvey5/ncOpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrX2yVbwYXeCF+BTZ6JIfqugH6Rr2+d2b9XAcbfioek=;
 b=ajtIbr3cVD8HhPqKDjKLD9OJPQAUihsmJ4IzEgF/xId2jQLk0WKJSTu+gjTDYHjbUpcXygXmuTzuSU8In2duslblBZAagPylQTjPY5nB7M2iMJiqYI5xMHImj0K4/ztljRF49eXnLb2IVH9vFsjS26Z3NqktsdSU0pM2HKf5oeo=
Received: from BYAPR08CA0050.namprd08.prod.outlook.com (2603:10b6:a03:117::27)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:23:52 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::a7) by BYAPR08CA0050.outlook.office365.com
 (2603:10b6:a03:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 15:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:23:51 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:22:32 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 0/8] Provide support for RMPREAD and a segmented RMP
Date: Mon, 30 Sep 2024 10:22:08 -0500
Message-ID: <cover.1727709735.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 119e0fdb-c404-4bd4-1254-08dce163e36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OAEWuGoS4apQw76SSqgS6HZXrTDyM9kw3qveBjiFthldZlxL8oyRpTJG4pHk?=
 =?us-ascii?Q?fqq0axbgza4aFOsj/9wM8GoJh5od/lQqh4d5lEWPQp+B37jqLmUtMF8tZ1+w?=
 =?us-ascii?Q?+VVukThJaSsCM4551GrZWM5uXcouszyo8SyvxRoTxUe4lCX4GVDIGOJZzQem?=
 =?us-ascii?Q?v2DcQnFYqwATtr5886Lg4atbbWjCFmaTZTBbiNZ9imlGlcmQc1nfbqmhNxdt?=
 =?us-ascii?Q?tkgv9Dfw7DMHp4gZj6GSH664OSeL4mshjB6vR4/hrdisyP9IDV84QDWl+MW6?=
 =?us-ascii?Q?oxqhQMZENfA9lJgtjNXOE8l/UA7+tteIABXcfhfQofTxhPCHsJ6vQtdiGodD?=
 =?us-ascii?Q?0/+j2trPJwYSjnIO3PzQFOpnBH7mdI9iVHOxhYgzIqjBIsoF+a5WR5tcz18X?=
 =?us-ascii?Q?bp1RqimL+trZGexwNn+yABbcUxd8TUjn253wJ7mibZ2/5apnthM/+ZbF3qtE?=
 =?us-ascii?Q?JRVsMrXB73Sv05bTJOE2CBNkziJwMgR0QM+57aiGov5S55VVAc/VbJRrWKdx?=
 =?us-ascii?Q?QlD9WhzVGpMgAc1gdetnKUdyb6MHCuEs5iKUMukfbgrhgDpOfuzxEytO3eq2?=
 =?us-ascii?Q?mRKy784CSaBZaETPzl6KlmJc8OPzQGFGjG4+pgJ6nbSsrBRQ4AC1PQiX/frT?=
 =?us-ascii?Q?pTDSqr/K/IcFor2miQWbSSOMpiYLZJygpBmSjA9blFSow/FrTGNI0+Scy40Z?=
 =?us-ascii?Q?VZnof/7eMMxpz8sAUwnrH5MmylaoC5EOsXIRwvFUh0WFCozYyKZIRwzuEgoE?=
 =?us-ascii?Q?0ex78NpL32FeM+63EieyDBUwkV8vVg3UyX8pwouyJhyYq84srVcx9d83zngG?=
 =?us-ascii?Q?X7Esw9pTj1I7oVTrtsqNSQBe56MIa57VOkbfcHM0TGSKGq3IREOwLdpNIAxR?=
 =?us-ascii?Q?6uwBs0jPk0K7IQhLvMnYNG5lwQ4hlzBGKThG+SZZ67cQftQE0OR1fMT9e0UG?=
 =?us-ascii?Q?58ou9s5p4c0iR8Kq+gbdZRkK5fVQBl8AVuJSQShF9MpU2N+GPIoUSMCeodV9?=
 =?us-ascii?Q?zhZlOrkHnPj+jgvfdamUt8JSjE4ofp3IpAD3eeTbYOOmz74x7eBwYOD1vd1J?=
 =?us-ascii?Q?Xa1qDizuENvCDFi63NCy3+tXOywEsFARM211jy9lD+iCJEN2hKZOxErvT/Pb?=
 =?us-ascii?Q?Q9kRwmRVkTylO+RamWkjio2sXoBMNLv5mav3MojSDMXb9Rwdh4q5KlNYJt0I?=
 =?us-ascii?Q?UOpKiuWFyTsmhzQ6JCBQ992IIijdzIrR8t4XG+1PZkewwFp9BlXoip2h+E79?=
 =?us-ascii?Q?mVRdaf21WsghUu6HzT7KnqBkruEXCwxNQhYTG1vYS6JBURjW8DkoFJftxCKN?=
 =?us-ascii?Q?ov03e6vSgQfPx2lJ7FBEhm2MzOm7Ns9L1PzWOC8YoKWt9gpvH/xwzTnwNOIJ?=
 =?us-ascii?Q?OBdaZ0taG2c5Bq8ygQp815YjcmTSB2RakXhdlWF4JDZ8x3SnjdFQpdwQRjFr?=
 =?us-ascii?Q?A7nm3sZVHjZB+MNtX5W2Z3pc9FJw8kuJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:23:51.1233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119e0fdb-c404-4bd4-1254-08dce163e36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

This series adds SEV-SNP support for a new instruction to read an RMP
entry and for a segmented RMP table.

The RMPREAD instruction is used to return information related to an RMP
entry in an architecturally defined format.

RMPREAD support is detected via CPUID 0x8000001f_EAX[21].

Segmented RMP support is a new way of representing the layout of an RMP
table. Initial RMP table support required the RMP table to be contiguous
in memory. RMP accesses from a NUMA node on which the RMP doesn't reside
can take longer than accesses from a NUMA node on which the RMP resides.
Segmented RMP support allows the RMP entries to be located on the same
node as the memory the RMP is covering, potentially reducing latency
associated with accessing an RMP entry associated with the memory. Each
RMP segment covers a specific range of system physical addresses.

Segmented RMP support is detected and established via CPUID and MSRs.

CPUID:
  - 0x8000001f_EAX[23]
    - Indicates support for segmented RMP

  - 0x80000025_EAX
    - [5:0]   : Minimum supported RMP segment size
    - [11:6]  : Maximum supported RMP segment size

  - 0x80000025_EBX
    - [9:0]   : Number of cacheable RMP segment definitions
    - [10]    : Indicates if the number of cacheable RMP segments is
                a hard limit

MSR:
  - 0xc0010132 (RMP_BASE)
    - Is identical to current RMP support

  - 0xc0010133 (RMP_END)
    - Should be in reset state if segmented RMP support is active

      For kernels that do not support segmented RMP, being in reset
      state allows the kernel to disable SNP support if the non-segmented
      RMP has not been allocated.

  - 0xc0010136 (RMP_CFG)
    - [0]    : Indicates if segmented RMP is enabled
    - [13:8] : Contains the size of memory covered by an RMP segment
               (expressed as a power of 2)

The RMP segment size defined in the RMP_CFG MSR applies to all segments
of the RMP. Therefore each RMP segment covers a specific range of system
physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
the RMP segment coverage value is 0x24 => 36, meaning the size of memory
covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.

When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
area as it does today (16K in size). However, instead of RMP entries
beginning immediately after the bookkeeping area, there is a 4K RMP
segment table. Each entry in the table is 8-bytes in size:

  - [19:0]  : Mapped size (in GB)
              The mapped size can be less than the defined segment size.
              A value of zero, indicates that no RMP exists for the range
              of system physical addresses associated with this segment.
    [51:20] : Segment physical address
              This address is left shift 20-bits (or just masked when
              read) to form the physical address of the segment (1MB
              alignment).

The series is based off of and tested against the tip tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

  5b0c5f05fb2f ("Merge branch into tip/master: 'x86/splitlock'")

---

Changes in v3:
- Added RMP documentation

Changes in v2:
- Remove the self-describing check. The SEV firmware will ensure that
  all RMP segments are covered by RMP entries.
- Do not include RMP segments above maximum detected RAM address (64-bit
  MMIO) in the system RAM coverage check.
- Adjust new CPUID feature entries to match the change to how they are
  or are not presented to userspace.


Tom Lendacky (8):
  x86/sev: Prepare for using the RMPREAD instruction to access the RMP
  x86/sev: Add support for the RMPREAD instruction
  x86/sev: Require the RMPREAD instruction after Fam19h
  x86/sev: Move the SNP probe routine out of the way
  x86/sev: Map only the RMP table entries instead of the full RMP range
  x86/sev: Treat the contiguous RMP table as a single RMP segment
  x86/sev: Add full support for a segmented RMP table
  x86/sev/docs: Document the SNP Reverse Map Table (RMP)

 .../arch/x86/amd-memory-encryption.rst        | 118 ++++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/msr-index.h              |   9 +-
 arch/x86/kernel/cpu/amd.c                     |   3 +-
 arch/x86/virt/svm/sev.c                       | 628 +++++++++++++++---
 5 files changed, 662 insertions(+), 98 deletions(-)

-- 
2.43.2


