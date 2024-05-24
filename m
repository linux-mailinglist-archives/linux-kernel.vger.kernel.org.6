Return-Path: <linux-kernel+bounces-188673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5688CE537
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05630282531
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F328627E;
	Fri, 24 May 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+W6JS/c"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6D8626A;
	Fri, 24 May 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553476; cv=fail; b=dftnxm2lcT6J2+B8/K2PWNsJYU4NI3e6QfP7/TCM0zMG6DJrNiKZmMdzniRzAAfjT5X7Y812hnkx2qZixLIsiF9/PO23PB8Jud6CBbU5Kdc+4bh6gG+hOawAJrUmjXy+TMArOeuNRAkJ61VNepf0qJQYDjt3D3BHe+9IrYlugdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553476; c=relaxed/simple;
	bh=N0wbudY26hHwlJliMovRmEPGVkeQ//SoWxdHoDjtX6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qi5pnfYTE3BWDzxGwI5GxiWzcVN6NFsLM0SHur5umS9AV/hFnOltubVWEZDHrfm14CMxPN9xYQN+uKUDM5b1cEbdeGYI9JHvXP69BUoj793GuUSoSe4hNkWvuq8Q2MzEWqsCM/JX56i10+BXpflhNGfrEtMHjNZsabsBb1EqiXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+W6JS/c; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGJvhC5s0DdFz6OIU+2dVuCPK3dGNU6cgGq0Sh+A03vVOXaHd+4a6JnoiOeJ8reWBFLNp30CNzcwv6uF7SOSSy/u/namtJbOnKOla5sAFgwNA9DQU0Vd+mi7xycp4gxFecmH5jrloSmMJRqCv0bj5UeXEyWvgVA/SFI8+ntRVsw/TMlVhw6qsWzCPvj2ii4+Bm2A07agWQ1xK3PEc5p5TtMnKEhei+AczRu7fGWatyOjyjGoJc5UKxdMQ3qhqi1+PYvSwC1YXcAv+PyFrNbkn+rPnLMzvpEKQqsw9cZlLfR+4+pq2b8z1mYzv7Wc4coiNwjQU0X5x7Se4rKdSMGUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPmuYGnFDh4Y5FqMAoiFBeAoDJwi1vo326t3bD2PiKs=;
 b=BgBxYMSz0eT60Cdmz8XQcKqTWbzwXodwbEdFAw3txAWOVKsRsNOrYMFFmVC5i6EgtXhswaY234h9I0Cpkk28Ad1la3Jsat2iOk3Y+wZPoAaZfnWTLwRiHM8MeAKpV7mPhQKwtZXvGRtO7DIfABIcq81bP4trLNpyRxF7+71482LFKQA5qH0we8Jjw4Cwm/lWLyuk9MeMtgXzPq/9oylAOqVOIFnaLSSz+ZmSSQR8c0N5qpS2TmtTJ5/2YiyemDQ/VAGEeorKQ1KqUyvJuMgr92DPG9gMVoFKur20+dkyEVwTePDChnayf7viTTiMJkjtxPHPVqWICj0rmEF+JYVg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPmuYGnFDh4Y5FqMAoiFBeAoDJwi1vo326t3bD2PiKs=;
 b=V+W6JS/cYgtYYmKRIJiexRICBR78YGm+rwMRvvts4O52fcm3F7/AE1khhtBEbv8YvDEYmdN9nDtQkOa+2TSbo0eN8VhfL9CPkDmKeciDIE5DXlXIoO0JDQcCLbqfB2JUj7XH9R2SCs7PSOmfJYFhvP/MzgBL/W9AKpuf/amx8bg=
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:24:30 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::95) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:27 -0500
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
Subject: [PATCH v4 05/19] x86/resctrl: Introduce resctrl_file_fflags_init to initialize fflags
Date: Fri, 24 May 2024 07:23:24 -0500
Message-ID: <67c8cd614925496971496a8fab7459cf5c037652.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c47496-2f84-443f-42e4-08dc7bec75cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/RkYTvzVfueFtHJwWhv0HTjxsnFgQzfspz6lvuRrRvNW1i2YfDVhd8IiYjv?=
 =?us-ascii?Q?JLK6mat3485fbGicBwmtDF4IUC/5SxgHvKe4cbko7sXT204oq+eDYkucVsGw?=
 =?us-ascii?Q?yHYHPBpNzIM4GDquu3z3oVQU1bGF1AujAPl/2qO4H0mxb2giMWv/Q+9pBZAg?=
 =?us-ascii?Q?nEIx7ltwx20dwWGhMS8a3tADC3XY0DQOcd7MwUPhpU+1skeG69CyoLkaw7sY?=
 =?us-ascii?Q?H0OmXUnVYW+rveWpDeh61C/oMNf5/okM+HYH9WxOpNG89A+CAjukkGhP8chj?=
 =?us-ascii?Q?Y8EV9i5Rp6P1FuCH3siSiIyXmZ9AFdAYGmQot3f+2bO1y0u9b+MbmIEsb7wU?=
 =?us-ascii?Q?lCZeDXgcGlnXyChn0wUJgcMEjM5uTZPcXjcA1iGwLhyxsFUx2HmAMxNIwH8v?=
 =?us-ascii?Q?KtL8PKGemNxdYuN5xJHDgca07/FY9cSUXV/G8SGyeoMFLBfIm2XIp7xSQ2EK?=
 =?us-ascii?Q?8ql0E+7xrKicSgtnoW48LrI8S4pgNT1UO+oVrwAUlLlPJMWsrYRTXCx7MnBv?=
 =?us-ascii?Q?bjhYpZ2315nZbsqyW4IybGe2ouud1c1jPzGgz/dboQ5/EDKRfRZBIptRkgAD?=
 =?us-ascii?Q?C4MM82xAfKvd1lu4viydnQe7CZnNGntnTkykvLlWvQylDVglBjaRwLKPA1HH?=
 =?us-ascii?Q?pCCRjR+JphbVfmzD+3M4NSBDZau/qjlc24+Llr95xfs41o9IMGqiUp+7DnyT?=
 =?us-ascii?Q?zVhKPzSKjMdbqFWh7J3F9ewcll/euehT1G7ligaHrpilcnIeokwGYr8XJDUA?=
 =?us-ascii?Q?Tabx/gyqrTxk1tAU7RQHDG1ztaGPjsYhP3wcZ5GimHTpnCobYCRRK7d14kMp?=
 =?us-ascii?Q?MWcYMFFgfjYvqQZKs79lafF59B2BrASWkwowuoSV3Rn1RzMP7Q6uWHKUNoj4?=
 =?us-ascii?Q?wE1FLPj2/2je0uxmZ3DerFHhFK6PWg5QFmjOlAq5rJ2gHH5SO0XMilH7pkBu?=
 =?us-ascii?Q?uyy/ZwbvpPhIIcstroXTXyE8njDh48ItsLGJ99oWXC+e603QriTUpklBkZL9?=
 =?us-ascii?Q?tXD81R8Fa1ilvAvWD1DDxSwI+g1xeb18k3+Efk6pj8pvo1kXQWTwwjPxEiXI?=
 =?us-ascii?Q?x6Jc2/xwLi4IaX4WDHmezX3izHoZe7xuFro0YLtLx04op+KuOM9niLnuV0gu?=
 =?us-ascii?Q?Iyb8k+Xeie9DIXVnWxFKcyc97TDJI/Vfov52bAdScZVNGuSpzdhzGKww8K75?=
 =?us-ascii?Q?sarc76AMhSFD5wirRjFGJyGR68cE/rXNeDqaVyv9XQcyFR/BngoTVZCeCKuK?=
 =?us-ascii?Q?Rb2TeBncrYae6wQVrpIH3fsnx3wz7NyiCQ5USOy8qsgjouEskn0tpCozipAX?=
 =?us-ascii?Q?o21pGvEy46/G+d59j0biSnyagx0aq4r2buPGYJk66tFKSWAf9wFNGr9v30DS?=
 =?us-ascii?Q?yoOQgQP82pBEuS8hLB2pVYxKJMko?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:29.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c47496-2f84-443f-42e4-08dc7bec75cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850

