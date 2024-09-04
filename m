Return-Path: <linux-kernel+bounces-316029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E980696CA2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746DB28AA26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23817ADF7;
	Wed,  4 Sep 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sbn3A+3V"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273B1547F3;
	Wed,  4 Sep 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488527; cv=fail; b=Nf0jaTv6ukv4FNeWYTzAguMK9m529+/VLdqYl1Ue+clI3XZURvxD8QbCoMoMAKkjOPUDvhLErquHP3ffvjdhSH4UMdff3EMldURu5PT51tlt7paHVkmTK6iQCAa1NYKjG5w75ew78jk3u4ZY5KK3C7FLLxNZcYR2BKh+LkPQUhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488527; c=relaxed/simple;
	bh=ejS05LfgglElVjD7lw7MMrPQVcjthdWJi1xBUVo+8ew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0pAjxpkF+JUkTiDlPhpZ22MTtOgguW+e3u+4644oU68bdwk/RFNh0LoSFhi8vRESnpr0izPF5Pitiyk1628KsUEG7T7SvW6LBlrTCaurJH6SzbKiWR60FhCMhTxmyo67NuedafZZeKml9pHd6ORg/pOX4qYGfRSOejFseEuULA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sbn3A+3V; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q63SSilD8cA+Jmk18PtwxSbC+mfY6m5IAa9yYvQi6sifRZF3wmLq82/BrAxXV9D58AKgMLOcETRr21Ghq4hCDoqUF0dxXM9xlK+5Au8TPErm8zeMgSMHTMo1oxMIoEKXoGr1FZ3lY2pWIsNg6aKg4oRQQvGfbXVPWa0afjHUzPVzMnArhjg4J3F6ALjhZlthd1m2oQWIIEu3RCayYoygi/nIFHl4aoPb8f7O9XwQUqyMzMz3EYZixokoqHH63ET8906BH4s6IiQLnYPuODGeFW9at2P1ozY1d0hT3HvHtsMcQHHg2plJIB/OhIkGCabr0XydFa5iRCz+uI26ol3P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFR3Gv/+L8/xkfS/J5HJhPN6gmMOpifhCZWZ2hBCYFY=;
 b=d+D2KXzqt3lNVYSmS9PldmgUpov5iJbT0KZXwAdfFDQ0mSCrXg6LLs88L5Nw+WfvckjLg+W7JcJzfVupKS5PXKM9KtURbNEM54FbRNQDAKdJzUkt4PpucQrMF1gxQh8dW+ckEv5n0bwsbEDuSGr13zgo3Re2XBtO1JugZ6/vXPWWcaMyCIDBXVBkFnyeRlAkmc6AFRBBQih0ud0NI3dJlxeLga1TTOTkWSbk45uYB+YDT5YRgi+9swRu0I4bM+ie6m2CeuIbUcaZ2SXNCuagj3RUXsiNnl7XjohGgc2B27Tgn98GvcNbbToBLLx+OB4kGsMWs5aKKxIoMA5Sm/oVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFR3Gv/+L8/xkfS/J5HJhPN6gmMOpifhCZWZ2hBCYFY=;
 b=Sbn3A+3VuUxFzs7OSr3RNAz4wQpDDyKhz77xlK5HklhgUo6+Ua5lFk7zu/r/dOlN3jxJifdtUm+GxVrX7LcESrgb2dbZpt7Gd12yAPPCVMDi2czGDfG9DInbRP8aHiDyY+pt2tU3D9xLp80bVh1+q5E2PFyhxf2senHWuZOT3gA=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 4 Sep
 2024 22:22:01 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::f6) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:21:59 -0500
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
Subject: [PATCH v7 01/24] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Wed, 4 Sep 2024 17:21:16 -0500
Message-ID: <7e676fcfe6b0581a738034c7033d1446cdb4318f.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 664199a3-c850-45f2-7e5f-08dccd2fff66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnH4Fp+jczYxcRlFG1Tfj/vg/q4Z3UCohmTROQklObS2nvSGT8+QcMijCrJc?=
 =?us-ascii?Q?xaTOXm9bo6O8dUnMtfeyQdu0nagoVXrODzJeigSOgCwUNCi/tzt3O1Y9FDXF?=
 =?us-ascii?Q?2cBv4RgziEyVDVQekLo1rd5MlO6x22UnVPhRTNyy9RqabF24KBX59AnGViYF?=
 =?us-ascii?Q?UoTdNmQTSOQ5LtE0F3hov9yGq+L7MJxocrMJIy7bNZLXI2LVQiwZWj8NdEsf?=
 =?us-ascii?Q?NkZZvX5o4pQVC2cD2ww9QM4TTkP1ERg1Jc7z1Vbo8Y1ECYh+hCNUmh85Q/Mf?=
 =?us-ascii?Q?4vRZj7j+yN1Ra72muEAYVifzdJT0qfCDnZTvljZ0BO+1cr0C3v7AISIZhAA7?=
 =?us-ascii?Q?vXUYr0zSEu91Vfd6UJpsGh3AGs89Joq4WFmCmLTnfAeJmfwyEYguYKI+Tti1?=
 =?us-ascii?Q?zPhbeQeol6XKktDDkV907nI0FeaQbCsVNmTF2rUugQx28QveHIuXZMQtBcSB?=
 =?us-ascii?Q?91RXsdb+WYjdfapPZLR6Iua7YdWZwemE/cVZE1IDx+v+sCI4N35R8/7h4idT?=
 =?us-ascii?Q?HULanzBmSk+oXconrt3gHitrW+PM5ryLOsc6YiVqgI1vjETnfb514+/pdXjM?=
 =?us-ascii?Q?PmEoZmLYem+qKx0U4dXyjsllMA+pGVwesU8Ml0UQZbsZh0pCvM0Q9+lBv7Ux?=
 =?us-ascii?Q?/HCpruZBRDNigBgIT/26N3elfm4fJftePTtGfgUabMqu5AzKzC9l3b4IZEZu?=
 =?us-ascii?Q?wuRpyOYhOpFFwtvAOlnL9TSYBIRHo4xni+e9OICd8SsfEt0Gt/VejwUhvAkl?=
 =?us-ascii?Q?IP5OB6fnHSNy6k+s6Qp1+icnKOscS/BoprAuWC8FY5CWSAeOCqzy/utQVwjX?=
 =?us-ascii?Q?3Oq/uvY4oi8dGmWOMTk/hcXgXpb/bUVkvfRRCx7IAzBfjSZNG1Hel6c592Md?=
 =?us-ascii?Q?2bdoYy7uAdRS/Rq8rOiNlnPDrGgme671gOaXArKvpAl+DvgzqBJ1sriZaTgS?=
 =?us-ascii?Q?m0fVYqDD3zIoU0U2E8ZbCI8y4cwAdofFmzqt5U5dm5qOKt86HHefDhpBhT9N?=
 =?us-ascii?Q?vBRprkuH1hUc9rXOS7kcdc52GLTaqxF3LFxsON7zIaXU7JdXOR5H/kKQ3CNt?=
 =?us-ascii?Q?FsPBTpfSicPQxVdrAArubLkHzoXC7gqbnRTN0PnS89UDVWSMe1QVExnOwqpg?=
 =?us-ascii?Q?OcjjgNNSwei7h6mKFiVIEyCfpCHSO7NCauZ5ARsnDgwHOVVEmLzYzghGIj19?=
 =?us-ascii?Q?mvVzFhZ/OjlBmbMBILx/bTMKzjhz7g5YuxgcaQkOxNq2+/VCCNdxMvdZq692?=
 =?us-ascii?Q?fLscg+PQ3ErhLQGEe4MEbTQlSler5tMKqCzlkmhhx7Nw1HK+98RqqtGmXnTJ?=
 =?us-ascii?Q?3GBuw0Nu3/QlAoTiUOOsH1N1PcI+2Z9Qg9ie1dIfIIuV7JISCmLt5hTdHF8t?=
 =?us-ascii?Q?XTlykBhPZBMKHB3YzJwFE8pjFGhXCJMnyN6XOXbsyzejOoIs0BBfqSXGa3+Q?=
 =?us-ascii?Q?+x2LsWMYIHYKa2PUlKzl4p/EGSOmVogJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:01.0269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664199a3-c850-45f2-7e5f-08dccd2fff66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

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


