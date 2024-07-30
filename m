Return-Path: <linux-kernel+bounces-268242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2688B94221A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12211F251FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7118DF89;
	Tue, 30 Jul 2024 21:19:05 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F01AA3FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374344; cv=none; b=hg50Oa5wuJDym9GydLbgLt5gcRFASmKpbB9NSudWHsioOcryyL/a03xj7brSMie0pO0GHs9Gp/izpbM6/XBv5amRUrMMAtTArHpgKJkEGbJmKGogk/vExVi/oagrWLHeP7eA+WdJzUbQnq2cKuyy1I4vLiHjByuD/8mArTo80qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374344; c=relaxed/simple;
	bh=1eS0nVnAphZGVyYJ9yEFyfKYqDFUsb5W5dSAbq3UOmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWIcMKBvDARBr9IA2WYjA8P281XP53ycgD4jwYdYzES2X5IpKW/z1SzdP3TUZQfnl0xy1mcsdf/HBjuedTVegYoFHUxTP6OYEsgddAO4n3fEnG3guKeFsnFap10sY/xDPuc1aWQbGsS2Igo0OEzwD9SW4JWu4kII2dG4/9NOkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so243691a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374343; x=1722979143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h4oOckaQbpA4RFdmyjjlpZlH3nTQfnD8xd/9tAjIvQ=;
        b=fIwaGVsBTdgaS7EdtP5FQNL5SA1J/Jsp508t3+qht3eond+EgtoRaElkeKDVYX5Cte
         X+S4EmnTSciHrniLJ6GgTeN4JElqCqkj6QfiAuSIh1qdXfLXCmMek71y8OekdfoCcF2a
         FaueFOTgyDRH9I/cHzS8WYQkkknYUxIPumogOkKKejNLTtChIw0uqYqShIjzT30BP8mH
         B2wdG2fvuly8cfgr5G2BepP56Hl8rUhm56gNqSiDCJPeGlT4ydfiXo+6xBEyl6QmFxXp
         9GKFowsF7nFUwHG34DEYA0FPYz3LAU9FTBJ5jlPrSJAajHB78595JCJ94jqfEy7pH4dU
         DfoA==
X-Forwarded-Encrypted: i=1; AJvYcCVKm7zo2bU2NFctB8kq3chJJ9opPlB8D0shcZx2QuXkE9CGngjT+/XKnMFu0h/S7fRkWKw4EFhCHj3asss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3iouzFW2aCfMgYC3ba/sATLOzi2nRGU8QgRO4xcg0Th7DIec
	olthD2v+Lj0wAazw6ECh4JstFK/wAJMtLyXXCiijq7zZxfGD4qKMl44BCm1ztW0DAtjQ6L+Wixh
	e6R9QtBwiMucBCjxP7e9/r9CrUFI=
X-Google-Smtp-Source: AGHT+IErcSvKFyg3AabhoO9DQmd0hyvZCOMCWSCfwit25Mj/KdG2P2nysBwKjcZoXo9A1akq/IustkqEO7gY7M3xr0k=
X-Received: by 2002:a17:90a:c38a:b0:2c9:6188:f3e with SMTP id
 98e67ed59e1d1-2cfcab88b66mr5228240a91.16.1722374342405; Tue, 30 Jul 2024
 14:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191925.469649-1-namhyung@kernel.org> <20240730204048.GU33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730204048.GU33588@noisy.programming.kicks-ass.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 30 Jul 2024 14:18:51 -0700
Message-ID: <CAM9d7cg9KA8MnS4HFrXmL=OkVm6JfrxSvFyquOSxxoH8P5Lhhw@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Optimize event reschedule for a PMU
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, Jul 30, 2024 at 1:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 30, 2024 at 12:19:25PM -0700, Namhyung Kim wrote:
> > @@ -2728,13 +2727,62 @@ static void ctx_resched(struct perf_cpu_context=
 *cpuctx,
> >               perf_ctx_enable(task_ctx, false);
> >  }
> >
> > +static void __perf_pmu_resched(struct pmu *pmu,
> > +                            struct perf_event_context *task_ctx,
> > +                            enum event_type_t event_type)
> > +{
> > +     bool cpu_event =3D !!(event_type & EVENT_CPU);
> > +     struct perf_event_pmu_context *epc =3D NULL;
> > +     struct perf_cpu_pmu_context *cpc =3D this_cpu_ptr(pmu->cpu_pmu_co=
ntext);
> > +
> > +     /*
> > +      * If pinned groups are involved, flexible groups also need to be
> > +      * scheduled out.
> > +      */
> > +     if (event_type & EVENT_PINNED)
> > +             event_type |=3D EVENT_FLEXIBLE;
> > +
> > +     event_type &=3D EVENT_ALL;
> > +
> > +     perf_pmu_disable(pmu);
> > +     if (task_ctx) {
> > +             if (WARN_ON_ONCE(!cpc->task_epc || cpc->task_epc->ctx !=
=3D task_ctx))
> > +                     goto out;
> > +
> > +             epc =3D cpc->task_epc;
> > +             __pmu_ctx_sched_out(epc, event_type);
> > +     }
> > +
> > +     /*
> > +      * Decide which cpu ctx groups to schedule out based on the types
> > +      * of events that caused rescheduling:
> > +      *  - EVENT_CPU: schedule out corresponding groups;
> > +      *  - EVENT_PINNED task events: schedule out EVENT_FLEXIBLE group=
s;
> > +      *  - otherwise, do nothing more.
> > +      */
> > +     if (cpu_event)
> > +             __pmu_ctx_sched_out(&cpc->epc, event_type);
> > +     else if (event_type & EVENT_PINNED)
> > +             __pmu_ctx_sched_out(&cpc->epc, EVENT_FLEXIBLE);
> > +
> > +     __pmu_ctx_sched_in(&cpc->epc, EVENT_PINNED);
> > +     if (task_ctx)
> > +              __pmu_ctx_sched_in(epc, EVENT_PINNED);
> > +     __pmu_ctx_sched_in(&cpc->epc, EVENT_FLEXIBLE);
> > +     if (task_ctx)
> > +              __pmu_ctx_sched_in(epc, EVENT_FLEXIBLE);
> > +
> > +out:
> > +     perf_pmu_enable(pmu);
> > +}
>
> I so dislike duplication...
>
> So lets see, ctx_resched() has pmu_ctx iterations in:
>
>   perf_ctx_{en,dis}able()
>   ctx_sched_{in,out}()
>
> Can't we punch a 'struct pmu *pmu' argument through those callchains and
> short-circuit the iteration when !NULL?

Sure, will do that in v2.

Thanks,
Namhyung

>
> The alternative would be to lift the iteration I suppose.

