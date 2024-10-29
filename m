Return-Path: <linux-kernel+bounces-387834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3A9B56BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA0E1C20D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB320C021;
	Tue, 29 Oct 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vu9zUS76"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55020B1E1;
	Tue, 29 Oct 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244211; cv=fail; b=shm8yqGsGyU6iTNafxkMU61+jrAnzH+wD8gU06edDWoQQt5E4RW11Utt25gtxePoaTAbONe+Y/5C6YNuokR1pSVg7TbWQWNMZWdC35TP1ew7htAB3Klk6O8ncDoj5aAIGC4G3WGw19wKAqFMjXFFDpstK3cLe8E1lQ0NGxKjujY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244211; c=relaxed/simple;
	bh=bM7G9rhz7fS9fFrT5fpHKNoHD+RlInYvyzrWLnRpi34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB1R9HGrQsQJDuhcCZhQcYJzpD3YlULArVWcdM4wby61N9Hk6ffILosvwkTPRXvYGSrl/JPpxJSEKmEqQRkgXHfzV1iA1tnfTJH/WdJ6Z526TT3gHKa+FcTiIjGNor5ipJq1dnaCCKTWUPTND9Qh1oDxFhed+YmUCbIt0fWfjC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vu9zUS76; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8IPYiazYMrj8l9mGXwjWmGIvHxhv7/CY/zEM3RXLnN1IsXtDY4WUsxsYgWGLRhiNQ7dEchFxsNqzThkjHZedsg0CYYmrOeP+eectEgWXNjubZoJ0maLpyTeZrqEpV03ucVkaapM3rSH/grf1uGcgvB9/VPRoFZd6sfr6OLDQyR0cUoGNvNASTzbooUVyVeic8dDGUlLNB6+zFg4IiK/WW7JRYvzuwfyM+gKPvlMJ62s6vS3jmIMeZy/Lqp7qwrQEdveKLtEg1XrsRPKZ8aBrSZgdUpCNr2E7bNXnlgLpI0UnuDjblXPBfpY7/ngdcTm0EQr9XusSJn4fHCvsA1Uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgC4xsyggsbag7VOHcTxXDOXQKnolLhpcCgOEXWrkos=;
 b=CaX3tbmYezvvVGHnQPQwsCfsJDVgrRNcd3y941f3EoAyU4mfChYXV7Dns9N/aV+o9SaYXnCwsBbT0bwBn7KzK2CIhb2Y2c6ak3MmXAVC6mrhKjn5MyHtmu/x5MzCk0aeQiJ8o9YUfMOatrtnA/6DA5s/xtmfjydEyse4PcZXS5c3VPycIG4Af+wPTr3We3B0g+8L9O7y7397b4o17aX5EFFefIT+lNqNjONqmZMNrcWp/gBE01ES+2LzFOEOsi6JiaJqDzS3JKevUg56ofRdxSjWJUhNKm070ISEncXS3SjB7LWlXJb83ZwH7zpbXCk5um9PRI+TJ4rwEAEzerm+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgC4xsyggsbag7VOHcTxXDOXQKnolLhpcCgOEXWrkos=;
 b=Vu9zUS76wa6SmXbsrIJOtJQEj1rhOAEuV2zjVct3yoJgHwckUmq4trTZQkQrvS4vlUbU3zrbF0S2ZF9sbaLoOGel6QNKuZhVju3PUrfLcAzPFWNZClyPyCx4iBv9ulqZwsUvvgq4Q8mABnw61qQNJCS8em5voZFStMfOAnDiv/c=
