Return-Path: <linux-kernel+bounces-208135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE9902149
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E6CB22905
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2C7E58C;
	Mon, 10 Jun 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIuQvjLb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLMiLGXF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD654650
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021355; cv=none; b=T3cfpSiA2jGJMJTSVvUawuLvU960XpuWcvHJczhlQZv+pZyUsKAq40uX2bS3W4QAVGmIRBXTvj5LqjN1MZzdRa0HD2APGRZNsk5/qHg3WWXpRBthphd7fGN39ygnPOieaylITOTwFr6ByL2FcqZsybblJXrYoksxqWapjoXXB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021355; c=relaxed/simple;
	bh=5StHzxrzZchICCcFFD/0JHx8xEvZnzAuh4YjDehg7ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5msvwnK0dBrYTYkHPRATjXEDSqJ/vob5Mu/sIs2Z9IiTZsVIGpaPuyoRroeh2qp2FAWvKsq0+iEdasU0u6kCtasSX+UQy0ul0VV3ojtLmemsGOuwBqABnyLb8zE4EjmIirfbg1LivNReLUgpGQUPwTL3TcFaaAXW7g2lOriic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIuQvjLb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLMiLGXF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718021351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qgi8dO6gsGFSn0NnWExXEDQG2efaSkYHOYSLWgTFEE8=;
	b=vIuQvjLb3naYazC+f6EQ6SJB4/ODLnCt40nuxP2N1tdQqkj7hRIjX+2WbXS28QydG1ghwU
	OIvZEZVOw5jxTNxQJb7dj7gwBu6zi+W2rZSXfIFPJLuP3CvAGHA0LSCvlxozDEZpmbjJbI
	SKksJWjE7DQ5BNMzft+CVsPwMF7qm4J9mTx71vT5WDM1y4hZX7qr/MYqD20JQv44/vBxPw
	aab57Y4k6GjNNTvi5xg59jq2b964bZM9L/idzlDgUJo6QbT72KRCrdUrEltXvBAaS71tnO
	6SI+zxwaHiNBZwfctu39kt2QB5gIKbpg45RN4JuP0D8z4dE7gqlrW0KvsMptUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718021351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qgi8dO6gsGFSn0NnWExXEDQG2efaSkYHOYSLWgTFEE8=;
	b=fLMiLGXF3X7ofj+bOP6S6qp0OoqiPehOo2zKlLjRaNirXeYtPhazrnGK/8OPX4lqEtS3bZ
	Fk4mzALjr/QC6lDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing kthreads
In-Reply-To: <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
Date: Mon, 10 Jun 2024 14:15:10 +0206
Message-ID: <87ed95j8yh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-07, Petr Mladek <pmladek@suse.com> wrote:
> I updated this commit message in parallel with commenting the related
> code changes. My later comment might explain the motivation for
> writing the commit message this way.

I am OK with your proposed commit message. Thank you for taking the time
to fill in all the details.

> <proposal>

[...]

> The write context in the kthread will stay safe only when either of
> the following conditions are true:
>
>   1. The kthread is the only context which acquires the console
>      with NBCON_PRIO_NORMAL.
>
>   2. Other caller acquires the console context with NBCON_PRIO_NORMAL
>      under the device_lock.
>
>   3. Other caller acquires the console context with NBCON_PRIO_NORMAL
>      with disabled preemption. It will release the context before
>      rescheduling.
>
> It is even double guaranteed. First, __nbcon_atomic_flush_pending_con()
> is called:
>
>   + with disabled interrupts from nbcon_atomic_flush_pending_con()
>   + under device_lock() from nbcon_device_release()

[...]

> </proposal>
>
> BTW: It really looks like the safety is double guaranteed. Maybe
>      the con->device_lock() is not needed in nbcon_kthread_func()
>      after all. Well, I would keep it to be on the safe side.

For the threaded case it is technically correct to say the safety is
double guaranteed. But the outer safety (device_lock()) can provide a
preemptible lock, which is the key for the non-interference property of
the threaded printers.

