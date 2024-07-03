Return-Path: <linux-kernel+bounces-240254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D95926AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F30B25282
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A24194A51;
	Wed,  3 Jul 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BgHe4qKE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D619644B;
	Wed,  3 Jul 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043369; cv=fail; b=l5pt6NRCBWj3l+lQXBvftadVEcixPknYmBolkJ+ojiANtYR0AqoQOdnryQuERiwpZZwLErBM/dItBoCPu5g5KkNz+nJHM2FdA2apgIgTgKPyLXO7F0H3buZIZUdITt2OsmM0jgzBCWI3D6Zo3nyMtL/coudAOzbYTgo8Lj/WQrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043369; c=relaxed/simple;
	bh=cwScgK/RXyM3g8zbsHm0p18P/Tdju4CKKpgce08bhD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCEuDovMJoTuDbbE2tzQ2do+vWVAI6X3fKmMlYD17DrX3BGDNVGEbJ0u8BiVWI6cwlCnhMR2eLux6z2WkYX4cN3pGuYABFB/aRKiSALJDrVGdGPy0TemV5OHbxIT5keHycEJW1vCTcOoIZ4YqzlJKCkV345Y2Cg8PxLtPSlcJ1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BgHe4qKE; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NENv9JO2erGN+wwBDrNzxFuNMoLpI7Hkjs2XNnd+nCq7cW2HDE/M+6yFLHoyYcjW5sajNHxKAcIvBZ0njOXQtzL/qndghaXXHlGKtYLk8q91gYLS7EVEIG61O7EJeuVux1oACEZu20Z6W2Hj4/h27RTrys7xmGtBxO97ZasQElXVkBz0q2PsV1bxmEzjlWKwAlLPRNRF+wqrwcs+/JydZ+jeTD2PrSrdfbCBY28na8L7BKwYLfqMBO/Uk9U/IrTLWgt8tyT0dxg4karyBI7T7voqN1fQxhaOwp8J+ZOnSPRgRIHJky3EaalK/U/LR4gsggE1P3gFEyDw5E+ccMkR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqJ9HnsGW1kbvvrSfY/pBETCPk3G1zfLOdHQ5iqZHdo=;
 b=GP3voC6ZDEYrwWu24gaSWOSDO+cBdN2jCzumpwWHfV/WPJzMiJuamE/Q7F7w0MVTg7TsAGp1CedRFrl/K7+ig90Xc5EGmil/lyhyK8iEQ1aaOLjD5lXVCL56dUMVMVPzi5UTlHt6mqOA5q4mGz20RxNm9sjKRKmut1Qdt6pUH/T4N9q0MozErik9gVxtJzhmTVwnvGA1bzi4Pq4TwgwIMEN060p8mNygH+cheqrlVVFZn58IhU3v5p8ezWQmpw5patJYjtasO94/Jh6FxUv89m3FZsP0TQoNomjTfkCJoJ8k8X9ef3SPElg2fRgRFDX4SGi6DD1B7ppc7zG4MxaBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqJ9HnsGW1kbvvrSfY/pBETCPk3G1zfLOdHQ5iqZHdo=;
 b=BgHe4qKEq/GHcKqQukoTEBWf/pWBRPD9JZxt8wO1dqc86b1FBeGKeoMYMS5WDjvagznIk4TWpWEWl3SR1Aw9PqQYL9CNujtz3Q9j/pG5CNhTf2SRdw2vqRn+EUp8vZeI3X3c4jt/FEnIhDR4pl5gTVRUUHbb2+q8pb2P2a3dYj4=
