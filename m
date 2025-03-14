Return-Path: <linux-kernel+bounces-560988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E5A60C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1E17F295
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3331C8FBA;
	Fri, 14 Mar 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KzPzQxn6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99F19C56D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942159; cv=none; b=McpDDC+YOAA/61UcZ0Sg5ky7l9f1aYMDL9JXotT70zVpLFVGmypZggnzbtuAikHNe16l7JS3xksyCRthA1t1CwluyVSXMoevizmpkTLYdgRvJgldDuIRyAvqlzStYsEGB8AgHO733YPnEZUemmc6TffiJWbhogu86oDgLCozSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942159; c=relaxed/simple;
	bh=6VNXUsHqHYqRXJR6qzm8s6ArlWGiBJM3isQFbI1HiB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/n7YKlo/baxr7979GbUKKRuhlpGavOgzcIZylVfAZd3GT/RGbeY25E5j/+Z0BWYuNOKdMY+aVJZehf+yytKJPT8hq9uCa8T/xDEtzIep1m9eK1Z22CablRlI9cVnzSIPlrMhXhzXzY9w+IwCiE/BhdYY3dmNLJzagKIwEKc9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KzPzQxn6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224019ad9edso48407915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741942155; x=1742546955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X34uhsKT3t0fFMyDV+L78XVEZLOjmlr61Qqm68Y4G9k=;
        b=KzPzQxn6kcDY7gsVvRb3p5t6Z7a7BWrXQ81JdwBrCaAf2NVEBqGcJEO/My+lPp0/Tc
         04j5yCgCIfPuLrAU9iFCVSyrhSrR8wcHFQ4th2doTo5xaZxbRyQN/J3qft0JOA74IrL/
         /Yk4dMrMaxA86DnRIMKh4EmN5+1D+Nq8mpBt41Re63YTyCORuTyFOAp0Tif8KPw/e9jL
         96KlgkxpNQbDeUjeJkKwF2vcxoD9bsPZ+kvJ/GusCC1JZpHkZgI76hQ7Gpg6tfmf+rad
         hQBPq/e/cMh08Jb0sDjFdRgZ5NYoepGcqmCbR64yWzSVXatU5VCP50ICMGQ+yywQmuQB
         HCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942155; x=1742546955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X34uhsKT3t0fFMyDV+L78XVEZLOjmlr61Qqm68Y4G9k=;
        b=bq/BZ0FXJZb649tgbDKAiSUOYrM+Yw1NOvuEQf8Enh+VzSJO0N+NkjxXwX/Zc5Pd8/
         BIhmyNOuSHGUrobO4le6X98t2sUVeNhGdSkNS/AJpmUDjpZs2g9rlouKf0cbzI/1JxYL
         QfM+j7x6FvUzT/DmyWCFKAcQAge3qauxYc13LlQuVjCvQY0W2qynYeRpMsndun2tH535
         VwynURoHrw7OOjk0i+McuayvQQsbRCEqxdJAVti+Q0I66X+7kRlmsr8ApFR/lmEMqvur
         6rECfmsKtKQAp6hm4/mgQOZ8TgQbcQzjmI99OWnihF23+rpcim0dVsI+O7epR6fExjPW
         Wnhg==
X-Forwarded-Encrypted: i=1; AJvYcCVpy8p3AxUWtBmZGVdvTJbksoZ3yWqxnbhCymuz6+FC2kHhwC78TWmX09wOWk2D6y+ZdnY1Roohj1h7JxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dMuGzToT+FLhEqyYNrvjictSZg4lFI2pl3PpjJI8eyb55HaW
	uHnySLZQCVFE4O6zqYi3eScnREuSABCA1UKCo/vs9tljYNgv2LwTShTPaIr1Qw==
X-Gm-Gg: ASbGnctqymuh7E7GplZzVo3f3Cpo7hhjimR14F5hIAC4PUJ8MvqzeqRPKs+ydrCj3kJ
	Hg7x71Yfk79Me/J13sKg+sSD+nEJvLnCZHzzKcRBInIti9UOcvfFzzm62cL/7j9MGTJGG6v2LjA
	4O66fXSyo7yg9QZ83YEEaceolWxJrxWQYUakSGnZ0xvPFU6oXlrDDHdHaIIF9H3hCAXs1jfc0SX
	QLsEWtiB8p4guhebrHHdx7moolBcCIecaeO5kjSrOa2ZFpfBVhmcz9RSjFInMB7RpItuGhoxSpa
	mzFYrfVRdJH16ZPwyYzKrhMRA+YHMPt+gKaw5tC/PXbZ
X-Google-Smtp-Source: AGHT+IH+F5Q38i7UCDmkQsV6WlBgaRoj4yCnOMzu24AKup4f2fRSoBmYQgCh1aInwGgnBblV97Vpow==
X-Received: by 2002:a17:903:1b6d:b0:223:fd7f:2752 with SMTP id d9443c01a7336-225e0a954abmr24742775ad.29.1741942155363;
        Fri, 14 Mar 2025 01:49:15 -0700 (PDT)
