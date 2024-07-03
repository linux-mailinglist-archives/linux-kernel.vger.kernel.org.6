Return-Path: <linux-kernel+bounces-240250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E093926AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4106C1C23FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7BB194A66;
	Wed,  3 Jul 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kWTZwmv4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D02194ADC;
	Wed,  3 Jul 2024 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043340; cv=fail; b=XpLErwubj4EG13laxPkGMDiEgtELZFafonGqD+lzVy5E1BAoLg7Vg6zqyKnQBdDso0tAXkqp/7tdtu0iv+vexfvhkZQ0zRafn9ELOawpNsE9MK413y05UD89M10ibCGKDEVjG77aWKB4j0P7Op6sldmNVkLClgx1eLFF//ykYjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043340; c=relaxed/simple;
	bh=DW3JfpjkGmWr993HI3WaZTyQm3v4l/yNsfORZSzQjqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orl+iLVIu7oZb8tBin4dIhl4+6RuprgjRoJ0AuCZWhUyIt8W4qUetGejA6EEtQ5i2cAId+cLz8QXqyxCYSIW55caj4XpqX6M+GY9preckpLG8PxSSJR5t0MYK8iNJ+8yRNv2OrVrFHaq3djd90QcfXd3sEM6N4wuHW9UAqg1fok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kWTZwmv4; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSJgJUkNU28DKJ/uBIh/nJE06vTWguxmHwbnzW+cyrkDQ9/HqbbvhnWe9Gvmqt2AMSGGSTK2Z3Ydgif6HLSo8N75jGRWAVCkRf6/pVlBhDkmeU/Lve7s0hSSCyhpQjsUmZV0KT0wXJl2Qwdlj22qHG8UBzul6IxmIyLt9vt0e6pZVHiPAPTgEjdoiuVVNWJM3+gjvDW1KUdOCypKuVqPfnH3vCPAkY+7hutn9KsxmJQiE3mKRav24gyq+gDTWv2/Wde998GiaCbUh/51Pv62IHKtApXtEqB2nVMY6BIvOAKXB5r+0+4CO58rd+Sfbq/2lk1OJ49H1uQMGWNEfYmHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEa1cBR5TVudI351X7bacIH/aULKFbWylsK88rpLnls=;
 b=VBQx4pGcwi5jkbv0XBWaBj6r25jgO+jwyLN7J32zVAjQsICGd2xr7asOA6NNdTagBQccxsNmYcvEiVYwGvm/Djx4mVU33HXgP7cf4A2VHaboWWlvb2Swfqn74S936Q/gNGYPZvD6yOQlpUytdzeB+WV/9YCzydk4knTRHeXz8o0jUetU+orPy4xKe3ay9KPowPFtjMOz4UFd35/NYmqx1GlWmAa6ZjqPENnaVJ41gVNCafm6vqUnvCo7M5m85EAKX0xRhwabzSJeSO1xCE85XhQ2NnC9G+BSiuJkhFnKTEEAA0rIVpbLnzRAQJvhLZeA6/OU2E7g9mvqRUHWv/qC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEa1cBR5TVudI351X7bacIH/aULKFbWylsK88rpLnls=;
 b=kWTZwmv4Vfw2k9jSE071jWKIucq3zjhFL0oys65UR4RnFk7jdd/UA+taYCaFkbOaOfE5P9zKtfyjdAo+XsWhZvRMvJl1XfaaXQmHPmtshl2JNl11X5rZxD1zRtF/R2WYEohjz9Q0Bl5XFFCEnjPYDdTYvkYst4e2WWWF7rUrW/w=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 21:48:52 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::e1) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:48:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:48:50 -0500
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
Subject: [PATCH v5 01/20] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Wed, 3 Jul 2024 16:48:12 -0500
Message-ID: <724d0234ca56d71f9d8d893806870181d027f556.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c97f83-21be-41f2-0338-08dc9ba9ee26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bf0xIPc0fyiquF3qY9i3OoVPsqwllcZzdu/xJ3F5V49U56lLgP6FgBkbw0ZN?=
 =?us-ascii?Q?zqPkyJTsl5pZJ0C1kBErXb8Zf7dUOFqBxJKrq2NaMHC1Yg+lah7zTIpdlq+/?=
 =?us-ascii?Q?H1txewehAN5UJfZMjS7jlz5jlAJPw5IdD/uY3KpPJlccByOQOOq2rLV+GQis?=
 =?us-ascii?Q?sJP/r/YJia2N5Uy/hdSJ3t2AI6bem2s6UOIhxeLND/RkuRjMgX93z6ZYtD4p?=
 =?us-ascii?Q?uqSqaQhUpTiiez/Nt6DxF5inVG8IPUJqX2gfOg/pjaqaPRFC8gAzUIOt1ZZZ?=
 =?us-ascii?Q?Z5iiu7Svl/wnrtTKWdyUFwWYy7FdNXU8JVqPym/ASbh936DOA4P3SfPkYeMe?=
 =?us-ascii?Q?jMJrFA/+ByaEIJTmbo8m3ptJ09JxRQiitOF9RtbsOk4AIEq954sBxCkjza1h?=
 =?us-ascii?Q?tfK0QTDY3HgRHc5FISYwH0qmtwt+gr6kAZLhGNH2kHuwSfFKhEqIlrOcv/pJ?=
 =?us-ascii?Q?w2daD2voZ7nrEhNGKi6iP6P6SQJo9ceCY3qxGpscEuRVsMAZsrvELmvZqj/D?=
 =?us-ascii?Q?HuYkGjCM/187bRy6Q247ycC/BqegSOx9MdR17p7hB1cUjJ0urQcwXoDKoILe?=
 =?us-ascii?Q?tmuNulNNInj3L0M9RZlMymXRM5GXi0bbuFGJBb2ysF2iDjoa0clwWJrR54+t?=
 =?us-ascii?Q?+fkCVB3VngJQlM1P0Mmi9tU8aZJWIWwWQjwsV3eLIEiiSIYaGEBtsQHX3tad?=
 =?us-ascii?Q?v+9pTGInaTzd3GQuvLTvV916yVVH/AHV7zO2gu+Uzl5/FVQlfEVNelfK8eNC?=
 =?us-ascii?Q?HVmrY1VzNL7HkT0vbikZggKZ+klf6coNwuwqXpUCpdInUhKigkwo5e7PFzDL?=
 =?us-ascii?Q?K6uRAzHk/juAqiWw4Th604WmMIYqYIPYv580dFqtj+a+wtTvVUQNssuDl9Yr?=
 =?us-ascii?Q?SqlHlQMjwpOiZng5IW3uweBMAGE6IAUbp10CbX0Ri9Xw92+9NzHAeae3m/JF?=
 =?us-ascii?Q?rFqIbojk4/IMNtW6dbgYndE6DyWwxc8tNzogED1K9D0qB1lZX6NAMbiNEWZK?=
 =?us-ascii?Q?ruKdd2ukY/xUSfM2A7lwFvYWq5mR0mGPDKBUIfrre2YunsDbXYnDihjCHN7u?=
 =?us-ascii?Q?KqZsTMDBLF+xvFR2wz5X041zQQzlRJG2JVJY/PkkRRmfa99XbcQhSuYLi4dM?=
 =?us-ascii?Q?B+ithcO48xgzHXOw3onDQmnQikHq7B4zRnYpL4M7Gde4J8ffhJQJCxfzdRxR?=
 =?us-ascii?Q?wpcHjL9w9dLsQ7HwuXc7JLnzSK9hKm4oXWNxGRJ2YXuzGcg43jY4XwBPegnp?=
 =?us-ascii?Q?dTDNPheMBWyNYJTB3C7I4fdT3d+m8db1Fwl0+BmMfyDk6WptksiC3tFLq+Nk?=
 =?us-ascii?Q?ZfenWYYLv8rsDkM9pasA4ypAmvg/sUkn2hu600lWNyCljFgk287vm8Yoskdc?=
 =?us-ascii?Q?CLtKRtKBxfd9Y8fa0UtX9/QeH72b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:48:52.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c97f83-21be-41f2-0338-08dc9ba9ee26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225

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

Note: Checkpatch checks/warnings are ignored to maintain coding style.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 6007462e03d6..d7e1764cbab7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -471,6 +471,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_ABMC		(21*32+ 5) /* "" Assignable Bandwidth Monitoring Counters */
 
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
index af5aa2c754c2..411b18c962bb 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -48,6 +48,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,		CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.34.1


