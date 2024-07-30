Return-Path: <linux-kernel+bounces-268136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA629420C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A631F23237
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9318C938;
	Tue, 30 Jul 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+pe15mn"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0641AA3C1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368425; cv=fail; b=bqBdI8jF8V+fjxmzCI/VDJl53dTewCYsXhgnacBF5EnGkfRjSI8MAeejfZlI+R3nDHaB566hOvaJSZLMTDt8RQ7fWIb0WbLx1ga49yi/E1Bn5GfxyAWWuosTKLWUIOoCbwGs8qkD7+Szw2kDlvVyjDV+rfyxQrKtrc+1/XlB3ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368425; c=relaxed/simple;
	bh=dLyaLPEVL93xnjgFd9SXNjwfxSRGbYAkw8zxL71jUrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmxCcn+Fw3pZ0mldG1fYHH2fxkKvG/RF+c0h6CpEV8H1RQ1QllKTQZ4MLp3HJcDSUk47SZ+AfHqGzOR7OserpYsUpo4RJim+0siczJiWCE6kxx+m/sH+K9w0qepb47yCvp7l2CaJW+4WT9KTa9rvwJakyHyRJ31jYC6voeh4GiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+pe15mn; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgIUXBvG5aqXFKbnTQZg+9cSW8E/Cp0m7Hgc6Yx2lTXuvgyuq1LdBLiNjLu7ra4jsglAHvXi0qyt280AF5/SP11mostu9XxGx1DddvgFLTcEM6pblKP4uCg1FGKJHanawljBZpV60xOEIl/f2JgLUtH6Tp7AtYlSI4AE2GxoYPn8ag06lAVAXRpsXxCbmqMpUls1u5pBoEene3IcqdFFyPRPcAbtO9n0afsSJfQNFceQwQih5EHkJYBIjEjvwSUnxQPIjljiHZpTKeKMQlmiW5alHmhygMcW6zHIUVcRC+grju+yy9UZ6gi0ng11S8rDXtz+AXakwQXMfZu5u447sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci7vpnzvhmTZgJspknkYguPkoHx0rtkbDKmtTJebWY8=;
 b=BuESFHWARA4BRMxZwWukTZJ+abSjTJ8tGEj7k/jABn7gz89OInmy32Dy8gYIBEIuIHsvqszOGwG295phWqc+u6YBPv3e6KjAlKqvjZG+2gCX8OYmAu20tIMSOMJIAF+B9sMDcW2Au3PsDFezB8EN8YVy1byCVAs3aDx0Glpv1Z3nYVGnDpDff6K9ukpaqoChmTtTZLfkDnigu+v8SPpqPgxkVPuQY3pJYUY4V5brZ8e8gMpQL1x71wBuIler+LvvYkyU/BtKjz011miW1UFNWbaJET13skQPCjJXrgZLBZTTHIkVBw0KxBXzPpnW+tJS8r0S8bqdDaaEFL8tPHx4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci7vpnzvhmTZgJspknkYguPkoHx0rtkbDKmtTJebWY8=;
 b=f+pe15mnPiigvg4Wlonw5nIz21zZdDxE9anyyOGVA6f0huCoCq5eHqF6hoI5z1xUgOW16K/iKO+3qkJBA8r+DYKVCr8EuhN4BqkXcO0A4NkWzxFlHpEOGaw2G4jUM7q9IMTTm/SE45qzdigajsgkbg2Dkuzq2H/StUVh05lmOD4=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Tue, 30 Jul
 2024 19:40:20 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::c9) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:40:19 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:40:18 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 0/7] Provide support for RMPREAD and a segmented RMP
