Return-Path: <linux-kernel+bounces-240256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6373D926AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D671C20CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B9198A17;
	Wed,  3 Jul 2024 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aNUBabUt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7992194A5B;
	Wed,  3 Jul 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043385; cv=fail; b=GVK7d19rpiq4eRr1yyHKafkIw9iaf8nQs0Cnowg1MveueedjOuMX+Y4im7YVhkrgdf3vLoMlJ+M+a6rzQfshjq4qGuoKkq0ia74oN+nidqTkbVbdTZTNslpqYnEJi2ZNi60V5EfhTarZI0crzDFNTLEi8YzxnWgS8mZx9e9FYNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043385; c=relaxed/simple;
	bh=RkJ8H1x2lB85H4tGXceYPBeFAQaYqAAu3jTVc8326LI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq+6ok2gjDuh12D7UA9i6rcrrgaqDfxDBD0ncpdq2DX2PAezP5Z44RJeLD1vFEDiijPznjBLTA+sLV0Aj/bthlq/nPEsa6IKsGpN+K9eh7hV+p44XM156mE67MqpmBCAhSET7TBxWtw3I+8pmXGSTH8CVGQrw19bqa2zdEVch5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aNUBabUt; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQjBoxpZrzXNcDo2uV0Y6oUXHH5dyhfYBLZoSkF7oA7EizZg5qz4noHSghJrLNUgAJn0HLdpyWSKY76Nz1FfGp70lJ1ds3p4SWeGDN58haJdOh6BV0x5jrvs2kQUCIWFse6u08yNxzwZzEd7IDXcydBMfcYEkmn1uzHUxwiIoc/7fb4TRpBJexa6xqNoejGqFui4MOnd7u9bg0TFwuWGLF6qZ0K0if6E0af2CtWVPFXhMWKlN70D6At6z7EA/m1ug2osKyyrNYeMh6fUCdgStuxMNHKn4pZ7HhY8IfgkM9hi5E2z3JgOMs8ROVPwZbuTk+8YSKFQ8v8Nnr+6vXOCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grRtu/eAEl4GcQEYXVeNV6HK8O9ANuGmhQ53NOkm7wM=;
 b=cnhv9picIFzMoIDiu3oMhD2eJ2raHWbW3B4qctdTb3Dq6xerphgDjhaZf6bjAyEA9CvcvlU5JtkgRy0pqMznKh+mgzpHnaldRMa6vO73iQBu8zzuZa+MDxG4T+Mp4TxrC6l+IntFdm5KPxNitp15z0a8OX+0j1npWg45PJd3Iz+G/pEYLavc+6Jv7Tl2myDmxspp7UXSzvB7ih0XlqMImS7B4J/Lt2zqJAMlgrhrZSVMfXNyEhfl7CtjK9t6zjo0bSFFuJSRy9SVxvIDuiClwAB9bAy5OIxLULrHxGbs9KxbfmUIilTYOAoW2VRRqC3X9mPOQAgfkCRJWKt5+kGNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grRtu/eAEl4GcQEYXVeNV6HK8O9ANuGmhQ53NOkm7wM=;
 b=aNUBabUt/jrCltrDCmtLQEL8JYeVPhO0cxbPYN2str26wzNeoSBiq6DGSXru4K7Yt5XBdzO5jRduYUxUVYOgluIAWkp/2TGFRvO+bk/3LCDbp2kaKbIE5K0pAtD/oXcoeXihV3XHIjaf2wRT6S7jQWMYWtJoMJl9ZUa7E9p+w80=
