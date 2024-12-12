Return-Path: <linux-kernel+bounces-443893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA009EFD41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A8818913B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1301B1D61;
	Thu, 12 Dec 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WvXREHmU"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC71DDC18;
	Thu, 12 Dec 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034674; cv=fail; b=mdIio32OSnotsqEnqyHJOPFdmxDBL36XOOKN+z8ktJUT+/W5ZXDvNIJzyWLYv4ZsiRlIOby19J9Fsm9rRCE2zHQ9rx7x5ZXqnDEWx3W+o81wvEi1kjV20yOXwr/eOyD3s0Rk3rk8KMp3di9qZ+nplmbqLTqP3tEPezobit9Mo+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034674; c=relaxed/simple;
	bh=sWlr0hGoBVT1yTnvzV7rwmOegKsYEP2Id12aRE1xS/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUQ0A1s9RdvezCBf7PB+DENbplayGGgHZyfj8NAdt9i2nRHTpcQlm+c3Lf8Ue/Skw0s9bb/xWNCvtvPPTETfc63Y7cJ9Uq36lJn01FBoaIlaYw1/emB1Q4F10OSbz9ycnCHFq79DhoO0KZyAIl+VKfEqWsODSHnrGfmugo6Utp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WvXREHmU; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib7EwmT7U0YImabyikFob3OdQvyoY28jGipZne7AszG529EchUx7DqcNTqa+Z7CdIXHPsYOap3x+7Kc5MU2rio8No4qfEbsVWkwSySeoLGwHLOhQrCs8nV4jXG4Z6gxsxb3DBmU5UthKIYfXOPr838dj5xdgNAi7p2WU6HelrGBM724du+68EsjzALiIPKNrUSk/qhnyi8uQX2oGl5u3uGedG+m1Y6wQhG1sb7MnMa1OV2r3KeQ9Iq13NX5R7Z/8UK+kZ061nyJBqA+QKLyW7/uqnXxA6Iv1+P0c31uX2iDfXQQVWU7f77ZqBLDEwj1S0zO98cm9mXf/mhLcdrMLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o51DFJmQ/f0tU1dj4XkPvnRlcNja3j7BW6uwoq53+YA=;
 b=NvodruVLY9ghB7jIpMxwiigtEOuieeRcB+h4k6a9UGY6pPXM/tmp7HgGgXrirrDQ7F+fg3Z51lKiQrU13rSL/iB8NR7q9Cs7k1vOJAWgW8TlpV1Do0iOnSWGRvdUDw2oo51FwlPxsJjXPqN397notuBgGg+SjvB5x6e1Rbn0mcPiQNW/IZdxpHWumIhPTqsxTq9y4H1oCxRP2EWXXnyuvZ+839g3McRKWn4506reJ2SKiVhYibHoN6PzhndBWo4g9CfI+7yGjJzWszsx/vddjQcOiDmZSVqGqsODdF/SG7lHS5zcJnn58P1SVglgMv0MZPsdkTNQRWlpxwLLfnKU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o51DFJmQ/f0tU1dj4XkPvnRlcNja3j7BW6uwoq53+YA=;
 b=WvXREHmUUn/02pw8ZhbwZFVH5t9T05xt6AI5N1rz32Z53s/iLnt9jy5f1sEUJ1W4c0Xz/7KS/zBzK5G60k5N9c9Hr5EIXs7QVTuNSpeG89OYacrnpeXZo1kvo8Vv8sy59laihVuVW6arQiFOf+uOn+MkPOZwwf0fdJ7OEAh28TU=
