Return-Path: <linux-kernel+bounces-276988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C877F949AC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527951F25395
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DBD8249F;
	Tue,  6 Aug 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B2zYHvEw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7F17839D;
	Tue,  6 Aug 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981717; cv=fail; b=UabQHXiF6S8aQI8m6VFc5qlt+jSxg82ZRP4d8Ke+rDH8w9Xi2X/BAy9dy3He8vv7kTaVVR6sj4zSCnQX5VHtEbtXmWYPN6oeaq7XwNR6TQZXU3L9UFlY2+vGLcE5D5F0QvYovxUIp71TQ5d57zH7wywlw8IJkb7g95ipYh3CIiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981717; c=relaxed/simple;
	bh=okw6cJM/4I7gD/Sk1UhJriASy5BjXO9ghC1m9T8vKE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHHxMzyh6pvuxU/67+xh1HNfOG1cPWmC2oxZ35m68fJWqyKG2jHG7PQw3BV/stf5Z1zcJfld+91C1X1+TNWsbEvpmUhDvzq8gMuGcTrcewIXwMZzWtJX/K7gqwDmfl5yWjU7odCw9yCqRlqCRSuCWpm9aPtrXZbjBR/h9NnKlRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B2zYHvEw; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpwCJWDq1hub7WC85ho7N0dAsuHmVBVIYDGPAZq2N2AS/s3iZXeP1LHC9+nO0g1vwed1FFzlKTTtWe1lHjMcXxwVxOF1iN6AtSSwruKj88dIEVLiE7bUG7vxhgRyH8CD5GRTwugS8GGDkh19JwSYX9i3AACpl1frlQ+gqVxwEhWMAqJDVgUb3Ti1grA97orjscFET7uo4CwI0acvRinRa+Gl6szOH9MXPWrbUV9PCNKLacFRZ6k4xkU8+TEikYa7/+QTklWVv4rqvSXYQIIKKyobGN+1a0uY9sNOqk0KabbX1TRA8PcJ325Msas9DnC1Eg6L0PwUvoUBOm0CmtFlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOtsYARouqgS+Tzr3CilimMzOnUPCEFzxEztq/0pQng=;
 b=xCONdPb7/oJ0FzC7CR/aeuT0xVBv+DE2Q0nPMQ9lY3cloT67hqr27ignJftmrV+BwIZV8/bhGBniwsXJgax3oAN4Jr212WZY+gw1ErE0qikUVBfDpxS1rjSsquB4Hk/3yYkZC1wHJrNOajy3FP+ZH23gpNnaaB6nSf2m6hdz6I2tSyYXxa04GEYThAnmhuWksA6YQgtRtDpLaZCnDH7i6/u+qfRuJXLLZrPfbwrYuxMzeLhNRFlvoFMUPhyUXZudZBfeEXAq9R0CIfUZyk5AZk8B/yrMgz09Woav9yFdQ/HDE8PfLoXeBqs6/hs1pzln7RL5zBZexoWZqwrVR73p8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOtsYARouqgS+Tzr3CilimMzOnUPCEFzxEztq/0pQng=;
 b=B2zYHvEwSMLqyYUg2xVX9tuPHkQBUvxNFl0+DUwbFp5fTnIxJxBeKm08ROtBkaQGOo4fxQFJEfuOPR50hj7Uhf21tm4Y38K5pUcDmCVtI2OWWkA2zLzRs09UNS1Jc7zFBL8/XFxVxHTN9QMAdxmUk+JB/6Lmb+t6UtAVwIxgdXc=
