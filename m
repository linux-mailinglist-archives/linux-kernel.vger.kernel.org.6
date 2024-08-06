Return-Path: <linux-kernel+bounces-276991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C293949ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBF81F21717
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2917966D;
	Tue,  6 Aug 2024 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MP7m55n9"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F4170A02;
	Tue,  6 Aug 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981743; cv=fail; b=O6WCbrCc4XbohQb+LvUSAYbFzSkiK9JWUfsWumRGdByDbbLZ75s22eXRUIsl5O8X8oLAP7SN8G95rRJWybZsNA5gUV1qjwsfGOcin3O9eQVoPrksqqiiZnVDwEP956nPBkTbuNpG4MUXZDTHcC4vO2bm17Y8aXDWSJdaPyI8GtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981743; c=relaxed/simple;
	bh=L8gB2Ic+eRm/bZx5HN4xXj/b9msPSsotYTDPmW5iYmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtgoOZBImXvOQ8w2Zr9U/IMYjD2a8puLiUOk6fKPco1SBuU4Gh8dc9wYq34GoaPVp9XS/iLKmv8aucymCnd3caKk7b2gPAHDqlA9UT3ZHBxx40SqYUONTEwJA5d6xfpV+V/MkGccRZXqZAuNidR5/1rVI85LN7TOnUMKKYLZtOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MP7m55n9; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmhrRQIpiFwHngnC48JZRGCigxWEKyquBCFcWFRhl7LFJOnEs10ZgqniyAyAgSCioEpW8+/+klt4d2ymb+xuN0TXieLVoxWf3ifvfMQ0wIW6swc6rF9fhrXBr/ZvT17MfBtn3hsKdkFUJ9Rl9ZUQZg3y2tGW/Kj+QnR3+okzmFcquSuuKzNvNQ0xBT8iPl+3cku+MpyUWXC/AnQEQBEf77CLSVtjOYi2UNlFhQ4d3tpO2L1p6PmoMb2JHUoy1xd4IXV0YonT9RyZBTB7tG2CrUmdnYgutvtHnZPGXPZ/1Vt6nhScwpr9CU3fD4pNyHsSIVGi5r2bYzVYMjYOugUKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chaZmqiJK292yC3DqytnWnFh15X6uYnKA8FqB6VgXdA=;
 b=uGJdFp0SVffUvDhaYUh7Gq7upSNLbRoX/n6ZuHufRnrg/w3YSwlLYbNQupY3Hwkj28gfblJghTjgUd9vJVPnhNvvwSuPlzN3kG1jShQh5pyqb+H3HXdND88gogYhKkxqSJWx6gsByzO22bQAx6KOJbj3H5nFulw47P5mQ9mTI5Gej61g9ewk8NWmLrO3eksGXdPHCWIjb5feCbbBFuwZoqvBCfcTxwNkNeaYws2lf14JXrtpPJZx2gICAaT6gA4T/m0CjzVNfan2f0QYI19V1APMUC4uaskUyC/j+QYx0BQku/VI52JMxl23AZtDTkFxoK/cjoSURBFiL88+J+z9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chaZmqiJK292yC3DqytnWnFh15X6uYnKA8FqB6VgXdA=;
 b=MP7m55n9G5ynhGxtTzuACCPFapDiIQ1/6n0tUzKSxeylSkRSFvrvFKQB0WJmXKnHfbX2qZP5bZXpInR1HrXOf34HvkCegO+g3KPo2Z8CCESrUcyHFI58gqegrvcDAkksMjLy/O629CiBnXNVUbGq3PwCl7LRjnGa2M38wPU4noQ=
