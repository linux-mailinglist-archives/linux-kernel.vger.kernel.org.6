Return-Path: <linux-kernel+bounces-357625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E399736E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F9C1F26863
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071781E3DC0;
	Wed,  9 Oct 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vMkCPtqG"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE91E1A33;
	Wed,  9 Oct 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495742; cv=fail; b=t8kXAg+NVGQ8JSR87Z/Ipc27xTY0k/eXWJmznh1J5duhICtljss0Ke/k/bdn/mMgiboggA0+g8WGNhYb3Rg0/YbVbwBmzt+wCPYF9EU6ik+Rl9lEmhZcW04WY5DKYzDjzTmNmb7480C7HGALbamqBcGdNed8GAQp0zsZhQyLlho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495742; c=relaxed/simple;
	bh=5AA33wEW4RmHQYqyrAuSIu/ZcGAMmWiTMteJD9EBTNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPhYGshvhaY3N+gObYKAUNiv5nPKKR6thOp7eeXQuXVQfXvKue6hxR+BOtZTHu8sxyclocExSIt1ePprOWAJlgb3wvjDtsBrd7OLZr+S/y/fRTY2cnCM0IMEWBj4uWyAjKk2/Qo79L6oWHqs4EVQh3/SJfsEet8MiuQe85VQpPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vMkCPtqG; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSarYAgnghTTtb1EFpUZyDLxJyXJLggPOKB2Bbok0Ngg1S4lZu39S1qPdQ9tEpTRCzeH3pMos9ZciIUKMlyZOXgSInuhaoJGH0g/7aJBzOnU0NWgpmbGyysvwnJay6vuLP70pbHDA+7clLGpjpi9KAxEDnQVEAx7g6ApOwUBf63RQc3COrg+hzJVsem3z2qEXUCvTJgS2XtHMRJcycgIU1PlYbS78mhwPxxPkb/6AL+SBBe2vKurfBbsezSmHZpS86/otuglkCyYxBB1HYBbZIcLSCvfn4zyUy9YBBvD6KK842irT1P7xsT33bV+0VpH1OBrgfCepSDslfw21/3L4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ2qWLhEqL0q+1ZgpyNrBBt//SU5rEtyko75c8TlI8s=;
 b=vZCEUaRjD+n1oA4Um/5YQZw6Bh/oixoilTFyZqPjiTdT3An3BS33WaMKL7nLrqXFRf23hDGst6trpptcADAivE+S4vl3pvaW6zBqxvXk0m7yHHTGLckbs18s60gHRlLHaTHY0yvRPRe7iOiUyEscwApXORS48gj7uvkw2K6qY+8exOoJS7pCJYlmw1e+iVIod8+uIUT3AJudOEvGmWvgdupvq3YiiIC2rGKzzs3/Sk2gct66TTYeEr+HjJi6CfsI59f7lVLegL4rIhCdY4C8lnq/nr+recocLde/gDxx0TZ8zCQkSt5PRzT17aBRf0TYBL5imXMsQBqAQdVdeqYvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ2qWLhEqL0q+1ZgpyNrBBt//SU5rEtyko75c8TlI8s=;
 b=vMkCPtqGmeXq/G9evP6N/lFW0SFYLalOWMNx7hH1NTso2Q7rTDVyu3tGuV4TMc3RID0X+OcLmljyr6b6eTrVAWxxjyjRaASHZuwauK1BIBxaz5OTGEHyvNRUeyzOnXqtuq2BxFRYgNoMsEftsOJkuvdXwmOpx7g3KUYFgQn3n84=
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:42:12 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::f1) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:09 -0500
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
Subject: [PATCH v8 16/25] x86/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
Date: Wed, 9 Oct 2024 12:39:41 -0500
Message-ID: <16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af46a2b-b956-4af6-17dc-08dce889b4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rKTKnmXHbO3guJwtLYgc+qJNe/UVkge/dSDTBQceFG5O9whfbvEI52nmvE1C?=
 =?us-ascii?Q?1voyLSBBO7P/eg2YzfZceXgIGh1KF+/e0D6MzSexqI9NtJz+G1vdMQDI2Gr7?=
 =?us-ascii?Q?UQxbASiFsrtoxN62A73KbaGKRP47CPZZB7IzCktpdrHJiS6wxeAd2TKFGRry?=
 =?us-ascii?Q?+IsN1uyUhm+dHCIQnpwnh7EUK3VyQZhDJP9jQK5Q8eQ2TtlsNKwKc5/3dwNe?=
 =?us-ascii?Q?uahkbxGQL5swxauDAwMw/Su2DO4wW5p4cY6n87qd29vBpCG8FK2lPTiDX6XB?=
 =?us-ascii?Q?wQGOE81kyRIcnkkfoiSQXzH/moLCVZ1on9kKkCfgfax3wlpfWZ0TYlXcmClF?=
 =?us-ascii?Q?t1eDQTfG7cFcPChc5Xs0b10L1svzSC3KWOwQr6G1SN0XjWWMS2FE0eAZHWuM?=
 =?us-ascii?Q?7FTLuPmBMRjAJ6L54MhMvvzbHW4YHMB77wqovAtTfZYdRTZlDMucoamkutP7?=
 =?us-ascii?Q?jfQhk37SbWMlt7ot70LvjA7zEn3s7gZmfAY1QaOVBbwwERyBabt9Gl6t2bsb?=
 =?us-ascii?Q?CjBGs+EYEGaMB4JT+2nuCL7/L/uodMHnfiHHQN9I1ZU3A9X30L7ELfmfqsrH?=
 =?us-ascii?Q?Btesao6RrNBD/ljgp0P+SyeGhUai+yBMM4A4F0BSXRc4h9AX1Qm/EF9acLZQ?=
 =?us-ascii?Q?Mjoh+lY7FEBO9y4RUH/cJ+0Gp0gYgclb59yRCKnJNtnuZT3CxASNPXZjpjdD?=
 =?us-ascii?Q?2DyQvViSAb16WHQsyvEp3J922uekfvZenCHqBS39whHttiPEez30VSFENEi8?=
 =?us-ascii?Q?tp+00hJkHAcTb/LKifCAkaMNWItwWr9xZlMnaNH068KAQAPmx8mfBEhNpElv?=
 =?us-ascii?Q?K8upeTHMDWPJn1LW5w41+zVpNqMmiDkBetlUSxCjuVDDsD77jYD/RfxeQfS2?=
 =?us-ascii?Q?XSmNf4FhHGCJQzuTgiKt/FQuMTXTcJRu2D0dXLEIy+vMTIsEzhIrPrxhlZUF?=
 =?us-ascii?Q?/FyNN2SHOfrjXBCuPpVZTT929iRut6nPHlkLWMosp1y/Mqor+LBiDotTEpFs?=
 =?us-ascii?Q?e1RyOYIXCQt3aSMPMkiL9CNvZiYRkxLHCT0taztMmIF/7WNpoksCcP3BmaYy?=
 =?us-ascii?Q?rUrAsMKRxNmyFKZkVOQ8qeApOgw3XQTZSLTVI7lG9HlElxoDujSxmYHFWqYm?=
 =?us-ascii?Q?8YPoJAWjag2pG4GNpmjGA4bftohvtOpelHUjC2zEGdUN9mBa7+suMAe0Zfgh?=
 =?us-ascii?Q?lCtYbrnTR+MjhsmerjcqAzD/0MLUrTd6QqOrYebzKWemBvey+yx5dpCvlCYf?=
 =?us-ascii?Q?h2SZRZRDeEvZcn59gGTLJ8+QEhXQg7kKbBxZfkH/YDzqzR9cksNhQMIVTbHR?=
 =?us-ascii?Q?OzXFeqcMkG3Pw9DqF07vpdq/JFDS3ehoZV4GHXdtpnWyzZWYS5yuSyFPRClT?=
 =?us-ascii?Q?Wsad5S2OPdFbpYfKxE6qQacIZV1b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:11.9340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af46a2b-b956-4af6-17dc-08dce889b4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned. The assigned RMID will be tracked by the hardware until the user
