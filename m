Return-Path: <linux-kernel+bounces-357608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFEA997347
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8798B23277
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11B1DEFE8;
	Wed,  9 Oct 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nSk7T3vM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF231A0BFF;
	Wed,  9 Oct 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495624; cv=fail; b=Rpyl4xwb7JAmIuFHLSmMt78IMi8bknHVhuzffRn11Ofs0ExTm/WDHk/4Uk/xdJTv/IhuEqGZrXMk5qlrX7afxtvOcEMRt8YNWAojpabk5KPvJEXSAcFCz64N3IVDn9YSjW3gHBbBypNeDDxLGYloSFsJUG9xKZUcXvEeswcJoLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495624; c=relaxed/simple;
	bh=Jv4eoGJ0CHRCbeTKocu7+5nm/tukVvda/K7YFiGJSnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz9/cRp+XkkfQz5rb2PSlFvijJtn3WLWRcrtYORLW75rgBG9RwHu8ka5FFi5KZevPPzHQxdRaiFPgVsZcikJEGdo9AD7EIbR6B6tr5S6+BNoNWB6NG4fnUWKYGk8YlsV/4IDUwjzhBv/0aU0PyExoi5N3zC74KvyxYmtWajNUXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nSk7T3vM; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSOfdAFxTCDBAHgb2cC2HjJOsHeB8mq9aXxBPSNm71FMDIPHwv88Uy6Gutp5nXeWSJnCfYvoyt5rzktoqpkyh+qRhrBdPCVsh3Gdnk1PKuDGNoWwJf62ZBP7V8NF52Hf/xLqzyzbOmI7V0yjqt+cHoF2xzxeX6a+HKamgmFeLz3+DoA3jbvFDna4A4J7nEkAcX+egXFZdDMuqlHhmwtEm8Kb13e7VRuwIUZDgOZkOKJQa3+1vyxrFLqSAx0nRoiDk7MyBfUyn7sM+G9IEmfkPIGixUvjNcxWdERmi3tiALJ3mEZmqSm+FON6xq3pc7U+Mq9+IVax/Ud3QsoUDTBraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYXwWbFbOAMzyU8p0RiypVSRJ96oTrGVa1KxZXLRpNw=;
 b=AyM1GT/FCk0Rq6Nax4t73D4Axqw/ABD2D+Aj1qr7lnDMeL6V521eW7We5a6QiV54EFz60nBWwjAFN1ImZtyswXt8pbespBvAb++ueMrBUKx7/1yrLNYEjKzPtzkRar7zXi4hR9APiWqHyCUoT3wcpCHW7gjATQmFJ1Ki+bmv+JFL6rGSDCxUGZdN4kOB/H1fRpx5Km2OCbcCfXxLOyRFljV4hKOvpVn4qKkC9I4YbtH1dQk6MYfgS5awDP5lenbhKZV2qAJrgo4Qrto/K4gHa4G65C9+e8grWXhTZdmMJerQxncOVjy4/+nLaiUC6Rspv+rxK68Rzkfg9K4r8iwZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYXwWbFbOAMzyU8p0RiypVSRJ96oTrGVa1KxZXLRpNw=;
 b=nSk7T3vMfWr564Z4BWCf2ipUgcma/am39GQk9DVeuzgOuHd1hYJ6kVPTB94tKZfMGDsa6BRWqvPlRDZ17I+iA385ldhE5pS9bLL0hC2RGjpt9Wpr5MgT1sxWyJRBIlaObAHLFjn7nti5xhI1dhDfd7XXIEXcdIK7NiMT61V+gcI=
