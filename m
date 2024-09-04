Return-Path: <linux-kernel+bounces-316044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D207096CA54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F83F1F21A49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AC18E752;
	Wed,  4 Sep 2024 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eh+2xV2/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7A18E02E;
	Wed,  4 Sep 2024 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488633; cv=fail; b=RP1RCmwcX/jpKozQX7ItbFc+A6xUstpCylcfnlI1AM+SjZNjmyHCKXemL0BoKIaXmNEt0aKGYltrignxTShWwoRbL3f20U2DWDIWFwSp2E0JMehdHxmV3zK2KRi6+6ZLmhzs5iiaqjHjHI9DStUit1Tt/HivARbxYFPYnCrMChg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488633; c=relaxed/simple;
	bh=4B5/tqXfX2xP+Ai5Pr4Oc0frRIbiL285H9goGbYsjl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3Jz9LHogineyzdVDCeYtLUYiFR5E+rpUMZ1LxUJdfVXzJi2/lJPZQFXI8gvwHOInm6i6YdlaQs9GN9tux9yrJybJ9K58BBSumLH6LjHprQ88m8A+Vk2NPdz+L6DAzBn0k+D2sYB7G5kB9PWMm2OHJnLi0YHEiMgbS9CP47Nsjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eh+2xV2/; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIW6TsFykRmmSwo+UsBIzrrhHzqPTrnXFiuK+4jXvWAShh3G5qbpZ09sU25OHm8NxKErmmEDiGUzqM8sXJ2xVMzxQTn8u/koqqgFARXz2MWbafHTaXC2FBvPbR21yhFMhB36AfGwheyd6j/Uk3a7y+UX8P5nSujEfZPXvn31MlW/eFUShB0M2OzUwN+7T2YdvSREWl62k8tOgEZaBIhEjkF65ajoEecoWobj1sqH9IYKOdNpt2XWc7SWZ9+ahDZIRvxJvvSfZ/Npo5Xbe8D+Ecv2/70yLZhIY+j9ZSqxhmwVqQbMoblsXBmGTsitXMFLzEt1rOhNfbQ1z0XCrH2KJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9gP4UtPQx0dUPN0oUMcpxwXV43C5RIcp4hvn5ptsLo=;
 b=pPhL8eqgHeckJXqUUNSKaCpUhDd+j79fUfdvIWMGnl2mS9CVgiDIxegs3hXLFBGh926F07OMczrdm3o5OoWiRMry3m0H5ju+2U8ago+NAkyQgT+A+gNSYv6o3Dp5VrAU+UHdIwj+s33wBVuN7NazY16AZRL60qhEXmDJ0W/EOo9wb71hesaSICplNEpds46RD8hhi0PDk9y8yi1G9ueRlNym42vKnvCT3fk4my1HbyYHc39Md7bVlX8dVk53AydZvbLIzM/YVaqz51fCG9wzT8FkWLKczy6P/zUvNzEmRYdhZ49czxbPdKggPHYCuVbjdqhmfo7/SAs3xAGdrVbkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9gP4UtPQx0dUPN0oUMcpxwXV43C5RIcp4hvn5ptsLo=;
 b=eh+2xV2/YZSLlWXVkyjOTHGxxzvqtlSPepePOF8XTS48wBQ1wkvvq7UP37QM0LEP/ddiDTEyXhIZWhsNx4f1ol8PguXcCSh56HrDh3P6PRdkzlmnvrmnvGgYwJX1VM/WuCRXJbqTbIZwTK6owP9WH3YYQh6pjCfUs5ENjLrjIy0=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:23:48 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::7) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:46 -0500
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
Subject: [PATCH v7 15/24] x86/resctrl: Implement resctrl_arch_assign_cntr to assign a counter with ABMC
Date: Wed, 4 Sep 2024 17:21:30 -0500
Message-ID: <2796f9514d9763d40dffbbfe651541d28bd4d995.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca551fe-bf0d-4c25-52d5-08dccd303f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ekzbSlVbEWy0vkD1yvmrt5y8X+xXo7XKSGMxujXnmyaOMbYGs/QjjwlJi1gT?=
 =?us-ascii?Q?lnBu+t04cjSC+w4MwIRIpmN5nW5h3965AjCjwIb2zj9R7E5ejM4i9CiwPBAL?=
 =?us-ascii?Q?etC/GGOFCiP+IiDeLFfrnNdWPWfYWrujo3ckCKxlHAbHoL9/CCIy5nZK0xYq?=
 =?us-ascii?Q?/K2zakpVRzWIjXhCVKSo0nmBWDPBEX9ClERwSOqmrz0sBMeOXPzqjNsKbknG?=
 =?us-ascii?Q?ClZ+34Ryu7O3pTX8oC6YQ8yyaD9e1XJDDXC1ADglqf6uQl1MyDuAcDosAvJx?=
 =?us-ascii?Q?qQ8JviWRQ6crfbSRtVS1ohY8GYPdchPUvdCsJQYuCq+7s35O9dSMNHSpTT8L?=
 =?us-ascii?Q?qKj3cXRj7bOPxZe7YdjXLxDnTQBknAxWfrPDH6avhjT8nbwd2kIg8YEvit6N?=
 =?us-ascii?Q?a28AUNv410naSDKbKd47lGAkUMgETWd3GAMJK9oQyWmJX6cQZAOOok72A3t0?=
 =?us-ascii?Q?CKijlaYxlP2NA/wp7rdS/QB0svVKAq24wYg6/pZ62JvvPakXR84Bk0iHW3Iz?=
 =?us-ascii?Q?35REL/uBvpw/93miKI/ieyz6e9JOIFm8EmC6pS3vY0gi7AE8nbg7/SDsuiVw?=
 =?us-ascii?Q?f+JWsjUd1DSPdHbCuaPK6GHqcHENrJkopn3cqV/w/K2N/iijESSiAcLkIw+u?=
 =?us-ascii?Q?Anvwogo1CpdI3GiwrhpubCt1BRydvT1UOF0H6EwrSS5Ex0oO7UihJIKGn0G9?=
 =?us-ascii?Q?lWwl0Gktai5E2bmVOnWtDqpDbt6+iWGeIxef5AqakUDmx8WQ7cDOEhopuq6h?=
 =?us-ascii?Q?BYbavAzIPlqfrKfSaRlvN/sdEqB71/8bYVWv6s1tGe+kLvCXubABJZYI/iLx?=
 =?us-ascii?Q?9xN7bcF+a2XI1wjHeoGvCBRuBhmOHDWKL8+4c+DeHdPByvrbvfcsngu2o36g?=
 =?us-ascii?Q?4/3a+mTDXhXzH+ldpvf7Ms0z5wx7FoTbz97CNz3M//hdGkZcF/4KZ08iB1R7?=
 =?us-ascii?Q?Ty6AkhoL+30weNl8W91Nzt1QWiuvRGBuyZjyU6JoC4cHwBFWVt5ErZ/Z8egV?=
 =?us-ascii?Q?6+ewtLl8i2eY9RpGOt3t5gWATf4CjeF/d9G3rkf88rDfuaxx1nllQIzeqYLd?=
 =?us-ascii?Q?RFf/XOUXfm5lqxKODEFtvkcM7tbFymDB0nuK7upiBxOGezfcsJBgju4aEClc?=
 =?us-ascii?Q?ykGpbZ8aYBqdk/mN+Vi9fgRlj/8pSe7/Bq04mspXOZ6NJ8kI3nuIDx9DV1Rl?=
 =?us-ascii?Q?zwAaEmM2bQHGI8QL3H9kpR/7JGm+8lYykb5M6VpdicREwurJNJrCWCFUZd4W?=
 =?us-ascii?Q?c/lOvIrxJKameFSndkKdEVaOGHy+XWO/utuy2SM45loI6BJO4DTc1ZJVDWCI?=
 =?us-ascii?Q?8zhX3qZjA9MF6wI/0MsliqbyQh4o2EMQg/A3CyMRRLQ6jCSeoffeZv2gOm5r?=
 =?us-ascii?Q?bZGXeIuBCJ8/IzTHSuU/o05VJFS5+OE0ozznf2uHN5Xayynt99aPYwx4iOR2?=
 =?us-ascii?Q?n6MKvy2nKd/l3p7XgsCbr9GNdirbPBRS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:48.3158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca551fe-bf0d-4c25-52d5-08dccd303f52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

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
index e0ae8b0b45b2..57c31615eae7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -702,6 +702,9 @@ int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
 void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7fa92143daa7..7ad653b4e768 100644
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
+int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
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


