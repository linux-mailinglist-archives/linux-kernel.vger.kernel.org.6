Return-Path: <linux-kernel+bounces-558521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E9A5E709
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAC117AF32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512071EF38B;
	Wed, 12 Mar 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6vtqQFe"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5491D5CD4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817528; cv=none; b=paEuwKSPKNhFuB0DD+GjNcDkTzUH4NfL0AUly/IMd4q4OLgm6Q25ScK39CpRPKbhS/4QPwr00KfGsKs8FAxEXKZHRKBHHC5ipe38j27tsFDbL7KUX8nQgaUHda0E0btuCqXKRXySpIkOB5ru+C3eQGOwNhjCXoLp8Ogtdymo5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817528; c=relaxed/simple;
	bh=mVOwv4gk/Ru3YsGqRyE9Cej02OxzZqGYpijbhmgD/ys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZpC2gXO7DOSMds1ocTOeSVHOpSdyciLxIbpLoJTZtvmF2PQeLkk8s0c++Rx5CteaGAHODepLyYlG3Qh0tKeQ+GA7enCiGHOcx/fENWcR+zCcMIHj0eSoCPGiHuMsvVjnhsFx3MArzPpv+Zw3BSZC1pWGqAs0rli2O3xR282Lej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6vtqQFe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso819386a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741817523; x=1742422323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMoRGAIyglXSYt+x2l3OhtgR+IyIgqGUSX3XXO59reE=;
        b=D6vtqQFekKz5XJnpRlUTjL3M8iZZUGHSYuCVBfsrxEQJxjak132pBMTVnD/a6Ko3S1
         VVPAWyJZKytKOSjlFIxLKawHcaLycY8VXdBe5Bk+fym9S4MgpF+dgzrRW0cymtUe2mk8
         PtUI9ofP+QSoVauDVH9QXnnNKC3Du9Km3Wzo3KqpTylCD6J0b5laBpzmWUM4b2pnE43F
         Sn13HbzYuUmC426D2kdhzGnb50g0Wc6uJK8RNdexHTpYBAwtAszdnRfpj7PFbecf5SKy
         RBmBGxvAQJmPu9nDh78Pmpni7IZzKbIYfcbBN/KHVTHwzlEEatM3zJ2ToXeWDMcimohE
         n5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817523; x=1742422323;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMoRGAIyglXSYt+x2l3OhtgR+IyIgqGUSX3XXO59reE=;
        b=cnrBKtNXDKREQKMORSbNEAw+Pcmq2FVUry43Pjs0Wqnm7RSCpHW+pbYyACas8lpwqW
         17M6TiEBDwJF2Ma4kXEjrGloFLA9zo6z5d7ag0UHlsMxeBBXRKYqRIbqwLvDpZVIy5SF
         oZgnOxYsWWJUpOhI7Vkas/scnJcwuOqb6+NGMfoqwx0oRKnsDmHOM6A7gH2C1yRwVsei
         H9P8afVrSA0k2h2XPQxr5mVxKJcXzPWiZeX+c4WHtMMjF52m1fBNoAGLofHvnz+iYLYD
         Z6kitC55JGqhuzYmw+am9JBAA0AW46XMoO+6fmIb5PqERq0ZC9Bd3dFA/swaKwum8Te/
         nSlA==
X-Gm-Message-State: AOJu0Yy3hbilNc/qZ1rWHawVzD9frv9zF4yAHpCnzgFgNNQ7dvHh8aae
	xP2j25/iDida89CAUX96WGgJSxFKWdFmAYrwIxhwvx6wkYYXGvhoq1fc8U1G5xMxhOvFxBnY2b/
	GylaZesrs/9PsAJxtm2IJpupd9iCz3xN9RwO1CAycGAXEgZMvQnnfKuW/UWwUlxxzoAFdTyudrJ
	BNymH8Ej4/w+KvYyl5HgwBPOIg4suSZQSBUpzUHg8vEWKA
