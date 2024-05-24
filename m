Return-Path: <linux-kernel+bounces-188688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB68CE558
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A77C1F2112D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CAA12BF25;
	Fri, 24 May 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3wS4nzC5"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DB12BF21;
	Fri, 24 May 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553574; cv=fail; b=Clk3BeL2Ik0EMPFyx/0Y4aeiVvikGeWIsDqVEi/hXKEOruDIDoI9Bd122ZVRiEkC9ay0ys3BmXGLIRepwMhZ/vsun28JIEMckWE7BfWfS7pPSCbq6JJCmDpu1ivcZFHTHYdrlIzYr1qSUF/oKiwFX8JsP8Y06dAe5IiBgi/b0zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553574; c=relaxed/simple;
	bh=7pMpJPwYmQG3OUVaU+O9y2wkYIxvAd+uGjVgu0cCTvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi0cJPddS4fEjXn/KkVmTpBMIKTsS9a0LtJxU7SKg6YE2iXjkjM0LVTnG5x6E++IzEx5DJYB9/OcCnyHN31JOyseQIbGqD2aeMtBRcpITuYpIbMM21ti4+tVO8sb9wjoKRSjt1nhm+Y6LhWALTxPVRFgLjszdwTzcDk0HnMojlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3wS4nzC5; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5ccaILi4ZWdUhmjNX0nM/kJwzyxra/oq7smuccedEHPxdAoXIvlq5psKrLrxPLlB3wDFkvjUt0gIEVwJQwV8sJU582arraU2HZinqZXJ8EkyV9WIS6RS+bhWqwF/FKkFynNUcUqLAE41MHxSRAQMyZ2VjUkRUWIvVRXRIaBFfx54y7YplSRzW5DCvtB2bPsFdTvOH4XLPAB8HBuaN16UkxoY+v0p5rMviWZBrS1haQQ1t2q9RhnBnuXyA9mNiBYayeXfABv3pimELbh6dMga3YXkpz4BBt2wro25xlL7KHxvWC09vIPSp6O21yopVHUZBLteoEzvnm3wFBtSCwszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jM0HK9qadAanc/hbgco/nwFz9NBWlxttnJE9nwpprQ=;
 b=cFBgIQ7DPoyrhF3VxIdnQRQHEqfn/XbDIVokffAiNIr86aA11w+KQSBHp/NyjNB6aMSPzyalM3nRMvz/A000kF3aMMSJUKus7ismCDpjwSRZUX7vUPm5j4hKXaHRmNGRM3OfK+AmpDWXdI162xya7hje0yNpo+boCRt15ZleLC4xZDR75lvvCgJZ10RwFbl2laTYlVT154rFK2T5BzvMC2xN/kM087VDPVUEEWk+WTVYSS98yhzFs5KmqeGzHJ53RKoF8D+NizCZsnjxjf5TSm7jH9y/pOaH8BJDBLmgz1tgMk2gnsxt72Q/5LsuMtiwKgwJWW1av57dYNOYgUiigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jM0HK9qadAanc/hbgco/nwFz9NBWlxttnJE9nwpprQ=;
 b=3wS4nzC5JvVL1Zh1hlvT7BuhnO7aj921XK6caOfmFWaIhINEWzfo4WDgFoVh4wrP1as2qHwkpqDLtt+Ja1LxSEnGyl1Ri1NbSRLpL+5YjSGqL/cDl71XThn7TnDVpvtHGpps2pgx6wotkqyeseprtpuMPg0wn3+qHQ8CgLrjTEc=
