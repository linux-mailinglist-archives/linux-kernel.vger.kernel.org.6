Return-Path: <linux-kernel+bounces-316035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB3596CA3B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D947128BAD0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846418593C;
	Wed,  4 Sep 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZJ4/3S2B"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F2154456;
	Wed,  4 Sep 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488577; cv=fail; b=n3V0OQ9n8tEWYsn5wf7ytPrjVpb1GdCG1lyUsMKqqgxeQ5anh8vFW2LZ6Jn4K/4bT6pVlpeRCkXQu7/0vBN/793zP/p0LebvghrUiQ7q07sVK4PftGUw/6wymo6yVKNK2NUsrDXVMQEltZdEJPxxCCrjK0/3hGurqBEPLOIpvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488577; c=relaxed/simple;
	bh=8jcoFIs9TfbIKDKP+mNKkgc6PdYz4kgyggp2QKLnCY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxa8Fab/sR6iOimApB4CU03mOniXrI2ZuCbdnt9w9SrGEu1dH+4CK/BtpdbmQARHFgfBG3ULRt+swBPSEv/K2iwk8qvRevQxnPQDslibBD9NXp88kAxQGXAD3e5sxm5MtkeHoEPmbFXvmUE2JA6dEIk6cx6Y9Ual5kO3eZ1LkmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZJ4/3S2B; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ggl2cMoKP2qPmquWuL9bwaVqCu7Kh/286dr6FSJ4H1iAgsN2vNS9pWQyf1KFlpFcm+WkwnCpevJjgzHu845QlDg2n1PtZbVyc7ySYRlfB1faFhKFChuUQ1PojT+Ptau3NMg2WOr/D9ZhX1OpdkdxX1jfdtvSIcq+YqhnDvTI6ANclpVOmKCmDixAbUF/C5Q2SiSfMoqd4z7yFbnGoNkI1DgNMNBuA5Flsl6N2pWJA9nT5pxanCB8kCa1+1R87vYUPZr2N2NuzJ6xRQqjoVsTw27e3YOBvfvQCELDa4bqJZ1N5Aa69IOCc7pZUpnLnj0eP0En8TmtpqzNJcez0X7z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CV+CBb/hSC6vOLXbgbD96KQgl6lY28eBgUKamKt4ho=;
 b=eLXQi8ytsf4KwZcQHMBKw8k0tPWR2sjpSeF2rkqm53qrDMpQrQmURP+vIxmNlM7UGRPZmRMt09hSbpR/bODBX5aq+Oqkd/I6qhD3u8m9AMrJtAxQyQQi8uUN73G++WWJMC729i49DkTZkWuSXVYcQODX/+tDywS1bNBxOEBSXbCHxSwiYKO2WSSqmAKIgYU7LcaDl65lhQPF7tZRk+MgE9PZZ3UvV6cHw67tEzlhc92HTk8g4PlqoQ54BE8dl2mzCRhM7/8mVEyknGk94YRPpyDFL0C2ODXJFnYrkpEMXuue6wULiS+Dwd/VmNXJqDH84TZ5MexS+3Da0oOB+c6mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CV+CBb/hSC6vOLXbgbD96KQgl6lY28eBgUKamKt4ho=;
 b=ZJ4/3S2BDuMJkI92Ie7OrCa+So37bqiN3R7+W6jpwUnBoyjFy0HORRhrXhkb4UKYa3sQ9+M8t7+ontLGR4sXYiq/PW6J7MXoYU17vEajUAsP0k8rPxj3bodlXlzTxy5HeCUOZkbI2neC1E3TbxfW/gg1/Xktc4kMVEwaPmrKi4s=
