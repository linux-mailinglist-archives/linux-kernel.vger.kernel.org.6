Return-Path: <linux-kernel+bounces-247308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C592CDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D734D287C68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732718EFDF;
	Wed, 10 Jul 2024 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yptkNHpB"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF718EA86
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602195; cv=fail; b=UYOkh9d/Fn5gS2zdY4AXHNY952eJB4YEG+hphYCiwYSykuDhL2kP99np4LqGa+5lzizfCpf4wEusVEreetHay56UW2tFpyYaQkKhOgkdNgm0g9NUH3X86d6eVOglLn8lGGqFdDJ3J99BLwMoPoyg2a29GXjCXnn2OtOixhEmiDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602195; c=relaxed/simple;
	bh=wJz8xlUL6j7pNimpIEL+8AYBbGd3gVI/b4Emsu/7A+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vs6v1qdHU6A5CsZVToh0dbCjM02RM6DXphhZmbfXdxyIh0eztgN3vZwDDZDxC8orccyt+Ta1D8uzgKwSo26M2PRX7zlqVLmB7eY9FR7759Mjkuld22AbgH6lOLIsvu6Fx2tkBtWUjqf7qREQTwAiBR7k/6T3jOffqKwtjTJHQn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yptkNHpB; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meOOPOha1CPP8GuUYXobftuqmGSXd4CZrogr2KV5IeYOdh9tVnUjww3c0G4M8Q8qY47I0XHi7iXAZzvR2x+ON6GKek11iI2G82Ou/as5sj3wP2VgVJYqaUjo6k6O2qIuHEMg2zUQrxW7MdFfP54uAJm+roMyxVI0DqGJqqebrg2+9mUtbH27oSBpLPjBSk0+m9oZGUB0nxV86Z0tuxjzPZU554zlJRAUBMGyCdK/0r1/6rcj+l8tCeQbvQrp3e/m3+tns6eQvAJU238aHrJl3oUFcCh9TyO5g+ODTPHlib2vstlHz19DiuoT+WQXUmRWAsP4zEeg17rH1q/FB3ofVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVAn/kZjrqAb3iJjYk/98xigYUD2onh9DGXB0lQ4Lk8=;
 b=FBK8Wv9yKc7iA6TAwi/hQM7KwbmNNG2fSpV3+28s0l9US8/xho2v+lKMjDw2BjPrc4miFO6VgCszE3FZRNvy2ArKuu6jCS06wE7CiqYl4ZbYigwsQkzOujDuB5WdnpWmdxQ4+yqrjD+Q8/pyeg29lQk7RePIHaTFu2sMGRsJFFq+V9Iu9O8t7x53oRvz6ySEp3lgTKBtljMobGORHliIjJ9l9MoFsvVxNbTnsrF70Xwy03Oi+pjk7ITJAU8ZR9uce2SJIEV0KtX8D0O7vVQP5PO45db0Zqp0c5nVLWYtCfMcCDEUkVz/R3RFP3+5sfuiNwMsBrr1kk0/UhKj0mrAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVAn/kZjrqAb3iJjYk/98xigYUD2onh9DGXB0lQ4Lk8=;
 b=yptkNHpBBa+ists9521f7A7hxtsflLLb887/vvPu/OpkQg2hTWSKk0g8exX/fWtO8xejrMwbmFzOkTDzHp7KyJiuj7qxIyoiaEHB7QB0ztE06+831HGSZ74RjE03YVg6Oj1cBFvyXrdVlwwnUct6I8nE7Qur6VPXepmRQcs9sMA=
