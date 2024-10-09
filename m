Return-Path: <linux-kernel+bounces-357610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22099734B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18535B2365B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC131DFDAB;
	Wed,  9 Oct 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r2kPzpG8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1F1D3631;
	Wed,  9 Oct 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495638; cv=fail; b=ZvZX4sRO+K/TQSzQIpQDIWLkWcH+03AIMTS8mw5z/JHg9/lFhEeDHGaAVoQZ6uHlUO93QGOE599VkDe3bguYx77sJw1g1lyO8qf5EeUKGjSmIBzw8SWNrWkMQF5RacWzaWZ1k8iy5S9MuIbXCOfsy3GNWz1bERD0rEmogCNLEJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495638; c=relaxed/simple;
	bh=50OF/Af4vnYAnh8YBlTdBAqV5yU+r/Y8ou8Pae2GEos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZixEf7OylIbY9ZNK+YwFQNXaWpjRNBXWxMqYbliNwi+TqkP8noqPITxdNnWG9imlQ2I6hCwTfH+WdKQj38Y4p3zCy5ZNX/5LqEZ1Fu4Z5NQBBIsXRz0yjgyLyFUyCqr+1N0SqU5Pnj+ywo+1+nmqbYFvusYHN6GyEcPCJdFvDwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r2kPzpG8; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw9buNm4azdH9z6N4ikeGl5C6oiUoQBfVZpb7tqsiScWhtVgmgGhuLJ487qjduXYcSQGFmsMfP/j+OxnvDTPUC9nTE/geL/yxWPAjtz5wBgAoSixdgXwYxrYw4twjfo+qL4EjB5Lnoo9a8AN0YMPlSQg6VzTZ/BKwjRffUkxnNG47nz6pOnNYs588+SoTqdaYSjFHjywoB8QC1qVGmuEeQmTgO/NirB6HjDIjdg7RxZ8e+leGg5NNCFDvBHAPoRnYFYbxv+CaAVO9z0a7cqnTPQTYUEr9eHRG5vpEUqPcHID8s/3x8H0wPNhh51ZSv8qNhnI2HfEN+laYS3jmw11PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOPxvjdgUFOCMbRC+vTYbtH1ymCbMDz59ENsF93yn/M=;
 b=LEQx+QvjJFbidXfQwbfln7t9m6qRebhjvV6TxLi7GclEQeFIJIFn/TRt5bEMJmdP/D4iA/Qv0R7+j59eE14Q0ELC+583SAXz4iKcFYzTI3mTFlUFJsFSewcGaoIlgiVnhYpiaJwmaBXrRRhpRYlt4aYoAUzDjmsbQqHoA47UXWu1gHzyvuX7EgTCX9D/oePC886WNt4hM9NEbr+hPICalyR3UpQflEsRKoabUYeXzwJncDQGOGxFHzsCD2sCEVHMTV+I0wiidwmncHGYYFZ56CjdIYSzdt0t8J79Q3k7ElAivBVqAnIxEp7ruXrP/I/dpYd23OJID1l77O4GiZ/VRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOPxvjdgUFOCMbRC+vTYbtH1ymCbMDz59ENsF93yn/M=;
 b=r2kPzpG8vUsNQTeeKhzPfoAmT5shZGdWqYbc35CO+DkMfqFYp6fZMHLcek8ffmoCoZN2GtQEWg2szs4ubo/lEhbDBE91QgfoXCuzj2nYW2xaq52BbzRQ+IuWFtwX+/IoRFtETgBfBQGR44RKMl7m0aX6ttcaGiRrl7e6hj3G+To=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 17:40:29 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::cb) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.15 via Frontend
 Transport; Wed, 9 Oct 2024 17:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:40:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:27 -0500
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
Subject: [PATCH v8 03/25] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Wed, 9 Oct 2024 12:39:28 -0500
Message-ID: <fc424d4bee8ac9887703fecbaad26dba3c633f72.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 747aa346-a7f6-4508-a849-08dce88977ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/owLoLwmhrW4l02+v8XNgT63iknrQibsUQ3Y+rNjyudokoLNPKHt4wr/jzsf?=
 =?us-ascii?Q?naOc64e2HkPN+cmmZacHcGODHGAZIxhPbko1tEU61fmC5tJFgvPZw19Nn7bi?=
 =?us-ascii?Q?z+O9KMzZjru8oKecawBtnLdVFe6jhJNSFNvuu8nYFZVVnk8YJnWCMBWDTCMg?=
 =?us-ascii?Q?kWky3ChlvzKMEUlwkE0OD9iGctwdZK+4103woemDK8TE9pwj5ccJBm3SIllb?=
 =?us-ascii?Q?HU6pCBzAYxeZrrDKsiNQB/OJAPZWf+UhN6MXEZ2lH7oGEyPnjbFTA+WEYlDq?=
 =?us-ascii?Q?HnrbyegOuv05zpIdKy+b2PP8NPxdz+WAor9J+cx3TWMOGzSpyJ6w9SC3evD6?=
 =?us-ascii?Q?N+6t87XtC+sR1BDolxnaG1+D14oFvwG0HyUndE6DlktO18PFnHZ7MCJT1suQ?=
 =?us-ascii?Q?LxFwvNShndCxwv+p368iERT32ObhHkIzSrBCmtoVuagUu3sRpGQh1RvqKWg6?=
 =?us-ascii?Q?9E98o0v2GKkyLlCLG0RqFUZEs0UzfV6hjtsZVCE3rB3uUvqqkxsme95tBNlJ?=
 =?us-ascii?Q?vWD0bJkHl8LnzT7Pv2mlHegFCssmInBUXtEd4QNeK4QuDeSUziZU8inbgqiU?=
 =?us-ascii?Q?xOi3pt9gjiw7gQz2GqOE8qXh0zZDLajt5enk+8IZt6jdFmOOE3crqhbBglva?=
 =?us-ascii?Q?8ZhSFTAyZxeUuPdYVfdT9UpOhx0qEU8kctH334VKcysW4AEVLWxikxwxxGAp?=
 =?us-ascii?Q?Vuw39F+IgrNLGLZmmHhfUR34ho9oJnAlA3mh5JoRTvaU9aajjBnuOaHdAPsZ?=
 =?us-ascii?Q?DSB8F89qIxGMnwNFsXqgP+f4mqRbXJ9KhsKU0WepZ9pnmQOE/1pSw+lT1IWM?=
 =?us-ascii?Q?2gZ7lF9J1ZIiB2fIQe6///KnqN2hJs50gCYbvUrFRWbp7oukz1q4wud5dVus?=
 =?us-ascii?Q?N4DJxujKmRJR84o5MqRgzjHSNcf43YCd7Xvag17iBFjldn5cLzOrWGppAZ8c?=
 =?us-ascii?Q?P5GVHJ3Wrtu+NF1J5MiHNBXN6k6djFkpuh2CigsQ7iLd+6n8sx+myp2wUKNZ?=
 =?us-ascii?Q?QkW17fyCmr/CcxezXgdHH0mslDMfCyoQL2IvF+OLW9YZlPb1zQ60q7l9dzCE?=
 =?us-ascii?Q?r/Lnkv3MgJuZeTNPDePWz4TvQ50Fg/JKXhy0+SZTUnEuL5IFN5doGlaYJ3IJ?=
 =?us-ascii?Q?KNrwdgWTykt4ABBlEBsmonmnBsifLSSVbhYtJ+5lONunn1JU5g3CM6RBXYsT?=
 =?us-ascii?Q?qRElVDU9TmtuwvQPaPgAQvgydElroM3PD5G35aKbJMrorVT8MsnmDJbTFscd?=
 =?us-ascii?Q?hqJf4nctg13PJEgu61b9MVgrp5pAfCeHHfXRZ2ivcUHg8b2rgGATzBzP3Qqf?=
 =?us-ascii?Q?zHldGQ97lpK+k4oAXasyDj0aZzaB94bNh3uXSBHjqVIlFf9D625/B0ZsU9P9?=
 =?us-ascii?Q?qGI+vCM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:40:29.5246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747aa346-a7f6-4508-a849-08dce88977ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

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
index 668148ceda0b..73bfc8d7a438 100644
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
index 851b561850e0..795fe91a8feb 100644
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
 static void l3_mon_evt_init(struct rdt_resource *r)
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
index d7163b764c62..f9f3b5db1987 100644
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


