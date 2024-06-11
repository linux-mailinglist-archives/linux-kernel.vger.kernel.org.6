Return-Path: <linux-kernel+bounces-210093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A5903F34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB0284C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FB125A9;
	Tue, 11 Jun 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QQZQ3Py+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8822334
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117468; cv=none; b=J3OaB78d72cV+9YJ59gYD+QM3Hf/tpzNWNI4ld4rnKbD+Gqvoc1ZGSnnKvg6eb30kTbRrH8/vbuuCvwxnNKeYifp9hRrehiNIgKeReCS3hDQB0c9wjMsoSb1FhhnTdDdSBX8dC6ZYhSeQuusaFs/XxdzCP0zxeCHAJlzI03n1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117468; c=relaxed/simple;
	bh=F7Q0rS0PPHhP4Y0YTO89il1ubaX2w6vF2F9Os/k45Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYrOhwX+5RK5cinAgqlHBRIbbTinXKbWmdPcyXr6a2jO6bOTWYVZp1v0OmPV/Sh1qD2cnMCvIHAamqxRSCHc15m5nE2Mj5hzo7hqJF9N1Ivee31MPshqZvW+97Q+v62pcYn9u56c8851wD8a/KeedN5AKhHW2TXXjrZVEuGiosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QQZQ3Py+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so2986994a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718117463; x=1718722263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4nxGWp24Ia/SZBCnhtzaq3vVRa6cViAPMhBDWU7p6U=;
        b=QQZQ3Py+WAumJTsTzLRn6FY0H5CeHqNvPkd/i3ynNYKlA167gkv3obH27gKDtgBHmi
         h/fV+ldHWnbqZETDETMEiotEBQVrb8TfVxcWcR+f0suYby5iPqXar/baqdUW4d6BstFa
         kyvJngiFqiJSv8GR0gX7RwgprNEtRB+H7QDdl14Mkn08k9+T3apqV/mhghx+3dmH096E
         9BPTM6mTahdUWYxXatFQHWNuug+YIjlnyLpxVAaKtmEgiyx9jG/dgbc9fd/Q5XioX5e9
         Hx9W3HUbAZFLRsPFc64iNxFsrgL7td1U/VItni4p2R5+dQ0IYy0zbd6LL0yGg6v26bBo
         +pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117463; x=1718722263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4nxGWp24Ia/SZBCnhtzaq3vVRa6cViAPMhBDWU7p6U=;
        b=HAT5TM8Lg7fICcZ2t1806CuCnCaElYFOhqlNWPlZWNODV0S5xVKsH7nGKugi15tzio
         1F56UAJGCXyJhJBoAX7sICP3D2sekxo+Yl/VzWNuHq1VlT7e6r0dCL5Z11FpDUkI5U8s
         rkVu4j7heZ9cgrHtiOeqM67VKH7h55fJOGxQmzIqzaRiqGle4+lossPsmQE7I1F73RVa
         S6jdW8SSiwbaU+Q81NbmwpKQtvxQ23L5oHdBrMrBccrgAXHw7AbReQboz8MlCHZPN12X
         YmxYISJN4sXVhr5s4ybFptVc+8WFJ6WISfj7IiAIeFtAxXnslmDXfmah+ZGw+kvFQoTY
         V8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWPaErtPg4pcmu0HsPKcqY+Jy+izoOe3bgvf2ZwoHTzUBIkURaKHsYxGO7zQV3F/Dov2Fdo0rjZSUV8+dd07AEBlDuqtrncLcmFhO+O
X-Gm-Message-State: AOJu0YySgmIzLYZCH4jnTkQ8TgOkdf4bZieVA2mTkiIvF7MgUHn4Ukvr
	4oT9KmxYklkzpLEI8P5dOPeUp6yA9L3RLk1DPsfhobR4RiG28PakGQagaaBkQ/fmT7GCHu/aX0e
	k
X-Google-Smtp-Source: AGHT+IGRPRcdqL9d8xoLXmXXZAVrplQ2boFrtr0plOlXKGEPtLzVmKGtODhy2Ndc3rrEjpRL7tZCvg==
X-Received: by 2002:a50:ccc8:0:b0:57c:7628:97d7 with SMTP id 4fb4d7f45d1cf-57c76289e85mr5353005a12.3.1718117463074;
        Tue, 11 Jun 2024 07:51:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c960e677asm1070785a12.62.2024.06.11.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:51:02 -0700 (PDT)
