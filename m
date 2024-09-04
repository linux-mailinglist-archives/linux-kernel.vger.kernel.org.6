Return-Path: <linux-kernel+bounces-316050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F0796CA60
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514E228C004
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE841925B7;
	Wed,  4 Sep 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivZ0C8ML"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25AF1925A4;
	Wed,  4 Sep 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488679; cv=fail; b=OEnvKpcTtp+JqHGouRVrTublQnj1l2FQ2weOBucf5tXilvWaW16s1djcy7rzCx3rolbirhOrTbWM47XGNTlBRLo1HTwsvjcWN3hQkpO2GAXOVYIp8iPdsKT8Vs/xYrIXkc1mj90a4zKq3fjN9qXrPRUXlBnIMEtPTgQNCSn6kwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488679; c=relaxed/simple;
	bh=FI1GDrsQ48wU7DXykC9DGCejCGG9X7qI5s6BMHqZdEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG1hGcTUJPLOp/tpYDSFVNRUKyVSGBisTVkS12qwtVnW45JH5LpDPSrosVTXQPVObCkVhGbzJOkwo0vwfruvI/8g6JnkwWqZK/I4XJNiIeae2KKjwLSF9eHPleqxnqrcc+JDLG4g4cTsVT1EDcokCLVCkP+Rhp0h1tmVjGUQxoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivZ0C8ML; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/JpWlRax+0hm5wxhYPED7wxY0NvwLNgVDgSlidfXrgPZ/K6IXl/Q/xZJTdJZzD0KNNgBMe0TwdHdN9pC+bNCO9Ty+hyUecKy/PZmpMCy+UgoCZjkQEkmFwreD6qFcN7nUOM/79xsS4Q5W1bW6EVmqDTvY+ccDEifwBxTlH0nnvHmYUi2h62bYD+YBRQJLrYS9NQOQRRIWbgKW5yPecNdHneP5zfu5b5Rk3kZmgHFBVlKHwcg9Nu8lmLVCuCGgFuFcXdwe0xuWSh4u9laz17nsjQaFIkR8vhfA0heuGweH9ISEaoSzRYn41XzMycrerCY5QCH4kh9tt7PnoZTygfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWnT6HD4f9TluS54AzONt24QVWfbzlV3nLAiCxSgOLk=;
 b=TjOjmukeU1e5Mz8HbvZvLD9POPsoaycgcV9gU2F5PdC9azSdfmnHEwqSZtGgf61VeE7PZNK2E5k7QAxu9YutyW/wg4SYiBwU/deVj1ts186UbnfNkjw5dNJ01m6bI4CxSkeBki8JG5mWRbCLto3fd0ytecqkf+jCY3hU+ZrcUWXmgEUccfVYX/hhRmbUgN6+UHjsba7OkSpKjtW+vtbIMklU+b7CXILMyHV184oiMj/6iNZt9j3fdXK38wud8+M5asgIKpSK7DgQGSCKq3xMJkOl7hibrzxrkm+tp1vCAorCRyMaL64peVzgWKbQdd0+pFZXFdVSkai/bqWq01ayBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWnT6HD4f9TluS54AzONt24QVWfbzlV3nLAiCxSgOLk=;
 b=ivZ0C8MLs+UejS0OudnDZlx76oVnuFEr+BI0Lw+c+OAO8N4lDWz5/2d8NhRCDUJqjUMOcRaK7y9g8dM0A7vvrCa6fRw0Jh3x2ap2ftie/5V/PHRUsSk8rZUMQ1rZ6R7cFjWwDCg4mdvlX5pXEBb/6r/dRd4fG4volDtBXhRSwvA=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:24:33 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::21) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:33 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:32 -0500
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
Subject: [PATCH v7 21/24] x86/resctrl: Configure mbm_cntr_assign mode if supported
Date: Wed, 4 Sep 2024 17:21:36 -0500
Message-ID: <d5687ef178320866b823445176b10a411e0e5ede.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa820f5-bcfc-403f-f4c3-08dccd305a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3CHltTpOgsJ0BIFqyPrewb1tihc0fGQq+jYjTSixeg1WbMUvbY4B7xktz7o?=
 =?us-ascii?Q?OizqNQsyj6xUNEyB7+9XF5aUteuVzrUDLXYNSZJe6uUFlw97r0BtuN914INJ?=
 =?us-ascii?Q?6PJt4nf+x8uvl7fAxWVLxDixmB67KvfeKOG8XGUStdpqbwPrxyHLEDwNGFK2?=
 =?us-ascii?Q?0KmozRej+VqspgwUTacVUz2qFH/qx1Eqchan0AFyWPtmj8h5I7GDclVkoWUb?=
 =?us-ascii?Q?Fdx8XEnJ99Lh/Jr02pOclkpzogaNMf+JohR+8tjKGoCLMDE7cLRO9R/KOQhp?=
 =?us-ascii?Q?Mx4Nj7F0BolSLJTbpk5/bY7dkmbpbBQjHvTQx4ZFYzcbZTIEF0LzsdoTf+tn?=
 =?us-ascii?Q?1zYm4mVf9cC+amdfEF5A31odw0rT+wqkBchtOYKUYB7QZBEvtBFd9UIN1D+I?=
 =?us-ascii?Q?LDsGEtNsQn8H7zCNrBU2OURVeirxSWuTLZw1pqTU6Zw8GRc7LHMq1iuwazLu?=
 =?us-ascii?Q?NK//EpLD6RAegxAqHMSfwdrTXy8zok15V7bIirOl4N6RfG6jJNbK3rkLe0jF?=
 =?us-ascii?Q?eqVALdWJxMoxvWkE5mpYmOu0cNMGcasElzNqXaBPoPdgwDOufIwpIlC9CqIR?=
 =?us-ascii?Q?Lj5wj1wUBkqMsoUjKdTucDGSN86l1xRa2tKmoVg2Hb+5FhDQIM4yvIxVkE4X?=
 =?us-ascii?Q?GNiDmDEaOUbp/NpyzJve5LiAvtZLvAjjhlvHAZ/9UrpI0u50BZp50BLbzCIC?=
 =?us-ascii?Q?p4Q6x3wTqmZmRhH64wSwQICPteo5T2ow1g/8tUVFl97uoMR+oRPIYqHDkuLV?=
 =?us-ascii?Q?6boLs11dBAda7VpEpkoWmaDWn+GU6836Ch3b+d+kFlEgsuwUaqK2zhZh8Z31?=
 =?us-ascii?Q?8ElRb33mF96VAOixwzAjixIdosYrFQnVcAFnkh+rwK+eWeR8HdVEIRbJZSsi?=
 =?us-ascii?Q?MfytW8vp2YwZiFnBJhlwAZCeefCMTt+vG2qSbFEvE/y2DZLM/yOYbTX2yp8I?=
 =?us-ascii?Q?kOwohkAL5n7sCvvmKxo/7BYh4rWoZT3xIaQkwe60x2EITjZp50XTe2o2cSE+?=
 =?us-ascii?Q?bNHKTru55t4wvKkC1LKrX7Uqq3xLF8kx7/lbp98/r2NOCK4M2HfLXJhBgJ/G?=
 =?us-ascii?Q?HTu6pApBLkvk5JJXNM+0+2ujugdxiP0elOCgl9pTzK79TBuE3qJquAtrKu+n?=
 =?us-ascii?Q?MFzxncQXuYDvqgm2vtYGs95ONwZ1LYfKGHob64aO/vllIx7GvpqCgA7zQ0AF?=
 =?us-ascii?Q?k27d4VGezZBhyVtLfiBJCCH51RoJdVSPNyRcvxJ1+EZKtBb9/FerGbpJtdE0?=
 =?us-ascii?Q?lHFjUKKVFuXLbBPF81AZ6M/1c41ABYWTAoPlw7MWYi/pmVDXmwPAwEge4phS?=
 =?us-ascii?Q?m9PJmsI8ra1ZRpiwpiprdmajcShAMW6qqcgu9tSgOzZajUhV5kTkDY21zCqk?=
 =?us-ascii?Q?lxC0ECXzLZygSF1WDYczC+H7+lzbJnKMzaze4L1G0U+ZY8Rxm7Gwqd4e29kX?=
 =?us-ascii?Q?R2Hta3tXpDJa7Vp2iVTWKgPXATNyZm3v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:33.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa820f5-bcfc-403f-f4c3-08dccd305a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