Received: from SN7PR04CA0068.namprd04.prod.outlook.com (2603:10b6:806:121::13)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 09:03:07 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::e5) by SN7PR04CA0068.outlook.office365.com
 (2603:10b6:806:121::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 09:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 09:03:07 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 04:02:56 -0500
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
Subject: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()
Date: Wed, 10 Jul 2024 09:02:09 +0000
Message-ID: <20240710090210.41856-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8996a1bf-142b-4029-9c7d-08dca0bf1d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AR50yfhuELSkMXm7iq3fbMdW+FIpubg6Sy0Z0e2dLKuGN71/DuK+z0g/uvKr?=
 =?us-ascii?Q?8TqGIcYKlk3C70EPyw3ZnURUMjksom1QPC/r7P2Um1bdj+oLuPvlelPHxZ/6?=
 =?us-ascii?Q?ME91nO9tZTA0gb5wnZQreE0OF8gvb34wHjKi7OehYJ5ZHvMyyagky/Ix4DNY?=
 =?us-ascii?Q?I+HGUaC5N+UwaiZhvB0Rmy48iO4eVNDHk2SJylO1g6A1kmGBMrOKLxn7l0SM?=
 =?us-ascii?Q?YFX3NgzIX1u2fvsb6tqIkLUcmdwC8z5cFI/34fzAs75aSQ09gM7RmW/KK/zF?=
 =?us-ascii?Q?DUssbcBWB69OAI0nQ/tGcDJyVwILo11T20kK2hdyNd/lF4g3NPsYQBVoVpkJ?=
 =?us-ascii?Q?yKhFGRwl+Lg+7L7VeA6FZW0qQrE5TX9cuHj8fjJZeM1H2/e/ZgdQHxWVUUk+?=
 =?us-ascii?Q?PnvHIUF60HmC/1eg9vfEFe5uyHoQUj4KHkhEITIEu6dZ790uok6CL/E0LzIW?=
 =?us-ascii?Q?Vq83a6cjakaKTJPJdh/BA6bo3Tq6EihHnqo+YkV4r0UmASJUUgm9MrRks4bD?=
 =?us-ascii?Q?cZw9+iPxmrocJIKj1gFiLvtfPKWx7egNJq7kuBQF5lNIdB+PqSP+vPvjiIsG?=
 =?us-ascii?Q?X1cjF7l5DU6GmTV4UUK9M/nzBXb7EtlzioaofQFOlJ59vX7884wiSpqRqAOp?=
 =?us-ascii?Q?9fTtfzlKyWmUU9Ex8yq8VnEXm0KGGFJCp7SAtQxPdvgmE7N+0DUAw89LfhK6?=
 =?us-ascii?Q?xQQeKHdNMvXlI+SVi39d9o6M1zIe+uTuJRpGnU7zlR73MtvBAO0I/hSYEOlx?=
 =?us-ascii?Q?bDAIGrBxyvlAMG12DK7wV6K0JXPoDiWaUEDmKMbACDM5y8+49xB3fowWNYTy?=
 =?us-ascii?Q?dgIhkA92ogNKHXVslxHNZZXusDNx48+miSp38b4FvdoH/LJ5zRTukf6DH9Fs?=
 =?us-ascii?Q?UOnW/DDkptHTIiVk9+3D2TB0B7Ez99hYz6dvid4pNNoLIpL8zpbHfPEbtDTf?=
 =?us-ascii?Q?G5rvR3U7MGU7qgldg/uCIjvMWGKFT6EiRcm6kTH6av+T7qt9qGFcM+chuncl?=
 =?us-ascii?Q?VHaHvYiC43Ukimlf2O+crZnMXknP7bSNgTzfXMo3VmMfOqtcyiQswzt2D4Z6?=
 =?us-ascii?Q?uZ4arkru/edKUgTzO+1Ff87nqANfhOKFPioqVd3F8w4Eq+qq805i6l/YJcvc?=
 =?us-ascii?Q?fN+n6yUUcNU+X6gBEdb1Yw5g+T432lWjPD6kBXIbDpISwHftSoB+V2CDu6Sm?=
 =?us-ascii?Q?yT/2vvDIXtYdH1FwvicRh/vEiEJwpnlYTdKM5Rk4L2k9hXQkIMOy9xBBtRGY?=
 =?us-ascii?Q?F9L0/Hxd7tKUZrIegKBLEEbIAhGoP8/Shak9wrYo8/fx552rILDELJlbaBcW?=
 =?us-ascii?Q?ZC0viBicBa+Jd65dBqgMxdY0huotXJjjZSlB7HE/Y9mxhxph7CHWazIerk0+?=
 =?us-ascii?Q?QdY01qh4iWNttG7QnPh4rOeauBI1m1A11TnMw/KSy+quZ3Blqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:03:07.2451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8996a1bf-142b-4029-9c7d-08dca0bf1d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

From: Peter Zijlstra <peterz@infradead.org>

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
IPI without actually sending an interrupt. Even in cases where the IPI
handler does not queue a task on the idle CPU, do_idle() will call
__schedule() since need_resched() returns true in these cases.

Introduce and use SM_IDLE to identify call to __schedule() from
schedule_idle() and shorten the idle re-entry time by skipping
pick_next_task() when nr_running is 0 and the previous task is the idle
task.

With the SM_IDLE fast-path, the time taken to complete a fixed set of
IPIs using ipistorm improves significantly. Following are the numbers
from a dual socket 3rd Generation EPYC system (2 x 64C/128T) (boost on,
C2 disabled) running ipistorm between CPU8 and CPU16:

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

   ==================================================================
   Test          : ipistorm (modified)
   Units         : Normalized runtime
   Interpretation: Lower is better
   Statistic     : AMean
   ==================================================================
   kernel:				time [pct imp]
   tip:sched/core			1.00 [baseline]
   tip:sched/core + SM_IDLE		0.25 [75.11%]

[ kprateek: Commit log and testing ]

Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1e0c77eac65a..417d3ebbdf60 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6343,19 +6343,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Constants for the sched_mode argument of __schedule().
  *
  * The mode argument allows RT enabled kernels to differentiate a
- * preemption from blocking on an 'sleeping' spin/rwlock. Note that
- * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
- * optimize the AND operation out and just check for zero.
+ * preemption from blocking on an 'sleeping' spin/rwlock.
  */
-#define SM_NONE			0x0
-#define SM_PREEMPT		0x1
-#define SM_RTLOCK_WAIT		0x2
-
-#ifndef CONFIG_PREEMPT_RT
-# define SM_MASK_PREEMPT	(~0U)
-#else
-# define SM_MASK_PREEMPT	SM_PREEMPT
-#endif
+#define SM_IDLE			(-1)
+#define SM_NONE			0
+#define SM_PREEMPT		1
+#define SM_RTLOCK_WAIT		2
 
 /*
  * __schedule() is the main scheduler function.
@@ -6396,11 +6389,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(unsigned int sched_mode)
+static void __sched notrace __schedule(int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
 	unsigned long prev_state;
+	bool preempt = sched_mode > 0;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -6409,13 +6403,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev, !!sched_mode);
+	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
-	rcu_note_context_switch(!!sched_mode);
+	rcu_note_context_switch(preempt);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6449,7 +6443,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
+	if (sched_mode == SM_IDLE) {
+		if (!rq->nr_running) {
+			next = prev;
+			goto picked;
+		}
+	} else if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -6483,6 +6482,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6523,7 +6523,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
+		trace_sched_switch(preempt, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -6599,7 +6599,7 @@ static void sched_update_worker(struct task_struct *tsk)
 	}
 }
 
-static __always_inline void __schedule_loop(unsigned int sched_mode)
+static __always_inline void __schedule_loop(int sched_mode)
 {
 	do {
 		preempt_disable();
@@ -6644,7 +6644,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(SM_NONE);
+		__schedule(SM_IDLE);
 	} while (need_resched());
 }
 
-- 
2.34.1


