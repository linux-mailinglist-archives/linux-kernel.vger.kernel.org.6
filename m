Return-Path: <linux-kernel+bounces-188681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646EB8CE547
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824331C217AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC008662E;
	Fri, 24 May 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TfSylcsa"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4086277;
	Fri, 24 May 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553533; cv=fail; b=ZJN8d2njhT4v8U8kgPIzT/w1RLK49bOlCwuciSo3t0KHvwxot7v4HmgVHvzlsBzf9hy6C9aIE6KHFc6fcyDUJUkTBT0uzbzhHyNSrjigtMzwkWJIvnuT/PZCzyCa1ZWhsysaSAg+LY6TgnhrlDdLZVaHcWbrwAalfpaf+NDdVaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553533; c=relaxed/simple;
	bh=m4ZZP1wmPP7RtRzpHdVrAI1Ve15EefET1a6bgE4gBZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRLfnxtRBYL7LMg5nMZWTj5Nz1cT8unRJvsPCo5SHOUs1SI2I4n5pkHyBQMAAbeNEhNzIXYyEB8W2o26/6zm7D/EcH7xD+DcGXxIATN/5JGVLN49j2bcsbCPluSThEHe49TNKb7NXXIIeF5LN+ZQqWUAuQfDjBvEk+nmejC6+OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TfSylcsa; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UraLDhVsPd2dW+ksxeUiifLUlyUKRR+spabfZHETJBPaGCKDNghN0xDX17ASaqdhre/bc/vahdHrEn1yX9Bqv+h3nsCBSwWN0aPcHpMLtqnn40g+puEGttostrakcA+QDa5lxbf/sa9Mt5j11D4dhiN7CZSUEELZmdsVf3wR+vA3HqyFkHFxQFwweg8oBkH6juSUNEH512+o2lei69+fWJV7+K+R65RQXsDfcYNOj7LOHjEque4nqkfwzw5uQMPz9yIQuPDykvogqbNnFi+b1eFWBgg6BYDQp7sNeSOJzYkEnRbgLfaa/tBps5I7xqL+RJ8k5ssq9huyEN4HgIIxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQBtJU1EEzepbI8Nhl0Po3Rz4Ar+w8/Px1J9tygiaeg=;
 b=ZRhZerKhhoVlrLtM8StZyjuh+DNGGhv6tFlMGV+bXze+GXMTALBSJw+F7Kj2Owwb/DBx0KDC+fsmHZqfdHleNJ8u9BterJPxmml+AIdFK3rNdnlpkmIrfhmixNpSrjuWoSUs3IYPQFCvPMZY2EzD2e7sN1IARb0L+bK2fICw8yqUdYORqpboliX1SbHJZgQglzEUm4aL2/tyQgqB1SfcRidn5sBdomqqug9G+Yz/L+TGQYNbe1oHluHKXrAhBd85BvLUHyPZXY6ankDLMru/FyXYPJcLgsVUc0aTp4ZE8hKj0/a20OklxSeKM1ExfXgXpX/lhmmTsgga8b3s4MC9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQBtJU1EEzepbI8Nhl0Po3Rz4Ar+w8/Px1J9tygiaeg=;
 b=TfSylcsaATxB8QF1ez/OoEQGwQuBCfzC2/oDcQ/2AqlEDFFyMNcKaEo+RxUfGCFSpWgLabJio/Q49kfLzN4G10hMyiWYEyUPE81d/ai9WH426X6rID/5xlpSnlSTuqIWFfCS3nO+3eRF3WmPxVOtOBzGwn/aSX5Emyo/ZgHcv0o=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:25:27 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::72) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:24 -0500
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
Subject: [PATCH v4 12/19] x86/resctrl: Remove MSR reading of event configuration value
Date: Fri, 24 May 2024 07:23:31 -0500
Message-ID: <9b7593b8d4e06129fb087e75ce18e5acb47798d2.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: b477f1b7-6134-4b4b-2694-08dc7bec97af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ozTN4EajRBqgug17N/lS0rQuXnZisKVtdbcMEpSvNP2SFyq+WFPNrQiw5n9r?=
 =?us-ascii?Q?Owuj46y4w4wWa3p/KRZvE+ME1hBR7Ui3w1XTWOqmT7y41oEqCT8yY/ns139V?=
 =?us-ascii?Q?l8PztBz8kd32/yBLB79TTrR3+Fy7Tf39ISEdN2KOpf6gsCt7RZcW9WF0V6uK?=
 =?us-ascii?Q?aZuWwjcYwnBvdw8idwI0MTluavW7vPvaLwnEowKM/76iCaxcM8c7mlyjS/mK?=
 =?us-ascii?Q?txP8Qb07l8cGFCQbgz/8QglnanIo9QVPDmTOmiTP7HqoQLhEMSTUAYkM+mtb?=
 =?us-ascii?Q?CnNEzw+UDNNCbsfWirxHUe4wFMn66Bf8O70pqEnd0JgB8ue0zsi61tDSJBRQ?=
 =?us-ascii?Q?vK/N7Pe8yAStKb88ohfTDQvMNTdRdaEuBCkiRsP5EMtRReOWI2qP1gveDrpa?=
 =?us-ascii?Q?JeRj1T2QzoEeS2oucG9kgTn9qLaSGDgF7S/hrLJYEM9Z9vLy3xqXxshqFjDt?=
 =?us-ascii?Q?mWLI41Iv1Y4cNQhOjm/Jd/+dFjQJAbPaQd5WLtR8WFEtjkWAkwWjRarNr5g1?=
 =?us-ascii?Q?NoGeMO5zy/1eyskobbqhNTOqH32x0xm3nO31Jfa32Ea0FbN43V/5FChLYp3M?=
 =?us-ascii?Q?2bDmJ90LlMkSpZWhVyHrXrD1WiEyvhdogYq0lhqpa5yxALFEpGzm5eggH+n8?=
 =?us-ascii?Q?dzYWRVDkpG5InCvj2JANtiJDQhHSc2ILsuTKZkL2uZqkb6jJZDIGWtH+6M1+?=
 =?us-ascii?Q?Bj8PVt6rrBVBt+PkGOM4JJBfx/cSMUlZt5ZDx4Bzs6hrW7+wT3t4XMnaoujK?=
 =?us-ascii?Q?TJquVObKtJGqFwYft/PMcQAK4Az2QIqzCUDE5mk0EG39eqxmhX4ZPUz83NGs?=
 =?us-ascii?Q?qz8E/TIM4LZvj9818FLx0MZeiUIS+Bj8WcRB3hid7tFZCC3oTCfjuzT09afv?=
 =?us-ascii?Q?f6Fimh3RRIx93X3B+4zkqciI05KFVurvNoa+DLIUpHNK+YmZkDM0dKU2fJi1?=
 =?us-ascii?Q?98v6KHRQlyok/sMnS2AU+s/bKwzcdAIOmGG5G6pAzPLm/NJIH8JSmZHtqUza?=
 =?us-ascii?Q?X3xOGS7Fv+v/fiV2MXNoUmMRQ6+NGQW30yU7UNjDXmkmxFc2PShOkcQiUXUg?=
 =?us-ascii?Q?rfzSNXD+iNnMVbJ0pZ1A4Focc3JTaM3ShWGkqqC37SkFqdQi65hV5AhKrjFi?=
 =?us-ascii?Q?Rj0I/qIMgAq4wdpU9PT5qdxJQUt54snbK3TFtZHu1JcMF79Ww1utuTcFaT5a?=
 =?us-ascii?Q?LaI3bA75iGTwyShEw5AgVafchBck22HWvcnp5gC9fLPkdS4P4FqOS1eWDpe4?=
 =?us-ascii?Q?kbTyErwyndy9/NbmhQ09G2xQ+oYsqRZ0ZL+P7GTunH5f1CQHuEF7EirTfDma?=
 =?us-ascii?Q?Z32ua2+9Xy/ltmIfT+irgpvHq5zCdvQ4yDiIOySwNhR7aJr6OC6SeqAjquit?=
 =?us-ascii?Q?hggZ1h5v/zAQe1EMtizCZzCFevbN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:26.5385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b477f1b7-6134-4b4b-2694-08dc7bec97af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

