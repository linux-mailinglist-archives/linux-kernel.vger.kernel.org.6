Return-Path: <linux-kernel+bounces-532035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BBA447CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2196F1890630
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD219B5B1;
	Tue, 25 Feb 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QockSM2y"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4921194A66
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503674; cv=none; b=gM4Vuc2Bcv0fXcTa/Z5YGU8ySNXLMZkslLC7yZCtEEyArz5WAgjHoVIkqnfgLKX6+AQlWk2TnYAi7GMV9jMOPY8B/kpdW9lnmyuwtIuEjoQfdF3rYui1dC0Ds0q3LoktRkZEqGN3XbQWpU0e05bTFy2NftWYZwkEL8A1eFMI9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503674; c=relaxed/simple;
	bh=o7/9GwWH4+cK/tvtuvXau0Nlwaaw/6Ni2jIOIaP9zxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq6118wLGKj1XHzFBierTTNfbtxz23pgicavRgS539gTFNGwqo64QDRmZP2KfW+hjqTbFTI1lyfM3lQkbemZnrJF2Kqxt3DO1wSZEDnWYtqOXfUiKpBCNS7h6oqAGrRE6lUsKSJMdfBixyDEawkLjtzCTu8OncSo+bCmsiFQESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QockSM2y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so9367401a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503671; x=1741108471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/cGtzAu5V3Ag06Q0Z5HGwm/ObyJ8jpk0pNoE+vuwzE=;
        b=QockSM2y8ZdZ1rZuzgBpPlxzUk7QxBwwmMkuewwobOeGnvhosWsVJrKpbD/wKHx0ex
         T6PmoWHVcIRqGivbor1BdjT73/vFkoG9D29Kbm2XORyrmRUaVkLM03I69+Y9Fe2uMHls
         6rU5WftCRVxi0CUmd3IVXlHoLCWmEqleNjWdom6rlb1xdcpglNU/yw+/3iNfuCU8wtpd
         xR7qdbM2jlfMKQja18doc7GPkR7AQotMNpxJNdhujkdrDR2ddpAxdLupaLGs0Q7dTYkA
         OmZ+wkIl7H9BSz/J3JKlIRmFPh2J5vRkPfutSGR81Nil10/LKXHCn3gSMuwLNqSdiHHr
         8u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503671; x=1741108471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/cGtzAu5V3Ag06Q0Z5HGwm/ObyJ8jpk0pNoE+vuwzE=;
        b=uX7znHTDrB4ore0JFLXhGStgCtdCu2oeKR+T1ePQaBKysUIVqelI0CCRSA/7GWi/k3
         96JvCEmZebJOMzPPZJXpF2dpYB+kP5hI8xPEFScnnzzUdsTZ6AfH9EVSJQI65pghSEsY
         /o2E4mbyEZIx525kLRjWr0WA+qgBx41nw0UhxQDqAz3fF/a9rsNXRIahrE+6hC2Q1yqL
         leCdRryzuuLYDcp7xzzbQuXrOJVNWVJA0zm2Z15HIqc52a63UkeThD1gWzpmrt1zmLS6
         ejgC6pfO3HyhiT4k1Wxmcujsm+cmYEGhBpJjxBXwlognBCN7a6ACrv8+IQFdkfprTrem
         rEig==
X-Forwarded-Encrypted: i=1; AJvYcCW2S1DJawht+ERQr3eANA/wX4hN3/CJXyKDgw5L9jYw4IO9/B/vpGP/ZrvrqlI0bICr4LZsff/Cu59AsuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfbnvbYbmqa0ZVY/hX4kg+RrHYqKgo7C4q8SIm4bUZ8iyZnOt
	lJJqf8/zDBwbPzaApC5CIYcuEbJoHVsOHpfoCJ8dmL63VwLqT9vhZLEaXOQTkfrF3GLfePzjvrV
	M0rbMG6nmmdZcXAi5/1M0gwOF1uw7zMfeNi8LcA==
X-Gm-Gg: ASbGncsY2Jzn6auAJvndrF6U3oH+tdZOqAA1NdO0npgUrzEbtqRGKOaivyAnNXm1UCV
	LW8SF6z/YWXIgkm+dITeD2EY7VFYxTf2bjh7Wj+pr0aKDVElhQ1XcY/ewN06rG+XZEK5WI2uVjY
	ozG2xk50FIfBzZG5vUo7R8Rrt7BWi2W9t8mh7S
