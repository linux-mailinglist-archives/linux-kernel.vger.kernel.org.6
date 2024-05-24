Return-Path: <linux-kernel+bounces-188689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83B8CE55A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6505B2221D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786CC86659;
	Fri, 24 May 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hjuyV0VJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01638664D;
	Fri, 24 May 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553583; cv=fail; b=cru6XZLdVzu1W2f0FDAbURbhIWt7n4fyC2G0uRi4sxhcFJhnv9h1eAi5yaO/7NL3erfVsrrxCw/ZNTBjWAfij4Gh3+kvaC/MQ/IgogJdS3hTxb9QuZPlAx2zU+/+gD1dMqmgUN9ZuHbsfNZsb7V0Q+VB1PsbI/OXWUQmjgfFD+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553583; c=relaxed/simple;
	bh=NIuo2t10R81Z0vdLLx/rWLCciNKNETApVwqTZtaqJjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I38z+L5zjHUJvzvdZfRJBOXGD2ps5YalQP8HRAhKJT5Q/b5e/9V9omJ2Xkm/Wg7VIOegEAbtFMFMKoUmDtHO1u7YmXNzpW3w8MAOEGkKbv/r2BtIfSCfYOjTGEt8lO0El+SOBI7BgyCbRFS0u2/UwVACF4ewj1pRAq6aPHcS0qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hjuyV0VJ; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik45cFIdFrjMHyQ9+cwV33THmb9sBWQVqNCRFAjWBEXfmPxbLzeWLguRQt6/dT+3NoL7BDUq1kC78wYRvo3H2Iu8LkI0WNGIoV9OA8VvwevmP5S7CCqd7eJ0ML9bBTfWmI22zvLaW1XFqGyvhbH5vr3ROV6XjlATC2YMbUvQ5O9dKu2Yr9DuocupmTEX9mCHIRBfjOXBDrZwqF5oko0ySF1MDhCicAM66nqiPo2JrxYodcdR1mpF4VyX1Ncuh9XZFLuXLMlXZLbKyFyE3VoNNVYhooHoY4muYC+BHj3CQu2ht7NqRALXOdVb3JmvRKIjsdGNjTY7yk/DTI3rX3ieVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75d4X/jayAZX65xoy+5LSy6V+2FbhjHf7pNCHcDqhKk=;
 b=GfEqD8sXh+VXSqCsjLxq0un3Ies3rLgG2N23hGRnRtK6VO0cJIMTwX//prtU0+F3yw/mQcEyaz9EFnYGM3A5lEkbG+0dnjiboeqkS/uvUjWWljCemNEiEAamyV/BUyn5IM2AjL7cm+OrYpSDWi2/inEqUEBpvCr0XUnDklV8pH5OIZM62F6QPjYLJ0iffEfDGCj0Jm/hoNxfExiyWlnsAdcnJuxOQwL32WHqJH5K8vORPnOE8RT2cQeJ7MHcwt2OWhi+gPAMwDeY0QLHYwwqurvL81f7XR/l9MYRU5ali+48hgQUzACXN9R6cA3m1FGL4ND+0c2TLZ89QiCPwRbfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75d4X/jayAZX65xoy+5LSy6V+2FbhjHf7pNCHcDqhKk=;
 b=hjuyV0VJdFR/caPCMl9RsqHk8XCamxu2kTlw7MTABlcoeMm9C+dsatSvRl7fLYb4aRX+i/NHUuxRHK5LfOWiLfvlKlaEyi3HUZgyxWPY/O5WiHfwxtPMMCqwcyjkvgy4dl06N2qhqgofEVpF08FW1QW403b/4p3O4PE/9O4X3eI=
