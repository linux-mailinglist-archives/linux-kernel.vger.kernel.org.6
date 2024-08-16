Return-Path: <linux-kernel+bounces-290035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84206954EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95C61C21F50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7881C231C;
	Fri, 16 Aug 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhaBsok5"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5E1BF33D;
	Fri, 16 Aug 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825048; cv=fail; b=hwzyQxjXChwXGq+TmHka2iuo7BfoeJDqjykcRhaj5JNxSKigptnL+QC14u7zrplh3aRNMoW5BTnssaU4xsGxZBvEF8q3s1ixggaRVjOkstCtzbCD2ervE7VMJ2yCMGj34MB5trfdpsS+8VhfaPaM6fysqUCEpJxhLYN993M7f7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825048; c=relaxed/simple;
	bh=rqYtQXHn67LjS+r/OYqWMre9lBL68TkdG/3B/sWk+34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TT7cGcIvTOzcGtNCFAP2iUcalrpM3LFma11v8roE8lyvz7RoW+n5pYKs35VAzdKsuvsBCuLsQdbAaE1pTBPoZOxgCjb9KQNPfnJHntlIct9LjaIoRnH+H4by41fegSjPBqcoiaGgrSxG72O89RiTtDhyQOeJqKdb68JJzTpsC8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BhaBsok5; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShEjyryePAUYodwu7JCAV/3u2NjdFB0dDyHNo++SXMGaAKTbhQTrmBKB6xOOyx4S30Rs6XnAsgYq4Zsi4cSayBQshBkZ3cvA3rTHfDyLFkl1b2g1e8kmS579TP5007qAmrW6y/pqPxsONXjeOP11RvJhCRDOS2R7De2l2TT9SZYr9flW5T8S8Hr1bIxmKXdQ5xNU9tp8gCWnzYdcJebu6DEdzTozAO60FGtPC7DyHjDtEIRaaz01csr6LfdeSoOMPDX9388LYtl87LYLEUls/tVyNsEP8sb8gQCj5III9PpkBz7/D45yOYqHuFrtrcj3ZpwL9WnzKDyhgRBR1JQJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzMwsKnv03Mwpj0eOxZS2gn6bnpCUB1sBikiO6YUSrA=;
 b=TL07c0YkstxsJ2ksq/p3H8AFnmhMMJr7rGLdOiCf+RmOInECLIU9RtoiumgTVZlguYMJePKkLYWSKBthskuErVyVgnyW6sOYV83eTJgAAohRC0iSq1MSt3UeercBo3Xl/cFC06Y1gRNzqfmh9UcgchD/rsW6KGvKWsccq/5RdnTHRIVEgw09hBVF+6wKG0ez6Jq2Ph5sYffjLWiDlpH8Nh6oN6qsFPmopgbXU5lVotJLCIJDNmVTTgT+30ieb3LKY5hFOPCDrYks2wMm3Ekv4sMOIKU0tDxsmMqGUNj0MYPqGGdhrew5SaP/OUG5Im+Um84MuSFeKc7TIntbMPPbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzMwsKnv03Mwpj0eOxZS2gn6bnpCUB1sBikiO6YUSrA=;
 b=BhaBsok5xCqItbciWq5jDw3gVrO/7ZQxlhIoiQyc8Rv6sSQfuOxhSrKi+T5QyvUzI48812pfWj14ULiD1ZVifXlT7+Tvn3N7pRR4UoyV7cF7H9FalxBNQi3yUOq2EP3lfHGXF62qK37QTbctytOhRTQafIhtWgN8yr5WpynZhgE=
Received: from MW4PR04CA0382.namprd04.prod.outlook.com (2603:10b6:303:81::27)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 16:17:17 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::31) by MW4PR04CA0382.outlook.office365.com
 (2603:10b6:303:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 16:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:17:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:17:15 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<babu.moger@amd.com>, <ebiggers@google.com>, <alexandre.chartre@oracle.com>,
	<perry.yuan@amd.com>, <tan.shaopeng@fujitsu.com>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH 6/7] x86/resctrl: Introduce interface to display SDCIAE Capacity Bit Masks
