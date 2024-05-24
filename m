Return-Path: <linux-kernel+bounces-188671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6FC8CE532
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F261F22C74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3681086267;
	Fri, 24 May 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vSdnEEsk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F986640;
	Fri, 24 May 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553460; cv=fail; b=P4InpNhSyH/ntbziDZvK0d4XxBHgPKyM0hhzTjWFz6alC/jo7izkki1XK324boltLy8uC9exErcv5G9RUs4TDFgeZlweJWYgeEPl5JFDDQNTp3DRfbKpPuBWJ6tx7z6JFZ9FReTiWL4FDZkbvDvA5adXbO+sYY9Ld9ltIh4+3NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553460; c=relaxed/simple;
	bh=NlkB3UecvV1cR7SxSTokA6z4AGJ/L7hJ/8s7O0KaUpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVu2qF0C2Cy8fzqd+mCU6FwuvLAhVsMB/y0hkh4VP9aOJlO9xsKrKhG6IT2wWX2TyKbMeU+HdISW+TEwgwDBEc85yhikUxYug/XdTz7V+JD2DopUYZU3Q3H2TW2OfxXtQHitwd8DT4mI44QOLiAeepOeI9HjZOJcIjqg1pJMF4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vSdnEEsk; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIbicVd+TJNv5clcb7K3sHYJS8kJfD7Xs+83+TmpcknGLVTt2cR/XPfRyc7T+PT1PiGgTeE6Pjk6fheQRTKzOrm9B+VNAUuBm+WTtzc+dxZ61S/FDTBEghvEtI+hslgzbeuSNXZM0goQX6Are3H4GaOf1uzhmZfPfawnPqiuRvGZcKwhdI/pq1MdZavMTFpDNsglqgERF2AoT19lAdQrwlfHvFhXS+PfVLh9FvtXdc1KsaNl9Om66Mp0klVMaNIJo67M77MxRzznSlPbrnl9QKksC4mAH3nuhFiIxdT8mkXPRgXhPgtD/uNAzrl+jfdkMKqdHx6WgD7EVijXIWCNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLrMwVDesrjw7RsEkAJEVUTtNpqgZuCD7Ha9rDMplY0=;
 b=gKrS4Yk5nDQG8ERoZoCgDcSXJ2jrhE/eJu4lTbfLHCTRhN5AuzjcpPFgWHuW30OYEdSsoLvCtms7eBPEYwf6S7fkX8fR77gfDWMZdWOAgm0q7fXlbPZwX4YXHnbn+9+2ehZm64HktfwXWLDNZVQRP786jSdKZHWOJHj75rUG+l+XOpaDGXYbB/OgpsXQtopPyaqe1wEdQwT8nOQI3hy7/Ysf7IqZLqZ0cAdAI5bzoloTnigekobeUqlun4bwAieXh7SdeqzLgpiReLaXbgzPdMCYavYNl542GEr6YSPiv7AKZNpA68PVKwghE9d/eCF0L22NThk/ySWjbecZMbLtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLrMwVDesrjw7RsEkAJEVUTtNpqgZuCD7Ha9rDMplY0=;
 b=vSdnEEskPXRORRnSFmTfX15begnMQHrq23qtJOZe44IGWbZp892M1ZfS+g88IsZfH3lDLSQzxij4/M1o2b1eUF2LVeqUL5SZKG/wMnDU5VAww4s0//0YEQFZ2S7Jy550QwNr0bFpeR3Pn9YsHMF61rI4ZaqeDzPlZ3PEB7RRpSE=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 24 May
 2024 12:24:14 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8f) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:12 -0500
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
Subject: [PATCH v4 03/19] x86/resctrl: Consolidate monitoring related data from rdt_resource
Date: Fri, 24 May 2024 07:23:22 -0500
Message-ID: <8f73c9ec4c9999c262d9297d46a03209a8affe3f.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e4f2fd-99fd-4f41-e222-08dc7bec6cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELygwwujOApx7lmOqIqt1KEUaaYHoItFzTz8VITrfXlR/8GJaYn5amhcUeYo?=
 =?us-ascii?Q?7UK47Auk3hDZTac+HwxCDdrpDB5lqKNZSrONrbRbNWMKs1EKzhbzuf0Rd5tb?=
 =?us-ascii?Q?fsVNC/GS2GYEq5LtchEYmS7LsAPAB0qcd9R+2O3UtnGKQpA8/8eM35p9TIgQ?=
 =?us-ascii?Q?/r5WNS3yEnPxIZYHcAMEg2sh/OxEIH/iQz1SvnjXbaKVJrkqNYJSNyJo6PHU?=
 =?us-ascii?Q?4MafiXscH4vPv9vgp/C6uugVq9PwZNgpntI1dq/S7HhTo6TE3F3XJZrGXF40?=
 =?us-ascii?Q?gUTBaNnTCM2u3rCEaUqmXgjh2uaRUCVIBtDugDiTc4mpIrFH/dCbrjIM5Ah2?=
 =?us-ascii?Q?g2Xiou1KjE3F6xlBuW1HVUxMi+6hvsl815e5lRq9Ep22VJmIP1nUAIJsyxY2?=
 =?us-ascii?Q?dz8fU9Yf/TqoM5EcIpRdD/p9ZoCt4cwDeQAceHvEPvu05+xCMKjsAEaO2Xyi?=
 =?us-ascii?Q?TRJC6AVxBporWdQ3Gfz/1pRiEncK7gVfGw/ySZW7quj2MlnGcJ1ooGziBOy2?=
 =?us-ascii?Q?wk7MEbrJJ2MhU0tcWnDCgzIuHMZ8V0gHKKjGBLcFB7K6L+4hm3c4ihiAjccf?=
 =?us-ascii?Q?zLFG9M+9ZmPLy1aRLwG6IY3GbWETMKBzGj71OoXuKtpWAOfFUSOfxzuCUcQH?=
 =?us-ascii?Q?QXrixYZaHg0iTxBqMXz90yi6ps+3eLQppRiNggN1VeW4N0ucPLiNmrAx1w8G?=
 =?us-ascii?Q?R+QhIfDQttnLLeLwqmadIpr44S6aRwOg9mT2a6pltiWIvIIYRs5MPngBMAb+?=
 =?us-ascii?Q?M4bxRJS7TgaoeFBBjCc1AYJKLUjzgzC/9jLe2CfDWaBI3eq+9CHrhc1gjYH9?=
 =?us-ascii?Q?DraeM0+sDKZ7A608SZZdDSt9aCoLaufqwlojEzeDilpFsNQ1SHofg3eNsl/1?=
 =?us-ascii?Q?b7w6xevpk7hi0qWwTxpo6hh8XfLuCFP8TrmoobrGxF/pVA+yeESTD02rxdhw?=
 =?us-ascii?Q?LP5IDr3SyRCCcFaCEADyakR3oVR6+TPiVAWaxse7gUqcZQkQ19RLBdVAx3kt?=
 =?us-ascii?Q?N2DxnsY00Xd1jcjONPP8FkQftaDe/GFwbalOP08lbnBG+7QLgu2ZjuSeDmSr?=
 =?us-ascii?Q?LTrkI/2B5nSEs/gb5buSt/Z5ZyODF5DlynFNn0XtqFHJagj98KKDYcFbgpUg?=
 =?us-ascii?Q?KsLhRC+YBNNVmCa58+XWuDYnrvFm6QMnSAhzRG8l6elip8oFwlz6PzEA10Wd?=
 =?us-ascii?Q?YgrEALj5Fe3t5GMcFfw4OGZvMwYKPcPEIKnahLZdEDNvUzxDkkWl7wKZGj+v?=
 =?us-ascii?Q?kjHpnr6q8ArL+f2in2YdKk3+SvZw11mAfnOEjMpk2pgbbSOFIpmH6M0FQXUw?=
 =?us-ascii?Q?6xYlCo65m7fzzSpwQ/ZYSDFPj4MqxNuCkxiuXJUMunJGgEBPJyuv+/VmnoV3?=
 =?us-ascii?Q?8cJoLtM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:14.4209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e4f2fd-99fd-4f41-e222-08dc7bec6cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

