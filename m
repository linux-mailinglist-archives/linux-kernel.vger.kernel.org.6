Return-Path: <linux-kernel+bounces-385693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C19B3A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81C9B21ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD929149E00;
	Mon, 28 Oct 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bj4qazS5"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91613173
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143984; cv=fail; b=U9CJeRANDntE+6BCJluqPAorWg+ArT4askTPReJhT6Xfa8K6zZ8fIfICKDI5VNa6m4SagkeMIisZ4absFCjttghfa5KuHUPn5PlawzpclHkfMez0p6Rju81tW6W8U9zbU9bnvcfcQys2XcwokBjbh+rR7DWx03A5GLueCBQPZyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143984; c=relaxed/simple;
	bh=lyfmUFgoJshN3SPaCjdnn+D+aByU+CdryRz6QJSZQek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vq/LrmE/NVb6QAawcOlf+Xdo0NitgtLGeWs82gd2zmZ0n08G40dTZTR3jhi8SX3VBLtXMbp/xa7W41z5gng9Xz0ie/oejalAHAIMWT70tazEXJJovgfTtZtelW+gd03V/9/7Z/Tm7OyqROsrJlo2fLT6502eEKa3ZtyeYg1GTAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bj4qazS5; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYOfYBPdvDb5AouM1Ge7ZSBVoC6etTZoJvlnNlVmg/LQmWfmNrzOgrpbTgaASc6YcqDR35n9orU22m0RE1D4AXHURtEHp78XA05LiWE/GdcpJyiU/fsoRbhPRPwKacDTxjtesFgYgzwAqQsryVIIogvqQJ7GrYKS+Ad6eSgFVnCCw28h7jk3zoOMsoBku5xXWtHBVrbCCVsZLxL9xHcDjphGfFqPlYSwQGo/u1K0kxxtzNqCfyFu++RAgjXPBBA4omm3Us/H38+u6N89wnafaFMKUJ/ZM3cja8n6CyA8BPpNvbsRSW+2dxU5ZDAQ/FFKugLYW2YckdzejxreTeDGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMpJv0iKeJ4saZabB7d6J0nvXsStRq8iTS5sKS1mLPU=;
 b=WdZkHNLIgbGv0cPRxSZuaokp2ysN5R8xHHyk8V4tUHY+GUc3SXXoSpaLz2OyrhJtWlCykvGfc0RoDPnRPv1NzMrr13ETp0naCIKlif4x/c5+eosSGi2gL7Yr9YJD16gLv8S7iHNsdFEUEPmbvUF85I6ozMU203p/pwAiz+embIfaFmQo3Pn5AJwsZM9dlXwAfwZyUBT65uOOWOfDTT/+F7ilK3wnmuwllLnGBha9WHEtsfaQL5ub4H1SwgYqa757/mYro4wYI+Fgm6Dw7CIFW1yHmlqVpAcLQUWbwD3DmTwJ2dTB+ZavhcYJapxgw1DCES6Qm+Lq3nNd+yl8WDBIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMpJv0iKeJ4saZabB7d6J0nvXsStRq8iTS5sKS1mLPU=;
 b=bj4qazS5Igq7491NmAq9XGNXDV2Z3z2AIEr3RrP5d0R2IHj/ToKZL8XtFJwxvg1e4QVh49FD3bYU+C8nGF/EwV8lK2pc1mRxRH4ea4Jzcxf1hZc+R3KIKgPROyw7tI2n2hHMzc7hw9K9+E4VetZqgVTwYH84AbbzHt8s1zlbjeI=
Received: from BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 19:32:55 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::39) by BLAPR03CA0132.outlook.office365.com
 (2603:10b6:208:32e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 19:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:32:54 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:32:53 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 0/8] Provide support for RMPREAD and a segmented RMP
