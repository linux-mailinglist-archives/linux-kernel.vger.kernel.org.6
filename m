Return-Path: <linux-kernel+bounces-234158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B491C2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C81F214C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADFB1C68A0;
	Fri, 28 Jun 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yi3+k1IW"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4381DFFB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589887; cv=none; b=N011zWH/3kxvqtmqhUZJByw5RWPO+soqkWla3AwoncOEjTXMsQ6+nqHrha9wfy06kQaE0gIXSoDXPrmD/lMpcdZwI8a9y77yQ/jSJm69mLnFBCvPXOo6Munz7aNY2bCwnYET81pj/zQ54jsWBUfVf9381sajXrb2GzStF8TThFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589887; c=relaxed/simple;
	bh=adoYphYFT/1Sc5QP6q0f19DG97MutxNPaEVwXibnRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1C8eTZFKZDqxX1hzZWYlFXjTv4gfcgKm7c1Op6/2vH5BIIfzDDMQZFgfg7wSzQypMG64svO4f6rlarb7mFCrQRkfF9C95hd5kRsJbcYc12iI9+Z+IBDqNRA8TEBHH7fxJTtjASg+8A9o5kxvGELkDdzzxKuvpcYPfd7l6XNHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yi3+k1IW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so8348341fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719589883; x=1720194683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=po9Xo1RKj0AfWsVZAcPUkfZIutZGZUhHOIJQi/w0PMg=;
        b=Yi3+k1IWLRekOMdHBuMI30QxdjVGtRGPZJFOdoS/GFtwQDSSUjiUHvt57vQlEOIrDy
         JNUuUxhjpi2y3KAqIujVaeeHjHx76UIKBnsF7+xBTriIQ5cbjwQjTg7iUu1yC1L+kFim
         rM+ZYZX+NkLhNsiqF+NAtFtVfT3HPYR0Nk8L4LqzWK0o39cO277qSzPyyxI5D9qUj89c
         ncKSQQuWTTOjVSG51n3A0ypNOtaVfxjKuNB/ElDNRhdl8qullT9djb8k3MkDv4y+5aCB
         yvQq7YC/4iTxrUWkwq/b1/uH5gqmtNlAxgP9CQdmpqyx6mEnv1x2fd1T63Omjs8V3LgQ
         jD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719589883; x=1720194683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po9Xo1RKj0AfWsVZAcPUkfZIutZGZUhHOIJQi/w0PMg=;
        b=s6dq8Ah4jm/rxsMpP2yoKkc8szKqyHfnCB0ZaZ9quAhyyyC/9J0bMXkljAM/7e7QDM
         qQxs6AvUhaesvj/ZN4ZeNbsyHT4AVXC2KNARRQlx1BILz1gvo714OwtdieqSStCVniPC
         xWBE2iWGbzae4F0a7/Cp96i4wmCOt6f3pedOzJbu4DuS0i8WLsq4vQVNxT1IJ81aJE5K
         Z41NGk+lxeeGoVZZEjiBz9enIYNBDaeOvPL3XSa6nEfMQkXRXR+pDfLF1uxM0X1vqSjk
         DGTjsj6FT4Ag5m3luqbTLCMyg1vzfa0YeI7UCOujqR4bO5wBgy52rMtk5zbhHDeZkdvZ
         BAHg==
X-Forwarded-Encrypted: i=1; AJvYcCVVM/KkjDo6xqS15wh53rCAn91sd9Lkpt9KsIEIudgY59guFwTAWs0fezLysRu1suMD9ID6iDGokpjgSwcitaG9GcGQkdTpYC9e06Oi
X-Gm-Message-State: AOJu0YwRmYuY8mcmixYZs04RiF2AHjcZS3qyDma+5e/vGMUSSek7htug
	/DBHnjd9wfqXy8ZarwvRMzZt3F2GOUS32yNvYaj5KRJHP8OnsnASsR5mhOORgGZtwO4JnMI5ejj
	K
X-Google-Smtp-Source: AGHT+IHgEZqwdnXYPq4aSbRwjDH2hkvEUdEEg9xS+lMgIDZtqGCFBLSgUa8RzaZbSJntCqU2D3XFWg==
X-Received: by 2002:a2e:9811:0:b0:2ec:5019:8fa5 with SMTP id 38308e7fff4ca-2ec5b388425mr96119071fa.40.1719589882943;
        Fri, 28 Jun 2024 08:51:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1fbdsm17298005ad.6.2024.06.28.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:51:22 -0700 (PDT)
