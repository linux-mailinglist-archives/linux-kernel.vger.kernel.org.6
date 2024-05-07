Return-Path: <linux-kernel+bounces-170656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629118BDA49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ECD286C55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD66BB44;
	Tue,  7 May 2024 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xc19Aci4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071886BB26
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057700; cv=none; b=PRgta7fYq5Djg5ehyvx2UmgHx9fdfghjZSP9QbL4yuKcwDHjmKwmi5B0ghdO0ORFPYAFHCdp5k9iAe5ZGRdkWANZlwbUDQ6kglOywxxW6j86Ddm/QZjDYUiIuvetQEQIRtfFiyfMr68N+eac1SGCInHUhT0CWIEgETf+vJZWo+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057700; c=relaxed/simple;
	bh=3ZCZy/HoQtFdIhsGB5dJf8G5rpP2j3/UO2fvvQgqw3A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FL4+N2HiSKWWRrAAmsWASHWQcMNBwpEqGIlBqOn0cd8ksIoLGXChZSL91zpO0qOlFu5saiJMTfTOFCjT6FFQbutyWZRbMB6jfG6lKf54y0rYI0ZlhuXT7A73tDp4+yBdwvbvbP6J/X/OKLRnJ9N7+z0uYEA43AO2NPxazqAlFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xc19Aci4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-62a379a7c80so610595a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715057698; x=1715662498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MV8LMwbIv3s10LPcUQCJEkpYWXTzgw68gY5nsFwahbI=;
        b=Xc19Aci4ba6/bX+isLzUPFRIxLjuJa7/SUwoBEot1d/w8PyTx1obUC8DLIt46meCJf
         KJTGFZ9qSVq0Nct9KZj2DxIgUEMbj/tj8ahrPs4SWfJHr7uK11h9OsVO2HJnNnioiv03
         E4T0YnJPoewCOhOB8OJ9Tc21zHaAtmM5ZDz19knPIPBNTvrOG3i/aHnMhDRc/SVmEzNV
         wqvR63/7fXO6MzLvJx1Bvv0W3eh9izmaMpHlTwSWecZ9bRcU0QAGSJWzxmD8+hYrUXc7
         cEzhIb2UmU7aE/cq0Qy5DEnK/Y1zIRCXSm5WQQhjeSdHzRy8gf/1Ei/Jz0PfIe4Dtbt5
         zWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057698; x=1715662498;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV8LMwbIv3s10LPcUQCJEkpYWXTzgw68gY5nsFwahbI=;
        b=mr4SftXhaCmmV6txZtcFsmtA8Fc0X56Enn7ZiyiGuobq3H4wSyS+onP4uFKbkp8qOL
         gG+WsqkPMu/GqbvQaZCNR52/VPRRZp3WTxnadQuD7o/r8nnE9RWlMosKFP5xROAlXJR+
         0i+dp/cySIbCghivqv2OWIK0JqEBnD/HPPrF5xEFutJTRi3gFZtn7nURWQ/EApCrxMgB
         EQDFWb1nGuDdmYnteeJ6raiP6IeJiSBc3MWDxXkZxLaEpz9fD2bi1styzPE0DvPLoHqi
         hXEMvrqRCFUw6L6R49yDLzsTzxzICtR6BzpcPB5cNZO/d8Ve1ICZSP8zT5AO9m8mFGIE
         tkzg==
X-Gm-Message-State: AOJu0YwKGKWSk0GODOYRp9rOJeRHZvNar3mV4CvtGu+fD/0Xs2UHLHK0
	HTaIRz07NvaSVg1h9mw0+1uLUj6RVSuIA60LcQYNfWe+wrqLG07/eum/iNXoV/rqAyKy137Dmnd
	1VJ0J6udbdyT1W3cw+Mp6F/kJooIwdBo8WFVNWTPuDTzbUj0rhN0L5YM/iqpAmdMfXHmA91uiVd
	5MxNftU/iWLwPqzhvAx48F2B7DCHTSpBCPrpeDd+f2wmyL
X-Google-Smtp-Source: AGHT+IFwARfqnh1THNFSd5KGhhVU0w79NS5ZR95Zr71e2ky0jLzCnvCsRc8LjD/FmlxHyCR1/Ht+X0HB3w5S
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a02:446:b0:61e:c365:8234 with SMTP id
 41be03b00d2f7-62b759e8042mr4877a12.5.1715057695879; Mon, 06 May 2024 21:54:55
 -0700 (PDT)
Date: Mon,  6 May 2024 21:54:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507045450.895430-1-jstultz@google.com>
Subject: [PATCH v10 0/7] Preparatory changes for Proxy Execution v10
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As mentioned a few times previously[1], after earlier
submissions of the Proxy Execution series didn=E2=80=99t get much in the
way of feedback, it was noted that the patch series was getting
a bit unwieldy to review. Qais suggested I break out just the
cleanups/preparatory components of the patch series and submit
them on their own in the hope we can start to merge the less
complex bits and discussion can focus on the more complicated
portions afterwards.  This so far has not been very successful,
with the submission & RESEND of the v8 & v9 preparatory changes
not getting all that much in the way of review or feedback.

