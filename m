Return-Path: <linux-kernel+bounces-260355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B552293A7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68851C22633
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C491422CC;
	Tue, 23 Jul 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMJxIuwW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645913D628
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763257; cv=none; b=M9mZFKclYwpbo25aTMiT4eXr0gqmGESzrACSTJ4Y85nuI+vsnX6jhfFeoIoMqV+I2QK7xj8y3lD4MsOkxGTHQ4fyvo1DC+mkRPsoPQLmTgK0Ru7vOzz3uE59THNpX6y4+YKU6tGuOCOtMcmYZBNYaWXtdZ/lbFR4STmQA1hyS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763257; c=relaxed/simple;
	bh=z8FgQvecvtNHGieM2KnvwOh/LbU5Hgk7Qe0Yf+O57bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsnb3D6qvZ0Fyd5CP7xOV/I4UeoW/L/t6TgYycEn9bqTgmd1KeKLDo+2ya3GHfRwvtErpfxaSTqEVfnjDHVsd5yUcMDgeGBbXFUdO9F4L7iucC84VJ6Gnzf4VbSieQDjy/5JR4LrXI4WrG7YWWBVrbUwNcsp1IZezVYDuDOSmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMJxIuwW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso1794990b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721763255; x=1722368055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MQsN4CntdndYNDyxb/mylMwtOD4tugKzH3GvbqW5dc=;
        b=iMJxIuwWMREJmHCqiFSdYYPt/cl4l7ERGFpLBrt2peiA3FWzSfkGrObW2oyfFyMtxZ
         R0BUUNC0x2FuG/i3kgSJvVE5Hve3KzzLNdSWJvZmyFjsqP6JzF0dZMvdX7jJM2cDo39G
         mc2zDXNFUEcGnepmsERGytNVV9zvDdOHaLCy14KoTOSeCU5hPmEVnIxS2JsubdpvKPx5
         hTDyS/CBcd+svh+eGbvLcoqL0xN/+TLXFrjZ8hABD6E3RtREkd+6B3yx+6LdnPGwcZxR
         hvFI3O5x5gGu8JyF12FoRGrS+r1meCcgmpJr87cWAwwJ0hInCTRSj5BHZa1rciPlavAx
         DYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721763255; x=1722368055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MQsN4CntdndYNDyxb/mylMwtOD4tugKzH3GvbqW5dc=;
        b=S3W/3z+UeP4ya4pmEGFrQVkqCfoych3Yks9AMvWKxeSyFvO2aumC5hfoMtKI2ZOlP8
         Y23dJo8vxhnLag84Qzj4wjwRiZUkK7hi/+f1/e9YeiVtOKZ6tSZNd6VxMvvWcPPadAHA
         Uyehx1/RAlaaQUqS66u8qkPYXTaoqDp00iObA6cowERg38qdVvPD/hh7M0DgGLJrmXV5
         qXy+9OPgNbfx3iKjB/2dCpbShKvwdqFsSM6joI0PiCW2LzZnDYs2YIG+4HUGPNaiz5Gn
         Fq5L+I0znd4DuUqt/V4YEB5geX01WuFbEKzTDlA3wou7h1WMM2Rh0w4tqju9RBx0FXBX
         L0pA==
X-Forwarded-Encrypted: i=1; AJvYcCVcqIDVSx9S+sbW2oeOZLC+/x7kCS8RJOb4HGyLbymio4MoiED68FjslS7on3GCEepq4dz1oQ+3j5SFkm0ffErNHYizEGnx3rJNpkN2
X-Gm-Message-State: AOJu0YyHbA5Ry8bDFEYGfQs23cHO9k/VR+caslVBq3ztZWlLZOq2rAu1
	RBNL3zMGy5lpA9VucfNHoVVo6hZEMQLMTHdks30rPj8BWl7GyZ6/
X-Google-Smtp-Source: AGHT+IEAiqxNxysHAOGE6NTaRjbYhqeC/dl3azrrWGpZ55ZUVQjSaMud2u/lDJ9Yj1xTm+OftxRr5w==
X-Received: by 2002:a05:6a21:910c:b0:1c0:f4b9:f7fd with SMTP id adf61e73a8af0-1c45e5959fdmr1067348637.4.1721763254941;
        Tue, 23 Jul 2024 12:34:14 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf808f082sm9445503a91.44.2024.07.23.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:34:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jul 2024 09:34:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723163358.GM26750@noisy.programming.kicks-ass.net>

Hello, Peter.

On Tue, Jul 23, 2024 at 06:33:58PM +0200, Peter Zijlstra wrote:
> >  	/*
> > -	 * If there are no DL,RR/FIFO tasks, there must only be CFS tasks left;
> > -	 * if there's more than one we need the tick for involuntary
> > -	 * preemption.
> > +	 * If there are no DL,RR/FIFO tasks, there must only be CFS or SCX tasks
> > +	 * left. For CFS, if there's more than one we need the tick for
> > +	 * involuntary preemption. For SCX, ask.
> >  	 */
> > -	if (rq->nr_running > 1)
> > +	if (!scx_switched_all() && rq->nr_running > 1)
> > +		return false;
> > +
> > +	if (scx_enabled() && !scx_can_stop_tick(rq))
> >  		return false;
> >  
> 
> Doesn't that boil down to something like:
> 
> 	if (scx_switched_all())
> 		return scx_can_stop_tick(rq);
>
> 	if (rq->nr_running > 1)
> 		return false;

