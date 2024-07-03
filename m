Return-Path: <linux-kernel+bounces-240263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598C926AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976E3B2639F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44952194A73;
	Wed,  3 Jul 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T4pk9iPq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE21946D4;
	Wed,  3 Jul 2024 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043441; cv=fail; b=LYdzCy78uaOID1XUbKIO8bf44lfmcYchAes4tUI/i0vkTfAD5iqJ2tqfPHiWyZFhs9RJxuFdGaUyesyjPNguYld29t7WZlAAv6j+u5M+t/9k3PGIGTgrsXuvbLKtIWOBLZT3F94en3snHFCBUGm7ISOUezJLGsOga7wFl12fNXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043441; c=relaxed/simple;
	bh=qxSJlsBSAsQgDbwXnFbFqkS2/SrffzR44KAfjNQ15S4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppkVoAJdFqJmJh4WLeUnDDhkEuXAAPw4JkctqvotTBk5DXS+rmHR2Iyxaj/PeLKr3bEO5jodxTgEAv0pcFg/xk6qqjWr8prYZHQbPB7ty0RbScyVI3x4xz5Qxk9n9uZmOqH9tylAjHzKRwAWJa7dZOKfk7ZX75kVn0UE7qHYP/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T4pk9iPq; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX7r1q3ROjzHjIkLs/+mw4P2nqJaakridHd54WzkErbaatkwMIbNdu05HCCinggdfLnp747/cNbEd/jtkSo5p8SFs6ExrqTU21p4OaacCjyaW8RSra4TE0D2+jiUD5uAOZcGxYJLOuMHXKEvz/NsfKK9JFA2sFdiqQ/rS1nIYlPVoiqiF8zGlW+6TJdHaoMWxO+JT0f9ferpL2EWOsYvATGStXQN9REaD4NvuGmG79vpl0d9+shg9aTlLaq0at033RXqF5bO3QDSQ48AI1gTRdepTF3lva/g8auyj+wwXAnIaiHE+1moqj5AHZvN4H/wCb5G9oXGEScczyCMKbsGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkxZZU7BVaEho0FMkpgLS9Vf5ou/ipcrWZcYK6TOcZM=;
 b=eqPrpKhjg3OSHus4uT4qLpwhdVLeFQoB83eBWwDQIgV1522ZJilSiSmrAmEHMs9t5W6v+uGE7ul7Lzwh6Eej2kC082zGgIHhlJlbaayHAvQsbi57b66CmYfoO/rbyPNWfZccxo56CQYhK0ixLYRZGmKp31r8TVTMXrs/r2JMvSRpc5aK9R4CidA/JyjzQBWaTD6vBnAXY33IasTuJXcOjiClQkY5Nt1df9TVbvbC6WFpTD+hr/cEhqQic/sHdC9hC8Dg+h0FlTO0YXPm708ExPhXyAT6FDX3TH8S36YzKCH2v23dcgyV3o8OULq7Qx2tG4PbJZMhGwN1wBTaBhGOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkxZZU7BVaEho0FMkpgLS9Vf5ou/ipcrWZcYK6TOcZM=;
 b=T4pk9iPqBwUHdVk+aO1d7YALxCe2IyPcRSNYblRr5Y6bE9wV3yyw1qHJq4SlSUaCi08nA2uF5UX8Q3/5Y+SyySVnN5e/KbNp9tdXRBPvn8B7UlrxBqtB3D/Pt45PQFPtRuyCkE1NWxS48m2t+Dd9ORuYMcl36X0dbrPqF+vgn3o=
