Return-Path: <linux-kernel+bounces-532596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F17A44FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95448188FBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0B21325C;
	Tue, 25 Feb 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJJV0fKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE27211A18
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522028; cv=none; b=EajkUhIMY+1g/ljaR58pTI8NwTxAsmJnlrOK2WIriGIIqgRD2/MTWV1ZYGHHumHIUwnD/uGQYOUEyQEJ/4b07Xqzw3u40nGOUKZ4d2nidg+Onn7wv3DAvVpdccD1/RnBdxEIw3DVcBjHlLtVN/xG1fqIGMXVK/stij/LRMa+1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522028; c=relaxed/simple;
	bh=HUWIXph1WZ6PMBfsIkpyUyjgNpeYqCTXmP28nB/zuRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVPtw1JQyFkQsxer3SKvV18Qk+Lzew4bjBSIzS885pJrOPb4OiWxfomr4FR0ehkuvPEFhCnddGZSC2s7aoo6gEMN01NEVFAwtW7tyUYzWAXfBpIMSpIzID37/WgfYwUZGDPsHcFUCUj3cBIF0dRv3RUQn5sL8eHGc6jilz4B2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJJV0fKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F29FC4CEDD;
	Tue, 25 Feb 2025 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740522028;
	bh=HUWIXph1WZ6PMBfsIkpyUyjgNpeYqCTXmP28nB/zuRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJJV0fKjemPxQ160xuz03Y3gG3DiM8/6bFgf2ccfviE33Muy2AP7CjLQVALKLR01O
	 dDyeimQItTc62RgacRa+ZfpN4KJAxaAAWhsGT3MXbDXObratMWdvwBKkVY2oppfWsH
	 zp1rUILmEidcUJt6+PlJccAQaXKGm9pywBVVM2IWrNdxx7J9fzG/uxxdGi5EVpowaH
	 cvOmNWRsf/YpwV8svBuZw6VIGkO1lt4uhDaW08mFzpiDLm+py06g81NgguQ0zeHnh6
	 RrmdQafwDv942BcwnWG0F3EC+H36xhH68soE3UlShoTZe//i3daES7KF7Nk8dJm636
	 6Ozgk3z+HeqtQ==
Date: Tue, 25 Feb 2025 23:20:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <Z75CKDw6uJZmNKYt@pavilion.home>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <Z73Tj3SAzNjaHwV3@localhost.localdomain>
 <20250225163549.GB29585@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225163549.GB29585@redhat.com>

