Return-Path: <linux-kernel+bounces-316052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5696CA64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F141F217BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93344185E53;
	Wed,  4 Sep 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsPxnkd8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A717BEC3;
	Wed,  4 Sep 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488698; cv=fail; b=RvouPtyhI2GiWhgJKZg2IVVbBY3xIAFQDKfReUeE58zfuRHmpRmPFoS6xAiFu6xWH3Y8T0C63y6nYkEyiSQ6d+otbsq8nUy/HpoUxjKU/GSL0xlBtAmgQKOF8kJoBVAbfribfduMf9uwH58vVZ/HNAYPlltFO3WShRm2pn6VwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488698; c=relaxed/simple;
	bh=ztFp9rIrRf9CgGH6wOTLUc6Kwe9EI+1KhwO2CgnaByM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRJejh4Bq+vJ0Y57jLcgEN14N/+ZvvCak1dKFtPFuKad3I59j2wXz8p6xZ4ntdyxFudYuyx+Ywdo/N6x8m2FJeKlyIAQiZMRtOzzsVLL0JkDXJby70AqUET5NdI8NngPFxBCglwlp9/4WSAkpKJtJrYMI/AC44+BjkvuOXqxUS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsPxnkd8; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQNNzz2BSz9y6I8+mVB7eJiXDp7Q+BwIBswy/a9wYZTeiRmuAgt8QOkWwnoCUFNkTump/98RzscGUjgEoe7Xq99cKf2lG5uW9SaJC0DD/1w90XuIzGvcwml7QwtLot1pdrqHZKWjfGUdCZKIEBqhTmHQ0axuXG9bcDL/1fenwkCXrxicB7lgNO3HGSMCrZt2GpnolePj5HjNu+tLMggajvMbh9Jw6gqbpxIkhtVVewawWEzsQQaBxzsRd3mEpzKSNCBukHXtmCA991zJX3ziTARqkRsGiwcwQ9PKtQxbnh4ZU3kOevmFQ8J1pEcKJy+x9PFn80lQAy15mO5G1inW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAit7TLjRE9ModwaBXqjVuwReQMxVBIV49cchu5vEzo=;
 b=lzkLvlLJE6sD16/yGfZL6tcDkxjULnUx0WR1ABwkt/JfhhFS3HP//ZswZY0zVbZ4UCMIDiEPjQx1LZ5VLK2hthc09T7Ona5M+l1IU4uqjyJFplu0VdvZcBTMaX8Vfv+tasTHdpAqasba7CmpN3+KzuRAiRzxFPsm/XTPiqLwNqfngN5CufJEZYMhztVjTduiDRHew1Wz8F3XcNlhbnyzegZ0tFNfDU1EaHT0xrb/cIKbybnMrRiGvCh8l1YP/V+RIQoz902YijqrDylxsGicDTuxuJHsD6K1/VLBlrMJYv/H8jscnirsV6jYD3pLKYIG6cj96c7P2XjWTue8EfOP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAit7TLjRE9ModwaBXqjVuwReQMxVBIV49cchu5vEzo=;
 b=ZsPxnkd871HBeguqeuxriX9z5874HE7TF+irhsxphRpqd47IqS98wHGm/IvAllYdEmclkOLzncHE2JRvjkodZJEt+XV3SvpfV6Bt7q3oHlT+aJHFiNG9pOQHcRcElNXCpMs2eq4WqqjNU9ED5LDAUX1LmxKtVHw/aIgZXgERJVU=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 22:24:49 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::bf) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:47 -0500
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
Subject: [PATCH v7 23/24] x86/resctrl: Introduce interface to list assignment states of all the groups
Date: Wed, 4 Sep 2024 17:21:38 -0500
Message-ID: <e6782ee97520b92d44ba80e510e8983895426e0d.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: a961cee6-ba29-44bc-2bee-08dccd30636c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6Ffx5YkUGPSUTZKTDB5s6rEbOUHokL87TzxHsbDqe5AYLjmIteodltGv/kC?=
 =?us-ascii?Q?BLbGkvOcBVRqiPafIiTLFVx0xe4BWbo/iTUXCtmn3MwJCgG2/pF9W4kVD3NI?=
 =?us-ascii?Q?UyjXDD7B1F+jorbhfjaIqJpf4DmSnT4/iZeNrEBNu2X7H4G2uZNOw7Jru4YJ?=
 =?us-ascii?Q?nhJv3EHZkiOedg6hI0VssfNAOYDeHYiGVyZWc1RDaz7F1C2TUvHlCw/fPrxo?=
 =?us-ascii?Q?zkUxBUsA5iqWMshcNBl7dAbUVZYDkJWDA6IjGphd3P0sd1lIIbFCDn/dwMqS?=
 =?us-ascii?Q?YmQbOHTvyLDDrT8zlHNRNQ5//CyxGn1IBou1UREa0a7CIihChtqvdfw6yIHB?=
 =?us-ascii?Q?Sf0X/cJkijjiqkQ0z4SPLcu5wouPYDoTLgTd0Q22ePRt07ImiGvFM/xnprq4?=
 =?us-ascii?Q?GF0ZHFrBwnEzn20WQSdNg7feoYxfOdZ0iSSiQYYiFEewvS35+upuvb54L4+v?=
 =?us-ascii?Q?bPggXIJQASH79uiXT11xnxpymAdgc0SFskBS6jx4oAK/CBtWFSuEWWNACkfa?=
 =?us-ascii?Q?x6a5lnzPBonrqZS5Z0zvTowZ8YYoGl7DvN4UZOSenJ0K7rFSdCFNcwhGGJSt?=
 =?us-ascii?Q?72re6R4X7etr1kIbEaKQlC1FbTMpgBCZOu5VuoV6+UTDjF9RtMK/xJ4Lzk8G?=
 =?us-ascii?Q?OwHVoZiBBebZTGdzunOhW7brOXrSYddSzHmb9jLuHkqnDpsfoisJLmLZFaZU?=
 =?us-ascii?Q?pD0lrYV0LNzrAjv/lEGwOkTU4VfG73yXAWVHmG74hBMD7OUNuirhvrrm9mQ0?=
 =?us-ascii?Q?RIttwiSVgGWyl2gkfvlldYGxerT8CMTkryC3ogbiHY4fsklwtz1PpyMC5xBH?=
 =?us-ascii?Q?cHLWFv+HvUUptIRNGUceIi2iq2QjwF7jtROKapqSLTkhuLddkWHS/G7ErNNQ?=
 =?us-ascii?Q?oceTt/8ASRU5x2B8BF8k6UaRz+7YYKMCJdHbfe0wwGxMMIRDmbGE3zPEWINI?=
 =?us-ascii?Q?wgY+Ogb2Zjhe+GyCZpaLTCoqtUayTmAegIFPtI25GKYsfJKomodKFuBB57U+?=
 =?us-ascii?Q?w3e1H3eowvEo1A/f1b3IHybfIxBpbmIJ6AE6k9Ztp9X7rmDctEvVWmmT5HnY?=
 =?us-ascii?Q?apno1oXJZWXi2GVLpSnnWlIbLHHEG+SQQWEZ8wY//Z9ag3oh7oxLohI7DHLB?=
 =?us-ascii?Q?6o5V9lChFC23GKZuDU2oeXMZ2bz49cTmKjpoYaSyHZ30srCh6NKliuVbOcQm?=
 =?us-ascii?Q?MSGVdcGmhVQj7LZUvFrRwPSDdeM/PZWEvqhHN3RA4HFkjUpJ6ITICZ6ch1UM?=
 =?us-ascii?Q?e3P4Vfx5HeJPtSO54m0ETbdNl7aGeDaHJ1sSyzRhKgdAACTZ1Ph/4bGEA2j6?=
 =?us-ascii?Q?9ojVIWmJp4g1IN8iq2X76bvnYKtDNO3PcCuic3Tqhih6p0UQOwZGFmvKBWty?=
 =?us-ascii?Q?VBNHkS7me1oxjxydT4vGnDw2/TsUzyTq69h/P8QkmHlv5eBvTpJzCrtCfL/a?=
 =?us-ascii?Q?BJUvL7oTy2LQuJ58VNw88lbkZWiX38Tn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:48.8988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a961cee6-ba29-44bc-2bee-08dccd30636c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

