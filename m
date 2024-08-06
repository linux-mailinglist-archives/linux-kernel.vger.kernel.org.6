Return-Path: <linux-kernel+bounces-276997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5473949ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44752B24557
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E417ADF5;
	Tue,  6 Aug 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="malPxV9X"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552A179967;
	Tue,  6 Aug 2024 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981780; cv=fail; b=I796j3RZl8T3mgDP4+0lG0xWOsgcWzPkJNSWxbREQuBbZHinEP1G0lVugxMlcdFjUY2SWuerLQDOtCZd+JTpV40HUxt5pmoJRTOXTm5Ume3aHTnQRICkwvdK3ANj7eAPwXBNjepMGw97pCES4cRSqGkTH9fsutLIsekVWDifpJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981780; c=relaxed/simple;
	bh=UTdTjwR05xDifqNlVbxEM1c8g1mFlMgfmMVxiGoKoJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIbYYxdFGUuY1WwRr3isY/WWep9NAqQ5q7zn8kGdxIf9yzyf8tKbiT80BOvFzCRTB+YZhNYTNZsE6FauiQhAAI8+ULyYYHboQoXnEyYMtpOJntScgN8ozI57lZVdy8jDPRXEn5P69VnZ3/ZnA6LTSXwho0R/Haly15D3o81lQRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=malPxV9X; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+K86ROi/HXNKIFXI8M8HEpHHLwfj5X0wZaQKtfFR2LhmWjIOCyqa4ym/RWOkcPU5pf3jkZ/UTTl/kvrF8OfEu7IwIo0P7KV3XqgFaZV0XlGdDztg03hP6XJZHIvBO8ULPozmwteVNeWRub5TNOE64/yfNTpib9JQQ6WPlA2BrlVsN/WX0kiX89hC+HaJvnZNzXtLxfPSP898V+Mc42ahlvFMVB0f7RQO7gDiiy/dbULAm7Zosg5hseQ5rQz/CPmfdyUGvwFkrH8MGJ/OiQGrdH3gmvDJ1wUHBCcPOcj7zmliATkHkee0T22jfXoW3Wu7zfePmzkTLthy/jL0Q3S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6VDyzw88vTpqfV24g+B5x/y7N4eAKIfS9+qtJjySOc=;
 b=izXr2hkx2eH9PF7r1T/wpYtV1RZyh4itytcOP/V2AaCOtPhEOdjLzekdmnVZs1SPnINW8pS7fdqwWU+XBpOg8j/qVM8skpQgt87XVu+CeWY5gg2R9dZWeOx8wVr9UDJJIYTCWB9i/LdFGHFQldlAEOznQ3gMsLjgFbOktUvjJyRwIxTwr8oId6jQXPcEH46pND0UnrFHF0ed7kHf8s5QqkFkwQrBEyOVphPzbn/VeVTAqGQF6BF9bzqFyRwK50fV2CZ3GysOkNcV12IcVNBVbUJLSYlepuog39yNppSHZbX0Eu2REG8ipqhIUB58ZyRChCnf0cHAofje5JBhYH5ftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6VDyzw88vTpqfV24g+B5x/y7N4eAKIfS9+qtJjySOc=;
 b=malPxV9XgMaJLmDQxkKLrX7cmx/S0ULLdKCQiZSQuiyZ3VFkn9RNDxM5Y2I+tbzyKDj3HzW2BEijWacKMNMbv9L7AXMR2UJ57PDL069KQvHvHandpyDfOhzsdjkwKizkW1QvOncTt+Lq/ut2LKc40WDOrgvv/tzXlZ9wOWJ82Ds=
