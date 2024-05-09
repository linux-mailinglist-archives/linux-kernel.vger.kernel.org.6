Return-Path: <linux-kernel+bounces-174507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6D8C0FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C211F23A35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BE13B7A1;
	Thu,  9 May 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DZXGrH3c"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33D13AD38
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258412; cv=none; b=naV987r1QbAhduvwkapUPAi/BuC8JZ819d5jy2DuqLxprGQ6XSsEZFQzpmiLIT7ucWA6jvZai93mBSej2NTgi5iSdtF6ijnTrq6uqKzfR2+RjraHzkGSD1o4DS3rr0hyEFP+Eu1afp7YUMl9Mv+IiN7nfUqXNQO+fJmT+iLKDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258412; c=relaxed/simple;
	bh=xTHG5e7wz8J6iLM/stIhVyAx6r42yfR/HuZsBWOWjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQMeoQSkn8a/IOTLPkEFrgBoqbWmL+3mzAYNGj3TGFtu2H3odXQkErvqDoBiaSjRapTjFSXxnr+njGpkpQZP0uzNLGMNVGNvHCgA3lZce6b2mN5Vv4SdZTm1LtzQU2MH8B/HUlYAtDUwbq2L9ia+9GDqHsqSKsFv9EislZdk4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DZXGrH3c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e9so6528045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715258408; x=1715863208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZts/U5mGFM2WkbRCutnzJZzymYo1b+PUsTv+EIiaYU=;
        b=DZXGrH3cJqbFsjiRZ4n5kVH9aRrKunjRe+K72dZiiJQsJJC1v/lw99VK5DyHUKj4yM
         AdJmvry0L36o3mEBf5DZpQfdXcKeXYrKIUUDK29Y2jDNSNS5Lfp4UvY5yn+sxS+JhbQU
         H6jbyLKSDiE33Ca3GjGyk7UBzBA21azH8GlbPkGMbRS0egtyvS7n4PB/nPzwKACwTHxj
         IXOA+YdUxLFL9V6Zd8UGudsqA+pN0mHUt0beWhwD7BSHyqI2YcvoeAxwkGrc/hlVrBGY
         KjXeP3/JB49GE/a9fVti/7fr2ovVlwJmzgctKUOwEnSDW1BHYjXWMaOvVvUl+g93J/Af
         rTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715258408; x=1715863208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZts/U5mGFM2WkbRCutnzJZzymYo1b+PUsTv+EIiaYU=;
        b=EWEQSZJb7YN3PljV+uPUlrtY/z1LXcN/7Jd5vIt2vSVQpD1sPVfjnvHfArxiHtyaWg
         rxmuOwaRHvvMkqWKkhntd3AhSkJs4JUx+AA0/HbGgXRArvHQap8gP4sY4/kDhtUJ6xK0
         9GwDSO6EO9WG2TDywvqd+LqLedrsu2bP5usBqfwbDnvJhVRrgSJ6igbMN5K1xH8kj7kz
         4UHY5W8HWN3pQ/MQqMuVR+VEMjNMZNDqk2i+yiDyIu+w2Rzc8E7yITMlF+McN6rM5Mnf
         qZhALoeGjvAoNxxkuEdF6G5jhamkojVbn5YsKXbSWPJ4yehKVQT3nCn3MChtJo1+Oxzw
         D6nw==
X-Forwarded-Encrypted: i=1; AJvYcCWZRty4/cYEl/KjcrOzp/YFoOk00Ijp5FBCwgKeF3Rmzqj5PSvKa9D8JBZRvGx4sHxe3eLOrbugQf5ORxPz4ZXdnMcXnxUVa7/ExWfo
X-Gm-Message-State: AOJu0Yzcyuw7Fffdxp9Tgo+WXjfMzgeyn+IcqTyhpPB+6FkIOIty15Xn
	uTXfp34RhnCzqbPHZHAQgtxVAqPnedhqyPQINh24JB/6X68s/YQMihqOFPIvD5c=
X-Google-Smtp-Source: AGHT+IHycysr3LR0p1aS/61wWEema4MLP7hieGNFHOrzW6tyzEZx8KJKEtoxQrlw6lWqUPhdcy1ccA==
X-Received: by 2002:a05:600c:5116:b0:41f:d4e1:5abc with SMTP id 5b1f17b1804b1-41fd4e15bb1mr9300075e9.8.1715258407921;
        Thu, 09 May 2024 05:40:07 -0700 (PDT)