Date: Mon, 28 Oct 2024 14:32:35 -0500
Message-ID: <cover.1730143962.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d685abf-50b4-4095-5b20-08dcf78751cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgF8izAmI5Qw1UspsMC0N0nqH658gZtwgDjK86aisnwhKC382D5xvsDDZ4Td?=
 =?us-ascii?Q?rR+XaEYk+0NbjyJZuXDL/rAP9ERgi5CyfKQUo/r4pSU/Vr05skhwYHaaSn1f?=
 =?us-ascii?Q?F5g9xx8i9i8W68ZexLYwVd4gI6wLoThQNdz2k/VXuSjUNnx4w8Oc2auLIF4U?=
 =?us-ascii?Q?69tbMgivDD8unUQ9s0H8O6RYphDGjrt7OJPfhs4R4jAnGutXI8H2BCxprAl0?=
 =?us-ascii?Q?rk4AzKhc6ShvmzIwd8bvdP50SAa80x7sA/a0zIFauoq1PkbU1Ue8/i1Vcg0k?=
 =?us-ascii?Q?80r/5MGLrH04XtlncS0ric7fI/us8yz9Mxw3Gk1ipnk76LxRfFG9Y8nFNqhq?=
 =?us-ascii?Q?gPCQpwx5o54CWuMxoJFFUCF6DhOBQRNrmA5DeUPQ7HsEDsIxqrwb+4ddAoLa?=
 =?us-ascii?Q?Qbl4jRCY60sCbRORMEaPua1bSqjFnI0tpKbeaHLcuoskEaA4tsHeQiVSO617?=
 =?us-ascii?Q?NVcf+VOJoK0E+R16ScvxWLyZ8dN8SxvxElcL/rIzTlArrY6Ssq9DqVX3afBD?=
 =?us-ascii?Q?CUXfIjKVW9TOEFcevQwZHvhfkGC03GsakmzdQYNbLneUg5oxfN98T/kfTEhA?=
 =?us-ascii?Q?tqaLGmE/V8PjSerDCdIuwe8mkj2NBqt9jS42Mp0alcflD3X+ybsZCCjOVPuz?=
 =?us-ascii?Q?QQOPwWryGt8wf3EvRC/rShNGGOwX/nkOLdY9XFjSgoU5um1boyDNQKZ3hCeW?=
 =?us-ascii?Q?moMOZBPcDl52RZ3nVsh0ziZUz56QEPX420s/XSdyq1P37JbfBgWnuzvaCjKk?=
 =?us-ascii?Q?qlOv4qi/50Rw9/Vnnt/BkkdFLSIGbg7U573M+fHqD/RM7x1sXID82wQe2/qg?=
 =?us-ascii?Q?HGIsrQJjX3l7cKjN34uNJ7ZTMWStGiXNsvGNFVAYdl9NpCw/RfnpSJsvTi/V?=
 =?us-ascii?Q?WASDmD6xS4hYJ45ZEzcjrpIlVB2F4I9fRZTTijiMRxGYdJkEG2gZica+0WmP?=
 =?us-ascii?Q?/n0uXwV2/vaXN1h/qrr+P7KmBA9vYXzBtyeiaYnlOB6kN5FXJAPpvG9OGPGk?=
 =?us-ascii?Q?o++YT3In4Q9v4/RwWiTO3U0LWADAPZ3XygxCTYFQQRTqlnBx2VBtj7i+/ePf?=
 =?us-ascii?Q?WhIh7LxugUYaUcYoNNJDw7vJ1xmX1oGjpmxC8eZus2tImzw9F0MH46E/KEzR?=
 =?us-ascii?Q?+LHn2hh3Q+NWHHJR9eOeEvTByFxbgk8XxvMZ3uRPfBOZFVMJ+UQ2abi2fA0T?=
 =?us-ascii?Q?Rbjsv63Bu6aGvY+3HfHiDcJs2NFQhlEKCdaJ7leF8gNLYPcVC7HfGCMSSP8y?=
 =?us-ascii?Q?f7dHuCComOn8z9flM8nHO626z1xnSOI+d77mooIH3Lv1Z1o6Db41I20M+Iui?=
 =?us-ascii?Q?dNtlFS0wJcEuarASvZ9eenFWG/wAxzr9/6S9Mn40Qohx7nUDm9J9DHwNFQMY?=
 =?us-ascii?Q?cTImN2S7f5MYFtujVc9ionEeXq4aI7fSZ8PBtOFKAWSrzjyZhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:32:54.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d685abf-50b4-4095-5b20-08dcf78751cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426

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

  8b2386497cab ("Merge branch into tip/master: 'x86/sev'")

---

Changes in v5:
- Change the structure names back to rmpentry and rmpentry_raw after
  seeing the patch diff isn't improved all that much. Add extra comments
  to further explain the difference between the two structures and
  rename __get_rmpentry() to get_raw_rmpentry().

Changes in v4:
- Change the structure name of the newly introduced RMPREAD state data
  to rmpread, to avoid churn around the renaming of the old rmpentry
  structure.
- Change the fam19h check to be explicit ZEN3/ZEN4 checks
- Unify the use of u64 for RMP-related values instead of using a mix of
  u64 and unsigned long.
- Fix the RMP segment end calculation in __snp_fixup_e820_tables().
- Minor message cleanups and code simplifications.

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
  x86/sev: Require the RMPREAD instruction after Zen4
  x86/sev: Move the SNP probe routine out of the way
  x86/sev: Map only the RMP table entries instead of the full RMP range
  x86/sev: Treat the contiguous RMP table as a single RMP segment
  x86/sev: Add full support for a segmented RMP table
  x86/sev/docs: Document the SNP Reverse Map Table (RMP)

 .../arch/x86/amd-memory-encryption.rst        | 118 ++++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/msr-index.h              |   8 +-
 arch/x86/kernel/cpu/amd.c                     |   9 +-
 arch/x86/virt/svm/sev.c                       | 650 +++++++++++++++---
 5 files changed, 686 insertions(+), 101 deletions(-)

-- 
2.46.2


