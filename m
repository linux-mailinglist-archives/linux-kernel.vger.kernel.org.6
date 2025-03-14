Return-Path: <linux-kernel+bounces-561008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AEA60C56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7456A189DEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5A1DC198;
	Fri, 14 Mar 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U1UYqkR8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720032C85
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942641; cv=none; b=QHUyJVMn5bmL9O3+OY2+L50K04SavSg75fwr0oRvFAJVPCRqQwfc3iyRKB2Fg+VheGmn+qK9sWSLsxCES10XaDV5PWf8TaY75boSJMWzKAcgJ4gjt35R90NqRxTiCqmNutFyAvfYMTcQPYkZbTwuaGCNB0Ih8dB3JamOaqNoLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942641; c=relaxed/simple;
	bh=Tlz+4JyveplqUguhzEKW3sCzVDhA3oNQ0nW9bI6BnZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSbRqC2W908NwYzVCN0YAI64UKRinIsZ9Vveug0D0uUiZVymD+XQNLpDV5NiDahtBv09EQWRRvMyTH06wC04L+2R4BTPlGrJ8org/Hu/MrzI/23aFx6UU8RFTybfBTeBzFP912ZSs/015ef1k6e6RZtDe76hIyWT2pTiPkv1LM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U1UYqkR8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239c066347so38676245ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741942637; x=1742547437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiaKvR0kxbaf4pPu409exjMHDDq+NtYqWRmCUcc44FI=;
        b=U1UYqkR8+dfedttcV1MbuypTRDCEk25hxIafYENSougGp5A+VEN0tBugWFUzWSVDrn
         Y8ju7GTnis+hf9ubzWe39qcby+eEoPySFQ6WQz71I3mi2aavf8hJr87p/7MX1zvGDCum
         OsjfqckMHa8SmOgo2uFX1kvbrJw4xBURJOa3762W/JP3e5N8nv3fN5lbhjzBK94Axoy8
         p+ADgXGZ6ubOuYxOR3kD/px1fO8cSPkFMWBTLJe7nDuS4mxJsDPKAGQRZX9bH4RLACzq
         pKwbGxNegTJb9vVknIViY04SMLHLQJNClei2BBiNwXdqr0qMdr/VTO643yfSl6m44lf+
         7jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942637; x=1742547437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiaKvR0kxbaf4pPu409exjMHDDq+NtYqWRmCUcc44FI=;
        b=Wnvc/BfUA15P28yWCbxD5xTkRCy4mtzGhvVhKH9bxNTPCYM262lvQwm8Iu7UyawQKw
         dDFPwW7agICdywZaM3SF6KzE2DmsD0y1fgN9UIXmQbG6+ux9plbYT3OcHa2KwCF80/js
         pRY4FN4V81Zo/caVECLz292U1P3c6L0paROlJsvmGFrLs4oRu5Ju6eKKZaWOBzI6mCwd
         07fiZvTVo7mTh3E+V6Dcd2IYRx28X+tI5o/RgM+Gj3XX+h0cDEs77Y4rX49eYwBO3WlM
         l4N4dAgNtKzZPXlZMaVnloxWZGEy/TyEbeMgR51I2gan6H7mNy18jn33v4yw6ewSxUSm
         jkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAsJMspWiq+SHYCxXd+P9aBKD6ukAi73ulrIzKu+pgqM4MixGAPjQDh4muHemqD8tsi9taF2HcYuJC9S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBKTqC6e0gqXll014Zkk/s3TGVzex6vYqZdbWFYXqoEc4Nw9q
	Bl2Chyy7LSjTpXxFsPlG+WKAEluod4I7anFCHxqvz2f6QOKWDvTndXBY02jVTQ==
X-Gm-Gg: ASbGncvmTv6cQtMVyL3KT9+q9W4xiK6eBlkazMcAs5Qx2jQOb5TK4z3pZcnaXxQdJ7S
	rUDI2bOFdAq98W0Hhx84PFWB0OuU6z3Jn4E8j/bnqCmrvTorSMj4IevBE6K0XmeW+xJ4W1rGwQP
	xAJlVQcVegMzLApf1wjuBES028YPl8Y5VZHKJIF/IFfA0PWMPItN3PnS8QVAHSCGTfRrDnHq3Y9
	nvs83eA2MeC65BCAmUBEW4qzPkeowLZ7YwZmtoN8RFCgqW9f4AIcRCAUo8Adeh4S6gFNCVPg9fR
	GEknjSOYHtGpwLlJvo9uYxGaYzKfneovnhM7258oyLOC
