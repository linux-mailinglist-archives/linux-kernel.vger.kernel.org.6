Return-Path: <linux-kernel+bounces-276989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29736949ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969AD1F2404B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC017556C;
	Tue,  6 Aug 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="glaKrM1G"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12530171E61;
	Tue,  6 Aug 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981728; cv=fail; b=H8toppk8jc6wkPvUxfGCR9LgjxfimElNz88sdnMVrI4aNYN3KxlehnuB09FyEQ5lZtmnTuiJ0wl6URJanZyVNzPWTPUtwAIO0qocQwCir62YIYQKivrXTVmVH/5j5cB8ofKXeSm2TvXOIys5qUyur2Lhtf4NHtlziFd7Ij/Kd7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981728; c=relaxed/simple;
	bh=rY95UJgg3m0PnYTv1w4zWZg48+jbWQSlvXwaBeZHKVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+EtVbaAErJgOCtnj2hSuPNRx/EDS9jzuuaVM/Jl5ia5PYfmSlsTRPkhFWQu1SRitKPrcZiC+zykLAy/d3mDPgQ5Vv1xzremkOU/IPx1Ma7X5XGKH9Caas7hPC94rKaZeooWBeKiwgd6jPUP2qj+EkWke6SZXPwrPA4r9aSaBms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=glaKrM1G; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR3IPLCnHuWag7r5036Wx8PuwFUbeO6VI6TS4UkWHqerh0YvdsgVafLJ9jfIEZH5j4JmdjJY5363zKC0o/FkY9rDXhaaEKSqxKieFcA0I47HNVggAtyVeP4AUiJ4CM6nyWGXl0veeJlJPC2z0Wj02D/xk9+bJPqZUdwANg6SCjCu6l0PR9XjLsDyJGbFWSfFM2Ez4YLH+5JKsATf9puyKm3kM+eMCUziwkzJ7j4eN0+8fdqmIsBhlOV28ic5GL33jJt+wTBdtw4R8HsxELekAjKaWAnKnPHj+qXTnSJOGYYoWDkDlDGZDrr+Scv8WYAnCIpbeoTfBFDHuVg2rx0X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b5dgNdN/fCfaLPak6Z7DYz7QenB2BY++LPgjCTBw3M=;
 b=FkXjG5zxzbAbrMUgT6Q9UsDcev1g5EKpiRIIklqldG4sc0QInmYtLrS3sIgwqTNIXcoY74MXIMS1UJfIZ35+A6+3BmkLwwDTlDxpK3hVIIJRDwyXRDROfDPJprynDbENIAr4fIE1Sqm3w4xkIqDTnQAnOvawMUBpkKC9DxkZAdvhBGCA191c8UZMc0tSy5HyVegvZGjqU613aN8YLjkMmainUGqW39tNZveitByoKMCPZPxLt3f2mDfTu8oGab4GEx+4XnnOZGBPX/5ODrd4M00xFeUQbIH6utgAh7Z7NmcuTakvCaeLgqeyYkZKmFiFScDLiMENWOGzIQfdj9kVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b5dgNdN/fCfaLPak6Z7DYz7QenB2BY++LPgjCTBw3M=;
 b=glaKrM1GD8XkqE18MEa6nnFprMUPIhAjv55Qt0UBkcDn/Fw44KqQ5fmeI6vsvtFy03Yqv7EpeoOksuw0NSZWSkPubaYdt2ingdx1t90zkYz/4phCTXsnOhM9zFSfvqjPUkyX63ub01fH7Y7vkDOWsvOJjbnRVLir4V6ulsKRm0k=
