Return-Path: <linux-kernel+bounces-240259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF92926AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45D1B259B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77796194C8E;
	Wed,  3 Jul 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qOo6Buj"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896F194A66;
	Wed,  3 Jul 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043413; cv=fail; b=Irt7w0PUb+UyTTuuwC8qBpdhUzLXVGGCStgSzxmdAg7SUxEViGOch2lfVx8m6EGmu20byPLmCdiFLbVlFTQs5y2X9yGRNejOTG/bhztiHN8DSLuuA60CoG7fjeUqxUA9IdnQ8ffO+7psgdWEdTnw9ZR29vhfFcOht2RJ+HCWhE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043413; c=relaxed/simple;
	bh=QA6xzUGhXw80Ls4wj7GG77b8I6JaGxMVrjb0TSvzLjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwAaUZHgXVwbYg/ImmwIkMoHAWxigZzn8t5TBcS5XCcR4cYvv+g8ZagD7fPuKrDcw6+yvqDbUgUW4iJNkptAW4JGhwuwTl8B3gk5exyIC+lYMFjUqkVI3RDK2faJ4kjX/ZiY1qwWVyXbbz71r7ZufRrSjfOzq1If4HSVHR5amro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qOo6Buj; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv74cYaWw25k3RfB2aZzzVmoe6c0SU/6yzeLrAxR3PxpwcVeJCsKps13M+DUd8NDkGVjcLDD34CQ3344uw+xzd3A78hAFTCtt9VAD1mVmeRdmLMM3g3UmpBL3YITeNajdSRrRgmTlG58lIbz7PXOUm7g1MSTYaxIf1KMs/MI26/qNCf/43rp1mhy/QpgSRBHLFTZu1fM9+G7opOtokgcJf9+N3OtpUBQJ4FvV7xuCgF+o0xp5Hfk8q9ctiQX4cH9MhD2lGXNdNLq1cv1bw3nYOJEEfKHCpCBK1DZJUln/Lq5JWLYtJg73rWswXzj9Q1Pds5McyD6Z6GOuq0zPpEkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG8PlnCkarpGFCTQcIWsmfHAbayM+scnDA83UKDljvw=;
 b=PVF6OwpX9/J+yQ/HHp/ym2tk4zjokaadsuYh1yULG3jLdj5U6RI05fnhTlpgcEsOgQTHB8wF0X5r1jMMXah6ggyI0xLZ2+RM8N60/8G6pRkqvB2GcaSLd17Qjt7oba2ltxHgaQczO3cbGYkELUOZtoLzd5Aw8JKBvnJPDcMbqaKeVsduW0E7+XK5IocyKzWsoVPg4rZa4pkZg90JRoTMNDH1EHN4/QRktjDGvHRTlR3wCXCGXtG1rD0zIwYn6GA+TM0mwTv1aeaEDTRWkU2u9E4lCUOUsv1R1f2moA4967qjT9x1K5UCThFTYMNL0RCL9iN8sruqR+uW2bRZKHwVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG8PlnCkarpGFCTQcIWsmfHAbayM+scnDA83UKDljvw=;
 b=2qOo6BujU4w9I2QKy5TBEH2rutYl3YHIU+5LIsg6tyj5UsCt5Ydwvq2D81FHOgpo8RpGrFL7pI9lpXniL8yQT9uuncD3PF8UA9KT6CjAb/CCDOoU5pFy8bhjek8uavdqWbbPTTB0xU+xL56/Pr7ErbN4NPJC+S3X/B7ZRYpgFZk=
