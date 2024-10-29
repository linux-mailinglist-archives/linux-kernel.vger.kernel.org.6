Return-Path: <linux-kernel+bounces-387851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D09B56E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145C8B22A94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F920ADDC;
	Tue, 29 Oct 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1qlhSjVs"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E520B205;
	Tue, 29 Oct 2024 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244342; cv=fail; b=LHv0zYdFiBhdboj62UtSSCxw/Q57LLMPu1U4Nz9bQE7qpLHJ7xGp3fNTU8n0lxYSRIpvz4hX1BskUNVpXxFdgis7M/6PtTdfq62OPdL4UvNd5kZtcf5ZcbYuuYn+VlLFk5w1iT5dQe/hsCjJwS4Mpkdvg7G2KngSdklw9ZSbqa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244342; c=relaxed/simple;
	bh=Odg4BbGdZD0H1Thz/1LPS6aNRPMC4gJkZgvuWuEBqC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbcV2o/pHvEzKaTqDK2dlMC2+zDvxHYnT9WOmMkYTcLnUfJpTXrLFTGLBhnkPcIZBfwFDlnUA4w3D7PUimw2ads0eqJU5B4iSDMMAz2uaeFDHodx+V+bZ0v67zdqTZ5cBioxopSdNGYt/SN9wXGNCMAXij61sqlgjsn1kXcwliw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1qlhSjVs; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ps50/JsShgs0OYGfd+8vClWbj6/pLltkajiQ0zoI8p527FTVJXvutkAZXxlTshZhklvcXaegimgfEKnjgO4TET27T+of0J6EofJLRl9keZq4RukbOyz4lBQG0RvBQG6//76wqFxIfBM7edoOcvKiSHuDj4MZhT9DQyusjXCAGNGryKSvMVrt3kV5zSUIDUlLxeUqWUFkCWFYpir2dATElKMHjSnnW6qQDn+8GRdc8nd/XebGNw1VtMa+u9tnh8wrMKKCke9xFNLcxNBgcWq5btFHY4qFLQY6pKfxZ4S+zYJIOwswXiNjkCJjAxWy3SFsrhPf5fZnDnHXsNnIku+ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWomWzCU3A5RdprHWMRth6YETaopobuqcBBuJ9JXT00=;
 b=Np1G1Z4GDdJADE+VmZOeQm0wLtKrgIbh20+btGdfCpvNv23AMatbhB2goNLzhyXhddPZKk9afgo4MfbavjLvGT/IWuoqztq2Zzs+fqbuXTL9WuvGKfjYTtfvxPjK0DaAIm4/woS/bjOmkCNAvwLM+M4/7qflhx9Nzoq9UOvzHEVpsqUBNZ6cWQR83rwv5anZQm/2jAHOTTwDuhDUVSHaOYYXKdfNxqYoXz0v5AIglSircQ6U3cK8PqNAyzAj1ayVfV+ecMyQZSJZwWyz+xYtJGdFkeNrO8ogDJlOsp2BI/m839AGIKXMm9GesIgXAC4Wf25+lWQzULz5/QPRhsm9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWomWzCU3A5RdprHWMRth6YETaopobuqcBBuJ9JXT00=;
 b=1qlhSjVsVEUENEfLNuuJHZAdWeZBDRaQMm9j3HtGYvEKuBU2NQO0sZKPsLYXQWgFPa8mrE8Nk8FCn47T7nCk7ieVpgI0ZPRLQs/DJdVu0UdvQIV+lxoT/sjJm+iViUfVFEAAnyWSog81t0tG/oZTfFAG/Fai/fpRhPAlhBaqRis=