Date: Fri, 28 Jun 2024 17:51:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: how to flush consoles: was: Re: [PATCH] printk:
 nbcon_atomic_flush_pending() is safe only when there is no boot console
Message-ID: <Zn7b8g1HtuTIAwyi@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-6-john.ogness@linutronix.de>
 <ZmrpxWxUb8k4swrA@pathway.suse.cz>
 <ZmrrhCf5GRUdGwh9@pathway.suse.cz>
 <8734p0yca9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734p0yca9.fsf@jogness.linutronix.de>

On Tue 2024-06-25 22:59:34, John Ogness wrote:
> On 2024-06-13, Petr Mladek <pmladek@suse.com> wrote:
> > Boot consoles are not serialized with the nbcon consoles via the nbcon
> > console context or con->device_lock(). The serialization is possible only
> > via the legacy console_lock().
> >
> > The decision whether nbcon_atomic_flush_pending() should and can be
> > called safely is similar and closely related to the decision
> > whether the legacy loop should be used.
> >
> > Define printing_via_context_safe symmetrically with printing_via_unlock.
> > Allow to call nbcon_atomic_flush_pending() only when it is needed and safe.
> 
> This patch, along with other comments you made about the many different
> checks to see when it is allowed to do what, forced me to take a step
> back and look at the big picture. Indeed, by the end of this series we
> have many boolean variables that influence decisions about how to handle
> threads and how to print.
> 
> I am thinking it makes more sense to incorporate these booleans into a
> single variable (printk_state?). The variable would only be changed
> under the console_list_lock, which could allow lockless users to
> leverage the console_srcu_read_lock for consistency.
> 
> The different orthogonal bits of the variable would be:
> 
> 
> * have_boot_console - true if a boot console is registered
> 
> * have_legacy_console - true if a non-nbcon console is registered
> 
> * have_nbcon_console - true if an nbcon console is registered
> 
> * printk_threads_allowed - true when it is OK to have threads
>   (set/cleared by notifiers, and more or less represents
>   "system_state == SYSTEM_SCHEDULING || system_state == SYSTEM_RUNNING")
> 
> * printk_threads_available - true while all printing threads are running
>   (and implies at least 1 thread is running)

I would call the variable "printk_threads_running". It seems to have
more clear meaning.

12th patch adds:

  * force_printkthread - which triggers offloading even the legacy
	into a thread. Or does it force using kthreads even in
	emergency?


> We could provide macros to interpret this multi-flag value for various
> scenarios:
> 
> #define nbcon_may_create_threads()
>   (printk_threads_allowed)

The force_printkthread involves also legacy consoles. As a result,
the "nbcon_" prefix does not look important.

> #define nbcon_may_rely_on_threads()
>   (have_nbcon_console && !have_boot_console && printk_threads_available)
> 
> #define nbcon_may_flush_atomic()
>   (have_nbcon_console && !have_boot_console)
> 
> #define nbcon_must_flush_atomic()
>   (have_nbcon_console && !have_boot_console && !printk_threads_available)
> 
> #define nbcon_must_flush_via_unlock()
>   (have_nbcon_console && have_boot_console)
> 
> #define printing_via_unlock()
>   (have_legacy_console || have_boot_console)

I like this "may" vs "must" variants.

Good names and good macros might help, definitely. But I think that
there are more problems. There are also several variants of functions
flushing the consoles. Are they are orthogonal as well:

One aspect are the console callbacks:

    + write()		# legacy consoles
    + write_atomic()    # nbcon consoles in atomic or unknown context
    + write_thread      # nbcon consoles in task context

Another aspect is the serialization:

    + console_lock()			  # legacy loop
    + con->driver_lock() + nbcon_context  # nbcon consoles in normal context
    + nbcon_context			  # nbcon consoles in emergency
					  # or panic context
Caller:

    + printk()
    + explicit flush()

Context priority:

    + normal
    + emergency
    + panic


I still have to think if we could somehow improve the situation,
for example, by using some systematic names.

Well, the conditions are more or less straightforward in most
situations with three exceptions:

   + vprintk_emit()
   + nbcon_cpu_emergency_exit()
   + nbcon_cpu_emergency_flush()

