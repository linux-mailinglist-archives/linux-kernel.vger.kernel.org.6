Return-Path: <linux-kernel+bounces-357638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC29973A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692981F267D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9051E908C;
	Wed,  9 Oct 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CRwQl8VY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441F1E1C16;
	Wed,  9 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495803; cv=fail; b=dWzESnJB6m5PC+ncROjxXIz9KOiUiuXiL31VlPyXXpgNSa7QzR1CiAF3Y9Kp4DgHoVGfHeD8OvmYcyZHAkWFFs482YO8Pzrfz1jNPRvkJR68b/GgqtBDbErswtaCT/FcxDVuDd4+RN+uAIeUL+lf0N13aBH+15iYdMG3934ujR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495803; c=relaxed/simple;
	bh=rYE4pqPKTxNWOiKpzB6HIH+2jMXh+jp2wukpmRbkobg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg0yWQKO2AsS4f6tK6eeXKX4ISI0SWWTkjt3MU/YTVnToa7OHEmMJPAUgtbXoRS6jtr2Smv2wpx5qIPdG95m+UAckc0e2h43bE1A+slZAzl/VgVG0tAykzjPPAa0WbPXNgPMI3ftnMjMQv8U4ZzIIWj34k434p7Ra/+Q7Vigzy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CRwQl8VY; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+lJ3/QaBmTpsdtIAZpAw5wp5hpfNnkUJexhp5YPT6KBu6xTioWdIHJyoHJ8KceOKhhNQva1yRjAGRLJr+fz6tgh9qrTfbVuFU1smZVXLE6wjI+6sZQgIaE0RgiBj6tOiNQrtiW7gMebgTs7sdWy78kuRl6R86XfZX/l308yBZhA9LHo+KXOjnB+0sFUwU20WiBEoSR2cYkmHVVombo6KZjk7+8Cx36VNSO1hIdbGzeDxVHoEHfP5ywufrxxx1z8rqvVPi2+J9Ic3l9nEgKjl9idlHVnC8Aqi4Yl5G6/LK4D8BRIuiAjYqyw8VFKJM5H3TiC5ULuUgX1AFkTnwqfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8dDnVu9ddF9jZWljiKZs//miZaaUmUR3ORebllxJbY=;
 b=aeR5HT3QVnYTatpgpNZfjyTCsW5AtNlflGDPueGr3txtFytgjiDlzaZMhBwfO4KMYGg4Q0beQL8RXf46bH2WJGpjIEeSazPxCrd/j3CyjBc8QUOx0WaVWoN+IbB3hxCUVCWXPJNV+bgsuwR8ZcFSj0IiqffF327Hwh4Vd0WZrlqF/kCuNxuuCasdVxEdoqLaATRePB1rLNHIGWtwGfCKUHybetfQd0NDZhpzbBG9jQhfq0lQkh5kjdomKJYsEwR2mGgc85wBVUSks3QnHVOCE95MRXbXQHqFOWAcyrr0GxeIAvrURZ5L6PbKSs9hKjPlmd7KnnAz5iANbwFuJnK+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8dDnVu9ddF9jZWljiKZs//miZaaUmUR3ORebllxJbY=;
 b=CRwQl8VYtnNtnpU3goCXTfvGk3S0vDiR1o6CpVgsmyMDOdWfUxoPVqcLuCHsXNc7RLRW8T+VAXbPKgaTvb7JOiL8KyzimdQwZhoqPWQ3nlNkWAw21Z2URdtPrzSJY88ewY1c0Xarsj/fRAtqjf21lHPQ9CxjPxPL2V0TYXBu2XA=
