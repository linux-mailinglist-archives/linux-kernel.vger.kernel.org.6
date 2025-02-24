Return-Path: <linux-kernel+bounces-529219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E90A42220
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE973AE12D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAE221F36;
	Mon, 24 Feb 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi7/sEah"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD0746E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404848; cv=none; b=qjcrFFHKRBAU1FZj3MpqeOEhltf+g6g4gd4K52rpdKti0Ce6McODrrF+FWb4gyUTpJsP6+r/1iTlijlVLbKhHfv8LdWJjBmenvGqUQlKCQfxbwxFAesRSEh2xIotxNuRHOn5gD30Br9zDjdgj3weSyZ2Ue+DX+IOL/1CKeFfRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404848; c=relaxed/simple;
	bh=fyaxM3VXGRDgOEKYyrlph04bKePu9DuWuWDKlGUkWXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+A1BMRrqah/DmXT0bIFcbpaYZISM4jfSUJEVzyu2BpjY+bcp0viqCuRTKVqvfVJT+vf9Lb97zwWbi5V8npsVbpi8XEzLwf5f/xFUgQ2oBGlsPKZrJFMFxrsEtdeC8VXk1k+3eFVwJ5Ir/gDaZ8yGJMONqKmkneDCm//0Yz43/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gi7/sEah; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abec8b750ebso45252266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740404845; x=1741009645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UWxadMYAfeEJXS/LEvboFT3zJx1f8+ZjjdBdy0sAFDc=;
        b=gi7/sEah/otkm8f5/W6cMQxz+g3njB7OC9am6gAFpoA9466GulCkpAg5m8ADFYkxFU
         cY47Mx1emtuMK95sn99L4H4e5g+bEmp+Sad47gRwP1PmmfnKcz9WamPi9CKnKfPjyVNs
         I6h94rf71hZsXT6qVyqJ7m11uu5KgZO5AD5J3hGN5F+XDyn7xxCDc+Nl3ak0RzfnSGU2
         yVC+UqXw+WMIjUU0XXclQ3useI8OsMUU9O9YkTS/XpJVZpPr08FYi0r/MTX7AivIaClc
         znCVeWeQb6DxUkS0EGi4KzdZw+OEXs8nIvGi+CjjcnkDIbqcJkNGcsHaEW4IhDVSn3C7
         hTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404845; x=1741009645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWxadMYAfeEJXS/LEvboFT3zJx1f8+ZjjdBdy0sAFDc=;
        b=cUZTTk2c2Ws3LepFmTiaHnChIPYxFLa/hBliT1yq7k8XLmr/B1dJN79KF6ZbVmmlhE
         0IMcu6w2INVur+ATX005f2tN/fZYnqfTbEM5Kq/vq90pBQ9iGJQlq649C/C8XVM4mekC
         sKD1ha/Mi5GfQvD6tCSrZV9nX90Xn08TKLVr360S5eijGTns3o5LgabCmc6UkT7UKSI0
         42StCA2V19+mJAmuvadJoTxg8igWBDsvx8riYAEg3gYStGmot1nIVTJ9vrPIo+Zf+clc
         YHJu7iGL5IwTM0eiqsiFJzAPbH7cGZDQxDZ8qJfCpxIYwrQXVibxBik8lIQLrRrZbpvC
         uCWA==
X-Forwarded-Encrypted: i=1; AJvYcCWfHrVqfRQZDCW+H2353CfbOZWF72c1q2T+p9bBazmAr0yCZbgXZBVsc2CcyoF7KUEqbHdnhSeyf/JzZ3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3w64dceZdZH+B/dsKxipjlpoC3lLZLpRlvjTyWNTmmG6NCso
	eGzgdhzSG+0ijQ/8FKMdRRIfTpyqAsnByjN8Z/nCVA43QHDis76jEEKImSC5ERSIAJWxWarVnRA
	O6NhpkFNDP0fnaczoTp9imDmwYLjLxk4f2DhicA==
