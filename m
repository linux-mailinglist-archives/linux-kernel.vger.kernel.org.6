Return-Path: <linux-kernel+bounces-206115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592B7900470
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B854BB22303
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6851193099;
	Fri,  7 Jun 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMH2qaUP"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EB1422C6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766241; cv=none; b=X5FLf3aHzxABhZV1tP1fDmz1xaOF+/KCJA8wngqOrgWa6/4z+DiR/9ZiMv863mn00rHQK3gDT3m7smrkGzxzsmUrM5inq51W2TcexjQYva6sB0p0/cBXmSTPHxyJTsHFl8vavCYnoSok9gl4FVYk3Mmnv4NcP06MJKgD8au2pFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766241; c=relaxed/simple;
	bh=AxplxJmdBLYgjy3Woj+EVrRMrpxD3INTc7J7DUe4dV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La4S+A0fK4Zon4I7GYVdlj2Wa4teZ9cFImJhUwFfCA+6dNTJGYRuQnxDjHMzE2xF3negdljpEfLhaFu2hzlkj0k5CLiD3+QS3OQ4KovRby5zH41nJSgme0HKwr+MplszouGCcoF/RBwG+p2tfTl9xc9cRJK/T/QtTO8xXlwaCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMH2qaUP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso30539151fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717766237; x=1718371037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k736Z77/OqDRTJagbsFHe899CRZb3AtQugzZUzREFbU=;
        b=DMH2qaUP4TOznWLlgBic8hj0IvcvvCg+VbaP7+4zrW6yXfSXVTD1tSdDwaPgtleVo8
         0IRGOhhRFtk/SJQlTGS1c3vYmeacpRHstHDiCxRVWz2u+uZshLXeNNJVPnhfYn98yN+d
         E48abL0PH6G7RDyk+iYJds8DFyZ0p3CyEKlUaK8Jm7DSIrIsACM0Q09faWOrQ3rT1z2D
         9BoC6u7YZPGnl3I3/T7T2T01elywbULNL/JyR3PZ3wD6tQiYgfJ2qL93KElkgXPQZfuR
         JtCiyMCJOZPfR67DeWnIWs52PtxOL2RNZ8cYt8uz4PH4/+gC73Yzop6k98Qqcg/AwR/x
         3bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766237; x=1718371037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k736Z77/OqDRTJagbsFHe899CRZb3AtQugzZUzREFbU=;
        b=NOMPWk9wzIgjWfhS8EgLPC2I9M/Ewmv6ClrmYgS3nergwIa/f9MPtpCPLA9TP6oomW
         gZYnZPaEOTkuo3FW7Fq0RQXBvDlmLjkOuwQIf8JzCRyWoBM6XvZ5uzTFq5xSs6UXGcSA
         umWZST8sId+meOlWhf1yJoEw+N9lDzOHM44azoQAFjklm62bU2IMG/r2tFwIJnn2hJdC
         teZI9h9brDquhXdt781M4fST0/0ueDDA8/36zrbDaRDeCagtrghduXqNw5wa77HVHoj9
         hPM6alO2HuZtdkwe9FR15DTgF2nXLyUbnygSZZ0U9/KKMQtRiMGe4Uqn+cI0PfjWSkSL
         V3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUdkJuPA7F3ZJFbbPR7XFTaj+wOkdBwFxdOk+b0vzWRECeWLh5fwE3+K6BNyyh2AtIpOqUww1SXpgegcCKfbiYdghZId0SH5uzktCMT
X-Gm-Message-State: AOJu0Yy2hLdYnNa+PxkXm5vEi05hGBIaE5hh3HVd8kiRfwSlpQ3P5vuW
	Wl7Xbmw7+3mdwmtjrdTh4emGLVwO0rh+Af+l9CpcR5IE38g62uaK1H2jdLrFwPk=