Received: from CH2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:610:4d::18)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:26:17 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::a6) by CH2PR19CA0008.outlook.office365.com
 (2603:10b6:610:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Fri, 24 May 2024 12:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:26:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:26:16 -0500
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
Subject: [PATCH v4 18/19] x86/resctrl: Introduce interface to list monitor states of all the groups
Date: Fri, 24 May 2024 07:23:37 -0500
Message-ID: <16999a5dc7e205fd1868b98f847a00460a05f40d.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: e69fff76-b7b9-4cbe-a8c1-08dc7becb613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/DRHmGxy1KoBWe69BF9kWLjzpAL+Z8g4c4wwc7AJsxkU9HDOLQlQb/You+NG?=
 =?us-ascii?Q?KaGNBGvxGN56VPEpfGrwUFx/JzG4RRt0v5Cq1SIFWkaUB5GW9KSgcgS7la76?=
 =?us-ascii?Q?ehgthEkM9RYZOBWwZzJCjq5j0o9/h8qtnnYDOnXVG5TfjG8QnPMjVD+wMyO7?=
 =?us-ascii?Q?2K/M4dyJKqEzzDBvI0YP2DYa+kdVjJXv4pHSJ6+gKRTUKgBTXfmHxYkS/tCq?=
 =?us-ascii?Q?OPW+PmuCbhfNK1LDFf1HkNenB2nwvM2zL/weqEHeskfzcWDCA66vEyOz5z79?=
 =?us-ascii?Q?k9iky2Iv0vSMkKKICuORnjEHpZh6bb42N28lWnI+qdtFUZ/7eNhhgAGUhETu?=
 =?us-ascii?Q?lMHgac+5ydn5rGJz93NBD8cYTVjeYQMDA/8vb+Oh4RCePe8fkvJraZCQF4yj?=
 =?us-ascii?Q?18bZZ49E2/ji992PdBqVqFC2n6+Ufv9OpEiQ9H3/bjYcJJIwr1k4QDjrWJN7?=
 =?us-ascii?Q?u0uQqOnFf2W1UcWpNzvXQOI+YH9KQEeqivinw9gtzf6Lor52U5+nK28XmTZ9?=
 =?us-ascii?Q?2XJT8LAEIko943iDEWfDVwZ/R9pB2l4v/coCcKEfGbLJAlwFFgjBTQqUfzXd?=
 =?us-ascii?Q?GRLN3RDFkd2MihDnAj+iTLZiPL7MAlzFoZo3B1deUHHM0NSvJ8orxoUn9WiC?=
 =?us-ascii?Q?gwgHfyR1JIjaZgFKc14vrKEohQIXMS0NbjyAw0pTFxrn1rC2v5dzDn24LGDA?=
 =?us-ascii?Q?vuvsMe9Y0kUE27iswK6IHhur9XQ1EVOdAFpxiFtWytrvpkgM469Kn3wHqJww?=
 =?us-ascii?Q?WA8JzuLIpYikhjBtImuwMQV6hQTpuUqnq6alUc98kdU4hqgTZAYQS00CEeja?=
 =?us-ascii?Q?9BL8Dcn/n8CLVAKebKNEmCmwEKWUf9M6F4VoGO7XShVkjqsnQ6+yfK5OBy07?=
 =?us-ascii?Q?GsPJdTXnRrJIZV4En3VkU97o+vwpbujZc3k3ig2/TRBOoxJXnznRoY175x0n?=
 =?us-ascii?Q?S8dbZ/sAAREoS6c1fkO2d2J+MLTUGteP/4OPcuYZgDuE0HqmJirY5gB0XQ+R?=
 =?us-ascii?Q?aYzlbRdFCNSzt0garQMNShIpYEXFJldShr5bD1htvFjV6PWQoinR1yrywFLf?=
 =?us-ascii?Q?4O6W5P+rim6p2nLTLqFIcAnpU8iw/E/46g6oD9UKokrjmTT1vY8eQrrorLCb?=
 =?us-ascii?Q?9TQz6eHUErzTke/u+lt4hUA1n1n+qkKmKoEIS56bksR7vlwn5PUHb21RQSrl?=
 =?us-ascii?Q?lHoUin1Ski1AUmlfqYUnjuid/U9KzJ7z2wtWJPshuKC2LK00ClCih2LGdqoI?=
 =?us-ascii?Q?1zcMo6/+d1TMWtyQx4kKcQIkmHJx7JrbGyGDeGKrx2vGkr6eKobWuUkuLVyY?=
 =?us-ascii?Q?Sug6f6mOydtgxznvYL3kq+4o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:26:17.6382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69fff76-b7b9-4cbe-a8c1-08dc7becb613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

Introduce the interface to list the monitor states of all the resctrl groups.

Example:
$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control

List follows the following format:

"<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"

Format for specific type of groups:

- Default CTRL_MON group:
  "//<domain_id>=<assignment_flags>"

- Non-default CTRL_MON group:
  "<CTRL_MON group>//<domain_id>=<assignment_flags>"

- Child MON group of default CTRL_MON group:
  "/<MON group>/<domain_id>=<assignment_flags>"

- Child MON group of non-default CTRL_MON group:
  "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"


Assignment flags can be one of the following:
t  MBM total event is enabled
l  MBM local event is enabled
tl Both total and local MBM events are enabled
_  None of the MBM events are enabled

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Added functionality to query domain specific assigment in.
    rdtgroup_abmc_dom_state().

v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     |  55 +++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |   1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 129 +++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index fd050d4d22cd..255087de568d 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -281,6 +281,61 @@ with the following files:
 
 	    # echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign
 
+"mbm_assign_control":
+	Available when ABMC features are supported.
+	Reports the resctrl group and monitor status of each group.
+
+	List follows the following format:
+		"<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
+
+	Format for specific type of grpups:
+
+	* Default CTRL_MON group:
+		"//<domain_id>=<assignment_flags>"
+
+	* Non-default CTRL_MON group:
+		"<CTRL_MON group>//<domain_id>=<assignment_flags>"
+
+	* Child MON group of default CTRL_MON group:
+		"/<MON group>/<domain_id>=<assignment_flags>"
+
+	* Child MON group of non-default CTRL_MON group:
+		"<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
+
+	Assignment flags can be one of the following:
+	::
+
+	 t  MBM total event is enabled
+	 l  MBM local event is enabled
+	 tl Both total and local MBM events are enabled
+	 _  None of the MBM events are enabled
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
+	 There are four resctrl groups. All the groups have total and local events are
+	 enabled on domain 0 and 1.
+
+	 non_default_ctrl_mon_grp// - This is a non default control mon group.
+
+	 non_default_ctrl_mon_grp/child_non_default_mon_grp/ - This is a child monitor
+	 group of the non default control mon group.
+
+	 // - This is a default control mon group.
+
+	 /child_default_mon_grp/ - This is a child monitor group of the default control
+	 mon group.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ab0f4bb49bd9..f4dba02db9c0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1083,6 +1083,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 				r->mon.num_cntrs = 64;
 			}
 			resctrl_file_fflags_init("num_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d77ff059269a..bd3a54405402 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -945,6 +945,129 @@ static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
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
+static int rdtgroup_abmc_dom_state(struct rdt_domain *d, u32 ctr_id, u32 rmid)
+{
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+
+	abmc_cfg.split.cfg_en = 0;
+	abmc_cfg.split.ctr_id = ctr_id;
+
+	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_dom_cfg,
+			      &abmc_cfg, 1);
+
+	if (abmc_cfg.split.ctr_en && abmc_cfg.split.bw_src == rmid)
+		return 0;
+	else
+		return -1;
+}
+
+static char *mon_state_to_str(struct rdtgroup *rdtgrp,
+			      struct rdt_domain *d, char *str)
+{
+	char *tmp = str;
+	int dom_state = ASSIGN_NONE;
+
+	/*
+	 * Query the monitor state for the domain.
+	 * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+	 * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+	 */
+	if (rdtgrp->mon.mon_state & ASSIGN_TOTAL)
+		if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.ctr_id[0], rdtgrp->mon.rmid))
+			dom_state |= ASSIGN_TOTAL;
+
+	if (rdtgrp->mon.mon_state & ASSIGN_LOCAL)
+		if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.ctr_id[1], rdtgrp->mon.rmid))
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
+static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
+					    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_domain *dom;
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
+		list_for_each_entry(dom, &r->domains, list)
+			seq_printf(s, "%d=%s;", dom->id,
+				   mon_state_to_str(rdtg, dom, str));
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
+			list_for_each_entry(dom, &r->domains, list)
+				seq_printf(s, "%d=%s;", dom->id,
+					   mon_state_to_str(crg, dom, str));
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
@@ -2143,6 +2266,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_num_cntrs_show,
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


