Return-Path: <linux-kernel+bounces-387840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFE9B56C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8752EB21207
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284B20C01D;
	Tue, 29 Oct 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VKZx90VD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022D20C008;
	Tue, 29 Oct 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244238; cv=fail; b=gQ3IuBbR0t3ahM1yBpqZg3MGEoDa8j7NAqsXBZuDi6NERlCOGIansvIGSs/x/b8Bee2HwNTyYYJzSC/bfWydZI8iiuPE/gJ1OSD1SMkRKk2vZEU6dfYvMblpI4sAbwdTNuu9WtWwS5kxrwZEClJruMsZdYShgjMKcNeURjAJmYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244238; c=relaxed/simple;
	bh=D5yaCKTll/trq2ZYQR7HCB4Qd1qrqFEP3YYYQ/2YA7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cty9HPxyqxaZ7K6LkXIvTi8uDtTeUf268XHALXy2BX/Athgsnet7z9zE6Dg/pJXE3QcR9p6LS5C4Afhrl6ll3KGar5Qp3x4QOnjar5sy9bjNET4uiX+D0hgSklH3NO6DYDIKZz0rEHr8n0EIoueG00sehWq9kigc6Bz6LorTe1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VKZx90VD; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5jn/nhIC4+2pQ4/GEMIigvlBv/jMW1ySzOV7hLToqOWfhPVysJctufRT3cX1ywmQjMtVJo8WbeTZViOCuHu6CBcHaTXaKskzUfSV7RR7Jv2XosqA0j+TFg8GHWNR0siRpN7l3kDn60KnPaVnKqLvOVbUbWdtZjjSBhqd03Hn5KwXJ7T2e78Wnb/fGz5yMUUgGhO9RIs85L6HjeNGsBAr+Iije1YiUdtm1evAtE5GcXmP2lKH9Q3pu915K9SLfskKBCwJvcqzw2wpkUmitAIiM/cNrPx0LmnU0ixWen3CYxGx8MFp0s6D5UvJbxUnd2jI1eXd7klOuj0582jkHYvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmB33JBfsU1aHxkGxbTudq+cV1CS5o3rY0NIf7+f1qU=;
 b=owYG7a0/RARMz/bzzQDav4PN94NHV2K3jUsgsb7iHQm7V+DlOjodJ5NkMjPQ9AiLy3im1z6wwVA9xh3XSShkZZcPEvC/gWrAxtQy2x+6tRURTEM80YSxKkbKMyZDgw4qPYA18iu9NExdwQ52lrxfCHh9ab8yIo8BY0NxWf1fSYCpUKGAGlz2mTMziyPV21zEcq0ANd9jUE91I6Pj5rnDJB2qPUG/NnnOscSPXcNsXHeDwHs+5sgzDo1AZ7G34CDSdAy5w5UzOpYCu5MTwhNo5qqPtFrefL0mUUPVICrEX0NtrSFBzyf+FXNbU8XgWQco/QFcCJvhhEjB0hJ1G0WMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmB33JBfsU1aHxkGxbTudq+cV1CS5o3rY0NIf7+f1qU=;
 b=VKZx90VDL/DKf1iOcpOtdJ2ZNlA1C5w8VY+RBYXZUgfGoJ3JNIiKLISfhnP+N8txMhT/2BVc+o/JbqhsJn15Y6CZXbNLVH8mZ3D9UC/BdqUzGEnPra7qxmrboXZ14CdwTydtt06fgr2+8ZYWtwjs0GL8bHWvnam4r/yRUwWYcuI=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Tue, 29 Oct
 2024 23:23:53 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::f3) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:49 -0500
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
Subject: [PATCH v9 12/26] x86/resctrl: Remove MSR reading of event configuration value
Date: Tue, 29 Oct 2024 18:21:44 -0500
Message-ID: <3180058bd0b5f80f8525063698c6d5971165193a.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c07e1ab-dd78-44c1-6c86-08dcf870c0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bx5F3cMS7bPqSe3zcjTrNQ1kjXi4Tqs/NgHP7iR70lWlfBerrKCCUxl1fyzi?=
 =?us-ascii?Q?smPTYjIjMG7VKiu7ZXWlLqYVYvAFEqU/ZpPogsr6BhknRgvVQ8LqpXyxN5X1?=
 =?us-ascii?Q?0EsQr0P3wj6xtvfEsNXjwfDkWiq+FYBivQyx5l3nkO4OmHqitCwsQm/tYrMq?=
 =?us-ascii?Q?tVNucKU3hnXaMYbWSUfDtJRKUqeWDQrqEhydR7vjTxj6Vrgo0Dnqptp0660D?=
 =?us-ascii?Q?dFufaOkNEgEB9O9fq1yC0yBvKnSAPnPfssiiZU9zFvrV78/LexetQoJBSmWs?=
 =?us-ascii?Q?pCvDrmfM+JhXUf6LZsJAXjhdgdOIjuXcynKi47G68KjvbwXmC+njftwYm5zL?=
 =?us-ascii?Q?/Dk0urJf4kjxy4wnXX+/ys32F0qZnDJ6+xbqJR3zArD4yFfvCeqzMx3Ol4kC?=
 =?us-ascii?Q?JXl1FsdPV0CnYBhNsfWz+y1hBu8+qjcLsubZNkZ5VnOXn0q+djkRDmYXTqpZ?=
 =?us-ascii?Q?UVqhPe2jNst2XVqprYx+pjMt+fvzvjXRtJrparo3+xGtlcniUDNOWDRQW5NT?=
 =?us-ascii?Q?5DV/D+U9nIdzHDz1DIeAFlbukLwsNiLZa4kFTGIAxZxx4ivGNRJPV+7JXf8Q?=
 =?us-ascii?Q?LCbl4bFGmJ5X6A4normpmsGIWX6RLA7yBKPstPWK5OalC8KTFMimDW+H/5yR?=
 =?us-ascii?Q?4w9eUceOxV7ddAW7C1wa0FWuApXjDQ3YfVsYurNujUEuv22rkZ0jmOCwC0jf?=
 =?us-ascii?Q?a599RPEW9HLr2tUnhNvMUVRpcwrcQpjHg/aWiLSexxNOu+b9c3y2r3feTwnM?=
 =?us-ascii?Q?d4xyIOjEDnPbNEqsG+osIrv5uus0njr7F99aVxwLIFPFiVGW7/jPPJ7DgTr7?=
 =?us-ascii?Q?AUCMDu89IlO7FwfOEXAwY5pE0TNzOnLScGcugFSRnWco/wCsfBVD8OeI8jSw?=
 =?us-ascii?Q?1drUY2KSyFZ/paF9qG2/KmpUcm6dbUc92Jkg80lM5nraEPSkyuerpV+hBh7E?=
 =?us-ascii?Q?YDJWdzCJZlbE1/Dcg8W9LhQQtHNbJ3sq+gKC7nLJBfrYUIHQ0pnCURU3necs?=
 =?us-ascii?Q?C/T9IoYT2TifcSYwuiuT91iTbKxgwl7zbzMqP2nz9tA59FVjOfiWdeoWDSmA?=
 =?us-ascii?Q?E+YHKeftQfdz5IXgQ66kZ+EesCh7aJYc0uUz2SNfQdw53jpN9KZZsw9SWB1A?=
 =?us-ascii?Q?jDDgyevLF+1zz5oFoE7NtDtBdIBCXwfEedA9xchHfIEFkh4BesCtcDPlpzNZ?=
 =?us-ascii?Q?/cA4UDenz0Il+FcHoEEa8Bwt1W1+syBOdKTgWHxPzUEodjDv8CPW+7fIdEAr?=
 =?us-ascii?Q?Z5+frv+uqo812C8w/xkkEolJ0630200Qn2/3bC5PbGXyYZi6gecO0ygkDHpK?=
 =?us-ascii?Q?+hIiCWS++c/8UYFEddcnWS/2YMCfBkLx9xNX+t7WjSCSYfez4EShiUYcUVij?=
 =?us-ascii?Q?VnJv/eeeQvTkpxA1hRvszPyk3YK07tzJ8SJN7ZX2+3aGmhHrhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:53.2127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c07e1ab-dd78-44c1-6c86-08dcf870c0b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