Consolidate all the data related to monitoring into separate structure
for better readability.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 16 ++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                | 16 ++++++++++++----
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index df1b43fd9f0e..6cf3c887c693 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -535,7 +535,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	if (r->mon_capable && arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		domain_free(hw_dom);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2345e6836593..b35d04fc761b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -254,11 +254,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
-		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_total) * r->mon.num_rmid);
 
 	if (is_mbm_local_enabled())
 		memset(hw_dom->arch_mbm_local, 0,
-		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_local) * r->mon.num_rmid);
 }
 
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
@@ -1004,14 +1004,14 @@ static struct mon_evt mbm_local_event = {
  */
 static void l3_mon_evt_init(struct rdt_resource *r)
 {
-	INIT_LIST_HEAD(&r->evt_list);
+	INIT_LIST_HEAD(&r->mon.evt_list);
 
 	if (is_llc_occupancy_enabled())
-		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
+		list_add_tail(&llc_occupancy_event.list, &r->mon.evt_list);
 	if (is_mbm_total_enabled())
-		list_add_tail(&mbm_total_event.list, &r->evt_list);
+		list_add_tail(&mbm_total_event.list, &r->mon.evt_list);
 	if (is_mbm_local_enabled())
-		list_add_tail(&mbm_local_event.list, &r->evt_list);
+		list_add_tail(&mbm_local_event.list, &r->mon.evt_list);
 }
 
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
@@ -1023,7 +1023,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	r->mon.num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -1038,7 +1038,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
+	threshold = resctrl_rmid_realloc_limit / r->mon.num_rmid;
 
 	/*
 	 * Because num_rmid may not be a power of two, round the value
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 02f213f1c51c..7114d58ef1e3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1098,7 +1098,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 {
 	struct rdt_resource *r = of->kn->parent->priv;
 
-	seq_printf(seq, "%d\n", r->num_rmid);
+	seq_printf(seq, "%d\n", r->mon.num_rmid);
 
 	return 0;
 }
@@ -1109,7 +1109,7 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = of->kn->parent->priv;
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	list_for_each_entry(mevt, &r->mon.evt_list, list) {
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
@@ -3042,14 +3042,14 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_destroy;
 
-	if (WARN_ON(list_empty(&r->evt_list))) {
+	if (WARN_ON(list_empty(&r->mon.evt_list))) {
 		ret = -EPERM;
 		goto out_destroy;
 	}
 
 	priv.u.rid = r->rid;
 	priv.u.domid = d->id;
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	list_for_each_entry(mevt, &r->mon.evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a365f67131ec..bf99eb9c6ce4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -150,22 +150,31 @@ struct resctrl_membw {
 struct rdt_parse_data;
 struct resctrl_schema;
 
+/**
+ * struct resctrl_mon - Monitoring related data
+ * @num_rmid:		Number of RMIDs available
+ * @evt_list:		List of monitoring events
+ */
+struct resctrl_mon {
+	int			num_rmid;
+	struct list_head	evt_list;
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
- * @num_rmid:		Number of RMIDs available
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
+ * @mon:		Monitoring related data.
  * @domains:		RCU list of all domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -173,10 +182,10 @@ struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
-	int			num_rmid;
 	int			cache_level;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
+	struct resctrl_mon	mon;
 	struct list_head	domains;
 	char			*name;
 	int			data_width;
@@ -185,7 +194,6 @@ struct rdt_resource {
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
 						 struct rdt_domain *d);
-	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
 };
-- 
2.34.1


