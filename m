Return-Path: <linux-kernel+bounces-443881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BE19EFD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C7628ACF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A341B4154;
	Thu, 12 Dec 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UNoUYYrN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE81AB6C9;
	Thu, 12 Dec 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034594; cv=fail; b=g+VncCA8324S2MfE0GaiYUsb23NoI8YNtW7LcyZDvESRgn01D4HhCaGssS331VimviegdqASN8UBepfTFx+hf/XpQOB67VnjQqW9PP7eGxCpMrp3VPqJTFMMaj6lx1xQvVK/IJloGaQKg84eqTqGcmh41+AFBONkiU9QX4tl/qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034594; c=relaxed/simple;
	bh=hx89S+hD5768AGgVvW5S4CTpHOw55fQETm+EwJA/zfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilhTwt5HXHU7d92/yTKXr60Rc8di17GMnR6j+9J6+JXnXe8SZ2SfFpgaKKCw2EYkqi4qoJ/6brht9lol58Ivuxx+pQOsGio0jSJwuCkst1uqQVlGNI3cIZ7reNaJOgVDUwupP3fjVVNdyr4CFlt7h5GiYcMeqeuNZfJ5g1B2Z1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UNoUYYrN; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kycqYYn0Akv+3b9AUX1wwctsBB2jWjDCZMDgqssVZmWwPz/FAJZt7FHH/bW2eThtE6tzX5ayz8fhkmI49IcxKaKUooV9go/grjqpFa5fy8XPY0bzr7OpJs6b9P6+aagr0V2zxkiJvk5Ocw6/3ezjT06/OXqPEbQ2VkzHlp8DBp+eN4sWDoVekq3bQQfdf/+ivSDA0zk6JOVJ2QgfjnF8oHoFwxqC2hNcmjt0ysqQ4lDadYCdR/IRGdpo/JjACl6r9t2/YVQd7LkMD8igogxCvMmFMpYqFZj1TDCAGyUQ57J+envuaXXVO4xTHYXc5Bxm68BehvCrrLU84btTZ6yPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnUf2SvAnXEq4ksrbcwrck/kzdcHCc1676XBC7QOuwE=;
 b=ivxVQeYYhQHONyHPUtTPK0IVuxDbETPAZkVC5sv1sXUXp7/w5QDOARe6bushpcbvdv4y7wXS514Md8ZkgD4KMVwM1wYS5ctMEMmGDmmJVrQ367cJjIiVnOohW+mdm7FWn5LVWP+btvpOdsCvOiD4yL/H399tgcVNLWyiCyM1atWHRjVSlrEwB8SYWw0blmTEFc+8WH+jt+hzpEB/p4kgHKkt/1rvpNETzcMqjtAkTSuWSlohe6RZheNUR6JhMr7PopnIcQXeWeXVC0AY1u0ZQVPUbZZXz9oLhJXmo3y1pA6YQaqrcQvYg4FH+Hs7NwtQbHwAv0kq3XmFVsYCtBndQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnUf2SvAnXEq4ksrbcwrck/kzdcHCc1676XBC7QOuwE=;
 b=UNoUYYrNAsvA1GyszlenDFqOW6bBGLs4Zvpjz2C1nUVZ6Cs60aI3E1NGjiQtz1+8jb5a8IkeYNOpb8h/JRFuaIoxbS/iVqk3mUxrJwJoXOXcaKMGXHT+6U27Mxx/4rxi0lC+KIFGFYjeqPapM72uk3s+Ccs2f1ENU4IH2H1lez8=
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:16:24 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::7e) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:20 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 02/24] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Thu, 12 Dec 2024 14:15:05 -0600
Message-ID: <566939769d612ed07b48060fc3adb4ce0f179011.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba41eaf-c029-4523-b80b-08dd1ae9d8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AgXXAiucBdxGDoAAZeJK/gEJbZO2HkpBvWMnhMuhq0niJLb7ijb6GOtwDp32?=
 =?us-ascii?Q?wSZaJRBzPayOAtSQhj7mkUisKwd8Ija70WXsuvsuJpczuOOB+pMpkhRRXPG+?=
 =?us-ascii?Q?pF6xIal0Yxbd1fadozu5D7Sfmw/mh3tbVcy81Mc9jv7dY+oyzUxP1wV3venG?=
 =?us-ascii?Q?brNVxIm8tF1MTtTg4DRWU7/jrKQm4U9AlCbKyeDYI420uY7nblo1uys9hon/?=
 =?us-ascii?Q?G6BR/b3Jtt+2ZzTHShwAG5HrVS5NjBmTfTKtLi91iBhY9/WiQGdpmugfhTLa?=
 =?us-ascii?Q?ngPjI0QR55tB0XvF0u1Kf/bylLOg7/J8wrN2f4rWR5BX55jnZpgKHL/GZw1U?=
 =?us-ascii?Q?IWZl8DHHBUZRlioMwgyTcQE7VQjK66cKULvBlJhcjqfcwIzIt8KN3Jr25gyh?=
 =?us-ascii?Q?fmRqlZAnipTj50HpmdI3zjJkbZaB+YRh7KSY7NQO8HvYgReXcWA05NNoixit?=
 =?us-ascii?Q?atJfFk461SqCkx8s5T+p9NTBUaIJX0zUIdoqG7Bm5IO4LbRM+Ep0XKqQzGEi?=
 =?us-ascii?Q?mBonhBSCsOE/LoUcPQFNhgQQRhe4TpC3y16EDFUGkdwsUaKLWjsgt8Ap74zB?=
 =?us-ascii?Q?nuvfEEQd52bJwFm4Pp8YU1LPUnIvg2mosKORX1G3RXEFyeHNrloKobz7NOJZ?=
 =?us-ascii?Q?C+TXti9FJd0+V733mfao+nDOLyFRtokA7L2fO1mz+cctqV7jd9/Y8/UWLbmj?=
 =?us-ascii?Q?RUaUpJKWpJlbPjbpatRpA4HpFqZpefb4jM32cKJ5dCQJypULfDUts5IlPMPy?=
 =?us-ascii?Q?4/Has7vPOIqc43fxhLxZ57+9iRQM+Hkt8uGu9lNORrKfK545yTc3GGSMqv/0?=
 =?us-ascii?Q?JAenn/45C5b5uWoyV/f4PPy0X+588x2s/iAM8B8jBZ+1vL7lhVvj7BD+kEmD?=
 =?us-ascii?Q?lfOlJK2O+6xaksC0dNSaH7EIzRtKktOp8n9iPmqxPvkLHiuwng8Q9utt3fTq?=
 =?us-ascii?Q?nJN8nogDpyQDrqSBq77EcKl39YvZt0+0YMAcJ/u3LrMtJr6PwHlsHnMMTO4K?=
 =?us-ascii?Q?3o6wHZlIlUz/VumRVuzL2f/gTZ+JE4bqTfLI9mAWIAO+1TXd9+taV99CivGq?=
 =?us-ascii?Q?6RtGu4+kQOHQ0RuE76cpaqFWxBk7+qeowZ2WaiZDM7HGX+UYlFE70G++s79B?=
 =?us-ascii?Q?A4VIlqOe87THyM+BgYai62U72sPqlO8Q/TvYMflQluCZ6gO5BJRN3qsLe4vA?=
 =?us-ascii?Q?n71b14f8Kwz6o4X56XwoXlP6oYq3h3HcqS63CzHEejNvsLIx/N1OhfRmSanw?=
 =?us-ascii?Q?UC1mRAmv3rtf2IsofVHZdXPC4GgEx/3tzmdubP3sY3P+tmHLAs61eKg2DVdZ?=
 =?us-ascii?Q?nGsg8exa+buWHFlMbPl8XGL4b6F4x8DXfvLNH3B7zgemo5gn9UZCwuNBYLvA?=
 =?us-ascii?Q?AFow2R/0L2jLez43I0SYTtWhlldbSMEqbwgYriVCNxRe4fCH4Je1Nd1XHF53?=
 =?us-ascii?Q?kKSGAxLOkjAIUlXObxny4lNLbpEaA8KNlPAwzo1ZzQxcD+JS9m3gbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:22.2628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba41eaf-c029-4523-b80b-08dd1ae9d8cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173

Users can create as many monitor groups as RMIDs supported by the hardware.
However, bandwidth monitoring feature on AMD system only guarantees that
RMIDs currently assigned to a processor will be tracked by hardware. The
counters of any other RMIDs which are no longer being tracked will be reset
to zero. The MBM event counters return "Unavailable" for the RMIDs that are
not tracked by hardware. So, there can be only limited number of groups
that can give guaranteed monitoring numbers. With ever changing
configurations there is no way to definitely know which of these groups are
being tracked for certain point of time. Users do not have the option to
monitor a group or set of groups for certain period of time without
worrying about RMID being reset in between.

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned. The assigned RMID will be tracked by the hardware until the user
unassigns it manually. There is no need to worry about counters being reset
during this period. Additionally, the user can specify a bitmask
identifying the specific bandwidth types from the given source to track
with the counter.

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

v10: No changes.

v9: Took care of couple of minor merge conflicts. No other changes.

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
index f725ccc77b01..662c334662ba 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -479,6 +479,7 @@
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
+#define X86_FEATURE_ABMC		(21*32 + 8) /* Assignable Bandwidth Monitoring Counters */
 
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
index 16f3ca30626a..3b72b72270f1 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
-- 
2.34.1


