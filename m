Return-Path: <linux-kernel+bounces-357620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F5997361
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB8C1F263BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2D1E0DC4;
	Wed,  9 Oct 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JIASC446"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B71E2600;
	Wed,  9 Oct 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495709; cv=fail; b=i8X06Uy7caWeKK/962LpK7LSFQU4Uns3C89mhCYwuwegpW1vn/m9l81u6J7f8JaA8kpmd78DQM5ocZUnX4OA/7cnRP3fA6dxxDaz5rDCX4HikrXClWGKmyFm8giutJsMhhBaw7Y8wHLfdHbZ/zBzbGHHcNsq5bFRByNw70tmOsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495709; c=relaxed/simple;
	bh=gRkDJ60P/GURFcnmnwiTefLjJ4L1TEV3bsofpWvLOho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG85JGHkdo+/kL//aSGTrRaOUy73Cq50BkJV332x4vvOqFHhBvW9DB/uKsmSk+sCr8Lklf1FP0Z4addNpJPDIukueAvOvTeNz974MKiEQORIEiyvdSijNkJ/VAY1Dn0kBzKnk7uAiG+OzwvR34e1hpjdeXvBtuO4IlNE/4kg/LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JIASC446; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V07L+isiLTyoSTWsNL9b3YCVXHmsEqU4EsstYRXp0lyVpWK7e/KIkgNIfs0rKnnV3H+8IyZ7BfB/HkTaH7stJlBLElw3l4qnQEXLeWhMSBbsPrhlN4pgjGgkdpKgWpb17PFd5xQlqiY54yFxw7DsnbJF085aDcArU5xBRF4n516ei3XzLdRywQ2PhJm/+XL0O1crr0acB8cT7mQn+EJuBODonE7Yj5tQaVhp+0T7wd8pXC+U3fwe/aJakugx7Wam41owvKoy9T4RkwnymNI9BaHbf8mZ/9d8+FJF57yKVvV5gAOlwfu7z9JmC1sz8WE8oQfYCmALfRmWTVtYfjSBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld1L2Ge2/Ngx2WYMtEfcs9zxiBrl0TgLL8XDprynbds=;
 b=rMd0WK2hf8Xn5jsBshUFVbJj5bhPx9rJElBQ1JpGt8oJGEe9jgg6h+LSUGOWrob+D1ObJdubuRBXUzT/foSf7yFbkxIkQRebZudLFjhs1crP0KD6u2RG4uKwQnz9mpqw+f3OXUwrtjcN1e2OAfciJdW7U3gwl2/kQUySINyDHf2SEKdV4+MUoIiWUB1UO5EPrjeaNKut67evHV3iXWOouyqqd4Un/LdW2BhkZqycvn0DB49CNHaiu+NpnRuFNprROt9Uh11M1Te8g97osz8aQBk71342JNXOD/z3iaTHGXB9D5pKxqA0g3HtwrAFTLreMtycO1HXfJSbS/zlYW+r4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld1L2Ge2/Ngx2WYMtEfcs9zxiBrl0TgLL8XDprynbds=;
 b=JIASC446dpzyOmz0xf1UKw6V5zST/w3bKZMrSKYNzg8Fwird2TbpIeiHeUgAAgQubiRnCigEn0zTyq4fysk24NPx0aU+nHOTW4igbd4Kko//znt1FzFDM5t1sOgxcARjF+zTmxUtKGO9KFrn6WjBV6omoomewoFEueSlpfTKIk8=
