Return-Path: <linux-kernel+bounces-227562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724091533C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08F2284733
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3B19DF43;
	Mon, 24 Jun 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvmdGyIV"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745E13DDC6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245735; cv=none; b=uOIK9RogmnOXdSZ9nqBA54jegGzgKVIMvd6vx7NtctAEK5bqMhbvwnWLTCvSSOs32peYjXBco81HA/TsUh6SASeVmRDhQLgx0952VUcRQ5qBP78GYylHeu/MYJzU1aqvI+oaCetZOfY2/K3Octgpiq/DDvGaIesVZnBrD24Oweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245735; c=relaxed/simple;
	bh=u8kHISbxUhLuHXYIrwQnWUymSkY9AbfwHSKffeBcQLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfW52v7MED+sKm+RRbm6F95XfcnnsjowvZ3TgHZADXGPZUKMwRgQhRQs/Y0q1r1fKm7nXfh5Z+yCT+JcXdD4WJHAob39tnlDhdV78/GebofJltzYliX9di1JB+7uLcZVXVrlY313OV0HvzCe1r5uQ0Tio/FYktcws2bPP31Xs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vvmdGyIV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7180308e90bso1888769a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719245732; x=1719850532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESCmjc+gXkWGK5qE/lkE2zydjhMGckqdJdyvpNpB8qk=;
        b=vvmdGyIVXukZUdOAZZPbYRPsJpyKJ2PKhNejIdg3W99Y+LGtWQ7Dm7uaX9QondIZ1o
         or1Zatu0nRAh8rQtXLJPGN6Tv71xHRIeO+441BlmDgx5TT+pTqAYCYWoCvxnMgDG+LNB
         cg9ZWtUZgvxkS5qqFF1J4t0yyXXOgbqAkYMsu6ne6Swy6RJmtTUaiogcBln/+qndjrv+
         3xvXKrebZMf/zIIB0eMq+RlzPTTw9HqGD+IzZBPromDoosXJ0OY+ky0splJV6d7aAs7C
         FkU/U+l0wXfZVRHQlmM9bztfm2KUxsmzYLmAMFFKVn5mEkokOS9XK2fCc7RLKeglFdLM
         nSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245732; x=1719850532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESCmjc+gXkWGK5qE/lkE2zydjhMGckqdJdyvpNpB8qk=;
        b=RuS3UHKaXQkxtg0ddMuXuKKgm/n3izgPivwzjcT+CWxaewFHL8ydEcbNWyEe8/GDCP
         pE64AMjCE4iXhFhculMxOm9XEr22TLRj5iMQbkdm+kyXG4L38KxJTDRUuAGcqfLX0xFd
         sKjP10pPLw7dvPGHGHQG6+Y1XrVfiZctxbcXbNIaunxUvb9rM2/YXTVA6SOJSmyoc/vl
         Pd/6n8I3w/nR3Jw0qxWxJBTWcwqlNtMaIx7QBnG6PgPXBnyBZOBI9wrr5hRtWvRMLXzD
         /Xm/CCIuI1z5XwPs5+NRJStzb03wWfG6K4ae7v/4jT/+IIT56fqkJl/hxTjkVLOpDFdA
         61PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAT/NbEzZl5fkdeJuANagR3sDinPgVr7rRkAj51VIBEyTvFqPm1qfZCBvlG2BaxLhO2vHntkd2/7y6xq/MWeDiim5vuxre7b78/jm+
X-Gm-Message-State: AOJu0YwTgbddhSRrV6JiQpE/nw98mLqH1w6Uy+JBIarKkp1KAJSmfp92
	fehgHmpuQJImuTqgtyM8antHNRcnWOfsVoutz/0txr1aj3QEXqQuU5ql5n2fxMH3E5Ek867FVQe
	PcWEX7KVCtXijCxJI7kU3xs8SqnWvD03BGxo6BQ==
X-Google-Smtp-Source: AGHT+IGQPaUFOQx7pbSZ9sEzbafpPFiLShdPhKC/UM/aacO/wIOQ9ZXjGD3jEx/22fVolV2PDs7b12IYbPpOQDQVJ30=
X-Received: by 2002:a17:90b:4a82:b0:2c7:af6f:5e52 with SMTP id
 98e67ed59e1d1-2c86124cbd9mr3477373a91.19.1719245731837; Mon, 24 Jun 2024
 09:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org> <20240501151312.635565-11-tj@kernel.org>
 <20240624123529.GM31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240624123529.GM31592@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Jun 2024 18:15:20 +0200
Message-ID: <CAKfTPtD-YHaLUKdApu=9AhKAdg5z7Bp-3089DcdA7NL2Y5pxiA@mail.gmail.com>
Subject: Re: [PATCH 10/39] sched: Factor out update_other_load_avgs() from __update_blocked_others()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 14:35, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 01, 2024 at 05:09:45AM -1000, Tejun Heo wrote:
> > RT, DL, thermal and irq load and utilization metrics need to be decayed and
> > updated periodically and before consumption to keep the numbers reasonable.
> > This is currently done from __update_blocked_others() as a part of the fair
> > class load balance path. Let's factor it out to update_other_load_avgs().
> > Pure refactor. No functional changes.
> >
> > This will be used by the new BPF extensible scheduling class to ensure that
> > the above metrics are properly maintained.
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: David Vernet <dvernet@meta.com>
> > ---
> >  kernel/sched/core.c  | 19 +++++++++++++++++++
> >  kernel/sched/fair.c  | 16 +++-------------
> >  kernel/sched/sched.h |  3 +++
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 90b505fbb488..7542a39f1fde 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7486,6 +7486,25 @@ int sched_core_idle_cpu(int cpu)
> >  #endif
> >
> >  #ifdef CONFIG_SMP
> > +/*
> > + * Load avg and utiliztion metrics need to be updated periodically and before
> > + * consumption. This function updates the metrics for all subsystems except for
> > + * the fair class. @rq must be locked and have its clock updated.
> > + */
> > +bool update_other_load_avgs(struct rq *rq)
> > +{
> > +     u64 now = rq_clock_pelt(rq);
> > +     const struct sched_class *curr_class = rq->curr->sched_class;
> > +     unsigned long thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> > +
> > +     lockdep_assert_rq_held(rq);
> > +
> > +     return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> > +             update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > +             update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
> > +             update_irq_load_avg(rq, 0);
> > +}
>
> Yeah, but you then ignore the return value and don't call into cpufreq.
>
> Vincent, what would be the right thing to do here?

These metrics are only consumed by fair class so my first question would be:

- Do we plan to have a fair and sched_ext to coexist ? Or is it
exclusive ? I haven't been able to get a clear answer on this while
reading the cover letter

- If sched_ext is exclusive to fair then I'm not sure that you need to
update them at all because they will not be used. RT uses a  fix freq
and DL use the Sum of running DL bandwidth. But if both an coexist we
use be sure to update them periodically

