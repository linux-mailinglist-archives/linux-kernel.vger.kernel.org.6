Return-Path: <linux-kernel+bounces-357624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738B99736A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB251C23112
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DB1E32D5;
	Wed,  9 Oct 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eMe+GQ5l"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF511E32D1;
	Wed,  9 Oct 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495731; cv=fail; b=BVv4Cgpa7ZCRMTKYpIYyf4qnf49DWj5QmzRLGxZ7neehCwtk59HbeNfIjVIBotT0pnhMpCJJqdLw2DGgIeEBDeZ4nqi8rkdUzBVF5ckR91td9KoCXf41/E3GOxW+qVVdUg1/RFjVtNgwnZp45Xe07r3jSmzQZQ4xTN2Z+Anv+pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495731; c=relaxed/simple;
	bh=M32fLlMWXhXq10kLBTMnEAmGBWXflttE78CJACq5wSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV27UURCQ2HqafHmfc8YLCF8P6B7S2vzFF6o/JOu0Xlg8yTSijUVaJzMyJnq1WXAzymr0cXNPOwAbVxMYk+TRpU+EhEFtQB1pi/o92Q6HJVnPmauHK4OY4TJDY2cANfURs4V5XY3OQNXY4eqaXX7FFyDrZD69y1bnuJmjd4sU5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eMe+GQ5l; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQDW1odIMhrgf0NvzM5yE8rJWsfB0zirVRaxaewRXPETgLVAwa1G9sXDLrlO9yPe7cdTLdp48s1zy8DTzPkHfOk4aRkMMGWum5/IWZrbVgA/4MzxulTF5BAyUr06PHWbqQzBFgMqHjZhtk/HXlWXA3lceN00cbwl1g5h2opQMT9FxdThZhdr1FBJ1nRGiuWOTs6TMLGqPqAiSYlRenR0VCKRcppNET/0vkHLx0UFeQwLtRr2TH9iMIZvYj54+9dC7Vf/UvWnSvm/UUWfMGx5qn4cL17kKe/yP+NtPzg4J93qFmY3EKMALf0rfnpeo55MTEkO3MHzu5m8Ez2ylbp+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4hDXsETz4uVGQ5eV7unGv0DAOlVnE8k9yIgIab80CQ=;
 b=d8aGsmjFTgtY6RRVwDdQt6VhCjnvF8/s0qb1ahFqBOx47bGKriByL/Mq/N6taxr7Lv6nr75Mh23zxKQykMstZJLM0fD+UGufOelDDat8+Z2qFrJz1hZF5g+YnTaILOKvQVZQJI2xt42oQ3K9qDKRXS4kdJz5TtSzxSzdkxzXGXC0bVTqIIOLTVUXlf4W0WQZw67juOiaXQiOnIBa9IhXqLmfHmOQL85/bqC4CxOmCfSsrFO3tcKk2JBhGhD4mGn0/NYgKxkegqQRXJk5QBFqMBoF3cBuYpNyhhifMTs1gUW82KpHQEyFyzIKJTTFBsBAtatz6A4pWf/sjzy0thxpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4hDXsETz4uVGQ5eV7unGv0DAOlVnE8k9yIgIab80CQ=;
 b=eMe+GQ5lKqtve2SeSIEBrp0qskoSaoJBbddIbaLT407cy4Q/TeCqrm73WFBDKX6TX2re3rUh+rk2uC7rBNEdmtn386vySfUEHVLz4NR9qPBGO14n8oqtLGzbPHPdIuiZpMcEHYEEdL8V5umdcamCdGPfafBnMaCemlaqKiDP0QI=
