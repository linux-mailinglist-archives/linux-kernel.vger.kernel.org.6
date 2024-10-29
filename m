Return-Path: <linux-kernel+bounces-387852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035D9B56E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17CBB22E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339D20C301;
	Tue, 29 Oct 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D1Kk6oTh"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5920C021;
	Tue, 29 Oct 2024 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244343; cv=fail; b=MdcfBA1+DdRDTj+pa+q3ShwWg5/iEolma0c0fHgGe9zHIZD+CW3LkVija+6HHY65nHOlFHRNRxaxl9FVD9qkf2UkJkmGZN9MOzWleBqOedILlX8QP0SG6S0zghTRYBN0Rbj2yKiBE1cL/W1AUzslkjN1JhDjpm0sy5+mFuSEKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244343; c=relaxed/simple;
	bh=LSt8nN0uTVbg99E+3w6E8o041GcbB1wKqieDFoqp1y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7WHrQrVxfOgjafG6khaym7iDGDITNJgbJ5X1rRaEl301lkUMaTJ2sSK9lVQtT85m3IWhE5e1Uvzc4Toe5PQfZ7bEVum0cdizXIF4n+XOotpyGcfEnKOWuLWbIzaPnuxbe3GJSwnLRd1puGt/oO1pGHC3trlYiDj8nuqCGN5+nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D1Kk6oTh; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBKgOi+NYxvOu05GJ53pQViZEcMNE9sMvSxWlyP1fWGY5tIQ6aNB9DOBE2TRpcGZVqNjI9FsyaAuISqibkAuNeqKEfYJRlC76twk+oemQwSZdXQIfghxa89q/qHs4FS+mM6WoN5J3WH6WKoWmAR9oo3vNDzACo875IPrBvxp1GdzqzH4Gfp+swJUY3dTatD++rEScbc54TQxA/4ORGt459M7MyBKr3SJcB+8hMSIzd/fx1OAxafeXgsdGpY3yKBuMCyzh1Yl+YcHYC/X/IpivAgBpT0VMkSyPs+zDpbPd7JUQZ8oNd8WiOzKaSJzi606OAFXpeOcAE+LCvrGFmERGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOtoiGQDo3pa7mdmg9cD7sIP1t3VoH957KV4U35TJbs=;
 b=UreqH8jkIJt8m5Yb6Dbu9o3x5Js6cviEYfFjDcFsAbF1gVtXsvDCDPQyFhd/FALCf6YRYWYI9N44C3ML/AXPJqwWf9yPD9Ejtml+IhLaRvBNKBsior2yvsMsnnkhOlqctXVIezzTyiAFEIAS5PcxAU+Y2TuqvVpy0jaShdalMRMkVU5j0XFSyLrONQbKavsOEauRrt59VhCDApLNZNcuUZd3DX2g/PjEF8Tdv9qsVkHanKO2FVFgndquxBOotDUFCMfTjcEewN0/a7BIzFIqgci3WKSvRUiEJGIFBunCNgnq+MUALiVNT0duZeaoKKsVf0zArT3u02dyb/cqxPO/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOtoiGQDo3pa7mdmg9cD7sIP1t3VoH957KV4U35TJbs=;
 b=D1Kk6oThDVVIgmx8GeF9b3bzBkKskWQlOVZjsVk6JWleY25UhZWkPUU6ZOfxzKkWW/Z9My3fIFXE/mT2ZttcOhBa6RQDGcTgMuQfAxYxqeeK2PZgtbmWNZ+2w/cdEtNcfnaWH/FIcxyxIi7o4CwegrGE0G75Wew/BfRReZd2k+g=
