Return-Path: <linux-kernel+bounces-390818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CACD9B7EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9D281E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C6613AA5F;
	Thu, 31 Oct 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WhJGqM87";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dFAYgpMm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1C13A868
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389587; cv=none; b=CrsacjUDJcM/nm1QjV/mAoRhz0bGp2yvq7Xd4Qkwm8sLxX6I1FnkP5tWXl1F75nUgRwORvha6eZbCTHmbUH0l1qP3G5KqTBanGoeemaP2uXdAQgcN3ZuK2qOPZ68T4W5QlwpCHjdwD8W9pqfjYBr0ChUcCoD1W96dCVeRqyOtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389587; c=relaxed/simple;
	bh=55LonD5xfg1a0IwuGcBdhgqy4KsW5BIGCi4ikVYszm0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=isDnGEF++yHK/F7gAQorJh1iO3P79jYEVUPGBwjy8Oy4pOYRdroQ1xnXI7mXSxA+YYLMTmf8oPp4wLcEFw9tJ0bb506hR4H1VbsV69LfNlPq/OjGW6GjvZNTiros/qD+ot/IorslUMndleWGtd3zQPXsYI8/02JgclWZs5A1J6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WhJGqM87; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dFAYgpMm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031151625.361697424@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=M9HMlGng7838XBNWDxaJRmqIFBaqhNdM/IzDR2OrnTc=;
	b=WhJGqM87V0+rmJ7jpzxrPIjXXzKFnwMmhX1eF8r9I8vd8+mrE9sYDOS4CMb/WioNOBRs1V
	Z2Nv62+RGQYmxY7wtHiB/PjqasQ8zLYqR09LyCryRcB/gl+aUX1LivGv9VF8COts8KPKx8
	MDwT5zUBgn4uhyHOdtwY3Y0NXQ0iqjSh90HM7GdejXqLV8EqfJddf6ocBdCzvApu1RnCtW
	zhlZLwgA/8wBjqd8MdJcvJ0y2M2QeeZCOxTDx2W5/FOW25mD30K34O6v5aOQpm8ZsmcrLC
	aDSjyQwpqtqrUIH4Yo1sndIL1k6Agfwnfw2mFnIki5j9YvMuFgCINvrlpsoqYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=M9HMlGng7838XBNWDxaJRmqIFBaqhNdM/IzDR2OrnTc=;
	b=dFAYgpMmDH+osLLTsgabwjrwnpZfrT00qchtNe+EGIkP5cwbf2JvSqDDW1Rl72+6mKIk83
	WgCOHJ/aaKCt6YBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v6 00/20] posix-timers: Cure the SIG_IGN mess
Date: Thu, 31 Oct 2024 16:46:22 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This are the remaining bits to cure the SIG_IGN mess. Version 5 can be found
here:

   https://lore.kernel.org/lkml/20241001083138.922192481@linutronix.de

Last year I reread a 15 years old comment about the SIG_IGN problem:

 "FIXME: What we really want, is to stop this timer completely and restart
  it in case the SIG_IGN is removed. This is a non trivial change which
  involves sighand locking (sigh !), which we don't want to do late in the
  release cycle.  ...  A more complex fix which solves also another related
  inconsistency is already in the pipeline."

The embarrasing part was that I put that comment in back then. So I went
back and rumaged through old notes as I completely had forgotten why our
attempts to fix this back then failed.

It turned out that the comment is about right: sighand locking and life
time issues. So I sat down with the old notes and started to wrap my head
around this again.

The problem to solve:

Posix interval timers are not rearmed automatically by the kernel for
various reasons:

   1) To prevent DoS by extremly short intervals.
   2) To avoid timer overhead when a signal is pending and has not
      yet been delivered.

This is achieved by queueing the signal at timer expiry and rearming the
timer at signal delivery to user space. This puts the rearming basically
under scheduler control and the work happens in context of the task which
asked for the signal.

There is a problem with that vs. SIG_IGN. If a signal has SIG_IGN installed
as handler, the related signals are discarded. So in case of posix interval
timers this means that such a timer is never rearmed even when SIG_IGN is
replaced later with a real handler (including SIG_DFL).

To work around that the kernel self rearms those timers and throttles them
when the interval is smaller than a tick to prevent a DoS.

That just keeps timers ticking, which obviously has effects on power and
just creates work for nothing.

So ideally these timers should be stopped and rearmed when SIG_IGN is
replaced, which aligns with the regular handling of posix timers.

Sounds trivial, but isn't:

  1) Lock ordering.

     The timer lock cannot be taken with sighand lock held which is
     problematic vs. the atomicity of sigaction().

  2) Life time rules

     The timer and the sigqueue are separate entities which requires a
     lookup of the timer ID in the signal rearm code. This can be handled,
     but the separate life time rules are not necessarily robust.

  3) Finding the relevant timers

     Obviosly it is possible to walk the posix timer list under sighand
     lock and handle it from there. That can be expensive especially in the
     case that there are no affected timers as the walk would just end up
     doing nothing.

The following series is a new and this time actually working attempt to
solve this. It addresses it by:

  1) Embedding the preallocated sigqueue into struct k_itimer, which makes
     the life time rules way simpler and just needs a trivial reference
     count.

  2) Having a separate list in task::signal on which ignored timers are
     queued.

     This avoids walking a potentially large timer list for nothing on a
     SIG_IGN to handler transition.

  3) Requeueing the timers signal in the relevant signal queue so the timer
     is rearmed when the signal is actually delivered

     That turned out to be the least complicated way to address the sighand
     lock vs. timer lock ordering issue.

With that timers which have their signal ignored are not longer self
rearmed and the relevant workarounds including throttling for DoS
prevention are removed.

The series is based on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip timers/core

The series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v6

Changes vs. V5:

    - Dropped the first 7 patches as they are queued already

    - Fixed the conversion of the firing flag to boolean 

    - Simplified the overrun accounting - Frederic

    - Reset the timerq pointer in case that a signal is dropped - Frederic

    - Dropped pointless sequence counter manipulation - Frederic

    - Turned plain checks into warnings for state which should never
      happen - Frederic

    - Picked up Reviewed-by tags as appropriate

Thanks,

	tglx
---
 drivers/power/supply/charger-manager.c |    3 
 fs/proc/base.c                         |    4 
 fs/timerfd.c                           |    4 
 include/linux/alarmtimer.h             |   10 -
 include/linux/posix-timers.h           |   57 +++++-
 include/linux/sched/signal.h           |    4 
 include/uapi/asm-generic/siginfo.h     |    2 
 init/init_task.c                       |    5 
 kernel/fork.c                          |    1 
 kernel/signal.c                        |  302 +++++++++++++++++++++------------
 kernel/time/alarmtimer.c               |   87 +--------
 kernel/time/posix-cpu-timers.c         |   50 ++---
 kernel/time/posix-timers.c             |  215 ++++++++++-------------
 kernel/time/posix-timers.h             |    2 
 net/netfilter/xt_IDLETIMER.c           |    4 
 15 files changed, 401 insertions(+), 349 deletions(-)



