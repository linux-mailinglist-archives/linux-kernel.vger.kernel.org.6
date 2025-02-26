Return-Path: <linux-kernel+bounces-534137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042FA46345
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD98918970E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE4221711;
	Wed, 26 Feb 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddMcL1Wy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39921D3C7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580938; cv=none; b=UEydpPu83ycLjKpdngQthC+X8tmAWARzDTiPBHVCi1NoGeHyCbAJtqY73pFnJBM4jt8NBilhwWcfacaduaP5YX3f0E7hDyPlaz2Z8awzJatO+Nzer5oU84tuR1ED9W3Tk+Y9YrVaJznHedShliWQenrJJSghcriOOfgxnIiu4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580938; c=relaxed/simple;
	bh=RPPUCQFNNRPULwXb1o+C2PDoiUpyW+jNKrMiUvragHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZGkjywmwrL9bb2aUwvKhtwAzBc3lcPv6Tk7izA/DKTsmktWss+qtqsVQvLTzFAZu6ZCuJQeOgC2p7Rxey1CDMMmV1DdccD4VtDSaiaU9pygYtwCbAup+9DIrx5qfriT0mBcQ7eRgzgpDbpMSlHVEHr/o85ehjXlyeCqsqiiw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddMcL1Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFB5C4CED6;
	Wed, 26 Feb 2025 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740580937;
	bh=RPPUCQFNNRPULwXb1o+C2PDoiUpyW+jNKrMiUvragHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddMcL1WyghYEvaEply3ddEJ0FHh6m1Djyk28bODOHQkRCx0LPk2fB/lBmn0pUWNjw
	 TeD4xY68lGn6FgseBSltwpFxbbdCMD+tvuCj0sJAsPGVNkPPAjSM6xyKV1T7QfapX7
	 ioDuwiWfuKUD38Dx+0K9mPI44UJAZk5PUAPNkeSRHfhBjPiF8UllYq8FAxKzTEUTGs
	 wHUEV8VnIUVup2Zcm4lKHupYMMLkT4c8NnL/9T5Q/PWLX4MLg+uqnCUuSjpUaMeqDJ
	 TtqftMee08ej5fWZPgUN/+/BU5C+ro1BFX2WnN/ANYcYaQAd8eJLo7i0P9B1La6oiT
	 PJaqc9pNkTCFQ==
Date: Wed, 26 Feb 2025 15:42:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <Z78oRqnN9-NZO_LJ@localhost.localdomain>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <Z73Tj3SAzNjaHwV3@localhost.localdomain>
 <20250225163549.GB29585@redhat.com>
 <Z75CKDw6uJZmNKYt@pavilion.home>
 <20250226131315.GD8995@redhat.com>
 <20250226140114.GE8995@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226140114.GE8995@redhat.com>

Le Wed, Feb 26, 2025 at 03:01:15PM +0100, Oleg Nesterov a écrit :
> On 02/25, Frederic Weisbecker wrote:
> >
> > Le Tue, Feb 25, 2025 at 05:35:50PM +0100, Oleg Nesterov a écrit :
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -5304,12 +5304,12 @@ static void perf_pending_task_sync(struct perf_event *event)
> > >  		return;
> > >  	}
> > >
> > > -	/*
> > > -	 * All accesses related to the event are within the same RCU section in
> > > -	 * perf_pending_task(). The RCU grace period before the event is freed
> > > -	 * will make sure all those accesses are complete by then.
> > > -	 */
> > > -	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
> > > +	spin_lock(XXX_LOCK);
> > > +	if (event->pending_work) {
> > > +		local_dec(&event->ctx->nr_no_switch_fast);
> > > +		event->pending_work = -1;
> > > +	}
> > > +	spin_unlock(XXX_LOCK);
> > >  }
> > >
> > >  static void _free_event(struct perf_event *event)
> > > @@ -5369,7 +5369,15 @@ static void _free_event(struct perf_event *event)
> > >  	exclusive_event_destroy(event);
> > >  	module_put(event->pmu->module);
> > >
> > > -	call_rcu(&event->rcu_head, free_event_rcu);
> > > +	bool free = true;
> > > +	spin_lock(XXX_LOCK)
> > > +	if (event->pending_work == -1) {
> > > +		event->pending_work = -2;
> > > +		free = false;
> > > +	}
> > > +	spin_unlock(XXX_LOCK);
> > > +	if (free)
> > > +		call_rcu(&event->rcu_head, free_event_rcu);
> > >  }
> > >
> > >  /*
> > > @@ -6981,7 +6989,14 @@ static void perf_pending_task(struct callback_head *head)
> > >  {
> > >  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
> > >  	int rctx;
> > > +	bool free = false;
> > >
> > > +	spin_lock(XXX_LOCK);
> > > +	if ((int)event->pending_work < 0) {
> > > +		free = event->pending_work == -2u;
> > > +		event->pending_work = 0;
> > > +		goto unlock;
> > > +	}
> > >  	/*
> > >  	 * All accesses to the event must belong to the same implicit RCU read-side
> > >  	 * critical section as the ->pending_work reset. See comment in
> > > @@ -7004,6 +7019,12 @@ static void perf_pending_task(struct callback_head *head)
> > >
> > >  	if (rctx >= 0)
> > >  		perf_swevent_put_recursion_context(rctx);
> > > +
> > > +unlock:
> > > +	spin_unlock(XXX_LOCK);
> > > +
> > > +	if (free)
> > > +		call_rcu(&event->rcu_head, free_event_rcu);
> > >  }
> > >
> > >  #ifdef CONFIG_GUEST_PERF_EVENTS
> > >
> >
> > Heh, I suggested something similar also:
> > https://lore.kernel.org/lkml/ZyJUzhzHGDu5CLdi@localhost.localdomain/
> 
> ;)
> 
> I can't comment your patch because I don't understand this code enough.
> 
> My patch is more simple, it doesn't play with refcount.
> 
> perf_pending_task_sync() sets ->pending_work = -1, after that
> perf_pending_task() (which can run in parallel on another CPU) will
> only clear ->pending_work and do nothing else.
> 
> Then _free_event() rechecks ->pending_work before return, if it is still
> nonzero then perf_pending_task() is still pending. In this case _free_event()
> sets ->pending_work = -2 to offload call_rcu(free_event_rcu) to the pending
> perf_pending_task().

Right it works but it does a parallel implementation of events refcounting.

> 
> But it is certainly more ugly, and perhaps the very idea is wrong. So I will
> be happy if we go with your patch.

Ok I'll prepare a changelog and see where it goes.

> Either way, IMO we should try to kill this rcuwait_wait_event() logic. See
> another email I sent a minute ago in this thread. Quite possibly I missed
> something, but the very idea to wait for another task doesn't look safe
> to me.

You're right it's very fragile...

Thanks.

> 
> Thanks!
> 
> Oleg.
> 

