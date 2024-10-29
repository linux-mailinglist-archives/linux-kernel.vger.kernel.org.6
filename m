Return-Path: <linux-kernel+bounces-387827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98FC9B56A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C6B221E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369120B20D;
	Tue, 29 Oct 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lkm9DsxM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C6205141;
	Tue, 29 Oct 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244146; cv=fail; b=NuSz0m2hJGkLDzFkw9MjDhhrIYGDCQhsk1JkDLNnZHMz6xy1vMoBdPb3Tz9TmpL3O8t24OlHp9tvW30zyeLM0/TXrLpxc3rxYtzbpThM1iMfC1DboLUIC2bmluG/GCzxkMgbgFLmSZbuftWSW3CXjt9n2OJsUHbQJzAfiF2XN98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244146; c=relaxed/simple;
	bh=cDIxdaAbvSwVa5sy/9YAsI++wnwTunF7m0sb+kUBK6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmHnbDBZlW84wnTjZ3H2rkdmCKhTSIMcnoYEbEu2un5SM5v57N1FXYClM+JNQT9B7QBgN0Gd/QSCnnuObCKazG35/9PNPuu4rdIau9OhjBO8Q3oSdsJOM8VTln2EFCTEbrHbDCFZVOmnfMrzncOEYFQ2jz2UqclRsE/Ake72g4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lkm9DsxM; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWF2BFy+BMc+LFE0woZckOkCz3zbS9IZl1RcR2DbWZza3v1Ipp0FCY1nH8v5Q+2ScuX9RCucVas6gclvoameCgjEgOIuel5bwuGkfyIgrmm/MY+ZREe0uSsDGUfMdJuqiTCJcEMPldDg7wKvmRk0UMWANaefsaGMnmkc4jbdNgrq9n7qq7Lb7as5kwC8snN0yM+xuszfACDbgnbNkaDrPTly4/RSWqJVnbARayNBzIaDG4WNTSr0WZOGgUDJgFFLx69pHlWmXeRtXYh2Ww1RVHQBRAVMZvHbUgRBX5RCwG9Yh6nZB+kgJjmN4HwrkGWBdPMKlZNUTeP1UGgMEr5T4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHWgWcThSJ6dZO+yDlGgR7f0+LGXTNQAnE7gyUfe0e0=;
 b=x0Bph2BDf4uHhl05lSj5K9tF1yT2HPebYsDd6vemzv6pMgcEJYyNchF+cPT+ygjYcY1ld4vgYrZiekfbQyQ+w7Y/Rln43HanE4LcAgNiy/FNIpc0yXfyVGh9kXjGAd1TOEI5UEyXw0H2RvhJYaYiHiPpyEuv2XRaj3QEzcFmY+cr9+pyor5dV7uQ9VBtGkPRGlxSTNIIIwxtE+hwAepMxufh86Vrd5BresynmWShEPKlH3TjfdMRCudjZzVGrVkctBCc1OKZhcAjdofX7Ja7qPjO3gMhimHMKkhMk+ixfkLI+4X6HSbWgK2bT4RndPZvL0nI6tFSJ6NVRMRG5KGMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHWgWcThSJ6dZO+yDlGgR7f0+LGXTNQAnE7gyUfe0e0=;
 b=Lkm9DsxM00cst4SfuJw0XHMXGSp3hXAuANbZrX10Le32pjnV3BGrP1mFOEvpetTbL/+KhY1PKd8FR/rDU1/mgwPo56+/9JE9ktHNfQS8Bsft0R8m+VEDmlM+KGZ+Q/SldmUrwm/ydUSi3xSpHlPJsdQsmlQQHetTIkdbARucljw=
