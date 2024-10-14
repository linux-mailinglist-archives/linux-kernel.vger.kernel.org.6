Return-Path: <linux-kernel+bounces-363611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A651B99C4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C770B1C22731
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247715359A;
	Mon, 14 Oct 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bs8haIZQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280714A0AA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896706; cv=fail; b=towGsEQRwvheO71dt1k5rZIU7bHRL8jyQUlJDB1BF6Y6CVY311940b6IcBVAM1G9JEkbUUKIb+kwhThN6V3k1vdAg3W6EBPeof+YMWDxntZ7LgEzzGOXPx+mLcYHiVC7uIT54Y1pqzeAIaaydxFHZk4Q0aoPcgdLX6pzldNNKLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896706; c=relaxed/simple;
	bh=FXY7bGQUPwQcqNYup3fSwLb5bEp+aqsTt9/xAaKbFyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPxqx4NeXS2GXYJYHE+v5uWG1Lne2wUgHbYX/ZWBdsWvARhhPnq6kStuIR8KgqAVJ+FqV5cMEZKHe894vy3wamHUDLWqWLslasjkVx4LdJ3Pnu4+NU4+4Q0xhuLLakzeThAn3mruwYCeWG6DCPsvElDvuP/7B9YLrvBrhSnenyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bs8haIZQ; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huvoGuw0kASHzWPBYHwcAGSCXVsY+VD9ZQ5KYMFtoaoZhBEjGBzcfMUy2qhFMNnOxiFJ2JCAJDea9ci2IqFagoj02mRClGEz1ED+sEf/vGzHPIAjijc/75WjzeF3TVEp/6u+jNn2xrAiBsXaQQHVBmCo4SrNV7Xe/uoG8RzwA6shjU+30EZt2RNcif52isBaRWAIF8FbxtkRBgr8X75Rh/HxVywQY2tMwhd9iEWi5r2j6k50XwuwLPkNiODr60wcVOTGjYgo3iDydnlEXxdV/ubV/SsD/R15nrM4a8zxv8CoEuCXxbK8AcmuoYXsNTvmUOEyPx989G+xuqxNZbb/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUHBiWBboSSLzj3A5G9NzZV2oiynraVsa7bVUdd/p4A=;
 b=Ug22hDAe8cD3OyPNjIeaeAMS5Dj1Z903hLH40iPPOFg87eC6fG2lo2imKdUc3WJf48fUvUefH1gBsNmCOIGPfeIdnGlpJAjYA7iieMYTqFzxH4UUl4KaevSivR6Itbp2MXttxeiQBO192CC2jM4dseV5FCKzmKFwFUlshihQ6LKpEd8X8O2XsORwI8/ltljqgdfjY11vpI93Vgh6anvZ0frKFDQNMNNrlnrKCocRirbDNH32frphAiAoOsdMv2XFP+jeuVJWiARRh/Im6H3LVdlWSZdP+0Zg0cpxexovajrUvGGenBO1KJj5cPvqW4uumLifxixsSIPfzGsAArKNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUHBiWBboSSLzj3A5G9NzZV2oiynraVsa7bVUdd/p4A=;
 b=Bs8haIZQ38LHSxvaYfVSCeXYoLjF2d+RkLFiUYNAvuQfCZULRVK7eOZHRsA6f2rPUDwEHUvE1PQ2VROZjAIkhRQurSjyyJAjh+ieJeBywIES6zu61KE5UNpKVZVsW84AJSDX2mmozdc1D+VA/NKuG+JQ9O2MCpdgAa+VrceEnjA=
Received: from CY5PR14CA0026.namprd14.prod.outlook.com (2603:10b6:930:2::34)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:05:00 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::12) by CY5PR14CA0026.outlook.office365.com
 (2603:10b6:930:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 09:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:04:59 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:04:46 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, Leonardo Bras <leobras@redhat.com>,
	Thorsten Blum <thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>, Caleb Sander Mateos
	<csander@purestorage.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v3 2/5] sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
