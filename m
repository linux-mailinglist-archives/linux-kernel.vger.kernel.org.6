Return-Path: <linux-kernel+bounces-429791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1B9E2495
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DAA287D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DD1F76B9;
	Tue,  3 Dec 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jfz6Wnui"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625741F8916
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240980; cv=fail; b=RS1vP5yYhDsc3decHx9VFdMZyjiFCRAnU6PPkG6KW83LYJnN0s4UxUCAPLtZA5AmNWVyUmyghcUuuH3XxI+zuUf6lWjNM4zS+zZHB6NRy5qZi6uzuHt3VvWPO9gADejqT8g9VXHjqpFrG8t6Klq/MPyWQ5eAUB6t6QiMZfbiwTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240980; c=relaxed/simple;
	bh=MTyuLKqdovvD7hi0ImXjuQxVpvggXrDGwq+nc5xL30A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3/ZjpeZ6ZhBfyTnz2tZOcHu/PqBCCCJHhf+fYehcn3jw5QpLrPnft60q7eWJONyMxGpwEK+jFVLF5w/fxlyTamIHIck2aW4aZ1/TjfBpWJs7cUi77dx5N2NCSZYdkAUCVgiriB55ax9PaMkgo0CANwPBiQ6WuybjEvU8DvyxoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jfz6Wnui; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ+CrHZKz74rLU34bNnx4WBUDYMiSvTUVpRky3dElJy5YTwuCIy8lEuNyPZDXYV6srWEDrwO+T28FYT+iMqhz4VQosAbKwrvHxdnmUa+7omSjOgMzjKhnJFp0QRmiQbc3JR9l5VwbNRD8zQDK/+A3+cjVZMWQzqBkyMsa/4R8SH+zbyG7b4iwZZ+cv87kshsL8QsmAbT5hmu9q5ItM/0L4XpFGqYMWH8QRhFbq1cqBx/3v2anLK1yQU542JzTkTkc4K3fFbf72uUXRIKskd74gQY1NAWl5qF0wNKTd+Sjtli7zYCK9atG02ZLoRdUJYTnnpe3hmhjlVhicWjcz7OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXCQ/KxVr0WmY0lUSCPCiBwMbuy3821BppPmIPGzvKU=;
 b=RsDl/zMNppnSEbl3RmntYUqTmXcNw/CmPOtkoxZb7gOPjgNz1UYJuR3rzQzNzrNkg6nm6yDp86NCk5YsQdm0WXqtHaA9PkskNlXTUkwXU0ifDL1Bm13q/5ywcnC3235YNWnEiZwtEjq57E3bmpkEek5VxiUu7wPud8JeX59FCURXQPlNzQcjAj/64F31/Tw5W8EaYZ1SFuIqVOBrNd2IlGdtz6H1z6sLbIfKZ3e+6VgAc7jC7FI9BvA4AxXNaNFGB8X9VEehHdEVxrHtTIaOo2651XYSdh/JRSVUdfKsWbh0aBbd2C9UQ8May0sWQhSjyw9yDg7wd4icZZRE/CZfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXCQ/KxVr0WmY0lUSCPCiBwMbuy3821BppPmIPGzvKU=;
 b=Jfz6WnuiEGZgCZa558RqaopztcjZqYx9xCTQBMKkWNCTeC98NCIAtns9A90wRXeXB+wMJUAsmFieM0j1bY8ZyloZYolrTwB4eCiv/GoR6WUvHRl2U9m0OufDlC6KJveixUP6srcSKidQpbOsVq84qKs/GZFOgR4eD6pO6Q5+Bv/Ib2sLlF3ATWrPnvwHusrbH5nm5x+kNgGG0JluDxr1NmdA76cIlgdeVIoyBSVd/HVG/Sj1ljDaR2LCT7WClScNpyjxr8fyQu3Cl7jPAJIT1CPOSjvhSZIyub3jGKEc0h6ti8MXJr7eEgLNwV5KqTudnDqH1ip4i0ZNq5pMynl9Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:49:34 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:49:34 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched_ext: Introduce per-NUMA idle cpumasks
