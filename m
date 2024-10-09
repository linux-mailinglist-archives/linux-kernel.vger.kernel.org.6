Return-Path: <linux-kernel+bounces-357618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F299735D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB361C21C62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE31E230F;
	Wed,  9 Oct 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sb4E1M4I"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2201E0B95;
	Wed,  9 Oct 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495696; cv=fail; b=nGSmNoqs7AIFUFsvv5HsXdA40nxNMw8PterQfEpWMfv7+d+rZqWRbiYRPkkb2YXRWRwfy099dKVyVNe6JpEnNcikHBWeezkFa4uEXdxGRsLZc3wHAj/4YNCtkThqpcoqOBnvn+oJqQSh2MPxH8LVIiNyznpYb2JdCLVLsjFWho0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495696; c=relaxed/simple;
	bh=LEM1S7isFhjpobl3h9yU163KqpZt9TP5NSn+FZhBFg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcLXQ32b3/F4u9CLhFJldPicXDpneQoBIFylciZokW7kx48tYCrU38ZGxsplSlcoHxhXS7iVUnAPy9YdOWQW5bh7aRZoTeP0MYB5lJaL8pW/8AFkv5YKFB8ASJQdXkGLDqxu8+4e4w8lixgH8PYgEhtsytVLAnFXE+3dF/H5lEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sb4E1M4I; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl7WRVKXudWZ/kiSz36stMs7c8eerylemV5ClHCGZf6E9DUBkbLLsaWKo2UUPD+2C8jM4WhGSwCAyczFFwtM5z/4/hZFuyMX19t6UgSCPiSQWr0+GX52T91X4PPY4AhqsIbA4FfNQ3wMYjHeeYKegEaLMOZvHJuToMGSlQRlpgjisZHQiaLKqZrUk+bbXg1dQ8PcLP7w+zYsCuW0J5UwdJo5sseSN4hkyxlbMIj2uHLB3cJVtuBafZXg57r5JPCOq1zdxDb7M4yH9ZgCN9FZMwKbsWZ1Y5cgoCiQ5cyBqGDseCGe6xY7Gu+odjl/ZPff8EtZy79jnLzcSfgCvhaWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiIeKwlKmuxdiZS1vuChAKJByBo5IbbcQioA4VxLWcc=;
 b=pbxF3EOA717VhubMRFaAG9n/+SOpaxskFCD3j7+PygNI7Qukuifm2zMS1cDaDQiP73vaqilY0RHArN3IWv+aCyj+QqEexn6Imt4PutpyFDOr6FLpxdqTmXP6gA8ViOaC/GiFKRexoFxWIabnVbAozO2NLh6GQEyp0rblcQNiE0Ac4/e+B7xu2OG+GAZem/s5K4Td1dnPoiP1ZZR/m1BMWr/BgXMTtYYxZaQthEmCE+x1U3Icfvupdf3ghbh4a5FwNTJA8m39aXuPi/Edpe/NbTPcDwl7LZ39l9LyuUAR/U+eQOUxgNIDOV4ec8mNgyLj1vlwD47FVDx5CjtV+vnhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiIeKwlKmuxdiZS1vuChAKJByBo5IbbcQioA4VxLWcc=;
 b=sb4E1M4IYqJaK11Ia2V20NTCeA8qZwsgfzm5yb6WqsRNCcltwvhKJPs73/UlJH6wYwBbMeMM09E1lh3VvdFxLiiKRZOg2YAqJgCCtfJCkTjuA7MjAyB88wLL/QGJdFq0sRoh/66Gerl6S5x6L54GKOyQUWgarG4d2NdkOzrY+HQ=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:41:26 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::2a) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:22 -0500
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
Subject: [PATCH v8 10/25] x86/resctrl: Introduce bitmap mbm_cntr_free_map to track assignable counters
Date: Wed, 9 Oct 2024 12:39:35 -0500
Message-ID: <669613777b83bcd4150f2f204311e96198417495.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a96c663-2d8b-4ef5-d4a2-08dce88998bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nYu+OM1ETZ9ZjPP0+NJq2Dc2OHmgqcDyWjNhBNI+L9QBFAEiT7OGKCgk92I+?=
 =?us-ascii?Q?OBcaQArGw+IwcI0FglZPe+x/FgNPXFIJRxtg8WFR9TOb/E60bI/P+FfVHMy9?=
 =?us-ascii?Q?No8mQfId2Hm1mP7QunuhkkmTUDl+eoNM6NYglq3oOFaJnAH9jEE87h56mN9g?=
 =?us-ascii?Q?Upc2211s+BrvbjFd/btim26o17nLCjwNV26TxLBPJXcyayjJOYhi3fpo64vQ?=
 =?us-ascii?Q?F3/0aL8vx3MUOsatUn8vvp1lk5Ch4s4uk+DWh1t3W25QY5n3JEp7Kqw8axHg?=
 =?us-ascii?Q?hObSbNhZ/KICsoKAXrRtRymOKIa3XIUbmDIpNUOkFCUBqfwFT9TcsLS7e//Q?=
 =?us-ascii?Q?DLxLNJHJgrvdtR1NBsQcYvcO7gI29cAohuLCOsmjdiY7/bDWcM66uAguPFvz?=
 =?us-ascii?Q?sCwtLoTCykJoZ2DD2j8FNyscbYLMfycQsRk5sErjMvRJYJY74+5xdW3rBJ5B?=
 =?us-ascii?Q?NT6FqNvnp4FxfPOTp0U6WzMdCDc6kncwfEv0aCx37LOTFMZt9MDo+U5PYIO1?=
 =?us-ascii?Q?UuxdhbHx/o6v2NOIaIl6KfqN/FVPJqJ9P789d9Y81yU58Gg18wDuW4P8+xH4?=
 =?us-ascii?Q?9upcd/W6zWenSubxyGqa6tyx5lPcf7RDM5oBwqw8OrGnFWhSPa+kuf8wLgwt?=
 =?us-ascii?Q?BVvg+MKYwirPBPFhJMIytoIAEm3uivuDDrx55UFNwb9XcWcZpVmlRaQYaUKJ?=
 =?us-ascii?Q?7mTMZorPdaR4M30w2RdItFHnpOn5ThunkaLxoNwVyNYpDmDgilxmDlyrykHf?=
 =?us-ascii?Q?Wf6IpVf9lgVeDSof5mCM1WfWruOpin80h92YER7rfQFZcEP18CVLwxGizsHb?=
 =?us-ascii?Q?oBWHdAP2ZbdIt+UJ7ooSdAkDG8ORVDALQA4lt27LDilofojjdxHE2V9RlCrn?=
 =?us-ascii?Q?oLAQi+YqhwDPho6QQImCRRpfsk7ZWm/Xeq4p/+Du01nqmNiLmBFywbSvefbm?=
 =?us-ascii?Q?+PXXTa4ZdgvJDdf85EgJc0wYtezj9gp5QQOYPJJzc/hGjYVuhYXbVZ3qCLIG?=
 =?us-ascii?Q?TBNQ5Vz1iZHgNyoiR4fOEU7rD5dNonY9igT1J940F4hjE37rfNibAcpJWGkJ?=
 =?us-ascii?Q?T3U7PlHKl3WlDEV/JYLJpSWC+X7a1OVc2UCg/UBQbVicwGIwuJR+stMi7H3w?=
 =?us-ascii?Q?gHnSsh91cqcZk6GTNP0oIf5BunR5MfWimOS2EmL5IXL6Y9oosVubpO24HLOT?=
 =?us-ascii?Q?oAjCYXzc6kZRWqOYtH0Zrdzs6SJ7yp36mDfIRnvzR11mEVpe//VSrNWrHsCd?=
 =?us-ascii?Q?Lk6hBfj1FHDTcVXYSuIS2Z7vf1aCEB7gjkEGl6HEvpgC7fQ3zbgNgtgLohjI?=
 =?us-ascii?Q?yGCv+y0MjDFTnvkL6Z0MgAaPPJe31V4o0eKEie3OIJ6rnvgMkWmiWwu6KzZR?=
 =?us-ascii?Q?edBKttpLkZjr0dTNHHt9spU1eeYq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:24.8880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a96c663-2d8b-4ef5-d4a2-08dce88998bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

