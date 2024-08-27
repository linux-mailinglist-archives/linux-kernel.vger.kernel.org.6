Return-Path: <linux-kernel+bounces-302986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD69605C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C8CB23A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC319F460;
	Tue, 27 Aug 2024 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sJRJ2cqV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008B19EECA;
	Tue, 27 Aug 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751452; cv=fail; b=hZDXeTZO0NUR7r9s4HPLDOXcpHy1d8dF/9R3t9UES3bOOR+/nQVWebGM9fn8nPHWO62FqklDzlGCr1dIaN69K6kkuWuERIiIm0xX+YsVSbl3YUlY59LVpBvxYUCsDLZJSot0vdEP4ceBEhIrX3DH3bgt2rjfFSRJ7I+S0cDIaBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751452; c=relaxed/simple;
	bh=9xa1KtGC/ra5DPs3eD1RNctmHVU/lp0+dw/eYey8LM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd4Ou/NUqJr6PV0kM3nZmt9Bzk/FM1lUomowWG4I6PgBFlEIcSz6v6m7/N/v9/hJRDM2r6msU5A7MULKpef4pgEamyNejP/m4f7jrGExIUYWjg56ZNA+0sB13Dktpk79xZR9I3X5RtMnWMrNtr1ef9Hz2ifECxhW0PPayNQelQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sJRJ2cqV; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep7SvSB+YeM7bFr3t+udXqp1TIULLmSuFaPFXjko6itdDrPhh/OB0lNRGetsOeP8g6+Hay3PFW3ns6TvzRMsKIA0FtbAOiBBlpIdBRW5BDa+4Af6NLg7Um89bUd7y1NrxxSkV5wAvPx58n2DvQbLXMRetJ7KkvKsXs8bIXvkDdcQ9b5p2XT4j4CPgUsL0M5ibnrtdDp2qiiTvIdX52brKV+TRNkWWgxcadZhwk49M53AwKV+xAeazkVxsYXvkaBWGiOcWEhD5cPC/drdipoDbiH9+Af7rjJwvDBL8M22Mbb9jBZK0RQbcwkudWZ+e8P2jqzq0c/UP4g/gosEkg2EuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqWYsMHaomXleB3MF1h/jI5Ekt1U+yKMHKaZaV3QzCA=;
 b=UAP/tMxsPUAPz221CJqhXTgGWGHc/gYiFnSShhhabbXBJqSRyqJRP0T1Y6+Zc34BksJ/OVjCCHuKleKtY20KfyeXci1TvEVSo/UaGKAQBDRw6MVv9softtwLeOkzcrYpCJjMnrKT7e5jXCvk0ZOnfqq7l83tE04p+yqn9iWqUEPQHKVc9yjz2bhL+fS699zPe1Rzl+00ZR5aT/rcAzsmUFyl4Si2c/u0mp1GI9xYLvJcA5G58FWagOUBDl6viKkIENWUicRjdQfsp6c/Q+i3UAg2XX/7LmRGiEnwwtWeC0eGO1oV1yAS7DUEGjc92s5zu5A2+X2orzPjhLP2w3sf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqWYsMHaomXleB3MF1h/jI5Ekt1U+yKMHKaZaV3QzCA=;
 b=sJRJ2cqVduzPus8GksvgR3ffaXznHY515/Lx6ikK4sDKb0JZEMhDMOZl57DmjAriFNYcc4PGbALXh1Yt4rLd+yA8w5MmmRLv6mupJNoxFqGazA/O0VX/i5Vahk04awg5rF5GnRRsPUGfxeMCjQBd1bgATB0MtFDkNaQI8WwmR4o=
Received: from MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23) by
 PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 09:37:28 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::fd) by MN2PR01CA0054.outlook.office365.com
 (2603:10b6:208:23f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:27 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 03/11] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