X-Google-Smtp-Source: AGHT+IFnPObnGZnDYYewE5bzXeVIht19BBac8VKyUUdJpslUR2AUcA00NGMI4YS0AcP4KOjwd3nk/O6mLWG8xC+eEec=
X-Received: by 2002:a05:6402:5418:b0:5dc:a44d:36a9 with SMTP id
 4fb4d7f45d1cf-5e4a0d7395amr376618a12.14.1740503671051; Tue, 25 Feb 2025
 09:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com> <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com> <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com> <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com> <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
 <20250224141012.GB145991@pauld.westford.csb>
In-Reply-To: <20250224141012.GB145991@pauld.westford.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Feb 2025 18:14:17 +0100
X-Gm-Features: AQ5f1JrZmWZO6GzKxZjIngzdzvqKRhwtJnx36SNELNBOVdFYuz0CeEfGjuvyVYg
Message-ID: <CAKfTPtC1hK7Cpy-+0EmSzB+zsWOZFZau2+LAckHY9CfJV4tvCw@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Phil Auld <pauld@redhat.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 15:10, Phil Auld <pauld@redhat.com> wrote:
>
> On Mon, Feb 24, 2025 at 02:47:13PM +0100 Vincent Guittot wrote:
> > On Sun, 23 Feb 2025 at 12:22, Abel Wu <wuyun.abel@bytedance.com> wrote:
> > >
> > > On 2/23/25 6:25 PM, Madadi Vineeth Reddy Wrote:
> > > > On 23/02/25 14:14, Abel Wu wrote:
> > > >> Hi Madadi,
> > > >>
> > > >> On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
> > > >>> On 21/02/25 21:27, Abel Wu wrote:
> > > >>>> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
> > > >>>>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
> > > >>>>>>
> > > >>>>>> Idle tasks are by definition preempted by non-idle tasks whether feat
> > > >>>>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
> > > >>>>>
> > > >>>>> I don't think it's true, only "sched_idle never preempts others" is
> > > >>>>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
> > > >>>>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
> > > >>>>> others at wakeup, idle, batch or normal
> > > >>>>
> > > >>>> Hi Vincent, thanks for your comment!
> > > >>>>
> > > >>>> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
> > > >>>> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> > > >>>> which said:
> > > >>>>
> > > >>>>       - no SCHED_IDLE buddies
> > > >>>>       - never let SCHED_IDLE preempt on wakeup
> > > >>>>       - always preempt SCHED_IDLE on wakeup
> > > >>>>       - limit SLEEPER fairness for SCHED_IDLE
> > > >>>>
> > > >>>> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
> > > >>>> The rules were introduced in 2009, and to the best of my knowledge there
> > > >>>> seemed no behavior change ever since. Please correct me if I missed
> > > >>>> anything.
> > > >>>
> > > >>> As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
> > > >>> it would help to document that SCHED_IDLE tasks are not preempted by non-idle
> > > >>> tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
> > > >>> preemptions for debugging would be lost.
> > > >>>
> > > >>> Thoughts?
> > > >>
> > > >> I am not sure I really understand the purpose of this debug feature.
> > > >> If it wants to provide a way to check whether a performance degrade of
> > > >> certain workload is due to overscheduling or not, then do we really
> > > >> care about performance of SCHED_IDLE workloads and why?
> > > >
> > > > It's true that we may not be too concerned about performance with
> > > > SCHED_IDLE. The issue is preserve the original SCHED_IDLE definition
> > > > versus WAKEUP_PREEMPTION, which applies across all policies. Since by
> > >
> > > Yes, exactly.
> > >
> > > > default the feature is true. I am not sure. Either way seems ok to me.
> > >
> > > Hi Vincent,
> > >
> > > Since Peter gave the priority to SCHED_IDLE semantics over WAKEUP_PREEMPTION
> > > in his commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation"),
> > > and the choice is kept unchanged for quite a long time until the recent merged
> > > commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> > > which seemed not intend to change it, shall we restore the choice for now and
> > > leave the discussion of the scope of WAKEUP_PREEMPTION to the future once any
> > > usecase shows up?
> >
> > Or we should just remove it. I'm curious to know who used it during
> > the last couple of years ? Having in mind that lazy preemption adds
> > another level as check_preempt_wakeup_fair()  uses it so sched-idle
> > tasks might not always be immediately preempted anyway.
> >
>
> It can be helpful to be able to turn that off when chasing performance
> issues. See the DELAY_DEQUEUE thread from a few months back. In that
> case we never got to a good answer, but did use NO_WAKEUP_PREEMPTION
> during debugging to take out some variables at least. FWIW.

ok, I didn't remember it has been used

>
>
> Cheers,
> Phil
>
> >
> > >
> > > Thanks,
> > >         Abel
> > >
> >
>
> --
>

