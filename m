Return-Path: <linux-kernel+bounces-290036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD6954EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE61C21F14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A31BD511;
	Fri, 16 Aug 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W/6+HRfk"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734F1C0DC7;
	Fri, 16 Aug 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825057; cv=fail; b=SPgt+AJtpOEcDQYfjoQ17qXPUOEo44RR2X8XR7GXpkbvN/gohFZk4Am4bJFue9ttRr/ubkcB2bnihFlQbPPl2E2PDLIgf7TakPOnChkZ/K+cEACfAulHN8O9NBq5doaCYW3EjIHiPMUDXGdIwgSF5o7RJM3ueqZWuGabOzpJ/9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825057; c=relaxed/simple;
	bh=oeHyBaBb3Q1l0x7LYqPSbHT9Hzx87MELccJB4R2G5O8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYwg9dftatro54WbZafJwbbjgbHsy584aBiVXEC7+VEiCBkZqo2ZdzWhetFCZItgIW4y0Y0rlwTDBu7WNt8ca6xoD+KNzS/gAkijgw+vFFXaNGy1fXw+ygeMAtreWkvivpbSOjj1Io+ectwJPrivO6bngmcPv+l20/37uGkMop4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W/6+HRfk; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV34BtD44WmmiearMQAFI4i5FOjvdp1uEQsHtz0pQwXzFyrCIcGj2wOGPVzDPr+S61wkeOCww2x5+my/wP+9AglgfTXLCFMOuNVpluFY+cME/ypar3y4yCGYFVR7E70krGn+jJ2PVqeUs5/jQS6TBZGiQLC0JBVkJui7otqhLY2VS9z1nVsLZr7oq1AoGz1ua5DLLDWf5YXnitMonMN6v6l2u4ky2k+nlxcS7nbKoOpwU/NggweLVN5MHdzDcQqEeiAQ27cuUGHTRpeUWXtUaZ83L8ZnYOzK+GD2aL3YDpn9+mKGpyM4iDTF/NjeBOdxKm4ibqkulxtNKEqiftrArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ieo+GzYUkaw8bz4yWe2bUS9FIB9QUsHYb04PKV2hMUs=;
 b=dOwhUIW1qTxurmf45OXheOt4AM81Xyj8Na1K6ptTdWmm01kTh8OAuO7yyziVre/vr5tk0VYS4e/hg4aXvRFgas0sfyXCtzf1ptkB4vnl8N5PxWKlbGSLndoh9bekGVV1ZByr1QwFVg8knYp4GhqjVJUaCowoWucEt5+QlxTM/InjNr8EhIHCKGnPZOjsbycrJnLuJJz8GB7pltZeCEUue1w7OSHMQbeKdHkZWi8NGwxwfttP3UuFmtL6WJljWicU4grNoYB9yewLJqLk0ceWPmB5v6V+cTsUQOOvVSvxs/FAHJWLnMhd36kPprJJfHdxDL44uFKj4AOU9PFvKqmIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieo+GzYUkaw8bz4yWe2bUS9FIB9QUsHYb04PKV2hMUs=;
 b=W/6+HRfkDpwJnomvZ9r4gXqStUxXX61zV4G+6Wg9+q8SR9RjA3NnUrIw3UN2TJ3oT4Ufu+w3NTSeXSUTmQ3JPXDN61gHGusLOC4zJj2JT0yMaVOdQPwueA11mIjJR1wXeElMoW0jDO/w4vBusiPwPBZKQBt1mElNJAxUhXCxUcU=
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 16:17:25 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::2) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 16:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:17:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:17:23 -0500
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
Subject: [PATCH 7/7] x86/resctrl: Introduce interface to modify SDCIAE Capacity Bit Masks
Date: Fri, 16 Aug 2024 11:16:24 -0500
Message-ID: <e8dab641ea14bacbe3847fc1d3fde5be60c4095b.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff54788-5cc5-4f50-c2f4-08dcbe0eea64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3zPoAndhN1Mgzr4wa60hrTWjn2tHWyeoZfGeDbM2FlcDfTOv7dObLkwCkQHK?=
 =?us-ascii?Q?BAs6KQKfYgBuG11kCWacZVwvGxQUXseGEHM7jRV8alUR3VL5nysnDS2le2af?=
 =?us-ascii?Q?jmk4/QPBMS5uAr2hJa0GgyP2yLqUY6mkz206ivhorJEYQAyEgIA//2UzfYtF?=
 =?us-ascii?Q?JKofYFtOuysoTO/3oaVaapBZ2vUHDhlHt/EZFO4IDkAMB1xMoKHTRfdq37Ef?=
 =?us-ascii?Q?aEjdFS14wb9ta1And9tPD+8ET+g1ey47zUA1CiQ71Pchik2YquOkXtgJz2XY?=
 =?us-ascii?Q?1R3CKhMEk6hAUBiM23pRbBcxRTVgQWwHKJQmudQWpjt+JVj+8EjJZvFQtfUB?=
 =?us-ascii?Q?4uo3psDHa6iO3T0uRl5MU74qPHMb7ENl9lEtmoLcFfrR3tdV6+5+o4W7Q4CS?=
 =?us-ascii?Q?7op9ULMFVniYynrhdrS685gfiF1HnPvqK79nrA6MSBchL9sK23pPkspSmlBH?=
 =?us-ascii?Q?QpQ2+sAWlShBM340A50mxb2fAmVRln0S01eCxmLHxJjA0hgeDPUq5WIjyaem?=
 =?us-ascii?Q?l/A2onBWROULzF0rEKcW8FjFDWZVeHchRYUhBSh8P4EfSC0hejXD/8ye/z0U?=
 =?us-ascii?Q?d87fi4zPQiKTtEdvksiLV9LH+WsSZcAeQXYKScibDSheAsBaaYpAuPFBffNI?=
 =?us-ascii?Q?z0u+zzwmct7y1niuJG2knMXzbI7hSqBbrJJXYoWiQ5Zt9u0vdptNjalNIvTo?=
 =?us-ascii?Q?LVoUkG3GjpvlTuFoC0TEvSdxD5O5l1xQ95Cojc6yQ4RIwzX2eDXXU7POFjVY?=
 =?us-ascii?Q?jP44lTKjDGLLKlN4DIirsOYYgVrQF/v1rLFKrNfWiuZllDFAN6gj8cqYvLBR?=
 =?us-ascii?Q?+KAJfqEWL3W0R4KheeNTN0PAb9U+hU5eY2lTGRmwgs+H7LKi+uJVVY/TqzNA?=
 =?us-ascii?Q?f38uIdxLQVB29/1+YFXW0+To7F2sGr2FzDlJTASVKLjNqF+x8iASqeb9eNQ0?=
 =?us-ascii?Q?YHnD2qo2PUnZImBSDHfm+aSTqtitjQlePGM/nI6EfgRTjjGO+UfWgFEbaYt0?=
 =?us-ascii?Q?SUyTvqISGmjh5c06+KGRKdwyh+3xRsJ1Zgf9nJzRmjnIe9AGMjRH+iFHVyVq?=
 =?us-ascii?Q?0X5EFFDLo77GkofTUNauyZklyQZB0XFxKwVtVW+KrvxLRk8gnqa4ufOBQlTo?=
 =?us-ascii?Q?27RwkEj3jRy4c/XEF/3POeAlBWypB4NwWw5+xNuMBIHs95+IbrnWLBIFtCvC?=
 =?us-ascii?Q?0aM5z0ziVCMBSxOKWCyopQmMf4fngVsSJTCfLrwECwNTWcUgoMlttIFH0szx?=
 =?us-ascii?Q?eJepfpiL/xoQ5jlsSu23uBs6trCU8aQlP5nrLwPukLgav9BCRoP1LtMGkEmy?=
 =?us-ascii?Q?WwTTOcyVvyYrnAOf0CeDfhMbtZdPFY1J3cSoAWJJx5uGnajIxmEHIpqVg2DV?=
 =?us-ascii?Q?wkdMXpBwi4pn5c1IrTKPVN/L5y+I/YnCWPPs6+rCDeEu1txtWiabAGH27GVR?=
 =?us-ascii?Q?KCDHXn3hTMCmzj3s9bTK/rK3k43XvyR2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:17:24.9496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff54788-5cc5-4f50-c2f4-08dcbe0eea64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system
