Return-Path: <linux-kernel+bounces-400826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED59C12DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F715283994
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BE23AD;
	Fri,  8 Nov 2024 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MB2Q1zTn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7538C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024106; cv=fail; b=RiG4S8EwKTD+MmVQu3CaLklXsfq4QnQjV1fv2lkXv9kTiSRoX3qdxG3ThX2+/HcAmGcvJ0K56lChV3fj0KM1pqO5MbnftbQnDJHXTglH3DJS2Pwo5BPUvXdPrVUPiZPEhbHngM6hz7NBF79PXUwvQAzIK4pX+hs/bZyg+tSNj3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024106; c=relaxed/simple;
	bh=tSRR/yV3ozk9OnBdyirnuApcGGfOrLlaHCIt5TEL1Js=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dryaKb2dxfJ5qv3OGQj48BgGPKv13UIif0XsCWivFRHTeX/PniuwRD59ctHnxpawKwm28X5IjU8HrRazj6lQbGJDQbMjZwtLcwZeW1oodCE7m8+zzfoUhkhzo2rI27YGUsknRQBmK9/Q4k2bwFIaCZbKnJwOZin2EfqyzKdtsng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MB2Q1zTn; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa30IDk19FPohtmIpgYcxr0WGQfqK8Z3r7JiQ4OVRDgJRtkiZW/vp4hF1+yWnZYRMjU2lMj+dz5sxazckG2WR4llIVaK3BFufRY+QTjaWbnHAaBkw3C/yM3qXPWtxGMc7vjbEHhzssP3s9xB4lmptJmSQJDoysIfJbPrlgi8eWhmxu3qiTi7hrTficO+/NzSxipmmz/dbqxDvFw5DWiUzU0BTnQiStnbZPR6zcPkn5X3vFu+9cux6Y3qXgP+95kZvXxbqGvOe9XDj5mVU4IfVmZ43NnURfuZisMG4uJdrtNxb9WakPl+fWSnasgxPiJWuDKHoS5Ihxbs1afndd9trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq2kvqwr2XcZls8Sw/3IczIXDH2JcSTSAKOpdV06LoM=;
 b=Fa0w+vYTtBLaKcebMa/Zlrx30NT7gZsEr0wCZJT4kS3Ie8AbQh2bXi52U7Puu30zXZd15v5Y4moPRZ2U5rZtNQ/PJagE9S1edpqXZRyLtjz5mKY3t3h17dkPlqhRVb8YO45CEjIXKjyySiNb+uqm+n1FlkBgD1XzAgPnSD6G5THKdwJysFltGIYt2oWgF+rLDVdniR3cXQNUYO4cyClEoQdFZ4fTt/Q+GgBtkORIOgbcVhTSo5KNrUExqMXDunjprt6U7muIZyj71p0Xj0USBE7ZGp7J8DKNh4V9Njf6gRt4ZHBlbOntU8/s7tV3JKRrfIsiVgjyCZyhQGPF4b1IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq2kvqwr2XcZls8Sw/3IczIXDH2JcSTSAKOpdV06LoM=;
 b=MB2Q1zTnXdUHpDO9KN5v/GSdBAHpUqRcErkV2uPuQJFdoVKpFr1v26HePjdL+AdVG4YxgYdvK/z5co68M40CwZ/BXGcr13tMGMXMXDGsAQX3P8kzcsr0pcAy1RTPaQZpHQu6hc0ubSMkCTYS2iQFnVJRmmN7PMbFq6rVrRxVnTWyeClqrMtZCk7baaJiO/2Baq69brOwYKyqfSk2GZ1y96T9KFc8ExCgyyjVNJX+B0gh7tN9CRZ8xNdiI0Y8P6l2xpvYNSIcnIbfRXybeH4WBwTN+QPn/UMC8i0vKR4d6C1AXE5jXiV3m/OGVx5kwGPOpp1xxlAfw6d0qjYMiY5t2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 00:01:41 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 00:01:41 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA optimizations when domains overlap
