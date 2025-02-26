Return-Path: <linux-kernel+bounces-534022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E43A46194
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F04E188A024
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34319CD0B;
	Wed, 26 Feb 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iI0MSZgq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550ED33EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578518; cv=none; b=N0q5C4ivBCCW8gTy5sDzt3d7OzowuQeWlclY9wudqQR+3f854laAsSStPZxGm7APw6ih03QKjlPk5c19dBvzx329CDCjyyEzMqd9mgFbwXNageaPPNnprU4jC7fINQ/FIPFc+JHy4t/MuWf1ed8jEOXQ6jbwifPZ2UpQfmdnYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578518; c=relaxed/simple;
	bh=I+OxKfcQydI4tB3i0AQ078Dwxniyn2sXERNVhUtiNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfVlmUFw8S4zclQ7CwHGiqyCbtkWsPGnE2h26xRZwDNSys1HLGrWTgH1dWeLS11NSEJ43jtU+/dOsP1XhSMwMTSRVqic45ztuZNyA8V1cR0RoljrqG7KEFymJwmFT0YtWpxtYqkOiavVkJXGBBlGSSwdybWZUi5UWS6caIoc83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iI0MSZgq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740578515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK0BGEEjl9jc4bHg/9SvhRzPaXYS4Q461+bnc0pkYPQ=;
	b=iI0MSZgqE7YMdo5NFD+SR3erZVDr6rAqoskPg29hZYABBNyUdC+ahwM638GN3UomthPbZi
	gqiSMuSAUOp9ij0ibEpahg74YyaQsvQ9z5dnz25a8oaXzYgT3FpmzNkOB7pBu0tciNHz2J
	k6Suwa14PMKTpSSxF5SV2UKC5VIRodQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-M_KJ3lygO1yUYl7bilbk3A-1; Wed,
 26 Feb 2025 09:01:51 -0500
X-MC-Unique: M_KJ3lygO1yUYl7bilbk3A-1
X-Mimecast-MFC-AGG-ID: M_KJ3lygO1yUYl7bilbk3A_1740578510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 567411800874;
	Wed, 26 Feb 2025 14:01:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B52E01800357;
	Wed, 26 Feb 2025 14:01:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 15:01:20 +0100 (CET)
Date: Wed, 26 Feb 2025 15:01:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250226140114.GE8995@redhat.com>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <Z73Tj3SAzNjaHwV3@localhost.localdomain>
 <20250225163549.GB29585@redhat.com>
 <Z75CKDw6uJZmNKYt@pavilion.home>
 <20250226131315.GD8995@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226131315.GD8995@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/26, Oleg Nesterov wrote:
>

Hmm. empty email? Let me resend.

On 02/25, Frederic Weisbecker wrote:
>
> Le Tue, Feb 25, 2025 at 05:35:50PM +0100, Oleg Nesterov a écrit :
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5304,12 +5304,12 @@ static void perf_pending_task_sync(struct perf_event *event)
> >  		return;
> >  	}
> >
> > -	/*
> > -	 * All accesses related to the event are within the same RCU section in
> > -	 * perf_pending_task(). The RCU grace period before the event is freed
> > -	 * will make sure all those accesses are complete by then.
> > -	 */
> > -	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
> > +	spin_lock(XXX_LOCK);
> > +	if (event->pending_work) {
> > +		local_dec(&event->ctx->nr_no_switch_fast);
> > +		event->pending_work = -1;
> > +	}
> > +	spin_unlock(XXX_LOCK);
> >  }
> >
> >  static void _free_event(struct perf_event *event)
> > @@ -5369,7 +5369,15 @@ static void _free_event(struct perf_event *event)
> >  	exclusive_event_destroy(event);
> >  	module_put(event->pmu->module);
> >
> > -	call_rcu(&event->rcu_head, free_event_rcu);
> > +	bool free = true;
> > +	spin_lock(XXX_LOCK)
> > +	if (event->pending_work == -1) {
> > +		event->pending_work = -2;
> > +		free = false;
> > +	}
> > +	spin_unlock(XXX_LOCK);
> > +	if (free)
> > +		call_rcu(&event->rcu_head, free_event_rcu);
> >  }
> >
> >  /*
> > @@ -6981,7 +6989,14 @@ static void perf_pending_task(struct callback_head *head)
> >  {
> >  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
> >  	int rctx;
> > +	bool free = false;
> >
> > +	spin_lock(XXX_LOCK);
> > +	if ((int)event->pending_work < 0) {
> > +		free = event->pending_work == -2u;
> > +		event->pending_work = 0;
> > +		goto unlock;
> > +	}
> >  	/*
> >  	 * All accesses to the event must belong to the same implicit RCU read-side
> >  	 * critical section as the ->pending_work reset. See comment in
> > @@ -7004,6 +7019,12 @@ static void perf_pending_task(struct callback_head *head)
> >
> >  	if (rctx >= 0)
> >  		perf_swevent_put_recursion_context(rctx);
> > +
> > +unlock:
> > +	spin_unlock(XXX_LOCK);
> > +
> > +	if (free)
> > +		call_rcu(&event->rcu_head, free_event_rcu);
> >  }
> >
> >  #ifdef CONFIG_GUEST_PERF_EVENTS
> >
>
> Heh, I suggested something similar also:
> https://lore.kernel.org/lkml/ZyJUzhzHGDu5CLdi@localhost.localdomain/

;)

I can't comment your patch because I don't understand this code enough.

My patch is more simple, it doesn't play with refcount.

perf_pending_task_sync() sets ->pending_work = -1, after that
perf_pending_task() (which can run in parallel on another CPU) will
only clear ->pending_work and do nothing else.

Then _free_event() rechecks ->pending_work before return, if it is still
nonzero then perf_pending_task() is still pending. In this case _free_event()
sets ->pending_work = -2 to offload call_rcu(free_event_rcu) to the pending
perf_pending_task().

But it is certainly more ugly, and perhaps the very idea is wrong. So I will
be happy if we go with your patch.

Either way, IMO we should try to kill this rcuwait_wait_event() logic. See
another email I sent a minute ago in this thread. Quite possibly I missed
something, but the very idea to wait for another task doesn't look safe
to me.

Thanks!

Oleg.


