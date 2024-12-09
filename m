Return-Path: <linux-kernel+bounces-438527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F79EA258
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5730E1888716
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72219E97C;
	Mon,  9 Dec 2024 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQwXdsQ/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114719E7D3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785375; cv=fail; b=HvQPcZYBPJZ0bfstfnGLVTaPybx7DANvGQKEYq84+OGLsJgvfDusUaCCgCdjgITzCOP4ZSV/JB+WBbSqhGuEWdDd9Uf8wMPwXh7s7slyS8bD1dd7vAjE4AojWQ3ROgyr229EOouaMWAIMYtqGKN4Qd55z0I6c+6Tck7K918cj98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785375; c=relaxed/simple;
	bh=H3XhudV/c1N+G3xv/3NkwozYymIQMcMz08FPfMeZZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XljGyCGtPE4RQ7SksfiHh7Q8VOkFU6UBPe2iwSnZVHNIg8Gb8aAkY+4kzVRAiVCC6F856CNFrH9fJklhnjzgTketzHXLwYy8qCsoTr21ax37SbxH2hmttw2WVfm5V+1i/Rpa99+yEVB/mgguIyWsQYxawGQVltZE8cyUoJ8ctAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQwXdsQ/; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+KHo51s7C104gVlJAFJZpbz2c0kobNB294rsbiA7g6uOr8vraXgbsdNWYDH0TdScPp1P3CPQb8uaomP31xknp0+6Fkr1pikhU6nUKWJK3ECiBIwryD+V/7UKC2sJGbzivoR01x2JsFBlXzM613XR/QP7l3xA2UQBtZr16+TFUF07yleQWDdoDekpLZ+NyjUc+YKAnMleMkm+dq2R4iPLCdqQZI4osznaBk0uUi3kQSXdE0MBwv4UqrX7lJIY3rRVUe8vi/V1rtxncrzCXzUI2UwHMMlEM0221QAvcq9Ju9BdbN4BCm9Tzwt+IiAQuprI9qm4xNuLvflzpUnBA6Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTU8FHv5aVnpZU8Q4G8Ft5b9qhrgGaa2vDILDy/qRnY=;
 b=cShwR0WVB+xHtCpt8RG4HZxhrEgT89BBRS+8xr6EzKud31VseMzvJoEI9ge+bEYTkWiGsajLH/LycMoNXoFwqkqPNGyTAGMYEEAfPkpo8Mk+i7UpVT863G/YbRl/aB8SJrWr5i197AOtZK348depiG3XOjoFqXsEaSZiT+WpPbcUXwCUKosFTKXyDGA2TqOgFO++e1A0eCXoFrXQbX0PW+H4ZxVqS2CP40QzaVv/Atof22rEnyMbbYvcW5Uc3VQCxTlFT7YnfHpQSTAaspFFrz0FXOIVGc5jjv1bbVCyFzqrgJOj72Krlm7ZEfHdsR+vzYHk/xHZF4pHZzaLlWhfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTU8FHv5aVnpZU8Q4G8Ft5b9qhrgGaa2vDILDy/qRnY=;
 b=AQwXdsQ/6oQdHXWTnnPZvaV8rEGGhBTbmN04RVW5vpZtji/NlInckKn8h8JneDQOD8a3W5pgA8q4xQGKeqtZT4K1h0uKsykUgNw3ICDSq4Q9JwSYsM6iqnqpwIYXLilqUfLzvUWeApvazjDXGp2/Rx51zbf5X7S8e7vtwWQMvY291Skx/Vzr2f0gSHkcl4ekwIyF8rD/36954aov27DTKQblM2oE08sdbggonsO6tVLflHaRoC+uR+Delv3l4WbPdsI/fSGlXc2fbmzUF++cY4rR8Fea/ztquGp7uRU23v2ZmKSuOA920dlkPyr5Fg7owRnCIPRsUIlflB8orM4O3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:02:50 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:02:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v6 sched_ext/for-6.14] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Mon,  9 Dec 2024 23:56:24 +0100
