Return-Path: <linux-kernel+bounces-316048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF596CA5C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A381C222EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DEA18453F;
	Wed,  4 Sep 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JZQ/E9wc"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849A188A17;
	Wed,  4 Sep 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488664; cv=fail; b=acXPRlyfBtnndq9nU00n1Knifk0hzL23m65xIwngRpfbI5FtyrwI4Pc70d3HUg4mL+hCaj40oSeXBM7bJ5AKiMiv2xMq3rUxn3PN5A0yW2JAocwi/XmbT5FJywQ/AoxlntGQFjknV3ZY7QLxmnIxbi8tRuD1Wwfb9Fh44glYXoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488664; c=relaxed/simple;
	bh=OPYptgLCZI99qUYCW73TllBChzFnEN/6OHOlsssi8M8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS1fV14SnJSvImkJS3MVtESntmAOPpIxcUINv7l6x00jYmJBAAfehxUA7aVu7CjngR9NH6B3Kavb/H7eAdm9KoOZVbCkTqZX82WiU55HlknIq8SZrqXLZ7/7I0EHdkpW7kV4vZXEzMFa/9jPJdHg4rDXNffT1BmXSHIIEhdOhM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JZQ/E9wc; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhBkwT5StYy6hgarGj5YjwsTSh2HuF/IJ6+YFz2sSXZ7zI1nPdv4cRfETzYs/nviBN3Cx0wQtK6s662mzyJXMR8i5v+AdkY24wi5R5fZpKRbY79AjOC2aCKiCw7yx8BYxhy15kmVDAgsyLY0ZxmxSfbA7ZypjqAPm654kMIHD/aWiZD/QZDN+INsYRPRjZN9bnuAI9SjvO/TEIwg07HhGixpnGVlBD2pwl6wYb4anicJJ/fLflt4VqpBOZ70SQYCWfPPhQbCsd51MCUJxq+8Wdlo4ZroNbnRFKp7k6TGAgdU8dxP9g+5cTLu4XUmwzecotFUl1jwLn5Xj3v3gp2N8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7/MKhA27MIVpHGLXlmxoXh8t7d+zigXGP5N6X4Z2H0=;
 b=cnVPxr9PmO6T6DmE+Xzirz4nsx03R9wnKfyig5QhnCU+AvtsaY1fjbxqaxPdvdjgw0EQI7vT+2gDI8HBndUPMCEQVDqB7yLtXeQVUygk8xdcJxZrZUbQGZLI9JnJa6XcASVP1t0fT1Xt3ViwP/j0+pH6mL41iKhWGETzfLB67CO2gDAc/ltwirQFJrTJy4fYNXcbidI8VMf8CGNSomqbiscL/+8i/7I0yQn/Je3h1DbDe7RvM28FA2DZrYYMzU2hiFxrlxbU9PAQEqUj+wf//E0uJci2IrV34zP6F2Ag6mWIRPawt6XERqmuxpCvQiOn92yjPji38VB7DVGWDf4R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7/MKhA27MIVpHGLXlmxoXh8t7d+zigXGP5N6X4Z2H0=;
 b=JZQ/E9wcJrN7kP1asi5XovmUY6KKkoN2iIGnqiP4V775aBhTMqJ4D0iFRdxDZ1t+abOxc3lEUH0XQfN/VuZ7pkXjWUbtcPGWfSMKFLFW/p3sFw14rE+987rbf7Rke/K/a2In4YORMk2juusG0wA9mDEMXIlCvZ8Slea9X/HnB7E=
