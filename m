Return-Path: <linux-kernel+bounces-443902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A44A9EFD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F9D16A3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782601BD504;
	Thu, 12 Dec 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f6zXSZYm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4918C937;
	Thu, 12 Dec 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034750; cv=fail; b=Pc05IZdUvzhufg70PxTTNRgNDqP+zxp+OXK4n740RqKemKmyY4Bw+32f5aT85Gr15evLqrqdiAKyfJdKyLte7YjJw0sODPeRD9LB9BMioQM13O0i/eo0Cl9IklFi4ekNsWHXX7vVTzlSpsYIsExsnC5mCcf3eb03ojUHwjZR+Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034750; c=relaxed/simple;
	bh=hT9JyX1TUHotGV2HBvRBh9icsw16DUNBUaM2yMKgRJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtsEuYoHuH5vnXoCVrtbyAA8NbX7B7SxViW6w5m3Exvg12dVN9GgftdEoXOEdKC/bmoTteYcLpqA3YWO4DFvBkYwvFTf1tk48BC9R4SJ8vlJ+YoO0ODRX42JdwW2To7ciVzNiVwfXyFr2bjskia7R+jxCTF4j+iMRJe1YsiNBAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f6zXSZYm; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH4iOs6wXo2ZFaymanDY45g675pDu9MTCriLIbUWoztVpAwPcXGNqUbgFjyKq7YIPi+Ey591yJxIhB4JRyl/sTXZH1fCUVMcfwrCIQYtNkWUjvFd6FdNGk3ypMC8JN37hFpEWzdCPWsBEEqOlaiRWuIajFzZSpKy7CPtakQ7guSGXmnoEYQ9GLXFRdudfSVIr3Ax5pbhE/jfPxWmgn6AvQVIsgK2s/MlSLhxZ7JTx16xVfsRSJDTAzqrz3LfbNp+RogsnszXRWsYvE60DGoRSXkn+RtpurBUwIKnTcx+U38+Al2qsoNvLUukK0vDZeJcGlPRHZ0Xa8pa82fNvG3S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmtWOyvSY6oZ2M9u0PQ8Af64fs66ZyiOeWf/hrUMp3g=;
 b=nFavSdxBOs7CkCRgLJGoxb2bzDhYBuCHqhmNGisiWZLgB1+00ouxa98S86hjb/Y/L++COv/ZhoWBo6e9xODaSpQntf1jxaaaKzXaWs/P1TwCgeD0VopRq6geS7yYlWfvBK8WihMYo5VaNh2GOtH0hnRzk+ktGYXrti3xqaPIScb/mGF9rgiBc06Jg7f7cwgmaOemLmunJQ5RgcI6ut06Uvz7GdMlqdzpBuGYgLu3njJlLIQnxadG1+VmlLObQeGG40bPxccY/yzuXEQjVMTUJaIeuebNUWzPMGzSktrKIJ2Bo3MX8Wxh5o0ynUJBxJVJiapS60RzuA4VXI0z0QMfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmtWOyvSY6oZ2M9u0PQ8Af64fs66ZyiOeWf/hrUMp3g=;
 b=f6zXSZYmqlMr6UhU9QEwL19BGeFWSORpTF+ZiIlvS3SZ2X/VNxeHkIQFXRC0Ym3ImtZfwPLPbmRGlKmESxGgBWwvHjkUy4za+f5KxLzhCIsaoorjGpDg2TIZHB/b5iGPFDMZ5QABjXwvIf+28YvXit0Q8Zb9E5tgt/Nv1VmN8p4=
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:18:59 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::b9) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:57 -0600
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
Subject: [PATCH v10 22/24] x86/resctrl: Update assignments on event configuration changes
Date: Thu, 12 Dec 2024 14:15:25 -0600
Message-ID: <8c8ecf12622c649bd269052b9fcd436710446034.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb0431b-c2dd-4571-46f7-08dd1aea3630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6EM59JcN4XVNY575ZQm+dEKqjeO/0E+pVp/hVL4vAmdjnqL/l8ChWMM0q1C6?=
 =?us-ascii?Q?8EQAcQ+VMWveQU0p8D5uEREymcvel6iA0vwqZuaZQAnPaYlwG68Q6k7OLiGQ?=
 =?us-ascii?Q?AjjUHabK56CJoW6Q1BtLLs5BbWgdN32jMxbt4K0HZKyR1SCQZLtnW6qknUYz?=
 =?us-ascii?Q?6Q5GTyK8CMdUCE0Tj7HHNQOllFfUv2g6aVkdDAvB+NeJf8IcRDJZk63SKGBO?=
 =?us-ascii?Q?AvxSCaojuzp3YKIOB4P98T96WMg3mp3Xquvii9iXxmp9yBYDiFBdxLYAWCEK?=
 =?us-ascii?Q?IRFEZHDvNjGyPFzfA758wYodHqAa0kNXb0mTMQvBzQRUctM7co2SPzWq3rU1?=
 =?us-ascii?Q?Yvpr/b5/03KF6lgezoLZSgLUTUQOnQ/t3zLDZL/rTMMp9uQpYsGYkeKI6+qT?=
 =?us-ascii?Q?cYE0aGaus57vzvZkcmMuWZJEfxF7xldIAiFUA+B7snDFBK2+dZmh1sooDkoE?=
 =?us-ascii?Q?1UquGKFwH1ohbZ7ToBAw1yyXOqgDCgTlyX3O7ZVRlLIf9xh0HE7jGtSHGW6x?=
 =?us-ascii?Q?u/ErH2sm8ywNu7jN6soEAIfrlZyoCT0TZkW53G/2JFvhzJnZdFGuPJwISQ4E?=
 =?us-ascii?Q?SAPVNXcfo4H5OhRWmHhBKvl0qXAcC3QQxw+oPRcUaemiSwCSKHUxoEQ391ik?=
 =?us-ascii?Q?WzJNF+keXd5uX0b8WvaKxqHAr2TMmdAPfdfpKg8vjLdmws/tNQHOeck//5tB?=
 =?us-ascii?Q?GW9ceoXuJTRvQCeVbEEUeoSerkHYebMNG+MFy3TO3KVul2CZQ6RfoEKd14Tw?=
 =?us-ascii?Q?ha8HveVQXCJ77DS+/rKm/LpT6UYdWUigRHCQ/3BKINpJzyTqqJmnR3FU13at?=
 =?us-ascii?Q?oSrgg0+V4AFEl0VbANOqzujFafFRG5kTIGbILXCrLlmZBIni1ZlpaLTD51nK?=
 =?us-ascii?Q?/O2BmrA0mKcTjM/WAd7V9sx0X3PvM0fPv0k4VJXO6L7D8WmdDOLKoitPWmF9?=
 =?us-ascii?Q?OdyqN13TLYsrQRe4/DmvQcqoz8omwUQx4CMV5u5YedVGkB4SG+4SL3sHm96M?=
 =?us-ascii?Q?LnKaihg713U8/K/HzrpBx4bHWTmCtx0b8NfaDw71hbvZEcMAihKvb2ukwvhX?=
 =?us-ascii?Q?rzP+KMsRUUq5IBT5A1JE02zkDW3JkU/gX9rK3EGf4164Xlc0Ra0V8m+71L4b?=
 =?us-ascii?Q?4R+B99V1ySa67cQ06LR8x+hcJ+LhmdZScV936N2JS28BvLLjGhk1HKN4y7zn?=
 =?us-ascii?Q?nrXWep0kzrb3+yfOTtx7jsOXjtI8azRCBPEBYE6FEfDVgYZNJIQPjYRkcImj?=
 =?us-ascii?Q?iITKJTJrH3mrLevrEv+AR0L2f86ms5Y92gPFvLjFIp6pfVmfyftSzg01G/p9?=
 =?us-ascii?Q?5ghLGyEpJkh9eMD9GzLKZvj18vDxvbUG0eudj0Apyr2bRlEoZvX7sdZxTvhH?=
 =?us-ascii?Q?FDC4xMxqLxJe6fJlbP7dAFf/okr50g0pTdil+hlsuMrO6g6tW1gT0P2bjpwJ?=
 =?us-ascii?Q?GswBUFv3mskZTWraK6lyM+U6zZeiWCucl7nCj8I0ci5Bo4Mc/loHlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:58.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb0431b-c2dd-4571-46f7-08dd1aea3630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

