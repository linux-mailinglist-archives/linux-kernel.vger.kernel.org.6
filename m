Return-Path: <linux-kernel+bounces-246632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D35D92C490
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE29C1F2332B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57E144313;
	Tue,  9 Jul 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV4tjqpf"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D21B86EA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557147; cv=none; b=S54z3WMvqQmJ+Q6sfPuuhWbVwF/+ueyK7Tjqw4WHeic/sHK3Lj8aMdmI/ljlA8sPJZm3fFo/QS5huSes/xTn89N487Q9II7r13BjpsE63idhOdnQMf7N8UPWJakGysEcbJkxLXYLhs8/fHrexJacFXPQ5z21NJk3fokLHQRxkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557147; c=relaxed/simple;
	bh=GJaTnVy1D/TTDlipo2mvQZn8n2kNZN+ywbRhh1IssHU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DnD2qHPujgc1UlCgr8us4pn0Wbsn/HSP3nHWa24y7Pxj8zvJ5AKfW6+zbXEEd7BAMV6egR6O6fwo4cK9qJ6Vyjj8z19XlsZuZuyKPnHKUKLiJKQYyGTH2gut9d2uHnZnZgOPzj3UwrkqYUgPs2KkguaP4+i01pB8JkF7p2FQoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kV4tjqpf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-76dcb7bb5efso3114160a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557144; x=1721161944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvUwNAdMeboM2T4pcbw5cmOYrJFYUtBvG6sxdLC2OgY=;
        b=kV4tjqpfgQhxMcKm26qjUzytI4b18Vb1L9fKQXxuiDDWsMamEqPkTCfmKG+Naag7OS
         ZoYIKo32LUEFhkrdLgNe0bnqRp6S3yrXeMvJvjwrHSZp9M3dDE+vDBJvZ3yk01xsRw7N
         WyO7TSHivWC+8sVdp2tMCNSuzz4uTyuOxqGHitg2trO9K0PLv8J36ZcjTA+d8H8b2/xs
         7WMJ/2Ej27d7bxFO3J3FzRMHN5euQBz+YCc4eGJLWs+yIapTqj1ZoNOg+0JOe0zW6Toa
         6HbB1Mplf8u2uwGVhudEL2L/QNXO/Z8mN5KAJ3w9TGVaIxcPPNbHORlrCDkk2yAnxc6j
         u+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557144; x=1721161944;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvUwNAdMeboM2T4pcbw5cmOYrJFYUtBvG6sxdLC2OgY=;
        b=qAFr10vnDhwH23AW6vW26uEJZCWH/+/ns75XyaGufcr3Oj4b5EPSyXIBFs72p+OSh2
         lvsIjljFA1ytEs6S4MEi0j2NvsUg15F1kFQUF0PJhqsHV2LY9QbGdlfmKiThQUzVctf7
         VrMWBsd53ardJGPmcrtC2orRT1UHHbTrI8pZd+Z5gXvYfJfjsHkwPAHW3T9s+qrGXC4D
         BZI1dkHkHlbDybsuZwt9hIZD5kd0BJ/oNsHmS8VdSvQyLj662dox9rY7+FvtYT0EvQod
         39SAIUOIcVvuA4oH6OzC00zLB3rd5PJbQVQD7WuuroavR1nWLHZFpmaC1GcMU6l9V1o/
         7egA==
X-Gm-Message-State: AOJu0YwZuGdVT+aHGdX9mJbs4obPo0mSJknCW//I/J146taXflZmsm+n
	yp+JUGUOhLUrRoc2/7/kP1tQEzkBs5zqll4ZwE/XEZydEAvooHcc625HBC+FxHsstPW8nM2lYnz
	8XKrrAExv/j+jsGPhEMSJ3oEogOg+DsiyMYGbRWiDs9qnrPIJM1NbFjXlRqs9pR8h/CH3ioo4qi
	smO5OldVpO9UrRslTu1DhnoyM8bTH3qa9KG7EKcLHoVBlI
X-Google-Smtp-Source: AGHT+IGbPz5x/4UTPe9AtnJIp1gs4PayUkG94Gyy8eQo/ie+5+NM8NCBcPXqyuzipdzyp7k/oO70/MoLHP1C
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:8c3:0:b0:718:d99f:1871 with SMTP id
 41be03b00d2f7-77dbff02e63mr6907a12.12.1720557143443; Tue, 09 Jul 2024
 13:32:23 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-1-jstultz@google.com>
Subject: [PATCH v11 0/7] Preparatory changes for Proxy Execution v11
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey All,

