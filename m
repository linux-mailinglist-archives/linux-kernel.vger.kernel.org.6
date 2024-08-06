Return-Path: <linux-kernel+bounces-276985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492D949AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199B6281AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1F176FB4;
	Tue,  6 Aug 2024 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lHslYEMM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AE176258;
	Tue,  6 Aug 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981697; cv=fail; b=kFX+R9EhsIfoAzN43GYEVLr7obWSHQDGNy6jhWR/OVqpzZBNTdEg9SeMjZpeTaNboVcf40bmFk5QCwDvqnphXj8HqDexTbrwEOV1VV5rs47n5RWYz21gpQ5Y3fnY/kkBD/2a7tYgW9BgizKrMQ+zoVPz/QfxRlN9Qi2DmW2RMzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981697; c=relaxed/simple;
	bh=qNfh4CH6xN+ztSVYjf4UOf2ukTP4LVNyCP7eV252dBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jww9UwCUtCqUdeHMwlp1cef62rrtsnpGOpRMoXFIDFog7J5vlLz1m4Y2da5k3KFfo7xbSbo9DmBw+KZ9NTBjF+HJo+QA5K3oeQM8VrTOsaD3UdnqOwLbs3l7XeF/eh/vbK4O9AVlda+EW+4Z560jEE44/B66w4mqNMNX/1DsGes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lHslYEMM; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZF912n4izNKae4lKXZwRYcTfl1hPUyarHWB29XB6Lvc+ydFXRI0WNTB2fYGzVBP5qOzlswzL1clXUQfsJVeNfdkDA0vV+2Lx7WcpaPOzkrLZtjq4Be/xoLD2ohOM49ysjtguj9bl5nr+YcNgd/7g/o4RRKxfA7DqM9XqydnEdpbuUkby0IUbV3Mq3vsLQezvabCgft3P7OEIaie/z2OD/DsCVgrkmg6b6PC/dyyi5foPQZEUVkajg8T9lgbt8IGef4amCGm6xWVA1/Zst76Yq6RQBkADKn0L55FnollwySPq1fxJUHgySw+RssMlHqrZzuH/dMtIzA/3RRNiE3JdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLHXNrpDpZngrnCAhg9RbHTmm4sLrNGB0V58UWDthB4=;
 b=vAIjg77Z0qo1pPYmBUQ2POpar/PAAdWvwWMtIbnE2VB5dFPMdP7mnthWt4lI43fisS6K0la/9qwA45kU5VPjtYDB4j+sVckVDhjYLepiv1MygAYqJUPZU2oETz8IEFtzD4TFZjHDmrmxOQzmHElSqQ/PGZSz+f9hhqO78nErXOsBJ9NFni/U2YFKHkF02h1A96x/+zpkDHB+K7DYNOPgaf1lFhmZ3SzzbUrK/4deJjiSOnvmHtgQVcH+K/3NjoksvQnZMOP3Kai0pvSi7gp+nGmVWuTyAsFzcmUJogqWad8vFNXXyE+GxZffpUOM6SrBk2yBN8UzQTbtRZhve4yeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLHXNrpDpZngrnCAhg9RbHTmm4sLrNGB0V58UWDthB4=;
 b=lHslYEMMeKzhS8KHCI+HVKwrWvR9MJyp3MCSfANlnZHmz4XMEjjnRsnT9SuvBoIxHfC+nkYqPfuldWYbIQuyJM08t0W6omi4BSGb8aUglEan8R+KvKQvHOEQyhoRLcIMJW9N3QmuT2db5hHDi962xZDU+lFpszF7l46m2whSteY=
