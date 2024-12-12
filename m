Return-Path: <linux-kernel+bounces-443896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D049EFD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3E428BA80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A71D9A79;
	Thu, 12 Dec 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zhu/mOm2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831391B3959;
	Thu, 12 Dec 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034703; cv=fail; b=T9OVzDmXEkkg+b4SYHOCkd5zhgRXstyvVd2kzrPJWs45ow+Nbvl5ZLLjrs/5efX8wlBShWkzCUwQ+LQQ5tu0VMQAzlcMO13yrJgGlK5C8av4rmoax1MqNYpArQQGXY3F4fPa77kwCzG4IcT5++fvdkdUSy8ZuvOwJ5KxxfoAYaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034703; c=relaxed/simple;
	bh=Rh69LkJpPiuS7Ia55H2hbv8uPP3DkG2HvnlzdxFPlLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4M2XnbbzbKjE+1kSgmtzYDT9enOfpzBau5Um2cfLXhWXfYTVeErXfOUp6Ikg8UlV+hQKPkhySaK0u2BC370oXW5nf7c8Yg9H6McrUoS6HLiqz3y06MzSQdlbqImihkpQI9HGVWohsLrIwAVODg9pdAMMeCzVVdP6g3Syeqep3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zhu/mOm2; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+Xbj3HSuoanVLMe9EgMQsvgvaz9n8/Qv4CM6W7Z0caOmJ4OyXoEBt/MTSxWSK+a0BucD6xQU6dGWv+vyUeh3U3BOGzthQW1jRezBlw4J/g+LlBL7o6dgPbuT/OBCtjQ1I0HTmDdGxs2bNFs1i1/Lpis03XW6TR82q89ey1eS7OZOuAHzZUxY9F81R+5m5IRLyKk8oUiwyJuYho+/HIYgQ0ZVhW2upXiy8LUtQMju7SX4UVzusCnq3TU4CNNnjgBhnVz7BrTCib3GUyx9THCrLsC8cJLtG2zua6YhuOxUOLajfx5F0YoGJWhZTew5/n2wUqZDz1HTEOlFf8hsqzw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oy3tA6CqjK/LutNusFwfh0c5bBy6gTCoEzSQYG2ix0=;
 b=TpjjcVsFYzxPAyqtIGTm50P4dkThz2P674/Cz7NGaT5p4/tfwDRQV2QDrAbET8ytSWe5+5xVk5q57vd1zGB4awTFgr9/podWQHZnEP/Go0bkUhkdcKA5NwYsCp9tC5Xo7P/a7EiiYmdG4yb6ALJlJkLkKbwuFgm90vSW9oLoAY0ZkJGL1+u/GsRSoc2xrMjlFmQ5j0fbdSW+StoCZYicD6RiQmQYck+iaOPxa5RBG0ucEtOKA8vV7/nkEPgDlh96bVNjTgNPBwhDgm1fW8Wu4L0+KInCAbpogmzk3AThF0cvPoTWwuiJwBvFGFZ3r8y5i23BY48THX5mnhoHGe1yCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oy3tA6CqjK/LutNusFwfh0c5bBy6gTCoEzSQYG2ix0=;
 b=Zhu/mOm2qJIimOWvo2TNIlmDzaRyinv0j4R+2rIbVXLP3bXU98EVNQ0SWFN1zD5p359eYsCkK4O0mJa4KO2YsBFEwMGLJaE21Pmu5CTTA07ysq3nwH3/Q5GUzTo9nlMIZxiTVmE8kLENEwuvGWa8fUKp5gcZ0sWwVxI7/3HVkFY=