unassigns it manually.

Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
specifying the counter id, bandwidth source, and bandwidth types.

Provide the interface to assign the counter ids to RMID.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Rename resctrl_arch_assign_cntr to resctrl_arch_config_cntr.

v7: Separated arch and fs functions. This patch only has arch implementation.
    Added struct rdt_resource to the interface resctrl_arch_assign_cntr.
    Rename rdtgroup_abmc_cfg() to resctrl_abmc_config_one_amd().

v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
    separate.
    Added code to update the counter assignment at domain level.

v5: Few name changes to match cntr_id.
    Changed the function names to
      rdtgroup_assign_cntr
      resctr_arch_assign_cntr
      More comments on commit log.
      Added function summary.

v4: Commit message update.
      User bitmap APIs where applicable.
      Changed the interfaces considering MPAM(arm).
      Added domain specific assignment.

v3: Removed the static from the prototype of rdtgroup_assign_abmc.
      The function is not called directly from user anymore. These
      changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 58298db9034f..6d4df0490186 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -705,6 +705,9 @@ int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
 void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 03b670b95c49..4ab1a18010c9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1853,6 +1853,51 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void resctrl_abmc_config_one_amd(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+/*
+ * Send an IPI to the domain to assign the counter to RMID, event pair.
+ */
+int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = assign ? 1 : 0;
+	abmc_cfg.split.cntr_id = cntr_id;
+	abmc_cfg.split.bw_src = rmid;
+
+	/* Update the event configuration from the domain */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
+		arch_mbm = &hw_dom->arch_mbm_total[rmid];
+	} else {
+		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
+		arch_mbm = &hw_dom->arch_mbm_local[rmid];
+	}
+
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
+			      &abmc_cfg, 1);
+
+	/*
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in next update.
+	 */
+	if (arch_mbm)
+		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