Yeah, given that rq->nr_running == 1 && partial enabling condition is
unlikely to matter and can easily lead to misdetermination by the BPF
scheduler, the suggested code is better and cleaner. I'll update.

> > @@ -5773,7 +5827,19 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> >  				  struct rq_flags *rf)
> >  {
> >  #ifdef CONFIG_SMP
> > +	const struct sched_class *start_class = prev->sched_class;
> >  	const struct sched_class *class;
> > +
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +	/*
> > +	 * SCX requires a balance() call before every pick_next_task() including
> > +	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
> > +	 * from SCX instead.
> > +	 */
> > +	if (sched_class_above(&ext_sched_class, start_class))
> > +		start_class = &ext_sched_class;
> 
> 	if (scx_enabled() && ...)
> 
> ?

Will add.

> > @@ -5782,7 +5848,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> >  	 * We can terminate the balance pass as soon as we know there is
> >  	 * a runnable task of @class priority or higher.
> >  	 */
> > -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> > +	for_active_class_range(class, start_class, &idle_sched_class) {
> >  		if (class->balance(rq, prev, rf))
> >  			break;
> 
> Don't you need fixing balance_fair() here? It has:
> 
>   if (rq->nr_running)
>     return 1;
> 
> Which would return true and terminate the iteration even if there are
> only scx tasks left.

Right, that will lead to issues in partial mode. I think it hasn't been
noticed because tasks were being consumed through otherwise empty CPUs. Will
fix.

...
> > +	for_each_active_class(class) {
> >  		p = class->pick_next_task(rq);
> > -		if (p)
> > +		if (p) {
> > +			const struct sched_class *prev_class = prev->sched_class;
> > +
> > +			if (class != prev_class && prev_class->switch_class)
> > +				prev_class->switch_class(rq, p);
> >  			return p;
> > +		}
> >  	}
> 
> So I really don't like this one.. at the very least it would need a comment
> explaining why it only needs calling here and not every time a put_prev_task()
> and set_next_task() pair cross a class boundary -- which would be the
> consistent thing to do.
> 
> Now, IIRC, you need a class call that indicates you're about to loose the CPU
> so that you can kick the task to another CPU or somesuch. And last time I got
> it backwards and suggested adding an argument to pick_next_task(), but what
> about put_prev_task()?
>
> Can't we universally push put_prev_task() after the pick loop? Then we get
> something like:

Yeah, the problem with put_prev_task() was that it was before the next task
was picked, so we couldn't know what the next class should be.

> 	next = pick_task();
> 	if (next != prev) {
> 		put_prev_task(rq, prev, next->class != prev->class);
> 		set_next_task(rq, next);
> 	}
> 
> I have patches for most of this for fair (in my eevdf queue), and I
> think the others are doable, after all, this is more or less what we do
> for SCHED_CORE already.
> 
>   /me went off hacking for a bit
> 
> I've done this; find the results at: queue.git sched/prep
> 
> I've also rebased the sched_ext tree on top of that with the below delta, which
> you can find at: queue.git sched/scx

Hmm... took a brief look, but I think I'm missing something. Doesn't
put_prev_task() need to take place before pick_task() so that the previously
running task can be considered when pick_task() is picking the next task to
run?

> This led me to discover that you're passing the task of the other class into
> the bpf stuff -- I don't think that is a sane thing to do. You get preempted,
> it doesn't matter from which higher class or by which specific task, a policy
> must not care about that. So I kinda bodged it, but I really think this should
> be taken out.

At least for visibility, I think it makes sense. One can attach extra BPF
progs to track the preemption events but it can be useful for the scheduler
itself to be able to colllect when and why it's getting preempted. Also, in
a more controlled environments, which RT task is preempting the task can be
a, while not always reliable, useful hint in whether it'd be better to
bounce to another CPU right away or not. That said, we can drop it e.g. if
it makes implementation unnecessarily complicated.

> I also found you have some terrible !SMP hack in there, which I've
> broken, I've disabled it for now. This needs a proper fix, and not
> something ugly like you did.

Yeah, this came up before. On UP, SCX either needs to call the balance
callback as that's where the whole dispatch logic is called from (which
makes sense for it as dispatching often involves balancing operations), or
SCX itself needs to call it directly in a matching sequence. Just enabling
balance callback on UP && SCX would be the cleanest.

> Anyway, it seems to build, boot and pass the sched_ext selftest:
> 
> PASSED:  21
> SKIPPED: 0
> FAILED:  0
> 
> (albeit with a fair amount of console noise -- is that expected?)

Yeah, the selftests trigger a lot of error conditions so that's expected.

> Also, why does that thing hard depend on DEBUG_BTF? (at least having
> that option enabled no longer explodes build times like it used to)

That's necessary for building the schedulers, at least, I think. We didn't
have that earlier and people were getting confused.

> Also should we /CONFIG_SCHED_CLASS_EXT/CONFIG_SCHED_BPF/ ? Then
> something like: grep BPF foo-build/.config
> more easily shows what's what.

I don't know. isn't that too inconsistent with other classes, and down the
line, maybe there may be BPF related additions to scheduler?

Thanks.

-- 
tejun

