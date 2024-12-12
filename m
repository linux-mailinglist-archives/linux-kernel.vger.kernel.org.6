Return-Path: <linux-kernel+bounces-443883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C402C9EFD23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CE528B4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52911B0F32;
	Thu, 12 Dec 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgTDmT44"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAF1AF0BF;
	Thu, 12 Dec 2024 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034605; cv=fail; b=hplVeGwzgKE95cgQCtCaMlAKmgSipBl5MhzESKdOhRm/1iYLTN5ZFevLUSnAwpT5K32oIZamCB4BVnqqsaALKEP2FUe4zTeSumZFhzJRnFSVq4heCaasD+albxyndNzYvImuQyQoZoOwMvP6sBJUIq9BuQhkERIv0lKfphasg90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034605; c=relaxed/simple;
	bh=qQ+BZVRJtFts4yiPWTYRFUxUDJ8d7MjMnMkk+gKZ4UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYQAE6hq1h/klszgP0SdhCRQMFpQVXwqXy2JtD0nLIiISQFnRBmpER+0cFTVwNDSsigV5dHCm8og8LPdS3cfH6XjiusZhanP27RiIPmAOU2nyUAdTR2Zwqe7A1NwSYGWibEhiyoj+n6oVlZHG+c/phpm8UOYVRcBsD5dd07+gtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgTDmT44; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlSxfHM9nvqgKIHX9nQfR43DpXZYArDObfiKWump+xFYbqkLAibScLGbMV50T7DnY092d9wQaUyTZTdmlkHYob9Zwst/alF45iJNi+zoTddAZwSRVxOO1ylwK2Kzo4fQ6wFeJ+gUaKOK5oYEGEfi09Y/lu9eUdyc6FFUWOArk9JQ0Q5gvR5wwnh4FBfQb4G1bpijIls/sYeAOLx8kv9t3lND7CrNHzY/kGLB47mbzn/IN3xa6hP3K7naf0BPjzc7gm2hYEFGX/AvZc0hjABDJTPrdc8ZT9Roe6OJkBKrzsi6iKDFIzYiE9ikIklKw6stBDuxvODjojqOmEumZ5zjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B96Ov3ic/r4QufviFS0WImCBRVcZaUIqvIw95hHAMec=;
 b=QzewDxDwh1xXJlnfUfP2PIYE73siMDTUyztFnWRr/PgKJLypeKfVvmDAKsEakeFqPS+B/WYmESK/m/9ux0XxVC+5u3dauB23V8wHVk38RwOZjdu80ZIp7xnNd44WtSxvhZgJyRl2AoRdVxm7VBwnbw91BeS/tTOjbc7LFidYmruPkZPjVK+PODqPX+H/xzQxzZvzE33wodpjtYNihCoZft/m67ILyq9waVV/4wQmaHozSNrbVhtK3WvmtzNtTP37+3gHREPrXVK+HecEvu2ucK4bvsFUJEPDBHR8xYVbRSMPJAssfjPiX7WkYNlfkgKbx1vQTXbBbeFW5tHxN9ukaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B96Ov3ic/r4QufviFS0WImCBRVcZaUIqvIw95hHAMec=;
 b=cgTDmT44P6+yd01+B3pyz1Gt/tYeuOA9MFJbVh4W+vi5qbrlv+5s6uuWvKqHcWziREZlYBAMGxaK7AsAwqSCyWDpsvNFg2P+UA+IY58U+cAXqh4/0LNT2BaoOxQ177vY6froibDMjvYcR2/s4Gf7SrUN4wvDi1Ken1Gtf2tBuiI=
