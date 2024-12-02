Return-Path: <linux-kernel+bounces-428358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B479E0DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57416B28A32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A441DEFE9;
	Mon,  2 Dec 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7jgjHaE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B761DE3B0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172671; cv=fail; b=UiQ7WrP4Gg+/y5B7ckWWdedcwifEeKWb1SbAC70Fy3f9PGSIoFo/AQVVaI8y0BDZatbxDh69XyM7N+t7Q6bbVhff4oaDmyd3CwXtErVLzBQ3P0jRpxpCoqANioyZmox1zSkNxH//P2i685PPJz4SkIZKURSyTQ8+8mzkZbCLLSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172671; c=relaxed/simple;
	bh=D1vtLQ394Cmw+7zDmZjehZl1kgLg87PQbLEMjYEKMi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AFDDj84exahdpBc2oYUNe9owbaXPGWWFg2CRe1w92Im034wboFeTcUo6S54IC0NSHpejr3OeOZ9plxinv7nWSXFUDSV/udy2lKEm68lSS7at1aPnoV5cBOrAYhjkTC8q3dSQ7r3r3mOvtQAk3NLmnpRlFcR9XwEZtccWcJV5m7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7jgjHaE; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKAS7p8m5k4gqSHuYn2gYkka5nekimBhtH0Glgzu3k9u6rBdIUjLF+nqrsNnIBHsdLjHn/M4ApR/4jFgRJl8Tqq/2M39QOpFsG1g83KY5AF5d/4i4C7GolOtZ9vSkM8Hit/z6PXeCZ7QbtW2ewGz0ExXVYhgl7nAR5u5gRHo4HTTne4iN85dmKH/L90Z9sTCGUNW2Gpvv4yBozXl3e4y9ms1e0wV4ivdMCoTsYSNuzOBNWKNi+JMQs3KG171Ku1ezO5mYIqw4Cs8hXJRBd7qLGTmJt3Evvf2wxnXhqoc7rhiZ7WeIkqRNPaFxMxcxnunykOBRosKwCaWlxVIOncGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTIUk5A/5JZokmRaQJVnjsXoWq1l1fSPUuWod2Lbjjg=;
 b=DRhkmPWlOPlUiolzmvHxtmqSPQylYjcj54xkynX2SXKUi+idyxqIucFtpYV1txJcoJx13Q94bUW2UQWQZCpuCa+3j5T8Rj3wBXZbl5xZ7lVT/UiLL+eWttT+xMCTc+hxu6RBsT2Udjo8KTCVPeUiWaFyVcLskzj0YyAeb1cU+gQv0M+WjdWLhsG5wmNvvz1dYyvpa6e+sWKz/hJVqr9khTkXX+PksugnctJSB6LuL0/uwI8SR9sE3+eIDSCkUV+QtLPlKIGUBgQ3TRXs8sOdRJ5QBpQ8TtlCHndMk3iQrACvIt/kSjmjrt+LoyMLkODRFirSjqt1qIg5ISfDXtUAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTIUk5A/5JZokmRaQJVnjsXoWq1l1fSPUuWod2Lbjjg=;
 b=B7jgjHaEKCtZTbJUOmgDSRprkp8DEifxbjXBxyxNh3uPf1MTst3iVvPC9w9mPqBpOJoojLnhao7/x0R6lzlubL/ZtwJ9x6rmAMCde6456mIxOcWWysloRsiKBHUOoovuB0BvwFk0rnrIhFnHFFawkzsbHsMfwVVLB5ti27HWKkI=
Received: from SN4PR0501CA0053.namprd05.prod.outlook.com
 (2603:10b6:803:41::30) by PH7PR12MB7425.namprd12.prod.outlook.com
 (2603:10b6:510:200::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:51:05 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:803:41:cafe::57) by SN4PR0501CA0053.outlook.office365.com
 (2603:10b6:803:41::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 20:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:05 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:04 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 0/8] Provide support for RMPREAD and a segmented RMP
