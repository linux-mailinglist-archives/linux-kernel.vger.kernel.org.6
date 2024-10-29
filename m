Return-Path: <linux-kernel+bounces-387839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391D9B56C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BB92815B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE8A20CCC6;
	Tue, 29 Oct 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nq6aVtIl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94A20C499;
	Tue, 29 Oct 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244237; cv=fail; b=cOwZwlyeo6YDON2ytADM8AgbP/HD3wrQrQK43MBRJf4ptlQ7J62GItvbt/QKbY6dwZyn5HImq1VkYTJVM2gcHVqHGjd5hu+bLXhJNg+NQOX1WwAE0ihkiXBjCF7SY6MjQIf81W+h/OsfJkGo0C6cNKiOfoZpNiXzaL1Gd1mWS4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244237; c=relaxed/simple;
	bh=f/BSWxa9+GBQgRmW85N1XH4jjYKGe7jn0Xzu7pUeHQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k53N3WzVHaff1YIqi2ThHUWKPLrgkdgqjtLPT9ef7pVjmKyTVSRebCYdqP6vtw8z3xfDn1qA6+Dh6BJ78LxeltaQQN98sVhFj4dr1amtvo7DY9a4G/AKxpLZ6PNFrksUtx3NRftiOUTqltEsNnzYkoUWnbfy+zCTxA6IwznKt6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nq6aVtIl; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxVlIbJo5AsaedNwRX0H3x9v6Ss6AAhvGKLjt+FblGk+XhNZeP5ZeKcQkAWeHLQOE5M+cw6MjC9+UtfSr8f7BWPUiml/WXS5j012BJfEgDLU1KRUWVOcGjAxK5jrPRXE7qwFL4gINnPB57/DnsggXvbCKjcFXIQb9+1k31p8kRZk5mSTlCE6hfml0o74reCPCX2QFclgXTPhoVgAFpFxphFtEofsqXvhRi9Wj/aHL20nCVy4drJotIjddGIPY79delDRMDKH16lUfQYTuRh4XHvuGv5Ridb8shYY525sYf8UOET+spyBBmxvCVaAfYScTat2S4DJeRX1GLCwo7ZqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj1mrtz0YnCm0z+g2Sz7o4rw1L/++YHoW4GU6JHW68Y=;
 b=PnhBcqetpHngGwSXt1+cq4Hiu0tjXRxsCvCyYXz722uxnsD3IE/gd1DpXUHPdSvavMnbtEMxQdyffAxxp0stg6jSBM3lIABEBkiYCPh95DyWmilCm7EjhuWO3HX2NtVN7gH6/6D1xiACqyTG5YdBD+V8fGl7kUhJfDYa9U4LIb0kLjIVRfFrS8qQkzJgqSvE/SDDqeVYDKV42L8mRILroaQHRf5pOHcs77KjrQpa1w8KBTtnFrXnW0bm6ZrM0oeiqzVZNGt8wIAYFmDrETlvbtpVWpYnSRQNVvg3cz59nSShGsTrjEIKl0aQlQCP0lCnboe0+pRTLOFWcP8Jh7GiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj1mrtz0YnCm0z+g2Sz7o4rw1L/++YHoW4GU6JHW68Y=;
 b=nq6aVtIlh8L+J79KQWR7v0AeMuJnTPybIsOGXlfxDEwiRVWMoUx6EjiX8GQjLY0u8jzqVok0zkvdKcPT02P5Jd2ZKd0q0se80PJPVwzCqsgngRCiXy0bLoNU+k1+Y0sgGEp6UAcvG3QBoM0Ofvw0UJXvpjMO+XWBEIct6IZa8JM=
Received: from SA9PR13CA0109.namprd13.prod.outlook.com (2603:10b6:806:24::24)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 23:23:49 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::fa) by SA9PR13CA0109.outlook.office365.com
 (2603:10b6:806:24::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:41 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 11/26] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg in struct rdt_hw_mon_domain
