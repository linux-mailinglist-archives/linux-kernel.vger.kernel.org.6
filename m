Return-Path: <linux-kernel+bounces-443890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD619EFD32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52661619F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC21B21AA;
	Thu, 12 Dec 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YJ/5tnmu"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B61D95A3;
	Thu, 12 Dec 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034652; cv=fail; b=GLsrzKQujaN3hTTtvYa89SdGTgPFldaibLK+f+rkaZTk1JfNYSEhco9b28fPJxVTYAGWVJF/2YnZLJayMua9PvXzVGDkiJWloRiTrAH0Pnfzfeq3CrogLfno/lemJReTN3uUCGSEjPEHnuCfw6VZzfUVAmdkbSPDHDHsJ3JmGIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034652; c=relaxed/simple;
	bh=qi/0uJHApnfu+wBTSh7kb6oixUfI3MpzVik1uuOs0Is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCYBNNa2OuVRmifOfWmw4sh1Bywdu39Tx9hpjqSHgLxXKYSQhH2S4INMu+h/jgsInkDKGiRlk4+nWMeIo7Jte5IIBq2DctXWdQRm0WXmQEz50win038uGzdKfZoCCBsbMB5izaV74JiHcHRN91zz1dr8Ow4omwAAHaHLqSfsA6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YJ/5tnmu; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFXk7T1lCQIbOmyVppZmjzKHdgOWUorpUC+Sf7OwK9+hoVMB2470+cJcjPrim0zjNjVB65ujKgqiW6FSE6qg0gqpDEHWZmO2L38vCX086lRMO+OKjzqQE9WYB/zQMzvlAtrgrO6MozO3Wff4bdhEwQzch6tQMHk35Gdgz8a9wvHIJSS5nxnmts0LtZsRYme5o4p/edjYtHP/PH7P+l/Oq40qAZdwH3dyMqL64h/2vAQnqicBNWgiSEh8lATAZOTAGUV40ElqHpsHLEq62EUR1J3zMk9kwoOq5czJxMfaktqz1MrklfNLqc0Mcs8DdtreRTzBXztdSoXcsjMmxmWg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEbF5G5Ta9HIWmtCAMAwo7cPgFi9Nqr+Ha5bLTn2HPo=;
 b=e+d+VQ8BC32Q9iruwlgjJMBSvB1OIxmRmEbqHj1A3FMqJKWWjfhshLM7yu2YMSwL3hWRc9nn1zRlMGkluFiRhf++G3keSrvIoQEn+fKKnZA8WojHzT1cbhhWgOo0YvkQaptNW239gVyLbEZz8WAbXhZzx39u7LVYKnxUhDutH5wT1cAcr5fW+1fDjOKkhDRK4VN6F5v9cnLDzx7DMeBDyJHIjoGoPCi5RNfQFor9+XcYpDwxKHnsSn+d+xapsnz9GbICfe5yzUNHBWBrdMg4/9uycFcPPagLvXiqa6gHmfNZaF61x14+ARcUBJdZgDy8nKoY90TXgvuB6qN7B95dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEbF5G5Ta9HIWmtCAMAwo7cPgFi9Nqr+Ha5bLTn2HPo=;
 b=YJ/5tnmupQ0+muetWt2rrq4ieMmqkiPpMfZfAixP21d0/GtDNXA7fgzsre44oubxsu22eHJ1EQV+SwZQM7EHRP5y04c+/gI0G1nTVvf+wtdTVcwM0zgk72KkFgbID/sCO3iaeBJFKRW1Cqd3cv9uVuosMbWqbav8CuhTdeP5kcY=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:17:25 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::8) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:25 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:23 -0600
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
Subject: [PATCH v10 10/24] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg in struct rdt_hw_mon_domain
Date: Thu, 12 Dec 2024 14:15:13 -0600
Message-ID: <ad2083e0a61d60b087304aeed1a0be3c322bfeac.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e681d5-cabd-4bd0-e39b-08dd1ae9fe40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L6ZYHBb+Vlc/Tx6Ckve+sQgDOMp6JQZNlm04x7QC64e7T1j32ULn4+/nwSYe?=
 =?us-ascii?Q?K/T+XQ9EOneH7AkM1tcwGKCj3BIzh3KJlxmBeO8JZ2ZMqVznjQJwkKx8XRjw?=
 =?us-ascii?Q?CVXrFEEAoGU+Isnz2wGW0pkSY1TDAytaOIIU18Mqa/Hlgt2GbmMZ9I000MA/?=
 =?us-ascii?Q?1I0E1eRelN3TX/97OEdpQz0yLkGfz2M4Xydf7rfbxhENcVquqhT7wPLX/cRf?=
 =?us-ascii?Q?Q3caJA1KhuAuUbBVbR73T+0SOSmkue7T4KJtlLE7BybeQxmiXth9FKnOt3At?=
 =?us-ascii?Q?kxCate7BsooOQdcczwHEh2SoUZ9C71qgzxRoCCXufjVk3Au/XMDuZUcew/mm?=
 =?us-ascii?Q?HfLT2U5+KLke1ikaP/zV63UOJNrG68zduEv+skv15gOiW9P+wIIpMHapL528?=
 =?us-ascii?Q?/9wNBxZc/j994U9t8vPWVAKXrKkAuraeS9FOnWWjW/8CiMJNOGsWGkmrKLbm?=
 =?us-ascii?Q?C8/pGX6aSFzHSfUVjNLP3v6wJqaLLaQ+5qohlqsXn/W/D2fHHQlorEmZsM5D?=
 =?us-ascii?Q?0n+zxyrY54c2rTIFxLOby8rdCiYtJmGUTL+oS9c/SO11suXC4EfV4Gx/iY8V?=
 =?us-ascii?Q?w3aNnFrTJLJVdsNNJwyY6M08gfC8/rDwck9sVL2DCd/OWlvaDWsShuwkHFKM?=
 =?us-ascii?Q?oNrPRNdr1LFEr5Xp15n3qXEVnOdRFIhwGJB+Au+SahZbPU1BCAR4waqpPg3A?=
 =?us-ascii?Q?QUnydOXIInSDTIoU9Ll3ruR4zmoyECfQ/skCaQRlBqgADiCOKfWqs5ymyg7w?=
 =?us-ascii?Q?22I+Y6+o/gcjLsvVW8D8A8q1MXOXJXexFv9zZby6XWnhgflWZuBAVm8EZZE4?=
 =?us-ascii?Q?0C8ctoCcaLYE7Eqq3QyY3FNKZc8JlYp0k09sLKZKSIg+D730gFR+U1UnN8Wv?=
 =?us-ascii?Q?cUQUVQDv3rd45zv45E4Rri40nWuJYp35Ynq2bkHB+moynN1YxtEIRwQUAmPV?=
 =?us-ascii?Q?cm/MFRcfw8E+VwaqScx9Tr3LQcRGBwtUMXrwkuSwl8D9atAeH+gJ51U4mc4U?=
 =?us-ascii?Q?Y0jJdnINikIqDBSad+DCjk04IH22QGyi9YdMNGydylQGxjWNoXWH883Jbxd/?=
 =?us-ascii?Q?pjBOXPN9m/i8HeaPPccT90HH+HeeZYRQRpoCQzz6pXqd4h0goSKzuoXA7pAJ?=
 =?us-ascii?Q?VGXVU7/3Oj0dNr+34hkLUiblNrearhd7w/B4wxesNNKEIIGT3Btyb9MFUrei?=
 =?us-ascii?Q?Jht2GomBbr6fxEU3ONp63nLx/u8GPsOEgXt7VUvT3paTzLnq20lF5VVsIJhL?=
 =?us-ascii?Q?kwVR5r8HvhXNtxmRXqC/W3engJcBVWYRqh9e7S7/8OUB0s+iLpLR7MClF28M?=
 =?us-ascii?Q?n5pKB6C6WL8HNbX+pNWC1w753e+vg4Jbw9gjbIhs0tlSzzwajQvyf7O5pcDT?=
 =?us-ascii?Q?GTgE+tuci3mxNxHaGcLLKFTlJBQoBStD5bOGURKyxn0vkYtkNSx0TnjgVeo3?=
 =?us-ascii?Q?djgvRhTdyBsF4JxM2Fbff/DQjE1nU49X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:25.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e681d5-cabd-4bd0-e39b-08dd1ae9fe40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific
