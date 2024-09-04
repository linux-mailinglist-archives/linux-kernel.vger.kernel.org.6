Return-Path: <linux-kernel+bounces-316033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7D96CA37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE83D28B58C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143518661A;
	Wed,  4 Sep 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xkr1w1so"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22621187325;
	Wed,  4 Sep 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488556; cv=fail; b=hBNY3aYkyYmIZxBumFbiJDAFZc/l8ukVi8HUJSQRiN7HBfxCCjBpbyPh4i2YEDSA4rsJBsHwUlxWW3sRUMXZg1xd4s69gTEb55YRN74XkqjyMfr0edZ7iwsPNHn8NMuYrq49n4+yiwYY0L4OWSD7XbDsK6RZpo55dinJxFf9ZEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488556; c=relaxed/simple;
	bh=RBbO9tzRQhynybTufiVbPY8/1X7k9d3xnoO/nl0B3Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suq4FarSij6vZuKv44ZF2hbbh2zGneGRJTN1EqYaZWz7BQutXkhjb8SrsB3eg2T/o9JMdlGLY7T9dlQTCIxHEJqga/7BQ55P0U/7MuHu6Umo5e/hQlrf959w11F57rij79PwcDqZYKnxR+wwIffwDUvaCJjIeyOlktYJsrPbk+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xkr1w1so; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtWJOsVDsLyBrlkBOocl2obmnH7y7sNke/VejtulLp/VYoKZNOZu4tT2KqSYkj4neNWDWTAISG4fXYI4dGUaQTjSt0oLJPiO+oDJ2IrCKcS1jvkuO9UKREgCBU/ip1xPXtFZreqzNQKs1HllKe72Hi1G88fUPG7g1DLu7mWOmwASUaZBPcOCbW+i8ZbgbGd3pePTixTsX0NQedkYbyKvhpHx7lvkLJbeeQJQFGT+E/37lLkICUduLPgkTg1Eza9vHWPkgjaB6C+Bhi2cxhjoUzbtlgAar6dNSjize96cbIWjwGBTmlvxvNT9L2FGKC6/aXOzIPK2i8OXFjlgS8Rz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJRuYOUrK4nw/y5m2qGuZ4lVDMss9bIzJajkmEV3UrA=;
 b=OYTfUXyx6c7Np2ZbdVe5rfeqmrL+SEF+bynYJSc5ISEEvXr7vPSW3ggC/u/R08N7K+E4i5i1MrcJIme9f9L788tEh64Z75DHsmanhgkJ3nqIq8h2Un+9h003DsKwuTSOhotMrZ5WqosdFoj4zUvVBrEoZ9+KTIkflsPKmjMGA1zg4irMOPsNFp4yweip1vEpEnP1hOyu7fD/LinT/TiaEOrlhv/fes8IZCNx584uteFN2ozW/a6GWIrPdnok80cbw9vEMhD60oyEMwEzvyRY+s0kFfcOXbwLroSo5Dj2bZPSKu40K0SP4v/A/A2y4UR/0bjmD2xLD4yOVIwc7JmjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJRuYOUrK4nw/y5m2qGuZ4lVDMss9bIzJajkmEV3UrA=;
 b=Xkr1w1soyatu3g6oyNZ5C0S0JQ4rkqyn/5+8c0OKC28wuaNR3t97Qmb0EQT3WeaYLMcxc4sHg0TABRoM7wAcRqL+JwMOsn3K9wFax9BKYJLt013XZrZoJnjASzEvkPMrJT0mjD8cfnCt46C6wAqr++E5kfz+gyDn6b3m1wteEpU=
