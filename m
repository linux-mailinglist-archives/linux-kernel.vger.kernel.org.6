Return-Path: <linux-kernel+bounces-337176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1398464F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E27F1F2443C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB771A7AC6;
	Tue, 24 Sep 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mn88kQhM"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD551A7265
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182868; cv=none; b=FO7ySbheedMftWKBJeIoAcXqOEG86mkWVONYLloU9MOqk/tL6uvLPx1q5f3hzFZTI/o7/o+AbZ6QqfjY4hfwMhuvG56mFRjwlI/yeuy4ESihMancB7egpCrI5jnf+b9yU7IvIltIKgDAAgybw2mWvsFYY3B11ZBUZytVY6lOySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182868; c=relaxed/simple;
	bh=qw22qbkopgs2Th+vBhrRAbcNFBETeab0zxWc1kdzaQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgrivF/WPT//3NXgL25KcwqQRJqIDX25MDHsGtv/q+3lByNu/m4JrrMQOgRsrb17baWA0VaCApB1as8f0hISy3fqRayvgpP9DujGKer5hsdGFdYAhteMlS0o2r79msQ/lKO7A33VkMPL3RjHKchr/BOuSP7dPE24K2se0j+hVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mn88kQhM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so3590399a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727182866; x=1727787666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htWWLJM4EsHdz/pR2CIXXvdnZw2zxHmQSomoN2+D/tk=;
        b=mn88kQhMTaQyRDbs4jTexNe7lkvCRZmFq/HpV/bNtpZabWJYS0fWcR6bnrSliu1l7R
         SvXHPERgkD2WGtBCM/7/ogkjGn40c0LiGIqbm5WD8KhAXV+yp8RsqJ3CHPtJNnPDN4Ag
         065/X0M2040Rui/uNVXtL9c/lPoc0Gzr8gA2uSey1pgdk6PFgLgcQcF/Hz8zYF41tDas
         x7G8bVma+qMHPT2D6XrGFF8x6iqnA0UjQwjKIhWykZvcd4VtmNv59k6L7zGaOToTZ2+1
         rZ8Pi+lPDVdKfCh+/Dhs3dxJMWzChABtcE8htffLiyYyvfF49qgK/ySFnmvnD88h3/qf
         i5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182866; x=1727787666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htWWLJM4EsHdz/pR2CIXXvdnZw2zxHmQSomoN2+D/tk=;
        b=EigXDdhqRjXtUqXNvgHaNSyIj33ShZ6dBuZDL3qnI5nwhEbCBZZnHjbxZFe4tUUo4g
         h08UIoglHztT+JzelQrU30FCr0wJ6XFw6YA0k6Cay1qnXYYB3K819ouE2Z/nChKaPeID
         hKMArpYob4uLCb8YR1cu/WlhcPvPXDBfyh0dRxFZaoT452FdRIHy9EFO9lXeF37zSCmw
         KjTbzIs+54CxGjuFT06bvS5HVxV9iDuch5bXU9FEXGJDCi1Hv+bXXTW1IDT5IjCy5dtJ
         2TiOAHgOP5ik7h8/jtPRZdoNQvZvqkSFYKbIT7tDWejV53EI7Y9X1cK20ruaNALsLMvD
         gZkA==
X-Forwarded-Encrypted: i=1; AJvYcCXgs6SQHelQ/nYyfjQNDcmMEqcJVWG+yvj/wN+J+Wo3rKyBPqHfMqRepssFXtSXLQW2yG+XNOp3fh5lYgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAt3/1OwglBy/JUySkDE1R5z6JU/XMaHr3p9j51AYYc1NesY8s
	XFikGLmORePI4ujuL7r30mP3HgclwtGwYavceV89X9St20XqtUJ+lXJD4j0ukKLMuUtJTmd3IoS
	auqMn8nWQhbIssNcD0lOAqMFWvI20kPT/dbJe9A==
X-Google-Smtp-Source: AGHT+IE0MHK9d/IYdNSmedh0leD/l3s4TzyfJ49CSx2TV+btNyB4bEqpM/R38wi+CjO3hKBLN7+BcSKug/SAFaRN0qo=
X-Received: by 2002:a17:90a:c70d:b0:2dd:4f6b:6394 with SMTP id
 98e67ed59e1d1-2dd80c7ecc7mr18695546a91.19.1727182865892; Tue, 24 Sep 2024
 06:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-6-vincent.guittot@linaro.org> <ff2be1d5-ace4-4d8a-9894-4ccc16c84d06@arm.com>
