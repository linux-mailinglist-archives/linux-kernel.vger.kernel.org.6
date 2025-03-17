Return-Path: <linux-kernel+bounces-563975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83293A64B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9892188C0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113938B;
	Mon, 17 Mar 2025 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FGKzCNrQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACDD2356B5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209016; cv=none; b=LtpbHv6LMm1hyfeCXa5BaetLSaVQB0gSrOiGm+fW5zVRZXDDZpp2GJv3SKBH7YY4HcvS0i24AnNCaJt0M2a+D8QCTsD6+btRmtUnPu917naOFXS5dlefnpxNeO9tAqLDwuQFzZCecNiKfvVZdXRXKioSxsROY+9BSekIMg91Fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209016; c=relaxed/simple;
	bh=c1uFLMiBZ+ErGYuPl59ME/RexuNbYLRbJ3FMf3/VKPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jtSqXAMFMqLGGf0bNXqOQXfFnMgKTYr8jm1AXDpY3oBHh67a+rjZWkBb+EGpDMDk5scuy5dH8pDUjrq0jg7KKUkV0iS6Zg71ZLTJJDOH9eVj0T3ICHpF7sqWaZk8zvIrXUpDcwmryiTu3TVseX/nXUe92SkOytKfFHmBbkKhpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FGKzCNrQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22435603572so63988065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742209013; x=1742813813; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaxJ9O4apvIduZQubjUCXxC2zDRvsa7Ud1RLywXuOtI=;
        b=FGKzCNrQkB8Pac1L0EKaZLI+GXlRfffVjJCKxh1AT4DAs7FfteFoGNCmo1iOQ5gmkh
         YIHUDdVyGtdFl+dLPhJQLV6sGY3JC8Qb1oTPtbzSkH4jQ81ch9pNuCHq6czvEW3Jyb06
         iKsQrB6pfKL5jxPBtG/gpRwe5lbu0BVXmOEdQ+4ITZ8ZVzAsmL3PgHIDVlFi4uOb2Z2/
         YDUSdhVwJ/m1lEXAl60E+3yeDHYEjLAsV+xlpeYOdwKmM+NNu3y5V9K/sVlS+V0CoKGl
         iBHgkd0Q6xRtpXBV4k3bUnqE02CTrPlg4EdR1Oq7AKv22v5lceAGqRkBCytQ+UbEOp0e
         3YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209013; x=1742813813;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaxJ9O4apvIduZQubjUCXxC2zDRvsa7Ud1RLywXuOtI=;
        b=woT6fQtpanNRtJLoBQrsoANRioz5cJ5Ocb/F1f2j9ypHgoij1VH6Xk+qVkRPjbMVky
         OOdQ0R4L+XpOQ9o2pyMd3FYo9talRmjC5HboqR0wH8kL2boxL7z3w8vqjgvV0o+Oh/Z/
         NuyEFdfdDLdcU0MgPhT686PIYgkCYmMTpfcqdOhGNvgxuMMGjYxRgXv24IS+Fx816t5B
         Kbw7sWWYkD4307dew0ivve6q1SETMjQEMbNWU2EF++UE3zH9EGN+ZNL2Is7754hrRTST
         KSJ425XQu9AcWaETYmNfPnVQrRNkWX/0n3WXWX/GtZArZDgolK70fIhZCAEU2PbXUCg5
         l7eA==
X-Gm-Message-State: AOJu0YzQryjbbLvKkfA7cJ2Oqp+DkF0NJGm5U7EGoztaegZP865NrXkw
	UHbrLMMyZMA8qfWAZdI6lIMFGE3cQ1KZT0Py7vQm/IEEBc+l9Ge8SDPxKquW2A==
X-Gm-Gg: ASbGnctsxzLCeZWLgW0pAsJprbETiPVm8+Dd6W1IqN4BllHcmRReVpAULPW25CX1RZD
	gvqfH5UNpAfNVTVVaSqsHvQcY6Dgm86mdRynQHQyjEcApTPhGpvRQKPWJ3OUPIcXWMpi0wvYHQn
	TyHD4xWX2D7QElYdeFZNW1w6/5EMMAgUegrjqZ+L6FlRyZ7RRWZB00JlUAXubsS2yO54z7HS2Jv
	baUckvCwtaZw+P6SHjLYAOTkHHetEjhUdlkpCx7xb7je2z/nqPKXQmYE4CRi66+1ftSYx8tyAVW
	CjdocTvg3XXmZJg0oTOpnlFy5NrQ93jF4uHyNsRxTZKU
X-Google-Smtp-Source: AGHT+IGwWX3ugLqYMor7hJhI4U0m/GmiCb1NmpBvx1SDpyAx3KtIp1pR2UdqRIgdmbgjt+iPSJ1OGg==
X-Received: by 2002:a17:902:fc8e:b0:220:cb1a:da5 with SMTP id d9443c01a7336-225e0af57a4mr179574105ad.40.1742209013158;
        Mon, 17 Mar 2025 03:56:53 -0700 (PDT)
Received: from bytedance ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e109sm7278526b3a.115.2025.03.17.03.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:56:52 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:56:47 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 0/7] Defer throttle when task exits to user
Message-ID: <20250313072030.1032893-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a continuous work based on Valentin Schneider's posting here:
Subject: [RFC PATCH v3 00/10] sched/fair: Defer CFS throttle to user entry
https://lore.kernel.org/lkml/20240711130004.2157737-1-vschneid@redhat.com/

