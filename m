Return-Path: <linux-kernel+bounces-387830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0B9B56AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24D61F23D35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1820BB41;
	Tue, 29 Oct 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RhH3ROhH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BF20ADE6;
	Tue, 29 Oct 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244179; cv=fail; b=tenE9LVsHhVNAjm5rHxCwNKOfDmRBBl8YES7COvJdLUuxgce4Y+KcnF1bXgixQxU77adh4+gJiUQ7sloJWzt18v/k5fEUehr7Dm8tj9xJ7H8jYRznFQ8teEfyqntY5ktqnW6+uA1tS7LAcd01LtJdqKXMYNwnHlu8kKODzm/0CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244179; c=relaxed/simple;
	bh=YnocjKKyo2n/NXGXlsPxMZCb3y1Pvf82EuggF84hcFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9KALjdlZRIbBRFeuPGX998cTaBQAuY8yiLD4R0rEJDxgmU2VpC7qhkoLU3wUjTh5dzGM+BKV+VyLnSEraDkAuGuVX8ntzNCEuqXbvFg8gj8OQBXKOV1vDR01u8B8ry4f7NvOPDpCdaF13fp6lONuEH+KdWPNkmNY3kJIFiwefY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RhH3ROhH; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrsZD9VxyRqUWlkdw6jJsOsPOdFeyKRY2Y9GX3sxMgLsjBbdXeE8wsWjbJMmfoPwhn0KcFR53w2vfXQYov5VBFuUf5SrJeGVzea6SSgGjtpocY69NUTVnDm2X3QLKmz8lj6Ix2vBb0kINvpvUQ9S0B9ooA/evvcD8ZOzWuYlWVbrZF1cMmshVNuqf4HLddCPBlOTsrreNdsKM7oSKK1whVtIGV0dv9R6LhwDYNzUVmBwv6WlHreuLFg/CFKQQkRTPg8f3rulG2uMauMqhqTnbtP8sHoeSoG5bshCaybfcZLP0SHGxQ2G3ppcP9Wu/4Zc9phGPylCkVNZoBAjMDRIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/FpFxUOalctJHHMAU/m0ygyyuRxwf39r2jX4i8bg/g=;
 b=Kq6o8GRPlJAJRd0HvW0LX5spFqENaqA8JUKY76MkLndhOMDqu+PuYlQzyzFk74RQGZwOAhgLVxQcnP33Aw9cIjFT78DYoY//ldkWOFXtYvIkirJyKayp7PevNH+8WDpAeaN7vVG1jP/NlYEd2lhHWgwNeydMxlXZCLYUgjfCzCsrDqAuM6QxHnN/8jiwSOTK1EhyM8J3I7zeTFnCEfCiOrr3s6qCP6ayohN7uKB015yD2kf3qqVgHT1Y75rIsG9mlY3EN0ybIyj3qizpsoYqN3/5KlmZ8vhjcbhPz3/qgNT42ykXT1kNUVHO/+QW3WaiyLePxOdfD06W2Ljes/BvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/FpFxUOalctJHHMAU/m0ygyyuRxwf39r2jX4i8bg/g=;
 b=RhH3ROhHpuhqbaxfG7m9tph0PI6c7mwxkzSyZcdbCSHefDq7ZN6oKZKWJ+s0Uuu+n5xm8D5D0ahSpkxCFbYp2i4iW4o43XjId5Wy+Op+jZu7Fc+e51DqvwRi9h4noO694Nio8/8arivLpzDlfjJXCJ444+nGd9AQ7dQWd1jYnSQ=
