Return-Path: <linux-kernel+bounces-387829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CE9B56AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48968283EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117E20ADDC;
	Tue, 29 Oct 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OPSIrSA/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186820ADE4;
	Tue, 29 Oct 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244176; cv=fail; b=mGUde50wDnAIKcfs2iqA2CHxWMePB9nk0jCh9G6sPdK/Eh0Jz+GUE8avqk0ZM5jI3y58T9n0DwqnGi8rwEiynAvMJHSn+SKYtCf98XS4jfElTNORdI1VFzWTzDXL0IVXuNCXPtF5DIHQgNAJPIT6Ua25LXGKypWKqz1nAwFFM14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244176; c=relaxed/simple;
	bh=pT5+Br2tUiTm71jfJkWRNOB+j2H3CoSRUTm2fJy679M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW/FN1rVayc9dntTy2KqCnpZotp5PdtWjgIJZMdua0kIHHlMatIXp2x4xjz6Rm6hi8pFkRgYbhN9Sba+dMABfBEvZEUm/ZV1gxDAfETJQgYo1nsc4RZHApoQpf/iPfZPfCrCpyuTpMQgTTnmqR/iL1TXRVxkFr8shpiOtdJWwNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OPSIrSA/; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRBq016LzlmQ6GIRGl7Etz4Bz3oZSFNIp2GRgwWLS72D+pa3DGmM2/ti3wLtbcpOik8eovVC0tGdlDE8S7m8XnX7gd3JL8rSkg3ZOBRAchshzrv2oYbu39nLvhZwvQstAgY0VJtlb1Aj94D5bumM7vJLXKf9cEctBrnaCIVzWgMKtA1UrdV0/lgj/waLr7V0b8PaU4sHsEGQcf2CM4t29IrLGiWjSp9Ph3JS0zgCCDjeZHFoV5oJwpuGoHmpSC2mJ3D9Htlrh3Wx/Wkr++LdUv6Ct0zhSma1L9FyVr5dHZl7vaUlxZLkf21gU7la72ghwc0SoyOz3w5WM/5lJdKTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov5xJv4hj0/RBb1KGcph702JHb9CzsrWt88ffsFN/rw=;
 b=b9GMqmpnHbTjy/X5ABvEOecEngD7Oq6wB8jYWHxsuyBFFjSUu+eTM1VloG4BqzSNIX8ZvGOJIeAx3M9VY7zB/MIUaPS6WqAprrjKuziN0ZpgBLgRTqgc9ZZ9oe/WVtsdUO/kAK0KuhL+1nnqX9uXfHRWIjc9oOU8TWzHHWs2mHJTZnSDuQWzgg7R3HFMtKrCr/1ghkaqfStemEiW6wb70jMiWjgF8t14xJZ6UFQaDDN6SIhR07UAaB54C2IT+Gmq6OO0hGCjOBT45t86cM8okMUWJS0atDvTq9tPpKDKhcXlaBEoQxveWki8TacmbNsUtjFe8iTEFSQXX89VqANn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov5xJv4hj0/RBb1KGcph702JHb9CzsrWt88ffsFN/rw=;
 b=OPSIrSA/1yO/+qfsYAUZ5LHmwf8FawVmlwHZhpXVKOSWGSCbue/YPuSAW0ATvJrdaXjzgzs4sQJdSJJB6qSvERqiWPu2Z9HJ7CbY2ssE+euqTxIhWdPZ5MVgSppaUYJBbYIPIUs1kjQI8JwRj6t6Nyrzbd2IxQHa6JxsZR+C4sk=
Received: from CY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:930:12::27)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:22:51 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::78) by CY5PR17CA0060.outlook.office365.com
 (2603:10b6:930:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
 Transport; Tue, 29 Oct 2024 23:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:22:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:26 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 02/26] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Tue, 29 Oct 2024 18:21:34 -0500