Resctrl provides option to configure events by writing to the interfaces
/sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config or
/sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config when BMEC (Bandwidth
Monitoring Event Configuration) is supported.

Whenever the event configuration is updated, MBM assignments must be
revised across all monitor groups within the impacted domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Code changed completely with domain specific counter assignment.
     Rewrite the commit message.
     Added few more code comments.

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 67 ++++++++++++++++++++++----
 include/linux/resctrl.h                |  4 +-
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 65b3556978ad..6b5c886b7e99 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1704,26 +1704,26 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
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
 		break;
 	default:
 		break;
@@ -1825,6 +1825,54 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * Review the cntr_cfg domain configuration. If a matching assignment is found,
+ * update the counter assignment accordingly. This is within the IPI Context,
+ * so call resctrl_abmc_config_one_amd directly.
+ */
+static void resctrl_arch_update_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				     enum resctrl_event_id evtid, u32 val)
+{
+	struct cntr_config config;
+	struct rdtgroup *rdtgrp;
+	struct mbm_state *m;
+	u32 cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		rdtgrp = d->cntr_cfg[cntr_id].rdtgrp;
+		if (rdtgrp && d->cntr_cfg[cntr_id].evtid == evtid) {
+			memset(&config, 0, sizeof(struct cntr_config));
+			config.r = r;
+			config.d = d;
+			config.evtid = evtid;
+			config.rmid = rdtgrp->mon.rmid;
+			config.closid = rdtgrp->closid;
+			config.cntr_id = cntr_id;
+			config.val = val;
+			config.assign = 1;
+
+			resctrl_abmc_config_one_amd(&config);
+
+			m = get_mbm_state(d, rdtgrp->closid, rdtgrp->mon.rmid, evtid);
+			if (m)
+				memset(m, 0, sizeof(struct mbm_state));
+		}
+	}
+}
+
+static void resctrl_mon_event_config_set(void *info)
+{
+	struct mon_config_info *mon_info = info;
+	struct rdt_mon_domain *d = mon_info->d;
+	struct rdt_resource *r = mon_info->r;
+
+	resctrl_arch_mon_event_config_set(d, mon_info->evtid, mon_info->mon_config);
+
+	/* Check if assignments needs to be updated */
+	if (resctrl_arch_mbm_cntr_assign_enabled(r))
+		resctrl_arch_update_cntr(r, d, mon_info->evtid,
+					 mon_info->mon_config);
+}
 
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_mon_domain *d, u32 evtid, u32 val)
@@ -1840,6 +1888,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	if (config_val == INVALID_CONFIG_VALUE || config_val == val)
 		return;
 
+	mon_info.r = r;
 	mon_info.d = d;
 	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
@@ -1851,7 +1900,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
 	smp_call_function_any(&d->hdr.cpu_mask,
-			      resctrl_arch_mon_event_config_set,
+			      resctrl_mon_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 03c67d9156f3..2bf461179680 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -137,6 +137,7 @@ struct rdt_mon_domain {
  * @mon_config:		Event configuration value
  */
 struct mon_config_info {
+	struct rdt_resource *r;
 	struct rdt_mon_domain *d;
 	enum resctrl_event_id evtid;
 	u32 mon_config;
@@ -376,7 +377,8 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
-void resctrl_arch_mon_event_config_set(void *info);
+void resctrl_arch_mon_event_config_set(struct rdt_mon_domain *d,
+				       enum resctrl_event_id eventid, u32 val);
 u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
 				      enum resctrl_event_id eventid);
 
-- 
2.34.1


