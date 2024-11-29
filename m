Return-Path: <linux-kernel+bounces-425866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E09DEBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFA4B22A25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739C1A0BFF;
	Fri, 29 Nov 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIZRFjX6"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490B1A76D1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903981; cv=fail; b=KoOzLrIEwTowifoipHc+sSjsWC2HtLc0lTnczuBSLr9sY12uySaQuP50Xh95gSOCijaA6aEQEPV5olCVz7Gbpwe7xtfH3cMIaFS4iIZH/Ez7cFrrc3ymNQJEB0XfqgRviV0chJWgL/x9rbxE1jGgc4S3aqqYdf4Vlemsv0T469c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903981; c=relaxed/simple;
	bh=jl+b+ttEKo6m8HjJhEsDehWlDIXT7nGDMzkRFxLZvzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfGHFFpayQ0Rte6SsrzjG93PDhG1xs+DNLIUJpekYlAw7OphjRWc/w/Y/475qfcubRsYZbF6zfPBvyVR+2BTy1NU/TytL8yfPEm31nOqLu3eSTOCcKsKFzWEexrw/5/VSgS5kE7dEvmCzFF9Rz5MQ6w2Iv59D4MHCBgMXZRNuEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIZRFjX6; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V20MOqoCqZN1BO+j+g221FQZnn2WAY6yn2RT+VcsSViiGgGojEOmKLOhjjc4QI7/ehaJNvwHBw3gAFWR/N2Ewp0OfY8hULXy1I2i8KIGQB+Pe4JW3LU5vt9c5Vz8DAByAwO2+aWgkN8AHSta1mVMmMuq1C+T6USMpvCcgLYq5+cA5Snnwug/7S9241YxevYEH4EAP/s0CET2asebGlpmVFvxMwkp9xX5iPbh54sldevd7SYMrEBCQHgZ/yOsn2jQh8P0kvlYROnhkKw0Tbnzbo4nWje2GDl14W+MWJaWa2P9zl6zKrAVlIQkoM0H02W8O2yLdW8xSr+Awzcvwe0E+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmtecXPT29XBLI145v+LFaIspZaSZ7/d2zTlHq5fvrk=;
 b=KYzW8LcHHW/ygkL9x6ZtsKPzgIrc3Ds9AU9xUM6ks9QDxI9paHpps/M7juXqp6rrw1PiMDwBWURHXGv+36rRkPaaa4WOiyZjAUpOlmGBPEnxmbKD1GIuIFEO6d4F6oqgIqZugg5utjYUpRzE2QvE99d1ucqVBPJ+XjM04KEwzi7IykYoGSHeNeVb6q+6S7DxTodjU/qUICzEDpNRDjXw8/hQqg2h+IDF7N6J9uRZGe2kMUYO9EN56unp1F5DDEt3P/LnN4Y4Qr0zhWOAnuKn72jT1K48h8f9N40wkp1oEtfMuzRRGmEiQ9N6aHPmRNa/YV0YLe2S0QCYFR34iUQDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmtecXPT29XBLI145v+LFaIspZaSZ7/d2zTlHq5fvrk=;
 b=mIZRFjX6ie8DtsXbW80fy3ZqnEVW3PVMIKFpTRXIvzORoQZRCzmUYwDGoazqqbDmB/vm5XvvEFCooFwaIhNAS2FsAyJJxVUlfi2t8NbWLsGfrXL2AYuG4uE2jyqqUBchQKb97+YXu7wCyNO6FFq1a8RasJehGw6g+RkqK+L6Fbw6TRAGsri6xzctyr0ZC9lMZIEaP/xTsaFFAtqa9qBLxFfTMacbD47XRKLipZ6UHRkWTAWIV0AWNSDSw5Dzg9TtxoCereTnou1WsNNBu0WKFV1iTfqcH6gIyysQJTdbbJOGYwwhy7Z8RJ2EqByEzqtABHIKAwhC3WKT951WPE+Tvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 18:12:56 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 18:12:56 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Date: Fri, 29 Nov 2024 18:54:32 +0100
