Return-Path: <linux-kernel+bounces-219743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16190D72A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C831F22397
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678694D8B1;
	Tue, 18 Jun 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="iH3wd7kI"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A046521
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724246; cv=none; b=NLfW5flmXiLtKBGdQMlQZTWcCy2qk28VKu8GGiZZRJ2hzJaAKBGleFBp8QgXIu6Qmy8TklNhQ4nZwik9C85+Se3s6zhcEPCQ3ccLUoqS/7ccZ4Ika6js841UhGg3fw/8wecop+JrtzbjW43sDVZq5nRcSOU1AxsA4iYEPLam0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724246; c=relaxed/simple;
	bh=lGAZT73tq+8x6YKBw/jmW4/L+cnmkO1lH+9vvmZyUFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGEWdcXkPbHEJv0lW43LI3rgHlNsPPdog93Sk79YMLR6OeGTkZUDHP7lM87caBhFxCHmGKk0t3uFVQ4cjOna0nTLCI3cidL8EUFOhGofvvGWC1ARfqaGMxiMpnv7g82G4+Wty2u2aZkQskK5o+iiAN+M/rZmWxaGkO63W8wMP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=iH3wd7kI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4829760f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718724243; x=1719329043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6J6o4zzrtXufCFtxTWSP5jRT8mGj14QoDpJgc9Joceo=;
        b=iH3wd7kIh4zFbYi7cEHWBLYxyviKrS2UALUHYSNM9tk9EJY5FEOCWDrccThCaLqo8s
         dJPg2sDE+whPnLT/gx2MkxqDkUoxAcin91lKXapwoLz2QI/WtOyg6InelEIkneyczt9d
         nmaGr5XcLEn+ODiT8BJ/bWT+RQKSwFT8W3tUg8aZywm/r6wUaHhmB7IcJTot8+CPfteI
         4v7dgSIetXvwawgWIep6BMPHkd1edHm+5CSh0vaTkPYP1xPzBKPYVGFatlEdoC08CQOY
         5KJKSOM0VRUQRoVLVpVjC5pFq7hOnOwOZo4W+zh5lPqhu6lJSPgTgpGX/XeHAUiUvZI5
         XeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724243; x=1719329043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J6o4zzrtXufCFtxTWSP5jRT8mGj14QoDpJgc9Joceo=;
        b=rXW7s9Rn6bcT7Y2KiOU+xUN3/Fa/sgD48Yg7vSwY8xET+ZRnLcN06T56Tusj60TboF
         IjtVppunds4hyhgKYfZFr7Y5qsKyLIDItDPtJWe46X7vQLSWLZAA5/H65RE162iaSdn8
         5jJtrt+SCLQ8VrIxrHLGOQJDC+2SLchNLpJVnQrLuDECvnXPwyrYGASwBIMc9tSmk56N
         vZRSt9N4VKdulfTu7BWPot5eZmbCdqSksXvnLijQmmOmPG/QJGvTZPqzIRw1WDWxnWso
         +B7+xvk3jX4KxYLdTfX8R4D0Zmzlr2u2HQcJQpJFOSSNPUB4mk3dS4QAorKP7eOtiI8D
         Ul1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5Uk4awdYNOWuTBBVTGZl6dSxHrYXFQnaRBB/RMU1jPSiDa/cz58BQMHy2U/fhS68ok4Y0CbT6Dlu8CSLTMejxAUPMAuwX1ZQcNZTu
X-Gm-Message-State: AOJu0Yyh2MKV1G8pWJo01kkySlIhvMR/JfX+Q6+XdN5mOr7gcf7s9Y7a
	rwMLNDaYk6T1ySQZGUzD7WfrTY6PLRIE4BXSqRusIuPUCAYKTSjU7JcNTNKCBsk=
