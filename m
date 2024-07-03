Return-Path: <linux-kernel+bounces-240268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F8926B00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56574281E68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3C194AE0;
	Wed,  3 Jul 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lk4OU/WD"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48354194AD7;
	Wed,  3 Jul 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043480; cv=fail; b=hJZgDL+Uwe7rtd8Iy8giI6jP4DTB21KRwfrtNyWzTMKqVs0NQfw+pKHaf/aHSjTQOhvkS7rvX82xkOhD+ew9iJ6OGCS1yb9afcv71UjbjYk3oXNhv4784c8M3yT1pqDkEmumy9U8TBvdfaYXTFwVQUW6ZYfuom7kd2AzA35GXko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043480; c=relaxed/simple;
	bh=Ao9rI6HmNjfmU+cDoY2K0GJLhfLJwncWR7yYMaW4DZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ValZQMmTmZynFyINA0AOG5//VfhqP06NzZ6mGTQoYJbEVK4ksakacq9YSJiBeunCoMEyh9ovXv1As7EzEMuT12aKqK4h7Y+cxuxXf86bkR/oxSAruptuyJXMt5VdWRi1UB5i4lQIWqMgxsBIw7SSRkIRpZ9JC68SFaGKLekU9ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lk4OU/WD; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTU1qEwGumSsCh1wIt7YzSqMQCyI/3p14PZrne/NW3H70rn0ewsdFdwr/h9F5aTV9fRt5t+z4NXNw73AIRp+MbiyleRYZ/aunGrMqR3NuEKbXjI8ezfSW4CVNu0cpwmFLCEWpxJ4y3H8pAG1EpRPWYzAeGI9NkPChDQ2gFC4aVHug4nkoTMp9NaBSk5eAZYZJeNgQKcnaTXrPsTwyEaihrnWnAl5uMv+w3UcmzuXtwGNH0s9b6HthxLh6ncUFMoJ1rwhmrGb5QOkkIoNoIgTuXRTxvHZZ1WtiCiZqbzJMhorbis+YXYpBiM+zgvh+dREAL5IgKI6Zvpd3gWiQYiD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYDJJCSfWvlSp0DbP2n02ZCGoHjQcL7La07xiVn8JK4=;
 b=Vf1hnE+ssF7C9LZCL4S4R7Vr5tHEF7uDx+HzMygczy0OIVoSFRy8AzK3rxuhc3xrrj/J1vYmCwi9kehHnX7DhfG5ek8IgKDXBPepqQUOIESUsNUNVM/iBCK7EOeDV5fTtOReAMz29mUlujH+vNZjT5NgAzZCUFzzjWD9LYSh8G9rAI6705xhLP1xGYQFM4pwqklJWAw2y6BbXdti5Ur2DdDqhE0pPcpmabRRU49FUq/q0sy8YGZIn0f6N3EeoNWS+FJ9HXJqO3vJdc24KlG+gPcWWQLtQ4rnoeYQxgCRTMKjSoIwwSeAVuwXzzQuuW9NNATgSBeJnvhzru0FWY540g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYDJJCSfWvlSp0DbP2n02ZCGoHjQcL7La07xiVn8JK4=;
 b=lk4OU/WDfi1Wx4wABcXU6HjilpZMdk2eDnuWLiOzrGCA1RoOY7unqlYM/17U79ZifAO4sU0+k9oIXCpfVEwxbwUBhpKpUeutySsa43zTFXx/WXTvJfNm7019BOXTsDJ9/2CJhC05rgRz+bgiWaajcmMlVuTnKNuQ23xe/Ochyxs=
