Return-Path: <linux-kernel+bounces-449606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB59F5155
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFDB1882468
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5701F7598;
	Tue, 17 Dec 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T94exKcc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46ED14A615
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453874; cv=none; b=MW3UQe9RH23ylW9kPtSh9ly9Td0TP8Upn7rdp8FT70bagxSFG+yNr6ZLLQyTIjnFb1DoJvS/ILGQQs1PgXb0h8ggM5M+qfljYtiey6zBzCdvs1tOJTYZdkRBHtWswIIoLAoZOmoxCbt9oyNytNLnLyWFZCRic6Sjlhy5e0HsY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453874; c=relaxed/simple;
	bh=RS9XeI84NOgiXDZJxIZ2UwSyN+uP6NXm6v9fymEPvjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKwPjq5P+JCc3gSqp+m09+VqXCPI6L8uJyO/741m7u2vKfZWjlR3xbJSJfxJoUaxPChdR16vDjiiUKDeAzp1itIWbATI6K9OIyvjBs0AoJFicU8yGxgbMx7df4RfxUsfqUZMorCbzaDpqI4i1pikrbcIl7LewKoC36zwKer6KB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T94exKcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F624C4CEE0;
	Tue, 17 Dec 2024 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734453874;
	bh=RS9XeI84NOgiXDZJxIZ2UwSyN+uP6NXm6v9fymEPvjU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T94exKcccsrqjiRJ9fcRu/hzgRWeZNPY15fRk3lX94RxEpF7BxghvIDaoDA0QuGjT
	 QqLmDF5aA77ZsiPGYV6/9dtnEJBJ0w5UXuqON6H7SKQQhAUtG7xxZIn+cx2nsLHyDr
	 2q72v3982vR3qoYSGIRGjgV5ByPRnmwRqTxVhxb1uaJmmgX1QaOU4oBzq4gB6h0DxC
	 urPz0/fLUNTAeZ4/6SwvYNt+FT9jql4Qsl1+Ey/g0rYuloGtBLXc3wEKKU7DXtmc+b
	 suvqL+kULMPMVfyaRyK35uK69qZDnzGx0NJX5ecgNfmWQVOxazZtD5Rv7W2fjOD6ez
	 Cw83BHZhFbalQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D99ABCE09DB; Tue, 17 Dec 2024 08:44:33 -0800 (PST)
Date: Tue, 17 Dec 2024 08:44:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>, shraash@google.com,
	marcel.ziswiler@codethink.co.uk, i.maximets@ovn.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] EXP sched/dlserver: flag to represent active status
 of dlserver
Message-ID: <2acb9c6d-a05e-45d8-90e1-924ebde9bb46@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213032244.877029-1-vineeth@bitbyteword.org>

On Thu, Dec 12, 2024 at 10:22:36PM -0500, Vineeth Pillai (Google) wrote:
> dlserver can get dequeued during a dlserver pick_task due to the delayed
> deueue feature and this can lead to issues with dlserver logic as it
> still thinks that dlserver is on the runqueue. The dlserver throttling
> and replenish logic gets confused and can lead to double enqueue of
> dlserver.
> 
> Double enqueue of dlserver could happend due to couple of reasons:
> 
> Case 1
> ------
> 
> Delayed dequeue feature[1] can cause dlserver being stopped during a
> pick initiated by dlserver:
>   __pick_next_task
>    pick_task_dl -> server_pick_task
>     pick_task_fair
>      pick_next_entity (if (sched_delayed))
>       dequeue_entities
>        dl_server_stop
> 
> server_pick_task goes ahead with update_curr_dl_se without knowing that
> dlserver is dequeued and this confuses the logic and may lead to
> unintended enqueue while the server is stopped.
> 
> Case 2
> ------
> A race condition between a task dequeue on one cpu and same task's enqueue
> on this cpu by a remote cpu while the lock is released causing dlserver
> double enqueue.
> 
> One cpu would be in the schedule() and releasing RQ-lock:
> 
> current->state = TASK_INTERRUPTIBLE();
>         schedule();
>           deactivate_task()
>             dl_stop_server();
>           pick_next_task()
>             pick_next_task_fair()
>               sched_balance_newidle()
>                 rq_unlock(this_rq)
> 
> at which point another CPU can take our RQ-lock and do:
> 
>         try_to_wake_up()
>           ttwu_queue()
>             rq_lock()
>             ...
>             activate_task()
>               dl_server_start() --> first enqueue
>             wakeup_preempt() := check_preempt_wakeup_fair()
>               update_curr()
>                 update_curr_task()
>                   if (current->dl_server)
>                     dl_server_update()
>                       enqueue_dl_entity() --> second enqueue
> 
> This bug was not apparent as the enqueue in dl_server_start doesn't
> usually happen because of the defer logic. But as a side effect of the
> first case(dequeue during dlserver pick), dl_throttled and dl_yield will
> be set and this causes the time accounting of dlserver to messup and
> then leading to a enqueue in dl_server_start.
> 
> Have an explicit flag representing the status of dlserver to avoid the
> confusion. This is set in dl_server_start and reset in dlserver_stop.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>