The event configuration is domain specific and initialized during domain
initialization. The values are stored in struct rdt_hw_mon_domain.

It is not required to read the configuration register every time user asks
for it. Use the value stored in struct rdt_hw_mon_domain instead.

Introduce resctrl_arch_mon_event_config_get() and
resctrl_arch_mon_event_config_set() to get/set architecture domain specific
mbm_total_cfg/mbm_local_cfg values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Removed QOS_L3_OCCUP_EVENT_ID switch case in resctrl_arch_mon_event_config_set.
    Fixed a unnecessary space.

v8: Renamed
    resctrl_arch_event_config_get() to resctrl_arch_mon_event_config_get().
    resctrl_arch_event_config_set() to resctrl_arch_mon_event_config_set().

v7: Removed check if (val == INVALID_CONFIG_VALUE) as resctrl_arch_event_config_get
    already prints warning.
    Kept the Event config value definitions as is.

v6: Fixed inconstancy with types. Made all the types to u32 for config
    value.
    Removed few rdt_last_cmd_puts as it is not necessary.
    Removed unused config value definitions.
    Few more updates to commit message.

v5: Introduced resctrl_arch_event_config_get and
    resctrl_arch_event_config_get() based on our discussion.
    https://lore.kernel.org/lkml/68e861f9-245d-4496-a72e-46fc57d19c62@amd.com/

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 101 ++++++++++++++-----------
 include/linux/resctrl.h                |   4 +
 2 files changed, 60 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 811b477f7710..3a3d98e8ca28 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1597,10 +1597,55 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 }
 
 struct mon_config_info {
+	struct rdt_mon_domain *d;
 	u32 evtid;
 	u32 mon_config;
 };
 
