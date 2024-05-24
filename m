Return-Path: <linux-kernel+bounces-188676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E732E8CE53C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171D51C216B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA286630;
	Fri, 24 May 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RTZMbBKa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0986641;
	Fri, 24 May 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553492; cv=fail; b=YRRFWNBJx1IUus7cHSnXxJ1XD/1Dh1o9kYTVUaeSkukfNflYfgEpr/YRgBMRmnjC+D8gbPwDee3qKPubMlrZjVGXDSkjUnOvGRnPi5UM13wmobasOPTKcP+Ocg6sDBsr+z2RF86zBA5WeaAELW1Y0L6ua9uHPYkDL2In8lRJ8NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553492; c=relaxed/simple;
	bh=+XwltoGDr22lFhm1jEsLBxQSrsP+yYS/fJuzbUggEMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAZJoRh0HL4Ur9ABb9O8re43/Oy1bVQLWwle6Z384ANViRxDwAzwN0Tz8GOL00fWexf8cdBZpcT+B7MFzP4oZXIWYXs6GaMcnH9hoZ5cdMrVXOgbMgadhVWg52cWVQu2nxG8Yjvu0sA1vd51LEOoXeqkG+dJpldqeKkuYYqAd/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RTZMbBKa; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfJdQNGLD+eqTauVK9JlsWmH735se0bzXkbMfPT0Gt2VrXhrZ16MLwj7vi1jKH2uG7mn/LwRuGd3ODhCBBenshOcu8lBQUZ2UQG3nS6Ze8HTE6rtnnOB8LoXEgfIb3EAki/l0gQ8ly2cFEp8rsOPlVF5cRuqVJWIyjIENb2iJFlmO6GNJEnzWmku6vuOTX1V8d2RYeliCH9/ExdAXkak0eVCp7kosR+SJjOfXDHCNWapWfEu08zCqEiEOoTZb0fBNf7Bg06Qj4+IAkyT3ly8Re2yhsI1mpsmIDJXIw9rQ2IRjDOjBxbVaslatp62tfIREGGLuNN5YGff0teVMyyP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCjzFycqxXpix3tzrYVGZlnzw99+wAg1/nxxnkJFLxA=;
 b=fkqvjQ3YLhxe1iOKUgRR6xN8sLs2noeLpyfr8E8AW3HxkRUI+NnWYr0mqr5NQJwtC0ygiKZsfo6eRxBD4LyLtve8BaDkge8GVYyb2QLwbykRr5w7YoVJcnps8lpeRv0NIUoG5ddkJzjDbq5QVoDXQ5/fqfBS2YsKstW1BYxfRIMAN/BQg34KeLIcdJ1VW3U+P4O0Z+kSFn60Pd9VHPHTGjFFQ+hewIGoKDMKgQ+fgCYblIY3NG2NWZTz0gKDwXEVel6L1E1XMYKn6yO+WSg9XCJaTzRvNSntCIcfXuUh1rTm3CJ7TR1oLUKrQUIvqgFVhCL6Ped+kFkNtbPaTicvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCjzFycqxXpix3tzrYVGZlnzw99+wAg1/nxxnkJFLxA=;
 b=RTZMbBKaKz+JfWbOUEeNkwSkwds5SLp6ghz9v03engzmw6Oj0s5QK66a89T/9ZKgc5JIAcPbFkUz5hTtEHg8Qmo2YkNp6pRm1HxJ9rQoEdttNejUKQC7nVsmPUBLxoUsITEQGSpKfDSN7veCEmzOeyWXlaO11S14XPOOuin8Ixs=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:24:45 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9c) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21 via Frontend
 Transport; Fri, 24 May 2024 12:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:43 -0500
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
Subject: [PATCH v4 07/19] x86/resctrl: Add support to enable/disable ABMC feature
Date: Fri, 24 May 2024 07:23:26 -0500
Message-ID: <e4edf1794852cff132b17c8f061f24799d9e79ad.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 060c938c-1303-46fd-60f7-08dc7bec7f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtPvJDTNDUDt2b3FUBF/zuUpt5p4QjzdeJURSLdTb3wnvBtpR8zquvAFjowz?=
 =?us-ascii?Q?rTrPpKp7Lf1SyEEyQmPx+VydNjQ/AHTRu+p6He+/3r72qBurG2YPY8k1ffxa?=
 =?us-ascii?Q?7SSlNUrFs67Cq9ZJbuHxkiqlAGM6yPsaGD4dbhL85ILghYO/kxTrCEij9WUL?=
 =?us-ascii?Q?b5mxrnsFf7XoVouBU0UsKuT4PBWZNX/qBWquxLoHStgmR5GeenZA7GuTtMKC?=
 =?us-ascii?Q?FvPEiFqpgPlgMan7Nt0+vSvwKlNPPFCXGd0nmDgMeXRm40xbQTRNHI1pfRkS?=
 =?us-ascii?Q?t9iYJOiod9ELK9X/HUcU3iIBnzvV0vNM5/nLW31Przi8n/xElKdztOoV7kRd?=
 =?us-ascii?Q?OOa0aVLqlS+eInI/ZPvnSnZ/MVMeJDiZMWMQkxeMgHsSuqNGRGcUrTkqO9/L?=
 =?us-ascii?Q?WhDBUA3Vxh1OkrCe4opYi2fB+U+Z+en7tvdu8GR7g4foCJ786Ahwp5QA2pWT?=
 =?us-ascii?Q?J8ChCSNJZQWCLpbWmzKUzGs0N1dvV+z/Gvu8tTki0kLTUHEAOADJvUBbukBQ?=
 =?us-ascii?Q?cAxRfWdgH8yCO4RZejdaWArAqSFaZh5g1xGSGzJZOYRXk6K9cgdzjFI9SQU2?=
 =?us-ascii?Q?6iua5WuByNcgyZHBrVK0bcyKDtb/+2cVV+UVfWsU8Zqa31w6yeLThMjmx9KV?=
 =?us-ascii?Q?D/F5SYFX8KXmcSJVzm0zmuqAFgQubY4OjghUG+cNhJO1hbufPvPAIfvbt4gB?=
 =?us-ascii?Q?YKDTULhsopuV2pRQ3bp17Lzu50sV5FUgMs0qPNzMnOIpPrI3h/bW6vSiR067?=
 =?us-ascii?Q?1uQ+N/LLtAA//64ZbzHT2VuNrzLONmApJ6iGD5igiBiEM0S0rr/0IG8kiC0Y?=
 =?us-ascii?Q?ZNB24DmGqRb7OjMYFJWACcO4Sdvtz6mAkSTh+q4+gVs0LKgzgVHHCBFwJ9DU?=
 =?us-ascii?Q?UGBfDGNSh9fD4q6SamJceW9BIs+AZPkB3UA6d60L/ALmRNTHQRCxHetP2u6g?=
 =?us-ascii?Q?0qiCY+0loeeIBzf/tLy+4Rr75tuL218PUqS62n6GUqlUvtKy/chCXsoITq7k?=
 =?us-ascii?Q?Y8KDuaqZD2ZLUDeTQIUJ/uN2ktrSEqi1kkLVuIkltZtQvPp3NeCxugxtROOz?=
 =?us-ascii?Q?opiFrLaGa69wGpcDvx4DCULMn1Y9DVWuooMTIhJ6kDffAbi/397Kt0AyKlWp?=
 =?us-ascii?Q?vdwDpm1HqM1DH3IsUg8NZq7Lcjg7Erm5MREyVCEz3bETsUC6zU3EnIXZdtfp?=
 =?us-ascii?Q?gJpDn892o3yWrgoMPwQNuultsq8c9lml698t4FBWx+Y/oVsMra3/51u/nyCI?=
 =?us-ascii?Q?OyUWpCryPTDtkA3W12TY7pzArDdFKFkMZNZqxHBSapaI/g6rSGe/DEkbDK1N?=
 =?us-ascii?Q?pBu4r8LvRlaS4+lUr/YjbfO0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:45.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060c938c-1303-46fd-60f7-08dc7bec7f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Add the functionality to enable/disable ABMC feature.

