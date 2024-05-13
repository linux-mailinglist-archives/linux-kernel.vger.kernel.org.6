Return-Path: <linux-kernel+bounces-177363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E28C3D87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24279284500
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F01482FC;
	Mon, 13 May 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7W8zz6K"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54891146A60
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590174; cv=none; b=fkftYAMSXkOCG+mU5BhmS0a8onm/cmYlrTEjUR2XJgG9IxfgeQXAODvoN0q64Yjwe4ipgvE/qeco0XTFk9KILdITSTwmLEwPLMhpmRVbUGuiN4f3+BjJxnsf9N66hAOpENyl/47W33lTOjgdspGSkSWgsdnJcTUO+Qy5AJqNhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590174; c=relaxed/simple;
	bh=RWxtSOvvqhgQz4wpMQaij7233nToE7MMcb2+bQqUfoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUp7IW2cbRk2Cg3r4XTPqXWb07P1XjLizfufEn43gUNumGhaM+pE8zcuUsUUbFmPa83Pd/PenX7NzlswxrYTHO0Aobhf8NBRQkf11XbwyuS9/1a4cn66Z0nO7g2cE2BFn6+yiw9ywQUXMY340w9L9PlTdUIGIjCvTjR4YW7/0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7W8zz6K; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792c7704e09so259130085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715590171; x=1716194971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBHEUWuf6vzjxU6vsBbBeAA7AmoiOzTlPAv7K3jhie8=;
        b=l7W8zz6Kiq4YAPCsdO8jZuTyT7GEWhX/b8nQkgOLjeJE7ROTAbomfC9FzsYAYSyERG
         helkefbgVCtXFwJQAEs3bjKPD34oxbPrTbA1IYSIJmNlA+3I+a0mwCETDEkqrFZlwY30
         i+BagT7Hs63Patv2OiKy8pCc6C1RoV5I6ahHqBry1ojJyZ2Tyx9j/aW2QF2OwtesdUj+
         RDEN1m5zpMJZ2+iYGoGaQcLsoSFkWOS90J9N0gSHIpmDHnwXXc3SbMrGQs4xoGS4pOWm
         juaq6NKAPzMaOW0MqB3iKzhL18AcDmsiU+hXIrijq/TiIk0js3jhJ0ftWcTFcb+oHDvS
         Jtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590171; x=1716194971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBHEUWuf6vzjxU6vsBbBeAA7AmoiOzTlPAv7K3jhie8=;
        b=IuvOAUvSn2l0vMsRFZSGreMv+JzQqRu6p/za7+Fdgo6AzPYIeXrsu7CcGP3zXhZ80f
         dzGgaM7+79ISdkqhiHIKYdSe2gNT07i/vaVARV+6bssmx46A9WwdL4e72Gmim0qhTk9t
         TZx0O8YlneBN0LZchrEsRGqtT3vw4Tuqp/g/Za8WZ4mxayxyOHBDW60kSFh4IIeGf4Yp
         jJsCdTshXn6A1lm7M6mnQs78cTBLkJggqdotgcVECHULzUqm9u5IvbvalChcF2zraOXp
         qiH+PCeXpIU5PmQJtSGM60P5CCCZGo7xGZtRnXgqNu5C78iArBMs2QMg82EKqIsDlJpM
         /yQA==
X-Forwarded-Encrypted: i=1; AJvYcCUpdkjOuqlr8laNKQnjKjx6bRJwx7jgN3LOwzAsBBYu42jnFF84QqTJQBxHGU7mpQMugLik1QROOm37WEqYefTmuovBax1SWWfQndIM
X-Gm-Message-State: AOJu0YwW2sbV5PYFhbUqgVtYfhSWZ27SB+eKjr+rTRaFs8ZrQKBR8C4D
	pTsAcSUMBtqplTHTgpCbwGo+mZrC5aZ9ZgvRbSC4w2LvDUm6QDvoFCVtS70p3sQVZZp2+9KaWRz
	PO4qo9NIftR5aw1yqk6U7ZaljcYQdJzbFh2D2KoMptJ6FGClweJQ=
