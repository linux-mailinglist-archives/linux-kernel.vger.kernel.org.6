Return-Path: <linux-kernel+bounces-316031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C696CA33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C5828B07D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8F17B436;
	Wed,  4 Sep 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAP4gjzs"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B515E5D3;
	Wed,  4 Sep 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488545; cv=fail; b=AaQKtZxCAUkD+ln9T1Vv597sR8Hf7Of0B2n8jfIoiW6oHgO5+Ss0/G27060aVJ1TYoxyiFtMqJTd6A2z0Gv4tB528310AIvnCoOAhOT0HI6aQwLvjbIPeDwjaoXbNaV2VpjuJGl7md+LP5h7RIPuodOgXKBJdHrNBgQ8QE2aK/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488545; c=relaxed/simple;
	bh=rDfxofeJOlQ551okyagr6r89i/BeZEPKxPZvDdxrz5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVuGv9xgocsT3RTqlluDp0FfjUnIBmB9jECGSNTbjc25PnU0B2QvpnYVtseuY5TcUPGGEiaDvJMQSoCJ/CXhMG0GuvRo+Gm8FSSR05txU2EwAJAifR55ML00GHAnbztoScD1pvG0JabeqIaUhSKjz8WyDkyHYvPxhHWXvO37BTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAP4gjzs; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaX974RBa1u8Yv8qLqWoG+nw9sxgj9o//eMDriC2GAnSYvQH8nhFXhimv3ZiElARl9rPHv073KEQ99H3K9n+YjFceVLEqf3NOpFMlznb7X3kiG+hVKsT1OkwJOrBxWuJxWE/M53CzELeEntDtx4onhjAI0LAG4SuJwsL9UNgCaC7cXP5jfQdOH8hWkkY+v32NZ2u7A8Tr+MqD8wXlybxtqi5u7bxCcLpLP54/dTtY+WSmX6KRqqVAzA5DXO+hEh+TOpziw5SGFzbZgxoFv5UM/cGd89Y5rpciX+0vR0CkgFLrPVoCtKCooZ7KR8MPmsHoth3cKSNS1w2s7D4x763lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayn9tEf6CO4TrpKF1ohVQNNke4R2Uj31sMSK3ccL2kE=;
 b=NX8LtxSRfMSbkP+N/OgGol6fLDGjxTHr+6BjYLQ1R7ELGn67FipOm81cpjlvOdQbdDl+AnQ+K9TXtqhwHVJC6w7P1SvlFtbFq8qZgkp59bO3ZAb5W+Elgan4vUPt5KaXN1cdTHhFxh9PmSm/E4b2a0SySRiVCNziuIESYCLynPlmb98yarFt8cgSY8e+iSa6lK9iAplJmWhgZ0mkC+uQn2ApqoAf+BMIdj4le0oKgcob5LjFg2hZLIShm0Oohv/EusuSgc1aPwdzUZQdMRozhSayrWAjr6SvcBQRt+I1+cFEL18gxbFFpJLdO5vTAcB3qYll4S+rJ4TROJaWUoyY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayn9tEf6CO4TrpKF1ohVQNNke4R2Uj31sMSK3ccL2kE=;
 b=MAP4gjzswo6LUjILTeSTo9HNytIedAl/gQfpHKlCTv9Cwzj8jY1StnqSqdGWIQtKNP/gSiMrYaWazAVdJjtejuwTN98E2W7lNxsULYQnd1Uy+EEXWEz+A8UIvCKrqwSpTsm/KFGuOH53Ms3kvhnxmXiwYhPBgaplFLNX1X4dSSA=
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 22:22:18 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::4b) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:14 -0500
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
Subject: [PATCH v7 03/24] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Wed, 4 Sep 2024 17:21:18 -0500
Message-ID: <2f0543ef8c04e24b94fd10d9792533554954ae72.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 296e8ddd-7165-4307-18e5-08dccd3008c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWrOpvGn/8/s/cL6GvHbTZaAUcYKBpsgsHAcINCtpTXJq0FAnJTPEHJBxL86?=
 =?us-ascii?Q?Iayr309pIBhWyA9/MS9U6/bqA2kvYNcNDYb2Wrqeuui6+1Z81S/OmT1MyAq6?=
 =?us-ascii?Q?2pf+R3WxN6VBHyCDir+ol/Au6Uo0tFH5PcaWznW0+R8UJUwD4Sf3g2CDWv8f?=
 =?us-ascii?Q?IXUQjrKCwhHwQE53NCW4HRJFy2tvio0XoFx3I0DNyxX/k7HXF5yqLz3WC+9s?=
 =?us-ascii?Q?EgFR6HLyXLLLaQcT8JT87TlfeCG8AUmbWZDoYkKtdOuWdyptIIo+td0uSPKW?=
 =?us-ascii?Q?PDZAR0ygNrwLPfisusObAwo5dcQl2bK3wfZws5Iu65FL6ilyEDXgbZAyMAyx?=
 =?us-ascii?Q?QRxOx0MmrDJ6Tes3POCTyC1I1lue5exxRX+Bp9E5npqHD6ixWxsLfO9mYi/G?=
 =?us-ascii?Q?9D4JjNbxGG3Hxi0l7ToFgN2WFei3OFB8o0G4vGlVPtBhebh78GgOKkFhreI5?=
 =?us-ascii?Q?n7Bx689j8xNb/2NyMP0IRatC51pCff1J/LbKj6XG3znYcUa2ppp0OGGTC4Q/?=
 =?us-ascii?Q?TOQ21kZH289hAfIDf9NydetelhBYEnf0ONXcJQs3+kpZeDP4SNKezglSbhq+?=
 =?us-ascii?Q?PK/xsr2vb8UaopHsPD6ZlojEyasK4YgRfOs5CneGGdw0YrB0j6Gzwe34+ok1?=
 =?us-ascii?Q?7cBFRGR3M6adlUQAleLcOcmKuXNebnxMshPcAZVD8EYw84Ns8EvC087rkJ4I?=
 =?us-ascii?Q?n92NiwI52OEUE+5UDVXkTa0Lur9LzQdGLXRtyrtTn/MYH3lRnKrJ1nzyWIl8?=
 =?us-ascii?Q?YlNtzLG8s5D9j92b5J2idKvx+TAIs1Kw5vEbCbpomdsVtZLRP/r0ScdOtCdx?=
 =?us-ascii?Q?KQTOlulZKxpXiiS2sI6fawrFMw3hrXWCsbHi69LP0pqjM6zKXoXMwrijcBg1?=
 =?us-ascii?Q?iMtcZXDsyuNCyfLNFHWS1Q4765hv1j7lh2o7QC3fvWhf1CxbhqBgOnv5N7dO?=
 =?us-ascii?Q?N2PTZ0odHhxpmAi5o2AIO+wOonagl+p6+PEsCOQJrt3NhBtyFlyIsho5Lz6j?=
 =?us-ascii?Q?OWTCGe+HmtiecHifJoHrMBXRSzgbNAeXbATDEkzRZDyTQcB+7pfM6ypNmZx8?=
 =?us-ascii?Q?AYiCTN4VewWW3zJmj590hGkrBVCKs2hc3//at+Cy687NxSxp3LF5PpqzObwR?=
 =?us-ascii?Q?o8kQOwBEt8oO0eGtbypnvYk0nSCPylTm/cRMl1HaNcgVhIRlyEv2ScRZ+TcP?=
 =?us-ascii?Q?OeWdFES6E3sMaaXQJGg84K/lsiFBckFoB8m2WYTaxpEdOjIrpr4wegFNlFdI?=
 =?us-ascii?Q?7GMiGKjGJUijAzGAisHULB49jglPENMSzQSA2Pwq2/UVAFHLT4yhQaxZLBCj?=
 =?us-ascii?Q?1u6XK/TShxT5K7j3B8Qku+PGopLtW8RM0OZ+VVQQsKHOdx660YJRllk2BbtD?=
 =?us-ascii?Q?sd3+Kleuhj7K7q+Rr5OZ46SXoLmaD4Y/H9/L4GENuZENB1bDFai16sSvHWIk?=
 =?us-ascii?Q?+6sqRR9zN506MS+mnDDFJCNQVvRUhrjq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:16.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296e8ddd-7165-4307-18e5-08dccd3008c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356

The cache allocation and memory bandwidth allocation feature properties
are consolidated into struct resctrl_cache and struct resctrl_membw
respectively.

In preparation for more monitoring properties that will clobber the
existing resource struct more, re-organize the monitoring specific
properties to also be in a separate structure.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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


