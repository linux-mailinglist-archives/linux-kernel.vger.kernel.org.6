Return-Path: <linux-kernel+bounces-188669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF28CE52D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB961F22CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC978664B;
	Fri, 24 May 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OgTIYEG6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A18627E;
	Fri, 24 May 2024 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553441; cv=fail; b=JPNUgKwnuCzUeVdL0v0UFEI/82WNmLrgdoIvFDfox3uBZgmSGmM+eh3fQLyha/edfeMWNyiqRzvqxKHhffmaC+n3tTUnqU08GlTYd+H+gXHVTviB2DjlpD8jQW7T/1R2HEGBU0d8BYQLlkBtzIyU2dtCtdjTes7EYzj64le2AU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553441; c=relaxed/simple;
	bh=9iStZDXdtVQMirEs8j/ovZrAlTsPGoj7j3NhpdLI4M0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6EcV9GwnrG42PkbzDdAoexMrsKFvEF2rBz9MFM6vcilTMw0TXc8qIOu1qlv0IZQEV3bF1czQahZfkXPxoqxfl/xQvunKcSSZhYpE9K4WgpjxDsttZHgSEg6GyeyafFZI+GJ6IwZDAH4WuozO/o/DcJTU34I3dFr937E0nFdm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OgTIYEG6; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeSG3L/DBUUCePodMBXUgIBPzSP7ZNsWZ6TBMpY+NNzkLzzyKcKDQenn7843g89ZpIjV+UYSWbY3RePV15vBMaJkd2df2CxvyoOq/vqMw8slV9f0wgkHzHdjUvbcakIZ+q0SCYo1/U6w+b+RRc6hSsv6zRZH/0Gl1bmZDxFksbaMLWogVJYW42MZYV0m3OIURWEjPjXBc1PfChtrC/RWyiFeSLZgsCKYyjR0fB1SRV8HjOpXEq+jCNMi0PWmwEQSUCU86HcNm/PAAtWyStKV99ZsUR4Miyh9WB9qCW/0Wz08YI8qcf25Sg/k84TnZobsl9JQ2D085J5vWy4T7kwIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhdxH2SAdVg3QAObI6PDqhP8RlJD4rKnpq6ysH+8YIM=;
 b=Svkxz48JV0ZFE84KxQlRkeB6IL5ntAQfGkbsV9BtyajenC0PLk5QGhjBX0ItBaopg5haRBmhrRM+ezw6+I4pRnc7A291TYtqjKBt1Ti6CVNdRUOFVu79tG8AhNdIVzXQkcCkE0Ov5lidsGiSDJdfgoMGkMl3Yb1ww0EZH81l8/rRgGgukdPVq8ej3liq5TqOpnU9yp3M6MCCZH7R1mtV8OCN3dKtW1NP2U2Q0VnY/6FDnMM9psr32Vpg3JDWr7FWKqkFRq0zUvCSPqiPMsnnmYM6BDi7+y7iX6DKNh4LWPSxdwQB/XH+Y1WPSo0Qlm/d8cm1q7sZlUbhk6/8lIP0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhdxH2SAdVg3QAObI6PDqhP8RlJD4rKnpq6ysH+8YIM=;
 b=OgTIYEG6O7It/2I7HRB5spEfHy3qCak0l0oCHz7mAkCYnTcDadJ+Ynrt34h8qxDAnPWg5ZThcKw4r3wF00kK4t7YFsW69q1bLbKiF9dvDcfg++RBA4/l5ZAAeJ5zJwtaY5NKzCQXkX3dUTKiVOWaGIiNdkPhc0HQOQfmIxGeJF0=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 24 May 2024 12:23:56 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::c1) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Fri, 24 May 2024 12:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:23:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:23:54 -0500
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
Subject: [PATCH v4 01/19] x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Fri, 24 May 2024 07:23:20 -0500
Message-ID: <38ecef15c453f5b70c8519ce1a5765f7ddd6a4cd.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 827847d1-7644-4e01-01b8-08dc7bec61ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wk3zeYBAxYKbSIfCV/nL1pXvLaOlk3vtAmKSCRRxcGlGXFYAtOHHxIy4/7UZ?=
 =?us-ascii?Q?jrZSNevUB7t38lYLHTaN/yx8AmW+LeWDLdlQwBWxXqhERWtPFb1wvpPbxjpV?=
 =?us-ascii?Q?Pdui5knAKMYYPrPMEYiDoUz52YmkOHYcI1wU/NzI41I5OiT7xPyDtFcK5N+M?=
 =?us-ascii?Q?C2uQDEvbQG/+OwBmjJqhrs42ETbUSk/UdZLI+qNTCE3ZweqMr+2QzTUcQjRJ?=
 =?us-ascii?Q?0pUP0qqH5TSrHx8dLhjsXYqLbeq2pCz9TG/ogR9aD+IOiE3P2+l9gUyGr+xp?=
 =?us-ascii?Q?+FQHvG7vll+t+fYFpCKEGOaaFylmzRl9S0QToAnqWeZ2Hip8Zx8iJbhdu0oy?=
 =?us-ascii?Q?gzW6TGH9ReC1HsiU7gaCds48De0R3tGzrxkTUHBHv1quxFOSlL12pjb5oPsr?=
 =?us-ascii?Q?Va71KZWK2+NWkBk1uA+4HHoWdNyYfA+aOpxAGi0CaqooPMzB4Xa/Mz6KZAYx?=
 =?us-ascii?Q?ueAU7Umoct9nxy3II5eqQDwG9XYfddL8oIRNW8eJp8tmMpAgJE8JUm5nPCdx?=
 =?us-ascii?Q?j6GjWLBP8hhoo9quaxsKFZ+v3NYbM9m4IHI9FFzgK4JU6VD0Day1N8XoJHZS?=
 =?us-ascii?Q?PgOSZf984CFDPwAsmUqbuj5SZLDr5kwhZ2e97epvorH08zv+Plhnt5IbqC+Y?=
 =?us-ascii?Q?/Sh1G4tg5hIta6x6M2+bZqQHM3SW8zv1qdTI/As1/T+fVXiGWZNV7aic8fvS?=
 =?us-ascii?Q?F8vNsjGpGQVmqjHAEY9p2zJIiPEoE1H1kU+wZl1m5y7ztweCYx5jR2mnyJXV?=
 =?us-ascii?Q?tYyNMb1LAieSUaioWzcP6KpY1RWidOetCQSdgmAorWVRXP5mdrn5PHzeaUvh?=
 =?us-ascii?Q?P+4mCrLzbfK9xNX2ON70WGusSe5wndH4AzJivtXvASPVV/Tna8bsIPVmu/d8?=
 =?us-ascii?Q?9WWnA7oR+sqEDayqG1Ps7gDZNm9q8r+o+/7F1iDydodSvDUb3vBpg+uoMwhi?=
 =?us-ascii?Q?tx2OBZZS7xypIpTpR97jZAzLXqECOy6Wln1j0v3CbmarjqukO2ssinUG2ZfS?=
 =?us-ascii?Q?TgdBNBPbIHZdKSJSqVX+91Ab2D5FvptSUJ6HUIK/i15I0IkhfQ3TPPlz9P5B?=
 =?us-ascii?Q?TARCCJobtubzxxPP+yUgrsnRfcpljKXBRV1w0F/fna+cdT8nILeDsei+Lq67?=
 =?us-ascii?Q?jiLszXQ9Hx/WPd8b4gVt7zaP5MQEaJLAUevMbR9RxGpz9CIqrC4XOQMrFeyh?=
 =?us-ascii?Q?BiInJ45Xexo9aLhTGATTG45eLoKZDnNQ7xmLxIX7HLKr5z8MVcUGPgkEeH2V?=
 =?us-ascii?Q?/ISrPfviw8JraecPVa41/QgQPzk1gnM5jMWDjny3obI8gFzKJRTA7HWxPOzF?=
 =?us-ascii?Q?6bxPpNWWldOP3TocRM+GvPdo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:23:56.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827847d1-7644-4e01-01b8-08dc7bec61ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

Users can create as many monitor groups as RMIDs supported by the hardware.
However, bandwidth monitoring feature on AMD system only guarantees that
RMIDs currently assigned to a processor will be tracked by hardware.
The counters of any other RMIDs which are no longer being tracked will be
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
index 3c7434329661..fbe118fa7f88 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
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


