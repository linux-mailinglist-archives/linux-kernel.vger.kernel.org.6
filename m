Return-Path: <linux-kernel+bounces-357636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F24899739B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FA92882A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E831E2301;
	Wed,  9 Oct 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jTwoU6Vz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325A1E906A;
	Wed,  9 Oct 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495790; cv=fail; b=DCIkinCu8AoKFl7dCHEmwLxFrkRS4jewvao705Hmifyux9M5egYDgWxkXyQ2ueR6iITW+hQ63MhAatVd8QPQsHPUDBF8XFtl+60R6LEM9FZeJENEqrNOrQHdQABh/f+sEuKN0kIuVIYvLT7vRAfz6byflXehIPAKv1HniCBlshQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495790; c=relaxed/simple;
	bh=hfYdBYcn3maJUcNMWvBwVf6FcLcZipDDaojnwc/Rybo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tleNgm1dHbuW9vA7oqnaItDt+TExmdDFQ9j+oJ6SHTtgt+eHqtKNKnWu7sc7Q9kd75RfT2IHX4MnhuYhZ0EOlC4wWceVVP4A+01Z30eJmGRFm79Hc7eF9qbxcoHb7umwulXw+POaSo61vUBf9NshU5YHMJpiUoPREDJ3yazTyt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jTwoU6Vz; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFMXQ5nxiPQ3t+rHHsYLsLvpzA5WJO0p71JhQbrWQ3ccvXr52ovo/J1ZpUf7ub+Xmcx22mpcV43hL6r+S4BZvxz/EkwT+vUSnm2CCwndch1PFuc6fDSYXGczdaYDb/hq+vDNVmRiYykmZ+j2hL1MFMMkQFQjSoy3pCOPM7i7oDkPd0lrm+VlBoLApMvQEoWmeoXxdYYHdOxWfpmfWh0IB4h4JJrkBW6DOYydirzULphpC7ssohLi1JCt6uRFT3whtId5eWWCXM4JWJnsR3uv5I1OuxxnufCKC2YX/gmopvs7NCPdoZiVMdCVScgwxBpi0RQc0AWR0ryW07KxJ6gRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG80/ufH+fy1EqmkR1wGC2tYi4umW0s4zU4RYKl0osc=;
 b=JSeNv/nnyl9M83lgrHFZOJzFFHbnR3jw0jDBqukklq3Pj/+7RrL4bAETl+EWuLiXQD3fX3X0/Fvrw1gYHhhKHKrHyeuNzNi30ABoUj0rcD1D8xp7yfxaak8eCCjRNlY2X2IelymbT5lu0eXZKyPZz9wjBXwHcLTaCh2HVhsKy8atS4rTnMiN/TayTysnVdceUHUGwXHEKyUAkabmorh5+vLIZmveW5+rRjyrJrQ18pCpijmx4adJggBFVPNsnheL0d9hIfeFt8O0ETl4i+EvbJhfd2MHV4T+gpUF8dsYJyoIY39RN9pMcAf8gfDgNcP1r55XnAi7Y+O3ViTErKs2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG80/ufH+fy1EqmkR1wGC2tYi4umW0s4zU4RYKl0osc=;
 b=jTwoU6VzjS9LJFGJejSw9gVTZS0IdL62SLSxjEFMm1C+foip/0NNFzRRdn277HA+aUHmmNwQhvzZbAOy67SMoVQ6o1WJm4FSdP6g+vNf96eqz8hw2v/t260yxywikhYWRTk+bjFCwE9PDvbS0p80QEe8wteBjDHeLah7xlQySYU=
