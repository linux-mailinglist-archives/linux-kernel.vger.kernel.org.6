Return-Path: <linux-kernel+bounces-569252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECCA6A091
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DE1189521D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B5204096;
	Thu, 20 Mar 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRIBAnpu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9B1EE7A3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456388; cv=fail; b=Q0ZGyU7a8hlI7+t2frgxedb7wCujdvp0bbcE/v/oOSfGt2aLGNZUt4yf9FXgrsbW6eWExOtBz01pEAlATdMK/0loEAjFcuKO+FC55Ta/XtmxeH5XyzGcXuvfNMlrbgZZVpmBT1G49Rn1n3/obVCe/oG4d4YxZnFq8OYt3ZCtLQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456388; c=relaxed/simple;
	bh=1xZ6NuSWEnrcGOl64typlA5iPb9lpll16ImyYgnWWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OK5ie1UCiVPna+Sf8NzNbieoDtoin/k0JZypzAFkzmb/liUhv4P3JBN8ZjZYYaLeYk+1KpmV+iQT/FiK3IR1JeleoIBWnEe4C3KvVyYAuPxiJb4Wv4Edw7HfiaaGNptTSI4ZbS8I6BpeyNQ3bMR1mFn9jGiAYHCA3/K7+y7ON4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jRIBAnpu; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOP3bIknyDScKIM5SGN89oBKtXkK3O5voboINs/RGPI5KZYbP6haSbjmgK3J6HLFn1a1vI8ne/ubeRI/vEYVC8TxJHzBnTwBpvyaWHnXLmGReNU7rhsGROxauG7+SzUpsCXgsQmo8tD6rDdb8MevhrwJwdYJqDHF0026irEJmnJAvEj476ysIuUwl44a7heL6z+mB5Juyt66Tw529ZRS6QgHrk/NuL+Y3Z4U4KsOyvdDo+gYIDri/aeihhkp0c0CUni15Mm+oH45fb41kii6vzOgiEl8bfZ/196vfum0qR80RmW4Qsl6e4K6ICJEJw2AtoSb/R4YFZpzOCnO+UUKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIMO78KURZfbupH0XQxVsrLdbclyiSULczGSHEfJeaA=;
 b=WBlig/Vx4YRYD4d2VAr+VOrFuu1tCuBin66qZjlM2VyBHPHfGYOmNRHDKmseOQv6fQrYz6wqzn9vaRquKmY1Bxj7nI9VWl0JAkJlkn8r40mGKfCdnwAjwr2Lu/HzogdM6acPMRUnG5w7m6PXnzWO8JwYHd/xN3FKGG3SgkMwq9ONXfRSp1Aq0Ds6jVi7K0Y49N18pTBmQlN5cRMobQOqvSh90Eg3YXRJN9XPxZgsvVuW7onaR+VpAc0jRvjjPXsxoO/AlZFfI23uuZzpm+Sru0u8oqN2d7/LRv+4m1b+bvWyvH7FoQbBuE6H9OFnF8RWVYt1XZFWOySVpin9eHjfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIMO78KURZfbupH0XQxVsrLdbclyiSULczGSHEfJeaA=;
 b=jRIBAnpurKhQGDKtL9qn6CD22z5/RToBypaxDNO2dsXGpwtfNiLht6Q413Vdoen9ifzJOXiZoRyTgnfsa6u69wuGK6xAmfNIEBNZ/6xyQiBMIi2lin1APDOXHcIdZ37eUonZKB53kwagORiuIF7FSJ/9+Zs9L5yfKaKfvhMVTyy7e8bzv9YvewOsh2vSj6iciMDweDULrTII1wvUxlz0yQHGm0mOHl1YxbWmvfA2aFQip/pqcngxhEbEanp9zSdQMwRxEvypugaCjBejT0GCRwaHCoe6LfIslzTF2DZCFCDk3UXn3TySxcpNgiT7f62kNjRT9y7NyKFTNRwZBk8Y1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:39:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:39:45 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to all tasks
