Return-Path: <linux-kernel+bounces-247307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA192CDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AFE1C224A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B618EFDC;
	Wed, 10 Jul 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJlDvwvQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160F17C205
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602173; cv=fail; b=Z3U9tMEHr2vVIlRpk8a3uIDUEGu+0+6Dh+1FUtdKpsueDShsBZ+xGgx1i0rSiFe3RpbUGHv0ZxlHiDqdjUhvcMtbqX9+9ApLfbYbWPTL6jWuuKhuUcbv7VPbZyR9szN/+lr9RkM4ZmwiQu1UFx86dZnEw9Ekz7SKRgYtR88OL50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602173; c=relaxed/simple;
	bh=/n1zw3pNW3dNP+cp4qWXAqkAl1jqer2S0aTtSaEo53k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lb0oBelD4gv6uhX7F+CYbAmCzJp7pJN3+I4zNEPkMoan2K42lnHdPsPhqhC+1PTkbvZw9GTog0JBvRyXhpUymIQxckhlk2o5j9NthGyaLQOeCoDqWx92doXibhKODQENMn6ZGyWpmEeTNncqoO0oWNjgh/Hr7xcZsI9UpLD49dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJlDvwvQ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCCj3E/R+A7y8kVUIl4yushh2MO9f0cwDkBOD5H3NEOSa7niIADUnucbJkMlHL+D3zjou3QW3BqTH0TQEzIIvNNMb+3lD+K2Rwvqm6MoCBd8cYkhvRSIAEj6D0sKXnhCziOTAgXd2sGg/CFG4F8RBkbuGaJvFTxEwsuJRrMyKJTjt+OSJnh0URLn85lcVl92R2qe6/OOrVECl3FWDl/a6Gh0069Dh9RdfqET1N2wTBfeoJf6hvDmQrLI27GOqnSWD4wIugPOWgV2r941HPOWdk4xlB2dTihmyMoYaqxQaY+gJVsyeK25LWzq9LeJTeG7RI2PuCyqUuNCHFKq+vS6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K/tW3tekbk++sGL2PuNPV4YHI6oJCgOEO0o4brTJwg=;
 b=LnuQ/ozfL2wNeaGB4ZcvQa8e0sRfVLRSauKDkYU81FayXf9v+MEnvq2yoFfqUd3t3ZzyO/XJIxI3VxvZxqtHAZnaguU2BAKdDtiFOJ+PffNNuffFzErhizoGBacfKh7u8IWSW1RGmLaNCU/4lsBYtJAlilPcj82xNTxNEXbAbNRJRw7VteD7qPx6YEsBehRsYSN6NKFFXLO8vqJCG0GED75fADzqbBVw9+C3Oncgc9zPq+8rETcQ1wRyBnZuQ/BVNiJ95nKMbQEuEcEVvNA9By/rxaG2WLTvQk13IqoAAdGCs7P13Bepl5X0+e2H5PpvQLDO8Z2CI5IPHORvg+Nr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K/tW3tekbk++sGL2PuNPV4YHI6oJCgOEO0o4brTJwg=;
 b=GJlDvwvQWE1Enh35Zu/pCPND2SyMnToZTNtDpBB899+w81ElDxmp5+BJBZ7m80PbKzX12l2MLNt+0bOPGU7IUSLlIVAyWA2kbNLhXvSTVcOzVd+h73yMYbej/+HeiAtHiKR7T/wjW39Si2nNOtddmeBHhHFCIrGQCZ6yG3Z/LG8=
Received: from SA9PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:21::25)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 09:02:45 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::47) by SA9PR13CA0020.outlook.office365.com
 (2603:10b6:806:21::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 09:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 09:02:43 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 04:02:37 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>,
	"Guo Ren" <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 1/3] sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