Received: from CY5PR17CA0048.namprd17.prod.outlook.com (2603:10b6:930:12::9)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 29 Oct
 2024 23:22:53 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::9b) by CY5PR17CA0048.outlook.office365.com
 (2603:10b6:930:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:22:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:43 -0500
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
Subject: [PATCH v9 04/26] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Tue, 29 Oct 2024 18:21:36 -0500
Message-ID: <8e78afcaf6d84ffc6631cfe641eab2ca7b45fe36.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a277de-b32c-4be3-93d1-08dcf8709d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XA+KRocVM2tffzyx6//pyJ8eojXmKJiMtSHc5nG9ERLu6zaGg+k/bRUvBzsG?=
 =?us-ascii?Q?MCz1lUWRZq6MQqvDkKBZ4sjrl3pTgW6wqSVUTHoYgRVsgVVOeT0vN5tKD6Js?=
 =?us-ascii?Q?cl8QYSs5K87UDymT8kyzG/nEjNOuotTK/ruGygFIRtggLJhpox/3ed0NZcJ4?=
 =?us-ascii?Q?WGcdpwopHeKrdQwtwKEPpaRZhGulnqeETAsm+SwDWg489TRyesZxyrv+LRA6?=
 =?us-ascii?Q?mWb7Sd0RodZ6tlpTxpOGPgfNahFoJ7GPd9p3AP8zaW1o3xMVcSx1N5s997KZ?=
 =?us-ascii?Q?EjHqLUt78wri+H2radfY6dmugYudpAjuv+8clvaOCj5LEA52zEcaiUZk0YJ0?=
 =?us-ascii?Q?kPmcbN/yyJxJ8iWjTDW5rYGLkm+nbFHDN1U7uJM1eqQ6/KturKPVmJgB0W/f?=
 =?us-ascii?Q?yzhJr20giDQ0Md1KOaxJMd/0dz739cH17pOM6xg1zp4S3w3ClEMzSLzZQerv?=
 =?us-ascii?Q?ll0nYSdcBBBZL6nQicf9UT+F45UQZBKyo4m8vs/tABh0E4APEIO+YhJi+2MG?=
 =?us-ascii?Q?PCK1SRANTK7MQYLhQpniV5hdfgggooyr1BHMCxMJCtma3pA4Gox2fYyPY7CB?=
 =?us-ascii?Q?vN4zz7J0rBJ82+wB43F+egu0zhVnX0c3PGKC4Gntqljv7CIOL5YF40MYx+jc?=
 =?us-ascii?Q?C6wUg/+XTX++qJpcA6LscLArzwJVty+YJYn75UAC+y/q3P8So1V1Ha0bfgDE?=
 =?us-ascii?Q?qhp/1wXMT8xn1PFvYompQH1HKZIOUDynSkQUJbX9OohU7TfJLbdhQL+Qdmgc?=
 =?us-ascii?Q?rhjmUaiS3awjXpeZ4P3mgoEt7+Fw/rS6QErykYWeIvi1Q4Pgfq6YepHmFKhJ?=
 =?us-ascii?Q?zJ2TxG41EE+67NGuGdwxLgiOcifXZUs8Rd3YteUrCC3oqOTMpx8mpAZzn8F+?=
 =?us-ascii?Q?Dpz9zvpihrMIYX6AMIB5QDFZv+X3PeSGwvWifSiQm8cIv18qElfm0mRSb/v7?=
 =?us-ascii?Q?pgKWrsyzh5hFdznTThteml4BM3BQ32eSp9Na4guo09byAdXwbNbZq0SwSCsy?=
 =?us-ascii?Q?z6z/0fK2CQLxYqFu1vheEza4qBEuYjqgXu1ZCNqmcsTwarAG4dpjYgIKQbUi?=
 =?us-ascii?Q?eSn9mndP59tfMdJR+tDIfXvhXL3/o3fOnJ/TF9u4Cg6zqPECPBMyR/c6UZUU?=
 =?us-ascii?Q?ymNFKRMg44RFraPg/6m3mJae5ebpCN2bxvi5I682kFF3bAMUK0ZYcoUTLRhU?=
 =?us-ascii?Q?3B2zyzd14cP829bgHff2K96EK217yH3X4z50iubQ+eM0IEpHBhO8cBBAFHWp?=
 =?us-ascii?Q?lKICt6juIK+QQ8OVfpjlL+A2S1NzCPyNIoFTMN1U0lVfXDTUmpIbxXpjxbjC?=
 =?us-ascii?Q?wXSyPdY2tLeXxDxIDzUjVNkFFRQ0Whfc7YujmoDmbuC6EOIyZgEq9FyGf0xJ?=
 =?us-ascii?Q?z9map+Oj+qmIOiXIYObMRpEbysR6BMZjhmDtR2Rzt82pSjhNvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:22:53.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a277de-b32c-4be3-93d1-08dcf8709d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003

The cache allocation and memory bandwidth allocation feature properties
are consolidated into struct resctrl_cache and struct resctrl_membw
respectively.

In preparation for more monitoring properties that will clobber the
existing resource struct more, re-organize the monitoring specific
properties to also be in a separate structure.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v9: No changes.

v8: Added Reviewed-by from Reinette. No other changes.

v7: Added kernel doc for data structure. Minor text update.

v6: Update commit message and update kernel doc for rdt_resource.

v5: Commit message update.
    Also changes related to data structure updates does to SNC support.

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 18 +++++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                | 16 ++++++++++++----
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 25616d82c0cc..468af203ca69 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -124,7 +124,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return r->num_rmid;
+	return r->mon.num_rmid;
 }
 
 /*
@@ -625,7 +625,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
-	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 17790f92ef51..f7fdf2c767f0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -222,7 +222,7 @@ static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
 	if (snc_nodes_per_l3_cache == 1)
 		return lrmid;
 
-	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->mon.num_rmid;
 }
 
 static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *val)
@@ -297,11 +297,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 
 	if (is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
-		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_total) * r->mon.num_rmid);
 
 	if (is_mbm_local_enabled())
 		memset(hw_dom->arch_mbm_local, 0,
-		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_local) * r->mon.num_rmid);
 }
 
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
@@ -1083,14 +1083,14 @@ static struct mon_evt mbm_local_event = {
  */
 static void __init l3_mon_evt_init(struct rdt_resource *r)
 {
-	INIT_LIST_HEAD(&r->evt_list);
+	INIT_LIST_HEAD(&r->mon.evt_list);
 
 	if (is_llc_occupancy_enabled())
-		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
+		list_add_tail(&llc_occupancy_event.list, &r->mon.evt_list);
 	if (is_mbm_total_enabled())
-		list_add_tail(&mbm_total_event.list, &r->evt_list);
+		list_add_tail(&mbm_total_event.list, &r->mon.evt_list);
 	if (is_mbm_local_enabled())
-		list_add_tail(&mbm_local_event.list, &r->evt_list);
+		list_add_tail(&mbm_local_event.list, &r->mon.evt_list);
 }
 
 /*
@@ -1186,7 +1186,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
-	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
+	r->mon.num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -1201,7 +1201,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
+	threshold = resctrl_rmid_realloc_limit / r->mon.num_rmid;
 
 	/*
 	 * Because num_rmid may not be a power of two, round the value
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d906a1cd8491..1647ad9145ef 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1097,7 +1097,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 {
 	struct rdt_resource *r = of->kn->parent->priv;
 
-	seq_printf(seq, "%d\n", r->num_rmid);
+	seq_printf(seq, "%d\n", r->mon.num_rmid);
 
 	return 0;
 }
@@ -1108,7 +1108,7 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = of->kn->parent->priv;
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	list_for_each_entry(mevt, &r->mon.evt_list, list) {
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
@@ -3057,13 +3057,13 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 	struct mon_evt *mevt;
 	int ret;
 
-	if (WARN_ON(list_empty(&r->evt_list)))
+	if (WARN_ON(list_empty(&r->mon.evt_list)))
 		return -EPERM;
 
 	priv.u.rid = r->rid;
 	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
 	priv.u.sum = do_sum;
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	list_for_each_entry(mevt, &r->mon.evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d94abba1c716..3c2307c7c106 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -182,16 +182,26 @@ enum resctrl_scope {
 	RESCTRL_L3_NODE,
 };
 
+/**
+ * struct resctrl_mon - Monitoring related data of a resctrl resource
+ * @num_rmid:		Number of RMIDs available
+ * @evt_list:		List of monitoring events
+ */
+struct resctrl_mon {
+	int			num_rmid;
+	struct list_head	evt_list;
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
- * @num_rmid:		Number of RMIDs available
  * @ctrl_scope:		Scope of this resource for control functions
  * @mon_scope:		Scope of this resource for monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
+ * @mon:		Monitoring related data.
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
@@ -199,7 +209,6 @@ enum resctrl_scope {
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -207,11 +216,11 @@ struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
-	int			num_rmid;
 	enum resctrl_scope	ctrl_scope;
 	enum resctrl_scope	mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
+	struct resctrl_mon	mon;
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
@@ -221,7 +230,6 @@ struct rdt_resource {
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
 						 struct rdt_ctrl_domain *d);
-	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
 };
-- 
2.34.1


