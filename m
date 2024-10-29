Return-Path: <linux-kernel+bounces-387833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A69B56B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C401F23D72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76620C00A;
	Tue, 29 Oct 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZUcKjurr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E520ADE4;
	Tue, 29 Oct 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244210; cv=fail; b=SHh4v2FXdQhzN6UG8IAnV+SJaOX16qBRzIE1FKIQ6Wk2vqH2Saoe7QuJlDND5t5mA1sCLBd+Scag8tI/vdWRO0JACvDTGjCL18P8BlpFaXhGWPiNvXdW/T0+zxewf5DrhulLbV9WnRslBhdOVPlhu2DMP5Y5uD/31E4/5/yjWYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244210; c=relaxed/simple;
	bh=ojcFsP7y14AuphmGEMlrKhyR2NqWX8T/haJ1kWERDUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXwOcWvQA9oTqvMDRKGoCUNYi1MoUIyYSjNxwRFhnYhQfX8Z1BjQVw49RHChf15fXw39Qgd9k0CzXGrknPPZabKCaqHsNJP1SJwFkgJw1HdlOE+LV/xamjK0M+K6bxtlfDLI/2aeyF2RHhc0Nre10Z+mBBDMfh+ZmrIMwj7PcA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZUcKjurr; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cESDbchEqXmzcZ7mSObc8YfvJ/gNrpgU9fqNaBFzOvAIrdh2PGFV89jh9zXL3DIvXNsq0m5p8pXyB1H3dhdNR4fSroLp2bxWV8LAfGlgoBUs0lgiimL0jx9tNebMeeDW7RE66cZLdQ/zsT2dnil5FTkSbhTQjMY7qRnZIVuhI84WT8Zt8ekMfrNl325hCZq76XIo5VXm4nEZ//6S5Qc3A+zqXmPKee9VPMNlJZksALwiDxtzlA0aumkp2NpLZ2egULrYmA2rAYLMt4GgodQ33d3Qr2q7AbGYMlshqqQxh2B0RBInTiP2fFJJMUuoc19ZHjpjFWG2C99kRtmIGf4vnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XGyz4UBN0RuYpQ5CUySLMPegAu5VDwJognTfSCM2xA=;
 b=Xw79LH0yzk50tbXtiohVI3Bza+dXBUelnt9TAlP/qMULEhUTSR68QmT/oky3Qil1ELlaOKpCSWqvbKamnXhljtOzTrJk61rCRgzhXFwRgHzcC4cNsqHan17v2ofnyp5XtmWIbBMebf4xvGctIObxmS3yaNDZBY9y6Xy0rhKIj8p6XlmTwIP4L4ZYV/UJnhZJ1yETMdI5hKyCyvP4nffUFnOAS0uGi5O+ub1d+unb4zrgZhaM+HWbKl4PLX3aChZykT3C7s7ERBkLfj66SdqK8NgvIOPOi5s3A6mc5ANxeriwbAoOobtqRQPdNfNh/x1fKvddOgCoiLcqoiRYme2new==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XGyz4UBN0RuYpQ5CUySLMPegAu5VDwJognTfSCM2xA=;
 b=ZUcKjurriz9sE8mu6Y4rZ97NPm9j0O2O9odq7Y04W4Q8c2ArmqNVYVBKuCJUMTcH4iW1XLVBT2KswmDX74BGn+9TExocgTuE4x1/oRKdMct9+6z1c2OwucZDLnkAxdSxCoGklf6qdZXIIkDggyWjfmk6yfMPC22AzVk20GsS6Pw=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:23:24 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::b2) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:59 -0500
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
Subject: [PATCH v9 06/26] x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
Date: Tue, 29 Oct 2024 18:21:38 -0500
Message-ID: <237409fb566288d9f3dc7568385e6488b62dbba0.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: b48c7b63-ea39-41c8-8084-08dcf870aedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ew5ba4pqzP7iCBAItCU1GSglkAKUb++oHDo/nqNG+304p1Bgtbw5/PwbKdtg?=
 =?us-ascii?Q?anKM3V5MEX6GWqKH/7Vovq+NuyCM8ZO+FsRrG6PfDg6shhHlT9lP5qG5Sj2W?=
 =?us-ascii?Q?bn3cBkvGxcjLaUt6E9rWl7dqY9JNsH1RgSL1eKUda+QLeI+C8VVg0iKbxrkU?=
 =?us-ascii?Q?m87azWm1oiTkaFxGJraUToOntEvmlGqHYRnQjfj6NOmcmdeQVM4f7zJgg/SP?=
 =?us-ascii?Q?3CLXAKhJX4H4zYdQ53cWdpwhEIFRADlqN1DehH5KlI4eVd6+TipEjQhUTYyx?=
 =?us-ascii?Q?Flc1NfqlIW900nnFVJFqCJ/nFI2+qQFxqkaogAFKpyqep1hCcT8lVVs76KbV?=
 =?us-ascii?Q?hF/fMMH5clX2tZNGKKwT29zQngTHBwD/mWr3aIO43YWQHwlU1Ywf3VDTXe5A?=
 =?us-ascii?Q?2SYERK4fWPdoum1wGIsuHNsh6CLSO3rcpcUFWuElGV2+kyzaZDuWwi//CTfk?=
 =?us-ascii?Q?xBpnqBdHC/9KWR3GMsb/gpOIRWzeBLwtnJYlwVlr5ikh2PzBqjDpJgURlRky?=
 =?us-ascii?Q?5H9bitiizureSZW0AVj3Ix8anPJ0cgeWrKzxG4v+I9b8yXeoChLNbsRVuFuH?=
 =?us-ascii?Q?MVh2IKvknJVulCxitggKhyX0YP7LBJSPJPgIezxgwHOR8qjEMyoPR5wfHPkZ?=
 =?us-ascii?Q?VU7Ex0LgidNrjI5N8YnN6ZqzLZqpMVFzEE617ceQ8jc/B7WE1b22sKddwzd3?=
 =?us-ascii?Q?wMBXfBFFSu9wpM3aKKLA6TUgzoj+W3JzXU6EBvI7VmoiHUV9nuWmRfnT3eBn?=
 =?us-ascii?Q?tFeNsxtT65/UAACxv3HvEosWtlF4da1nKsNtfQBSIq4fjgL1PXlay7WZOjFk?=
 =?us-ascii?Q?t+VvywLNzrEejARxZwZsr/GnxGyYxM7Z9E8ZRh9fWd1WRmfIIHVTHW9j/dsH?=
 =?us-ascii?Q?UVC8SU9H88ChOlNeRBJBTLCRI3/jqutFiM5Xjq9orzYeFgzaM2R5d5U2jZqf?=
 =?us-ascii?Q?jfahzrW2i7PEnFP4Wt3dGxBu7aHh2tX1dE7znvPy3LpQRRb0HhqlWuSLtYX0?=
 =?us-ascii?Q?zYSKo5vgeOlb7AHLapP4nJnhrtFlQmPeXEeNuT5XUHh+/7u1ZiOOC9nGxfeP?=
 =?us-ascii?Q?JfrQIEakzRR2iZj+/3LtGR4HV0PNR/1pxUQQN0mO2btsASDARXnet3aGjBG9?=
 =?us-ascii?Q?qMGflNwlurVcEsPmy5EwYJvlsl2DykdtEpxhxn+pvGfVbhDVO42rOroOPuR4?=
 =?us-ascii?Q?sWI7HSiaiqPzkbGCODlGgU0DlktTGcdDM+YJS1SyD3+jTOjhsgA8M2BfHe6I?=
 =?us-ascii?Q?s/Y1vioIyLKSnH+QgYRI5cvEkY5UQ08EvtFNeILHNdm1x5PReL6vjqI2JlLD?=
 =?us-ascii?Q?ERepkiPg6fspGjYCSHmo96yJiVt0DSbSn8hvJzcGd5I1vRsiMHcalBY7jF6D?=
 =?us-ascii?Q?ikydqOPIl1+sO9sx4i13EvF7AAF3al+JBOcF4/jrzoQW9eIWgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:23.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48c7b63-ea39-41c8-8084-08dcf870aedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552

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
v9: No changes.

v8: No changes.

v7: No changes.

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
index 468af203ca69..7beac735c8e5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -234,7 +234,9 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 16181b90159a..9dd1799adba3 100644
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
index 383bf3ad2dcf..9209fb3dc78f 100644
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
index 1647ad9145ef..687d9d8d82a4 100644
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


