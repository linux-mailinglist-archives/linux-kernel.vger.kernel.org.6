Return-Path: <linux-kernel+bounces-443901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880F9EFD48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39830289EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596811DE8A6;
	Thu, 12 Dec 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s8D0F9Fr"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7BF1D63E0;
	Thu, 12 Dec 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034736; cv=fail; b=ply6rXIjN2tvUrHs7L5rrWwigLmMPV1XG6uSXM+Gr92odmHk9ZCH5aq+qcsQE0Jkm//UnN14t0Obyg9mfYXAOXClPdOsh2h5RYsvU17l8dW66fhDMjrStg6/RjR/D8GO8QRbqsyvad7+Pnb7Goks8r5wfJwUJs76ZgZDA67DTTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034736; c=relaxed/simple;
	bh=Uvhncm8z1IViTTGDq+VRhKBbfcJ4QQMhN+y1GddDLoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orCQBuCTnU22pFuBV9A58dlr8r7C+D3wD5fl3nQ/xOMFqo5nAuRoUKuisUsCLbmDRDuBqgilCDj7vw82e9vFfp6lY6s9AAbi52hCAfJyOHWzeN633MyJKq2pF3WMsFXLc3HfU1TzhGHo+0si0B7ugzWxZWsGk+WKbUVtBHR4JGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s8D0F9Fr; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnikfOlUmcfVfEzUpERv5gUlkUW/+3qZ/DLCzTnr3MpIadKqzJcYkvKYss1gCoQI7iustQEeeS1tqMsJ2WI8gUeQeDGU88SFNInRXmqYuCtktzA5pgQAsv+fIDRu4MTB8D9llD1ZhH66/mANDQO48YfnCQGEe8SY3EZwTkmo+1AwC5Lcyn6QlMyCEBATPFkAACzHY8tZu/HnsNlEposmD1QPSI50ln0S3k3iaMBUWDDhMD6wVYkym4f8qU0WlC1NWHXxG+9UUf0mAVd0GnDOOSsJoaBddkZGRIEel9H71OSlD3sI7CYIevAXs3nzSJyzKJnAeul1zb0+d3i5IOJSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TGOGWzi/LC/qXDA4FllsrqoRqqtWo5wn7OOlWyFOfI=;
 b=ejP5WaUFXg5a+IHmjfskzWn6yTghDliruv4iFWHWszn3bPhkoHQi/3xfxE1z0V4hLsVzJOBUUdnI/vGldR84kGLxl2bLLdYsbmqIsbvorEREwDrJAnavmVdZ33almigAkCOhzhL/aDkjSjU7H79+WLOe6xaOycUyx6sb2omV91fFQelHztjVcFxCSRSAmO/hehmtVt2LMYxSTCpT4I27cjBoFw3k/7TYihtpLvrmYBrYXadNzF68T9jhdrI6qelW63rHj9FkoIomDZNvLVclynxprh7yr+A4DCD1vxIegkgyzko99zaq7BhFfyfmUrs45LLixPzSuCydYjg/NdXqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TGOGWzi/LC/qXDA4FllsrqoRqqtWo5wn7OOlWyFOfI=;
 b=s8D0F9FrTwzEt5mV9znCjhpXs1btB6EDsWHwB6gfrirQSbd5lQaLjtawS5MIYlsE+FISy1jKsiWKbt0UEkb70N6RTFY6IuHRYaSGofCbBWOShxrzgTLptdVa9Z6NTy+qGbrzUDL3o531KTZY7yt6mgXCxXFt/mruXumHsoaGUJQ=
