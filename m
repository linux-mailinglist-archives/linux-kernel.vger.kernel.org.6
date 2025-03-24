Return-Path: <linux-kernel+bounces-573398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A96A6D6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D937A4043
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2FF25DAFC;
	Mon, 24 Mar 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOsPXeOn"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD925D90F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806591; cv=fail; b=Tk5OYLF7WGOaj95lFTvOWuczlelNXHS5e2VpzT41rTeiQZc5UbYR3lf0lGKXWoaOtPVE/Nv9pPjDfEz80QLT1SidwtxV1tG9Lm1tl5WhvXG+VIMlF8lVyh/p7u38v5IsLqb9hlQtHw+3VnrgPWsgalOa3F6HKVo2n8Qayz3kQLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806591; c=relaxed/simple;
	bh=iwKijLjp/yT5h+Kd2eOQy3sshDkYiA+ZsqM3rOS9DRI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dw3gWg3CyAyLhz13GpKjc47bN6Ju0w1vskcUgnDRwkWjL1lxAw5y6IJaBeFYXaXtwe5pMGq7ogH35bz404J/7xIQKsjWjpNoKrMn5tePfZPc2nGIZ/TFewzwAleehpm9iubS9zd9ugLlRLCRTei9HuTiI0jWMSKUu32RQerbom8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOsPXeOn; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGK+JKcSpsgVHxZpKhxvui7EuMoxQzugOiuVXWvVT7KVux1A9sNi080VTLsuEBme3pwu906ZCQHw2ct4q/Gc2UEZQkJTnMdCNQ7BNh3udJvKKZpFIb3IE5OcELa82+JUfrR2Iu6Pai8G+KFb/HZ+7GdBxc5m9jDprd0iL48gMBILeL/IOZnP1pXRucehdbR4cVInXAujMS6XRKLu+onhxFGjQ1BNojmKDDnIEb0DiWZHtz9zNMuuG7uAkmpU4FK7eF/M7Xo7Txg4FPgNJqfK/Ti9RNiGYB9dDT6VkQsQV+tYLnnXnwqu63QheU/weIPNDzcb6GFCVRyc8t/QtVaTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4jXNKrbtW1ANiXrxyy16cQFPC35IQc1jMG6n89c6a8=;
 b=YhkUYDNo4G31rf8FAzWS0ijsKjZ33T27wRZpRjk/1DDqBWAaPyp2YO4km62Vu4I1ali2xlt+boEO7ammBtUFqdcMeiWbhnJcmxtVFfByPiA+KKXJ3xpqM8mUuM5s0zYZt4uUj6Bt1XVL5q7jDiysiTHJ4+NURmfTUaHWbW4eHSv8DKpQEYWjb4ZK76vrpP5DVa/De+MHliL2/XOfyiC7vhB0984penaMXP6gjZpGsEMg0e0Z9DN4/YDwNeDC64p707hmZAvptd9LH9OtgU3AJYlYjZWCHV0ODf3ifn9vLU8Lm3pbYcZPENMEYC+vct9Mn+eR4uvqwmtSsCffFEklGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4jXNKrbtW1ANiXrxyy16cQFPC35IQc1jMG6n89c6a8=;
 b=sOsPXeOnK+TRGlKyVC/25x+X0h4T5vrl3W5bFOqCFczsj/z+9i9o0RXvA19Q9tUT4TlRfMMTG93GzWRRO6x4ND9fks6HASNpLn9gEliq4BE7tNT/PEKTuG6YgQr9YRuD6y+DChaEMk1FVTVSgB/b+opqKJw/Tdg44VLQQopnKmCEHvsQtOofPToV6xHSVTXBhtviqUGgdxFLtgDYrp2zWbWE2+3JjvY1Fh+FLQnG0zrVafoykTtw35a3t7gUFvPl5Gr4Edf7DwI5bG77VzTUQXlR4LuSUSGwnJvLIlLeEyfJ9bdoXwzp7avtXVgpmp6VlLWR6yDbCFBse2dmhGh9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:56:26 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:56:26 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: initialize built-in idle state before ops.init()
