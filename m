Return-Path: <linux-kernel+bounces-216523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A3790A086
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CA5B212AE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114736A03F;
	Sun, 16 Jun 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SW+RRZy3"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EC14AA0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577382; cv=none; b=p26+t68gz1I9597d1PT5MNfkAF3f/1uG8fjAcQ6+eh92RJr5NYfugfCMLbGMN+AX154b51qSSjOh8hLq7ezE3z7ch4QM9Ozb37y3TrodS3WztxsVp3KQLV4MWKZXFX2YBonIXA2/jr0EmqeqyZuDTDxlSI6k/Nv9TIcJDHtCt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577382; c=relaxed/simple;
	bh=T3NhWthJWz4r1HX1HYosQ5cCAv28QDff8ikJI6bSsok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9KZTvzGfsYX3CrH8KatjW45mSofczTJCNTVD9SldkjC2+FE9L0t72ctkpteBUxOL0S3AUGNLC//btrY+yDWse3jCJl5yJxTzzG0wrinSHu4v4/dynenAeTMFk6/Oln31IPHJ9/5JaWSuNuoEptzJLLFA0KvuO5FJnMYqkjNai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=SW+RRZy3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so39373451fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718577378; x=1719182178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMpwNaihWVYr/8gWTWETi0OGOrxuGT0d1jHxTdmuHfs=;
        b=SW+RRZy38GSdto0nHPrX38mPZuLpa+jwcAOsGoe4TGY/QPCakObsxV9zUl0nUd5jiO
         ioDUCeP1NEav8gBEYr4gOlzqeQZItJdrdGK4hRGgHqc01X5KkNnK5UD7WGGbtjXGnFO2
         FnLb+uk3CR3aBuYeOYVWmosvwwA8b7mDdxiaVToqP/2xYNNb/t4DHDc8RWGVxEdKxSwD
         3tFx+xFIZUByJnpLbaII+93ZJI/NX+KbdXRDHF6I3ctjRX8VbJFNK2RQgp7Lc6XuWOR4
         jfKBEgO7eHY+29IGNLe5n8brRzZkaS+/HTdg/go0lCjGuHE4RrkVgXsJWOgf+jUH7TUq
         PVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718577378; x=1719182178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMpwNaihWVYr/8gWTWETi0OGOrxuGT0d1jHxTdmuHfs=;
        b=ednDm+KpQSCscft+Af4hFFyO61lb8udvaEiEsRj6wu9pwHDXWCTPFfLPaD3pB2Ytsh
         fc90zcx3t9J8KiHQ8V4iIxa9tO+kQtazA6n13mgLwpL/XKJsf6cS0nQhJb7KmOFvZcpQ
         Wla1DlLf4arbY3EO224dNmt5X+71l+bINfHwmlnjRzVMabNUbn0M5xUWqWwNUcFJJ0Ln
         gmB/2Tsq5MlNJ7+4F8aTTT5C6XNQqcnHya38ulvKmO7t4fP3LoNBXS+q7dn3Ibum+edx
         EvjdS50caYmuFzhJsYQF/aQDeRzNRtpnaCCoNwoadRW85Urix2johcNDg69MZgAt2P5F
         wcig==
X-Forwarded-Encrypted: i=1; AJvYcCXWxHmaVWZjEIJAlsR4D9iku1iznBNhPJy3ydOm1rhG3k1T/fcmpZXAeLeEMbiVDz2CiM6ucLqabn4NA9RYMNnRG9Bc99QIL3vw8mK6
X-Gm-Message-State: AOJu0YwPnd9jH2/PwBoeH/IhsqGbqMtkT9CD3Amx680T0eKRESPyy0mM
	yMVZapi+AHIMsnLmJ16ccT+n4od5C31uLWRr3M+8q7H6oY0ia1ArJc9hmKKFByI=
X-Google-Smtp-Source: AGHT+IGVApgaj6HQ+JGfgoYD0Y0RHD/vMAnBxwDmDJmUqyEmUAmHgJgFXL1FjFfZWMagRIP/CRDdsQ==
X-Received: by 2002:a05:651c:221f:b0:2ec:1042:fafc with SMTP id 38308e7fff4ca-2ec1042fbdemr63789971fa.0.1718577378233;
        Sun, 16 Jun 2024 15:36:18 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8b7sm10426424f8f.26.2024.06.16.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 15:36:17 -0700 (PDT)
