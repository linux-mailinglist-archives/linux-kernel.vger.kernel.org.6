Return-Path: <linux-kernel+bounces-443903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67A9EFD53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AC4188FFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370018C937;
	Thu, 12 Dec 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J9NfqU3F"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4911DD0D6;
	Thu, 12 Dec 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034755; cv=fail; b=EdcZhPnbVC+FY5Lkt+hzdAuIQEhXhKOsP84hdKP7oKLaYBSVJq4lay3ONaeeFZvSOakSLD4UZBGV/RrXhC23Mtj2Qnpo5mptdZIPBccoIdez3/6QHfCveTuD21fxuShCCh0DLmf3NnEgdr0XdMfzY4GHf9QMYP/5oTB4TFgq2mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034755; c=relaxed/simple;
	bh=V/bbCCgzwJ8jGELm3JlF+CBYVbOCeRm3GuzyznDCC1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJIQx6bMfcNej58AyV74s2gUTCnBB4JSvzcYMgNub9XCA89a9+YBWQ3A5+HQg15F3l7Q5WO4bCUQ8+7EJkIvFvqMh3v4bjU8D3WSK1mUByb5abj6vWbxqJ3W5xFHrpDE1Wdp3P2wTdu9tgYdnvvZxmbv+MrispGFQTije3/HbZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J9NfqU3F; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXvfMJgx7gpsuxsD4hO9XrXLKaS6dN5eig043Ju9ufATxhKLu0Hup11RG++437+/6WYASmClT9t0YXjN0tgLH2mB0DTPaJKkFnTvk3E+gcte5QnIsikCOpoK+lgjb4wCorH/RiYl/1lJTqxZScP74OEsjKgUnN2JLkMaEabXuDFWYTgu9j8GLgr/tYFkkoMmDmmCpR0Krx5HlgJNuGz+M6IxF23bZVouFAlERGD00VggwL5VNjh2F+ACTf1gLv3H8ryhOZnNi7l4K6qC+gEKMofkzwCr9Fud4QrYUFtuikjJkdZngtMXrwLGwO8JiITWrckutttGaannhGII77rEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/73EGiZ+/RbvZXesqQCRyYvxjznaTnCubkH462lj8Y=;
 b=Emq1XoPLhNB5aK9AuNHHEnL5BqqnCBnpAMkg1g+xRWSy7SvbL4p23xIGi/KVrjfRvcPrw1/ZAuG1Ff8m61xSnWPcf+ulu9wvrZw4QffUnjClALMZONjCFFSwIAtEdWKMIZedS5iqZGhaxaNnnTrBZh/t+QqOaV9LvF6yTUT6eJJ+Tpzfu4pm00iE+KwEuWRwVnKZOQn6rXpoy8kzfKGjAHnda62uMalKY01ExIbu7ws45jRtgUIGvktiw2NQ5LraHIJtg8syNOLpI37V1BIptQQbGbGIVH1UaqGDo4G6ACXDyocxHXOUdbHovhsk5XnVzXCiknf5wHFi0p3c75Mwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/73EGiZ+/RbvZXesqQCRyYvxjznaTnCubkH462lj8Y=;
 b=J9NfqU3FN4Ln5082lieXX2QA7iX2NGHRGkx/uE6hvrs3u4EPY4KSnE73WriVxkWB49w4QqsWPkzf2MsxfDAmnqFflWWw0KmFbpTrBVWYPRrTaH6qx0j2Y3O17xswTimaPWUJfOkmBMQ71kQCVOZeyovONuasy7AqHTIFbfBFRVs=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:19:07 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::a3) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Thu,
 12 Dec 2024 20:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:19:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:19:05 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 23/24] x86/resctrl: Introduce interface to list assignment states of all the groups