Date: Thu, 20 Mar 2025 08:36:41 +0100
Message-ID: <20250320073927.216147-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2204a6-1af7-41cc-a7dd-08dd6782626c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvLNF37ae8gAWi/9BHVObJxtQ10Cd3LVR/PWumx/yC+kGFFkbddTGDlE67BE?=
 =?us-ascii?Q?1wgrE5LaXsMQSV1ydCMrZtnHgFAWiXjJNzKP7lmdLA3RhKWg2MfyYIIn9n9K?=
 =?us-ascii?Q?6W9ZrB/dRao1PAGB0mc/Oaw+Dit0dD1L85rtBGu7YEbth8WaLCXe1YeEUeVi?=
 =?us-ascii?Q?e6sciKPRW+HVFlcUwD16I0BxVehgSgKtZ1a3TaF9dMlTdRBi1IYQulWcw3/2?=
 =?us-ascii?Q?+re17DSziWV3Ck2SGZJMgVPQtblN0Wcix0APr0sM5iZ9PI10EqYh6jeIEIGO?=
 =?us-ascii?Q?3bBJAp2MKbt0L7SQGzWsF0AHe/ZtJPH9JJpN5otAq50DQuZD6vvAXGMbipGQ?=
 =?us-ascii?Q?4JqL1SMrxqwjBfUxqMgtXftgQ3egfzG8lhQy19sb1qilZRxqZOV69/Nbp1ms?=
 =?us-ascii?Q?oSPSfzHO/f0oJC3k1cOuAWUoeLGhxOdm/+JXLkRcoKkpCjrk0UmxsxJRNf0N?=
 =?us-ascii?Q?U7jD+0ZSuZqS9PJnSpRaPzZFUN3z5sRZOkgmd9kSpJEcb1MrxOYg2xg+EQfe?=
 =?us-ascii?Q?3qrqZoWW0+fHAe6iaqZF6M4VRCzb36PEynfSRnDBNdrwtI63SHTAS4w8nN8p?=
 =?us-ascii?Q?15cKGAPR0EPY+tFTlANi0MJBKeok67YSn/R3BiqozqGrb/SWDt/MrvBOwpwy?=
 =?us-ascii?Q?8uQ/KvRYf7mzKQTusqgn9iz6CcPoa2O0U2NSPs5kuDd41vTyBV7/ouaK2oIR?=
 =?us-ascii?Q?1UcZge2OGJfcJcC27kqelVIwrM5Qu3Hjbvs+eme+ORk2kduiaH4n9x/d8Eoj?=
 =?us-ascii?Q?7R0qLBTiXPPfJ3ZZ7NZzSORBtn4WTmerphF6azMaCFay9NFYersnVz80/zNA?=
 =?us-ascii?Q?jRyrMKbKNWe1r43t5j0Tu1EUqatGXBUNq+Xak28NBoqLEyj2oQ6ElZpywqDv?=
 =?us-ascii?Q?2Fz0kYUtrLedHiy1hug9mb4bQuf7JEWdMAdJZ5wYad+dbGnHxVgiBLOtMBCU?=
 =?us-ascii?Q?JNu3/sLNqZ54TOQX4lKvv/bj1FW0Kk5QcXXV7H/aBVbkyHOJXS5wTOvSkSgO?=
 =?us-ascii?Q?F0JwX6EntHUh/EXQAIgw1yI93G6SXtVeE4u1pCwh/f5HdC1pQQ7bjj3AXWR2?=
 =?us-ascii?Q?d5vhS6P+l5sPmfypfdRg9gvQwONaMXhqBkOtNnIQvIrnAhA44NF2sUD2/tXm?=
 =?us-ascii?Q?YVc6JlRBrXUfcYgyYDu+ftHugEAF8l92tvKIEaHB/U/lPuoK5QsrehMZxG2O?=
 =?us-ascii?Q?hdCDDK1zOzcOyycFpUf3dfo2XvlM+kkVcDHXatPKjHQCpG4OcCGq9k6g65vH?=
 =?us-ascii?Q?SlG96lTUnnXCyvwu6IOegd5ncTpPWpun/DhvemENBkut/OdRpvibHoQ14wD8?=
 =?us-ascii?Q?OdaBfyfQSOswVj2QwIWXsr6qNseN9fz1A3Cf8efNkJlciXqM3hsjlO1bzgNl?=
 =?us-ascii?Q?AlMmHvCKXl8rQGxMTlabkYGrihFc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXRYL9LZNSfvGDZjgDXj13uvOqfXGbljiA7EsSgdXc2Yrx6vK1rj+gR0ff5i?=
 =?us-ascii?Q?X3x7eaDX6E+yqNJJhvyS6idXDa/MPGDJW2O1clZAWdSVfkuhQ+7p5JcV4MPe?=
 =?us-ascii?Q?9Th8PMPPgZGtnU6dlPu9GgBJG5qtIWLkpxLaxKP7lqQw14c63IaYojb5vzbH?=
 =?us-ascii?Q?7EjW0zUtw03obkDEMwxfZEAbQbHBMnZw05v34L6rcaPHH50Zt8tDUavPc28J?=
 =?us-ascii?Q?rHx/Gv7cLJk3bxqNbYXl4zqzTljD1LCgHtTaxFGvwzhuzjxq4KIP3+EeCS73?=
 =?us-ascii?Q?rtmeHtwWOK7ys6r6KVE07gGLsG9A4SHp/lipsKYeQ20q+XscexTew24FdXwV?=
 =?us-ascii?Q?pfdpi361jFp166FUTIj1/WXFQCXaaLFz+pUGYlhJZwkbM8+dzBgjde0pvNRl?=
 =?us-ascii?Q?Akt1qe8Ep+abtibdbJouA6A+dYjs3KfigJ7v6gXgxRbahXKDsyeDcXRGuzVR?=
 =?us-ascii?Q?Q+8toDqbzv3QzD4rQLzmChU0+/ErVy3kkH1gJ5ko0qepcHUaWlROwM+Vd6V+?=
 =?us-ascii?Q?dU2zbO+liJXNV4hCUg38Q+6Oszde3Vma39Jk6CfeJtsAFVcDR3O0yrMOLAUG?=
 =?us-ascii?Q?7b3tD9PXydiLWv2TalBMcNcj+qHRPDfOd2YKPgks2kJyjj9+2wk2FXQjcfwn?=
 =?us-ascii?Q?MHIrSXqilDeK2HolZ9hqjwX+TX2qk9b6rbO5toIshF51rm0yLGeFawObj0HF?=
 =?us-ascii?Q?ifTMxFxSGvtgVoPGZf8YcwwM4mv49m2k/edKrZSxv5HP0NtsxORVIR9YZqPo?=
 =?us-ascii?Q?xBgU06GwuFeuznAMpoCvCBO/aIBrW+7KZx1ldmK8/sKY1X4GE/2WG/ChkuPr?=
 =?us-ascii?Q?njaSWCpFdDwta6OjD5nkb0l7ifr3SqvDnPM+0oCxL4aHi0m0kZsZd1W8Wc7/?=
 =?us-ascii?Q?gNCOAZ1HTX3ztfQbnD77AkcGNwV0yVzU96Od1AgPprfbrIVUIHwuzp0jHUCI?=
 =?us-ascii?Q?AJRTpWEDOOjK185Gj1ESlnQEv0c+BYZpx0SjtQvzaGsApJi3kjq8G9cjNS3Q?=
 =?us-ascii?Q?HxeIRapq2kPzPeVLE0tZWUCfAVemvXJJtWNt5TlsVQ9VbTPWC3ZRZ2SoQmlh?=
 =?us-ascii?Q?+y9uX1lgYUC5qvwWJs8rhdJsc/9/vLWmULcaFz5R+4SWnKJluGJvOTrJ/ecL?=
 =?us-ascii?Q?PzmnRBr1Y5CzawPOTZ5XIREH+jiIbMu0SzqyOTELqEH3K7zeVdRuHiV4lpXb?=
 =?us-ascii?Q?6vqDmGpUB9QiV9s7VlEF0tOIekCCEMG+hUqVruNtjoFyxJ5tcSNty/apazbv?=
 =?us-ascii?Q?OEU0/doGQ5aOaclRo8ZI2xezm65MUOrGTw+WWc0U5mlutAbE9LwMwCCS3+Pr?=
 =?us-ascii?Q?U/H2d6ROZ5YGDrC1BRNQINqhqO5YIa2FuMNa/ernbAkatgqSk9qD7sH2KvXS?=
 =?us-ascii?Q?aIrD3cH3U258MQr6O8FwQH8c8+EOSqLiEdO4fKIWcvQnuJnhboN0nieoNNZs?=
 =?us-ascii?Q?V4sqT9KEJTzEXcePYKuf064oWS/tRrLImN808d1v6OwjgRDh3c5KJ/G7ZI/+?=
 =?us-ascii?Q?DCm1D+foObIyOZT+YJWD0eYQhmVwENxPXZguhnOUWkzRpvmlgrR6hhfNS9+S?=
 =?us-ascii?Q?AgyXYaoyehucGaylZBefdTi+x8nJXijhIUlmZWrP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2204a6-1af7-41cc-a7dd-08dd6782626c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:39:45.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogDB3u0P+KSczwhE0c3N85AC8pHkWfPB2DHI2K7B5ylxSZvO0ECKIe5ZmMR5yTCEmZMMcLeWt9Ujr67Nefw0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