Date: Tue, 30 Jul 2024 14:40:00 -0500
Message-ID: <cover.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: f44b5eb8-8504-4ff8-7bdf-08dcb0cf7229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5p/7hUXkAIHuYmqkiLFfPPfE+I0wtFeO7FMJY6zu5pSRNGgylzkrRZGA5rDY?=
 =?us-ascii?Q?gHgLzgTTSQbMIBlb9qotC06syMBRqsbTRHpArXBii5M85n0t2sU7I+dfe1La?=
 =?us-ascii?Q?d0xmZbu7D5wLmYGm8llCnils3JymAXnpmplrD7RUZyUDkAy7f1uJ+r2E3QxB?=
 =?us-ascii?Q?ZnET8hanhCcE4muK2m2+m+GwdVIoip6Oi8KoySQl9WYiTpdbDOChnWB8BKbP?=
 =?us-ascii?Q?a35KYjfhLKGAhINrznwFHlN7n2WnWOlck0hHtDWIIAqialTZnZKzqvKXioU6?=
 =?us-ascii?Q?OsIlShBmW+EXMPavV4c0rEnAKZMvsdd+j3+4QRC/xR61wSlet00pLjbadh/D?=
 =?us-ascii?Q?iPqX9Abt9i5SzuWNvXwnWezN2ro1l5YFYyn2uJpS5J3zA/0LAsEXrTIuhuD/?=
 =?us-ascii?Q?gw0qycuPdNzgPcn3PmFWkZW6SGJFtJhvaOJNAHQrJPQNy+yvOiJpNe53MMbj?=
 =?us-ascii?Q?Ywh57W5BUuet+FAQgLKvHT2v502/V/WMYmHINefST5lM1sJ7ZAHoPpB7mwmo?=
 =?us-ascii?Q?E86H7r8UyHAmdCjrnGcVCJoWxfDsZ8ixboKqFQupf6r5UwJOrRv++ra0ampc?=
 =?us-ascii?Q?O1oaqDrmTtYvY0pCMG4KXctJaq3umXWi9hKRnjRuFmqbGmW0aL2zoMBHWuR5?=
 =?us-ascii?Q?tS9bckJMbIwoEv9JxeAWgYQP37bw9P8h3bzDKNRPp6gZX2OgboZ3OnNZ7mEh?=
 =?us-ascii?Q?pjdzwDoHeJr3W1nl5+1cPABSr4S1zu5qdW39OVRQZ7TmuTc3XIRuEdlArnT/?=
 =?us-ascii?Q?gF8KXumXXnQK0sOzH48QtvVxilLfPofwD/0F+CJM/awoqBuckzkSfiV6detn?=
 =?us-ascii?Q?qDLkozgWpC472W7/+a+SBxCM0uL1c+bklF7iHBKRgdAdXqGaUKC4QvIDnZ35?=
 =?us-ascii?Q?mVWDaQmGd2E2NaOxylb4ni9M6K0rU8CC6YR23AhFaZDbWXSPO+cyfSg7e8oH?=
 =?us-ascii?Q?qM4fMpdRlIcNxHykqFgSAFFBKtg46fKP70K61hR/CbQnW/FYVmpAgMmYg5Jc?=
 =?us-ascii?Q?dA3/tmlcA2xNx4e1vxM5HuoP05qKbEmYHIsJGjyeayueIHX57gzHZNN+nGsi?=
 =?us-ascii?Q?ktzJV02AKl2qvYBjkMWgvhCnvxKBgMI1D43xifetju1a5M/O+0qrublr3LWs?=
 =?us-ascii?Q?dEWOCgM4masJ/t0MqyZX7kpItd/WQFa6OpNCPsNA9njPB6Hz7k3c5c1bvjMB?=
 =?us-ascii?Q?cMlaxgiFXd3KoPWvL7HiWUskv0QklDlZcIB9yXlONI+QoMQYyt3sDyDw0aW0?=
 =?us-ascii?Q?YPSA56bUS4ELaIubKWskpfMjmtQQZ23CRjIKsgn9U84QnheUt65OXhmFhLXJ?=
 =?us-ascii?Q?MNnn7T9vLZWmNOB0qxxdMeqVqKutiV5tnyyX4ij2SQvaZda2BavVYoCRVK6z?=
 =?us-ascii?Q?W+QKZr6k2ILWmIsyCKWGtnrV4Ln8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:40:19.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44b5eb8-8504-4ff8-7bdf-08dcb0cf7229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

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
    - Should be in reset state if segment RMP support is active

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

  9735495fa893 ("Merge branch into tip/master: 'x86/mm'")

---

Changes in v2:
- Remove the self-describing check. The SEV firmware will ensure that
  all RMP segments are covered by RMP entries.
- Do not include RMP segments above maximum detected RAM address (64-bit
  MMIO) in the system RAM coverage check.
- Adjust new CPUID feature entries to match the change to how they are
  or are not presented to userspace.


Tom Lendacky (7):
  x86/sev: Prepare for using the RMPREAD instruction to access the RMP
  x86/sev: Add support for the RMPREAD instruction
  x86/sev: Require the RMPREAD instruction after Fam19h
  x86/sev: Move the SNP probe routine out of the way
  x86/sev: Map only the RMP table entries instead of the full RMP range
  x86/sev: Treat the contiguous RMP table as a single RMP segment
  x86/sev: Add full support for a segmented RMP table

 arch/x86/include/asm/cpufeatures.h |   2 +
 arch/x86/include/asm/msr-index.h   |   9 +-
 arch/x86/kernel/cpu/amd.c          |   3 +-
 arch/x86/virt/svm/sev.c            | 628 ++++++++++++++++++++++++-----
 4 files changed, 544 insertions(+), 98 deletions(-)

-- 
2.43.2