Date: Thu, 12 Dec 2024 14:15:26 -0600
Message-ID: <865b7f067bd0a1e90a07950fc4edce8dcf1c99e1.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: b092d480-b7a4-40f1-b897-08dd1aea3ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t4KBCg87F9/mfohDKWgKCZpj81iAQpZkM74XdOPRUZesyG9fD1DYf05XuBih?=
 =?us-ascii?Q?YAlmZUNU8GhV35VfSpulPzxG+zwDYvLAPHbMwqJsWysjYBbW4Tb3HiZ8y7a7?=
 =?us-ascii?Q?5+i1khy3JFcIbJEEwyS0cVLKRgZTgDYY5rEIbGa2AOoKUT6OtYbbAZxNG3pp?=
 =?us-ascii?Q?RfFBZ+Zvb/9+sGjJJrWFR5tTbTNweuTiBv0v9UlNkZsBvrjwXVzYQeXFCo9c?=
 =?us-ascii?Q?xA+QOsAtn2JlClDHGWDpvWJGsqmgKdo+534T/FPHIgLdLOBYedGAHhjyB7lc?=
 =?us-ascii?Q?YW7uPfOcaO2QT9OLH2uEZqRNvYCly7+PvSovjDIyrhzO7eg12OyN9MzY7msf?=
 =?us-ascii?Q?horicUS+gZsLZJ68PXcXjpHS0eyTNaYcndMJXMiVMV1uP6zE4Szuk5GOeTuD?=
 =?us-ascii?Q?dihzq6Rq27UA6YxTBkHBaExi2aMDjYMflHMZ1sMWIGxEQBhS8s8g+GvqG/84?=
 =?us-ascii?Q?SUz/BET5WsmH3nwSBB2TjVn8jKD3W64l+v7JN+FTOVb6/dF/zwJLu8pyx9zl?=
 =?us-ascii?Q?OCWCQkE8FMR3ZI90CKyzRCJw7kh3Z0rxDBoPpOgWkXFFnq0t9kslFMs2yrhm?=
 =?us-ascii?Q?ezQYDtl5HFE2wHn2t972nL+P34CfP1xwVqhWatVn0nulFtLK+sp7fH97n4Zk?=
 =?us-ascii?Q?Jkx1XKHijKcgA5vsmTONdx+ERjZMKRKabP+yEm+oO8cHbsS0GIJQ6+9h5owd?=
 =?us-ascii?Q?gb6MtS5TNxSkXUVki+qA+EBEGPBoS7yf+c5qn1lhZVgxE1lrKdXkDTLcNJFF?=
 =?us-ascii?Q?5UA7iwL3Q1FnG8QcK1kn2nq/I8k8OJRzfZGPszAw2FZH7kufNwCbyKC2Y5CG?=
 =?us-ascii?Q?Kl3RH4AIg9pMgriAUCJLfk2nMR5eFWDWmIEO7QLUnSYVaqXayKnf8kn81OZ8?=
 =?us-ascii?Q?wrBd8lYvv9yvqCunFikWoVBeIU7pSjeJ0JdE1P1/z4wlrra1NlNCXGKOlcmd?=
 =?us-ascii?Q?Egjj3H5GjWoabadC20GPZUvkYRbUnUQJVd/eYVT/2WyKMhpFtU78mbneiU9R?=
 =?us-ascii?Q?Sr3C0jYa/453yEKuuPm6PH9OwZYqD3NLjdQli8hjJ5BUmVjFm7oqCEqfhA0C?=
 =?us-ascii?Q?LcyxQX664Fp9an7ri6mcNKBOqfp5ijaA7gcmfcEhTVPFPhbrJU5or/B3iejw?=
 =?us-ascii?Q?TF4rEoN4EZ3VYW3MzKFas06Mu+237M1A+gHrqjUbMEurtHioj/BNuipifc7q?=
 =?us-ascii?Q?bFQ0xju0cJshScMwnDSH1ZEncJucPp3H8QTDSGUJYQwkzt9Gl9P/q5dn2for?=
 =?us-ascii?Q?fRqKJTBHkRdrGOXDdFsLEU6E4Ldk/jp5X4SGD3FAKJeN5dOSOrd3kXZ+3z7y?=
 =?us-ascii?Q?3mnbekqddXopECP9wZxmONb6GEDKh57ITuKOqfgvectmRs9lo5Nmftt/Wi+n?=
 =?us-ascii?Q?pyVHsWaH7BHQX29Q+Phr3lGC2WiBZJzk6kQvV7zc7m7f/GXQzJCTOEsoDO0J?=
 =?us-ascii?Q?sB1HdrZhbLz0NNrIFzZ4hUSFbZj0KKA6fpYqBlfnYjukCIuFGqn64w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:19:06.7870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b092d480-b7a4-40f1-b897-08dd1aea3ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

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
v10: Changes mostly due to domain specific counter assignment.

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
 Documentation/arch/x86/resctrl.rst     | 44 ++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 71 ++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d3a8a34cf629..9ae2b8f335dd 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -321,6 +321,50 @@ with the following files:
 	The number of monitoring counters available for assignment in each
 	domain when the architecture supports mbm_cntr_assign mode.
 
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
index 845636a205bf..3bb4313df92e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1240,6 +1240,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			hw_res->mbm_cntr_assign_enabled = true;
 			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 			resctrl_file_fflags_init("available_mbm_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6b5c886b7e99..70bf590ded8a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -986,6 +986,71 @@ static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static char *rdtgroup_mon_state_to_str(struct rdt_resource *r,
+				       struct rdt_mon_domain *d,
+				       struct rdtgroup *rdtgrp, char *str)
+{
+	char *tmp = str;
+
+	/* Query the total and local event flags for the domain */
+	if (mbm_cntr_assigned(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID))
+		*tmp++ = 't';
+
+	if (mbm_cntr_assigned(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID))
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
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		mutex_unlock(&rdtgroup_mutex);
+		cpus_read_unlock();
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
+				   rdtgroup_mon_state_to_str(r, dom, rdtg, str));
+		seq_putc(s, '\n');
+
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
+
+			list_for_each_entry(dom, &r->mon_domains, hdr.list)
+				seq_printf(s, "%d=%s;", dom->hdr.id,
+					   rdtgroup_mon_state_to_str(r, dom, crg, str));
+			seq_putc(s, '\n');
+		}
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2316,6 +2381,12 @@ static struct rftype res_common_files[] = {
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


