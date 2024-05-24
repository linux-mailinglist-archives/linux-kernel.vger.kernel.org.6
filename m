Return-Path: <linux-kernel+bounces-188679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F18CE544
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FDE1C214D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11121272B7;
	Fri, 24 May 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vY386f5Z"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48E1292C1;
	Fri, 24 May 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553516; cv=fail; b=VHZd4PHjMKEBEqYWpWqZ4qKU1exue93AmVQcm8z6k/DPl3KbA9OsfVLlU65rH5bajlyeqnkteBUHei9dQeWjA/PvIoX6CFPh9mQfwPFtgPCnbyFmekR6llYKDe1JtwsxloB4SJsFFQ01eBy/6SpL9aWdLGwlJWWcztcrms4y8Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553516; c=relaxed/simple;
	bh=PdS8i1GjpI5CMnVnrxG85m+Pi7MCPwOnm0eyWLb1Tlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcaI6pjYNJoicE9e+guT8tQOFok6my0T3Z2ad65FpP/7oR4oUEo6KbnS6bYxL68PBKscNRHn3yHt2CIr6Coo/u6ImpZnZZP2P78Zj1Zt7/BVatFmr/YL9N8506q9JJkNZlDwSX/GAz/8qrrWVdAWixSsjpiMKDqhehk7M9kJBBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vY386f5Z; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpHpKF+Pta9Ktt29dtRkL0gZb8+o+Oh4npVSZSIOps4VWtpkDFDc0IZleRUAVXaADbrYwub0Eo6lBZofa0ebVDjNbCW+cgzledxZOMYPAo6FN9UcNf7+yP2CijcCstwS3RdQvrubpGMsLXZdOWOKJT9si5Yx6HqukyTzq/CAq/kUZugr0rew0lZGe/stWbKBY8HlrALuPYa7WCeaK8iVki/u1RSMOk+4T2M5XJpR9pSMwvO90rHp9RxQfkKbs2wKM1Ojxg3n9FPnPY6+6lSGn10zcy5/qYLil6Znq1T0kAp3iH96wcyIAabINcWU8Qf9Yx7oDI1RlrH7yuZkaM8A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhoJLgI4fWCAu7YtXCqQPt6EYoIAItdWalh8k638SnI=;
 b=dpIeRH9rXtusglJZh1pivjEyo8SSrY7JEOo24Ari26SYp+n8dBev/yKJpV9fzGOxbLneTqOCf4OtIgEE8Ex0dGEbUw0Kc6aZg2PkF7hgMKQ/5ZsxgB6sHHs65bEb9jWXNmYxMIBjnNtdOc6ReUaUbmcSW1PGfzkdnig8J5kVjUtCs6Va2ps7w9z8RdRKgzMoQqXbcent4SXj1k15x6tvqQd44q3DM79CgER3OGOKvXbyny7/Uka22h1YGXr1gsWoSCK/fhR0eQHuKoPKUpzxQU9xjgKSMyQfyouj7ywzPE3yLfNx6fyNrul9tRDV4XPa4za/D9Yr7fMSLpuKe6OLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhoJLgI4fWCAu7YtXCqQPt6EYoIAItdWalh8k638SnI=;
 b=vY386f5Z0GGeAgpdISVcVlSBZZXlRofkbLLO+8M9+X0upffs/NMWbA6E4nWPNanlCb6yUgENLK0xX7+LocPWaYNHwfiPc5NxjVj/aI6lcLHyqJ+5SFyFQB1mkVB5kmQHUXRMZ+HJxAeVeSol5502dpynxXwT2yHhDT7bR/rBAEU=