Received: from PH3PEPF0000409A.namprd05.prod.outlook.com (2603:10b6:518:1::46)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 22:01:30 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::1) by PH3PEPF0000409A.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:28 -0500
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
Subject: [PATCH v6 03/22] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Tue, 6 Aug 2024 17:00:40 -0500
Message-ID: <de0a8fc4b8f6093dd74516ca7ef569107de7b213.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 223c4989-7333-40d5-98ca-08dcb66353eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNpEjGlLREoyjSbCH3ALPB+3rzUXUP1OkcgqSyRMycp1FqQdXJiRpNWiB/TI?=
 =?us-ascii?Q?5chjjI5T1vzrgIMEk2ZN5z0H+AfSpMMqVYuvl4DIfH5FY0PnW6qy8fMt+zal?=
 =?us-ascii?Q?J6Uvh19iwEZTuskj5epEzA/TVPmSh1zZ2houd+BPlIEmTMhT5DjBQ0X0ZmbI?=
 =?us-ascii?Q?V86HbbRZVqvQaoPKXGf26lsJWYDI3eXOcuNIGJ1L0dIukT3xiPsevtZTdu+8?=
 =?us-ascii?Q?9E+cKS2gdus3C/PCasfY1uKMslAAUv9d3e2LgHKLwWxd+wOiIXAyvMW7JU2/?=
 =?us-ascii?Q?0cxj7jI08kvlNGoyDEkTrixqMB/+wxDKA1zTpmK87egjSB4Ylu5G9NQ+ze7u?=
 =?us-ascii?Q?EQsnsYseRqQ0U5WEdJhRcc9KOyK80zW76PhO1eiYQKmr5BAx38lMox82ZAV5?=
 =?us-ascii?Q?lk+qzsno3HKzBNPUtj1P5eW4YbJE49zxSAq7ri7pg8/5n9mYZCdD99AVy1Zn?=
 =?us-ascii?Q?Z/0Zq/cv8ZbPD8MaQiP8+BRl99yjjR7YzDxtvYx4SwX3kq9PLkFAkcH1bJRo?=
 =?us-ascii?Q?JCVD/sTbXpgiM5PIUIpw0vrAVsWD/2UxVZEH4XIc1zxzD5gOAvs0ujm2cWe1?=
 =?us-ascii?Q?DeTQuNkMyVEg9ClkfyoHxPMRLG9SijImr+Irw8tqVl0kdZBzkeWfwo0773Kc?=
 =?us-ascii?Q?tEJmSHqqzHCZAuyCp3VdfXbvlVAGxV/D/AZ57MsTFIFDn2wnIIsWGYjktXv3?=
 =?us-ascii?Q?KerUpo9Zk9NIvevTJPGWReaOk56PhSmSZ0OlcarAd1LeBkfaDaD7y7f5uEzZ?=
 =?us-ascii?Q?LDwnQRPXFx4k2qiCU8SSjbyyTfckzXmejOX2auoFCCFwXLEpivZb09OfBiLg?=
 =?us-ascii?Q?u1EgHHkMbuX/sg26cF+N+mukXKZN4wTUU5W0g6vyXHpAfDJfSPHeAMZloemv?=
 =?us-ascii?Q?CAZphy6U3SjzaDI2L6Zjew5BEAJGP0Seml2TUIiPzlim1+lznC2vQdNMP6xj?=
 =?us-ascii?Q?xvTopjD3wq0IJIE53iGRrDSuWA1mPh7ptL8jtHnMYWFCakCF2VOcpCGyDVb3?=
 =?us-ascii?Q?DICbDN5abyZ9EJtfuZ8WTGarD3ON98oe2sqVyeHCkPc5FloytIcEWwXWfZeT?=
 =?us-ascii?Q?7TA06PatkuPe8ypwTVQG6m4bakEFoyyzEq0rnDTJ+7a6Cr7555E834fGxm52?=
 =?us-ascii?Q?A6AY1qdUx8YuRSBMABLHFS+FBQLxV3F28W+KtdTfe4RkiGvmmBydojHaN2Si?=
 =?us-ascii?Q?pRwbwkjY3hp6j/c9FAlXLVEX4ryNHqKKZBgzKFNn353Xcn+0dz5oNwkybnAL?=
 =?us-ascii?Q?pxBD56PGg+xizYz9wqtLEWuLrWV0qM02KWL18A8qTU3nacX+8nyQ6Yn4dbTh?=
 =?us-ascii?Q?y7XFsiKWoeMTt7bK2MgNQWN2Y5aZ/Hj4DrOjlJs2ShDIfLUa1EnHYFNmt1df?=
 =?us-ascii?Q?AeZvbuXov3qcMU179kYe4MeBYKEvUY+u70tBjbzD//MFkq82BeYgUCY9fOgX?=
 =?us-ascii?Q?4KXpotRE+zWndhO2O65z3p78JDDm66un?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:30.4952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223c4989-7333-40d5-98ca-08dcb66353eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

The cache allocation and memory bandwidth allocation feature properties
are consolidated into cache and membw structures respectively.

In preparation for more monitoring properties that will clobber the
existing resource struct more, re-organize the monitoring specific
properties to also be in a separate structure.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Update commit message and update kernel doc for rdt_resource.

v5: Commit message update.
    Also changes related to data structure updates does to SNC support.

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 18 +++++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                | 15 +++++++++++----
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9417d8bb7029..4a2d0955ccdc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -617,7 +617,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
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
index b0875b99e811..1097559f4987 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -182,12 +182,21 @@ enum resctrl_scope {
 	RESCTRL_L3_NODE,
 };
 
+/**
+ * struct resctrl_mon - Monitoring related data
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
@@ -199,7 +208,6 @@ enum resctrl_scope {
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -207,11 +215,11 @@ struct rdt_resource {
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
@@ -221,7 +229,6 @@ struct rdt_resource {
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
 						 struct rdt_ctrl_domain *d);
-	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
 };
-- 
2.34.1