Hardware provides a set of counters when mbm_assign_mode is supported.
These counters are assigned to the MBM monitoring events of a MON group
that needs to be tracked. The kernel must manage and track the available
counters.

Introduce mbm_cntr_free_map bitmap to track available counters and set
of routines to allocate and free the counters. Move dom_data_init() after
mbm_cntr_assign detection.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Moved the init and exit functionality inside dom_data_init()
    and dom_data_exit() respectively.

v7: Removed the static allocation and now allocating bitmap mbm_cntr_free_map
    dynamically.
    Passed the struct rdt_resource mbm_cntr_alloc and mbm_cntr_free.
    Removed the reference of ABMC and changed it mbm_cntr_assign.
    Few other text changes.

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
 arch/x86/kernel/cpu/resctrl/monitor.c  | 43 +++++++++++++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++
 include/linux/resctrl.h                |  2 ++
 4 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 92eae4672312..99f9103a35ba 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -654,6 +654,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
+int mbm_cntr_alloc(struct rdt_resource *r);
+void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 66b06574f660..5c2a28565747 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -983,6 +983,27 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
+/*
+ * Counter bitmap for tracking the available counters.
+ * 'mbm_cntr_assign' mode provides set of hardware counters for assigning
+ * RMID, event pair. Each RMID and event pair takes one hardware counter.
+ */
+static __init unsigned long *mbm_cntrs_init(struct rdt_resource *r)
+{
+	r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
+						 GFP_KERNEL);
+	if (r->mon.mbm_cntr_free_map)
+		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
+
+	return r->mon.mbm_cntr_free_map;
+}
+
+static  __exit void mbm_cntrs_exit(struct rdt_resource *r)
+{
+	bitmap_free(r->mon.mbm_cntr_free_map);
+	r->mon.mbm_cntr_free_map = NULL;
+}
+
 static __init int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
