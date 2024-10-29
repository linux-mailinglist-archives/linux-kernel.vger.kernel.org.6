Return-Path: <linux-kernel+bounces-387838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E79B56C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5E828221B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18020C495;
	Tue, 29 Oct 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2jaWM5i9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FE20C493;
	Tue, 29 Oct 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244233; cv=fail; b=bSEiVsDAoMtrrBl6tdqClK171Jg4FqNXOine1dXGKnEgO+OgBct34VoHE5vauKfcWJJrXZmRqhdREdtX+naGCMV7Dx811C9l5414UZaXasmn9y+lsYCIWygBniJ36NrFBzuRJM2Yeo1nNsm2jqSijiSoO1+iKCKAvT18tDw20eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244233; c=relaxed/simple;
	bh=nCuO+Vv2mgcXXbVfbB3I5v85C3HVDXBVS9FASdUajS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhSX4wjK6pCrpj3Mpp818SDW6Fi9qCX/mZQTohA9+KL7EcJ3jNmuGJWI6X6ulBTatoTFUEYckO6X8SYsQ1PH8Oe2y3E1ElXu36+1XroDcI2yfUXOmR22mtUpzkVRLHo0lKs0reLwfM5l47elmjO3uMmk3BrU+QoVw3M3VEBaQXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2jaWM5i9; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5PhOPYWpJJLqkzSe1Xlrk6uWwAPNCNw5ZJpsJlTngvVMLFhZnJAnNBJNV0yYMhEiujtx8S2+0o8+Kp96Xk2GFXOh9NOJfKD7MIKoCi4Ju4W0oUC/CzZFtrqBW7muNpawa0Wa+CrwJTzVRPPfEkWXQhSYfmv82VG7m9YxC1RfJD1sQoBzo8DhoMG600B2elxQKOXU0lDhq2oT4hjsBtcgne77z49RKaPNGLv5iisKHsPhZvTdBRsQhlg7qpcTgcQFkjAVIdS0WPr7I7xAL/9SSS4MntYzzaOmOzioZtqr6u5YtmK3o7hsiEF7NT/WbZUCFM/t1XLQBEUWVi7zqi+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STS/1bVXOKa7pUwinRf+BzeIByynmucKkkvfKknqXu0=;
 b=CrTqzxJRbZNxwyu6ZFelwM3ihdZ40dZrQHtZM/wp86OHPyARvO4rM7XyzbX3T3u17gDlHUdbSpzu/nIuGVa5km/a13AOGsFULhSJftMlA3wO+xKi1ibtdDIrFYcsUsaVD+VAbGQrvdz9rzMoWabgBHKkmFM3TDbSAIAQK4USw5TxTpQELQ/SzyllOsMUSN/9kBUUNdslmZcTtNJCM2zMQL2ybFJyHUnofNb/+GeajQkkfA2dFArVVIYAYXVPwKzT2EF6aWvwgDAZ4G7AxNlwD+e/fzH0adELVrFYjRR6WDaHHFMW7i9kdpbqZl7TYOF5OtcwG1FM1+weHTKzlf3aKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STS/1bVXOKa7pUwinRf+BzeIByynmucKkkvfKknqXu0=;
 b=2jaWM5i92qY97jU7mnPpnKBwfXavCpKKMQ35cLCDZ67ikx3rAywu8pl39O1vauxSWpoyTYXUGLSJkkPWnJh+N4p6UEiFoROLD2yre6R2N14CFrzZmaRX7W3ZgrpifLpzf62yoFauiLBaiu3wK5wzzldoLHE5Rcryb4bW1iUGcjo=
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:23:48 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::52) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:32 -0500
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
Subject: [PATCH v9 10/26] x86/resctrl: Introduce bitmap mbm_cntr_free_map to track assignable counters
Date: Tue, 29 Oct 2024 18:21:42 -0500
Message-ID: <d9a18a268ece764a18a177ebfddb9899e53314aa.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: b17a2f03-4e09-4870-19fa-08dcf870bd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNdJ6NOeSjMWGdOozCZQv5UhlP6R3BdcwfqPzt+2+Z9hjTokB9zo/8+zY2eR?=
 =?us-ascii?Q?Sr/cQlpBUXy08pif+NfU5TZ3rDVZx0M727k4a54dZLtNrwK9lELYkZrhz5MX?=
 =?us-ascii?Q?ExumD5Hc8EYa114cVoBSfacbz3Skot7QyNN8oHYDbODXz3M5qVB65KFcnVgZ?=
 =?us-ascii?Q?oWZ8pMQYdzoM4eNpm9tsWxTh4p4Fj22etVhDgH0xNq8ce4Bb+Ng0/E7eYvx6?=
 =?us-ascii?Q?F7C4t2YRjFwQISZTHRrJUF9lrYdMW+1iDKqqWVA3L4R1tHk8wqwA1cgz7qMe?=
 =?us-ascii?Q?xBRQr9Ekqnx2tDJNTHjtB/WFaJPJdjz37wC7vUwb9d8sX8Arowrr4TwBIFPc?=
 =?us-ascii?Q?JxNcW3sTdiLCN39bJGysAhz9XcXaWK0llxU3kNWVzd6icGJwCj9R+Krtw3mI?=
 =?us-ascii?Q?Vq+w7uCDgoCNGSqDBdvO0CfMaotalCQQtisqwe1NEZkwYYxgm7PGHb+pzr3M?=
 =?us-ascii?Q?WQjGobLQnnD4lUa4KK27twPdNuaegN3CZKqYvCO6Hje6L0wz9UzwIPceMzsB?=
 =?us-ascii?Q?c4Hnx18sBUdtQmO7gFBsq2G4EY5wNNek5hkbYUCrqiAahlvKwpF48Tpjw0G7?=
 =?us-ascii?Q?wBj5uIjuJtT+iMTcyM1QeR6nYTMhYUXsgsJHnYdTZMuu1xP/jdnZ9T/bsAEA?=
 =?us-ascii?Q?NbLRmO38JiUBt4+vDAva6yrJF+Ik1nFPUEU4mMvINrqyafg4GrdBWlrROTfX?=
 =?us-ascii?Q?b/CW0HRM6Nnrj/1XlZuEmuXwxYMdPVtu7NQ0bTFJu++DUjAQApleVXSAWSGO?=
 =?us-ascii?Q?Gt/6pZ6c0Lt0Ou+wWgKw+03lZSw5r8psc9J4nCmcgfsW7P2YYieinmdAmsJa?=
 =?us-ascii?Q?3/ayYXFUba61fVkmmcoAFH9G85X9HBwIr1a+ocx6Jg/uK2ZkeIKzDrSl7Npq?=
 =?us-ascii?Q?AmxiJzixgwHXj/MKWYzQlXOATWYzk0aH/UwKy4jZ6tlRIHGLDjK7fH3f0uAX?=
 =?us-ascii?Q?Ep+uJypZGm95x1FkTeH1EdSYtehmjr2f3tdwCttBaB42uG8S6Ra4h1MNxzIr?=
 =?us-ascii?Q?tvDJiFpMMT5BUSr0HeOOouPoYWUAc6BuC+bMiFpf6x8460CkGYKrVZBOsQU5?=
 =?us-ascii?Q?3VjZcgcgijAlFf9pQAgb8JuPMe73Jrf4+nStiuUijMcxIalJE7UB5TckQGmF?=
 =?us-ascii?Q?Uq5IhQ35YIXuJBq0jd8MakEbyZ7yACkzC3XYLVNpKXS0cgQTkvtma+oA068u?=
 =?us-ascii?Q?61TpQa+Xd2vEl0c2NQTwEnAQ/zkomcjOtw95YFDAIa1/xP1e3goALnAl/W0l?=
 =?us-ascii?Q?jzNjLMhLDnfTlIQBpIv7afdmE2Vyn4R7Z61rom9muDmMaN9hgDQtGZ+PmPhW?=
 =?us-ascii?Q?VeVPlosFsW/NN8JJym8A3Pfml2pVOYkQJpHej7PAEpSbhngTgDf1BPh/sM1C?=
 =?us-ascii?Q?uu6Q0A0MN1FuT1YgLc3DQnsljRKm4N0d+e+XXVZ4KpRV5NixTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:47.7907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17a2f03-4e09-4870-19fa-08dcf870bd7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361

