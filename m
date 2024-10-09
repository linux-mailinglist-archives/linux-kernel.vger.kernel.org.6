Return-Path: <linux-kernel+bounces-357619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7739999735F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339E0285C08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F41E25F6;
	Wed,  9 Oct 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnlG1wUk"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3B1E0DC4;
	Wed,  9 Oct 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495705; cv=fail; b=lXBFemBJ7hKMFcWgVOBP5rszzKdL+MhdxuPD7QuEljBV9oqmlplX0CEnvp/mdkXs/rx6DZ9kY+64G6kKREb7aC+ShJVOSZ6Fip7s8qWYFHFgBAV4PCY/CoFAAbGZQT4bZHdJZqg6AWJm+mGA4SeHMZDVi3IEIfWvzYd3Ntlaztg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495705; c=relaxed/simple;
	bh=TCa+BfMmHKGFwPhDfik/QxZIicGHTdo76GMmgl9Xoew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZu70sk4Itfcb7zfEmZmi1RgxJVyDVrp4X6hD0NdfYNghHS5btn/r+0CxE5805vYTF+5WX+nkIq7WUZpaF1vZe/lc+FuK3OWi2WzEWqB43io3YAzh6zFR+046zWHcU9h8fqAHr82a5l0DMuOEmJOOJJQcSI1qyuzjfQk+ofEXYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnlG1wUk; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So99Wnk69QnYQH07YPDXqV/UUuP97xaxsmFMAa7MMJRajsTA5iT3wI+/amZ/3cDTbj6ZA6rXF4sPzln2JRyky7CwRMmKmO7G10TBse52ag+Tfd5IcTbhOoWvKwDIobDgYTW50apPjzioGj0p1C2CJg94d0cb/MlBaz1GtaEF8/MmQZO5mdK1FY44zmRaZZx/azo+QG60+of5NpF84P0oTkQoinP86z0Yub7s8PQLdglsAj87FY12DcDYfITwevMlp2sxQQ2K45aOAs73JQrQlXZi4UU1fFnwLny2P6IYulF1tirQM9ulADWjxtcNtCITxLrdobIafhf89FslyJjAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIutta4V5/XE5Gb5HQ6OT17MzEYY7LqAfnmuzsOe9uM=;
 b=EG/60CUZIvgB12+5jEOMGKLXfveuLxd2lm6UgyZZ/93VEHBoDo6hizeo8WyfSvBjQdEgI4DperN2ILkmNreYJJLxNi+UjvO44F9tnAmmezP7BOjQtyKyus8XfaJXauLma4XJ1oM/Vjt4S1xI4bbziydK27kYtgkEFBFmz3j9j5eSII3QGyvmmRmZNh/NGbiXuUyy3AYti0ImY3LT697k74BycfErSnawhWsJbJFfkMhxK8irtM6gWxNPFWRDWvKD0TKgDdx9LguWkcpocHVvX04iPB22kP9LDaUg06RPrGL9wymRKPx2Cr3WqDMk/i6gxoE8T5OveLOYP3R4xMMSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIutta4V5/XE5Gb5HQ6OT17MzEYY7LqAfnmuzsOe9uM=;
 b=BnlG1wUkH1UrZC1nKwztAyALlNtmYl6eOH4pGXFK7ZoGylF3c78AoPqg2QBY8aCr9uluIAvqxyQxXIurkKriFwPmNCQVz4NY8mB5+nw/oXN0WZgin4GvD1zNbx82dsr/TRiGbyHJQ8OWlrnJ9m6SdRXf/XxiRD1nOHbd33swkAg=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:41:33 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::2b) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:30 -0500
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
Subject: [PATCH v8 11/25] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg in struct rdt_hw_mon_domain
Date: Wed, 9 Oct 2024 12:39:36 -0500
Message-ID: <c428eff6b5763635f445f25ea8c8c6d9b1b23b31.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 02957d40-67f3-4a34-8c53-08dce8899d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWH+vEtWBZTV+siAL58FrTuctayN1kvfvrtyE/o9T91E760G1xKj3Ww+DQT2?=
 =?us-ascii?Q?jTv69esCqo949VkC7y/NTQHWv5Fc1jMNIsJihCQE0+iJMa0WLkjcLE4D+Ebc?=
 =?us-ascii?Q?MNRg/OOlP0XIyqNGbQ0q19KP07S+xtqYhz2Mi4Bu6ZIngM/szsUQh4JK4Z1c?=
 =?us-ascii?Q?Gz+I8uZ9qiI3CXoah58022gVPNtCfaTCXHkByg6BeWZcvswuJQ9vZ2J4/kB/?=
 =?us-ascii?Q?10DUjGn9nUelVRpx7/d3Uep05abI3do+rFdW9pGt9XUDAEg+te8ue3FCXoGp?=
 =?us-ascii?Q?NXWrfpkdXzX2K9/Hyg4oxDjvTNP6uyknXLwETKkAc4NBK0DantyGpHeD1ni6?=
 =?us-ascii?Q?TCRufyc6Cg+NLoJy6+cB0ZYKy53UPx9TEmhHQLXhgBT5+z1Xf/kk/8GxGbzZ?=
 =?us-ascii?Q?Fs5qx205GCthAeCM1sbBPtMoFgXR/QU5W3xHgfLk9ktqCez4vWiNLvS5XuUm?=
 =?us-ascii?Q?R8UzfNpotm9HZVIUqDZrWpfe3IEUrnGAKyC9ut5LrFNsTaDsHmOZdAaZkLI4?=
 =?us-ascii?Q?v+sBu7aFtEsQ7NdYqCLR9aqyEKiEnIUfEiII6P+E9/mQbokR1ufAZ7TFEG8D?=
 =?us-ascii?Q?hiygvF50+XWroU58q/37oCP+YW44TERjYGUBYhZrjpJs0r4klsy4AFymDDB6?=
 =?us-ascii?Q?pC0cuh2ditVXWW6zWpNJgTjUxpHIKY/kDVtADEDDB3H+bXk+7CAoHf3NB6xh?=
 =?us-ascii?Q?yM/AHt4ETSDDX5VIIqUnGJQywzuwDzyqiPE+1v3KkpS+u9597zaJ5TNmMO6l?=
 =?us-ascii?Q?aq4Xb4QlVriK733bZH5AcTAsZ4Fu3Poj7ZVrn8QVVZljluIMWqDSqzDwEEqU?=
 =?us-ascii?Q?kSSx7lMrTF44Iqo9BHZ7ZFCLlrCZX+rYzkRBq+iZ+n9prSNSFK4mVvpRNvIy?=
 =?us-ascii?Q?Z/x8U9mVXYi6WHz85fSDP0eVClDht3JL64DrnN5lhQZ5trMVgtiKfoZiNLsR?=
 =?us-ascii?Q?BSs5H8PZSzHBGvpW2nyH6H4UU4W0b6wro8Whg0FZ9zAAZMwrAy/habrBjQhA?=
 =?us-ascii?Q?s232hAzK4N7Z/qYgNgbM78/lPFRTbCQpPOaJ3rlwNupHCVmH9kDGihiJ4U/Y?=
 =?us-ascii?Q?aop9TvhsFcqXSB0iZpHO+WulnCcRy4D0cz2pZyVq6tuUG7y6oxYxkuBTHbQd?=
 =?us-ascii?Q?WJ8pqnFj7HFiDK05Xbx0PvVDnpZRGp0kp/JqCg3IaSOifpdEFnZ9d2ElImgv?=
 =?us-ascii?Q?7uL9Kw3JtSB4wvwqROCNJ3fGkGx9uzQZJYmazrNHF05gnUBjagOGxwXsqOs2?=
 =?us-ascii?Q?Rdei1cS2fX/SeqlM0FPe40Sl4cwEm9xzz8HP/Ks9lJbwtbw93YgxiTsLFxhY?=
 =?us-ascii?Q?Nj1VuZ4iJC9uZaDQyTmzpkG2RHCpbYzJ0apGWxoHGQxxXmMzdfHpVGBtszmX?=
 =?us-ascii?Q?Q/JUFcc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:32.4974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02957d40-67f3-4a34-8c53-08dce8899d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

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
---
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
index 00ad00258df2..a4f88c327b40 100644
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
index 99f9103a35ba..86e3e188c119 100644
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
@@ -656,6 +663,8 @@ void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
+void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
+unsigned int mon_event_config_index_get(u32 evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5c2a28565747..6b4cf4813a4b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1282,6 +1282,32 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
 void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
 {
 	dom_data_exit(r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8ffebd203c31..91ffd9d24883 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1601,8 +1601,6 @@ struct mon_config_info {
 	u32 mon_config;
 };
 
-#define INVALID_CONFIG_INDEX   UINT_MAX
-
 /**
  * mon_event_config_index_get - get the hardware index for the
  *                              configurable event
@@ -1612,7 +1610,7 @@ struct mon_config_info {
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


