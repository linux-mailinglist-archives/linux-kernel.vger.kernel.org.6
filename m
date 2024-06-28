Return-Path: <linux-kernel+bounces-233816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2791BDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7061B2336E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7415821D;
	Fri, 28 Jun 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jcx9a2VG"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D7158219
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575225; cv=none; b=L5lseKo7So2/6NK3CLmS6Ukl6CQVE2YX6DmQBIMQVfRFW8/l+Z7Qzn/LV9W00DIbX1Uw3TtZtybMgap8d5QVX6yWrL7jMBFPRgkbEZWf4ydOZ6VhQO0k7NI9JPwOlyzCklu+INLfdMS0LLUfjCXUbhzzqxnFiXakqDhwyy3iVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575225; c=relaxed/simple;
	bh=dMuI+sr6mzwDxiaRRb026zow1xs3wDKo+kVL5+Ojcxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUE9vYfwq90HCWBuaJ3g5RDroNc7Pa7B0a1iVGo5n9uzZNl7Sk29lKqj2HrQf+sa0H3bP2LaeGuqicOZ7U0P7a5uas9H3p4HmPlSg3H+1D56VN8C8/O/sy66hZ+qo6i5L3n1w3qV/NHXckbvIpJSnYmjn58CtVVCm9xQRJpvZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jcx9a2VG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec5779b423so4811321fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719575220; x=1720180020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAHg1VkP9tUqCTE3AHgnAJVWdN8CHrByRy9RBNCGkGk=;
        b=Jcx9a2VGgHexiD9xrEnuzBIbTVJTvKIrGuYQcoFkaTbqe4bhEpvcwhvH/3euAzyHbl
         SZLokX5w/RZiwJscUTZyzgeYzxstXjInN3rjjuVSgTr7c6GMRbYHU2lCHG5ZBgGsnBmv
         bus01JwRlyG25z5QjBSQJhSdZpaz8Azyri7t0+BPejhzV18j+8gmNdVvBoRzkM938OtI
         jqf1SF53fsae+DaHLzWy4EurC+LpVgoVOT/l0+PdAsNU+GVitTd4yoRvyU7ZIPF31nOP
         v50kJvjBmC0Xz+4dUSQQxQdEwe4zCGv0JUc7TyFKdUyOGj8N0UtySyS9FnPRIGvcYo6U
         aIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575220; x=1720180020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAHg1VkP9tUqCTE3AHgnAJVWdN8CHrByRy9RBNCGkGk=;
        b=pcdPAHY2iQ+OG9ghhX4BXCiXHZFBfq87z/ItPM4efe3aBUcmDBDMfR0uSBAZ6SBqvS
         1PbieyV0r++AQOPkL5B8Quxbz62aJraFVaY2dVKUHnG9+w9bYWY9vEoQo6Qr5KCAmM8G
         P5BXC7qJteQHL0uXPsYU3OCBa5jnDkJDQUxjUFtISG6hNCAtoLvH2z7MApDhJecHQhK2
         nH7OUWu0mo4qg07LJPY90QAu122biXpqvajrQuhp8i2NDO93S8q3usxHjFk5DatmmfaS
         DtCuSnlp6Xjp2DfndsFqJ8MxA4eCXXJKB8i9MJACKCIBu7s4Xh7fH1H/qwwIQXBjbFx1
         P/5w==
X-Forwarded-Encrypted: i=1; AJvYcCWxM/JZqQH2mcXxaJyzqMB4Rw931bXU1SUSvBuwTEm8f45ZCdQ7JcSxVouJaIJaYY/cJ7J5EJhkAEeWKKnAm7J/iiCw87ZSrO3SKhng
X-Gm-Message-State: AOJu0YyEWla+4lrBotKOMDgZHP04rX3g6qThuR1RFLkY5mWi1TCTx/AH
	7rmczWkVYUNJlH31twfGRh7LsSgVaj8F1Cwr6rZzFoKY5guOXVxBDO31YWirnZQ=
X-Google-Smtp-Source: AGHT+IE0xsW0T5AJ7ZSOTTVJxlHbt7P3Z4DRFeCO64J7ACcmeISazvH34Z6hgUEn09qXHXMZIeKfdA==
X-Received: by 2002:a2e:2419:0:b0:2ec:422:126 with SMTP id 38308e7fff4ca-2ec5932a567mr116256651fa.30.1719575220375;
        Fri, 28 Jun 2024 04:47:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce44d5esm1417161a91.19.2024.06.28.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:59 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:46:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