Received: from DM6PR02CA0139.namprd02.prod.outlook.com (2603:10b6:5:332::6) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 21:51:15 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::c2) by DM6PR02CA0139.outlook.office365.com
 (2603:10b6:5:332::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Wed, 3 Jul 2024 21:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:51:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:51:13 -0500
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
Subject: [PATCH v5 19/20] x86/resctrl: Introduce interface to list monitor states of all the groups
Date: Wed, 3 Jul 2024 16:48:30 -0500
Message-ID: <3be66db2dbbe2d231fd5afbe6c7f092278b5a903.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f7f601-7bc0-4236-2437-08dc9baa4322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o7M0hAc4DAIwVAJ3v9xWY8iH0SRqr547vE+xoTBYfBlahsactXhuERwmU7wj?=
 =?us-ascii?Q?PFXW1oRAgCmMsWr+RnSSfDc+lgEhQ17OqTTPK2VACsj7wCsEI5ta6zFXHIRY?=
 =?us-ascii?Q?bUlTdEGSFGvn5pG3ySGCUuqNLypSNNSH8qBEFTUtxqcPIJXBnSjV8Vdnq9V1?=
 =?us-ascii?Q?Ai+A9HGl22CQeE72bDBoZzEuOEtf4wHseszgKA+XM3xnXTCFfYs6vOkvEILM?=
 =?us-ascii?Q?taf43Rqb2qvG3P042Um+3Z/pM00OHDz1DzoQKlplDcYZtUHALM6WL1nY4kJC?=
 =?us-ascii?Q?F1VyiV85VWUdZFBYjlUWPrYYv6U8NXzcbEizMiYCl2jRTCEVJND/f1qadqi7?=
 =?us-ascii?Q?tnLbx2ZkR/oo7Y7VErxd/DAcrCSLTXT3WijtVyvZI2aEY1lawCK29IuY5t7j?=
 =?us-ascii?Q?vAj8eNIN2F3Jf4aFurHzvGrGs9eWTOoRantXLR5/rX5cKrhFvn0O1yQQTprf?=
 =?us-ascii?Q?TKKevyLIepXbQayg3VlyqHCjllsVdF7OwDWVOCHSoRCBRU9GlQoP7YgiOe5v?=
 =?us-ascii?Q?+6KPsW78/LxO853GgSaHdt/wMbCuu61oquxX9taHvnouBQ5pk9SQLrWBX5CA?=
 =?us-ascii?Q?na0lcXFh250Ef3x21SsaoKZRWwGOXWFjDL4EtGv6ynq3FdxkMWgsMD8NKvNz?=
 =?us-ascii?Q?wN817Mhxy59NWUowhWSyJVhYe5Tohk8SpHdZXGZ79/cckbcdfaTRqVissCeF?=
 =?us-ascii?Q?wVI1Zvur0eEuAQwQrHUjP+nJFjEEqr+yQn3yfL9WjEtlby6OOUAK3unJvvPF?=
 =?us-ascii?Q?hXAqbzPbTftz7/F/aH1K3FFEvb9lcSGv4GswuV/3pu+0JOila+QzrYaPAEww?=
 =?us-ascii?Q?3SfGu9TP/C8pkW4MYuB0IWDXccSTd7TEqFPLpOB2iy64t7mcig2wjP+NwidK?=
 =?us-ascii?Q?sxZjv1sJsZw76cFtwBzE7g/yNgdzE0yGzVI9GZ3FXBh2cQaYMF7kSyn98kkY?=
 =?us-ascii?Q?vEJfPXC7lI8k/sQzBCyuMSMbGjHfj04cGQpMH4xvSYI7uD8r7wFcxy2jyzMJ?=
 =?us-ascii?Q?FldI+3L3HHppJ5wGOkKTznRpKsaIA3Dw1Ci+mBJFZD3ecDd7oXOqu/6A1qh1?=
 =?us-ascii?Q?khKpzZuh/EYuHGexVYeWPXczuOU2bzOz0y0aNvvmx7mNdo8bgBalrcQUYzPU?=
 =?us-ascii?Q?F3ug3ChvjF1T+ufyVtyu7JvDqFA3vSWAM9khIlHBwwpKfRj+O+uC7m4aeK3o?=
 =?us-ascii?Q?9kd8EkJ5VViuNTXFxDeLY//V0MP3FQ4gCjfsqMxJM0BsrULQxwusNBDNIg8U?=
 =?us-ascii?Q?Z5CcBX2zJkraa73g9kc8T/q6KIOa5C70u4HYZIDvShOIYjNg52L2A0AHd743?=
 =?us-ascii?Q?gWtjLF9TZ6aE8nb1ZeYyXEWpCx6qiVGKnbUws8IlohGhi0QFJt2gr7nNZ0g/?=
 =?us-ascii?Q?MI748aZ2IZH+p9RSOviP387QGJtRHPhjYyhAAXbyEQYyWlm9Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:51:15.1730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f7f601-7bc0-4236-2437-08dc9baa4322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782

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
 Documentation/arch/x86/resctrl.rst     |  54 ++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |   1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 130 +++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 4c41c5622627..05fee779e109 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -304,6 +304,60 @@ with the following files:
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment.
 
+"mbm_control":
+	Available when ABMC features are supported.
+	Reports the resctrl group and monitor status of each group.
+
+	List follows the following format:
+		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
+
+	Format for specific type of grpups:
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
+	 There are four resctrl groups. All the groups have total and local events are
+	 enabled on domain 0 and 1.
+
+	 non_default_ctrl_mon_grp// - This is a non-default CTRL_MON group.
+
+	 non_default_ctrl_mon_grp/child_non_default_mon_grp/ - This is a child monitor
+	 group of non-default CTRL_MON group.
+
+	 // - This is a default CTRL_MON group.
+
+	 /child_default_mon_grp/ - This is a child monitor group of default CTRL_MON group.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b96b0a8bd7d3..684730f1a72d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1244,6 +1244,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 				r->mon.num_mbm_cntrs = 64;
 
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d978668c8865..0de9f23d5389 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -944,6 +944,130 @@ static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void rdtgroup_abmc_dom_cfg(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+	rdmsrl(MSR_IA32_L3_QOS_ABMC_DSC, *msrval);
+}
+
+/*
+ * Writing the counter id with CfgEn=0 on L3_QOS_ABMC_CFG and reading
+ * L3_QOS_ABMC_DSC back will return configuration of the counter
+ * specified.
+ */
+static int rdtgroup_abmc_dom_state(struct rdt_mon_domain *d, u32 cntr_id,
+				   u32 rmid)
+{
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+
+	abmc_cfg.split.cfg_en = 0;
+	abmc_cfg.split.cntr_id = cntr_id;
+
+	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_dom_cfg,
+			      &abmc_cfg, 1);
+
+	if (abmc_cfg.split.cntr_en && abmc_cfg.split.bw_src == rmid)
+		return 0;
+	else
+		return -1;
+}
+
+static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
+				       struct rdt_mon_domain *d, char *str)
+{
+	char *tmp = str;
+	int dom_state = ASSIGN_NONE;
+
+	/*
+	 * Query the monitor state for the domain.
+	 * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+	 * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+	 */
+	if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
+		if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0], rdtgrp->mon.rmid))
+			dom_state |= ASSIGN_TOTAL;
+
+	if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
+		if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1], rdtgrp->mon.rmid))
+			dom_state |= ASSIGN_LOCAL;
+
+	switch (dom_state) {
+	case ASSIGN_NONE:
+		*tmp++ = '_';
+		break;
+	case (ASSIGN_TOTAL | ASSIGN_LOCAL):
+		*tmp++ = 't';
+		*tmp++ = 'l';
+		break;
+	case ASSIGN_TOTAL:
+		*tmp++ = 't';
+		break;
+	case ASSIGN_LOCAL:
+		*tmp++ = 'l';
+		break;
+	default:
+		break;
+	}
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
+	int grp_default = 0;
+	char str[10];
+
+	if (!hw_res->abmc_enabled) {
+		rdt_last_cmd_puts("ABMC feature is not enabled\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		if (rdtg == &rdtgroup_default) {
+			grp_default = 1;
+			seq_puts(s, "//");
+		} else {
+			grp_default = 0;
+			seq_printf(s, "%s//", rdtg->kn->name);
+		}
+
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
+			seq_printf(s, "%d=%s;", dom->hdr.id,
+				   rdtgroup_mon_state_to_str(rdtg, dom, str));
+		seq_putc(s, '\n');
+
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (grp_default)
+				seq_printf(s, "/%s/", crg->kn->name);
+			else
+				seq_printf(s, "%s/%s/", rdtg->kn->name,
+					   crg->kn->name);
+
+			list_for_each_entry(dom, &r->mon_domains, hdr.list)
+				seq_printf(s, "%d=%s;", dom->hdr.id,
+					   rdtgroup_mon_state_to_str(crg, dom, str));
+			seq_putc(s, '\n');
+		}
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2156,6 +2280,12 @@ static struct rftype res_common_files[] = {
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


