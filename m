Return-Path: <linux-kernel+bounces-316034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BE96CA39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056A21F288B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A8183CD6;
	Wed,  4 Sep 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ie0WshY2"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A5179967;
	Wed,  4 Sep 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488567; cv=fail; b=t2oOInpaOw7XW0aHuO+1KLW9dY//9oTHr2SvApeKimZ7UYnPBJgOpV1zFFP3vj7zkFi8vSic8LBYWfsOqaijpgX3dhRD8hNNA1y79dpPZbXdOc35kBerl7zOffy2kqgZi5M2DzBn8kGnfYygRn7g05K2Aqc7HaGIFR0rP9NUSmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488567; c=relaxed/simple;
	bh=W8RElHHHvlUoPq2Fq5nYoWMyF/OLv7iakqv6e8I+qo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoLRe9T2D4c5ZS/PxI6ZTj7d6KzsrvrwdhIcb1qk03o4kQYIlbZQCBGqkV8pYp+U72ByX+GYCSlevrupWv+HE8LgDsSarkJJcOQFNjiRlW8+95t4K0rWj1dFRh9YndN/6W1McUAdTXz0A7wScS+hZhZPglgS+NPH9MCaywLQihI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ie0WshY2; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYBRCsM0WtaLi3+RHfTcfQmdVFA33nqxyXm0M4rkgWEhURwjn5Li0yzoPoxs9NPxLcpBmvt4OPE+mmbenzrEeew1mTRirG5qQ7kP67wuj/fOXzcnaei1MhGg+UaQzLVO6o98CQQEuVjTj6xde1sfcvpHYzuQUbwmIuhtgxee8OUvr4ck2w0U+vHsz+3qHbCRaKc3VgunJGQxGlE9xgv2Vju0dOq4E0JWEwfvAVurIq28UY9mfaELtGmelQMy6hgd/mdTMnHjPgb59MLIriizjoC2oKmS15C6PCTZY5Wy2aXSnEpR2bxzGyLpFuy+x+E8EJmMLpZ5cEN9neOdB8TBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqWYH0UCDerLHkPdt43CtaSlK2DYemCus4L2l+cEnHw=;
 b=B3blrHT0hgaOwgncOo80qqjQhHj/tCsMSgw1twPlJRhyYwnFWJt9LFIX8XhEGEmvKL3Xx70mtSKhBBhCs/ZNtwW2BMd3I4u3u12zBwTje2qaT0nlY6JkAV51omgbZ3lSyaayze4w1em5Xiyhosss7KzpCIlb5HyFXIHuVrSEM7kz+MQaj7UyqVs2zowNRLD8+RlAsw3ECve3Fa27jX+SxMHFJI+xZyKE9+PCXVRwNZr61bqPCkCnFN+gcrsThCEzrTy7F3y+RtyoLM03O/S65I6wixqh79/jDi+YRLmqQlJ5SrVnXdH+cdrluZ2SnUnv8BfojtGYKxGHOJopor5HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqWYH0UCDerLHkPdt43CtaSlK2DYemCus4L2l+cEnHw=;
 b=Ie0WshY2L33pUfEyyUBI6JSK7EbUZXenvryv+iiIsBIUk9WAoeoJkBqObRse4r28IHvKP5cYQJ1n4anD++nnh02QPKFrrp7wR+LzG/dSNulqshEoMKlOflxn/lmsK7ukwc3iIbK/27Cr4wX/JmQlBb+YjKNtGGelPYCpTM6Giyk=
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 22:22:41 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::ce) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:37 -0500
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
Subject: [PATCH v7 06/24] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Wed, 4 Sep 2024 17:21:21 -0500
Message-ID: <556b3576ce076c8867795d4af1bcdaf883397304.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: a19321d0-40d0-4e3a-7583-08dccd301708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nRK1kEmwLTZQFQj3ku/AtRyiQ9BHqK8je31ilB4ogaIVkrApJrZ8BtNINzVN?=
 =?us-ascii?Q?AS+JC0TMvndperz6fenSr1cdmASFoy62BJqM3WP477VcO6bS6qoJBz0gGABu?=
 =?us-ascii?Q?aiTG45GBgBgOrhkyqbhDW5x4+thCdDSkpqA+X6mXK58Ppm7VPmNAU27eJPWN?=
 =?us-ascii?Q?P+HTEtxlEQjMe74pMJ0eqq+7slG3SGVSvisfwhLAiyiTpfuPxp7Btcwsrt5/?=
 =?us-ascii?Q?E/yC87hvG0uwlBnPQDqiAqheEgTG4gAjzD+2YZ41HFbsMd4FB5ZrXIV5cGa7?=
 =?us-ascii?Q?VtPSYayxGMe80cBKryrWEofV7UIwkOdDaenV6AaIlaLPt412bT6WlUMaa7jU?=
 =?us-ascii?Q?mYK7iNbedebHdFW+tY9h8mpxNo8PHd00PUR5d4FwRkbmA2aG84dKdZ2pk8pH?=
 =?us-ascii?Q?IlqcJf9AjYTleGEd+PgcRArDwcKwJxQSHkFYYf29j5HQINhKq1AWbmFFI0tm?=
 =?us-ascii?Q?VeHLmg8if9A9cHghTyWuwcMTBp3yE7JTHO8Ce/YximkkGtd/w+IepPhjGfxJ?=
 =?us-ascii?Q?Wm/i/aFflQ85fpiOd3xYdG6bUMzmoOgmTrCDVuh8LzBawlQypQpQ8P/I3l2c?=
 =?us-ascii?Q?eKFKZDSlGMNrQ9UnY1oj16PUQTGY3mG8hUSFhhr3KJiQGhbBjvNHPTi5syZx?=
 =?us-ascii?Q?2P2sGwQjDHH/nEeSJpyET06xYhlKwfznkxXVmp0kanlaDR7PNPkeztCbctMp?=
 =?us-ascii?Q?Cmdxfz0zg2KclU8FRRYgThT/5wYf453ZBIu3Y6xm4OF1qqKujbVmP9V7ysKH?=
 =?us-ascii?Q?9DEhpuz8oqeaP/eg32/SMJgJIOj50S4Q5G0InHaR0AL0j9TKFY8zXdS8JBat?=
 =?us-ascii?Q?vOuJ4XeZEBGwQjqmqu+4H/FIOkIif27dGEJGlW9t+YwGl6eMwoQzZ/0yO3Sh?=
 =?us-ascii?Q?xa0YaDP/GcqjiBcGxmg0d1VrURXcRIr9Pq+ZXw7zpcsgv7Y1Jl23dqrW+GWP?=
 =?us-ascii?Q?F07bzFqPTe4ELDIjJOlvJxjGR/uv5yYLIa+wcLUMc4F9Xd0DHUyR3Gxuijc4?=
 =?us-ascii?Q?9F2lUvmAuqFi2aOpLQQvfne3+rklKK3vrbQdW/B7YO97YlRfHOU5Fu+VPM5M?=
 =?us-ascii?Q?LRF1WVRnMRhEn5dhJX9VnsK5RnX4uK8Oo7SHLdUvuy4HQVwVDl8c6W5hp4t4?=
 =?us-ascii?Q?b+ia1IHmeG+X1LilPP4ssvtvZ8d+Tu0l/FttE78qWvSZ323BYoNfczPLxzDQ?=
 =?us-ascii?Q?AdvjnbImA5KiSERsx33kvuBVVHPOnnkWPJGVgKGbOr/67nhrtRikLpl1NvfW?=
 =?us-ascii?Q?WqdZ5KVEzJXg7otwBXuMkwTzAZENWrY7XaS29r7Z5OGn5OOeCam8w0P/VXCK?=
 =?us-ascii?Q?JmjUWA2zMPKi4wY7W83hism0iLI36arQpVIq1mgGWsx2f/DGSKhdAGJ+fV+w?=
 =?us-ascii?Q?Lk0Cwm/vvxsbpZvZEJRpyH5xZQqnpAXsXPBJc/5MyGdcXqXbgXXoqcNP/w+b?=
 =?us-ascii?Q?GbvVWKAS0ZKJlJztgP5PdqxC2Oyx2sOk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:40.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19321d0-40d0-4e3a-7583-08dccd301708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