Date: Fri,  8 Nov 2024 01:01:36 +0100
Message-ID: <20241108000136.184909-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b19147-fc1f-491c-7451-08dcff88861c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2pFiJ/xgjZvEVqTdLzsaFz++nA1S/f55pvU5zr7Lv+AoQrvTvejmKUob/3jW?=
 =?us-ascii?Q?N0heCTzRApdoMkk9LVz667uM/Bo0VOkMq0h43vusBa1FE+NhmfqZ47xWB6sq?=
 =?us-ascii?Q?Nw8o9XfiAen0+x8BRi5ddrGEqsHqoBrOgcB/dy2Y1l/FMhoXYAXrJdFs7Yh3?=
 =?us-ascii?Q?As/wdsWcLF/8nSHfoGkcticpHMI2Lf7mdXefuQn0uooadfSfxvh2PCURBmjN?=
 =?us-ascii?Q?U/8er4iKikzRP8a56NECmxBga4MK2hSLCCvhiwqPELF6HUZmZRzMB3JLss/F?=
 =?us-ascii?Q?g9Qetl0j525g4EJ1UwneR1mvYi46s+Fp9W1ZU3Xq8LTZxCG6BvD7Ifrl3ZTu?=
 =?us-ascii?Q?8ScFZ7RXbnruqd8U+Ag+QG+G8iiS8wsQzU4nwBejVRY4oNgMdjMVxuGRcLAT?=
 =?us-ascii?Q?vNl+3+i2waJaSPlvXyQLt5yZbYkGAK+FOE+jk6COHRsHr5xvcjgFtRalbWz3?=
 =?us-ascii?Q?7lmSTGVqPyYO6sGC4L70tSxxBpjENHP3aVsKp9IbX44DbOtHt7Wx5PcpENet?=
 =?us-ascii?Q?CDqujFSrmWEmoJg90V9NSqFIUh3enrWREy7Bo2BiqCdpWcr1EZieA3iuji7Y?=
 =?us-ascii?Q?8cvCjbQNbUYdPcgbLNmQEcM1zR9WHgPxrYirr6a2q5+VnBNvV/OY4E0HHd49?=
 =?us-ascii?Q?rutY1XJNVBniDIGjeP3BhV89nto5si16+4jQDEJH/rZGUy1yhpRkO79/pi4g?=
 =?us-ascii?Q?B0Q5mC9fJki3UgNBfC/cAd0MM2PzyNISx4Taf+IQUv+HI6soN+X46tOFPBbH?=
 =?us-ascii?Q?cDm1OAS/55ZdlwejTRVFrKewcWBPkD6cwUzaKwAJg0lvjZG9dTG0ro/Stxyc?=
 =?us-ascii?Q?+xJaoukTOYlIjNim6kHwAFG9Ozq3nd1exlG4vw9BWSynF9nWQKawIQGMsa1E?=
 =?us-ascii?Q?exekjFZAo/0lM7vsZbwUEdeje4frxI+AKM7GFtbJ45mfJVynbVs/+abnt9Pz?=
 =?us-ascii?Q?p9T/KOYFe78EuPx7eExrvLN8myTmahAjSq6IFQy9iHaTG1C/yQQYSYn4xgoA?=
 =?us-ascii?Q?MwszJqfy7/Tqwwhc2drVGqGXo1NMf50rRxS8NVdUChCGRysZBNeXPZd5hOmc?=
 =?us-ascii?Q?gnRE4lPyyUsIOvoCyeTheomWBixffeOxcg3fMqe4sCfHvdiBoVLlhmHL9Wf0?=
 =?us-ascii?Q?GluYtsBM1FZrRlEBtDSwVfF9kDxsWk4t0AocIYC6dZ/b7mPDKCqNQXPFSTO6?=
 =?us-ascii?Q?qNCiwiurIUN+Q91WsgKXv8FelOIZ9oT7I+YrwX7M0xQoIWv9K+wy2EwZ1UUb?=
 =?us-ascii?Q?DFx5hniTNo/OEIQJSkIZTt9YTssG5a4dEqs2Pu+wnC1KQS/lluahnziyN8PY?=
 =?us-ascii?Q?UBn8A7l61vhjZMGKZJh4cgj4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F79DCcb12WDb6Ze58Ikzk/poVC4nYbJ6DriEb6axVueI/YkDgLtYXRbKGo06?=
 =?us-ascii?Q?0aKrghxLbaRT1rdgHukLNSAkkvXoE38EDxHILGMSMvo85Sf4BAs4mik6C/Tk?=
 =?us-ascii?Q?i2cHydQAr1lhD0SriD+sIH+ynml4vL+oSNv9ffr+jhnUY5tXRzmh1MUH2/FH?=
 =?us-ascii?Q?xY5YOj3h7Nb737pFveGhuZNVcyC6whFfEO0LPJ5Rw/RMdIkqoddP+JyedKBK?=
 =?us-ascii?Q?VUcoN6PuGSie2I56luSKhflx/ZpYAGeELbJBY6Y7RNAQjUNvpdfXa2prMOQj?=
 =?us-ascii?Q?WLK/mWfvfOufeVKNJO2RrA/VHtPR1OG1gSHwaFrXAlhppOeTUpSmCgcmjog8?=
 =?us-ascii?Q?h/E2SJrKMjr6rNQs3mcR3zxwPB1TgYYn5RvJTCKmCzSF47dHmSaRK8uk20Wu?=
 =?us-ascii?Q?QQxZUguuvAYx11HbkyYyZYw46WgIXc+P5UX+fHQULxh8idgrDzkbdp9fkWyX?=
 =?us-ascii?Q?vxRC9JIIMDRcX78pvvUiQf1RElnrmMO62T2hOWCS29lzGIK27e+3fuacsPLX?=
 =?us-ascii?Q?lqmVvg9OkEjh4CgPFX3cVCr6c57fXiDXut3ZbtKE8x+YbB0N5eYgo4mMPv4H?=
 =?us-ascii?Q?bATY2I+lP3nN8Bcuwfr3hULy3T+nIkmU7+VmPZews8/ASvWpKmmCBLuUpXMK?=
 =?us-ascii?Q?wwyXvdZQGWg+YJpbPO8jqXxhgRMpS4r08iL+zeKI7hUXdgh1krsbeNVzDxmk?=
 =?us-ascii?Q?dig+DecMfL9RoUEW9GFHX9Ben1m+29+YEJnJfx/17cgCDmjGbZbuPggGK9PM?=
 =?us-ascii?Q?pWdFh/rsLCiyip7SEhof/PigBB9dB4QEkwt9rBkm3isDyz/i4vZC02RFedf3?=
 =?us-ascii?Q?CbgJjbiObkgnRfpUwuSxRIC3L24XfLX87dXL0NrexOOvYGZ7n2REHVA9i5ud?=
 =?us-ascii?Q?lN00Go80mxYYIkhL5ETF0OOxYhjYd74oTtdZqO7qWtyQ2r5Q0ZiD59Er3rAy?=
 =?us-ascii?Q?xZygBpYBENIrROwEpJLDGh1U5FfZBs/7mBVani7LD33Pu/Q8FvfOgRpwj1Ej?=
 =?us-ascii?Q?lmRuLNlxPmkwDby79ciV/qVXAc+QUdntxmiJNpw1HcfmZG+KsW7mPEk6fCLu?=
 =?us-ascii?Q?BMFcBmJeBoiREPNZB7X/UR2ZaAG1VJQ2L0PgP48ltfSrRt7N6iJ3tSX9NpZ8?=
 =?us-ascii?Q?fCyOvgi1uWWKvZjgU0MH7zBsrUbL++0ygwcBkwt1D9j+COs1axlGHJBf7z1j?=
 =?us-ascii?Q?C7NeNsnrAH+abgCyGyfrqF4BhlHdjv9rqNoq/xzWwKsXT0pglxuBE5Pgql1s?=
 =?us-ascii?Q?FDjUXM717Hk91Ipc4q+76sOQhXWU6x7ghPgh7qXnGmpo3vIqyJ8m0j9EnDwA?=
 =?us-ascii?Q?Dtbp4bhCpXUHVE1uJrt6DW5bGP9b8LPBmWcZVTq/Hm5svUqSifPs45SOYc2J?=
 =?us-ascii?Q?sSNVgN79hjq/vDzcefXQ2jZcX7xnCePIyn9zDPLyFALRGxi02YzSeyaig7ul?=
 =?us-ascii?Q?2qeDEdvJkZqPmSzpyGzXwa0L2KFbz7sXO18j+Wea0L/MlFSbllJf07k62u0u?=
 =?us-ascii?Q?pqbBBSO2W+su24fo9Yk1wmZDMUnQvuUMLLBje36Yz16lR7Ng+GFavsvxQQlg?=
 =?us-ascii?Q?mFf2qOHplh/oWCzEiKWCOfZmcXzY8icEzN7bAFrE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b19147-fc1f-491c-7451-08dcff88861c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 00:01:41.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaGPhYm1HkKa0ejob8ggUXyd4zE46ny3byd293X1ME5O7l6fxfcJGIBwHj+hSs1SkSpA6iA7bMu1rmoigri7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