Received: from CY5PR15CA0042.namprd15.prod.outlook.com (2603:10b6:930:1b::26)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:22:21 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::6) by CY5PR15CA0042.outlook.office365.com
 (2603:10b6:930:1b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:22:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:18 -0500
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
Subject: [PATCH v9 01/26] x86/resctrl: Add __init attribute for the functions called in resctrl_late_init
Date: Tue, 29 Oct 2024 18:21:33 -0500
Message-ID: <2372314c135882d233eb8dba69af7c245efdcc8d.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 001e9623-8621-4b49-9ef0-08dcf87089ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S3vo/+aY0r/KnnGOlnk446GcvfijQ3OFOgzoj6m8GlS/J9sThc7cukeovXIN?=
 =?us-ascii?Q?lRqiKbNHn7+aUtPL+vGg1asC6xCVR7cmVJ7mmO6mWLY/I4KXeOvf9AI+0bpR?=
 =?us-ascii?Q?rJ7/jhYaJl6JyYQY7pjsiQ8PyU5DS9Rfrx9uZXiqkQYB6u/+Mpm+WW/xBbm8?=
 =?us-ascii?Q?3NNLual/1FRZYKIO60HoElCS7MKCjH7gCqj3jC2celgcyMSVoVz/19Z2foRp?=
 =?us-ascii?Q?0KUIpIClHh15iGdu1jRcMWee+4u9qVlGS1H3LlId98EV4GIvnEwR6RrSjFFb?=
 =?us-ascii?Q?fu/a1sdtxy+Oaen3cFxORqi+ApZQtUuR99cJVMEqUnEZamAkNlle1TLEkK/7?=
 =?us-ascii?Q?mgynpjt3APGpr+TVEykoti3gUm8wdjZpWEt+KUdSSMBUTcbn9k14SPksWO9Y?=
 =?us-ascii?Q?5nSB6/cG29Pczi0iAGEtbjswIkMDnjmyEqFglgQPEm9LcTTrVz1+CWigusmg?=
 =?us-ascii?Q?OYUnzxQbkhvQr0JSyy8yktmQTdCBUVo0AO6Aimubx0rt+sRKeHKzS3wYrGtV?=
 =?us-ascii?Q?oXpcNugABE29cqCZMf1j/PcVJcsz4zXe6yGkECZin1fCgjYk3Ep2B8HidSW7?=
 =?us-ascii?Q?YC7Ad7pMrTyF7GBNvsSNwN++NEXPsTIW9KIHQlolBfB/cvSuVx1rd83mk2p3?=
 =?us-ascii?Q?xPcmRACV4VaiauEgmedVGlFx2u4EQcIRWOSv828TmNWaaTLdsksOONGd2QEJ?=
 =?us-ascii?Q?olfvWsZCCmZCOIogYaTP41lNVgrTncmCFPrqhEEF0jGC+bfbcXZekauvZsSL?=
 =?us-ascii?Q?kvEwvZXzkQoO3f2UKvz9P9EBgTUzJ1ee2LdoTLWGzEPhuC4GVxG5QDQEdKPx?=
 =?us-ascii?Q?TAqbrY6bRHOYsya8ObHUM5eYTW/QsSQBZIgAknR5UjKr+VlTiR7mu8bCjsI0?=
 =?us-ascii?Q?wNQEoOilpi480l3AeprJDzPZqtEeXVpS+LnWsNjrsGIhLdnXSFM2zl/WSsd9?=
 =?us-ascii?Q?JsXapMcbgQ7Ga50zzuHG/9eJtINrnYrQil3mBoqi7/s0UwM7/wfnoydDbzmk?=
 =?us-ascii?Q?R/4rSL3wTr/TGwpBWmOQzjV1PlmXrQDdPbfAW9Cgv8BJip87xDvoFM+rvn8m?=
 =?us-ascii?Q?8IFA1u2e8nS2yAcWyktj/4MbFuXX/iNoUc1mHqRmEpSuJw0yHn3qOLw35fAP?=
 =?us-ascii?Q?C+AnIA20jQiND1zCoaSlAIQhIboMRBeBJku68A+Jwxg3LsZJ04yE4J89otkD?=
 =?us-ascii?Q?l6sf5JngiLlE3rtCZsbVPP4co3S96GlKKqifL9zaXaP6u0MVbs3zBKBJoVs3?=
 =?us-ascii?Q?HFR6zSkPkzNHNgpHoZISHnacBPz76aBPPqXGD2VRyHlq1bdRHFyTeY0M+qUs?=
 =?us-ascii?Q?NdyDYR6y0u/Ybr8H2MNWUwlaqk9izWLsXmLWwtYQ1TvI3baFDgUmnewm6YHM?=
 =?us-ascii?Q?dX6+EkiIHcyiK5d92Kqhh9RupLK58FAnw8ysjfGIEhRSuKr8aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:22:20.8622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001e9623-8621-4b49-9ef0-08dcf87089ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

The function resctrl_late_init() has the __init attribute, but some
functions it calls do not. Add the __init attribute to all the functions
to maintain consistency throughout the call sequence.

Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
Fixes: def10853930a ("x86/intel_rdt: Add two new resources for L2 Code and Data Prioritization (CDP)")
Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Moved the patch to the begining of the series.
    Fixed all the call sequences. Added additional Fixed tags.

v8: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b681c2e07dbf..f845d0590429 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -275,7 +275,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	return true;
 }
 
-static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
+static __init void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_1_eax eax;
@@ -294,7 +294,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->alloc_capable = true;
 }
 
-static void rdt_get_cdp_config(int level)
+static __init void rdt_get_cdp_config(int level)
 {
 	/*
 	 * By default, CDP is disabled. CDP can be enabled by mount parameter
@@ -304,12 +304,12 @@ static void rdt_get_cdp_config(int level)
 	rdt_resources_all[level].r_resctrl.cdp_capable = true;
 }
 
-static void rdt_get_cdp_l3_config(void)
+static __init void rdt_get_cdp_l3_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L3);
 }
 
-static void rdt_get_cdp_l2_config(void)
+static __init void rdt_get_cdp_l2_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca..16181b90159a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -627,7 +627,7 @@ int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
-int rdt_get_mon_l3_config(struct rdt_resource *r);
+int __init rdt_get_mon_l3_config(struct rdt_resource *r);
 void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 851b561850e0..17790f92ef51 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -983,7 +983,7 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
-static int dom_data_init(struct rdt_resource *r)
+static __init int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	u32 num_closid = resctrl_arch_get_num_closid(r);
@@ -1081,7 +1081,7 @@ static struct mon_evt mbm_local_event = {
  * because as per the SDM the total and local memory bandwidth
  * are enumerated as part of L3 monitoring.
  */
-static void l3_mon_evt_init(struct rdt_resource *r)
+static void __init l3_mon_evt_init(struct rdt_resource *r)
 {
 	INIT_LIST_HEAD(&r->evt_list);
 
-- 
2.34.1


