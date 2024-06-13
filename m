Return-Path: <linux-kernel+bounces-213495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3D907610
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D00FB21253
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75C148FFC;
	Thu, 13 Jun 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eS/7T7ZF"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7C63E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291320; cv=none; b=X7ALdI4SgmlMCcZOXfQ+oWhIFoi3YxQ6+2/GMlBDCIojcbRV5UnPmVDG1EoYmKVf0yXE4/RrEVikP1WKyQ2bv1b5OGH19E7+JUocvvLA3wCMAcwsYFut58YYOnEDQIF0tIXO4xFvcCO8+uMwfmN8uAa2HMgCBZ3eMCO5xFCvyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291320; c=relaxed/simple;
	bh=8+SD0tmxrwIoBocw+dtGIM1lVxuUxUwF/jG3/D/i598=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6+OIyJkWIF8xjzZxMDSIc4EoL2g76kZwkVbMNPuRTflyWT2oD7OVa3vTNpw8/AVA5jJwezeiYFEcAvcrATxv5XST0x9Gx3ykk/4KNIo3ANwgkL2QYx2qdHmS4LdVsgzeYwOjl6f4GMuDTx2kXtPfot80SHwQ6dILqYqU8WS3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eS/7T7ZF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so586337a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718291317; x=1718896117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhID+k8XeeSr/DPRlvKbgj/P3D1KVK4o924CydGnlPU=;
        b=eS/7T7ZFxP8X2vFAbH67JOyT5M2yYwaSo1w2oJZRX5wGHD70xi6+3wlD1mNVkcGa+w
         6xc+VRS+ecqln1mG3mGaOxeRtok9d5BBYgDv2J9jj8WFAovlNl4eSZjRKn7qNz8JHnZC
         ezRQBuwmjLWZ2Kr56pvdbif6wbE5fpSNVHwb3HJxUaGHVANgW4h+bxxeEG0RhgiVqPqk
         gqyn8CNYsqA9n7UKg2mrxftOmr98N6C6uY15iLqL8Vo6YGtGc63GQ+rq7ha6Ljfl4HdJ
         8jU3Bw9CJubgOYnKgg0JynSDlcyLBfTUBPAxK+il1okYYeqhy2NLlXoTRuCZMFeLFAC7
         4aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291317; x=1718896117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhID+k8XeeSr/DPRlvKbgj/P3D1KVK4o924CydGnlPU=;
        b=ii5E3fuUnQi00G/e4tr7nVni0qFXhurIIxNiBM6yONgtglfKiYSj+0AfPk28ML2q+D
         +KEfv3PHbUWUCy2FQGCt5RuFWDzefUpAtY51TmgaXjMueBgv1dZoEF0ism/8j8bQ/7ZJ
         Q+dZE3T6aOts/2sM3yUvKAqW/ltl9dhHmUBq53jTZPam1bPP+XqPogmxReIOcOelBYx0
         XvATvE5r1Epb2+pVR35lLABVHn2EJV5A3VkxTozAgIFMnUq5cKe+jssjlhaRJukL0OE4
         i+FCQRLSSzuhGZJQkWej8hgP/NaCTi7RLruTVGtv9keaZyhikBfxrSK/CF7WcyUc6D+x
         ud8w==
X-Forwarded-Encrypted: i=1; AJvYcCWksrQEOFu1NEKbN8KIpWGl82iDrwmFgWXYc1lNZz25lO21O54demf//Z+S3lTQA6eK5a7+tDsLkZfWjsvaxTz7Mtx42TRYxucG+A9d
X-Gm-Message-State: AOJu0YwYbTa8xSsXkr4kMTvNYhKEdbH/RUDdF6yIJVSwl0lwI2RNpgGW
	qMZ5Hx19QICh9/sOTeO211QxxGZgaxRdYjaDvJyNXWJaqpD5KZpan/ToO191Pgw=
X-Google-Smtp-Source: AGHT+IEhmDqD8mRpqWA2r1Yjc9ekY4U/B7wvSAb/seXq+ZuAyGV/URFJqmu5cSnK3NKaMJK6VeKgTQ==
X-Received: by 2002:a50:cd0e:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57cbd68487bmr81891a12.15.1718291316203;
        Thu, 13 Jun 2024 08:08:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce2b3sm1015574a12.14.2024.06.13.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:08:36 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:08:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v2 07/18] printk: nbcon: Add printer thread wakeups
