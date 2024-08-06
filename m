Return-Path: <linux-kernel+bounces-276993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7281E949AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286BB28103C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5A517A582;
	Tue,  6 Aug 2024 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8Jf6gTI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80C176228;
	Tue,  6 Aug 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981756; cv=fail; b=MRWubd7sAwc6pgCgfZQQTbtHWHrU1VOS20SJgF06ZksBbEgkdXQyM1FKF7PFIN4K/LlLtYEVjyWKiJ32G5wrdZEaCiZG0tS9TTfFBombsVyjPouPgWRvwQEGUD9K0OtW9pwNH/6kVsbeLJ2NSQU0nLFArFoSe8lk+wWYGvoD3NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981756; c=relaxed/simple;
	bh=8GzP7MBOWnqTs0R7AXNf0NGaUSrA+v5aLKHcLUM435o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THTTpOJ2xHFZ5EX5hgDAF00odMSXwR6wBZspdsfOJje71q8FmT62KgsKUW2Gc5deUhRYTZYLQLY02eCTX79t6B7XVImi+0kz41Mvkve371NthVbzu6PiV6Bh94MqEM253MAfA1AUjwqSavepSn64DgHgdboH5DW7v+74GgqNBF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g8Jf6gTI; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZcCawZw8Fl3Jh/BrTSq5LaqyBSi0B4alTfVHhYXoIksGvPHOjDGwBwgXKlf8A/+nDvr1WcjQlM6OKlPylNswy1LHtO06IZe0njCQmp+TPdH13QX87hXoS9DgTSoFeTfkuSuaBw59ShzVop2dww/AZ9bXsFbnUcEeevjRM6aE3OPjMbJalzuXTz65JYNZ8xy4xR2HAfsNYwr5lT8EqAL8rf02BJEEHs5ZnzjA2XuBp2uy/pc1kDJAg7Mb0re1qSYEjWSsN/HM9a9oaOGdzc7HF36G47ksIeCxacW4o6Sk+2heeIu7d7xnHIFErTGVlb8OF8Z4DkDgw/wcjPs9RlrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMvi706/mQ9DRdcroxYPFTGH4CV7PENdEuiH2OhsJ0M=;
 b=bA0cwvRuPEI+owRTzIkJfeQfX4glWrnDeAzQBdtEIQ69MD5RF9GccUVUjhJ9pM69agP8G/H7Lp/s2XBcYryH3UF09AVKipSOJFfIafy+41G/WCHZ005x7yqcqW6QRkKhK4j5o1Aa3qvNHe7wfiU48FTmDfA9Nb4qjLl19QLf7uXmkIZZGFlzWpHLhVpN65pVrEWhiJ+MFGW7FZRV+nxy9yBvImpStmZ7e4PLX7ay+UobcFhZg4mZyY9mPz9RpJwcWr0DuF+fmp+b0YNGLWyRuEcwUjrqfZycETCGwBWwxG9pAZgPSqcYdsVoR6SyVZ3dXMmhJxfMfXm7S5OlBQ1NPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMvi706/mQ9DRdcroxYPFTGH4CV7PENdEuiH2OhsJ0M=;
 b=g8Jf6gTI3+FALgC80an4oX0C0ANgeJW/RB/V4z+o4UZUgUT7qidDY2UHRMhBYZ5OS/MdgozoY2d7njT5gUdMfL6Yh00+G74b07FWrJXLkC2a3A1kK1YLkIXCZD9tnrt2u50rxabDwAq23XmNy1w1AcMH6uzHA7MliOYDIGIRUOA=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Tue, 6 Aug
 2024 22:02:31 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::f7) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:29 -0500
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
Subject: [PATCH v6 11/22] x86/resctrl: Remove MSR reading of event configuration value
Date: Tue, 6 Aug 2024 17:00:48 -0500
Message-ID: <ce8ca46651c5488dff19ed59ba7c50009c90ac67.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dba7810-fc8d-418f-9434-08dcb66377d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZSJyA+U6fKF1chmOKAmvamYT8rnYulWSY4CC4MUfmm3jQOLVrjqEAixo5Bo?=
 =?us-ascii?Q?pMSlaXQ4VMR7EFqhsrT8yoXCbR6WccBMUbYEJQhFqyzCt9D3nO+EG6ryyPAl?=
 =?us-ascii?Q?Kt/4cpjL8FlcVE0aCZT6xf1Ab3CFYKdTLPyXZ3PmLDUdzfyJDLlfSXTIAkb7?=
 =?us-ascii?Q?byxlbb1O6xtEpC6fXbh0ZQcTAFfN9exUlsiSZ1vly8K/vOmDCkFqYF9Lj0dt?=
 =?us-ascii?Q?Y9cKVh+aCUhxbm5fLvOlxCYToRfm5i/3fvPQxNxDNTzSj3u8hKy8zL5DQFPI?=
 =?us-ascii?Q?ohgkB5RO3jiHUWU97asSL2NcEa27Rlts5oskkJguYykyRKWmzjs0YZTuqh/Y?=
 =?us-ascii?Q?qsbXX+cO3I9JDaQHOrfbB1M9WfCBQZq1QeAyhCi+1by5kaxpasGt4wDsgTLF?=
 =?us-ascii?Q?svpyHARA8HDO/rs3tmO7OcMBPlxwYrXLpyWSMbu+rvz6OwfPrVc09HnY4VcH?=
 =?us-ascii?Q?LgvY1j/OxzVcSLm0l6nVbPt9PK5pV7eoEm3NIxj+GpuAjHzZd+UI4LSK6opq?=
 =?us-ascii?Q?ceqAFnICrmOzLDWYrYlSSmhJ6Lu3pOLoJf2FPxNG57G2euOZtLSjdhFOrWUk?=
 =?us-ascii?Q?b4ONM8wo/o/aoYPdDXn4eZ7zRMYgKB9CHZDge6HXES/NRVYIuvp1fVuS6/9n?=
 =?us-ascii?Q?tO0rVgh5UAm84sqex6xFEHdsxhvNqdgOaU0eS6WDBXvj5dRYjZyCuC1S6hgC?=
 =?us-ascii?Q?9+l2QDOhDeQsap1DJswtags755V6lL2kcfZ6ZwE8sJHH5GF5X4Z6mEnYaI7B?=
 =?us-ascii?Q?oJ8gxeKq8Jycj89LDgJzsdAmGhhYzJ2RWAE4vZvO+B77zEiiN6HQ9n9am3EA?=
 =?us-ascii?Q?+kMbwLLvQ+TvB5OXRGmanE9MorXFONfDtOAee+elQ+uF7Gi+gJHmbPWtp3fV?=
 =?us-ascii?Q?s9YWbyieQnHgW3eTle5XSQOpRIBiSUi8X1p+ZYuKYx2XGeZn2x1xfssVi5Ub?=
 =?us-ascii?Q?ZnlnIcznfavWiUnF5OwH/hNoemS5zr9QAKuvNYqEZUVnvtjmh0GAQKSuaS0F?=
 =?us-ascii?Q?85N7hiH3eegSu55mwkV+dDQ2r30iEsO9QqqCrvZjYabOEMlWhoO6t+ygqtUb?=
 =?us-ascii?Q?eJnZI4zafIqKu4GO/IJrC0YMrr+x8GOaDlkSleMfEMA2cmj4f3SoLaYAwPEC?=
 =?us-ascii?Q?0USpk21H1XbmfLdeULb/QhN2B2bxE9rXr0fDD+7nEEcejzvN4/toHiuloJSO?=
 =?us-ascii?Q?0qaaKohTV/Z749lumaJsnnYAQQ4sLjoI1VkWfRCwwRAbZnPkjdR6hZNTHfE1?=
 =?us-ascii?Q?YPFuZYm6FKiY5xej1QVBjuua9Eo3oXMd48T3VqcwPaeL+hQ9UPXzTOOcypRk?=
 =?us-ascii?Q?gHxFfeWpwZeZZTc7hGninDCxbYzV3XpWyEOsUmK5B4xSKSjND/42qYfAeMEE?=
 =?us-ascii?Q?nGlWwckLs2g0u3thJmYuo46kUAU4QJ5pBVciieVcy+o5c8InPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:30.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dba7810-fc8d-418f-9434-08dcb66377d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