X-Google-Smtp-Source: AGHT+IElZohoxe7YmzXwQTUAQYRMMoc0vTobSIf8Cy6cJ65NJhLSEcUsq8jCyDe9IXndZndk4TmnOw==
X-Received: by 2002:a2e:82c4:0:b0:2ea:938f:a239 with SMTP id 38308e7fff4ca-2eadce3779bmr17135571fa.29.1717766236484;
        Fri, 07 Jun 2024 06:17:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7cce9dsm33914935ad.129.2024.06.07.06.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:17:16 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:17:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing
 kthreads
Message-ID: <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-5-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:39, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide the main implementation for running a printer kthread
> per nbcon console that is takeover/handover aware.

The changes done by this patch deserve a more detailed commit message ;-)

I updated this commit message in parallel with commenting the related
code changes. My later comment might explain the motivation for
writing the commit message this way.

<proposal>
Provide the main implementation for running a printer kthread per
nbcon console that is takeover/handover aware.

Once the kthread is running and available, it gets responsible for
flushing any pending messages which were added in NBCON_PRIO_NORMAL
context. Namely the legacy console_flush_all() and device_release()
do not longer flush the console. And nbcon_atomic_flush_pending()
used by nbcon_cpu_emergency_exit() does not longer flush messages
added after the emergency ones.

The kthread uses a new write_thread() callback with both device_lock()
and acquired the console context.

The console ownership handling is necessary for synchronization against
write_atomic() which is synchronized only via the console context
ownership.

The device_lock() serializes acquiring the console context with
NBCON_PRIO_NORMAL. It is needed when the device_lock() does not
disable preemption. It prevents the following race:

CPU0				CPU1

 [ task A ]

 nbcon_context_try_acquire()
   # success with NORMAL prio
   # .unsafe == false;  // safe for takeover

 [ schedule: task A -> B ]


				WARN_ON()
				  nbcon_atomic_flush_pending()
				    nbcon_context_try_acquire()
				      # success with EMERGENCY prio

				      # flushing
				      nbcon_context_release()

				      # HERE: con->nbcon_state is free
				      #       to take by anyone !!!


 nbcon_context_try_acquire()
   # success with NORMAL prio [ task B ]

 [ schedule: task B -> A ]

 nbcon_enter_unsafe()
   nbcon_context_can_proceed()

BUG: nbcon_context_can_proceed() returns "true" because
     the console is owned by a context on CPU0 with
     NBCON_PRIO_NORMAL.

     But it should return "false". The console is owned
     by a context from task B and we do the check
     in a context from task A.

The write context in the kthread will stay safe only when either of
the following conditions are true:

  1. The kthread is the only context which acquires the console
     with NBCON_PRIO_NORMAL.

  2. Other caller acquires the console context with NBCON_PRIO_NORMAL
     under the device_lock.

  3. Other caller acquires the console context with NBCON_PRIO_NORMAL
     with disabled preemption. It will release the context before
     rescheduling.

It is even double guaranteed. First, __nbcon_atomic_flush_pending_con()
is called:

  + with disabled interrupts from nbcon_atomic_flush_pending_con()
  + under device_lock() from nbcon_device_release()

Second, they are not longer called with NBCON_PRIO_NORMAL when
con->kthread exists.

Also note that the kthreads are running with nice -20 so that they are
scheduled shortly after a printk call and with generous runtime
budgets.

This patch provides just the basic functionality. The followup changes
will add the necessary integration, for example, creating the kthreads
at the right time or waking them when a new message appear.
</proposal>

BTW: It really looks like the safety is double guaranteed. Maybe
     the con->device_lock() is not needed in nbcon_kthread_func()
     after all. Well, I would keep it to be on the safe side.

> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -373,6 +376,27 @@ struct console {
>  	 */
>  	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
>  
> +	/**
> +	 * @write_thread:
> +	 *
> +	 * NBCON callback to write out text in task context.
> +	 *
> +	 * This callback is called after device_lock() and with the nbcon
> +	 * console acquired. Any necessary driver synchronization should have
> +	 * been performed by the device_lock() callback.
> +	 *
> +	 * This callback is always called from task context but with migration
> +	 * disabled.
> +	 *
> +	 * The same criteria for console ownership verification and unsafe
> +	 * sections applies as with write_atomic(). The difference between
> +	 * this callback and write_atomic() is that this callback is used
> +	 * during normal operation and is always called from task context.
> +	 * This allows drivers to operate in their own locking context for
> +	 * synchronizing output to the hardware.
> +	 */

The description is not bad. It seems to include all the important
information. Except than I still needed to scratch my head around it
to understand the real purpose and rules.

Namely, the following sentences are kind of vague and bring questions
which I had in the past before I understood all the relations:

   1. "Any necessary driver synchronization should have been performed
       by the device_lock() callback."

       Q: Why do we need to take both device_lock() and the context then?
       Q: Why the acquired context is not enough?

   2. "This allows drivers to operate in their own locking context for
       synchronizing output to the hardware."

       Q: What exactly does this sentence mean?
       Q: What is the driver?
       Q: What are the output callbacks?
       Q: How exactly is this related to write_atomic() and write_thread()?
       Q: Is the context more strict or relaxed, in which way?

Also I still keep in my mind that nbcon_context_try_acquire() is not
safe with NBCON_NORMAL_PRIO with enabled preemption. There is
the race discussed in the previous patchset, see
https://lore.kernel.org/r/ZiD3FNBZh_iMOVWY@pathway.suse.cz

I wonder if we could be more strigthforward.

<my-take>
	/**
	 * @write_thread:
	 *
	 * NBCON callback to write out text in task context.
	 *
	 * This callback must be called only in task context with both
	 * device_lock() and the nbcon console acquired.
	 *
	 * The same rules for console ownership verification and unsafe
	 * sections handling applies as with write_atomic().
	 *
	 * The console ownership handling is necessary for synchronization
	 * against write_atomic() which is synchronized only via the context.
	 *
	 * The device_lock() serializes acquiring the console context
	 * with NBCON_PRIO_NORMAL. It is necessary when the device_lock()
	 * does not disable preemption. The console context locking is
	 * not able to detect a race in the following scenario:
	 *
	 *    1. [Task A] owns a context with NBCON_PRIO_NORMAL on [CPU X]
	 *	 and is scheduled.
	 *
	 *    2. Another context takes over the lock with NBCON_PRIO_EMERGENCY
	 *	 and releases it.
	 *
	 *    3. [Task B] acquires a context with NBCON_PRIO_NORMAL on [CPU X]
	 *	 and is scheduled.
	 *
	 *    4. [Task A] gets running on [CPU X] and see that the console is
	 *	 is still owned by a task on [CPU X] with NBON_PRIO_NORMAL.
	 *	 It can't detect that it is actually owned by another task.
	 */
</my-take>

My variant describes the purpose of device_lock() quite different way.
But I think that this is the real purpose and we must be clear about
it.

Sigh, I was not able to describe the race reasonably a shorter
way. Maybe, we should move this detailed explanation above,
nbcon_context_try_acquire() and use just a reference here.

> +	void (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
> +
>  	/**
>  	 * @device_lock:
>  	 *
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -936,6 +944,120 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	return nbcon_context_exit_unsafe(ctxt);
>  }
>  
> +/**
> + * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
> + * @con:	Console to operate on
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + *
> + * Return:	True if the thread should shutdown or if the console is
> + *		allowed to print and a record is available. False otherwise.
> + *
> + * After the thread wakes up, it must first check if it should shutdown before
> + * attempting any printing.
> + */
> +static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
> +{
> +	bool ret = false;
> +	short flags;
> +	int cookie;
> +
> +	if (kthread_should_stop())
> +		return true;
> +
> +	cookie = console_srcu_read_lock();
> +
> +	flags = console_srcu_read_flags(con);
> +	if (console_is_usable(con, flags)) {
> +		/* Bring the sequence in @ctxt up to date */
> +		ctxt->seq = nbcon_seq_read(con);
> +
> +		ret = prb_read_valid(prb, ctxt->seq, NULL);
> +	}
> +
> +	console_srcu_read_unlock(cookie);
> +	return ret;
> +}
> +
> +/**
> + * nbcon_kthread_func - The printer thread function
> + * @__console:	Console to operate on
> + *
> + * Return:	0
> + */
> +static int nbcon_kthread_func(void *__console)
> +{
> +	struct console *con = __console;
> +	struct nbcon_write_context wctxt = {
> +		.ctxt.console	= con,
> +		.ctxt.prio	= NBCON_PRIO_NORMAL,
> +	};
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +	short con_flags;
> +	bool backlog;
> +	int cookie;
> +	int ret;
> +
> +wait_for_event:
> +	/*
> +	 * Guarantee this task is visible on the rcuwait before
> +	 * checking the wake condition.
> +	 *
> +	 * The full memory barrier within set_current_state() of
> +	 * ___rcuwait_wait_event() pairs with the full memory
> +	 * barrier within rcuwait_has_sleeper().
> +	 *
> +	 * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
> +	 */
> +	ret = rcuwait_wait_event(&con->rcuwait,
> +				 nbcon_kthread_should_wakeup(con, ctxt),
> +				 TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
> +
> +	if (kthread_should_stop())
> +		return 0;
> +
> +	/* Wait was interrupted by a spurious signal, go back to sleep. */
> +	if (ret)
> +		goto wait_for_event;
> +
> +	do {
> +		backlog = false;
> +

I am not sure how obvious is that we take the lock around the entire
operation. In principle, the console could not disappear. So it might
look like it is not really necessary. But it actually plays important
role when stopping/suspending the console. I would add a comment:

		/*
		 * Keep the read lock around the entire operation so that
		 * synchronize_srcu() could prove that the kthread stopped
		 * or suspended printing.
		 */

> +		cookie = console_srcu_read_lock();
> +
> +		con_flags = console_srcu_read_flags(con);
> +
> +		if (console_is_usable(con, con_flags)) {
> +			unsigned long lock_flags;
> +
> +			con->device_lock(con, &lock_flags);
> +
> +			/*
> +			 * Ensure this stays on the CPU to make handover and
> +			 * takeover possible.
> +			 */
> +			cant_migrate();
> +
> +			if (nbcon_context_try_acquire(ctxt)) {
> +				/*
> +				 * If the emit fails, this context is no
> +				 * longer the owner.
> +				 */
> +				if (nbcon_emit_next_record(&wctxt, false)) {
> +					nbcon_context_release(ctxt);
> +					backlog = ctxt->backlog;
> +				}
> +			}
> +
> +			con->device_unlock(con, lock_flags);
> +		}
> +
> +		console_srcu_read_unlock(cookie);
> +
> +	} while (backlog);

Thinking loudly:

We do not check kthread_should_stop() in the cycle. It means that it
would flush all messages before stopping the kthread. But only
when it is already in the cycle. It would not flush the messages
in the following scenario:

CPU0					CPU1

printk("Unregistering console\n");
  nbcon_wake_threads();
     irq_work_queue(&con->irq_work);

kthread_stop(con->thread);

					nbcon_kthread_func()
					  rcuwait_wait_event()
					    nbcon_kthread_should_wakeup()

					  if (kthread_should_stop())
					    // true
					    return 0

Result: The kthread did not flush the pending messages in this case.

I do not have strong opinion. Well, it would make sense to flush
all messages before stopping the kthread,

Maybe, we should move kthread_should_stop() check here.

Maybe, we should move the flushing cycle into a separate function
and the kthread might look like:

	do {
		rcuwait_wait_event(&con->rcuwait,
				   nbcon_kthread_should_wakeup(con, ctxt),
				   TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */

		nbcon_kthread_flush();
	while (!kthread_should_stop);

Note that I did not add the check for the spurious signal. It looks
just like an optimization. IMHO, it is not worth the code churn.
Also the spurious signal does not mean that there are no
pending messages. And if we want to flush everything before exiting...

Anyway, we probably should document the (desired) behavior in the function
description.

> +
> +	goto wait_for_event;
> +}
> +
>  /* Track the nbcon emergency nesting per CPU. */
>  static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
>  static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
> @@ -1332,6 +1454,63 @@ void nbcon_cpu_emergency_flush(void)
>  	}
>  }
>  
> +/*
> + * nbcon_kthread_stop - Stop a printer thread
> + * @con:	Console to operate on
> + */
> +static void nbcon_kthread_stop(struct console *con)
> +{
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (!con->kthread)
> +		return;
> +
> +	kthread_stop(con->kthread);
> +	con->kthread = NULL;
> +}
> +
> +/**
> + * nbcon_kthread_create - Create a printer thread
> + * @con:	Console to operate on
> + *
> + * If it fails, let the console proceed. The atomic part might
> + * be usable and useful.
> + */
> +void nbcon_kthread_create(struct console *con)
> +{
> +	struct task_struct *kt;
> +
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (!(con->flags & CON_NBCON) || !con->write_thread)
> +		return;
> +
> +	if (con->kthread)
> +		return;
> +
> +	/*
> +	 * Printer threads cannot be started as long as any boot console is
> +	 * registered because there is no way to synchronize the hardware
> +	 * registers between boot console code and regular console code.
> +	 */
> +	if (have_boot_console)
> +		return;
> +
> +	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
> +	if (IS_ERR(kt)) {
> +		con_printk(KERN_ERR, con, "failed to start printing thread\n");
> +		return;

I am a bit surprised that we ignore the error here.

Hmm, it likely works in this patch because the legacy code would still
flush the console when con->thread is not assigned.

But it would stop working later when the legacy loop is disabled
by the global @printk_threads_enabled variable.


> +	}
> +

Thinking loudly:

The kthread is running and started processing messages at this moment.
But con->kthraed is not set yet.

All this is done under @console_list_lock. It only guarantees that
the struct console would not disappear while some code access it under
console_srcu_read_lock().

The value is used in console_flush_all() and in nbcon_device_release()
to decide whether to flush the console directly or not.

I first though that console_flush_all() and nbcon_device_release()
could flush the messages using write_atomic() in parallel with
the kthread and it might create the race with NBCON_PRIO_NORMAL
context ownership.

But both calls will ignore this console until it is added into
@console_list which is done later under con->device_lock().

Not to say that:

  + console_flush_all() acquires the nbcon context with interrupts
    disabled => race prevented

  + nbcon_device_release() acquires the nbcon context under device
    lock => serialized with the kthread

So we are on the safe side (double guaranteed). Well, it took me quite
some time to realize this. It might be worth a comment.

<proposal>
	/*
	 * Some users check con->kthread to decide whether to flush
	 * the messages directly using con->write_atomic(). Note that
	 * possible races with the kthread are double prevented.
	 *
	 * First, the users ignore this console until it is added into
	 * @console_list which is done under con->device_lock().
	 * Second, the calls would be additionaly serialized by acquiring
	 * the console context.
	 */
</proposal>
> +	con->kthread = kt;
> +
> +	/*
> +	 * It is important that console printing threads are scheduled
> +	 * shortly after a printk call and with generous runtime budgets.
> +	 */
> +	sched_set_normal(con->kthread, -20);

I would prefer to move this into a separate patch. I feel that it
might be kind of controversial and subject to a change in the future.
We should not hide this "tiny" detail in this mega patch ;-)

That said, the low "nice" value makes perfect sense to me.
And I makes me feel comfortable.

> +}
> +
>  /**
>   * nbcon_alloc - Allocate buffers needed by the nbcon console
>   * @con:	Console to allocate buffers for
> @@ -1458,6 +1639,7 @@ void nbcon_device_release(struct console *con)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	if (console_is_usable(con, console_srcu_read_flags(con)) &&
> +	    !con->kthread &&

This would deserve updating the comment like in nbcon_atomic_flush_pending_con().

>  	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
>  		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
>  	}

Best Regards,
Petr

