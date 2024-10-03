Return-Path: <linux-kernel+bounces-348797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89398EBF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D27B22806
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DF1474C5;
	Thu,  3 Oct 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2JjEQd3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94814601C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945889; cv=none; b=E1ZZz2aVVfS9jxrDTa6reKoh7wWdGOjLcTC844RcHmLiqG0bic29MdZlRsi7XZU2Opindneegm9T1hPpvAdVySzRAscxragmcEy9rJxRBiHFGmeoegSMmz468NOAGwbySoWxeO9JOR3ADVWFvEw8q5IqWTGQcW/Gp+M6T/uAbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945889; c=relaxed/simple;
	bh=awwEhkOjHJaWQxx4t5JKTZmx8iPufNhO0vx7v/2Ubic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqeW2lPGKJsVEerHJaUHuch24RvEC0iEkt+9g68h+ngkneV9PZ6bk8xUlk4oW0Rq9hl0965FOUoCdVVeUQCwMdnLPD21JRY9gEKIur1zkjkYEqAYxHUZdlP31e2Y5WZAnTWAeSRFMMIX40/xUn6GB64HS8wuTwOubzV8a2a9l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E2JjEQd3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bb610be6aso7205475ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727945887; x=1728550687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iW6pzrx+FvwaudPKKn9aXT1xp5ZWYU9O4pdFsXkRRPo=;
        b=E2JjEQd3dzOO6BPdjYwuaW8Wy8/U9APlfeHbjm9n24fEj3AWCIoVicCOoq8d1JgE2d
         iAAvQ8jtkaMXIfMZmbr9MSwGDFCwlrq0m5M3e1muyrpQe79087kijCS1L9WTIYvNSgBk
         subvG3jZy/nSiIQvGBHTgUNDQvHyaR8DZxbwxD8Md38iNu7OV4oLFTW/V3Sw4TRv5DjN
         3qQxlesUMcAZpUSjfHSicvUIFhE2ImFP4WZ+29cVOgxen1Ug0HaemLEve3GKwaBDCku3
         ePUquzhZd1vFfKdUbUX8fSezZoWWOo92VIimey8tRY9eDmQPy2Fql8L9g/z763/HrIPB
         Emhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945887; x=1728550687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW6pzrx+FvwaudPKKn9aXT1xp5ZWYU9O4pdFsXkRRPo=;
        b=ThkrefbFbHhAzuDOYKYfevWQKFz0y3OVFvxol3tnPDJaMNv+kGIupH2oc9A7Xc9aa6
         90oQNWcH/vij+6PIv1BIS7H5/zgYRU46SlEzhxWKXsxxou06xZNKMsN2JzQiMX2jJvQL
         gbjUzHB7yVliKO3a6Q2RiqGQwbQ54GDZF/gzCMxX4gHAFpS5EIPf+a9Z2GPpa+UVl8xo
         90unegT/1JNoChR7anGVpc360t6pipZ/WavxSrjGWxfgZsc596+Nu4p6rV5tS4epI0iH
         VyJ6XyXpO5C0hY8SfA+1n5MAf+FrN1SNBV/Dnbu9gdWd8/YzCjTdbSjqh1T8sXBIA1WY
         Fhvw==
X-Forwarded-Encrypted: i=1; AJvYcCWHl8FJPOgsiwUiLFiTG/WXIgx9rJmf+2OFEtRRbekI/8PWWY+thQYV7xMgoXk+5kskT3bMnkHCrD4kNU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4YuFENymuClR9DQpCVIoz+08lGTJhkenFtkfVzKF6kZLwjwR
	NAQDRhiGG6k0J5I4tBjpnPpgui0UhzauB/OOooGkfN3MzrSdBFuH0Xi/2HirjPUM5cAnuTSHypV
	kmXKa+HW9m8Krka1Ik1bPzYCNAeOeaOmGFLxXMQ==
X-Google-Smtp-Source: AGHT+IGodTNe7u5ZLJeTyNQhaxHDCYZybbC/XZorK5doq1fFf9yNq5NtPxr0D4FT7Ck3VSMx3zNhfkcwKS8BWTyn2Ew=
X-Received: by 2002:a17:90b:1811:b0:2d8:8c95:ebb6 with SMTP id
 98e67ed59e1d1-2e18480148dmr7884475a91.19.1727945886606; Thu, 03 Oct 2024
 01:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com> <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com> <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
 <Zv5UDufqpoXvSocy@google.com>
