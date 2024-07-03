Return-Path: <linux-kernel+bounces-240266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B031E926AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E1F1F21DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C92194A59;
	Wed,  3 Jul 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3FzDf8eb"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C518C324;
	Wed,  3 Jul 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043465; cv=fail; b=tNak4ghh6imza9+30nEd7jKgRpDXF386JYVo9RMmgAPg9vtbV202afgExKj3eP5V9Bpu/cN0WVloo3tDl6C9cRX0N3RvbCkdIgwrJjAA2vozhYqQB68VZ8BQ9pJEFvra0oz7yCEHFhQq+gMTX2AFHjagOeFF10TCnIrJcnLH7mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043465; c=relaxed/simple;
	bh=f/HA/QX6zsMaNfWQOxMrh8GDt6ran5sR3ITfr4p9R+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJCvgpt3ht6OiagR0Y+SDjvwlerOSMRzicUkf53VywMTpU+egnXXNjzZzUhQA6P8ETU6pD9U4MWswrGJPzJfOOiFuAjdWSw+iGhQbzSRUL6oTLFkh7F/iwXxo4uUB6E93io0Cqw1ejUaIjMdxm3PMd0psk9JAmVoEAVt9OjR0ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3FzDf8eb; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaC/cVNUUOHMS5QBuoxl7GwYiumYRp17q9gQ26uu25V/ToMggdr5vU+whWPd8gc05cqXCa2GPfIUBIXRBHObWecw0Wo22SxjBNU4Q1dPMRWn/PyZq99WUgkgB7GiUAGhVZsq3eRJzyhuaOncUKHc+pYO/DE4cnemBaxvy2hBH2+1uiKHItO4AlwolJyfZJ2oBeV73y4xYF5bMvxxssLVZMOSTTaSBkwD49A4YVSJc8VYbqkRHVrq2uMQwU0yyV7du2Xsypz5VGqMfKk06dgOpBaEl0r+ViVpYQXPCuDlohfMB+/ETJg4cpQ0znM4CjrLXAYeeYz2IBvcKSXD35hA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCiFcgbTGtyAX2wkmjQHp1CwB9DcWvfaBtFqiqTBEsI=;
 b=NsiCj54qRZqU+5t9fJ1ookdIEPXmo6y5t9oWXuf72C7m1lt0a7dof7lyvR9Rq0vrcooQmGQlUVSna12ZLfylJFAX4agZ+HJDUADJW9Su2qlE4a0EwHH2toCWUwJaM5/DzRFqAMLSWaCHpKnPUo0uRYFrnwb8j6c9wfcd1asTlC46VhtazqizSsVgFlapswzy84rJ6ajWQbD67nr0gs1suAj0VKVjveLbyzcfIFmIRrjO+D9HOI8A0aqbRwo+1wCsl2yHBa47G+0mcYhrHF0JlXqm6uOS4lUfPccXft1smLXszAgbSGBhnN/vLXcmBZWgTe2h/vooGg4rCHWw3E9BNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCiFcgbTGtyAX2wkmjQHp1CwB9DcWvfaBtFqiqTBEsI=;
 b=3FzDf8ebjR+xhQpOZvGCCh2fh5BWNu20E7HAnQ9PpK6RuncGar4IBbAUBhQTA1zdl2Nd7XnkBbo9NrQ/IOFnbI46tEdaQ9y0Ne0ev1PDBKCbQ4hG9tDXgRMa1qTUOFQVDSfKiJgNyWUsXs+h0mnoDdad4NBOzi0ZZt80t1BntZc=
