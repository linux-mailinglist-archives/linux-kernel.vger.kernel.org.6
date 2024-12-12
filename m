Return-Path: <linux-kernel+bounces-443891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECC9EFD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AC3188FD1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1831917D6;
	Thu, 12 Dec 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L6A6U+qK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E11C9B62;
	Thu, 12 Dec 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034663; cv=fail; b=rzVeo3AyLdq6/0OsjaXGOMnURFWnaqetbshT3Gp89np28BZAdlLrYgFP/GpZ0+IbkzI8c+ws71Uo7UnU7JTm/5t5zX2G3sjBuxlQ8XT3KjVlq7bw2XaLWhj/QBzjlnp34IEGKeH2b2pwWpA+9mmao0GxPlRZ3Xx9wiptbRSAAC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034663; c=relaxed/simple;
	bh=qusnw720zy+uS6oKhYWlEPMmgCv2ME0rj+7EbML9Szg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUntOtps+v0MDIZm3rDS8bGOwkCH0vrhpWaXQxMoubUvhaKA6Aq6Po9efIRZHRSEGpA1S8NR6XNCCPuDubVIUXPVGeeJbi625epXVxIh3wn7BkP5BiuJTTAvNqk7kxhTiQHA/sh4XKCva788KQu5040vBqxAmBnuvYO+EQ1LSGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L6A6U+qK; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=To0R1MV3kllbNrgb1/Q7CKGYye85qTSFZdG10IoAmjkswvr2Nt6ZKVELFHhzOdjziZBAoRIsRtpAsHRDT6fLENDkWarbSPP4JwoBb73YhFkVKuKxnS+xDJutfSLyVoHfYRDLMDmiYaJLkZMYQnZoRLhMu6uyK/lhKr/x3S8QbgsFgSCImcAqsHkMQ7UZjfs+tfKIT85smQfHBazvNgnLaaInTGotC5/SzbLjcPU+NmFt1pEDn4oZwOXsSiNP/bTFNqzdgP1NqMI1YzZDmnwN/OHtk9+ohYu65GK4QurOYEYHhhc6BFP6wy+KhK4u3oWGnK1WXRBrBtHXn8C8O3/p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K2shUw2EkTztNcXzLdp6iD50BPJ27ibnexc+x1hk1M=;
 b=vPjpeaMcOso9fFzLFtbPSnjB7fbDwlYV8FndxFmeTqBsKvPwCOc60stie9bKoKjuD1tBWxt4khMhVjF48QNuYlLjOe+y5iIeAE2B0RovR71F70v1CfIV12T+d0QIFbexhBPmtAREZ+W9wxxmQXf/y2yuREC+IIuN6KKb1JCd8ug7ewFC4I41MjKtFZBzDos4DDGCTV1P5Lh4tO9O9GUb5ED+os1lf1DNRk1LTxH8neEXlBuRYuElD7EpmkWQpUov9MGNfI0H9CWJqh4B0eV07BEXcBrYDD7f/5vp0qHfuml07CwZ8vZtD9dFPO/yxnoy6asECHCGxCqY1fwauUI0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K2shUw2EkTztNcXzLdp6iD50BPJ27ibnexc+x1hk1M=;
 b=L6A6U+qKMd72IKwqCLHwmkc9Qn5l8Lt5m1PHTtBdnFsBnZZIdK1ydbsHprREFvWo9s6ROuyKG8i3WfEYOROluYCXvglXc7Io86aK4L8dzaFmxNNkEyAk0UYcuwvmVsRpNDdfZuC/6FdXQVZOoOmmLQdhnjLwv3WJRRRcbNlcbhM=