Received: from BN9PR03CA0612.namprd03.prod.outlook.com (2603:10b6:408:106::17)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:16:38 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::12) by BN9PR03CA0612.outlook.office365.com
 (2603:10b6:408:106::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:36 -0600
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
Subject: [PATCH v10 04/24] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Thu, 12 Dec 2024 14:15:07 -0600
Message-ID: <0e3c2f0ab4922859816d57862df7cc3aefe2a803.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4b0982-1271-4c57-8854-08dd1ae9e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qrcsy8NQIOr6Dr3nG+AG2wbpr9j7w3friB7gTN+imL0fBXNEui4NUmn3AVFh?=
 =?us-ascii?Q?0/TVWn89qykOU33qO04nCse+ENeoFCHG52KTFzPEe1ll8f8Ep/ehygQYKV+5?=
 =?us-ascii?Q?8KvxinbePwKGdTb6W1ZilZK4w1YpkvUdf0lDl6tWCSy2DIP/jcTdr1oLkTz5?=
 =?us-ascii?Q?SDdIP6HutiYbCdj0qDWCwPzUdm/YX9Ac4YrjH+MYbmFxYuZWZaXLnZyqxaoq?=
 =?us-ascii?Q?QCVmveS2SHInS/DspCsE5JzZugkaBVhqjUU3C7r3W5zVmSB/9OrmEoo9h2jq?=
 =?us-ascii?Q?IKL9eJOucD/rXQhMJCMd0GAxrfHOMU0w6CeUHUB3bE8lj2lNcp+fV7zwaouM?=
 =?us-ascii?Q?kuB7lv/BYeUr8TJw5bdSo5cmtfxg9IstyeRgGfGgunraNd1VAPx6+JCsjPds?=
 =?us-ascii?Q?J8LgbA+us4Hhpl4JEqJ1jw09zz6XJYC5QEfyxgX+1VYnM6NvNCRWtHIOcdJ0?=
 =?us-ascii?Q?M2IfuPY0Qr5YJMhW++/SKh3bqUUW4neLmTdtOvj8V4InxFYX4ABa8eKWRUgY?=
 =?us-ascii?Q?/59wzHwTWCAxsQuTx7QiP5Ai6hToEdrHQQ8kD3MoKt46QnEyBTjcEkSjxYNj?=
 =?us-ascii?Q?MxoRN3/JnmMXPD26Var7Ubk27W2ZG/ORYQTLxjIAX30/sQdYi5i/2qyn+IdJ?=
 =?us-ascii?Q?9R7MeHV8NM9mI6/Ibkizqzb2Vw8aAqCtPw7qWdncxHdG/52pCuimIHCOGGsI?=
 =?us-ascii?Q?TVZfMg4TrSdt+jnTYCv8mN1OAeORmfSePKoHdSNvpHnMCfU5o4jUavnw+yfD?=
 =?us-ascii?Q?U3Rk+wjMTaXCafgFJFTQ0f3/E8iRg2l5RHPlWACMUhfCbIMt06ZvPoMBdInV?=
 =?us-ascii?Q?vQSgM4AvT4zwBBcscCFLpiNw5NdESQ+YuGN5nXDitFG+n8QYFn9ZWfiQCmml?=
 =?us-ascii?Q?YgD5hFB6gv0yFn0epBMVCsEskvJ2q+BSbpNYeMGwUFrgUAs/6gWNbjONtTns?=
 =?us-ascii?Q?vOf0/ZNuAkRB2SuAKwdOtOIq4tdBQn2rESAa2abstmMSx7ldiNxtUP2tM/8H?=
 =?us-ascii?Q?Nz4qCA2Dib+dZCXkjzqOY7Kz7Mpdbb2L4ZKsq/bjBs8zM9zEVEz9Z8WEs8j2?=
 =?us-ascii?Q?i2bmVlp8uYTam9x43erH+iJf+Hj7MLPS/DO+ffo9Q6JuyJ1YKkf2jdxx5UCc?=
 =?us-ascii?Q?+s7FYZDh91geIG82wYuxOQ/OWgSFI6QOT6Yao01xWCS0XeFxpXIaxJYIAliH?=
 =?us-ascii?Q?X3lLdofQJ+1MNvSWtoZUUOBn7T6b+McLwdQKGba+xYadR9m+hHrYmaNqp7FN?=
 =?us-ascii?Q?hgsbFhV/IZcgzGtRxru8LcJMDVx8yAHlD/Nwot/YPMRz6e5Crew5s32sZc/7?=
 =?us-ascii?Q?4WDSUpnLYk9lTIpgz8sTzHEf465RmL+3hLT8W0vI9g1i2Cw5O7H1d7mKLBBQ?=
 =?us-ascii?Q?nNoaoKr4gAiRSLgDog2KJU6D3niPuMWQo7NBMQOO9s7LVBsgCtlcaxetW61I?=
 =?us-ascii?Q?yeNQFSjak+IZNoIm7HpU6JHh2IAsRzof?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:37.8748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b0982-1271-4c57-8854-08dd1ae9e217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

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
v10: No changes.

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
index b3861f0e5857..ff4dc649e35c 100644
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
index daf2e8c03d86..ec2a237321dc 100644
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
 static __init void l3_mon_evt_init(struct rdt_resource *r)
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
@@ -1187,7 +1187,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
-	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
+	r->mon.num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -1202,7 +1202,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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