Received: from CH5P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::21)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 21:49:24 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::5f) by CH5P221CA0011.outlook.office365.com
 (2603:10b6:610:1f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:22 -0500
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
Subject: [PATCH v5 05/20] x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
Date: Wed, 3 Jul 2024 16:48:16 -0500
Message-ID: <9176ca716368fb433c956ae72d70f0f16278248a.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ecea15-f642-4f32-32e5-08dc9baa0110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iqg2goJ5IOocjOgFcyTrmvGesXgmk5d7QAXyygn4nVtlZ5hl7BIq61wozwDa?=
 =?us-ascii?Q?6JRLJBZsKEYU05QYonvXS5TL1JvdQ19QBxnlWqqtzSZ9/dbQ7KYgRwjagmSZ?=
 =?us-ascii?Q?+jLdw7079/dixVo/BYeuQgGM1lctOYN2qfNuCHS3p+5zh5G0Fi/J9pdYvK01?=
 =?us-ascii?Q?JAn+VEqnI7bTNxU2AMypG+kSMgkLS0vSP99VKJhGsENHWINP0kxpTjb2DSVk?=
 =?us-ascii?Q?+l/Xdl3ZkIYGfYJhCUGAjRiCkTXX20q9qLAf6nWEMD//lVtn1cO1r30LgUIm?=
 =?us-ascii?Q?D2jGct8Xmn2gUtU5hn1QiNF9IXLXcvDy9jAyVuEPM5JUowxHXuOpX1WyEpvd?=
 =?us-ascii?Q?SAUQJrWxmtwEMarcnFiTwXFTGOIlH3BmPYg6bmiWZ/LJI4UffpEE/cujXtut?=
 =?us-ascii?Q?iTIMfZ7P8FVHrNPtwe2MTTyxRMUIgoqc3igminbXGu6wKhBmhV+a6y8Jl+sg?=
 =?us-ascii?Q?dMrpVdXNLMG2eo+Tzkb8/MrJheakYyJV6SvlcArPwxYJfOzPkjVQuW5gkI3m?=
 =?us-ascii?Q?gruZiE+SlCZ1Jnu4I3Ut/10NvArLJTKzi54i88yZ0iFSSSbspWh8hbLoiKr9?=
 =?us-ascii?Q?6Slw99wVao2PQ+da/Kidgev3pCOQPvscFuRsouCdNxMre0J62fw4hgr+xYPb?=
 =?us-ascii?Q?XSwKqoYZ+o8gM4aAF+y+qrgs6U1QCRYBCOspXeY0K4JTG623+L84gGwMyW1g?=
 =?us-ascii?Q?VmZJ7ww8mK/XIaeecB/YmH/Llam/TvnVkMk2nIgIqFbvbBPlWcqToXNyKJwl?=
 =?us-ascii?Q?0mW83OlxgQM39l3YrhbLkLn9jjm8w1WS/gRJjYNxVbos2o47KL2CMSxqpd30?=
 =?us-ascii?Q?q2Le7QwGvGmvRhP+DBk5sC8Q2dHjVX3ZzscHpgtt8cEc/jbFrr69k6AZFo8R?=
 =?us-ascii?Q?dTaAYLCtd/f3PTzqVMe2GJKwrAfcMKEGgJ+mX5C8OUj5Ib/xSu2dOh1NeacW?=
 =?us-ascii?Q?t+0pZoinCKxLAezEawG8qvmBKQfV/+u+xzg6EXGqs7auWv/zj17Lw8VJ9HUA?=
 =?us-ascii?Q?ewyXzpCTh1RO0dA/+iiYAYa3YdryGlG0xjC8wqRUmFff6ErNmK/PPbabwnq/?=
 =?us-ascii?Q?QWK4tWef2GjXzuRVyMw1xmKvwd3NovHE92zJaENUbbrrFBq3i6IiuHa0w6X8?=
 =?us-ascii?Q?x/ffcmKS1luHF95Y1NR6Mv+lS5Z5OYxJdxG4cjJlr8Ld+Mb3uoMXRBE35Up+?=
 =?us-ascii?Q?Mp8xrXYChHhQfdKPcq7ZgJR8ZMgXqz2j7t6CwUgSQ4iXpohnQaJTFRXH0XaR?=
 =?us-ascii?Q?VTXft3IFL8TYbOAWFswssNCEvteDHfYaXrt7e6OlhBo3PDuIgbmWbQW3EJ+V?=
 =?us-ascii?Q?wIEi7ys0WcaY3EFT/7OZMsCLWVASKKm/bPPfti+l/tvUCC/0p2rQgdEswrFu?=
 =?us-ascii?Q?KDG9sOzpGkKyu+SghjAWnihjbL4lHlICXZEFrztQwwsya50N28Wivmv0LfWw?=
 =?us-ascii?Q?AUiGh9IBwiTQxjzuicy1rUTqK2WwILKL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:24.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ecea15-f642-4f32-32e5-08dc9baa0110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

thread_throttle_mode_init() and mbm_config_rftype_init() both initialize
fflags for resctrl files.

Adding new files will involve adding another function to initialize
the fflags. This can be simplified by adding a new function
resctrl_file_fflags_init() and passing the file name and flags
to be initialized.

Consolidate fflags initialization into resctrl_file_fflags_init() and
remove thread_throttle_mode_init() and mbm_config_rftype_init().

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 87d40f149ebc..12793762ca24 100644
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


