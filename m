Return-Path: <linux-kernel+bounces-558896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C5A5ECD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C0C18997B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F91FC7D6;
	Thu, 13 Mar 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YVkyf/rE"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0181FC115
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850464; cv=none; b=E5Qs0e/v3RuqX78ItzVUe3QpQTaq4nI3QcI17eRY8aWGHI6cxEA2hhnzhMgdaS0SLj7C16u72OGDrPcwQ7iRBRiGe+vVs3CQmCrYIARZjXE/hLQNGwLLF14PqlGD1kanoQWAw+dIrLvSfPo144VjXc/CpXeW+bnkk1BbGQSdz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850464; c=relaxed/simple;
	bh=WIGP6c7pZI3O7KpjjWTotO+yvTTuYyAJpgqOBOyp8gY=;
	h=From:Mime-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=NEXdh8t0HHZ5H3pK3v+6+bfF4YOwrBPdfBlXXkygsvez7TPFVx6LAR6hI8F/PD7yiC3psZ3a0TgVkwx254ukqiljHZHXfiWeHFOvBn24oW3FNxPQurmx49GI1wmhvM6q7zFZpcbcA8TLKLsWM2StcfZThv28mS88gr1t3T/6n1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YVkyf/rE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso1292905a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850460; x=1742455260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mb3Bt/L4MdFutbv6VVq0j5BWvIHVvycjsyPwMxwTSVE=;
        b=YVkyf/rEIq4G+0mjtKjW6SKc75QD6VjpQQFZ4iP9FkHJa63qm3XW3RMZgGnSQSyVKO
         2dnEu+Wfaq/eme/qMKAL3wLqof1fH6L8kWxJ2o2AQkr271wIs9+gwomHKaqyTZLRQCQ1
         EQQ21bQVYqzIlIaSfBcsQL1hPzgY2vGLidcbvEg6lTg/IStFdv9UFgNVOQ4X1N2snDnF
         Y+wF3X1lKPGlVXHLRoExnaz3vMAXF9x83my0+3PLijYfYQwTFPWw6POz/VpYivXwRlI1
         abqcK4GP+oUvpsXXc7v7h34eVVxu8yvRFJEbOQrjdyrbChg9DVTkPotTe6HveV+GR8Tw
         VtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850460; x=1742455260;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb3Bt/L4MdFutbv6VVq0j5BWvIHVvycjsyPwMxwTSVE=;
        b=hSf+OOhispxaYtet75qquXRSgwEDeNkYFskfTGBcK0FK/YWjkPFP9TP8gc2HG342L+
         3ZEGLjrz0Gxpc52+6E8oYPAX1gsqINjGd5xjxu3cSop9P6RhRVkIsglUWSRlLLJFBlsu
         uuKzmZV9JjmHr+vk4kMp0v0BNKqjsmHXwcADxZQkQChxSGJGPbZOxalCD5al4KHy0UgX
         WKIv0RlUE6yHEsvpVQL3Bm0Bh1HS3/z7SHwXVJENWcNEc0jeM/B7u2TuSsDvd61HBLY+
         s+MdCEwS6c5kSgSWn8awzdibE/TL8RoLZwQIGeER1Ox59n8sJEovGLcgY2TCkGiwkvvG
         AQlA==
X-Gm-Message-State: AOJu0YweUIrjIA9v3AgO/lOWXKcczW5EJApUa8JpAuBZY5Y0jNIBnyyK
	itvcw4xR2bvuiz3jjVrRCYt7xIh/uCmOcGsDXubSAsKxrQYUfNsFdFhpvIudZ3UMtpoftuwKIcb
	2PQrTTzsGY/KIU94+s5HYHfQOGtoUDKeXQ8zM
X-Gm-Gg: ASbGncsxlwkCvMTJh9YO0lz/0qMcHpkUPir+f1Sx64BSUEKYDlWuF7FZHQdWjXUhzts
	MsTFPFZCmmKM14v2PgzUVpG03T2b8mWbXB/Xz1cYZKqwaKYB5+dbHes/uS8fCOn4D9e0F5vMvmK
	B39vzT7qZvWs7Ms2ZXvKGArAMdFaI=
X-Google-Smtp-Source: AGHT+IERlEVj3mE2Hy5QG0uYVmlj+6xc3jcRkKGk/VCX2hZvznrMEDQOpTktFKZqRLDONhEEnwt8+8tRuhlC6y2ywvc=
X-Received: by 2002:a50:cc0c:0:b0:5e7:8827:2c33 with SMTP id
 4fb4d7f45d1cf-5e788272ca4mr9539592a12.11.1741850460222; Thu, 13 Mar 2025
 00:21:00 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 02:20:59 -0500
From: Aaron Lu <ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
Date: Thu, 13 Mar 2025 02:20:59 -0500
X-Gm-Features: AQ5f1JrQjfSy-mFfh2-ULrAKsV_fUeB6HXQoUOKf9a2vBVkInMOCWuwIlG7L1h8
Message-ID: <CANCG0Gfn-BENDNqJmWC2BCxXLA8pQWrAwNibx22Dv_yUzyNV5g@mail.gmail.com>
Subject: [RFC PATCH 0/7] Defer throttle when task exits to user
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

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
  [8K, 16K)            274 |@@@@@@@@@@@@@@@@@@@@@
         |
  [16K, 32K)           132 |@@@@@@@@@@
         |
  [32K, 64K)             6 |
         |
  [64K, 128K)            0 |
         |
  [128K, 256K)           2 |
         |
  [256K, 512K)           0 |
         |
  [512K, 1M)           117 |@@@@@@@@@
         |
  [1M, 2M)             665
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [2M, 4M)              10 |
         |
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

