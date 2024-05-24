Return-Path: <linux-kernel+bounces-188684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359D8CE54F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E71F211D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01F127B68;
	Fri, 24 May 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YsFjzSqM"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC668626A;
	Fri, 24 May 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553550; cv=fail; b=p+J5PTJtS1juHqpaJa6WXG+MFqC6B6nsTr9zQgLQjrK12DFgqhcwyg4WvQR83RrZb/mrvc1KNiU2TIS6yRMYPoSWsTCoxzwTxoGjJHHPgbdMfltsaXcxoLUTu/n3yejTW9MY/Fj5TF57ifzSRMyIozUMxLK43vSpD1eYI3t6hwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553550; c=relaxed/simple;
	bh=Zt+17xK3ugIFHbr9urDglZVF5daS1aPHokBJX/78Dn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyJjSCq+g/ozCM3c7W9ClxLMgn9jN5CDE+zKWKgojhEPunIjbdeexJXlphjwlSAbHMiziFeozAqxJCEblNLTpVURhD38vkDoEuwpgJiWKEZFpBp6IThBnTimFcU9Psa8qJekR80Pt6D8U/f/dkOvvYlNaU63wC56u+CaFlbUnq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YsFjzSqM; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/uhAIfhURVUaZrLLvkEyWRmTJnRyEZALpaksY2a0xWUTjW5NcnIrpivst+Jb6ZCBepeiurlgvwTNW7Bp+HxgxmM+p+2dnOXVZFzkwzb4J9pFDCswlV/44tcEduXADvsjzVWjHCTw15Ez9etbKt0+T+agt2AG/36mYQtoIsWGx4OkbrzwmbfesVDqQzdDWkjEEUhEw+mFmcz3mrdqsqcbKskIj4y7JUzxWMBfp4+EkDYKNoZJZYM+3NEmAP/tyzSeH/y0eV2mPRfyz0DHqBNh7USxcAcvpSRDSj8tqKNlM/yaxjugsuFw22wkSvs03gD1ChIoisZSU3VXJI82Z7+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjnJFVq85AMjM1UJvpPJuaj0pnGR1mcAepsamLU+YZ8=;
 b=F9SaZAAkZ16F9vvOtUp6ff94LIhSaw98WtlIS3tQDBNfZuNWE1OMz/Zu97VYMngAOsAd/WQojdHfGl3MhG5fHP5jBr1JMLaOWAaupcFP/1AsGshQ0g3yEbXnuGRrZwtCLuVQqa0wvV8nKIWqIuFC9Gl+G+4vWL+tyscX7piwn5krbsNBehjwkha6DABUM7IgDrPmTzH/gyzrywpNNYz2A1ik9M41YbwUQlNVpBClz3HQ0BikfbW2fSuAY4w8BdXZShtQYMVKsqgvKzZvJ7iDTf1YdATJeuIov1SXW721zbaboQOuqzUfJ9afGAmkj8KMJ14tAHI1VdcBjDxBNt7/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjnJFVq85AMjM1UJvpPJuaj0pnGR1mcAepsamLU+YZ8=;
 b=YsFjzSqMAcaR2oNB8vicQrsip1eFXtLtTqbsJHoEpDFc3/NZ8ZDNIIiE5VJiVIYXW4XaarwvJNnAWEnveSXFZ8uN3UVuo9a0JLf7buZ/K0qEGN4iGSF8605WMj/wfjrHX+o4vzMIM5X6kpuFEeuxG8dtcjhFw7cpMsz2CBlWP8c=
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 24 May
 2024 12:25:43 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6f) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Fri, 24 May 2024 12:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:39 -0500
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
Subject: [PATCH v4 14/19] x86/resctrl: Add the interface to assign ABMC counter
Date: Fri, 24 May 2024 07:23:33 -0500
Message-ID: <631092558e7fe0ac2e6267070e40c4a97b300f57.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf284b9-4f9d-43c1-099c-08dc7beca0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOxeYALbm3UtBjELLLv4ZvnbXuuIvFU+6lQctUDlYp/LkhuIw5s5W/Cuhofu?=
 =?us-ascii?Q?76yeSIBc/DXueBaDtrAbxC5/to2cVLi3Fab9SgNrfom+Q2eLLOPcplG+2yeB?=
 =?us-ascii?Q?V3bpTf2+CUJQRmSJbhWDs1PQ9alPW1HaWAITtWb4BA79Iue0WYkAPDIorLIU?=
 =?us-ascii?Q?Z50N0w9rT8lvGxqnYdkvFgop9a0DE+BGuFfcvm7Z/Tclm4PvmPF4pywdiAuZ?=
 =?us-ascii?Q?t1buKLwhopqXcWWiOztSiO9a2HjRGc/0rS5hAegiRbLHSbd9Cd2ESkfVJhwS?=
 =?us-ascii?Q?Bgxb6+7+m6ylL/jfB9KpcriP3Ey/lJsbBgdgrJqXEYeNFYhRF0EckbXSPkum?=
 =?us-ascii?Q?TS6ecDYhvR/XvCHm/rBeFKglAuSm5qQcnfsSV1Z4/aBGYBkD4Lb/Hhs3DXCL?=
 =?us-ascii?Q?hseu70LuKG6+xguWV4Vjd/QZnNIyQgpyaWyZKJMAVzQPNJmZc0hhyv6lgliE?=
 =?us-ascii?Q?yhQIt6BWzclkULDROFXR5JVefdmW/4BwKpoiXhMn/eCIBVp42tjFVcvsvXuW?=
 =?us-ascii?Q?Fc01y6XXFonTTArZeFER2ZyROhabrm+CsyFLltR98pKVEvTg4ibiQNTbhoqG?=
 =?us-ascii?Q?CQYBl9dyKf03RmXKNj5I8ic3OBKOH9UnF3VrNdIO4z3JzmFZVlnwscXD66/p?=
 =?us-ascii?Q?qT5X/BmtNpzSjKjkxvWklfDZ79K27ciBTS3Wly1N3ITqAk9+fTFVRanV4ZYG?=
 =?us-ascii?Q?sQ0CfHODmy4/XjQnVJAfJXMMnn+7gb2aqQUSam+1a+6pKqJzqpFOsxht0ySP?=
 =?us-ascii?Q?sRZD/1IVuLfw0yOne63ZQE/wVXkl7CRldDxd/muHZ0ehEU3KLkO+AqXzs1cC?=
 =?us-ascii?Q?Q8c07JNYmCK48GqUioOacfH+A2AsF4phYZisD91j0UpjBIWUjWX2IqeL/yG2?=
 =?us-ascii?Q?+iRussmH8tyuLh+HIPrQ6Rehv+79niL/+g9sPJAIyh4RG2n7V4kwaiY9k0J/?=
 =?us-ascii?Q?mkkyEgVyidsS253ltlrQeUXAc3AWLQC/ZhioHHq46b/72yUgiFAnclMveVGW?=
 =?us-ascii?Q?K3SYqiHd7b3i5leMhTPSX/2cDfY0XMfPFpVFSd6K3phMQdO+GjA4xR0C9r/G?=
 =?us-ascii?Q?azlU3oUjpqtgeORSWuQPc2P9ifmlI0ZRxZNjYPPiecQiSwBaFy28AHlWqHtF?=
 =?us-ascii?Q?Kg2mNxdSMwyt3dEHwgNkqRe3vaKmZx5hzTcHWjJdFPpcZL3kGSwe24ssByEu?=
 =?us-ascii?Q?+GoyVE7J/58kuhBgJczLwtsU2OcyV3ZCQPmiSHUQH830UGdKpkNYRjhWmj7i?=
 =?us-ascii?Q?shaEUwqkT4o+cca//g1D+zTuI2j0eP18P2hDB+yjciLVjt/UfTKGeEHSvOhI?=
 =?us-ascii?Q?yBlclUYt6Qa82ly5v0mvXjnV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:41.6307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf284b9-4f9d-43c1-099c-08dc7beca0ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