ABMC feature is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG.
When the state of ABMC is changed, the MSR needs to be updated on all
the logical processors in the QOS Domain.

Hardware counters will reset when ABMC state is changed. Kernel internal
counters need to be reset to avoid overflow condition in the next update.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v4: Removed resctrl_arch_set_abmc_enabled and resctrl_arch_get_abmc_enabled.
    Directly calling resctrl_abmc_enable and resctrl_abmc_disable.
    Renamed couple of functions.
    resctrl_abmc_msrwrite() -> resctrl_abmc_set_one()
    resctrl_abmc_setup() -> resctrl_abmc_set_all()
    Added rdtgroup_mutex lockdep asserts.
    Updated commit log and code comments.

v3: No changes.

v2: Few text changes in commit message.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  8 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 ++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..5f9a0139e98c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1171,6 +1171,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d566251094b2..fabe40304798 100644
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
@@ -436,6 +439,7 @@ struct rdt_parse_data {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
  *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
+ * @abmc_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -450,6 +454,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
+	bool			abmc_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -493,6 +498,9 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
+int resctrl_abmc_enable(enum resctrl_res_level l);
+void resctrl_abmc_disable(enum resctrl_res_level l);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ca692712b393..9148d1234ede 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2416,6 +2416,68 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+static void resctrl_abmc_set_one(void *arg)
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
+static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdt_domain *d;
+
+	/*
+	 * Update QOS_CFG MSR on all the CPUs associated with the resource
+	 * Hardware counters will reset after switching the monotor mode.
+	 * Reset the internal counters so that it is not considered as
+	 * an overflow in next update.
+	 */
+	list_for_each_entry(d, &r->domains, list) {
+		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_set_one, &enable, 1);
+		resctrl_arch_reset_rmid_all(r, d);
+	}
+
+	return 0;
+}
+
+int resctrl_abmc_enable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+	int ret = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!hw_res->abmc_enabled) {
+		ret = resctrl_abmc_set_all(l, true);
+		if (!ret)
+			hw_res->abmc_enabled = true;
+	}
+
+	return ret;
+}
+
+void resctrl_abmc_disable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (hw_res->abmc_enabled) {
+		resctrl_abmc_set_all(l, false);
+		hw_res->abmc_enabled = false;
+	}
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
-- 
2.34.1


