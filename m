Return-Path: <linux-kernel+bounces-416220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171CE9D422A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99742843DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5D1AAE05;
	Wed, 20 Nov 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2mw00C0k"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5549145335
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128393; cv=none; b=rf5gDYpBwoAor3JQ9J3WVrNSfeQw0T2ct8kvZVstDF6ofnYQ4Ubi7Cxyofduhekj4H4y7ifzYkoUGSDFOUHNOlVzr9yn9N0cusDm2r5IibrNm9sLSUkZxyfIuGoMmZVfJm09X5PkyjRoZf6K2yivlOc5Te+38HIm3J12fP5roJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128393; c=relaxed/simple;
	bh=FCvj2/G36BpuLQdzReLtR5lIFwjoErIAljyykkiAk64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fCWuN31HAtc03BWf8QAjybQN3OX/ZsqArp3Z3pxZP2CqHJE8pwQqE9dMc+zu721FzGScS2huWf206Rg+jB+6bpVzKRC1VQLQCjXr9Lnb77kt23iKgQugWanqpuPbffKGxxon6bFxxbdtsou/280OC/Uk7NBO7/8rlxpjBIGHo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2mw00C0k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38dbc5d05bso19877276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732128391; x=1732733191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hA7/jTfvEvvp0vYIHl4c3THkQPVUzVNCs6YM2/ZYMNA=;
        b=2mw00C0k3pny6ewLkbJpoWGjzD5/w++ABPZKKgFGkgX4UKg04gkM2d8NCt+9nro9Fi
         BBVxSOGot3HGcolKpNlqis053G2gBwC3vtKZJG33iZ9j5sGHCPrmJGHkBK9naL7pXO4K
         ktKkwJl3++Jmex89NIRp6HSnhJsf65lbdbIhPX1mEgj8HeTv08B5ts9O8hQ/xII2j40V
         uCX7ux9py0D/RKdJqH7Tq8qWQzBHcoCQakh+jvYCkixEiBfIseaTz9/T1PadcwVrpIxs
         IvRkZPne9CpgPyn/b2e/QAPguMbDr8mV6eastPsVi8YJ5RHCkn/X2C3UnoshWYP/4OR5
         twLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128391; x=1732733191;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hA7/jTfvEvvp0vYIHl4c3THkQPVUzVNCs6YM2/ZYMNA=;
        b=DWRWKQGn0qrhaGehrMkCbtUlVuLwh1IxAIh3ugVvNT7JAXrP1J1DSsZHdS/pVlVZ2H
         aGZ180i3XCogRQKYPPVtLGi+ZESrXl+GwPSOOBd4O05uf3mdOZ2V4GP52mIukSxO7/WB
         M2+4tPj9deCJPIo5vRyH2Omn4Io/A7c0HpTDNMMJjuf4adz47xc0VBPhHI1pugUYHkO7
         hj63VMw0KhSUnfcXBdI6CHbdcZRfQSbw6If/r9BeF+fUvOWo29l5KRy4AiBaz8vJ0tOV
         wNExjZghXBfIrI8tdzcAv+QeY2Z4miYNx0h9x27H4mticg8LYXRcGUlC6V1Xx28TQAAy
         5UFw==
X-Gm-Message-State: AOJu0YyzT9U39vBYmw6NwyvmtUDsz2xNaPYVSfdocy4PAIGsbGEIbBKR
	PKPJ4QIzgAn6F/weCMVWOlylSoJJ7fet1b3vpAKXCjbqVTV6bM/MaR/zDTg2xevQNINTP8gk3VY
	1XhbMGhvUVv5xTCJjCHVysePYI/TmUmMG2wqhVkCPG5CrrBK4dZeo/ypB/u3hMSj/YgPGEVNgcD
	5pV2ENxixIGjNW4WqxstOi0kQLJtX9NX9HrpyKJaYUtRPw
X-Google-Smtp-Source: AGHT+IEDkhYTiI5OseGPF+A421GcX+ypm5rVUXPDgikPovAjusbWISocWyC3x6sPz54Lt/atzxBlsEM+WW+c
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:d601:0:b0:e30:d445:a7c with SMTP id
 3f1490d57ef6-e38cb5470c0mr1453276.1.1732128390415; Wed, 20 Nov 2024 10:46:30
 -0800 (PST)
Date: Wed, 20 Nov 2024 10:46:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241120184625.3835422-1-jstultz@google.com>
Subject: [RESEND][PATCH] locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex
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
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
Apologies for being noisy, I recognize its only been a week, but
I wanted to resend this now as the problematic commit just
landed in Linus' tree and I've not seen this get queued yet.

thanks
-john

---
 kernel/locking/rtmutex.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ac1365afcc4a..e858de203eb6 100644
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