Received: from BY3PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:39a::24)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:22:48 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d0) by BY3PR03CA0019.outlook.office365.com
 (2603:10b6:a03:39a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:45 -0500
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
Subject: [PATCH v7 07/24] x86/resctrl: Introduce the interface to display monitor mode
Date: Wed, 4 Sep 2024 17:21:22 -0500
Message-ID: <e3ff30d647ab9bc452c882ce1dfb366eabb0cc25.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb99b19-d0ef-4396-fd7b-08dccd301b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmLCRVT9ZySTpDrN+P0atJ6O+9cSKP5KQJRhiJJm0GNCdeio5kMUUA5OomSa?=
 =?us-ascii?Q?Q4uTc9QX526/2LeS/hFtzDYx/chDBalhZ+k+JoKOPPayf8dq8Ink5Izf1AhY?=
 =?us-ascii?Q?NhR9CwMNUqUX7HFr+fjry/XCBhlJCiLtZ780ax6a3XnxGIvbo5yXJDKu+CJl?=
 =?us-ascii?Q?gPwUph/gZIkxL3N8ZMaBH1G/n/cdSZLGfPXkSR8KLL89cI//gd2FfnPEW0Kp?=
 =?us-ascii?Q?KgoY0yoaJa6RFpI70leNb4XbQc7V7KQMctNFBy42FQgeBYj0LhZKT5oeYcqh?=
 =?us-ascii?Q?p5mgGCUh7kFI/NE0T9m5fFMtiZ3VYCXvN6xRhg5zA/poFFUSidD3tWhj9WS6?=
 =?us-ascii?Q?Z/pgziUaD+0UnUxEzoSGhfavKaMQpRgd3nFipI9mq30As/NfiDOpw7GgNEUn?=
 =?us-ascii?Q?mSNimSP2jBf+K/1ZXwmgtvI0u4pPbIqHblzEAhX+Fc3J/ANF82LN4vmqXs/h?=
 =?us-ascii?Q?bN6jELneRmSAKcB6Q8RsPYqOo2dyam7lSUNmBSao3L1Jx1uCPxXhhJ5P5mjV?=
 =?us-ascii?Q?q974zibgWrZgbftP916i8nTujpKgCQf8w5lG4SwLaNK59TcC3GJ4ilu5owIh?=
 =?us-ascii?Q?jJjNCLAd6i2UgJBcn0CS2OeBKomNvFDXsukPSsFtzgIG5iY4n7+2Z9HVcB+s?=
 =?us-ascii?Q?gsLILtmjaUHAeXugcy+CBhyqKvO4vN8yqZkJGyRnBgUIU09H9dmJJKpP02rd?=
 =?us-ascii?Q?aEm9WPINjNwVZeuMogfyw2bVeZwGfsKlB+4Hef4ZJr65waX92cBi6NG3bJUK?=
 =?us-ascii?Q?n7+KDi+PnbYyCblHgqpKLzaWMSnX70JLLMejg9e81kanqssZPkHCPjj23Rn7?=
 =?us-ascii?Q?zAZ5dZkD7rZ/l26S9fioFKLJV/4ZBlYfBaadtFWclBtxSjuJTlOS8cEATt+/?=
 =?us-ascii?Q?eJzl0KuAeya3ljg5Te4dhX2Y52WTZJEA2xUFPZYzL66lTSgKQc6a902wx/IH?=
 =?us-ascii?Q?HR6mQ8SXq04qmqtPZssMkbHBwD21NZR+QGD8AadcsidviQrY4bvWNdpj3VWe?=
 =?us-ascii?Q?ZqDnwYee/FelP3ThWu6HBGnJQSpOmN5VE03ykaUJFe9BJ4gH6uzHpqxmmTM9?=
 =?us-ascii?Q?HAxR39TFx5lldaFzImT4n4h67PtuXJEIi0+qPaQe9UwwWt66tOQDwhwIvqV7?=
 =?us-ascii?Q?nNRxt3wl84mtZ6yy6ZXayHLfGw6egQwpdEgzDi9Ya03RkYRzT3aC8kiMjP+X?=
 =?us-ascii?Q?0rUx8Cm6CNUO3dMAXRhQHfQi4wo2CP0ouNF9cLs55PlbCF5yhqS6fFOUPHni?=
 =?us-ascii?Q?oTmRdAwdjYL7JCqi7DhL8XjGk8AMtP6Kcj2Rcdx6J7J2RWvPjAlMCZdqptJi?=
 =?us-ascii?Q?lQgaeq3waSj1UkJZRERQM4VhMdI8HjjWyqwzOR0x7xNQTojNL4LVgVFOL2sk?=
 =?us-ascii?Q?PZ2292V4dJikUsYil0H5YAXAoI3N+7S7xSqhSX6AqAI6IhYSXC0tLaBVLbv+?=
 =?us-ascii?Q?5BU7KZ9AtAvOiJJtRPZc+3+E1HERCf2r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:47.9605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb99b19-d0ef-4396-fd7b-08dccd301b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709

Introduce the interface file "mbm_assign_mode" to list monitor modes
supported.

The "mbm_cntr_assign" mode provides the option to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.

On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
Bandwidth Monitoring Counters) hardware feature. "mbm_cntr_assign" mode
is enabled by default when supported.

