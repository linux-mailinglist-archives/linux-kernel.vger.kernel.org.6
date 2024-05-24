Return-Path: <linux-kernel+bounces-188677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5BA8CE53F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE5C1C214AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3686659;
	Fri, 24 May 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EaYAypOI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ACF86641;
	Fri, 24 May 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553504; cv=fail; b=kJV6zH3AbsiuSEMdk/8sPJYM1QsKYzWTIduTRMlM7QX7UP9A9IiljwB0a6ddpjvgviQRKEj4oTjE7iOqA/OZszaMf63lWim2Jh4C+GfdOLRS5x7gRTIrZn9IvvYGPgPhJB0MoiQiOmwMOTkHwKTQRqZKFtfAxNMv45Hq3+/Dagg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553504; c=relaxed/simple;
	bh=Sy0o7OKV9TwXYaAOITt5m3IrokHc82nhnFX1BtYREmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ba+g0nxcqmWD9B5tThszb3pzSl22q/o6ixgFtdLBr7BPMDfAnwwyYHv7y6+tzfGa5+g1hssMAWTz7CTx05FSYNTOTRWziabTDvFIDdWDu62uoM1nS1UwjExKc4Wrd0l9rQ2SdIGr6YZfvFCT9O8+WdRWvbDzQiXzR4MUj5gTlfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EaYAypOI; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA30TzN9Lk9Css60yuE9yuvgDTkxC86vRLNz4PC7a2rSPSglScCjeKLv/bpPoHWx6eX3tZjt8HOybiR813P1VgTVNnDXG6M+NCI4NX8jmB/ln1dLYkfo72NaBlrmbzMkQny/8gO8FhyWHe+LxmPz3hI4/TweduewfCWLmT9hYFIDHoLz6QYumXzxXiTeJAjJ5neLZy+nnklFGIwSOFX2cb4vmUfQ18rvmAqwPsTtQU2R2tkEm4g37WYX86fgY8BTPF0KPo6UTdDflGi1nVPm8sZ5taMbXtN0KzGuzLmzqFl7gBWLz4O+bbXclmkuDNmG+uaGCilYM980YmZem6FPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpiA1ns0tP4/JeEE5F3LV8xqPrgtkmMxjnFtl//7eFw=;
 b=m+AgYxcODdWpx3JMUnUYOO+MqyXv/KCtHc6JE+ywYJQiYC36a17IY3ZJ8/MC+867HAHTlE+BSo7UGGYDs+4stgsvG/s1zAJH1IRq4MKpSSOAOs4+4PmVSLE3H40ap5JDcpwDKSNyXUrd2cMnh718t+p+kzQsANDrRM+JnKr9jytFLdx26sM/pWMnn+0frY+ta3IGGcgeFiTpZJhT55xC1I5/1gY+qFg0rFY90Iv8TwPLEwGqZ/Awu9whB9YFt98bjW+MLOO0+Lvdf2UudaXb1F/mByVV9ODOHbfNbQIfuPIChHVpz1E8e7IqyIPI7kf5q8VBUNk7PHRd34/6yqP+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpiA1ns0tP4/JeEE5F3LV8xqPrgtkmMxjnFtl//7eFw=;
 b=EaYAypOIuXpIxE/0FgeC5dfOq8+jZkZ/DPK+XhAr/ZLe6RqvqfHjuiW/EPqgfz6OvXgArhiat1iP6g4WskoN6hRjEmRkCE0eaVtW8A3iMXoCwzn1dJ1QUmHkHTC3LCO3oInGhHHV4FPNI+vhYTZrxSquiLqfMFtSzb9I3cZZJqI=
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:24:56 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::eb) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.5 via Frontend
 Transport; Fri, 24 May 2024 12:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:53 -0500
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
Subject: [PATCH v4 08/19] x86/resctrl: Introduce the interface to display monitor mode
Date: Fri, 24 May 2024 07:23:27 -0500
Message-ID: <3b9ef8bc03c1004794a087537c6f2f051760402d.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 801b6850-356c-4117-b0de-08dc7bec854f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWg8KhlMf/iAxIo750FL8ZnCZk39adeyPgSJvThLcuNwOmtGOiqO+5O77ur3?=
 =?us-ascii?Q?A8d/3nG2u1HUzsfVd3iW1u5mqa+e9rug7EFb7PRpU3y/UEHjKbFHTqlHN8UG?=
 =?us-ascii?Q?j7aEmSMhOlK0P5MChYEoI4ISrF0i0TfqS2ww8U7a6nhNTjpYAJPdKoGVjrJl?=
 =?us-ascii?Q?3Z71/4+7eavq+1XRA/Fu5o5t4gE0nT3Eo6atnCOtFtAaL5hEGGI7/hyeCh9g?=
 =?us-ascii?Q?ptVPVcrQewxnt9RY2Egcd99aWAGu7N6zvW8t9mRJMWmczJIa60LABgct0nV1?=
 =?us-ascii?Q?LJIy54PU5KCgoWOHGTEJp+DM8tLb0drqzKYQ/u9gUntQlPSlpg/fDmwEpgE8?=
 =?us-ascii?Q?vn1/BieLolQisr6ZocLftIEbQa20EdEztPpz0AR/kQCIN7rC2VkRAJqjO/c6?=
 =?us-ascii?Q?7InuOBOU4E7dMp7923zE5y7P/Zx1g54H8z741SAfAdxWpQculPkxYnB5/Jj5?=
 =?us-ascii?Q?C4g+BOsJs2rjA7ur+cN2Ij5U2wwdyIaTZMLm20GOuu1OxzA4ye80Jq8Cu5eS?=
 =?us-ascii?Q?eLci8j5LgCKY++VoRWQi1i1lDYKjuGEOzKJYpQ30zd6gvlVxp2nMaeedE+ZV?=
 =?us-ascii?Q?OUyYxJgTfVims7CioZZRsEs8bBLsfdj7pwUKUjEGD6aXQDAcc37lZYilxvO1?=
 =?us-ascii?Q?M2NrX0zn1CL2mMy4QDqV1qL3vykwoIGvNLFOziD4f6qZNnYKyJcXnZGMnxCD?=
 =?us-ascii?Q?/BWisbANp0URw3sLRra1ViAegf3RSn6Kk4y/Tjs0vyOSAEuHS22967GBwHVA?=
 =?us-ascii?Q?vawJVfxN2S1caVSG6y0IHLP/vRnunsB2RrqGT2CGovOys3OYFguremW5aUQy?=
 =?us-ascii?Q?dUi5ou5VghyfIvpa4VRr5vYKX8kAqApD4zG80RytmgKkupRIUanxpn6sng/c?=
 =?us-ascii?Q?2cEJ1D5iTWbMo1dr+QQ37sKTi6DWHwBu57mk6+w61tz49/eWZj4iDKLSA10Q?=
 =?us-ascii?Q?i/Y0orfeFpul3/xfoyFFB9LtPVrd4Mb9LpQxxyMfDRLC3X3sMDig4eGXhwOc?=
 =?us-ascii?Q?vvDUjSg6bQgrkxOkKdhFs7K9/SphSBfB8LNd6L4eKbbcwZgHf88d12mXCav6?=
 =?us-ascii?Q?aBkYeH1Akdosec8g13aL515wdsyUop4vwQ6Kw17jy3YSikKVtJ5UeWK5eD7u?=
 =?us-ascii?Q?dMvSesgYMg987rG5rgZ9icSIlWgUVNBVbxtwRtGrvkYpOoB8rq5+oT0jUzGF?=
 =?us-ascii?Q?rax0AdKLMPiqBeQge96oku5DmCXEh+t7lq3IvEO64WBX2zgb4plPIjAtXXzn?=
 =?us-ascii?Q?w1arsbALgGnPe4/ypVEYbYwd8QoJwpGrM9yM4GnBeM1mRjYgHxUUc2kejOJi?=
 =?us-ascii?Q?eKUkieMctMPRrgt9sU0PMeRdNiEb9PgC3Pp5i/d1sIdL8VKb0pQhT/WeWhPe?=
 =?us-ascii?Q?HD30SWzf0d7G1xkP5vqZ4BmVafDw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:55.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801b6850-356c-4117-b0de-08dc7bec854f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