Received: from CH2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610::34) by
 DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.23; Wed, 3 Jul 2024 21:50:59 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::af) by CH2PR05CA0021.outlook.office365.com
 (2603:10b6:610::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:57 -0500
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
Subject: [PATCH v5 17/20] x86/resctrl: Introduce the interface switch between monitor modes
Date: Wed, 3 Jul 2024 16:48:28 -0500
Message-ID: <cce527151843aaa1a6001c75a17ee46108821233.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b4745f-348a-4db9-1a8e-08dc9baa3992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykFPAnPfLBmT2+p7N7qMD+VyQqzkES6NdedzMdtg4+Yq7TTskdmeAPEHD0DG?=
 =?us-ascii?Q?tC1gThAVtk7GN+VXMdIzQ06l/mfYe+yiVIr3Ds1b7IplgiLb1SatXz4G1vxR?=
 =?us-ascii?Q?RcOnvnhrx4UK60ng3NJUs5M66XKNQIH4k+Q7UwsNPFcONkcTT3ZR3MwDZZzU?=
 =?us-ascii?Q?e0wnF1Y+o1MmUbIdUVpvf5k0pJAkQRvzWs/N5NkAEVUonx/DGeRcV/Z+dC+C?=
 =?us-ascii?Q?gSRBHqqnn9f0hAdaGEvS21MLQuSLCQnyC5afVrJxsL1Y+xAt4xl7fhFQBZn7?=
 =?us-ascii?Q?SmGJQ1ClqvRhyXhSXDLCNposeEQMYwuqBCDKm0uxpZXfCchq0VFOvYOyfhOg?=
 =?us-ascii?Q?XD+xhbuW+bboc8QOpGihkSP94NtMG9PwV8iK7rYdRlL3FUsHT9GJvhZ0jLcb?=
 =?us-ascii?Q?+LwrCZoFuBLVHoJyntsPaLhBHYrvsceClqGH15jQaIiK9Vu/arSxhXHQ54Ps?=
 =?us-ascii?Q?ZVcCDhTRwa0hdnSBCIsqlR03SCoVT94fVwzFDh+VwL6QTkUD3fQaVDrb5q0Q?=
 =?us-ascii?Q?5kw7L8mI6Z76hUeVSzLeRJ6aLZM/kY2qgiVfFR1IjeJ1OO+8FNqIBe6oZ5tO?=
 =?us-ascii?Q?fkp9EgKarhmPcU3+k44vxD8oKRGSAuxwEu/BMGEPuFJKN049o0PZS7gubimt?=
 =?us-ascii?Q?apMtEJXmP8jHa+RqGVcB4xdtYp/CmVyf2niUYi9wBg0TjqjqzixAVQ/hAesH?=
 =?us-ascii?Q?zF1eEHg94EzZtKfipLUNmbubg+6wMgkCq5Npc4HYQni0dPh1E/kgI81OYb8I?=
 =?us-ascii?Q?t2KuGIX7RiHn3+DttVkJ8N61LgGNCwO9LiTUupu+lYjVdpX73tEAMp2vGV7I?=
 =?us-ascii?Q?0kCoZTeXig2ypF+V7dUk9lGIMOUm8Rbm7+ek0FFrKKrNPqzsPIJrTY6lXmRq?=
 =?us-ascii?Q?99EKfFAbx4VoRFc6vz9hUQwR4bIBcD3u4XgprHvPu9S4XKWO0VsDfPHyZAAC?=
 =?us-ascii?Q?xiYoEneDMopSU8QvIItD0G3R6JggtABd8A/9Dvw6lcjuPCmMRlyXpdOxGyin?=
 =?us-ascii?Q?2UywjKRsKBSfeWUN1ch1b4VwRZvVbqxPKvunXicrXjCCgcDxnJVelUirj6jP?=
 =?us-ascii?Q?muGEiscHwpDDzvR3aWR5XzHQKSzBgXh4eYz4EN34dYU6npjbgnRibKWDFj8z?=
 =?us-ascii?Q?FR3AMCbnEX5+r+7LZm6VBg0uTAzkWbHAY9ePfzTnsRbGVs5opYsF6ofqTkaQ?=
 =?us-ascii?Q?3DT44odtv6dkXwURnyIr+SCzhkVBAdltcvyIoxqv//ES31lgzvpeO+0cb8mF?=
 =?us-ascii?Q?y3LEN9XA5AJVTqpv31Dd3+EVlhd2vyqKxtOGHFjwf9c3bNOIcQUkCq9xf5jW?=
 =?us-ascii?Q?aWNp6QSb4mseUQhyGP0RQ/O4OG734339cIMRIheqCgrcX5m6OVgKC9/RAcVj?=
 =?us-ascii?Q?HczdkiHmX6pHooj2CHLfMNUhcSk4KyhOKzK0RqmQtimnRKmEiGD+F9ArPWh7?=
 =?us-ascii?Q?h51j5a6l1KGq2XHawm/2BcO2NCn9/9d5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:59.0514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b4745f-348a-4db9-1a8e-08dc9baa3992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

Introduce interface to switch between ABMC and legacy modes.

By default ABMC is enabled on boot if the feature is available.
Provide the interface to go back to legacy mode if required.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_mode
[abmc]
legacy

To enable the legacy monitoring feature:
$ echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Minor commit text changes. Keep the default to ABMC when supported.
    Fixed comments to reflect changed interface "mbm_mode".

v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 10 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 37 +++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 11b7a5f26b40..4c41c5622627 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -291,6 +291,16 @@ with the following files:
 	Without ABMC enabled, monitoring will work in "legacy" mode
 	without assignment option.
 
+	* To enable ABMC feature:
+	  ::
+
+	    # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_mode
+
+	* To enable the legacy monitoring feature:
+	  ::
+
+	    # echo  "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
+
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment.
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 475a0c7b2a25..531233779f8d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -910,6 +910,40 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
+				       char *buf, size_t nbytes,
+				       loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret = 0;
+
+	if (!r->mon.abmc_capable)
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
+	if (!strcmp(buf, "legacy"))
+		resctrl_arch_abmc_disable();
+	else if (!strcmp(buf, "abmc"))
+		ret = resctrl_arch_abmc_enable();
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
@@ -2103,9 +2137,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_mode_show,
+		.write		= rdtgroup_mbm_mode_write,
 	},
 	{
 		.name		= "cpus",
-- 
2.34.1


