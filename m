Return-Path: <linux-kernel+bounces-347123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5698CE28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0D21C20FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE419415E;
	Wed,  2 Oct 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBVXs0qt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A76D517
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855726; cv=none; b=rgfuTaAp8GGcqu34x3dQbx4ioAa9bePi3skmwC/53C1O5LxpgwhjdHkr/fqY773We3GSxwiZW5+/852E8WsKVAX1lCN8sWMDEEmd7zTwAfWTinGoKI7GShiDGMBUxaWDi4Lqg3LlXCLBj3V6gHaDFzNlc4tzE3tf3SB7gvLXpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855726; c=relaxed/simple;
	bh=nCMeb8UkNSL+ajcO8B/YmTy2lW6ksNPjESBGA8q1yAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZRKMjJ0Sgu4hkk2K/KoZDHbIqWo6nB8VaU2ixV4rln2c1SeUgoU1abhziNh6wdD05iI26jnLMLD+beioa7ITIHdg5cFuzOjv0QNhYE3b5+tHDavsbpUVVMFkhaXnODdAnKQdJaXUh6PEY1A/msE4HgdbOTY4Ekw99DDvINEIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBVXs0qt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so827733066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727855723; x=1728460523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Otv+TZb79wWb311UHcwxcmXMG50GoaHXdLlDv428pk0=;
        b=cBVXs0qtHrzpEmLgrQ23VXYpJQWab7Bv2kEa1AeQf6hlPjm2DveMmL276OUtR5Hr/Z
         c7pSIuW1WpYDdCXEE00NKA7xWxNmwhWTDpG+LOnVXk6Ay0+w3hodJXbCgCc7YsZNkFHT
         e9JT9nXMMBbQpkX41zeSxdvFHtk68GNUHjN6s7DHyxudzk5AKFf+BRgRZ4gjbn571VUK
         2tSIOi99lZ47P0I8hSQXK9vj1f0vYkIuOGhu/9KI8u5Fq8eiFBhP19AB6JAZaBBaXqTX
         K/nDKfpVT0h2wyzH9P1zPczr+OmQIN/j6yYnVi9vMqHOv/vZE8kcE5MyiIA6++049c/L
         3I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855723; x=1728460523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Otv+TZb79wWb311UHcwxcmXMG50GoaHXdLlDv428pk0=;
        b=gosBDBnXn239PfqSCCesHpRLyO4MCdN4FQFliIdukNJcH1uYSeJTNnQ1dWVa2rirOt
         NG8sSKtLLnQVsxU2gDO0Y3gJxV2W+gzbrOVx5aUfDjBnFytmKMCPPmHsRLEVQq0ATvwf
         uXuLiPtOTE+MfR7NwxRHp49Lv5UrMeouTWlKXxU1NObtZNloqYEl2h3w9p9MoipsNrXw
         z1ypaKG2Bqdj/i5HP24jfGSsu6763pmIUREnNtkB4o/hfqDSB6LVhA69gtC+mc4KEEme
         X1EdR93TS+8U1HgjViKh2MpS2ap/lD1sSx/CxJAv3kcqruSGyg2MUmjFGy0qIV5+kwmr
         yVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuygG4q7TCsGvVH+oRVswxQlfCGEjvb9+7gYQmwaEQFhqN2+boDlu9wzRcQ7ISugzy+RlyVRuAYr/nlWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Mp2Xn7NGGOkqAFfmsjPO4elqrCWAn9TR3KFtv2AUDGI6a8tJ
	b0ecuBKxjxqrNKHuCgl2X3VTS1nmSoL9EQqRyhiNoofWSCGGcydu8WgTcs+Ijw==
X-Google-Smtp-Source: AGHT+IF0kN/oGvguBUCVK/K25NOr3RL4gjZozN7vpWulGNBJiknowxjR32TlnwTClKL0g5dDWflDdg==
X-Received: by 2002:a17:907:989:b0:a77:e48d:bae with SMTP id a640c23a62f3a-a98f827005amr190693166b.28.1727855722302;
        Wed, 02 Oct 2024 00:55:22 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2777209sm819637366b.44.2024.10.02.00.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:55:22 -0700 (PDT)
Date: Wed, 2 Oct 2024 07:55:19 +0000
From: Quentin Perret <qperret@google.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org, qyousef@layalina.io,
	hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <Zvz8Z_EDI93l2GBt@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
 <bb89dbad-f6e8-471e-a165-750cce2b1593@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb89dbad-f6e8-471e-a165-750cce2b1593@arm.com>

Hey Lukasz,

