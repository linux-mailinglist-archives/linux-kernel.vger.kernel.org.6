Return-Path: <linux-kernel+bounces-358020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9D99795A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBADB21F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524D61E3DF7;
	Wed,  9 Oct 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0F8Exw2"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20943149C4F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518041; cv=none; b=Z2TRPSrVV+AqO32IzQ/d9lVsT40zRdm64qtl33kDOrdt4ppYHCZ1RlRZ+p5LvlmTUxkXWBL5hUE9jyNdFBjgCNnyDrxHMkmB6PQhW+uVBqDFtjZIykdkjo9wphft68XpYTq6N7vrQ4gVTIPyu+H0g3KppxhTiPVtACRZMwuUC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518041; c=relaxed/simple;
	bh=PGbwF0vW7JxqyOXFMF8PuHNFzeFWCLjDPRWhYoe5eT8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lkwSvcTQ+BmzcLKX2UQbX4c2JnF38MKsT+4qJtztD1KYUOSthpJ86Lqf4d0TquJDURqBv9GzNoMw3hCd8sFXz8wK4EYU3iAEtThpunh+YrHcTybnggEaGBrJS83hgbPJ8x0loGWzS3cm9gE7T+xCwxc+j+xdSk2yQlPGdyX8FGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0F8Exw2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e1e989aa2so444067b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518039; x=1729122839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rdIMgaEH5qpszgDuWcf3czBUpKa8YMWLOiFCJokg8c=;
        b=R0F8Exw2y+HmgKuhrPnUQ+MK0y/LA0NLarRszBaaQxLdhgZ8zcsJCn2FJZHkZ7O/wN
         VhVp/H86ICRzEGvHoS1GolfF6v8RXGZ4nqtIRFJnsPSIzWSmrzt9xR9f92dYXwuUveoS
         PYYJxj/0Fk9VxXwNgOHBBNkZGFtpIdl+6EOQZnUaaRV5bQ0+qXBXi/AAuVyUWljbQzEV
         9nWjaIUx/U4xtGHOqNo/m+67D6iwq8kY9q7Q5ZRdTHYgEH24ut7CnLePg1mJQn5EWF/W
         3/0v8+1+CDuKz0u2Mf/OsP9eiJxDW/hKn90zxtHOYdR7DZUSE2VqQE9XTLVAdh05A+JJ
         xsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518039; x=1729122839;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rdIMgaEH5qpszgDuWcf3czBUpKa8YMWLOiFCJokg8c=;
        b=T4SnJwrDUNS1rsMjwBFqylB/TwTf0ip6pV6XT0UOWSJU54NLhkJi+Gm5AJfBFN/Yyr
         hms2/eNfEuV80B7rDhVdwqUGIyGZ5+PjfdaYZCCVgXIDqH80FQCh024BhLyYHuTqpPUQ
         /H/DvRMMzHZ+CrM1hZGuA4pGg0g5rgeth4VfMiP9VjUeuYYuGj3fMHXHiEcPaQoAUOXk
         7xKZIYvQxNLr3w0jD1/+BOQHcxM5MugbMeExEIxqqiRd2K/b9axcQND4QXvq2i022PPo
         o1rGg2klVhTTJimRj/dhvW+5Kpdzhi0CDCRKmibnpUVjAJTpk8q6r6Wz3yfP/FADgfab
         asDQ==
X-Gm-Message-State: AOJu0YxMHHFBcEJyfqROTs2o4YgPt6/xNR7CpTQkMi5oGg+SHntAd/Qt
	5KXtHISQBqNG0fS9TGPtJ1N3GRJN0h8QfhkX7qUgenFigZre/MGaIVp5hTo2oCXMT1sgKPiF3vq
	g1BF3tGBOSAfQvUZBSCKUCU/+frl7/i3cW8Pi+9AnDU35JVuPIkibYl4jxyvpeht+Fe3ujFv/nN
	zataneH4WRwfL7gavzrAxwoEbLLcEl96TWRRO9gXDWKIlH
X-Google-Smtp-Source: AGHT+IGT0ZX6To6tqT7LDekhWZEW1xHn2letogGDQcnkYfZmkq9VTlCxHkmc2YfB8r+be6m3EsSd4pZDA90X
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:4fcf:b0:71d:fb06:e79b with SMTP
 id d2e1a72fcca58-71e1daa9410mr9187b3a.0.1728518036979; Wed, 09 Oct 2024
 16:53:56 -0700 (PDT)
Date: Wed,  9 Oct 2024 16:53:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009235352.1614323-1-jstultz@google.com>
Subject: [RESEND x3][PATCH v12 0/7] Preparatory changes for Proxy Execution v12
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

The only change in this resend is rebasing the series on top of
the current tip/sched/core branch and resolving some minor
collisions.

Usually I link to the full proxy-execution series here, but
while these preparatory changes rebased easily, I still have
some work to do on later changes in the full proxy-execution
series to adapt to recent delayed dequeuing and dl_server rework
that landed in 6.12-rc1. I'll post separately with those changes
once I've hammered all the details out.

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
 kernel/locking/rtmutex.c        |  49 +++++++++----
 kernel/locking/rtmutex_api.c    |  11 ++-
 kernel/locking/rtmutex_common.h |   3 +-
 kernel/locking/rwbase_rt.c      |   8 ++-
 kernel/locking/rwsem.c          |   4 +-
 kernel/locking/spinlock_rt.c    |   3 +-
 kernel/locking/ww_mutex.h       |  51 +++++++------
 kernel/sched/core.c             | 123 ++++++++++++++++++--------------
 kernel/sched/deadline.c         |  57 ++++++---------
 kernel/sched/fair.c             |  28 ++++----
 kernel/sched/pelt.c             |   2 +-
 kernel/sched/rt.c               |  67 +++++++----------
 kernel/sched/sched.h            |  50 ++++++++++++-
 kernel/sched/syscalls.c         |   4 +-
 17 files changed, 324 insertions(+), 228 deletions(-)

--=20
2.47.0.rc0.187.ge670bccf7e-goog