Valentin has described the problem very well in the above link. We also
have task hung problem from time to time in our environment due to cfs quota.
It is mostly visible with rwsem: when a reader is throttled, writer comes in
and has to wait, the writer also makes all subsequent readers wait,
causing problems of priority inversion or even whole system hung.

Changes I've made since Valentin's v3:
- Use enqueue_task_fair() and dequeue_task_fair() in cfs_rq's throttle
  and unthrottle path;
- Get rid of irq_work, since the task work that is supposed to throttle
  the task can figure things out and do things accordingly, so no need
  to have a irq_work to cancel a no longer needed task work;
- Several fix like taking care of task group change, sched class change
  etc. for throttled task;
- tasks_rcu fix with this task based throttle.

Tests:
- A basic test to verify functionality like limit cgroup cpu time and
  change task group, affinity etc.
- A script that tried to mimic a large cgroup setup is used to see how
  bad it is to unthrottle cfs_rqs and enqueue back large number of tasks
  in hrtime context.

  The test was done on a 2sockets/384threads AMD CPU with the following
  cgroup setup: 2 first level cgroups with quota setting, each has 100
  child cgroups and each child cgroup has 10 leaf child cgroups, with a
  total number of 2000 cgroups. In each leaf child cgroup, 10 cpu hog
  tasks are created there. Below is the durations of
  distribute_cfs_runtime() during a 1 minute window:
  @durations:
  [8K, 16K)            274 |@@@@@@@@@@@@@@@@@@@@@                               |
  [16K, 32K)           132 |@@@@@@@@@@                                          |
  [32K, 64K)             6 |                                                    |
  [64K, 128K)            0 |                                                    |
  [128K, 256K)           2 |                                                    |
  [256K, 512K)           0 |                                                    |
  [512K, 1M)           117 |@@@@@@@@@                                           |
  [1M, 2M)             665 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [2M, 4M)              10 |                                                    |
  So the biggest duration is in 2-4ms range in this hrtime context. How
  bad is this number? I think it is acceptable but maybe the setup I
  created is not complex enough?
  In older kernels where async unthrottle is not available, the largest
  time range can be about 100ms+.

Patches:
The patchset is arranged to get the basic functionality done first and
then deal with special cases. I hope this can make it easier to review.

Patch1 is preparation work;

Patch2-3 provide the main functionality.
Patch2 deals with throttle path: when a cfs_rq is to be throttled, add a
task work to each of its tasks so that when those tasks return to user, the
task work can throttle it by dequeuing the task and remember this by
adding the task to its cfs_rq's limbo list;
Patch3 deals with unthrottle path: when a cfs_rq is to be unthrottled,
enqueue back those tasks in limbo list;

Patch4-5 deal with special cases.
Patch4 deals with task migration: if a task migrates to a throttled
cfs_rq, setup throttle work for it. If otherwise a task that already has
task work added migrated to a not throttled cfs_rq, its task work will
remain: the work handler will figure things out and skip the throttle.
This also deals with setting throttle task work for tasks that switched
to fair class, changed group etc. because all these things need enqueue
the task to the target cfs_rq;
Patch5 deals with the dequeue path when task changes group, sched class
etc. Task that is throttled is dequeued in fair, but task->on_rq is
still set so when it changes task group, sched class or has affinity
setting change, core will firstly dequeue it. But since this task is
already dequeued in fair class, this patch handle this situation.

Patch6-7 are two fixes while doing test. I can also fold them in if that
is better.
Patch6 makes CONFIG_TASKS_RCU happy. Throttled tasks get scheduled in
tasks_work_run() by cond_resched() but that is a preempt schedule and
doesn't mark a task rcu quiescent state, so I add a schedule call in
throttle task work directly.
Patch7 fixed a problem where unthrottle path can cause throttle to
happen again when enqueuing task.

All the patches changelogs are written by me, so if the changelogs look
poor, it's my bad.

Comments are welcome. If you see any problems or issues with this
approach, please feel free to let me know, thanks.

Base commit: tip/sched/core, commit fd881d0a085f("rseq: Fix segfault on
registration when rseq_cs is non-zero").

Known issues:
- !CONFIG_CFS_BANDWIDTH is totally not tested yet;
- task_is_throttled_fair() could probably be replaced with
  task_is_throttled() now but I'll leave this to next version.
- cfs_rq's pelt clock is stopped on throttle while it can still have
  tasks running(like some task is still running in kernel space).
  It's also possible to keep its pelt clock running till its last task
  is throttled/dequeued, but in this way, this cfs_rq's load may be
  decreased too much since many of its tasks are throttled. For now,
  keep it simple by keeping the current behavior.

Aaron Lu (4):
  sched/fair: Take care of migrated task for task based throttle
  sched/fair: Take care of group/affinity/sched_class change for
    throttled task
  sched/fair: fix tasks_rcu with task based throttle
  sched/fair: Make sure cfs_rq has enough runtime_remaining on
    unthrottle path

Valentin Schneider (3):
  sched/fair: Add related data structure for task based throttle
  sched/fair: Handle throttle path for task based throttle
  sched/fair: Handle unthrottle path for task based throttle

 include/linux/sched.h |   4 +
 kernel/sched/core.c   |   3 +
 kernel/sched/fair.c   | 380 +++++++++++++++++++++++-------------------
 kernel/sched/sched.h  |   3 +
 4 files changed, 216 insertions(+), 174 deletions(-)

-- 
2.39.5