Date: Tue,  3 Dec 2024 16:36:11 +0100
Message-ID: <20241203154917.123419-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203154917.123419-1-arighi@nvidia.com>
References: <20241203154917.123419-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: a770e649-b14d-41a8-c7a2-08dd13b21551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkZvg625VtuUGXNPqKc3BAILtN8eoWey4Kb+NLwOxAoNvncEfbfMZBhD4/Wl?=
 =?us-ascii?Q?fIJLvw2YwAGVjoKfn7o2+K5r/v5nGNFbi9Qk0b2vGOzxLTGgyc2kEdB6r8RT?=
 =?us-ascii?Q?QPp5YAmTGt5Nt6IWdSfy1feumJnnW+lslznOWYhyTsuvXkZukqSiIExH0SYV?=
 =?us-ascii?Q?FI2CtN4Ai1y3jTyPgZ10+8S+t1RMwopwaLixtO21rjUxX2kRqwa9UIQ0i0+6?=
 =?us-ascii?Q?08PtAe4SdZ4CVrgbLvJtTyar59FjyWzKcQX8RlmFEVMGaoSnepNBPEH3GhXL?=
 =?us-ascii?Q?8wM+W92aHf/H57M4v7BBMiRZXwr0B1bJEp0gXI9M895lwNpAtIBYGq0F00N4?=
 =?us-ascii?Q?WU+GZln5dBfX04t3+Z+G4hznDlsbelUxvFaD4xgEwQZOnElAYtgGJhi/STHk?=
 =?us-ascii?Q?RSNdcbZw4X1iqAv46Y3UjwS6lrbt0IP2lC8vw301Ctk3Qa+9VtqYMrMP70pG?=
 =?us-ascii?Q?pAm/P7s2K5MtyAhBZID0RbC1MgS1m1EhodunCx3mForKA9NB3u0IBhxyH3fH?=
 =?us-ascii?Q?flB3pdIpHwc0ReqjvYynpwRBswj5PcIfmq8DQGL+Bv7sgo9wcS963M/CSLUx?=
 =?us-ascii?Q?55NRzkE7FwxCPTZGT6jhj6kpia7ORwB4oBWzGMXtbIcalq3jW6XEi7VMeW4+?=
 =?us-ascii?Q?riXMhx1ujAQikUBjcwLi2BeFfnHEIrlKWtro3swSpY2DOjyEQuyDLfRIDUKk?=
 =?us-ascii?Q?nyJQYmseFXE1/pr/ve+IKsdRDkV77pCXzXZSQOhsqPkh+ljSeRdlkRSLdN1Y?=
 =?us-ascii?Q?fZR4qFAsJaVXSnIQY/wWO2oBF0UTw5qsOvGOvK6UrtwpByWMFRDUWne+oOp/?=
 =?us-ascii?Q?+viJP8Eoq2MECgrBjCgz+HrtHzSDsKbsd4HkYjwKOmLFANjcmZkTnjDNhQJg?=
 =?us-ascii?Q?DaOni1/825X3Y1Uvu0ewB5QLCzwPteUPz7L1z3enUF+VGASXuRP1XRt4hMcX?=
 =?us-ascii?Q?3EonV/k4iYZ4EWeqITaZqKyI9kTX6uhbBsBI+doJZyg6TjxF8qOybAMjc6hV?=
 =?us-ascii?Q?Jj6iGMT9CgFTK0Zzt+MffC9VSa5n4Kigo4I9eptn08n7Ko7vpJNHI0gX6r0G?=
 =?us-ascii?Q?rC3D+ohJiTD0j+nQaiWk/GQqYkbbO0sewLqaFExTPSHBcw52RUTT594//tgd?=
 =?us-ascii?Q?eOQYuEW5xpuzZw/MF4/7o1o0KG8hwRi7UQc4jDWnO8OW7ccBAxW0UTdl1J1P?=
 =?us-ascii?Q?wxOoA0W3G0sjOiDsRauzY2YmYx4kvF1X2uCy2ifDwU7ppAvXhOi7SodIy4ph?=
 =?us-ascii?Q?qpOfBtrAPtwFRXAn2gDaaHLnUFfIVRlrXw7+krCffhBLPIzQLbBrWx7gVMfY?=
 =?us-ascii?Q?abibZmgkhs0TKc4+Gew1L+EfZiEddc2HVz6HmN3kxpTjaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubgitO+LuQhHgLtOhjZH7E2Ypjfoz9tFpNvOnQbOfC1YRCG0uszbhVyIfDQO?=
 =?us-ascii?Q?1ZqMsPtZXp1QGNBLZh0jiSkkvrhKRMbktfKRQ5BZLCHqmYN/DljxZN3VqjoL?=
 =?us-ascii?Q?3O2VZaa/pcPrSiMStN+1UTDopaz1MAqvu2HJGn8g1n9HYMP9usWgpUvAzRMO?=
 =?us-ascii?Q?WlNiJt+ZG9QrXGQJahSzCi40yyJUrub5pCrqFR3Nf5AWTZresprvIYmDBKLx?=
 =?us-ascii?Q?suF/AWyd/AWIKu002V1h+HevOkgQXRMGdmBMt6ydCdkCMEyCxJygl1xrcDjD?=
 =?us-ascii?Q?5kMoA2VLo+xqRiOZBhirSoKHNltTFTY5HphUAYWqhIAfXn199DBc7dSTDid+?=
 =?us-ascii?Q?/Jui4WSIDDoU6RN9LW9+h03ai6OHupq2GvLrQiNRddu8Aella6PBz5CMedv+?=
 =?us-ascii?Q?n6yJQzeoDIaxLDPo/UygjmLCxTskmDJY9fGa0IawJjSMQ0OviPORZ1UzKMqO?=
 =?us-ascii?Q?1Jny7UvM8jtJgGbx/JG55wB4cjJLFKmHes+axh5INA01KpbQnADiIG/5ocZu?=
 =?us-ascii?Q?rYP447vwKxpqhKT+lQJOYH30YmK/Ny4nb3Is4591pCYs6A2DONtlEKmVJ4zu?=
 =?us-ascii?Q?3Q45ld0GyrEXem19GzoreJXmqd07Zh6hTO/xIOE2+pfQTbsNJw1wjAX/rbgT?=
 =?us-ascii?Q?Z8XrxNzl4Akc+UTDf4pkDeSOWqbLLgVv5DAj3/Q8LcODl6a2x4D0Q6j5hhVq?=
 =?us-ascii?Q?uhbjSKbK0BYaENoiKuRGD7QzZXBYTDPsRod79N/3xFCP2UpVl2/aXFI90xuS?=
 =?us-ascii?Q?AujKyNC2C70p/ONp+VTFAy48mQARFtJaidTGd8M0tMO3erwcbycZ0vah88pq?=
 =?us-ascii?Q?OAspEy2J8qzYR23wO8fYjncDq78CJskp3pWO8bBBionqUzMz/FrOD5h7AbOt?=
 =?us-ascii?Q?oDeT66l9J4+hg0SHyl2Y8bIxFXhvRwr/W8HRWM0joZZ0rGyCD+4fFo9ibFUe?=
 =?us-ascii?Q?zQYlyGCVdMZn0hwA/lrvc4b53A6h1PTBz5fuKY5HsS3cZIb70xceHJAY/qNK?=
 =?us-ascii?Q?YweX4tWj0l9YGYthZ9VtqpsKFLy80Xn8KcEVaHC4xaXEdxKdKV4OLwCUDEt6?=
 =?us-ascii?Q?rweTrTA+8wN56kQM9sMjlMXYocS75SMWUvaU507QfeUxdm34VbpTryqbUByY?=
 =?us-ascii?Q?1OfFuKQ16R+LQN9G6O2+9m2rFaXpPxwgU430QRCWKjtZPfFS2INcOT+JTGt1?=
 =?us-ascii?Q?jGYR0Y23qllidxxLd2U5NEC2UihZg60dKxVqK7jSjwXaoTdWT/nlXvaabMrQ?=
 =?us-ascii?Q?z/icI/hIERc+Aw/SURxiT2IWj/1q4Yec9hYf69qL25O19DQfXd0aM6dBidnT?=
 =?us-ascii?Q?7UVjysId/9zo98dDwN1vK5zXxeCmh/lgXXDpH5lxlUJ4XFkkp3dUSWnDjEpE?=
 =?us-ascii?Q?exQna3NpPVFTiRyU7YKhEBQJC2XdQgDdgSGDjafIf04V+/3QRNnXiM5Izdzc?=
 =?us-ascii?Q?hX3st+hAX113dYjSS3u7oub5noEtGDjcln8wNU572+AayvGVaRdT+uNhWvbw?=
 =?us-ascii?Q?l3e8N2CfUnrg1G7+o/SDrRBh20E8R1rH/FbRr7fuFeCcD9mcXMENWR9t/5Fz?=
 =?us-ascii?Q?CP65/TSrw5N/ubXmmfLTSjtFV9EQ1gW5MkIOfRv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a770e649-b14d-41a8-c7a2-08dd13b21551
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:49:34.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvegeJgXyM9s/DhLaTwIZj2fXi0B1VobkWXCsVnsNI9gKt/PPOaDge3Nx7uROw3xWagDz2Ay7/C3z+KYqrkIng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