X-Google-Smtp-Source: AGHT+IH65+ikBQ8QAYBYxA40hi3MDN3FgRNsSk3rU/vDJOI7F4DnlQISS6IdbMAg5N6qGAP1PSEzwA==
X-Received: by 2002:a17:902:f545:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-225e0a626b7mr21650295ad.17.1741942637397;
        Fri, 14 Mar 2025 01:57:17 -0700 (PDT)
Received: from bytedance ([115.190.40.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm24837205ad.249.2025.03.14.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:57:16 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:57:09 +0800
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
Message-ID: <20250314085709.GB1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <ddd839a6-916b-4a23-a998-0d44486588ab@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd839a6-916b-4a23-a998-0d44486588ab@amd.com>

On Fri, Mar 14, 2025 at 08:58:14AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/13/2025 12:51 PM, Aaron Lu wrote:
> 
> [..snip..]
> 
> > 
> > +static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
> >   static void throttle_cfs_rq_work(struct callback_head *work)
> >   {
> > +	struct task_struct *p = container_of(work, struct task_struct,
> > sched_throttle_work);
> > +	struct sched_entity *se;
> > +	struct cfs_rq *cfs_rq;
> > +	struct rq *rq;
> > +	struct rq_flags rf;
> > +
> > +	WARN_ON_ONCE(p != current);
> > +	p->sched_throttle_work.next = &p->sched_throttle_work;
> > +
> > +	/*
> > +	 * If task is exiting, then there won't be a return to userspace, so we
> > +	 * don't have to bother with any of this.
> > +	 */
> > +	if ((p->flags & PF_EXITING))
> > +		return;
> > +
> > +	rq = task_rq_lock(p, &rf);
> 
> nit. With CLASS(task_rq_lock, rq_guard)(p), you can fetch the rq with
> "rq_gurad.rq" and the "goto out_unlock" can be replaced with simple
> return.

Got it, thanks for the suggestion.

> > +
> > +	se = &p->se;
> > +	cfs_rq = cfs_rq_of(se);
> > +
> > +	/* Raced, forget */
> > +	if (p->sched_class != &fair_sched_class)
> > +		goto out_unlock;
> > +
> > +	/*
> > +	 * If not in limbo, then either replenish has happened or this task got
> > +	 * migrated out of the throttled cfs_rq, move along
> > +	 */
> > +	if (!cfs_rq->throttle_count)
> > +		goto out_unlock;
> > +
> > +	update_rq_clock(rq);
> > +	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> > +	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> > +	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);> +	resched_curr(rq);
> > +
> > +out_unlock:
> > +	task_rq_unlock(rq, p, &rf);
> >   }
> > 
> >   void init_cfs_throttle_work(struct task_struct *p)
> > @@ -5873,32 +5914,81 @@ static int tg_unthrottle_up(struct task_group
> > *tg, void *data)
> >   	return 0;
> >   }
> > 
> > +static inline bool task_has_throttle_work(struct task_struct *p)
> > +{
> > +	return p->sched_throttle_work.next != &p->sched_throttle_work;
> > +}
> > +
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
> 
> General question: Do we need the throttled_lb_pair() check in
> can_migrate_task() with the per-task throttle? Moving a throttled task
> to another CPU can ensures that the task can run quicker and exit to
> user space as quickly as possible and once the task dequeues, it will
> remove itself from the list of fair tasks making it unreachable for
> the load balancer. Thoughts?

That's a good point.

The current approach dequeued the task and removed it from rq's
cfs_tasks list, causing it lose the load balance opportunity. This is
pretty sad.

I'll need to think about this. I hope we can somehow keep the throttled
tasks in cfs_tasks list, I'll see how to make this happen.

Thanks,
Aaron

> > 
> >   	/* group is entering throttled state, stop time */
> > -	if (!cfs_rq->throttle_count) {
> > -		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > -		list_del_leaf_cfs_rq(cfs_rq);
> > +	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
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