X-Google-Smtp-Source: AGHT+IHhRgCMiL+T52tLiRD1su7j/TyGlM5+fm73YsGmPbkm4WWqb00/gQcHWb4+r6jYRIzjw8v1Hd41yyUQkJBPi1U=
X-Received: by 2002:a05:620a:4551:b0:792:9332:c25 with SMTP id
 af79cd13be357-792c6b5e76emr1656894485a.0.1715590170995; Mon, 13 May 2024
 01:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505233103.168766-1-qyousef@layalina.io> <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu> <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
 <20240509124003.hsuatsid4vtjpzhv@airbuntu>
In-Reply-To: <20240509124003.hsuatsid4vtjpzhv@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 May 2024 10:49:15 +0200
Message-ID: <CAKfTPtD2moiyBprY=YLOE0N599=O8L2=UPFnmpsZ6Mc=+C__6w@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 14:40, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 05/07/24 14:53, Vincent Guittot wrote:
> > On Tue, 7 May 2024 at 13:08, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 05/07/24 10:58, Vincent Guittot wrote:
> > > > On Mon, 6 May 2024 at 01:31, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > Improve the interaction with cpufreq governors by making the
> > > > > cpufreq_update_util() calls more intentional.
> > > > >
> > > > > At the moment we send them when load is updated for CFS, bandwidth for
> > > > > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > > > > sent in a short period of time and potentially be ignored at a critical
> > > > > moment due to the rate_limit_us in schedutil.
> > > > >
> > > > > For example, simultaneous task enqueue on the CPU where 2nd task is
> > > > > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > > > > the first task will lead to dropping the 2nd request until tick. Or
> > > > > another CPU in the same policy triggers a freq update shortly after.
> > > > >
> > > > > Updates at enqueue for RT are not strictly required. Though they do help
> > > > > to reduce the delay for switching the frequency and the potential
> > > > > observation of lower frequency during this delay. But current logic
> > > > > doesn't intentionally (at least to my understanding) try to speed up the
> > > > > request.
> > > > >
> > > > > To help reduce the amount of cpufreq updates and make them more
> > > > > purposeful, consolidate them into these locations:
> > > > >
> > > > > 1. context_switch()
> > > >
> > > > I don't see any cpufreq update when switching from idle to CFS. We
> > >
> > > You mean SCHED_IDLE to SCHED_NORMAL, right? Yes, if we switch policies even
> > > from fair to RT an update could be missed.
> >
> > No I mean going out of idle. On an idle cpu, nothing happens at CFS
> > task wakeup and we have to wait for the next tick to apply the new
> > freq. This happens for both short task with uclamp min or long
> > running/sleeping task (i.e. with high util_est)
>
> And without my patch you see a freq change? If no stats were updated to cause

Yes, the behavior is correct without your patch

> a decay, we will skip the cpufreq update at this context switch.
>
> I'll audit the code again in case I missed a place where there's a decay. You
> could be hitting a race condition with update_blocked_avg() sending a cpufreq
> update and this could cause the context switch cpufreq update to be dropped by
> rate limit.. You could try to reduce your rate_limit_us to see if this helpsits

I already checked this. There is no update happening before the
wakeup. In fact I thought it was linked to a 1000 hz tick and the cpu
not stopping its tick but the problem is still there even after
removing such potential problems.

>
> I'll try to reproduce and investigate. FWIW, I did test this on M1 mac mini and
> pixel device running speedometer and some iowait workloads and didn't observe
> problems.

I'm using a dragonboard RB5 and I have a simple use case with a task
waking up periodically around 100ms for running 40ms.  As usual I'm
not using a strict 100ms to stay unsync with tick and cover more cases

