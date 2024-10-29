Return-Path: <linux-kernel+bounces-387842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13329B56CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0E2815B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F920C335;
	Tue, 29 Oct 2024 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YD9GoiT+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD920C02F;
	Tue, 29 Oct 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244261; cv=fail; b=mVmE6LCsb9c+Jzy8GmuFp9qfgCwxv/KHcc0ZjtThI6F+P+EF0Jx2S/+WTXOjJFSeV7XZjFuRrch4q1QBYb+edymkFecad51jx2LMJLA3mPNMH8BQv7lAG8SmEjkhzaFIpCoyk3PLClSB3w4cJcvm7cw9vGjfGYZ6Vsaq9NRLgz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244261; c=relaxed/simple;
	bh=uKosg+X8JTtiQksnX0ueRWF8Un6v8SRHOD1Kp6m1oqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9ac2UgC52xkgpTtxec1zfKgs+tPkkul1uA9+RpQhu+ocFCsIGoqLZQokc5CZEMTnwYoGhfOUIBkOy28w6U5OScDyjG5xXPzU06Kwu4meXvj39LPeViU9QzDY6Ki7JB704TyosB3vDBgr7zcJRETSUm8NqFijyibv/npGSBfh5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YD9GoiT+; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTVW1iRdP/oDAW7JW5gDGJ1Vqsi5oMFy3N2+Z/1XJYQMLOpU0XqUJL6y0R0zdEEwfq5OXELNdq1hRVEkM5vy15vIixOo2zi5ocTocF/Jled8EwtJ4wxWYM3FVuE/Xe13GYY0wF3iwpbnjVKwWbLwcx5/air5Ae+wohFyqnZ4hX7B/0wvwhsOc6mI0YsxThLfF9XLBcXLyhWC3LIi1QVn30ircGlMILY6YUBqUxBrTIOmAJ/eTQ8579VRA/WUrh9Xr5AoovlM0xl2zIeO0TQcqrjdV9fki+JHJkGaiVE6rMjJ3wS5U+X2Ho2Ml4pdQ1KCdOxPScZpP94mU9XpfCzolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDhVrrFoCYPa4Z3w4K6fMGRRMFF7ib7y+dIqc/WR7qU=;
 b=GPQ4PDDIybGZnUJvGPkpDj/x9ElnzQa6ygBdUBOlSoyWIsFlnZtokpk6xJTUeuqw525iSwo8hcZr2GtgK+wPLFTOBxHJVT1o0MvUYc3wM4PTuZf8DeO5TuJU/OJYaFyHHYuy3j8wkljvQpL+Y6wEmcXeko3v2oQZ0A6tDGijb4/ZAzFgPaTtVlIIxsnaiJiQ8JGxStwOKN+jbTL+jMLZmiMOHMZo8512QSHDqMRtdDWM7Oku1KH44dJP5hoaQg9S2EXBvMaj+ZSxc+4SdBPPDHZMo2D3eVIVAf005rJmZinACqvCxhib+bUzxsZFM4Hz4fA5a3FsCQr6IVtwzTUVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDhVrrFoCYPa4Z3w4K6fMGRRMFF7ib7y+dIqc/WR7qU=;
 b=YD9GoiT+KtxY5AFnnqCBU1gxvi4HldLk8ep9dVdi9kEF5bUoULXNdbwAbzpTkZ3YsglloZJYQhoGdpv6ch0uuzXZCGoxZw/bnDG+jaPghPKHMy7DD+TlvDmihNhJS1bghjyHkw+bBr8UR4LZq1S6/qqVu2qj11WjCCvdEmHshPE=