X-Gm-Gg: ASbGncuVE9By8+Z2/eEmipJARbJD7DguEUP9k1e/V1/ebB8wHhBY29OtruXCXrB2t5j
	xPYU8BX+0ZlYMT5o7ZJ3ningPiVTufdqPkC8/c9M9fgNpEWbBTv6Zm+NiYDA0odVk9slK6BqOKd
	M4Dhus1dP76xjfnAVB3nLZNSiD3lWx2ndpPVUm
X-Google-Smtp-Source: AGHT+IEXgEcaM6fmtiVKMWHxLL7Ev8HZz82tJ/B32qKShU58btSIx9SMgB56lMAxbeTJ8q+/paxbAo5XKePweXwSIfc=
X-Received: by 2002:a17:907:78b:b0:abb:eda0:774a with SMTP id
 a640c23a62f3a-abc0de15e4fmr1177331666b.35.1740404844575; Mon, 24 Feb 2025
 05:47:24 -0800 (PST)
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
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
In-Reply-To: <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Feb 2025 14:47:13 +0100
X-Gm-Features: AWEUYZnNsPwRxUgfL3q2Sxv9igMpR8z18GsQS6d56e-nBG5_y1xsK1p-71OuCz0
Message-ID: <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 12:22, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> On 2/23/25 6:25 PM, Madadi Vineeth Reddy Wrote:
> > On 23/02/25 14:14, Abel Wu wrote:
> >> Hi Madadi,
> >>
> >> On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
> >>> On 21/02/25 21:27, Abel Wu wrote:
> >>>> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
> >>>>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>>>>>
> >>>>>> Idle tasks are by definition preempted by non-idle tasks whether feat
> >>>>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
> >>>>>
> >>>>> I don't think it's true, only "sched_idle never preempts others" is
> >>>>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
> >>>>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
> >>>>> others at wakeup, idle, batch or normal
> >>>>
> >>>> Hi Vincent, thanks for your comment!
> >>>>
> >>>> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
> >>>> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> >>>> which said:
> >>>>
> >>>>       - no SCHED_IDLE buddies
> >>>>       - never let SCHED_IDLE preempt on wakeup
> >>>>       - always preempt SCHED_IDLE on wakeup
> >>>>       - limit SLEEPER fairness for SCHED_IDLE
> >>>>
> >>>> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
> >>>> The rules were introduced in 2009, and to the best of my knowledge there
> >>>> seemed no behavior change ever since. Please correct me if I missed
> >>>> anything.
> >>>
> >>> As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
> >>> it would help to document that SCHED_IDLE tasks are not preempted by non-idle
> >>> tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
> >>> preemptions for debugging would be lost.
> >>>
> >>> Thoughts?
> >>
> >> I am not sure I really understand the purpose of this debug feature.
> >> If it wants to provide a way to check whether a performance degrade of
> >> certain workload is due to overscheduling or not, then do we really
> >> care about performance of SCHED_IDLE workloads and why?
> >
> > It's true that we may not be too concerned about performance with
> > SCHED_IDLE. The issue is preserve the original SCHED_IDLE definition
> > versus WAKEUP_PREEMPTION, which applies across all policies. Since by
>
> Yes, exactly.
>
> > default the feature is true. I am not sure. Either way seems ok to me.
>
> Hi Vincent,
>
> Since Peter gave the priority to SCHED_IDLE semantics over WAKEUP_PREEMPTION
> in his commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation"),
> and the choice is kept unchanged for quite a long time until the recent merged
> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> which seemed not intend to change it, shall we restore the choice for now and
> leave the discussion of the scope of WAKEUP_PREEMPTION to the future once any
> usecase shows up?

Or we should just remove it. I'm curious to know who used it during
the last couple of years ? Having in mind that lazy preemption adds
another level as check_preempt_wakeup_fair()  uses it so sched-idle
tasks might not always be immediately preempted anyway.


>
> Thanks,
>         Abel
>