For example, for an nbcon framebuffer console, device_lock() most likely
will be a mutex.

During normal operation, the inner safety (console context) will never
be contended. That really only exists to synchronize the atomic case.

>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -373,6 +376,27 @@ struct console {
>>  	 */
>>  	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
>>  
>> +	/**
>> +	 * @write_thread:
>> +	 *
>> +	 * NBCON callback to write out text in task context.
>> +	 *
>> +	 * This callback is called after device_lock() and with the nbcon
>> +	 * console acquired. Any necessary driver synchronization should have
>> +	 * been performed by the device_lock() callback.
>> +	 *
>> +	 * This callback is always called from task context but with migration
>> +	 * disabled.
>> +	 *
>> +	 * The same criteria for console ownership verification and unsafe
>> +	 * sections applies as with write_atomic(). The difference between
>> +	 * this callback and write_atomic() is that this callback is used
>> +	 * during normal operation and is always called from task context.
>> +	 * This allows drivers to operate in their own locking context for
>> +	 * synchronizing output to the hardware.
>> +	 */
>
> The description is not bad. It seems to include all the important
> information. Except than I still needed to scratch my head around it
> to understand the real purpose and rules.
>
> Namely, the following sentences are kind of vague and bring questions
> which I had in the past before I understood all the relations:
>
>    1. "Any necessary driver synchronization should have been performed
>        by the device_lock() callback."
>
>        Q: Why do we need to take both device_lock() and the context then?

The device_lock() enables the non-interference property during normal
operation. OTOH the context is taken to synchronize against non-normal
(emergency/panic) operation.

>        Q: Why the acquired context is not enough?

Because the context _requires_ disabling preemption during all driver
activity, which is a major source of interference to the system.

If you only care about UART drivers and !PREEMPT_RT, then there really
is not much difference between spinning on a spinlock vs. spinning on a
context. But for non-UART drivers or PREEMPT_RT, there is a huge
difference between blocking on device_lock() with preemption enabled vs.
spinning on a context.

I think it really helps to see the importance if you assume
device_lock() is a mutex. (All the printk code must also make this
assumption.)

>    2. "This allows drivers to operate in their own locking context for
>        synchronizing output to the hardware."
>
>        Q: What exactly does this sentence mean?

For example, if a console driver uses a mutex to synchronize hardware
access, it can implement this callback knowing it is under that
mutex. This also applies for any locking mechanism the driver might use.

>        Q: What is the driver?

The code that implements _all_ access to the hardware for _all_
purposes.

>        Q: What are the output callbacks?

I am not referring to callbacks. I am referring to any code in the
driver that is accessing the parts of the hardware that are related to
outputting kernel messages.

>        Q: How exactly is this related to write_atomic() and write_thread()?

Both nbcon console write callbacks must synchronize against other
activities of the driver. For write_thread(), it is primarily via
device_lock().

>        Q: Is the context more strict or relaxed, in which way?

If device_lock() is using a locking mechanism that does not disable
preemption, write_thread() is quite a bit more relaxed than the disabled
preemption context of write_atomic().

> Also I still keep in my mind that nbcon_context_try_acquire() is not
> safe with NBCON_NORMAL_PRIO with enabled preemption. There is
> the race discussed in the previous patchset, see
> https://lore.kernel.org/r/ZiD3FNBZh_iMOVWY@pathway.suse.cz
>
> I wonder if we could be more strigthforward.
>
> <my-take>
> 	/**
> 	 * @write_thread:
> 	 *
> 	 * NBCON callback to write out text in task context.
> 	 *
> 	 * This callback must be called only in task context with both
> 	 * device_lock() and the nbcon console acquired.
> 	 *
> 	 * The same rules for console ownership verification and unsafe
> 	 * sections handling applies as with write_atomic().
> 	 *
> 	 * The console ownership handling is necessary for synchronization
> 	 * against write_atomic() which is synchronized only via the context.
> 	 *
> 	 * The device_lock() serializes acquiring the console context
> 	 * with NBCON_PRIO_NORMAL. It is necessary when the device_lock()
> 	 * does not disable preemption. The console context locking is
> 	 * not able to detect a race in the following scenario:
> 	 *
> 	 *    1. [Task A] owns a context with NBCON_PRIO_NORMAL on [CPU X]
> 	 *	 and is scheduled.
> 	 *
> 	 *    2. Another context takes over the lock with NBCON_PRIO_EMERGENCY
> 	 *	 and releases it.
> 	 *
> 	 *    3. [Task B] acquires a context with NBCON_PRIO_NORMAL on [CPU X]
> 	 *	 and is scheduled.
> 	 *
> 	 *    4. [Task A] gets running on [CPU X] and see that the console is
> 	 *	 is still owned by a task on [CPU X] with NBON_PRIO_NORMAL.
> 	 *	 It can't detect that it is actually owned by another task.
> 	 */
> </my-take>
>
> My variant describes the purpose of device_lock() quite different way.
> But I think that this is the real purpose and we must be clear about
> it.

I would move that last part (starting with "The device_lock()
serializes...") into the kerneldoc for device_lock(). It really has
nothing to do with the write_thread() callback.

> Sigh, I was not able to describe the race reasonably a shorter
> way. Maybe, we should move this detailed explanation above,
> nbcon_context_try_acquire() and use just a reference here.

How about putting it as kerneldoc for nbcon_owner_matches() and refer to
it there from the device_lock() kerneldoc (or vice versa)?

For the write_thread() kerneldoc we could refer to the device_lock()
kerneldoc.

>> +/**
>> + * nbcon_kthread_func - The printer thread function
>> + * @__console:	Console to operate on
>> + *
>> + * Return:	0
>> + */
>> +static int nbcon_kthread_func(void *__console)
>> +{
>> +	struct console *con = __console;
>> +	struct nbcon_write_context wctxt = {
>> +		.ctxt.console	= con,
>> +		.ctxt.prio	= NBCON_PRIO_NORMAL,
>> +	};
>> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
>> +	short con_flags;
>> +	bool backlog;
>> +	int cookie;
>> +	int ret;
>> +
>> +wait_for_event:
>> +	/*
>> +	 * Guarantee this task is visible on the rcuwait before
>> +	 * checking the wake condition.
>> +	 *
>> +	 * The full memory barrier within set_current_state() of
>> +	 * ___rcuwait_wait_event() pairs with the full memory
>> +	 * barrier within rcuwait_has_sleeper().
>> +	 *
>> +	 * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
>> +	 */
>> +	ret = rcuwait_wait_event(&con->rcuwait,
>> +				 nbcon_kthread_should_wakeup(con, ctxt),
>> +				 TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
>> +
>> +	if (kthread_should_stop())
>> +		return 0;
>> +
>> +	/* Wait was interrupted by a spurious signal, go back to sleep. */
>> +	if (ret)
>> +		goto wait_for_event;
>> +
>> +	do {
>> +		backlog = false;
>> +
>
> I am not sure how obvious is that we take the lock around the entire
> operation. In principle, the console could not disappear. So it might
> look like it is not really necessary. But it actually plays important
> role when stopping/suspending the console. I would add a comment:
>
> 		/*
> 		 * Keep the read lock around the entire operation so that
> 		 * synchronize_srcu() could prove that the kthread stopped
> 		 * or suspended printing.
> 		 */

Agreed.

>> +		cookie = console_srcu_read_lock();
>> +
>> +		con_flags = console_srcu_read_flags(con);
>> +
>> +		if (console_is_usable(con, con_flags)) {
>> +			unsigned long lock_flags;
>> +
>> +			con->device_lock(con, &lock_flags);
>> +
>> +			/*
>> +			 * Ensure this stays on the CPU to make handover and
>> +			 * takeover possible.
>> +			 */
>> +			cant_migrate();
>> +
>> +			if (nbcon_context_try_acquire(ctxt)) {
>> +				/*
>> +				 * If the emit fails, this context is no
>> +				 * longer the owner.
>> +				 */
>> +				if (nbcon_emit_next_record(&wctxt, false)) {
>> +					nbcon_context_release(ctxt);
>> +					backlog = ctxt->backlog;
>> +				}
>> +			}
>> +
>> +			con->device_unlock(con, lock_flags);
>> +		}
>> +
>> +		console_srcu_read_unlock(cookie);
>> +
>> +	} while (backlog);
>
> Thinking loudly:
>
> We do not check kthread_should_stop() in the cycle. It means that it
> would flush all messages before stopping the kthread. But only
> when it is already in the cycle. It would not flush the messages
> in the following scenario:
>
> CPU0					CPU1
>
> printk("Unregistering console\n");
>   nbcon_wake_threads();
>      irq_work_queue(&con->irq_work);
>
> kthread_stop(con->thread);
>
> 					nbcon_kthread_func()
> 					  rcuwait_wait_event()
> 					    nbcon_kthread_should_wakeup()
>
> 					  if (kthread_should_stop())
> 					    // true
> 					    return 0
>
> Result: The kthread did not flush the pending messages in this case.

Nice catch. How about if we add the following to
unregister_console_locked():

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2ac7aaab234..fab69ca7f938 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3995,6 +3995,8 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
+	__pr_flush(console, 1000, true);
+
 	/* Disable it unconditionally */
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);

>> +	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
>> +	if (IS_ERR(kt)) {
>> +		con_printk(KERN_ERR, con, "failed to start printing thread\n");
>> +		return;
>
> I am a bit surprised that we ignore the error here.
>
>
> Hmm, it likely works in this patch because the legacy code would still
> flush the console when con->thread is not assigned.
>
> But it would stop working later when the legacy loop is disabled
> by the global @printk_threads_enabled variable.

The thread failing to start is a serious issue. Particularly for
PREEMPT_RT. Probably it should be something like:

	if (WARN_ON(IS_ERR(kt))) {

In fact, I nbcon_atomic_flush_pending_con() and nbcon_device_release()
need to check @printk_threads_enabled _instead_ of con->kthread. Once
"threading mode" has been activated, there should be _no_ atomic
printing during normal operation.

> The kthread is running and started processing messages at this moment.
> But con->kthread is not set yet.

[...]

> It might be worth a comment.
>
> <proposal>
> 	/*
> 	 * Some users check con->kthread to decide whether to flush
> 	 * the messages directly using con->write_atomic(). Note that
> 	 * possible races with the kthread are double prevented.
> 	 *
> 	 * First, the users ignore this console until it is added into
> 	 * @console_list which is done under con->device_lock().
> 	 * Second, the calls would be additionaly serialized by acquiring
> 	 * the console context.
> 	 */
> </proposal>

It is enough to mention only the calling context. How about:

	/*
	 * Some users check con->kthread to decide whether to flush the
	 * messages directly using con->write_atomic(). A possible race
	 * with the kthread is prevented because all printing is
	 * serialized by acquiring the console context.
	 */

>> +	con->kthread = kt;

>> +	/*
>> +	 * It is important that console printing threads are scheduled
>> +	 * shortly after a printk call and with generous runtime budgets.
>> +	 */
>> +	sched_set_normal(con->kthread, -20);
>
> I would prefer to move this into a separate patch. I feel that it
> might be kind of controversial and subject to a change in the future.
> We should not hide this "tiny" detail in this mega patch ;-)

OK.

>> @@ -1458,6 +1639,7 @@ void nbcon_device_release(struct console *con)
>>  	 */
>>  	cookie = console_srcu_read_lock();
>>  	if (console_is_usable(con, console_srcu_read_flags(con)) &&
>> +	    !con->kthread &&
>
> This would deserve updating the comment like in
> nbcon_atomic_flush_pending_con().

OK.

John

