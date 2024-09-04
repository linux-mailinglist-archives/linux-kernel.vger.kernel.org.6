Return-Path: <linux-kernel+bounces-316040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECB96CA47
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6C41F288A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5F18A6B0;
	Wed,  4 Sep 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EuYQ3v8g"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF415189B8A;
	Wed,  4 Sep 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488603; cv=fail; b=kkHKpyIeqDR9Ai5Nh9OCBfQ2FPo4v9BJkGOnOHC7o0XGA/G0zwV3HN1fcdC0AV9c6HFQb+V+LHpAoqPFDFNVpCfVbw3dekwMUhQNuv71uHP9ESeEekNILadx+wuTxC+P5yiUEtl5hO2jK9qx6xZFKeoXG2taaz4lmptW1Y1y1nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488603; c=relaxed/simple;
	bh=XkL4cAFZnYtPpPBKllZkUmAVpJHf2EBp+6FWMWheKRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh7pcPP2c/nHpVmpyTGCqKaJGqPkkTQsPLC2ELeAzzv8UFlol+UN7SNOjSo/b7ecddhC67zVT0qyUG08PSrVEC2ke/Ab57E8VsVggdESACam7LHP2vaK11CabgbEPBRNUUuxs2f56YPluFzIJ3SKA0rGy2meABlq5ykXbIk3JAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EuYQ3v8g; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m21CS8Ozrl1rbXsJPn21bAiKgwZf26g1Ug+Vu1JEg9Ex5+DJwGX9klCGavoU5F0MXwNhZkVZ58NiznI7Plxp1CCH0kGkb2qfFQ2lRP8nCrYdD3Da2dCDPmpKr4a5DvZo9yQyEuHS1W0eQnCbrwIF6PFgsMtN8FwllNAmtzKExzYpkt0Tip7QZzE+ak5tBAw93CX9uZc1RwYr20tMNjQ0vi+SzR10Ogqjt1JZmPSuerxGB/2skkqHqm+aaLraCLbKIdmANjYMt9zonBdjFZ36BlPKsU3ArZwuEMKJa6WzBDIqAs8jtdorGjtsbdPfJFF5QY7+5JOPO3OyoEl6PvNUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHeEbwCikAIF4uX+n+LJ3tXvXhXb1BbIXce7CphsNQc=;
 b=G17B/UkMROmRXd+VKOgEdoPhkAC208Xt/7g1NauMitoUTpPNT/mNoUIwd3BBpCW+xRBVYgRZqMFQF407cCt7MAEXcuqqB9Do4eWbFR03An2L0NyDGBTP8lm1PdrXYROhND8HU4aUkVfbTaju367eaV9SDUBDbAYfQjwxtcKhkFwzVbLUl/rjdxExwy7xaAH8C47N1rWUB+MKJoL5yq2YCF5UZyIus475xV+Y6scCPXeb6GKb42PtMc7y0tPxy4/APYMOCUryxJLWNmPsPeQ/yz6uJTY0CzRABfRg2YEkICHPIqtM7vmTROX7Hmvi+zsUCkxO6BjA1wVFChPpJAQbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHeEbwCikAIF4uX+n+LJ3tXvXhXb1BbIXce7CphsNQc=;
 b=EuYQ3v8g5lXaqUOUN4zvr9XeGeN4+417YoVVFUABaZknazKicWwXTRJgrSCOESqh19BTsd2B02u3QX8oz8TNBJBriTtwvQeE+eESX3hYkBeaofR7efc8Iu/B0F9XI3vylvK3scjR0hLEizOitNQHkGcvpaWtjja5+V0ZbFHJMCA=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 22:23:18 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::b8) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:15 -0500
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
Subject: [PATCH v7 11/24] x86/resctrl: Remove MSR reading of event configuration value
Date: Wed, 4 Sep 2024 17:21:26 -0500
Message-ID: <dd3a5803de44391e7496649147d8fd03ebe52525.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de047dc-fbab-4344-a9da-08dccd302ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCtYwOidH8JCRntwHvRY6WoowexMED57/vNLiTNyqB4xunEyGfxdPEhO2UAU?=
 =?us-ascii?Q?2XatTCm52q0mCvUpFz3cK8AMZScmpQpEhGNWoE8N3yjEMQa2AyrV7xCNOXcT?=
 =?us-ascii?Q?lR2zCHSIu90P8XK/gMv/SfYErFrNBq2l5qW7NXZHVzx3CNFMd79vjbaTafUx?=
 =?us-ascii?Q?nWsoZhMe+T6gp7NvTKV44Cr31SK3mXb54epogbfmpYCVGM+xkAOs4DcinAT0?=
 =?us-ascii?Q?rQIhur9H84suRDa9C5dOLqzo7z37SW205tsIGEePcJvm/2L3E5Bk/BW45Eol?=
 =?us-ascii?Q?9YpG2tMa3c9Z0IAdobvT8heZnslnjfs0Taxvkb9jZJsiNqgu5Rv/0ya9WAa2?=
 =?us-ascii?Q?nUj7glG2oyxs4uNaQzDFc3zgntopwgDgNiHor/h5PNYnvdT1IZKjyYd8MS0Q?=
 =?us-ascii?Q?Gpds+Cr5555r7m/Lj/G2WMYj8tLu94VdZIr+wBcgkpdVuDyV1LP3FEpidQOo?=
 =?us-ascii?Q?91U7hFTZfjolij6Rgq0fcEc2ZR7JEMlksU3zk5ZsFRSuVpOU5w9ahd8xrEZW?=
 =?us-ascii?Q?OVsbpBWRd9nRrqT/AF6bBC+jpdFKpA/j8JH2WUnVyDihqR2SrIA7yfT9E0n/?=
 =?us-ascii?Q?InmftWl8theuFgWkd6bfoYowl1dX+Vua6Susd8qdJWEfNdqf/ME9a9UbO81j?=
 =?us-ascii?Q?BNF+dtiFaTKOSwmglQk9MgRE7WZZW8c0L0TB09NRoRAzZb9TEyCunA0qtJ4S?=
 =?us-ascii?Q?IcSiDR5eiiasDLiCnduQ7dJnlLLQj33fvfuGCjTDXkb7pN1J01x+anc9Uefe?=
 =?us-ascii?Q?rKcEFlGymE9ktbU2vPbSafjGUZrg2zpRPN+BITHid1HKTFCsRyn8Av3HShYg?=
 =?us-ascii?Q?7XCOCpRQ7g/4U74Ja10ECkJEgjVoRG9DwlxB1XNdmliFW/+TmCkd/GLx9C3a?=
 =?us-ascii?Q?XLrj1x91ODxHbGSNgGJLun1Ot9hGVWrJx9OnaT3eKggu+qaA6n7QW5DHtuCb?=
 =?us-ascii?Q?UBIeEomb8al1F9Yp7wb1/HpXATNKW+zTWK5kpmfUfz8V2PsjwIZvpXvZtfc7?=
 =?us-ascii?Q?2ugtCFBZUb5pvXvcCzAMl7pABrs1kxHLGFSx15GEnzC7PeByGWY/ngbLW/ji?=
 =?us-ascii?Q?aemWX8YIYyS9OlJXz9wUxaBw7tihC7+e/BWX3eHpTwgk5aRUNDhnBHe6HHMt?=
 =?us-ascii?Q?onN/OCuPPJQ3w3rdfNno0tEV5FKD9P6noN4GlJd6pzv4K7Vw2/8bWUKa9cwi?=
 =?us-ascii?Q?NoKYPww53JIK0yWahbFLny74HlButUMGA0nlqBWBJH5XdpEWJgUKcYtlEEvr?=
 =?us-ascii?Q?NoLOeqO0FQLPcEiaJTYzuKEeC9Jeoim/xjCyCTK+WdzEL/Hw5wdc4VPsMABY?=
 =?us-ascii?Q?btPX5oiHgt0wq85piZk6vLw8WUVOxMVAg0jHw5qkbUl9mNM6ELHykdGMf+qI?=
 =?us-ascii?Q?n8mRfITt6W9WdxFLVWTFTpxwjB2jsK64HSsiERAYo88rS4vCPqeBdWm2XcDl?=
 =?us-ascii?Q?Pzz3iH33aN4lFCFX9hwkr8xOOmz65TDR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:17.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de047dc-fbab-4344-a9da-08dccd302ce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

