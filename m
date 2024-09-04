Return-Path: <linux-kernel+bounces-316045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC996CA56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2381C25524
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16518891B;
	Wed,  4 Sep 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IF+edS5Z"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA60179967;
	Wed,  4 Sep 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488641; cv=fail; b=KNC14of/485xzJzk//K8xy9yBFAz77NHB54JNafBFVKizk0c8AFzShYA+T/5/bYJ3vSt2P4ZbXQwBYRhm3iDhRoY359EHb5wOwLl51jWGysT7xcPQV/Lgqyafyut7/0ZZg33id0X+T6xnJzjKfHfDm4MbyKryFGe2nHSS4r8SDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488641; c=relaxed/simple;
	bh=3ErKUHKlKgWNx+Up8BDeinlLI5dVfcgwsPLDP5ieYIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KStaE3d8obun1ftTsqzrMUuwvB0gSBCLmjB/WyoTbfa7dv1LWq55PiMtfFZqQIjCnFN+/UXOtY/wfEO8aZma8rZoNBY2ciom2PI4nijuyjdRhSG21BJn9gmHr1s3xUrW4sDqo8EyrQGBrVpHRvgaA8fgczaqCPbL3OiPwbUfzXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IF+edS5Z; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQgp6d6zkykPfyErDTDmwCsNK3eoOU4QXXMosqhsmzr1dceWIScM0+n30j/+5c70OE5kbj6GQYyFMFDoI98WEx1iWxp3sjO4Wi+RJUKk4SBuFtTphDwJ7tZJNlFaspmHsFMkY20IJtl7RU+ESqNF8EH44WUivv8cP2izFsp+sfGyvzUG2jHnTolzE5dH4FPrkmOKBjq/MzC5+QjMMdUWciI5tMqu40MLPUgWqmO87VtIduCqrkROHo+brcgDkNfS2ZnQVOnAa1Iac7fCeuWDmcDqktvGhobhNMJ1rDIwwY8ilff+jPx6EbkvSO7kFEW35V0WjVg0n67+g4JIiY0hsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=759UPfKn/jtLTmTJL0TOR28KoSwbPv9HsOFrQVNS62I=;
 b=ZRYlWwFO1mG3G5Kps7V7KAcHAtFW3hCIfkCXJiUp2NuUsfQh6S14QOtyrrWVNgpIqHb7Hhrn/1P93LgJws96W+J5OVmi4NLadfTMrXPTRfaOmbENBvwNjhUlSJr23YlL9tW9EPxz/YKnP6mZpv58Do1366yZFbmZHGTUom0LR/DOegOMvcqX4QNG7Y/OTfh8B2oIi4fiEdjjFrY5tUzAXKbEIbOxCsHzLt86uT/YX63rIRaNuWb2YZa3AHPM6tUMCj23u8JtZrcFlRV33l/77/3dVkuLCxGYnoLe0ymM5G8zvJFDVoK+1aAEdssOyUIGcsReA+908XAAfeuDk+fcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=759UPfKn/jtLTmTJL0TOR28KoSwbPv9HsOFrQVNS62I=;
 b=IF+edS5Z3ji45DReY0TGTZ090SlZPv3SUqM7ZgP5TQJwFD3JaVZHaIeH+PXZwgqm22QKMH1u+0ym7DTvXYm95vK9e2UEb0YTmfA3SBLCqlkSMHsaQwfkHj9jyofJhPWb1WazKiGW0Z40UWvnMZe1cxOw/WHKEuKDjBJUfmOnqxs=