Date: Tue, 11 Jun 2024 16:51:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing
 kthreads
Message-ID: <ZmhkVAC_3FMohrEr@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
 <87ed95j8yh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed95j8yh.fsf@jogness.linutronix.de>

On Mon 2024-06-10 14:15:10, John Ogness wrote:
> On 2024-06-07, Petr Mladek <pmladek@suse.com> wrote:
> > I updated this commit message in parallel with commenting the related
> > code changes. My later comment might explain the motivation for
> > writing the commit message this way.
> 
> I am OK with your proposed commit message. Thank you for taking the time
> to fill in all the details.

We should probably update it a bit so that it describes the role
of the device_lock() more precisely. See the discussion below.
> > <proposal>
> 
> [...]
> 
> > The write context in the kthread will stay safe only when either of
> > the following conditions are true:
> >
> >   1. The kthread is the only context which acquires the console
> >      with NBCON_PRIO_NORMAL.
> >
> >   2. Other caller acquires the console context with NBCON_PRIO_NORMAL
> >      under the device_lock.
> >
> >   3. Other caller acquires the console context with NBCON_PRIO_NORMAL
> >      with disabled preemption. It will release the context before
> >      rescheduling.
> >
> > It is even double guaranteed. First, __nbcon_atomic_flush_pending_con()
> > is called:
> >
> >   + with disabled interrupts from nbcon_atomic_flush_pending_con()
> >   + under device_lock() from nbcon_device_release()
> 
> [...]
> 
> > </proposal>
> >
> > BTW: It really looks like the safety is double guaranteed. Maybe
> >      the con->device_lock() is not needed in nbcon_kthread_func()
> >      after all. Well, I would keep it to be on the safe side.
> 
> For the threaded case it is technically correct to say the safety is
> double guaranteed. But the outer safety (device_lock()) can provide a
> preemptible lock, which is the key for the non-interference property of
> the threaded printers.
> 
> For example, for an nbcon framebuffer console, device_lock() most likely
> will be a mutex.
> 
> During normal operation, the inner safety (console context) will never
> be contended. That really only exists to synchronize the atomic case.

I see. For example, the spin_lock_irqsave() in __uart_port_lock_irqsave()
will be sleeping lock in RT => preserving RT guarantees. And it will
make sure that the inner nbcon_context_try_acquire() would never
have to spin => never break the RT guarantees.

It makes perfect sense. Do I get it correctly?

