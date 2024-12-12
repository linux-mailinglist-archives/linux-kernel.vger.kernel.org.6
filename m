Return-Path: <linux-kernel+bounces-443885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4099EFD26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD33188B2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036EC1CF5EA;
	Thu, 12 Dec 2024 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c3ZAAo0q"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E11B1D61;
	Thu, 12 Dec 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034621; cv=fail; b=M1tOH4lF/LbRXKQ1nbfGzPnujC+u/0LH+TUPzeFYpVkdeyUh7qaKX/6P3RXUmN24aLXKo4CdR1fC4uC9FPsUyHdhtY1X2hUL9VLBhnyRD+Prt6HrF4MuskJlKrVUTdoHIyafVdScbqhfE70IHV4RxDw9WWiGJEMqrtGxIDKS8QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034621; c=relaxed/simple;
	bh=4H4GQHAyuyTwmeDdeXPywrB9TjigxQD5iEFXLJRk+Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8LHTriKS6Q64wCRToYBJX7tjGIbB+RdAZmI/cIlN4Fq/RBPjEQJIn6BhvPhV/s5H274OBCaYwht5vjXqk+14YDADl47elxPjfAOXcfwnC5nCYCF5F+fdoOm2lv8dPDQEs6usbuXzsBtje/Zc344H0x75qhe/nfOt7oBrWudW1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c3ZAAo0q; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVvq8jfZrQf3uhHHjFq5IGAGsxkw6jRJ5ZxEsBDLO8WS7493dvpYneuGkjfMLpVwcpkL6GJdFLHFqirFSfD9jw3TUoGcN50qeV2TzYTE4v8Sp+xJ3DoAXR85WBQPRComG2YMqUkcwZtJDMAwCguDESdCYg5hHRQ3OKJ8cafES0StPcDQzVJi72dCo/GOPXiGDJFjPB+M0WI4MJInVfB0EebYSwCY6edWy7Uwf7vIx9N3pRgpruuOGfZiKYkJXzI4TdHlqcmBDBYn/pstZz7q94R4lIcdetvzzFDtN/w+Ak4qgI6MPAaDg4DNDXhYzjTgX8OBPzeIzIcUCkH50RtMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3CDPS/IdASRIG5Hd1iTMlclWXE+EeNfIQkA27FPLY0=;
 b=PhltUsN71RvKjL5fZJXfCe5l2CwIxgDWvg1IDgSy7bTHdQGLwdxggz3Zb7Y+IyuF39WlRu8gdvHit5L/PP5auO3XjiJ8zhDgRH3pL/QRbyo6Un7eCg/qVRFFtH1xZuFNWhHQqkWCL7H9JunExoCBuR15AG+bxqhxtstIRxM3GRa2YhsJQL0eZPxil+lk5R3Vp/jqT/+iaSMaY7JoIMQPduJNInUoAIOSQqRdEGKJjNcUQos54Yx22371hp+N/g2qnzTDc8hOzbXJvtoOJJV7QKooTucVNpIF9jrButw0R3T075u2TPwrOYD+GWv3tBqA2Bonka/jTAFcjKZzxHJZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3CDPS/IdASRIG5Hd1iTMlclWXE+EeNfIQkA27FPLY0=;
 b=c3ZAAo0qx9lCMjkFGKvSDqR2d6xdiKkYNuavykT/gVpWtxT0/tLwAEkOhQakfuMtnin+NYDjbcFaNZGCRZQGufZ1uUbVxPLOrBw0PcDYDevKz/6mF7sNxtArxIzTYobtYGfAnPGJY0S/+MtTVJ1sL7+TtxIldlQXAIoXJzSBVQQ=
Received: from MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::25)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:16:53 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::6a) by MN0P223CA0021.outlook.office365.com
 (2603:10b6:208:52b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:51 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 06/24] x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