Received: from BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:22:32 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::f9) by BY3PR03CA0022.outlook.office365.com
 (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:29 -0500
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
Subject: [PATCH v7 05/24] x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
Date: Wed, 4 Sep 2024 17:21:20 -0500
Message-ID: <39e412a215ddf68f78ae082ca5afd0f21564d3bd.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: b7665636-b335-4c54-caa5-08dccd3011b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4t8xx6+NOcRa8YWFp+5jrD5ygi3e6x6Qp2N4YAlEY2hB3IYM/WEOfY5qF7ev?=
 =?us-ascii?Q?UJpsNU9cwLgzYTGxWXOrxWFflvpEf38ji91f7vleyAtjJG4clL/inHZMxucn?=
 =?us-ascii?Q?5txHN961/ZQDkpN+mVuvk5nJJbD+xLjTn8v9wl09xO1ChqUE76DwzSe+nwTM?=
 =?us-ascii?Q?0oShhAmp6cZ639GaaCvXt0LtOHUlnnjqsl5Qk4APcFp0OiZkJ/8ib7+PimS4?=
 =?us-ascii?Q?+g2oxprD4chJi3tEc1F6AC04NozmkDiyweEOdRkoawG+bdEzP1I959GHmoNn?=
 =?us-ascii?Q?b31G1ytnrHZAWWCRY5YTKebKMXe473kj1no4BgqIF4N8SKWFdjQZkbZ9hvYY?=
 =?us-ascii?Q?hm4A+K1N0IK6GuOLoLTLa2+3qt9TMal9Mz+aOA6gvGcC5gjm8djYvN22i/v3?=
 =?us-ascii?Q?qgMyWHPaps7x42iF/9S1b2jCM90R2QNc0yWHqp5y+/5LZc7tNgj6sCG5LL3P?=
 =?us-ascii?Q?jl4vFRaex3FM/qmmfPDJ/Xc2NhIeKMqjxshelGO1SMmQjTTw73KtI3xnbrNa?=
 =?us-ascii?Q?DIMtTKxU3WGj45X/IVWK4DkRPOtQ/T88w+0K68T7jP9k+ixUYnoXKp0dR0T/?=
 =?us-ascii?Q?aajd+MuzNznbckZP4l28euAJE/FeILMm53sxboHr4tzNXvZ9g271COoXw2+H?=
 =?us-ascii?Q?w8RGMS6k0e0lVJNZpN52d3ILYMZD4aq3bBqgpK87l3CX7RWHZXPYKHL7fZ5x?=
 =?us-ascii?Q?k157Tqc0zAQAeUSabO9i03nMdV55HXMwXZJyWRQYXjIWwb2vDCzaGHplrVAQ?=
 =?us-ascii?Q?ooLZPC5fmxi/qzjKYuyf5uI/jaEm0IPkwNknossv25CR73lF/fMgFMGVH1cb?=
 =?us-ascii?Q?ic1e0C0gL+3r4ND81kLeg6PoyQWb6SfRi09MtWnEWQZOjjRoWmLSi8HKIvHY?=
 =?us-ascii?Q?JMb+tYfUCYRVGDZ8b0JyTSxGNeFwD8NyjN/H41CC+S9M4kXGR9XhaBrG/TJW?=
 =?us-ascii?Q?2kmwL8I9eyyzbd27fTiC7Hw/D34+dIGEVkdj7pSiEY7UnSlmo7gk+KbsqcGb?=
 =?us-ascii?Q?DHgX6xc9ZVcqX08XdLLVA8ELnHl/40qMJviDi0V8ZETrg09XRjnLS2Q1L5Bq?=
 =?us-ascii?Q?myxsL5gHM0HMks0P2VOPZaO2eG6INLCH0LCxgekZivFtpGkV5B7gu0mZ3P6H?=
 =?us-ascii?Q?i3ZLeq/n8/QF4SGBPyeEbuetXKwHcjxPwMVi10yZSXfs9KeIEh7LM7Al2ni/?=
 =?us-ascii?Q?7pEiAZnmjoXEiyP0La8o3EiMDwlnmtoY0Dn8OoCqqrlCM6Fxu+0egVhAVg5S?=
 =?us-ascii?Q?rpuXufW+iXdIpwT+djOFkw3XqQAgKoKWJRyjXYAH/VGJ8/bc9CqUZDJXP5CH?=
 =?us-ascii?Q?Lf3y9FbhrCLgSv+FTFjsNmt0U/ZL3XZ4yl8eCyNpe2W14kKrAWwD8FForzGF?=
 =?us-ascii?Q?9WobpQEmxIiLZrNx1OWTXG0iAzrdOIY63WX3F+MYAyk7V5MZ5b4QuEKm98fh?=
 =?us-ascii?Q?izg2NsGqYtcNcH0IUtzguiL5fyMrC+1K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:31.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7665636-b335-4c54-caa5-08dccd3011b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

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
index 73bfc8d7a438..186d8047578b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -234,7 +234,9 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
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
index 6a792f06f5ce..71fab31e20da 100644
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


