Return-Path: <linux-kernel+bounces-365378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291BF99E176
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC859281ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC31CDA0A;
	Tue, 15 Oct 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZyaX1Ok"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D20757FC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982023; cv=none; b=M1nNju7k1dsnhkiwQp6dIMRltABTwFA+MFTG2IThbxucWMsW1qIGWSJaiecue2vhDaoKWMrjCTU4aHbGaR9ApGdwdu/n0ytQ4gr2KFb0BZvlVMIK1j3vsxFiZnodMFOG7wXaBM9TqRH1Z5dD9Dl4CD39pSM/KQszkWoXW0/96KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982023; c=relaxed/simple;
	bh=qo4mAlw+3vd7YCSMKVLKj4oPr907cn8yEmhQfACX+h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIkLKKpecI3SksMS1Cs1vRXC9XhrCy0hCMDU/HBjW/MYAAYgNHS8SBE5HRpEmcGLM9oeim6GUmmRjHhG0aMT4dzPoRKyaHjOLRVn4wgHDMMn8bhdybGh57nXcWrdsMvNjnsq+SMxS/dUfXG1gTPxyjd8HkhY6/a89HtqFd0sKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZyaX1Ok; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 10:46:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728982019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rhHxx3USreQswu+sGVxLz519SlTZO+A0EebSAa76M+Q=;
	b=kZyaX1OkJBdqR2XdG50t7ofBhgfOl7BLaQivm0i3orpjVdQI+MSxnFV+bFsHchWp7yJkOX
	MDa6hPIVaskBmQzuAeqPBfXdQWebvAmZUJTTMotFZGF+FSiYWKReDpPLgG2GyjDjhMbUsO
	FKfvzBTLQm88LJrI/8s1Pu75/7CE9do=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw4r_YYU_2-ws98k@gpd3>
References: <20241014220603.35280-1-andrea.righi@linux.dev>
 <20241015074526.GO16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015074526.GO16066@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 09:45:26AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 15, 2024 at 12:06:03AM +0200, Andrea Righi wrote:
> 
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index d2f096bb274c..5a10cbc7e9df 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -459,13 +459,13 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
> >  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> >  {
> >  	update_idle_core(rq);
> > -	scx_update_idle(rq, true);
> >  	schedstat_inc(rq->sched_goidle);
> >  	next->se.exec_start = rq_clock_task(rq);
> >  }
> >  
> >  struct task_struct *pick_task_idle(struct rq *rq)
> >  {
> > +	scx_update_idle(rq, true);
> >  	return rq->idle;
> >  }
> 
> Does this do the right thing in the case of core-scheduling doing
> pick_task() for force-idle on a remote cpu?
> 
> The core-sched case is somewhat special in that the pick can be ignored
> -- in which case you're doing a spurious scx_update_idle() call.

Hm... that's right. So, what about keeping scx_update_idle() in
set_next_task_idle() and also call it from pick_task(), but only when
rq->curr == rq->idle?

In this way, we should still be able to handle the scx_bpf_kick_cpu()
call from ops.update_idle() properly and, while we might still encounter
spurious calls in the core scheduling case, the idle state provided by
ops.update_idle() will always be correct. So, scx schedulers that want
to implement their own cpu idle state can rely on ops.update_idle().

-Andrea