The functions thread_throttle_mode_init() and mbm_config_rftype_init()
both initialize fflags for resctrl files. Adding the new files will
involve adding another function to initialize the fflags. All of this
can be simplified by adding a new function resctrl_file_fflags_init()
and passing the file name and flags to be initialized.

Consolidate multiple fflags initialization into resctrl_file_fflags_init()
and remove thread_throttle_mode_init() and mbm_config_rftype_init().

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Commit message update.

v3: New patch to display ABMC capability.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +++-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++-------------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6cf3c887c693..ec93f6a50308 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -224,7 +224,9 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f1d926832ec8..d566251094b2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -603,8 +603,8 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
-void __init mbm_config_rftype_init(const char *config);
+void __init resctrl_file_fflags_init(const char *config,
+				     unsigned long fflags);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1602b58ba23d..0db9f12debb9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1060,11 +1060,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
-			mbm_config_rftype_init("mbm_total_bytes_config");
+			resctrl_file_fflags_init("mbm_total_bytes_config",
+						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 			mbm_local_event.configurable = true;
-			mbm_config_rftype_init("mbm_local_bytes_config");
+			resctrl_file_fflags_init("mbm_local_bytes_config",
+						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 
 		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7114d58ef1e3..aa3eb6ea059a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2022,24 +2022,14 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-void __init thread_throttle_mode_init(void)
-{
-	struct rftype *rft;
-
-	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
-	if (!rft)
-		return;
-
-	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
-}
-
-void __init mbm_config_rftype_init(const char *config)
+void __init resctrl_file_fflags_init(const char *config,
+				     unsigned long fflags)
 {
 	struct rftype *rft;
 
 	rft = rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags = fflags;
 }
 
 /**
-- 
2.34.1