Date: Mon, 24 Mar 2025 09:56:16 +0100
Message-ID: <20250324085616.26810-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b10a6e1-3ddf-4fef-07ef-08dd6ab1c2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d7R51hdEtzazudySuu7ajq8rh4SJnm/0xeuCTnDtmpDQaGOnf+nKWd2Sxopv?=
 =?us-ascii?Q?zdpHAP9aJcOrhwO2sJEk9pTBJsuJvT3+E0im9i21u8EybeRdcjiOAVRDEMWX?=
 =?us-ascii?Q?9+XkCib7+Y/G3bpdwVwFPhNxvQlz5P15M9YSbHt1ObnObC+wVH/vVC+kBaYF?=
 =?us-ascii?Q?uZrOmRmrDfCzRRSLt0wx9I6JDFugSBb7tuI92Tijuir6KablCYFaMFfN2s9S?=
 =?us-ascii?Q?YoTvMHYjUDvaPs1gKBqyg0yip7aV6ELaHLPQTioPGhOSu5/OwuFCFd+VIyq6?=
 =?us-ascii?Q?wjVsqW+Nxmr1JpxBloPf6y0pNzq4lM/bwcSRiST78lCs9tlqRjoe5ZDwlW5P?=
 =?us-ascii?Q?3bHLEq4rUrPrVhIjXje+625f/KofhqR8WcqAISTK0FG5i+BAjslT44SZ/hYn?=
 =?us-ascii?Q?H9Uc8TcNBqNrwh5f3P73gYClTgax7S2zN7yw/14ZM+1N3jTXDGrD2QS+3xvf?=
 =?us-ascii?Q?Ax1BE3jg8Tpoc8WsnNNiAu/u/PGnZB7aRUQyLC07cc9TfMQob2DxMB10KARi?=
 =?us-ascii?Q?bI7ZoOteNKV9rY3JaF9U93f/dyyZBUtGLSIL9BKWdJr87PmHz6xhHsU+Nm4Y?=
 =?us-ascii?Q?Np/9PjB+/kx0vWB36dqmfOkblc31FHOTvimOazIx4dSiyrt1QTLVx1idisDG?=
 =?us-ascii?Q?eTia4Y1MMp3mmDFYnW/b7Ew/zLbeq8svBB4SIS6NgEdXIIk6W48h85M00bzO?=
 =?us-ascii?Q?vHvJOX0lgxvuOPy2Sg3dDmeLAXLyoCx/mhAdzU3jJwXkP+tQjAW6YPqynVbW?=
 =?us-ascii?Q?PcYnBWeCT4FPfYyGm9NEVUCXL+o0M7pVmLqxV7WGD5/8OP7DPfSa7TyEa2GG?=
 =?us-ascii?Q?hRwPLd1q2nLns9Yh2Q2b7ondZuWniHDoLT0kd8D9z3poS4D+plEojJujQXi2?=
 =?us-ascii?Q?DvdKEGSAdLZL1tp08PbG1qn8eTi9Uwpyf40eDluI08k9iptOS5gC+ufPPJQG?=
 =?us-ascii?Q?0P2NVoIxBoFiZgq3fhxqnXchJI1UDSm9NJGL6C4ph84NxFjK9d7DBjRTylVr?=
 =?us-ascii?Q?kOot/ni/gaOSBDhR2/MGWDHvqByILZXiILHs1ny/vZPuO/L7wN+GyFuS+ao9?=
 =?us-ascii?Q?lJohzyZb4yNx3yCiMtI6oa9jYK1U30qsig28gggD81h0HEZHp/w2QeK+Espw?=
 =?us-ascii?Q?Z8Rg5qjgsDo7I9rx2U9wzpLeH+YsOPVoC+vwWyefm6RgD3KRGaRTds81q7I8?=
 =?us-ascii?Q?ouTO05UvcaXADlQYLKemUfwF6nSu9jYP0VZS4Knl6qbGIWXJefGEJnp0xyym?=
 =?us-ascii?Q?Zm77vTn6jsjRQKLkI/OMnxvjmrdiZX771GSwBfPe9vgAQ8Op5sriyln6M9lN?=
 =?us-ascii?Q?rW9zHdL80n4cNP8CfTnCOP27y2isDZVoean6ZRmZVq/FNk4wziowN4kzlxwK?=
 =?us-ascii?Q?rAbl6wp1ZFEi5qjrjGrswHpVjhGR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zL3/guHWCAyny8gKsMoSCSHR0EA6gQIt1cjuDh/RwbvXKQMEBawr5yq0p28y?=
 =?us-ascii?Q?KeahXacQmRPfrv2a+ONYqHewgYBHNHAP+3kRDwaJuUc3j4qQidiCpgNl6lJJ?=
 =?us-ascii?Q?GbPuSfuydc38rhzIWG4vgGF41EvHkzsiBS6JL1WMcZr/wc0EEIadCiGiDM5N?=
 =?us-ascii?Q?/GDldfDRO0yDz/kYdNA+9Z2BSwBQt1EoOraaaki5C2DWIXMh9MHV0BMpvzim?=
 =?us-ascii?Q?wlXdFCvLKiw/5LhVh0S5PLIA5Qz/4DJrweARKwh+0TiYpFHqvhljHTU8CBXj?=
 =?us-ascii?Q?hMmQFfkO6ny9xsppRCGEnRhQPsGTRRDuF9l4mim5eQCn0+GduR4LcGdQYVBn?=
 =?us-ascii?Q?/fwHWVuyatMor/uW85TuarcIXkcItTRbazfGWk8eKpqfRkOVLgDBfGJqffUb?=
 =?us-ascii?Q?6BBoAA3a2zVBGCfjy7v9TyJiPSHbXZ/1BnhKd/sCPvVe+sGp0bO1eO1TapQn?=
 =?us-ascii?Q?rItZlPtoVfK5XrqiaYlUPK0z0ciSVdsGEKpEv6HkiO9aY3Fq+csp6cgqyttA?=
 =?us-ascii?Q?0lEN7IETkys9GmgZXF9+ET3Ypfx05vhmi7dAU8GbDKjw1Vv2u9e5fj6s4Re5?=
 =?us-ascii?Q?Ysi7Qmhu5dDEEsa2WueYoJiEKGvP3R1xzHR+AgSgUI8zTY8wLp7GmtfdtUpt?=
 =?us-ascii?Q?zQL2PQ6Jql0Yuf14VVok3vMi8ywKmxT1TOLEHi/Y7M3+nP4tJI7+Og65XU2s?=
 =?us-ascii?Q?UQ3aRusP0y5Qq2MeoxNKOtSdpJ8aJWw7eDCtqoRW/V1QYbvR7fQ+btBPK/6h?=
 =?us-ascii?Q?hAB2P3uVnPvr4TU20brMsjN/2do1oaEqDZOJloM2IefxZfbWObUVGT7Z23V7?=
 =?us-ascii?Q?Bp8HEQaLHoFVPeNudj6LswoatBFAtalWY9HI8O47EEnhMXDvzLkTCzffk3zr?=
 =?us-ascii?Q?aVzSHIaPod+30N04VV3rxcZBpSKNL7SssviSVUY+Y2f0KNFBRM2ChlwwEZFW?=
 =?us-ascii?Q?ME9tptNeB0HToAyHjRWUuMkgmDLFOOAoeWAu6pSyCYgtdSPy5SYRvDg7r8VT?=
 =?us-ascii?Q?+4YIPFS5WdJqbAPuriaxDFVaxqeRkHT2fiZ+73RLXUEaxJM/d7SWgoVVwper?=
 =?us-ascii?Q?PvTMRkH/0Z3WkMv1d8Csliz5NQEHZrZEvdofF/GlmewJoobSHdr53fqxqpxK?=
 =?us-ascii?Q?oxBExCDbQ8+ChcWhuTZMjedZeqGWXRYgWV5/Hi/clu2qy6X/S7+1vUXqcV8i?=
 =?us-ascii?Q?bMWJl4rbMUaCT+ox9KbvrZYVepZzkXiQ+nbe302qRVR18FwLqX4NVh/rnx4A?=
 =?us-ascii?Q?81YGolA/TsOOtdFdL3YGCkwOp7LMQNOTg8LSF5hxnZXATMWcblC7QecYgfEg?=
 =?us-ascii?Q?DiwAiEXKxJxoV6BsmYIKtlLERJha2eW6+paCuDqYO8w1/a4b+W9Ob0UkH4c5?=
 =?us-ascii?Q?x1h+Vqu7Az0oK76DL21HBmxzpGH4XVuahdCyJj9dPBqjFeC4GWbmc23PgJEJ?=
 =?us-ascii?Q?2Xi4VRPZhI9JQ6VzXxLqC9L7BQvJzVSbl2CY7CdM4ryA1gKs5sg/rin1XHjZ?=
 =?us-ascii?Q?8FjvmG24Ceyb1H/UXKIQkscDw1IjMJDYrt7Yykrq2lTlIkYsp1bRhCr7detJ?=
 =?us-ascii?Q?lB5Sq/FiZXRG8HsHBdnwc/jdXgmG440cy1kQLHYD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b10a6e1-3ddf-4fef-07ef-08dd6ab1c2a1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:56:26.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypTVO71yeWYUOJ7gEHV2er7eWMKQN8ZpzW670B/QfdsMbYD1BW8iFJiDdugTvKj+vm8xDKMQ3m7e5GHQn72Wvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
before the scheduler is fully initialized, either directly or through a
BPF timer for example.

However, this would result in an error, since the idle state has not
been properly initialized yet.

This can be easily verified by modifying scx_simple to call
scx_bpf_get_idle_cpumask() in ops.init():

$ sudo scx_simple

DEBUG DUMP
===========================================================================

scx_simple[121] triggered exit kind 1024:
  runtime error (built-in idle tracking is disabled)
...

Fix this by properly initializing the idle state before ops.init() is
called. With this change applied:

$ sudo scx_simple
local=2 global=0
local=19 global=11
local=23 global=11
...

Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06561d6717c9a..1ba02755ae8ad 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5361,6 +5361,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	cpus_read_lock();
 
+	scx_idle_enable(ops);
+
 	if (scx_ops.init) {
 		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
 		if (ret) {
@@ -5427,8 +5429,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	scx_idle_enable(ops);
-
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
-- 
2.49.0