Message-ID: <20241209230242.775225-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b078406-02be-4795-9dfb-08dd18a59a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LIk0oEbpTEg0RXjisJ4BjLpHI8Td2uAjawfKtrUW7aA4/F2X5tP+beuULUuZ?=
 =?us-ascii?Q?vvDHJFq/BxzmCxnhugSjVIpYBPrsBbai+DlOmjVrHQHcZH0MqzEYRk3KHEjy?=
 =?us-ascii?Q?y0tmdmXWRvVbK1tmR92dA6SO9hatja+rc4reQ8Cyj3qCt1//OQCJ2lslVLQm?=
 =?us-ascii?Q?hwgl3olQYYIjipagNvYEnzOvKNq7wKB0Te+S1XoUkgRf6RsuYAFVm7fsmhrG?=
 =?us-ascii?Q?JSbkNmDopLIudp8ilg7tyAymWjryWe+ACru5mBNxhMTOpwV3B1shypX5ueRa?=
 =?us-ascii?Q?Yp3R7JUvliZ9Lh9b7EtsrEr16Vy0pT1ftsuZH1NMSzQD+9GZ8Cbdx+0WWqVz?=
 =?us-ascii?Q?jNBCLafbaq+nVf87yixjJEpCq8EEI81fChOwrfMD2//8KQOe7Nr2idVWGmyO?=
 =?us-ascii?Q?7ArMTNDcF+zNLiJTofkphvuwn0vD/MQzosHDeZtVfdQ2OG1/F+QmtQohboIq?=
 =?us-ascii?Q?3L1L+YU2tjlbqZy8uL27jAqtTInHZoZ65ZGtDAHsElznKMXzWojqgzAn+6AS?=
 =?us-ascii?Q?k5R+5LHRKKgl+yGpJmTCqEVsidq5anBagXHtu/dQp9KE7nSCjuqDPObDl0g2?=
 =?us-ascii?Q?L8GAemn+8/LUL9Hjfu/Pk9J5QL0srF6uG5lgDeTC8rVKg9/963qFWhF+vnRh?=
 =?us-ascii?Q?H+c2b/AvDBHLKEBRctsd0+MX1zJukAeft5NARqHJSZ631UzI5PgPBjJr9Ef5?=
 =?us-ascii?Q?GYapm0HBQS9wOpud6Oljst+2J9f1b0gb11ScT0gfTW/nHaMbiDokrGfXRktK?=
 =?us-ascii?Q?AiV13pxROAaSApHVEGSIpp2E/nfLyoslfBJccTiOqVyaxkUbyTBOblOlnY0V?=
 =?us-ascii?Q?nkvp59N5/G7q+7/MwNKNM4Gjm+OQn5Q0CrrahpquPINDqL/hMYqernzDsBLw?=
 =?us-ascii?Q?IJpuod/tuSKrbgnLSfjhQ7rDIWv9WCyaYTSaR6fSKJUIJ3j6lzxBLLiEmXf7?=
 =?us-ascii?Q?oeu54Dz1a/ctTFT6+RmUdKg7GdRWBxE/PYddYKT3Y52m5m+CnlbdnSxNAEr+?=
 =?us-ascii?Q?8iQnB8iOJRbgEnD6DMWxWcSQN7tJXDFPGbM1mB8uABMCRMUO4xQirNpWN2nd?=
 =?us-ascii?Q?BamlsrovlFrLQDRqPgG1PiF2M3h39D0szTIexSI6Vj3mskVSgFU0jZgTIeqN?=
 =?us-ascii?Q?dWnAN0nVQoL/IMsd7qtPUOT4/LsHiBMleToB1YBLI1qFGWPn6C2mdg4CkYGr?=
 =?us-ascii?Q?2vgdlZAA8Jbk7NGkbe5CJHbcsmX0frdeKeFwEzbRisCHS2eoJE76Eq5M1gyI?=
 =?us-ascii?Q?t83X5bi2pJfCYEPs+kS/x9bi6XCbLXvuxXVfxJb6n0CED7dVo25nfsY/7th5?=
 =?us-ascii?Q?+n7b9+zww7Ep9sKmbQKYkIHiwzB0cDyKTwY3M7afJmjATJ36BpcrydDt5bvY?=
 =?us-ascii?Q?HoZDvpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZuO8l4FL1PLa+Q/xFx3j8qJFZKztAAXaQFG517cHSzTodtttOlPL7fvnbaP?=
 =?us-ascii?Q?NJPuDZi3X10maINH1Vow9o++WeJKItP9HbfHLYp3OyORNgA6vQSXNErwHvZC?=
 =?us-ascii?Q?6mbAB6MF9OpLtrtrJXXjuUh6vgH0wBx4ERkSGG9yNsrsbVPdIufrxZkCHh/S?=
 =?us-ascii?Q?t1rwJd7shX8zp/h9Av1iGjAp0RAY+kUWHke0yIKaTq3jaNvMp/ZwZnLlZN9S?=
 =?us-ascii?Q?LpCvYPxK22s0hN0kzBX26q5Oa9WgxmjaiVPveATG8qoelm5YIx90ClSiwZ1M?=
 =?us-ascii?Q?VWZtGQ89+kaa7h3a+/gV3BpGGrVH6i5E996INlSkOp+0naRLY1fVtOdgAVFH?=
 =?us-ascii?Q?I1LUXzl4yLYZlSmzAlAsCuOfLwS0tgqHmXEDLUmb/X8JyiKGCpx2RM3LLyUi?=
 =?us-ascii?Q?THtyvSGrmq5O0fND+wYMc9GuXXsWiiB4rpOcLaCulDVn2mZ8M0PNURDOvBeM?=
 =?us-ascii?Q?A92WJlSHxbgtV8vj/E8yV99aeIyAfO5vGKsjiQkBA/dTEz73j7P9+oW59RnP?=
 =?us-ascii?Q?JH0sdAKA9+OZ5tfEpUCVkJ5rsjqIiaY8vC6U9I1xwP5gIxjaiJD4s25e2rDA?=
 =?us-ascii?Q?/EyI2rSmzXZClDfVG8+vlAL2hP0f320rpRuCapeG8+O+mopcbAFVzw04C4f0?=
 =?us-ascii?Q?Mef7/NyWmd5RrniHSVpdIUQqjid3chY2naXNtXNR710xOBE3nNNVSt326IqT?=
 =?us-ascii?Q?gbJva/4VczVc7B2Be5BXEN+4Gbzwyn3n2DMJyDP5siXEgeVg2TnwKeBs1VM+?=
 =?us-ascii?Q?Lg9y3dldxadHrYRkbRnNpljcySJJv6G+Cv8s4/ajuIYzACJ8acn80uxaPgqd?=
 =?us-ascii?Q?sMr4py45cEQIHbBanJF0nms803Q2cPmn7fZ5J4Qm1KsksWyofG7WUsO2VV6D?=
 =?us-ascii?Q?hr0ttqsg09aW7H645v3/H86EyW8wj/eIEv/8i2R4SodfgrsL33ga4O6uNQB0?=
 =?us-ascii?Q?9iBsqngraSqDf7eCZUXEzHtwpQ92HKtG6hW7KMBZA13kyCQS7a/crxiaZZTn?=
 =?us-ascii?Q?QdO6K9ZFtplIBaRKPW6XYDkUq0gYZYlBwtOc3nP+hjYFLxCb+uGZjyGwoTii?=
 =?us-ascii?Q?UrUWjxbVvolQgqJra/bTYywtP+433L1dybf2A8i1jksR8y4VkqKwnt5n6FKu?=
 =?us-ascii?Q?X1aq/htu6cYsKI8uYD9q7smWN1COoitPGWdF5GJS+EZ6T9TipNBRL/Lyriet?=
 =?us-ascii?Q?eIrTazAGyjj4dD0rvpQDQ/OlHTWoK6CYhOYGFDZvBs02xz2pNrj0kenopwGg?=
 =?us-ascii?Q?Wcd3VoEnCDm6JyFJFZFUfZfOpsHp+HpaThPsxjDOAia4Dg8dcCx6GikxF8Kc?=
 =?us-ascii?Q?Yoz/rMLVz+mkzvRxz6XbJsvTt7c2Mm9uENd8Qq38Lzm6p5gPb8Z/Al1/RmHE?=
 =?us-ascii?Q?+bkrqw1MOscmydAxzeBz9arwJVKqTeD21v0nVBahUekHca9AaAOVXdT8Jzn6?=
 =?us-ascii?Q?N8MqK5VQTVlTJ2wegMRlvxypUDsZcLZnIVYHEhEmJl7LQNd1YL0tZS1/AbJP?=
 =?us-ascii?Q?o4txcF3kZXuJAJFanNzU1YvdAsEuEqekNPhVL1SvzQ7ZsvG7Ti8vH8rRSIP+?=
 =?us-ascii?Q?f8FZ7Sni6WfMMu34xTExGT03OpiHD1nuseKcwEKO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b078406-02be-4795-9dfb-08dd18a59a5c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:02:49.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1rB+jQqNj195/viYewmaoRaozpJ+vxPLvWdI2M0hZsQLRn7kegIzHMjtGFovGYbrMmUOWBaSx2BUgO6DdyRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