Received: from PH7P220CA0131.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::33)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 22:02:18 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::23) by PH7P220CA0131.outlook.office365.com
 (2603:10b6:510:327::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:13 -0500
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
Subject: [PATCH v6 09/22] x86/resctrl: Introduce MBM counters bitmap
Date: Tue, 6 Aug 2024 17:00:46 -0500
Message-ID: <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: bab95ec7-3a3a-43b7-575a-08dcb663707c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fIp+1rJ7EP98kRH/vJ7PU94y4kn+xEgkgXD900TQXtKtQ99fqLA4Q5bzFkH?=
 =?us-ascii?Q?3Zu5vgxqxGCLe+7QQyoXdEDTJflejGd4wnUVIOrnVDtZRzQYo/qF8uSo390J?=
 =?us-ascii?Q?S9sMxQGtjtKvY2fKBanP6VCkdF927ala+mcc6V3kRKXB0XB2ime+B89mKpr4?=
 =?us-ascii?Q?HCgL7ZLNaR/hrYQBYSpHYz+/FnNsu7dEFojiZW1X+d7OQrjOb58/kJm6KSHk?=
 =?us-ascii?Q?5sfGOmCuaZQ3TDb9PqahScxsTgH4LMz3kzwpClGTcG1trBH6aIKFCAZjlw1A?=
 =?us-ascii?Q?hsPycsoJGx1e5qYgbQ8oslDJmIxtQeerCGy3I2aamWBY5vlf/lG7cT0zXND+?=
 =?us-ascii?Q?9xqocwmg6wLQ6vPE8JXCgjB+NJKUJTY2xk/v/xWG9tIxVBa2V/U2KlKWBqln?=
 =?us-ascii?Q?XBvE0j79nZ0LKBs+0om56HQHUf/3pUOCTeHcGgY3xA1uJNTBskVANxbsEaCW?=
 =?us-ascii?Q?abUIoDXahmHXi0NsF5LYuGjpMcPJ/IUBIpbtRWhw/1bQbmNsvQr5LfNJBoVz?=
 =?us-ascii?Q?wjAAo4slzdzGuZ1AJf+cw4Pgrb8DW1XtWk35F0g2k5v+6b6qxksWkHJYy354?=
 =?us-ascii?Q?XLP+RFhKmUaYwINILr24uE5BsPzZeHAu8kXfNSp9LcA1odwSi1Cl5NxYLHdl?=
 =?us-ascii?Q?rVhJEeyvlS/CUaDJSCdlfwjsW0eL1BTlU2Rt0pmcSjnNbthkZRCW5uNBhPkl?=
 =?us-ascii?Q?ponSpMqdFb9CYE7vLMHhCOqZeXmXOlAQfmnLkGrbqxZYX3dtyHlRT3WC1TmG?=
 =?us-ascii?Q?NzonurfrCy1J6056nPhU9Cc4RJyJ/h6yyuPVmyQxe9qY2tDFWMEMYxQXEygk?=
 =?us-ascii?Q?MVMVRR1PsG72WvMDvdd9vVkn9DzE4CJvoyFvoIYSVx8ehrMsYx+OEAaQlnjC?=
 =?us-ascii?Q?Zd7VLD1Ol75o8dIlimM8GqUS2DmADtleP7s5i0MXDimBjh4EYqmj6oPtqn59?=
 =?us-ascii?Q?ArUhvnGJrsHP635x/397WEWR0nHmj9IDx455YlKY6o/uF4gCE4nIABDT4BWS?=
 =?us-ascii?Q?DTXUCc2mfR/cXYEx1zwwlIjYWLqi5isd14W+jvsVk9xeh07nTjHwAmJNWzNu?=
 =?us-ascii?Q?EhHTkP3vqcwJrdUfEc4Q965LxaCAMsl2IDdPXhcn1kBKSdIpUeTp+0mY5NXf?=
 =?us-ascii?Q?G1d4lISTO0AHkDxYU4q/FsxNnj0nZtA/hKhsQs+oC7Ep/C/nSK5/ul1d0RzK?=
 =?us-ascii?Q?0i4VXdZ6l1mJP4Dp2s5B3uu4pWdS4v6YoXaKwK/XtWagWrAcpo86/Sl0Cwec?=
 =?us-ascii?Q?CLbP9T7ejli+KkI3uS+d48byOsE5rPs72bUhDXxLy9JwBjqbuDodNHAflWmi?=
 =?us-ascii?Q?zmL2Lckvh2aCRpk+pl1cupSHuKsPAEJ3fsk05aGrVcI1L6Rygpq/2HMNFMb+?=
 =?us-ascii?Q?Up8JiBeJ75NF0Ov6cndzLZxoekU4nzLsl7hdb038UaY93XeUVytBwyDq8yEV?=
 =?us-ascii?Q?BzCSoGTZ1FPLujrExGXMVGPxPPgEvLbm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:18.4201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab95ec7-3a3a-43b7-575a-08dcb663707c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

Hardware provides a set of counters when mbm_cntr_assignable feature is
supported. These counters are used for assigning the events in resctrl
group when the feature is enabled.

Introduce mbm_cntrs_free_map bitmap to track available and free counters
and set of routines to allocate and free the counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Removed the variable mbm_cntrs_free_map_len. This is not required.
    Removed the call mbm_cntrs_init() in arch code. This needs to be
    done at higher level.
    Used DECLARE_BITMAP to initialize mbm_cntrs_free_map.
    Moved all the counter interfaces mbm_cntr_alloc() and mbm_cntr_free()
    in here as part of separating arch and fs bits.

v5:
   Updated the comments and commit log.
   Few renames
    num_cntrs_free_map -> mbm_cntrs_free_map
    num_cntrs_init -> mbm_cntrs_init
    Added initialization in rdt_get_tree because the default ABMC
    enablement happens during the init.

v4: Changed the name to num_cntrs where applicable.
     Used bitmap apis.
     Added more comments for the globals.

v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
     from the name.

v2: Changed the bitmap name to assignable_counter_free_map from
     abmc_counter_free_map.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 154983a67646..6263362496a3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -662,6 +662,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
+int mbm_cntr_alloc(struct rdt_resource *r);
+void mbm_cntr_free(u32 cntr_id);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ab4fab3b7cf1..c818965e36c9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -185,6 +185,37 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, &closid_free_map);
 }
 
+/*
+ * Counter bitmap for tracking the available counters.
+ * ABMC feature provides set of hardware counters for enabling events.
+ * Each event takes one hardware counter. Kernel needs to keep track
+ * of number of available counters.
+ */
+static DECLARE_BITMAP(mbm_cntrs_free_map, 64);
+
+static void mbm_cntrs_init(struct rdt_resource *r)
+{
+	bitmap_fill(mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
+}
+
+int mbm_cntr_alloc(struct rdt_resource *r)
+{
+	int cntr_id;
+
+	cntr_id = find_first_bit(mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
+	if (cntr_id >= r->mon.num_mbm_cntrs)
+		return -ENOSPC;
+
+	__clear_bit(cntr_id, mbm_cntrs_free_map);
+
+	return cntr_id;
+}
+
+void mbm_cntr_free(u32 cntr_id)
+{
+	__set_bit(cntr_id, mbm_cntrs_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -2748,6 +2779,8 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
+	mbm_cntrs_init(&rdt_resources_all[RDT_RESOURCE_L3].r_resctrl);
+
 	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
-- 
2.34.1


