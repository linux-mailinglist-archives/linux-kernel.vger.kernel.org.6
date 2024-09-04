Return-Path: <linux-kernel+bounces-316038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCE96CA43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC528BD6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746131865E1;
	Wed,  4 Sep 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G4vQ6Ws8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5E18951B;
	Wed,  4 Sep 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488588; cv=fail; b=nahO65WWiDNYmUch8VRrvdJ0xBHX2MY2nFxAJJUhzCfFIL86ArzbHXGJyXoPQkIUoS9j484vQWD6R8qguIWsQdbD3yjmT17Ftv5aJ4X2NYo2WWLjWL+zPtnPhzz0eUA3paOZSQh1CsvLR0PGwCNQItTE6iBF3hFOYWLsu79ecA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488588; c=relaxed/simple;
	bh=ZYsnYEl1aVi0wjuPdziBokPSQCknz37992mKRjr3C0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2lpJBWKLlT8ksqP3SUJgv5BR0X+zmCmKi9cQHYSMZduIaaUyshOb2gV6GKUqkOzI/DZ457m84d5uqup4/oZxfdjseRQyjWFXVVgu7BipqlIthTGrmiLpv7CNyD9HxAWjz1U3aG/0eaZ+Fl/TdZEcqtznYJNdkkEfVY4KREzhxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G4vQ6Ws8; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOmSKO50npi+5Qp/FfmaeSHPqR5GCOhtTQhzQLMs5an3jTMDErIMoy+V2Cfs5U7WVPB86VC3+A9Bruc0C9Yqdw3VzbE9ci2f11g89lG3lYfhu87bFNHp8zq+8EGd23Qn+xzg1KNOKLh3+KvOIrWU/+4IuP7UVT0HWwPDfAx22wlQAPPxHjUoW6B2XIyGR9sJzvhKp9RY/u562+eugLO28oEQwhXDLBB91u4sdxYz/ieSRaz+4BSqlBM4JS/ORncCW3eMqr0eYT/ZpactgLw3YxH+o1YyJhYHrBGRYP9U5zc+tR824QdIldlGpYfNiV/sVu+wLOkJ5C+WxnUrwmsOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raplkjNj/CncAHH5zqrDJ8Wcj70tkgwOkwM6K+9w3z4=;
 b=X71VKDnFTlVhraCLlXCV2KJy8OrS2nb0IArkrNfTm5rFd3LsC4gbbdXVBMcLHpPbWiUmNAojwhVvIfFV1Co49dA/1+gXT0yrCl5XI5KXPLyo13kuiNVT5V9WIl98MvQZ1RfO5257zNxlEA8gNgsDSXYn0vTykPA6Y0GIFyKR7FPC1pNPj0MZ/URptDArUxs24+gAikz73P+ADsU/HzLv6Q3wP7RJ9DxZY5FrEfoiloM9MJPMeFW7GuB5YaQk6Rgr1aS4r14E8N1VmUWgmdZnObnaeJDvRq1lMJzcFj35371B+4dj+4g12V4+w6XOfg5Rz+UqHbm+hn8aI99roaz58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raplkjNj/CncAHH5zqrDJ8Wcj70tkgwOkwM6K+9w3z4=;
 b=G4vQ6Ws8cgZxb0zYMuWq1x1GWoA9zW/rXnxQ9X1lNyz0Sw5FLy1k5YuhXWfzo084nmcBSWHPipzJ8x9ovS3N7ym/0p9vSfhoLkPSdfVFgqXGIRxhFxWzq3GMYXfpDacrrxOvvjWBqNXrptW6Z29gct5M01YtEBhxW4+1ErKFdrM=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:23:03 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b3) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:00 -0500
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
Subject: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map to track assignable counters
Date: Wed, 4 Sep 2024 17:21:24 -0500
Message-ID: <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d0fc62-9319-48bb-3749-08dccd302472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5GZIEqBkKQl+TtPbYj3t5cFTAC2cJPA85Z9Wg8QXzRrJU8FODN11VV8WnIz?=
 =?us-ascii?Q?i0zvPG0MnY/oskL+Iq+6yFl+vjFgs/E57ZAj7TWlCkfrAaGIxpG1eBd+zCLI?=
 =?us-ascii?Q?J1ZTcr9RmDGP6hYjqkbScM5+FaLwnvCxihDBtTaAqfC+TruElNEsMesKUqxo?=
 =?us-ascii?Q?dn0/8eCvaxU4JAkKsL22LjoGdQd23yawjO4YIOsgCBSJiesZJT3ww2k9hJhK?=
 =?us-ascii?Q?PceNye06rL7DVILYrIF1qv5fGYnvMVeOdhoxGZJ0aypa+GLVTb4AmJEq1j5c?=
 =?us-ascii?Q?ysGec6QPwmcY6y+Xu9mJ53DhJOPEW1f+x+VtM9j1dpcc5h/HaDc4Jn6Yr1YW?=
 =?us-ascii?Q?6nyLolvVOV4ifkQ4gLTxoTEXDE9xhNixLhMU5SIkHfC1XKjAV9Vt2c9/vP63?=
 =?us-ascii?Q?HlByMQyKg5bvR1DrWGy5tpt3RTxwxdTdCizv5LNx5XtwFes1vRemK5XhGIQf?=
 =?us-ascii?Q?ed6gvJRsoV3e2X/MqJsxX4rjmjt7jvHzZu8Ehyxq78+TZqlH8NcDWDeJwItf?=
 =?us-ascii?Q?+9I6x5VQ65x3Ejv5d3Q9UMQzhJjvjIKO/0MSEJcBIzx7TkQ60hdW3z7mpCMe?=
 =?us-ascii?Q?bIr7I2KeMbBiDzTANtRlIxYdihuJuDL6MCqcUV9Aw7/qwRSTnaVmPws/ePbr?=
 =?us-ascii?Q?6kiFkx96jL3ABgMD6sfV/GsPrKvVLv3oNxMuAnvoB6c5FIsXhMhWBaXJeuP1?=
 =?us-ascii?Q?YfCTS/K+MYcp4J/P7kj6W0FvNPIfum2ASyqBReSiuUmI9pfClis5FUujJrH3?=
 =?us-ascii?Q?mZu6XtymJmZZy1eLvBfPpVIQRZZiAO3nHPuEjJuKUnKJCxACrxVoWprkNY08?=
 =?us-ascii?Q?1IcXqeoVlF7WlWQTuer+8lrIRjG5zLZh/n6KkDYlKBcKFZwHBul8rW06m7DU?=
 =?us-ascii?Q?NynZODoQkdRAw++AncSSj1Qwh27t3K9QjQvAAJuWRWO7RtD47oaFiEQodkk/?=
 =?us-ascii?Q?OXMZoFxuNEgxjFR1GhHibYLf832jI/UDLzQNb/wp1N3LbQ7PSyiLMmdYAuCh?=
 =?us-ascii?Q?ZHjB1orPpod25qGlZnidZkz5LMc+FQ8qalNAZYgywozwOQsdWwrp63gjJKPw?=
 =?us-ascii?Q?IwTlw8gDFRP0D363b57NYMNscWXuioF2knKPJuU3qWUlr1Tdg5sc6xw7ktFM?=
 =?us-ascii?Q?IVQDE2tsgzgtVqOKNgNOm8AH3BpMJ95ac+sLS0bVs2lo1Z+jp1vbzAoChksu?=
 =?us-ascii?Q?PUVtxc6AEcF9tuKus9eti4PkmxCKf9KDw1DKDJ2AGvHS+y4NM4WRuc/jJrk0?=
 =?us-ascii?Q?i6lIc1D96zYNsnQ7sh79laWkDAsOyhjwhCtklgo/4Ep0YpFyoKl6Wn3CDXnJ?=
 =?us-ascii?Q?VZIYpY911QOhkyhSdijUU94wz2v99WS86xRjOz4pdiNJ42Qr8WBYbGcbHFMU?=
 =?us-ascii?Q?M3OlCoR1jXKoMD5FCkTDQlu/hFaP+xgdRcEgM7GVjNgLbgnNVqUEN/8eIqmu?=
 =?us-ascii?Q?/VtXvPjKfLkVBfg1q3NTc6/euyvxzELz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:03.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d0fc62-9319-48bb-3749-08dccd302472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176