Received: from SA9PR13CA0096.namprd13.prod.outlook.com (2603:10b6:806:24::11)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:25:36 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::1d) by SA9PR13CA0096.outlook.office365.com
 (2603:10b6:806:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Tue, 29 Oct 2024 23:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:25:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:25:21 -0500
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
Subject: [PATCH v9 23/26] x86/resctrl: Configure mbm_cntr_assign mode if supported
Date: Tue, 29 Oct 2024 18:21:55 -0500
Message-ID: <2964648aa19f9d961c76c83a25f10fe3993abf59.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5b0fda-1a4e-4696-e14e-08dcf870fe2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w2DHId/oWRdRTmqLFH2zs2LoYQ1C1CXzzDS0WW9idz9QMy/Bf4uhz27AjZgz?=
 =?us-ascii?Q?8oBEUzxoRH6qVbTAikOy8oyhC4ao39zeQBEUzFnBSaTLYLtoP95yUEHssKbg?=
 =?us-ascii?Q?KKq+AABcBMuu3tU+hPOcSF7OyjnNeg/idFCIG293MPjzSCzbQbpqwUm25hJQ?=
 =?us-ascii?Q?T53QOvSl+f/Jmlv6cIjdtr4DhRlkMf7CbuGA39MRdNQ0HWkthIAm60wCP99n?=
 =?us-ascii?Q?3HUEwXnlpIrLsfn3Pdta6lgqnI1N6c/SPjTzFwHtRmk9FVJo0Yn8Di1Dw9eA?=
 =?us-ascii?Q?uM4iuhhdgjyMw3ZVOCxzAtj+OdoN4E4oIBOMejzyTmVy2uHHouhSm5ec9Mgr?=
 =?us-ascii?Q?fkFsmXYH+ekfsEzUQgvNfn3qhzhXgXfHfOJPlaxSbpOv1HbMifbrszwHtmA5?=
 =?us-ascii?Q?S3edyOGTIEQ3bdtK2vh9f5ExfGRJEjj8/f17yBSBIwz88DaOWdZcnbtSyiM7?=
 =?us-ascii?Q?zlv/I7CbUM8HqZdRnx46GUb+7xoWz0IXAtCp4sH/RbCpyA4GS+xhNecLoUsT?=
 =?us-ascii?Q?A1O4ly7RNpj2odzQ7wJ7kOOSpRYKQi7RVV6d7o1Np1Hda3E8EkONfHJAy2yv?=
 =?us-ascii?Q?TExyvdWOIVnjFoI4DbgtUMjEVeSeDOhxBXJ4Y2laQDUye45Mtqk8lSmZzRxo?=
 =?us-ascii?Q?Ek3OZZtPgLqzQ0drYZSE2C96zm+KBvDTyngCogq3Aux8bML7+q7mp/z9ZqdD?=
 =?us-ascii?Q?/IKBlK9yGRks3/tSMzdL9TcwQr9HT64vPHQtys8xHHbweOAhLLpkTRPbZ242?=
 =?us-ascii?Q?sFyOlUkO3UxRyiyC23WUhWsQ9XU8HO6hDYeT9R8+PgM9GGggAsWz/xVRBHFW?=
 =?us-ascii?Q?FOEFcOS4mtsKGLzB0v2J6Cdk8r7FXBo/KrTN4jk/Mf+YEf/wLfu3JjyP5+yU?=
 =?us-ascii?Q?V4O8q9MnOiN0u9VGJT61Z6/2ktuy4nLrwgvaLlPlDCDe/F4YEz5AYeUAxBkl?=
 =?us-ascii?Q?mg0aN2zceUjXy7J5gwZ9thPCTpC+CRKNE9eLGx/6vrOq3pZkgexga+/WJV+8?=
 =?us-ascii?Q?+lKnwsOa3MJjSW1XtZMQJQJYjA7KNr1argkd8w8pX5K7pwlgQI4SZ4I8ikXy?=
 =?us-ascii?Q?PEz22+NADgKKuBWHDT3Wkjg5pAFtHHBfovJp/0xWjOyQUa9Z1x/8U2pydRNN?=
 =?us-ascii?Q?8k1o8X9XIMD60UO81CVbuktBT+L10PJ3uamLTxkby+WNIeS0BNxtVUIh1lym?=
 =?us-ascii?Q?jdX9lN6svL8nC61NXhdU6sSMk2CVCzLWXpoPCkl+czyv82ElEVgxGkOLtCAf?=
 =?us-ascii?Q?UVlzNXrdLOa0vqVxTZqv33j04pTtU1UGmWVIHe5Jbeg+8UCIPetUq04uZds9?=
 =?us-ascii?Q?SemzCrv3S3fHouSUdN2EkSo1hBaoEpisex3c/IrHv76XOkLv/T1aR2k2HynV?=
 =?us-ascii?Q?LtKu+J4j38JfhcVTcqla/lq6ncJNWh0YPs+Hp1MapuvyuZeC2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:25:36.3235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5b0fda-1a4e-4696-e14e-08dcf870fe2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

Configure mbm_cntr_assign on AMD. 'mbm_cntr_assign' mode in AMD is ABMC
(Assignable Bandwidth Monitoring Counters). It is enabled by default when
supported on the system.

When the ABMC is updated, it must be updated on all the logical processors
in the resctrl domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 66de0ce12aba..b90d8c90b4b6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -721,6 +721,7 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e8d38a963f39..4ba5007fd1aa 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1267,6 +1267,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.mbm_cntr_assignable = true;
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+			hw_res->mbm_cntr_assign_enabled = true;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7fa6a86c6ca8..5b8bb8bd913c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2799,6 +2799,13 @@ int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
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
@@ -4582,9 +4589,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 
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


