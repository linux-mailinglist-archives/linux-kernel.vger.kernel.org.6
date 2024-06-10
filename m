Return-Path: <linux-kernel+bounces-208815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D3F902981
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFE1F23193
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA8D14E2CC;
	Mon, 10 Jun 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Fp2fBxpL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497461BC39
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049072; cv=none; b=TXeyN8Fn/byk3he9t2+bFeeztgFFjgXHxDltczkfEqja0kL/sXOM6JWlwksyM5CtiF+18p8jWgtQiHbg3Ely7cngNnbYWxmDNVWBYHUiwEwr8uy0b8ACPTrwNYWlMkk8inkzxGueOE4OfoHNSaW1Im+x+gn6pyjimP7+osy7ZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049072; c=relaxed/simple;
	bh=Wzgss8W6RrKndDZzkX94PO/uvvzi+1kSH2P6eOIOV4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQuXkAT/kFVcJofuSKQe2WisS9W9fmJKYvGJx7hP8PlEExlqielbFl7VmXAWJaZWzVtz+fj8V3SdrCrme2ea8NwKA8Epes9d/Bl5oZ7ED5rRzlenJoqBmSPC8TOzfWBv8rRCCrDkXJledM2sjeR3nKC7E+U0QJYJY55BtK0X3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Fp2fBxpL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso3248405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718049069; x=1718653869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fTM/qhjMS0XuQLa4oDkHvgMSQPDJhP3x21CFBI0cVyg=;
        b=Fp2fBxpL5NlNdk/7kZ/2TPVtMMfmZcBdxPJ3UMCPg4IHTSqEJJ1hfhV2Ba1vzXWvbf
         pB0UTWT4tnvHknHEKQJp4EWzv273zF7yFnUkYT/T93GseU1TPqKFS67xEMzCcMKXsYGD
         ep1yhnUDRJn7RpBwb8gd2c8ZChnWMBzv5/mmTCoa1KztmJYP5jkaxiD0gD+LtsxZAWqV
         sKm+Ch39Gg5A97lXZtadV+iE5Pb6lNuceDX7kdv3zp4ZlxG02q3Iq0g1gox81+lUX9n+
         n1KMMJKwBsurpd44gAf0XcgsSFSn3fcYHh/ldvEHwrmhjZZL/g0S5+EsrGtXJ1VXgmZH
         B/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049069; x=1718653869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTM/qhjMS0XuQLa4oDkHvgMSQPDJhP3x21CFBI0cVyg=;
        b=Ol4Xd1sb6OX5Uc1IVe8Ksng6fT62SgE9ffrukSYuDQp0b8bnHtxJ9C4BbV4arPCeLv
         yW8SzvNCj29TLRfAKW2bC4gPkBnTPF/UQtfFD6pVUyW7ry0s5Aqj+xfymAG/z6tXfmdP
         8SaaFBhlFawd3u/tokdNKCgZiah1WoVGp0jzIxPDqZ3yxIiYf3lcnhQ1OAToCiHZy87u
         Zw17yfp6psItylAW+H5QNuIONDDuWnYsRrLWvi2mLLJVa0nbMmvABiGM2z/5JKlHMC7a
         9gcL7+OV4l+Nt9b0Rq1iiVRvuN+nGldH+Z+Zho6HaEeO32YovKtLWE58I8sJ7ZPd/zyq
         RBDg==
X-Gm-Message-State: AOJu0YwGkCm4UPb9QFYdHuO4D/5Jv34dGUVaSTNaKaOVFizWxJHJ78av
	o+pQ5luZ/ChhJpOugoHkixpCwNqOK8oNBXYROA1EyGX8kn7ZyaH4laqCqiFY0WQ=
X-Google-Smtp-Source: AGHT+IHXmREQKLR9prnvlQ9NcyDJ3VOGL9LT6S0aEUMYCCqDN4COTFDy9R36QoNLpzu/aJpIPUB+pQ==
X-Received: by 2002:a05:600c:350f:b0:422:1163:44b2 with SMTP id 5b1f17b1804b1-422116354d0mr16804325e9.7.1718049068435;
        Mon, 10 Jun 2024 12:51:08 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f16c8ded8sm6910046f8f.31.2024.06.10.12.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:51:08 -0700 (PDT)
Date: Mon, 10 Jun 2024 20:51:06 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v10 7/7] sched: Split scheduler and execution contexts
Message-ID: <20240610195106.lsswyuutossuo45q@airbuntu>
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-8-jstultz@google.com>
 <20240604141103.idwodwyeecml4keh@airbuntu>
 <CANDhNCrDqK=hmK3w5P74twM6YFPhp9VKsvSfbcGh1xwO1PjHNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrDqK=hmK3w5P74twM6YFPhp9VKsvSfbcGh1xwO1PjHNQ@mail.gmail.com>

On 06/04/24 12:33, John Stultz wrote:
> On Tue, Jun 4, 2024 at 7:11 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 05/06/24 21:54, John Stultz wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Let's define the scheduling context as all the scheduler state
> > > in task_struct for the task selected to run, and the execution
> > > context as all state required to actually run the task.
> > >
> > > Currently both are intertwined in task_struct. We want to
> > > logically split these such that we can use the scheduling
> > > context of the task selected to be scheduled, but use the
> > > execution context of a different task to actually be run.
> > >
> > > To this purpose, introduce rq_selected() macro to point to the
> > > task_struct selected from the runqueue by the scheduler, and
> > > will be used for scheduler state, and preserve rq->curr to
> > > indicate the execution context of the task that will actually be
> > > run.
> >
> > This is subjective opinion of course. But I am not a fan of rq_selected().
> > I think we are better with more explicit
> >
> >         rq->currs       /* current sched context */
> >         rq->currx       /* current execution context */
> 
> Yeah. While I've got my own opinions, I'm very flexible on names/style
> details if maintainers want it any specific way.
> 
> But just personally, this strikes me as easier to misread, and not as
> descriptive as the "selected" vs the "executing" task.