Received: from SA9PR13CA0112.namprd13.prod.outlook.com (2603:10b6:806:24::27)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:25:37 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::c8) by SA9PR13CA0112.outlook.office365.com
 (2603:10b6:806:24::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Tue, 29 Oct 2024 23:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:25:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:25:29 -0500
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
Subject: [PATCH v9 24/26] x86/resctrl: Update assignments on event configuration changes
Date: Tue, 29 Oct 2024 18:21:56 -0500
Message-ID: <89e98891f50d1d57c1cf8bc18c1f562ac58d2cce.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e1a7ff-eb11-424c-b0ff-08dcf870fefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykuf1LqseT0iBWdGKGqM2dvIN8lOie8/ruq9BmKijLdZ1bH4OUil8FyFgk+h?=
 =?us-ascii?Q?z8aZBSnr6XtMixFJ3XRiqCIkKrjCXjrQ48LMZoq30iZE+iq9iP8EbaArYnt4?=
 =?us-ascii?Q?qyYLGXA0F39LFMkO2CRapStKXADbQwmIcSoDIWwY840gT3IJS3A2kJVx/VPF?=
 =?us-ascii?Q?qjusooj3o9eFLDeIl2fEqsgW7/9eODVe3cfGULUjHZRoHb5DniiUq6ieUNcW?=
 =?us-ascii?Q?eV0X8C5raCvLVNtcTBxYjETwS7WnUKtl1ULbsFT/NVkCn2rUseqPPGtx9S2d?=
 =?us-ascii?Q?QyvGPfndFQOIbeOJIzWIVZ08DmT/sT+6KfWcSnKYrdftIoEiLnxjthWck1us?=
 =?us-ascii?Q?YHj9KvIIJLv5lYFt/OqYZButloUCqMIJI2WRGKUzTiOzr+2ZeILEDxRkiW8h?=
 =?us-ascii?Q?tE+Z4n1Is6nrMv9PoyrmyIqWrnjGsKasqjl8T3OVw0p1+N0ma6FqrhwsPDBZ?=
 =?us-ascii?Q?iflKKv+atREFwgocuAJOgB7jqzJUdSGoSXc40P/MY6rzPT0v7aFJTdyMVmxJ?=
 =?us-ascii?Q?ZZaw9pxnseAeB9c+Gyh4TO1W1qCNiVq/mIoIRFELJRzQabZyJo+/ezZCcalR?=
 =?us-ascii?Q?ja+5gmdS4TDM+sQIcHmpDgguiOMBPKt9SfL8fpiOXwXrSFnj+VVwPJ+SK0mF?=
 =?us-ascii?Q?EeL9OimovAfyoIJX+YUkqg22HCAvpIMvHIY8m6GmWibt/esdSM8cjecL1fV4?=
 =?us-ascii?Q?TrOhyHUL36Xo6gz9oo6uWOciVNau5Ocnm/AX/LjKWyXo3mVOzX9T1vDjzcg7?=
 =?us-ascii?Q?/We+h3gX8gqi9u5JUsWdD+IFrYJJ9G5U+DG41OBpEdimgo67DwJQfSzN1uDD?=
 =?us-ascii?Q?0BoOSUYZryJ0Zl3yAmTF3w2+hvPrEIPfwt9CYLm60pMdDkXY2bitcyMIJI7s?=
 =?us-ascii?Q?LGqWfG898E2nsMUbTk3GM4b7B+C/nieLfpbdD8ydoLfpVUpr7rCftzh0e7nU?=
 =?us-ascii?Q?7uWfrPDN1P65v1o4xM1LqK/bNCJb6yH8ZmInuL1exJg+prUbfqcF5loXF8lG?=
 =?us-ascii?Q?71+XSi2Ffy77580FaojqiCTsRML9lNWBYT6PpQ/L6RZd7FL0lhFWpS7FcZ8A?=
 =?us-ascii?Q?4YW4y2iO3yo5LlKvvnc5NVsm/8yqnTMsGmpUVupaHXvppobAuCwW/oxXeVHi?=
 =?us-ascii?Q?n3BUBXBaEX5lj09LJr0r+3U4YzotM9Z3HUVGNtRwXg0crJs/+AAOI3Ty74Li?=
 =?us-ascii?Q?v3UOgE6RJPWCp+ljE/ZhvSJAHHIJpAAn+D4hmZ/TtmUGhBD/KI8Q+fcq2lGA?=
 =?us-ascii?Q?6QlsqRBWqNmralrBi8CGZiMb3mPeEVOhVGfWSdc7O3dv/b0o39w4b4yfMdCj?=
 =?us-ascii?Q?p7MYDsW3ysqocfkGi9FPqKdVTRnLbufh+jojQyBLpppCDfyNDFisSxFRxXTV?=
 =?us-ascii?Q?FCYJhGZgNGrdnqL0WAdgk26ySplZFHzQ2o1EzYPfin39ezJYNZcQSFC6w4yO?=
 =?us-ascii?Q?PlQADK0bLb8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:25:37.6985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e1a7ff-eb11-424c-b0ff-08dcf870fefc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

Users can modify the configuration of assignable events. Whenever the
event configuration is updated, MBM assignments must be revised across
all monitor groups within the impacted domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Again patch changed completely based on the comment.
    https://lore.kernel.org/lkml/03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com/
    Introduced resctrl_mon_event_config_set to handle IPI.
    But sending another IPI inside IPI causes problem. Kernel reports SMP
    warning. So, introduced resctrl_arch_update_cntr() to send the command directly.

v8: Patch changed completely.
    Updated the assignment on same IPI as the event is updated.
    Could not do the way we discussed in the thread.
    https://lore.kernel.org/lkml/f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com/
    Needed to figure out event type to update the configuration.

v7: New patch to update the assignments. Missed it earlier.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 +++++++++++++++++++++++---
 include/linux/resctrl.h                |  3 +-
 2 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5b8bb8bd913c..7646d67ea10e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1710,6 +1710,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 }
 
 struct mon_config_info {
+	struct rdt_resource *r;
 	struct rdt_mon_domain *d;
 	u32 evtid;
 	u32 mon_config;
@@ -1735,26 +1736,28 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
 	return INVALID_CONFIG_VALUE;
 }
 
