Return-Path: <linux-kernel+bounces-276980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D5949ABC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A83B21C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA9D16BE3D;
	Tue,  6 Aug 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+p+npvY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6D1741C9;
	Tue,  6 Aug 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981682; cv=fail; b=KRh6ww1y/3wRMcneRYn5zcORnwUZ9wmJsltTth3py6CEilCIEZh8/Pz3fYdCHgbWi4K+sun+66vR965+ZXlViNoVjmr0UlW2S/bCjN1OIh8qM0f8chqiIKvNq2OF0dtuzDjYWkcSE2phHymC9lG7vUDKzYg/+IXj50NCzXsYENg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981682; c=relaxed/simple;
	bh=HhvtIO+1v3ip1SgrquzqqTlZGxdUMkemART2Ha4x8Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHqreCNn2P9OLxNkuFFJKylfE+PamXiB3z+LQURKwJew+p6Qok31UzKxv6ws4Q23ZU6T9yV9jPYM7faQuvyTZt0tmswZ2PLIM0XYfl972/glcl5UvOl/ZjenaZNT+MDsbZW5UpV55obXVndLmldO6V77YsDH1P/WgVaBTMKxAXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+p+npvY; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJgTM9hqTRn6mULfzm7ieVFhQyLEuTTOjJXWYN8lF6zs6k/B9Hl0Y5x0aSxAVonGG1rlyukOOmRs7WbhsnnR/1bftH3Od+UCrUs4XNphcmci+KfIwMouJ9DKsIPD0A/spZAnRlptbyLcm0MNgHiNfdr4y8I3uguFWJxnYdLPWqLqXuBxn1+QKsFYhN3mcylRY+6sQvwBvpUE9/67zQStCIZpo/oPyOP06LuKLOrb99XCj4p3FRTc35ErN82b9TVTBoCZ+o5xcb+PL+oV+UE4UUTkAj0SmjeLXHVk7WKfa+qL+ZODVpsVKvcEJDu3BtGtOdCjCrHz3JXSGndd6YWGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHH64LIbbtre7Zdtdv7NLazKdshn2F8/Lvht34dsMDw=;
 b=NBk7AUtkp3DoRBsRDB4Z26QeRqSkjIyFLGHZ/zrZsTyqBdYgX13wkaG5f6e8bIcWeXBHlicdN/wZD+bW1A9wdYLEKyhR/S+N9Da7ZJExSYZZw6y3IGRO2Tht1nZdyhDSNJPWs+lIFLgiUCJ2rRhMCm07u39QHc13JjMzIyGgCl/Tr3nB9ZF45GTyY2Q/iUXajozYE5sdpNJd56Go0BwHeZai/BpL2lXcufQU5m10l2Teh+wRfakhbasfD/wO9lAy1s9pO/E4HyO5uRJzRE9jN7mkrxDc51iGre6EN0CDHiAymTfaeqaW+DPxyZDFklfCicXw2yFYFrnyPJgSF3HU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHH64LIbbtre7Zdtdv7NLazKdshn2F8/Lvht34dsMDw=;
 b=K+p+npvYcS0EjPANrYT7zw1fPYHgBcxoJ+1my49blkT0qgLVpEDCs1ViCJYfG4FXLYLqBSBpHOsP/ZXg8hvpIC103Y65Q3QYnXG1ZJ5Iy66oZPZhBs+oeNcDcGqW0OwstxdecBirN7rQs+t10omyNcmwinwcmk7L6o3r5/3yFTA=
Received: from PH7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:33d::31)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 6 Aug
 2024 22:01:16 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::73) by PH7PR02CA0003.outlook.office365.com
 (2603:10b6:510:33d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:13 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v6 01/22] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Tue, 6 Aug 2024 17:00:38 -0500
