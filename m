Return-Path: <linux-kernel+bounces-188675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F028CE53A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30098B219D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4786AFB;
	Fri, 24 May 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xi1fZcnB"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A4127B5F;
	Fri, 24 May 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553483; cv=fail; b=ZtEu7iqJzAGEJwoxjYaRBu5FMqKHR5kUmicn+f3RfzHYzo0wxPcTaWhkpBCmZEuyia/GEEKHZrsyzyjC128Julx7VYwpWm0Aqj0EBV/Arfo50TKYLYOo58BPdL/OUA2EdwcmjV5EswrDpXIe28vo2BKcYwO88ZYIcqpz8P2q3rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553483; c=relaxed/simple;
	bh=4HWxYg7/MW01n629br1BFy17tyZaUvGwwOAdSjYHM1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkbYKsZgtsellOsRUkVLtajGlzPqqJuh89NiXiV8B64C8SZ9GfI5LYdqoECmsxFo6awYGNAGKuQmiGOR8QOQgC4UCUKqmtBtuv63DgtvQ6iUiNcDVdAe9U0SFGks3LfxkG6A1VQAKIXFQXbvoa2J0bdFZ9z1TemGRaX6yGLNvWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xi1fZcnB; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLRUG8Z2XQHmg0iLKwn80UEv3kCFa/A+Vtn2b5dqVWJOfHDaJxbYHIA2ysaiDExstkATvyF733xGCMYM4hWumlaNjMROgJRlmH3BSkQInoT7mK7rz2YXE+VY2lOELfaFoyr05NlDV7Xnw43GYOcsOl1m6xhjZ5rwPkHtZ1sFKyXbxEst4wz2aPwA2TFAX9outJhQ6NPS/8Sy7gz1xvePgx0ue3edyaVeGHfwmeFGYm1EJruuIkuufYkVsg4eYpRC7dauJBNQNmikepeWheznrbyFvnIBUbL6QpKVumS2nGQ3d6U9sH2/OPs0gEsD25l1brm474KsmkSttXtSYp/8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2o1y0r3tFIJdbrw2VEy+jHIQTZ9vVVVOAJA5RaeBhI=;
 b=WkmLDks95iC3A049syF2HtWDvvPiYB8IxU+rNxH1M+sSXs9JUYH5U1zUGbq05sqxswCXQJzxUjmewiI9VIrRHsRCA4fipEZdiJoxvSKsFegUtW9Oz1o1eeKlBJzX9aSSLOigD9TfK7oSW767khxMWyIOJL3M/j2ibOJFz8V0c1cyTKbmtdid/WhmeBIab7+iJZyEBU66LVA8EZyUiKCmaUf6Q03mHJcoaehEyPCrQRt7eZ4iMa626qVRl9UroRd9pIVlr7wvjw4aXnSoSu9onzMDYVAbp6EG/+//gyoP1V3eoj8cV39//CoOukhKCrS6j07GQBNvh1af5V6Xn/U1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2o1y0r3tFIJdbrw2VEy+jHIQTZ9vVVVOAJA5RaeBhI=;
 b=Xi1fZcnBX0r2YRH9GYXP9M4PffYz7EtCyOWOz0Kij7gMjo/LJOlDuha+eEKGuYbt1ASGjCpnjKdM1N93CrXMGLjNJP7rWbQRYN/vbBDm+7vNAoxZxBx1CmMg20/KPX+tdmGKe0wyCnyKcd+wqMFac1oZBKTcN+XfmauRkL0Mcl4=
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 12:24:38 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::85) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Fri, 24 May 2024 12:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:35 -0500
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
Subject: [PATCH v4 06/19] x86/resctrl: Introduce interface to display number of ABMC counters
Date: Fri, 24 May 2024 07:23:25 -0500
Message-ID: <6fdb1c3df8960a9d634a7a904421c63406b1a4b7.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6717a6-e873-4ed3-680a-08dc7bec7a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UiNE0CtQR5tDfx5vaDV4FFVxkGQwtMvY2vmfLtIHwVLwFummdcrmjFtiL1X4?=
 =?us-ascii?Q?Noq7HsZ8hkHMJXNoOU3CYpbgYuig1BQvWeLPOH9ci1DDfy7BnvHMV0TbUDt4?=
 =?us-ascii?Q?/7gurmoVzjyMy2idGVfx28BsAJ3m8WcI4roW/uxoUv1H35S2fOyahw1UfNGv?=
 =?us-ascii?Q?LohX8EmdaxGZzldA6OdYr/Z/KZQljBHRWJEbG/uYvpbxIa0ubxlF7mUiqS9/?=
 =?us-ascii?Q?3C0bNQ/ehRKKD7dNluBhOtSH0xTnrsFxKv1WdhvT7D7J8b5dXyMQG6QS9X4w?=
 =?us-ascii?Q?rwD6BqhLpC0NEZOcz0c7hjSfWZYEimPAsvm/avHWxQbJJvNr0llGwuHCo36u?=
 =?us-ascii?Q?1pvHFeWT9mZZH0uz0docsRBSeBEdwiLxxQEOquqO/EooG1K3reC53kumWNH7?=
 =?us-ascii?Q?fmoYL+7cputj1IOJHgm/MWAgZsjqA+bfQAELP44PVtLwp0VxIUKjnQnqxOwT?=
 =?us-ascii?Q?HwrAhTDnbdndCHPwUDhbDPqJeQNWoDSOm85OADfctGXx7CfBO3RaRZcZ5EZP?=
 =?us-ascii?Q?JSYyAAkwo1iC4vM7oDdkr+5Hzn+AdXT/5SNCjZJUGzRZo8HlnAE+rmenxGyO?=
 =?us-ascii?Q?t5H+2AleCj0mA2L+QdX3uzpFawJxl8bF3wVszULrm/gFYPSdPu1wYwczOm6V?=
 =?us-ascii?Q?S/MQ0w5JNSef8oAqaYQL4nhbU+8fNFkDAsrRyNJ7uH2LdUerIO2aQCgRUuwg?=
 =?us-ascii?Q?5vgV+/Qsp2jMaMgYSfvbz9SYMUgP9PFIugM6Rq9oA29Nd6hE1VxDYlbJ8+kF?=
 =?us-ascii?Q?X8XS+G/P8e+RXShuxwTcefFYqyQf+nBbVt0UpVZprI8pqyOclREo/sKKcjf6?=
 =?us-ascii?Q?XTpjpg0OwOh3TPwNcK/L6Jvd+bgWqFOnJS5cmX5hKfSZBITRXGFfUbWbDbpJ?=
 =?us-ascii?Q?y/i3Iuk0RYDSeF36BaEUtTw80idDwTwR4jxFYZSk49O4DVXAslXJ6oelKNJA?=
 =?us-ascii?Q?vlN/c91AnvUyll3oGEJlMb/dR/xuE1Dn7qqPe+weBFxV70eZyUIxF9DecOPS?=
 =?us-ascii?Q?RMuG7GzO3JFVhBOLw6JyJYwW7mvmWHsQhJK+/hEOs5gwBSvg2fblhueyGixp?=
 =?us-ascii?Q?yE2GneL4fiO6HCmQMUXI9vfPePh9Xyv9os2NDDjQ7xIdKKZW4A6ulYoGhwnF?=
 =?us-ascii?Q?yyYZIGq11Om5My6JXYVGIMeYDpQzYTzjYfWZ0ILJbPp4clcpDdi7bp0ArkmU?=
 =?us-ascii?Q?OMVZOXCFL/qb160LIu1as/BCTP6GxB5Tkfw0x+w/K3XlF/SpQMNCm2QQLC1n?=
 =?us-ascii?Q?ZguVW5RA+JLHjZ4HDCTwSJOEh5TynLn/k/deGXt3z04jDetVmfqhEzYl/vWQ?=
 =?us-ascii?Q?PMbtXE1sZXX03gfzlwwDgFIYEo1lsFqTXUr7e7lrLsaUhJfHU++inh++JhL1?=
 =?us-ascii?Q?rbscA3RUsJtKNtZM6mzkSWtByIKd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:37.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6717a6-e873-4ed3-680a-08dc7bec7a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as the counter
is assigned. Number of assignments depend on number of ABMC counters
available.

Provide the interface to display the number of ABMC counters supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counters.
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 02790efaabcc..7ab8172ef208 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,10 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"num_cntrs":
+	Available when ABMC feature is supported. The number of ABMC counters
+	available for configuration.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 0db9f12debb9..e75a6146068b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1081,6 +1081,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 				WARN(1, "Cannot support more than 64 ABMC counters\n");
 				r->mon.num_cntrs = 64;
 			}
+			resctrl_file_fflags_init("num_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index aa3eb6ea059a..ca692712b393 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -846,6 +846,16 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_num_cntrs_show(struct kernfs_open_file *of,
+				   struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	seq_printf(s, "%d\n", r->mon.num_cntrs);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1911,6 +1921,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_cpus_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "num_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_num_cntrs_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


