Return-Path: <linux-kernel+bounces-378694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F39AD428
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08749B217B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133FA1D1756;
	Wed, 23 Oct 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kYZBePyC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B01D14E8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708944; cv=fail; b=UjW1Ic4ugyJlVPf4QBH3KYlZqC9pvkLpGqOUROvfN91zA7iCXWSZbFccS5X6BXMVx6DBly4Y0h9nsiwFRtMAp+j6msbFHKnpKb++xOBDPNntFKwrEp/druZNtvBx1oICUan4a1KYX1Y+fScLsLr4uFU2xlKLyOSaQzmuua9mn7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708944; c=relaxed/simple;
	bh=1J+frWh1UQh10GRk9nR8A2BSREn+0LGdvSrbnayJrnw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qxTKmMJnAi6hJawZqJxcd4bIwoDnRnoJC/P2BGeQiGLCkfVGe7r3WprMKpAjWaHPHZnlalmMSfRGNjqkhCoO+egpPzI+nPrP5qrRdnFn6JC2zUQYIg/57pZk2fFVC8uSN55RJ1z04GTMARlU8OF1m07mBB9YH+Bm49MZHfORkHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kYZBePyC; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so8sCHAY5E8yGa3BwnhQAh0sTk2y8WSDRZtzqNy5emCvoVpz7ywUu8XBHFG9141XXBO+NgTkMCLGWHAye6tBto2R/TGOPwXtQVV4XRUWjkjbbF6Oz+ILA1MI43pt53MrNR71aWCsjPkWNtYXhEQl6JKvML7OOUfE+bhBHYBfYCatN64K8jVVAFKKa2TYydom+7RkazQyu8QPwMu+oL6rj4CTCPW36XF5O0+Jei5c836sxP3q7n/UrbYSbMc/j0FH+sro2WO+jcWkVoynhkT8Vw1OsNuzlaRiWNVibse7UmefnLN57E4p+FvkEdhtUoKpwrlcFvuWDCXgdS9Py/w/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbCeXKQxWYFmyg6aOoepbpvyAxc0DMOTGxk0CxncIPU=;
 b=cAhnQz7rG6kyGs9QZuYRnZLUf5XpeJlNW1IzdslOyyybmm75nVJiYjJCus6WQH2FilhTHKTwxVBEgsgFMD2FbAbNdapg98ft4HxVrJvc/MXlxaYBiUToS0NyOoed6jPF34a4kaBKJ4k4BI2Z7fyD20YWnMVrNndSuOL8Fm9/pSZZLlgE8X5Eq00j6I+wtjduJENMhi5E4opmaNWKlIpPYMl5/y08teHz2YkVmTxmBZ8nqkyWBmfGBpO8FyaC43gNCbR2yGqFN9E4T8SVaNBie564McRgbWS9O8rjDSly2dmJTwaJrZZIM/kAmm2QnqlMHvsVZK/EPruHVhHBxZbgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbCeXKQxWYFmyg6aOoepbpvyAxc0DMOTGxk0CxncIPU=;
 b=kYZBePyCZKYLaHHBHFlI56U/XhspAEv0MW7YV5vvX7qD3QmObjs6H1o7d8+ALsqcYIrDyKMDglR5KLF6dlGsSKrpSfssR9WlblQKdFzDbhxA2W9kkBnaOcEztBwV1qD8N5jTjZ8iZ6JedeCZst4b0HDDEadwY7S4yxNV41w4BSs=
Received: from PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::25)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 18:42:15 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::70) by PH0P220CA0005.outlook.office365.com
 (2603:10b6:510:d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:14 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:13 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 0/8] Provide support for RMPREAD and a segmented RMP