The event configuration is domain specific and initialized during domain
initialization. The values are stored in struct rdt_hw_mon_domain.

It is not required to read the configuration register every time user asks
for it. Use the value stored in struct rdt_hw_mon_domain instead.

Introduce resctrl_arch_event_config_get() and
resctrl_arch_event_config_set() to get/set architecture domain specific
mbm_total_cfg/mbm_local_cfg values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 103 ++++++++++++++-----------
 include/linux/resctrl.h                |   4 +
 2 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 299722b3fd90..cc101fbe8683 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1597,10 +1597,57 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 }
 
 struct mon_config_info {
+	struct rdt_mon_domain *d;
 	u32 evtid;
 	u32 mon_config;
 };
 
+u32 resctrl_arch_event_config_get(struct rdt_mon_domain *d,
+				  enum resctrl_event_id eventid)
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
+void resctrl_arch_event_config_set(void *info)
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
+	case QOS_L3_OCCUP_EVENT_ID:
+		break;
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		hw_dom->mbm_total_cfg = mon_info->mon_config;
+		break;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		hw_dom->mbm_local_cfg =  mon_info->mon_config;
+		break;
+	}
+}
+
 /**
  * mon_event_config_index_get - get the hardware index for the
  *                              configurable event
@@ -1623,33 +1670,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
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
-	struct mon_config_info mon_info = {0};
 	struct rdt_mon_domain *dom;
 	bool sep = false;
+	u32 val;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
@@ -1658,11 +1683,8 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
-		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
-
-		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
+		val = resctrl_arch_event_config_get(dom, evtid);
+		seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
@@ -1693,33 +1715,23 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
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
+	config_val = resctrl_arch_event_config_get(d, evtid);
+	if (config_val == INVALID_CONFIG_VALUE || config_val == val)
 		return;
 
+	mon_info.d = d;
+	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
 
 	/*
@@ -1728,7 +1740,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->hdr.cpu_mask,
+			      resctrl_arch_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index aab22ff8e0c1..757708cf5d3c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -354,6 +354,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+void resctrl_arch_event_config_set(void *info);
+u32 resctrl_arch_event_config_get(struct rdt_mon_domain *d,
+				  enum resctrl_event_id eventid);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


