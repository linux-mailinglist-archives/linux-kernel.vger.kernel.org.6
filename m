Return-Path: <linux-kernel+bounces-276992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FAD949AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B511C216C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CB17995B;
	Tue,  6 Aug 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r5DUlnOL"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD1170A02;
	Tue,  6 Aug 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981750; cv=fail; b=PdFgPH8NyDPDRUJljt8sNq0UpVRLqL3o5Y8h0w/X066ku/g+5qmnaVsw3T6M7lU5SV0+xQhgf3fwbl2VJJGwYidabqB+UXG9GgouPDEPqGzyXCdp1yR+2R92rtcMaRTQ9Ogx5vUeXc710Y/f9ZLZnZsufPGGH87wWRxYWzYtq28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981750; c=relaxed/simple;
	bh=CqU0znsNpN6csqO3ixeF6ajtoO1ymsXAdH46z8rAP50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hX2c7mHOwZDq4U5fRLGbgYA2QXkIX2YdcAbXWkjhRyFeEwpq4b5BPRfm6uEiIcUzLD6O2IKw6P5RLv7vudU5e8yCOWnaN0XmiVVbpKOJlXqE2q7YJbBIsuJXDfAHbbzHfJ/qJ56sB3hvegAC2A9xEBHvV85wz8nbrrquyIxCQ1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r5DUlnOL; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbNtvdRXdhsECh68dNRR+6vfEDsacTbtNjHbppQzBe6PFxP26a2MBetTVqcvfbU1qfxt+YuNGPCjOeLH3rdFjNDFwVMy7Dyq00/+wk5DR8z06Iw8TyzPajPaWTLoatQoXmD8C1c4IBcmp0Z4AO4J63By4WeSQ7NtLGLsMVMGLlJ2tifzHClqSKfDCc6LBQbP29ZMfkPK29Fz9wPNWa+iGfYNbPWtHynfY36PPttLTWgTDqYTony0QZUkcDBkH35ULeq0hZ2G9fez4EH2IUKgDmyrGCZ/kaj6bgCbOSyHeznHN0hPXe6U0782EbhMCDP3CsZ+OeUXWFHB7h6hRCeguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iubdRcBETQPHWR+Rf5QBUk/M26q58CDUzx8ej1IkuI=;
 b=nblAL/rC/gEbpSgSvVP+MJEqZaKJ9n5JZ3yMYr1Xnz9S4xogFlEKoRA02o3LKdWkVEPq3qyMd+4iBU9XzKDlsjoKS11r1kFA6ljbQxqu5Ia7obCq1mSYJv4aqQ/1Ts4J8QV7Wte1EqcAmuRN8DiVHSzY7UC/BiYIT3XzTc9r4Ckfm7nR1bzPMBTz4T7Hxi5TAAgiL5GDY4+/Q698Woj7qxRhtFvbBsXvYakGgTMM3m/NpgplZuq2QtaZZAgDkYBqkTHEp99ugSsulmdrelkEPFYmz5rOer2ds+49a8kX4zULrSRYoKr19xIJdbqeQqzk45VYBhgRR84fRMyu2QwmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iubdRcBETQPHWR+Rf5QBUk/M26q58CDUzx8ej1IkuI=;
 b=r5DUlnOLex7lVyusUJb43pS9TZozm8vuZ3/H2Vd60zDpQIWO+O0jrLntYtSgPfEGQbuN+vP2p4y1THD3KWeER6Ww8zTAjrJ9yUyN+7/G3R7vTATLuFjeLeYnatzVLxum0HLsAdXGVwnlB9koG5GiE2EsL6JIdh3hYsEOXfgfCMs=