Received: from MW3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:303:2b::10)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 17:42:05 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::e5) by MW3PR05CA0005.outlook.office365.com
 (2603:10b6:303:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:02 -0500
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
Subject: [PATCH v8 15/25] x86/resctrl: Introduce cntr_id in mongroup for assignments
Date: Wed, 9 Oct 2024 12:39:40 -0500
Message-ID: <0af9b74cc32cbdd26fb0d9adda40c359e8bf1bb9.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa61f55-5daa-4695-0f95-08dce889b03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQ/lBC99fGNht45QCfPrviwvPV8AysC9NAQTW5ganuNKM6xZlPeGD0oQNwfx?=
 =?us-ascii?Q?StOU4RFbLr4402bjwAFivG1io9A1qjcnR9D+jFhUwVop3sUnrEdnnIq2MGUi?=
 =?us-ascii?Q?z0yLMzbUmoNlWRGkQRX+X1iFmSe1bWj5TXQ3riBLmW+Bp40Lgef6sVCCQ0Y+?=
 =?us-ascii?Q?d5rwhpFAFyZtrJOA8iabU8Zl+2ktTLr1i7xcXskRMbHs3eCsLly7obu7X2R+?=
 =?us-ascii?Q?DKOuSKWbXOzDmpjAQxePzUN2DvkbMitKlZiEQH3d8QsAoXzjgWP3PNfKesIu?=
 =?us-ascii?Q?K60Tl01bxNiUJAC8VMoQviXkB5mIBfsQMRBOtuNH1tBWFxw6wR/Xzog4n04M?=
 =?us-ascii?Q?lbhFKjR1+zLhZXak1uab7FlIPBfK/Ao5pt6iGXzKYS2mG93T04zZFt0LNa+l?=
 =?us-ascii?Q?gfK9ft4qdoTxa4vHurZTaMfzQlyk/ASDO3Vm2pGKXEweYdP/FpGHuw/BpasT?=
 =?us-ascii?Q?DJ+XjzLvC8ODrPPZ3e3ap6Cq+xkpo1BB3yxEN8B1JwHYrE8gtLtxYeZVLFgc?=
 =?us-ascii?Q?93VZFYnBu5AcRw/WhS0u2h9NGfjcOQXSjUZZfI77s5yb6+sf4C+YfFwSh45Y?=
 =?us-ascii?Q?kLMqSNi+fqOV6SF3KLE8O6SQ2R9AAMkG6YMYvpw6H2hCsUuHZlEf03zuCdzc?=
 =?us-ascii?Q?Z5GYAdOlmwf36hH/12u6fqq2BD3vckMR3U35Kr9K4zi4mFZjijAiu8+fuDQO?=
 =?us-ascii?Q?UHadTCttCG/ixdyUxh61B/yHYl3slSz9NBBno4VSKBtjOJwCfWPDhbdbllXw?=
 =?us-ascii?Q?sWtGGiEIdLU/ookqHC/FOPg9S4CBUKtmWXfRSTzQu0gLerkLGfiL97pdjUZK?=
 =?us-ascii?Q?AB/8g8lMnJFtgym+rKYAoEgaLmZfPLCEyraeySs+EWP0dUjUHfW7NJgYUBHg?=
 =?us-ascii?Q?gIm1JSmu65HnKBkdi2HKGuA/i325bdyOXlf80uWKeOhbyx222nHzBCzNKUeb?=
 =?us-ascii?Q?IgNcqsC7PLWAEu8f4+XLcw+p4vL/AlH/fD9K6e31aT3S5tq63KjfizlE9yEE?=
 =?us-ascii?Q?JXsCketTCO4+35ZX7zmobwxV4mhszsmyA2EOI0a9bH08X8qvY0rZ4r1kxNT5?=
 =?us-ascii?Q?ZRzWRVQJ8MKK5hhj1PRpFFij0oNHDdZwTAgKAniblh53OteXCTSO/oAemJ4x?=
 =?us-ascii?Q?asmbF/OUh7EZm5DTbmZs21k3Va8XYCbMT6qDBc4qKxpK57pzJ4dUkIgmMzq9?=
 =?us-ascii?Q?xNZWDPezTOkXiOiwHVmOLrijJdFjkBNw/2ThtAUVFVDXDb9xxNNVwGA+3jAd?=
 =?us-ascii?Q?r1s7jvCbidme6AGr5lcMfZmsGGCC9N0Unt8OeZpT6bS3v/DeecOXe0zFqrno?=
 =?us-ascii?Q?/fS6r+Pg9OOuBn8xOImVVpNV3Hr8o5Ej1plYA4tPFKsf/NTqmk6aJY66JYmN?=
 =?us-ascii?Q?42ULqMMZA9GTd4QcGJuFWTNu7OgR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:04.0101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa61f55-5daa-4695-0f95-08dce889b03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333

mbm_cntr_assign feature provides an option to the user to assign a counter
to an RMID, event pair and monitor the bandwidth as long as the counter is
assigned. There can be two counters per monitor group, one for MBM total
event and another for MBM local event.

Introduce cntr_id to manage the assignments.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Minor commit message update.

v7: Minor comment update for cntr_id.

v6: New patch.
    Separated FS and arch bits.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index de397468b945..58298db9034f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -62,6 +62,11 @@
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
+/* Maximum assignable counters per resctrl group */
+#define MAX_CNTRS			2
+
+#define MON_CNTR_UNSET			U32_MAX
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -231,12 +236,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @cntr_id:			IDs of hardware counters assigned to monitor group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			cntr_id[MAX_CNTRS];
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 610eae64b13a..03b670b95c49 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3530,6 +3530,9 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	}
 	rdtgrp->mon.rmid = ret;
 
+	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
@@ -4084,6 +4087,9 @@ static void __init rdtgroup_setup_default(void)
 	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
 	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
 	rdtgroup_default.type = RDTCTRL_GROUP;
+	rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
+
 	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
-- 
2.34.1