On Wednesday 02 Oct 2024 at 08:11:06 (+0100), Lukasz Luba wrote:
> Hi Quentin and Vincent,
> 
> On 10/1/24 18:50, Quentin Perret wrote:
> > On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
> > > With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
> > > utilization"), the util_est remains set the value before having to
> > > share the cpu with other tasks which means that the util_est remains
> > > correct even if its util_avg decrease because of sharing the cpu with
> > > other task. This has been done to cover the cases that you mention
> > > above whereboth util_avg and util_est where decreasing when tasks
> > > starts to  share  the CPU bandwidth with others
> > 
> > I don't think I agree about the correctness of that util_est value at
> > all. The above patch only makes it arbitrarily out of date in the truly
> > overcommitted case. All the util-based heuristic we have in the
> > scheduler are based around the assumption that the close future will
> > look like the recent past, so using an arbitrarily old util-est is still
> > incorrect. I can understand how this may work OK in RT-app or other
> > use-cases with perfectly periodic tasks for their entire lifetime and
> > such, but this doesn't work at all in the general case.
> 
> I remember that commit Vincent mentioned above. That was from a web
> browser test 'Speedometer', not rt-app. The browser has to run the
> same 'computation problem' but with quite a lot of JavaScript
> frameworks. Those frameworks mainly run in the browser main thread,
> with some helper threads in background.
> 
> So it was not purely RT-app or other perfectly periodic task.
> Although, IIRC Vincent was able to build a model based on rt-app
> to tackle that issue.
> 
> That patch helped to better reflect the situation in the OS.

Sure thing, I'm absolutely ready to believe that an old util-est value
will be better in certain use-cases, but again I don't think we should
conflate this for the general case. In particular a util-est that was
measured when the system was lightly loaded is absolutely not guaranteed
to be valid while it is overcommitted. Freshness matters in many cases.

> For this particular _subject_ I don't think it's relevant, though.
> It was actually helping to show that the situation is worse, so
> closer to OU because the task was bigger (and we avoid EAS).
> 
> > 
> > > And feec() will return -1 for that case because util_est remains high
> > 
> > And again, checking that a task fits is broken to start with if we don't
> > know how big the task is. When we have reasons to believe that the util
> > values are no longer correct (and the absence of idle time is a very
> > good reason for that) we just need to give up on them. The fact that we
> > have to resort to using out-of-date data to sort of make that work is
> > just another proof that this is not a good idea in the general case.
> > 
> > > the commit that I mentioned above covers those cases and the task will
> > > not incorrectly fit to another smaller CPU because its util_est is
> > > preserved during the overutilized phase
> > 
> > There are other reasons why a task may look like it fits, e.g. two tasks
> > coscheduled on a big CPU get 50% util each, then we migrate one away, the
> > CPU looks half empty. Is it half empty? We've got no way to tell until
> > we see idle time. The current util_avg and old util_est value are just
> > not helpful, they're both bad signals and we should just discard them.
> 
> So would you then reset them to 0? Or leave them as they are?
> What about the other signals (cpu runqueue) which are derived from them?
> That sounds like really heavy change or inconsistency in many places.

I would just leave them as they are, but not look at them, pretty much
like we do today. In the overcommitted case, load is a superior signal
because it accounts for runnable time and the task weights, so we really
ought to use that instead of util.

> > 
> > So again I do feel like the best way forward would be to change the
> > nature of the OU threshold to actually ask cpuidle 'when was the last
> > time there was idle time?' (or possibly cache that in the idle task
> > directly). And then based on that we can decide whether we want to enter
> > feec() and do util-based decision, or to kick the push-pull mechanism in
> > your other patches, things like that. That would solve/avoid the problem
> > I mentioned in the previous paragraph and make the OU detection more
> > robust. We could also consider using different thresholds in different
> > places to re-enable load-balancing earlier, and give up on feec() a bit
> > later to avoid messing the entire task placement when we're only
> > transiently OU because of misfit. But eventually, we really need to just
> > give up on util values altogether when we're really overcommitted, it's
> > really an invariant we need to keep.
> 
> IMHO the problem here with OU was amplified recently due to the
> Uclamp_max setting

Ack.

> 'Max aggregation policy'

Ack.

> aggressive frequency capping

What do you mean by that?

> fast freq switching.

And not sure what fast switching has to do with the issue here?

> Now we are in the situation where we complain about util metrics...
> 
> I've been warning Qais and Vincent that this usage of Uclamp_max
> in such environment is dangerous and might explode.

I absolutely agree that uclamp max makes a huge mess of things, and util
in particular :-(

> If one background task is capped hard in CPU freq, but does computation
> 'all the time' making that CPU to have no idle time - then IMO
> this is not a good scheduling. This is a receipt for starvation.
> You probably won't find any better metric.
> 
> I would suggest to stop making the OU situation worse and more
> frequent with this 'artificial starvation with uclamp_max'.
> 
> I understand we want to safe energy, but uclamp_max in current shape
> has too many side effects IMO.
> 
> Why we haven't invested in the 'Bandwidth controller', e.g. to make
> it big.Little aware (if that could be a problem)(they were there for
> many years)?

Bandwidth control is a different thing really, not sure it can be used
interchangeably with uclamp_max in general. Running all the time at low
frequency is often going to be better from a power perspective than
running uncapped for a fixed period of time.

I think the intention of uclamp max is really to say 'these tasks have
low QoS, use spare cycles at low-ish frequency to run them'. What we
found was that it was best to use cpu.shares in conjunction with
uclamp.max to implement the 'use spare cycles' part of the previous
statement, but that was its own can of worms and caused a lot of
priority inversion problems. Hopefully the proxy exec stuff will solve
that...

Thanks,
Quentin

