Return-Path: <linux-kernel+bounces-397552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAE9BDD56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306C328445C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB218FDB2;
	Wed,  6 Nov 2024 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfCxwcje"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05618E368
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861823; cv=none; b=lbitbh228YEJWWqmQYufHb0tZLvfWHhI/ytQguZn3dTY/c1y3U30bQ4WKOtXRuVyY7s2hGTlOkAXXiOeqaRqwGBVtXTCwdb46G8SJTebnmuQ6An8yZVhEcfd3xOlITRzo1k8Fk7JLovYDgDicVV8ZAuJ9KVG9KAEgwgkxb8QThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861823; c=relaxed/simple;
	bh=K1LUohyPz/0WNupAZ5KwUtcKQEeNH80IRs8UoxG0G/4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bFvv4BhT0ktnf9qc17eu2tJueloxcF4lnNv35vNEurXzScRjYOVpKQUDI29K8V0iI0ME9mgXbQ3NK3frmAOyJemVRKsQWNGYG1AXkMqP7Z6L+6VUBbMxORConvhKboSUzfKNMv177eKMnY9PYYK/u0OHMC/9uphWO5dnWcOWcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfCxwcje; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2dcea0f03so7280057a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730861820; x=1731466620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTde3W0Y1lpP76+zZsp6bWPjd4V0tnqNBZOVtz5tsM8=;
        b=gfCxwcje3L3L9nqhB+i4xqr9HWbSPb5yJnq9F5G6UUqZbPIJw0ClYXF6M9l39ygl6G
         Q9q2IR9I77E+nhdkcXdRakkeaYsYNwmj1jHJua9DBtFp2EcTbnbLbYS9+gRYCI2xlMgK
         5mLPl8g914a5hDEDDiesKj6c4rmY3G760oXG/dLqI99UQtID1C/8eJGU/Zs31rJOEUog
         T2xrIHYq3f3UxC7wEmAcIpCfmoxEQ8rZFgRKv+bWIl9IUHE61xRZaHngbuvevzU5J0HZ
         iqJ2xp3XsiVTGqYKHHX+W3+ViMHwbc8SqH0y7PfLMcSegD6xaLnnm00EQmcenWwYBOq7
         58KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861820; x=1731466620;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTde3W0Y1lpP76+zZsp6bWPjd4V0tnqNBZOVtz5tsM8=;
        b=xRl7yaq1NcIJ3NCMRubOleazWE9NcTy8mHlz6WbDiMkAyr/V+Zmqul5VtoDSK7lh0p
         ATFpEfwgR0p4BaiuP1BZy/wpn5bT9pxYLFVFQeLBDa2qYF9oitkNx6NK94A8M9uRW/ML
         nWMom9yIfma972DhRZOWa8IRm/WlE9NwIeo4e08A/G0UCDWYVKLYL9i+oV1Oe/+uwgKt
         gAJpxUrMEFvNascI14EGQkLlcyfPC8UmkzV0kYMcAPuPpPFw3fknwCVAzq5fa6gI7jI/
         0ak+w+sRIKzD71BsNfzxmZw68eT2ydSTxWfp0+7G58JhzLfrYVzdqsubZDuE9FNbjiA7
         Ngvg==
X-Gm-Message-State: AOJu0YwRPD75UcuSAkKk8tarY/LiDgF3RugZ/FQ+soFMA0+4v6U5haiO
	slwPAqcpSmL6Et7kBnuU24guKHAS2ZuH90DLNE480DOJjaBZSL6qXYou+Ag/NOH4YKSyAp6YncK
	etBsTbrLvke4eTSZlwYRk3Q35mOv65mAdPL7BN6YwRttYFbqA9fjQZ/ugF9nXIpnTCfSRIB5nuu
	yw2pTeRccLuRq8QRtevnbAhbxXGdBvyKDDrCk68E3eTnq7
X-Google-Smtp-Source: AGHT+IE54tJfKtjhJXv7X6Qzti7ELjQu+oOr+pdgK4CNuAU3HXPajjrADudNU2EtHRBXOnrjrFcSU7U+yRtP
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:4ac8:b0:2e7:867f:bd45 with SMTP id
 98e67ed59e1d1-2e8f0d5d8d2mr75887a91.0.1730861820032; Tue, 05 Nov 2024
 18:57:00 -0800 (PST)