Received: from airbuntu (92.40.184.205.threembb.co.uk. [92.40.184.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f8811110asm60817755e9.35.2024.05.09.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:40:07 -0700 (PDT)
Date: Thu, 9 May 2024 13:40:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240509124003.hsuatsid4vtjpzhv@airbuntu>
References: <20240505233103.168766-1-qyousef@layalina.io>
 <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu>
 <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>

On 05/07/24 14:53, Vincent Guittot wrote:
> On Tue, 7 May 2024 at 13:08, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 05/07/24 10:58, Vincent Guittot wrote:
> > > On Mon, 6 May 2024 at 01:31, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > Improve the interaction with cpufreq governors by making the
> > > > cpufreq_update_util() calls more intentional.
> > > >
> > > > At the moment we send them when load is updated for CFS, bandwidth for
> > > > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > > > sent in a short period of time and potentially be ignored at a critical
> > > > moment due to the rate_limit_us in schedutil.
> > > >
> > > > For example, simultaneous task enqueue on the CPU where 2nd task is
> > > > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > > > the first task will lead to dropping the 2nd request until tick. Or
> > > > another CPU in the same policy triggers a freq update shortly after.
> > > >
> > > > Updates at enqueue for RT are not strictly required. Though they do help
> > > > to reduce the delay for switching the frequency and the potential
> > > > observation of lower frequency during this delay. But current logic
> > > > doesn't intentionally (at least to my understanding) try to speed up the
> > > > request.
> > > >
> > > > To help reduce the amount of cpufreq updates and make them more
> > > > purposeful, consolidate them into these locations:
> > > >
> > > > 1. context_switch()
> > >
> > > I don't see any cpufreq update when switching from idle to CFS. We
> >
> > You mean SCHED_IDLE to SCHED_NORMAL, right? Yes, if we switch policies even
> > from fair to RT an update could be missed.
> 
> No I mean going out of idle. On an idle cpu, nothing happens at CFS
> task wakeup and we have to wait for the next tick to apply the new
> freq. This happens for both short task with uclamp min or long
> running/sleeping task (i.e. with high util_est)

And without my patch you see a freq change? If no stats were updated to cause
a decay, we will skip the cpufreq update at this context switch.

I'll audit the code again in case I missed a place where there's a decay. You
could be hitting a race condition with update_blocked_avg() sending a cpufreq
update and this could cause the context switch cpufreq update to be dropped by
rate limit.. You could try to reduce your rate_limit_us to see if this helps.

I'll try to reproduce and investigate. FWIW, I did test this on M1 mac mini and
pixel device running speedometer and some iowait workloads and didn't observe
problems.

> 
> >
> > I'll need to think more about it, but I think adding an update when we switch
> > policies in the syscall looks sufficient to me, if the task is on rq already.
> > Agreed?
> >
> > > have to wait for the next tick to get a freq update whatever the value
> > > of util_est and uclamp
> > >
> > > > 2. task_tick_fair()
> > >
> > > Updating only during tick is ok with a tick at 1000hz/1000us when we
> > > compare it with the1048us slice of pelt but what about 4ms or even
> > > 10ms tick ? we can have an increase of almost 200 in 10ms
> >
> > IMHO the current code can still fail with these setups to update frequencies in
> > time. If there's a single task on the rq, then the only freq update will happen
> > at tick. So this is an existing problem.
> 
> But any newly enqueued task can trigger a freq update without waiting
> 1/4/10ms whereas we need to wait for next tick with this patch

But it is racy. By deferring the decision (sampling point) we ensure better the
RUNNING task is reflecting the current state of the rq taken into account any
past events.

Note if there's no enqueue/dequeue, the problem is not fixed either way. If we
get two consecutive enqueues, the 2nd one will be dropped. And we'll end up
with delays.

I think this way we'd be just more consistently failing or working.

Systems with high rate_limit_us or TICK generally should ask for generous
headroom and I think this is the best way to address this issue in a scalable
way. People with fast systems/configurations can be more exact and frequent in
their requests. Systems/configurations that are slow will tend to exaggerate
each request to cater for the slow response. But the requests themselves are
done at better defined points of time. That's my hope at least, so I appreciate
the reviews :)

My other hope is that by doing the sampling at context switch we can better
handle uclamp and iowait boost requests which requires special cpufreq
constrains to be applied for this specifically RUNNING task. Ultimately leading
to removing uclamp max() aggregation at enqueue/dequeue.

> 
> >
> > The way I see it is that setting such high TICK values implies low
> > responsiveness by definition. So the person who selects this setup needs to
> > cater that their worst case scenario is that and be happy with it. And this
> > worst case scenario does not change.
> >
> > That said, the right way to cater for this is via my other series to remove the
> > magic margins. DVFS headroom should rely on TICK value to ensure we run at
> > adequate frequency until the next worst case scenario update, which relies on
> > TICK. Which is sufficient to handle util_est changes. See below for uclamp.
> >
> > Wake up preemption should cause context switches to happen sooner than a tick
> > too as we add more tasks on the rq. So I think the worst case scenario is not
> > really changing that much. In my view, it's better to be consistent about the
> > behavior.
> >
> > >
> > > > 3. {attach, detach}_entity_load_avg()
> > >
> > > At enqueue/dequeue, the util_est will be updated and can make cpu
> > > utilization quite different especially with long sleeping tasks. The
> > > same applies for uclamp_min/max hints of a newly enqueued task. We
> > > might end up waiting 4/10ms depending of the tick period.
> >
> > uclamp_min is a property of the task. And waiting for the task that needs the
> > boost to run is fine IMHO. And I am actually hoping to remove uclamp max()
> 
> But you will delay all CPU work and the running time fo the task

uclamp_min shouldn't cause other tasks to run faster? From my perspective this
is wasting power actually as what we want is only this task to run faster.

If the task wants better wake up latency (which I assume what you're referring
to by making things run faster then this task should get to RUNNING faster)
then we need to annotate this separately IMHO. We shouldn't rely on the boost
which is there to ensure this tasks gets work done at an acceptable rate, not
to impact its wake up latency.

> 
> And what about util_est ?

Hmm yeah this won't cause cfs_rq.decayed to trigger so we could miss it at
context switch. And could be what's causing the issue you're seeing above.

