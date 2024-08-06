Return-Path: <linux-kernel+bounces-277003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD918949AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EE1C22944
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50A178373;
	Tue,  6 Aug 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e1g770E+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC7176FB0;
	Tue,  6 Aug 2024 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981825; cv=fail; b=syJXGy5G+w2LpJGL0btwqxxYmwzcPq8ZYuwZYEL4UAXC44ynPyhnyQGaNA6jDjcbQbwjgQiLYHP58C3y2Q82IZIjcM1UbFkvcWLSamlMPSwuBGooKLo2w8nVk6AO4JZsZ8pdbZV7RiWPv2mt2+fY/BFKB7KB4qtP5u2uk3vLCd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981825; c=relaxed/simple;
	bh=p/J/LYGTOEAb0f2jWN9MIegJTCTXifk0DjehSEYJBbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATHoUMscMb2bS0W4Y8vzzj+2JYcPnjYD5B+ttapsEPBG9VMo63+ggn7IBQLzDZEAs9DN58TD4Ao5ggqCAuJRJ4D+lNdFNoyIpWshv4Jm2akIJilUvNcn4BqfhYsEbJkbJf4d1pbJyTuywFRpR0k7Wg+U6qgY0ugYd6SOcGYE0ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e1g770E+; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAbI1OGsYTY6xBeYkWObjbQ37mrjtyGWMgcYDH7Hm/YXfjKe5PoTRxL/G0HByBVnBnlzpUngUH4c15ECuUSck5Ps3tbWMv3iOjPH6tgUG3UGYZkOyLgYK1z6vrwbLGEKwfD9CRNhkLD6J1B1zHPAcN/HvPBRCut5KwuqarNeYdoN2kIuKYwCfkYkj9y2KMFG7pzBR48kspY3/lyYzOZsNm72o7o36B2DOpzkcM4X4jL+hRqIukMZ2FlCu4X5YX5zYu75/8KdueeLz3DRnrSxqSXUYdSQNupjaYaHNF7080+7a3lvQZogJSnyNjQp9h4iZTDoIRkfY1ejI+vW6xlTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS1ethcq9suAZA0pTe6zGF/wa7i4N0VHnwca7AyzQ+8=;
 b=s2DRVdxRt9qUnwxiUzZyh+aEpCuOoeTeEHNSBcI4PJjP3+ilR6Zu6VGecn0B1ykfSKmqdrHKY/0oORaVHuHyrPujRIcn0GjK2M8h8LwYQVDss7QX24gmgbfllGN6Hy3760TfRZdAKVEuFRCPREr6vYJxzn2nNBhZR9eoKrMEP2BekqZyCNasi+wsZSIjKiKu1LhfbkxnKhWnsmDCKjO4rGL3JUtsMTQsXR6c/z2ePwNY7XaCa/gSzAxuQqidkZ/PKk+ztHoE965IMVRTu3M2L4B9pq/cVzryzW2YzUyLX1NOduwBZilFMXXzbuyoqm5nlqmqf7ZrDmAdJHKdP7jWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS1ethcq9suAZA0pTe6zGF/wa7i4N0VHnwca7AyzQ+8=;
 b=e1g770E+OChv+W647IQmhQ/+5FIk+0oj7k4lTOxaWPgK6HrORV5tuJGNzYHTW/u9FL3eWWhbt6uTbOZ4ArP56eXEmd2MD762HeIQPf53757W8VtC4Psu7n19Ca5nEInLhs2evk327Ki+G+THRrVYPKwvBhWK4qlxbroW9PYhzqI=
