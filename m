Return-Path: <linux-kernel+bounces-545508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC9FA4EE01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E473F188CF0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1712376E6;
	Tue,  4 Mar 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gbohs/iT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5B1F63D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118492; cv=fail; b=JP4hCe5gnKzzDduf1lbGnrYyrpg+CQBCbHfT6ZMQox2G5AY845BI0r76kXprDSg2lA/s0EnmWDFiaIoviPH+yYPsHuX9D6mvZF7DbcFbcx73amQQLBRQHKcSt1U3esTzAigzsyGVfS2fg7HgHsqw9YJ2is7nVYIYhVqqKaQtipM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118492; c=relaxed/simple;
	bh=uv49jkEZgOHJhv/fZrYtxOFbCtd8WXh23sCahF4Cl9I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kUSdolom9aJjQa8TO85MEoCxtEepKExnIngEm0kkRPekQunDNS0E7l7Spf2LFmHf2rK0HpWGH4YnKejBk2KsY1lninAMLVoVfALF8wvArefypfZESBkPFnigg12uPqStpuSklIqWjAM7O3RvCTr3uM049+RnLp/UnnVGbOYE/jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gbohs/iT; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntoV8asAHwMFhwyGgsu4FyqCSuqsL2/vckDJ3w7D2kigOz9aZ8PTwiWckV9pgF95tI3wjz2V+fxUXwgo2oorJO5ttyVGcBWoyB++bcKnWaMIBMMx4XDMp1OWo7kOBS6dX/FVcF5MlyoW/NNbG695Hkh97OkTzfhXpc8OhceoNMW/08GklndKFL7pCdJSImKlacNTPfRNFJePjIsLHtL2bKg7KSTcqVzUm7Wa8oPOgjh3MD3n7n2tKgwRL0KL2C1x9stWRI2iYnUjmdluB921MuBkKZGUZU2wkSIh4qmoW5gTtbcO7SIRkGyuBH0QO+2zdkWJCLRlB24kD7mHpcOGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fs2F2blayEwmcNXO8eonCGzUd7FxYIoRQC9g+5XSVg=;
 b=oOxuu0L+FdQ2hy3QHmV/KpaGG0HkeaNzmdfeVgtWvmkArZo3ygOa0RUtzXluPVXaASmq6/xx4OVBcpzCTqnmNQE/ZjSWQHMyK0baBXWoaeclrIH7b7z5ruVSwKAC28hMQ5gTw2zA1DR8D1C1owaQfe+zp+6jK0L+geRDkr6Sd3TPQkwEhJB6gWPZRxxFuTrL3BxmU8Bf78qyxhg1OSM+rMXRycT7OybrcNaNlWMVLCAIXfjbGYMpaoSqgiUPCa9VpdwRWHwiNy52Yn201awhGtN6H5tUl54WDyJOjGcFrIyzrzEhl12OJ0Vkq8JfgYvbbd6sEyVQfsBZzfoyizlrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fs2F2blayEwmcNXO8eonCGzUd7FxYIoRQC9g+5XSVg=;
 b=Gbohs/iTwavhEs8/2BRKLKHIPy+eoztZSWpunzB04QY1lwmFGQS1VKZUpRWo9gp3wViC9Ju7UJJJtgBUh9nKTgZUnCVAyC1HnhoCzy01L1xR1jo298apIYlBnCjHPFOO5ynE9D0pGKVK4xosLQlWaYf2MXjjLI6UsahsgXtakSVE04e3tdwg52wBRl8VmomhH31dCqSj0wpPaQdUDxO3hH9QvMTVKFezjIXvpBIyI+BJKU04qj/K0XKR4hej8v6FniZ64ZmJOKJhs4PnU+rSr7tcBVNYPo8cNvd/mD1uSvzN1bwFTGkPb4WVJ630RfZlNPQlVHHISUKJnEGPUNgF3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 20:01:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 20:01:27 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime is -1