Received: from MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 23:23:25 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::53) by MW3PR06CA0024.outlook.office365.com
 (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:08 -0500
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
Subject: [PATCH v9 07/26] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Tue, 29 Oct 2024 18:21:39 -0500
Message-ID: <b50aa8e3853b204a6d615c58ddf09419adb26dc2.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd5706a-d7ef-4eea-4f55-08dcf870afaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLiFHDPDXtYzBOxzg8ZsmXXClnbYTkzUGHt1tjZ2j/fXZfhP7df1k/HmlztJ?=
 =?us-ascii?Q?GxADNzjwQMq30ySeRoWIG2CFnbwhEE5MVRit8P7Qv2fWa879kRImZwQ2SFZG?=
 =?us-ascii?Q?Y7xqeY1QmKkJC9m//uP8gobNgTs6Kamn2Mrq7xjHODLraVwrIYwDnDByi/dj?=
 =?us-ascii?Q?KmmcpI6rp/+MfUipMQuvNutIaHrVEN+ZCmKJA2JTLb49XjlPhDK3eWwN0ldS?=
 =?us-ascii?Q?+T+PzTW9HFyhYRgcOYlHWW3i+TmzHyJHgju5fW8uGDz70KhvIKO3SHla5HcB?=
 =?us-ascii?Q?sMuT6IXQrLSMYTJ3T6BfZjnbd87R5JZRGzIfgqjp7d5P1o7leCRXNSEnGSvS?=
 =?us-ascii?Q?p+ToNmB7+U1aXE7BlK/U5easV/zxIP+w5dHlaxkZXuE1y7xQvop5HmhIYYTR?=
 =?us-ascii?Q?RLQF7Kr3/DSBUl/xu+bQz39KN8Q5xoOsIvRjtBYEPCFKc6tvJ/K2+V/D+yWB?=
 =?us-ascii?Q?vnsxc6jFg2nHRx2cFkbQjmO0NdkcAQb3ZhG9PJwb99N2UfEYAgyNvzpgIx/n?=
 =?us-ascii?Q?F8TBKdEgZ2a2H7zZQeDBwJZrnTFcRk2L8RP/gYs3dq1EBUMdxQtYXIN87DYp?=
 =?us-ascii?Q?QjVm0BQoIylXaCq6j3+2dlPvWiaSzNIUIrGrgKHMWlSOsdKnMxeTjSiNVZba?=
 =?us-ascii?Q?x+0t6/Sjt2R5+GrnL1iNHEXJ86kNaTP7wBOSwEFRj07vpwwx+6WFYOPTX8zH?=
 =?us-ascii?Q?Ckvyo+aE8oCgnofevfTaEZVBujEPBmDHi6OpcSIaf+6wvLBGZ+1mU49kANVg?=
 =?us-ascii?Q?qALW6RyP4YYI1cy6rY6WYzrZwc5LbwDgtIpqy7TO6vF4cENlwWH6CpjQnbxS?=
 =?us-ascii?Q?gg7adBEIusR2owq2zMVOTRHihRx/plGh8R//1pt+HYZ376K0ukCteoeP4d68?=
 =?us-ascii?Q?lKNuIeAEMpftgdr8v9197flIvIuv6KoZLO1yrhR3vNsuoVHkXVOVWrIJv3jQ?=
 =?us-ascii?Q?urvDEAtjwo0hv4GM0ZMZxc/cDUG1ja6aCyRLxUW0txIPme9Bb0QyaA1i1piq?=
 =?us-ascii?Q?qVMTEll2zxj0wCYZxSQ/ySL0kqf5wC3qhkPd344IyeQXV/ERRBIFpC8EgrsG?=
 =?us-ascii?Q?QaDTOymqyteygOblrB1cF39vBXQl4IfDBpCB6mpqTE++Q12pqiU8OwvLJXYw?=
 =?us-ascii?Q?nQ2qGl9LnZoHvCAx+2Z8DA/egadFgOe6KU55r4eOg5v2FcQeNyX5MFFawLXs?=
 =?us-ascii?Q?+UsHl0GqXHiBbePlEX6CYHr1Xmrkqdx6oel3EDdwYkoiB1soH/l81vTAX1Md?=
 =?us-ascii?Q?SwDUNYvyz0YDFOsjb8yR+yBgFjPD1J/GlOCSwvyJLsk7XMy28phgl3cWLedU?=
 =?us-ascii?Q?XNcBeSBZboRsB+sTbVd2v+vWIi0MnJQd9k2uOvCUiaQ3wP6HUL95iOZAkydS?=
 =?us-ascii?Q?yw7T3kZd2Vl4JpvpUv8qVZHfYZGra6jGksIW/7pZp639dr9pHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:24.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd5706a-d7ef-4eea-4f55-08dcf870afaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

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
index 7beac735c8e5..9603f5cb483c 100644
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


