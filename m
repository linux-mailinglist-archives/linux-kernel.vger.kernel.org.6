Return-Path: <linux-kernel+bounces-408360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B341D9C7DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3E7B23F03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FCF18BC27;
	Wed, 13 Nov 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRCdWD30"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84817DFE9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534796; cv=none; b=Z43AbE4oAlUHaVSWewTbdYKTr+PYwAVtz5u6mCETBO5i2rschFVKzwyGZ91aov5/vDRJ4xgONiWMQRIv8FfYgCJpw0yaPyBgNzg/NIwkQzUG9OOZREUMLptxpXfmH+V+wNuPNdgFaNVFEK+X0Z0KCSZkqzCBcP7JUHh9q3eccDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534796; c=relaxed/simple;
	bh=1gtqBmv4LOxMysWSZDSqwya86Iy9JPs6MnvG18orsBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dfSezMZceb2wUxspW89u+9MU7c1xTVLJ6M/I0i3fsb4btaEpR2KLZKwYQDuPhhOm2FW5mfVZh3bWwmz/q2yo/JJB646l5AOHnVvdFhxvl+hhI8qzKlnWhvr8kQTey0WmAjXAddfE6FhLBxJ52fyI7co0QwPtAi3afAOLmgR4tUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRCdWD30; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee3fc5a13fso1705537b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731534793; x=1732139593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSiOK79AMI80lLclvOXgM+NOOU+LKK3bCsUwnEym3Jk=;
        b=oRCdWD30pIUlhDRqboAlsoqVo+jHPEX/np8GRjWIg3s5TwRk3w+CMce+HtfFpYu4Ze
         eNePkHvOwWZgZkSjayRWp1j+4HifLTsHIBW05fvzyiMWAmEc5kJTbGJl0VRQSTZPN135
         3Vzs7mYqOt+pWv1i7U4qDUk/MsNOxBY/PomcL98RlpANeeAK0X3f81tJmqI7FVBppKdT
         udNMhy9jKEDIwFTQzWDqgoOXWFt6EC7gzrzxDEXLk3byKFI+WnLd7RE8Qh2NxwxicKbn
         rY3Lhk9afC0h9gwCloIbIL9xApre6t+mQ4T8WPu2Kjo3gxoUwmHAwZwTQVVLW+OfLh6u
         l/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731534793; x=1732139593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSiOK79AMI80lLclvOXgM+NOOU+LKK3bCsUwnEym3Jk=;
        b=kXnQDGuEpPKFgOwrbNIfbcoesnHFXsGtkAmGI8wGYu+6bpSPkimcaJaZB/bC7ABPlL
         yu+OPdyll8xJ9D17QIG7TC0VsWJDaE8iDGrpkP/j90rub2O0q00ZWq6DGyZpn2mEWh5C
         Kr8GsmrT8tOKE4U0VRy+eLhnacel1DwD7KNVztcv0oS35acNO9ZTAxk5iT5nA2l56vHl
         zudKLj+/1O7DNww9DSKOALapaDZChoB48P15WxSvdHr2EThI0rsaOcUzPpy442hrchDN
         L9FFripDMpr4snsxrEXXzV0k+0ZL2edioYLStWO+6R70qylyZOWf4UKxJbmvoF1+Y6iU
         FJog==
X-Gm-Message-State: AOJu0YzKI7nmG5zFkpLvKbPeyVnmMweldRtbdXhOIiDo7kq/EJ8Rpm7b
	ye6ohySSxKqHAh7Fon7XzvdhCvl423Pot6qfeC37o3efmRgapITbJ6RRuf8qKlDPFAAX8fmLHq4
	th1QnpEPl3mITpnD5yze06h+MN3dnQaRB5xyMVZrVk2DCeZCIsfc7Qlnd+xlQpbX23qyTNr1Ey4
	M4VwEdOmiqSwx+LBMvObBbrwkO3jV4TWVnekPY3waksheq
X-Google-Smtp-Source: AGHT+IEiL+1a+AvbhcU4zjlTxQUvqr6xSQeOV+iycviPCkZHmampjj5X3owY8NfbwqMfrB9efBAxwLkq292Q
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:4c0e:b0:6d9:d865:46c7 with SMTP
 id 00721157ae682-6ee3d478c34mr327147b3.2.1731534793297; Wed, 13 Nov 2024
 13:53:13 -0800 (PST)
Date: Wed, 13 Nov 2024 13:52:29 -0800
In-Reply-To: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113215252.3977066-1-jstultz@google.com>
Subject: [RFC][PATCH] locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex
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

Anders: Can you double check this resolves the issue for you?

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
Link: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
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
2.47.0.277.g8800431eea-goog