Received: from SN7PR04CA0213.namprd04.prod.outlook.com (2603:10b6:806:127::8)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 29 Oct
 2024 23:24:16 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::1c) by SN7PR04CA0213.outlook.office365.com
 (2603:10b6:806:127::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:06 -0500
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
Subject: [PATCH v9 14/26] x86/resctrl: Introduce interface to display number of free counters
Date: Tue, 29 Oct 2024 18:21:46 -0500
Message-ID: <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c28c17-312b-4e4a-6312-08dcf870ce5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgpiwojA2v3RO3n/0mBPfqlU6exAmjYz11YpnUJQnrmXZaYu/APFu3x4fp3X?=
 =?us-ascii?Q?8BzkvpW1EUsRaotKW26I9TF8Dnm41QkFU3Sex6UTbUM1FIYcKXpNdZCJhdGx?=
 =?us-ascii?Q?taYtv5GvGBS4WbSP9Q/ymnsKHiCZDBYgoPWriSJ6tLNtgNZCQegfPX+qbD8d?=
 =?us-ascii?Q?2d6sUSfRkGcnhk8qEprKh7CgTRx9wp4GELuXVQRpHgXRvTPtBIm9WyuGrO/K?=
 =?us-ascii?Q?N6A+oXl3xB4ygX32C/LuTAyEV7rnAWQmpi4qcrpuEeI6xJhmlUHRjEeOTdmL?=
 =?us-ascii?Q?U7CtXk0KAh0goX0eb2ggt724p1dCKkdlEdy7UJbPh+A5tK540FZKky5IWDOO?=
 =?us-ascii?Q?TwDQhe7khj9W7minSdUJmIWXupmV9e8zD9fhjqtkg8g+Uqa1WepSvQP7tJ/t?=
 =?us-ascii?Q?vBKNNRIOdK03Sb8CuTZ1K5EQsuaFW65DtHwNLaeY3TPHYoYpWbHHSfZwYwca?=
 =?us-ascii?Q?o2bcVXfVm9W4eAUZeDkuwojj99OSyl1XtKhUuYYxXEKGfzpTUoZOVJx/pphi?=
 =?us-ascii?Q?pDK/0hzHfVewoHVFgHwb9H+aNGHgROn1e+aA5KYNWUoBxawB2UBjWN6WgqR0?=
 =?us-ascii?Q?Jh0fVrazgPvee5I09tMea5EH2nmiNit0WxC2QZMIDXYkeCq30NdtA16Y6skj?=
 =?us-ascii?Q?1qUdD/QnJlVTjUiSfmCHEhnCkHKKfsThpZ9PlUtYfKTxmGlCc9Tx9asPRYke?=
 =?us-ascii?Q?93uA+dsQGJUERyzN9SKpvn1VklBJs1MJwl1y5f1nLNC5B+zoa3HN5ODeFvwg?=
 =?us-ascii?Q?cHYqGjEumVZS+QS0+M5l2m0vv/3H3pkg+ELMSXj4Zql8N/N5xfYNKZMNKgEC?=
 =?us-ascii?Q?6CPHjpFuF10ElwBebPVXZrZV1rMU5EqCIEvr1BC76o2RlT+pRKhtLEBfinFU?=
 =?us-ascii?Q?XXamrue8lIJS39oPSoti9IeYQb+fY9JvTGibdB2CkXB9gfC0szboTLIcYscO?=
 =?us-ascii?Q?A80nAk0BFiiF9o55G9QXmOf15tBskQvvHbN31SxI0DubC5iv0gdJtThkMB1S?=
 =?us-ascii?Q?UnxN5ihWCQNJf24bxDJXfFPtacMnEvvBZ0T/CiSTNrxRhNVjd/6/tUbgqKgk?=
 =?us-ascii?Q?e4wVz0ovORduFQb6Gwl+wGQWQdB6X8RnQWB76HzastcKdAtO7Kn4ssS7Y1FD?=
 =?us-ascii?Q?I/UUc/uH/YcRBaM58b6NzZwCsQUOo1hLf7E0lkqLm+muSsaaFRvT39IRdd38?=
 =?us-ascii?Q?J4gyIm4izopfe/71ph3mgKEKu+6LJ7RmIMn9yjY4dFeHJVGVGE1ZWhNOphSL?=
 =?us-ascii?Q?772LR1rVr4b1DQGfKj8yfphNU1vGVzZqE4D6A0LsiC2AaShdwd1GPeTKL5Ji?=
 =?us-ascii?Q?zaJmyXyb5czEBGIZ1Tsr3OnkQ13eua0OAg/CkjVhRWX8UtglZuMeu3TQjvYx?=
 =?us-ascii?Q?tZqYtdR5QqrYxjNcVG9HCR40yA4YALq8AM9CE85zi02GjyGw7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:16.1369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c28c17-312b-4e4a-6312-08dcf870ce5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003

Provide the interface to display the number of free monitoring counters
available for assignment in each doamin when mbm_cntr_assign is supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: New patch.
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 2f3a86278e84..2bc58d974934 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -302,6 +302,10 @@ with the following files:
 	memory bandwidth tracking to a single memory bandwidth event per
 	monitoring group.
 
+"available_mbm_cntrs":
+	The number of free monitoring counters available assignment in each domain
+	when the architecture supports mbm_cntr_assign mode.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3996f7528b66..e8d38a963f39 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1268,6 +1268,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 654cdfee1b00..ef0c1246fa2a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -898,6 +898,33 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_available_mbm_cntrs_show(struct kernfs_open_file *of,
+					     struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_mon_domain *dom;
+	bool sep = false;
+	u32 val;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_puts(s, ";");
+
+		val = r->mon.num_mbm_cntrs - hweight64(*dom->mbm_cntr_map);
+		seq_printf(s, "%d=%d", dom->hdr.id, val);
+		sep = true;
+	}
+	seq_puts(s, "\n");
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1984,6 +2011,12 @@ static struct rftype res_common_files[] = {
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


