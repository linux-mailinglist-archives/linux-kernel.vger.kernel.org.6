Return-Path: <linux-kernel+bounces-441967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D439ED62B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8877316537E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2B3236940;
	Wed, 11 Dec 2024 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fvarJAJa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7E236922
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943472; cv=fail; b=sryyDLNz0Xk52a4TDL/PqGC5XO5kcdVStUdV1rwQOKzKRIz9GwjL8RCAd4Nacr5Gpt5m1e5QXxHQn8LMogE4We88Cii67ERJXavk9hWFOAh1zH80VV7JKIGkekkmrSPj24JlQOiZ5xc5wlgTxUHXLl0W7DhEneR3krtGxAZAFbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943472; c=relaxed/simple;
	bh=jfbFhRvWdBJCN7Ujoprw7/0NCMifpSme5/gHONEu90g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQbrhFCj51tYuZ0QnJOG802fF+vGhHRA5doim3VgUC6+9Ai1VZGsYa8D4iMbHgykOpy3g989YO1iNN0Fgt/7A1r6XNbH8Y6xUOpVvIGOy5nOgSD9ea48DT6hgMfVEZ07tH4P28P2PBapzmTIiDTNV2O7rQKauEghvps+KDaOKi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fvarJAJa; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkwE0I7ubU93CRnL1tsPPhiKhYxyJV6Cz9w19V1WYG5s5Z7ZX3DT45VXS/HPPN0GUDnDlD3UHxWITYSpxelUmjzloHtbeNSHSEZBOe3WvF5ZSkwR3zRs4l7/w/7r9oH7nSQHM45Fq0twIKcK6mdKWDs1nLz9HwKtvvLOMbyCZhE/sH9Yp7u2+7iuCU5ufhzlnfhdq/V4ORmI9VnMyLEgoJxGsScNoxOV8xwiWjo5o2F8LHrUp5e5v5Eq8+oeMAztLRIN/2fVYmfYoekMnJ862eiXlzzgFECPeWN4+MfeokqiNN3R/YBnLeJgBhe/ftssrbzeCPZXjFZCzbqkUVA7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+84XmnE6pEcSd/r4oC/BHypl2a4yj76z0zfZN2bEkU=;
 b=bgEs0ZcVvyKaBTsU/+gv2A1Xi9BEAU3cVRn2OZ32DJXiT7QcbFI8u7fp/VwSqQ6vYCOvddjKLxw24vuYOwNuL+HGs+XUt7bQ9j2HFRGP0jB03j9BqZT4INiWR9HIVatBZO69rxQUEa3st678dwqZMmhGE8ve14p1E5zmaWlOJNMLpJavYOwvb2BXeZCt9tz7XcuYrhzu2+iByF+VdxOMLjk1dlac1c/IZ5LSk4hvEmkh1gwepWnryns9zvr3ysIG3FDjRFF5wW/WpcgIQlSLqJFgyWQTTK72NE99qpD7bza9ZwQsCMPccjMZvy/BWAB70lDy8Cp6x97X3/LoW7JTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+84XmnE6pEcSd/r4oC/BHypl2a4yj76z0zfZN2bEkU=;
 b=fvarJAJac+BC1gMoAe9tMWLK9nvfbr252jYWICqwiUqtpmttXWMht5gsnuwSQ02BLtLEhYcQkwRTYDIddMDhiNE/lprjfVuqwe+hAA2YQwgr6Exokro3ahyU7OooOBCcl4KCItwsRaf9ZFdE3pAip5RGfn+ZCGE8a/5F0mZZgIc=
Received: from PH7P220CA0109.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::11)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 18:57:45 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::92) by PH7P220CA0109.outlook.office365.com
 (2603:10b6:510:32d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 18:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:57:44 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:57:37 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 5/8] x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally
Date: Wed, 11 Dec 2024 18:55:48 +0000
Message-ID: <20241211185552.4553-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185552.4553-1-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 076cc923-30a9-4975-445c-08dd1a15b2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Cn0KD5xVITBkHvy/l8JdlccBD8WnYu1/JXlHrgGlBIcnqSzrNf+eJBTZ6DS?=
 =?us-ascii?Q?dVyU/Tiu8qWyktkox5WyxK1ffxN9z+Z/Vam5YbSSjzPdV1BYJpPE9vRrxL8H?=
 =?us-ascii?Q?24tH6nLicliKlpM0rkFuJNTcoI6kBfMeQkF+uzSgHp6IroBlQbaiIbgJ44NV?=
 =?us-ascii?Q?QX4yJzFNg071WeHbblk0r5OlLXFg6gnNak/gYirUk1+eBcLAh6I9epgqtBHf?=
 =?us-ascii?Q?iN1FjI++lxUO1RIfmVXlrz1j+hTdDCCOnBQ1i6EG/GLjmE0NUagwOqDE5dSu?=
 =?us-ascii?Q?BXZrTERbtuQ6WVT860XG+QGTd6Dmugu5bXu3FwRQ78W/nQOw6reJbrkFVn/F?=
 =?us-ascii?Q?MGXvn9Ky7ekVVSGxR3380rPTqVkDrM27Fs0OLsiwKcVC90vL+Klk3g9YuxiT?=
 =?us-ascii?Q?PfMLNuPUC1H5NIOKAes2BfSTXYr+5fvOTKSZWr3eR6Q1ybCUzhThSOEYlf68?=
 =?us-ascii?Q?jT7vbEJC/bmGONO8QJMjhW76lEWeWjK8jSTW8zzIPgfo8B7z5DNG1DnmKhBH?=
 =?us-ascii?Q?ibRv4dBs70xmSwrL7h2uQLQZJWc+IcyMfunH7HxyEx/Z2A7C+8/cDFMla7Lp?=
 =?us-ascii?Q?SG5SASn5ZgXw4mCV4QHsCNP0OLfTu/3H3shcKUl5c1hAieTGAbb/zX7+UI++?=
 =?us-ascii?Q?gJ3N7o8Z76L77klaTd5Z9DjTEYqB7GgZi+CYVJ/ta6Cgf+22bcOY5QlkGa7l?=
 =?us-ascii?Q?yoUZNvVAeTBP2IzzMe/z3+g6psYaHc+qt/24pYCvktUwsHDSPS+QUlMLHZ59?=
 =?us-ascii?Q?bH5noqkpo8u3QIPpZ2wBkThWsVEX3/8LMlB+luUU5ZmLQaSGWy8syZeimdBh?=
 =?us-ascii?Q?onoE08lLe4UBSZo2gzIFemz7Xae4wksb9DPz7LwK+ne7o3xvvLZSob5pmodz?=
 =?us-ascii?Q?v3IyOgGfQmqSLrc6iwrwkHZCQ4YoeSuWIZcbzw4pXWGtLGhVQQ3FroUozHhf?=
 =?us-ascii?Q?mUG5Bg6n14nmYPKd1prO4bzoy/9uDfzppOWPeRi7amRfztA1pedGDavD7NqN?=
 =?us-ascii?Q?JTP22CeKhbiZE10KIRoYCDxXs1+zl66HA+oAKEZzZWhBw48QWTb2CujhtktB?=
 =?us-ascii?Q?Zu4XHNJYDa79usfAOfbtF7jtf3/INx+e1guyK/fEjvmVdahon56N4HNX4Kgs?=
 =?us-ascii?Q?D5pPD7PIMQstKEdYtVqjRey6nbtKU2Se2qRO6B6QLLDmQlZZskZjHB+JAAJy?=
 =?us-ascii?Q?Afx798YXFFkAvGYGv5mKtSNX9ywTT06unrsCSv6KoKL/kRK7GX2kPxdIt4YE?=
 =?us-ascii?Q?EuIQR15295TIwVx7vVwC4mODKt2aB9/2APUJOpyxirhHeqnHhof5hLDyYAAL?=
 =?us-ascii?Q?J7nVsemgBJSuvjiJhP54vA7u0ZEgjZeH5YnEBCVXteV8vGpop6hTlOPXXzZ4?=
 =?us-ascii?Q?V+I2GuB5CMr74PCsDeLRd2cZlBJxcCg119Lkvzl6ecAE0PB8hamNm3taC563?=
 =?us-ascii?Q?+/j1C9t1TQRprtzH6cO9yiFKIZQnJx1g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:57:44.8636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076cc923-30a9-4975-445c-08dd1a15b2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

