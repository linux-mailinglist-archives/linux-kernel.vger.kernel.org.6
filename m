Return-Path: <linux-kernel+bounces-277004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A6949AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8491F2203D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C917335C;
	Tue,  6 Aug 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJT7+M2D"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2F173357;
	Tue,  6 Aug 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981833; cv=fail; b=mCMgZolV0/aiygtTAC9KmHmtKEoWDQLtK6adhFpYYqmuT0ZsJXrBYRLl5gqMDSSiCt+PDARBT2KXuLKGwppNPkWOKa4h6PR8MMGFSzbq5jwF9G89e1BnYWQKcReGeOQRltZ3fQ2GQsh+Gv2VxYbsAggIo8li300rNfXKpwNQjdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981833; c=relaxed/simple;
	bh=B/dmYuK9vUPp1Ou+XfvZLk2fTttWQEHcsPO2W2K24wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWzEfvwXN0aXKrmJ3w43lbzBDIwoUk2E9XUuzmSIDPlptJbTbswSsVgRFNB1HvqNRP4dwIq7PC60//AGG6l3cyOJRCAbUe+dgkGU5bGJRU9NZDxv3BA0cmeqd2ZHfHLadIpqlT6HHPXcghi9wbOBecJBq1B01SO65KgFnLf8d/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJT7+M2D; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNdpukIExEq3LeDnpJmqGjT42GRxsT0x1hKkgfPTRsMc89lgiAuj44sKdPKT6LvYaU98LTQ2rGjybeWJ+bNzsrBxg1yNPvuAt1bU3qLKAodaoXfWxIVr3EByO2hVa/O1H5dkbAryUvfFPnK6ftIV8uLWx6unhF94ADFdYrmEjMEWV7iwg2uAHcz9/yZH2yOeH44Fhw8NE/E/A4iTrsVdp6urttZJqYk9zI+W6+Xd+TNnxtR4DUu/lmQeQlpeKFsRXS/zg3nFY/8bol5ciYfWxb48LBPcG2LxSq5KxkrlFi+SxD0+DPs1iYS1mKJFHgOsnYJpZBqUVd9HYuGPDV2dsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMDKInZaoV3fLVyH3mxFmd5P67T+yiouA/+vv8Rmlpc=;
 b=ptUoo3vW1rXd+If6FJVPqldPPVanbmrVwVdzUfjEyYy0Qr4F8qw+GNDVwGf9cWo1DH7WynZf3vracjp3/e0jhv/acHdHyngCs8ApafTVnh6eGB+3qTzz3Hdc6BAyM1SMcfbIZPBPG1hD/HNuSPlIULJtbCDdZDjKI3dxxLd4C5PiKBaiwpTyPD8GNzeV4xPrHPRA3nN8MDkytqhnhRp5Om6mchH2l4qboZUfPtOX+vfKMj1p5QvZ9aIaXyLsv5yH85IYiBB/hfv7CHquRndRMzZfWjtfjpiFzpTY5HNGONUYKpJA+tIM8PiaTXzcFpyU1k87UwJsX9Ayb0vQUmlqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMDKInZaoV3fLVyH3mxFmd5P67T+yiouA/+vv8Rmlpc=;
 b=HJT7+M2DnQpS/285At0VPStcGCbiAAjXSJLIvenSbNxx0SKOa5O4WORtV1SxD7pKltQI5PxTX+gjOWVPOHN925sxEq3xf7NyEWMop25qcINY3Gff6HqWDhUtuFoMG1y90tEuf0uTnQTSv550BpBkaKg0qFwUmQSTC2R/V8ZASis=
