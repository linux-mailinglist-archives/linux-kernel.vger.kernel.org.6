Return-Path: <linux-kernel+bounces-408406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4719C7E60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA4D1F22988
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26118BB84;
	Wed, 13 Nov 2024 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5x/ozgZ"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EE15B0EF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538187; cv=none; b=hrhowzb77/AW3YR+fcpnEEHHzs4S4PmM2kP3+L6mGAxV06uhdfotVhshn37Vg0oxLa916NmR5gwuXCCoqVM0OaYKF3UWY3kAxjF7EiL4Sxh6KKlTtY+h/8YCXd+GnemlCFYZ0HA32Qmlvhq6mEjR6RNVBir+kWvcILjB1Rwos1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538187; c=relaxed/simple;
	bh=ykcg8Fef1iKHGipEC0cGCA1oJ4uYT/CtTbCPaquxCb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw8yicJYAqTMwo7fxN6Sg+0yhG87UvEG2ff+qqHivrwiyIfm/R5lwka8+9Q4XvweAvXeolGVJ9RpdyqPgbqy6CxoW4yF4uyJ6BLM/zmCM2GkBVwsjPlbOcHsvmO+RUyZgl9EQWXDILU/QUM7O+2+buNncXXz18M7MBCBwhYWGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5x/ozgZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d3736a6204so3450506d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731538185; x=1732142985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y/y0P4OqeeWZF74x2AMQJ4Ih3vxd26UzW3OzjwMKNw=;
        b=J5x/ozgZJW/lakDDfSPsHa6b7fHrYKiQ6uVLjY5UNV1ObhrQ9oBWg8pCTWgFHu9Vvy
         0PXNh7eE041a3+O0+LMfCl93KLVnphTUH7LNOQG9X4NCetstSMlR1trKeZsZ5O24B5It
         GsxnVaQmr/6H9bsrEbvzZtGsELkKXdk/PN+k75NUsst2eKzbHSHW8SoeI0RVMRgP0pL9
         nqwRdIR3icz2SuVsrIo0GcPdKWt1lHLI8rgcgtgsualO67KgDOa6yGrWBzVmfpD7H4ke
         R/cUdsEx27UCbIqJE25Sd+wutFy6TWO6qFLZ/slJ18iU3Oz2w4m4pJcUV70m28b345N5
         hGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731538185; x=1732142985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Y/y0P4OqeeWZF74x2AMQJ4Ih3vxd26UzW3OzjwMKNw=;
        b=mrg8l1e8o3XDeibw3yB4/aTse5QVFRaA5nuwqPLUxVo8W5fNHzbM5qcuI+JHkJTRqA
         icAnl4fb6jIi8uxPQPfSMZKo9vfz9OWTDbsjXQgj2Jshzc76tTiU8UYKm32F+YjpndEr
         +/TAi7d06bvCIVLYX8iQla1SODlOK6OlyNmPFbJLcsWlsiVv1TJHP0UpR/tva0WW/FLV
         mFyZ8G457xyPym9KW9iGURoH6EdZu4PT3rDoE0Q++rw1lIB44Mho8r6VUgEX9411FCpF
         /B9t9OYoi2YYhSqKz8ND9NYaDOjboo0jC2kFvRvJPVF/efGy0usYxmnDD+xGUEo5D4YJ
         /MJg==
X-Gm-Message-State: AOJu0YzzdqFKxDb43xsh9IMsuy9W90/ECBmxIinjwJik8/0yLiZU31u0
	NmMqwAxQtPYBiCGCEHwIC43cJX96dYljze4CpIcQ0CinpBMSjl2SRWXG8oiIhtxQ9bwnp30GVs3
	wC2rBsf18IwCS6VYJE1Bo4GKwTRHld7Pxca4QzA==
X-Google-Smtp-Source: AGHT+IEVBkG+Vt0df6B4aIQ1qk8n7CToRwVSEBBWWEQATjd00M09LrjqoT5DZj8Ova9jzgvmF/Hidi0/5UP8wRPD5T4=
X-Received: by 2002:a05:6214:2aab:b0:6cb:4a88:8cf5 with SMTP id
 6a1803df08f44-6d39e101afemr119742786d6.2.1731538184672; Wed, 13 Nov 2024
 14:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com> <20241113215252.3977066-1-jstultz@google.com>
In-Reply-To: <20241113215252.3977066-1-jstultz@google.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 13 Nov 2024 23:49:33 +0100
Message-ID: <CADYN=9+mRq1Z3nR42-CR8CkmS1Oq456_vfKey0QnOg9nrfZuHA@mail.gmail.com>
Subject: Re: [RFC][PATCH] locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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
	Thorsten Leemhuis <linux@leemhuis.info>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 22:53, John Stultz <jstultz@google.com> wrote:
>
> Anders had bisected a crash using PREEMPT_RT with linux-next and
> isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
> wakeups from under mutex::wait_lock"), where it seemed the
> wake_q structure was somehow getting corrupted causing a null
> pointer traversal.
>
> I was able to easily repoduce this with PREEMPT_RT and managed
> to isolate down that through various call stacks we were
> actually calling wake_up_q() twice on the same wake_q.
>
> I found that in the problematic commit, I had added the
> wake_up_q() call in task_blocks_on_rt_mutex() around
> __ww_mutex_add_waiter(), following a similar pattern in
> __mutex_lock_common().
>
> However, its just wrong. We haven't dropped the lock->wait_lock,
> so its contrary to the point of the original patch. And it
> didn't match the __mutex_lock_common() logic of re-initializing
> the wake_q after calling it midway in the stack.
>
> Looking at it now, the wake_up_q() call is incorrect and should
> just be removed. So drop the erronious logic I had added.
>
> Anders: Can you double check this resolves the issue for you?

Thank you John for looking into the issue
It booted just fine on the rockpi4 now, ontop of tag next-2024111.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Benjamin Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: kernel-team@android.com
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: regressions@lists.linux.dev
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/locking/rtmutex.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c7de80ee1f9d..a01e81179df0 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1248,10 +1248,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>
>                 /* Check whether the waiter should back out immediately */
>                 rtm = container_of(lock, struct rt_mutex, rtmutex);
> -               preempt_disable();
>                 res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
> -               wake_up_q(wake_q);
> -               preempt_enable();
>                 if (res) {
>                         raw_spin_lock(&task->pi_lock);
>                         rt_mutex_dequeue(lock, waiter);
> --
> 2.47.0.277.g8800431eea-goog
>