Received: from bytedance ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfb4fsm24959155ad.208.2025.03.14.01.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:49:14 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:48:54 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
Message-ID: <20250314084854.GA1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <c9b1d117-2824-4238-bb8c-6390ec3e931b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b1d117-2824-4238-bb8c-6390ec3e931b@amd.com>

On Thu, Mar 13, 2025 at 11:44:49PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> P.S. I've fixed the wrapped lines and have been testing the series. So
> far I haven't run into any issues yet on my machine. Will report back if
> anything surface.

Thanks a lot for taking the time to review and test.

> 
> I've few comments inlined below.
> 
> On 3/13/2025 12:51 PM, Aaron Lu wrote:
> 
> [..snip..]
> 
> > +static inline void task_throttle_setup_work(struct task_struct *p)
> > +{
> > +	/*
> > +	 * Kthreads and exiting tasks don't return to userspace, so adding the
> > +	 * work is pointless
> > +	 */
> > +	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
> > +		return;
> > +
> > +	if (task_has_throttle_work(p))
> > +		return;
> > +
> > +	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
> 
> Does it make sense to add a throttle work to a delayed task? It may be

I missed the case that a delayed task can still be on cfs_rq and I agree
there is no need to add throttle work to a delayed task.

> dequeued soon and when it is queued back, the throttle situation might
> have changed but the work is unnecessarily run. Could the throttle work
> be instead added at the point of enqueue for delayed tasks?

Yes. If a delayed task gets re-queued and its cfs_rq is in throttled
hierarchy, it should be added the throttle work.

> 
> > +}
> > +
> >   static int tg_throttle_down(struct task_group *tg, void *data)
> >   {
> >   	struct rq *rq = data;
> >   	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> > +	struct task_struct *p;
> > +	struct rb_node *node;
> > +
> > +	cfs_rq->throttle_count++;
> > +	if (cfs_rq->throttle_count > 1)
> > +		return 0;
> > 
> >   	/* group is entering throttled state, stop time */
> > -	if (!cfs_rq->throttle_count) {
> > -		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > -		list_del_leaf_cfs_rq(cfs_rq);
> > +	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> 
> Once cencern here is that the PELT is seemingly frozen despite the
> hierarchy being runnable. I've still not tracked down whether it'll
> cause any problems once unthrottled and all throttled time is negated
> from the pelt clock but is there any concerns here?
 
I chose to do it this way because:
1 I expect most of the time, if a task has to continue to run after its
cfs_rq gets throttled, the time is relatively small so should not cause
much impact. But I agree there can be times a task runs relatively long;
2 I think the original intent to freeze cfs_rq's pelt clock on throttle
is so that on unthrottle, it can retore its loada(without its load being
decayed etc.). If I chose to not freeze its pelt clock on throttle
because some task is still running in kernel mode, since some of this
cfs_rq's tasks are throttled, its load can become smaller and this can
impact its load on unthrottle.

I think both approach is not perfect, so I chose the simple one for now
:) Not sure if my thinking is correct though.

> Maybe this can be done at dequeue when cfs_rq->nr_queued on a
> throttled_hierarchy() reached 0.

Yes, this looks more consistent, maybe I should change to this approach.

> > +	list_del_leaf_cfs_rq(cfs_rq);
> > 
> > -		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> > -		if (cfs_rq->nr_queued)
> > -			cfs_rq->throttled_clock_self = rq_clock(rq);
> > +	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> > +	if (cfs_rq->nr_queued)
> > +		cfs_rq->throttled_clock_self = rq_clock(rq);
> > +
> > +	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
> > +	/*
> > +	 * rq_lock is held, current is (obviously) executing this in kernelspace.
> > +	 *
> > +	 * All other tasks enqueued on this rq have their saved PC at the
> > +	 * context switch, so they will go through the kernel before returning
> > +	 * to userspace. Thus, there are no tasks-in-userspace to handle, just
> > +	 * install the task_work on all of them.
> > +	 */
> > +	node = rb_first(&cfs_rq->tasks_timeline.rb_root);
> > +	while (node) {
> > +		struct sched_entity *se = __node_2_se(node);
> > +
> > +		if (!entity_is_task(se))
> > +			goto next;
> > +
> > +		p = task_of(se);
> > +		task_throttle_setup_work(p);
> > +next:
> > +		node = rb_next(node);
> > +	}
> > +
> > +	/* curr is not in the timeline tree */
> > +	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
> 
> I believe we can reach here from pick_next_task_fair() ->
> check_cfs_rq_runtime() -> throttle_cfs_rq() in which case cfs_rq->curr
> will still be set despite the task being blocked since put_prev_entity()
> has not been called yet.
> 
> I believe there should be a check for task_on_rq_queued() here for the
> current task.

Ah right, I'll see how to fix this.

Thanks,
Aaron

> > +		p = task_of(cfs_rq->curr);
> > +		task_throttle_setup_work(p);
> >   	}
> > -	cfs_rq->throttle_count++;
> > 
> >   	return 0;
> >   }
> > 
> 
> [..snip..]
> 
> -- 
> Thanks and Regards,
> Prateek
> 

