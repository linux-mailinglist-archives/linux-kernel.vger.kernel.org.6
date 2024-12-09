Return-Path: <linux-kernel+bounces-437586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59789E9579
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F49C2818B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95D1E9B1E;
	Mon,  9 Dec 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xa0T5U2B"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569801E9B18
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748969; cv=none; b=YKnmLB+bUn+eBofbLOcDzp/6yhtK2YNST04mQqgaKzdtgfit3G2Df6XTbnx63LrFtT6sRyb0INsRCaJE35wte8qYOrjB6fFoVoJgb9X0EJzpJ2hVZ/BlGHB5lI90uKeB6fuf6vlk3YXqNrLpg4aGrXh712jo4KBPohBoGem6Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748969; c=relaxed/simple;
	bh=ZhzXJwBptn9rcja0eAHt56tAHAM+NWf7/GZjgem0c5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebmw1vx0Uo9krf0blZd0J8I+IhQar05Fz06w30h0/vKREhVU9Fp0C41vxoQMM1aIgGnubwLXUfPCePSyFn7ZAKkGh54Unlg6q4nmVLfsm8bwoE+wmMAeDTjexOOCtc4Rny6QZVA43LJMHm7XLf/ICeCozddkWVphpRTjh13cfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xa0T5U2B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oAB1948Z3fUbwysk0tNuvg7hkygv2nKzSIKfQylts4Y=; b=Xa0T5U2BXNP9ZD6Eg7qmqs6qPs
	D1IDdcZnnklyRHRMQEU8yKo0D+KqR3tlMFAJfkgrWsx6YJfRS54B004YcL2HvjknF1SYndA9SuGyL
	Cv5SwCkYmx2mVGSfsPFV7xfSKlH8rBWjt4Hw7d7slzRrdVhvg8vtoCIkaGSFOKG+cO8hy/mb4Egpz
	XIeu/zflhnIoDQrg5tFUNhr1SaRr49PddkrvGrPoeGkxl54MfEEl49370SUixadkBj/qx0wd+7e2+
	pJ0Bx71bkpmOIJrDpJiEOR8+m1BXVwgJ4vfxAe8CuR4tvhYkWkJFxTYru1Ddvp2MB7j16ZqKWW55W
	qo5iDnXA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdIv-00000003XQ1-3fFr;
	Mon, 09 Dec 2024 12:56:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 646DD3003FF; Mon,  9 Dec 2024 13:56:01 +0100 (CET)
Date: Mon, 9 Dec 2024 13:56:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
Message-ID: <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>

On Mon, Dec 09, 2024 at 07:29:52AM -0500, Vineeth Remanan Pillai wrote:
> On Mon, Dec 9, 2024 at 5:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrote:
> >
> > > I was able to reproduce this WARN_ON couple of days back with
> > > syzkaller. dlserver's dl_se gets enqueued during a update_curr while
> > > the dlserver is stopped. And subsequent dlserver start will cause a
> > > double enqueue.
> >
> > Right, I spotted that hole late last week. There is this thread:
> >
> >   https://lore.kernel.org/all/20241209094941.GF21636@noisy.programming.kicks-ass.net/T/#u
> >
> > Where I just added this thunk:
> >
> >   @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_se)
> >
> >  void dl_server_stop(struct sched_dl_entity *dl_se)
> >  {
> > +       if (current->dl_server == dl_se) {
> > +               struct rq *rq = rq_of_dl_se(dl_se);
> > +               trace_printk("stop fair server %d\n", cpu_of(rq));
> > +               current->dl_server = NULL;
> > +       }
> > +
> >         if (!dl_se->dl_runtime)
> >                 return;
> >
> > Which was my attempt at plugging said hole. But since I do not have
> > means of reproduction, I'm not at all sure it is sufficient :/
> >
> I think I was able to get to the root cause last week. So the issue
> seems to be that dlserver is stopped in the pick_task path of dlserver
> itself when the sched_delayed is set:
> __pick_next_task
> => pick_task_dl -> server_pick_task
>      => pick_task_fair
>           => pick_next_entity (if (sched_delayed))
>                => dequeue_entities
>                      => dl_server_stop

Ooh, that's where it happens.

So the scenario I had in mind was that we were doing something like:

	current->state = TASK_INTERRUPTIBLE();
	schedule();
	  deactivate_task()
	    dl_stop_server();
	  pick_next_task()
	    pick_next_task_fair()
	      sched_balance_newidle()
	        rq_unlock(this_rq)

at which point another CPU can take our RQ-lock and do:

	try_to_wake_up()
	  ttwu_queue()
	    rq_lock()
	    ...
	    activate_task()
	      dl_server_start()
	    wakeup_preempt() := check_preempt_wakeup_fair()
	      update_curr()
	        update_curr_task()
		  if (current->dl_server)
		    dl_server_update()
		      enqueue_dl_entity()
	  

Which then also goes *bang*. The above can't happen if we clear
current->dl_server in dl_stop_server().

I was worried that might not be it, bcause Marcel had biscected it to
the delayed stuff, but I'd not managed to reach the pick site yet :/

> Now server_pick_task returns NULL and then we set dl_yielded and call
> update_curr_dl_se. But dl_se is already dequeued and now the code is
> confused and it does all sorts of things including setting a timer to
> enqueue it back. This ultimately leads to double enqueue when dlserver
> is started next time(based on timing of dl_server_start)
> 
> I think we should not call update_curr_dl_se when the dlserver is
> dequeued. Based on this I have a small patch and it seems to solve the
> issue:
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a6..a9f3f020e421 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2419,12 +2419,18 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
> 
>         if (dl_server(dl_se)) {
>                 p = dl_se->server_pick_task(dl_se);
> -               if (!p) {
> +               if (p) {
> +                       rq->dl_server = dl_se;
> +               } else if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
> +                       /*
> +                        * If server_pick_task returns NULL and dlserver is
> +                        * enqueued, we have a problem. Lets yield and do a
> +                        * pick again.
> +                        */
>                         dl_se->dl_yielded = 1;
>                         update_curr_dl_se(rq, dl_se, 0);
>                         goto again;
>                 }
> -               rq->dl_server = dl_se;
>         } else {
>                 p = dl_task_of(dl_se);
>         }

Hmm.. so fundamentally that yield() makes sense, but yeah, it's lost
track of the fact that we've stopped the server and it should not
continue.

Does something like the below make sense?

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..abebeb67de4e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -664,6 +664,7 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_server_active  : 1;
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..e2b542f684db 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime)
 		return;
 
+	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 		resched_curr(dl_se->rq);
@@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_server_active = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -2420,8 +2422,10 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			dl_se->dl_yielded = 1;
-			update_curr_dl_se(rq, dl_se, 0);
+			if (dl_se->dl_server_active) {
+				dl_se->dl_yielded = 1;
+				update_curr_dl_se(rq, dl_se, 0);
+			}
 			goto again;
 		}
 		rq->dl_server = dl_se;

