Return-Path: <linux-kernel+bounces-227366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CCC915017
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690AF282052
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E219AD73;
	Mon, 24 Jun 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gc/xZNre"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FE19AD45
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239852; cv=fail; b=jRoTyDwn8azRq/f8TqXrDOyYwZemMSHdy1ABbTtohHMc713oMHVKFBz0SU2RQrMfrnb2ChIpiUFa3BilDEf0BlhldWd02/d2X5BHsJAxEHzk+HZItRpX7x7gEz1c73pdkuUS65eyWjbbhHZezqe60Vpz0JGczeMo1Vr/3B1cOHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239852; c=relaxed/simple;
	bh=T/HaAH6fK964BZEAqSwjkdzZPiuidvkBOAKP1nHDBhA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YfPyPEeexHesefKHLgz6dQ8bky8jvEWyrCL7GaN0DQwXEy9o2oLKR6zcv+6wXGoWNG/jl/hnGTNYPdzaBoTS0PB3xj5VAB9xzBe6+AUpXepPAL0H6VgPE9Ccjn2vYcKAEgGqDMuOR5hvnD8GfmFnEvKQmuccq2Kwhz4iUohSXv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gc/xZNre; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmSV7XOv4oB8tKAAiBs3MJFSsMCY3lcJWsVGdWeJDkRf439/aFJyLsSpGW5pNttjo5/FjLHSOVs/+oMxJdHWyhkUQ2ZQgx+2Pg5875t/AKcWB+SpegEkci8ZAAcS5azFxI4H6fTLi3BKJ2BxT0NpEWPhoPNqj9QLLc4+IhMLHi7P74Gmq0VQvf/2ReNqVy9kAS0hKtgQpKttmThDBIBe7vq3j0is0r+qXq0GULTzgt8lOnuswzfrDWsNw9VPn1l6ZsJmca/r+ym6u/0HiDHG3++xuPjeF30gN0Nf70V5YKKGNWgVNn7UBeKzs6wQv2LX1t4C8ubk3KAXJyzkGFU1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAMcH97WGfOYsAqNIzkvFgcCHo6Y9b9/1TXKo0NULWs=;
 b=cPj6ihrBvh0m4ex9g9TAhm7PBf85MkvWmNSPO1o3iOhfMIiC96rpqfXuUSibZBMcJouQlSqimRWYPYanAiVkonltyNCyjNc2J2jMIGzC2uDuNICno1jhI4kTVqrcDz/Gu0LkTmUSLjugEJ50WIafKyi7DxG0b4UW6lW8Cxh1Dh1Z+OLsj7dSS3EK/hLNjjhXuwzkcO1Yt9EdknfcSKK8Vo7pOaATDLZdcwzMVamd9QOq0uF7rK5hO+lXsv0y9CNXXEjiwCHO80EQ4WXjBtswDwvmsgHeOlh7pmtXuQoRor6dvtwlCeMd9FOg85rCJ13mlv5Q1+qvSoa8Pn1zSHx5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAMcH97WGfOYsAqNIzkvFgcCHo6Y9b9/1TXKo0NULWs=;
 b=Gc/xZNreutiynfL4tlFjF/3r5DOWDJHiaPd5sQ31U5WME1zzyWfa+aJzG3SYLzfqA1worFzCc34CZpQxCZm6a/+JUR4h2GazusPP2Axv0wY6bDT8Lv3hJekVA7LMlHNKT+SCVgUeyzK2CgsDkN1RVJM1CIcDg8CK7dxmIC9TvVc=
Received: from BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:37:27 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a0) by BL1PR13CA0359.outlook.office365.com
 (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 14:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:37:27 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:37:26 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 0/7] Provide support for RMPREAD and a segmented RMP