Received: from SJ0PR05CA0189.namprd05.prod.outlook.com (2603:10b6:a03:330::14)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:43:00 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::3) by SJ0PR05CA0189.outlook.office365.com
 (2603:10b6:a03:330::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.11 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:57 -0500
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
Subject: [PATCH v8 22/25] x86/resctrl: Configure mbm_cntr_assign mode if supported
Date: Wed, 9 Oct 2024 12:39:47 -0500
Message-ID: <262fdcc3c84a26576d451649914cae9f7d431692.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 87630c2a-324d-4807-5611-08dce889d101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BX7/NIuXYBZhZy6SAg8+v9CtwFXM4jevY2O9RXFngd1b1So9n7BYen7Xm9c8?=
 =?us-ascii?Q?2FT7F6lgnqv1djyWz53sIuCljr3nw2W6zHlDT2VFV84p08FbAh+ydoC1ntTi?=
 =?us-ascii?Q?5N4TRV3FG9Vx+J1PjMOQOYdvNWRrOiQLThw5deYwxlo0AeB3easOeTQsScmq?=
 =?us-ascii?Q?saf+mBjflujUz4LWYzvVPvEfqq4AwP2ruJ41VHcNQiWcBgkh6uidDYXVYqTr?=
 =?us-ascii?Q?5lr8FlA9DG6t0bJMstrTnRONLmXHmfQ4wX/Jd8QM5Tgzwy5axFpcBpi8w7fI?=
 =?us-ascii?Q?KfXQytG+86/AqXEiO1f5ye2ArpL0B9X1H3BkHim7rfJhhmzlW+Enk3ABfTVu?=
 =?us-ascii?Q?lPIf5AB65f186tFP9geUpZDct9+VlJ/ZewQiZGixi2l1uPRswRsKTLcDEiN8?=
 =?us-ascii?Q?pDlVRdUlXkeSuldRTF7lm/76ImOgDa8ZKnzTkqThJzVvXi0lmGA2CDzwUq20?=
 =?us-ascii?Q?xirVOvliGDfFiIm1OGBRbzNKN+CowUqrjCqZBNgpyxllA8zEVpK7sxzPkgfZ?=
 =?us-ascii?Q?kyPJPBSTMp5jNw2n8upeRnL6WScHcnLwoYp3gcimygnQnqrm3YTtIUxHscCa?=
 =?us-ascii?Q?RD09colfIMMSzk7L9KeK4SqLDkWGXQuT+I3kwuv90CMytObCFXQBDmXDXnpf?=
 =?us-ascii?Q?dbZCnmxvzv5Iw48m+Bm5w5OTPyggHvljb9Sdd1YBjO31WlipBdYGluIJsVhM?=
 =?us-ascii?Q?2S04KfHo2gDiYjSsa+SoYWZUPRhhCMAIgVHXT/bJ6wDrMC5F3czJkJpU22tP?=
 =?us-ascii?Q?7efjWTHFbEaoBAST8fPKBJ3zNL+LDh/mJJzaMlEYnK0TPLFTvXkF604aoMOt?=
 =?us-ascii?Q?gIL50jtIfkrz5y4b5Z2vmBmM+tmEfgjXCDincOZvJ85OsxTrmb/2JVnge0Xa?=
 =?us-ascii?Q?+uw5ArmdbXOCdktR5armHbak9YxBX7TLY6ZSOTB710JNVZGReKCCSt/0qErE?=
 =?us-ascii?Q?BYXo0dWcaPEXmTFEx4r4GGnfJgPQzHDdYarVHdp9joNrFDetxHJDpNQn1jXj?=
 =?us-ascii?Q?0RjTyQ/4iBsvERIWLVaNdB4tirapIFfVMkFnXJVHXjsxMcPx48dEq4n2Ltu0?=
 =?us-ascii?Q?Fr+87+TBEaNggm3lIG5DdA1aj5s/IGd3d0yKovgdDfAYrHjGziPbZlfEHJMk?=
 =?us-ascii?Q?O0VnIc9QpVwaa6xZuv4oBXNNEwc9qWnNy4DVLvmwglqCEmaPajNO3S5YWxCt?=
 =?us-ascii?Q?qX5XQdl4cIEKEVCXcXYRda7ncddx6mtMw1iQ+GDAXYZppdZGBU4ycyOYOdhD?=
 =?us-ascii?Q?7lMxrybvQCjDT8lhizjj6HcWlJiBlZ4BFHqEZa4h5riIgWtO9vzUG0akU5Rc?=
 =?us-ascii?Q?3Cl5+0hHiS4PtYSlId3BGAIIqnQkzSjayX40em2ZkxBM8H1UpXi5g8OicEvo?=
 =?us-ascii?Q?B7n2Ioro1blWJFgkL8QH7arOxCiH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:59.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87630c2a-324d-4807-5611-08dce889d101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752

Configure mbm_cntr_assign on AMD. 'mbm_cntr_assign' mode in AMD is ABMC
(Assignable Bandwidth Monitoring Counters). It is enabled by default when
supported on the system.

When the ABMC is updated, it must be updated on all the logical processors
in the resctrl domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 6f388d20fb22..a6f40d3115f4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -719,6 +719,7 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 6b4cf4813a4b..395d99984893 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1268,6 +1268,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
+			hw_res->mbm_cntr_assign_enabled = true;
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 88eda3cf5c82..f890d294e002 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2736,6 +2736,13 @@ int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
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
@@ -4523,9 +4530,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 
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