Received: from DM6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:5:15b::30)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 21:49:40 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::68) by DM6PR18CA0017.outlook.office365.com
 (2603:10b6:5:15b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:38 -0500
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
Subject: [PATCH v5 07/20] x86/resctrl: Introduce the interface to display monitor mode
Date: Wed, 3 Jul 2024 16:48:18 -0500
Message-ID: <4b8e3a4dcd8b6c7d7ce80a54cd2a129cbd2eedda.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 067094b0-ebe2-46f7-57f3-08dc9baa0a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mi/Ge6AAcu/lTUyN0lAQyOwgCszkkAnypzaAUYJIz5GOkipyhwFrayK4yvV8?=
 =?us-ascii?Q?R0q74xm0Hj1QruLPrqWKdf3FoGNA3/+S3fYLZ/gGW+L/8tZUQU6SeIM/3qVu?=
 =?us-ascii?Q?BeYBU/SuKVT0NdzHSzd91ILp3OTANWCoNpTNrY6mFXAMV/4NzxTew71B2FRF?=
 =?us-ascii?Q?W0QCzTGONUiG/TBIEEREta07zgpUKGxtSJdduO1qr0y0axRyl6qdKh+eHkUq?=
 =?us-ascii?Q?Fteo1Gqr3EtNfvebBoHozg+bC2fZ6EH7cZyJzhHBF8+cD0LzTKjYFpTPsnjD?=
 =?us-ascii?Q?CD5mlK3+r3Q4w7R1lUGYpdaqnn6rBShFl85/UQNtxDHrQbchI6ebnFVQLSG0?=
 =?us-ascii?Q?yXBQgM+/4CiyxXSF7dwbkKfPaQ3dCWlLnPFbXvmzW7npkDBiNGBJhb9xUE4b?=
 =?us-ascii?Q?3WoPljLcFnjhmeTwd+XFtr8FgN2WEpBhY3YCsYYK/2JjsJu8nB+6l9rMPW/f?=
 =?us-ascii?Q?rqiwpHXXonY/AXjI5eSJJHyBhxIyxUMxeAj1Xvios8AkoBEAoqXqxmO1CZxY?=
 =?us-ascii?Q?1hXUA+UmxEdLD/HXREuPv+kOJqpTmF1vBa+12B32e0X7WAsY5xAgJ8WORZa4?=
 =?us-ascii?Q?3TNEVG013EZzthnwqAHrXUk/mVU2O9AfSf7EG45kYBSqmoHKuRqqpP3UgXw+?=
 =?us-ascii?Q?FdxE0FCZfoEIU6iloGoyINF/SnlTHhyOvpbGY2bjGHxhWFVsZfGnHkVg0vfH?=
 =?us-ascii?Q?iSN3EK2IMDnlxI8FoEp9tXVx2zJ2ob6iXe83ieIsyWz8m4lDDKDdkECf7nVr?=
 =?us-ascii?Q?zJauf771USc4aIx+cc00n2yBG9LVY0lnCNVHFvQZI3+h3YeOfeKSleZvCrv7?=
 =?us-ascii?Q?HJdYSBcyXeLgW1bauU6k1LThLRz6/EkLMCXdz1vonEn1XCVOUQpx7noBHLs8?=
 =?us-ascii?Q?Ft77uKu4Z5vTadKlZg17mLvHlcDyMo0WXy3FiGqJtEDChbQFSSRP1BCvCRma?=
 =?us-ascii?Q?IF647enEJdYIVa7cIEbPfwBQWmtzZJJhEh85NlSTleWxHH6g6BmLhvfHDq3D?=
 =?us-ascii?Q?dSTlEYG0WY753HJZAKQXPP9jU/aws5FjKZKpBVRnWuye6otaKPu1H6iw8qol?=
 =?us-ascii?Q?6qEabxztGJlGmA9glAkZ0lUFdc8IelTE7bpuDUBYCZXss0lgCWzEwFogQSY2?=
 =?us-ascii?Q?j2/KakOTfuvg0YgbIRrXbTaYh/JNsd8hhmPggVYN/k8JOd5Loe8NBiYjwLfH?=
 =?us-ascii?Q?T3m4EYIGIEMzYlcT1lSDcX6pK5EOXS786fSxbjpf4HM8HuxA9z49oWS+Llvp?=
 =?us-ascii?Q?vE5+vmfUWR78m7PAZmml/ooPFcIFJZ5Wy4le2SK4MdVn1mE0MtRtpJ0taesj?=
 =?us-ascii?Q?7kxddnvtjBjyNvMgyHIq0bAJ7EcKjRYMk6RLO7UOb53lx6YN5KjUsxeVc5Ei?=
 =?us-ascii?Q?Jl4YaO/PiL65eBNqNSlOTnSa11l5YyjoFjznkP/cPhcbDy+BOPtHelZlesle?=
 =?us-ascii?Q?kFzVVMm0tiexl3NySVkFx/Ptc4G2FfPg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:40.0947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067094b0-ebe2-46f7-57f3-08dc9baa0a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
ABMC mode is enabled by default when supported. System can be one mode
at a time (Legacy monitor mode or ABMC mode).

Provide an interface to display the monitor mode on the system.
    $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
    [abmc]
    legacy

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Changed interface name to mbm_mode.
    It will be always available even if ABMC feature is not supported.
    Added description in resctrl.rst about ABMC mode.
    Fixed display abmc and legacy consistantly.

v4: Fixed the checks for legacy and abmc mode. Default it ABMC.

v3: New patch to display ABMC capability.
---
 Documentation/arch/x86/resctrl.rst     | 30 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 26 ++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 30586728a4cd..108e494fd7cc 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,36 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_mode":
+	Reports the list of assignable monitoring features supported. The
+	enclosed brackets indicate which feature is enabled.
+	::
+
+	  cat /sys/fs/resctrl/info/L3_MON/mbm_mode
+	  [abmc]
+	  legacy
+
+	The bandwidth monitoring feature on AMD system only guarantees that
+	RMIDs currently assigned to a processor will be tracked by hardware.
+	The counters of any other RMIDs which are no longer being tracked
+	will be reset to zero. The MBM event counters return "Unavailable"
+	for the RMIDs that are not tracked by hardware. So, there can be
+	only limited number of groups that can give guaranteed monitoring
+	numbers. With ever changing configurations there is no way to
+	definitely know which of these groups are being tracked for certain
+	point of time. Users do not have the option to monitor a group or
+	set of groups for certain period of time without worrying about
+	RMID being reset in between.
+
+	The ABMC feature provides an option to the user to assign a
+	hardware counter to an RMID and monitor the bandwidth as long as
+	it is assigned. The assigned RMID will be tracked by the hardware
+	until the user unassigns it manually. There is no need to worry
+	about counters being reset during this period.
+
+	Without ABMC enabled, monitoring will work in "legacy" mode
+	without assignment option.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 12793762ca24..6c4cb36b4b50 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1245,6 +1245,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
+	resctrl_file_fflags_init("mbm_mode", RFTYPE_MON_INFO);
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 471fc0dbd7c3..3988d7b86817 100644
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
+	if (r->mon.abmc_capable) {
+		if (resctrl_arch_get_abmc_enabled()) {
+			seq_puts(s, "[abmc]\n");
+			seq_puts(s, "legacy\n");
+		} else {
+			seq_puts(s, "abmc\n");
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
@@ -1901,6 +1921,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_mode_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