Received: from CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::20)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:23:55 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::ba) by CH5P223CA0011.outlook.office365.com
 (2603:10b6:610:1f3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:53 -0500
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
Subject: [PATCH v7 16/24] x86/resctrl: Add the interface to assign/update counter assignment
Date: Wed, 4 Sep 2024 17:21:31 -0500
Message-ID: <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6f4e3d-2c7e-4133-66a5-08dccd30438f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxuBNFNtxn0j7zQeIP8VScRlwmFquGTM0xaoK19TdM6CLMVbsh+n4NQ8oxcg?=
 =?us-ascii?Q?gkbdwpGfK20dxo8Dv3YpVzWxDJ8H1DsV/F5VzKphscgf8DO+EyVptwUadU5e?=
 =?us-ascii?Q?B5fqwM2O4WZYC9dd5fj1Nsd1YapGVVnv+sz78LoDsH0h27jQXEG7ADRtFQl6?=
 =?us-ascii?Q?qVd9JcvhWLLUC1VuoFogh15fZmcCsOZZL5OBuOqPFBExaRgFDujIavTID5FF?=
 =?us-ascii?Q?+k16x/eThP9874L1WJhSBeADDjfP4T0QTlOPEAYF/i+VhxccuXWZIz1QpswP?=
 =?us-ascii?Q?2KRJHmw7bc4gDj3g2k732j5Skl7HgeQzjDi3/Mf2pzufZVP9iu6W53rs4aGz?=
 =?us-ascii?Q?Cu2o3i713iEPgB3XiEL2n+tGO9lPj0dwfLfp30kJwZZ4OMWxDP0FwdEOhZt7?=
 =?us-ascii?Q?h0Z2tUHsqHa6OZzM/rUvn4AUtzq3L+mE7NpiWq8EFDIVkMY18GpCnGCSEh3m?=
 =?us-ascii?Q?NWfzoRIFxfKMvhGk/yym7QHO3UoY+H4uUwxaLIJTqKNYp82Zo++5F/7R4A2u?=
 =?us-ascii?Q?eOc2mgxY66xRVuQ+I3b31ydxY6/D5nxNGIRUCLfydJBUnT/fgSjzOTheYbde?=
 =?us-ascii?Q?3IpeTZTBtYI2T30TVAeHnQTTL8mpYpCtmX2viVs3l/txIJ5TtGNvIuurHNjY?=
 =?us-ascii?Q?JRqogh83BC34iF0zK8YXn9EJ9WToi0AIL9Wh7XYzjaPyt8QKamktLjgq7yCD?=
 =?us-ascii?Q?FNJA+3khyGtwuGuS7yspYlP1qnN7nkqSTDrlxpF7BIYrburKJCa36CXHuBSL?=
 =?us-ascii?Q?Mpmn9tjJAe8bgETHzlZ6sy9nn4QMrB9sdHrd5O62E1+YgyXpz11Re0ooL0LP?=
 =?us-ascii?Q?A4Y1/AZr6RMvhiT315AT73ls7yfmEoCiQUKjpVRJ1q4wGKz1LSdE5k/EjSLn?=
 =?us-ascii?Q?8zdUfstxg8UN00Wd0uszY97i1cPCwi9t1siFbf0sI6ztKIeYRJeiJEfqXwUb?=
 =?us-ascii?Q?Rphoac/8+SFci6RzEmKC13T+xCFnCA3D8Bb/JiwBKnrWj0NpNlkUlAkvGsCx?=
 =?us-ascii?Q?sN3Nr+YPG1rN+Nz+Y8nHDWPQDogV5MmE/e4i2DYiQR1hCMcyp5F7w5M3MvXr?=
 =?us-ascii?Q?qTB6NsDnIsXb/Hu7vRNgWyMVtyFn84eZCcNvjQ+WLKmo8jpeh65jOxiBjTZ1?=
 =?us-ascii?Q?XCvTZXfNVGbiAxyzok3xgnwJ26fbYPD8jkn3JRH44Vhepjalbj8ImSQgGMxT?=
 =?us-ascii?Q?Uebo1nttInhfPQeoqVza3qSjxgsaiswoThL4M5OaQtII3HnlPwlg2th6WAmC?=
 =?us-ascii?Q?fYfi/EAABdeyYZ3yO/k1WHvlZ/QlubxbiMlb2MudcKQXgFo1n/xxhZUkWvU7?=
 =?us-ascii?Q?AG0rD7BxVTIqqnv3HFrvvPC8/XpJkT+C15KMBdpt0yOkec08d5R82ZSxSo39?=
 =?us-ascii?Q?1CtikzlSjonROzYuTRibYSed5YNhFYYyRBirReSkxim8sJceb6C9dOfJosaE?=
 =?us-ascii?Q?1Me80X1WI7cOZQbxY35i+evEc/KsnVtI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:55.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6f4e3d-2c7e-4133-66a5-08dccd30438f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

The mbm_cntr_assign mode offers several hardware counters that can be
assigned to an RMID-event pair and monitor the bandwidth as long as it
is assigned.

Counters are managed at two levels. The global assignment is tracked
using the mbm_cntr_free_map field in the struct resctrl_mon, while
domain-specific assignments are tracked using the mbm_cntr_map field
in the struct rdt_mon_domain. Allocation begins at the global level
and is then applied individually to each domain.

Introduce an interface to allocate these counters and update the
corresponding domains accordingly.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: New patch. Moved all the FS code here.
    Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
    Adde new #define MBM_EVENT_ARRAY_INDEX.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 57c31615eae7..6a90fc20be5b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -705,6 +705,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
 int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			     u32 cntr_id, bool assign);
+int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7ad653b4e768..1d45120ff2b5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -864,6 +864,13 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+/*
+ * Get the counter index for the assignable counter
+ * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+ * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+ */
+#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
+
 static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *s, void *v)
 {
@@ -1898,6 +1905,45 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return 0;
 }
 
+/*
+ * Assign a hardware counter to the group.
+ * Counter will be assigned to all the domains if rdt_mon_domain is NULL
+ * else the counter will be allocated to specific domain.
+ */
+int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtgrp->mon.cntr_id[index];
+
+	/*
+	 * Allocate a new counter id to the group if the counter id is not
+	 * is not assigned already.
+	 */
+	if (cntr_id == MON_CNTR_UNSET) {
+		cntr_id = mbm_cntr_alloc(r);
+		if (cntr_id < 0) {
+			rdt_last_cmd_puts("Out of MBM assignable counters\n");
+			return -ENOSPC;
+		}
+		rdtgrp->mon.cntr_id[index] = cntr_id;
+	}
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			resctrl_arch_assign_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						 rdtgrp->closid, cntr_id, true);
+			set_bit(cntr_id, d->mbm_cntr_map);
+		}
+	} else {
+		resctrl_arch_assign_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					 rdtgrp->closid, cntr_id, true);
+		set_bit(cntr_id, d->mbm_cntr_map);
+	}
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


