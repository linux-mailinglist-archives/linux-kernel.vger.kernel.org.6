Return-Path: <linux-kernel+bounces-276987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E64949AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766BBB24D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE951741C0;
	Tue,  6 Aug 2024 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A7e5oNvS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C963178367;
	Tue,  6 Aug 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981711; cv=fail; b=Ke0yfJdou+1PbV0d0OLwVJ8vICtM3xerzU/s00+NRiI9EHLC0CmOsM+oWViqL2tzE0+IarJknvtjhlNTfFhtP+tmjcFhK+Nh0LkB44yPF09wVw9tjDcm0zdjxXhbkv2odoiBOfjKpuVelthrGewQ6oEgbfNn4BU28tHxxValmoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981711; c=relaxed/simple;
	bh=IoDdgETboZCuQUwpbvtog5loN92R1YQNJSkOnjwAf54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ayc5IVUsLeStelS3TBstgbdFTJt5R5KTmxo0/Nbvz/bP9EL+/Jnq9B3Z+MwF5CQFJF7esruvx0NOCV1Go0c4HwrX2rEeTsJ9yhoRuJRle7ZDGCksH+5yiQJJvYYJToGDrHgzwrPqzMt2LqXO8OR+3K/r0rJW0bu7vbMjCETg3Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A7e5oNvS; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaS4sPGSIA2w0xqvH4IaSv/yf3v33jhBXqReCa43nZPOtN8/Qlxvt5vGdRjEZKKZBCy/9dfkUjJ+xDdtR5HYKSUQAeq9X5PTf84ID3+nC1LZOcrnVZkYEFg+U/9FreW5MCB42XOTPR87xK+HdlK9LvzLpEcQsDBzV+DovaphksKZGJUJgtSWXXmW0X/r4rNXUMV0w0k2DvNU6iIyb+/+Wp/XFquyNNk9L/YTnedEafQvzvDpE5jeFl4lS0+xloSD/AZhe4Ifr6aPIomJYET1Rd9h+M5c0lxuTmiAugGOXUI1IVZTF9YdBEvuv+s5fB8LP4/xxtYQMpjWGnQMzZg53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/grx1LEZem64veHctsoR4ENSjA0UKbOfkEgX6WsCPl4=;
 b=wEzQt6s+6Zt2R4SOr/+zugjNIGLyBKpNFsb+VDil13PhUZMijIPfKOI7iL1gzpfIuQzk6xzv5rVIKn4DHB79enmIOSoPv8ETA2x8PLKOzx5glzDyBVuSPYUX0DGgDVOJ8VNolx78o/2xgQzEG2UZtQ3CFO8n/E5Z7nd+3A0AJmNNaVgSTKjlzWI7q2oLo9eaoanTAtUmAjZcbIs3tDTd7CQ0xYR/A8bGpQz61IORK0W0mkioQG+jqUY+mvF+xH/fzeIwyuVY+6JAazmC2aVybqgAxF3CzVJ9D81IWEa7nppWOb2JgG8u7wKdfjgXRv2UdhpBykUDyogXeb45IfK9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/grx1LEZem64veHctsoR4ENSjA0UKbOfkEgX6WsCPl4=;
 b=A7e5oNvSQJyJjZrRDIGytw84jsmksnUeaMdk5mS1hqgJ8m1lZ0GmWym5Gb+8jHUlrh+mHlRAHJiVK41iJxXVNC7zLI89XM4vfeQTxfsDGp4tZBIIyNHmAgDeDlT85FCkcUC4swFT4wrfIJj87haJPYWF4vIQXeGvA/90IaUKlhE=