The built-in idle selection policy, scx_select_cpu_dfl(), always
prioritizes picking idle CPUs within the same LLC or NUMA node, but
these optimizations are currently applied only when a task has no CPU
affinity constraints.

This is done primarily for efficiency, as it avoids the overhead of
updating a cpumask every time we need to select an idle CPU (which can
be costly in large SMP systems).

However, this approach limits the effectiveness of the built-in idle
policy and results in inconsistent behavior, as affinity-restricted
tasks don't benefit from topology-aware optimizations.

To address this, modify the policy to apply LLC and NUMA-aware
optimizations even when a task is constrained to a subset of CPUs.

We can still avoid updating the cpumasks by checking if the subset of
LLC and node CPUs are contained in the subset of allowed CPUs usable by
the task (which is true in most of the cases - for tasks that don't have
affinity constratints).

Moreover, use temporary local per-CPU cpumasks to determine the LLC and
node subsets, minimizing potential overhead even on large SMP systems.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 78 ++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 52c36a70a3d04..e1e020c27c07c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -46,6 +46,12 @@ static struct scx_idle_cpus scx_idle_global_masks;
  */
 static struct scx_idle_cpus **scx_idle_node_masks;
 
+/*
+ * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
+ */
+static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
+static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
+
 /*
  * Return the idle masks associated to a target @node.
  *
@@ -391,6 +397,30 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+/*
+ * Return the subset of @cpus that task @p can use or NULL if none of the
+ * CPUs in the @cpus cpumask can be used.
+ */
+static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
+					  struct cpumask *local_cpus)
+{
+	/*
+	 * If the task is allowed to run on all CPUs, simply use the
+	 * architecture's cpumask directly. Otherwise, compute the
+	 * intersection of the architecture's cpumask and the task's
+	 * allowed cpumask.
+	 */
+	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
+	    cpumask_subset(cpus, p->cpus_ptr))
+		return cpus;
+
+	if (!cpumask_equal(cpus, p->cpus_ptr) &&
+	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
+		return local_cpus;
+
+	return NULL;
+}
+
 /*
  * Built-in CPU idle selection policy:
  *
@@ -426,8 +456,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  */
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
 {
-	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
+	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
@@ -437,23 +466,16 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	rcu_read_lock();
 
 	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
+	 * Determine the subset of CPUs that the task can use in its
+	 * current LLC and node.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
+		numa_cpus = task_cpumask(p, numa_span(prev_cpu),
+					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
 
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
-	}
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+		llc_cpus = task_cpumask(p, llc_span(prev_cpu),
+					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -598,7 +620,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
  */
 void scx_idle_init_masks(void)
 {
-	int node;
+	int i;
 
 	/* Allocate global idle cpumasks */
 	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
@@ -609,13 +631,21 @@ void scx_idle_init_masks(void)
 				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
 	BUG_ON(!scx_idle_node_masks);
 
-	for_each_node(node) {
-		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
-							 GFP_KERNEL, node);
-		BUG_ON(!scx_idle_node_masks[node]);
+	for_each_node(i) {
+		scx_idle_node_masks[i] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, i);
+		BUG_ON(!scx_idle_node_masks[i]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->cpu, GFP_KERNEL, i));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->smt, GFP_KERNEL, i));
+	}
 
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+	/* Allocate local per-cpu idle cpumasks */
+	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 	}
 }
 
-- 
2.48.1