The event configuration is domain specific and initialized during domain
initialization. It is not required to read the configuration register
every time user asks for it. Use the value stored in rdt_hw_domain instead.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++--------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c176bacf7ba1..0e425c91fa46 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1618,46 +1618,30 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
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
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
-{
-	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
-}
-
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
 	struct rdt_domain *dom;
 	bool sep = false;
+	u32 val;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	list_for_each_entry(dom, &r->domains, list) {
+		struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
-		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
+		if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+			val = hw_dom->mbm_total_cfg;
+		} else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
+			val = hw_dom->mbm_local_cfg;
+		} else {
+			pr_warn_once("Invalid event id %d\n", evtid);
+			break;
+		}
 
-		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
+		seq_printf(s, "%d=0x%02x", dom->id, val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
@@ -1704,17 +1688,28 @@ static void mon_event_config_write(void *info)
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct mon_config_info mon_info = {0};
 
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
 	 */
-	mon_info.evtid = evtid;
-	mondata_config_read(d, &mon_info);
-	if (mon_info.mon_config == val)
+	switch (evtid) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		if (val == hw_dom->mbm_total_cfg)
+			return;
+		break;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		if (val == hw_dom->mbm_local_cfg)
+			return;
+		break;
+	default:
+		pr_warn_once("Invalid event id %d\n", evtid);
 		return;
+	}
 
+	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
 
 	/*
-- 
2.34.1