Received: from PH7P220CA0150.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::13)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 22:02:03 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::d) by PH7P220CA0150.outlook.office365.com
 (2603:10b6:510:327::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:58 -0500
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
Subject: [PATCH v6 07/22] x86/resctrl: Introduce the interface to display monitor mode
Date: Tue, 6 Aug 2024 17:00:44 -0500
Message-ID: <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: aa344e07-c848-435f-f626-08dcb6636781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYwm9SCRrLTqR/a8qLbZjmcnlbMX3USR8ykcQ7WrAaFnMH0FxA18YlrrGcuW?=
 =?us-ascii?Q?GvlXBFtHnbo13wKIDXTFURh42w44iVM5nQjFd0Kzmt4aURSU398CHK2OxAKJ?=
 =?us-ascii?Q?R37ML1JZxcBL9dSk8O6bhLKHcwwL9boqlQgQI0rGw/kyjEQD00TmY+h7J9WY?=
 =?us-ascii?Q?IquT/6pbj4GKFO3IfRtbjUkBa6RZP4ouISdb6RJj5fltGSCizrFGv77/1WNw?=
 =?us-ascii?Q?RRGpO3PO/3155HpddJxp9SFQbRv8Lyim7rPE7Q/IMyj8B63MKqkswgqMZRvS?=
 =?us-ascii?Q?z8smoColBUXy6t0pfC8S9KFJLPGKinwkQbaT+j2Tz+nPzl27Wy8QNu2GlLu0?=
 =?us-ascii?Q?l5lA2IyTJor6+ho8eOPPd0ldvBCrw4w+lebbn8yH553HAvFavGfxPr1vzg6v?=
 =?us-ascii?Q?YP+LtItVXowdSEkaxLV5I1A9J/wddHljzY7ekrQMekNlzVk/t+sCns4wTRU/?=
 =?us-ascii?Q?VTJG5jcaiwnjozjKPBWJ8GfloW1M71OoKvVAA2bU+l/j3bX9CEnpbT1CYmcA?=
 =?us-ascii?Q?mDNQ60/dMYFxOJBiV7L4V+bSQfWBbQgzZ94E28LRM1/zF6VaTdl7MAyj3B2r?=
 =?us-ascii?Q?ISe301DcXmFtatT2B5lEY5Zijm52rqCw5vgBTSMHXMCyb/Jh4urfjcB2O3L7?=
 =?us-ascii?Q?13xPrM3kQDZKNVI/apnVlVTNKmU5whRhP3KjOfpr0w0NbXmzUpXBNRxr2cHb?=
 =?us-ascii?Q?RajORdWCh56BpeM/lUPrpo9hjto+WJk7vO1CvVnJofz15Y2QHP7ABrFKknK5?=
 =?us-ascii?Q?ye2WweYdIh3fCFMVTMAehdqLb6UDGqCtQGpsHPNuarJbbKNwZDd5uFczOKQQ?=
 =?us-ascii?Q?DaJUBF8UEH/LHyh1cXPGjHeRkWDyH+YiUVI9DSedM7VFvns0bMnc3Hgs6U7i?=
 =?us-ascii?Q?R9cViMQzWNA0AGQETU2SGYKNs46CVKblwaAIoIdlmgtl4apbu21pt1EV/CTb?=
 =?us-ascii?Q?Wo2RCtKB4Vw2sO08JRPZz7ZORbpacdPcvkxt62ym2O9sqmm7vdN+OdCn/Qpp?=
 =?us-ascii?Q?HZ0IoT8m8fub3OU8hgl9/+Ue06XUROSPcsGB7Ezr3rmn4XS7OU13WUGsDMaI?=
 =?us-ascii?Q?ePmXGIbjZjrxja8ExlkypTOqVRswIkuNjzMq1GrVc/G3PK6lIFRMwPMtUdx9?=
 =?us-ascii?Q?Ut1uM61eN8qrpUuxt5gi/RoSr4nWZoai/t70eJDdA3yc7prq5dSxPTWnQGpG?=
 =?us-ascii?Q?7tDWApFbwFRwAOjhdnSJu39jrzODt0Irq0Ymxd0ZS59GdNTQUh66HSTEB8cT?=
 =?us-ascii?Q?KOyNMgzjuoW6DerWBVyHj8YlSYvuGLQI1OluIV8/TVq9zyRS2FKeC+VgcFBF?=
 =?us-ascii?Q?iIDUgDs21WSBSO/oBCRosZJ6IOTXQqbF6xiaLVzbE35ETPT0p40xcDdVbw0y?=
 =?us-ascii?Q?BHSm7Zycf1gUEjNh3n5hfYED7MC6odclK9vHpZPV/3oSVR3AzBfo5fiy6RcT?=
 =?us-ascii?Q?wjnLRu1FKEs/pste4xNRjnynDZZqsFLU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:03.3418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa344e07-c848-435f-f626-08dcb6636781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

The mbm_mode displays list of monitor modes supported.

The mbm_cntr_assign is one of the currently supported modes. It is also
called ABMC (Assignable Bandwidth Monitoring Counters) feature. ABMC
feature provides option to assign a hardware counter to an RMID and
monitor the bandwidth as long as it is assigned. ABMC mode is enabled
by default when supported.

Legacy mode works without the assignment option.

Provide an interface to display the monitor mode on the system.
$cat /sys/fs/resctrl/info/L3_MON/mbm_mode
[mbm_cntr_assign]
legacy

Switching the mbm_mode will reset all the mbm counters of all resctrl
groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Added documentation for mbm_cntr_assign and legacy mode.
    Moved mbm_mode fflags initialization to static initialization.

v5: Changed interface name to mbm_mode.
    It will be always available even if ABMC feature is not supported.
    Added description in resctrl.rst about ABMC mode.
    Fixed display abmc and legacy consistantly.

v4: Fixed the checks for legacy and abmc mode. Default it ABMC.

v3: New patch to display ABMC capability.
---
 Documentation/arch/x86/resctrl.rst     | 34 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 27 ++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 30586728a4cd..d4ec605b200a 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,40 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_mode":
+	Reports the list of assignable monitoring features supported. The
+	enclosed brackets indicate which feature is enabled.
+	::
+
+	  cat /sys/fs/resctrl/info/L3_MON/mbm_mode
+	  [mbm_cntr_assign]
+	  legacy
+
+	"mbm_cntr_assign":
+		AMD's ABMC feature is one of the mbm_cntr_assign mode supported.
+		The bandwidth monitoring feature on AMD system only guarantees
+		that RMIDs currently assigned to a processor will be tracked by
+		hardware. The counters of any other RMIDs which are no longer
+		being tracked will be reset to zero. The MBM event counters
+		return "Unavailable" for the RMIDs that are not tracked by
+		hardware. So, there can be only limited number of groups that can
+		give guaranteed monitoring numbers. With ever changing configurations
+		there is no way to definitely know which of these groups are being
+		tracked for certain point of time. Users do not have the option to
+		monitor a group or set of groups for certain period of time without
+		worrying about RMID being reset in between.
+
+		The ABMC feature provides an option to the user to assign a hardware
+		counter to an RMID and monitor the bandwidth as long as it is assigned.
+		The assigned RMID will be tracked by the hardware until the user
+		unassigns it manually. There is no need to worry about counters being
+		reset during this period.
+
+	"Legacy":
+		Legacy mode works without the assignment option. The monitoring works
+		as long as there are enough RMID counters available to support number
+		of monitoring groups.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6075b1e5bb77..d8f85b20ab8f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -845,6 +845,26 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
+				  struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	if (r->mon.mbm_cntr_assignable) {
+		if (resctrl_arch_get_abmc_enabled()) {
+			seq_puts(s, "[mbm_cntr_assign]\n");
+			seq_puts(s, "legacy\n");
+		} else {
+			seq_puts(s, "mbm_cntr_assign\n");
+			seq_puts(s, "[legacy]\n");
+		}
+	} else {
+		seq_puts(s, "[legacy]\n");
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1901,6 +1921,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_mode_show,
+		.fflags		= RFTYPE_MON_INFO,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