Received: from CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::12)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:24:18 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::d3) by CH0P223CA0024.outlook.office365.com
 (2603:10b6:610:116::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:16 -0500
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
Subject: [PATCH v7 19/24] x86/resctrl: Report "Unassigned" for MBM events in mbm_cntr_assign mode
Date: Wed, 4 Sep 2024 17:21:34 -0500
Message-ID: <1c5b054d8fbc3f7ad22c686d0d5e21e6573187bd.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf2e772-be7f-4e2d-c07b-08dccd305144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aFY9w6ZgS101+VevG9MAVlWDchBuzqhRzUImfuviFRBRNbigffzwaw0HhcNI?=
 =?us-ascii?Q?TjnRPxpl8BL3a+S4iQSnJTMeEMuPADmWkMXZcNNrP+QWVLroyLUplvc8DluY?=
 =?us-ascii?Q?dy1J9TtjfuL8+ECqgJrayJ01j77Uj0JK7BKE6ADv+yQi8pMHAcoVysnfXSOK?=
 =?us-ascii?Q?8jR87q8B7gYY+uH0UHfk8EwHcyvjW3kZxlylJFHywBj58jl6REKd11jL3xhI?=
 =?us-ascii?Q?bh9J4eRyfo6QGVNBKRsZyck51OoNKlN31U+YFzKsCRbzrI1FTQzdAbUIZM7I?=
 =?us-ascii?Q?zuoBbvVKeQnjTEizMYsTVgCibuQwXozTbqSTfrIeGe6SO26E7UCHEAT72jJ7?=
 =?us-ascii?Q?EujEzGgKL8fCvnkbObJRDxRxdACSTE+Z9iSy05BTYkif/lmg1QKTfOHTOt7h?=
 =?us-ascii?Q?OOmPdY7jzdovFdn0hWjIMCltTE2THoGFCpEkPx3XhPnulvxMR6VzxK3U5r1W?=
 =?us-ascii?Q?RU6Kt9xZEPpcsX4sUMV2yHeHHQVHgLHIuBFyQbS/BLqZd9lkwFXte6vjE/Ch?=
 =?us-ascii?Q?knel6WT5EEoLPtBZhsIpEiP+bo+Pswc7YmXOHt1H/xynOIbeo2XnW0vy3dD3?=
 =?us-ascii?Q?Crfhkd+1ZYEd5UOsS+wwnySUFC9qJtFpL70EibqtieTOVyjzNq/+MslJA7pf?=
 =?us-ascii?Q?Mj9Np7/fooCCxrzuHwy+YRd73AkU7YfDmbaXMzwC+17Ul4RFCswmJF05Si8Z?=
 =?us-ascii?Q?m6S4Ob08a3IMP1YlmyCT7xkB8UVRm8yZNelfQJvkX9g0QqGaYqpVK6ZSDOzf?=
 =?us-ascii?Q?1CVnFXMQv7XbyFurKdjIVwUiZj1wk+jcaZzoMb9ZdGlP6ikAJvjzse74bYqt?=
 =?us-ascii?Q?dVvs29ck5EZyLK78G1ZFqy2ePjOpVHrOprBHK82hV3PxgekTuZaHQbH6HN/H?=
 =?us-ascii?Q?/PHxACi/iGpRgEkdFwpl/AZtk50jWEFCZllwTG8XQN6dLeAzwv5IPHei2y56?=
 =?us-ascii?Q?mxB1QVHYcJNo1Hp63s9L9mepR89HUlghW+LkB2cV78WDWwbp1xofhLTpF9Bg?=
 =?us-ascii?Q?vlLvH+n55XW9PgtYYtg8ZbHg9FZTQvkjCOMye8JU5DZAUBqXKjLwgdKOqsLG?=
 =?us-ascii?Q?fr5vtywYyWKwcEI3z6c+RHaIYZs7FGUoODDAxpz72JgvIpr4ufeX7SidhL1T?=
 =?us-ascii?Q?Hl0y+DO7AEDtCsDEXb0Jev49sA+Aaw3AavAX03W3Pt5bBbBWJd470frxZIlx?=
 =?us-ascii?Q?Z+jA5CoZq1yVzpvKcE8e8rdNnhx/pTss/uqTkmhf/oq6n6SH64lftoE001Dk?=
 =?us-ascii?Q?6aDpDqYmlllr8mdxwjKVP3hcY+vpVHtVg6/lVI4MDOlPzEGXX2eHjU/4x8zb?=
 =?us-ascii?Q?6RjLwbn9wfx5/U/5mlgdIbXPcs9RakgLYFt2Fl8h6V3w/ecraxOG+Dxm/Iu1?=
 =?us-ascii?Q?eiH9HY8KZkD6w1NbJbUH74FbxoIrhqdKcamKPQNt2liKoiv3GIaYGszk0z4V?=
 =?us-ascii?Q?/qzn3cP04ygQli8aAmd3dF6YdsSTOe9O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:18.4571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf2e772-be7f-4e2d-c07b-08dccd305144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

In mbm_cntr_assign mode, the hardware counter should be assigned to read
the MBM events.

Report "Unassigned" in case the user attempts to read the events without
assigning the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Moved the documentation under "mon_data".
    Updated the text little bit.

v6: Added more explaination in the resctrl.rst
    Added checks to detect "Unassigned" before reading RMID.

v5: New patch.
---
 Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 3e9302971faf..ff5397d19704 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -417,6 +417,16 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	The mbm_cntr_assign mode allows users to assign a hardware counter
+	to an RMID-event pair, enabling bandwidth monitoring for as long
+	as the counter remains assigned. The hardware will continue tracking
+	the assigned RMID until the user manually unassigns it, ensuring
+	that counters are not reset during this period. With a limited number
+	of counters, the system may run out of assignable resources. In
+	mbm_cntr_assign mode, MBM event counters will return "Unassigned"
+	if the counter is not allocated to the event when read. Users must
+	manually assign a counter to read the events.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..fc19b1d131b2 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	int ret = 0;
+	int ret = 0, index;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 	r = &rdt_resources_all[resid].r_resctrl;
 
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
+		index = mon_event_config_index_get(evtid);
+		if (index != INVALID_CONFIG_INDEX &&
+		    rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
+			rr.err = -ENOENT;
+			goto checkresult;
+		}
+	}
+
 	if (md.u.sum) {
 		/*
 		 * This file requires summing across all domains that share
@@ -613,6 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
-- 
2.34.1


