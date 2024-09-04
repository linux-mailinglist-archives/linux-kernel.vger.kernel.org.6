Return-Path: <linux-kernel+bounces-314849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E296B9F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9526B23DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A21CF7B7;
	Wed,  4 Sep 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lN0Sz9BM"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D11D1737
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448403; cv=fail; b=sIrQlGhf9pxiTEh/gXaQmdubAYugCbwrpX2uZhRi4qp6uT6mT9Mo4/NzAjQgBPXYApKEwxkW2YhkNufUk9gcZXz4TQvpEocTOKm4MST3SPwdpfqYIdAnKFoxCcj9kJIfGMXcrH0q7LrFKFM/WmzBiuQM7C1wOvAsJCkEU7UtUYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448403; c=relaxed/simple;
	bh=OO0wmb5wmhOrYsyMyz/DY5dUDfkAyZF7hWxTAGjl9Gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqldUCRBxRDjTYb133rqaTZQUqgWD3Oi/t1Rb1LYF2vj8deo0DEGhn4P8bdXImQvblrgg3H/PK/WloE+sXFx6X/0QQtsyC6ThLQXMrFK1+AtWCRkMjRdeDafaUsBoK+Y6k9d1Uno7HcLeOKjP42Ov38aqGKLiobn45QuZwbh59I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lN0Sz9BM; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqvsw8eSeE5DZJ1dKCwwn2Ji5OBXnLjpBhO88l9d/BznTLx84GzcUZuG7lq3FHfF7xPYiseCkUmgda1TW5t5bzx6WbbS1ucVcgEo32XMudlIw8pew350VpJnKzVsmVv1MhLTLI5APkN/Gei0M7pZJH2HGfp0qbla3O/+uQusZSOFw1q1A5fEfS56vEtcs1pqu87GPZHUet0y5h8mNTcHPauY+pDheT9gulX1zDcrIB26iGIlMitqOGFfLRwa305FTnJmzlm2F79apB6csM1wOH8Q1wObKD2uSLRiysSrMjPlosO4Hs6dY0pN6QlgcRg/7BGfAGdFTGrNorjgLqgT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyNztcr6KwyHBUvTDhkV1jlKtHlzcD/C15p/urXVO/w=;
 b=y2awn51IAUFBaiNwZxrpjVfHQ9I1CmSqKKreixm0chLlMdOHpsRQM5lDi3PCO6YzKFWR9oxRfl7wZ2j78v78NGCaB6BRh17RaLKsHHdjk4AkqlrrLjWtjluBGxzGY4ISVz4TwNivLaF5dponI+nHfpQhg1n0tsDS7zM4O3yN02X1p1jc+rpPSpWkj5ooxU8rcYs+3m5Tgztqhbuh4uOjWZQxz7i5UXyCLQ+Ud4YaMRYBj8PNpPg4f43LHUCS2bMQ7Ofi6qDS205Qk2Ajl6wV9njg6ScV9UourkMmkQ6ME2oz4mH7IUq4WM523WsZshwEmD1WDTaILJdqbENPwc+Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyNztcr6KwyHBUvTDhkV1jlKtHlzcD/C15p/urXVO/w=;
 b=lN0Sz9BMi6vz7fuVKjHF8df/Q7N9hWsN42lumch7uUCAVPxeHGOc1AM8yN85ZrAA+RZRekz0uiKMMLuyffWz++Qs4zigiMTxJav9mx+oMKJRQyO5WE1A1QWxh+2v3WuvxTM6F6vC1rX+raX/rQWLQXqLgI1XHBRI0fkRxvdDcUg=
