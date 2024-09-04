Return-Path: <linux-kernel+bounces-316036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DABFE96CA3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D04B2375A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6632188588;
	Wed,  4 Sep 2024 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZfYRs3/7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB0185B4F;
	Wed,  4 Sep 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488580; cv=fail; b=HHTKIZG+Z/b9U3+Vkw0PB5B8iWK4c+joxSdbA/l5F1CU2d3zuExIR/5H6EpnOg47uVWI4usUetZ/ud+bcDMnqqEn9Ox0ooR/arVhF7xeq9JOGNCrPfXN0yJzQqCb4131IiT9I8FqN6r5akzu9qrM/kkxn9vmyy6L/3HoAL24aq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488580; c=relaxed/simple;
	bh=H7HktOcgalo1pwakBLdvzyzV4sXxINb8frH4QBeQApc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUJj7JFw/dhz/3etnZDU1/DrnSp3uPFF0UKwScP7aEA+ne6XcjRG5+Q5Jata5kk8IS82XsosbbD5N0k3kdY+PA9CXIvguMER7pPqueKzw6PxKoXmef/fLSo4x/OD13ZDFlfZ3nGKb8n1zw1UCl3PCuvvyxzMDenu6XNv19xCWEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZfYRs3/7; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1EJJcIg0nMM+J4HUid6pAAa09DVtkZUk/1vbTpsApu0upnTHJWtKzuhMK6fldUBf/heZkPyQpwF2icp0XZ0Ht+Oe+QAbVzs1565R+f0HRqgZUWxquKprccCN5Eja+NRAFsgbPWyf2JcguwfVYdsc1WWw5I52xagrgP2OlPrGQEen18Zwyu1udIWx944q9rbgwCQtp8zPbgMhM1wSev9c88xPUZctM+QeUBxpt8QnQhRuf7QWtAVb4ZE4LgrJq7qBb11a+yce0pY2eJXesq9p38vqqvIQ8TfiCAg2CsA8V0nlq8edQgraWbZjpdcX3ic5AuTqUWfdLEVeP9XZCQBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ypd3QB0/f18Huy4uNbK4//dmgpLb375PIi5eVqwrvBo=;
 b=EynkrSo/KXnV8OfPXItA3mKDjR0yCQkGapmvBxI1HhDYVHI4er/cSobD0JQhAxFSJtMBAs81PAXyevB+LRTYKw0OAsMtmvUeQmLj4WBAj+K1bd29Z33EFjWyOSayT5TZAsaRz9PPMrbaF74nJ9yM0S3GEq8YlTrASiFYcgxb9rvspLVF7Fu5aCEo3cXcE7icHwqrZTWwRzu85f89fptBG4EIYrrMT3sNPHLkvrAEPN+0oLfaY3tqkb1V9w8PcYVD2sFfgZ43KErNc4El4I0KVuDEpNx9VmSSQ1UCq1TEOIeDG8Eag2ZHakydIe/ywpRyUAPwQG1jqcEvtEV30/3Phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ypd3QB0/f18Huy4uNbK4//dmgpLb375PIi5eVqwrvBo=;
 b=ZfYRs3/7uzlmj5re89rVqmaKbHzVuoU4DVue1Kh37o0jlLURu5cTYNRIY7ou+SBKyywGEnRGiCR5Lexl3TtAbuFFADc3yFzn/3XKskXCn3nLPBiqphTkDFDUGihcOZ5vj7OPRpt3A/NgJduFhhyAdKDbPfZO6//JfDb0hdkTRRU=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:22:54 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::c2) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:52 -0500
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
Subject: [PATCH v7 08/24] x86/resctrl: Introduce interface to display number of monitoring counters
Date: Wed, 4 Sep 2024 17:21:23 -0500
Message-ID: <e7e411b2055c50e036e5c2a833e36aa6d3016d3c.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: f5607f59-fe1c-4e1c-6201-08dccd301f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxkAxlAIVkJMbKj3fPhwRjt/JuGK89sVFnEILaTjPTLh0mpLFBgLLzUp64le?=
 =?us-ascii?Q?89b1pAubwqIEDYS7YRDPuv62mRupML+OjTgAmAPM6qekit9xl8U3HqbXig9G?=
 =?us-ascii?Q?hPYfew6pF5Y7dl/fsR4RvXMNon40wmBF3OGJcwowgKxfUeGQmyP+d+EypQLh?=
 =?us-ascii?Q?7HQAMhEaY/IlMxuCgP81JlijN+lWj42VAJc8IVPBpE+p30ELJjuAPnwwbNLy?=
 =?us-ascii?Q?6gq+6n/L8yH2YKurkOXElGzgP7QPHUbWpGZPruD0RVdpqhMsrVP1rRxONY4/?=
 =?us-ascii?Q?byHOkHggiR6CRXbPjARkRre6Y9XoRi3vrERaslTBsvdAnMizmEqsbSLatBfV?=
 =?us-ascii?Q?Bj+KTT9YSEQedMBLgj2fElwf4nz69Sdow3pYN5NX0c1r0lnuL97CFR1bZf0m?=
 =?us-ascii?Q?zdlCpTV66/ajPRpYALNly1UVnzoSrEJNCZ3KN3kCWhO0FyNsuNmXrFdWUQT2?=
 =?us-ascii?Q?dqPKJGUqEXXymFoX5dEvS8+yJO05cc5K7pJDcGaflq8kleO2jeDXbPOl/pX2?=
 =?us-ascii?Q?N6szXzEdHqiXB130BZMpxfVpKuzZ1jWgWDYTtGpRlv5FEOqyX92MuW9/2C77?=
 =?us-ascii?Q?ZEQ9zS+UNYn+2jM8uH8W22KE2okPr61OgoyeDKXfP8cIDLLhWv+DTN1RsHxj?=
 =?us-ascii?Q?EeefPer16o7cushhQRRA7ydyt5fTYh/7MOzNaxOxXle6yg77yCdW3atssieb?=
 =?us-ascii?Q?8DZ+eg5qj0Atu+asbe0mtvXD8jH+4/PcJqx9/z1v45rpUuHdAR6u9OE+Voi4?=
 =?us-ascii?Q?qowXcVHzvQjtB6xnkPF451nK20uqX29uD/dMrwTePiJ7HhmvR9oXSkJz3Jel?=
 =?us-ascii?Q?t3YPYisi9gV2tkdeoNATIPTSnN6vYQ43r9YldiuC3ttkALhPNu6u9cJUZSfG?=
 =?us-ascii?Q?ihBo4W9GcXIh38zPrb8CVbEnfmv7bOC4OlA8ATStWJYaKsqJWtz1U/JDVuiG?=
 =?us-ascii?Q?2TvQQKaMtgf85UREox9hz3ki+Jcj1j5Z4VCv9QvDkRFvJzUn8LYS6H5lu4QW?=
 =?us-ascii?Q?DHKsHOgwXzTLSmGZBksr2xG206ErPbx217BpRv4sByi8YCn/LX8nr8AHE0Er?=
 =?us-ascii?Q?raHUC51II/DLRS9RrwxKZzNIC/yova5+fQeU3uUNjcC80AJaqkB9krLEf8KJ?=
 =?us-ascii?Q?7FqrJPAJm3wtVKZaM4SNTBl1mJlUk9j9gtl4IkbJS1ascNLyXppfd8j6XSXm?=
 =?us-ascii?Q?e6C+Ajp1OayGq8R/KlBSK7waD+DYXjjqTwg5OvS5IjW2mAFhsDhe0YeQDwdN?=
 =?us-ascii?Q?uWXmvZRPyNJgIV3Jfp8F8BZ+bqLh8bghRwhSrOHn/A9t80Ocl0bS28ERrd0J?=
 =?us-ascii?Q?ZiYM81LuDnlS1uuJsXzApwpxYVe0QFSl2hoUs7XyrpzPVB8JkmE/bdcfNc4Q?=
 =?us-ascii?Q?Unfypf2o8FXEwSOA9ZdMbjI7CoBMdw6G7W5fmXlKYEKEV6pv8YuHvEoiUszT?=
 =?us-ascii?Q?2KzrZl8oSlLls8pT70uNQbxP3vHJc0VP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:54.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5607f59-fe1c-4e1c-6201-08dccd301f52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

The mbm_assign_cntr mode provides an option to the user to assign a
hardware counter to an RMID, event pair and monitor the bandwidth as
long as the counter is assigned. Number of assignments depend on number
of monitoring counters available.

Provide the interface to display the number of monitoring counters
supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Minor commit log text changes.

v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counte
---
 Documentation/arch/x86/resctrl.rst     |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a7b17ad8acb9..3e9302971faf 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -290,6 +290,9 @@ with the following files:
 	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
 	if there is no hardware resource assigned.
 
+"num_mbm_cntrs":
+	The number of monitoring counters available for assignment.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 71fab31e20da..e3e71843401a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1236,6 +1236,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.mbm_cntr_assignable = true;
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
+			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index dbc8c5e63213..ba737890d5c2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -869,6 +869,16 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	seq_printf(s, "%d\n", r->mon.num_mbm_cntrs);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1940,6 +1950,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_cpus_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "num_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_num_mbm_cntrs_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


