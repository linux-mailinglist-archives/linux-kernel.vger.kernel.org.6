Return-Path: <linux-kernel+bounces-443886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D99EFD29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C5A169394
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F421C07E2;
	Thu, 12 Dec 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uVoTfcPP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F01AB6C9;
	Thu, 12 Dec 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034630; cv=fail; b=LUg5p29e1ZsbuK52Uf77h+Jakf5BRdbydwvVLzgBE58lm4LKG8zAb/2CUKx/LNft6plXHN1pSPLgKgKP/+gk+2np+OWS/AUjM+RDEvJ1QyPFcJFtGTAOKHKbItobiy/pbaeWTznYJ4PPz9IbeC65J1efg6ditQUwiwrypn77vZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034630; c=relaxed/simple;
	bh=8RrYCwNtDbFADlZTxI9AdvQ0BxyRLFiN/yG0A+RJovo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgDSiZxJG1MbAlUDLbN125+9Tgy/p4zy3VaKJaFHsxXXYtbpVx3JleMXeNbs215K8yrkt/3ARKK9gc7gBBEaJkW3mc4A+i/Nzz4ibS1wusBkZhm3qweRG+/+mqpDVhzgZfrJgRtNes+346htlebXoHP+PUwGPbFoKCis5Xnscxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uVoTfcPP; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inaV1bJ3BbIJ7sLgDuvURD/AVM5slO8Jy/DW1QquT43V7nwXGOx2qOgN4MkQb3WfJW7BiGLGQ68BRsRbv5YcrJkeOeimij6/Fj/Ezh4nRZFOC2tZOddyxoTl8oX+Bw7BOCefEbhIyp3V6HnArJapn55GwI7atzlPPFyfno1mWPxbsbsUr0KgPMEhSvkWEn8+ZobxAtBn0qc2+zpI4AgaA6+5EVh56LwrRQOzGuKHIAkp5B9yqtS7BW/c+SmXMiuXQX2jCIVMjFE5Z48bD5u3FXNe75cRsA3AWD33US3oHUzAUfrxZZuxkSvTedQTfY+THFxpmifMsigwIT0gr2Q0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4o4sAlEaEq+2CtxkRbcQCWycIDc+0V9PoXdKJq8zB4=;
 b=MzWDqTZO9vGt5IELyAF9hK+DVffdwPu+QLe4lfp+fErG5CbGYkAKz1zIEC9pC/BQOYzM1OWvBx77KTzgCKcaesmzaDk90QB5FR3rhJ9pvwxU60g9oJVk0VrhTzq2olTSbDAwgPbJOpGLMPMAyDRjhjmIHKKG/7yI2XFa5/uRW9fTZwHe/KiHkWkewWIn0ZFqfhfPk9vTXE29n4iBXxUFAS1jkY9MgXHkLP73wVOhjOaRweGXrqAwxhyYVws8aVyVQxRBb+JvZbYgi3e7GCyzJ9KIo2qWXeMjWGa6r3rJKGc5xN0BnF8J79FHpjrPeZUBxypwVlU3u63N+PA3sqPWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4o4sAlEaEq+2CtxkRbcQCWycIDc+0V9PoXdKJq8zB4=;
 b=uVoTfcPPWCphIwEGl12RDMmwz16MRGkIk3rL3d1DbFjvErumZgf0es4+HDVLEqGRC/lWoy3EStNiYj30ZQGkBCnNk4+q9Tui8QjteeqoVTbvtSZTu1Wi6Pg5ny1QL+0L4vOPA9pSV3A8ur0xhTxRr8+7qouSR0CuYeAEbasDiCI=