Received: from MN2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:208:a8::37)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:17:33 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::b5) by MN2PR12CA0024.outlook.office365.com
 (2603:10b6:208:a8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Thu,
 12 Dec 2024 20:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:31 -0600
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
Subject: [PATCH v10 11/24] x86/resctrl: Remove MSR reading of event configuration value
Date: Thu, 12 Dec 2024 14:15:14 -0600
Message-ID: <123e82c551444762300a483aa3fa687b70a0ba7f.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 769fcb8a-3e0e-40b3-af86-08dd1aea02c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNdeaEWWFelrATBJVhKT5dbpKONI4hLq3QJD5xrE5uotSPCZWQGeiRWD7CwZ?=
 =?us-ascii?Q?MaXyb4fcA2TvYPJ/97Mz52W/gzyTlwGNofhg+l/HFiyKlB2v/cPVv8sd2dnX?=
 =?us-ascii?Q?tUTHiJOGeANoaStOTKqCJ9IyReTdNlHNv1pfrj3vPNqnkNOYXFbL+S9Ay7Fn?=
 =?us-ascii?Q?2xlutrtwTbu32EQPpzbLIicUmnVpAfV4w8Wkz4O7ht8+fjaSvJP7AkRYmBy3?=
 =?us-ascii?Q?4Xz3OVzGuQJPL+fgrbY/KUKm/25tA2rBBCR25FT4qlfIjj41ig6Eh74BFbYn?=
 =?us-ascii?Q?Wj1Jsyuhw3LYeisIfQvDroKg3fA/TKzqfU57d0+Td9EjpzmqrnCPXwi8FSRu?=
 =?us-ascii?Q?q4CdgLjVGvS7op6hYu8BrGZPxVX67Z3nQ1w3qDwai0oz2eifz8vqwfVCt5jW?=
 =?us-ascii?Q?JKgTCkS1kLUPPIyLIu/kT5T7KqJYbVqyrlVjqUq4pyj5eBcOBehZ4AwWEDW1?=
 =?us-ascii?Q?sEUrHROdv0OzzPovFL8a43OGVZBD9Q/oc2bMjrBwW2ork0bXgi0AfzjxUDpX?=
 =?us-ascii?Q?BJNesaR98OUu6m6Dv6y5t89squdk6ctaHI6eyCSWSFZ1AvlgbwRj6p3SbDGD?=
 =?us-ascii?Q?x47keGMMNBa38ObndxI8nj5qmTsz1mPrM8bjuMU32MO7pVCbRVrE139V8jOG?=
 =?us-ascii?Q?rhW83KHVEDZwW9FWgFqzZ67bGOVEaPJur8vb3U238cf76OPDzUFOAN3fBKrT?=
 =?us-ascii?Q?SB2uXJ88Qk2AU6fRJOjfF93CV8xEOnuMbRooSnXyVw0KpCZw9c2uW0dSkU/r?=
 =?us-ascii?Q?OGwv+0JYNGGsKXgkofyUh4EgZfSKewmkypp33K35jQvlxoPDcOiWX1+i2n1G?=
 =?us-ascii?Q?1VJM5LwxCNcYSD3IEt2dti055DkB1Wi7zguHJm5S2sPgj2/w+9vJ36z5moQs?=
 =?us-ascii?Q?Crm+6ScfPrNd0mpx9el5bXbXJ1AUi5U0jHKgLW5j6qxR+SRSn4WeNlofOp75?=
 =?us-ascii?Q?UigvG5VFb3VQWSKum9bjk7FXZDl/n2a24wWnFMrGG3oxUQntR5jakEjQr+4W?=
 =?us-ascii?Q?En6C0lgOaLE5vb3Srud6EWPF/5y9GPjPrAzaFQktDVR7iAFiP9/QRr/agonc?=
 =?us-ascii?Q?GllFSKk/+AckHiOe4duNSUgYjxdbF5jePBF8vJp7GLzA4ssBvOd1RtBBdbzF?=
 =?us-ascii?Q?jDXS4lTrahj6ssUoP4EnNqrXZePfyKOywzHSIwAOIsTdjTDaIFuM0SRtDD56?=
 =?us-ascii?Q?W+2SbKJzZWYNqlg97A2JB5+9GvwZgm68LgeSdENUWaTeV9rjwQvpoP1YUh5E?=
 =?us-ascii?Q?aMr/NApQ4NG4wQkg224H0busHhbswoA0ENKcKAtYbfHZThxBvaQJaVw/y7Bn?=
 =?us-ascii?Q?uC2R6IaS91os0oLdOUtGx5TiWhe7x1/nzcE9U2vV9V3GtpbnrJCBK+5k+ITZ?=
 =?us-ascii?Q?QSVf3139ZjiRxKCPktPVGnRBv6CYPQnqFNYSFHUxW//nG9l69D5Hxi6WzCQh?=
 =?us-ascii?Q?sIIPxcMSmu6RHzbJHX4RiCjIl8wIiOk6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:32.7295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769fcb8a-3e0e-40b3-af86-08dd1aea02c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074

The event configuration is domain specific and initialized during domain
initialization. The values are stored in struct rdt_hw_mon_domain.

It is not required to read the configuration register every time user asks
for it. Use the value stored in struct rdt_hw_mon_domain instead.

Introduce resctrl_arch_mon_event_config_get() and
resctrl_arch_mon_event_config_set() to get/set architecture domain specific
mbm_total_cfg/mbm_local_cfg values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Moved the mon_config_info structure definition to resctrl.h.

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 105 +++++++++++++------------
 include/linux/resctrl.h                |  16 ++++
 2 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 541bd353c567..682f47e0beb1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1577,10 +1577,51 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	return ret;
 }
 
-struct mon_config_info {
-	u32 evtid;
-	u32 mon_config;
-};
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
+	default:
+		break;
+	}
+}
 
 /**
  * mon_event_config_index_get - get the hardware index for the
@@ -1604,33 +1645,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
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
@@ -1639,11 +1658,8 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
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
@@ -1674,33 +1690,23 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
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
@@ -1709,7 +1715,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->hdr.cpu_mask,
+			      resctrl_arch_mon_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f11d6fdfd977..c8ab3d7a0dab 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -118,6 +118,18 @@ struct rdt_mon_domain {
 	int				cqm_work_cpu;
 };
 
+/**
+ * struct mon_config_info - Monitoring event configuratiin details
+ * @d:			Domain for the event
+ * @evtid:		Event type
+ * @mon_config:		Event configuration value
+ */
+struct mon_config_info {
+	struct rdt_mon_domain *d;
+	enum resctrl_event_id evtid;
+	u32 mon_config;
+};
+
 /**
  * struct resctrl_cache - Cache allocation related data
  * @cbm_len:		Length of the cache bit mask
@@ -352,6 +364,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
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


