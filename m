Return-Path: <linux-kernel+bounces-290029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57C954E99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7483F28396D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE81BCA0A;
	Fri, 16 Aug 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IPRJbHDX"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253B6F2F0;
	Fri, 16 Aug 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825009; cv=fail; b=FQ+vr1vKBARmNVO8Ua7vIdcJez9OFeu2+mYkP14xUOGjNz4dbCTn6hKluvwn1LcgcBkBrIOWxnOTUEy4ikqBup7hgS89u7UIScO0uGGqsfpfE9I/aB0nG4GSq4hbcvV0NnPuFlXdGECyj/6C9YVW2+YGS2ilUDpSHEHAyCl/IoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825009; c=relaxed/simple;
	bh=5oB9A5szl81/U1aMzyutPBYOS18x5PMbtbdgFpx0VtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ8yvFjBjRnlR+qihcbnu9jdNjE6Qb4sWGg4rxnUjIZ3JOVXiFkqOO1EsukzIjz6cxkWS69QSwtP7LxBUw9QFP1JJ5XhirvKMiZs8MUwyaIjtuMnuWzuZS3DSFBK0useMKPaAYDJ9toI/J0lE5sCdGOjgMWKG9DyICLgSog3LvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IPRJbHDX; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTA3W9NPfdfomtbt9omTavt1n7/FuGrgPlrhw7mB3fpjCB7yWi3oApcLfFDWxqfC7puZd5vaDa7gJo0ZtQ0+zg0b5ivW2/3jhzQf/x9jYOXcE3Qp6CdQNg5w428iUiKXIKOF7yFshkeUk/qDVOBcntBzeqne6xa+Jp/6srGPD4mZ/T9wvbCr9Tkd8Teu8cjzc9lPhbRr6Fm6DQRgj9AEI8QHs2xkMBFFt51kY3totrq2wp5lLqmb81HhZXanlfFgpB8yQlJgw8wJ8mW5bMKVULM79rP2TeJlfcnlAwNQ4z3VsPHJ2dURX5PxwxDzagi0qaDtAaaf7BByAHu8UkobBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYeChJH53/q4X/xzAsr+GMw03ffC+qiqpPplUHepV1I=;
 b=DspUT1zExrevJJdQagb13qFVjRogKkbmE6kJSt21lAtzeGiyAOmStKFhFwV8tIrhQmfqTwFctSlyHnI/ihR6yROclvQ18wciJQvwVd3gZivateZDg5CHEF41pnjQZPFTgqOeg9oeddTtImThAr0f24yk7GanSq3TpkKvNq3Nbvw5ueszUa+GszitR2ipmtv+8lgxtqLMqDISNvHQb3b3K8hGl/PPx3jsrpRnHFHL2A0rDmb+a96ZpDAec6osNQakCFXsWxUiJk8R7xFIiLx2N7uAxUbz6Wg7GHaemXxA+ignqAToWIEd7Ejv9DvunXxWdNcBpdUNzyP7/7gHO+HM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYeChJH53/q4X/xzAsr+GMw03ffC+qiqpPplUHepV1I=;
 b=IPRJbHDXa0Sa4juNQhrqRLw7xrGOvTEojMcV5WG11vPVbx8K3PvS5his/YSdJFGxJNhAnRaDsVBnLE1yIJivi42l1vWlhSmoK9aE6e8iCEc7lDzhah6YBMPZ0gs4AA+7CDIm0wj9rbWC2i6bvrMgkzg09VRPeq4WTfARjHKBTQY=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 16:16:42 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::a3) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 16:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:16:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:16:37 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<babu.moger@amd.com>, <ebiggers@google.com>, <alexandre.chartre@oracle.com>,
	<perry.yuan@amd.com>, <tan.shaopeng@fujitsu.com>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH 1/7] x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement
Date: Fri, 16 Aug 2024 11:16:18 -0500
Message-ID: <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723824984.git.babu.moger@amd.com>
References: <cover.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccb7009-4808-4633-6506-08dcbe0ecf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zX+xB0uBgu7hO3WFAg/szYaR2qzsUYQovP2mW6um5gALq5LhPzK7RFgb3Ywn?=
 =?us-ascii?Q?HbZCLhxkQyxYmiDxurt5SmbkEAG5au+yDhgDLxX/7cIc8HmZn9cXRMpfBzGJ?=
 =?us-ascii?Q?1ahEbC07sQxjgpnrUlNqq6N+D+oxKcqaU0dUacwJ4UG0tm4ONWzLEKjKFUtP?=
 =?us-ascii?Q?ceiKsQq0dNdrOCozmZLWr8jxUgbMqoS+sK++pAL14BxLrC20B7fYSGkELyNQ?=
 =?us-ascii?Q?VeWiQeTq1Pwev9qUmunntfbdBd8sCbrw6MPakWUss9ytLOf+X4EDLAnkW2nH?=
 =?us-ascii?Q?xQNZUvVGEu13hVPv2LfsUAEruVufHVnlimVW+XY686XKdDjGwBdks0249CFi?=
 =?us-ascii?Q?mTOEygHGWCZLNOqdwjEca2ms5iqnzMEfziCEbMirU1OtpdRNXeyWcLn//FVJ?=
 =?us-ascii?Q?1MlvmFObUKwgYba3e4hjIWVysBEaiWpW4pw47MM45OFzKh7KqYAuW9eAw/LS?=
 =?us-ascii?Q?x29BvruDfSjXgIdlf/QkjVXvpsHAkvrA/9W1yIOENLBT2c53mwM7VqfRL8Ul?=
 =?us-ascii?Q?p6ZNu6YLFJNeJoX77kPcQB7/AzLsfvOpWOybV+yytzjKOEGdTmc/V1J9jLfG?=
 =?us-ascii?Q?pxhXZ5RrBcAwfLcMumk2cQAar/B/GfGq2ebNLXhg7o7t3KC7lvyS/CskvF5F?=
 =?us-ascii?Q?6bniXEmm5qDVi8x+no7tszZUQtthivdrm5ONlXOZFC+ICyJCxAPG2WjP5DQv?=
 =?us-ascii?Q?7VwO8jz+y3JOEkgnX6fJj9RiE725Ka+6JOnaZUDSv4Nyo2hzGnS5oQbZkB4u?=
 =?us-ascii?Q?eTuWC7q+DNeiOFAl7/cgTJMkODwx6LZrRQuYJ8E26FE9sh164q0yNfeAFdND?=
 =?us-ascii?Q?C1sirn0cWIDUNLxBg5mok5D0BpWsApIczcR/dvwYe6kxiA2YulL72xkvD+K6?=
 =?us-ascii?Q?vPiptaupuxBf7pMEcAP66oflWyi7kSkm0sdn6EqVqS7FEW4wHUjwErlokxn8?=
 =?us-ascii?Q?SbqBw6PrpNFHI9XgLtYB5tCu4NELX8NPAkwhe5ZFoUZRt/qnx1CCFntiMi7R?=
 =?us-ascii?Q?6nTL9XoGTxHZF4EjxtaahT3Q0zL2d5sQn6ysB4wg2MhLma9fyhY8KjcJA5v2?=
 =?us-ascii?Q?f6SG2VfRGkzkKCWgUw8f7d1avjxdSz9Y89e4Zl51u6GaKrKCQAVmbIrJW77u?=
 =?us-ascii?Q?fZXa9kySViSKXwQcLce2drTQ+145aZygeBYk9n8f6UB/uoB1fYxXSBWv9NW4?=
 =?us-ascii?Q?iDacv0bLT8i4J/++MIxNNwS6Z3+GfToQ8layz7OZqNmdAkFdPYG3BzldCPuq?=
 =?us-ascii?Q?GNpBqibGVSNWE0IHPtD/fyDD8zxyoX25EfQh///As+IeUG0CXXD0urO+ppl2?=
 =?us-ascii?Q?2+eVAPO60BDSnh85E63pSFbuEOdgvtgbySFuPjhS1bTLmznqaBst+vLBERkX?=
 =?us-ascii?Q?fCId2zf7Med0ASWGyMzZ1pYpb3nhmKUUUy2p/M2l0zKD6jMngP69f1jRaNPs?=
 =?us-ascii?Q?L23SuEbYPGS25zt/uFvnW5+3Amw36nZ/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:16:39.8519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccb7009-4808-4633-6506-08dcbe0ecf83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

Smart Data Cache Injection (SDCI) is a mechanism that enables direct
insertion of data from I/O devices into the L3 cache. By directly caching
data from I/O devices rather than first storing the I/O data in DRAM,
SDCI reduces demands on DRAM bandwidth and reduces latency to the processor
consuming the I/O data.

The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
to limit the portion of the L3 cache used for SDCI.

When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
partitions identified by the highest-supported L3_MASK_n register where n
maximum supported CLOSID.

Add CPUID feature bit that can be used to configure SDCIAE.

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..5ca39431d423 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,6 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_SDCIAE		(21*32 + 6) /* "" L3 Smart Data Cache Injection Allocation Enforcement */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..1ef42cc4cc75 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -70,6 +70,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_SDCIAE,			X86_FEATURE_RDT_A     },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c30188fdf..88f00575c9ff 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_SDCIAE,		CPUID_EBX,  6, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.34.1


