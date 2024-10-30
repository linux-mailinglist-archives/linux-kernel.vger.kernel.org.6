Return-Path: <linux-kernel+bounces-389574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C19B6E92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF22D282714
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A81CF7BA;
	Wed, 30 Oct 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFwSgTu1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0A1BD9E8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322919; cv=none; b=CHdkxpmGJHLL7fG8cxbheSHJYKenSAAxIVBIjUziWuFoTVnnQvd/xW2TQHrNEPO4yEy+OprbUYzanB5Q0NZt7FTBSLc4mQxNI8odp+CrY3DQVAbladSlRZYsYTV2uYvp1Rltf0s1PAlyHh4aAf0NOPr7v24DkPJBc0UYXqms23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322919; c=relaxed/simple;
	bh=3NdbEY+40g2u4PJZgAGawzFFKoDnL2ekE+kgA+nNaIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBP17oMXhKcS6mTYQWxphHRTvHFR6QK+fezSyf7yxPSfDg+kHzKRpDfa4CcIt1uH9VYMOOBep6EC7tkOgGl6NPgpD6wyOrndBgBYxtYqiiJfZHG32k8cD0fUCyVUty1l7EYsS1BSdAWl4QL2KgbmadF9WKuAzonktQmJStjz7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eFwSgTu1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r4sF1w6wZ9YNJ5W9haXfyzIjOPf0e+55cCGv6/q1+DQ=; b=eFwSgTu1LFnfSlwKTjmCUd6d54
	MQvJpKpcOLsXbUblt/Fe7w9l7LmtXFukgDzaoUe5Yd23tS4gaQnqHcsaYSMkyDTbScW51L+gIz3Ss
	D3a0GpejIBZk+PVm4qvuZRlFzvDwgsRi7VhERbmTUR5Hpi2MiY4qE43OvuvY2Ccvqp3AF1os9VcE4
	aPC6FezSaCR6QBt/W05HSWLyJ3krg96Az3zi/4M+z6OXEygFcHSyEe51lbX02eSCWcGkBLyTbXLOx
	dRYzwutvpg7wmOXTS6NPnGzAWUFYK/UALYv6BytnFO+jOjtirMulTlMQAvqEkN+MC5j5aXhYiYMOs
	0CuIZVAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6G1z-0000000ALNA-0491;
	Wed, 30 Oct 2024 21:15:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 608D9300B40; Wed, 30 Oct 2024 22:15:06 +0100 (CET)
Date: Wed, 30 Oct 2024 22:15:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/6] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <20241030211506.GR14555@noisy.programming.kicks-ass.net>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.711768679@infradead.org>
 <ZyKhQFuMItKsmsnh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyKhQFuMItKsmsnh@slm.duckdns.org>

On Wed, Oct 30, 2024 at 11:12:32AM -1000, Tejun Heo wrote:
> On Wed, Oct 30, 2024 at 04:12:59PM +0100, Peter Zijlstra wrote:
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5199,20 +5204,24 @@ static int scx_ops_enable(struct sched_e
> >  	percpu_down_write(&scx_fork_rwsem);
> >  	scx_task_iter_start(&sti);
> >  	while ((p = scx_task_iter_next_locked(&sti))) {
> > +		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
> >  		const struct sched_class *old_class = p->sched_class;
> >  		const struct sched_class *new_class =
> >  			__setscheduler_class(p->policy, p->prio);
> >  
> > +		if (old_class != new_class)
> > +			queue_flags |= DEQUEUE_CLASS;
> > +
> >  		if (old_class != new_class && p->se.sched_delayed)
> >  			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> >  
> >  		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
>                                                ^
> 					       queue_flags
> 					       
> >  			p->scx.slice = SCX_SLICE_DFL;
> >  			p->sched_class = new_class;
> > -			check_class_changing(task_rq(p), p, old_class);
> >  		}
> >  
> > -		check_class_changed(task_rq(p), p, old_class, p->prio);
> > +		if (!(queue_flags & DEQUEUE_CLASS))
> > +			check_prio_changed(task_rq(p), p, p->prio);
> 
> Maybe prio_changed can be moved into scoped_guard?

It wasn't before -- do you have need for it to be inside?