Received: from PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::22)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 17:43:16 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::58) by PH7P221CA0005.outlook.office365.com
 (2603:10b6:510:32a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 17:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:43:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:43:13 -0500
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
Subject: [PATCH v8 24/25] x86/resctrl: Introduce interface to list assignment states of all the groups
Date: Wed, 9 Oct 2024 12:39:49 -0500
Message-ID: <a7a62f49523aabba1afdeb469c8df393e182acd8.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 312dcf3d-8abf-47e7-9f7f-08dce889da72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnmR4uYHaLDSwWPyFhQe2DtxkHU69GXejebZrN6wyFq/b59Wr4JCb0SfV8iX?=
 =?us-ascii?Q?TDYvzs2vBd22DoLJsiZ1lkdJtr75EiDvzUul7Ia+GfK3J9gECdDGoPsaIMWz?=
 =?us-ascii?Q?f4s4ojZMAIIyabWHNy5xjAAeTnpSqTqEO9Gq85MtwsaPJ8Vb9ZwuaZbyURGS?=
 =?us-ascii?Q?bShsV0peTabTATTvvDReXPb56t0Qg+uH06YfVuwkHq+AgbPVeyEGLMYXSmC4?=
 =?us-ascii?Q?f7L3WP5m0bB3hCiIfiS7rhEa02FL3TO1cuQ1FbmbsRudJ2qcy9CcjIL3hoM7?=
 =?us-ascii?Q?lATrk82MEgEzwSw9ue/B3+SXEPdn7MsppQr6bbRgRm0VKi0cJ1Ujjch5wwbC?=
 =?us-ascii?Q?VGKiDyon+QtOGc73UkSfktL/yUeid3v+atSnZi9BKT37JARjvMPFpdBHmVwJ?=
 =?us-ascii?Q?cQfFYKXmLeoTYQT/XE/Mhl+I9COvGtfVfNKocoQTOXj5EBiNNnxtTyTFrcH4?=
 =?us-ascii?Q?k1WSamPD6p/cvg6Lw4mEAJs/VSFraFlTF/cuzp32sGdyCsnFZdu1+0ZOcePh?=
 =?us-ascii?Q?cFsDfHVGlPkOTnQYbDLfLwOs9Tocs1/168oeAVrQ5voXmGlIJYG5zoJJVbbZ?=
 =?us-ascii?Q?o390gj3hkmIYEHDW9X5vd8cWQWlh4jJWCIcOB5Xho+SA18Rk0Pfb03CQMM00?=
 =?us-ascii?Q?Wk4uWjiXyH9pJMbRPGTukNlyJr9gUSlnX8kt/Ic6bQiOF9mbVZJaFPhEGsev?=
 =?us-ascii?Q?Ep18Is+lHutSl0z1XNmg4asDnQl1uZGfKX0irJK/mb9mY3X06M9bO1LuWPYY?=
 =?us-ascii?Q?b+FClKzgHKQVWsUHpfP7rbpU9F8xpjvS7uZsiooASta3bCiPpsiO5f3lKmGb?=
 =?us-ascii?Q?JLFPVrmSu/9HBmd5iKzoL5zOTDq+PFHdOCpR5TLupX1YC6pJ6hk1U3DGoSJI?=
 =?us-ascii?Q?ILOkW9XU2Iq/vqE5HdtjUYOg/9qp2ld+tsf8z8+N/vy7ZIq2DRIfUYlqHRUm?=
 =?us-ascii?Q?PmzPJ9MW543Cr4mMOgeOYbjPTe+dSztCdAcIShaQ1GbAqzej8bXTtNV62xg/?=
 =?us-ascii?Q?IAt8DknH2AhBMaCGwwOGm9eCc4eUvss7liQj6zdialuoyBteurNFMxmM8FJW?=
 =?us-ascii?Q?y6MVrnKQCWnR0+WZU+gD3Qbn01UUo4TC2Hx3YRBwLWhnXAxpl5Rog2m9C9Dw?=
 =?us-ascii?Q?/ZO69jeFNC2ECu0Yp2GJXyDwR+KCzQwgbeR0zDGRXuGr//t/WpC5o7jTYu9+?=
 =?us-ascii?Q?NqshfjgDfVo/GauJjGET6NNgf4tO0AZsx+SfkCZmDSV6qObSM+z8HSl680a1?=
 =?us-ascii?Q?LCy+Nvh8SLtVuFgoDqBJN41+scKfgMa9dn7kWtQt7np0/Yj2KVJTad6qkHCd?=
 =?us-ascii?Q?6KV4GZOvWWNiwd51t7euPnI72WDgvsTd+HOKEhFkKcyFN3+E1KKBjTmwnghE?=
 =?us-ascii?Q?nSSIejDFmzwYnyhcXYfMtVXhhDsP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:43:15.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312dcf3d-8abf-47e7-9f7f-08dce889da72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

Provide the interface to list the assignment states of all the resctrl
groups in mbm_cntr_assign mode.

Example:
$mount -t resctrl resctrl /sys/fs/resctrl/
$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=tl;1=tl;

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
v8: Moved resctrl_mbm_event_assigned() in here as it is first used here.
    Moved rdt_last_cmd_clear() before making any call.
    Updated the commit log.
    Corrected the doc format.

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
 Documentation/arch/x86/resctrl.rst     | 44 +++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 ++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d9574078f735..b85d3bc3e301 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -310,6 +310,50 @@ with the following files:
 	The number of monitoring counters available for assignment when the
 	architecture supports mbm_cntr_assign mode.
 
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
+	There are four resctrl groups. All the groups have total and local MBM events
+	assigned on domain 0 and 1.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 395d99984893..fa7c77935080 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1269,6 +1269,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 			hw_res->mbm_cntr_assign_enabled = true;
+			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cf2e0ad0e4f4..cf92ceb0f05e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -970,6 +970,76 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
+				       struct rdt_mon_domain *d, u32 evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtg->mon.cntr_id[index];
+
+	return cntr_id != MON_CNTR_UNSET && test_bit(cntr_id, d->mbm_cntr_map);
+}
+
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
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		mutex_unlock(&rdtgroup_mutex);
+		return -EINVAL;
+	}
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
@@ -2256,6 +2326,12 @@ static struct rftype res_common_files[] = {
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


