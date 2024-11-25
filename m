Return-Path: <linux-kernel+bounces-421574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9549D8D08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C19F28C0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76C1BF7FC;
	Mon, 25 Nov 2024 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmDnwaFu"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6E161328
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564330; cv=none; b=X5kTtX0GLkbQsg3nB6Zc3g8s3NTxAhdsfjtS7vEzGwlXLtGxA8yhrTuA1SesAjjR76rV1l1Jo3ZLgObOO0nMePvIl5PFsCyrh1loVToC6qANLve4niDpR63jZAfC4IY8rLs4bvg2+M5hFKNb/lx/PhtAqHom29cFbfKM+npCxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564330; c=relaxed/simple;
	bh=mC9DD+LHda8LpHWhT6c53hWujdxZmrK/n8tliggTBNw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mlbKI92DUmhHogg5bksk1WModHaa14tM0uG809G/ueWTKZDfJaiwSV0D4fpMH1zsrLVHrroWFpGlUkR74AGul0BxDBj8kKhxnFNfJ5Pmu1NgZx/rcGeAT+Gek1sgVdCKWahPyCYvsY+KKeYX9FZ5wrUtzLgWm9dYBVFvzfI4Hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmDnwaFu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2123308f8c8so55177565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564327; x=1733169127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcG8b6tZ7szsisU1DiqjeBqD2RUd+104g0dUm4VY7lQ=;
        b=hmDnwaFuE85CMsf7Zk4QVUu+xTXIB6C9yel6gsnZmXaq1zgjqpyqXTt2ciyyuyqvxi
         5rI500/XszOq1DD2YVbbyKKSBJxxzkvZjfM4wihkvCficknn8kOgA09qIS+pZrrckBXM
         nAgHULN0WBbSH1gQ1yTwG42HJD6ADIOpwcc5AjuFZ2U92VjPipoBeiaA/5cOzLaYTfns
         FoQtgjA5qcVH6msVu/JqD0DhdP/fIQsQZzhwzFR7V1gy349eY5AODrZjYUyoOtd2BH6I
         KIHHqvInmlMiOh7uibnCkBRNrbOq21WAMnSQCXVmUpHCi5t/f/lBi3LT6Mc3eFiD5rPE
         6Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564327; x=1733169127;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcG8b6tZ7szsisU1DiqjeBqD2RUd+104g0dUm4VY7lQ=;
        b=QzCeqDliz9+7tBzrC2dmxuR+ESTbEJJbdYbYYlvB6W706kAV+95NZtzIk6Me0y4Wqb
         qcYzOm6NkI0eaEwxMDhIu1wAPQPsYkOB9kxj1I2iPr8NdqPLF8sZNYyVt+1dBMsqpXw8
         HjpC82EgA1xOwUbcohlNlqWIxdQwdBjXXH/nXUxHtdubdsLPPjyj/rF/vDH6NZ+MF7gU
         hUqrn88dr3apizOSfU/3kOhq740aJ1WL2oMO+RvttgUR+zX9OLFJMx3nUP7JR0fCQ20I
         IIh3pP+gh1c/+WQSgLDC8SUBhNS7pzBDM2XJ1R3idkIcHGDdfJxWFIFiUSu5SDJCo8wa
         KKDA==
X-Gm-Message-State: AOJu0YzLIsGn7JZQkxsSUrJ22JFXVvhm6Zgys1HyJluQiMjFgKktojcH
	VTMWKW2y1fCIAj7/uPR62AwfJ7P67FFkv9cEN9FttMZJGXIR09obOGvezRIteM7/sG/F8EoSLOV
	V5yIAbmw64dMBz+nlTKKTEqvcBnpk4fv2B0EDMcT16LHVxsWbtKU51u/MYJgQCNsKF+I6OCS9c2
	HLbRGApmMRh/1KRj4Ig1YELElM5Yg5Oq+c77dRlqBxGiYr
X-Google-Smtp-Source: AGHT+IEiDkwsbcGzOrXjeFR5JthTkfcUt68HZiTGWF6fvCOA4nSRoeAi2B6j4EEZdlqOBTGeM9AbOaxJA4P4
X-Received: from plgq1.prod.google.com ([2002:a17:902:eb81:b0:211:fb3b:763b])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dace:b0:211:18bc:e74b
 with SMTP id d9443c01a7336-2129f22090amr236844875ad.1.1732564326983; Mon, 25
 Nov 2024 11:52:06 -0800 (PST)
Date: Mon, 25 Nov 2024 11:51:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-1-jstultz@google.com>
Subject: [RFC][PATCH v14 0/7] Single CPU Proxy Execution (v14)
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

