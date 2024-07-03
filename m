Return-Path: <linux-kernel+bounces-240252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A9926ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC7B284756
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295F19415A;
	Wed,  3 Jul 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0yuOQRf+"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95B193097;
	Wed,  3 Jul 2024 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043356; cv=fail; b=L8arwcwRHuE0iwv5oY4jJs7V4tL0psPRT0S6u3BaDCS91PTf1EKEayEY+ZT2EtzhDjJ6T+nsVuLqKUCgJHBIv41Icg7PeFhqJHjDw0RL1VXV7N576RGN8DITQAGlF9PLfkv6feGrUeUb/UOjmchIrIsC2oJ48Xs6rl1IJcvBmMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043356; c=relaxed/simple;
	bh=1e4e6e629+lln4gti8bMtesL+csS2HGD/mb9aKmpC00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoUaxzYLzd9rNyVR5vR+4SxQNpRjVanK7PzmX39JIu2uDpGAgwFpG4cX+zg63Sb6rFTooGLKnGsqQJpuXHUlqy2Qsg5tDLG4H75ml0PYNVF0cwGGw6ByiiY/slZboGdRsgpyrRB+uokTVtWwVtaeRmte9DA8bgGbfUdOowBHY8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0yuOQRf+; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN9aDebHpLQ9rvegI+BLFVCd/GdL82XA07Nw/s/+m/yWNJp+qfPcdhtjMtbfaSFXPkgjiAqN65RTqfvjYb+28h8U8HQHOBKPPiRhdgyKJW3HlbLg3/lZUvJb1Q25I9Y6oyW6KrQbu0UY0XYMR4nXneYH94pRtQB8gpaPPUv25twHCysLRL2gtPGdJkpRLty6ONJywnGmxFdJ3aqovghT1iuTwqBI8/m3Bmv7dS3ej8kdX5PZ1hpGKA4rL2kDhefuzQ39ZCg4HSYjgVFypyZ9v1Y/m9aBb/B5gjCl5NO+C/FNCxb/x0IDf8BlS0kPv4KZOGZoNXmbEUGOG8g8HyaI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zu64DXufjZim0l//kho2tnMMIMnDOOJom6l32u7RLU=;
 b=VfKyYxgBCMjbwkavVWJu7qVeEAr/ukTfRQNqqJqhLgKHWhbUpMLEbc8q/9ChGaWwenxAZEayN+U8mPFcfeRx8TmxriZwNJeLTd2CvwlodKZy7RyEG7/7xEVOYNwmvoNc7fbj3GOJTPrqehgQ0ECCT9jct/knDlERldx8VlVDWmtlmq7DWJv8hp0yPhMjXolHhHfIta89V/30Fhl+lW/dMIRg+RlZFiigRFjGUNTLC/0lk9ByqxFlTnQV0RihsNKXmm7WBxZzMyWld9dDNhFF0zMINdfIVVYLsZm+/hyvoeyrCnLlIuPLqpv8ODgWQnSZDabiHyR7TOvo3kt3s155dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zu64DXufjZim0l//kho2tnMMIMnDOOJom6l32u7RLU=;
 b=0yuOQRf+1/FyEueWAZh+GikAJhL6P+JT+ayZBfKr31dac+xkEfed7ukmlqePH5G/WhIKm6Tb9QuZfVJJGqNOLtntYn6pevlEv7Z95Y7zLwddGIQHxWOosdDzQvYgo+u/q4QE0SbkMoWJNBqJaVwEArkgZF6KK3FulxtZXLZJvX4=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Wed, 3 Jul 2024 21:49:08 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::54) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:08 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:06 -0500
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
Subject: [PATCH v5 03/20] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Wed, 3 Jul 2024 16:48:14 -0500
Message-ID: <29280097cecb6a4717d7e8a19249c9790684f67f.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df71c2e-8bd1-4017-94d7-08dc9ba9f797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQcsoEWm+g0tsRakJaYUSFn+4hGRYbFo9+Qc7kGwM7hA/pcOtr96Wa49om+O?=
 =?us-ascii?Q?aWvRIL6COrHCV+r5wnMDyZ/m0CMAGPm8OXeaHPaOTzMqzjgsB8HYXaSmPwUj?=
 =?us-ascii?Q?n0rcQcXJlbuiDa8naeLAiliegfkVPYcBnjzJfrxCYGlaMXJUMDCBNPirQMy7?=
 =?us-ascii?Q?iLw9Pb9w8KMtqB2LdYzZFVaFKuvisgZ8BnRjqVzU2uJw9mFutilNo8P7we2o?=
 =?us-ascii?Q?DMMXiSHG6SapdGoa2ryer6SauMAescbBqC8/e+a62vBxMb9/+kS87QPJIN1v?=
 =?us-ascii?Q?K9LKKmgb++p7QrHjcS77iJbiEjDTzdkkGmqOdWwv5icZeUPow4ZNKYuOqxl7?=
 =?us-ascii?Q?afGLVuSHg/fnO4BT8Gu/ijAGNSzY3pIR4KrzoLuKoQzps6qTLe0TIxJ3Oy6l?=
 =?us-ascii?Q?GMdnKlgAUxOcXIzoYeD+4HO7rX/r8sgJbfNl7fHpgnVsNy9SVQE9MHgycgNG?=
 =?us-ascii?Q?CK7RNxlUrX8DSxP2erWAyW7C7gAl6dkbNQh0Mnfuaepj87hP31Z8L7LMkuof?=
 =?us-ascii?Q?wjzhQkBEeX7t3KwqjKlRfC5i4dkY5N66QRLZ1Z8YiAAaLmK5FZ9ZahAEuC3V?=
 =?us-ascii?Q?9yOioiWzSRcqMjK/EfJj5LOx/Vv8EPkHVQAE6R3wbsdRuRz9wLNHyZv4zHya?=
 =?us-ascii?Q?bGs0FUuUH/ccm0aZ7xtBqqo2w5JxtX42p4Ei1WuQ3DzA13UiNeCVR0ZaGyoY?=
 =?us-ascii?Q?9d+FGUsLC7MHcPukeBoo0n/vBtkzddFDDqSKpyA6J37fTmQGDNkKYqLIm13R?=
 =?us-ascii?Q?J/8jDRZBqn3EaTJtSNows4bGdbyaB3zVJt3sqyzN4F5AbRX4GqbEcpNPyP6B?=
 =?us-ascii?Q?F5sYkJl9juxUdNyL8StnCpXlDvqcoKXe2YI0Li2r8kVA8u/Sb6Hz+oPZ+Pt3?=
 =?us-ascii?Q?JSnWYdKJA9Uv4Yw3vk/TVA+Ff54J1U+R7Vu2TdPwEXM95Tv1pBk6SoVGGRlr?=
 =?us-ascii?Q?+P6Y4XIwdbUWO2m0wyCaUpoeTVp/SALuO0i4BkCcXyoU+flgEBH9qn8bA1oE?=
 =?us-ascii?Q?pPK2WacqqsuBH3Qt2BNUSL6sfYQAVP80KWqkEPDssFzalbsU0kASv20Bjlc6?=
 =?us-ascii?Q?dDK+SYgoZTH8Y71ihGWFv1XIKtAIMCM/UMitnHj7zxu52QuqtOjZs3QFnpBQ?=
 =?us-ascii?Q?k3F1Mug6ZZyEnseUsPhi4pGR1svKCpeHBfvSgb5AlVtD19dI4tLtHtzKoq5R?=
 =?us-ascii?Q?lvgxoT4dfeOEvV9hqiTIL45MGqcQwDaazuJNLEPIC/7Yp8wkAoXLvKvGuHXD?=
 =?us-ascii?Q?3Jz0hZm/jT1CI4ZdMbhqNZ/wnutl0U3h9FyVqA6xOV4TIuDXmeeAdXdFS1Wk?=
 =?us-ascii?Q?djB+fP2RNNNS1T0TN2jn5IaJRhCuY7zfeUcCSVyHL3ecM0IdW9G+NVG2VjwM?=
 =?us-ascii?Q?i/ughRkW5akfVqkX1UXOIoweyrHNM9Ro6jyCH9GO05doXdk4AHgayipGiHaQ?=
 =?us-ascii?Q?44uRCwr2+Rk05WrTgy24DeFPNVws5wVW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:08.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df71c2e-8bd1-4017-94d7-08dc9ba9f797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332

The cache allocation and memory bandwidth allocation feature properties
are consolidated into cache and membw structures respectively. In
preparation for more monitoring properties that will clobber the existing
resource struct more, re-organize the monitoring specific properties into
separate structure.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Commit message update.
    Also changes related to data structure updates does to SNC support.

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 18 +++++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                | 13 +++++++++++--
 4 files changed, 25 insertions(+), 16 deletions(-)

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
index b0875b99e811..e43fc5bb5a3a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -182,6 +182,16 @@ enum resctrl_scope {
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
@@ -207,11 +217,11 @@ struct rdt_resource {
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
@@ -221,7 +231,6 @@ struct rdt_resource {
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
 						 struct rdt_ctrl_domain *d);
-	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
 };
-- 
2.34.1


