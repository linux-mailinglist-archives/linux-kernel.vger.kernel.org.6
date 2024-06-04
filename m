Return-Path: <linux-kernel+bounces-200711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54C8FB3DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9DC1C22B16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD0146D54;
	Tue,  4 Jun 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="D6aoEnmK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016A1E49B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508025; cv=none; b=OSKZx6JtTJOJvxWzqaCug6xEuSsx8UHcQbJDkYuOVM3xo5qezRlm49URZ47qhWnFmpQ3YB9+BSVHUY3crkiph3keTHQyOghuJJpZkyxWGyFKxfIaoIyUW1IHhpIe+CXK9d1jWvI2wG3K4lx5KTjjFvyNlGgXMmzd8KW6scKCf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508025; c=relaxed/simple;
	bh=zJH0UtzfETZVb2KsaT+tnyz16tbFpzqegge602kJ/cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+cFG3vcxt63/667dWySUrxG0QTiyuyAdLU4+8CNs6+ZQwI+PicDbcRtZ4oDyFWihuRxYESkx0KlzJOt9neIy9w+AglofWB3iZJGaLL3wLTvN3aIcNHKjuuud+UfLkGci0pWm2Y3QeORaTvfXh1flcrgvAFqLRW5s48qKQmF11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=D6aoEnmK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1200699e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717508022; x=1718112822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv7PY4Q+nsAuoSfxXLoNbj+FkNR2QAoSIleRCtRFtRs=;
        b=D6aoEnmKWGNxu4Riit20yM4+cfGdESqpHpc05rkUUYm0CLLTuLKMI5p0nP4MFR4lCq
         SXOu6tNvjQ9KaryVyodF+0nl2I1MiNfyf0PWuneWqqt1aUvPwF025Ov6yza0hPFyVVBm
         kpHBp1z+z8/DYQMQdiJ3KOih3vV3H7XAEaVSpeWDdmBqDwG3nj11SixbAuEwg1BBpBdw
         g8Z0plvs0yM6GZfE2fJtN6ghDLlRKTClj122QNzwSo6yPiDTbIUwB41OQ9L0su52q/30
         O29hwfovV0gaETy5zAQVTekMd4LI8EMgpKxgIjB8b8/kSRyqq3i8EkJongZm7oFeruF+
         XnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508022; x=1718112822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv7PY4Q+nsAuoSfxXLoNbj+FkNR2QAoSIleRCtRFtRs=;
        b=r2LEKlIRK+7eee/KMow3b1HBeQ0d8jrNV/jfN6nd7z4Z1Q5dDMqpHFPpQWeQ18T627
         u2yJz25Rv/CCK7TRnCsOaTKO5zMx7ufoAxAi4DH9nEdDTZdtbQ2OK6xVYZskHP2GI+Pl
         UFNIq6+Qhx/x78vDW+cGMIoJArtlNaSUuWNhSzxPPi5yrvqL2XRMYtU9JQiZy5fqYv7Z
         wIPPm5pOD3qkN6feVVe5+XNC2P6QP0x9lBl+MhN9YQ2/zP5VPd5dEjzJ/899c7BTRdc5
         rM+XhF9A0rBkb4KON35eXBwRozEZ/c9vfKRXT0iCacupYbp9VYC4/pm3dxyBGxSpmxvQ
         1o1w==
X-Gm-Message-State: AOJu0YwMcYSOgScZ1Dgc+wTvRFfRr2wDD7mtFDW9mrVjXpscBGtbKKM9
	Ak7u4S4CssUncq5pN96Vjx0Q9JQoe21QvStX7RjNME8GFX7T1XQk547GL+YfPFI=
X-Google-Smtp-Source: AGHT+IE8V9Y1lJMbipRt+27dNuX+Ak/Qqzeac6WCkMpuLLnrEetyYXrK/dgnHQITSw4yaFfZBNRjdw==
X-Received: by 2002:a05:6512:2508:b0:52b:840d:c5c8 with SMTP id 2adb3069b0e04-52b89576bd8mr8959339e87.15.1717508021502;
        Tue, 04 Jun 2024 06:33:41 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca434sm11609626f8f.30.2024.06.04.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:33:40 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:33:38 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v10 2/7] locking/mutex: Make mutex::wait_lock irq safe
Message-ID: <20240604133338.gvkswrn3um5jp5wm@airbuntu>
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507045450.895430-3-jstultz@google.com>

On 05/06/24 21:54, John Stultz wrote:
> From: Juri Lelli <juri.lelli@redhat.com>
> 
> mutex::wait_lock might be nested under rq->lock.
> 
> Make it irq safe then.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Metin Kaya <metin.kaya@arm.com>
> Reviewed-by: Metin Kaya <metin.kaya@arm.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v3:
> * Re-added this patch after it was dropped in v2 which
>   caused lockdep warnings to trip.
> v7:
> * Fix function definition for PREEMPT_RT case, as pointed out
>   by Metin Kaya.
> * Fix incorrect flags handling in PREEMPT_RT case as found by
>   Metin Kaya
> ---
>  kernel/locking/mutex.c    | 18 ++++++++++--------
>  kernel/locking/ww_mutex.h | 22 +++++++++++-----------
>  2 files changed, 21 insertions(+), 19 deletions(-)