Received: from BN9PR03CA0843.namprd03.prod.outlook.com (2603:10b6:408:13d::8)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 11:13:17 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::56) by BN9PR03CA0843.outlook.office365.com
 (2603:10b6:408:13d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22 via Frontend
 Transport; Wed, 4 Sep 2024 11:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:13:16 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:13:09 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
CC: Leonardo Bras <leobras@redhat.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, Thorsten Blum
	<thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>, Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Caleb Sander Mateos
	<csander@purestorage.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Chen Yu" <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Subject: [RFC PATCH v2 2/5] sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
Date: Wed, 4 Sep 2024 11:12:20 +0000
Message-ID: <20240904111223.1035-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904111223.1035-1-kprateek.nayak@amd.com>
References: <20240904111223.1035-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: fbed5a6f-4681-4a11-9dd7-08dcccd2937a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtNsbllxUetVmt91X1qMJisoZjPkBR0h/hvr9AHpfH7cBvfOVBC2CrQspzqh?=
 =?us-ascii?Q?Y4wE8D5jn6Rhq4rGahcCRzoYdEm1u8raWad1tg55yWdbGxORq1Wqay3XUyfa?=
 =?us-ascii?Q?Dxx2VQW9CBvvCAf50W1NGXD6sUp8yWn90224Lh3Lyn79E892OyFjb4aFfazS?=
 =?us-ascii?Q?TYGUdjz5wpLLcBNsA1QsLeO0qvS8GUY05ajwvQlT0e9Nkfgj854xa+TF+jVw?=
 =?us-ascii?Q?E4g3RgQljjvAkl8cwtDIgmg/E2029azhTToRiOE+KOL6USviKh9re8gSOBGl?=
 =?us-ascii?Q?rvUQ8PbPnrPOFbKdxtQ3H+v8E16sIiTa2W28UcfsihOeOx7UldZIghTqLKcw?=
 =?us-ascii?Q?n4E3Bel2qb5SFyMZFUYYsuCgdnRtfNReceqSqOTkdenm/8BH+zkh8/1WgDmy?=
 =?us-ascii?Q?Mmrm/F5Q72rDMYFhg3CpOKX0o9IC6k7Lg2Ft5acTshzlHmhVCvAUd8iyyKVK?=
 =?us-ascii?Q?Hz8YTj13Q9xFomHxOnHGTDuqYI25j4u9UJhbagPbrBqpymTTz4X59rLDcVYU?=
 =?us-ascii?Q?AibuwJ68WyDYXhyCthSrj1hn1/p3tX5G3SUmDmc/L0UIYWlXn70eRxqJpoVt?=
 =?us-ascii?Q?LGjfwKNS70uF7w33OZNCjsLWIeE+8JbnI/Za2KnTgpFypUE1nTdCRhaJlbs8?=
 =?us-ascii?Q?nFbctqfbnQJlg+p1j8k58UNKRtaY4lxn0pm4y3TYf05azdCAuNJ+N3kR+CFz?=
 =?us-ascii?Q?SBfCWzX+CnPoUB9Fw1ZiFKr0JRO+UW6nlYtK5QBE/43lAc1qpHB/+59xuntS?=
 =?us-ascii?Q?TR3Bgi54xu9ma1ZLjdWl1Ta8ibIRZeBgcjG8BZApVXZ43OdVER0bhd0BKqd1?=
 =?us-ascii?Q?7MtHCs2SXwYEDLgqKSYAS25hpBGrNoYmGqHp/PmPUqxG+CQs4z1ZADX64qAK?=
 =?us-ascii?Q?lY7fa6GOQj3nHj/ydZKeTj+Ief9KxX04oHQLGSm3KEm6r2uGkp7i+vshb3+g?=
 =?us-ascii?Q?di8HMq4ypzNqb8+nbRPh15I+l5gLupyn5ogFaJDpN1eqi7iMg7IZI72/FC5k?=
 =?us-ascii?Q?+mJZh/an9euhNgqwZM5buQSIph8a0IGH+5VDHZmzBlDXBS2+nCErnekYKrSY?=
 =?us-ascii?Q?Yt5V8rPqX4O7jAxCIZJGDkSG2UH/P5IzxAqd0l6X3QrkRZ6CE93hJkEk4+2Q?=
 =?us-ascii?Q?1iInGoay+e/iXxfaZ8Kmz64EFwwNVJ1v/MmrWyn1S/iuCAz9uHYHDO6mX2/8?=
 =?us-ascii?Q?AAwZUvSFFx6xOuD8TnaQ9VdbcdpFDlmIF2a1jOKtMgL/t/A7fX+VSJajiuht?=
 =?us-ascii?Q?sD3jAjpyXpLcopIVSBzPx4iix0GDQRTYW7e8xeTnUhfxw2wXdJ71/QOeugzi?=
 =?us-ascii?Q?J0gKg5Cn0x+a4AsRSPwgrEfWewihF2ACY1dcSRUCS4mfrTzAYeVG+2ehUc9n?=
 =?us-ascii?Q?/8WNqTaBkL45y/VfRfB9DWr4C/5JsLJgjlYBIgK792BJfVzkfrRUe6cNYdSe?=
 =?us-ascii?Q?nMX/fru9ny6vkba+N10RYe4cSRogR61+XBRATbyzzjhvTKJrxP27QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:13:16.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbed5a6f-4681-4a11-9dd7-08dcccd2937a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351

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
v1..v2:

- Fixes in changelog.
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcad010bdc6f..3497c35587fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1223,7 +1223,7 @@ static void nohz_csd_func(void *info)
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
-	if (rq->idle_balance && !need_resched()) {
+	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
-- 
2.34.1


