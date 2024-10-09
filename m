Return-Path: <linux-kernel+bounces-357615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A4997355
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37CB1F26267
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FE1DE4CE;
	Wed,  9 Oct 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31PdSIyf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE381BE869;
	Wed,  9 Oct 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495678; cv=fail; b=FBtlgF/StCJ4vx+zk/4mAu+owHV+XfsYN3ybnEjMjnSy4fmE2uhmZ9z1DQZqeuCodAhN7cJ7LUCIsFYeNtWJoAzv1uBqvLWuz7dE7dW0zllwG3Dnzyea/ot+Sm4V+cQKmMoezqQKTp/rCex/CdVKXDAlnJCD8xmq6RxUJyAOFcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495678; c=relaxed/simple;
	bh=Ea2fmp5yG2Ao0LwFzh5ZmUfLpUtgfwLekDuPEkIDlA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfCtOJaSmb31u5/PfB1jYsg9hykOff++eQcUbICqnRtuMfmeAtbWCSif6/tVaakbxdDR+WiS2Fr9dcFwZ46hOz7LqZtpqlOl4sEuEAtYLwp55Gbsmvbi7d0C+McGQZIfm7lrIU8ontzuvNFDoWxI7+ins6RO2qHQsY12k/A4Iz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31PdSIyf; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG1RP9VnIV2qgeOiQy1iIjP/fTnFdc9YWkFDZ6WZkHRUGbDiGJ8ZePej0StgvNcFvAPUEvYNeS6l2WcTEEw0oVX+vulOFwiditfzr2gaH4j+uCGpuAD2gsemn8grv+uE6JMglTfnhzzF6L10uCu9Mfd/DT8JnBGvQyMIWQTnYXSrJg6MICuvfGQ+AdizbA6mier9mDIVBDbZCFhs+JzqoHJnm7fYIwiV6uALs0fiuj8/2BnTCed59O9IMGY0HDlcusv1pVgt9HbwFIMcCpsDlNt3TAtdPt9dCsgzVZFwtU28HUAUb6orq5WG0LZGT6AvR2E75Alq21izA1EUpriXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f1Vr0neq7JV8XmCCitwFoc7oxkg8ox0uKV1OWio/bE=;
 b=Awq3Meq6kxflo4/O3+NFOahmgztNY6pLKgIjs9SWgCJDZsSRK9sKt8dE0nHAqFbbYG86CU59Uvr7iQb6Xf07K2YsezdVqKi7Vdoz7xUdNZMGUVrVon1mzFbDxLfdjwsa52guT1vZJ8ZBnqeSd6mCxj34nagIhge17IUYeXNXmYMEszyfESqGwTttNtBYr5EQzWVoo4cd2p09m+sGAoY6qxPVpejHsoKkf5nUSIKTMK/8KYNDYYiFeUQYxrXRpVbNZ/RJJTYAjsWRuF9c/xzzA4zCNtHnI8yzAgeXzxM4d1c2aVyxaet4aMdCEFgTJs4b3dUFJxDcws2erRDEfYdIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f1Vr0neq7JV8XmCCitwFoc7oxkg8ox0uKV1OWio/bE=;
 b=31PdSIyf7ktg6Hv9GCprb479Kw65865svWJR/PDxmVVjF/U5KogJbDSMqet8gsRKodFTZZb2EqOfQvbiUSG0McLE4gOU+KRfaN8yen+iAMUxqOnC0rRNyh62xL+u3dyrutqOGQaZRni0YByFjy319YXW6iwvYK3vM8lYo8tZn3k=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:41:09 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::2) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:08 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:06 -0500
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
Subject: [PATCH v8 08/25] x86/resctrl: Introduce interface to display number of monitoring counters
Date: Wed, 9 Oct 2024 12:39:33 -0500
Message-ID: <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 4410f197-965f-48ae-52f4-08dce8898f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7reEQfTDgiUdKA/lw+rStG/IduNAG+5XlwQ5Za44FJeOvvCay4rT0gwmqEmh?=
 =?us-ascii?Q?OO/iKOPHcCVRFEZdjyCtQTxuGCD8vZSZ+X7kt4Sooc956f7JhejBET60jSME?=
 =?us-ascii?Q?kkVhdPBfRj0m14b7C9o6o9KwEFjQEgXxdxiYJmFeL922QkfHW7OTWgpMHads?=
 =?us-ascii?Q?G18JnRZD9tojaBhK2wnnsSG+J5rdrhUsV37Lfc9JZPB5RnjADJo/8KXuNj5S?=
 =?us-ascii?Q?71nAJl9aWVyFJPNdfvfpiePHUxbNL7evoY1pAN/IEDcFNeY1+ToFMhvIo90T?=
 =?us-ascii?Q?/Pc0S4Tvij+AtyXZiCT/Ji7y0EgJ72nIVxqcVC4zoBI01BOnOzqvePyxvJ3T?=
 =?us-ascii?Q?ImASoJYsizTr14g4FqynT/Z6bB9IqezFnuLNE9GrppWOPi6PeLDIxyVuXiZL?=
 =?us-ascii?Q?i/0Fnpt151ukGbEqkBHFSiOTwKVqjNMtK7HjXPGA6oGD+45NTk9f4zxmIwpD?=
 =?us-ascii?Q?KTNnjYbuHsofXWT/pyyjRzx87xt97uoGj1O1z7MPf9lrdjT/y+KTpZOQiK2x?=
 =?us-ascii?Q?rtJPBX51oZ3KAUIDYDDI8CndxxGpyoAqhRJ4EECK494653wOlwqskWz+4nOE?=
 =?us-ascii?Q?iM5gqPB7SK7ycVzx+Qq2EM6Q8tKT2hvtFqt9oL/Q8pHwynhXRcT49TMdy5sZ?=
 =?us-ascii?Q?PS+KFRS2xVL3ulfFPDerhNsKAn6oJSsrZ1AeUpfoePXhcTGDvEyXX3bfzgtX?=
 =?us-ascii?Q?HCXdUyKb1x7RtSPJS6Z0A2IdCV/majLFNWhaK7qZe9Rlv9LARH5l8hFD9u9c?=
 =?us-ascii?Q?/diwy2dbvNbic2lwCqv1UhLxzaWbm08U1I4IgbrZ5q6wp6weJQnFVMCP6bmZ?=
 =?us-ascii?Q?1IWPKndbjUaCT/Jy1uNEB6yJPuEeJGCLN1sbSQdT/Mi+d2bdyVXX4eMG0/NN?=
 =?us-ascii?Q?n9DCXp6BZ5EljXXvIOFXTUzuEIjtjQVXBgl2cTLx579oBfkBw3pKEUJ2fxx9?=
 =?us-ascii?Q?VtyW4BM4TrJpnrpIlK8VKfC1dJhky+2T+hXk09nCJVSDXYwTe7oqsZwo0mDy?=
 =?us-ascii?Q?wUTC97Z0cJEGeKFLZI15d9tPVZkWF1OjUzlpl8VQV1L6ZB/rn5ovDVtisohz?=
 =?us-ascii?Q?/OFpQvLo/1bSoP508pXVuWZ4XbfDMJTcpb2ytw5KZUY//Dc189QjBvLkhvFa?=
 =?us-ascii?Q?IAMzI2haOYb2w/GJvK1XqoibNWfoaf1+3s645xaTHAnFhH1s09r/tWS71GHX?=
 =?us-ascii?Q?0TPWfegcvFiL8VBltV6VfSeWRN4akRE2KyW2cnlj0cTh19CiAN6voxLSNNNX?=
 =?us-ascii?Q?feS1d/9yHN4OecPnXCM7DT05v4IhNji1B50HqGGdMMfY3ilX67uZnlDLdUCi?=
 =?us-ascii?Q?3ijrqwkERdXDn5gdVUL2IQDcfdnWfsfsE6IY5YV5YHkcxFxdUwTcKQC8B90u?=
 =?us-ascii?Q?b/rSpZE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:08.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4410f197-965f-48ae-52f4-08dce8898f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

The mbm_cntr_assign mode provides an option to the user to assign a
counter to an RMID, event pair and monitor the bandwidth as long as
the counter is assigned. Number of assignments depend on number of
monitoring counters available.

Provide the interface to display the number of monitoring counters
supported. The interface file 'num_mbm_cntrs' is available when an
architecture supports mbm_cntr_assign mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Commit message update and documentation update.

v7: Minor commit log text changes.

v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counte
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index e4a7d6e815f6..1b5c05a35793 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -291,6 +291,10 @@ with the following files:
 	that case reading the mbm_total_bytes and mbm_local_bytes may report
 	'Unavailable' if there is no counter associated with that group.
 
+"num_mbm_cntrs":
+	The number of monitoring counters available for assignment when the
+	architecture supports mbm_cntr_assign mode.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2f3bf4529498..7aa579a99501 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1236,6 +1236,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.mbm_cntr_assignable = true;
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 895264c207c7..c48b5450e6c2 100644
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


