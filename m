Return-Path: <linux-kernel+bounces-240255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE06926AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C06282107
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6D194ACF;
	Wed,  3 Jul 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jxAo63C7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F466194A5B;
	Wed,  3 Jul 2024 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043378; cv=fail; b=P08gB19nPwCv1FBAbQw4I6qIeOXq21B9OcclxPyMQIDmx53QS6ZKAAaL4lL+eYo/xoVvimXhg1zk6AjgJC8fOa27BkTZVnba0l4g9aZF7WqZ37ymxskr4hqxWHF7MUHdfz9FjmnIhCoX+StyA/MCPhki7U2ZZAcNDZ0f21CBqH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043378; c=relaxed/simple;
	bh=ctiS8aM0JSe0iH8iyLO7UJ//xc5tnTVH865Z9MikSD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Um+VHt1z7QkP0GOeuRn+C4uR5oZYv6lG0sWnpPhWpTdPPYH7LmjeD7/Nx6ddEQL6CjidqFEYmshwfNO0sSRPdL0F2+BW0Itw51rpoj44bN4sD0971BONHmRpzNZr6yqBjgMLOd7UmHnrxV5akWaZG5Pfzw8TyF6xGuuVdcnRSAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jxAo63C7; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLVGsCYkkTICpXZazK22QIWUK14Q9T5ZwPPm38z3hJKooNPWkuF1zNEU/P1wQI/VCeZkhhUcR8Oe04448typNYsOqYk2cWr+jlE52XvDqVzSUwHt5WGbS2olVCge6pGUK7kqcdEHBjFKIBzK/gGPaH3ea4N1e/2GBFZLX1limZ7twPRozrePYkIQfEEqCiAxUedkQ72M37DJ4M3CttZz886C74COzNrjn0++cTB34Yjed1OZx1XcTJg2jo5XkcvzS48j8+iMcdU+NFChjhJY3NM+IPBVJccDmQizPPcdpB1gdjNwuwQW0D7ErUtbf0mlXwjzMpTMgI7CodeFm+S02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEXkGucI87O6F1seTTwWieLSd5A5cBS1ifBJuM81v7k=;
 b=Cjjcg5X8YubUHfV/ovaI9lwSsoLtdr5k/2/uYwLu+TW+e7bsqJdvlOPuPsqH+Rhf0djnAnUN/yfGXDO1MEsi6T6iQhC+Z7Af3ZNQ+/R36JstO9n3OR1GsQ84UQieelnra6+bZBy1N8xMdh7NUPgBT0b6LwOdJSMqdGgkRBoFO7RT5gJFn0vM1BZVSyJbQceqK3Pbc4irVYtg+PMRmBPA7XGTzovflsb3orWzEQ6BjrEtjzJjYJ5w7zke+q2c0RhUp/MYY/BdMEfvJBue2Lk73robLW+iisNyriuvyaDlBKb9tmHZnWRgRM9jL0xiRzxUhsXNxKZjpfG2rB2O7TveQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEXkGucI87O6F1seTTwWieLSd5A5cBS1ifBJuM81v7k=;
 b=jxAo63C7ltOnDE8MjYxgqybGI4OOZtsVpEmVvckuOdbkqi8GdXAFfKLb0EOzPPMGCPNzY9iET7Ytb9AdBCzPSB965SA2vCZNHCnTxuM4VzIURIQDua8u3MYguOmZ5JTBty8FQTl1NvdFWZOQ/mzN9Uvcx1Y3auPPBnzwHAT7dOw=