Received: from MN2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:208:1a0::35)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:18:51 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::70) by MN2PR07CA0025.outlook.office365.com
 (2603:10b6:208:1a0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:49 -0600
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
Subject: [PATCH v10 21/24] x86/resctrl: Configure mbm_cntr_assign mode if supported
Date: Thu, 12 Dec 2024 14:15:24 -0600
Message-ID: <5ef497199a48c72a3a9100ca5e96f6a04ba94f30.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: a3266a27-c9aa-402a-ff9b-08dd1aea3172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?El6+lr6jJvgC/hHTFVemhTdrdCs89FPeJskIjiGBmbN89l8nvZKPfx73SLjr?=
 =?us-ascii?Q?wbhh5dxYOWJEq8kbymm4TgGz5GYmrAJQAeJ3+VaQspY5mZN7QGpNRFAjaDit?=
 =?us-ascii?Q?p1nxJ8tFFk/wI96Ew2MlKVYkP8rEM7qqCSu9nmtlzvYl9TqQgjGNAe2klxPV?=
 =?us-ascii?Q?zeADw8U/SdDYSxfjCRcCCVUfhvixrd5Mol2fEKfZ1hBRcfKKkZ66qVY2xAN7?=
 =?us-ascii?Q?ocLhAP8p5r6SsnslQTQ0A/8QAPqS/eU63g7e1ThwDG1bQtGb7ERugu64xBpc?=
 =?us-ascii?Q?E+LjaK+GJHAND//kaTmvoSskWsiWb47UOK7TaEf/AIukyCj1QP3yB1/gBFhX?=
 =?us-ascii?Q?NeB1DAcm+t2EgUWWPA4gi2NXzz4PBIXi99rXPVuScCr8Xx+ZFA3RrQ/8DjNu?=
 =?us-ascii?Q?LK8XJ7vuiznk86K4Wk2qTxJFlFcDBj7gdTk77wnRVNOIY2z2vpgHmV1OB73S?=
 =?us-ascii?Q?1bDWx28PBgJnWvtf2PGVrVWMrSkr5rnqEnDyEpYGxbl+mUPlCCSh7AVJpzFS?=
 =?us-ascii?Q?EZSgV00tWIPo9B54Gq2ZTH848bAqbG6k5UAsNPu4154e+G0DrNn1kEDxSq50?=
 =?us-ascii?Q?XbmJWyWeLZSO+28HJoiUkreNE3HqI1s85PlZdehj3N9SD3B5HSwVxts24egL?=
 =?us-ascii?Q?raem9/Qa+PGrzCaeJx6yrAw5LfyMfgRNlxRar+lqe69mjt3HOTN+h2+Lw/XL?=
 =?us-ascii?Q?DLWo/HG1wDykYpVmd7JU65OMr+B6yK/f+UDlR6DcriK/LNYQ/fa3zPCfui4S?=
 =?us-ascii?Q?vj3N/9FMTjUmy9tBrb3HsuzJxIHPq82jPu0b1E/jrOfoE2YAaGyIQhWVm7sZ?=
 =?us-ascii?Q?h6wie9+5U8a8Tcc7Q8aDURfsyK+9mhUlkQn4hxrjijbI5ndQvKc3ThirXoIz?=
 =?us-ascii?Q?v+XhcbozYAUdm07vsRABaPUIkoDDokwqIqv+gbv+B8P2mYowz2if9bD1J0NF?=
 =?us-ascii?Q?Cr81yIQdmpJxldNZ7J8/CoOG3Gvv5NWCNde4XPBv5Dd8Z5r7iwMa28YEG8Rm?=
 =?us-ascii?Q?cTl83hOA4SmXzRC7HPuYJzpYfK7Z+NKSJ7DYvIPjuiyRS/JMm3SkPT26xcYB?=
 =?us-ascii?Q?+zQrw1RKbVAIiwLB8zmcFcQUxQzCafPq/sFHB8bxDOJf/eQ44bPEMcMgdTkE?=
 =?us-ascii?Q?QO1cAu+bsPm0l5/X5KduwbbUALrmoj+vCUYdks/xIezziGyVJkYoWJmS1syq?=
 =?us-ascii?Q?xCWcjRCNVFXS+EvW0Tf3OvH6XT8eA9wLVhtd54iyYo1UZQCj63DTDgtqj4Xj?=
 =?us-ascii?Q?nFlUbaIa6LwfyPCmvP603+sPuOOMXcesT/GliR88b3SLhXcXSLfoOod1DE8b?=
 =?us-ascii?Q?L1Dfh3ogvcLRtkxMuvbQ+N0uHMG6oYeq93s1sJN8Aj7k5EbWRcc8KVJXzdd5?=
 =?us-ascii?Q?Qd8mTJR4Edi88V88DOR9zqCxF9X8CH2MkBxsMRh8ZiOFikc7smOrqhsz7SvQ?=
 =?us-ascii?Q?R+Ym1IvePxRj5Kp3yNMdt5ydcjwTvquM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:51.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3266a27-c9aa-402a-ff9b-08dd1aea3172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

Configure mbm_cntr_assign on AMD. 'mbm_cntr_assign' mode in AMD is ABMC
(Assignable Bandwidth Monitoring Counters). It is enabled by default when
supported on the system.

Ensure that the ABMC is updated on all logical processors in the resctrl
domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Commit text in imperative tone.

v9: Minor code change due to merge. Actual code did not change.

v8: Renamed resctrl_arch_mbm_cntr_assign_configure to
	resctrl_arch_mbm_cntr_assign_set_one.
    Adde r->mon_capable check.
    Commit message update.

v7: Introduced resctrl_arch_mbm_cntr_assign_configure() to configure.
    Moved the default settings to rdt_get_mon_l3_config(). It should be
    done before the hotplug handler is called. It cannot be done at
    rdtgroup_init().

v6: Keeping the default enablement in arch init code for now.
     This may need some discussion.
     Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.

v5: New patch to enable ABMC by default.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bb3213a7993e..1ca51f68a523 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -712,4 +712,5 @@ struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 				u32 rmid, enum resctrl_event_id evtid);
 bool mbm_cntr_assigned(struct rdt_resource *r, struct rdt_mon_domain *d,
 		       struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8823cd97ff1f..845636a205bf 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1237,6 +1237,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.mbm_cntr_assignable = true;
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+			hw_res->mbm_cntr_assign_enabled = true;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index eea534cce3d0..65b3556978ad 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2824,6 +2824,13 @@ int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
 	return 0;
 }
 
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -4600,9 +4607,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 
 void resctrl_online_cpu(unsigned int cpu)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	mutex_lock(&rdtgroup_mutex);
 	/* The CPU is set in default rdtgroup after online. */
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+	if (r->mon_capable && r->mon.mbm_cntr_assignable)
+		resctrl_arch_mbm_cntr_assign_set_one(r);
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-- 
2.34.1