Date: Wed, 10 Jul 2024 09:02:08 +0000
Message-ID: <20240710090210.41856-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710090210.41856-1-kprateek.nayak@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: d5956d86-3b38-443c-60ee-08dca0bf0fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fy6Cq5O0CWAdYHxE2CzjZHzYutKnW/XUvv/AW2mbdjeDQOE6sCqOd11t5l5d?=
 =?us-ascii?Q?mRg6BJ9d+fU/SqyWUa+t4Er/eFUj5jn1NUkJoRsxr6IHyGc86ODGRHgc1TP+?=
 =?us-ascii?Q?1GJax/QCJ2ycI7gm598ILkY2V7FUwFgsosMAofNpUZKVzBnidZgRbW6tIpae?=
 =?us-ascii?Q?jPWnpCXrVBp7gbZMl1vttWbQVG6ND2l/4rPZJQoqkZCZfusCziZqbcW8KYZT?=
 =?us-ascii?Q?y27HAQvPKRRK7UVWa0M8Fc+0ThJLENf/2PGo+YZO6GrzflliQU4rWms/mNep?=
 =?us-ascii?Q?XyTPB3/rHlvT95//2SnLdw9fLe9bi4o0PFMkjxONO4Gw1MbNU1RLSsqBB4Kl?=
 =?us-ascii?Q?AD4gt9hzA/iRepaGc5iOqiVSMsowi4yR178BQAwrY1NGdufsooOwmTviKjQP?=
 =?us-ascii?Q?w3J3vkgKdooH4xxjTDVZbuRDfSbAla+ZWYHvIOBOnxBODFCdgD7/Qi36Xq3y?=
 =?us-ascii?Q?0yH7qSQlzOE0LEnOXKQCFjCjyjyEYrGWR0TXfAJZAitH6FApor09ed2xSZJr?=
 =?us-ascii?Q?9gOjriNkp+R3+XdsLKCVoCroJLT9oQwhJPUmXqEqUU60jCPz8yQ7L0X0i/Hu?=
 =?us-ascii?Q?6IklMej0h670USECrBNZwz7pWZ44AW8psjDFSLeEL+0x+RJb0n8uPV4AW/Kv?=
 =?us-ascii?Q?2CvBMF8JOOcRr3WJNK9PGMXAueIAMNqXpTXl8zX1che0OgRdQ44Y/DmMyaLN?=
 =?us-ascii?Q?zfxllZEA0E83PR64js6fTe8Mlde1zNGuYD6lxEfLOl3GSAmjeUaZCPGJpiNM?=
 =?us-ascii?Q?tuQyizgW84DLMgooiju1XM743sj/ZqEggSZp0th5MpFXnF3pucoZCAxNzA4N?=
 =?us-ascii?Q?+aoB2pBFc296++zNch2fGLMOVErKrgJZBZt9LBipTJhBYwZAT6jNFGgigP3p?=
 =?us-ascii?Q?0MJtdMTj3e+Z/aIKugMZ0gzv/3Q1dVmJT+WsveMGOEmg9YTfMYJq91n4bYFK?=
 =?us-ascii?Q?Yv4AnLbm3bvvKnKx1o6OUUaGC66kjFfWvAdbdFGzJ8BIDy3z3bf3Bu8nCbJf?=
 =?us-ascii?Q?ZssAYODnGW9jTwYA7rzT1cb/58hcp5MQX01p15rSsLppXVYa3OwamtFS4097?=
 =?us-ascii?Q?9SSwsvW6wKIBdXIaYNz40uzsRU9HK0V5TFNAeDIzvMpWEv9zQe+ajWa8Rpuv?=
 =?us-ascii?Q?iJktc1CApLPxn5rjv8hGedBD7Lj8a1edYDhwxV3aQJCVk2M7btq431vPiuno?=
 =?us-ascii?Q?LlZRrKUVnSrOxEG/qCptXv5ShiBPCkQVcpuSK9cCwid3NbVifenbgUjIrsQ0?=
 =?us-ascii?Q?02xhTVGFCkPQQSsRmFmBIutubhk9i0tblutTCWuGj95D9CGfeczpe57k6cmj?=
 =?us-ascii?Q?HdZoBZbJv+lec4La7log1c5SXc2fmbQ44DZuIo6wDSoqlG7IXlU3Og31NIU7?=
 =?us-ascii?Q?XbMPBC6bLaKHr1h6hWoqYDSm5TJYda3sAXF3w3JIZrXUa939sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:02:43.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5956d86-3b38-443c-60ee-08dca0bf0fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

The need_resched() check currently in nohz_csd_func() can be tracked
to have been added in scheduler_ipi() back in 2011 via commit
ca38062e57e9 ("sched: Use resched IPI to kick off the nohz idle balance")

Since then, it has travelled quite a bit but it seems like an idle_cpu()
check currently is sufficient to detect the need to bail out from an
idle load balancing. To justify this removal, consider all the following
case where an idle load balancing could race with a task wakeup:

o Since commit f3dd3f674555b ("sched: Remove the limitation of WF_ON_CPU
  on wakelist if wakee cpu is idle") a target perceived to be idle
  (target_rq->nr_running == 0) will return true for
  ttwu_queue_cond(target) which will offload the task wakeup to the idle
  target via an IPI.

  In all such cases target_rq->ttwu_pending will be set to 1 before
  queuing the wake function.

  If an idle load balance races here, following scenarios are possible:

  - The CPU is not in TIF_POLLING_NRFLAG mode in which case an actual
    IPI is sent to the CPU to wake it out of idle. If the
    nohz_csd_func() queues before sched_ttwu_pending(), the idle load
    balance will bail out since idle_cpu(target) returns 0 since
    target_rq->ttwu_pending is 1. If the nohz_csd_func() is queued after
    sched_ttwu_pending() it should see rq->nr_running to be non-zero and
    bail out of idle load balancing.

  - The CPU is in TIF_POLLING_NRFLAG mode and instead of an actual IPI,
    the sender will simply set TIF_NEED_RESCHED for the target to put it
    out of idle and flush_smp_call_function_queue() in do_idle() will
    execute the call function. Depending on the ordering of the queuing
    of nohz_csd_func() and sched_ttwu_pending(), the idle_cpu() check in
    nohz_csd_func() should either see target_rq->ttwu_pending = 1 or
    target_rq->nr_running to be non-zero if there is a genuine task
    wakeup racing with the idle load balance kick.

o The waker CPU perceives the target CPU to be busy
  (targer_rq->nr_running != 0) but the CPU is in fact going idle and due
  to a series of unfortunate events, the system reaches a case where the
  waker CPU decides to perform the wakeup by itself in ttwu_queue() on
  the target CPU but target is concurrently selected for idle load
  balance (Can this happen? I'm not sure, but we'll consider its
  possibility to estimate the worst case scenario).

  ttwu_do_activate() calls enqueue_task() which would increment
  "rq->nr_running" post which it calls wakeup_preempt() which is
  responsible for setting TIF_NEED_RESCHED (via a resched IPI or by
  setting TIF_NEED_RESCHED on a TIF_POLLING_NRFLAG idle CPU) The key
  thing to note in this case is that rq->nr_running is already non-zero
  in case of a wakeup before TIF_NEED_RESCHED is set which would
  lead to idle_cpu() check returning false.

In all cases, it seems that need_resched() check is unnecessary when
checking for idle_cpu() first since an impending wakeup racing with idle
load balancer will either set the "rq->ttwu_pending" or indicate a newly
woken task via "rq->nr_running".

Chasing the reason why this check might have existed in the first place,
I came across  Peter's suggestion on the fist iteration of Suresh's
patch from 2011 [1] where the condition to raise the SCHED_SOFTIRQ was:

	sched_ttwu_do_pending(list);

	if (unlikely((rq->idle == current) &&
	    rq->nohz_balance_kick &&
	    !need_resched()))
		raise_softirq_irqoff(SCHED_SOFTIRQ);

However, since this was preceded by sched_ttwu_do_pending() which is
equivalent of sched_ttwu_pending() in the current upstream kernel, the
need_resched() check was necessary to catch a newly queued task. Peter
suggested modifying it to:

	if (idle_cpu() && rq->nohz_balance_kick && !need_resched())
		raise_softirq_irqoff(SCHED_SOFTIRQ);

where idle_cpu() seems to have replaced "rq->idle == current" check.
However, even back then, the idle_cpu() check would have been sufficient
to have caught the enqueue of a new task and since commit b2a02fc43a1f
("smp: Optimize send_call_function_single_ipi()") overloads the
interpretation of TIF_NEED_RESCHED for TIF_POLLING_NRFLAG idling, remove
the need_resched() check in nohz_csd_func() to raise SCHED_SOFTIRQ based
on Peter's suggestion.

Link: https://lore.kernel.org/all/1317670590.20367.38.camel@twins/ [1]
Link: https://lore.kernel.org/lkml/20240615014521.GR8774@noisy.programming.kicks-ass.net/
Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..1e0c77eac65a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1205,7 +1205,7 @@ static void nohz_csd_func(void *info)
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
-	if (rq->idle_balance && !need_resched()) {
+	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
-- 
2.34.1