ABMC mode is enabled by default when supported. System can be one mode
at a time (Legacy monitor mode or ABMC mode).

Provide an interface to display the monitor mode on the system.
    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
    [abmc]
    legacy

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Fixed the checks for legacy and abmc mode. Default it ABMC.

v3: New patch to display ABMC capability.
---
 Documentation/arch/x86/resctrl.rst     | 10 ++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 7ab8172ef208..ab3cde61a124 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -261,6 +261,16 @@ with the following files:
 	Available when ABMC feature is supported. The number of ABMC counters
 	available for configuration.
 
+"mbm_assign":
+	Available when ABMC feature is supported. Reports the list of assignable
+	monitoring features supported. The enclosed brackets indicate which
+	feature is enabled.
+	::
+
+	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign
+	  [abmc]
+	  mbm_legacy
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e75a6146068b..b1d002e5e93d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1071,6 +1071,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
 			r->abmc_capable = true;
+			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
 			/*
 			 * Query CPUID_Fn80000020_EBX_x05 for number of
 			 * ABMC counters
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9148d1234ede..3071bbb7a15e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -856,6 +856,23 @@ static int rdtgroup_num_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
+				    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (hw_res->abmc_enabled) {
+		seq_puts(s, "[abmc]\n");
+		seq_puts(s, "mbm_legacy\n");
+	} else {
+		seq_puts(s, "abmc\n");
+		seq_puts(s, "[mbm_legacy]\n");
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1913,6 +1930,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assign",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


