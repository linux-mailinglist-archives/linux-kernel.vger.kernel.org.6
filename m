Return-Path: <linux-kernel+bounces-323930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C097456E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D930CB21F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818E1AB539;
	Tue, 10 Sep 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPppjqnW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3617A924
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006381; cv=none; b=ep7z81hhswndXI1zKsqi5fhC8yopShaBdMpRXSw/w/60/LHEEo+MpiIEO97MEqRzxXQ9PPQm3J67/vjW/AWGthVu2TqRV/y0tyopu7vUJSnzlEgVJgpbHqOL+bLrQP2J7i4NKXIH57Dw25IOd89RVO6SzGdLSkl9gwVW1v7Iv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006381; c=relaxed/simple;
	bh=Wn3qeNGWCEUYSxzodKUtMjqlsL1YYYBHp/zLBdF0fnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QfCtW4UL0YkEgJZkjIv2ofmxP3XsdVQMf41KjKBGjaezpU7859I2GbKnmjQtYx+ygeP5tKEdCZBtgoYim1/oh93FGcU+CnVd/p1I7iSJ6NYhdNFoXe6rjFlUArKHeWEIdlLwjLqfOYxoUmM/kGlIfIGPJdD0Ws9d9sb7QCITXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPppjqnW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ab008280aso2596827276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726006379; x=1726611179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWGE5ZuTE2Z+bTUWfKlPHzg0Xpebck+8K+Ms7FhXv8s=;
        b=HPppjqnW2cfwhvlT78vU9rTdjFaCKTD0cYDLALZNqLFiJhaysSBgKxCn0sB3xVftzd
         L6WvgCA02IrRb65NCC4xtAX5S7r1euiyO7cdfM+S3lOEpGhdtQS6IvEuSj692keVVB8M
         iSzqPZGwIy1QYHUv4stAD1Apa/9Dy+lRe4Lhzfwu849tTK6eVNfRWlOpuVTMUAXrwzfT
         T92tse6dLAH99PUE/ICUgKz7bbMYfGkyqKXGf0UdSHVPwBb80syelZqwoTfnemv2JAev
         qOif4Tef1SJzFFxUGI/0tbNOpGojo/ll2KXOr8cl22mE0fHewL09y9COY8qTGzk7K5o3
         qaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006379; x=1726611179;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWGE5ZuTE2Z+bTUWfKlPHzg0Xpebck+8K+Ms7FhXv8s=;
        b=MOPtjEQE4M6K8dEm1t2dVRk87Ex9PagMUpmc3yXe/k2uHXTkIpBXedw7o0E5P2bMiu
         JsvmZaMfuloAdPCwi+L3GZlJWUKFQJSgizmFgETZPKQpCBB2Ep4kVol//zW5Dlo5Vu5Q
         n0KbjUh/swY2IYZZmzwsAKy9TA1D10NkW2f3W7m8UzJUcnGG9E8jLlxiq8UziFy+gbSQ
         0NA4iAlLcxR829hiJJEBSwZYo3BUGLYaakBo++7/18I1PmdJK0zAtYcQfeQJozeC20G8
         AfGE/55VjR13TbZizgBUvyMAD+ddA9gcKtSHcIHBFckoHz+mg+7GjatksXbE6v5F/cQY
         SHug==
X-Gm-Message-State: AOJu0YwgkWM9nC8uqgSTXGvCpDz4rijdeGhQy1Cl0ks3CtQkJ+f9Lw+D
	O0EabyXmlpL6fsZHG+DU7jForF8ZjXzWeQLRZwDEnZo9wUlPn+RFbqo0XeiWppwWAhHP6LAPBgn
	tjnxDTRshgjZdjZhKBLjKyEvr0//ZULwTOL/HW3u5eIBimcq0tb4D4V4W4G9D6bd6BgK9HyHwhK
	VaQNalNVqfdLbJc59sW82OMY+6tob/YWshcjp8BoZZzHCS
X-Google-Smtp-Source: AGHT+IFi3x7J6DeAT9lbuAHh+42DUmxrTFRSBwfJ/dys3jla9yle8Vx6puUOIgmDKViFR1OltwMWO9cpoWTt
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:e08c:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e1d8c5319c3mr1255276.8.1726006378201; Tue, 10 Sep 2024 15:12:58
 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:12:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910221235.2132138-1-jstultz@google.com>
Subject: [RESEND x2][PATCH v12 0/7] Preparatory changes for Proxy Execution v12
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

  I wanted to re-send (again) v12 of the preparatory patches for
Proxy Execution - an approach for a generalized form of priority
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
rc5
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v12-6.11-rc5

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
2.46.0.598.g6f2099f65c-goog


