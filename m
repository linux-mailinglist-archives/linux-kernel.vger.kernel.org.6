Return-Path: <linux-kernel+bounces-240258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA0926AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BAC1C21A9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F26194C73;
	Wed,  3 Jul 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M+rA8Dh4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D4194A66;
	Wed,  3 Jul 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043403; cv=fail; b=K5wdMSXKMCxGZYVcX8m1sJddsBUSN5UuVQ9l4Ml6nr1Nc7tAMw2lWdgoqfF2IDBz8GOQ2sgfhMUHbXQgdTEgzuYFFRozIxaZSj2+XTdNnIq61NYCrtt4btf2hZFBiBMtlPk6GCNp/LnXGl7GIlrgchc2djQHpJdFah/3Zkg0W9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043403; c=relaxed/simple;
	bh=kOO7S3N2zsPYJ0jlpVzUhekJWXSIcawH81mlTkjv6so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXVsFMpQ0T8kYS9w2jro9ohNhGG/ur0sZ8dExscJAmZgueGrZv8RYRQiQYdK5jNFvAXAD1hB7hlLw2NAk7+K9d78jFhoYWURgSJiWNUxCWEhY8I4NHEm0aNaNu1NyD+KxJ82kLuVC2y3dEiiKFWgzEva030y+nW6BMHM1nQBoCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M+rA8Dh4; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4llurGmQWEY7ADHTL2fejYfjtZeGxrsB/492IaYwGgiWB6pM5b3jsjhdVrkTORepSxVyK7Bp3zQ6G/j7SUKHnLSo/iRIjV4ldxcMw0NB7QxWJWeXWIKiypvlSDQjG35tYLNTWaPpwYQXlxE6xLdjgigeQ6g3cHUpPV4ficoN9Q9vrgiuDWQ1/fgOxw+djgulhJY2GQY9pBMdPIN+GYkXD+AeZW9v0s4/Lddz85924CqdpvqUs8RQCMpwmq+16qL7IL8ELnQRcIv7Pb2jeRdx8LBIE3E647dTnrH6Jwt5E2yHZ3dyKXK5BAIvFq5Q9iJhpa0GN7ljLvKlMG81Pacdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A0L5Ot4zFFzsW0CCxFbud1lSs9VqhQIGBAVaxrGnEI=;
 b=fsG4Tdsr4RpZ8KfTF0t1n2Wb0Bl2FxkySW814fjfoUfiFlc8zQxYjBnYnykg17kM5AFqMWw3TYENRsQlv+lLFAv+fOIhA5yGNAGs+YGeE8NdA+FHc6TOdejNAXTzEgeC4zc5F467IqbMtEOnJ/A7BR3vGQTZUcQ+j4mov81ZwZNYG8DTlXSYA7rz/Vbb59OKYB8CfI9Eeg2adzxVoChwi3251YtIn+B15jYWJB/TRjPi9Xsvl+TBfymxbaLehFDXiJrE31cTaYOupaNBdxcTqffy0QMLjBNNDweIRHZNV1W/wxNfxMfqa4Ht6zjsqukwDWypAadn2FEBzlsqBnhQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A0L5Ot4zFFzsW0CCxFbud1lSs9VqhQIGBAVaxrGnEI=;
 b=M+rA8Dh4aLtF6EOhkIHY3t5zsCmTbdV7+lGYEjHOIvtOf9lJAlkNG3v0lEUS/zfgqS/rfgfWZBI3QbcljZ2zd9aMMnlo3SvdoMYKiEQ2R05htwBs0goV6R2HzhXntUr8cMMDE2Cu0ojRaIVurgv2zt9jcKzm4k5oMGo1B/0hh8A=