Received: from CH0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:610:33::19)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:26:10 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::98) by CH0PR08CA0014.outlook.office365.com
 (2603:10b6:610:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:26:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:26:08 -0500
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
Subject: [PATCH v4 17/19] x86/resctrl: Introduce the interface switch between ABMC and mbm_legacy
Date: Fri, 24 May 2024 07:23:36 -0500
Message-ID: <0148e3317b0de3b5d1eaa58af37a2910783a69c9.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ec3c51-09ef-4dff-9e30-08dc7becb178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zwL0Yxz+Io1vCE/gydVTwh4LAr71gQdKpqCOmjFMiLTo8c8oIL5z+d7Ox/84?=
 =?us-ascii?Q?WTMXB6lVWwxAegASM9RNli9q4RuqmlQJ2RyP5PXaBFg6xt2LVoHD6uQdraJG?=
 =?us-ascii?Q?ximyaRca94sBRfzoTjcAIKGFaoFBXfmzVTB/lvFz1CLHEOIGm7L1Wj43A+aH?=
 =?us-ascii?Q?fX5OQ+Oa5pLxd+erl8EZYhxDIb1Z+GXBsqaQYMGiNDUHkZ0OdSdUGc9rm2PE?=
 =?us-ascii?Q?jP7SVecdeQiHkcngGhB4UOY8AUQeUSzNkR4gh0/4eZvZydWb7j/CspYtP1li?=
 =?us-ascii?Q?eNWSeItBcFPr3Ndeuj7cjyag0l/Iu5jF6jcswJo6cyKKJeDP7QT++Jp30IP3?=
 =?us-ascii?Q?eyQeAW4rt+H+ARhKdKUPZQXguYzS9Teo4nW6S90qNjAeH1wLviIeTxRGgNuJ?=
 =?us-ascii?Q?CQbAujkQEkbyWqpy62o1Z6OSWHuyUyYF3Od9Sx6HIr1oy9Nvl44YJsvZ3msH?=
 =?us-ascii?Q?NBgWc0jLjU8bMR2GNC8ObO/pS7O5KKnhlyKWOvCOarQYiymUn99NxHR2Bi4E?=
 =?us-ascii?Q?cGbDjn7bZY8Z7EemI9Chct+GKn4fFuh+6p+/DSZlBm9xS+1oZg14sqEzc4ud?=
 =?us-ascii?Q?zmJD/ljaZBXWusIgsP3OaW79NTJHH0Zz9h9V20MnJK+2lGi7MyOJQQ6LHxED?=
 =?us-ascii?Q?VYYkrnAvdgHGzsdWv0uxjbmOaW3UUksW5WAJSb0eLz9Emc46DhEnP6G7od/k?=
 =?us-ascii?Q?4SaRXaH8Dhd6qr2JBGVwoogGC6FdRmrZQDXJQr0XLvOVzH7oQ/NOmxkPDeIv?=
 =?us-ascii?Q?3qzGLSsrfZLH+rmSwiB2PkSOT5dpFtVyXDX7Jz4c5iyQU7c4/fyH2YF5rOTh?=
 =?us-ascii?Q?GeWPjLfcTce2waIbmjzbCk6z+nOzdHSWQCiVPLPRLbefjLK8JQdHAgG31F+y?=
 =?us-ascii?Q?m+geXgvOwF1ELsN/rEKtfSFcL74uASw8Nju9pa9zhuNDGFwK/30XGolyBKvn?=
 =?us-ascii?Q?Y2QgzA1g2Ti6bjfl45S9cnXqFz/w6IZP6qRMM1yrhmXzAFWKXLS8bzSyILpY?=
 =?us-ascii?Q?VkBJ5ok1iimBbNztHVAPwyuKxZdKkU5E30NuSQ3otIwQvLql4PdehNJZPjK6?=
 =?us-ascii?Q?Z6L9GLV/92Y87VXoXd9poWUqITtAFn6Uxl/UtZdoiyXAFcHMS6hXDsukq+b6?=
 =?us-ascii?Q?LhCL1XUIPF/oUQMpSntjNyAsMpW3cEf5p9vJ5AUE7AyI7cfXKezLv4jYyOeo?=
 =?us-ascii?Q?7XvZGiQwW3DJynmYPKjjzbYhV0iC7nIINmmQYWZk+pnZMq8EhEph4jDOMQw+?=
 =?us-ascii?Q?tYZ7Bw6oNi9KZz1mwOqYhkh5vB2AUWPTeNikWz3lrU2mFQmlQEUHTeXTyS+x?=
 =?us-ascii?Q?kinH1lnt8wcArePpvb1dT3kBdAAlNw3aVyMN5PaOttJ0AwdkaeQOhQd2ikAO?=
 =?us-ascii?Q?7jzvc0Pr6dPGk4szTMMOZz5uNLSe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:26:09.8956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ec3c51-09ef-4dff-9e30-08dc7becb178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

Introduce interface to switch between ABMC and legacy_mbm modes.

By default ABMC is enabled on resctrl mount if the feature is available.
However, user will have the option to go back to legacy_mbm if required.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign
[abmc]
mbm_legacy

To enable the legacy monitoring feature:
$ echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Minor commit text changes. Keep the default to ABMC when supported.

v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 10 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index ab3cde61a124..fd050d4d22cd 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -271,6 +271,16 @@ with the following files:
 	  [abmc]
 	  mbm_legacy
 
+	* To enable ABMC feature:
+	  ::
+
+	    # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_assign
+
+	* To enable the legacy monitoring feature:
+	  ::
+
+	    # echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f452b6d9bb99..d77ff059269a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -908,6 +908,43 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * rdtgroup_mode_write - Modify the resource group's mode
+ */
+static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes,
+					 loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret = 0;
+
+	if (!r->abmc_capable)
+		return -EINVAL;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "mbm_legacy"))
+		resctrl_abmc_disable(RDT_RESOURCE_L3);
+	else if (!strcmp(buf, "abmc"))
+		ret = resctrl_abmc_enable(RDT_RESOURCE_L3);
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2087,9 +2124,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_show,
+		.write		= rdtgroup_mbm_assign_write,
 	},
 	{
 		.name		= "cpus",
-- 
2.34.1