Received: from PH7P220CA0165.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::14)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 22:01:52 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::19) by PH7P220CA0165.outlook.office365.com
 (2603:10b6:510:33b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:50 -0500
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
Subject: [PATCH v6 06/22] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Tue, 6 Aug 2024 17:00:43 -0500
Message-ID: <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1b186f-1505-43b9-f9b8-08dcb663610b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/wjPBg7qKUZ+4VXXlFyEnoKUHTey/NuHlgJPhgFvFtVMr2rkFeLNXGP1OK5R?=
 =?us-ascii?Q?/DLK1BviVq24IBe6Qi8NXgKNpPCSQuMJG8KBBEJ8fpFzERCpLcOKtW58/PHr?=
 =?us-ascii?Q?s6Xli3P5Qc6sYkPCjcAk9wXJ4xqXLQakwgZo5OuqdQBZ87FfAfg8IJugyH7b?=
 =?us-ascii?Q?MI3l9JCDHXXWa1obd7TdKy8Hh4Y236nQeocublCRpKE85X4LnlWfIbNVl4jR?=
 =?us-ascii?Q?bx0qMlWRH2J4St3ebwSPWeowoapicB8EWyYaVKT0qbDOYahHsYvkowIL71Eg?=
 =?us-ascii?Q?JdK7Q0h3HNAIiw6VfOQ3092K+aOqywwo0q3sldp1wE9c9yaL++R1Kt+QGpLm?=
 =?us-ascii?Q?153PeU94yAUIjgwuq4piWlZWUuj/3pWmkVkgungkz+DX+iOcheiKcI1eV3gD?=
 =?us-ascii?Q?qJfSDnqogFCc+3kPCUV+VmLTtk3LS5YwspQAO/T9hM6zaBJ5CO2hulLD/+6T?=
 =?us-ascii?Q?ofaaFD6lyaNa9MIUHfbEXuwuBayrk/+lGomGRpY1tqvJwhwdk14MzhKzJnXz?=
 =?us-ascii?Q?mqOAsqFvspk+KHvSUui4VA/sSQIZX5YXZZUeuMSPgFm7MTY5sIk3kGswdCH7?=
 =?us-ascii?Q?4z/pn/rz6hxmrwtb+/wObUZi+5FjsYSdReQKqewYpSHCpemQv0JlxsZLepKA?=
 =?us-ascii?Q?qgCLjY4QrkIcRh+SV25zabJM6extlxWEoInbvi09uUEa4lpXRYSVwo75Hzha?=
 =?us-ascii?Q?LnNWDtdlFTbdTRMUjJDEaWhLARI9mOHFLODUXNeYlLap6k9DW/+gIvbPde8C?=
 =?us-ascii?Q?C5yN1lpjDX7JUBNvdA1jzi9OM5xvEbEDnAZ3PK8Qrj8M7q31vAgp4WuRWjdK?=
 =?us-ascii?Q?RwWqrI0IFUmcb/IHHmzw8iFJi+5cE9bz1nB/hjGnkex69N4Uj2Om5J102wdc?=
 =?us-ascii?Q?6DnJG0J/Ujhm2YnThNQYFYHoE+ZSSkQWYN6c491YdCuxt6ISHHO41i1mFtY8?=
 =?us-ascii?Q?UE8l/NUb2gql9mevqrOgWox8hNghI/f6Pk7tdkFnnHFCPIz7B90/nsPplDG/?=
 =?us-ascii?Q?guZn0GCdfUPn40amP+Jkj+0V4sSpKG8FyB2fL1dQz+9KIMmG4Shkb37kRDEZ?=
 =?us-ascii?Q?SSd0Yb+53onJrecizZilDBEvzGrw15tVEWtV27uY0dF8WdEAcL2ivXhCrcRN?=
 =?us-ascii?Q?lBSjEfOF7lIgmC0i0geGlQBpVDi+2rp0aaGdkdhiWLeXH55QSlT4AWTNCjfb?=
 =?us-ascii?Q?Rk+KRDVqX+4USF4OiIGqfOzXzEVudRPOiRExIXfK8hiAx7ydXA0kj/Jszi+p?=
 =?us-ascii?Q?k7UrZ3cZWrx64bCpVl5twiPdOd4iS8m3aDJmOY5jsdMLBdSTL3yJ/W3zElw6?=
 =?us-ascii?Q?BPRuGV5uKVV2IokyZK1C7ml99mCSmXo0tHCpWD2N2snuj7WGp1y2hgPwVdCW?=
 =?us-ascii?Q?6Li0D0aMQG76cucWNp0k2w/iFh3yU0aFYP8f7ZRrK3f6oD0xRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:52.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1b186f-1505-43b9-f9b8-08dcb663610b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372

Add the functionality to enable/disable AMD ABMC feature.

AMD ABMC feature is enabled by setting enabled bit(0) in MSR
L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
to be updated on all the logical processors in the QOS Domain.

Hardware counters will reset when ABMC state is changed. Reset the
architectural state so that reading of hardware counter is not considered
as an overflow in next update.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/internal.h | 13 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 57 ++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

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
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2bd207624eec..154983a67646 100644
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
@@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+static inline bool resctrl_arch_get_abmc_enabled(void)
+{
+	return rdt_resources_all[RDT_RESOURCE_L3].mbm_cntr_assign_enabled;
+}
+
+int resctrl_arch_mbm_cntr_assign_enable(void);
+void resctrl_arch_mbm_cntr_assign_disable(void);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7e76f8d839fc..6075b1e5bb77 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2402,6 +2402,63 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
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
+	/*
+	 * Hardware counters will reset after switching the monitor mode.
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in the next update.
+	 */
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		on_each_cpu_mask(&d->hdr.cpu_mask,
+				 resctrl_abmc_set_one_amd, &enable, 1);
+		resctrl_arch_reset_rmid_all(r, d);
+	}
+}
+
+int resctrl_arch_mbm_cntr_assign_enable(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (r->mon.mbm_cntr_assignable && !hw_res->mbm_cntr_assign_enabled) {
+		_resctrl_abmc_enable(r, true);
+		hw_res->mbm_cntr_assign_enabled = true;
+	}
+
+	return 0;
+}
+
+void resctrl_arch_mbm_cntr_assign_disable(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (hw_res->mbm_cntr_assign_enabled) {
+		_resctrl_abmc_enable(r, false);
+		hw_res->mbm_cntr_assign_enabled = false;
+	}
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
-- 
2.34.1


