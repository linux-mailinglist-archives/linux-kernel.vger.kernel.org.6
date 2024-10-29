Return-Path: <linux-kernel+bounces-387853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6219B56E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55191B23089
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FB20C033;
	Tue, 29 Oct 2024 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6NHf4rP"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBF209675;
	Tue, 29 Oct 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244369; cv=fail; b=A+uwaWJeMqDHhk2+th1RB6sAYvd0Lgpwz9w9gVwn2BTgp17CfMQ3X8OMWhPCSXbWSjub9s4XuCBf2UAsKiXTWX+NY5Po9kPrY9oi+AjgCvui/hBQme7CmDRNYP8uhdRXI1srKGTmAfRHdXYZeQfWkSegvG0WmX/tJdUQh7gJrVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244369; c=relaxed/simple;
	bh=yLx6B6k2fHyxymF9e0pZjYwlNSpiMUw0E980tmcKa+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfEKvR2aVXAjDXS498qoifdNgMZqjx41uJmjDi/Jit3yf9wX7Dj+HzSXnHriGV/UM+ZPVqke2Q6qyp4KHXjVkEM3uD7aMSvcWAH2LJqss3kdIIYQG6NuQ+DE9tZkClkXG73L1d7hBHF72lnU6yw/boPMXm3eQvPzQkwQAmB/W1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6NHf4rP; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtbtYRMXCdGPpD2jRkmKrrhHPs5tyuziTXnmMZlccn/Vzc6N/FuiObevNx9hf/0DPD1gO0bx5H0YvgA7BGR3JGrzXSdZWBtakH73cwQnC5t7kEaN6RGjRarAmd0vR/kVZ2bZMeBaJfYjyJ6l6PBU0E4UzWYqNvp8a6VTZ6dKOyAdGxwmf0jnJ0VBPoc0y7YUmID6IlvTbeXD3meMHAmLkNTBUJkJ8xSc6hE7cgdoNyINHdq/AhGWj0fzTeJdIqYcdsCkKm4J0t6v0ymtyfdZ+Db633MvycWKRuYyWb7cAfLYlbPWqF2YGtMEWVJ+/wmGVr+Ok+vCVx+f2Rn19ZAXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G5v+CjQIes4JHsUBsG7YnY1gP+3LSliecmbYfy/JFQ=;
 b=qKIgtl32wLz5ECVumk39vklj1fq/6B417av/1PtqSkUfBwyKheLLCiDdB5H6gw5a0Uk9vA9RXK1BbGa3/HolRNpRd02LG/D/fT84bWV9j/mXF4RXnk2e5rbeyPlUZLguRkbVhEXYfI3Kgud2oxjV1dEur5C8OtX4+/wheR9Fg4yOPzGLNJyl4KD3rUoFgi5kOVpCOSgvLM4RtMhp0PBb3SWopUIDc/73fxiKs+kD27XjtLsFy/OEB+/jNpp3r97mZ+Ii/gy6DX33qJw7mft1zWU1W3+vIMm3hI5uBj+Cbth0yUwm/xKatKBFTdZnq2IlZfZ5OM75kMvlio52KboeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G5v+CjQIes4JHsUBsG7YnY1gP+3LSliecmbYfy/JFQ=;
 b=Q6NHf4rPd4C0BVLVG8s+cUhrfoTfReDchA5mZ9PgcYJQfGU2Az0VwIHgn4iYZVungkScHLK5Z/cMvlE3+5uzcExLrlIO4If32rCGcq8Lw+vrXH7M4/lSmMFjVT8YUBIWHbAagC2HRCF00YyfrTpzNQW5/KKzvnvz8JOjY2E+BbA=
Received: from SN7PR04CA0228.namprd04.prod.outlook.com (2603:10b6:806:127::23)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 23:26:03 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::71) by SN7PR04CA0228.outlook.office365.com
 (2603:10b6:806:127::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Tue, 29 Oct 2024 23:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:26:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:25:37 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 25/26] x86/resctrl: Introduce interface to list assignment states of all the groups