Date: Thu, 12 Dec 2024 14:15:09 -0600
Message-ID: <b7d9688b7a1c4ea4c832f232912f6fe4cd873964.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 820607ed-e87d-4836-052e-08dd1ae9eb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NX0bDlvxP4HIC3JNMve7ArLGuwAu/zasfPlxKDag/CHxyWwEnHVEUuUtPvzR?=
 =?us-ascii?Q?Rl4qv6OgaDCcfu3c24iCEB1FjDhagxm65XIgOwN9gsCi8gH/i5Hv7YODzxS5?=
 =?us-ascii?Q?zICc0h8dTPkN4QuNW0PyBRDcW3faoMR5TYD9lcA4oKuogja0gMdODwFHXdTu?=
 =?us-ascii?Q?fAx+Urag9FePJJwq80BbbBPDqLjOYHMTMPcr77ysiGoncpnpCXV6BZlCZL/E?=
 =?us-ascii?Q?fs6CWTwRcoJIZozHSrPj8Vdrx0EnFBuqjixeIoeQ6/VPJxFr9iT+UEjJjb40?=
 =?us-ascii?Q?GR2pzAjjCIpYlWroRqU7WpjinkYsMBW8oqGGI6Gf0uaFsIzw2GaZTO+jnqRH?=
 =?us-ascii?Q?9ZRg8AG5PYVWwFvWKem8Zuz+qksckZHknF16mf/HxDvpLBT6lHrizp5Oi15q?=
 =?us-ascii?Q?2ZHcnEy94ji29noBwWsqpfc6l5Q++9cDwlM93E+iooYJd1ufO0n4s+bmxuqC?=
 =?us-ascii?Q?nEY+B3TyySH1Z/yjpmysJ31KjUAo6KRDtHuGtxs05SZeloJj2wu74U+IErRH?=
 =?us-ascii?Q?pAzpjrY4dCHjN75XfCsbLQaDf1N6Caz2nQZgvm170PBFVaEP/pGzrsMbwMkd?=
 =?us-ascii?Q?gGM5GZhn7crH7jZvOarzVVXeI85gq6LXJqoGwLgJdRDKdVR3i24OpE/XM1r6?=
 =?us-ascii?Q?zZ21WFmY91VON6mXM+e+eGY73bhhSDu6mv070zQDM3yQXk4YqoQftbJFR/LK?=
 =?us-ascii?Q?A7e6/drVn5w/7c3mFFjYWIF/QfRZQxKQ6l64k8uX+lxMCjtjA+vLc5zU5FQ3?=
 =?us-ascii?Q?ThKGlT0glgTbg+DFCnpUxJCc+XyYv70abKbh3tJaXLa8e9XhOW0ikLFu6j+T?=
 =?us-ascii?Q?5K1EPmGjHq1hNsbU6Whyfl0+TY+UgkE4zen75V4HRu9XhkGmpRU6xN6OV2eK?=
 =?us-ascii?Q?XxZuTc5wH5hXrndJ0b73I45r8lhWs4/0E70CaQgK1UqFyckgtcCdoYDkPh6C?=
 =?us-ascii?Q?wtdRmsdj2dVLTa141UAtZEAzijUvbePRRRPRmZ6U7TAidw6R9azIWQZNbrbx?=
 =?us-ascii?Q?3LX5qR1+ppe86CIjCzD6WVHPai0z8kpoDE9UEJ7psS1w//OXrtWZ8QLSplsA?=
 =?us-ascii?Q?XD23i8AimbrNMME7VrDAKyv1ADhrysaepaFPuHcaMeSUv13cvkq2BKiEC2jY?=
 =?us-ascii?Q?4/yNzaOggXLQGDds1BrscpgICEENnv3hjE5Tjz/dc7mFVuxmpiX3RqQdT8ll?=
 =?us-ascii?Q?FuRHBJNM5zC8wu0CehxA/73vQBw4ct10D4sG3pZoTTWcesEb5/Keds3r6kfw?=
 =?us-ascii?Q?4HewgvbnrTDMe1JF1emchLe/RwgYSxWqO+IvGCl3sZlfXGZp3Jz9RWrkC7vH?=
 =?us-ascii?Q?LXIFi0Jdpw8Y/dyk4m/L+1x25RL8JCgulxgob7xFaqPSjWhtXH1naGlxb2bu?=
 =?us-ascii?Q?dwUm20eQNjSnmYP8qCvyfN+hP4cdnUC9QzsgcwaGTdoPD1RgjqxbxgCiW+jO?=
 =?us-ascii?Q?kzJ2WnqT/DApKAaf8ZIECj0cAupJQLRt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:53.5058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820607ed-e87d-4836-052e-08dd1ae9eb6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412

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
v10: No changes.
     Tony added this patch in his series. Will remove it after it is merged.
     https://lore.kernel.org/lkml/20241122235832.27498-2-tony.luck@intel.com/

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
index ff4dc649e35c..45f74d57de84 100644
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
index 36df69da99f2..80be91671dc1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1224,11 +1224,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
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