The "default" mode is the existing monitoring mode that works without the
explicit counter assignment, instead relying on dynamic counter assignment
by hardware that may result in hardware not dedicating a counter resulting
in monitoring data reads returning "Unavailable".

Provide an interface to display the monitor mode on the system.
$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

Switching the mbm_assign_mode will reset all the MBM counters of all
resctrl groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Updated the descriptions/commit log in resctrl.rst to generic text.
    Thanks to James and Reinette.
    Rename mbm_mode to mbm_assign_mode.
    Introduced mutex lock in rdtgroup_mbm_mode_show().

v6: Added documentation for mbm_cntr_assign and legacy mode.
    Moved mbm_mode fflags initialization to static initialization.

v5: Changed interface name to mbm_mode.
    It will be always available even if ABMC feature is not supported.
    Added description in resctrl.rst about ABMC mode.
    Fixed display abmc and legacy consistantly.

v4: Fixed the checks for legacy and abmc mode. Default it ABMC.

v3: New patch to display ABMC capability.
---
 Documentation/arch/x86/resctrl.rst     | 33 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 30586728a4cd..a7b17ad8acb9 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,39 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assign_mode":
+	Reports the list of monitoring modes supported. The enclosed brackets
+	indicate which feature is enabled.
+	::
+
+	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+	  [mbm_cntr_assign]
+	  default
+
+	"mbm_cntr_assign":
+
+	In mbm_cntr_assign mode user-space is able to specify which control
+	or monitor groups in resctrl should have a hardware counter assigned
+	using the 'mbm_control' file. The number of hardware counters available
+	is described in the 'num_mbm_cntrs' file. Changing to this mode will
+	cause all counters on a resource to reset.
+
+	The feature is needed on platforms which support more control and monitor
+	groups than hardware counters, meaning 'unassigned' control or monitor
+	groups will report 'Unavailable' or not count all the traffic in an
+	unpredictable way.
+
+	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
+	enable this mode by default so that counters remain assigned even when the
+	corresponding RMID is not in use by any processor.
+
+	"default":
+
+	By default resctrl assumes each control and monitor group has a hardware counter.
+	Hardware without this property will still allow more control or monitor groups
+	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
+	if there is no hardware resource assigned.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0178555bf3f6..dbc8c5e63213 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -845,6 +845,30 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
+					 struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->mon.mbm_cntr_assignable) {
+		if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+			seq_puts(s, "[mbm_cntr_assign]\n");
+			seq_puts(s, "default\n");
+		} else {
+			seq_puts(s, "mbm_cntr_assign\n");
+			seq_puts(s, "[default]\n");
+		}
+	} else {
+		seq_puts(s, "[default]\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1901,6 +1925,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assign_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_mode_show,
+		.fflags		= RFTYPE_MON_INFO,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