Configure mbm_cntr_assign on AMD.

'mbm_cntr_assign' mode in AMD is ABMC (Assignable Bandwidth Monitoring
Counters). When the ABMC is updated, it must be updated on all logical
processors in the resctrl domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Introduced resctrl_arch_mbm_cntr_assign_configure() to configure.
    Moved the default settings to rdt_get_mon_l3_config(). It should be
    done before the hotplug handler is called. It cannot be done at
    rdtgroup_init().

v6: Keeping the default enablement in arch init code for now.
     This may need some discussion.
     Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.

v5: New patch to enable ABMC by default.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9a65a13ccbe9..3250561f0187 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -709,6 +709,7 @@ int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+void resctrl_arch_mbm_cntr_assign_configure(struct rdt_resource *r);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 09b1d8bb0aa0..314c0b297470 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1261,6 +1261,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
+			hw_res->mbm_cntr_assign_enabled = true;
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7a8ece12d7da..1054583bef9d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2726,6 +2726,13 @@ int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
 	return 0;
 }
 
+void resctrl_arch_mbm_cntr_assign_configure(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -4510,9 +4517,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 
 void resctrl_online_cpu(unsigned int cpu)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	mutex_lock(&rdtgroup_mutex);
 	/* The CPU is set in default rdtgroup after online. */
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+	if (r->mon.mbm_cntr_assignable)
+		resctrl_arch_mbm_cntr_assign_configure(r);
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-- 
2.34.1


