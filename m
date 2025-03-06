Return-Path: <linux-kernel+bounces-549317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5AAA550E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6881E189713D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847B23026C;
	Thu,  6 Mar 2025 16:26:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DA230251
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278408; cv=none; b=XgFqpAMlal936Z8l2+ZGYfwRtqOHOiGicX4Kz3iMk14Nn49pXLRk/hELYFwb8oEbmoW3lJilX6kIqmY41QrprJABCtQG+w29NLEufkDwYbecpyeqtxmJ782cARg+Ya1L/xikuPo7W0UwSum69Qv0ipUzuE+9Es7RDqlr9Sygvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278408; c=relaxed/simple;
	bh=U4D6AnkAm3DyMaIpwwnp4I3SonqejwJWrZdwMLpk5XY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+UsaKAinYrDVC7QioXUS98bw+IdA0FUIsYrgA8lSznPI6+/YGtJ9iJe6Uc4TzsamRNVZNOUNeZ3VSLgvBka66JBhOYKWat0LqBKkPrSTSp9dfZDV1kJyZZvtEIOVEk8tberJZEnSmIVDfQDvZsMVYWBYNeBF626u2BgYRH+mjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564161007;
	Thu,  6 Mar 2025 08:26:57 -0800 (PST)
Received: from e125579.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 721683F673;
	Thu,  6 Mar 2025 08:26:42 -0800 (PST)
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hagar Hemdan <hagarhem@amazon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] /sched/core: Fix Unixbench spawn test regression
Date: Thu,  6 Mar 2025 17:26:35 +0100
Message-Id: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hagar reported a 30% drop in UnixBench spawn test with commit
eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
(aarch64) (single level MC sched domain) [1].

There is an early bail from sched_move_task() if p->sched_task_group is
equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
(Ubuntu '22.04.5 LTS').

So in:

  do_exit()

    sched_autogroup_exit_task()

      sched_move_task()

        if sched_get_task_group(p) == p->sched_task_group
          return

        /* p is enqueued */
        dequeue_task()              \
        sched_change_group()        |
          task_change_group_fair()  |
            detach_task_cfs_rq()    |                              (1)
            set_task_rq()           |
            attach_task_cfs_rq()    |
        enqueue_task()              /

(1) isn't called for p anymore.

Turns out that the regression is related to sgs->group_util in
group_is_overloaded() and group_has_capacity(). If (1) isn't called for
all the 'spawn' tasks then sgs->group_util is ~900 and
sgs->group_capacity = 1024 (single CPU sched domain) and this leads to
group_is_overloaded() returning true (2) and group_has_capacity() false
(3) much more often compared to the case when (1) is called.

I.e. there are much more cases of 'group_is_overloaded' and
'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
then returns much more often a CPU != smp_processor_id() (5).

This isn't good for these extremely short running tasks (FORK + EXIT)
and also involves calling sched_balance_find_dst_group_cpu() unnecessary
(single CPU sched domain).

Instead if (1) is called for 'p->flags & PF_EXITING' then the path
(4),(6) is taken much more often.

  select_task_rq_fair(..., wake_flags = WF_FORK)

    cpu = smp_processor_id()

    new_cpu = sched_balance_find_dst_cpu(..., cpu, ...)

      group = sched_balance_find_dst_group(..., cpu)

        do {

          update_sg_wakeup_stats()

            sgs->group_type = group_classify()

              if group_is_overloaded()                             (2)
                return group_overloaded

              if !group_has_capacity()                             (3)
                return group_fully_busy

              return group_has_spare                               (4)

        } while group

        if local_sgs.group_type > idlest_sgs.group_type
          return idlest                                            (5)

        case group_has_spare:

          if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
            return NULL                                            (6)

Unixbench Tests './Run -c 4 spawn' on:

(a) VM AWS instance (m7gd.16xlarge) with v6.13 ('maxcpus=4 nr_cpus=4')
    and Ubuntu 22.04.5 LTS (aarch64).

    Shell & test run in '/user.slice/user-1000.slice/session-1.scope'.

    w/o patch	w/ patch
    21005	27120

(b) i7-13700K with tip/sched/core ('nosmt maxcpus=8 nr_cpus=8') and
    Ubuntu 22.04.5 LTS (x86_64).

    Shell & test run in '/A'.

    w/o patch	w/ patch
    67675	88806

CONFIG_SCHED_AUTOGROUP=y & /sys/proc/kernel/sched_autogroup_enabled equal
0 or 1.

[1] https://lkml.kernel.org/r/20250205151026.13061-1-hagarhem@amazon.com

Reported-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b00f884701a6..ca0e3c2eb94a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9064,7 +9064,7 @@ void sched_move_task(struct task_struct *tsk)
 	 * group changes.
 	 */
 	group = sched_get_task_group(tsk);
-	if (group == tsk->sched_task_group)
+	if ((group == tsk->sched_task_group) && !(tsk->flags & PF_EXITING))
 		return;
 
 	update_rq_clock(rq);
-- 
2.34.1


