Return-Path: <linux-kernel+bounces-307801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F796531F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD964B20BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308191BA891;
	Thu, 29 Aug 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9mFKYOD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7718B47D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971939; cv=none; b=Zi5eZssi4NMA3eqQbENGlJZUxHR+zujTHxf9OTHeZ2srCblRH/pw3rQtkG5JQAuVPHiuStogFc3nCqYtzpzHZuj67oUdkRBpZW0xRbU7Hn3T91EhKHq6wqPkibK8Mr68NkIlkm5tR413ohnkC2m6jWyK6gNKp93AfyptET5I1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971939; c=relaxed/simple;
	bh=ttaCZr8NW7s3o1ysXfNCTZTnxvVZNR+te2ZXOXxJkDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gQK1PR6MPoVCpSct0D5FyB6AJLFWJ0C4Z7GKb8zOnuDDfh++3DgSRDVlfDqymJNEeZ/LoBNg9YQuW8UUHe9Vm1YtxRp/3aJbT9tmPuWhifMmv+xucd5Iy1LF0JcHR6mvEluWJd7E99Tp7l9dYIAmOK//RSgmdM3a3MTp/yf5l80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9mFKYOD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d3c89669a3so1385117a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724971935; x=1725576735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ox4H669XkbvoyzIym4MmiIQw2MOi840k6y4BZqkU14=;
        b=h9mFKYODCsJETLCSlzhNW9vAacK335TZGaYhoClrH/y8PONxoSsUnoxa4Fk01+Id7M
         bpzy46cIv2aAasxfm08wwuXGz1xrBMJrvasbPw9OrrDPUNailAA6TlOmBpYFHzeXnd/C
         fD8abOjTRypwG2MkjUWRgtBLAOG5e9C6tLn4CjqTyoVbnvThBDugFugL5qrE7nPge/l5
         nAwuZb7eQys/jsWjhlCe00Vt7d9RW0k226rcC0JOyda+Tw8Vtz0mDCKQ0EDtK/hsaV7A
         AbpwyQRuJ/u51lcEov6OyDZjTEy9mmwc0nT+3672Z7wxF1mRW5KPV6qHMCvxc5vFHXdX
         qY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971935; x=1725576735;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ox4H669XkbvoyzIym4MmiIQw2MOi840k6y4BZqkU14=;
        b=uOMs3jKehSLxJKtZRwyCs6Vq7nJFUmwFS8b6TEA6kAdnMJ6v92Rwg8zzlyjbGA9KAn
         WZn4/lMNzHAcSqTD5Z90mzLm7VQAiYSunf3Ur+ommqkbARo3SEx8psV5C3OulcVNXLzz
         HMW7PZdEZN38R341kLyyr2glydFasmem+xLba+Qf7uCXK2FnwBkiM5zSQfNd2IHeoseu
         6qX2+jA3KZXxSBPOTOEcnocyOYvmxBn5oRcThBs+ngymZNfS+DlJKSiLkHas5WBpxtLh
         n//oNnw8D4C/R8Fsi7eX18xILLdlicur+4osh7dNFslgw6R0D0WRrgXoHHj4oiYV/II7
         Fi+g==
X-Gm-Message-State: AOJu0YyiwgCO1O+A3VlPn8WiLP7S86O8AUguIWlAQb0y5tnGB5+zrkLr
	2wpcWKq+AyJu0VtX5YDY2AchUDHGYaSaT/mcYiHQLB95J+YDqPNvyKIjnjnpdJ/RoaVFDKKuwHc
	BlkC3hGw3klF8nkMbtdtLG6k9QZSti+B+aE0bKsZj3duQZG8fhaZ8aIfvz+lOQ44nUMM7iAnZmH
	MtZqGpCotznRnPmhytXFu7hEUF/zdS5KGRes+xuyy5yNMK
X-Google-Smtp-Source: AGHT+IGjKO4mgZkb6LD8u2nL0L1GVf+HDj+qGNdH3QRknsCzshKnkIouLjaTITrcWz9b2csZ19XgPnOAoZHN
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:d50a:b0:2c8:6a6a:1ef3 with SMTP id
 98e67ed59e1d1-2d86b5d00d3mr11052a91.0.1724971935329; Thu, 29 Aug 2024
 15:52:15 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:52:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829225212.6042-1-jstultz@google.com>
Subject: [RESEND][PATCH v12 0/7] Preparatory changes for Proxy Execution v12
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

  I wanted to re-send v12 of the preparatory patches for Proxy
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
2.46.0.469.g59c65b2a67-goog


