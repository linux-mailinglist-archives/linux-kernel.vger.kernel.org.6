Return-Path: <linux-kernel+bounces-316039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8296CA44
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45281C24ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29871865E7;
	Wed,  4 Sep 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iUBJBcRD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490F1865E8;
	Wed,  4 Sep 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488599; cv=fail; b=o4Rv3k0ZRzUSz4Lyvx7xXYtdcpJ7pv3ftD/7Dw358alRTEw4U/euhoHClLSQ9cE/HgynD7UF0tRZZzl6XYvBugQ/p7Bba98a3JykdfZFRSlIb2MniTEyvt+EcyH3W87XTTGijaFAjfYrppoeoNozeJQHo+uoHTaQasO8AetyNsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488599; c=relaxed/simple;
	bh=HdCRHGBEQnBecOQceF74biMimgIkRgyjGlHsJ4Suzkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5FNmBRTuEJVeBaKvEZaM9RmW6GOZpg7y2wzjsvI89DG2AKQJPP7UKbA5Y8CyXaO72qY4wZLaKVOG5SStJ0VaWoRl9AD7Q2xCatHOvzN7Y08XfF8DWz4/CjtPnrflXqdJEnmottKT4+L0zyCg18HlpZrLP7XO/rIbcnTYPFVvqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iUBJBcRD; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJw9m/EXtSawb54kCERN0h7L5mcWX9cCixJjoyn9j8lgSNy1e5bHWQ2TPsW0tFAkaBpocmFn25iW1JxX/pyu48oYDDnGXAcgogiGi9AUXkOuLj7LP1J/D2kmrUx5pt8CHbzUKLc+kfEksSVf85jGfEF1pCqRP3slEmqWqCyQ0QzrhIj3oCazZPrBGIa/gycQBagcrAmYceYOsBh8CLCivLXBLITi30ulAeQqQ2ptBWPCm3CGN14oSn7q0yHSM8EkKuykCHJpzZIbh/aF8qSg6/jvtrnapk9ixNmfCpUq05t8teRQqKkYVc9d5JXnWVbg5TXY+YiU4bmCFaNVXmUKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr/SmCrzK4so66LWpDIHcWIT3M2xebsbdF2VHQOw4n4=;
 b=e/j7hg1fVO4Q9A3WwOuvplfolMaFa4AWGoH3UmKFvfiTsqcNu+6ISiKR9pb4fzbZp2Zh9Bg8ZOHzOa7JW2YGdvfo9GgBF+27qHXrq1/1Su1Jr6V62abZAh1NXLEYzpNuxJgDNdAuRsHSzxzPJim/cQE5fFpV47fPBlGa72Djgyw/J31alFoFA6KQwXUvzkc72LPc0gP+nxvcCavkM1FXpGlg2oWrS2znPGebBgfA+MDBIlCCKyf0UlT/MKrNpS8NX6sTBssnleeQC9luwsPEBThSqoKR2pAdZ7vZdX04WexNsPjYqyDUDZ1YQ1i+L14yoXwyp8M7JNYpVMIvHWDAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr/SmCrzK4so66LWpDIHcWIT3M2xebsbdF2VHQOw4n4=;
 b=iUBJBcRDXqtGszSSXS+/V0E/v6vdlbJ/DI7o9/+YjL9m8p4gdkZec+hZyQ+ym4fJuca2lFOLQhNFJ3gQnfVvBQKHy2IMKFHKJlK9z0Ys5ieo+GwoASg8T860n9peAzRkJ/IFH2JaFS/OezqpmOPM7x16idCWxdg+Hmj4lC0H9Xw=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:23:10 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::f8) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:08 -0500
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
Subject: [PATCH v7 10/24] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg in struct rdt_hw_mon_domain
Date: Wed, 4 Sep 2024 17:21:25 -0500
Message-ID: <3182fb783dafc73fefbd762d7d83ae790c25629d.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 426bdc02-f98a-4e3e-db89-08dccd30286b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x7SwC3TKdqvJtYlBlBtGcfyS6T0nBIngdBHTzyb4p+/O3JDrO7B+AH5U9fEE?=
 =?us-ascii?Q?jw5g94O2bxrbO255V3PkpFgItYvoUV5QCazgEb8tYwvzCTBvO5ngU+3FZOT4?=
 =?us-ascii?Q?WkSivy0CxYvvWhn2tkFGgekym60hgeypLP6Vc1+KB1halCzR9ba5gtrdr33g?=
 =?us-ascii?Q?Vc3qXcK5/XkZ4GsWqkyLPxktb9tKLEE1WWNx+MESfurC/+/u42bgUd3o3Ktc?=
 =?us-ascii?Q?VmhBZ1wEV89qtHZtAez3KDRpvBIrudH9AIT+GGb+8bKaaTpfr1lAzYqgN52N?=
 =?us-ascii?Q?FMH+jrsAIa+qk4D5O05gr/MizBhf3hKBzDsf7OK7qtBolI47pOCIEQjaRU4P?=
 =?us-ascii?Q?UR2N1VKZgCtyNIMJY6+Y2ePVSCx6IFFBndhi7s/eUA2RATH4l7MzjxBhnB2L?=
 =?us-ascii?Q?Z9nPzoLrzSbT5FVc37oUZcM/EvDLR5/DZmAn74XeK0KWD4QINILNTbz5r2Fq?=
 =?us-ascii?Q?+0T5EsLWRC7vvfrDAux9s5ElMRONDW3vzK9qry3jWiWmBRcJT2zfuwSNuy+o?=
 =?us-ascii?Q?UhiKVfhx4k4orNgDmsh44UPmMGAwND2DCWVJHzbSL3AXUHqDibuBLVD0grYT?=
 =?us-ascii?Q?BwICyHpIyKpnf6I/pe16tnyIl3XYjCw6i29IEUrK4oVb1gH9ylay2TWRfxT6?=
 =?us-ascii?Q?fBHshQ003cMDugmpU+B+zYs00bhQ/CPF/LlGjEGM2dVIk9dwNt8XR63RDzJK?=
 =?us-ascii?Q?Z6c4xyugjpujYrk/RFsOXgjRlZcGkagrn7ADj1DSL9J9tUal5FDtdRIL+jn2?=
 =?us-ascii?Q?J6JQ9E9KFnOD7W1ZtPZsg//OElfKfbuSt0s8rDeXS2xVw+6Egold1vaLhEXr?=
 =?us-ascii?Q?t1AmxarhK3kKsOM/zEFnjtngHwuYgFC08a+L2jrOeYl0JfjgNha34sRlSIJ9?=
 =?us-ascii?Q?Z+2nashWznNpPzmevy0z2F43EZ/QHWsmUeI7k+hEJflkFhbcHTvgbAmsYGTe?=
 =?us-ascii?Q?vIWSgcFx3oNNs98oZv5d4eQOuUW+R3H6aPPVaqBuI+lc1Zb2dou9cFtQlWRj?=
 =?us-ascii?Q?gqxl7Z0HPzjUwrJVNwcl+Lkvqjaald8OsPblzo4pz3IC8Kbqz8fmNlx9rBgX?=
 =?us-ascii?Q?rF1FS6zxJVwcNqAmqIbwA2X9V2Q51qbFQIC9dMD5YCjIfGEiX0KDwuStMeqG?=
 =?us-ascii?Q?qPX4Y9POdIi0GSyWg4M+TBiiVrb47QuvcuYM2zJhkEPoahlGpvqokBNZEdRy?=
 =?us-ascii?Q?q5asatDqfEcKj1B6QEmhzvyZCH0kHbnU1y7UrjBln3j0PuN9O93tDIrYX/RI?=
 =?us-ascii?Q?RyPD/emoRA8VmlelDhtnUr4eq7JVs+UkVUJI84FMIkjroupbF/pIWsDMQoEl?=
 =?us-ascii?Q?cn+cBNq4Y0UNxiRWblc88MxkCbd9xCn7tntjbeO2rcv7lf54+TYfUaO4GF45?=
 =?us-ascii?Q?HglqgFeGgSCTOenRI2MpJQemhGKlUYLuoAP1omVD9LJX6PMbX0yMjClkCkWf?=
 =?us-ascii?Q?LF2KiTq9/K8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:09.8486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426bdc02-f98a-4e3e-db89-08dccd30286b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific
events. The event configuration is domain specific. ABMC (Assignable
Bandwidth Monitoring Counters) feature needs event configuration
information to assign hardware counter to an RMID. Event configurations
are not stored in resctrl but instead always read from or written to
hardware directly when prompted by user space.

Read the event configuration from the hardware during the domain
initialization. Save the configuration value in rdt_hw_mon_domain,
so it can be used for counter assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 00ad00258df2..2a4be004a2df 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -632,6 +632,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
+	resctrl_mbm_evt_config_init(hw_dom);
+
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 99f9103a35ba..6107101f2d8a 100644
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
+void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
+unsigned int mon_event_config_index_get(u32 evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f98cc5b9bebc..09b1d8bb0aa0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1275,6 +1275,32 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom)
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
 	dom_data_exit();
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a51992984832..299722b3fd90 100644
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