Date: Sun, 16 Jun 2024 23:36:16 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240616223616.im3tlh6jheadlhnz@airbuntu>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
 <20240614094833.GM8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614094833.GM8774@noisy.programming.kicks-ass.net>

On 06/14/24 11:48, Peter Zijlstra wrote:
> On Thu, Jun 13, 2024 at 12:51:42PM +0100, Qais Yousef wrote:
> > On 06/13/24 12:04, Peter Zijlstra wrote:
> > 
> > > ---
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0935f9d4bb7b..d4b87539d72a 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> > >  
> > >  	rq->prev_irq_time += irq_delta;
> > >  	delta -= irq_delta;
> > > -	psi_account_irqtime(rq->curr, irq_delta);
> > >  	delayacct_irq(rq->curr, irq_delta);
> > >  #endif
> > >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> > >  
> > >  	sched_clock_tick();
> > >  
> > > +	psi_account_irqtime(curr, &rq->psi_irq_time);
> > > +
> > 
> > If wakeup preemption causes a context switch, wouldn't we lose this
> > information then? I *think* active migration might cause this information to be
> > lost too.
> 
> I'm not sure what would be lost ?! the accounting is per cpu, not per
> task afaict. That said,...

Yes sorry I mixed this with per task accounting..

> 
> > pick_next_task() might be a better place to do the accounting?
> 
> Additionally, when there has been an effective cgroup switch. Only on
> switch doesn't work for long running tasks, then the PSI information
> will be artitrarily long out of date.
> 
> Which then gets me something like the (completely untested) below..
> 
> Hmm?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..36aed99d6a6c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  
>  	rq->prev_irq_time += irq_delta;
>  	delta -= irq_delta;
> -	psi_account_irqtime(rq->curr, irq_delta);
>  	delayacct_irq(rq->curr, irq_delta);
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> @@ -5459,6 +5458,8 @@ void sched_tick(void)
>  
>  	sched_clock_tick();
>  
> +	psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> +
>  	rq_lock(rq, &rf);
>  
>  	update_rq_clock(rq);
> @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  		++*switch_count;
>  
>  		migrate_disable_switch(rq, prev);
> +		psi_account_irqtime(prev, next, &rq->psi_irq_time);

Hmm are prev and next swapped here? next == curr in my view if there's no
subtly I missed

>  		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>  
>  		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 146baa91d104..65bba162408f 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -991,22 +991,31 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  }
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -void psi_account_irqtime(struct task_struct *task, u32 delta)
> +void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time)
>  {
> -	int cpu = task_cpu(task);
> +	int cpu = task_cpu(curr);
>  	struct psi_group *group;
>  	struct psi_group_cpu *groupc;
> -	u64 now;
> +	u64 now, irq;
> +	s64 delta;
>  
>  	if (static_branch_likely(&psi_disabled))
>  		return;
>  
> -	if (!task->pid)
> +	if (!curr->pid)
> +		return;
> +
> +	group = task_psi_group(curr);
> +	if( prev && task_psi_group(prev) == group)

nit: whitespace misplaced

LGTM otherwise.

Reviewed-by: Qais Yousef <qyousef@layalina.io>

>  		return;
>  
>  	now = cpu_clock(cpu);
> +	irq = irq_time_read(cpu);
> +	delta = (s64)(irq - *time);
> +	if (delta < 0)
> +		return;
> +	*time = irq;
>  
> -	group = task_psi_group(task);
>  	do {
>  		if (!group->enabled)
>  			continue;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 62fd8bc6fd08..a63eb546bc4a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1133,6 +1133,7 @@ struct rq {
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  	u64			prev_irq_time;
> +	u64			psi_irq_time;
>  #endif
>  #ifdef CONFIG_PARAVIRT
>  	u64			prev_steal_time;
> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index d1445410840a..1e290054c5db 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -110,7 +110,7 @@ __schedstats_from_se(struct sched_entity *se)
>  void psi_task_change(struct task_struct *task, int clear, int set);
>  void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		     bool sleep);
> -void psi_account_irqtime(struct task_struct *task, u32 delta);
> +void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time);
>  
>  /*
>   * PSI tracks state that persists across sleeps, such as iowaits and
> @@ -192,7 +192,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
>  static inline void psi_sched_switch(struct task_struct *prev,
>  				    struct task_struct *next,
>  				    bool sleep) {}
> -static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
> +static inline void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time) {}
>  #endif /* CONFIG_PSI */
>  
>  #ifdef CONFIG_SCHED_INFO
> 
> 
> 

