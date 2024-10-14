Return-Path: <linux-kernel+bounces-363620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E617799C4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D91C226D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B2156F3F;
	Mon, 14 Oct 2024 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQvLh3pe"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A813CFBD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896790; cv=fail; b=tbIRuUmrZBbjfSjktWMTmLfQzenjFUiOjFymi6AQ3jLSJM+GV/b5IN2lhBRWvYZyUgYLly2d/5cA4ScyAWkUW2ZbGu6yYIBFXDJXTY5IOfxZrrjd6vTEf86whAO1r4HP0b7H/aTCNRFHnzS/FJmjVl3ZstcVT7SOoINyv37Zv74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896790; c=relaxed/simple;
	bh=sIyzz3fvlpW3TOgaOOWGImoYuQ78AypeefgW9lyqiGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnpF/Ti3uW2v6oyHiAvnz6fsx2nXQZbqa0e8omN5H6MAsvqvVH4mtOFbXtV490x6gLvXJ790piI3XBLTskTNHzaYEW4jDZ77Bou/tS5yWDIduObp3hcHu4mmFi2TAeq7Q2X83Z+CoSzJq1P1/LjTDWHzz9VsGMNoKrfxY2nfY0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQvLh3pe; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yamCgRwaF8/4GdtsiNhHzbSKX2WpGs6WGIWizNBfRTMmfLPyRKKJWVZcY5X52Nxs1uUOsgOfZcnFwLiQFcegUbe7d7yC8uHGuNEyWU5vtV1hXyFpLIvgVlskliw10Eax9fd3NQ6HxXN9vxE5DPaVJWi2PJQcqq0Dj/2M7WEfN43jdkg94KlAxg6PtoLWUFtvjH/qn4Waka6dm9WJNBMITa8xQUO5W+/04wacF2F10YMewqstvHO+P3Mv/zuWfgvBvzICuHe9NhxODSOTU/yzW1a926+Dp8AoRqAHGou/zOGuE5guB5TCGpUaMzJUu4vrlvTRH+MU9PxUxsD+zicNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7V2FYQZbGLGP2iose40F3ChidVJFQAWWV9OIk5z96g=;
 b=CrHguMNcNqHHYZq7rNb7WbijeeJrK2D34bYJIoDbPJZ/TuWxKvi5ffFSpOYPYP1o+WZJBWoPFN1D8pWohJeJVlBISMuSV8NHxRFeb8MlPWnKdm/hpiUBF/S0cbir9PjqyjB1svuYvXvf4fSbDChxT9qdT3HhaQIJEv15Y5MLQI/rt92Oj+O8/5r+QnWv4Uv3ZHhA0CVFTFJKqnnXJPNV+RilixpqtPrVNtbLucPjPeZ0GvS4bVf/LCYZC4SHRWAudieJDkLwfz4mv5rwMUaSg3MR41uQ2LO2NuA8AkAgVbGNINi1hZn5P8ZRElwh/ttaV402ZTX3LU37L0ZHZu5qiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7V2FYQZbGLGP2iose40F3ChidVJFQAWWV9OIk5z96g=;
 b=nQvLh3peQHGWY+MUa545aRQFhyNhjSOK5wkVaz1vD5kAtsXj29oUnWNFsTgiwppUX1uTgBsWqeB1O73EZZC7Zrzn7W1nyTECmiQIeUs7oY4y8iYLR7giBYP7vhc+F1am+9InThP0IKRqkqQjLy3Ac2WLPG5I3RKJ+pRDzeO/R1Y=