Date: Tue, 27 Aug 2024 17:36:51 +0800
Message-ID: <067b306ea3457091d5ac97b0cc5b41fcadac10d2.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724748733.git.perry.yuan@amd.com>
References: <cover.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a538eb-660e-4b46-1ae7-08dcc67bdd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZt2PtcW79yfu92jZpLxWXGKFYWorWUWVLo3/rQDkhUBUjv0KK2Ko458QfFT?=
 =?us-ascii?Q?bAJC0ImJgUYCnVcmWIkg2UTodRUaNGXFkUtpMZ3SvtKdbXlYKJXqhrBnBkTb?=
 =?us-ascii?Q?6vOvfa9k+HgmBprkjCh/QHUXgdYTq0w6MdU0wueJNArLVEaMcotkjVD8MBWt?=
 =?us-ascii?Q?uYysZxOmDVI+8ry9C1jnJ7CfzBuHMpIvXZupkQol9oOF2Ke0yZ1Dsw29f/vH?=
 =?us-ascii?Q?7t1KhAVv4HuIg//qKd5+fflkFIx7EGXKJRTQlGp1n6hEeTFqPDdPVD9EP3sg?=
 =?us-ascii?Q?e7T8lGqplYEvOx36B0orolilDEAq/utbw59oWm9Ygm5S5UxGUtHkpFDAEpq5?=
 =?us-ascii?Q?JtyqNF9JfbkE9S3fSQPK0t7gOow25Tu1WVJuieVWXHGRZP7O+Vwb8VBbxi9s?=
 =?us-ascii?Q?X6KAm6hvDdJmclOGCqrhfmuL1Sj+8IIvdexSaE0MLR7Fyxc+Y5SMt9Z8qnMF?=
 =?us-ascii?Q?YjOx4MfxzA52XuL4rCbL+UZUmjlsg2llrHREXWOy6f9uB0ZpiPPC7gK7wNRD?=
 =?us-ascii?Q?JGqDlQvXFvm4wSc8yljkrURvZuF2lGYGpGasNowiV7oU4cSvfdN3JlvD5C3D?=
 =?us-ascii?Q?Wn/vWuhIsTJBWt8YhljaixzqasRKZt8C+im92hpSu1EOu+G8YVLbsr2n6HGx?=
 =?us-ascii?Q?KN65isWjf6dL1YDfjRMWVU0DqkGBCYLprgrwHZ2N5JMjMvNXZEYFDMh4yLlR?=
 =?us-ascii?Q?5MJYng3JU+HmtXlrnHHZZtco8K3IJyS/zdE9BJB2SqfbFRvPvtEOcr+ZvoqY?=
 =?us-ascii?Q?IYBfp0nXHVTqJcLA0T9h5FsL9TXkxMjmNp03IMLqCiP2/jF8GanHdHTn65Vr?=
 =?us-ascii?Q?LMgzzM0YrQQT/rwTvTfmsXSZUA3sTjh5x3LHnk8FHwIkqmZusMkFpi+8qpsz?=
 =?us-ascii?Q?fQ2uTo5gB/5jqvVdfV2i7OuCa5/g1lS4FeD6FEao/hPETkGn3Birph5ojWu1?=
 =?us-ascii?Q?k6hXwf5eeV+d2MpX6h3iqTfccvthdpeqagPzN7NMfXmINR/IW+hnnDoFPScl?=
 =?us-ascii?Q?tVTvgsnhgczIxpB2JYC3BAkCHfeIOAazD/NC440CyqoPJg00e5sCtUmjCFRr?=
 =?us-ascii?Q?sOIR1Ex9us3jDy2UWYx0PgD+LvSLYy3fwE5ZjvC57B9XYeRUfK06SCz9C4hB?=
 =?us-ascii?Q?o2RTIVQv/H+quw1rDDPt2TPrsVdKsY7xQBShT8BOgJHo5cV60eAvUXJos3Wf?=
 =?us-ascii?Q?gmz4AqzZb/Rt0whgFeM7mvapUUrcBDvvgj9ykSsdyLjyrVAFsUVTAuzI8ZEP?=
 =?us-ascii?Q?KPtEsWHEM2n+XOVFT3UYJVPpROTHmw9AoVctIoPvw89O/t1KHliDqzLjOOkv?=
 =?us-ascii?Q?HW6VQtOd40Z666ycipeM1zRKiJQ+fNWkHLeCsGJ93c2N2OUjsEA2+pn879SE?=
 =?us-ascii?Q?FyUrkRhhT7hvo2Id5HJrZKXFzg5dmVBn3fR3VGXv2AMkqmIrOoc2j39y+U3V?=
 =?us-ascii?Q?K1OaeiQA33SAiSlTZbficrU2nUGMOtLm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:27.8741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a538eb-660e-4b46-1ae7-08dcc67bdd8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

Add new feature bit that indicates support for workload based
heuristic feedback to OS for scheduling decisions.
When the bit set, threads are classified during runtime into
enumerated classes. The classes represent thread performance/power
characteristics that may benefit from special scheduling behaviors.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2975209594cc..10e97c29216d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,6 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
 #define X86_FEATURE_HETERO_CORE_TOPOLOGY       (21*32+ 6) /* "" Heterogeneous Core Topology */
+#define X86_FEATURE_WORKLOAD_CLASS		(21*32+ 7) /* Workload Classification */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 3bba55323163..b6547bab9e23 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_WORKLOAD_CLASS,   CPUID_EAX,  22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.34.1