Received: from CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38) by
 PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 21:49:32 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::81) by CH2PR05CA0025.outlook.office365.com
 (2603:10b6:610::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:30 -0500
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
Subject: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Wed, 3 Jul 2024 16:48:17 -0500
Message-ID: <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7d176a-1c42-4af2-8a08-08dc9baa05c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O6UkHnJP97BBmGmDYSzACssjMCmHvcgQjyJoVRyo2H4LLE2IOSyh7zY8zgN6?=
 =?us-ascii?Q?e6OHcnWWya+apcS+94+RTK3yncGlUQ+Dwhok3MtHoyw6AwE+hcW0+CZqaRSO?=
 =?us-ascii?Q?NA5AvOYIWjuOaqD9VwXkDifFZ8s5RMXz67fBBWKlpAFYcYxOzL+qVNWwnaf/?=
 =?us-ascii?Q?63xPnkLMc+fRa1mYx00otyf43aF4oioLST1mb2FCgKOc30FZ51UIPKrG7jBt?=
 =?us-ascii?Q?JM+QZ5k152NYfKGZNEXeqYtzvxv9sAOeV24ThfIGFbmZ4YJpN9O9AX1SaT9A?=
 =?us-ascii?Q?fEd6c3uh/l3pLqsuscphqv0FACAIXN3rVHNiwvCYk43Bt2b4h1G4N3hidkfx?=
 =?us-ascii?Q?/y/kkah3sjsV/9zFaT1SikFub2pfRft60kLnW/8S10NgVHOHX4uv/kZlsfzs?=
 =?us-ascii?Q?lONBpIRUkwe8pejz3lOG4TkMb9Qj/E5EOvOgzYBHI+rErlWcSrxr32AtCCqv?=
 =?us-ascii?Q?XkUHRJSXC/EBu0LGuUAfqlpze1Lna1xFLEAZ4GyowY3lj7692XJ8bTxrc2lx?=
 =?us-ascii?Q?zhDT/m+Bsqxoz3rqfOVrt1hIYUCQX/IDH3GHi1jm8Y02OTlz+5JvBVm2RCmA?=
 =?us-ascii?Q?IdiSNbyFjt5SMIa2fd4egah7YHsKdude29pXdn3KE9aIkGcIE1yxAzaFeBmy?=
 =?us-ascii?Q?ATy9yjcQBnNCDGq3aWGC2cLpX6zY3vy25uRsUU/ICK1/rh42yEh2NYQOs8+t?=
 =?us-ascii?Q?EaDW7fXu5pfE5u4MnPH2+YA+g3DsOAlA5yrezr7mU6KLmz1mFtP9uWSGKz5R?=
 =?us-ascii?Q?MSgSXZAMuuAdZerlZiE/uthWutoTAG5Tr0bBycEWDCV3T1m433KjLZvdLoBb?=
 =?us-ascii?Q?6gIbDQuqltMsGoamv2cm7RFpqdw+0JvlaEu39u7pd8BJoBW39H4rM1Ns3lDW?=
 =?us-ascii?Q?zP13LKYMaI/g4OoRhy8ccnRFb5kSPqz+LIPI5ERr3xq+AVt2Ocf9NF+UilOI?=
 =?us-ascii?Q?aMb4Jg1i2rON8tlGIOxK02LbKHCVtdEQEU6sb8H6BWm2aF2oSmd1qku034wt?=
 =?us-ascii?Q?Apht26Fb3ddwXX2ufj0DsEwW2c4A/nGP12yh7JLAu1nRjaWFoJymaJmPW5ie?=
 =?us-ascii?Q?024dlStZynXbHtNOOMZdbqY3e/08W2Xj2Bx8o4LS670W+3uJajFFoAj5B4EZ?=
 =?us-ascii?Q?DAepqGQfA4XVAS5IfhjmkOtaeyNiRyP9oZ5LjEbBwQQasm76fzbgqjtXYXqd?=
 =?us-ascii?Q?jrFqueOCrYJey3Aqup9IbgJ7NE2Q9fcYi6NLBeogj30l+EvzBJeNhvPQGTuY?=
 =?us-ascii?Q?68vIf0dgt2sEpxtt2hPDwc5GGMiJVwTU60d1s+EqsC7y1SW9Qcs3BR7IUQ2m?=
 =?us-ascii?Q?z4x24qzxX/TcJIoxiR2PXSas9dJuDYEcHPwH77Oj14PvBQurW/vmz6lXkE/9?=
 =?us-ascii?Q?QhtK0OJlXHPNxiBnHm8itjbyQK9H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:32.2382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7d176a-1c42-4af2-8a08-08dc9baa05c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

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

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
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
 arch/x86/kernel/cpu/resctrl/internal.h | 13 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 66 ++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 01342963011e..263b2d9d00ed 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1174,6 +1174,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2bd207624eec..0ce9797f80fe 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	return cpu;
 }
 
+/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
+#define ABMC_ENABLE			BIT(0)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -477,6 +480,7 @@ struct rdt_parse_data {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
  *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
+ * @abmc_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -491,6 +495,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
+	bool			abmc_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+static inline bool resctrl_arch_get_abmc_enabled(void)
+{
+	return rdt_resources_all[RDT_RESOURCE_L3].abmc_enabled;
+}
+
+int resctrl_arch_abmc_enable(void);
+void resctrl_arch_abmc_disable(void);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7e76f8d839fc..471fc0dbd7c3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2402,6 +2402,72 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+/*
+ * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the resource.
+ */
+static void resctrl_abmc_set_one_amd(void *arg)
+{
+	bool *enable = arg;
+	u64 msrval;
+
+	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
+
+	if (*enable)
+		msrval |= ABMC_ENABLE;
+	else
+		msrval &= ~ABMC_ENABLE;
+
+	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
+}
+
+static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
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
+
+	return 0;
+}
+
+int resctrl_arch_abmc_enable(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int ret = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (r->mon.abmc_capable && !hw_res->abmc_enabled) {
+		ret = _resctrl_abmc_enable(r, true);
+		if (!ret)
+			hw_res->abmc_enabled = true;
+	}
+
+	return ret;
+}
+
+void resctrl_arch_abmc_disable(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (hw_res->abmc_enabled) {
+		_resctrl_abmc_enable(r, false);
+		hw_res->abmc_enabled = false;
+	}
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
-- 
2.34.1