Message-ID: <b0bdc269a0f790de8cdde6c1cf3d3aa95b9bf280.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 9456a30e-aff1-450f-a531-08dcf8709b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wycguPE3VgXKzqDTium79kmec+4pOVf80Hm5WK8L2C5ksakA1GdMRlvaxAiN?=
 =?us-ascii?Q?s3izN8uFqgjBgMT2R7GEWkxNKUHL0FV1LhPmJ25d1IM40bQSIsCasv+sx/Jg?=
 =?us-ascii?Q?VAx7S99Mn+O8qmGU5PqH8oUSGPqIrSks2IzZPKjARSxNTazPAaCZgmyqK1Nh?=
 =?us-ascii?Q?O6/DWcXvkw/u0ghTmXPH3mgtvsOJBfy/gDGHmMTasFwLaZUdddBlR84ZDN3f?=
 =?us-ascii?Q?nTatqnHodUiZl1n4WsK++lt2/sr+ic7oAtMzXcyQDIY9I2vOvdNwB4/i3T79?=
 =?us-ascii?Q?/LMuuG8nyDzi1oTcMiq4rj9Y8wXSsN9MmSkxZC7lILr9HNYeFa5HyEQ+5Net?=
 =?us-ascii?Q?Epr5sMYCa9hjrySSSSGtbYmyTfzravf+28HG30sbHxDhA2cxXc5VbnqZYn6H?=
 =?us-ascii?Q?+6TDecJYEmMCzhXAxrZ9JNHNBYQSCxDRjMjV/bOO9wKRHqbA8Zp6VGVXXyK8?=
 =?us-ascii?Q?XILwxFBaaBKKOVj/+sDVYFlEO4KsNqRHKffhzrOQFtwLKGNTFmam74XuHiuP?=
 =?us-ascii?Q?m76QWp78UsiQqi6YV464cw7QxXZMtrqUd+7KLesASsKUnN+0in1j12kvvyqh?=
 =?us-ascii?Q?qUwsRW5hnjZGVKSGCxLcfirw/aQKo+HtOL5NsmxSmj8obswlNc2gQun1xl5k?=
 =?us-ascii?Q?5qi54FQdSp3GqY+5nX96JOT8pHCfa2Z/jXBWwIVRdgpHSqsPMUe+GYgmmoak?=
 =?us-ascii?Q?ozVma9myM2KuV5WXxF/fY+8chzVYfkDcj/bLl9f585WZNvYQnpCAYoKBXkBn?=
 =?us-ascii?Q?Pqza6ojB13+JYVVOpROP/ksjC3s7/ctcceR8M4KNgEPArztLOd5Qj1T78FaQ?=
 =?us-ascii?Q?x0vufVWAo6BcBdEtEi1CLHnsPoYIGKerrfGXMc1vm+dd9hExQ8iS9wKHrgCc?=
 =?us-ascii?Q?2iDhKoiIuDYjeIXGGv4+jKhsaXPXssZRY1Y1zcfAWXfUma4juDkKg/qoXINc?=
 =?us-ascii?Q?7x4I4dKBpq4/apqy+dOL9mQxyYBYtV1aTyomVP7227RRjVAAXeWHF2f5tsSP?=
 =?us-ascii?Q?lyRBvimCvFQ1xhnNGnb+nFCgcdi8XY/uQv9ew9ES+k6WiqX0UkhUUcAd508t?=
 =?us-ascii?Q?dGTccWQRxDTSnKJ4gQuXeUhjmbmbw3VZmO89+r6Ujyoop6HAIq86goKROuLs?=
 =?us-ascii?Q?Sz3+BpfICUEvcRRj1U79PJ9qJZ3Hm9Se43TqI7HoPgozDxbNMVB8EyzSRXTp?=
 =?us-ascii?Q?427IJkqz/eY7vPLQ3rAvCBqZ/JFUIjmXVqUGAecNj9ogSQk/C8cbYZeaBydl?=
 =?us-ascii?Q?+VQLED3fHIR9mdM2tEaMZDPBFtwcKcNsZlVD6MMnFN1GG9sU6uurbafV2+xb?=
 =?us-ascii?Q?7+bKH773PfiuEniSKSS3JkAPRHBI2c4ilFij4eHCQMJEcZRZ8LPpVqb5zqBJ?=
 =?us-ascii?Q?DE597wdsqZQ7qX6PbL16raPD5jk19Jwd5PXjkp5rGuTGQSymX1VAJiod0rv/?=
 =?us-ascii?Q?QOCdPbMROX0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:22:50.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9456a30e-aff1-450f-a531-08dcf8709b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026

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
index ea33439a5d00..f52e5f8fe24f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -476,6 +476,7 @@
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


