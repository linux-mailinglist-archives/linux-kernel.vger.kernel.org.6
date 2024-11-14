Return-Path: <linux-kernel+bounces-409812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D59C920A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48B4285290
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AB19ABDE;
	Thu, 14 Nov 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MX5LbXVA"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710F1487CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610858; cv=none; b=EntuirKxxgQyqmDjPvpuF0MbzLb54F6hizJu71dpXm1Oyc889COSVD/LGFsLHM0OwrGBFvPZYxaPUDYM2vg81/ZAyCbJlhTD75rto45aAE51qAu2rXEQNz+qZqLK3KoUuak7WlkU1zfu4c1lqZJW6HRH1g/nqm6z8THmNDoYrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610858; c=relaxed/simple;
	bh=ksnwTDE/dUDhebnDpklJdpLWpJpk3HHSBiMjts9oTM0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ishofvkmpiGJmzUC1SLspdrxtRiVKSwwhuBbIz2RTKbT4wKNz0sg88uCqhBnR4//5hbL/lU6HEH3AUg4oMn2an9RKVgNPBmY0+efUHOvoOnbIoGeOpvdUzyU3nLE2aO1CQMGixWROkE2ioF+s6BPWwIkPxdMLnoB+gSozjyvPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MX5LbXVA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-724229e625aso980912b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731610856; x=1732215656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+vtCKFwRHOyBTbrHTcq12fkzIAClNT27MCjUuoEV7g8=;
        b=MX5LbXVAqQNx0Hgxd6okaJIgXNOPE0EVr3vWcpIpczvJMqQxZ02mIqphliozqCxVFI
         3qXxaY5FFQyJ3JTSLd237GvJQSS5MNtp1PY4ZFdo36dcaYVFs1bcOyd5beBQ5oHMjBOL
         PxM0IAtuTMFy4haCMjsB4JpCoo7ThvM4AU9FeXg50vjCKVxwaz5sYl/WbrArMlcd2fVP
         1HfVtCYkw5zp1QW4BVDBhJVPN9X+InTOReo9gCM4V4gXoBBEZwBTmFCyxBtacXB9R8L0
         GI0jqmi9xFWll8Lbu+NvhBGpYT5/6nQ+N2+ouZhPkYXqPTOvajcWeU8LH+e1jA9EG1zA
         IaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731610856; x=1732215656;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vtCKFwRHOyBTbrHTcq12fkzIAClNT27MCjUuoEV7g8=;
        b=H4ieuByFh+9X70Bghtb4OKyQDGoiM6GauC19/i0mxADI1gtihJjfwrPxkE0mpR3fmP
         xVSeRXttcpeQcQpl4ckwD/iH5GTQuoCH9CiJVxr6xyy71YuKwQp9GRqVvuoicurL71oM
         pN2Qro3uzCARXr6OzshPcE7EhY/nN8mb2TU93C3KJ6IrW/cvmBg4I1/Y4aPlNvmsBhuQ
         VpcI7A6Q3WyGgoYsTSk63ICO1I+Oxz7hsu4TJ/W6FGmgS2lJHNcaUl/khsbrl8ymp39T
         bF9nT5FbK1IiTK8ZsnPY2Cks3whUUeMAxRd4D/Y3k5KmJa7Lfnnf22R/MtgSYSe6W1OM
         JOlQ==
X-Gm-Message-State: AOJu0Yx9ht0l0qZvoCJfkX5B6B35nLSST3nKJQ1xKI9LFQHSMUCzZ2gb
	nDcanS+YhbdL+Jr93dxUwPpuDsUL79Z/MP1Xby4hp5PWha6eXIGuB2grxX4Sl+s8chZvApKphyv
	cNsd+3wCZpurtDMbOXgWu/BZcTwgEW9l4+sR07vugQ1wAmUV0gf/sv7uAHWvRShK1nXMDkJ2SC9
	gjoyjRHadiitMbml1u7heRWSKItHd86ErfSGFJUrryN76V
X-Google-Smtp-Source: AGHT+IE/GDni8tDvMRvqR7DODgCnOX8yXZFz69Y33hmoz1TmL8eynyASyO7qKiEpJ51ScOibxQmXGliBBDYT
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:988:b0:71e:4535:9310 with SMTP id
 d2e1a72fcca58-724769f6913mr101b3a.0.1731610854501; Thu, 14 Nov 2024 11:00:54
 -0800 (PST)
Date: Thu, 14 Nov 2024 11:00:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241114190051.552665-1-jstultz@google.com>
Subject: [PATCH] locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Davidlohr Bueso <dave@stgolabs.net>, regressions@lists.linux.dev, 
	Thorsten Leemhuis <linux@leemhuis.info>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Anders had bisected a crash using PREEMPT_RT with linux-next and
isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
wakeups from under mutex::wait_lock"), where it seemed the
wake_q structure was somehow getting corrupted causing a null
pointer traversal.

I was able to easily repoduce this with PREEMPT_RT and managed
to isolate down that through various call stacks we were
actually calling wake_up_q() twice on the same wake_q.

I found that in the problematic commit, I had added the
wake_up_q() call in task_blocks_on_rt_mutex() around
__ww_mutex_add_waiter(), following a similar pattern in
__mutex_lock_common().

However, its just wrong. We haven't dropped the lock->wait_lock,
so its contrary to the point of the original patch. And it
didn't match the __mutex_lock_common() logic of re-initializing
the wake_q after calling it midway in the stack.

Looking at it now, the wake_up_q() call is incorrect and should
just be removed. So drop the erronious logic I had added.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Benjamin Segall <bsegall@google.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: regressions@lists.linux.dev
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Anders Roxell <anders.roxell@linaro.org>
Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/rtmutex.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c7de80ee1f9d..a01e81179df0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1248,10 +1248,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
-		preempt_disable();
 		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
-		wake_up_q(wake_q);
-		preempt_enable();
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);
-- 
2.47.0.338.g60cca15819-goog