Date: Mon, 24 Jun 2024 09:37:04 -0500
Message-ID: <cover.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb47253-4de9-476f-0e14-08dc945b2b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4z/8Ndpa6s5FL8nBvAlrpAelQnrlA6gtrqf5qsHB0rYv00crsWPqrQreEQh?=
 =?us-ascii?Q?W5PsvHLQN88fUFVEDjJYkK7xYyw/wxSwMsYlloKzfnfakRcaOIPHBoCoQFWX?=
 =?us-ascii?Q?FyJ6HGLOHvlJHk1BQ9Bo8+JRwqxFUMAHHYfETzuIZ/xBoiiFoEQN5KnZacvj?=
 =?us-ascii?Q?Lo0zyU46QPI14Ocj3afngVFRHlGRh7NDiafddNV+Am5rfwOV0u7W/yKBkoYr?=
 =?us-ascii?Q?vRTMgd3Cb0W5wsUR8LPNxusK31RL+r/8Hex2HDnCMm1kMSlkphrGrhmFinQC?=
 =?us-ascii?Q?466xzWGbm+FaruBELo1ab+avWUJKv9wEI9gvLR28JUa1rBqtNqUun0eE/As2?=
 =?us-ascii?Q?AEp4ndRiC1E1MLrT/+9OViFnzi+yMKsnLAuO4DeH2SzhGa9T6iR4DM4jBxD9?=
 =?us-ascii?Q?cigE/S8FDbKiy8hcXpUtya4Xr0LMmr1JONgJ5BlWBnTnmJwYdJO0UqZMLzvP?=
 =?us-ascii?Q?ezZbj4NgX47ExxVsdmlwBOaVMIjnascngp4xAkJ23WMZQLVoxDY9UYefoSaQ?=
 =?us-ascii?Q?jwoXVirTGCo/9asLgN2t29hajYjrP+ljr+UB3Sa12q53nfvoRK2BjVP1po13?=
 =?us-ascii?Q?/HQcigxZ3BJ5dgNpBDG70P7PXSCH1J/+7DXTnvgaFnoxscYMZPQ4eXEF3if5?=
 =?us-ascii?Q?Z22tfx6h5LR/O03+D/FRk0eXMGY498NC6ngrNNgfBBA4WiyUex9ITiGQCIdX?=
 =?us-ascii?Q?wMgGjc1bSH51XBc+tCHj2Vyp+Qx05yGRjKWFR2MsA5Si1qbymCfT6QQWZ/Bp?=
 =?us-ascii?Q?Ej16iPscfoeVpBwBHB5UCaNsnCUy/u03Gw47RxQkFfffIl1mlXJKFiPh1kUb?=
 =?us-ascii?Q?ZDCRLLz1M5hx1n2vvXlGhGZm20ACYVTV3zE3/SDFGcvoap/lzWwmehTLUyIU?=
 =?us-ascii?Q?OTk/GRYA+gSv4ZboXZ2UlmD6B2qdb0c/c/fGn448S+CdUFLilLgFqXR2PlWs?=
 =?us-ascii?Q?T0yBaVnbaNR5TP1DVZOn3Uy4iS8Y4DNWDuaATHWWg3d3CmFbLZ5pcd3wZSYf?=
 =?us-ascii?Q?9TgFdkqHQExXFjy1oaG0KpRo6xsjMmAz0F08yEjJMWMB6NnudP0uqw+7+DGx?=
 =?us-ascii?Q?2OH63mh0SOIQKSPqc6aAB3IHbUTDxJS/HQGRJ1Npw6BUdQtAGPqVMHy4nLQt?=
 =?us-ascii?Q?FLKwGiPbNgN3j5PR4pGP7fsV04m4DPwjbIbOP9yAsRPWyUCr00MxjcddJMkA?=
 =?us-ascii?Q?U0853rt6Npy1ELd3u2pGIElWE4yFxGYWFR/uHp0wWGExY8xfQOAtkp+DY9lW?=
 =?us-ascii?Q?JuI2deRG5/BI7cODlW0ziSZ1GemomjXUINVAuGesDm10XoP5wOXBZ+XkNkhA?=
 =?us-ascii?Q?hhOu4MNElwQtcBpivbgP6MdP3GD4wbwTCTKypAG5xCyagQ1BMVixznnF+Ckj?=
 =?us-ascii?Q?2oBQV/k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:37:27.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb47253-4de9-476f-0e14-08dc945b2b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

This series adds SEV-SNP support for a new instruction to read an RMP
entry and for a segmented RMP table.

The RMPREAD instruction is used to return information related to an RMP
entry in an architecturally defined format.

RMPREAD support is detected via CPUID 0x8000001f_EAX[21].

Initial RMP table support required the RMP to be contiguous in memory.
RMP accesses from a NUMA node on which the RMP doesn't reside can take
longer than accesses from a NUMA node on which the RMP resides. Segmented
RMP support allows the RMP entries to be located on the node with the
memory the RMP is covering, resulting in quicker RMP accesses. Each RMP
segment covers a specific range of system memory.
This series adds SEV-SNP support for a segmented RMP table. The current
RMP table is required to be contiguous in memory. RMP accesses from a
NUMA node on which the RMP doesn't reside can take longer than accesses
from a NUMA node on which the RMP resides.

Segmented RMP support allows the RMP entries to be located on the node
with the memory the RMP is covering, resulting in quicker RMP accesses.
Each RMP segment covers a specific range of system memory.

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
    - [13:8] : Contains the programmed RMP segment size (expressed
               as a power of 2)

The RMP segment size in the RMP_CFG applies to all segments of the RMP.

When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
area as it does today (16K in size). However, instead of RMP entries
beginning immediately after the bookkeeping area, there is a 4K RMP
segment table. Each entry in the table is 8-bytes in size:

  - [19:0]  : Mapped size (in GB)
              The mapped size can be less than the segment size
    [51:20] : Segment physical address
              This address is left shift 20-bits (or just masked when
              read) to form the full physical address of the segment
              (1MB alignment)

The series is based off of and tested against the tip tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

  aedd5b6d65f7 ("Merge branch into tip/master: 'x86/percpu'")

---

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
 arch/x86/virt/svm/sev.c            | 633 ++++++++++++++++++++++++-----
 4 files changed, 549 insertions(+), 98 deletions(-)

-- 
2.43.2