Received: from PH8PR22CA0003.namprd22.prod.outlook.com (2603:10b6:510:2d1::6)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 22:03:39 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::bf) by PH8PR22CA0003.outlook.office365.com
 (2603:10b6:510:2d1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:37 -0500
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
Subject: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default when supported
Date: Tue, 6 Aug 2024 17:00:57 -0500
Message-ID: <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: a85769cf-0c63-42f9-cf29-08dcb663a089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZS8AeIodI4KbzKjv9uXrNp1hf72GmZBLJjcE0uiic71GjXKMujD/uSa+KuEO?=
 =?us-ascii?Q?vQVeX+YLp9KNo140DsxCsE4YcJZoMi19WVpUWJzfBXLJ6TlAIlSOLNwxFICb?=
 =?us-ascii?Q?6fyftNh5+3pNd55U8gb86npXdxMu3e4TJ+8j+7EJUsxLl+ZkyH4Ua8rKoHza?=
 =?us-ascii?Q?CIy8ufl/TcAogmsXUkqROMuCU7gI+/AMnUXuRTiZahmqfw1EHueI8wEY82am?=
 =?us-ascii?Q?CMkD8DkXHFLjBzBHseH0wTZgksnjDl5ZWlE+MJd7t2l8XUk0lJl2AqY0AEK+?=
 =?us-ascii?Q?xDZjpXCAu1u+7R1d+ICEqyTOQlc28uURjgkAJ12hbm9/QYsoT22fso68JpRB?=
 =?us-ascii?Q?3AGeiFDWZyUPU8Z0zPgTazvknbknfv6BP5LFAr0BBpCbrBLVpxYPGcWBQCR7?=
 =?us-ascii?Q?+IHEEIb6thBRu6wjf6GLTWo9KpTRJWX2bW9FciytCeEHfoCD3HO6JfF3U3xL?=
 =?us-ascii?Q?aI5OJKAaktGDwwaKnxKEE8Q/JSLxTLesuVq0Mcy07LjW78z6HxroM97cY26C?=
 =?us-ascii?Q?1sxcq5nodz1kj4iXPpILBzflPrZ/mWGQykHJ2eVc/SujwA+D9Q+3tPAe+kss?=
 =?us-ascii?Q?UtG4j1AB0t+4oCRaJTTwiZc2dqwJr8s7KanOWurMU9NLEaUx2QP8nb9Avujz?=
 =?us-ascii?Q?rUSQENl/gTmBvi+9/68K/zT3CEGwNswDOBcIt4G7KtfPUSiyV7hu7iXAiA+Z?=
 =?us-ascii?Q?LGA6kbgezzE4ZaGO18/8TS41ZX8AiJwNu9Qw9v20NffAazaIvoHCf9jiKZIB?=
 =?us-ascii?Q?89QGep2BcFtyrxT3YkbIXskasvkjhC21gg0yQHHj9eCjUKREy9sIgzOKVfL/?=
 =?us-ascii?Q?3KkCCqyuOt97RaExVoYxQ3IRpD1qL7D1AGQBqxciBScVzoE+dJYxYgmoKI4w?=
 =?us-ascii?Q?F8IdEFeYDLwvaZ/M12J6EwsZhlPHoQ9v6op8QfA0ATr0d7brL6/MhxtLGVPE?=
 =?us-ascii?Q?5YrtqKrEVnud5g5645oqt/fzNAMpTIbNU8pCqZGfgzVcadvTMQELzmavjqAc?=
 =?us-ascii?Q?kCyWH2ZRUCegHXkwioAP/t7NG2ZONbkoD/LD/Au12V4mgNrQor3bt7UBFpuL?=
 =?us-ascii?Q?gfWc/n+p7NBG8drEwa6ZLhCfZJNthGV/3qLQYr4rz8eygmaSsOiM/lk64XlQ?=
 =?us-ascii?Q?xyJFNkJbGf0dmP8P2rwv80vOY5U3SjAj2upQIYscM/FnJjDWFgBDNzhhs/PT?=
 =?us-ascii?Q?pzaKRybIgaFeNC1/s1H3BxgDgPaPAF7aFGwBE6Brin0WbpRY57wsmPAbyIbw?=
 =?us-ascii?Q?nyAaW20Rk+QxaPwXaizwG5wvwtFM1PGAk4GjnRseKtnbw5POFoNWqa7JnDSL?=
 =?us-ascii?Q?/WIY+8Q3XqD30Bd9+oAGILa2gN4enMDkge2nf0kJeNJWGbf4NNIDthyiSduS?=
 =?us-ascii?Q?BhCgTjwO4pjgeMl03akx3UHJBf2ZJihpVjsnFI2RwtT6cqqBzSBkLw6Br2jQ?=
 =?us-ascii?Q?H3+e/cTJN8JHQayR0pSlPErUIMa7k3g9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:38.9921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85769cf-0c63-42f9-cf29-08dcb663a089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Enable ABMC by default when supported during the boot up.

Users will not see any difference in the behavior when resctrl is
mounted. With automatic assignment everything will work as running
in the legacy monitor mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6 : Keeping the default enablement in arch init code for now.
     This may need some discussion.
     Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.

v5: New patch to enable ABMC by default.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6fb0cfdb5529..a7980f84c487 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		resctrl_arch_mbm_cntr_assign_configure();
 		return;
 	}
 
@@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	arch_mon_domain_online(r, d);
 
 	resctrl_mbm_evt_config_init(hw_dom);
+	resctrl_arch_mbm_cntr_assign_configure();
 
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index cc832955b787..ba3012f8f940 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -685,6 +685,7 @@ int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(u32 cntr_id);
 void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+void resctrl_arch_mbm_cntr_assign_configure(void);
 int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
 			     u32 rmid, u32 cntr_id, u32 closid, bool assign);
 int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 66febff2a3d3..d15fd1bde5f4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
 	}
 }
 
+void resctrl_arch_mbm_cntr_assign_configure(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	bool enable = true;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->mon.mbm_cntr_assignable) {
+		if (!hw_res->mbm_cntr_assign_enabled)
+			hw_res->mbm_cntr_assign_enabled = true;
+		resctrl_abmc_set_one_amd(&enable);
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
-- 
2.34.1