Date: Fri, 16 Aug 2024 11:16:23 -0500
Message-ID: <52902dbb00069b4f6685835deab83748a7472b8b.1723824984.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723824984.git.babu.moger@amd.com>
References: <cover.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8c4d35-9a33-48f8-19e9-08dcbe0ee5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tuFHq1cEtNWkZqbsJMpcu3N3f+GBP/AnpqDATpK3/cgYuBmn3/vPyFGadnPt?=
 =?us-ascii?Q?MW6uMthj1lJmIYFETNDOatekffAGUlBrpWrortIVSVuIIEVxkUom1g488Ee/?=
 =?us-ascii?Q?L650H4BCajH3Ya4LKMRgVCrz28sctGQcaJ864O1lK3PyiLCGrwEFwFiGmA/3?=
 =?us-ascii?Q?6lmZom4yQgsPP5z68feHDeGdGtERPh3DfhU/JFDgAB7d/1VoDqUxvrzQdO8R?=
 =?us-ascii?Q?7qQ+Bc5NeMRbh4K6W7p+Q6SwzVflH4p6jkcO6GxBEt2I83ynnGx/jk6hITxq?=
 =?us-ascii?Q?z0tAO7kglY+ZunvmbocX1W2VKGBRC3JEcWY0BZBnFuLELWWiqPlrvSR6RSoW?=
 =?us-ascii?Q?0UhL3vnmAkghQffdejh7WYGMA4WwaH4GbZyq9WRDicKn19JMZC+3FVPUcY/1?=
 =?us-ascii?Q?j4LeRcv/hdYeGcTvfhP8pE6Y+UOh8Pv8DsrY0I3XAk3nkGyAkdPol/b5oTwp?=
 =?us-ascii?Q?ijdFRkTXDRYYMTPN6xg7BCxP0L/Du80Hm+qrSH/ErdfVFI86+QiZkrfZ7Xil?=
 =?us-ascii?Q?riUGBlr15jM47bT+Ch9BJHKqlg0UQP3QXZcgF6YQYxQ2vhhwumUG/2wxdUeK?=
 =?us-ascii?Q?aTuCsJluLmCNOOjM2BzGb7zOonXWZ+z26+REECx81SZ3idSHruKOTz+vQTJd?=
 =?us-ascii?Q?Kb69bzADwXA0JLA4cBg35W9IpRqa253/oJ+F+icgE5gVmQuYgUiqPEiRYh6v?=
 =?us-ascii?Q?cOWZK1t1DT3qdWaNOn5qR8MaPm3vyCahjdJPifyw9+A+2kfKNANTKioYm1YG?=
 =?us-ascii?Q?qO760tPtM57bn6JPcT0mxm4NO5BWyyks3HVwzKRD04a1xWbwqPWE6X85YVCN?=
 =?us-ascii?Q?4m22hOcq/tK6fS0AiIogqtrRJ/AEJFGJkCPh/aaz/S8BnlHDKGhyJfb3rCaO?=
 =?us-ascii?Q?KbGzoguJHSXlfC40oCZgrUXpcEfy4mpoSyUXMSZFGQQx+YgEV320ExiWnKVT?=
 =?us-ascii?Q?ceSDSWP/lPGztvcZ/ceCauNGrViKe0VNCQt1vk/shGVXTlP1ht5XnnoewOZp?=
 =?us-ascii?Q?UoRD+1mwbK/FpD/kOElRhiA7vl1/D+1Ydde6zG7+bdSV2kULRPbvMW93OG3L?=
 =?us-ascii?Q?YJP2gvJGT5Umx4qTLGQlNiWdVIZMVmJfqcOW2P9QMnxhxiW3cwa04uDFh9br?=
 =?us-ascii?Q?/cehKo0DYtuLKD/MjmlQiK/iFEXSD9XguIsZ7zmS2xkJu/RUtP18h1nobr3f?=
 =?us-ascii?Q?PWvNl0A9cly8zeBWXz7t7B4G6AkCj2d6QYTem0uQCWHkHCMiWIdwHOMWtVQL?=
 =?us-ascii?Q?8tnI18RJcDHfOTJZ2wVDUhKrShSn4iGUeHRo0OdLiB/tHyJlnYssxsqjqHIu?=
 =?us-ascii?Q?3nSvg0pz40D0O3yx264DuYdprxggViAkkJoSOrYUGEFkQfoGuEzpNul3mO1v?=
 =?us-ascii?Q?QKVdMNHNlobN1WHcycbwzNCSLG2hxysUkcaPpvKYNG8WoJ9+SMel9TMhemMz?=
 =?us-ascii?Q?jq8Relez9XN0ms8BZhBn22I4Cr4Y50zK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:17:17.3668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c4d35-9a33-48f8-19e9-08dcbe0ee5e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
partitions identified by the highest-supported L3_MASK_n register where
n is the maximum CLOSID supported.

Add the interface to display CBMs (Capacity Bit Mask) of the SDCIAE.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..fc99f4d17e6c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -439,7 +439,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	return hw_dom->ctrl_val[idx];
 }
 
-static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
+void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
 	struct rdt_resource *r = schema->res;
 	struct rdt_ctrl_domain *dom;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9a3da6d49144..f2c87ca37b13 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -663,6 +663,7 @@ void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 void __init resctrl_sdciae_rftype_init(void);
+void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 58e4df195207..51bc715bb6ae 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1922,6 +1922,25 @@ static ssize_t resctrl_sdciae_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+static int resctrl_sdciae_cbm_show(struct kernfs_open_file *of,
+				   struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+	u32 sdciae_closid;
+
+	if (!resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3)) {
+		rdt_last_cmd_puts("SDCIAE is not enabled\n");
+		return -EINVAL;
+	}
+
+	sdciae_closid = get_sdciae_closid(r);
+
+	show_doms(seq, s, sdciae_closid);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2081,6 +2100,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= resctrl_sdciae_show,
 		.write		= resctrl_sdciae_write,
 	},
+	{
+		.name		= "sdciae_cbm",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_sdciae_cbm_show,
+	},
 	{
 		.name		= "mode",
 		.mode		= 0644,
@@ -2187,6 +2212,10 @@ void __init resctrl_sdciae_rftype_init(void)
 	rft = rdtgroup_get_rftype_by_name("sdciae");
 	if (rft)
 		rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
+
+	rft = rdtgroup_get_rftype_by_name("sdciae_cbm");
+	if (rft)
+		rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
 }
 
 /**
-- 
2.34.1


