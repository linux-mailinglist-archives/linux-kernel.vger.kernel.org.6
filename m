Return-Path: <linux-kernel+bounces-282052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500594DF09
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4471C21086
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0951422B4;
	Sat, 10 Aug 2024 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R1Tc1kRe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294028DCB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723328264; cv=none; b=DxLV+FQKofy2D9JDcywc6ewj7kyoIfKAD+jSlYRmGwjT+aGfHvGRADOI+023iJxXNOrsEIaPn6UggJuFdfb1Tvt5lpkzmEmt+ykdpaWspj8+9D8bjvyw4Vx03oMbsuccJHXXHOnyPtJL6Ii4WQbNrUfXJPgqUZUlu8Q5Lix0AxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723328264; c=relaxed/simple;
	bh=bx0JYrelvK2GOBUYj3D33kWDY3t4eQ8kkK4L59HMZ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqogLpDQ5wxcmgcxNBXhEduPx3mtzlGQ7vnaBtvuU7lrLN8CxhBJ3gdm/D4Re5j1z4bsSbVlqzTjZ7iA2I6g3kXOJX3//rkr8avvK3C1BjLzRuhD6Wlut7YZAq9L9dpdkssoGANgafxdD8zuG7JGSxsC8Gd7zfCog4eQg6s55Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R1Tc1kRe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z4ByhhI4e1dsxO3nlwjCfFRoBJOGOT6Asid5HZvhxF4=; b=R1Tc1kRe3xJVwoZEzIyOeyiV2P
	8EMGa68sFYsb8gNjBnMObCAyIC/A0tBk8stKnblnXF8SaT8Vrc8C62y8D2KX/qzz6br6kE9QosxhC
	DzJVDThQs2hPDpSZYteWqX3Hb4WSA28z766FjvPF1kBommQqihCuccPMdDA0t3NY5RkxhTItAURU3
	Va91eMOYetgznQPhT+WMGyuamJ3Eo/4KligobJ2Niy9Ycvpssi4yw9wVhCLl2Ej5PLzyr8vnbRdFD
	WA/pUkFZb4+c8QDr2D5PPS55d2++UzcvowGOrtzkNwnVDUK70UlgKclSrAI/icNRsVB7S7iQjYO4M
	pdwTG2RA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scuOp-00000007G9V-4BBB;
	Sat, 10 Aug 2024 22:17:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8EAB8300729; Sun, 11 Aug 2024 00:17:23 +0200 (CEST)
Date: Sun, 11 Aug 2024 00:17:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 07/24] sched/fair: Re-organize dequeue_task_fair()
Message-ID: <20240810221723.GJ11646@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105028.977256873@infradead.org>
 <xhsmhh6bty6wl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhh6bty6wl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Aug 09, 2024 at 06:53:30PM +0200, Valentin Schneider wrote:
> On 27/07/24 12:27, Peter Zijlstra wrote:
> > Working towards delaying dequeue, notably also inside the hierachy,
> > rework dequeue_task_fair() such that it can 'resume' an interrupted
> > hierarchy walk.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/fair.c |   61 ++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 40 insertions(+), 21 deletions(-)
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6861,34 +6861,43 @@ enqueue_task_fair(struct rq *rq, struct
> >  static void set_next_buddy(struct sched_entity *se);
> >
> >  /*
> > - * The dequeue_task method is called before nr_running is
> > - * decreased. We remove the task from the rbtree and
> > - * update the fair scheduling stats:
> > + * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
> > + * failing half-way through and resume the dequeue later.
> > + *
> > + * Returns:
> > + * -1 - dequeue delayed
> > + *  0 - dequeue throttled
> > + *  1 - dequeue complete
> >   */
> > -static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > +static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >  {
> > -	struct cfs_rq *cfs_rq;
> > -	struct sched_entity *se = &p->se;
> > -	int task_sleep = flags & DEQUEUE_SLEEP;
> > -	int idle_h_nr_running = task_has_idle_policy(p);
> >       bool was_sched_idle = sched_idle_rq(rq);
> >       int rq_h_nr_running = rq->cfs.h_nr_running;
> > +	bool task_sleep = flags & DEQUEUE_SLEEP;
> > +	struct task_struct *p = NULL;
> > +	int idle_h_nr_running = 0;
> > +	int h_nr_running = 0;
> > +	struct cfs_rq *cfs_rq;
> >
> > -	util_est_dequeue(&rq->cfs, p);
> > +	if (entity_is_task(se)) {
> > +		p = task_of(se);
> > +		h_nr_running = 1;
> > +		idle_h_nr_running = task_has_idle_policy(p);
> > +	}
> >
> 
> This leaves the *h_nr_running to 0 for non-task entities. IIUC this makes
> sense for ->sched_delayed entities (they should be empty of tasks), not so
> sure for the other case. However, this only ends up being used for non-task
> entities in:
> - pick_next_entity(), if se->sched_delayed
> - unregister_fair_sched_group()
> 
> IIRC unregister_fair_sched_group() can only happen after the group has been
> drained, so it would then indeed be empty of tasks, but I reckon this could
> do with a comment/assert in dequeue_entities(), no? Or did I get too
> confused by cgroups again?
> 

Yeah, so I did have me a patch that made all this work for cfs bandwidth
control as well. And then we need all this for throttled cgroup entries
as well.

Anyway... I had the patch, it worked, but then I remembered you were
going to rewrite all that anyway and I was making a terrible mess of
things, so I made it go away again.