Received: from BN0PR04CA0182.namprd04.prod.outlook.com (2603:10b6:408:e9::7)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:18:14 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::91) by BN0PR04CA0182.outlook.office365.com
 (2603:10b6:408:e9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Thu,
 12 Dec 2024 20:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:10 -0600
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
Subject: [PATCH v10 16/24] x86/resctrl: Add interface to the assign counter
Date: Thu, 12 Dec 2024 14:15:19 -0600
Message-ID: <a72e23d8fe43038cd319403ed68b657fb36e23df.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f2ed62-a3b0-46ae-5c7e-08dd1aea1a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7XIbV27QbJsA5efWk6y7YWXwN6qVE+ZzteQxJ8vJt7aT5vDK56G/+sMBBeyk?=
 =?us-ascii?Q?gRlCHV6iSRDvSj2AorHI/xNyc6ypi/HCxIwVt/nx4uZjD1PJjbM+ABnDXJp7?=
 =?us-ascii?Q?RfYce6A3SPSGBiOlrQSp29kCOIt6boPugVheage2eXib07dvgaAg0RvEQFV9?=
 =?us-ascii?Q?TKZVl0l0APZoXfwNktQxaZ4yfIFo6QHMNWeCCTGtAlAuf20PK4oBTu7TstqC?=
 =?us-ascii?Q?v06zd6t+AljVi0XrFciDxanSNqyVAYLJKqrpTHJFi/iFlhpxh0QB45U5uWxZ?=
 =?us-ascii?Q?VbrBJ1OgBqYvCGbWE5siZd/zho4OQtCqE88Q1K0cIUmgBfnfo78VPKCEh1sp?=
 =?us-ascii?Q?KKWR2aO/HcERUkl0x69QK1Zy9KUHk0QOIXQmIVO9wfI7CLW7NaiiZP9J3Akf?=
 =?us-ascii?Q?zlBaSN/kivbfZRUfzekvInvKbW+OkMvOayeww1fGP/4ycVWpDhDCa37lgzzv?=
 =?us-ascii?Q?hWe7UdQWJvLzTnf/SdLkBWlPiassXN+ZfrGjG+w+OvQcUfqstxCGfsV1VB/o?=
 =?us-ascii?Q?0gfyMruTqvpO3IG0LOsBxDt/XD401foWIDrpQktptwLEQcTfQXnoyLAUpIiP?=
 =?us-ascii?Q?IDOchcWaw4vCJ5VFOM6Y2J5nJ1wO55iMq08R+S6A50kpSXOWdViZt8ws5p1d?=
 =?us-ascii?Q?Dqt2vt6uv1YmctU97uCcnMykMkr0I8ZApozTTJ1V8rFE1O6+JqUhJh9BdOaX?=
 =?us-ascii?Q?MWUGqpKTbISsoWDDoSN1GsTOHimneJV4joA6WWbAWeGaBRQUtMYjDOtCTT4E?=
 =?us-ascii?Q?blz5L0I+0SEbS2Ve78nfDM8IhenpGPIRDvtE352lFaCbKyDgF7OVJtpTcBnp?=
 =?us-ascii?Q?d0UJfee7vIUF526hw8EDjDrzQ1HUVprFulF0aaERvu/ORLCz/DiVVf5iCOxg?=
 =?us-ascii?Q?4WlBc66kAoHSWP5yyQE19pCSIfjX0YvmIWh5dW/B1DcvGCpsg2/RGo06kKOw?=
 =?us-ascii?Q?gcvbafXzQHjX721gaVPfBL8ShuXPe+MSIFqv69Ku/K0p81HRfnPcYIdCsBmG?=
 =?us-ascii?Q?e7YolZdbIwC2YXg3OrNTrIbarZlyy2KgWz2mZJaESocNnLoHH39+UmrJqBHX?=
 =?us-ascii?Q?Yr9WSVcJz6L9CYHxMlUPPopI2pi3QE9aibv3uKCMVkNVFHQr705uZwpj+brk?=
 =?us-ascii?Q?8eZi9+QtJVmS4smbFYN7PhPj8zIxecRFnIGeZHGDE/1OZajdtEwXirmzqk4k?=
 =?us-ascii?Q?d7h1/GkADDxcz/PKPY6sLP0ytPrx+BfdSkZVSprB25sg94tw07nCpAL+JdAS?=
 =?us-ascii?Q?TlL1Lc4RO7KMWp2C6gJuD9wZTCnVQPy/77v1Eew1wiP4G9jdoQve66YRZrJe?=
 =?us-ascii?Q?6H5DcGVrL1EVtnp0UIude9gZyAZPdMdw/rEdnAgT31PVYskWnFyJwimTGbOq?=
 =?us-ascii?Q?ErDqnW5Uq0cczT6fmfNlk5Ct0CxEwBcYPYub/XoQl0++eXBXD4QJhtzKHiEV?=
 =?us-ascii?Q?x9hjRyE1FjmrFjBHNoTnjpc9uzr29Us+lh6tj66TQccWGewh/MfBlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:11.9506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f2ed62-a3b0-46ae-5c7e-08dd1aea1a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

The mbm_cntr_assign mode offers several counters that can be assigned
to an RMID, event pair and monitor the bandwidth as long as it is
assigned.

Counters are managed at the domain level. Introduce the interface to
allocate/free/assign the counters.

If the user requests assignments across all domains, some domains may
fail if they run out of counters. Ensure assignments continue in other
domains wherever possible.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Patch changed completely.
     Counters are managed at the domain based on the discussion.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     Reset non-architectural MBM state.
     Commit message update.

v9: Introduced new function resctrl_config_cntr to assign the counter, update
    the bitmap and reset the architectural state.
    Taken care of error handling(freeing the counter) when assignment fails.
    Moved mbm_cntr_assigned_to_domain here as it used in this patch.
    Minor text changes.

v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
    Added the code to return the error if rdtgroup_assign_cntr_event fails.
    Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
    Updated typo in the comments.

v7: New patch. Moved all the FS code here.
    Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
    Adde new #define MBM_EVENT_ARRAY_INDEX.
---
 arch/x86/kernel/cpu/resctrl/internal.h |   5 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 110 +++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 849bcfe4ea5b..70d2577fc377 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -704,5 +704,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
 int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			     u32 cntr_id, bool assign);