-void resctrl_arch_mon_event_config_set(void *info)
+void resctrl_arch_mon_event_config_set(struct rdt_mon_domain *d,
+				       enum resctrl_event_id eventid, u32 val)
 {
-	struct mon_config_info *mon_info = info;
 	struct rdt_hw_mon_domain *hw_dom;
 	unsigned int index;
 
-	index = mon_event_config_index_get(mon_info->evtid);
+	index = mon_event_config_index_get(eventid);
 	if (index == INVALID_CONFIG_INDEX)
 		return;
 
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, val, 0);
 
-	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
+	hw_dom = resctrl_to_arch_mon_dom(d);
 
-	switch (mon_info->evtid) {
+	switch (eventid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		hw_dom->mbm_total_cfg = mon_info->mon_config;
+		hw_dom->mbm_total_cfg = val;
 		break;
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		hw_dom->mbm_local_cfg = mon_info->mon_config;
+		hw_dom->mbm_local_cfg = val;
+		break;
+	default:
 		break;
 	}
 }
@@ -1826,6 +1829,70 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static struct rdtgroup *rdtgroup_find_grp_by_cntr_id_index(int cntr_id, unsigned int index)
+{
+	struct rdtgroup *prgrp, *crgrp;
+
+	/* Check if the cntr_id is associated to the event type updated */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		if (prgrp->mon.cntr_id[index] == cntr_id)
+			return prgrp;
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (crgrp->mon.cntr_id[index] == cntr_id)
+				return crgrp;
+		}
+	}
+
+	return NULL;
+}
+
+static void resctrl_arch_update_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				     enum resctrl_event_id evtid, u32 rmid,
+				     u32 closid, u32 cntr_id, u32 val)
+{
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = 1;
+	abmc_cfg.split.cntr_id = cntr_id;
+	abmc_cfg.split.bw_src = rmid;
+	abmc_cfg.split.bw_type = val;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
+}
+
+static void resctrl_mon_event_config_set(void *info)
+{
+	struct mon_config_info *mon_info = info;
+	struct rdt_mon_domain *d = mon_info->d;
+	struct rdt_resource *r = mon_info->r;
+	struct rdtgroup *rdtgrp;
+	unsigned int index;
+	u32 cntr_id;
+
+	resctrl_arch_mon_event_config_set(d, mon_info->evtid, mon_info->mon_config);
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	index = mon_event_config_index_get(mon_info->evtid);
+	if (index == INVALID_CONFIG_INDEX)
+		return;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (test_bit(cntr_id, d->mbm_cntr_map)) {
+			rdtgrp = rdtgroup_find_grp_by_cntr_id_index(cntr_id, index);
+			if (rdtgrp)
+				resctrl_arch_update_cntr(mon_info->r, d,
+							 mon_info->evtid,
+							 rdtgrp->mon.rmid,
+							 rdtgrp->closid,
+							 cntr_id,
+							 mon_info->mon_config);
+		}
+	}
+}
 
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_mon_domain *d, u32 evtid, u32 val)
@@ -1841,6 +1908,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	if (config_val == INVALID_CONFIG_VALUE || config_val == val)
 		return;
 
+	mon_info.r = r;
 	mon_info.d = d;
 	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
@@ -1852,7 +1920,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
 	smp_call_function_any(&d->hdr.cpu_mask,
-			      resctrl_arch_mon_event_config_set,
+			      resctrl_mon_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0b8eeb8afc68..4dc858d7aa10 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -356,7 +356,8 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
-void resctrl_arch_mon_event_config_set(void *info);
+void resctrl_arch_mon_event_config_set(struct rdt_mon_domain *d,
+				       enum resctrl_event_id eventid, u32 val);
 u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
 				      enum resctrl_event_id eventid);
 
-- 
2.34.1


