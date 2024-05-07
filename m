Return-Path: <linux-kernel+bounces-171318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4658BE295
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CBD28C8C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26F15CD55;
	Tue,  7 May 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmKz/7si"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414C156885
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086441; cv=none; b=DKS131XMWam6WSoCPTI8A5xjuAQV7Xt3qCYVW6BAc1UBxJ1/wWawAuIxOdHLzBlV9JeRIBE8o5QE9gWFUbK2LH8L+f9uOEhGPkDyec589gAiZU9jjpJjxu2zJNKzwleKvOg22Wn4d4eXXlzVvQTLheIbMO/i76+smyRldNusK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086441; c=relaxed/simple;
	bh=qXGfUlEuyq9acMc9wdmCRc4sbAYNXOqxy6N3x85FJp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRGS/8PwPaDH2XU22FJHh8RokCNQwrsDGTAbxfL870Dg6RHdRDIqhMst3vDGD2za/a5C1gxrlt6QxH5Bn0m12BBZIccFXDVKcUYIP2AKlzpAdtA5hdKZlDYhXUnlmWAKW6qdXYMhuwuzM3kPi7eGGomowrML8pTfYTirFf3rCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmKz/7si; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso2071692a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715086440; x=1715691240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXGfUlEuyq9acMc9wdmCRc4sbAYNXOqxy6N3x85FJp4=;
        b=QmKz/7si5sk2ZXhDFfHm4Abf4ivIBe+F8/ofEZwcQM6a1sH52euRDjf1S4sFC4JZXe
         QJHq0XNWEv14zgxHPhrg1AdTzEKyHT6UR5NIcBeiq64oANkoFufMvh/PpM15KyRH+vtG
         Z32UxiV+6US1OyOlTs/NNpmtDtMQC6+7BLPQ8HN2ITL3shQZGHt/gyF2zQE2lmn9uTF4
         TMaMlNfH8V1YLsuVf8JENZ6gzgdOhgDieRM/HTW24gD2DV/23T4oh+XhADHLxga2cG2y
         zLJv2oF3L5h7H3p6QoIVexAKiq8FFgEP9sM+wkSYvd5LC7UBeIUnoGm7W4iGFUJOR0Hl
         XkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086440; x=1715691240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXGfUlEuyq9acMc9wdmCRc4sbAYNXOqxy6N3x85FJp4=;
        b=kUQGt84AWRetPbmELSphksn3kEtMP4qIJha6jBQSdH0KFhuhZ2fpQDG1Br0TDX//NZ
         lVHd7tN/0/PpO1vFlziOGnkPusWFbN8GLD/Zy6itnm5b6ox6cvpVnM4rGVVkSkkUmoq7
         jN3SeyD3c+i1i32L4Juw5JIS4VZW2CuX42mcTDqsuEmSZLX5BRQOqSdUpCVsmVpvDHQp
         Cf244o21nsASbhL9fP2RC40iRTtxUZpRM+UdpBiBuIOLIM91GE+d4nQIv32Q4+QPO9NQ
         cXkEYmufxmtan0iqPQZ3gfldV84rgt0dWEs5y5XMa+EaVNXpW/TxAhFcXqqVpiOpEsOZ
         GRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe+SH4xheY98rhYcQ96rqwCGXh0rgTmc5bunv1jNqdXKpQsqbq23/6Q0/PknNgy71XHX3mY2DQOk/ARMPIQaZ0YDw5yL9y8D+Y300w
X-Gm-Message-State: AOJu0Yz5S4mqXBWBjBZ5JLyUaUaFtej21NrI+XDFJ1uqky5qyLorrE4y
	A1NIe7lenw1rhD41CBVRuhwjdXBuUu1vgYh4z2tDvyNjxKZSilNdmR+7QsqRwPC4xnF6V7em29o
	TF0sUEW1M4gdpYRYlJ3nop+MDGu6DdKUQXgoKoA==
X-Google-Smtp-Source: AGHT+IF3096jy/BSNmowrhBG7/4P6Cfwvb5f60E87UNKn0QswOMKfkSoKQ0PEOrgiFEyqfvYve9FVZFHeqzt4AK+nAo=
X-Received: by 2002:a17:90a:930c:b0:2a1:f586:d203 with SMTP id
 p12-20020a17090a930c00b002a1f586d203mr10241315pjo.41.1715086438068; Tue, 07
 May 2024 05:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505233103.168766-1-qyousef@layalina.io> <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu>
