Return-Path: <linux-kernel+bounces-273044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A539463F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D771F22D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966124B28;
	Fri,  2 Aug 2024 19:32:36 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE81ABEA5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627155; cv=none; b=s1T+P2RT3e0xGBjoSYfaAjprChWiTwHx9ckG25tvqmStSjWtIFgj7I+ObiKhdvF6E86qqRU04TRmwfHQqdz+l2SMeVilu7VEVWnUPSl7WDnUNL/EvXALfBeVj4nHYIQTn5tl0z3AGHcASUgjYAoLmfYwQ+WdKeDqHUIpy2olDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627155; c=relaxed/simple;
	bh=OgwaN75HRRT1Qec4egz3FXRmawq4KRvhVa4/7kRbRyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfThlupr64/DriI7gTkNgbz26Zg5aCgsETTR0IPVbf04Xdp9VNZNjXFarqqH6qDEmrxAHupnjm7UANSLazGJWi84j7xLbrUvygEwGLoUFbr32tbFkqBKi+DH4xY/uzQcXBu9KS4TYbN6cMYxzhcHkwfU5BHJRwp6K3BO+5B2Nos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so5773510a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722627154; x=1723231954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJz4xqTkpbsz5B/Z/O7+Q8fvwOR5A/2YE3X38np2dj0=;
        b=rkFXTrXTFdcSvg1ImfaGCK6TT9dkcwT0p6Hr/JPea62rUVQsfRPQFcpiCC89zHrDf5
         YPsyjTRx2op7xgoNw5jlLxcoWOsYH4/aAkCTMAuFUtKnprHBgG8yJ4CsqovSOB1QRS6/
         haLru23UUge1UuINCVgJDW5FoPuS3m7O/TSRcu7D7geblNn06RI1sCQxjGpoq4izO/9p
         7O7QxXJsh9M0rqvTQc0RfSIrhsURt/s3n8TYRfD9C+tR9ie8rANQrzIex+kYbfouwH9V
         Tw/2xUSfDQP0qKfrx1T2DxaahxlhrP7IVUP5cIOnOSNX4uWv9eLCqYhKN8fcGZhn7+RU
         T0UA==
X-Forwarded-Encrypted: i=1; AJvYcCV2r/BxSCW3afNRkz8ywrsN1zpBid9TDKm8zx8GX+r5Vx7dS2EAbR2azRSoiRwO2FEsAL+S75W1DybAKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWAYduFa/h7gmXwA3LXz2JzG++ZhM7qyUy9c+AiIBMYptVGoR
	pKreQtZ9M/kK+TBq1z070mqs7f6GnYOajPpgjLv+ouoNCuMG2Lb2sYbF7qG0IK5hxhwJUXL1AmT
	lFku9dRAO0q2nlVK5lNgMrrvqWdM=
X-Google-Smtp-Source: AGHT+IHIjvgMP7XmEYiDoMc00oPc5hY/ni+N69p0N144S3HojMq72Bm5hCR8FKmEcNC8sfx01Zz2NxRtnm23d9e8i10=
X-Received: by 2002:a17:90b:23d4:b0:2c9:81c6:b0e7 with SMTP id
 98e67ed59e1d1-2cff952d0d7mr5250993a91.30.1722627153489; Fri, 02 Aug 2024
 12:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731000607.543783-1-namhyung@kernel.org> <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net> <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net> <20240802191123.GC12673@noisy.programming.kicks-ass.net>
In-Reply-To: <20240802191123.GC12673@noisy.programming.kicks-ass.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Aug 2024 12:32:21 -0700
Message-ID: <CAM9d7cisWgqdyVkxgY4q5PYUTGrxus6H55f81Z4VwqCsM1FoOA@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 12:12=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Aug 02, 2024 at 08:50:23PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2024 at 08:43:50PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2024 at 08:38:41PM +0200, Peter Zijlstra wrote:
> > > > On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > > > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(vo=
id *info)
> > > > > >       if (reprogram) {
> > > > > >               ctx_sched_out(ctx, EVENT_TIME);
> > >
> > > Clearly I should read better...
> > >
> > > > > >               add_event_to_ctx(event, ctx);
> > > > > > -             ctx_resched(cpuctx, task_ctx, get_event_type(even=
t));
> > > > > > +             if (ctx->nr_events =3D=3D 1) {
> > > > > > +                     /* The first event needs to set ctx->is_a=
ctive. */
> > > > > > +                     ctx_resched(cpuctx, task_ctx, NULL, get_e=
vent_type(event));
> > > > > > +             } else {
> > > > > > +                     ctx_resched(cpuctx, task_ctx, event->pmu_=
ctx->pmu,
> > > > > > +                                 get_event_type(event));
> > > > > > +                     ctx_sched_in(ctx, EVENT_TIME);
> > > > >
> > > > > The changelog doesn't mention the time difference much. As my
> > > > > understanding, the time is shared among PMUs in the same ctx.
> > > > > When perf does ctx_resched(), the time is deducted.
> > > > > There is no problem to stop and restart the global time when perf
> > > > > re-schedule all PMUs.
> > > > > But if only one PMU is re-scheduled while others are still runnin=
g, it
> > > > > may be a problem to stop and restart the global time. Other PMUs =
will be
> > > > > impacted.
> > >
> > > So yeah, this stops ctx time but not all PMUs.
> >
> > But isn't this already the case? We don't have perf_ctx_disable() here
> > currently.
> >
> > Bah, this heat is melting my brain.
>
> I think all it wants is to update time and ensure the added event and
> the resched all use the same time, which could be done differently.
>
> But I'll have to continue staring at this later.

Right, probably we can move time tracking to pmu_ctx.

thanks,
Namhyung