Are locking folks okay with patches 1 and 2? Is there any concern/side effect
not to pick them up? It'd be nice if they can get merged and soaked in
linux-next. Reducing the amount of patches to help this series make progress
would be appreciated - if there are no major concerns of course. Some feedback
would be very helpful either way.


Thanks!

--
Qais Yousef

> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 4269da1f3ef5..6d843a0978a5 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -578,6 +578,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	DEFINE_WAKE_Q(wake_q);
>  	struct mutex_waiter waiter;
>  	struct ww_mutex *ww;
> +	unsigned long flags;
>  	int ret;
>  
>  	if (!use_ww_ctx)
> @@ -620,7 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  		return 0;
>  	}
>  
> -	raw_spin_lock(&lock->wait_lock);
> +	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	/*
>  	 * After waiting to acquire the wait_lock, try again.
>  	 */
> @@ -681,7 +682,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  				goto err;
>  		}
>  
> -		raw_spin_unlock(&lock->wait_lock);
> +		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  		/* Make sure we do wakeups before calling schedule */
>  		if (!wake_q_empty(&wake_q)) {
>  			wake_up_q(&wake_q);
> @@ -707,9 +708,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  			trace_contention_begin(lock, LCB_F_MUTEX);
>  		}
>  
> -		raw_spin_lock(&lock->wait_lock);
> +		raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	}
> -	raw_spin_lock(&lock->wait_lock);
> +	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  acquired:
>  	__set_current_state(TASK_RUNNING);
>  
> @@ -735,7 +736,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	if (ww_ctx)
>  		ww_mutex_lock_acquired(ww, ww_ctx);
>  
> -	raw_spin_unlock(&lock->wait_lock);
> +	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  	wake_up_q(&wake_q);
>  	preempt_enable();
>  	return 0;
> @@ -745,7 +746,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	__mutex_remove_waiter(lock, &waiter);
>  err_early_kill:
>  	trace_contention_end(lock, ret);
> -	raw_spin_unlock(&lock->wait_lock);
> +	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  	debug_mutex_free_waiter(&waiter);
>  	mutex_release(&lock->dep_map, ip);
>  	wake_up_q(&wake_q);
> @@ -916,6 +917,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  	struct task_struct *next = NULL;
>  	DEFINE_WAKE_Q(wake_q);
>  	unsigned long owner;
> +	unsigned long flags;
>  
>  	mutex_release(&lock->dep_map, ip);
>  
> @@ -942,7 +944,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  		}
>  	}
>  
> -	raw_spin_lock(&lock->wait_lock);
> +	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	debug_mutex_unlock(lock);
>  	if (!list_empty(&lock->wait_list)) {
>  		/* get the first entry from the wait-list: */
> @@ -960,7 +962,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  		__mutex_handoff(lock, next);
>  
>  	preempt_disable();
> -	raw_spin_unlock(&lock->wait_lock);
> +	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  	wake_up_q(&wake_q);
>  	preempt_enable();
>  }
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index 7189c6631d90..9facc0ddfdd3 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -70,14 +70,14 @@ __ww_mutex_has_waiters(struct mutex *lock)
>  	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
>  }
>  
> -static inline void lock_wait_lock(struct mutex *lock)
> +static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
>  {
> -	raw_spin_lock(&lock->wait_lock);
> +	raw_spin_lock_irqsave(&lock->wait_lock, *flags);
>  }
>  
> -static inline void unlock_wait_lock(struct mutex *lock)
> +static inline void unlock_wait_lock(struct mutex *lock, unsigned long *flags)
>  {
> -	raw_spin_unlock(&lock->wait_lock);
> +	raw_spin_unlock_irqrestore(&lock->wait_lock, *flags);
>  }
>  
>  static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
> @@ -144,14 +144,14 @@ __ww_mutex_has_waiters(struct rt_mutex *lock)
>  	return rt_mutex_has_waiters(&lock->rtmutex);
>  }
>  
> -static inline void lock_wait_lock(struct rt_mutex *lock)
> +static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
>  {
> -	raw_spin_lock(&lock->rtmutex.wait_lock);
> +	raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
>  }
>  
> -static inline void unlock_wait_lock(struct rt_mutex *lock)
> +static inline void unlock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
>  {
> -	raw_spin_unlock(&lock->rtmutex.wait_lock);
> +	raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, *flags);
>  }
>  
>  static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
> @@ -380,6 +380,7 @@ static __always_inline void
>  ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>  {
>  	DEFINE_WAKE_Q(wake_q);
> +	unsigned long flags;
>  
>  	ww_mutex_lock_acquired(lock, ctx);
>  
> @@ -408,10 +409,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>  	 * Uh oh, we raced in fastpath, check if any of the waiters need to
>  	 * die or wound us.
>  	 */
> -	lock_wait_lock(&lock->base);
> +	lock_wait_lock(&lock->base, &flags);
>  	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
> -	unlock_wait_lock(&lock->base);
> -
> +	unlock_wait_lock(&lock->base, &flags);
>  	wake_up_q(&wake_q);
>  }
>  
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

