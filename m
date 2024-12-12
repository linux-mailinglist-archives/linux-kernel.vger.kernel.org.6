Return-Path: <linux-kernel+bounces-443887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848249EFD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA36169EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665281CCEF7;
	Thu, 12 Dec 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pj/LczVW"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908C1AB6C9;
	Thu, 12 Dec 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034637; cv=fail; b=DQXPyTe3k0C2KkJMv1kFMjG5WZQYIJj3ZTyNcpRlgyNnqnqIoSK5qG9L0NaIp/Jl4l2mIm+zgGCC4NXtSTPYN4yjOO5Pt62c8xEWH24lv0EhcBb/nkQb/ZsuH2eZXfQ8Q7JA1K0hEL0/h6EOesDLV+yw+l8R3GC2mn0cSSDSdMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034637; c=relaxed/simple;
	bh=iErObPPFj+/pPJSSew9voT/uthjg7dBNgMW1ghjtBK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFsY3Z4iuAPG8kgP+vriR0A3sN5p0+gJoAcpoWRiWJO61Z7ADKO4AxK0UMQ37lJEfg1qyAMO0ikZbtrV51+vwLuC1nENYdZTKa76smizDcF+6IwPdGdxHDqFUNhzlYE8R0cgeotco77XU8rzmvGA45Zk4aYx7BIuyXSTM4OZY/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pj/LczVW; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNd5HFX+KA54vKk5CLYygSgLyXKVbiiL0loiBZ6jSuCWfJdv5+hLlKWHv4yQf5Q0VL6aYFhvkI97cp//O3T91H5dTSH4EggzGkfP6WveE7SXeSkHYnBzF+hsy+KG6dC+lQIy5f0FPoFeLwgbqZPejvzAr5Ogyq1VWV26+/Spsxg2/OUM6zkwbuq6qCJ7wCkefVdf6Mxbu+WyyneUUI3ElwCGZovVkUbwRNKgmZTHajePzddExQLnpPvAqsT7Gr7KNysVCSDcE1aQEhD2o9M0JEaoy1MoD5ErYX3zRZduFM4C2uWeI+q44PcItBtLvxP1rEmPqhBnovMMbZeuH7lq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIIyVOWDsfpDEIzqOEuNCpt6RALCcbYeGJW16Wnmiow=;
 b=UbUI4rEUQULO4Rd6AVnK3QJ1qM1oRYRiQ7BKHH3EMbPdC/O7YWS6SPuMHkW3UETij13XYHvcJoGeL5HLraZgM5hfwnbXrGLIxoPiLitBJq2oBIcAhgvBeArbUsOFPVZayWbiz2DX8XyIcCmZyOQEVqESPSUj2hKBGoogXWYo/cYQX9/ZamHj75kHOxXmpRSK6gScg2tZGv+3zY+8O5O+v0I4aODP3JSOd3CL0eRNBq5NKwFINTjFBIrCD2xaPo/pwgRWI+s9hsOLnJugjRHDT2S4zgfIq5Rc69m6UBbdAqa8cXTne0CdoxWqeUMT5oOhCfwNajwgZu82DgS43ohVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIIyVOWDsfpDEIzqOEuNCpt6RALCcbYeGJW16Wnmiow=;
 b=Pj/LczVWlUGiuiiWZ6FEUI1esBRwp+7/vdE/6QVQ2eNAcK0c9l5he0M1tEdKCp7vUzQ+Ir+IlSOfgSRpAfw3/29OwZqnRoexn4xzwMFXA2TcFLdKXuH8iqRwOp9prdBAVuVoC8mmZ91ok65o/U6w7MiEAYeNaCZnku8QVyAi5pU=