Received: from PH7P220CA0140.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::17)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 22:01:46 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::15) by PH7P220CA0140.outlook.office365.com
 (2603:10b6:510:327::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:43 -0500
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
Subject: [PATCH v6 05/22] x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
Date: Tue, 6 Aug 2024 17:00:42 -0500
Message-ID: <ecb5ae86fbfa8a0e360ee80ce90c9ccab30d8bd3.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb63a85-7ade-4fe0-0b99-08dcb6635cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tcwKSzr64ip24dAKpRRCeLMJez24SEtzI44r60z64VefkrjRDpRKevY9OcWo?=
 =?us-ascii?Q?NOcxbFIgtZgOh4rigQvj98Yi8k+u/zCBWt7+jNJv58Sd9mZOPaeLYULNAkBH?=
 =?us-ascii?Q?AK17zl+j+DOi85ql6YbRcnDbnj0reqeyG/MzXiGTdsOYjLLDhjPM8xIi1u1p?=
 =?us-ascii?Q?0TzJft5ZY/MvyKy7wr4sio7yJQ2V8SKEffcHMYlaaU8vU3RfjcYRx+LZ8f5h?=
 =?us-ascii?Q?sF2Ko6slEGI/yHR1UIqv/plwNV4Og60ByMjFaNx6EYlvOrbVndQpBFMQiHBM?=
 =?us-ascii?Q?CduuWxng69MOZnBnk+/a+QJ63ERXSVDe4dBnWoXyUbNIowqnF5p53DD8s0DN?=
 =?us-ascii?Q?/Ymvyu6PH+o7ewEzXjzPLAPfx/sPjUaE8m32SXeQOFig5MNPlQmswfU2eEUK?=
 =?us-ascii?Q?jhjEtxVh+nBULi3VElaCD9QcIb5rnXxJ65oNpANOxG7c3iBVbBt8q8qRC2Cv?=
 =?us-ascii?Q?EMXSEt8TbAzQAsl8glSjtVFsDRlTV8pS5Vd5tzDDBM8i5HH8X4E12EoKxL2o?=
 =?us-ascii?Q?zPm0qEyY14jR+m1VLR+al8gwl4cZNVYhJNntCMFxCOtOGYLi++N2Z+TYJafP?=
 =?us-ascii?Q?jP0kB+1Py1UU9tC4wVcgzXrmUmTch3tQn59R0muOyrGvWJ4IJDsq2lsfuqJ1?=
 =?us-ascii?Q?ZKjrYrxO3c2Ov4KJLZRcBEOtgAMIcaBYPXl2ZnLvJLDGmgpild91xTJB7aSv?=
 =?us-ascii?Q?crZK0pTX5JE5WUUKJf/nqsAob8rGGPBxVOAW78H136T94EbHNzmnMmmfhyuL?=
 =?us-ascii?Q?fYkqSr3OIBPfyEfGFnvQeOQw79WGy7hbI7ezxYapDUTKfafUL7gefBT0rMjy?=
 =?us-ascii?Q?i29OklJuNOaSKNPA881Y/STQiobDX5vsV8gWnYBNPfUdCGBLIPMUZctoifCN?=
 =?us-ascii?Q?q71AksJ9CPmmMzYwn4ZT7NXsXgmh8iBrdjgmmD6ib0rEs9kT1FQ03TtpsyrJ?=
 =?us-ascii?Q?fFaZqn9SyruCLS3bW2oTYg/TQ0egp3rdFdcEznBhrfzRCGV+YBDh8XbKVPC2?=
 =?us-ascii?Q?K1SbvgeoemedY0uBS4nNFrbPQaSn15EGJ8jxk0asfFflxDWvaTppEbBWn7jA?=
 =?us-ascii?Q?du8LVjFYCnLBxauWsl4imLUxlwS2x3XpD3TW7hA9I8dFMF0EV+cJQmq6mXLV?=
 =?us-ascii?Q?T5t2MTQbHQmv6bFB/F57r9SWXr7mF03T7Yr4tcvleW9TaKl4gwYAxZGRSyl0?=
 =?us-ascii?Q?HZizIfoDT7C7Bbv4MDLEBtp5oKyXcuzRnlkWym2s7ESETkt36TMexmwAlEuo?=
 =?us-ascii?Q?ypnum+3Rc4SmKmoI+gVvry7hvSSVFxYJi36MfqB9II3+Wkj2+RoBNgvgjkGw?=
 =?us-ascii?Q?MUGiLHpVfePWI2XKhm0DYViwfQuMhVZ5bsuvercOu8D6pWNlHjETEzcMC267?=
 =?us-ascii?Q?PuyuJJPUoT+1aNDE/XjQKy7X8gL+5daPxTOY3mvgewLa89hN65xr5wBUXgNG?=
 =?us-ascii?Q?DVLCYHSj72Cp1EcLGeZlEnr6I221Tfmh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:45.2478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb63a85-7ade-4fe0-0b99-08dcb6635cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

thread_throttle_mode_init() and mbm_config_rftype_init() both initialize
fflags for resctrl files.

Adding new files will involve adding another function to initialize
the fflags. This can be simplified by adding a new function
resctrl_file_fflags_init() and passing the file name and flags
to be initialized.

Consolidate fflags initialization into resctrl_file_fflags_init() and
remove thread_throttle_mode_init() and mbm_config_rftype_init().

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v6: Added Reviewed-by from Reinette.

v5: Commit message update.

v4: Commit message update.

v3: New patch to display ABMC capability.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +++-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++-------------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4a2d0955ccdc..ff5cb693b396 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -226,7 +226,9 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca..2bd207624eec 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -647,8 +647,8 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_mon_domain *d);
 void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
-void __init mbm_config_rftype_init(const char *config);
+void __init resctrl_file_fflags_init(const char *config,
+				     unsigned long fflags);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 88312b5f0069..5e8706ab6361 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1223,11 +1223,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
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
index f9f3b5db1987..7e76f8d839fc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2020,24 +2020,14 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
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