In-Reply-To: <Zv5UDufqpoXvSocy@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 3 Oct 2024 10:57:55 +0200
Message-ID: <CAKfTPtAmgi0QbtjqjJ_mzq6qat8ivd3vXXNYMiniDeKvLwujDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Quentin Perret <qperret@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 10:21, Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 03 Oct 2024 at 08:27:00 (+0200), Vincent Guittot wrote:
> > On Tue, 1 Oct 2024 at 19:51, Quentin Perret <qperret@google.com> wrote:
> > > And again, checking that a task fits is broken to start with if we don't
> > > know how big the task is. When we have reasons to believe that the util
> > > values are no longer correct (and the absence of idle time is a very
> > > good reason for that) we just need to give up on them. The fact that we
> > > have to resort to using out-of-date data to sort of make that work is
> > > just another proof that this is not a good idea in the general case.
> >
> > That's where I disagree, this is not an out-of-date value, this is the
> > last correct one before sharing the cpu
>
> This value is arbitrarily old, so of course it is out of date. This only
> sort of works for tasks that don't change their behaviour. That's true
> for some use-cases, yes, but absolutely not in the general case. How
> can you know that the last correct value before sharing the CPU is still
> valid minutes later? The fact that the system started to be
> overcommitted is a good indication that something has changed, so we
> really can't tell. Also, how is any of this going to work for newly
> created tasks while we're overcommitted for example?
>
> > > > the commit that I mentioned above covers those cases and the task will
> > > > not incorrectly fit to another smaller CPU because its util_est is
> > > > preserved during the overutilized phase
> > >
> > > There are other reasons why a task may look like it fits, e.g. two tasks
> > > coscheduled on a big CPU get 50% util each, then we migrate one away, the
> >
> > 50% of what ?
>
> 50% of SCHED_CAPACITY_SCALE (the above sentence mentions a 'big' CPU, and
> for simplicity I assumed no 'pressure' of any kind).

ok, i missed the big cpu

>
> > not the cpu capacity. I think you miss one piece of the
> > recent pelt behavior here
>
> That could very well be the case, which piece are you thinking of?

The current pelt algorithm track actual cpu utilization and can go
above cpu capacity (but not above 1024) so a  task utilization can
become bigger than a little cpu capacity

>
> > I fullygree that when the system os
> > overcommitted the util base task placement is not correct but I also
> > think that feec() can't find a cpu in such case
>
> But why are we even entering feec() then? Isn't this just looking for
> trouble really? As per the example above, task migrations can cause util
> 'gaps' on the source CPU which may make it appear like a good candidate
> from an energy standpoint, but it's all bogus really. And let's not even
> talk about how wrong the EM is going be when simulating a potential task
> migration in the overcommitted case.
>
> > > CPU looks half empty. Is it half empty? We've got no way to tell until
> >
> > The same here, it's not thanks to util_est
>
> And again, an out-of-date util est value is not helpful in the general
> case. It helps certain use-cases, sure, but please let's not promote it
> to a load-bearing construct on top of which we build our entire
> scheduling strategy :-)
>
> > > we see idle time. The current util_avg and old util_est value are just
> > > not helpful, they're both bad signals and we should just discard them.
> > >
> > > So again I do feel like the best way forward would be to change the
> > > nature of the OU threshold to actually ask cpuidle 'when was the last
> > > time there was idle time?' (or possibly cache that in the idle task
> > > directly). And then based on that we can decide whether we want to enter
> > > feec() and do util-based decision, or to kick the push-pull mechanism in
> > > your other patches, things like that. That would solve/avoid the problem
> > > I mentioned in the previous paragraph and make the OU detection more
> > > robust. We could also consider using different thresholds in different
> > > places to re-enable load-balancing earlier, and give up on feec() a bit
> > > later to avoid messing the entire task placement when we're only
> > > transiently OU because of misfit. But eventually, we really need to just
> > > give up on util values altogether when we're really overcommitted, it's
> > > really an invariant we need to keep.
> >
> > For now, I will increase the OU threshold to cpu capacity to reduce
> > the false overutilized state because of misfit tasks which is what I
> > really care about.
>
> Cool, and FWIW I am supportive of making this whole part of the code
> better -- a transient OU state due to misfit does make a mess of things
> and we should indeed be able to do better.
>
> > The redesign of OU will come in a different series
> > as this implies more rework.
>
> Ack, this can be made orthogonal to this work I think.
>
> > IIUC your point, we are more interested
> > by the prev cpu than the current one
>
> Hmm, not sure to understand that part. What do you mean?

As replied to Lukasz, if you want to discard utilization of a trask
you need to check the previous cpu

>
> Thanks,
> Quentin