Received: from DS7PR07CA0022.namprd07.prod.outlook.com (2603:10b6:5:3af::24)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 21:50:04 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::25) by DS7PR07CA0022.outlook.office365.com
 (2603:10b6:5:3af::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:01 -0500
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
Subject: [PATCH v5 10/20] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
Date: Wed, 3 Jul 2024 16:48:21 -0500
Message-ID: <f3f03d4c3518474d3e8a591c22d965ba5b934361.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6efcf2-a703-4f25-ff55-08dc9baa1891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WzB1U7EI6H0DU0in4wxZm2r690+EQRZwQ/R6HJjSCu3Cug0Pvwnw1czKr3dB?=
 =?us-ascii?Q?Yq1os93HGzbHNZeniXsuFsAXWmbmUeS/1a+bVeENqXv3gShy0zjNtpc4QK/2?=
 =?us-ascii?Q?YAdyTbjkfxyrjuCuWLkl23qeqGeLvfR1JLFuMbr2uKCkGPu3QCgim4V9oRWN?=
 =?us-ascii?Q?5Kp6FOF2rXAUdgwvGMvSNWsBIosg8hNNRVvsYU7u9EhR6m7XZhdhEbELJuxM?=
 =?us-ascii?Q?FWp2g0M0g2BGrk5226pmz37GY8ik6dTndOe+yeAMs1dEkgqzphmlE/jvAN7C?=
 =?us-ascii?Q?lsLW9uR+yA1WQvvHHBIfPnZZoXjSbSk0JVplif8E+DzyUkR0LYsD9fLKmjpL?=
 =?us-ascii?Q?t3dl+hk7ey7SOVSmlENvbhbs0RW9EY94bbe936RaHBnDb6/wRhcjrtp5M4TE?=
 =?us-ascii?Q?eMoQzEGni984wPVB9XNw8+beQ4UQodmi7cB5kE9g0vV1T7fpTgs6gJJVS6Et?=
 =?us-ascii?Q?T1ZkRCjPyUpeQcTKJ8lyHyCgDX2HqnG3mKg0lhmEzNPj+Hz58FN7aMGyT3xI?=
 =?us-ascii?Q?sTyX0Ezs24WE4UMmNz/UczCRoPtdytm0tRN/oihIQ/z+PwjWH30J6JT1Q5TY?=
 =?us-ascii?Q?i19dIVpPTcbmPOJW6RJa3ruBrnhuHUO6RsjINd/qqk5dtwoo9aA47ujXKz7k?=
 =?us-ascii?Q?1d4y8LVkKpvzj2TygUj5vcag8dQ++NAG0/8SDyJgK/8kYbWqvPSUjOZYbnYZ?=
 =?us-ascii?Q?I6ETaxSpOF4v3+H2/oY5DP6NLnG5lVq12pfmcV85bMvIwZ0+q3+5+dN6dS83?=
 =?us-ascii?Q?y3AiEF0xEc1OrauimJgW567t0Arol6T0zGD27RJJNWPyTr5rDVBCzU5MSNiJ?=
 =?us-ascii?Q?ugi9QkXsnlEkHi5b3US+pQqRivFXdMyhHF+rS1pPriRx9Vle4FPzh/xXtraB?=
 =?us-ascii?Q?rQL3dsJLRl0iJxUCHWacE0WVRqO1vvsB9Qf4KXqtIPeyp4aMjXhBYSEcSFDr?=
 =?us-ascii?Q?kB0BlL1Fi/bymv0CsHjKozZ/s2ZphbFbEbRIyF5dIvFm+w5bMPLAIsMtsNwq?=
 =?us-ascii?Q?K1GPDIVxtTTdmB68V/xu4ohaj/BMzVUs4ouZKmW9gq/K2iDMZnuTTsmAUXwe?=
 =?us-ascii?Q?8npTzrrmtcu5e4sBUM17a1Tv93aa9W9q4g8pDq1pUeWEWDbefcZqBBYn3EIC?=
 =?us-ascii?Q?et4Iajj85L28vqsRPtxY7a5mNnpkAzvjjisgejj+fUw3rU9hXVPndyLcA0Rl?=
 =?us-ascii?Q?zgGQhzO5lrwYaCzeKpJaYdSTyUKv80x4HysNd17WTnEe+7t9eK3R0Gvms8FC?=
 =?us-ascii?Q?PFcNwXTZcLMO/udYZ+q4yrapYo55FmJVRuw34oiOPw5YgYYJXNHZJB2SMGKN?=
 =?us-ascii?Q?LM34bMFKHVINr0KEZADpaHjPRQaA9lsu+uEWtmhoJeJn7td4exX/2D3A5RSm?=
 =?us-ascii?Q?3BJI6rd8u19msvvrj481NMwDJmZMIyDBZf64yHWHImZjQABmdAYoUBTvuC5r?=
 =?us-ascii?Q?y6lis0HOwFo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:03.7640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6efcf2-a703-4f25-ff55-08dc9baa1891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific
events. The event configuration is domain specific. ABMC (Assignable
Bandwidth Monitoring Counters) feature needs event configuration
information to assign hardware counter to an RMID. Event configurations
are not stored in resctrl but instead always read from or written to
hardware directly when prompted by user space.

Read the event configuration from the hardware during the domain
initialization. Save the configuration information in the rdt_hw_domain,
so it can be used for counter assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Exported mon_event_config_index_get.
    Renamed arch_domain_mbm_evt_config to resctrl_arch_mbm_evt_config.

v4: Read the configuration information from the hardware to initialize.
    Added few commit messages.
    Fixed the tab spaces.

v3: Minor changes related to rebase in mbm_config_write_domain.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 22 ++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ff5cb693b396..6265ef8b610f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -619,6 +619,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
+	resctrl_arch_mbm_evt_config(hw_dom);
+
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0ce9797f80fe..4cb1a5d014a3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -401,6 +401,8 @@ struct rdt_hw_ctrl_domain {
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @arch_mbm_total:	arch private state for MBM total bandwidth
  * @arch_mbm_local:	arch private state for MBM local bandwidth
+ * @mbm_total_cfg:	MBM total bandwidth configuration
+ * @mbm_local_cfg:	MBM local bandwidth configuration
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
@@ -408,6 +410,8 @@ struct rdt_hw_mon_domain {
 	struct rdt_mon_domain		d_resctrl;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	u32				mbm_total_cfg;
+	u32				mbm_local_cfg;
 };
 
 static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
@@ -662,6 +666,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
+void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
+unsigned int mon_event_config_index_get(u32 evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7a93a6d2b2de..b96b0a8bd7d3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1256,6 +1256,28 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom)
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
+	}
+
+	if (mbm_local_event.configurable) {
+		index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
+		rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
+		hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
+	}
+}
+
 void __exit rdt_put_mon_l3_config(void)
 {
 	dom_data_exit();
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b3d3fa048f15..b2b751741dd8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1606,7 +1606,7 @@ struct mon_config_info {
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