> >> --- a/include/linux/console.h
> >> +++ b/include/linux/console.h
> >> @@ -373,6 +376,27 @@ struct console {
> >>  	 */
> >>  	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
> >>  
> >> +	/**
> >> +	 * @write_thread:
> >> +	 *
> >> +	 * NBCON callback to write out text in task context.
> >> +	 *
> >> +	 * This callback is called after device_lock() and with the nbcon
> >> +	 * console acquired. Any necessary driver synchronization should have
> >> +	 * been performed by the device_lock() callback.
> >> +	 *
> >> +	 * This callback is always called from task context but with migration
> >> +	 * disabled.
> >> +	 *
> >> +	 * The same criteria for console ownership verification and unsafe
> >> +	 * sections applies as with write_atomic(). The difference between
> >> +	 * this callback and write_atomic() is that this callback is used
> >> +	 * during normal operation and is always called from task context.
> >> +	 * This allows drivers to operate in their own locking context for
> >> +	 * synchronizing output to the hardware.
> >> +	 */
> >
> > The description is not bad. It seems to include all the important
> > information. Except than I still needed to scratch my head around it
> > to understand the real purpose and rules.
> >
> > Namely, the following sentences are kind of vague and bring questions
> > which I had in the past before I understood all the relations:
> >
> >    1. "Any necessary driver synchronization should have been performed
> >        by the device_lock() callback."
> >
> >        Q: Why do we need to take both device_lock() and the context then?
> 
> The device_lock() enables the non-interference property during normal
> operation. OTOH the context is taken to synchronize against non-normal
> (emergency/panic) operation.
> 
> >        Q: Why the acquired context is not enough?
> 
> Because the context _requires_ disabling preemption during all driver
> activity, which is a major source of interference to the system.
> 
> If you only care about UART drivers and !PREEMPT_RT, then there really
> is not much difference between spinning on a spinlock vs. spinning on a
> context. But for non-UART drivers or PREEMPT_RT, there is a huge
> difference between blocking on device_lock() with preemption enabled vs.
> spinning on a context.

This helped a lot. My brain is not trained to see these RT-specific
effects.


> I think it really helps to see the importance if you assume
> device_lock() is a mutex. (All the printk code must also make this
> assumption.)

From my POV, the game changer is the RT aspect. I knew that
for graphics console drivers the mutex was a nice-to-have thing.
I did not realize that for RT it was a must-to-have thing.

I mean, I did not realize that nbcon_console_try_acquire() was
not RT friendly. We could also say that nbcon_console_try_acquire()
is not acceptable for RT as the primary synchronization primitive.

> > I wonder if we could be more strigthforward.
> >
> > <my-take>
> > 	/**
> > 	 * @write_thread:
> > 	 *
> > 	 * NBCON callback to write out text in task context.
> > 	 *
> > 	 * This callback must be called only in task context with both
> > 	 * device_lock() and the nbcon console acquired.
> > 	 *
> > 	 * The same rules for console ownership verification and unsafe
> > 	 * sections handling applies as with write_atomic().
> > 	 *
> > 	 * The console ownership handling is necessary for synchronization
> > 	 * against write_atomic() which is synchronized only via the context.
> > 	 *
> > 	 * The device_lock() serializes acquiring the console context
> > 	 * with NBCON_PRIO_NORMAL. It is necessary when the device_lock()
> > 	 * does not disable preemption. The console context locking is
> > 	 * not able to detect a race in the following scenario:
> > 	 *
> > 	 *    1. [Task A] owns a context with NBCON_PRIO_NORMAL on [CPU X]
> > 	 *	 and is scheduled.
> > 	 *
> > 	 *    2. Another context takes over the lock with NBCON_PRIO_EMERGENCY
> > 	 *	 and releases it.
> > 	 *
> > 	 *    3. [Task B] acquires a context with NBCON_PRIO_NORMAL on [CPU X]
> > 	 *	 and is scheduled.
> > 	 *
> > 	 *    4. [Task A] gets running on [CPU X] and see that the console is
> > 	 *	 is still owned by a task on [CPU X] with NBON_PRIO_NORMAL.
> > 	 *	 It can't detect that it is actually owned by another task.
> > 	 */
> > </my-take>
> >
> > My variant describes the purpose of device_lock() quite different way.
> > But I think that this is the real purpose and we must be clear about
> > it.
> 
> I would move that last part (starting with "The device_lock()
> serializes...") into the kerneldoc for device_lock(). It really has
> nothing to do with the write_thread() callback.

I agree that describing the details of the race is not important here.

Well, I would still like to describe the role of device_lock()
for write_kthread(). It would help even me to create a better
mental model ;-)

What about the following?

<proposal-2>
	/**
	 * @write_thread:
	 *
	 * NBCON callback to write out text in task context.
	 *
	 * This callback must be called only in task context with both
	 * device_lock() and the nbcon console acquired with
	 * NBCON_PRIO_NORMAL.
	 *
	 * The same rules for console ownership verification and unsafe
	 * sections handling applies as with write_atomic().
	 *
	 * The console ownership handling is necessary for synchronization
	 * against write_atomic() which is synchronized only via the context.
	 *
	 * The device_lock() provides the primary serialization for operations
	 * on the device. It might be as relaxed (mutex)[*] or as tight
	 * (disabled preemption and interrupts) as needed. It allows
	 * the kthread to operate in the least restrictive mode[**].
	 *
	 * [*] Standalone nbcon_context_try_acquire() is not safe with
	 *     the preemption enabled, see nbcon_owner_matches(). But it
	 *     can be safe when always called in the preemptive context
	 *     under the device_lock().
	 *
	 * [**] The device_lock() makes sure that nbcon_context_try_acquire()
	 *      would never need to spin which is important especially with
	 *      PREEMPT_RT.
	 */
</proposal-2>


> > Sigh, I was not able to describe the race reasonably a shorter
> > way. Maybe, we should move this detailed explanation above,
> > nbcon_context_try_acquire() and use just a reference here.
> 
> How about putting it as kerneldoc for nbcon_owner_matches() and refer to
> it there from the device_lock() kerneldoc (or vice versa)?

Yup. nbcon_owner_matches() looks like the right place for details
about the possible race.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3995,6 +3995,8 @@ static int unregister_console_locked(struct console *console)
>  	if (res > 0)
>  		return 0;
>  
> +	__pr_flush(console, 1000, true);
> +
>  	/* Disable it unconditionally */
>  	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);

