Return-Path: <linux-kernel+bounces-285642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3989510C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D84C1C22579
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D21AD414;
	Tue, 13 Aug 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdDyuSA+"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263E1AD40C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593463; cv=none; b=HvpCWkiRy+7oSoVgn21pTOuJr1EZMq2WtAS3Xe1v48sBtC8C0AP26RLdJHThwPnf9ufhrFx+3SG9wBMqftlY4w3FGyn+x1d7e33xtU4Alh+484oUIXqoFb9BiFeZdvAp9dSU4hQkjmC0XbWYLPmx/Kg9je159v+XPYxSIIupro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593463; c=relaxed/simple;
	bh=IrewcibzVN4ibz5vt3zbTJUrJ6DdyL73ZIB6WQdmVbA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SrLRq58kHopPgRhVpZdFu4bC3zQmYjFOE6qmhKM2/w08tr5h3+f2nEmAQe6BgLnGtDpBPM04o63jRYExRb8TfQpjfs+LawvfVvMnqFcrwbb+fvpVDxZ2jEb9MfSuiZqMacYU0QhSmzemBezKqI/dqL5LiShDolVi29WBYfuUwlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdDyuSA+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a994e332a8so4324175a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723593461; x=1724198261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRL266fqGPRaBWl+8mEzQGsgQ4/gP4SKa2m28XZp4Is=;
        b=IdDyuSA+j/Mfo9v7UXrx7+Dafkm1q2trLc4kA1tgSyTqAzuPUwnVomGfgK0fB6nI/z
         7AuF12/KZrM/7iVbeQf6+nBw+k6phGPb769KXtCy02GfUGvOQAaDlykKZL4rrW7dYptz
         YJnyAawZ+cIUQ7TNjiGjBAlBisnwsZwXxdeeHJoLwPgRtoOyyjJKP6Jf/JD+FlcfgqmU
         8p7fFhEDkxUjMRY+1myMS/CJq8+1m+p7FLFQUvFpKx4Bf1wEfgx5U8fDVZ0swyuFnUPj
         qtjop6lpZ7Uq6IS2bsW2WpYMks+PF1l2MIqWNtwho2qAnOJyezlHlkEIeVFU7hNG6kZ3
         ct4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593461; x=1724198261;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRL266fqGPRaBWl+8mEzQGsgQ4/gP4SKa2m28XZp4Is=;
        b=vktC2avLLwdhxVhjfjhMsXwNxJx/Yb56BgokvflXWGGwCho+0tXVH9B7VPoF6q0Sgi
         XeLUG73e+BLh8+uN7XUYAZPIUi4Mvamx+GYr5wSwGjsipv1WqQ3izkd+L0Bis+V1tdlH
         sennncpSDYm/iWHhdYehA0figf+DGeRZdcO9+xTbZ99F0JpCW2H6aEzYOezPuXLjln3E
         aUNjBHAvIklpu45iXUJiZG57xI8Mmp4O0nuqIPcncC8uLpHFn/2RaCPtIfeTnQsLspgp
         kFc/nPYZF64ah7ESBiL29IYgwuSTfmMDmwj/5Tl9Urhlt2SIJ5m1qM/yK7ipDFnj5LbK
         aPdA==
X-Gm-Message-State: AOJu0Yxxb3lAgc0NROod4B1llzflGAHsmYBeJHRKnyE7ns18lRdozWC+
	ZNzh51dojU4sLbG4MznkTDEEe2nK326SoH3ZFD9HucoqCrb9k+tj1Ah4TvCWzbcXVt0IMhh7Lr1
	u0HhVcctw1U41eQp4lfkM1j3hE+umIa5TG7lcx+MrK2PocJ2skBBDrqsY3Xu2s4o0hqfwq7uU4y
	wi6KJD1KiPLKNPqZv53LgEDVNdPGGD3t8JnN/hglszHYWX
X-Google-Smtp-Source: AGHT+IHurckt3UEgkqYqnVnxUH76wIIIjgOSBSXi9OIsJrinQI4+2VFozEybNH1gfU6bMFR+wgzm0FUrq+/b
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:1c1:b0:1fb:984c:5531 with SMTP id
 d9443c01a7336-201d6389c1fmr534645ad.2.1723593460383; Tue, 13 Aug 2024
 16:57:40 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:57:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813235736.1744280-1-jstultz@google.com>
Subject: [PATCH v12 0/7] Preparatory changes for Proxy Execution v12
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey All,

  I wanted to send out v12 of the preparatory patches for Proxy
Execution - an approach for a generalized form of priority
inheritance. Here again, I=E2=80=99m only submitting the early /
preparatory changes for review, in the hope that we can move
these more straightforward patches along and then iteratively
move through the more interesting patches in the Proxy Execution
series.

There have been a few changes to the preparatory patches in v12:
* Peter suggested I switch from using =E2=80=9Cselected=E2=80=9D to denote =
the
  task chosen to be scheduled, and instead use =E2=80=9Cdonor=E2=80=9D
* K Prateek Nayak and Peter both pointed out issues in the
  =E2=80=9CRemove wakeups from under mutex::wait_lock=E2=80=9D patch that n=
eeded
  some work to solve.

Thank you for all the detailed review and feedback there!

I=E2=80=99ve also continued working on the rest of the series, which you
can find here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v12-6.11-=
rc3
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v12-6.11-rc3

New changes in the full series include:
* Avoid donor migrations of SCHED_DEADLINE tasks
* Fix to avoid recently discovered race when bulk migrating the
  chain
* Propagating rename of rq_selected -> rq->donor
* Rework of ksched_football so it can be triggered repeatedly to
  run via sysfs

Issues still to address with the full series:
* K Prateek Nayak did some testing with an earlier version of
  the series and saw ~3-5% regressions in some cases. I=E2=80=99m hoping
  to look into this soon to see if we can reduce those further.
* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)
* Juri Lelli proposed an alternative approach for handling
  issues with donor migration and SCHED_DEADLINE. I need to get
  some time to read over the paper he shared and understand it
  further.
* Also at OSPM, Thomas Gleixner mentioned we might consider
  including Proxy Exec in the PREEMPT_RT patch series, however
  for this to be useful I need to take a stab at deprecating
  rt_mutexes for proxy mutexes, as everything is an rt_mutex
  with PREEMPT_RT.


Credit/Disclaimer:
=E2=80=94--------------------
As mentioned previously, this Proxy Execution series has a long
history:=20

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
 series really is due to them - while the mistakes are likely mine.

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

 kernel/futex/pi.c               |   6 +-
 kernel/locking/mutex.c          |  59 ++++++---------
 kernel/locking/mutex.h          |  27 +++++++
 kernel/locking/rtmutex.c        |  49 ++++++++----
 kernel/locking/rtmutex_api.c    |  11 ++-
 kernel/locking/rtmutex_common.h |   3 +-
 kernel/locking/rwbase_rt.c      |   8 +-
 kernel/locking/rwsem.c          |   4 +-
 kernel/locking/spinlock_rt.c    |   3 +-
 kernel/locking/ww_mutex.h       |  51 +++++++------
 kernel/sched/core.c             | 129 ++++++++++++++++++--------------
 kernel/sched/deadline.c         |  57 ++++++--------
 kernel/sched/fair.c             |  32 ++++----
 kernel/sched/rt.c               |  67 +++++++----------
 kernel/sched/sched.h            |  50 ++++++++++++-
 kernel/sched/syscalls.c         |   4 +-
 16 files changed, 328 insertions(+), 232 deletions(-)

--=20
2.46.0.76.ge559c4bf1a-goog