Date: Tue, 29 Oct 2024 18:21:57 -0500
Message-ID: <c81f814cfe653c9bbf3c8ed2665f097c3892928c.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: c064548c-3792-4c57-2e10-08dcf8710e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvvjFK7q6ZSNgt1BvgQrXv7OSD/wWTVBDLWvOkbmTYmh09BPSu5B4zMS6I2d?=
 =?us-ascii?Q?nDVnIiL/WLfWn+gifmtlYZ0soRfE68yzT9O66+b8Epw6j0KjWfMKw7iclxgx?=
 =?us-ascii?Q?iwgKM4rquCUHOG/cbIUdClbll26e006mqYkufglyeuMZmloK9tlFI4CPDMIq?=
 =?us-ascii?Q?cVBOQmqTcYZfCZH8aVyzwaOoipDfNIC0IHH5z6aifUEJ5ZpeGY3n2LZ47vAE?=
 =?us-ascii?Q?eo3wSwt6X7aehAt6Kp2HJ+1DJUgvddVb4NRQkRnd7P7dOTgZKpET2IyXvRbw?=
 =?us-ascii?Q?L6Zj2MStz7dMy3SNeD7Ql9lKUkpTRIX55hBLBrd36DsbWYm2ZYYDIcIH9csI?=
 =?us-ascii?Q?g2/FJDyvg5ee3mHy98RQseh5ddoU7/o6ybQJxoBZRW6VbjGpKtu6KtN+nvnG?=
 =?us-ascii?Q?IKLZWs4q/LToC0Wod0k18LE+n5a+P2POALshH7hmhZc9rBcRQUzA9y/mveP3?=
 =?us-ascii?Q?2RbEvHwTi+mG9opD2bgZSwgALRVk1Ig2Fj6ETUXc+KM4NDu+nfCeZOAkwjFk?=
 =?us-ascii?Q?4WWZveMWEBhG5tLRdwNkSgflwPndBsnFx5RAKtne8GFUFM/Pj+Q8nDgPwOPv?=
 =?us-ascii?Q?j9NLaesvnYnamrZyq/EoOybRBlQVOf/09z8EhWJUACrz6Ru+vDGhWxqP8S1d?=
 =?us-ascii?Q?x6oxGL7qGynQP8LsUKIhQx5dcVlN5Ui6uIpxCgoGzBPLnIY7ff65tFQ70wFQ?=
 =?us-ascii?Q?BGmu9mOGxfDe8ceMkmblwpEs8vly2X0ysN3jcG92GXTk1A7OpHHz9UhhTEKe?=
 =?us-ascii?Q?v4OsoiXBMFaf4LGyDi0zJCtRDMzhA7b7oMRzvCvJzWDFBBPxkxi4yp1wTxa+?=
 =?us-ascii?Q?21DP8NIQC7krQ64AeU5TA1UpSe0YDSLczZWvx79aMdWCNWJlSjdVeZ67Na+z?=
 =?us-ascii?Q?cGoYXcgRSzqTv64pJ7jJYaW/KaQHT2tTumO7CRhsRFuNGOLapYblcpBIwnmS?=
 =?us-ascii?Q?YcfNSi/pI3W+zQRPQpXDvnG8q1uUsEG/CKDBUKB3jWJAuUjVNv+kyOT/5Hsb?=
 =?us-ascii?Q?fMVDdDm/P7Fl/RIQggYb14E8ScfjEEPW4whOwjLYew7gZKekLiQ/ULFcdp1G?=
 =?us-ascii?Q?nPlgZXxJFSBXrB38SywKkBRNSvlttKvCSdGqPgBh0SgEO60KFIzPUnZHbFPb?=
 =?us-ascii?Q?qD72HXA6guWbBIU0kOeGtV2Xv6OLZBNCbit0Bh+WYycedIsP3fepRFdmUIMY?=
 =?us-ascii?Q?3IIKEHNmJMew6nsfre997pocm7evBB/mxqUqbMhqYwBf/Y6CAEEE2MFPHbUL?=
 =?us-ascii?Q?3Ve/O3rZUGXtwSEv1DfQ8f16thRNWi4DKP0NUEls8C5MP1APdFHY8DiuVTYQ?=
 =?us-ascii?Q?eA6Lsu/speGcKPaqalgD+TnZdxZhfofrpxx8GdfzT/D9JRtV31tRVvAcO9lG?=
 =?us-ascii?Q?6UTgybVt74oAS9y6OE874XmOU6bgEiyYRKQQi6Fmyxhbt0u68w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:26:03.8572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c064548c-3792-4c57-2e10-08dcf8710e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

Provide the interface to list the assignment states of all the resctrl
groups in mbm_cntr_assign mode.

Example:
$ mount -t resctrl resctrl /sys/fs/resctrl/
$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
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
t  MBM total event is assigned
l  MBM local event is assigned
tl Both total and local MBM events are assigned
_  None of the MBM events are assigned

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Minor parameter update in resctrl_mbm_event_assigned().

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 77 ++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 1b39866e8b04..590727bec44b 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -321,6 +321,50 @@ with the following files:
 	The number of free monitoring counters available assignment in each domain
 	when the architecture supports mbm_cntr_assign mode.
 
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
+	 tl Both MBM total and local events are assigned.
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
index 4ba5007fd1aa..fc0e4ea480cd 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1270,6 +1270,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			hw_res->mbm_cntr_assign_enabled = true;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7646d67ea10e..5cc40eacbe85 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1011,6 +1011,77 @@ static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
+				       struct rdt_mon_domain *d,
+				       enum resctrl_event_id evtid)
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
@@ -2310,6 +2381,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assign_control",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_control_show,
+	},
 	{
 		.name		= "mbm_assign_mode",
 		.mode		= 0644,
-- 
2.34.1