When the LLC and NUMA domains fully overlap, enabling both optimizations
in the built-in idle CPU selection policy is redundant, as it leads to
searching for an idle CPU within the same domain twice.

Likewise, if all online CPUs are within a single LLC domain, LLC
optimization is unnecessary.

Therefore, detect overlapping domains and enable topology optimizations
only when necessary.

Moreover, rely on the online CPUs for this detection logic, instead of
using the possible CPUs.

Fixes: 860a45219bce ("sched_ext: Introduce NUMA awareness to the default idle selection policy")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 85 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 13 deletions(-)

ChangeLog v2 -> v3:
  - consistently use cpumask_of_node(cpu_to_node(cpu)) to determine the
    NUMA domain, instead of relying on the NUMA sched_domain, that
    seems to incorrectly include all CPUs in certain NUMA configurations
    (I'll investigate more)
  - use sd->span_weight instead of re-evaluating it via cpumask_weight()
  - clarify comment about CPU -> LLC -> NUMA hierarchy

ChangeLog v1 -> v2:
  - rely on the online CPUs, instead of the possible CPUs
  - handle asymmetric NUMA configurations (which may arise from CPU
    hotplugging or virtualization)
  - add more comments to clarify the possible LLC/NUMA scenarios

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fc7f15eefe54..f154aaeb69e4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3129,12 +3129,63 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Return true if the LLC domains do not perfectly overlap with the NUMA
+ * domains, false otherwise.
+ */
+static bool llc_numa_mismatch(void)
+{
+	int cpu;
+
+	/*
+	 * We need to scan all online CPUs to verify whether their scheduling
+	 * domains overlap.
+	 *
+	 * While it is rare to encounter architectures with asymmetric NUMA
+	 * topologies, CPU hotplugging or virtualized environments can result
+	 * in asymmetric configurations.
+	 *
+	 * For example:
+	 *
+	 *  NUMA 0:
+	 *    - LLC 0: cpu0..cpu7
+	 *    - LLC 1: cpu8..cpu15 [offline]
+	 *
+	 *  NUMA 1:
+	 *    - LLC 0: cpu16..cpu23
+	 *    - LLC 1: cpu24..cpu31
+	 *
+	 * In this case, if we only check the first online CPU (cpu0), we might
+	 * incorrectly assume that the LLC and NUMA domains are fully
+	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
+	 * domains).
+	 */
+	for_each_online_cpu(cpu) {
+		const struct cpumask *numa_cpus;
+		struct sched_domain *sd;
+
+		sd = rcu_dereference(per_cpu(sd_llc, cpu));
+		if (!sd)
+			return true;
+
+		numa_cpus = cpumask_of_node(cpu_to_node(cpu));
+		if (sd->span_weight != cpumask_weight(numa_cpus))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Initialize topology-aware scheduling.
  *
  * Detect if the system has multiple LLC or multiple NUMA domains and enable
  * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
  * selection policy.
+ *
+ * Assumption: the kernel's internal topology representation assumes that each
+ * CPU belongs to a single LLC domain, and that each LLC domain is entirely
+ * contained within a single NUMA node.
  */
 static void update_selcpu_topology(void)
 {
@@ -3144,26 +3195,34 @@ static void update_selcpu_topology(void)
 	s32 cpu = cpumask_first(cpu_online_mask);
 
 	/*
-	 * We only need to check the NUMA node and LLC domain of the first
-	 * available CPU to determine if they cover all CPUs.
+	 * Enable LLC domain optimization only when there are multiple LLC
+	 * domains among the online CPUs. If all online CPUs are part of a
+	 * single LLC domain, the idle CPU selection logic can choose any
+	 * online CPU without bias.
 	 *
-	 * If all CPUs belong to the same NUMA node or share the same LLC
-	 * domain, enabling NUMA or LLC optimizations is unnecessary.
-	 * Otherwise, these optimizations can be enabled.
+	 * Note that it is sufficient to check the LLC domain of the first
+	 * online CPU to determine whether a single LLC domain includes all
+	 * CPUs.
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_llc, cpu));
 	if (sd) {
-		cpus = sched_domain_span(sd);
-		if (cpumask_weight(cpus) < num_possible_cpus())
+		if (sd->span_weight < num_online_cpus())
 			enable_llc = true;
 	}
-	sd = highest_flag_domain(cpu, SD_NUMA);
-	if (sd) {
-		cpus = sched_group_span(sd->groups);
-		if (cpumask_weight(cpus) < num_possible_cpus())
-			enable_numa = true;
-	}
+
+	/*
+	 * Enable NUMA optimization only when there are multiple NUMA domains
+	 * among the online CPUs and the NUMA domains don't perfectly overlaps
+	 * with the LLC domains.
+	 *
+	 * If all CPUs belong to the same NUMA node and the same LLC domain,
+	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
+	 * for an idle CPU in the same domain twice is redundant.
+	 */
+	cpus = cpumask_of_node(cpu_to_node(cpu));
+	if ((cpumask_weight(cpus) < num_online_cpus()) & llc_numa_mismatch())
+		enable_numa = true;
 	rcu_read_unlock();
 
 	pr_debug("sched_ext: LLC idle selection %s\n",
-- 
2.47.0