Received: from MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 20:17:48 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::d2) by MN2PR12CA0006.outlook.office365.com
 (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Thu,
 12 Dec 2024 20:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:46 -0600
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
Subject: [PATCH v10 13/24] x86/resctrl: Introduce interface to display number of free counters
Date: Thu, 12 Dec 2024 14:15:16 -0600
Message-ID: <0376bcf61650e619b3f39ea8c2e59b6807de28b1.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: dca3d643-5637-4521-a02f-08dd1aea0c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eyZnxUb/GTarie64AA32U6a71P/t1CZkdDC3EfmtvzKHApedhjfQiwX6QO3m?=
 =?us-ascii?Q?EW5OSWp1X1If+oHbc4gWgQpbj2Ik4394g6zpFQSslhD6GQTguiO91Nbv+ObO?=
 =?us-ascii?Q?e+PQUghBJcCNnGNRRFBsFH8scxWGFhRaCzNdv8IluuNWVl4SX1GF9B+J07VY?=
 =?us-ascii?Q?sVDblAK/7Dd6kM4/ppPBpHH5eTsVmNj34vF/RfRUwKn5Ruv1SASLK3Bfyvep?=
 =?us-ascii?Q?HSspdbpD0qStKXno5N/9K4c61B1rZbqYYi33ZzSZM2qK9nBYNxljyO+GkuPp?=
 =?us-ascii?Q?+mLZWxwpcMPFNvnz7MuMoGSM06py0Dr7Zrf72GqUSEAo9W9zgR2NFkmSpTZ9?=
 =?us-ascii?Q?4D5D/wMBZPwzoiQMtnX00O+jQjQPRju2x1ALeoNL034kzm8vHO2LK4yq0YFp?=
 =?us-ascii?Q?K6ij+/SDH8GhpmLfgzcirV+39kIL7gT4pnAkeac1eI7fyhpboeoaF29UChrw?=
 =?us-ascii?Q?VCqyKSZc2nJozKY0b4q6ayxEs3zo7BnqbrCbM/V0niwERCxcFGsAQMGxSKNk?=
 =?us-ascii?Q?yMP406b7ifg21fjcHGhrX+Gk+IIVAETFNhRcHILXZ17J6shimxGAQl3UXnF3?=
 =?us-ascii?Q?PbQqPlV6tFK99sgVesjErz0AX+JglcOnsbWkjCO58Sfxo5aoS94jnqwHTuSH?=
 =?us-ascii?Q?YVPo7wepVZ6anbH/j8pt4JjC2ztHN0BQ5Pr4hgCtIHWZ9xhXl3+2Wb62FV8r?=
 =?us-ascii?Q?DJ/AZmQNI3CVspUqG87EPQUxYR8OCvRZbKLWzcPjkrx3LRkNYBjJ7UTlC08g?=
 =?us-ascii?Q?MsRN9dJK0j2X6YDMZG/DT6zDJFqE2OC9Ob0pj+wxUJSpiuBlOC4N71YBAbvU?=
 =?us-ascii?Q?XUcncuhTozlrhBBbd7ODZAv4CoRSt3ACYmX0zkIRIObwb7PUk/XchsGcWQuy?=
 =?us-ascii?Q?rkW+N10JdKWDNr2EtHZFPYZtrYI1WgB1uSydyCY4mgu3SwnMNAftM3sUB7yQ?=
 =?us-ascii?Q?PWFcmOPbSgJpOuyG4ZDYzbt4X+2NsurRmi8Bs1VJPZt9/ADpxqRvtb4MJ32x?=
 =?us-ascii?Q?2NviN/jrYbm5bG0slPrwQcJ3d4efoVb7H7T9h9FxgiRMxWIFmRNozR1fbIT0?=
 =?us-ascii?Q?THifh6P2P0JwWZtfUphmb1DhH9rv4bacDp+sXQK9fBXj2X/stspu1VLKSITN?=
 =?us-ascii?Q?e7UH0PzXXxht1JN9TH9CM/8YLrxZlYRe0xm7MCQU8NIEpmfKFxj05WkXeZ9j?=
 =?us-ascii?Q?5vGbszHHMk8zQkNUq1/lOD8dshI9pfMKYmApZAFJdM+GBgbUK4yNGdZU/8SI?=
 =?us-ascii?Q?DbsV7ZcwoIbIhLfb6js7kan36gEhT0YloW8w/8d5oxcBdJ2zQUtcFDPrXl93?=
 =?us-ascii?Q?QhOpv3Ncg+hYI458qUgB5/mcxwvkCJ5KGULnIHUAMyOoWj7E40x+mSA6MUry?=
 =?us-ascii?Q?OkXTFC+MtGKyhdlEESY9dvGvDsb14uMzxpMmEF7tXM1bMCBGJUhbjg6tW/sQ?=
 =?us-ascii?Q?hLlRLnLlsJQ3MSyWxvhNyOKrMKM3h0Ac?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:48.3700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca3d643-5637-4521-a02f-08dd1aea0c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

Provide the interface to display the number of monitoring counters
available for assignment in each domain when mbm_cntr_assign is supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Patch changed to handle the counters at domain level.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     So, display logic also changed now.

v9: New patch
---
 Documentation/arch/x86/resctrl.rst     |  4 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 47 ++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 43a861adeada..c075fcee96b7 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -302,6 +302,10 @@ with the following files:
 	memory bandwidth tracking to a single memory bandwidth event per
 	monitoring group.
 
+"available_mbm_cntrs":
+	The number of monitoring counters available for assignment in each
+	domain when the architecture supports mbm_cntr_assign mode.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b07d60fabf1c..f857af361af1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1238,6 +1238,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1ee008a63d8b..72518e0ec2ec 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -879,6 +879,47 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_available_mbm_cntrs_show(struct kernfs_open_file *of,
+					     struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_mon_domain *dom;
+	bool sep = false;
+	u32 cntrs, i;
+	int ret = 0;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		ret = -EINVAL;
+		goto unlock_cntrs_show;
+	}
+
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_puts(s, ";");
+
+		cntrs = 0;
+		for (i = 0; i < r->mon.num_mbm_cntrs; i++) {
+			if (!dom->cntr_cfg[i].rdtgrp)
+				cntrs++;
+		}
+
+		seq_printf(s, "%d=%d", dom->hdr.id, cntrs);
+		sep = true;
+	}
+	seq_puts(s, "\n");
+
+unlock_cntrs_show:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1961,6 +2002,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_num_mbm_cntrs_show,
 	},
+	{
+		.name		= "available_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_available_mbm_cntrs_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


