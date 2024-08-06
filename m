Return-Path: <linux-kernel+bounces-276778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F40949842
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E46282C01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA6113D525;
	Tue,  6 Aug 2024 19:29:15 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3042AA3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972555; cv=none; b=Wwh9yF8Q9/z9ylqQssPm9u6JOgrmF0+6zxhRvEVj7KwzIWRMihD8z0EkM69/P3a0YvKbHQ9jCgA3kRDEaiGdmPjmjtj8bAZFV0hYJqleCUtG0iCX0iC2xy/IDARPT5WTkCF9peQ/Ib8LYkO8viFbrK9cIq9GLxk+8Vp9NDWTo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972555; c=relaxed/simple;
	bh=hX1U3OYxqcRaOns9CkE9/DTByX9kG3JIpbmIqQCTBFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE2tsKpDHUIXY6YZjA079hy03byOfRSOVyE4D7NLY8wjq3d4vsg1a+E4Wq/FpDsoGsBKIZ44Y4gcAv3XecLfLCbR4FMX91SoyFYrPqAUEqB+Ly5T8x/1fSCXcz6JRoCm3HnstQ5+rAyleskly8F7Rm2WJxxwCSsoYh/SeqPQ5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7bb75419123so728903a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972553; x=1723577353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+60JV+Pi39dzmT8HhulLl3F1zl6AyrIn9VNVnxZRdZE=;
        b=XSAU5Z7xJAgy8lufHSjiyKrdvd1yy4ANZwkuhsK6yTvw1h0/QZkDYfq8zka4AyGc40
         UUEBi6TAlrjrOgNoVhN22w0bnp+sCdMNGs56BDpQTICcliby//+2R917iXoL8kj4leJ2
         PwkGpgMmoyaq1t2MKnYM3O7jiu6Gf4ef6ByBSd98PGRPaMQjluZxnCv224g88b6nHrZP
         y/j1H6q7ZTVIttyzYecqqe/qcUyiAMUOLG6VabEDzEDqzwR9z6Ek+jTWPdYDnZkfXd1R
         GJWfoXybb4oGStms+Kk4pAUuI0rAUHDBqMzMvr+L+tCHtD35svRDvt/ON61XwCnq027p
         +Y8A==
X-Forwarded-Encrypted: i=1; AJvYcCW7eDu2CouVUvlhibFO1NUW1IdCCmol739EQaI7K0edjAfX5bCbROOcDVb4d33vYN50jOqBvggxBfZk70tZc7w1IQ+Otx2WK/2xA8Vo
X-Gm-Message-State: AOJu0Yzeu8SczLHmHDgHToAm2HtrHncU7IYOrnWz2Y5n2ObnvcCz/wyT
	R1gzylenYTgQ1TwplkhH8m3cQijVURsvAsfI9X5nSZ4sMosxEdsxWEVyOR8dZcHcysiv2ZWy8wi
	TNdMd42WJRTt/65yC6skUfkj6A6Y=
X-Google-Smtp-Source: AGHT+IGRWfreRNnctKZ8ixT5eJZkLYL/fnQDOAs0eUyrXw9xfUoOnLSvXSQCmSr2Lva1iE23aWygWcbNUO5pPVsW6bI=
X-Received: by 2002:a17:90a:e54b:b0:2cb:5de9:842c with SMTP id
 98e67ed59e1d1-2cff9475fa1mr15550799a91.25.1722972552870; Tue, 06 Aug 2024
 12:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731000607.543783-1-namhyung@kernel.org> <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240805092058.GK37996@noisy.programming.kicks-ass.net> <20240805145827.GE12673@noisy.programming.kicks-ass.net>
 <CAM9d7cj8YMt-YiVZ=7dRiEnfODqo=WLRJ87Rd134YR_O6MU_Qg@mail.gmail.com>
 <20240806075630.GL37996@noisy.programming.kicks-ass.net> <20240806080757.GF12673@noisy.programming.kicks-ass.net>
In-Reply-To: <20240806080757.GF12673@noisy.programming.kicks-ass.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Aug 2024 12:29:01 -0700
Message-ID: <CAM9d7ciSJXFC4Wdioy2PxZNCd+6-+kcA6+qqJs-BvQ3yAgQmAg@mail.gmail.com>
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

On Tue, Aug 6, 2024 at 1:08=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Aug 06, 2024 at 09:56:30AM +0200, Peter Zijlstra wrote:
>
> > Does this help? What would be an easy reproducer?

Yep, it helps!  I guess you can reproduce it easily with:

  $ sudo perf stat -a sleep 1

> >
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index c67fc43fe877..4a04611333d9 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -179,23 +179,27 @@ static void perf_ctx_lock(struct perf_cpu_context=
 *cpuctx,
> >       }
> >  }
> >
> > +static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
> > +{
> > +     /*
> > +      * If ctx_sched_in() didn't again set any ALL flags, clean up
> > +      * after ctx_sched_out() by clearing is_active.
> > +      */
> > +     if (ctx->is_active & EVENT_FROZEN) {
> > +             if (!(ctx->is_active & EVENT_ALL))
> > +                     ctx->is_active =3D 0;
> > +             else
> > +                     ctx->is_active &=3D ~EVENT_FROZEN;
> > +     }
> > +     raw_spin_unlock(&ctx->lock);
> > +}
> > +
> >  static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
> >                           struct perf_event_context *ctx)
> >  {
> > -     if (ctx) {
> > -             /*
> > -              * If ctx_sched_in() didn't again set any ALL flags, clea=
n up
> > -              * after ctx_sched_out() by clearing is_active.
> > -              */
> > -             if (ctx->is_active & EVENT_FROZEN) {
> > -                     if (!(ctx->is_active & EVENT_ALL))
> > -                             ctx->is_active =3D 0;
> > -                     else
> > -                             ctx->is_active &=3D ~EVENT_FROZEN;
> > -             }
> > -             raw_spin_unlock(&ctx->lock);
> > -     }
> > -     raw_spin_unlock(&cpuctx->ctx.lock);
> > +     if (ctx)
> > +             __perf_ctx_unlock(ctx);
> > +     __perf_ctx_unlock(&cpuctx->ctx.lock);
>
> Obviously that wants to be just: &cpuctx->ctx :-)

Sure.  And I think we need this for perf_ctx_lock() too.

Thanks,
Namhyung

>
> >  }
> >
> >  #define TASK_TOMBSTONE ((void *)-1L)