x86_sched_itmt_flags() returns SD_ASYM_PACKING if ITMT support is
enabled by the system. Without ITMT support being enabled, it returns 0
similar to current x86_die_flags() on non-Hybrid systems
(!X86_HYBRID_CPU and !X86_FEATURE_AMD_HETEROGENEOUS_CORES)

On Intel systems that enable ITMT support, either the MC domain
coincides with the PKG domain, or in case of multiple MC groups
within a PKG domain, either Sub-NUMA Cluster (SNC) is enabled or the
processor features Hybrid core layout (X86_HYBRID_CPU) which leads to
three distinct possibilities:

o If PKG and MC domains coincide, PKG domain is degenerated by
  sd_parent_degenerate() when building sched domain topology.

o If SNC is enabled, PKG domain is never added since
  "x86_has_numa_in_package" is set and the topology will instead contain
  NODE and NUMA domains.

o On X86_HYBRID_CPU which contains multiple MC groups within the PKG,
  the PKG domain requires x86_sched_itmt_flags().

Thus, on Intel systems that contains multiple MC groups within the PKG
and enables ITMT support, the PKG domain requires
x86_sched_itmt_flags(). In all other cases PKG domain is either never
added or is degenerated. Thus, returning x86_sched_itmt_flags()
unconditionally at PKG domain on Intel systems should not lead to any
functional changes.

On AMD systems with multiple LLCs (MC groups) within a PKG domain,
enabling ITMT support requires setting SD_ASYM_PACKING to the PKG domain
since the core rankings are assigned PKG-wide.

Core rankings on AMD processors is currently set by the amd-pstate
driver when Preferred Core feature is supported. A subset of systems that
support Preferred Core feature can be detected using
X86_FEATURE_AMD_HETEROGENEOUS_CORES however, this does not cover all the
systems that support Preferred Core ranking.

Detecting Preferred Core support on AMD systems requires inspecting CPPC
Highest Perf on all present CPUs and checking if it differs on at least
one CPU. Previous suggestion to use a synthetic feature to detect
Preferred Core support [1] was found to be non-trivial to implement
since BSP alone cannot detect if Preferred Core is supported and by the
time AP comes up, alternatives are patched and setting a X86_FEATURE_*
then is not possible.

Since x86 processors enabling ITMT support that consists multiple
non-NUMA MC groups within a PKG requires SD_ASYM_PACKING flag set at the
PKG domain, return x86_sched_itmt_flags unconditionally for the PKG
domain.

Since x86_die_flags() would have just returned x86_sched_itmt_flags()
after the change, remove the unnecessary wrapper and pass
x86_sched_itmt_flags() directly as the flags function.

Link: https://lore.kernel.org/lkml/20241203221746.GKZ0-Dii5rnZppkM_e@fat_crate.local/ [1]
Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/smpboot.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6e300897b7ee..ef63b1c0b491 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -489,15 +489,6 @@ static int x86_cluster_flags(void)
 }
 #endif
 
-static int x86_die_flags(void)
-{
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
-	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
-		return x86_sched_itmt_flags();
-
-	return 0;
-}
-
 /*
  * Set if a package/die has multiple NUMA nodes inside.
  * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
@@ -533,7 +524,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(PKG)
+			cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(PKG)
 		};
 	}
 
-- 
2.34.1


