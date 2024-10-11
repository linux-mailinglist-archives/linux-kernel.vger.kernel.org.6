Return-Path: <linux-kernel+bounces-361962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9CE99AF5D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4401C27457
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA341E2841;
	Fri, 11 Oct 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ljqcCTQ"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED131E1A10
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689141; cv=none; b=sSYVavn6BU170AKlJG5kq0r1nMRL6/y43e83/LS2YDBWgxj/vWiLnMsklZDdN2Jd7qzQ+G+0AaSLI42AnLQflNAKK0fL9+nMK/PfIqDo9d6kgIC+jggeLF1YfdTzJ9ojv93QvCQZpWW+AE7Xg9HYSpSI7atP6TL/H7TpjjS3a0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689141; c=relaxed/simple;
	bh=5qyQYtadlO7N26jA1/SgARS0BtgFVqMM1qoc9JKFVEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ni/YbOFwb35G1+UwGuOfEo0I9luEqOFomBnRLywqyi+oj4sKIO2htzdWtI9VV+k1j1NXnbEEN5X63aamfUknVL3Pahumzh+a2gcTjDCma/xySW6HdYgEATvgxzE30yEamS5BNkJn3w5MjrHM9NQtRaPAggzwf5kqT8WI3yNqHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ljqcCTQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea6ebdf5d3so4046a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689136; x=1729293936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DChFR+k07GiHeawZcsj3goXcAMW/ZVmxoj+0ePjCDYA=;
        b=2ljqcCTQltv3uxa028TMHPeSw+imFGHlU04ZicRR835wXws2RxpAdapBv8V2mQBSid
         QEkuedZxPzpm/p++Xe7Ozuc4Ee8N+7mNfTeLDsnozP583xuVK5Bp1Z4Rnc5y+Agpvvg2
         hykQsvhqpv4Ri/v0Pzi9CbkxcS+j1ACVPm3DHwPJhcnFrkYrOIElSkHSJ7utwT0reiPJ
         NigFRFS0na1X55Id2NfL/bjfoBAZvN5KOUjbzfRl/8biaGaAwsAFe5+xNxAev3kx4l7k
         xYxo902IJKsiI+d79wnaqE3d0cEoPyaSKtZMSYQ9NUJ6PIQkofAr2pOh2yCdtMXC6ZPd
         7oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689136; x=1729293936;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DChFR+k07GiHeawZcsj3goXcAMW/ZVmxoj+0ePjCDYA=;
        b=XQ5G+Tx6BF8AhH5xrdbw0AlILXmkEf2z//bQai91aeFugynZQOLNJDauazd5U5xeSK
         aNJfRCfx1q/BUnoJWGeDs6mn9XoPBnjWPU7qAhlVAYxuz/gn9XlXexjksUcDN+7tp66x
         fwbxh/QHB9MVU4oBWerla4CXaSsLLwra/WYY3R3vp1PQBwDh3NTomOZ7ihN38VIHqYNI
         wIzuaZlmkrIF8dkR2vEIlDPD02H2RFXWNWsumjTSCdq/SOg5waT+PyZvjq9yMR9kBk8i
         RUsD1PfmVPOwQ/8b0klUWDhGz7HbEjyay2alUiMALrcmps3RQB0E/FNZA7BO1dPWwaBi
         +Omg==
X-Gm-Message-State: AOJu0YyO7cLwQNu3Lj2Nzzi1GgOeDTnAFlgVG3j4LheOLuc/u09xJBt3
	FEuU1DzwnaocmTU4wl+Cc3ayWHIHZ+czvz4CM06rUH25CcqD3JRfj9fivx6VgSdGvI+PpU+FT+Q
	tCRzA5bxoPxR5meRP5zyp3Mo25/upG93uuKjRMjT4dscY/OOzy0fLi+u3jvxE92ZCQGVu2AlF3n
	oTJZcFB9NCURrSSorcySrCQ0yLnPCF3Z7/8wyPimz0xcx2
X-Google-Smtp-Source: AGHT+IHrOQtEuJLFJeKBWkxMyYCkXJXC/ODVWVXkdRggBRR3ubCTnb4j5nIkQ6lZZU9Zx1IrkGiUrPhxfeVc
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:77c7:0:b0:7ea:6d63:1071 with SMTP id
 41be03b00d2f7-7ea6d63126amr518a12.7.1728689135226; Fri, 11 Oct 2024 16:25:35
 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:25:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011232525.2513424-1-jstultz@google.com>
Subject: [PATCH v13 0/7] Preparatory changes for Proxy Execution v13
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

  I wanted to send out v13 of the preparatory patches for
Proxy Execution - an approach for a generalized form of priority
inheritance. Here again, I=E2=80=99m only submitting the early /
preparatory changes for review, in the hope that we can move
these more straightforward patches along and then iteratively
move through the more interesting patches in the Proxy Execution
series.

There have been no code changes for v13. The only difference is:
* Expaneded commit message, as suggested by Steven Rostedt

Thanks you for the detailed review and feedback!

These changes are based against tip/sched/core

Usually I link to the full proxy-execution series here, but
while these preparatory changes rebased easily, I still have
some work to do on later changes in the full proxy-execution
series to adapt to recent delayed dequeuing and dl_server rework
that landed in 6.12-rc1. I'll post separately with those changes
once I've hammered all the details out.

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
2.47.0.rc1.288.g06298d1525-goog