Message-ID: <ZmsLcu2tHmCfLiu0@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-8-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:42, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add a function to wakeup the printer threads. The printer threads
> are woken when:
> 
>   - a record is added to the printk ringbuffer
>   - consoles are resumed
>   - triggered via printk_trigger_flush()
>   - consoles should be replayed via sysrq
> 
> The actual waking is performed via irq_work so that the function
> can be called from any context.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1058,6 +1058,61 @@ static int nbcon_kthread_func(void *__console)
>  	goto wait_for_event;
>  }
>  
> +/**
> + * nbcon_irq_work - irq work to wake printk thread
> + * @irq_work:	The irq work to operate on
> + */
> +static void nbcon_irq_work(struct irq_work *irq_work)
> +{
> +	struct console *con = container_of(irq_work, struct console, irq_work);
> +
> +	nbcon_kthread_wake(con);
> +}
> +
> +static inline bool rcuwait_has_sleeper(struct rcuwait *w)
> +{
> +	bool has_sleeper;
> +
> +	rcu_read_lock();
> +	/*
> +	 * Guarantee any new records can be seen by tasks preparing to wait
> +	 * before this context checks if the rcuwait is empty.
> +	 *
> +	 * This full memory barrier pairs with the full memory barrier within
> +	 * set_current_state() of ___rcuwait_wait_event(), which is called
> +	 * after prepare_to_rcuwait() adds the waiter but before it has
> +	 * checked the wait condition.
> +	 *
> +	 * This pairs with nbcon_kthread_func:A.
> +	 */
> +	smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
> +	has_sleeper = !!rcu_dereference(w->task);

We should use the existing API rcuwait_active().

> +	rcu_read_unlock();
> +
> +	return has_sleeper;
> +}
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2402,6 +2402,8 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		}
>  	}
>  
> +	nbcon_wake_threads();

This need to be called only when there is a nbcon console
and no boot console and it has not been flushed explicitly.

I think that we could move this slightly above:

	if (have_nbcon_console && !have_boot_console) {
[...]
		if (is_panic_context ||
		    !printk_threads_enabled ||
		    (system_state > SYSTEM_RUNNING)) {
			nbcon_atomic_flush_pending();
		} else {
			nbcon_wake_threads();
		}
	}

> +
>  	if (do_trylock_unlock) {
>  		/*
>  		 * The caller may be holding system-critical or
> @@ -2708,6 +2710,10 @@ void resume_console(void)
>  	 */
>  	synchronize_srcu(&console_srcu);
>  
> +	/*
> +	 * Since this runs in task context, wake the threaded printers
> +	 * directly rather than scheduling irq_work to do it.
> +	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(con) {
>  		flags = console_srcu_read_flags(con);

The wake up call has already been added in 4th patch of this patchset.

I would slightly prefer to move it from the 4th patch to this one.
Same with start_console(). But it is not super important.


> @@ -4178,6 +4184,7 @@ void defer_console_output(void)
>  
>  void printk_trigger_flush(void)
>  {
> +	nbcon_wake_threads();

IMHO, this is not needed. vprintk_emit() always either flushes nbcon
consoles directly or wakes them.

In each case, it is not needed when printk_trigger_flush() is called
from nbcon_cpu_emergency_exit().

Hmm, I am not sure about the situation in nmi_trigger_cpumask_backtrace().
printk_trigger_flush() is called there to queue the IRQ work yet
another CPU to be on the safe side. But the irq_work used by
nbcon is per-console (not per-CPU). I guess that an attempt to
queue it on 2nd CPU would be a NOP.

>  	defer_console_output();
>  }
>  
> @@ -4513,6 +4520,7 @@ void console_try_replay_all(void)
>  {
>  	if (console_trylock()) {
>  		__console_rewind_all();
> +		nbcon_wake_threads();
>  		/* Consoles are flushed as part of console_unlock(). */
>  		console_unlock();
>  	}

Just an idea. We probably could do better for nbcon consoles. Like try
to flush them directly with emergency prio. But it can be done
in a separate patch later.

Best Regards,
Petr