Date: Mon, 14 Oct 2024 09:03:36 +0000
Message-ID: <20241014090339.2478-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014090339.2478-1-kprateek.nayak@amd.com>
References: <20241014090339.2478-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: d22b4590-286e-4597-58ae-08dcec2f482d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5h1Om1zqUoqi0mBo5ZC2VbBA4oAw/RuLbkFIb5c7No3BN+E7cWYKQWz0mLrN?=
 =?us-ascii?Q?Jt8VW1rFNNueB1piec9mT+21VebPTuU7LnlfY3NKiQ3hen6f6TjaL38NQ0mL?=
 =?us-ascii?Q?RhsuqpdDAOkuSWZ0Gdio7p7Ny8rM9+CpNWqVTE1ZhUUOuSQrx8hsqwyKow2S?=
 =?us-ascii?Q?EOSaRyVHDhQapUENFcWJiUlVUn1pKkk4q/KhN2MoVXydSS6UJx8o1cloEcld?=
 =?us-ascii?Q?t8xHsXneXhk9H/n+C5RqeWzyt0T99aVDCvolHVegxgZMo+9awGw3B5ekCO76?=
 =?us-ascii?Q?uIK2660lgSbVT+aBctmih0q8rsejg8kcGyk0i42o3a92PsMzlCJg5ZOAGvQo?=
 =?us-ascii?Q?FQz8fAH91UP49qeujFjAvHs0UF6iJG29JEJINW5unWikhZxw1PCwFusSa2Ss?=
 =?us-ascii?Q?6VLTpK046UxBKzqfHEn/8CL+lt2a6MBNAgKbFzcyab6e61pGGh+v1jn9nRI4?=
 =?us-ascii?Q?DgBaeL14mltWorJKGsNK2x21UhRhxebz7Sepu3cNbXRrhkKPFc0SFMQF674A?=
 =?us-ascii?Q?QZe5PS3OYkvYunmmHbGUnpA/a6hsTXFr+uJEurf5TtnCbPtM2bj+LGXI/sxw?=
 =?us-ascii?Q?++kiEBPBWTMiVttMz7gxicb2+fJ1tQh35y7Q5Ig0xWKyoKOWlRue4ucq118t?=
 =?us-ascii?Q?NlLhcoVMn215NtC+nPy1ZS68/NwEDS3AzCfaFu659XcO0CgFRVEIZt6lPRuX?=
 =?us-ascii?Q?bhxZV8XSJU5y3vw2pZCrRGkTeI0Dzfby8GAek7/gruZc5ny9hLumNZN17F+r?=
 =?us-ascii?Q?nLJBMeSgCs0SzPHQIhIyjqND10oaVIKvk6LKoL/oCkjDtXknJ37Wxehrqhnp?=
 =?us-ascii?Q?K/zgWXcA7ckYHp6LcxstpndwLYGGjcwzpbDU46dW5jcpUXHfsIwOQ/gyrU2h?=
 =?us-ascii?Q?84vfEqHekPUj4AKHhyodhbxRh4RBZxqfh7f88nN7kTMLaO4XZZmtu+cWFhzn?=
 =?us-ascii?Q?FdA7tHR52R+F5UDXMiaycclTGoUltvrU4I6LQcKCSPmuU5nOPk79OuiRv2y6?=
 =?us-ascii?Q?GhGVsqXFE9M+nAz84gXSbZoj41AcQjJUk7g3YFv5732Oehf2emaV0L0yxbYu?=
 =?us-ascii?Q?0SqylqTNNk+VuZMW3VPpDbdks5NQs2IgRSciNMaJXnQinJmwMFI0pc3Hz5DL?=
 =?us-ascii?Q?d7iiLbtvEiUwhqqK7kYG69cGqlVMC5NQU53KWzZUNNBXLUlmafIDeut7pUi5?=
 =?us-ascii?Q?UQsJ9BBSN+w6+mjdaHkYhGWnYq/BMTA6OZoFvT8xVYPkqEf1zoFlDA2x4Pm1?=
 =?us-ascii?Q?xHwa+1HftUy9CEFN15tiL6BUzu/USzrZp7t+m2x3wOoASKTyUPGv7D0kRZGE?=
 =?us-ascii?Q?iAxKSZQOsSyQvlKMms6wDmb6LuqryH/H9v7/gxnoUBLy1XoZmztuNCMAhUbl?=
 =?us-ascii?Q?Pk8HU1yhPkRmbIdentPpKpbmfBd3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:04:59.6598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b4590-286e-4597-58ae-08dcec2f482d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

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
  balance (XXX: Can this happen? I'm not sure, but we'll consider the
  mother of all coincidences to estimate the worst case scenario).

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

Since the condition to raise the SCHED_SOFIRQ was preceded by
sched_ttwu_do_pending() (which is equivalent of sched_ttwu_pending()) in
the current upstream kernel, the need_resched() check was necessary to
catch a newly queued task. Peter suggested modifying it to:

	if (idle_cpu() && rq->nohz_balance_kick && !need_resched())
		raise_softirq_irqoff(SCHED_SOFTIRQ);

where idle_cpu() seems to have replaced "rq->idle == current" check.

Even back then, the idle_cpu() check would have been sufficient to catch
a new task being enqueued. Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") overloads the interpretation of
TIF_NEED_RESCHED for TIF_POLLING_NRFLAG idling, remove the
need_resched() check in nohz_csd_func() to raise SCHED_SOFTIRQ based
on Peter's suggestion.

Link: https://lore.kernel.org/all/1317670590.20367.38.camel@twins/ [1]
Link: https://lore.kernel.org/lkml/20240615014521.GR8774@noisy.programming.kicks-ass.net/
Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v2..v3:

o No changes.
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..424c652a9ddc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1237,7 +1237,7 @@ static void nohz_csd_func(void *info)
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
-	if (rq->idle_balance && !need_resched()) {
+	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
-- 
2.34.1