-
+int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
+				u32 rmid, enum resctrl_event_id evtid);
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f857af361af1..8823cd97ff1f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -575,8 +575,8 @@ void free_rmid(u32 closid, u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
-				       u32 rmid, enum resctrl_event_id evtid)
+struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
+				u32 rmid, enum resctrl_event_id evtid)
 {
 	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e895d2415f22..1c8694a68cf4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1927,6 +1927,116 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return 0;
 }
 
+/*
+ * Configure the counter for the event, RMID pair for the domain.
+ */
+static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			       u32 cntr_id, bool assign)
+{
+	struct mbm_state *m;
+	int ret;
+
+	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
+	if (ret)
+		return ret;
+
+	m = get_mbm_state(d, closid, rmid, evtid);
+	if (m)
+		memset(m, 0, sizeof(struct mbm_state));
+
+	return ret;
+}
+
+static bool mbm_cntr_assigned(struct rdt_resource *r, struct rdt_mon_domain *d,
+			      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
+		    d->cntr_cfg[cntr_id].evtid == evtid)
+			return true;
+	}
+
+	return false;
+}
+
+static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
+			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (!d->cntr_cfg[cntr_id].rdtgrp) {
+			d->cntr_cfg[cntr_id].rdtgrp = rdtgrp;
+			d->cntr_cfg[cntr_id].evtid = evtid;
+			return cntr_id;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void mbm_cntr_free(struct rdt_resource *r, struct rdt_mon_domain *d,
+			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
+		    d->cntr_cfg[cntr_id].evtid == evtid)
+			memset(&d->cntr_cfg[cntr_id], 0, sizeof(struct mbm_cntr_cfg));
+	}
+}
+
+/*
+ * Assign a hardware counter to event @evtid of group @rdtgrp.
+ * Counter will be assigned to all the domains if rdt_mon_domain is NULL
+ * else the counter will be assigned to specific domain.
+ */
+int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
+{
+	int cntr_id, ret = 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (mbm_cntr_assigned(r, d, rdtgrp, evtid))
+				continue;
+
+			cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
+			if (cntr_id <  0) {
+				rdt_last_cmd_puts("Domain Out of MBM assignable counters\n");
+				continue;
+			}
+
+			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						  rdtgrp->closid, cntr_id, true);
+			if (ret)
+				goto out_done_assign;
+		}
+	} else {
+		if (mbm_cntr_assigned(r, d, rdtgrp, evtid))
+			goto out_done_assign;
+
+		cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
+		if (cntr_id <  0) {
+			rdt_last_cmd_puts("Domain Out of MBM assignable counters\n");
+			goto out_done_assign;
+		}
+
+		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					  rdtgrp->closid, cntr_id, true);
+	}
+
+out_done_assign:
+	if (ret)
+		mbm_cntr_free(r, d, rdtgrp, evtid);
+
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