[Open issue]

The scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to return
a single cpumask for all the CPUs, have been changed to report only the
cpumask of the current NUMA node (using the current CPU); this breaks
the old behavior, so it can potentially introduce regressions in some
scx schedulers.

An alternative approach could be to construct a global cpumask
on-the-fly, but this could add significant overhead to ops.select_cpu()
for schedulers relying on these kfunc's. Additionally, it would be less
reliable than accessing the actual cpumasks, as the copy could quickly
become out of sync and not represent the actual idle state very well.

Probably a better way to solve this issue is to introduce new kfunc's to
explicitly select specific per-NUMA cpumask and modify the scx
schedulers to transition to this new API, for example:

  const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
  const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 159 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 114 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3c4a94e4258f..cff4210e9c7b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -933,7 +933,37 @@ static struct delayed_work scx_watchdog_work;
 static struct {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+} **idle_masks CL_ALIGNED_IF_ONSTACK;
+
+static struct cpumask *get_idle_cpumask(int cpu)
+{
+	int node = cpu_to_node(cpu);
+
+	return idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_smtmask(int cpu)
+{
+	int node = cpu_to_node(cpu);
+
+	return idle_masks[node]->smt;
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
+	BUG_ON(!idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
+		BUG_ON(!idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
 
 #endif	/* CONFIG_SMP */
 
@@ -3156,29 +3186,34 @@ static bool test_and_clear_cpu_idle(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask(cpu);
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smt))
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_smt))
+			__cpumask_clear_cpu(cpu, idle_smt);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+	return cpumask_test_and_clear_cpu(cpu, get_idle_cpumask(cpu));
 }
 
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(idle_masks[node]->smt, cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -3186,15 +3221,42 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
+	cpu = cpumask_any_and_distribute(idle_masks[node]->cpu, cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		goto found;
+
+	return -EBUSY;
 
 found:
 	if (test_and_clear_cpu_idle(cpu))
 		return cpu;
 	else
 		goto retry;
+
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+{
+	int start = cpu_to_node(smp_processor_id());
+	int node, cpu;
+
+	for_each_node_state_wrap(node, N_ONLINE, start) {
+		/*
+		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
+		 * if none of the CPUs in the NUMA node can be used (according
+		 * to cpus_allowed).
+		 *
+		 * Therefore, check if the NUMA node is usable in advance to
+		 * save some CPU cycles.
+		 */
+		if (!cpumask_intersects(cpumask_of_node(node), cpus_allowed))
+			continue;
+		cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	return -EBUSY;
 }
 
 /*
@@ -3338,11 +3400,11 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
 
-
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -3361,7 +3423,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 */
 	if (p->nr_cpus_allowed >= num_possible_cpus()) {
 		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
+			numa_cpus = p->cpus_ptr;
 
 		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
 			struct sched_domain *sd;
@@ -3401,9 +3463,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask(cpu))) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -3417,7 +3479,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(prev_cpu)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -3427,7 +3489,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3436,7 +3498,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3444,7 +3506,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3461,7 +3523,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3470,7 +3532,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3478,7 +3540,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -3560,12 +3622,18 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
 static void reset_idle_masks(void)
 {
+	int node;
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+
+		cpumask_and(idle_masks[node]->cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_masks[node]->smt, idle_masks[node]->cpu);
+	}
 }
 
 void __scx_update_idle(struct rq *rq, bool idle)
@@ -3578,14 +3646,13 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			return;
 	}
 