Received: from CH2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:610:57::40)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 24 May 2024 12:25:13 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::47) by CH2PR12CA0030.outlook.office365.com
 (2603:10b6:610:57::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26 via Frontend
 Transport; Fri, 24 May 2024 12:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:09 -0500
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
Subject: [PATCH v4 10/19] x86/resctrl: Introduce ABMC state for the monitor group
Date: Fri, 24 May 2024 07:23:29 -0500
Message-ID: <75c5c798fb8675285648e6bd6696f52d08208464.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9fffd3-5e72-457f-53a2-08dc7bec8f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CxAUUh+BERXGYdvxFaEAnDJT+GUQIAcSKbwNs70rcm1cEVmEbU8p+D3ZnZd?=
 =?us-ascii?Q?YuPe150RNDvTu+10NxyMlwUHCZd8OtYHfcSa4zZG3Q6UIpVIw+qNItc0jO4I?=
 =?us-ascii?Q?YpOQ736jeiFEHlGBh68XJDEV6XVsPMG1295eUxUK6vaP7RH3VnWyOEmlL/MA?=
 =?us-ascii?Q?WHa1cxNw4sMLDO79+kFH2s8iJgL4Pti1XVfEVdJKcEa6PmsaIpbJY5K8EF2m?=
 =?us-ascii?Q?smQpwJpyPYLA4IXe0naKKDL0iek6xheMLFotqA/l3fSb7o1EeCfbch95ikio?=
 =?us-ascii?Q?Qgi2XL5tfmJy88RPHft9oBH9Iea5PkXXR9srsThO1bz8/TP2kUzwmp5J8hHG?=
 =?us-ascii?Q?E4ZU2ZW/p19Wpg5DzwsKlLaQD8jz+EbMDznfShsqEEdgWg+yS3UqAhwuEl4n?=
 =?us-ascii?Q?F8rWthPp5bCR9LHdNo3prXcvuv11ERfk45VK2C9znwcbNf1LSqbYhOdQA22w?=
 =?us-ascii?Q?rJkrGJ8EsfDzw17WBgcFh4GFFx8WpkQcY2ZtWSKl9HzYbF7/VPgtGN9wZTL4?=
 =?us-ascii?Q?d2tWw+eiVYgjDPxRJqQ3WL2a2TtYNZUE3mQyXZNEJ8oDAxWNkKl6BD33YZ2r?=
 =?us-ascii?Q?zumcS/iCNDLBYtwwEIh/6wJEoihJC3f2cNH6yN6jFBrX2VVnzmcKnhbmeYR4?=
 =?us-ascii?Q?fiCQfEpuPpccUsxpn+0KKQxpqEO2X1CiaPswj/k7HHm/m2e7EQ+uoge+mvUX?=
 =?us-ascii?Q?6Q7kSI5S4FoSbmmMIkScsKY8pGI3JVuqL51VonvrkNrE/nj991zyjhdfpALT?=
 =?us-ascii?Q?8fGwJVrHOKj2EOl8blIhhua7T62QK5NN4lZ24ssAaMilSb1DGkneKjNZja/A?=
 =?us-ascii?Q?NQ3yxtSz3/Z2Sm9UVI2J+BKXtzD3u2Fh12nc8+FWag+viVr98wQ3JALkxx1y?=
 =?us-ascii?Q?gDErXbzXbYtCW39BxOsmrNdOw8m/MykrHEBbVh8Dsm1kK6ByumSPnHv9gwKD?=
 =?us-ascii?Q?B2ubsbW9q/Dytu1v2FrblmgopxaCihhAX7dRWIAjH/h4FAeuSFa/LYPMPusE?=
 =?us-ascii?Q?9+JTV+R9FLzXWPlnHjdYN6lkVA0rPQJBc6mLd3uRzqFpBD4gGR6kAaw1WG/a?=
 =?us-ascii?Q?EdjJP85A4JKlZVigb837ogazenurfR7cD/aQdrPM91ouyII4XC2ElZ1PY+qT?=
 =?us-ascii?Q?EKMh/6EWVv+fkclgrhadXCizNGs4RbpYBFXrNwcwP1WgNh7DQkYD/KHHQYWm?=
 =?us-ascii?Q?dvlybfynbwmC0Jj9jD97kL3xZMm3CUW1GmL9TZLAWOHMkxerR+ZX4hN6Ij0w?=
 =?us-ascii?Q?oENebtmaJw3IuakXVG8CUy6oimeOwgblhxMEGdaOIkZJpmWEgP8yfnN3arjN?=
 =?us-ascii?Q?BidKCb6/chxwtdC0bG3D/0T0KjeGQ2XVRQRHGqC9YNTelO2Kz85MEUgeUk+9?=
 =?us-ascii?Q?Gq1zWdiNKq2uxMOl/2w/T7K0H0+c?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:12.8406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9fffd3-5e72-457f-53a2-08dc7bec8f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
There are two events per resctrl group, mbm total and mbm local.
User have the option to assign or unassign each event individually.

Add a new field mon_state in mongroup data structure to represent the
assignment state of the group. Reset the states when switching the
monitor mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Changed ASSIGN_TOTAL and ASSIGN_LOCAL to use QOS_L3_MBM_TOTAL_EVENT_ID
    and QOS_L3_MBM_LOCAL_EVENT_ID.
    Few more commit text changes.

v3: Changed the field name to mon_state. Also thie state is not visible to
    users directly as part of out global assign approach.

v2: Added check to display "Unsupported" when user tries to access
    monitor state when ABMC is not enabled.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index fabe40304798..5e7e76cd512f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -100,6 +100,13 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
 #define ABMC_ENABLE			BIT(0)
 
+/*
+ * monitor group's state when ABMC is supported
+ */
+#define ASSIGN_NONE			0
+#define ASSIGN_TOTAL			BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
+#define ASSIGN_LOCAL			BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -203,12 +210,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @mon_state:			Assignment state of the group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			mon_state;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 400ae405e10e..c176bacf7ba1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2474,6 +2474,7 @@ static void resctrl_abmc_set_one(void *arg)
 static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)
 {
 	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdtgroup *prgrp, *crgrp;
 	struct rdt_domain *d;
 
 	/*
@@ -2493,6 +2494,13 @@ static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)
 		resctrl_arch_reset_rmid_all(r, d);
 	}
 
+	/* Reset assign state for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		prgrp->mon.mon_state = ASSIGN_NONE;
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			crgrp->mon.mon_state = ASSIGN_NONE;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