software to limit the portion of the L3 cache used for SDCI.

Provide the interface to modify SDCIAE CBMs (Capacity Bit Masks).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst        |   7 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |   1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 122 +++++++++++++++++++++-
 4 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb1532dd843f..33de17387980 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -157,6 +157,13 @@ related to allocation:
 
 			# echo 1 > /sys/fs/resctrl/info/L3/sdciae
 
+"sdciae_cbm":
+		Capacity Bit Mask (CBM) available to SDCIAE supported devices.
+		CBM can be configured by writing to the interface in the
+		following format::
+
+			L3:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index fc99f4d17e6c..cf39eee5fba9 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -97,7 +97,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
  * requires at least two bits set.
  * AMD allows non-contiguous bitmasks.
  */
-static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
+bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len = r->cache.cbm_len;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f2c87ca37b13..66428950a326 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -664,6 +664,7 @@ void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 void __init resctrl_sdciae_rftype_init(void);
 void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid);
+bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 51bc715bb6ae..247909461ab3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1941,6 +1941,125 @@ static int resctrl_sdciae_cbm_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * Read the CBM and check the validity. Make sure CBM is not shared
+ * with any other exclusive resctrl groups.
+ */
+static int resctrl_parse_cbm(char *buf, struct resctrl_schema *s,
+			     struct rdt_ctrl_domain *d)
+{
+	struct resctrl_staged_config *cfg;
+	struct rdt_resource *r = s->res;
+	u32 sdciae_closid;
+	u32 cbm_val;
+
+	cfg = &d->staged_config[s->conf_type];
+	if (cfg->have_new_ctrl) {
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
+		return -EINVAL;
+	}
+
+	if (!cbm_validate(buf, &cbm_val, r))
+		return -EINVAL;
+
+	/*
+	 * The CBM may not overlap with other exclusive group.
+	 */
+	sdciae_closid = get_sdciae_closid(r);
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, sdciae_closid, true)) {
+		rdt_last_cmd_puts("Overlaps with exclusive group\n");
+		return -EINVAL;
+	}
+
+	cfg->new_ctrl = cbm_val;
+	cfg->have_new_ctrl = true;
+
+	return 0;
+}
+
+static int resctrl_parse_line(char *line,  struct rdt_resource *r,
+			      struct resctrl_schema *s)
+{
+	struct rdt_ctrl_domain *d;
+	char *dom = NULL, *id;
+	unsigned long dom_id;
+
+next:
+	if (!line || line[0] == '\0')
+		return 0;
+
+	dom = strsep(&line, ";");
+	id = strsep(&dom, "=");
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
+		return -EINVAL;
+	}
+
+	dom = strim(dom);
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			if (resctrl_parse_cbm(dom, s, d))
+				return -EINVAL;
+			goto next;
+		}
+	}
+	return -EINVAL;
+}
+
+static ssize_t resctrl_sdciae_cbm_write(struct kernfs_open_file *of,
+					char *buf, size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+	u32 sdciae_closid;
+	char *resname;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+	rdt_staged_configs_clear();
+
+	resname = strim(strsep(&buf, ":"));
+	if (!buf) {
+		rdt_last_cmd_puts("Missing ':'\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (strcmp(resname, "L3")) {
+		rdt_last_cmd_printf("Unsupported resource name '%s'\n", resname);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (buf[0] == '\0') {
+		rdt_last_cmd_printf("Missing '%s' value\n", resname);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = resctrl_parse_line(buf, r, s);
+	if (ret)
+		goto out;
+
+	sdciae_closid = get_sdciae_closid(r);
+	ret = resctrl_arch_update_domains(r, sdciae_closid);
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2102,9 +2221,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "sdciae_cbm",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_sdciae_cbm_show,
+		.write		= resctrl_sdciae_cbm_write,
 	},
 	{
 		.name		= "mode",
-- 
2.34.1