>
> >
> > >
> > > I'll need to think more about it, but I think adding an update when we switch
> > > policies in the syscall looks sufficient to me, if the task is on rq already.
> > > Agreed?
> > >
> > > > have to wait for the next tick to get a freq update whatever the value
> > > > of util_est and uclamp
> > > >
> > > > > 2. task_tick_fair()
> > > >
> > > > Updating only during tick is ok with a tick at 1000hz/1000us when we
> > > > compare it with the1048us slice of pelt but what about 4ms or even
> > > > 10ms tick ? we can have an increase of almost 200 in 10ms
> > >
> > > IMHO the current code can still fail with these setups to update frequencies in
> > > time. If there's a single task on the rq, then the only freq update will happen
> > > at tick. So this is an existing problem.
> >
> > But any newly enqueued task can trigger a freq update without waiting
> > 1/4/10ms whereas we need to wait for next tick with this patch
>
> But it is racy. By deferring the decision (sampling point) we ensure better the
> RUNNING task is reflecting the current state of the rq taken into account any
> past events.
>
> Note if there's no enqueue/dequeue, the problem is not fixed either way. If we
> get two consecutive enqueues, the 2nd one will be dropped. And we'll end up
> with delays.
>
> I think this way we'd be just more consistently failing or working.
>
> Systems with high rate_limit_us or TICK generally should ask for generous
> headroom and I think this is the best way to address this issue in a scalable
> way. People with fast systems/configurations can be more exact and frequent in
> their requests. Systems/configurations that are slow will tend to exaggerate
> each request to cater for the slow response. But the requests themselves are
> done at better defined points of time. That's my hope at least, so I appreciate
> the reviews :)
>
> My other hope is that by doing the sampling at context switch we can better
> handle uclamp and iowait boost requests which requires special cpufreq
> constrains to be applied for this specifically RUNNING task. Ultimately leading
> to removing uclamp max() aggregation at enqueue/dequeue.
>
> >
> > >
> > > The way I see it is that setting such high TICK values implies low
> > > responsiveness by definition. So the person who selects this setup needs to
> > > cater that their worst case scenario is that and be happy with it. And this
> > > worst case scenario does not change.
> > >
> > > That said, the right way to cater for this is via my other series to remove the
> > > magic margins. DVFS headroom should rely on TICK value to ensure we run at
> > > adequate frequency until the next worst case scenario update, which relies on
> > > TICK. Which is sufficient to handle util_est changes. See below for uclamp.
> > >
> > > Wake up preemption should cause context switches to happen sooner than a tick
> > > too as we add more tasks on the rq. So I think the worst case scenario is not
> > > really changing that much. In my view, it's better to be consistent about the
> > > behavior.
> > >
> > > >
> > > > > 3. {attach, detach}_entity_load_avg()
> > > >
> > > > At enqueue/dequeue, the util_est will be updated and can make cpu
> > > > utilization quite different especially with long sleeping tasks. The
> > > > same applies for uclamp_min/max hints of a newly enqueued task. We
> > > > might end up waiting 4/10ms depending of the tick period.
> > >
> > > uclamp_min is a property of the task. And waiting for the task that needs the
> > > boost to run is fine IMHO. And I am actually hoping to remove uclamp max()
> >
> > But you will delay all CPU work and the running time fo the task
>
> uclamp_min shouldn't cause other tasks to run faster? From my perspective this
> is wasting power actually as what we want is only this task to run faster.
>
> If the task wants better wake up latency (which I assume what you're referring
> to by making things run faster then this task should get to RUNNING faster)
> then we need to annotate this separately IMHO. We shouldn't rely on the boost
> which is there to ensure this tasks gets work done at an acceptable rate, not
> to impact its wake up latency.
>
> >
> > And what about util_est ?
>
> Hmm yeah this won't cause cfs_rq.decayed to trigger so we could miss it at
> context switch. And could be what's causing the issue you're seeing above.