Received: from SJ0PR13CA0169.namprd13.prod.outlook.com (2603:10b6:a03:2c7::24)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 17:40:14 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a3) by SJ0PR13CA0169.outlook.office365.com
 (2603:10b6:a03:2c7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:40:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:11 -0500
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
Subject: [PATCH v8 01/25] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Wed, 9 Oct 2024 12:39:26 -0500
Message-ID: <b991b2de2b8797823ae696be8c193888a5571d69.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a33f69-0ad3-4ccb-47ef-08dce8896e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BVEuEGdTcZNdn+aDjtLu6F+Wnh440SD478PNkACHCE2rj62oMcB8hh6jTK6H?=
 =?us-ascii?Q?TuNARbyrzbh44JE8tV88zj3biZL7kldCjVG/91O+zc6EWQF9hGcNFWgujaMr?=
 =?us-ascii?Q?8XnwlZ8+tbverF0Gzz7y+aPuUqmZhvIhxCryj2vPKgHbC9LFVrLr+PBu7A3s?=
 =?us-ascii?Q?b8mx2EvGKSkXwmjVQP9gReMVgSBJ12QNqfT81VsapeZlzJj5GnmHNRaQuOnn?=
 =?us-ascii?Q?VOGvyITEtvUU4hcrUKktkkq3yMdL9a1UaQDd90EOWUraUJSNkFfdkv9XgQ6w?=
 =?us-ascii?Q?l4no8On3mjCk4r0ywqA/bVFYrNWdhgQvEgB9ZCeaphGPIMpLRNFq32nxYL+R?=
 =?us-ascii?Q?7xX08YjvFxLVVRlIqkTXeJRX2UxFoDk3cGYd0wsAdqvIz3EDhNhkZhoxVtG8?=
 =?us-ascii?Q?JIpQjBzCFMBmJeF5L511kgqV0SkCtHzwLWjoyE/Ul+oECTtKA5p1ftU1YQ1Z?=
 =?us-ascii?Q?SX5GeomwCMmv2lXN4hdMwSrghUmrc6yS//luIH4xcpNdPsv192ra52bcB37J?=
 =?us-ascii?Q?qLaWys/nRilG6OVaLRmWo7IfUxKhEixb61sjWa9U7ZYQenEk7LE5g68lEDzy?=
 =?us-ascii?Q?DiOvIz7lEmU6hovJpWJeW21aYdKUsENW9VldJX30PSrfOM11cNc02mdqM5dr?=
 =?us-ascii?Q?qLM1cWDgp37RoJeYaHQS8y2lWbdIGsnIP0UBQPTrkhyVFd4G5UXNUBcX6+sR?=
 =?us-ascii?Q?wsYXL9z5l+E+0y/V1hsjloFIZpY/79mcLmJterIdEDlcshZ4TeSrQtLzlpSV?=
 =?us-ascii?Q?xoIOUW6YA/SXzNSVDuRKZPIV9uPATcddMb26Ue6L9tdVxeP48ZLeBTFurWKP?=
 =?us-ascii?Q?GOp1Qoi/pHgc+FX3tGj2R2OErDbDgYua30KG+0KIAaAeCpCBjIQ2UvQmcgQ5?=
 =?us-ascii?Q?2y0CLCD/oQm3JdYOO0+z2AmxRGsP1kU3kl9FIQ8m5Klcp1kdpZ/4H4pN1etg?=
 =?us-ascii?Q?ltfe53GPfGSMb3JzC7VCH06Y0p3S3D92Zh57TfEsltWl3EzLFDUeeG/NTuMl?=
 =?us-ascii?Q?wx/h73wdTS/RbQXz0WnicWjj9wyjyI3mmFDDhop6uGxetcH3t81PR2tJZX12?=
 =?us-ascii?Q?KX8VZoiV3mA1ccNHZ9MnETJIkRxAna/kHJ7D6I4U+c5OmbJI+RhGnbQ+atS3?=
 =?us-ascii?Q?ZdBzRwIkspVyRmr430OGQ+TEzOJE05ggR3aDCiLR2ec4+dkl0sn+sRkVBa0g?=
 =?us-ascii?Q?//tpXjWb+CYPouTo4iYosT77i1BHVIJ72DRFluf+3VSrniZNTsFF0aflasx/?=
 =?us-ascii?Q?GiiXNGtcMD05hodphEk0mK+uHft8U+dlcA5clots7veA9NAlF2nByTxw01v4?=
 =?us-ascii?Q?j8vnBArDEYPpEenDYRsb570YMhZqMYB4n5h3UpCGdeujitP3yr6zmEFxtAWL?=
 =?us-ascii?Q?zGlU4+Xq1BOGFc9P8Wq7497Or2hS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:40:13.8132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a33f69-0ad3-4ccb-47ef-08dce8896e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

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
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned. The assigned RMID will be tracked by the hardware until the user
unassigns it manually. There is no need to worry about counters being reset
during this period. Additionally, the user can specify a bitmask identifying
the specific bandwidth types from the given source to track with the counter.

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

v8: No changes.

v7: Removed "" from feature flags. Not required anymore.
    https://lore.kernel.org/lkml/20240817145058.GCZsC40neU4wkPXeVR@fat_crate.local/

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
index dd4682857c12..4c514cb245ff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,6 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_ABMC		(21*32 + 6) /* Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bd84114c2d9..7e4d63b381d6 100644
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