I wanted to send out v11 of the preparatory patches for Proxy
Execution - an approach for a generalized form of priority
inheritance. Here again, I=E2=80=99m only submitting the early /
preparatory changes for review, in the hope that we can move
these more straightforward patches along and then iteratively
move through the more interesting patches in the Proxy Execution
series. That said, I=E2=80=99ve not gotten a ton of feedback with this
approach, so I=E2=80=99m open to other suggestions.

There have been some changes to the preparatory patches in v11:
* Qais Yousef suggested a few other spots where the
  move_queued_task_locked() helper could be used.
* Simplified the task_is_pushable() helper to return a bool as
  suggested by Metin Kaya and others. It will later be a
  tri-state return, but that can wait for later in the series
  when it is actually used.
* A few spots of re-arranging logic to reduce indentation and
  simplify things, suggested by Qais and Metin
* Metin pointed out some spots in the split scheduler and
  execution contexts patch where variables could be more clearly
  named.

Many thanks to Metin and Qais for their detailed feedback here!

I=E2=80=99ve also continued working on the rest of the series, which you
can find here:
 https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v11-6.10-r=
c7
 https://github.com/johnstultz-work/linux-dev.git proxy-exec-v11-6.10-rc7

New changes in the full series include:
* Got rid of recursion in activate_blocked_waiter logic
* Added more detail to new traceevents as well as additional
  traceevents for validating behavior
* Fixes for edge case where wake_cpu used for return migration
  ended up outside the affinity mask
* Fix for case where we weren=E2=80=99t preserving need_resched when
  find_proxy_task() returns the idle task
* Lots of small detail cleanups suggested by Metin

Issues still to address with the full series:
* K Prateek Nayak did some testing with an earlier version of
  the series and saw ~3-5% regressions in some cases. I=E2=80=99m hoping
  to look into this soon to see if we can reduce those further.
* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)
* At OSPM, Juri Lelli and the (very very sadly) late Daniel
  Bristot de Oliveira raised the point that Proxy Exec may not
  actually be generalizable for SCHED_DEADLINE tasks, as one
  cannot always correctly donate the resources of the waiter to
  an owner on a different cpu. If one was to reverse the
  proxy-migration direction, migrating the owner to the waiter
  cpu, this would preserve the SCHED_DEADLINE bandwidth
  calculations, but would break down if the owner's cpu affinity
  disallowed it. To my understanding this constraint seems to
  make most forms of priority inheritance infeasible with
  SCHED_DEADLINE, but I=E2=80=99ll have to leave that to the
  folks/academics who know it well. After talking with Juri, my
  current plan is just to special case find_proxy_task() to not
  proxy with SCHED_DEADLINE (falling back to the current behavior
  where we deactivate the waiting task). But SCHED_NORMAL waiter
  tasks would still be able to benefit from Proxy Exec.
* Also at OSPM, Thomas Gleixner mentioned we might consider
  including Proxy Exec in the PREEMPT_RT patch series, however
  for this to be useful I need to take a stab at deprecating
  rt_mutexes for proxy mutexes, as everything is an rt_mutex
  with PREEMPT_RT.


Credit/Disclaimer:
--------------------
As mentioned previously, this Proxy Execution series has a long
history:=20

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.


As always, feedback and review would be greatly appreciated!

Thanks so much!
-john

[1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com

Connor O'Brien (2):
  sched: Add move_queued_task_locked helper
  sched: Consolidate pick_*_task to task_is_pushable helper

John Stultz (1):
  sched: Split out __schedule() deactivate task logic into a helper

Juri Lelli (2):
  locking/mutex: Make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (2):
  locking/mutex: Remove wakeups from under mutex::wait_lock
  sched: Split scheduler and execution contexts

 kernel/locking/mutex.c       |  60 +++++++---------
 kernel/locking/mutex.h       |  27 ++++++++
 kernel/locking/rtmutex.c     |  30 +++++---
 kernel/locking/rwbase_rt.c   |   8 ++-
 kernel/locking/rwsem.c       |   4 +-
 kernel/locking/spinlock_rt.c |   3 +-
 kernel/locking/ww_mutex.h    |  49 +++++++------
 kernel/sched/core.c          | 130 ++++++++++++++++++++---------------
 kernel/sched/deadline.c      |  57 +++++++--------
 kernel/sched/fair.c          |  32 ++++-----
 kernel/sched/rt.c            |  67 ++++++++----------
 kernel/sched/sched.h         |  48 ++++++++++++-
 12 files changed, 295 insertions(+), 220 deletions(-)

--=20
2.45.2.993.g49e7a77208-goog