, where:

  +  The rules for the direct flush are the same in both
     nbcon_cpu_emergency_exit() and nbcon_cpu_emergency_flush().

     But only nbcon_cpu_emergency_exit() calls the trigger-offload
     part.


  +  The rules in vprintk_emit() are much more complicated
     by the special handling in:

       + NBCON_PRIO_PANIC and legacy_allow_panic_sync
       + NBCON_PRIO_EMERGENCY

IMHO, it would help to:

  + avoid code duplication in nbcon_cpu_emergency_exit()/flush()

  + make the code in vprintk_emit() as compact as possible,
    especially avoid updating "do_trylock_unlock" all over

  + make the code in vprintk_emit as similar to
    nbcon_cpu_emergency_exit()/flush() as possible.


I have tried various variants and it always became complicated.
So I decided to make the logic as compact as possible in the
following two functions:


/**
 * struct console_flush_type - Define how to flush the consoles.
 * @nbcon_atomic: Flush directly using nbcon_atomic() callback
 * @nbcon_thread: Offload the flush to the kthread
 * @legacy_direct: Call the legacy loop in this context
 * @legacy_offload: Offload the legacy loop into IRQ or kthread
 */
struct console_flush_type {
	bool	nbcon_atomic;
	bool	nbcon_thread;
	bool	legacy_direct;
	bool	legacy_offload;
};

/*
 * Decide how the messages should get flushed from printk().
 * It is supposed to be called in vprintk_emit()
 *
 * Variant per console type
 */
void printk_set_console_flush_type(struct console_flush *flush)
{
	enum nbcon_prio nbcon_prio;

	memset(flush, 0, sizeof(*flush));

	/*
	 * nbcon_get_default_prio() can be read safely even in premptible
	 * context. NBCON_PRIO_PANIC is used only on panic-CPU.
	 * NBCON_PRIO_EMERGENCY is set only in context with CPU migragtion
	 * disabled.
	 */
	nbcon_prio = nbcon_get_default_prio();

	/*
	 * Skip it in EMERGENCY priority. The console will be
	 * explicitly flushed when exiting the emergency section.
	 */
	 if (nbcon_prio == NBCON_PRIO_EMERGENCY)
			return;

	/* How to flush nbcon consoles without legacy loop. */
	if (have_nbcon_console && !have_boot_console) {
		if (nbcon_prio == NBCON_PRIO_PANIC) {
			flush->nbcon_atomic = true;

			/* In panic, the legacy consoles are not allowed
			 * to print from the printk calling context unless
			 * explicitly allowed. This gives the safe nbcon
			 * consoles a chance to print out all the panic
			 * messages first. This restriction only applies
			 * if there are nbcon consoles registered.
			 */
			if (!legacy_allow_panic_sync)
				return;

		/* Only NBCON_PRIO_NORMAL left. */
		} else if (nbcon_kthreads_running) {
			flush->nbcon_thread = true;
		} else {
			flush->nbcon_atomic = true;
		}
	}

	/* How to do the legacy loop. */
	if (have_legacy_console || have_boot_console) {
		if (nbcon_prio == NBCON_PRIO_PANIC &&
		    legacy_allow_panic_sync) {
			flush->nbcon_direct = true;

		/* Only NBCON_PRIO_NORMAL left. */
		} if (is_printk_deferred() || console_legacy_thread)) {
			flush->legacy_thread = true;
		} else {
			flush->legacy_direct = true;
		}
	}
}

/*
 * Decide how the messages should get flushed from printk().
 * It is supposed to be called in vprintk_emit()
 *
 * Variant per nbcon prio
 */