Received: from CH2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610::34) by
 PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 21:50:35 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::57) by CH2PR05CA0021.outlook.office365.com
 (2603:10b6:610::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:33 -0500
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
Subject: [PATCH v5 14/20] x86/resctrl: Add the interface to unassign hardware counter
Date: Wed, 3 Jul 2024 16:48:25 -0500
Message-ID: <9036479261abaa3255c9fe3ce460c590142672c5.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: ef07ff2e-9c2d-4161-f579-08dc9baa2b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dEVHHDtMHFudpX91SXBezqQZUtAATOX4DtfNc8W8mQO/54olLYaVgzTk6Av4?=
 =?us-ascii?Q?Zef9ciyGGLLsuPWIsTwBTb9x7tpVFUsMjHxw9S716/hag0Bl//GlnMUbtCem?=
 =?us-ascii?Q?t+FbBUwsCIn6juqMq+iFZXoGkyqcO0G8LykLO3QMaCAaLeZRheZ7XwSqwUTs?=
 =?us-ascii?Q?3u1C/ckokaMx4x3qQsrVDEVD5DopFEKTEpmj2EENcMBrnskrKs6JWvXWNCm3?=
 =?us-ascii?Q?gf5k8/bse1Q+4PlOSzSDXDjlbEdFXU/7bDQq6WqlWhL5bCcGlAQ2wBsOmM8X?=
 =?us-ascii?Q?D8x+SR7Z9EmyolZDSN17hogBf0qCB2eqZJDV7J8Tg4WoZHhRfpIxEDlbaxpp?=
 =?us-ascii?Q?NvFiGmmKtdzArFZFfbneHWlZ9cKfM8kQxQ9J1tQDdmkzZgWPWwPIPkJPJR4i?=
 =?us-ascii?Q?hk2zmroj6Oc6SAdmRjRg3s0kewXG4pv/x0ihVhKg66hEq9IyL2Ge25qpmiIl?=
 =?us-ascii?Q?EC+QLK0uXUnsdWjYjWoY4K4dOl4VgoarP54xuVFCcQWN/kCRHhuCGdHH1gIl?=
 =?us-ascii?Q?rDCloTuwIQw3ght45WP1QIoKMHRI7ftSTJ5bE2KhEq0fnSYF6H6lHH3FgnKt?=
 =?us-ascii?Q?gGKYezRhMivQHhIEwwFYNyh1O/mC+7GS8yE8wDb/kPUbJ4zQHMA2uWKtMSWP?=
 =?us-ascii?Q?S4CeqSa53YY1c3J5bHlNX4oTus3FhrdhndcG95AbrlquckU6dZY+dKlMKq3I?=
 =?us-ascii?Q?QCDaB75ZtmRtQgXQveUcQ3HIa13Jc0sCn57dtzqPJL0yIvf+pvdNmLz0Va+J?=
 =?us-ascii?Q?T1KQvLZnta3/+84rwnak8PFzSSlst6Y1Xt6uWOW4T/MrjL91sQyYiElO/l4S?=
 =?us-ascii?Q?9JTQIizj7lmfjcPhGXnPzApVCvuMb7HbbhmYZwsEV+urLwe7087i73hADMNS?=
 =?us-ascii?Q?Rf+cJ7/4XqxkWdbU+PqM7An/8VHrSDvgw5BR+sArGqTb42AQqFpPyTKPVGYF?=
 =?us-ascii?Q?hqP7vLfuWBRhcpnbyETSsYlNt/xG28f2HvF9rAh7i1iZ04ZVx3kpbqd8bMWm?=
 =?us-ascii?Q?RuqZBwD7hdwtqFZA/kngk15vqbJyr2U6Qm1bRynVuyCfZg8VbOzCDzEYTo6x?=
 =?us-ascii?Q?k1OZsGOwN8NpnJCM+mezpHKjBASHOz9H1rAYPZaq0c62WTaA92po9r3wAMxC?=
 =?us-ascii?Q?jkMyu7L/kDZnx2U/frWrUFPyo67AQ1AHCXQ/kjRApXSZgXJ5w82J9ndYNCSD?=
 =?us-ascii?Q?bQBumtLhW/rMl/DhquO7I41dLL+3TTI54ztkcwn0JZ/ye+e6KmSmnqn6dfjX?=
 =?us-ascii?Q?os/lTfbk8o2YP23+Rx+wvczddWp33Ij6h6jOFdkPK4wsEcxZWAsnuPAZ6mCI?=
 =?us-ascii?Q?CJiTMSgLz65pw+hYabSpUE67aDwQT6FZGvGr4lBELv3nTzog0ru3KDSK/Qj6?=
 =?us-ascii?Q?QPVEOXM9a7iRUrdu/fNHoHBV4Vuc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:35.3481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef07ff2e-9c2d-4161-f579-08dc9baa2b62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
The assigned RMID will be tracked by the hardware until the user unassigns
it manually.

Hardware provides only limited number of counters. If the system runs out
of assignable counters, kernel will display an error when a new assignment
is requested. Users need to unassign a already assigned counter to make
space for new assignment.

Provide the interface to unassign the counter ids from the group.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v5: Few name changes to match cntr_id.
    Changed the function names to
    rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 66460375056c..beb005775fe4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -711,6 +711,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
 int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
 			     u32 cntr_id, u32 closid, bool enable);
 int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid);
+int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, u32 evtid);
+void mbm_cntr_free(u32 cntr_id);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 44f6eff42c30..ffde30b36c1a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -215,6 +215,11 @@ static int mbm_cntr_alloc(void)
 	return cntr_id;
 }
 
+void mbm_cntr_free(u32 cntr_id)
+{
+	__set_bit(cntr_id, &mbm_cntrs_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1956,6 +1961,34 @@ int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid)
 	return 0;
 }
 
+/* Unassign a hardware counter id from the group. */
+int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, u32 evtid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_mon_domain *d;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list)
+			resctrl_arch_assign_cntr(d, evtid,
+						 rdtgrp->mon.rmid,
+						 rdtgrp->mon.cntr_id[index],
+						 rdtgrp->closid, 0);
+
+		/* Update the counter bitmap */
+		mbm_cntr_free(rdtgrp->mon.cntr_id[index]);
+		rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
+	}
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