Date: Tue,  4 Mar 2025 15:01:16 -0500
Message-ID: <20250304200116.2210119-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0641.namprd03.prod.outlook.com
 (2603:10b6:408:13b::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 866664ba-36e1-43d4-e5f7-08dd5b575928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMNvFtOHrcgwY6jkhMy3xiG/TuzLhpkO6Br2thAhCK/EQ4WOVprK5X+MyA1G?=
 =?us-ascii?Q?bzn25GGPusKPhFD/xRhJ/b7tH6cX0GtpfzucmoGV6Lq0SjfPUGMFmPl/G39s?=
 =?us-ascii?Q?uR/X4lB0dIdFLmHx3AoFyNm+tuxLfF9/jN+DRvTrKONvUNV7lb2J3bqPuiGr?=
 =?us-ascii?Q?4VcV4YlhVG0QETFIfK5DT5fM/551atAwSzO4r78oZnpG+tr7kMkv8Z009Lku?=
 =?us-ascii?Q?nE5R6AemrKB65WFpJtB5MhPC0gF42MbwLWjgyJznVfjnlpPoC+92rRVbuk3o?=
 =?us-ascii?Q?EfIdGyUcW+buTpNYsNbngiTKeVsecBgf9RnIAAnzn1Yw+sBAVNNZddOb+sta?=
 =?us-ascii?Q?ovtCpY41890uMu2KJLR7qp5s0tnKvVex5qAdbUeadsAJqDqo8/UhuCYQ7Yr7?=
 =?us-ascii?Q?XfbCKhMV1zWi4PTRPnZbAdvqzBaJ6ZL4qMIgbpNyxIStIZzmm2VzzsyPV0bj?=
 =?us-ascii?Q?C0U936QM+iiB049Nat4VYPTduvuhZz1IKI5IHRGZhUAOquhJwcKkrD8AGcAH?=
 =?us-ascii?Q?9IEpCC+Xwz/bDrwhRAKN1/npat1Df4fySsxH8BHMl317vJ6Y6WVKcKS2InIB?=
 =?us-ascii?Q?6PPYI/uegHjYN/oWcZyo+UTtis9FlYrS1sT0FTZCA+lSucm80qluzbOQ28pD?=
 =?us-ascii?Q?NKOhT2y9idhDM2CzhqyJdteBsXjFQFMXV7nODy2fv+xsBTT6zc9pl7iekqm3?=
 =?us-ascii?Q?/1eJYrgvoHL3J2DJoaXimBw6wwkbeN71RFoEIv1vEU0kXVL0ih0CW3k4Orwz?=
 =?us-ascii?Q?UxPx7U9Uoow4x7Q2kg6aCkWZAPFXem9EKGh8H2/Q0J3mMR7Aej4/IhM9TGPO?=
 =?us-ascii?Q?flo9/bIQq54cf1VMK2cj/p+9H7nUq0X8DKnmccJ1znyIu7TO3kxjjBrhYY/m?=
 =?us-ascii?Q?9JMb6tY2afhQs+ZdIbsgyOBgF7b/JIb3pwmJmP1rCvT3VEtpJSDbw64H4WyG?=
 =?us-ascii?Q?MIun38GjteLsd/NYrXjErQbKRL9mjuAqrvBfecM7psz5FCEsevuJ/4IzQNlP?=
 =?us-ascii?Q?LunfDqovUsPQ84JXM6bNz7gjXwJE2TKNStUY4BAuDvQNgQeBPbJxaNBP3W2X?=
 =?us-ascii?Q?v1c0ycvlHO9F3ZJ5mDrSauP73B24pghdWd58bLQMfO4l+ul/ycxIgmVL6TOW?=
 =?us-ascii?Q?Y/ImV7uhvIUXQl+oBR3K9oN0CD2lYRDE44Qb0kcfo6g4RSsWRqEGRB/ISRlv?=
 =?us-ascii?Q?OIYGNp1yFz6ijbAfCuGLRvfVa//LYonwUTjpPx2GTswbvaJJ9esVaxCllor7?=
 =?us-ascii?Q?Zhux+vPaGFI044fcH0/3wyWqodIcWdCFBMAiHKG9WnncqbHr50ewdXyAWxvp?=
 =?us-ascii?Q?+vCVlevJzNRRYo3AvpzgPqMuZLlS7r1AVhoJD/8VTC3gfvmO3Zwfc90f2uHj?=
 =?us-ascii?Q?p38FkXi6lIoNz28Iflnhf9bqguZZ3LyiVIlSAB0xgOnoSwpdab/SIMY/2boj?=
 =?us-ascii?Q?j9vYhjKEXCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txpqSUSM14zSQqfZ1cSVEr8iSo9mhjaUz1M4qvbpBpy/RZhZ5b9t89rx8J8c?=
 =?us-ascii?Q?2riHdaR9dmiotkE8EFCYeXoWkUEQg0LhvFkhb1r6Yvvg9fJAv4hZkT6slT5H?=
 =?us-ascii?Q?qEADbQXCVlDBqrqiroq5mHv+n7qDj7PgeJOxdcp3RH2BOeEQ8u4z5zLvIgBC?=
 =?us-ascii?Q?1tegaOpB6z8gxG0ieCvdnvME2gqjQ42oqQHggDIKq8a0TUFP4jo1k8nZjsfS?=
 =?us-ascii?Q?zHBQxbrKsWH+2xI9wVp59Or7ZziESvRc5kDu0HdlQuZj4jxspEnPppoVv9V4?=
 =?us-ascii?Q?l8SnxawFtfjJfjO8MRkN5YcBg8n7p6/JY7f5NOGSp3u0Fs/65IN4hsOjccsJ?=
 =?us-ascii?Q?HUGOUU18F7/CIXSlcLer7SRWp2SopQebX/kJkUoREMRldnp5icvSMtETEIqH?=
 =?us-ascii?Q?LGIt6gv6dILQA4s/xDOiLj8Tki8AjXltKLDuwHRQYjf1Ca8UL2zAJIXSJg8F?=
 =?us-ascii?Q?q3/cE1NxPW12za/eu/jBB27KY6Nb4wMMNWdEygqkogbIw7fY7jmfZCWEmhtM?=
 =?us-ascii?Q?dO2VP58xexFm/rPDIUVLJTAYPI9vBDzFx05h3czV+Djinvm5TRpt1ReBsgMQ?=
 =?us-ascii?Q?vCSVNXkLg9QVIQAJf8iKJjZH+BdFtkgawh6GY+ituDsYMe4TTTfTf3SiNB2o?=
 =?us-ascii?Q?nqFLh3df2aR9HXs2QgGRngh2EU5dw6gGy/fxoKfznjBRP+O3pzTN/uSSs3xs?=
 =?us-ascii?Q?Dts5W+d+bxsEBTIcFc6wnl/WKnuESgBDW+qdYN7LDb/HX3DAVChhcVjYyc8Q?=
 =?us-ascii?Q?q6isTtqrIzd2Tq0LRcJ8JDMNzTJ/V1pexy9r8mrU8TR6Cvgob0Myb3UCKGDS?=
 =?us-ascii?Q?4HywaIBw1Ftpn/TbLQJD71uTzgQJDlvqn3cWUs0s4pNyvT81CR4PmDsAwr6K?=
 =?us-ascii?Q?TFv/daHNyh3SrgzahHtvuPo2q64S53DbP/pnt9f9pqYJM6+USX/KhDmDZ1L0?=
 =?us-ascii?Q?96RpRyfse3GQFbymOQtk6ShOuxm6Ne4TCwsm4gLBlP8ggCHplrV+w7cKbssr?=
 =?us-ascii?Q?rCTAsab15+L7cPF9RGylY1SnQzT0ExE/+yykCR6A6XRtUXeNmmhxiuEHZTCz?=
 =?us-ascii?Q?AmuiKyJFTCUFFbqw8vMDdVc7XH52oZxnhbxggQ+5naY5SnYGO1xvk2KigelO?=
 =?us-ascii?Q?TPT/E7YasG9/IhPgIoEB8XAFOXYk2U45gzFLiNPHzj2w6udse6/8AD9iREbe?=
 =?us-ascii?Q?/2UnAJLjCeuBngcNQevFqSUqOenqpUAGVIEe1bOHBotdMzEbfgjk1GpxkWmw?=
 =?us-ascii?Q?fDKGKLk+eDLcEmZcrT0IHIG732OAHeiJLlHOwiDR6uMlZflou3Dz+qEXUvl0?=
 =?us-ascii?Q?fg3XExhLV0t8JTdhH4gmiWSlqw6plHMxALbZZ4NkFh6ML7ybJnHsJUQXGaMU?=
 =?us-ascii?Q?O9aQlfQ8DlDCs7tmq6i0NkKwerfclMWLgrTvgjb3xLlfW4k5kecmHI0KAc9z?=
 =?us-ascii?Q?94fbCvzT+J5Zv+1PM4kyC83goHsUZzS7UC5JSIf3LDmcuYRV2SvTb3shUQQJ?=
 =?us-ascii?Q?x3N+coCvXvItFZjj40CdbV+MCuawxYMownafmDzZTRtEOpZrWCuNbDo04IV0?=
 =?us-ascii?Q?ROjvc+mSxKURNQ1iUp8zBOoQHrxMfxR+9FnOl4RK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866664ba-36e1-43d4-e5f7-08dd5b575928
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:01:27.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78LeuoDWCJ03NkfMzYAbceQZFg8mGTKn2r9L2b4yO3gro64zuNj+YCCDh3k862Xd/T8/eBXwArxy/o1hAvw26A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Currently, RCU boost testing in rcutorture is broken because it relies on
having RT throttling disabled. This means the test will always pass (or
rarely fail). This occurs because recently, RT throttling was replaced
by DL server which boosts CFS tasks even when rcutorture tried to
disable throttling (see rcu_torture_disable_rt_throttle()).

Therefore this patch prevents DL server from starting when RC torture
sets the sysctl_sched_rt_runtime to -1.

With this patch, boosting in TREE09 fails more than 50% of boost attempts
making the test more useful.

Also add a check of this to task_non_contending() because otherwise it
throws a warning (in the case when DL server was already started before
rcutorture started).

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..09c5139a3183 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -448,7 +448,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(dl_se->dl_non_contending);
+	WARN_ON(dl_se->dl_non_contending && rt_bandwidth_enabled());
 
 	zerolag_time = dl_se->deadline -
 		 div64_long((dl_se->runtime * dl_se->dl_period),
@@ -1648,6 +1648,13 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	/*
+	 * Prevent dl_server from starting if RT bandwidth is not enabled.
+	 * This is used by test code to test RCU boosting.
+	 */
+	if (!rt_bandwidth_enabled())
+		return;
+
 	/*
 	 * XXX: the apply do not work fine at the init phase for the
 	 * fair server because things are not yet set. We need to improve
-- 
2.43.0