X-Google-Smtp-Source: AGHT+IFxWeYw366FJhku/o4kTWirRDtrUARGgxRfIzNpWXo+V1gqMCPItQYoH7eIHDEunAhpIdUBMQ==
X-Received: by 2002:a5d:59a3:0:b0:360:827f:1c3e with SMTP id ffacd0b85a97d-360827f1f6dmr9847529f8f.3.1718724242919;
        Tue, 18 Jun 2024 08:24:02 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509353csm14368212f8f.22.2024.06.18.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:24:02 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:24:01 +0100
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
Message-ID: <20240618152401.flylbc5ye2ch54j4@airbuntu>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
 <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <20240616223616.im3tlh6jheadlhnz@airbuntu>
 <20240618070412.GA31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618070412.GA31592@noisy.programming.kicks-ass.net>

On 06/18/24 09:04, Peter Zijlstra wrote:
> On Sun, Jun 16, 2024 at 11:36:16PM +0100, Qais Yousef wrote:
> 
> > > Which then gets me something like the (completely untested) below..
> > > 
> > > Hmm?
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0935f9d4bb7b..36aed99d6a6c 100644
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
> > > +	psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> > > +
> > >  	rq_lock(rq, &rf);
> > >  
> > >  	update_rq_clock(rq);
> > > @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> > >  		++*switch_count;
> > >  
> > >  		migrate_disable_switch(rq, prev);
> > > +		psi_account_irqtime(prev, next, &rq->psi_irq_time);
> > 
> > Hmm are prev and next swapped here? next == curr in my view if there's no
> > subtly I missed
> 
> This is before context_switch() so prev == current at this point.
> However, more importantly, the PSI thing accounts to its 'curr' group
> and that should very much be the outgoing task's group in this case.
> 
> That is, we need to make sure the outgoing group is up-to-date before
> switching to a new group.
> 
> Makes sense?

Yes, thanks! After reviewing the patch though I wondered if we care to handle
when the group changes while we're RUNNING. There will be no __schedule() then.
But it's a matter of how accurate this is supposed to be. In sched_move_task()
we dequeue with DEQUEUE_NOCLOCK which IIUC would have not caused
psi_account_irqtime() to be called on the move already. So we're doing the
same.

We can still maybe move this to sched_change_group() (keeping the psi group
change check you added)? This still LGTM anyway, but thought I'll spill it out.

> 
> > >  		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
> > >  
> > >  		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 146baa91d104..65bba162408f 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -991,22 +991,31 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
> > >  }
> > >  
> > >  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> > > -void psi_account_irqtime(struct task_struct *task, u32 delta)
> > > +void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time)
> > >  {
> > > -	int cpu = task_cpu(task);
> > > +	int cpu = task_cpu(curr);
> > >  	struct psi_group *group;
> > >  	struct psi_group_cpu *groupc;
> > > -	u64 now;
> > > +	u64 now, irq;
> > > +	s64 delta;
> > >  
> > >  	if (static_branch_likely(&psi_disabled))
> > >  		return;
> > >  
> > > -	if (!task->pid)
> > > +	if (!curr->pid)
> > > +		return;
> > > +
> > > +	group = task_psi_group(curr);
> > > +	if( prev && task_psi_group(prev) == group)
> > 
> > nit: whitespace misplaced
> 
> Ha!, is that's all and it all works in one go it's awesome :-)
> 
> I'm still trying to learn to type again after switching keyboards. I've
> used a thinkpad keyboard (either on an actual laptop or the travel
> version on my desktop for nearly 20 years... Now I've picked up a split
> keyboard out of necessity (UHK 60 v2 for those interested) and muscle
> memory is still cursing me every single day.

I failed to use those split keyboards..

> 
> As a result, I now also cannot type on my laptop anymore, so lose-lose I
> suppose ... urgh.

You mean you're not using AI yet?! :-O

> 
> > LGTM otherwise.
> > 
> > Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 
> Thanks!
> 
> John, can you write up a changelog with some pretty numbers and all
> that? Also, when you re-post, can you make sure to Cc the PSI folks
> (johannes and suren iirc, get_maintainers.pl seems to find them).