ABMC feature requires to users to assign a hardware counter to an RMID
to monitor the events. Provide the interfaces to assign a counter.

Individual counters are configured by writing to L3_QOS_ABMC_CFG MSR
and specifying the counter id, bandwidth source, and bandwidth types.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v4: Commit message update.
    User bitmap APIs where applicable.
    Changed the interfaces considering MPAM(arm).
    Added domain specific assignment.

v3: Removed the static from the prototype of rdtgroup_assign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/internal.h |   3 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 101 +++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 45ed33f4f0ff..a88c8fc5e4df 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -657,6 +657,9 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
+int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
+			u32 ctr_id, u32 closid, bool enable);
+int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0e425c91fa46..48df76499a04 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -203,6 +203,19 @@ static void num_cntrs_init(void)
 	num_cntrs_free_map_len = r->mon.num_cntrs;
 }
 
+static int assign_cntrs_alloc(void)
+{
+	u32 ctr_id = find_first_bit(&num_cntrs_free_map,
+				    num_cntrs_free_map_len);
+
+	if (ctr_id >= num_cntrs_free_map_len)
+		return -ENOSPC;
+
+	__clear_bit(ctr_id, &num_cntrs_free_map);
+
+	return ctr_id;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1830,6 +1843,94 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void rdtgroup_abmc_cfg(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
+			u32 ctr_id, u32 closid, bool enable)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.ctr_en = enable ? 1 : 0;
+	abmc_cfg.split.ctr_id = ctr_id;
+	abmc_cfg.split.bw_src = rmid;
+
+	/*
+	 * Read the event configuration from the domain and pass it as
+	 * bw_type.
+	 */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
+		arch_mbm = &hw_dom->arch_mbm_total[rmid];
+	} else {
+		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
+		arch_mbm = &hw_dom->arch_mbm_local[rmid];
+	}
+
+	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
+
+	/* Reset the internal counters */
+	if (arch_mbm)
+		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
+
+	return 0;
+}
+
+int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int ctr_id = 0, index;
+	struct rdt_domain *d;
+	u32 mon_state;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		rdt_last_cmd_puts("Invalid event id\n");
+		return -EINVAL;
+	}
+
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		mon_state = ASSIGN_TOTAL;
+	} else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
+		mon_state = ASSIGN_LOCAL;
+	} else {
+		rdt_last_cmd_puts("Invalid event id\n");
+		return -EINVAL;
+	}
+
+	/* Nothing to do if event has been assigned already */
+	if (rdtgrp->mon.mon_state & mon_state) {
+		rdt_last_cmd_puts("ABMC counter is assigned already\n");
+		return 0;
+	}
+
+	/*
+	 * Allocate a new counter and update domains
+	 */
+	ctr_id = assign_cntrs_alloc();
+	if (ctr_id < 0) {
+		rdt_last_cmd_puts("Out of ABMC counters\n");
+		return -ENOSPC;
+	}
+
+	rdtgrp->mon.ctr_id[index] = ctr_id;
+
+	list_for_each_entry(d, &r->domains, list)
+		resctrl_arch_assign(d, evtid, rdtgrp->mon.rmid, ctr_id,
+				    rdtgrp->closid, 1);
+
+	rdtgrp->mon.mon_state |= mon_state;
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