With both these patches, TREE03 ran without error for more than 20 hours
in a configuration that normally generates 50 enqueue_dl_entity() splats.
This provides at least 99% confidence of a reduction in splat rate of
at least an order of magnitude.  ;-)

For both:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/sched.h   | 7 +++++++
>  kernel/sched/deadline.c | 8 ++++++--
>  kernel/sched/sched.h    | 5 +++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..66b311fbd5d6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -656,6 +656,12 @@ struct sched_dl_entity {
>  	 * @dl_defer_armed tells if the deferrable server is waiting
>  	 * for the replenishment timer to activate it.
>  	 *
> +	 * @dl_server_active tells if the dlserver is active(started).
> +	 * dlserver is started on first cfs enqueue on an idle runqueue
> +	 * and is stopped when a dequeue results in 0 cfs tasks on the
> +	 * runqueue. In other words, dlserver is active only when cpu's
> +	 * runqueue has atleast one cfs task.
> +	 *
>  	 * @dl_defer_running tells if the deferrable server is actually
>  	 * running, skipping the defer phase.
>  	 */
> @@ -664,6 +670,7 @@ struct sched_dl_entity {
>  	unsigned int			dl_non_contending : 1;
>  	unsigned int			dl_overrun	  : 1;
>  	unsigned int			dl_server         : 1;
> +	unsigned int			dl_server_active  : 1;
>  	unsigned int			dl_defer	  : 1;
>  	unsigned int			dl_defer_armed	  : 1;
>  	unsigned int			dl_defer_running  : 1;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 33b4646f8b24..0abf14ac5ca7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1667,6 +1667,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>  	if (!dl_se->dl_runtime)
>  		return;
>  
> +	dl_se->dl_server_active = 1;
>  	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>  	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
>  		resched_curr(dl_se->rq);
> @@ -1681,6 +1682,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
>  	hrtimer_try_to_cancel(&dl_se->dl_timer);
>  	dl_se->dl_defer_armed = 0;
>  	dl_se->dl_throttled = 0;
> +	dl_se->dl_server_active = 0;
>  }
>  
>  void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> @@ -2435,8 +2437,10 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
>  	if (dl_server(dl_se)) {
>  		p = dl_se->server_pick_task(dl_se);
>  		if (!p) {
> -			dl_se->dl_yielded = 1;
> -			update_curr_dl_se(rq, dl_se, 0);
> +			if (dl_server_active(dl_se)) {
> +				dl_se->dl_yielded = 1;
> +				update_curr_dl_se(rq, dl_se, 0);
> +			}
>  			goto again;
>  		}
>  		rq->dl_server = dl_se;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aef716c41edb..65fa64845d9f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -398,6 +398,11 @@ extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq
>  extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
>  		    u64 runtime, u64 period, bool init);
>  
> +static inline bool dl_server_active(struct sched_dl_entity *dl_se)
> +{
> +	return dl_se->dl_server_active;
> +}
> +
>  #ifdef CONFIG_CGROUP_SCHED
>  
>  extern struct list_head task_groups;
> -- 
> 2.45.2
> 