Hardware provides a set of counters when mbm_assign_mode is supported.
These counters are assigned to the MBM monitoring events of a CTRL_MON or
MON group that needs to be tracked. The kernel must manage and track the
available counters.

Introduce mbm_cntr_free_map bitmap to track available counters and set
of routines to allocate and free the counters.

dom_data_init() requires mbm_cntr_assign state to initialize
mbm_cntr_free_map bitmap. Move dom_data_init() after mbm_cntr_assign
detection.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Commit message update and kernel doc update.

v8: Moved the init and exit functionality inside dom_data_init()
    and dom_data_exit() respectively.

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
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 49 ++++++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++
 include/linux/resctrl.h                |  2 ++
 5 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9603f5cb483c..02ccb4d2955d 100644
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
index c07a93da31cc..8ab59d59c15a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -633,7 +633,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int __init rdt_get_mon_l3_config(struct rdt_resource *r);
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
index e0d8080dcdcf..185ac210d46e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -983,6 +983,27 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
+/*
+ * Bitmap to track the available hardware counters when operating in
+ * "mbm_cntr_assign" mode. A hardware counter can be assigned to a RMID,
+ * event pair.
+ */
+static __init unsigned long *mbm_cntrs_init(struct rdt_resource *r)
+{
+	r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
+						 GFP_KERNEL);
+	if (r->mon.mbm_cntr_free_map)
+		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
+
+	return r->mon.mbm_cntr_free_map;
+}
+
+static  __exit void mbm_cntrs_exit(struct rdt_resource *r)
+{
+	bitmap_free(r->mon.mbm_cntr_free_map);
+	r->mon.mbm_cntr_free_map = NULL;
+}
+
 static __init int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