Provide the interface to list the assignment states of all the resctrl
groups in mbm_cntr_assign mode.

Example:
$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control

List follows the following format:

"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"

Format for specific type of groups:

- Default CTRL_MON group:
  "//<domain_id>=<flags>"

- Non-default CTRL_MON group:
  "<CTRL_MON group>//<domain_id>=<flags>"

- Child MON group of default CTRL_MON group:
  "/<MON group>/<domain_id>=<flags>"

- Child MON group of non-default CTRL_MON group:
  "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"

Flags can be one of the following:
t  MBM total event is enabled
l  MBM local event is enabled
tl Both total and local MBM events are enabled
_  None of the MBM events are enabled

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Renamed the interface name from 'mbm_control' to 'mbm_assign_control'
    to match 'mbm_assign_mode'.
    Removed Arch references from FS code.
    Added rdt_last_cmd_clear() before the command processing.
    Added rdtgroup_mutex before all the calls.
    Removed references of ABMC from FS code.

v6: The domain specific assignment can be determined looking at mbm_cntr_map.
    Removed rdtgroup_abmc_dom_cfg() and rdtgroup_abmc_dom_state().
    Removed the switch statement for the domain_state detection.
    Determined the flags incremently.
    Removed special handling of default group while printing..

v5: Replaced "assignment flags" with "flags".
    Changes related to mon structure.
    Changes related renaming the interface from mbm_assign_control to
    mbm_control.