= Overview =

As discussed during the sched_ext office hours, using a global cpumask
to keep track of the idle CPUs can be inefficient and it may not scale
really well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures.

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [1] (so that we can focus at the built-in idle selection
   policy and not at the scheduling policy itself)

Test:
 - Run a parallel kernel build `make -j $(nproc)` and measure the average
   elapsed time over 10 runs:

          avg time | stdev
          ---------+------
 before:   52.431s | 2.895
  after:   50.342s | 2.895

= Conclusion =

Splitting the global cpumask into multiple per-NUMA cpumasks helped to
achieve a speedup of approximately +4% with this particular architecture
and test case.

I've repeated the same test on a DGX-1 (40 physical cores, Intel Xeon
E5-2698 v4 @ 2.20GHz, 2 NUMA nodes) and I didn't observe any measurable
difference.

In general, on smaller systems, I haven't noticed any measurable
regressions or improvements with the same test (parallel kernel build)
and scheduler (scx_simple).

NOTE: splitting the global cpumask into multiple cpumasks may increase
the overhead of scx_bpf_pick_idle_cpu() or ops.select_cpu() (for
schedulers relying on the built-in CPU idle selection policy) in
presence of multiple NUMA nodes, particularly under high system load,
since we may have to access multiple cpumasks to find an idle CPU.

