Return-Path: <linux-kernel+bounces-357612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300399734F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE2AB24670
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CB1E0DD4;
	Wed,  9 Oct 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uE4IaPAd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66E1E0DC9;
	Wed,  9 Oct 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495655; cv=fail; b=sFlvpjXDzr/oQLp4h5W5ewhkIJ5M7NZ9Xv2rhYOL+Bw6GLCL3lNe0rEwMtoB4C64P109JReHQ/IlyDRYZ5zqsNus81xXTkZtohpII53YiMPTeiKL4Kh9zeG3WrG32rwAOgafqB8a+lzyVJfNeQM5SvshwiTm+mRIDtdtOACp1kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495655; c=relaxed/simple;
	bh=YFA94wQ+PjaIuG4pZJrTVayaCQ/G7h9ZtXfYfyzrxgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+cUx29RAe8GC1Mc4eNprXK5E3TPtZKsA+ZZGZ4/9KGeZFZdaeaAX+CW5NfZ3JpkcFXS2hQZSBtfqjbbc+W4ufOiGTV/jhlmUWFQItXpqElpa9JTavYWasG6oXsMxzT1TVawFp4Ufu9/C4qTK7yfP6UKGm34XQzfULZK83Xi8Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uE4IaPAd; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8bTzhEbHSMCRjjJgj3gQnLchtabNpvGlyA5eff0PADuZmk5CrBRxsSgmklsebIVlDOU5Y4yPdM6Lc4sTJYOQ4Zp0M+ZqEEBUnl2pXRqXx20JGKBiZlPPfOKbUR9KncLWExB5DoIvHBFTuUBNJITkuSeLj9OY93JzpMQMG1i6PbcjSdLcnVoH6L9nPzutBO+6bavnxeip5sWSjuzlBgbY2L5ZtzkkUQcag4MPLoM3GuQnLCdrdv6HTMDBkB1nU0uG0vD5e/qAHD87yZRa6jaPPywuSdMifAhzCqYTts3Y47YUBQBH435RN4khj9vK0UkUgge/JAUSGAEuqm4kBvTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zptC0EhgCU8BnFQtcxNOa/dCGfMWkbirpe9ax5Kc+DU=;
 b=s0tfm2yLfBAbklZVl4EqaGtt4Iipato5Pxbeg7DzQFjze+avWwiuRS3R6zn3htSfQs87QpPROflJVa/a2B/1i4biPOpuRncXFN2jtdtDmg1HFD9QjvOjnIZDBiKqluj0Vls0R+MZXC0qxCKR3RM4vAqhZOyaMpDg0WGuPG5cde/XdgYjWNvorVn4AxdzUUJqvuhSZMAXZIzAZmOrJ8ne9jutDFZnluRmdrUt3E1XC0zZBJQhGadi8Yku1aTgq4AX5/AhMnqykd9xtmyPNWykV0m7TOMkft13kPZJa/PWg1LBa4ILgR3Ll0oQyrL+gDZ31C7TieeoghbtsHT3hILjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zptC0EhgCU8BnFQtcxNOa/dCGfMWkbirpe9ax5Kc+DU=;
 b=uE4IaPAdDZ/Bkn/JWvWyOjqnSXyW+1s+0IMl1enomkqEPcFBOD2New7E9lw0PuclTZxbF63bb5ZGY065iO7vgWcBTjdVyA82zbVsZ+xuLf+46VzgKvgFgW/9S5GkaNVr7JmoklVrzX9YLU6gqijlp9zPh9g7hPECblr/G6iOM2Q=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 17:40:45 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::20) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 17:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:40:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:43 -0500
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
Subject: [PATCH v8 05/25] x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
Date: Wed, 9 Oct 2024 12:39:30 -0500
Message-ID: <c81aeef94b1e3f66571d91924288cfe4677c5a50.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 892697e7-eeec-4c01-fa34-08dce889811c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/qlOugF4FBcMC8iFcphJNTS+piap/5ZApbok6py3f419xvRTes9HWz04Epzu?=
 =?us-ascii?Q?WO1pbwYf3XYMuRr6JmZ5PgLy7lpEESi6C4rnxu3VwEbsJ/BBkl8mLpRIhCix?=
 =?us-ascii?Q?Alk7yT9p2n5d/MVCr+MiHmYpRDsrgR2kDUL3b8Nziy2nTTvSZ8mMyQlGxdRM?=
 =?us-ascii?Q?BNEyUsGw3cspTrzEey54KjNTRvK4+q+1Ik/64DFqcEkCbGqAI0QY8/Q58nE5?=
 =?us-ascii?Q?JgYbG3rISVecDa+iin2YFHwjtHZgIWgKzXxwv/rMET98qO/VHRjP7DBb/nH8?=
 =?us-ascii?Q?jyZgDsjQVOIM/Uiszzrl+4uS6VCj0WHzvh4kJiJLDQam90BSqbfALM4xCJvg?=
 =?us-ascii?Q?y8i0tmZ79lTc6Xzxx7Io0l3XLSWUk23yop4nlUW9DEQzEPviWxPvkcOF9ylw?=
 =?us-ascii?Q?HKZz8WdX0/lyKL69oZ3nAh/zutQ5ANqttIFXTIi4MfHfyceNCPernOu61wqb?=
 =?us-ascii?Q?0kWm1XcUwRA71Gm2LHuCtQjNA0JmSPd0TDNRijObh3lIIaLQXdeuqnj41pJ0?=
 =?us-ascii?Q?NPB4Wz1gO0lPu12KWl3hgpPiIbXcUBZHVP3lcjRhTztn5ZXe9p61xcoTDYI1?=
 =?us-ascii?Q?hMndhFL2Eh/9Qukdil4GBBCrBHXmYDybDec8JxZ5cGgiSuidi5mDXW2IOvOw?=
 =?us-ascii?Q?KQUEU9CZo6ohubWmbXKMXRKn949QdSLYg6c9+MoV5s5KJWRfl+VIYr6mBinS?=
 =?us-ascii?Q?wDDcmm+UrxDHRNP2/E2ver7GmypDcwS86rVt9EqKwv6HTj1NhufburfKSEh+?=
 =?us-ascii?Q?dOQvZzdB1S+Vk20WRfVxRGH9EYE3bZweHGBENz4cSqiCp6/42T9VdBuiy1RD?=
 =?us-ascii?Q?11obbTQsU2O4Y5NDKAXFrYWHaP6RzBGCRapObn/KAYJrKEUk66nFwYHDvusP?=
 =?us-ascii?Q?foQ1p4vyNIegWHU1rG+GWbx5pZ0JbrJtcBijIls7zNM+m53Uoch8hlBDIvt2?=
 =?us-ascii?Q?eJ8Y+k93K8Pq3ajf8JjAQruHEOYzGVmSeYKbq90c+Ns0iv/2ecLLIZW8FaLw?=
 =?us-ascii?Q?3jGS7Ae9FSwlpeMJdm7ggtyoFj2ofPHodgNmtxy0fytL8hRrJdqWokENWjBv?=
 =?us-ascii?Q?X1+Cr9y7/Ev4eTFTzRDD76ToUUXMOaYJNjujf3rX8MGSz1YDveU4p8uGkIhR?=
 =?us-ascii?Q?t1oBwqJY22VXS4bBuMoB2h70P7RpDjJzPdQIQT0YKSpfyGRe0/kGj8mmuNzO?=
 =?us-ascii?Q?VQzuq3VSVXLSTnwxAJSrk5ougbS6JlO3+7Z9J7uYYZxLMTPFoW6q6x7kmDE3?=
 =?us-ascii?Q?SOGL/LDUOumeP1rt/bgxKrvutgOZqVw2WheNqpZvaUICHYIe+0pXr1Gndfd1?=
 =?us-ascii?Q?9P6OR2UZHR1b8Et7hJgO8pA54opBrLuKVhw6QVNsKTE7Um1a8pLJ+kXhXuXj?=
 =?us-ascii?Q?MRQAgKzHoheYXGmk39SwEuXZEh8B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:40:45.2685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892697e7-eeec-4c01-fa34-08dce889811c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

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
index 41a8b587f4f5..2f3bf4529498 100644
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