@@ -1020,6 +1041,17 @@ static __init int dom_data_init(struct rdt_resource *r)
 		goto out_unlock;
 	}
 
+	if (r->mon.mbm_cntr_assignable && !mbm_cntrs_init(r)) {
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+			kfree(closid_num_dirty_rmid);
+			closid_num_dirty_rmid = NULL;
+		}
+		kfree(rmid_ptrs);
+		rmid_ptrs = NULL;
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
 		INIT_LIST_HEAD(&entry->list);
@@ -1044,7 +1076,7 @@ static __init int dom_data_init(struct rdt_resource *r)
 	return err;
 }
 
-static void __exit dom_data_exit(void)
+static void __exit dom_data_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -1056,6 +1088,9 @@ static void __exit dom_data_exit(void)
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
+	if (r->mon.mbm_cntr_assignable)
+		mbm_cntrs_exit(r);
+
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -1210,10 +1245,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
 		u32 eax, ebx, ecx, edx;
 
@@ -1240,6 +1271,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
+	ret = dom_data_init(r);
+	if (ret)
+		return ret;
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
@@ -1247,9 +1282,9 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
-void __exit rdt_put_mon_l3_config(void)
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
 {
-	dom_data_exit();
+	dom_data_exit(r);
 }
 
 void __init intel_rdt_mbm_apply_quirk(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 339bb0b09a82..a4b92476f501 100644
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
index f11d6fdfd977..afe3b22d3e60 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -187,12 +187,14 @@ enum resctrl_scope {
  * @num_rmid:		Number of RMIDs available
  * @num_mbm_cntrs:	Number of assignable monitoring counters
  * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
+ * @mbm_cntr_free_map:	Bitmap of free MBM counters
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