Date: Tue,  5 Nov 2024 18:56:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106025656.2326794-1-jstultz@google.com>
Subject: [RFC][PATCH v13 0/7] Single CPU Proxy Execution (v13)
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

  Since the earlier proxy-execution preparation patches have
been queued in tip/sched/core, I wanted to send out the next
chunk of Proxy Execution - an approach for a generalized form of
priority inheritance.=20

In this series, I=E2=80=99m only submitting the logic to support Proxy
Execution as both a build and runtime option, the mutex
blocked_on rework,  some small fixes for assumptions that proxy
changes, and the initial logic to run lock owners in place of
the waiting task on the same cpu.

With v13 of this series, there have been quite a number of
changes:
* Mostly dealing with collisions from changes that landed in
  6.12-rc1
* The most basic of handling of delayed dequeued tasks (just
  deactivate for now)
* Renaming =E2=80=9Cnext=E2=80=9D as =E2=80=9Cdonor=E2=80=9D to clarify thi=
ngs in proxy related
  functions
* Lots of cleanups

I=E2=80=99ve also continued working on the rest of the series, which
you can find here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v13-6.12-=
rc6
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v13-6.12-rc6

New changes in the full series include:
* After talking with Juri at LPC, he suggested for now that we
  re-add donor migrations of SCHED_DEADLINE tasks, so I=E2=80=99ve
  dropped the logic that previously disabled this.
* Workaround handling for =E2=80=9Clost wakeups=E2=80=9D issue (see below)

Issues still to address with the full series:
* The new delayed dequeuing logic added in 6.12-rc1 really
  conceptually collides with proxy-execution: As we now have
  multiple tasks that aren=E2=80=99t runnable for different reasons
  (one may be sleeping, another may be blocked on a mutex) that
  are left on the RQ and the rules for how we handle these
  un-runnable but enqueued tasks are different for each case.
  Right now my workaround is just stop proxying if we hit a
  sched_delayed task, but I=E2=80=99d like to have a better solution.
  My plan is to treat it similar to sleeping tasks, and do the
  same deactivated-owner-queuing (queuing the waiters on the
  sched_delayed task). The problem is when a sched_delayed task
  gets a wakeup, we won=E2=80=99t hit the logic to do the
  blocked-waiters activation, so I=E2=80=99ll need to change that.
  Just getting it working won=E2=80=99t address the conceptual
  collision, so I=E2=80=99d love any thoughts or feedback on how to
  generalize these two new forms of unrunnable-on-the-runqueue
  states.

* In testing with the full series (again, for clarity not with
  this same-rq proxying series I=E2=80=99m sending out), I hit some
  rare cases of what seem to be lost wakeups, where a task was
  marked as BO_WAKING, but then ttwu never managed to transition
  it to BO_RUNNABLE. This can cause us to get stuck either in the
  pick-again loop, or in a idle resched loop. I=E2=80=99ve added handlers
  to detect this and to safely do the BO_WAKING -> BO_RUNNABLE
  transition along with return migration if needed to avoid this
  issue, but this really is pasting over the underlying issue.
  This has been difficult to diagnose as by the time the issue
  is noticed, the wakeup may have been long in the past and the
  tracebuffer overwritten.

* K Prateek Nayak did some testing with an earlier version of the
  series and saw ~3-5% regressions in some cases. I=E2=80=99m hoping to
  look into this soon to see if we can reduce those further.

* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)

I=E2=80=99d really appreciate any feedback or review thoughts on this
series. I=E2=80=99m trying to keep the chunks small, reviewable and
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
 init/Kconfig                                  |   7 +
 init/init_task.c                              |   1 +
 kernel/fork.c                                 |   4 +-
 kernel/locking/mutex-debug.c                  |   9 +-
 kernel/locking/mutex.c                        |  40 ++-
 kernel/locking/ww_mutex.h                     |  24 +-
 kernel/sched/core.c                           | 300 +++++++++++++++++-
 kernel/sched/fair.c                           |  31 +-
 kernel/sched/rt.c                             |  15 +-
 kernel/sched/sched.h                          |  22 +-
 kernel/sched/stats.h                          |   6 +-
 13 files changed, 507 insertions(+), 36 deletions(-)

--=20
2.47.0.199.ga7371fff76-goog