X-Google-Smtp-Source: AGHT+IGZEAjKWIeqoA4bPCMv6Uh/JpftFF0WCXb8YLMY+CVgHWjyexvgqH4pOG+53Mn9xkIX28U37WKGGfdy
X-Received: from pjur13.prod.google.com ([2002:a17:90a:d40d:b0:2ff:5752:a78f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5186:b0:2ff:58e1:2bb1
 with SMTP id 98e67ed59e1d1-2ff7cf317efmr29496823a91.32.1741817523614; Wed, 12
 Mar 2025 15:12:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312221147.1865364-1-jstultz@google.com>
Subject: [RFC PATCH v15 0/7] Single RunQueue Proxy Execution (v15)
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey All,

After sending out the previous version of this series and
getting some great feedback from Peter, I was pulled into a few
other directions for a bit. But I=E2=80=99ve been able to get back to
the proxy work the last few weeks and wanted to send this
iteration out in preparation for discussions at OSPM next week.

So here is v15 of the Proxy Execution series, a generalized form
of priority inheritance.

As I=E2=80=99m trying to submit this work in smallish digestible pieces,
in this series, I=E2=80=99m only submitting for review the logic that
allows us to do the proxying if the lock owner is on the same
runqueue as the blocked waiter. Introducing the
CONFIG_SCHED_PROXY_EXEC option and boot-argument, reworking the
task_struct::blocked_on pointer and wrapper functions, the
initial sketch of the find_proxy_task() logic, some fixes for
using split contexts, and finally same-runqueue proxying.

With v15, I=E2=80=99ve tried to address some of Peter=E2=80=99s feedback,
splitting apart some patches so they are easier to review, and
breaking out some functionality that is not yet needed for
single-runqueue proxying, so that it can be introduced later,
closer to where it is necessary.

I=E2=80=99ve also continued working on the rest of the series, which
you can find here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v15-6.14-=
rc6/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v15-6.14-rc6

New changes in the full series include:
* Having CONFIG_SCHED_PROXY_EXEC depend on EXPERT for now, as
  its use has pretty narrow value until we get to multi-runqueue
  proxying.
* Improved naming consistency and using the guard macro where
  appropriate
* Moving the blocked_on_state logic to later in the series
* Improved comments
* Build fixes for !CONFIG_SMP
* Moving the zap_balance_callback() logic to later in the series
* Fixes for when sched_proxy_exec() is disabled

Issues still to address with the full series:
* Peter suggested an idea that instead of when tasks become
  unblocked, using (blocked_on_state =3D=3D BO_WAKING) as a guard
  against running proxy-migrated tasks on cpu=E2=80=99s they are not
  affined to, we could dequeue tasks first and then wake them.
  This does look to be cleaner in many ways, but the locking
  rework is significant and I=E2=80=99ve not worked out all the kinks
  with it yet.
* In the full series with proxy migration (and again, for
  clarity not with this same-rq proxying series I=E2=80=99m sending out
  here), I still am using some workarounds to avoid hitting some
  rare cases of what seem to be lost wakeups, where a task was
  marked as BO_WAKING, and the mutex it is blocked on has no
  owner, but the wakeup on the waiter never managed to
  transition it to BO_RUNNABLE. The workarounds handle doing the
  return migration from within find_proxy_task() but I still
  feel that those fixups shouldn=E2=80=99t be necessary, so I suspect
  the mutex unlock or ttwu logic has a race somewhere I=E2=80=99m
  missing.
* One new issue I found with the workarounds I mentioned in the
  previous bullet, is that they can cause warnings during
  cpuhotplug if we try to do manual return-migration to
  task->wake_cpu and that cpu is offline.
* K Prateek Nayak did some testing about a bit over a year ago
  with an earlier version of the series and saw ~3-5% regressions
  in some cases. I=E2=80=99m hoping to look into this soon to see if we
  can reduce those further.
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
history:

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely mine.

Thanks so much!
-john

[1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf


Cc: Joel Fernandes <joelagnelf@nvidia.com>
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
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com

John Stultz (3):
  sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable
  sched: Fix runtime accounting w/ split exec & sched contexts
  sched: Add an initial sketch of the find_proxy_task() function

Peter Zijlstra (2):
  locking/mutex: Rework task_struct::blocked_on
  sched: Start blocked_on chain processing in find_proxy_task()

Valentin Schneider (2):
  locking/mutex: Add p->blocked_on wrappers for correctness checks
  sched: Fix proxy/current (push,pull)ability

 .../admin-guide/kernel-parameters.txt         |   5 +
 include/linux/sched.h                         |  62 +++-
 init/Kconfig                                  |  10 +
 kernel/fork.c                                 |   3 +-
 kernel/locking/mutex-debug.c                  |   9 +-
 kernel/locking/mutex.c                        |  11 +
 kernel/locking/mutex.h                        |   3 +-
 kernel/locking/ww_mutex.h                     |  16 +-
 kernel/sched/core.c                           | 266 +++++++++++++++++-
 kernel/sched/fair.c                           |  31 +-
 kernel/sched/rt.c                             |  15 +-
 kernel/sched/sched.h                          |  22 +-
 12 files changed, 423 insertions(+), 30 deletions(-)

--=20
2.49.0.rc0.332.g42c0ae87b1-goog