+u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
+				      enum resctrl_event_id eventid)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		break;
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return hw_dom->mbm_total_cfg;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return hw_dom->mbm_local_cfg;
+	}
+
+	/* Never expect to get here */
+	WARN_ON_ONCE(1);
+
+	return INVALID_CONFIG_VALUE;
+}
+
+void resctrl_arch_mon_event_config_set(void *info)
+{
+	struct mon_config_info *mon_info = info;
+	struct rdt_hw_mon_domain *hw_dom;
+	unsigned int index;
+
+	index = mon_event_config_index_get(mon_info->evtid);
+	if (index == INVALID_CONFIG_INDEX)
+		return;
+
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
+
+	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
+
+	switch (mon_info->evtid) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		hw_dom->mbm_total_cfg = mon_info->mon_config;
+		break;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		hw_dom->mbm_local_cfg = mon_info->mon_config;
+		break;
+	}
+}
+
 /**
  * mon_event_config_index_get - get the hardware index for the
  *                              configurable event
@@ -1623,33 +1668,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
-static void mon_event_config_read(void *info)
-{
-	struct mon_config_info *mon_info = info;
-	unsigned int index;
-	u64 msrval;
-
-	index = mon_event_config_index_get(mon_info->evtid);
-	if (index == INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
-		return;
-	}
-	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
-
-	/* Report only the valid event configuration bits */
-	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
-}
-
-static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
-{
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
-}
-
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info;
 	struct rdt_mon_domain *dom;
 	bool sep = false;
+	u32 val;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
@@ -1658,11 +1681,8 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
-		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
-
-		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
+		val = resctrl_arch_mon_event_config_get(dom, evtid);
+		seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
@@ -1693,33 +1713,23 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void mon_event_config_write(void *info)
-{
-	struct mon_config_info *mon_info = info;
-	unsigned int index;
-
-	index = mon_event_config_index_get(mon_info->evtid);
-	if (index == INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
-		return;
-	}
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
-}
 
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_mon_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
+	u32 config_val;
 
 	/*
-	 * Read the current config value first. If both are the same then
+	 * Check the current config value first. If both are the same then
 	 * no need to write it again.
 	 */
-	mon_info.evtid = evtid;
-	mondata_config_read(d, &mon_info);
-	if (mon_info.mon_config == val)
+	config_val = resctrl_arch_mon_event_config_get(d, evtid);
+	if (config_val == INVALID_CONFIG_VALUE || config_val == val)
 		return;
 
+	mon_info.d = d;
+	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
 
 	/*
@@ -1728,7 +1738,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->hdr.cpu_mask,
+			      resctrl_arch_mon_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index afe3b22d3e60..70885a835acb 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -354,6 +354,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+void resctrl_arch_mon_event_config_set(void *info);
+u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
+				      enum resctrl_event_id eventid);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