Received: from MN2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:208:a8::43)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:17:01 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::f) by MN2PR12CA0030.outlook.office365.com
 (2603:10b6:208:a8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:59 -0600
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
Subject: [PATCH v10 07/24] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Thu, 12 Dec 2024 14:15:10 -0600
Message-ID: <401d9591e0b76133b649f71029965d1eb2391f21.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1eb8ce-ee88-49b7-7fdf-08dd1ae9f011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5fEO6GWKL0YI7EUkB0czfCZdo00+ogDTZ0jIZ+5xPzVXwSrhV54804jVVeN?=
 =?us-ascii?Q?cqpJbzXAFlQmfsm6DiigRl1NmbW8qvZPkOsEEgppAR3hUANvsoUTdZwBVHgC?=
 =?us-ascii?Q?k1mLoEWirIQpAYmd4OK0YIIm7chXZetHDh9McmlPvS1Vy57XFQf8i9sXoOs9?=
 =?us-ascii?Q?+vfUoWpzYmAltQAlxlziqGBNAZb6b9c8dUDqLQ1PVEkNCVzLvRPgA1NE6tWL?=
 =?us-ascii?Q?82CMIuj2yJF3039gXWjXvDhMh0+zay4NmesyGMUH5J+9GdpLtkQM7yB9PQbq?=
 =?us-ascii?Q?+SYiVYN3JMIpVdbECxznbb5FjXkkKUSfNJ5ecJwlOXVixSFln+Kc/FdBxuHs?=
 =?us-ascii?Q?aINGYUwAEvgokLVyiQRaBV1KoNuroe5QjQsbdIFl4HtaWanq0A5vKh/JhvlF?=
 =?us-ascii?Q?7u0X50e0b28Uf0ZvIK6RPQbEL6AyV1sAhcYhaeHbU9Kz9dpyB1Po/k6VnCVS?=
 =?us-ascii?Q?Tk8U1r8c0rFIlOfVIXeDkPdDOWkJlqcMhVLzkAhwsw6x+f4pYjQvmUgzV/cp?=
 =?us-ascii?Q?YY7alGAXJ9bl4wixqvXSh0MVbqXN0zDqWA5phApc90N4+JCVmpfcgq4pGYaK?=
 =?us-ascii?Q?TJWllsK7/5SwFhGd4qlWdbPx5X0EQLbSH65On7uNdsT7jTFIVt7kKho3EMGZ?=
 =?us-ascii?Q?M9ZQ39L12HNl3TSdMaREEq4Jg1OEb6YAjc7bpiX+ErRkSJjJonbnZkbxXPN2?=
 =?us-ascii?Q?zJNbWLBadI/WC0T1MDt0ehnfeidGzyEA2bAUy6JB2aEKbqr//t7p7zeekztH?=
 =?us-ascii?Q?G12iiNrio4+bmBZ2tNwXHd7RQbTecUETjFThmADmnX9YTwt6T0m7EmTYUMOK?=
 =?us-ascii?Q?aWiVpbmuSPj/jamcA1aw528xi4HS3ObTvTOPbNHnfYoH8dRHf/PVB8aVElXq?=
 =?us-ascii?Q?TUAdx6ZSCGxmTtSvnBclH+OY5Ff2N8aTiLkTMbG/9MKFBkiQ/FCxgwAUquIv?=
 =?us-ascii?Q?HX8xx61V0+CiJdlD3eoN7C9YCdmoSVvhaOaRQ1frYbyoOKMfOJEyJXPbSriD?=
 =?us-ascii?Q?LzFmrF2e3Bf8nNll7vjAfoNW0PdcI+hzBGFrGUVE6uyvzzCq49t1MIwdqJha?=
 =?us-ascii?Q?JdVdGByd2grrmT499zg0N+pmHPli9wBenjSgBYr4Ok+jCmCwGSP1FdfxGAca?=
 =?us-ascii?Q?2wMtKSJLvaP4ct3ob3kdK013rnYCx/vi9u0fHzMFm98oXvaheFylgIHnLmO6?=
 =?us-ascii?Q?yJFtGTHNPVvQmhFmoPKHY3wwQFzelNJIRp9iOM41Q/WEBf+INod5i3lHggFP?=
 =?us-ascii?Q?9/S5TF4kmdm/J6zC8NQf4RqSolnG+ndD1/pZrBMZXsL9hoGywnkO5mfIHXYc?=
 =?us-ascii?Q?ZTrflOY1GhD5mIBtkPaJUfq9aYEjK2JHVRUysytb7z95c7w2nWhM4u310YcX?=
 =?us-ascii?Q?lwPzF4K4K5VGYCJLiFMElu9eHyXeiYC7Z78FkogK4X5rkIgq0ukqk+nqU9Aq?=
 =?us-ascii?Q?zaMxOIkfdu95DyzGrvGbB+3ukqawIJv0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:01.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1eb8ce-ee88-49b7-7fdf-08dd1ae9f011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

Add the functionality to enable/disable AMD ABMC feature.

AMD ABMC feature is enabled by setting enabled bit(0) in MSR
L3_QOS_EXT_CFG. When the state of ABMC is changed, the MSR needs
to be updated on all the logical processors in the QOS Domain.

Hardware counters will reset when ABMC state is changed.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v10: No changes.

v9: Re-ordered the MSR and added Reviewed-by tag.

v8: Commit message update and moved around the comments about L3_QOS_EXT_CFG
    to _resctrl_abmc_enable.

v7: Renamed the function
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 36 ++++++++++++++++++++++++++
 include/linux/resctrl.h                |  3 +++
 5 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..bdc95b7cd1b0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1194,6 +1194,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* AMD-V MSRs */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 45f74d57de84..407a80454ae1 100644
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
index 9dd1799adba3..c07a93da31cc 100644
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
index 687d9d8d82a4..d54c2701c09c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2402,6 +2402,42 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
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
+/*
+ * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the monitor
+ * domain.
+ */
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