Date: Tue, 29 Oct 2024 18:21:43 -0500
Message-ID: <9df47857dabab2c2a21b98c77322b430c8d9dce1.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ac636d-4ac6-4975-b0a1-08dcf870be12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mojmUVLqpz5O/Bp0LG2rNYsWJkUx5LV13ME62pYJnWq7fkWVAB9G12as7ldE?=
 =?us-ascii?Q?36EENpcDw1tcoV+97p3sA0HmtJFgQg/20wQdlTkZS9k/FwJVTZIyoHa8rfcN?=
 =?us-ascii?Q?KClyrD93HFi7ybVy3f7wk8pDxFmabHPJM//kiI3/QeOXJjifT10K6kmI3wE7?=
 =?us-ascii?Q?QfWnOceTfTxxvwAAWUdL73eUPBwzqbMa0WNaeDYuDNmKoeb/3Dxtv9DdUQ3P?=
 =?us-ascii?Q?n4trr0Jai0ae+2LAukY8wGJEH1H8peH+ZN6jcWpvnyR4cMIdzHB++urVj4qK?=
 =?us-ascii?Q?tmIkUkbvRxJrplximb6mIQgM0HpJcR4cOpjdJaIyXnuqlVoR+ghpN0fMN/gJ?=
 =?us-ascii?Q?ChI21CExhi9pvP20LpVZkrL+Tp7baOb5k9pQL7or6idAnQYHrwLmawqnJWZL?=
 =?us-ascii?Q?O8EvqcCIFLaBypEKIWPo6X2lUglKNVdVu9QUjfLMjMZ3brBAOtNcZda8tAYl?=
 =?us-ascii?Q?aTl40L/9EnJUvvtsRru4JgrLnoeCWFcdccRvxHRP6oDiJ+q4RN7IFnsDWIIF?=
 =?us-ascii?Q?WC0aw8NYcM/b4pNRqlqs0JncnJh0nKViy5M+01SDvHneLU1uq+zYFZC6W8cQ?=
 =?us-ascii?Q?LvQV+1eMhOK4VJk0MYeb3BB4fpjljMXnP2aPOPlw2NzerlYZsHg6KcKeWN31?=
 =?us-ascii?Q?6Z3HB9GAl7zTNBwTN6mYzuxAs0G5/dzqJCsqpAVh7MSGO1Kl8p5oONu4g9WG?=
 =?us-ascii?Q?0bo0cHLbGSBSXFkRdjXrqHtJYOxthjlFp0QYBbpCbEuXxg3T1gf0uieiSUlL?=
 =?us-ascii?Q?+6HcjiZXPPRa3YDuzTY57z3w0esQp8xoYipXE3ciJsvTDuuJ7HaR36F5t0Rs?=
 =?us-ascii?Q?onD79bEAjpXS3nLvdCb3IxahZY/qKuR9vB44U+nIwP96EHsIsv4tDW7BGwDZ?=
 =?us-ascii?Q?sLsVdOALZMR2feZ36wXPfOsXPHfVvrGSfNAWaNPdlb0oIac8B1KeDhkMU0eu?=
 =?us-ascii?Q?XBhxHXiTM6aOgl2brALeb4Bc+bUC6EQu7Zd98N+QnW1Nu+zBRtG+XCw+jJiE?=
 =?us-ascii?Q?PIIZIL7EHVqYdYwNEfB3hqAtM+JTKezmQJKo8vRyCXTNGntjhVXMQF3CVIOe?=
 =?us-ascii?Q?o7RswXFw33PEDGGhcHtBbzO/kpQmGBmo4xtGoD6P5eiIBIsWPbCOY0L5vjo6?=
 =?us-ascii?Q?CcO5y/EXD67hyhHfgHK9isgSoSEMjgKnhF4AsdkmEO54IiVnEZHne5ZFteT4?=
 =?us-ascii?Q?yixUqKoFPEj9YpfCB3RtAY4zCFUVxK0HDlvhRFAhMpT/p0HnQS6fv2xbqJTP?=
 =?us-ascii?Q?lGxyhLsJSt7LcfdE+PXedOo8S3Y+vhaEcdNCDHI6oIzcMaaiskMvwOt0Z7iD?=
 =?us-ascii?Q?7AvjCfyTItjOJzF6ggwClB6yMzCAJJlUjxZUevhDQCxeO69J1tdn8G8hNC2x?=
 =?us-ascii?Q?P6zKLWkgNd3bgoytuHcRYR+YMmeUirThC1140VRi+5BrY1RDLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:48.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ac636d-4ac6-4975-b0a1-08dcf870be12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545

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
index 02ccb4d2955d..11cba9f35945 100644
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
index 8ab59d59c15a..add8e84b483e 100644
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
index 185ac210d46e..3996f7528b66 100644
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
index a4b92476f501..811b477f7710 100644
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