The event configuration is domain specific and initialized during domain
initialization. The values is stored in rdt_hw_mon_domain.

It is not required to read the configuration register every time user asks
for it. Use the value stored in rdt_hw_mon_domain instead.

Introduce resctrl_arch_event_config_get() and
resctrl_arch_event_config_set() to get/set architecture domain specific
mbm_total_cfg/mbm_local_cfg values. Also, remove unused config value
definitions.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/internal.h |  21 -----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 104 ++++++++++++++-----------
 include/linux/resctrl.h                |   4 +
 3 files changed, 64 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4d8cc36a8d79..1021227d8c7e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -32,27 +32,6 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
-/* Reads to Local DRAM Memory */
-#define READS_TO_LOCAL_MEM		BIT(0)
-
-/* Reads to Remote DRAM Memory */
-#define READS_TO_REMOTE_MEM		BIT(1)
-
-/* Non-Temporal Writes to Local Memory */
-#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
-
-/* Non-Temporal Writes to Remote Memory */
-#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
-
-/* Reads to Local Memory the system identifies as "Slow Memory" */
-#define READS_TO_LOCAL_S_MEM		BIT(4)
-
-/* Reads to Remote Memory the system identifies as "Slow Memory" */
-#define READS_TO_REMOTE_S_MEM		BIT(5)
-
-/* Dirty Victims to All Types of Memory */
-#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
-
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 02afd3442876..0047b4eb0ff5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1605,10 +1605,57 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
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
@@ -1631,33 +1678,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
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
@@ -1666,11 +1691,11 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
-		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
+		val = resctrl_arch_event_config_get(dom, evtid);
+		if (val == INVALID_CONFIG_VALUE)
+			break;
 
-		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
+		seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
@@ -1701,33 +1726,23 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
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
@@ -1736,7 +1751,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->hdr.cpu_mask,
+			      resctrl_arch_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 72c498deeb5e..ef08f75191f2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -350,6 +350,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
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