Received: from MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::35)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:17:09 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::61) by MN0P223CA0018.outlook.office365.com
 (2603:10b6:208:52b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:07 -0600
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
Subject: [PATCH v10 08/24] x86/resctrl: Introduce the interface to display monitor mode
Date: Thu, 12 Dec 2024 14:15:11 -0600
Message-ID: <28399c9a82b771695181e8cb69d9c21847ff4c9c.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a299f-efaa-4c34-6012-08dd1ae9f4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3JnMpyTLXWa7Pr+KP2pEhe0XQDpZO/8w+NFJtM7qVF2dfbIzJ5q+NyW+SUF?=
 =?us-ascii?Q?ZPlESu6r3IAx7kfd4EC2yfoVmKyZTfcrE5BpJ49voFvo/JyijZ18craa252+?=
 =?us-ascii?Q?nAgtNPErfmQvbaHaPol41UGIK5JERQ7dVCe6tfVZNDRwWs5Z76LNiDlzE89F?=
 =?us-ascii?Q?AEhrl8MN+qlJRPIx/IVWGRPTySD0iiWaOS9kvT81WYM1PT+KUh6ivQgiZSdl?=
 =?us-ascii?Q?znIAS4YWm2HwkZrEDmQUNjwmyQta7VYrjbHTuXrM4Iv+6lY307pNXKub1aPN?=
 =?us-ascii?Q?QNtfcSgdYe5T+shIroNvvdzupT5EFZMkhoFkBbsDjbpiy6XetYbePFzV5lcu?=
 =?us-ascii?Q?gz/zLFLWNSuw/uJvrgeYIz1GMLJm6CXKhrildSQ/8iPFUWxlGOlkaob/A8wb?=
 =?us-ascii?Q?6UbLt8Yyiu3paX1JQLDxFA5ll9Xa4uALMPdNjyScSAejLpbeyxf97mnmKvzz?=
 =?us-ascii?Q?B970WHDr8nL0pWgOr3n+yV5E+kyZ4MX6P0tSP4lK1meRer9h/tLTJ/Z55g/8?=
 =?us-ascii?Q?Z2Q3WxqY6VSUJ0a06LA+gA8Eob7wsQtmDxU1FtTxYMH5YroVlkpGf1sBv1p+?=
 =?us-ascii?Q?NIffMn3Aza3Ag9jywVhMQdQ9z5owtwf9dsj6qMaBJ2OyTolAZ9l3cGOF5olc?=
 =?us-ascii?Q?+L8c27TgvWomlggHgRILSTWHcuyRnH3et7BVMIeryTq87QSYIqD8LAwFlQZW?=
 =?us-ascii?Q?aStDV0wlk/kpB4IHHrEDqUgp8ELM7GLH4FdGYP5vb3MtKiGr4TS459eEjV1p?=
 =?us-ascii?Q?38pjfemxg18/yrA1xdr+T3xYkKvndAJxxErV4CBzhojFdkH+vd3bXhLfwqVp?=
 =?us-ascii?Q?tyQDX6N3x6g9p7txvk0teGhxrbD7+UzHMQBU5YoxaMzRY7ceqJ60rceeKb3T?=
 =?us-ascii?Q?L/OUEZIvqdHn/BFJolGxuYUN2XgKPha6ghfCNFCvAA+bHttXTvUTw5jJheR4?=
 =?us-ascii?Q?1YHMazby0xQsz/K5Q34D0P103GSsfg6kzfuwmCJqCxNHjEAELo9bQGvW5E1L?=
 =?us-ascii?Q?S0GAQA8e7Z/rSvoxiJqjZvH9xhjSs5H0jrPo23weV7aDBPcVzolcVwASc1IA?=
 =?us-ascii?Q?oQdkOpIZ109QEkKWuu2oSzEF1qjuzBppxIhwXLO3S5S5AJmIaS7XT/Cqg8Ad?=
 =?us-ascii?Q?KfWrrJyigKMKutSR7p+A/wgeKzp99dGypxAVx8rmOjoTqH7w+ujir89Jzob3?=
 =?us-ascii?Q?A1yR4bN2dk8SkfL4Wvruvw+b0OXSdjhis84D+CpxLxLOO3XaRXsAzFCXirxE?=
 =?us-ascii?Q?4QxFH+WDDxWAsbbL6MQUzKpmrx9bFYF9jveddbJioxoshq65NgJRn9/rfRY2?=
 =?us-ascii?Q?BTBZf/R/cpNr0bqlugPtntkG46deRackPCDbIZlilK506CUCzZujGoYI/zYN?=
 =?us-ascii?Q?GTAWaPfYZ4feJTGobjN62YwKtLZt/v2NlqiUJ07eOrVrXkJi2NHS5Kv16kdK?=
 =?us-ascii?Q?DHO3zyf1+/b7BQ5SxGZapbmM4+tH/H+h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:09.1934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a299f-efaa-4c34-6012-08dd1ae9f4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623

Introduce the interface file "mbm_assign_mode" to list monitor modes
supported.

The "mbm_cntr_assign" mode provides the option to assign a counter to
an RMID, event pair and monitor the bandwidth as long as it is assigned.

On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
Bandwidth Monitoring Counters) hardware feature and is enabled by default.

The "default" mode is the existing monitoring mode that works without the
explicit counter assignment, instead relying on dynamic counter assignment
by hardware that may result in hardware not dedicating a counter resulting
in monitoring data reads returning "Unavailable".

Provide an interface to display the monitor mode on the system.
$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Added few more text to user documentation clarify on the default mode.

v9: Updated user documentation based on comments.

v8: Commit message update.

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
index 30586728a4cd..1e4a1f615496 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,39 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assign_mode":
+	Reports the list of monitoring modes supported. The enclosed brackets
+	indicate which mode is enabled.
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+	  [mbm_cntr_assign]
+	  default
+
+	"mbm_cntr_assign":
+
+	In mbm_cntr_assign mode user-space is able to specify which of the
+	events in CTRL_MON or MON groups should have a counter assigned using the
+	"mbm_assign_control" file. The number of counters available is described
+	in the "num_mbm_cntrs" file. Changing the mode may cause all counters on
+	a resource to reset.
+
+	The mode is useful on AMD platforms which support more CTRL_MON and MON
+	groups than hardware counters, meaning 'unassigned' events on CTRL_MON or
+	MON groups will report 'Unavailable'.
+
+	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
+	enable this mode by default so that counters remain assigned even when the
+	corresponding RMID is not in use by any processor.
+
+	"default":
+
+	In default mode, resctrl assumes there is a hardware counter for each
+	event within every CTRL_MON and MON group. On AMD platforms, it is
+	recommended to use mbm_cntr_assign mode if supported, because reading
+	"mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable' if
+	there is no counter associated with that event.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d54c2701c09c..f25ff1430014 100644
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