@@ -1020,6 +1041,17 @@ static __init int dom_data_init(struct rdt_resource *r)
 		goto out_unlock;
 	}
 
+	if (r->mon.mbm_cntr_assignable && !mbm_cntrs_init(r)) {
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+			kfree(closid_num_dirty_rmid);
+			closid_num_dirty_rmid = NULL;
+		}
+		kfree(rmid_ptrs);
+		rmid_ptrs = NULL;
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
 		INIT_LIST_HEAD(&entry->list);
@@ -1056,6 +1088,9 @@ static void __exit dom_data_exit(struct rdt_resource *r)
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
+	if (r->mon.mbm_cntr_assignable)
+		mbm_cntrs_exit(r);
+
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -1210,10 +1245,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
 		u32 eax, ebx, ecx, edx;
 
@@ -1240,6 +1271,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
+	ret = dom_data_init(r);
+	if (ret)
+		return ret;
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c48b5450e6c2..8ffebd203c31 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -185,6 +185,25 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, &closid_free_map);
 }
 
+int mbm_cntr_alloc(struct rdt_resource *r)
+{
+	int cntr_id;
+
+	cntr_id = find_first_bit(r->mon.mbm_cntr_free_map,
+				 r->mon.num_mbm_cntrs);
+	if (cntr_id >= r->mon.num_mbm_cntrs)
+		return -ENOSPC;
+
+	__clear_bit(cntr_id, r->mon.mbm_cntr_free_map);
+
+	return cntr_id;
+}
+
+void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id)
+{
+	__set_bit(cntr_id, r->mon.mbm_cntr_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f11d6fdfd977..5a4d6adec974 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -187,12 +187,14 @@ enum resctrl_scope {
  * @num_rmid:		Number of RMIDs available
  * @num_mbm_cntrs:	Number of assignable monitoring counters
  * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
+ * @mbm_cntr_free_map:	bitmap of free MBM counters
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;
+	unsigned long		*mbm_cntr_free_map;
 	struct list_head	evt_list;
 };
 
-- 
2.34.1