Message-ID: <Zn6iq3n2ggL138Gs@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-13-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:47, John Ogness wrote:
> The write callback of legacy consoles makes use of spinlocks.
> This is not permitted with PREEMPT_RT in atomic contexts.
> 
> For PREEMPT_RT, create a new kthread to handle printing of all
> the legacy consoles (and nbcon consoles if boot consoles are
> registered).
> 
> Since, if running from the kthread, the consoles are printing
> in a task context, the legacy nbcon printing can use the
> device_lock(), write_thread(), device_unlock() callbacks for
> printing.
> 
> Introduce the macro force_printkthreads() to query if the
> forced threading of legacy consoles is in effect.
> 
> These changes only affect CONFIG_PREEMPT_RT.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/internal.h |  11 +-
>  kernel/printk/nbcon.c    |  54 ++++++---
>  kernel/printk/printk.c   | 241 ++++++++++++++++++++++++++++++++-------
>  3 files changed, 246 insertions(+), 60 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 9e027e08918d..b66dfa865591 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -21,6 +21,12 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  		(con->flags & CON_BOOT) ? "boot" : "",		\
>  		con->name, con->index, ##__VA_ARGS__)
>  
> +#ifdef CONFIG_PREEMPT_RT
> +# define force_printkthreads()		(true)
> +#else
> +# define force_printkthreads()		(false)
> +#endif

It seems that the only purpose of this variable is to decide
whether the nbcon_legacy_kthread will be used or not.

I know that force_printkthreads() has been choosen to correlate with
force_irqthreads(). But the situation is different here. In irq, there
is only one type of kthreads (ksoftirqd). But in printk(), we
have kthreads for nbcon consoles and a special kthread for legacy
consoles.

Also the variable is used together with:

   + printing_via_unlock: boolean variable which is true when
	some console need to be flushed in the legacy loop
	under console_lock().

   + nbcon_legacy_kthread: pointer to task_struct of the kthread
	flushing the console in the legacy loop under console_lock().

   + wake_up_legacy_kthread(): function for waking up nbcon_legacy_kthread()

   + console_emit_next_record(): function emitting the message in
	the legacy loop under console_lock()


It is a crazy mismatch of names ;-) The main used terms are: legacy, unlock,
nbcon, console. From my POV, the most meaningful are: legacy and unlock.

I would suggest to rename:

   + nbcon_legacy_kthread -> printk_legacy_kthread
   + force_printkthreads -> force_legacy_kthread

or another "more legacy" names.

>  #ifdef CONFIG_PRINTK
>  
>  #ifdef CONFIG_PRINTK_CALLER
> @@ -92,9 +98,10 @@ void nbcon_free(struct console *con);
>  enum nbcon_prio nbcon_get_default_prio(void);
>  void nbcon_atomic_flush_pending(void);
>  bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> -				   int cookie);
> +				   int cookie, bool use_atomic);
>  void nbcon_kthread_create(struct console *con);
>  void nbcon_wake_threads(void);
> +void nbcon_legacy_kthread_create(void);

It is about legacy consoles. It is even implemented in printk.c.
I would call it:

     + legacy_kthread_create()
     + create_legacy_kthread()

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1232,6 +1233,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>   *		both the console_lock and the SRCU read lock. Otherwise it
>   *		is set to false.
>   * @cookie:	The cookie from the SRCU read lock.
> + * @use_atomic:	True if the write_atomic() callback is to be used

I would prefer to use a "hint style". Something like:

 * @use_atomic:	Set true when called in an atomic or unknown context.
 *		It affects which callback will be used: write_atomic()
 *		wrt. write_thread().
 *
 *		When false, the write_thread() callback would be called
 *		in a preemtible context unless disabled by the device_lock().
 *		The handover won't be allowed in this mode.

>   * Context:	Any context except NMI.
>   * Return:	True, when a record has been printed and there are still
> @@ -1247,26 +1249,38 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>   * Essentially it is the nbcon version of console_emit_next_record().
>   */