Add the functionality to enable/disable AMD ABMC feature.

AMD ABMC feature is enabled by setting enabled bit(0) in MSR
L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
to be updated on all the logical processors in the QOS Domain.

Hardware counters will reset when ABMC state is changed. Reset the
architectural state maintained by resctrl so that reading of a hardware
counter is not considered as an overflow in next update.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7:
  Renamed the function
   resctrl_arch_get_abmc_enabled() to resctrl_arch_mbm_cntr_assign_enabled().

  Merged resctrl_arch_mbm_cntr_assign_disable, resctrl_arch_mbm_cntr_assign_disable
  and renamed to resctrl_arch_mbm_cntr_assign_set().

  Moved the function definition to linux/resctrl.h.

  Passed the struct rdt_resource to these functions.
  Removed resctrl_arch_reset_rmid_all() from arch code. This will be done
  from the caller.

v6: Renamed abmc_enabled to mbm_cntr_assign_enabled.
    Used msr_set_bit and msr_clear_bit for msr updates.
    Renamed resctrl_arch_abmc_enable() to resctrl_arch_mbm_cntr_assign_enable().
    Renamed resctrl_arch_abmc_disable() to resctrl_arch_mbm_cntr_assign_disable().
    Made _resctrl_abmc_enable to return void.

v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
    Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
    Introduced resctrl_arch_get_abmc_enabled to get abmc state from
    non-arch code.
    Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
    Modified commit log to make it clear about AMD ABMC feature.