v4: Added functionality to query domain specific assigment in.
    rdtgroup_abmc_dom_state().

v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     | 44 +++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 68 ++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 743c0b64a330..a72cb3a6b07a 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -308,6 +308,50 @@ with the following files:
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment.
 
+"mbm_assign_control":
+	Reports the resctrl group and monitor status of each group.
+
+	List follows the following format:
+		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
+
+	Format for specific type of groups:
+
+	* Default CTRL_MON group:
+		"//<domain_id>=<flags>"
+
+	* Non-default CTRL_MON group:
+		"<CTRL_MON group>//<domain_id>=<flags>"
+
+	* Child MON group of default CTRL_MON group:
+		"/<MON group>/<domain_id>=<flags>"
+
+	* Child MON group of non-default CTRL_MON group:
+		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
+
+	Flags can be one of the following:
+	::
+
+	 t  MBM total event is assigned.
+	 l  MBM local event is assigned.
+	 tl Both total and local MBM events are assigned.
+	 _  None of the MBM events are assigned.
+
+	Examples:
+	::
+
+	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
+	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
+	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
+
+	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	 non_default_ctrl_mon_grp//0=tl;1=tl;
+	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	 //0=tl;1=tl;
+	 /child_default_mon_grp/0=tl;1=tl;
+
+	 There are four resctrl groups. All the groups have total and local MBM events
+	 assigned on domain 0 and 1.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 314c0b297470..74db63402482 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1262,6 +1262,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 			hw_res->mbm_cntr_assign_enabled = true;
+			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0b1490d71e77..ffa0ed98efbe 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -985,6 +985,68 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
+				       struct rdt_mon_domain *d, char *str)
+{
+	char *tmp = str;
+
+	/* Query the total and local event flags for the domain */
+	if (resctrl_mbm_event_assigned(rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID))
+		*tmp++ = 't';
+
+	if (resctrl_mbm_event_assigned(rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID))
+		*tmp++ = 'l';
+
+	if (tmp == str)
+		*tmp++ = '_';
+
+	*tmp = '\0';
+	return str;
+}
+
+static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
+					    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_mon_domain *dom;
+	struct rdtgroup *rdtg;
+	char str[10];
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		mutex_unlock(&rdtgroup_mutex);
+		return -EINVAL;
+	}
+
+	rdt_last_cmd_clear();
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		seq_printf(s, "%s//", rdtg->kn->name);
+
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
+			seq_printf(s, "%d=%s;", dom->hdr.id,
+				   rdtgroup_mon_state_to_str(rdtg, dom, str));
+		seq_putc(s, '\n');
+
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
+
+			list_for_each_entry(dom, &r->mon_domains, hdr.list)
+				seq_printf(s, "%d=%s;", dom->hdr.id,
+					   rdtgroup_mon_state_to_str(crg, dom, str));
+			seq_putc(s, '\n');
+		}
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2251,6 +2313,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_num_mbm_cntrs_show,
 	},
+	{
+		.name		= "mbm_assign_control",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_control_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