rq_selected() makes me think we're returning an rq, not a task.

> 
> > and the helpers
> >
> >         task_curr_sctx()
> >         task_curr_xctx()
> 
> Though would rq_curr_sctx() and rq_curr_xctx() make more sense, as
> it's a property of the runqueue (not the task)?

Hmm maybe they could be viewed as property of the runqueue. But I think they
belong to the task. With the current suggestion we are keeping two task
references, one to get the execution context, and the other to get the
scheduling context. But in reality we have one current task, not two. I think
the fact that we look at current task should be a sign that its a property of
the task, not the runqueue otherwise the info should be stored in struct rq
directly.

IOW, rq keeps track of current task, but current task might have its scheduling
properties upgraded due to inheritance. I don't see the latter is a property of
the rq. But rq can help keep track of the two tasks to make accessing the two
properties (scheduling vs execution) easier.

> 
> > This will ensure all current users of rq->curr will generate a build error and
> > be better audited what they are supposed to be. And I think the code is more
> > readable this way.
> 
> So earlier I had changed it to: rq_curr() and rq_selected(), but Peter
> complained about the rq_curr() macro making things indirect, so I
> dropped it (though I kept the rq_selected() macro because it allowed
> things to collapse down better if SCHED_PROXY_EXEC was not
> configured).  I do agree the macro (along with renaming the field)
> helps ensure each use is considered properly, but I also want to align
> with the feedback Peter gave previously.

Yes please, let's wait for the maintainers. Don't want to waste your time with
changes that might not be agreeable for sure :-)

> 
> > Another way to do it is to split task_struct to sched and exec context (rather
> > than control the reference to curr as done here). Then curr would be always the
> > same, but reference to its sched context would change with inheritance.
> >
> > ie:
> >
> >         struct task_sctx {
> >                 ...
> >         };
> >
> >         struct task_struct {
> >                 struct task_sctx *sctx;
> >                 /* exec context is embedded as-is */
> >                 ...
> >         };
> >
> > Which means would just have to update all accessors to sched context to do
> > extra dereference. Which I am not sure if a problematic extra level of
> > indirection.
> >
> > I see the latter approach  more intuitive and explicit about what is a sched
> > context that is supposed to be inherited and what is not.
> 
> Hrm. So I think I see what you're saying. Particularly with the logic
> where we sometimes care about the execution context and sometimes care
> about the scheduler context, I can understand wanting to better define
> that separation with structures.  One thing to note from your example
> above for unblocked tasks, the scheduler and execution contexts can be
> the same. So you'd likely want the task_struct to not just have a
> reference to the scheduler context, but its own internal scheduler
> context structure as well.
> 
> That said, I'm not sure if adding the current scheduler context
> reference into the task struct as you propose above is the right
> approach. Particularly because while this is a generalization of
> priority inheritance, it isn't actually implemented in the same way as
> priority inheritance.  We don't raise and lower the lock owner task's
> priority.  Instead we pick a task from the rq, and if its blocked, we
> traverse the blocked_on chain to find the runnable owner.  So the two
> are really properties of the rq and not really part of the task. And
> remember there can be multiple blocked waiters on a mutex, and they
> can both be used to run the lock owner. So one would have to be

Hmm I would have thought this should still work the same. But we'd end up with
maintaining current's scheduling context. In my head what should different is
what is being updated, rq->currs/rq->currx or rq->curr->sctx.

But you've been looking at this for long enough now and I could be missing
some (many) things for sure.

> setting the owner's scheduler context reference on each selection,
> which seems a bit noisy (I also will have to think about the
> serialization as you may need to hold the rq lock to keep the donor's
> sched context in place (as your crossing task to task), which might be
> an unintuitive/unexpected dependency).

It could be oversimplified in my head..

> 
> Instead as the two contexts are really attributes of the runqueue, it

I guess I am struggling to see the contexts are attributes of the runqueue. The
current task, yes. But what scheduling context the task has, is its own
property the way I see it.

> would seem like one could have what is currently rq_selected() just
> return the struct task_sctx from the selected task (instead of an
> entire task), but that might also cause some annoyance for things like
> debugging (as having both selected and current task's comm and pid
> available together are very useful for understanding what's going on).
> 
> > I generally think breaking down task structure would be good. Hopefully the new
> > data perf can help us make better decision on what attributes to group
> > together. And generally this might be a good exercise to rethink its content
> > which grown organicaly over the year. Maybe we want to create similar such
> > smaller wrapper structs for other fields too.
> >
> > I **think** with this approach we would just need go fix compilation errors to
> > do p->sctx->{attribute}.
> >
> > Proxy exec later would only update the reference to this struct to enforce
> > inheritance for rq->curr->sctx to point to the donor's context.
> 
> I'll need to think about this a bit more (and hopefully others can
> chime in on if they see it as worth it). It would be a *lot* of churn
> to tweak all the users to have the extra structure indirection, so I'm
> hesitant to go running after this without wider agreement. But I do
> see there would be some benefit to avoiding some of the confusion that
> can come from having to deal with two full separate tasks in much of
> the logic.

Don't change anything yet please :-) I could be missing a lot of details. But
I think for now it's good to know why one alternative could potentially be
better than the other without any specific action. It's the type of detail that
can be changed at anytime later - but for me I see these as properties of the
tasks and that's what promoted me to enquire why not done that way instead.

The proposed way does seem the fastest path to get something working, so I am
not against it. But I had to ask if it is the best thing longer term.


Thanks!

--
Qais Yousef