Received: from PH7PR13CA0016.namprd13.prod.outlook.com (2603:10b6:510:174::9)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 22:02:54 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::93) by PH7PR13CA0016.outlook.office365.com
 (2603:10b6:510:174::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:51 -0500
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
Subject: [PATCH v6 14/22] x86/resctrl: Introduce cntr_id in mongroup for assignments
Date: Tue, 6 Aug 2024 17:00:51 -0500
Message-ID: <5b8b1f354c2f4b5eda3fc7f2ba0d4d0b3744fb61.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: fea8b4ca-b1b6-4f8a-982e-08dcb6638575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I27X0ZEe5TIzJ427Lqz5YQIlIaf+FK26hKRoN7uNfkpet1vD5ldcccXrLTkp?=
 =?us-ascii?Q?86agXEZjY7X+b0vqBm8mlj4q1yJ7kjucqoaFULMSBxlKw45gSq4VOSvtxDV5?=
 =?us-ascii?Q?WkuCNk0pby9H6b2I/NnfbSQXMoaXz6swh1jSDKNOfRC8W2sDZtfiYHwE1oLL?=
 =?us-ascii?Q?9ccWn5c57Xtb5l1UwoXmHXDVIR6NQA8+C3wW2RFaG5R/goeof/XA2ni2sNtr?=
 =?us-ascii?Q?lMFwSMzoBFLNi6exb/+5Wq34/QT+RVk6qcezGqJy3L+qMRWKS7c98UV06Tip?=
 =?us-ascii?Q?0Mfs1ZbKRejcbledAsbE72F0MhopCCkivajT8pd7+6Yn0NitVrqIO/ScozAc?=
 =?us-ascii?Q?Uz7OQPGdleoJZYrPzAfZvDD7e3czSwQTdO/jeIFsWhqqyZ+3IFgQHuO7ICde?=
 =?us-ascii?Q?o//ZKfqsu38MRRsl5gPteTUxPdnGtJ+4JNW8PHY5/H89GUZGLaWI60c9oLgj?=
 =?us-ascii?Q?O2DyZ2T+X7EiOoKAglznv43pzr2UUfvWwuRVtmOCQDAdY4gjkJ97Vsuz75oq?=
 =?us-ascii?Q?6fT12el2cH4OVWmSTePABmZ7U1bAaKsUW0SBbTQuYxxvFyN3vC9/bGRfUT4v?=
 =?us-ascii?Q?noomomcS7adWE/GRlv98yxO1krsk1QEpmEKyJ8BfpRNPYSc7LqZE3hv1MufK?=
 =?us-ascii?Q?v/4oYrz/mwBdh87MHsqIk+SsaIRbLKHj73NqdeRklePScGqGXVBXJ/5GRngJ?=
 =?us-ascii?Q?DDy74FiXfidPpVfbzjDfPSrPN21SeDt7DXNIIOAKBSqHX9T0TsxRezg7Yxh5?=
 =?us-ascii?Q?W05vOvjnDPOHea9sZWvrH68WToti0A10OCUqz9Z8JesbstBy7mBD8T64Gg/Y?=
 =?us-ascii?Q?9Qa6JK4dFrtcJdLqMo68auGj0xKUK+37inP1JnJevKkrDMbcHtwTG1HRuv0i?=
 =?us-ascii?Q?00dEKv3dW5jA8Zrm7tBc8MKKmOIhzjEl0N+AT5Bg0UJx0/51XVLmqimfE3Lv?=
 =?us-ascii?Q?yOEiFk59cpbEZfpOSCOBUd1noQhtG2fqYI5IjbfOfvkmMbse2n7aTB8z8Fku?=
 =?us-ascii?Q?aYKX5LcXxxlF5p7qrNq6BycHMf4FelRrsaVoUQ0SgOoR9NLWbNBSDxJahx7E?=
 =?us-ascii?Q?Y+Mzykzayz2RszqpyRI6916gYcTUsVwoiqY59g+buPTold8/kniNO3b7PnbE?=
 =?us-ascii?Q?Od8/y3J1SpsGG6HDEaHogb/xadQaA2Cs6eqQTSOSudk084ltG5p8TjeouU1U?=
 =?us-ascii?Q?k3mC66jqfuH4YY5D8E1Xxyy4VBIexYNrs2xpFDRLykEouFQSOo7aRqXikE5M?=
 =?us-ascii?Q?FcdczRJj3RI8S+HYTibxSaU5QL2LBVp6kHS5NMaJDGmh9Frlmv4RVyi4v67F?=
 =?us-ascii?Q?57zPumHoMCw2U7qjZgPZHbUa2r/dbEBoXIq/hRMOMYPhVNGb1jpjKdZVgcPM?=
 =?us-ascii?Q?3FxMv5v96quW9xIwRAaKWzBAL6GRD8m4d11A+qHalO6EAbZlEkMsK3Xn9YRD?=
 =?us-ascii?Q?fzKaYN8AnxDzdxLymxVuji55T0OXPq8w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:53.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea8b4ca-b1b6-4f8a-982e-08dcb6638575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

mbm_cntr_assignable feature provides an option to the user to assign a
hardware counter to an RMID and monitor the bandwidth as long as the
counter is assigned. There can be two counters per monitor group, one
for total event and another for local event.

Introduce cntr_id to manage the assignments.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: New patch.
    Separated FS and arch bits.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index af3efa35a62e..d93082b65d69 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -41,6 +41,11 @@
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
@@ -210,12 +215,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @cntr_id:			Counter ids for assignment
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
index 1a90c671a027..60696b248b56 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3564,6 +3564,9 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	}
 	rdtgrp->mon.rmid = ret;
 
+	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
@@ -4118,6 +4121,9 @@ static void __init rdtgroup_setup_default(void)
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