For v10 of this series, I=E2=80=99m again only submitting those early
cleanup/preparatory changes here. However, please let me know if
there is any way to make reviewing the series easier to move
this forward.

In the meantime, I=E2=80=99ve continued to put effort into the full
series, mostly focused on polishing the series for correctness.

Unfortunately one issue I found ended up taking awhile to
determine it was actually a problem in mainline (the RT_PUSH_IPI
feature broke the RT scheduling invariant -  after disabling it
I don=E2=80=99t see problems with mainline or with proxy-exec). But going
through the analysis process was helpful, and I=E2=80=99ve made some
tweaks to Metin=E2=80=99s patch for trace events to make it easier to
follow along the proxy behavior using ftrace & perfetto. Doing
this also helped find a case where when we were proxy-migrating
current, we first schedule idle, but didn=E2=80=99t preserve the
needs_resched flag, needlessly delaying things.

If you are interested, the full v10 series, it can be found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v10-6.9-r=
c7
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v10-6.9-rc7


New in v10 (in the preparatory patches submitted here)
---------
* Switched preempt_enable to be lower close to the unlock as
  suggested by Valentin

* Added additional preempt_disable coverage around the wake_q
  calls as again noted by Valentin

* Handle null lock ptr in __mutex_owner, to simplify later code,
  as suggested by Metin Kaya

* Changed do_push_task to move_queued_task_locked as suggested
  by Valentin

* Use rq_selected in push_rt_task & get_push_task

* Added Reviewed by tags

New in v10 (in the rest of the series)
---------
* Tweak so that if find_proxy_task returns idle, we should
  always preserve needs_resched

* Drop WARN_ON(task_is_blocked(p)) in ttwu current case

* Add more details to the traceevents (owner task for proxy
  migrations, and  prev, selected and next for task selection)
  so its easier to understand the proxy behavior.

* Simplify logic to task_queued_on_rq suggested by Metin

* Rework from do_push_task usage to move_queued_task_locked

* Further Cleanups suggested by Metin


Performance:
---------
K Prateek Nayak provided some feedback on the full v8 series
here[2]. Given the potential extra overhead of doing rq
migrations/return migrations/etc for the proxy case, it=E2=80=99s not
completely surprising a few of K Prateek=E2=80=99s test cases saw ~3-5%
regressions, but I=E2=80=99m hoping to look into this soon to see if we
can reduce those further.


Issues still to address:
---------
* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants.

* CFS load balancing. There was concern that blocked tasks may
  carry forward load (PELT) to the lock owner's CPU, so the CPU
  may look like it is overloaded. Needs investigation.

* The sleeping owner handling (where we deactivate waiting tasks
  and enqueue them onto a list, then reactivate them when the
  owner wakes up) doesn=E2=80=99t feel great. This is in part because
  when we want to activate tasks, we=E2=80=99re already holding a
  task.pi_lock and a rq_lock, just not the locks for the task
  we=E2=80=99re activating, nor the rq we=E2=80=99re enqueuing it onto. So =
there
  has to be a bit of lock juggling to drop and acquire the right
  locks (in the right order). It feels like there=E2=80=99s got to be a
  better way. Also needs some rework to get rid of the
  recursion.


Credit/Disclaimer:
=E2=80=94--------------------
As mentioned previously, this Proxy Execution series has a long
history:=20

First described in a paper[3] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

Thanks so much!
-john

[1] https://lore.kernel.org/lkml/20240401234439.834544-1-jstultz@google.com=
/
[2] https://lore.kernel.org/lkml/c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.c=
om/
[3] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
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
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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

 kernel/locking/mutex.c       |  60 +++++++----------
 kernel/locking/mutex.h       |  27 ++++++++
 kernel/locking/rtmutex.c     |  30 ++++++---
 kernel/locking/rwbase_rt.c   |   8 ++-
 kernel/locking/rwsem.c       |   4 +-
 kernel/locking/spinlock_rt.c |   3 +-
 kernel/locking/ww_mutex.h    |  49 ++++++++------
 kernel/sched/core.c          | 122 +++++++++++++++++++++--------------
 kernel/sched/deadline.c      |  53 ++++++---------
 kernel/sched/fair.c          |  18 +++---
 kernel/sched/rt.c            |  61 +++++++-----------
 kernel/sched/sched.h         |  48 +++++++++++++-
 12 files changed, 282 insertions(+), 201 deletions(-)

--=20
2.45.0.rc1.225.g2a3ae87e7f-goog