After sending out the last revision, I got some feedback that
pointed out I hadn=E2=80=99t done much testing with the now upstream
enabled PREEMPT_RT option, resulting in a few build issues. So I
wanted to send out the next iteration Proxy Execution - an
approach for a generalized form of priority inheritance.=20

In this series, I=E2=80=99m only submitting the logic to support Proxy
Execution as both a build and runtime option, the mutex
blocked_on rework, some small fixes for assumptions that proxy
changes, and the initial logic to run lock owners in place of
the waiting task on the same cpu.

With v14 of this set, most of the changes are just build fixups
related to PREEMPT_RT. With PREEMPT_RT the abstraction around
mutexes means accessing the mutex owner runs into some trouble
with the rt_mutex as the underlying structure changes, so I need
to do some further work abstracting how I access that to get it
working. So for now, I=E2=80=99ve just made SCHED_PROXY_EXEC option
exclusive to PREEMPT_RT.

I=E2=80=99ve also continued working on the rest of the series, which you
can find here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v14-6.13-=
rc1/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v14-6.13-rc1

New changes in the full series include:
* Rework of sleeping_owner handling so that we properly deal
  with delayed-dequeued (sched_delayed) tasks (also removes now
  unused proxy_deactivate() logic)
* Improving edge cases in ttwu where we wouldn=E2=80=99t set the task
  as BO_RUNNABLE
* Making sure we call block_task() last in proxy_enqueue_on_owner
  and not touch it again to avoid races where it might be
  activated on another cpu
* Make sure we always activate blocked_entities when we exit
  from ttwu
* Fix to enqueue the last task in the chain (p) on the blocked
  owner instead of donor, so that we preserve the chain
  structure, so mid-chain wakeups propagate properly

Issues still to address with the full series:
* While I think I=E2=80=99ve now properly handled delayed dequeued tasks,
  I=E2=80=99d still appreciate any input on ways of better generalizing
  these multiple approaches to having un-runnable blocked tasks
  remaining on the runqueue.
* Even with some of the fixes in this version (and again, for
  clarity not with this same-rq proxying series I=E2=80=99m sending out
  here), I still have to include some workarounds to avoid hitting
  some rare cases of what seem to be lost wakeups, where a task
  was marked as BO_WAKING, but then ttwu never managed to
  transition it to BO_RUNNABLE. The workarounds handle doing the
  return migration from find_proxy_task() but I still feel that
  those fixups shouldn=E2=80=99t be necessary, so I suspect the ttwu
  logic has a race somewhere I=E2=80=99m missing.
* K Prateek Nayak did some testing about a year ago with an
  earlier version of the series and saw ~3-5% regressions in
  some cases. I=E2=80=99m hoping to look into this soon to see if we
  can reduce those further.
* The chain migration functionality needs further iterations
  and better validation to ensure it truly maintains the RT/DL
  load balancing invariants (despite this being broken in
  vanilla upstream with RT_PUSH_IPI currently)

I=E2=80=99d really appreciate any feedback or review thoughts on this
series! I=E2=80=99m trying to keep the chunks small, reviewable and
iteratively testable, but if you have any suggestions on how to
improve the series, I=E2=80=99m all ears.

Credit/Disclaimer:
=E2=80=94--------------------
As mentioned previously, this Proxy Execution series has a long
history:=20

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

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

John Stultz (4):
  sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable
  sched: Fix runtime accounting w/ split exec & sched contexts
  sched: Fix psi_dequeue for Proxy Execution
  sched: Add an initial sketch of the find_proxy_task() function

Peter Zijlstra (2):
  locking/mutex: Rework task_struct::blocked_on
  sched: Start blocked_on chain processing in find_proxy_task()

Valentin Schneider (1):
  sched: Fix proxy/current (push,pull)ability

 .../admin-guide/kernel-parameters.txt         |   5 +
 include/linux/sched.h                         |  79 ++++-
 init/Kconfig                                  |   9 +
 init/init_task.c                              |   1 +
 kernel/fork.c                                 |   4 +-
 kernel/locking/mutex-debug.c                  |   9 +-
 kernel/locking/mutex.c                        |  40 ++-
 kernel/locking/mutex.h                        |   3 +-
 kernel/locking/ww_mutex.h                     |  24 +-
 kernel/sched/core.c                           | 300 +++++++++++++++++-
 kernel/sched/fair.c                           |  31 +-
 kernel/sched/rt.c                             |  15 +-
 kernel/sched/sched.h                          |  22 +-
 kernel/sched/stats.h                          |   6 +-
 14 files changed, 511 insertions(+), 37 deletions(-)

--=20
2.47.0.371.ga323438b13-goog