Date: Wed, 23 Oct 2024 13:41:54 -0500
Message-ID: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: bc43243d-13c7-4317-9c13-08dcf39269fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vcbULiOx8cfy5py4Pt+lpgCKpsU7TBN1cC2jEZ2uiPakc+XJIWcj1IKTSF3j?=
 =?us-ascii?Q?tg4jFzhsFkyCsMepJuWonO6HrrGxodruTqLyNb8ypMpNxtTHCXyPcdZOUYjN?=
 =?us-ascii?Q?R9f3mpnDUmPQ8O9FCoGMJgLr3++OCWQw7iMze/vPRIF93kgsmal/hPjK5rsP?=
 =?us-ascii?Q?0WbZR1n+XAOqvVMcyjjXWzjifk6QYmpVLR0DE53iUo7xty+aGjmjgfCInfrK?=
 =?us-ascii?Q?K2TP93qGI+A+cZqM6g2X56Wq0ipnjOl1UlIrCVbL/n/ItCNkfQPW+OvH+goz?=
 =?us-ascii?Q?GdykQ9O0vfDhdFmiaIBEzJlQiy/OEuBXszYloOxS0kMN+Il/Epj8HgZVLBnS?=
 =?us-ascii?Q?6X7WAvUiKTTyqJEfeQDeus1ynzEnX1trVEX5P/qN0v5A/mJsY91OgnknoHxr?=
 =?us-ascii?Q?/S5wlWmJEj7CvFkk5UMnZyNNFuJa2IeyOSNumNcc2QjK/GgN6zmRYhIv3i6l?=
 =?us-ascii?Q?hbU7pKX6uA4VOTDP0H4oPxeecYkSImZRmCZSeilvWZy6xP8j8Zf8whbtraOh?=
 =?us-ascii?Q?pq35m7dZXT92goyPFtum5wwsCXf5MkYx2n1ZkiKaB5PfPFrSDGLN496EYI5g?=
 =?us-ascii?Q?+XYavYgSDVddgjcgWHkie99BeBILMZOyGPX7dV1qqHyl8dpxxiLyTU9WKEPJ?=
 =?us-ascii?Q?14BO4d5o0vosi0wYoURskAQ2+lb/la8tMcHfuxbKXy4PW2s3c5FGsGg9G2Wx?=
 =?us-ascii?Q?02TnFxUPYc3zcLEVkx77UdAP0/wo+RU/N7TjUoqY04edjhEvM8ms1a3yYPgv?=
 =?us-ascii?Q?ZWnMhcA4Out5VsrbFoI0ah08trNpqMAdmYJyyfHJ32/muz002Tcv9eYdT6tm?=
 =?us-ascii?Q?cMDwtRqNT1FxpVr8EHmDIXm5kXhaKPiA10Yx0SsAHCfm0jP4XkzjutjhGbgY?=
 =?us-ascii?Q?v6Mb4aGYbGCvQl94fzaAf5qmoir2xPqMtgsbu9eKpgTgsHsTCY6mGSbYASpd?=
 =?us-ascii?Q?WunJGbScZ1nowVBqOUOiZ7UQya2CYyuQrDbkSvyC/YfJllKulUfjWQBR0rZi?=
 =?us-ascii?Q?Oeq1uHXP7gcfWoMaQ6pDIJGBFXYV0CIixhZ6pHp0OaUHLmtZAwE6NMph4oj3?=
 =?us-ascii?Q?lt9nDhdXhe2r5C07qfdpXoTAd5sGBFSeaogD8j2SgHfYdwCPyVi30bQlevPX?=
 =?us-ascii?Q?6Drr5yRoE8oMj2h5KAbGyCMkend9r8jtlMTAs79ITh3PQcOIFGGcSKr3w/5i?=
 =?us-ascii?Q?wVaDJQnXsyNnjKcc+0eENdoj3lTuysVpq4fBqXvLYLQhuIwsUPxBskVyN9nz?=
 =?us-ascii?Q?VC24Fi5JxJP1HHlxcTbh5F0+L8mTroII8Svccf51fHIp8FWpASTG1+3x3lu9?=
 =?us-ascii?Q?/XOzMn/cyrq7dLz6cv2ZcgYNYqZX4w80bi2aU1/wOYQhqeS59WBgEuEp9EFH?=
 =?us-ascii?Q?+B6R1SI9hDM3n+0Nea+VqnCkp9o/yHJVydVYV7rVaJn62eE29A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:14.6961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc43243d-13c7-4317-9c13-08dcf39269fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

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

  94559bac4d40 ("Merge branch into tip/master: 'x86/sev'")

---

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
 arch/x86/virt/svm/sev.c                       | 632 +++++++++++++++---
 5 files changed, 675 insertions(+), 94 deletions(-)

-- 
2.46.2