Received: from PH8PR05CA0022.namprd05.prod.outlook.com (2603:10b6:510:2cc::10)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 09:06:24 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::4d) by PH8PR05CA0022.outlook.office365.com
 (2603:10b6:510:2cc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Mon, 14 Oct 2024 09:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:06:23 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:06:13 -0500
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
 Prateek Nayak" <kprateek.nayak@amd.com>, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v3 5/5] softirq: Avoid unnecessary wakeup of ksoftirqd when a call to do_sofirq() is pending
Date: Mon, 14 Oct 2024 09:03:39 +0000
Message-ID: <20241014090339.2478-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ab3f0c-705b-4799-fe49-08dcec2f7a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ezrnlsbXhW2AZQ/U3MkTn8NL3NOc+ITDakWE+RdkFkf61MHDBvpIq1nqI7hG?=
 =?us-ascii?Q?71C4nC4/0GfgxBeSCqZ9qNbqwOV1I8yZI7rg/bM4+0fe0KaBkfPz6lOxxV1i?=
 =?us-ascii?Q?R3qSd/Gb9u4eKjMI1xqjPEBB2026yNJb04PdNTGHoJo0W5CQkXNB+9ZrvDbF?=
 =?us-ascii?Q?yWYnVj3lnHP93Lm7jfgzcqTipd3Xee7Kkh8hoUS+UbUJP3caFaxJP3g681o0?=
 =?us-ascii?Q?tbn3wRD+1unlP144D6zlueKzigXHm2tGCnIJr4LXAyK2POH9eY0ocVDpIawJ?=
 =?us-ascii?Q?Cwpc5/vsnsfnn1ls8byWBHHldMurmshVKa9g7/4tOsiwfEGukKQ+ZQqK9zYM?=
 =?us-ascii?Q?92gUwXlFRHQRyoFzfimQ2OOo5zytiLO3YDihIQ7JQIuMwSuLlb/V54ikO4Xr?=
 =?us-ascii?Q?7u9vqMtAZo99WocaNwY5eSXYnri/kJjK11mF4FYMrvYOWmssBPP6qAmMPUyr?=
 =?us-ascii?Q?SeEdG3uLFv1JpagVeWd/q80cnFmVAbg/4ozSn3gXJIimkPfwmFkX/ZEZIwEM?=
 =?us-ascii?Q?2HvjiDlLixxB5pHsAvCTeMlh7XuB3tzAUJfPDfUs+ZPOdh/v93PmPxJkLQz3?=
 =?us-ascii?Q?XEdEZYSGvGPLm/vqrfrnk6VS1JCMvnI7iYvw+tSSlFiuNoYtaDIEDKrHYwaH?=
 =?us-ascii?Q?ZiOQcIDN7eLnVU1QtP05ChoR5fZQfWanyTj/aSOeGf47ScyNaAb+lQoK+/aA?=
 =?us-ascii?Q?Vn6at0rTC4mkSaU+0+PpUTJmIvPAI8RO5LOXjmIkyKJcop0l2bQULLKUu4C0?=
 =?us-ascii?Q?q4b5oj15AU+/TZHdhQvypUwb4drhlmhgNxqEVizQdyuLNYPnjVC7Nph4Cxzw?=
 =?us-ascii?Q?2aOHP5KVszWnTLeBKG8ZpF6PK66c+3n7cMYV1HxlkXNWnsUTeJtJsM+K4z5f?=
 =?us-ascii?Q?jyEhqlpK7FtQUgUOwMZJieZ20gnGNt+nqPxjUhuOzUOqf6EyvPdY+Rp3QIP3?=
 =?us-ascii?Q?B0QiiXkGT/BMr0WK+AqNr50qf4fuqPAw6tA3o6dTzmTvkHefw1eVb8bDbdEg?=
 =?us-ascii?Q?oKc/ho3S3es0MzDsZPFVeU5gawIR8KDp9YsbQtGTz7RgepwxpxD35lai6xIk?=
 =?us-ascii?Q?fQyW5czrN4RYhXiLu86rdIXMDGPiY+pDWgtO6ItIYAUEjH9fYkYGW11ZlVvl?=
 =?us-ascii?Q?A8fxf6IUhTfKnk9nNMY5W6DJWKEaYWTxKwcnzNa0rGDSmwxCD/k1TBzQqQuw?=
 =?us-ascii?Q?WoZ2/KhKdIJ1grfVS1QhBaHqn6kKV3ph9itEBX98WJ1TfJmaAORtzrilXPob?=
 =?us-ascii?Q?Vpq32Iw1slT+LV87F2ETVE0woN2ghNEEl6wQeFlcJ1lfSeixY0EMX4B/SMzS?=
 =?us-ascii?Q?rxYToydO4VgZEEmzsQyzh+qECfgN+2kq6hV67QfMr3+HQ1NgLjEyxNKulx60?=
 =?us-ascii?Q?eI1Om7Aw9vi303E8DaAsk2ZJoMjn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:06:23.7230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ab3f0c-705b-4799-fe49-08dcec2f7a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623

Since commit b2a02fc43a1f4 ("smp: Optimize
send_call_function_single_ipi()"), sending an actual interrupt to an
idle CPU in TIF_POLLING_NRFLAG mode can be avoided by queuing the SMP
call function on the call function queue of the CPU and setting the
TIF_NEED_RESCHED bit in idle task's thread info. The call function is
handled in the idle exit path when do_idle() calls
flush_smp_call_function_queue().

However, since flush_smp_call_function_queue() is executed in idle
thread's context, in_interrupt() check within a call function will
return false. raise_softirq() uses this check to decide whether to wake
ksoftirqd, since, a softirq raised from an interrupt context will be
handled at irq exit. In all other cases, raise_softirq() wakes up
ksoftirqd to handle the softirq on !PREEMPT_RT kernel.

Adding a trace_printk() in nohz_csd_func() at the spot of raising
SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
current behavior:

       <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from nohz_csd_func
       <idle>-0   [000] dN.4.:  sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
       <idle>-0   [000] .Ns1.:  softirq_entry: vec=7 [action=SCHED]
       <idle>-0   [000] .Ns1.:  softirq_exit: vec=7  [action=SCHED]
       <idle>-0   [000] d..2.:  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=16 next_prio=120
  ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=ksoftirqd/0 prev_pid=16 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
       ...

ksoftirqd is woken up before the idle thread calls
do_softirq_post_smp_call_flush() which can make the runqueue appear
busy and prevent the idle load balancer from pulling task from an
overloaded runqueue towards itself[1].

Since flush_smp_call_function_queue() calls
do_softirq_post_smp_call_flush(), waking up ksoftirqd is not necessary
since the softirqs raised by the call functions will be handled soon
after the call function queue is flushed.

Introduce two new APIs:

- set_do_softirq_pending(): Increments per-cpu softirq_ctrl::cnt by 1 to
  indicate a pending call to do_softirq().

- clr_do_softirq_pending(): Decrements per-cpu softirq_ctrl::cnt by 1
  just before calling do_softirq().

Call set_do_softirq_pending() before __flush_smp_call_function_queue()
within flush_smp_call_function_queue() to indicate a pending call to
do_softirq() and clr_do_softirq_pending() before calling
do_softirq_post_smp_call_flush() to mark the promise being fulfilled.
Since this impending call is tracked by softirq_ctrl::cnt,
should_wakeup_ksoftirqd() will return false and prevent a pointless
wakeup of ksoftirqd.

Following are the observations with the changes when enabling the same
set of events:

       <idle>-0       [000] dN.1.: nohz_csd_func: Raising SCHED_SOFTIRQ for nohz_idle_balance
       <idle>-0       [000] dN.1.: softirq_raise: vec=7 [action=SCHED]
       <idle>-0       [000] .Ns1.: softirq_entry: vec=7 [action=SCHED]

No unnecessary ksoftirqd wakeups are seen from idle task's context to
service the softirq.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
Suggested-by: Peter Zijlstra <peterz@infradead.org> # Reuse softirq_ctrl.cnt from PREEMPT_RT
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v2..v3:

o Updated the traces with one where SCHED_SOFTIRQ is raised from
  flush_smp_call_function_queue() and not from hard IRQ context.
---
 kernel/sched/smp.h |  9 +++++++++
 kernel/smp.c       |  2 ++
 kernel/softirq.c   | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 21ac44428bb0..83f70626ff1e 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -9,7 +9,16 @@ extern void sched_ttwu_pending(void *arg);
 extern bool call_function_single_prep_ipi(int cpu);
 
 #ifdef CONFIG_SMP
+/*
+ * Used to indicate a pending call to do_softirq() from
+ * flush_smp_call_function_queue()
+ */
+extern void set_do_softirq_pending(void);
+extern void clr_do_softirq_pending(void);
+
 extern void flush_smp_call_function_queue(void);
 #else
+static inline void set_do_softirq_pending(void) { }
+static inline void clr_do_softirq_pending(void) { }
 static inline void flush_smp_call_function_queue(void) { }
 #endif
diff --git a/kernel/smp.c b/kernel/smp.c
index f25e20617b7e..be0f84d62475 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -612,7 +612,9 @@ void flush_smp_call_function_queue(void)
 	local_irq_save(flags);
 	/* Get the already pending soft interrupts for RT enabled kernels */
 	was_pending = local_softirq_pending();
+	set_do_softirq_pending();
 	__flush_smp_call_function_queue(true);
+	clr_do_softirq_pending();
 	if (local_softirq_pending())
 		do_softirq_post_smp_call_flush(was_pending);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0730c2b43ae4..3a6b3e67ea24 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -99,6 +99,10 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
  *
  * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
  * the task which is in a softirq disabled section is preempted or blocks.
+ *
+ * The bottom bits of softirq_ctrl::cnt is used to indicate an impending call
+ * to do_softirq() to prevent pointless wakeups of ksoftirqd since the CPU
+ * promises to handle softirqs soon.
  */
 struct softirq_ctrl {
 	local_lock_t	lock;
@@ -109,6 +113,16 @@ static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+inline void set_do_softirq_pending(void)
+{
+	__this_cpu_inc(softirq_ctrl.cnt);
+}
+
+inline void clr_do_softirq_pending(void)
+{
+	__this_cpu_dec(softirq_ctrl.cnt);
+}
+
 static inline bool should_wake_ksoftirqd(void)
 {
 	return !this_cpu_read(softirq_ctrl.cnt);
-- 
2.34.1