However, this increased overhead seems to be highly compensated by a
lower overhead when updating the idle state (__scx_update_idle()) and by
the fact that CPUs are more likely operating within their local idle
cpumask, reducing the stress on the cache coherency protocol.

= References =

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v5 -> v6:
 - refactor patch set to introduce SCX_OPS_NODE_BUILTIN_IDLE before
   the per-node cpumasks
 - move idle CPU selection policy to a separate file (ext_idle.c)
   (no functional change, just some code shuffling)

ChangeLog v4 -> v5:
 - introduce new scx_bpf_cpu_to_node() kfunc
 - provide __COMPAT_*() helpers for the new kfunc's

ChangeLog v3 -> v4:
 - introduce SCX_OPS_NODE_BUILTIN_IDLE to select multiple per-node
   cpumasks or single flat cpumask
 - introduce new kfuncs to access per-node idle cpumasks information
 - use for_each_numa_hop_mask() to traverse NUMA nodes in increasing
   distance
 - dropped nodemask helpers (not needed anymore)
 - rebase to sched_ext/for-6.14

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (6):
      sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
      sched_ext: Introduce per-node idle cpumasks
      sched_ext: Get rid of the scx_selcpu_topo_numa logic
      sched_ext: Use SCX_OPS_NODE_BUILTIN_IDLE
      sched_ext: Introduce NUMA aware idle cpu kfunc helpers
      sched_ext: Move built-in idle CPU selection policy to a separate file

 MAINTAINERS                              |   1 +
 kernel/sched/ext.c                       | 744 ++-------------------------
 kernel/sched/ext_idle.c                  | 845 +++++++++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 +
 5 files changed, 912 insertions(+), 701 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c