In-Reply-To: <20240507110809.a45amdmhy5vr5cuw@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 May 2024 14:53:46 +0200
Message-ID: <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
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

On Tue, 7 May 2024 at 13:08, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 05/07/24 10:58, Vincent Guittot wrote:
> > On Mon, 6 May 2024 at 01:31, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > Improve the interaction with cpufreq governors by making the
> > > cpufreq_update_util() calls more intentional.
> > >
> > > At the moment we send them when load is updated for CFS, bandwidth for
> > > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > > sent in a short period of time and potentially be ignored at a critical
> > > moment due to the rate_limit_us in schedutil.
> > >
> > > For example, simultaneous task enqueue on the CPU where 2nd task is
> > > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > > the first task will lead to dropping the 2nd request until tick. Or
> > > another CPU in the same policy triggers a freq update shortly after.
> > >
> > > Updates at enqueue for RT are not strictly required. Though they do help
> > > to reduce the delay for switching the frequency and the potential
> > > observation of lower frequency during this delay. But current logic
> > > doesn't intentionally (at least to my understanding) try to speed up the
> > > request.
> > >
> > > To help reduce the amount of cpufreq updates and make them more
> > > purposeful, consolidate them into these locations:
> > >
> > > 1. context_switch()
> >
> > I don't see any cpufreq update when switching from idle to CFS. We
>
> You mean SCHED_IDLE to SCHED_NORMAL, right? Yes, if we switch policies even
> from fair to RT an update could be missed.

No I mean going out of idle. On an idle cpu, nothing happens at CFS
task wakeup and we have to wait for the next tick to apply the new
freq. This happens for both short task with uclamp min or long
running/sleeping task (i.e. with high util_est)

>
> I'll need to think more about it, but I think adding an update when we switch
> policies in the syscall looks sufficient to me, if the task is on rq already.
> Agreed?
>
> > have to wait for the next tick to get a freq update whatever the value
> > of util_est and uclamp
> >
> > > 2. task_tick_fair()
> >
> > Updating only during tick is ok with a tick at 1000hz/1000us when we
> > compare it with the1048us slice of pelt but what about 4ms or even
> > 10ms tick ? we can have an increase of almost 200 in 10ms
>
> IMHO the current code can still fail with these setups to update frequencies in
> time. If there's a single task on the rq, then the only freq update will happen
> at tick. So this is an existing problem.

But any newly enqueued task can trigger a freq update without waiting
1/4/10ms whereas we need to wait for next tick with this patch

>
> The way I see it is that setting such high TICK values implies low
> responsiveness by definition. So the person who selects this setup needs to
> cater that their worst case scenario is that and be happy with it. And this
> worst case scenario does not change.
>
> That said, the right way to cater for this is via my other series to remove the
> magic margins. DVFS headroom should rely on TICK value to ensure we run at
> adequate frequency until the next worst case scenario update, which relies on
> TICK. Which is sufficient to handle util_est changes. See below for uclamp.
>
> Wake up preemption should cause context switches to happen sooner than a tick
> too as we add more tasks on the rq. So I think the worst case scenario is not
> really changing that much. In my view, it's better to be consistent about the
> behavior.
>
> >
> > > 3. {attach, detach}_entity_load_avg()
> >
> > At enqueue/dequeue, the util_est will be updated and can make cpu
> > utilization quite different especially with long sleeping tasks. The
> > same applies for uclamp_min/max hints of a newly enqueued task. We
> > might end up waiting 4/10ms depending of the tick period.
>
> uclamp_min is a property of the task. And waiting for the task that needs the
> boost to run is fine IMHO. And I am actually hoping to remove uclamp max()

But you will delay all CPU work and the running time fo the task

And what about util_est ?

> aggregation in favour of applying boosts/caps when tasks are RUNNING. But more
> things need to be improved first.
>
> We are missing a freq update when uclamp values change by the way. This is
> a known bug and I keep forgetting to post a patch to fix it. Let me do this
> along update freq when policy changes.
>
> Thanks!