Message-ID: <20241129181230.69213-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129181230.69213-1-arighi@nvidia.com>
References: <20241129181230.69213-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c26a029-9ccd-44a3-dcb9-08dd10a172f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ec/ZMbf9y5H1+ayJmyd/Vx7GD8dL3ifO51O6EECNx7+a84kzPxIp4nwHxWP1?=
 =?us-ascii?Q?3fzIvk8mw+ij5wSYqT590CkI2SzcTOFBnxMgbdusENJnXPCQNAFmFPWTGnw4?=
 =?us-ascii?Q?hRYGleFYyssftE90GJBBpSN09cwCYe3ma3onBvwQWYJ03zD1nVE38/q0e9zH?=
 =?us-ascii?Q?nED9sEifJP5B4tVoG7/VXZvgG9Fn/03cneJOLd1UDi1lGtZfpUtqV8nq/N3x?=
 =?us-ascii?Q?R77pbK6jxfxHt8g18nSKkFg4n2ItoCQYk7FAJhginlNN4UmtFvAO79Tdukd/?=
 =?us-ascii?Q?r0t63ofvTMubvV991h4DqOAgzI+Yd7RfRpqnqDQT6KUFGbUIdFNo7Lh9rz0d?=
 =?us-ascii?Q?g73F9BGiVakdwBMbg7+BlJGtVCtgDPPSCpmdx0zJaJ3QaYVBbm+MdUN0qm7v?=
 =?us-ascii?Q?7DTnVHrtUBfEGfMY16Dks+cc2yp2lw770hi+OVVg4WvkXMcyG86cOO8F0ItR?=
 =?us-ascii?Q?qhvcANXEF7aIJh+4NvoFTH5GfMqmiL4nxFmLH4baRb4sF9B+3KWtcWWSvGAz?=
 =?us-ascii?Q?VxU379zSEKVUVel7FCym2iprBOUo2a4Zuc4AGcI5xNwOjmAN+blmqIP61VZE?=
 =?us-ascii?Q?RmzbGQ1APy6ZWIjyIyyjHFhpulIO+ytqTNQ++3oIjbPRWndp2f64KrOvfqPt?=
 =?us-ascii?Q?Y66111ZT59/uqF34Eq/vrWM4ZLFnFbUZpxjXS0rBz5DLh5debdze1c2pxFyF?=
 =?us-ascii?Q?LNWVKl3WxzbrmKiIC0/Ql3XGT4Rz61GvPZGFGcg8VOFdO8rSF/Oax89dDLCK?=
 =?us-ascii?Q?5EzKSJdixqBRdNa8w45BVo7U09e1AeyXzYLyNHejUgr1a4+j3OWbRPxFvU+r?=
 =?us-ascii?Q?QykyhHRk8zu4fAx9NwZnh/2QToZF9vAKycJAbtZ/jFGeo5HkxItqJmWDwm/x?=
 =?us-ascii?Q?QSyxOV91sGWHfszzR3VpYhNsc03s+RDD1dS4fdSy3FSCAZrroy7r7W+eh24n?=
 =?us-ascii?Q?x+pjRx6BeKB05mhuh3vOHwcm5I9FzZzPl9wUVdtWp5E//CFAMDl1YNU85vjx?=
 =?us-ascii?Q?Dqck8xe0ROmxg4ZPWGJ78GNsxifUGE6E4GQiIReW7aEAW1/RVVDkqvYqm+y3?=
 =?us-ascii?Q?p4nBKkG7i8+s89k7VIbZSgZfsKrgRSTSkl4rO0WDwxsyR/va1tViEwAaJJNJ?=
 =?us-ascii?Q?QhaQBqc9YjVwyddZFDxfGvPCZDy0bZBuEOhahHmTfbO3FcASyPNf69UKwPYd?=
 =?us-ascii?Q?pAsAPecHZQqLOlcJR3tHe6EMdptr9RI/A7NV1Dx3BImeIBKZxzxJ76/dLCBs?=
 =?us-ascii?Q?h8gbZH7GwmmJRmQx6wZb8jANzJC947t49mtHZRyECQme9L4tFciswNGIy3E9?=
 =?us-ascii?Q?mDP+WhCqGCdLOIoJf1JkFJtg3F8KYHLZMbQXrIN3xfJF9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FUNSNpHzgbPx4rpSIJG87GavUYprm8N1R2phXrWRivZTmVTBPkNkjqIS7ZI4?=
 =?us-ascii?Q?UVp0Hn5iIZRHXQIufYNEUsJEKUeVCMMBxg6v5mHIHcQdr9VshDwKWFOyxcNT?=
 =?us-ascii?Q?XAWu45JgFHk0+z19U+ByeigQLyzoSjeI1xCG/H4hiPKJ/HGH8KaxPLBHeXgg?=
 =?us-ascii?Q?OgVSeL47UKLHpmCqB1wPqv+6DG1L2xwygYSj37J1tVNKeePPiTPNY1krnnM/?=
 =?us-ascii?Q?RKTTM95rB6Zyba49a/Mkzi7JR31QXXInEM8uWFNK3MsYQ7frg8Uo3IsdP9ux?=
 =?us-ascii?Q?tOLENa7M7MZ+IYsswyD29F0o8tvYEDPpOpElUv34rUl0dTum/PBEq49o9S6X?=
 =?us-ascii?Q?yM0rwpcpXrvZPRtEy5j75Ir9fEN6p8vo+bMjPWDVAt+ICke1iu3YgPRdUXKK?=
 =?us-ascii?Q?ce3chRgx0OVDTNQ8NDnevydRnOhZCDAaDg5zHc3AN8ChZooOLEBRsEuzkcvh?=
 =?us-ascii?Q?Oxc0HDCEVqgdC1ClJoySUCctmVcl7d3RA5GOitjoEDB2smoCCEl2XfJDDZdR?=
 =?us-ascii?Q?l/9psqFUenkVHMxcfKc+ZWR+GUqr61OJIklIdbvKfQvBv5BQfOpDk3TpCYFy?=
 =?us-ascii?Q?BnCKdm6u1Ez9DlYuY1nQOo/Wh5dSDosllqQQOWHwflikHlPzSsTuwaYoo2fD?=
 =?us-ascii?Q?TjTjm/FcKdxRUo6jNVjyn3pndSYCdQbPSeuSaJkxC7oO9Z6Z4WAI6TP2OxVk?=
 =?us-ascii?Q?z52KCkR/wmVQDL/59aCzZblwxxqPSKFXzTH7Rc6uHKMzzIiVmpyglV51im7l?=
 =?us-ascii?Q?9GGq4wJnIqtO1cJ6OJeih34Sm34II25cXo0f7DaI/dn8/FlHf6YxJwIcMspp?=
 =?us-ascii?Q?AxMkccFUvAPt8Aej7NKjg5JHp4PNxmWlZnYEdQf4JkDCKP66QWeqA2g63t3f?=
 =?us-ascii?Q?IxLZjTquZgvvTjUB1O8K+6z++15Pa4g5yrTwbK1bOygMyIYAJ/EWvJcFJyp8?=
 =?us-ascii?Q?n8Afku5LuPtKaH9PwKC2YOf5JL4YyZ6Plu1YCDbNSbdTWQbkVtrSm9OZiznx?=
 =?us-ascii?Q?YgfTSOMJmlef82ZVBVkHYFOt3PZpzfIVVmssLwaMIjWbYe5qOTQRg9t85xhx?=
 =?us-ascii?Q?MZJKEEuubqJD3E5Xnrs31Z9zJIkViudJjoz0yOxFC/BUxohKc6Rmi3gdrwmO?=
 =?us-ascii?Q?niOrPMilyjE5Nup0qxCmUh5he56PGGEc2YhOXRTh3aL2RsTefxYlkaEraikG?=
 =?us-ascii?Q?JUATBzmXnLK7tOmBDxzCLj45XGqCCJ7nPwIiENp4GpOoOTekbbrLJsQpbtZl?=
 =?us-ascii?Q?qQZP4urwKz83G0J1RF/3sUPKm31U3QJx+jbDNo8YjyMRJ53jbsDUtihVry2J?=
 =?us-ascii?Q?jar1oJn8UyGwltSWH409w14N8Dy7Cvy2Sy9ppmG6CNYFjEfLGV8xIU0YVOaM?=
 =?us-ascii?Q?EB9OcacembkMuLxkbQypwA7d4W9VivHhlq9dPke8gShgqeYwr3RAWlIFyAX1?=
 =?us-ascii?Q?sm+VdfHjKT1SqojtdVp3yF4RwY1iNFvg/WBDKAJCDN8scSuwZVK92A8hhAgi?=
 =?us-ascii?Q?jcM+AXKfDZoNUjrlYdCTz+KjeqYl4+rLeNOjOlUNyBP6rbvEEE1PPLoCZ/a8?=
 =?us-ascii?Q?DDSKH3jpPAXrhY19e7uUmogfqUgEJ4tjltDhKJAv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c26a029-9ccd-44a3-dcb9-08dd10a172f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 18:12:56.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvSwFGfOsmdtOKts00gBwAEc8rDCJw87tUDRzePjV5OjlojZzLntLcWHkQhlnJi8nBGH92aCmL69f97+twQKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

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
 kernel/sched/ext.c | 115 +++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 508845f0c25a..c10131171dfb 100644
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
 