v3: No changes.

v2: Few text changes in commit message.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++++++++++++
 include/linux/resctrl.h                |  3 +++
 5 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 82c6a4d350e0..d86469bf5d41 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1182,6 +1182,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 186d8047578b..49d147e2e4e5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -405,6 +405,11 @@ void rdt_ctrl_update(void *arg)
 	hw_res->msr_update(m);
 }
 
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->mbm_cntr_assign_enabled;
+}
+
 /*
  * rdt_find_domain - Search for a domain id in a resource domain list.
  *
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2bd207624eec..a45ae410274c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -56,6 +56,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
+#define ABMC_ENABLE_BIT			0
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -477,6 +480,7 @@ struct rdt_parse_data {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
  *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
+ * @mbm_cntr_assign_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -491,6 +495,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
+	bool			mbm_cntr_assign_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7e76f8d839fc..0178555bf3f6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2402,6 +2402,41 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+/*
+ * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the resource.
+ */
+static void resctrl_abmc_set_one_amd(void *arg)
+{
+	bool *enable = arg;
+
+	if (*enable)
+		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, ABMC_ENABLE_BIT);
+	else
+		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, ABMC_ENABLE_BIT);
+}
+
+static void _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_mon_domain *d;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list)
+		on_each_cpu_mask(&d->hdr.cpu_mask,
+				 resctrl_abmc_set_one_amd, &enable, 1);
+}
+
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (r->mon.mbm_cntr_assignable &&
+	    hw_res->mbm_cntr_assign_enabled != enable) {
+		_resctrl_abmc_enable(r, enable);
+		hw_res->mbm_cntr_assign_enabled = enable;
+	}
+
+	return 0;
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 511cfce8fc21..f11d6fdfd977 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -355,4 +355,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable);
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r);
+
 #endif /* _RESCTRL_H */
-- 
2.34.1