Hardware provides a set of counters when mbm_cntr_assignable feature is
supported. These counters are used for assigning the events in resctrl
a group when the feature is enabled. The kernel must manage and track the
number of available counters.

Introduce mbm_cntr_free_map bitmap to track available counters and set
of routines to allocate and free the counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Removed the static allocation and now allocating bitmap mbm_cntr_free_map
    dynamically.
    Passed the struct rdt_resource mbm_cntr_alloc and mbm_cntr_free.
    Removed the reference of ABMC and changed it mbm_cntr_assign.
    Few other text changes.

v6: Removed the variable mbm_cntrs_free_map_len. This is not required.
    Removed the call mbm_cntrs_init() in arch code. This needs to be
    done at higher level.
    Used DECLARE_BITMAP to initialize mbm_cntrs_free_map.
    Moved all the counter interfaces mbm_cntr_alloc() and mbm_cntr_free()
    in here as part of separating arch and fs bits.

v5:
   Updated the comments and commit log.
   Few renames
    num_cntrs_free_map -> mbm_cntrs_free_map
    num_cntrs_init -> mbm_cntrs_init
    Added initialization in rdt_get_tree because the default ABMC
    enablement happens during the init.

v4: Changed the name to num_cntrs where applicable.
     Used bitmap apis.
     Added more comments for the globals.