@@ -3156,39 +3186,48 @@ static bool test_and_clear_cpu_idle(int cpu)
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
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		cpumask_andnot(idle_smt, idle_smt, smt);
+		__cpumask_clear_cpu(cpu, idle_smt);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+	return cpumask_test_and_clear_cpu(cpu, get_idle_cpumask(cpu));
 }
 
 static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 {
-	int cpu;
+	int start = cpu_to_node(smp_processor_id());
+	int node, cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
-		if (cpu < nr_cpu_ids)
-			goto found;
+		for_each_node_state_wrap(node, N_ONLINE, start) {
+			if (!cpumask_intersects(idle_masks[node]->smt, cpus_allowed))
+				continue;
+			cpu = cpumask_any_and_distribute(idle_masks[node]->smt, cpus_allowed);
+			if (cpu < nr_cpu_ids)
+				goto found;
+		}
 
 		if (flags & SCX_PICK_IDLE_CORE)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
+	for_each_node_state_wrap(node, N_ONLINE, start) {
+		if (!cpumask_intersects(idle_masks[node]->cpu, cpus_allowed))
+			continue;
+		cpu = cpumask_any_and_distribute(idle_masks[node]->cpu, cpus_allowed);
+		if (cpu < nr_cpu_ids)
+			goto found;
+	}
+	return -EBUSY;
 
 found:
 	if (test_and_clear_cpu_idle(cpu))
@@ -3459,9 +3498,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3475,7 +3514,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(prev_cpu)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -3618,12 +3657,18 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
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
@@ -3636,14 +3681,13 @@ void __scx_update_idle(struct rq *rq, bool idle)
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
@@ -3651,12 +3695,12 @@ void __scx_update_idle(struct rq *rq, bool idle)
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
@@ -6232,8 +6276,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
@@ -7379,7 +7422,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
+ * per-CPU cpumask of the current NUMA node.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7391,7 +7434,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	}
 
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return get_idle_cpumask(smp_processor_id());
 #else
 	return cpu_none_mask;
 #endif
@@ -7399,8 +7442,8 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7413,9 +7456,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 
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
-- 
2.47.1