Received: from SJ0PR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:332::20)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:41:42 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::df) by SJ0PR05CA0075.outlook.office365.com
 (2603:10b6:a03:332::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:38 -0500
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
Subject: [PATCH v8 12/25] x86/resctrl: Remove MSR reading of event configuration value
Date: Wed, 9 Oct 2024 12:39:37 -0500
Message-ID: <d6e298e9ccbf04207cb352b4f3c9f90613547b52.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: e14f62bc-a386-4fb6-4d80-08dce889a203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zo6A4XfH1WuxbW4pOp/eRz3kRXtFW87vc52v8q95q6pGh+fguvJ87nOV+1+A?=
 =?us-ascii?Q?/1ihiH2vRwtPzUqOlVsOCe+kKrFRgOHbGr5GFdm7pJTnh1vhEcyX8cYl6p35?=
 =?us-ascii?Q?gZTNQ/wJrG6yoDDtcOgEdZ2JugZh1WgiFb0Z+gx1Ue8clJLSrcv32VYg16iC?=
 =?us-ascii?Q?boF/qBe1z5NMVB1dKi6f3jLDqCUithZDzIXHtwUsTRKrofNhJc87/Xcmfn/C?=
 =?us-ascii?Q?RldaHDbtGUBK2+CQQwxaS8iciTtuaE7jEFySSvqxhdrSZExCee+VPLqg132+?=
 =?us-ascii?Q?GO8WpnfgtFZOdNH7Dx80QWq+nLP7p0QXyq1xhelca3xnsX/PZ1dOy+KvTneJ?=
 =?us-ascii?Q?whTkIP7gAElru02JNsqPMoi782cBePJZXvAPDLGqK6KccpGQD9rMGl+ukp/T?=
 =?us-ascii?Q?ltL3yWqsP/yEt26uNF0zS5U+Md6G7Oh8Mkbb8LQ9Y+9ZMDhCAAsAUKlkqQqC?=
 =?us-ascii?Q?YgXUmeZ3PVLPO7iAiLWMJ6aApYNEs+va9SoIfkZGRGhPuHR/RHd9TRjWgiXT?=
 =?us-ascii?Q?v1qootDME5w0ooquvZdg5c+4ncdZR2H0vFWUSTAvld3ktiq4l9MBsk6RrL72?=
 =?us-ascii?Q?9gZzmsK0Vzc6FDDr/eAf9O23eQmszn45+JZlPSZRggS/69M3ZaROHPiOCjYN?=
 =?us-ascii?Q?05Oi5BAa2aH+dYbbc8daPaT0ZlPTc0lBb2aQ2H/oHE1knERwMlN+NX7+NkTL?=
 =?us-ascii?Q?vj9KysUjcRUiTmkK0OE47kciksKcIKVHEzsFGPo1MjWYbb2lsvCQ3riz32WP?=
 =?us-ascii?Q?SKCCZfQIrZPsz8mtJ2jwEg0bBVRZep3UQeAJUUD19K3ritQoYRZrog91iXTb?=
 =?us-ascii?Q?g3md9ynwiETKadAX0RwgNdGOmgBoceWrsySmyMEqSeOm+a5nnS82h+bu3tPO?=
 =?us-ascii?Q?V3VDOeyyvCJcHe6gLTa7daJ7daIzw9QtVVY3Dn3R0iGU5eNSar0CURgAUn6g?=
 =?us-ascii?Q?JP8j5Poq5tTlyNqUslCnSPRlzzUeH2ZaUEumW9v49NNI+KXv/EhvmBaT8yu8?=
 =?us-ascii?Q?1eJhhNhszjhgnVBwPtH270QoD8hggSE+EiMnJldQSQrRSFTDLbJCeX6C+y3P?=
 =?us-ascii?Q?8a44B3R0LDDENSevnhaUscSYMIJFCrsS/JYp8cMTvLyWjOE3pIbNVO+b4IJT?=
 =?us-ascii?Q?ifPEnRd0bA/wVuMgi1XuT8ixmWaiY+1UvnxLLb9Jl1Jb2VDdyTOrBXhhl55C?=
 =?us-ascii?Q?LOa2kgBraMLm3i9RDG7DrvdcL8GuhYmdi8p508RJlsrSA46neB9/xZ7IJw0p?=
 =?us-ascii?Q?6fHSdC7MJUIUtr+DhiuVBdlCZwGXjK4CGw+tAidVCwwBq6UHgCO0Yt8Vl9Fe?=
 =?us-ascii?Q?4x2KxVDooGghLfMFHaql+QNWyyA0Q0daXE50e3Il3y43WDUP38wvgWOmb/KB?=
 =?us-ascii?Q?fhl9QCtduj91TSp8oCq9SfNOEFeV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:40.4650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e14f62bc-a386-4fb6-4d80-08dce889a203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

The event configuration is domain specific and initialized during domain
initialization. The values are stored in struct rdt_hw_mon_domain.

It is not required to read the configuration register every time user asks
for it. Use the value stored in struct rdt_hw_mon_domain instead.

Introduce resctrl_arch_mon_event_config_get() and
resctrl_arch_mon_event_config_set() to get/set architecture domain specific
mbm_total_cfg/mbm_local_cfg values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 103 ++++++++++++++-----------
 include/linux/resctrl.h                |   4 +
 2 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 91ffd9d24883..ba90e520150f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1597,10 +1597,57 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
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
+		val = resctrl_arch_mon_event_config_get(dom, evtid);
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
+	config_val = resctrl_arch_mon_event_config_get(d, evtid);
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
+			      resctrl_arch_mon_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5a4d6adec974..54eacc8a9d49 100644
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