In-Reply-To: <ff2be1d5-ace4-4d8a-9894-4ccc16c84d06@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Sep 2024 15:00:52 +0200
Message-ID: <CAKfTPtCEM4A+-6FWEb1ncMSObgqBbcs7EWc5Xwk+KpHJBRRw9A@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 18:08, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 8/30/24 15:03, Vincent Guittot wrote:
> > EAS is based on wakeup events to efficiently place tasks on the system, but
> > there are cases where a task will not have wakeup events anymore or at a
> > far too low pace. For such situation, we can take advantage of the task
> > being put back in the enqueued list to check if it should be migrated on
> > another CPU. When the task is the only one running on the CPU, the tick
> > will check it the task is stuck on this CPU and should migrate on another
> > one.
> >
> > Wake up events remain the main way to migrate tasks but we now detect
> > situation where a task is stuck on a CPU by checking that its utilization
> > is larger than the max available compute capacity (max cpu capacity or
> > uclamp max setting)
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c  | 211 +++++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/sched.h |   2 +
> >   2 files changed, 213 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e46af2416159..41fb18ac118b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
>
> [...]
>
> > +
> > +static inline void check_misfit_cpu(struct task_struct *p, struct rq *rq)
> > +{
> > +     int new_cpu, cpu = cpu_of(rq);
> > +
> > +     if (!sched_energy_enabled())
> > +             return;
> > +
> > +     if (WARN_ON(!p))
> > +             return;
> > +
> > +     if (WARN_ON(p != rq->curr))
> > +             return;
> > +
> > +     if (is_migration_disabled(p))
> > +             return;
> > +
> > +     if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))
>
> If the goal is to detect tasks that should be migrated to bigger CPUs,

We don't want the tick to try to do active migration for the running
task if the task can't run on another CPU than this one. This is not
related to the migration to bigger CPUs that is done by
update_misfit_status().

> couldn't the check be changed from:
> -  (p->nr_cpus_allowed == 1)
> to
> - (p->max_allowed_capacity == arch_scale_cpu_capacity(cpu))
> to avoid the case where a task is bound to the little cluster for instance ?

I was about to say yes, but the condition
(arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity) is too large
and prevents migrating to a smaller cpu which is one case that we want
to handle here.  That being said I have an internal patch that
includes the check done by update_misfit_status() for push callback
mechanism but I didn't add it in this version to not add to much
change in the same serie.

>
> Similar question for update_misfit_status(), doesn't:
> - (arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity)
> include this case:
> - (p->nr_cpus_allowed == 1)

For update_misfit_status, you are right

>
>
> > +             return;
> > +
> > +     if (!task_misfit_cpu(p, cpu))
> > +             return;
>
> task_misfit_cpu() intends to check whether the task will have an opportunity
> to run feec() though wakeups/push-pull.
>
> Shouldn't we check whether the task fits the CPU with the 20% margin
> with task_fits_cpu() aswell ? This would allow to migrate the task
> faster than the load_balancer.

As mentioned above I have a patch that I didn't send that adds the
update_misfit_status() condition in the push call. I agree that should
speedup some migrations of misfit task to bigger cpu without waking up
an idle CPU to do the load balance and pull the task on a potentially
3rd CPU

>
>
> > +
> > +     new_cpu = find_energy_efficient_cpu(p, cpu);
> > +
> > +     if (new_cpu == cpu)
> > +             return;
> > +
> > +     /*
> > +      * ->active_balance synchronizes accesses to
> > +      * ->active_balance_work.  Once set, it's cleared
> > +      * only after active load balance is finished.
> > +      */
> > +     if (!rq->active_balance) {
> > +             rq->active_balance = 1;
> > +             rq->push_cpu = new_cpu;
> > +     } else
> > +             return;
> > +
> > +     raw_spin_rq_unlock(rq);
> > +     stop_one_cpu_nowait(cpu,
> > +             active_load_balance_cpu_stop, rq,
> > +             &rq->active_balance_work);
> > +     raw_spin_rq_lock(rq);
> > +}
> > +
>
> Regards,
> Pierre