Received: from SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) by BL3PR12MB6523.namprd12.prod.outlook.com
 (2603:10b6:208:3bf::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 22:02:25 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::3f) by SN6PR2101CA0008.outlook.office365.com
 (2603:10b6:805:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:21 -0500
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
Subject: [PATCH v6 10/22] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
Date: Tue, 6 Aug 2024 17:00:47 -0500
Message-ID: <9f014a567d8b5a5c47a4e4438eae3de7f2633302.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e6e254-f48e-42e0-8c7f-08dcb6637464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wnxauMwbQZNSj4QVchsMFbX01GjrGW18HFsFsAkvkK8Rr6CRJjlSqZPmmdrr?=
 =?us-ascii?Q?2PyR7TB9upBECMzB6+Ub2wZbkxUTTyKpsYuMXo5jai3r+AJEvNnoqs8e8r1m?=
 =?us-ascii?Q?yi3Z0zycy3f8K9zqwLNWX1GIAjgvdIukn1jJzY6V99glkWNYN6hPc3pE/ViR?=
 =?us-ascii?Q?qbhizmBOsn49mY+utcGeEyuSGPcqWyNIzY2hVvzSG/pGW29jhCkIoJu1LmQ5?=
 =?us-ascii?Q?YpZnseQwov9HGkJOGmvFn5X+H/egOe41l+kX+6yR8F9qijfrKMk8WkPboWnw?=
 =?us-ascii?Q?miFHtlTl35f8YS8bv5LUKpiaovKcUFtOe4Lp12q6zgJR/CEuOucFocPFGnta?=
 =?us-ascii?Q?4Z1WsVZHx42rszgLZDYBrD7gRicBaralHaccbJMqGqpb5PhSFAmXlJJJxmM9?=
 =?us-ascii?Q?rXW8LebZOkNmtSIAzqAsHTyMDU0QU5RpJR+5D+EsjTpi486hShtkilurcbaU?=
 =?us-ascii?Q?snRmMZr1KB0rGXptrdc1ylEOzx7TRUZij8jUZvBURlKS/gA8LfPPZyQuoKDw?=
 =?us-ascii?Q?/yGabtWCOzLiikvCv1cKraHgy72fowzGVUQTqEIHxFigdvFkNxqbnpWjdMTD?=
 =?us-ascii?Q?U7CBCYlm0YOQj8rBAF77rYj1Irs0eFuk9UKHZK0Gz8RsevsVSCwyDV4Raj38?=
 =?us-ascii?Q?CTtsnzrY1ZF814VTXCYB3GRrFNZAsy5nWH0RI/BzNKmmOlCTMzgU60lzRQqg?=
 =?us-ascii?Q?p45yoCRQkVoew3nkH9yi8o0b5hcqAnfCpza+v2i2Y0w+dnJkZON0cYtENoYu?=
 =?us-ascii?Q?a/A5tCiLvN1MQfrPzLa7Y8DRdAWmL/y0k7UAuVnPRtYytNzk69gbDctnpdi/?=
 =?us-ascii?Q?yXC2bFzacTAwnYyXcIUTT103mXnyyhWAjscANjd9ZmoggEltxGm6SZoHBl5C?=
 =?us-ascii?Q?6m1pQ7aT3ZyFiZyQaIRdUIdcRIKpexOHxHI52gqXatlV4gtsZ0QivZFE03Vt?=
 =?us-ascii?Q?ZQONJyPqAWHykRkA4Eap0QZ1ZeSmizJGu21070z7HkNCFWC2OeONSVevLIcp?=
 =?us-ascii?Q?IT26B7VAf4aaVaLaClor6ReGujDER2U/0no2enRmqZ5XtoIEp/btOOVNgJld?=
 =?us-ascii?Q?v941sGBpzDGU4MIv+aSCrwogwQ0dbl3zTWS5v6kHeXUXNo/o1ohUwwCJnMxC?=
 =?us-ascii?Q?NFN13CtEeGkFjVFcian6mgBJoakNVpimd9DjNz6IbiH47IerR0lhCevQ5MaE?=
 =?us-ascii?Q?mcvL1f4GJU+lvcLHncmiETYhdNBvBBbNZXEMJAQ1Y3Z7bTvGRgiwSzS5hepq?=
 =?us-ascii?Q?l6AVZ/TrfbtViMD7c9SQuoBCx0GN2l11K6yFFEaZq9yB1hjuQ3jlxB7NGha5?=
 =?us-ascii?Q?cLy704CNy0YaDwpW/dFC21uZAnvHKK1ctFWaRjdbPyue5ANnmgNCWii/mAG4?=
 =?us-ascii?Q?q8fXz8HO5b2+0IyIv2sDZbMv1nqoId0s5RbTzPmmG9ud1e9CL4+Vk4dYE/vq?=
 =?us-ascii?Q?4FBCZ5HqI/U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:24.9750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e6e254-f48e-42e0-8c7f-08dcb6637464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific
events. The event configuration is domain specific. ABMC (Assignable
Bandwidth Monitoring Counters) feature needs event configuration
information to assign hardware counter to an RMID. Event configurations
are not stored in resctrl but instead always read from or written to
hardware directly when prompted by user space.

Read the event configuration from the hardware during the domain
initialization. Save the configuration information in rdt_hw_mon_domain,
so it can be used for counter assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index ff5cb693b396..6fb0cfdb5529 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -619,6 +619,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
+	resctrl_mbm_evt_config_init(hw_dom);
+
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6263362496a3..4d8cc36a8d79 100644
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
@@ -664,6 +671,8 @@ void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(u32 cntr_id);
+void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
+unsigned int mon_event_config_index_get(u32 evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 83329cefebf7..2f4d0c12b80d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1254,6 +1254,32 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
+		hw_dom->mbm_total_cfg = INVALID_CONFIG_VALUE;
+	}
+}
+
 void __exit rdt_put_mon_l3_config(void)
 {
 	dom_data_exit();
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c818965e36c9..02afd3442876 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1609,8 +1609,6 @@ struct mon_config_info {
 	u32 mon_config;
 };
 
-#define INVALID_CONFIG_INDEX   UINT_MAX
-
 /**
  * mon_event_config_index_get - get the hardware index for the
  *                              configurable event
@@ -1620,7 +1618,7 @@ struct mon_config_info {
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