v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
     from the name.

v2: Changed the bitmap name to assignable_counter_free_map from
     abmc_counter_free_map.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +++-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 31 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++++
 include/linux/resctrl.h                |  2 ++
 5 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 49d147e2e4e5..00ad00258df2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1140,7 +1140,7 @@ static void __exit resctrl_exit(void)
 	rdtgroup_exit();
 
 	if (r->mon_capable)
-		rdt_put_mon_l3_config();
+		rdt_put_mon_l3_config(r);
 }
 
 __exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a45ae410274c..99f9103a35ba 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -633,7 +633,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit rdt_put_mon_l3_config(void);
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
@@ -654,6 +654,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
+int mbm_cntr_alloc(struct rdt_resource *r);
+void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e3e71843401a..f98cc5b9bebc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1175,6 +1175,30 @@ static __init int snc_get_config(void)
 	return ret;
 }
 
+/*
+ * Counter bitmap for tracking the available counters.
+ * 'mbm_cntr_assign' mode provides set of hardware counters for assigning
+ * RMID, event pair. Each RMID and event pair takes one hardware counter.
+ * Kernel needs to keep track of the number of available counters.
+ */
+static int mbm_cntrs_init(struct rdt_resource *r)
+{
+	if (r->mon.mbm_cntr_assignable) {
+		r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
+							 GFP_KERNEL);
+		if (!r->mon.mbm_cntr_free_map)
+			return -ENOMEM;
+		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
+	}
+	return 0;
+}
+
+static void __exit mbm_cntrs_exit(struct rdt_resource *r)
+{
+	if (r->mon.mbm_cntr_assignable)
+		bitmap_free(r->mon.mbm_cntr_free_map);
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
@@ -1240,6 +1264,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
+	ret = mbm_cntrs_init(r);
+	if (ret)
+		return ret;
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
@@ -1247,9 +1275,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
-void __exit rdt_put_mon_l3_config(void)
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
 {
 	dom_data_exit();
+	mbm_cntrs_exit(r);
 }
 
 void __init intel_rdt_mbm_apply_quirk(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ba737890d5c2..a51992984832 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -185,6 +185,25 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, &closid_free_map);
 }
 
+int mbm_cntr_alloc(struct rdt_resource *r)
+{
+	int cntr_id;
+
+	cntr_id = find_first_bit(r->mon.mbm_cntr_free_map,
+				 r->mon.num_mbm_cntrs);
+	if (cntr_id >= r->mon.num_mbm_cntrs)
+		return -ENOSPC;
+
+	__clear_bit(cntr_id, r->mon.mbm_cntr_free_map);
+
+	return cntr_id;
+}
+
+void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id)
+{
+	__set_bit(cntr_id, r->mon.mbm_cntr_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f11d6fdfd977..aab22ff8e0c1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -187,12 +187,14 @@ enum resctrl_scope {
  * @num_rmid:		Number of RMIDs available
  * @num_mbm_cntrs:	Number of assignable monitoring counters
  * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
+ * @mbm_cntr_free_map:	bitmap of number of assignable MBM counters
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;
+	unsigned long		*mbm_cntr_free_map;
 	struct list_head	evt_list;
 };
 
-- 
2.34.1


