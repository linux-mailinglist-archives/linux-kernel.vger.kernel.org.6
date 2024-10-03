Return-Path: <linux-kernel+bounces-348756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4398EB7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EC41F216E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34DC139566;
	Thu,  3 Oct 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fo/soYTG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A212D1EA
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943702; cv=none; b=rCgVUpyMv6Rp+hbly63kppv8d1G6xVoYT8LoyN1D5W9cwrelkoaWzuEfNpuZRG5ZqX4yMI8VREdgAJNs5sRqRhyLu2jS79ZLOjZZ2SzR19BO36gC9YZxsQqKYjSSB5/D9xayzYOdRW2v2IpTNKDfoFhB9mujia+OOGXQZoElme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943702; c=relaxed/simple;
	bh=KplTSHqztpM1Dh+dAV6//u3uKBrryVreQyEsBnaiJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWl+74rh+oVtN9wpAucu8AfHyRwJs/ChWRO1yFgTyLiyH5YI8Ynh5+lj/K/2KBZr4lS2xBSPGDuwJPfiAB+jfLzl6ucEvc0McG6RNTkaksapV2z3zUS0aSBMrT7+Hv63ZsMSQNlU/LboFq1+Mroz0/wBj4niBPPFYTrXuY1OirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fo/soYTG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so847585a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727943699; x=1728548499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpZauHiXCQ9ONC1tT9ErZ1Hq9O7Cm3x7myLl9yKn6OI=;
        b=Fo/soYTG5bgUkGcVuEy0lP2xopWAsYrXTnasAa1kcnbJwQZFcjeCNFxrgg6qR5O/dg
         wWb6NMGX4Isy5d3CjRJyNbQmN2LaKGqohlVLB3UubUipo7JM/FcF7W60nEkuHZnZqGE+
         1O5bk/nlwRw61Tghaupm4Afgm4eTTNqCD9YWP0XsgDMiEINR4ioLYHpmDfdmiV89IZv4
         MItbxdoNlxhQxu50s2RCBKDFqmccHokJUIcItcs/M/YRWgZ5KviJ/B61Tkd9N/Q79UUT
         M5Gb4I47he9PwiiF7yaeeZ+W+v52Rmz3s0zko4LUaNFTL+89bDEqwNdHi/ecyQ7nJCYa
         IjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943699; x=1728548499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpZauHiXCQ9ONC1tT9ErZ1Hq9O7Cm3x7myLl9yKn6OI=;
        b=RYx64nKEBVmhoDz58x6JuAkTbD5BIEh8jw8DsTrM8HCLq/sUQc5rV2ZA9GBI1IajV7
         2evRb/uwW+ZOko9ed2fTMZ3WDo44+/ODr0WDV7pt4+RuaBAxa1fTNqrc/NkzEQWAGfUf
         kPTcJ7TERRRUvY1EWvinGG7WQXJkpNjPqUdNOcVO2UDFg0DBOrQSXZs7yW75Oev1jiuX
         Pc45lJbUbbJ2V5nELqGuUdh0IVWRjoNFlaXd6KLkrCYNPBmB31eQK+87dawu03YJ8tK3
         VJpZXP5GSov72UPQ6ficL2/brvjscB40ufi+LknsN6lBxE6kGsmm/P86SJeDLkjmJkBL
         +0lA==
X-Forwarded-Encrypted: i=1; AJvYcCWoIfiYbDuHvpnxWmUyh6UegXlp4ZoYFXxdJwsg2DAZPZgW27OBT6XU58uiHyrWxi0t1RCWW9vW/Cb/IEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2Tjn1gbLtbNjMD+bQeOKEXMwPkZmhdxbh9lWZz9/rIAa9lb3
	jfDwelJS8zur9BMreiqtF2DHs5hw3euTgc19eFzgt/XyHbgTOVB8Wsu+y2G9Lg==
X-Google-Smtp-Source: AGHT+IHCJS8ODk4IYAkWoDrQH7x4Z50UgiLow/a8s1L+GGL6vmTC9ZDgJub/gyg7IVo73Xs8VrVxrQ==
X-Received: by 2002:a05:6402:34cf:b0:5c2:5438:6ea with SMTP id 4fb4d7f45d1cf-5c8b1a3363fmr5148411a12.19.1727943698311;
        Thu, 03 Oct 2024 01:21:38 -0700 (PDT)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3fb68fsm438025a12.47.2024.10.03.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:21:38 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:21:34 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	qyousef@layalina.io, hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <Zv5UDufqpoXvSocy@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
 <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>

On Thursday 03 Oct 2024 at 08:27:00 (+0200), Vincent Guittot wrote:
> On Tue, 1 Oct 2024 at 19:51, Quentin Perret <qperret@google.com> wrote:
> > And again, checking that a task fits is broken to start with if we don't
> > know how big the task is. When we have reasons to believe that the util
> > values are no longer correct (and the absence of idle time is a very
> > good reason for that) we just need to give up on them. The fact that we
> > have to resort to using out-of-date data to sort of make that work is
> > just another proof that this is not a good idea in the general case.
> 
> That's where I disagree, this is not an out-of-date value, this is the
> last correct one before sharing the cpu

This value is arbitrarily old, so of course it is out of date. This only
sort of works for tasks that don't change their behaviour. That's true
for some use-cases, yes, but absolutely not in the general case. How
can you know that the last correct value before sharing the CPU is still
valid minutes later? The fact that the system started to be
overcommitted is a good indication that something has changed, so we
really can't tell. Also, how is any of this going to work for newly
created tasks while we're overcommitted for example?

> > > the commit that I mentioned above covers those cases and the task will
> > > not incorrectly fit to another smaller CPU because its util_est is
> > > preserved during the overutilized phase
> >
> > There are other reasons why a task may look like it fits, e.g. two tasks
> > coscheduled on a big CPU get 50% util each, then we migrate one away, the
> 
> 50% of what ?

50% of SCHED_CAPACITY_SCALE (the above sentence mentions a 'big' CPU, and
for simplicity I assumed no 'pressure' of any kind).

> not the cpu capacity. I think you miss one piece of the
> recent pelt behavior here

That could very well be the case, which piece are you thinking of?

> I fullygree that when the system os
> overcommitted the util base task placement is not correct but I also
> think that feec() can't find a cpu in such case

But why are we even entering feec() then? Isn't this just looking for
trouble really? As per the example above, task migrations can cause util
'gaps' on the source CPU which may make it appear like a good candidate
from an energy standpoint, but it's all bogus really. And let's not even
talk about how wrong the EM is going be when simulating a potential task
migration in the overcommitted case.

> > CPU looks half empty. Is it half empty? We've got no way to tell until
> 
> The same here, it's not thanks to util_est

And again, an out-of-date util est value is not helpful in the general
case. It helps certain use-cases, sure, but please let's not promote it
to a load-bearing construct on top of which we build our entire
scheduling strategy :-)

> > we see idle time. The current util_avg and old util_est value are just
> > not helpful, they're both bad signals and we should just discard them.
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
> For now, I will increase the OU threshold to cpu capacity to reduce
> the false overutilized state because of misfit tasks which is what I
> really care about.

Cool, and FWIW I am supportive of making this whole part of the code
better -- a transient OU state due to misfit does make a mess of things
and we should indeed be able to do better.

> The redesign of OU will come in a different series
> as this implies more rework.

Ack, this can be made orthogonal to this work I think.

> IIUC your point, we are more interested
> by the prev cpu than the current one

Hmm, not sure to understand that part. What do you mean?

Thanks,
Quentin