events. The event configuration is domain specific. ABMC (Assignable
Bandwidth Monitoring Counters) feature needs event configuration
information to assign a hardware counter to an RMID. Event configurations
are not stored in resctrl but instead always read from or written to
hardware directly when prompted by user space.

Read the event configuration from the hardware during the domain
initialization. Save the configuration value in struct rdt_hw_mon_domain,
so it can be used for counter assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v10: Conflicts due to code displacement. Actual code didnt change.

v9: Added Reviewed-by tag. No other changes.

v8: Renamed resctrl_mbm_evt_config_init() to arch_mbm_evt_config_init()
    Minor commit message update.

v7: Fixed initializing INVALID_CONFIG_VALUE to mbm_local_cfg in case of error.

v6: Renamed resctrl_arch_mbm_evt_config -> resctrl_mbm_evt_config_init
    Initialized value to INVALID_CONFIG_VALUE if it is not configurable.
    Minor commit message update.

v5: Exported mon_event_config_index_get.
    Renamed arch_domain_mbm_evt_config to resctrl_arch_mbm_evt_config.

v4: Read the configuration information from the hardware to initialize.
    Added few commit messages.
    Fixed the tab spaces.

v3: Minor changes related to rebase in mbm_config_write_domain.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +---
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 407a80454ae1..136b081ed04b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -632,6 +632,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
+	arch_mbm_evt_config_init(hw_dom);
+
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c07a93da31cc..f864550ddd42 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -56,6 +56,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+#define INVALID_CONFIG_VALUE		U32_MAX
+#define INVALID_CONFIG_INDEX		UINT_MAX
+
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
@@ -401,6 +404,8 @@ struct rdt_hw_ctrl_domain {
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @arch_mbm_total:	arch private state for MBM total bandwidth
  * @arch_mbm_local:	arch private state for MBM local bandwidth
+ * @mbm_total_cfg:	MBM total bandwidth configuration
+ * @mbm_local_cfg:	MBM local bandwidth configuration
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
@@ -408,6 +413,8 @@ struct rdt_hw_mon_domain {
 	struct rdt_mon_domain		d_resctrl;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	u32				mbm_total_cfg;
+	u32				mbm_local_cfg;
 };
 
 static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
@@ -657,5 +664,7 @@ void __init resctrl_file_fflags_init(const char *config,
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
+void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
+unsigned int mon_event_config_index_get(u32 evtid);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c23e94fa6852..b07d60fabf1c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1248,6 +1248,32 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom)
+{
+	unsigned int index;
+	u64 msrval;
+
+	/*
+	 * Read the configuration registers QOS_EVT_CFG_n, where <n> is
+	 * the BMEC event number (EvtID).
+	 */
+	if (mbm_total_event.configurable) {
+		index = mon_event_config_index_get(QOS_L3_MBM_TOTAL_EVENT_ID);
+		rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
+		hw_dom->mbm_total_cfg = msrval & MAX_EVT_CONFIG_BITS;
+	} else {
+		hw_dom->mbm_total_cfg = INVALID_CONFIG_VALUE;
+	}
+
+	if (mbm_local_event.configurable) {
+		index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
+		rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
+		hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
+	} else {
+		hw_dom->mbm_local_cfg = INVALID_CONFIG_VALUE;
+	}
+}
+
 void __exit rdt_put_mon_l3_config(void)
 {
 	dom_data_exit();
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 339bb0b09a82..541bd353c567 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1582,8 +1582,6 @@ struct mon_config_info {
 	u32 mon_config;
 };
 
-#define INVALID_CONFIG_INDEX   UINT_MAX
-
 /**
  * mon_event_config_index_get - get the hardware index for the
  *                              configurable event
@@ -1593,7 +1591,7 @@ struct mon_config_info {
  *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
  *         INVALID_CONFIG_INDEX for invalid evtid
  */
-static inline unsigned int mon_event_config_index_get(u32 evtid)
+unsigned int mon_event_config_index_get(u32 evtid)
 {
 	switch (evtid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
-- 
2.34.1


