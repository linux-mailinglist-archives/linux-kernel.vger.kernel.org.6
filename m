Return-Path: <linux-kernel+bounces-348793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFA98EBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFA81F234B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162313DBB1;
	Thu,  3 Oct 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJJRtaKb"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726F13B2AF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945588; cv=none; b=XLauJHrbN2YmsgsxJLIczm8Rky0MZUVQ0VCKQMbbC6gjfL+BH5AP1NUdE8FEyhV2CsyVI97GKmdV6NdPRrZuDD6vDwdEoSO4XKUwIZavzzA4eMUX6SqOloKH+JI8VwlR7FvixebVnfymrA5veqKVW7TZ9zUOvJPvle7ocOZgEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945588; c=relaxed/simple;
	bh=8/RcAShUx+4/hucXdLx+VDk3Ev07N7XvQkGwK7Djepk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLMYaluXxy/CRw2XAFUKdWDA4XXNx91SyzttSUfRvD81AjBC1ktz3pS01xn+fHdugyI3Yjq/zWxi87L/exBl/kPHPW9Lwg3havTeiHR6i/CP/N9QtPhkGgCRUen+NtxbyKLp5xEzMoq3/XtixAv7SnqbSWpIj9Gg8uCSdp/rHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JJJRtaKb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e109539aedso640188a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727945586; x=1728550386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/ew+xUpwTY6RSUemCgB2ze/fVhIK30NyPUNAms6Zsc=;
        b=JJJRtaKbDnNQO9/iC6GXrC7mW+BbwJ55B7OoO76WDmZY3S2EHyljbVgwckUStImkIH
         hr5H1dFMwR+og/gO6VzUfPEPnx6xASmXNEIidqXZ/IGbopbtp0yE+HR8yj06260qorLI
         ANCbO+x+dlYcbPHwJ5GhAzIgowI0AYAvlkz7aWW22ulety0iBfTGxqKdXSat9Sv6u53B
         KBlMcAfzpoaugTKJeHRsnXNMHHXDxTh5swdiJohzg7Njo0ARbj+mItFhwT+1riaeVAPb
         zB3f4cVJJHdILGj+Mb5VPs4SAF/D4z+AJYqqtSZNAm1sS/TTGieFuxNcYjfYtzDM6Zws
         9ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945586; x=1728550386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/ew+xUpwTY6RSUemCgB2ze/fVhIK30NyPUNAms6Zsc=;
        b=e6EAMWIg3GSbkfwAVFedrs/VT1ScpsGHnjhzIExtigeX0tI41d5176lFr9ivwhibJ/
         58RPnGr3ChHfyV+CwX+BcIQcqJR5E4RKi8JJmuJAV+CN9OeRy1DzrGzSLPJnUSHF2e8h
         DiLjfIksPKAY1b9TBN2bZS352b9IZxfS/LnPV5ykCvQEJQOGFhX0I81lYuyXq2wn0kNi
         6pwoGGxRemUHmMDS3ez+iitu7C70LLPWji3+kMLwi7v0OxK8S6Id9BjdM83/mli+JcRc
         HOuCr8761iQawpFKgPcS+2N5S38LLNhUgwl2Eo1PwdQpLlW8vQxizSS97tPbBFOwY9sT
         D4zg==
X-Forwarded-Encrypted: i=1; AJvYcCUQtpEnp2CQREY5w4+7JZwG/kBBf8D8pqGBm9lLGLqRSoKSaLR97Y10GgnkNoEjzQOCFWfeOsUGR7dkyvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgc3PfgnVAwXgyMQaXFzPA5E80WPZpqMDzl9qTYXUZLQ7EZBWF
	s2Nq5T9S0RKyhUqOkEudSixJ+k6cYKKIqbw8QFnu8SXl+lBDJ04pigGr/+aZAP3ZUNqc4Vpy1bx
	XJgjteTQn/FxClucddaoYyXiK+sKz6mpYYka7nw==
X-Google-Smtp-Source: AGHT+IHWHGiQk1HjIJ8MEluWaOhvqWglzVczOR8aRpVDcBjY6lrbMylBCpz4S/StSmxDxkrDwrXruWcuQpRrqy8cScg=
X-Received: by 2002:a17:90a:c7cb:b0:2e0:90fe:cc2c with SMTP id
 98e67ed59e1d1-2e1849696e5mr7309917a91.26.1727945585811; Thu, 03 Oct 2024
 01:53:05 -0700 (PDT)
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
 <71e7e154-584a-4856-b906-ba92c636b17f@arm.com>
In-Reply-To: <71e7e154-584a-4856-b906-ba92c636b17f@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 3 Oct 2024 10:52:54 +0200
Message-ID: <CAKfTPtD1N1qqEPV8AAhbRh-kzqXutNWi8+e11D5Z+8kQztC8FA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, rafael.j.wysocki@intel.com, 
	linux-kernel@vger.kernel.org, qyousef@layalina.io, hongyan.xia2@arm.com, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 10:14, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> On 10/3/24 07:27, Vincent Guittot wrote:
> > On Tue, 1 Oct 2024 at 19:51, Quentin Perret <qperret@google.com> wrote:
> >>
> >> On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
> >>> With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
> >>> utilization"), the util_est remains set the value before having to
> >>> share the cpu with other tasks which means that the util_est remains
> >>> correct even if its util_avg decrease because of sharing the cpu with
> >>> other task. This has been done to cover the cases that you mention
> >>> above whereboth util_avg and util_est where decreasing when tasks
> >>> starts to  share  the CPU bandwidth with others
> >>
> >> I don't think I agree about the correctness of that util_est value at
> >> all. The above patch only makes it arbitrarily out of date in the truly
> >> overcommitted case. All the util-based heuristic we have in the
> >> scheduler are based around the assumption that the close future will
> >> look like the recent past, so using an arbitrarily old util-est is still
> >> incorrect. I can understand how this may work OK in RT-app or other
> >
> > This fixes a real use case on android device
> >
> >> use-cases with perfectly periodic tasks for their entire lifetime and
> >> such, but this doesn't work at all in the general case.
> >>
> >>> And feec() will return -1 for that case because util_est remains high
> >>
> >> And again, checking that a task fits is broken to start with if we don't
> >> know how big the task is. When we have reasons to believe that the util
> >> values are no longer correct (and the absence of idle time is a very
> >> good reason for that) we just need to give up on them. The fact that we
> >> have to resort to using out-of-date data to sort of make that work is
> >> just another proof that this is not a good idea in the general case.
> >
> > That's where I disagree, this is not an out-of-date value, this is the
> > last correct one before sharing the cpu
> >
> >>
> >>> the commit that I mentioned above covers those cases and the task will
> >>> not incorrectly fit to another smaller CPU because its util_est is
> >>> preserved during the overutilized phase
> >>
> >> There are other reasons why a task may look like it fits, e.g. two tasks
> >> coscheduled on a big CPU get 50% util each, then we migrate one away, the
> >
> > 50% of what ? not the cpu capacity. I think you miss one piece of the
> > recent pelt behavior here. I fullygree that when the system os
> > overcommitted the util base task placement is not correct but I also
> > think that feec() can't find a cpu in such case
> >
> >> CPU looks half empty. Is it half empty? We've got no way to tell until
> >
> > The same here, it's not thanks to util_est
> >
> >> we see idle time. The current util_avg and old util_est value are just
> >> not helpful, they're both bad signals and we should just discard them.
> >>
> >> So again I do feel like the best way forward would be to change the
> >> nature of the OU threshold to actually ask cpuidle 'when was the last
> >> time there was idle time?' (or possibly cache that in the idle task
> >> directly). And then based on that we can decide whether we want to enter
> >> feec() and do util-based decision, or to kick the push-pull mechanism in
> >> your other patches, things like that. That would solve/avoid the problem
> >> I mentioned in the previous paragraph and make the OU detection more
> >> robust. We could also consider using different thresholds in different
> >> places to re-enable load-balancing earlier, and give up on feec() a bit
> >> later to avoid messing the entire task placement when we're only
> >> transiently OU because of misfit. But eventually, we really need to just
> >> give up on util values altogether when we're really overcommitted, it's
> >> really an invariant we need to keep.
> >
> > For now, I will increase the OU threshold to cpu capacity to reduce
> > the false overutilized state because of misfit tasks which is what I
> > really care about. The redesign of OU will come in a different series
> > as this implies more rework. IIUC your point, we are more interested
> > by the prev cpu than the current one
> >
>
> What do you mean by that?
> Is it due to OU in e.g. Little cluster?
> Is it amplified by the uclamp_max usage?

You need to know if the prev cpu was overcommitted to know if the task
utilization is correct and usable

>
> You're re-writing heavily the EAS+EM and I would like to understand
> your motivation.

I want to cover more cases that are obviously not covered by current
EAS implementation

>
> BTW, do you know that if you or anyone wants to improve the EAS/EM
> should be able to provide the power numbers?

Having power numbers with the latest mainline kernel is not always
easy as platforms don't support it. Typically, pixel 6 doesn't support
v6.11 or even v6.12-rc1 with enough power optimization. And older
custom kernel don't get last changes and are often modified with out
of tree code which are out of the scope of the discussion

>
> W/o the power numbers the discussion is moot. Many times SW engineers
> have wrong assumptions about HW, therefore we have to test and
> measure. There are confidential power saving techniques in HW
> that can be missed and some ugly workaround created in SW for issues
> which don't exist.
>
> That's why we have to discuss the power numbers.
>
> This _subject_ is not different. If EAS is going to help
> even in OU state - we need the numbers.

I don't expect EAS to help during OU state but more to prevent
spreading blindly everything around. I was more concerned to make sure
that EAS doesn't regression perf too much when overutilized so it can
keep sane task placement whenever possible

>
> Regards,
> Lukasz