Received: from PH8PR22CA0013.namprd22.prod.outlook.com (2603:10b6:510:2d1::11)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 22:03:48 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::c7) by PH8PR22CA0013.outlook.office365.com
 (2603:10b6:510:2d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:44 -0500
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
Subject: [PATCH v6 21/22] x86/resctrl: Introduce interface to list monitor states of all the groups
Date: Tue, 6 Aug 2024 17:00:58 -0500
Message-ID: <821b725e9f00b4d423cc28d777d66d5681e1ba29.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ffd8ad-5c22-4e3f-7c21-08dcb663a5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7VTM77KP+PJKdbM5X98wNEGy6yO60c5ZMyweOW0DK5yJzGZBqt8saTK9Wyv9?=
 =?us-ascii?Q?I7SrbamTwbq2W1RH5wdazyu1PUiUM4tOOjvva60Lm1stAbBURazkOPyv8xnw?=
 =?us-ascii?Q?3or3c/20D2L6yYn07mnxTBjRSdzqXKxM9gAMJA8gW2rNRoyaSpzCltNdNq8c?=
 =?us-ascii?Q?7EZ8L/bINMybdDlzpnkWdHxkGrDu3U0k8c7wHEbnbzQzg3p7x5JdML3B9xv3?=
 =?us-ascii?Q?VO6H6u10YQldyC831r3ia3NDcIYKq/hHL+palFc5pqMXBPGZaQ3UR5OVndsh?=
 =?us-ascii?Q?6EIfqbMH1tfB1CtYQCmrHuUo/Zu3VSYoUodAJiIVl3+YJ/AwAA+9ZbfXi78r?=
 =?us-ascii?Q?07LPVCUD9rA+a7cpdWCa/peHJkuW7lFD8wmsUuWtFoLIfwEZDO0D/fMLhtm6?=
 =?us-ascii?Q?r7WrHpW1altx7K2kB9hPZCV9CVQso1l37zsU7NbxkggFFvu+LxWaObHDwwX6?=
 =?us-ascii?Q?qcEGdHyCUm3oNxNuMIDPr7ejK23LLMv8tusgT83b2A8vhGZopmwzFjGjFzRJ?=
 =?us-ascii?Q?l2BvQViJUXiYF9jFsylhqFpNxd2IhE8q7Fj0GtL5AMkBdUllRBZG5HNMDDAZ?=
 =?us-ascii?Q?+VnKbbtZ+TnKj0SQUMZQfo5BSpIZlE5dxgnE38+nDs/Hki8ThS+UhANWFpIA?=
 =?us-ascii?Q?upx0Zz0Mj26YG9SNd8/ZYNS1W9iFy+opAB45FBIhZ3fIvU9rWLdtmz4XDnIU?=
 =?us-ascii?Q?ICxwV1F0lrBf3j3xAiV2SpiOu7K9H/ggVyjsyOdkznjrR9oWoNskpI/A9623?=
 =?us-ascii?Q?YfGcyteBgBpeptVSPsMdf1XLWfigOtRQ5D5fta8kNfMc+/J9nNXCzsO+pnPS?=
 =?us-ascii?Q?R6AhbhxI0EbRg5f5zlT561tdT3U0NPnn4ovFqP/iXE290J0QLRVzjZKDr5kv?=
 =?us-ascii?Q?Ce1xESKE2Rkoi6M9tiLc3QQIw/4xTp07KdYt8E+Wi+xldFqj/rG5l+U8jmiq?=
 =?us-ascii?Q?w346XCWDlvbSbQdjE+IQr79PsV7VMLrO1TBg/8cqv99DSmDUWvUHT1HXCtC4?=
 =?us-ascii?Q?Dii8M/Ns1jucR8vON++SxFMtCQoZjjvHtgX2YetC+thqNEEav8xWIBD7JvE6?=
 =?us-ascii?Q?L5beonvNiOAo2xdEEF2LD4rbfY0idpSQrsHizS46nyGIz8NKVi7CdVFxSq/f?=
 =?us-ascii?Q?HvXn1oPpX482yK9DLbQ2IB48+vMF7LUPYuOjrxAqIBjgqntj6bCgA0ViVMMX?=
 =?us-ascii?Q?G0AeycShD3+j3DHmVVz34+VPAwUH2wmR45A+ZQlP4Aj/b9i9XwZ447EAdvnB?=
 =?us-ascii?Q?/wGmBiuG6hRxBybIkhImgrEZ2wUktC6Xeg966ut0u0s6zDrYKa6KK6YWZE46?=
 =?us-ascii?Q?H4y1uCwXfXDJTha+CCo7lUp4Hnn7OkwMQCGsBdkxfmOssKSZYuILEXNKzAX/?=
 =?us-ascii?Q?S/GVO7tRpuVX1brXzfUZeuQ3Xdb8N3MiJ7P3Cy6IvXRrrahcPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:47.9921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ffd8ad-5c22-4e3f-7c21-08dcb663a5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

Provide the interface to list the monitor states of all the resctrl
groups in ABMC mode.

Example:
$cat /sys/fs/resctrl/info/L3_MON/mbm_control

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
 Documentation/arch/x86/resctrl.rst     | 45 ++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 75 ++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d6d6a8276401..113c22ba6db3 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -320,6 +320,51 @@ with the following files:
 	the counter is not assigned to the event when read. Users need to assign a
 	counter manually to read the events.
 
+"mbm_control":
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
+	 t  MBM total event is enabled.
+	 l  MBM local event is enabled.
+	 tl Both total and local MBM events are enabled.
+	 _  None of the MBM events are enabled.
+
+	Examples:
+	::
+
+	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
+	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
+	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
+
+	 # cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	 non_default_ctrl_mon_grp//0=tl;1=tl;
+	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	 //0=tl;1=tl;
+	 /child_default_mon_grp/0=tl;1=tl;
+
+	 There are four resctrl groups. All the groups have total and local MBM events
+	 enabled on domain 0 and 1.
+
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2f4d0c12b80d..87537abedb01 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1244,6 +1244,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 				r->mon.num_mbm_cntrs = 64;
 
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d15fd1bde5f4..d7aadca5e4ab 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -965,6 +965,75 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
+				       struct rdt_mon_domain *d, char *str)
+{
+	char *tmp = str;
+	int index;
+
+	/*
+	 * Query the monitor state for the domain.
+	 * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+	 * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+	 */
+	index = mon_event_config_index_get(QOS_L3_MBM_TOTAL_EVENT_ID);
+	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET &&
+	    test_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map))
+		*tmp++ = 't';
+
+	index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
+	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET &&
+	    test_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map))
+		*tmp++ = 'l';
+
+	if (tmp == str)
+		*tmp++ = '_';
+
+	*tmp = '\0';
+	return str;
+}
+
+static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
+				     struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_mon_domain *dom;
+	struct rdtgroup *rdtg;
+	char str[10];
+
+	if (!hw_res->mbm_cntr_assign_enabled) {
+		rdt_last_cmd_puts("ABMC feature is not enabled\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&rdtgroup_mutex);
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
@@ -2206,6 +2275,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_num_mbm_cntrs_show,
 	},
+	{
+		.name		= "mbm_control",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_control_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