Date: Mon, 2 Dec 2024 14:50:45 -0600
Message-ID: <cover.1733172653.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 27de7414-1c4b-47c8-99f1-08dd13130a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0nsiZlXo+DxrVVFwgFmGCMVlb6hn/4g4yc0lSKlSa0GCivMroA9Dilq3+K2?=
 =?us-ascii?Q?K65aSXSufLeZpCIAl9mrHwE/sbz+yB0+Y88cQBEnbA2NjJgkV3a79MAG5mOa?=
 =?us-ascii?Q?nRuwVNGym6ditu+hYyhvTPW/2g4EfjJjf6J+fFYSx7naEAEzKEs7IJWP7ArM?=
 =?us-ascii?Q?ceZB+FzvpGwsoxFCpQxuOT9YcTao+hQBMRscYO6gwxjyv7oEhvGlSaIb64jb?=
 =?us-ascii?Q?JFpfJ0Lq2JicM+l5AvhVw4kC/Qu0hmYv1xJmewVEMDE/rqfecT/TXhVSHQuj?=
 =?us-ascii?Q?TtlGyrEnpMlpzErWUxs2Uo7AXGS369gr/HBqZwr028S+fu6zavoMaNg4RcyE?=
 =?us-ascii?Q?+EDgFlGzrj1toFEQgnXPzh6jInRwNz+Rw8FML1xUIQeRUnxxP1zRBe542AC4?=
 =?us-ascii?Q?GkQvgstG+L93KZSJF95O1ruhCIj5hd8Ac9ZR46x0KI8aNrMRac8ZeVOpVApg?=
 =?us-ascii?Q?i/tF0ZgckdUK1D+3IOkxdjZ5MwL4D2mVPs41bJ/9O+c+PZayZoZPjMYvN3v6?=
 =?us-ascii?Q?l+RLNB2SDPpUfcGYpi6RmxhGRM6gzJp6yoTFu1mVxcvKro++/oeB+emETzdD?=
 =?us-ascii?Q?t8RtSLlJWwrO4HbdDww4/xyL7uZya6J2Iwgl6/EG/wGNLHw7YHnl8GoOXnW8?=
 =?us-ascii?Q?yYVAiAcMH18wGMH4Iv9RrNS5fOFUO8oxwf3G/gVt4WpGSBPAOmVjMxNemJ5f?=
 =?us-ascii?Q?19EU1FwfMlV81mN5ce1+mTgY4LMeYTRpn6J14PLibdIew3AeYx7kLEP/GucE?=
 =?us-ascii?Q?fTsSW9/eWcLvye0ofoxwxguI702+mKN0WR/dGB5Y5Be/mnKQMWxuGXlTJWaq?=
 =?us-ascii?Q?5Ufl509ND2zEhKfzdkDbBHW/RvClTPuKa0XPqbYzXw2J8zBdYCSRI/7pPMez?=
 =?us-ascii?Q?ntl4pqr7N5tBMHrH+xd9a7WXOGQtyLYNLLL14Vvp8WCpx54vTkWdAB1M0/OX?=
 =?us-ascii?Q?XIMfZ/h2HzZcShrhw319ErbJGPvlqjtPDOY0zZFpjsKxflpwx7tfUFnt9SLa?=
 =?us-ascii?Q?oBysZG+/SS00tIgCH52hCIRLcxKYe/g0EYQXpvNrL54ICUjYui+5AMfoMt1m?=
 =?us-ascii?Q?rlMDXGnm/f6bAziUByCrlh1n//jrMWCIXQwolOKwqhrhIau9G2LuvmzUQkC7?=
 =?us-ascii?Q?jv746h19J1yYQS6zlG8jJAq7a7ovbzcm2voX9WHIfh3Mp2HOuq+SPKsimQuA?=
 =?us-ascii?Q?TAsR2jAp9QKwp1RXn2f/mrDc8gWniZq6f2TSo4FdGjGK7qeXSdJDKgbAP2H6?=
 =?us-ascii?Q?KTR1lNojyDT824ivNJ5yQ/1GLhct1flgkEK2N+pNs+BXl2QmLKtaU2Wpl3tI?=
 =?us-ascii?Q?ZBbft4TOYGbfqWheEizoOBWOK44Vr7avfXYX2iXvdlgD30YwBYoP7duoubFh?=
 =?us-ascii?Q?k+k6R5Go2uuCLiH7NlYalPra5FbPw1Con1wxm+zplKQJMu3es+2ENCDEIZAJ?=
 =?us-ascii?Q?cYoS+832AnMF6SolrFvCakMGyxKLyCEv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:05.7663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27de7414-1c4b-47c8-99f1-08dd13130a87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425

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

  f4f18c053de8 ("Merge branch into tip/master: 'x86/mm'")

---

Changes in v6:
- Minor changes to function and variable names.
- Remove array_index_nospec() usage during RMP intialization in
  alloc_rmp_segment_desc() as there is no userspace involvement around
  this.
- Perform RMP segment max size calculation in alloc_rmp_segment_desc()
  rather than using a static variable.

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
 arch/x86/virt/svm/sev.c                       | 649 +++++++++++++++---
 5 files changed, 684 insertions(+), 102 deletions(-)

-- 
2.46.2