Message-ID: <72b61576c5101f6d325c2384f838cb475c7aa576.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: b45be339-e6b7-4a24-5ce4-08dcb6634af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QzO87bzBudajmk5sQbkYm7FEPbrikMbxtcLIe/t0n5rD4cJ7QPdH3idRvSer?=
 =?us-ascii?Q?R2+YOxthejpEFR4QBeheaRhAeOtAUrfdz3zpjBKCwokqJ9cgUml7x2RkmxkZ?=
 =?us-ascii?Q?Kvb9UbJXebxYd/NC+Rtibhu4SQb/TRRtgJre+EZDOJs0iJpZYatSroGEU+kk?=
 =?us-ascii?Q?8UWInVlhnag0JOcJpX9vFBvn1OJO6+/SUFoQ6IRxgbzv3xjEHQYu6/+H8h2X?=
 =?us-ascii?Q?o6Wy8QM25N8ec8qCg3wpEK0Et8YR06Qi9EGaYolGfgMrdO29ED87602hBNsV?=
 =?us-ascii?Q?PnvGPlp7O1aU9Ss+XnzjSPOVpnP8ZZFMqsVB3XjvUdbf89n8WUiulpM4cgKI?=
 =?us-ascii?Q?24SZcBP4OATGwHafJqZqGMl2816YR5wJjSBWRvZeAY0PP/7Q6DsEVhNViSH4?=
 =?us-ascii?Q?gv2adqDrlb+yoAefaajKKy+Xe8TxVNQHGFtGhpTmAPr2brQhL4LJwAUzaChe?=
 =?us-ascii?Q?aAHYjHxZAF3wAwKVS75YBDcP0zNjenOQHyfg5hMtxmmDF6hKJhkeDjoaNlLN?=
 =?us-ascii?Q?VGOZFh/PfE9hykAlkCxgAqV+0c0byiFCiy/Zr5dJ4YQzYTj/o1bBMZo+Fu2q?=
 =?us-ascii?Q?lek3mPsL3Ni0gEGuM0VZ1mCuzst0HXjUvU3/VSHFRtUgnLXiGc2TrvMyUzdw?=
 =?us-ascii?Q?f7oG1GB02wApoGsiSbQjtailtp/ZJuRsS+qhdgppSVTnGfa6xB8GN8mbYi5g?=
 =?us-ascii?Q?t1Zb88WQOzvS9xt4Rq3ILeR4vdPBZ4/hJIHzpAJebFAsQj/mVVcuCPXgWHKm?=
 =?us-ascii?Q?UsJ6UscRoiK9Xw9CwxBUqdjDTdBfBXi00iKT5l7YbhsZ5QYYmB4BokKkE0mA?=
 =?us-ascii?Q?mKtbJ8NsuNQQ0YlL/nNJbI7Zig77LFDHcqbKJz9IbpeAvh5LvduTryc/tpYz?=
 =?us-ascii?Q?AvSYY3X+8riUNfaYFyU7HsPBy4Ip5RqhZJyaWrHZClOvBMhuOZRarCeFfNLu?=
 =?us-ascii?Q?0tO4QLjxnQyJFvEG7Lp08j1/qf6eu2f+f//V5FyGQeKJ3HM1fRvEZxUL2iVG?=
 =?us-ascii?Q?Xn5Kj+o3c553aVC4vKYyQ36yUiKObw8cER7teqxwYL4wUjeYRpYRPIuUuFPr?=
 =?us-ascii?Q?fcAdcR1zarpIsBaQ8lB+Vs8DkIYOsm7pJ36I3+MDw0qe+i+uPFZJZohUB7YA?=
 =?us-ascii?Q?KFVp2eKn16hpmDE4x3c9dO/rIzZfwxDAAlyc+lOtEkrvtCPLbVvhCJZKY2Dr?=
 =?us-ascii?Q?n404pM25x/uGC57KK7pFhVKOgXXM8zrvZQi1LrvDGv5h+NZxh5iutunpj256?=
 =?us-ascii?Q?Anjpr6xMxaInU+4L0lSTeddlgMisW8v44EKHqaub9y4+XfwiXjtTe1e1RNw/?=
 =?us-ascii?Q?4xbBmyEUwNLQbfjWCe4SI1Tnc3SK5K4PIcUwsvkbMZN/relkoMSdEQN068xG?=
 =?us-ascii?Q?wAsBgGSIoFv/u6SZun9h4Vp0/ou+/o5F4dL3KeXQKt/TxkJApA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:15.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45be339-e6b7-4a24-5ce4-08dcb6634af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

Users can create as many monitor groups as RMIDs supported by the hardware.
However, bandwidth monitoring feature on AMD system only guarantees that
RMIDs currently assigned to a processor will be tracked by hardware. The
counters of any other RMIDs which are no longer being tracked will be
reset to zero. The MBM event counters return "Unavailable" for the RMIDs
that are not tracked by hardware. So, there can be only limited number of
groups that can give guaranteed monitoring numbers. With ever changing
configurations there is no way to definitely know which of these groups
are being tracked for certain point of time. Users do not have the option
to monitor a group or set of groups for certain period of time without
worrying about RMID being reset in between.

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
The assigned RMID will be tracked by the hardware until the user unassigns
it manually. There is no need to worry about counters being reset during
this period. Additionally, the user can specify a bitmask identifying the
specific bandwidth types from the given source to track with the counter.

Without ABMC enabled, monitoring will work in current mode without
assignment option.

Linux resctrl subsystem provides the interface to count maximum of two
memory bandwidth events per group, from a combination of available total
and local events. Keeping the current interface, users can enable a maximum
of 2 ABMC counters per group. User will also have the option to enable only
one counter to the group. If the system runs out of assignable ABMC
counters, kernel will display an error. Users need to disable an already
enabled counter to make space for new assignments.

The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
Bits Description
5    ABMC (Assignable Bandwidth Monitoring Counters)

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Note: Checkpatch checks/warnings are ignored to maintain coding style.

v6: Added Reinette's Reviewed-by. Moved the Checkpatch note below ---.

v5: Minor rebase change and subject line update.

v4: Changes because of rebase. Feature word 21 has few more additions now.
    Changed the text to "tracked by hardware" instead of active.

v3: Change because of rebase. Actual patch did not change.

v2: Added dependency on X86_FEATURE_BMEC.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 3 +++
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..9dc54d24e8a5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,6 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_ABMC		(21*32+ 6) /* "" Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..5227a6232e9e 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -70,6 +70,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_CQM_MBM_TOTAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_BMEC      },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c30188fdf..87f63e6b2994 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,		CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.34.1