>  bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> -				   int cookie)
> +				   int cookie, bool use_atomic)
>  {
>  	struct nbcon_write_context wctxt = { };
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
>  	unsigned long flags;
>  	bool progress;
>  
> -	/* Use the same procedure as console_emit_next_record(). */
> -	printk_safe_enter_irqsave(flags);
> -	console_lock_spinning_enable();
> -	stop_critical_timings();
> +	ctxt->console = con;
>  
> -	ctxt->console	= con;
> -	ctxt->prio	= nbcon_get_default_prio();
> +	if (use_atomic) {
> +		/* Use the same procedure as console_emit_next_record(). */

I would extend it a bit:

		/*
		 * In an atomic or unknown context, use the same procedure as in
		 * console_emit_next_record(). It allows to handower...
		 */

> +		printk_safe_enter_irqsave(flags);
> +		console_lock_spinning_enable();
> +		stop_critical_timings();
>  
> -	progress = nbcon_atomic_emit_one(&wctxt);
> +		ctxt->prio = nbcon_get_default_prio();
> +		progress = nbcon_emit_one(&wctxt, use_atomic);
>  
> -	start_critical_timings();
> -	*handover = console_lock_spinning_disable_and_check(cookie);
> -	printk_safe_exit_irqrestore(flags);
> +		start_critical_timings();
> +		*handover = console_lock_spinning_disable_and_check(cookie);
> +		printk_safe_exit_irqrestore(flags);
> +	} else {

I would add a comment:

		/*
		 * In process context, use the same procedure as in
		 * nbcon_kthread_func(). It might allow scheduling
		 * depending on the devive_lock()...
		 */

> +		*handover = false;
> +
> +		con->device_lock(con, &flags);
> +		cant_migrate();
> +
> +		ctxt->prio = nbcon_get_default_prio();
> +		progress = nbcon_emit_one(&wctxt, use_atomic);

This is repeated in both branches.

> +		con->device_unlock(con, flags);
> +	}


I do not have strong opinion. But I slightly more like the variant
where we do not repeat the common functions. It is easier to see
the difference of the context in which nbcon_emit_one() is called.

	if (use_atomic) {
		/*
		 * In an atomic or unknown context, use the same procedure as in
		 * console_emit_next_record(). It allows to handower...
		 */
		printk_safe_enter_irqsave(flags);
		console_lock_spinning_enable();
		stop_critical_timings();
	} else {
		/*
		 * In process context, use the same procedure as in
		 * nbcon_kthread_func(). It might allow scheduling
		 * depending on the devive_lock()...
		 */
		con->device_lock(con, &flags);
		cant_migrate();
	}

	ctxt->prio = nbcon_get_default_prio();
	progress = nbcon_emit_one(&wctxt, use_atomic);

	if (use_atomic) {
		start_critical_timings();
		*handover = console_lock_spinning_disable_and_check(cookie);
		printk_safe_exit_irqrestore(flags);
	} else {
		con->device_unlock(con, flags);
		*handover = false;
	}

>  	return progress;
>  }
> @@ -1494,7 +1508,9 @@ void nbcon_cpu_emergency_exit(void)
>  		 * to handle it.
>  		 */
>  		do_trigger_flush = true;
> -		if (printing_via_unlock && !is_printk_deferred()) {
> +		if (!force_printkthreads() &&

Is this correct? We still need to flush the messages directly
when the legacy kthread is not ready yet.

We should check !nbcon_legacy_kthread instead.


> +		    printing_via_unlock &&
> +		    !is_printk_deferred()) {
>  			if (console_trylock()) {
>  				do_trigger_flush = false;
>  				console_unlock();
> @@ -1530,7 +1546,9 @@ void nbcon_cpu_emergency_flush(void)
>  
>  	nbcon_atomic_flush_pending();
>  
> -	if (printing_via_unlock && !is_printk_deferred()) {
> +	if (!force_printkthreads() &&

Same here. It should rather be !nbcon_legacy_kthread.

> +	    printing_via_unlock &&
> +	    !is_printk_deferred()) {
>  		if (console_trylock())
>  			console_unlock();

The same tricky pattern is repeated in

    + vprintk_emit()
    + nbcon_cpu_emergency_exit()
    + nbcon_cpu_emergency_flush()

With each new condition, it is more and more complicated to see
if all the locations do the right thing.

It would be nice to somehow refactor this or create some
helper scripts. I would do it even at the cost that
some checks will be repeated.

It is already being discussed in the thread about 5th patch,
see https://lore.kernel.org/r/8734p0yca9.fsf@jogness.linutronix.de
Let's continue there.

>  	}
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index cf0d612329bf..1c63fd0c1166 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2345,7 +2348,8 @@ asmlinkage int vprintk_emit(int facility, int level,
>  			    const struct dev_printk_info *dev_info,
>  			    const char *fmt, va_list args)
>  {
> -	bool do_trylock_unlock = printing_via_unlock;
> +	bool do_trylock_unlock = !force_printkthreads() &&

s/force_printkthreads/nbcon_legacy_kthread/  ???


> +				 printing_via_unlock;
>  	int printed_len;
>  
>  	/* Suppress unimportant messages after panic happens */
> @@ -2740,7 +2756,9 @@ void resume_console(void)
>   */
>  static int console_cpu_notify(unsigned int cpu)
>  {
> -	if (!cpuhp_tasks_frozen && printing_via_unlock) {
> +	if (!force_printkthreads() &&

s/force_printkthreads/nbcon_legacy_kthread/  ???

> +	    !cpuhp_tasks_frozen &&
> +	    printing_via_unlock) {
>  		/* If trylock fails, someone else is doing the printing */
>  		if (console_trylock())
>  			console_unlock();
> @@ -3000,31 +3018,43 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		con->dropped = 0;
>  	}
>  
> -	/*
> -	 * While actively printing out messages, if another printk()
> -	 * were to occur on another CPU, it may wait for this one to
> -	 * finish. This task can not be preempted if there is a
> -	 * waiter waiting to take over.
> -	 *
> -	 * Interrupts are disabled because the hand over to a waiter
> -	 * must not be interrupted until the hand over is completed
> -	 * (@console_waiter is cleared).
> -	 */
> -	printk_safe_enter_irqsave(flags);
> -	console_lock_spinning_enable();
> +	/* Write everything out to the hardware. */
>  
> -	/* Do not trace print latency. */
> -	stop_critical_timings();
> +	if (force_printkthreads()) {

s/force_printkthreads/nbcon_legacy_kthread/  ???

> +		/*
> +		 * With forced threading this function is either in a thread
> +		 * or panic context. So there is no need for concern about
> +		 * printk reentrance or handovers.
> +		 */

The comment describes why it is "safe". But it does not describe the
motivation.

If I get it correctly, the motivation is to call con->write() with interrupts
and preemption enabled. We should document it so that people won't
break it in the future.

Another question is how it is guaranteed. OK, it is called only from
console_flush_all(). But it is called also from get_init_console_seq()
aka from register_console(). I guess that it is OK because it is
a well known and preemptible context. But it is not clear from
the comment.

> -	/* Write everything out to the hardware. */
> -	con->write(con, outbuf, pmsg.outbuf_len);
> +		con->write(con, outbuf, pmsg.outbuf_len);
> +		con->seq = pmsg.seq + 1;
> +	} else {
> +		/*
> +		 * While actively printing out messages, if another printk()
> +		 * were to occur on another CPU, it may wait for this one to
> +		 * finish. This task can not be preempted if there is a
> +		 * waiter waiting to take over.
> +		 *
> +		 * Interrupts are disabled because the hand over to a waiter
> +		 * must not be interrupted until the hand over is completed
> +		 * (@console_waiter is cleared).
> +		 */
> +		printk_safe_enter_irqsave(flags);
> +		console_lock_spinning_enable();
>  
> -	start_critical_timings();
> +		/* Do not trace print latency. */
> +		stop_critical_timings();
>  
> -	con->seq = pmsg.seq + 1;
> +		con->write(con, outbuf, pmsg.outbuf_len);
>  
> -	*handover = console_lock_spinning_disable_and_check(cookie);
> -	printk_safe_exit_irqrestore(flags);
> +		start_critical_timings();
> +
> +		con->seq = pmsg.seq + 1;
> +
> +		*handover = console_lock_spinning_disable_and_check(cookie);
> +		printk_safe_exit_irqrestore(flags);
> +	}
>  skip:
>  	return true;
>  }
> @@ -3188,6 +3207,32 @@ void console_unlock(void)
>  		 */
>  	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
>  }
> +
> +/**
> + * console_unlock - unblock the console subsystem from printing
> + *
> + * Releases the console_lock which the caller holds to block printing of
> + * the console subsystem.
> + *
> + * While the console_lock was held, console output may have been buffered
> + * by printk().  If this is the case, console_unlock(); emits
> + * the output prior to releasing the lock.
> + *
> + * console_unlock(); may be called from any context.
> + */
> +void console_unlock(void)
> +{
> +	/*
> +	 * Forced threading relies on kthread and atomic consoles for
> +	 * printing. It never attempts to print from console_unlock().
> +	 */
> +	if (force_printkthreads()) {

s/force_printkthreads/nbcon_legacy_kthread/  ???

> +		__console_unlock();
> +		return;
> +	}
> +
> +	console_flush_and_unlock();
> +}
>  EXPORT_SYMBOL(console_unlock);
>  
>  /**
> @@ -3411,12 +3456,107 @@ void console_start(struct console *console)
>  	flags = console_srcu_read_flags(console);
>  	if (flags & CON_NBCON)
>  		nbcon_kthread_wake(console);
> +	else
> +		wake_up_legacy_kthread();
>  	console_srcu_read_unlock(cookie);
>  
>  	__pr_flush(console, 1000, true);
>  }
>  EXPORT_SYMBOL(console_start);
>  
> +#ifdef CONFIG_PRINTK
> +static bool printer_should_wake(void)

I would call it printk_legacy_kthread_should_wakeup()
to make it consistent with

     + printk_legacy_kthread		# proposed above
     + nbcon_kthread_should_wakeup()

> +{
> +	bool available = false;

Nit: I would use "bool ret = false".

     The word "available" is not much helpful because it is not
     immediately obvious what is available. It might be console,
     kthread, or pending record. One has to read the code and
     "available" is not cscope-friendly ;-)
 

> +	struct console *con;
> +	int cookie;
> +
> +	if (kthread_should_stop())
> +		return true;
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		short flags = console_srcu_read_flags(con);
> +		u64 printk_seq;
> +
> +		/*
> +		 * The legacy printer thread is only for legacy consoles,
> +		 * unless the nbcon console has no kthread printer.
> +		 */
> +		if ((flags & CON_NBCON) && con->kthread)
> +			continue;
> +
> +		if (!console_is_usable(con, flags, false))
> +			continue;
> +
> +		if (flags & CON_NBCON) {
> +			printk_seq = nbcon_seq_read(con);
> +		} else {
> +			/*
> +			 * It is safe to read @seq because only this
> +			 * thread context updates @seq.
> +			 */
> +			printk_seq = con->seq;
> +		}
> +
> +		if (prb_read_valid(prb, printk_seq, NULL)) {
> +			available = true;
> +			break;
> +		}
> +	}
> +	console_srcu_read_unlock(cookie);
> +
> +	return available;
> +}
> +
> +void nbcon_legacy_kthread_create(void)
> +{
> +	struct task_struct *kt;
> +
> +	lockdep_assert_held(&console_mutex);
> +
> +	if (!force_printkthreads())
> +		return;
> +
> +	if (!printk_threads_enabled || nbcon_legacy_kthread)
> +		return;
> +
> +	kt = kthread_run(nbcon_legacy_kthread_func, NULL, "pr/legacy");
> +	if (IS_ERR(kt)) {
> +		pr_err("unable to start legacy printing thread\n");
> +		return;

Is this acceptable for RT, please?

> +	}
> +
> +	nbcon_legacy_kthread = kt;
> +
> +	/*
> +	 * It is important that console printing threads are scheduled
> +	 * shortly after a printk call and with generous runtime budgets.
> +	 */
> +	sched_set_normal(nbcon_legacy_kthread, -20);
> +}
> +#endif /* CONFIG_PRINTK */
> +
>  static int __read_mostly keep_bootcon;
>  
>  static int __init keep_bootcon_setup(char *str)
> @@ -3706,6 +3846,7 @@ void register_console(struct console *newcon)
>  	} else {
>  		have_legacy_console = true;
>  		newcon->seq = init_seq;
> +		nbcon_legacy_kthread_create();

I would prefer to do:

		if (force_printkthread)
			nbcon_legacy_kthread_create();

to make it clear that we start it only when explicitly requested.

>  	}
>  
>  	if (newcon->flags & CON_BOOT)
> @@ -4146,9 +4298,16 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>  	int pending = this_cpu_xchg(printk_pending, 0);
>  
>  	if (pending & PRINTK_PENDING_OUTPUT) {
> -		/* If trylock fails, someone else is doing the printing */
> -		if (console_trylock())
> -			console_unlock();
> +		if (force_printkthreads()) {

s/force_printkthreads/nbcon_legacy_kthread/  ???

> +			wake_up_legacy_kthread();
> +		} else {
> +			/*
> +			 * If trylock fails, some other context
> +			 * will do the printing.
> +			 */
> +			if (console_trylock())
> +				console_unlock();
> +		}
>  	}
>  
>  	if (pending & PRINTK_PENDING_WAKEUP)

Best Regards,
Petr