-	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
-	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
+	assign_cpu(cpu, get_idle_cpumask(cpu), idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_cpu = get_idle_cpumask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask(cpu);
 
 		if (idle) {
 			/*
@@ -3593,12 +3660,12 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			 * it's only for optimization and self-correcting.
 			 */
 			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+				if (!cpumask_test_cpu(cpu, idle_cpu))
 					return;
 			}
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smt, idle_smt, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smt, idle_smt, smt);
 		}
 	}
 #endif
@@ -3646,7 +3713,10 @@ static void rq_offline_scx(struct rq *rq)
 #else	/* CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	return -EBUSY;
+}
 static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
@@ -6174,8 +6244,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
@@ -7321,7 +7390,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
+ * per-CPU cpumask of the current NUMA node.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7333,7 +7402,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	}
 
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return get_idle_cpumask(smp_processor_id());
 #else
 	return cpu_none_mask;
 #endif
@@ -7341,8 +7410,8 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7355,9 +7424,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 
 #ifdef CONFIG_SMP
 	if (sched_smt_active())
-		return idle_masks.smt;
+		return get_idle_smtmask(smp_processor_id());
 	else
-		return idle_masks.cpu;
+		return get_idle_cpumask(smp_processor_id());
 #else
 	return cpu_none_mask;
 #endif
@@ -7427,7 +7496,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 		return -EBUSY;
 	}
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 }
 
 /**
@@ -7450,7 +7519,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 		if (cpu >= 0)
 			return cpu;
 	}
-- 
2.47.1