void printk_set_console_flush_type(struct console_flush *flush)
{
	enum nbcon_prio nbcon_prio;

	memset(flush, 0, sizeof(*flush));

	/*
	 * nbcon_get_default_prio() can be read safely even in premptible
	 * context. NBCON_PRIO_PANIC is used only on panic-CPU.
	 * NBCON_PRIO_EMERGENCY is set only in context with CPU migragtion
	 * disabled.
	 */
	nbcon_prio = nbcon_get_default_prio();

	switch(nbcon_prio):
	NBCON_PRIO_NORMAL:
		if (have_nbcon_console && !have_boot_console) {
			if (nbcon_kthreads_running)
				flush->nbcon_thread = true;
			else
				flush->nbcon_atomic = true;
		}

		if (have_legacy_console || have_boot_console ) {
			if (is_printk_deferred() || console_legacy_thread))
				flush->legacy_thread = true;
			else
				flush->legacy_direct = true;
		}
		break;

	NBCON_PRIO_EMERGENCY:
		/*
		 * Skip it in EMERGENCY priority. The console will be
		 * explicitly flushed when exiting the emergency section.
		 */
		 break;

	NBCON_PRIO_PANIC:
		if (have_nbcon_console && !have_boot_console) {
			flush->nbcon_atomic = true;

			/* In panic, the legacy consoles are not allowed
			 * to print from the printk calling context unless
			 * explicitly allowed. This gives the safe nbcon
			 * consoles a chance to print out all the panic
			 * messages first. This restriction only applies
			 * if there are nbcon consoles registered.
			 */
			if (!legacy_allow_panic_sync)
				break;
		}

		if ((have_legacy_console || have_boot_console) &&
			flush->nbcon_direct = true;

		break;
	default:
		WARN_ON_ONCE(1, "This should never happen\n");
	}
}

/*
 * Decide how the messages should get flushed from emergency context.
 * This is called when we really want to flush the emergency messages.
 *
 * FIXME: Emergency messages should always get flushed directly, except
 *        when it is not safe.
 */
void get_console_emergency_flush_type(struct console_flush_type *flush)
{
	enum nbcon_prio nbcon_prio = nbcon_get_default_prio();

	memset(flush, 0, sizeof(*flush));

	WARN_ON_ONCE(nbcon_prio != NBCON_PRIO_EMERGENCY);

	if (have_nbcon_console && !have_boot_console)
		flush->nbcon_atomic = true;


	if (have_legacy_console || have_boot_console) {
		/* FIXME: add force_legacy_kthread? */
		if (is_printk_deferred())
			flush->legacy_thread = true;
		} else {
			flush->legacy_direct = true;
		}
	}
}

The first function might be used in vprintk_emit as:

asmlinkage int vprintk_emit(int facility, int level,
			    const struct dev_printk_info *dev_info,
			    const char *fmt, va_list args)
{
	struct console_flush_type flush;
	bool do_trylock_unlock = !force_printkthreads() &&
				 printing_via_unlock;
	int printed_len;

	/* Suppress unimportant messages after panic happens */
	if (unlikely(suppress_printk))
		return 0;

	/*
	 * The messages on the panic CPU are the most important. If
	 * non-panic CPUs are generating any messages, they will be
	 * silently dropped.
	 */
	if (other_cpu_in_panic())
		return 0;

	if (level == LOGLEVEL_SCHED) {
		level = LOGLEVEL_DEFAULT;
		/* If called from the scheduler, we can not call up(). */
		do_trylock_unlock = false;
	}

	printk_delay(level);

	printed_len = vprintk_store(facility, level, dev_info, fmt, args);

	printk_set_console_flush_type(&flush);

	if (flush.nbcon_direct)
		nbcon_atomic_flush_pending();

	if (flush.nbcon_thread)
		nbcon_wake_threads();

	if (flush.legacy_direct) {
		/*
		 * The caller may be holding system-critical or
		 * timing-sensitive locks. Disable preemption during
		 * printing of all remaining records to all consoles so that
		 * this context can return as soon as possible. Hopefully
		 * another printk() caller will take over the printing.
		 *
		 * Also, nbcon_get_default_prio() requires migration disabled.
		 */
		preempt_disable();

		/*
		 * Try to acquire and then immediately release the console
		 * semaphore. The release will print out buffers. With the
		 * spinning variant, this context tries to take over the
		 * printing from another printing context.
		 */
		if (console_trylock_spinning())
			console_unlock();

		preempt_enable();
	}

	if (flush.legacy_thread)
		defer_console_output();
	else
		wake_up_klogd();

	return printed_len;
}
EXPORT_SYMBOL(vprintk_emit);


I do not say that this is the best solution.

My view:

1. I like the 2nd variant of printk_set_console_flush_type() where the
   code is primary split by nbcon_prio.

   And I like that the rather complicated rules are as compact as
   possible and quite clear for each scenario.


2. The situation is much easier in get_console_emergency_flush_type().

   Note that it never sets "nbcon_thread". Maybe, we could flush the
   consoles in this function. And just return whether it is needed
   to offload the legacy loop.


Best Regards,
Petr