Makes sense.

And it actually means that it is too late to flush messages
when kthread_should_stop() returns true. So, it does not matter if
we check it in the while(backlog) loop or not. Well, it might be
worth a comment in the code.

> >> +	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
> >> +	if (IS_ERR(kt)) {
> >> +		con_printk(KERN_ERR, con, "failed to start printing thread\n");
> >> +		return;
> >
> > I am a bit surprised that we ignore the error here.
> >
> >
> > Hmm, it likely works in this patch because the legacy code would still
> > flush the console when con->thread is not assigned.
> >
> > But it would stop working later when the legacy loop is disabled
> > by the global @printk_threads_enabled variable.
> 
> The thread failing to start is a serious issue. Particularly for
> PREEMPT_RT.

I agree.

> Probably it should be something like:
> 
> 	if (WARN_ON(IS_ERR(kt))) {

Might make sense.

> In fact, I nbcon_atomic_flush_pending_con() and nbcon_device_release()
> need to check @printk_threads_enabled _instead_ of con->kthread. Once
> "threading mode" has been activated, there should be _no_ atomic
> printing during normal operation.

OK, we have two possibilities when a kthread could not get started:

1. printk() could fallback to flushing messages via write_atomic()
   in the legacy console_unlock() loop.

   It might break RT guarantees but people would see the messages.


2. The affected console would flush the messages only in emergency
   or panic mode.

   This would preserve RT guarantees. And printk() would still be
   able to show emergency and panic messages, including the WARN_ON()
   about that the printk kthread did not start.


It seems that you prefer the 2nd variant. But you are RT-biased ;-)
I would personally prefer the 1st variant. But I am printk-biased ;-)

Honestly, if the system is not able to start the kthread then
it is probably useless anyway. I would prefer if printk keeps working
so that people know what is going on ;-)

> > The kthread is running and started processing messages at this moment.
> > But con->kthread is not set yet.
> 
> [...]
> 
> > It might be worth a comment.
> >
> > <proposal>
> > 	/*
> > 	 * Some users check con->kthread to decide whether to flush
> > 	 * the messages directly using con->write_atomic(). Note that
> > 	 * possible races with the kthread are double prevented.
> > 	 *
> > 	 * First, the users ignore this console until it is added into
> > 	 * @console_list which is done under con->device_lock().
> > 	 * Second, the calls would be additionaly serialized by acquiring
> > 	 * the console context.
> > 	 */
> > </proposal>
> 
> It is enough to mention only the calling context. How about:
> 
> 	/*
> 	 * Some users check con->kthread to decide whether to flush the
> 	 * messages directly using con->write_atomic(). A possible race
> 	 * with the kthread is prevented because all printing is
> 	 * serialized by acquiring the console context.
> 	 */

I am not sure what is more important. In fact, all these users
check con->kthread only when the console is on @console_list.
So, maybe the note about #console_list is more useful.

BTW: uart_port_lock() allows access to the device and it acquires
the context only when the console appears on @console_list.
Well, the access is serialized by the device_lock.

> >> +	con->kthread = kt;

After all, I would add two comments, like these:

<proposal-2>
	/*
	 * Any access to the console device is serialized either by
	 * device_lock() or console context or both.
	 */
	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
[...]

	/*
	 * Some users check con->kthread to decide whether to flush
	 * the messages directly using con->write_atomic(). But they
	 * do so only when the console is already in @console_list.
	 */
	 con->kthread = kt;
</proposal-2>

Best Regards,
Petr