Le Tue, Feb 25, 2025 at 05:35:50PM +0100, Oleg Nesterov a écrit :
> On 02/25, Frederic Weisbecker wrote:
> >
> > Le Sun, Feb 23, 2025 at 11:40:15PM +0100, Oleg Nesterov a écrit :
> > >
> > > I'll try to find and read the previous discussions tomorrow, but iirc Frederic
> > > had another solution?
> >
> > This:
> >
> > 	https://lore.kernel.org/all/Zx-B0wK3xqRQsCOS@localhost.localdomain/
> >
> > Though I'm not entirely happy with it either.
> 
> Yes, thanks...
> 
> Can we do something else and avoid this rcuwait_wait_event() altogether?
> 
> To simplify the discussion, suppose we add a global XXX_LOCK. Just in
> case, of course we shouldn't do this ;) But lets suppose we do.
> 
> Now, can _something_ like the (incomplete, ugly as hell) patch below work?
> 
> Oleg.
> ---
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5304,12 +5304,12 @@ static void perf_pending_task_sync(struct perf_event *event)
>  		return;
>  	}
>  
> -	/*
> -	 * All accesses related to the event are within the same RCU section in
> -	 * perf_pending_task(). The RCU grace period before the event is freed
> -	 * will make sure all those accesses are complete by then.
> -	 */
> -	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
> +	spin_lock(XXX_LOCK);
> +	if (event->pending_work) {
> +		local_dec(&event->ctx->nr_no_switch_fast);
> +		event->pending_work = -1;
> +	}
> +	spin_unlock(XXX_LOCK);
>  }
>  
>  static void _free_event(struct perf_event *event)
> @@ -5369,7 +5369,15 @@ static void _free_event(struct perf_event *event)
>  	exclusive_event_destroy(event);
>  	module_put(event->pmu->module);
>  
> -	call_rcu(&event->rcu_head, free_event_rcu);
> +	bool free = true;
> +	spin_lock(XXX_LOCK)
> +	if (event->pending_work == -1) {
> +		event->pending_work = -2;
> +		free = false;
> +	}
> +	spin_unlock(XXX_LOCK);
> +	if (free)
> +		call_rcu(&event->rcu_head, free_event_rcu);
>  }
>  
>  /*
> @@ -6981,7 +6989,14 @@ static void perf_pending_task(struct callback_head *head)
>  {
>  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
>  	int rctx;
> +	bool free = false;
>  
> +	spin_lock(XXX_LOCK);
> +	if ((int)event->pending_work < 0) {
> +		free = event->pending_work == -2u;
> +		event->pending_work = 0;
> +		goto unlock;
> +	}
>  	/*
>  	 * All accesses to the event must belong to the same implicit RCU read-side
>  	 * critical section as the ->pending_work reset. See comment in
> @@ -7004,6 +7019,12 @@ static void perf_pending_task(struct callback_head *head)
>  
>  	if (rctx >= 0)
>  		perf_swevent_put_recursion_context(rctx);
> +
> +unlock:
> +	spin_unlock(XXX_LOCK);
> +
> +	if (free)
> +		call_rcu(&event->rcu_head, free_event_rcu);
>  }
>  
>  #ifdef CONFIG_GUEST_PERF_EVENTS
> 

Heh, I suggested something similar also:
https://lore.kernel.org/lkml/ZyJUzhzHGDu5CLdi@localhost.localdomain/

The main point being that the event has its refcount inc when the task work
is queued and put from the task work handler. This restore the initial behaviour
but without the bug where the event was freed before the task work was reached.

My remaining worry was that exec'ing tasks with suid might get an irrelevant
signal from the unprivileged past but surely we can work around that. An
untested, complete version would look like:

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..854486d78e1e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -831,7 +831,6 @@ struct perf_event {
 	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
-	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..2cf7fa688dd9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5288,35 +5288,10 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
-static void perf_pending_task_sync(struct perf_event *event)
-{
-	struct callback_head *head = &event->pending_task;
-
-	if (!event->pending_work)
-		return;
-	/*
-	 * If the task is queued to the current task's queue, we
-	 * obviously can't wait for it to complete. Simply cancel it.
-	 */
-	if (task_work_cancel(current, head)) {
-		event->pending_work = 0;
-		local_dec(&event->ctx->nr_no_switch_fast);
-		return;
-	}
-
-	/*
-	 * All accesses related to the event are within the same RCU section in
-	 * perf_pending_task(). The RCU grace period before the event is freed
-	 * will make sure all those accesses are complete by then.
-	 */
-	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
-}
-
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
-	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -5441,10 +5416,17 @@ static void perf_remove_from_owner(struct perf_event *event)
 
 static void put_event(struct perf_event *event)
 {
+	struct perf_event *parent;
+
 	if (!atomic_long_dec_and_test(&event->refcount))
 		return;
 
+	parent = event->parent;
 	_free_event(event);
+
+	/* Matches the refcount bump in inherit_event() */
+	if (parent)
+		put_event(parent);
 }
 
 /*
@@ -5528,11 +5510,6 @@ int perf_event_release_kernel(struct perf_event *event)
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP);
 			list_move(&child->child_list, &free_list);
-			/*
-			 * This matches the refcount bump in inherit_event();
-			 * this can't be the last reference.
-			 */
-			put_event(event);
 		} else {
 			var = &ctx->refcount;
 		}
@@ -5558,7 +5535,7 @@ int perf_event_release_kernel(struct perf_event *event)
 		void *var = &child->ctx->refcount;
 
 		list_del(&child->child_list);
-		free_event(child);
+		put_event(child);
 
 		/*
 		 * Wake any perf_event_free_task() waiting for this event to be
@@ -6982,12 +6959,6 @@ static void perf_pending_task(struct callback_head *head)
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
-	/*
-	 * All accesses to the event must belong to the same implicit RCU read-side
-	 * critical section as the ->pending_work reset. See comment in
-	 * perf_pending_task_sync().
-	 */
-	rcu_read_lock();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6998,9 +6969,8 @@ static void perf_pending_task(struct callback_head *head)
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_no_switch_fast);
-		rcuwait_wake_up(&event->pending_work_wait);
 	}
-	rcu_read_unlock();
+	put_event(event);
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
@@ -9945,6 +9915,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_no_switch_fast);
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
@@ -12266,7 +12237,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
-	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -13431,8 +13401,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
-		free_event(event);
-		put_event(parent_event);
+		put_event(event);
 		return;
 	}
 
@@ -13550,13 +13519,11 @@ static void perf_free_event(struct perf_event *event,
 	list_del_init(&event->child_list);
 	mutex_unlock(&parent->child_mutex);
 
-	put_event(parent);
-
 	raw_spin_lock_irq(&ctx->lock);
 	perf_group_detach(event);
 	list_del_event(event, ctx);
 	raw_spin_unlock_irq(&ctx->lock);
-	free_event(event);
+	put_event(event);
 }
 
 /*