Received: from DM6PR06CA0048.namprd06.prod.outlook.com (2603:10b6:5:54::25) by
 LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.39; Wed, 3 Jul 2024 21:49:56 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::2a) by DM6PR06CA0048.outlook.office365.com
 (2603:10b6:5:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:54 -0500
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
Subject: [PATCH v5 09/20] x86/resctrl: Initialize monitor counters bitmap
Date: Wed, 3 Jul 2024 16:48:20 -0500
Message-ID: <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: bb394016-aa05-4fd5-b993-08dc9baa13e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8tRSCxYiVy9f57xYsJkhpUFpS5gmxbRXP0PxhnJgk4TXFT4zcsdvuwhbQLQv?=
 =?us-ascii?Q?5f0wbxLfy++4KwRhoHXut2oFqVfq31gpTQRGXAy847bg3uMWJb0TnOWvhTDG?=
 =?us-ascii?Q?JMwA6l6Pdf/vHBPQxPIo2gOe2PauVG9kZycYEgzjdE0P1DMMiOyoqYdcWp+A?=
 =?us-ascii?Q?32AcR/FKq2N+bfZpk8yz8hTM1F8N5CqBSPVT9pGn/yYRZw/ODRZXnaYkl9ac?=
 =?us-ascii?Q?imKABrf+J+M0aiGZxH0sFh4MhK9hoECuItM4vMMngl/aWyCDPJ40BcUy7rex?=
 =?us-ascii?Q?U4QQSeIMj0uAWk5C/VHHImMdY5973Yxkp9l+uPxuzRXsJ3qXu3OZUp5K1Nxn?=
 =?us-ascii?Q?mABqraGttqtIjE4qFQr7pPdcZX+tFR/0Jd9UNM6jjReL5DORL3wcx7Ei7Hit?=
 =?us-ascii?Q?guHXkqcEAaro1bcK08GLVmmF08dk/ZZuusq4aT3bEXWpNTOXs9KtdTqs6oCd?=
 =?us-ascii?Q?xw1ZD42RaDyxIWygcDLm0SPXX+mDyeTMD210X2ykqE2umVLEY9xGvrk7CrRU?=
 =?us-ascii?Q?Gfkme9ROtlINgmih8y4qSx44V4jT/48lbGzZOGtAteF7L9U04nEUvMFUhn1S?=
 =?us-ascii?Q?/O1aAM7bFLxGqIRJygBXEMMJu9+MEVfYYw379k2/UtBTltlKvmREErrpeYiZ?=
 =?us-ascii?Q?hb4JFaoyuNu4UobU36IdFu23MLs/qZQVXVGD88NmLr5tLC/F7FqorAmNUvfc?=
 =?us-ascii?Q?91pmFkw71HE7LrxxO7nk9vGrjQYexOTD8Ac7b077rFFKNvv/1HMKbPKQgLJ1?=
 =?us-ascii?Q?Q1hziCgYtUlHik/In9WtgReakdmCMHTEM26vSyyl/lXMjzeMCGsYXb9hpb01?=
 =?us-ascii?Q?sgyphScPFYBjdFMrqIeGymUt9FQv3zCdmPyuvN4Jl7iR/mGAcHL3N7jMROE0?=
 =?us-ascii?Q?QqhhPXwQN+7K7JMLNNjPUxBMd8yXKIkwjmKN+RReObD637jIsZWuMQOwR9vD?=
 =?us-ascii?Q?8yw59SBV7DZ1Ohh1AkbEoTSnTP3mSuVkgjKoonLd3IVUtbtR/E5n8TDXQ/dj?=
 =?us-ascii?Q?q/Bp8EGNUFn+cr9ItRWcHrwYLKUdu1lDu/TlWRxr0WFyK/z6oCdX2+tCXUKP?=
 =?us-ascii?Q?B1Z85eilgVxHLNP7l8v7vzRpsszgV7TWn0adtTdCtFmMW52OnyZ9iPFPOoSc?=
 =?us-ascii?Q?pVYkdqT+8scNvaMIYRQv8pJIZcJKKGXdCYHmGKNJm7/qz/yzIVZrr125aanL?=
 =?us-ascii?Q?GnHVkpSFrRPHPAG7065Wogs4CPdESGzCFTn7zrYuXawAcNsx5DUp7jPZANC3?=
 =?us-ascii?Q?MOTmxM65h9begXbs3I9GEJId8zJPFuixmOE728ygPuSjMDXqOnLBdjyFd3uV?=
 =?us-ascii?Q?Tisv4aRxkhzJ0MmWIJPBL4KGO2DMcBu2fKTQn2REwVuAcMTxg1jsAKAWS4hh?=
 =?us-ascii?Q?tb5oXnez0KnTtX/0k3vci0Rz5W1ov199yiITEL88g/b+/vd+Ms2+tToGNDAZ?=
 =?us-ascii?Q?UD+zEfo+Ea/y7457z9X9TwBYST+WKNT3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:55.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb394016-aa05-4fd5-b993-08dc9baa13e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

Hardware provides a set of counters when the ABMC feature is supported.
These counters are used for enabling the events in resctrl group when
the feature is enabled.

Introduce mbm_cntrs_free_map bitmap to track available and free counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4f47f52e01c2..b3d3fa048f15 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -185,6 +185,23 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, &closid_free_map);
 }
 
+/*
+ * Counter bitmap and its length for tracking available counters.
+ * ABMC feature provides set of hardware counters for enabling events.
+ * Each event takes one hardware counter. Kernel needs to keep track
+ * of number of available counters.
+ */
+static unsigned long mbm_cntrs_free_map;
+static unsigned int mbm_cntrs_free_map_len;
+
+static void mbm_cntrs_init(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	bitmap_fill(&mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
+	mbm_cntrs_free_map_len = r->mon.num_mbm_cntrs;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -2466,6 +2483,12 @@ static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
 {
 	struct rdt_mon_domain *d;
 
+	/*
+	 * Clear all the previous assignments while switching the monitor
+	 * mode.
+	 */
+	mbm_cntrs_init();
+
 	/*
 	 * Hardware counters will reset after switching the monitor mode.
 	 * Reset the architectural state so that reading of hardware
@@ -2724,10 +2747,10 @@ static void schemata_list_destroy(void)
 
 static int rdt_get_tree(struct fs_context *fc)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_mon_domain *dom;
-	struct rdt_resource *r;
 	int ret;
 
 	cpus_read_lock();
@@ -2756,6 +2779,9 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
+	if (r->mon.abmc_capable)
+		mbm_cntrs_init();
+
 	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
@@ -2800,7 +2826,6 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->mon_domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
-- 
2.34.1


