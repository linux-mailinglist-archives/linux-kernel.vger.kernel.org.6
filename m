Return-Path: <linux-kernel+bounces-311726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC1968CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E961F23EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9DC1AB6E8;
	Mon,  2 Sep 2024 17:30:34 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62009183CBB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298233; cv=none; b=kaYZJ9NJt0QUWgQovvBT6/QKb/+VITgLrRgVFSI2+FfS1GkbMTk2FgxKkN6lGOoIqiLcqAMEShbMTwVPypnHjk+gHYp2YB1VH+0LCe/7zgJq/FCj58v+HZEnkbTLcw+Zu9e/c7IaVbHsxyXieyCjnWFbbm/CVELGSnbjn6k6qlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298233; c=relaxed/simple;
	bh=/snvTa0uroGmf+sTeHxwzoukVu05rGMxpWtGZxFYu3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2u/F33x6/WMA5Xznsc8FRmDhowjr5WOw7TKYsxPMXr2w6Dnhd71tIohMZIJiFv92HGjgFXsAMFF9EgyJAs7Qy0gDsTPJK8eGagpfwYn0HKSDlrGsJqDsRBoX+v6wUYa0pM31pQWaCA2DYBvLyGhFS8D3OaGIOODtGTVu/Z6tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so1594286a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298231; x=1725903031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i203f9s6t0ft4wQbLxaC4/ETLBTWXgogKsC9yrqdZGo=;
        b=hZaBZDRTkd92c2IWx9KDayNqG/S5RQhY+o3OSbLij1Ne7qw0bp6D9V9/KvFmEcNna6
         yN5Qs00TCqSBTBiN/Di8J314F/zrFRPt3n4PPmj3jfjmU0nnLvBsthDZhzFzk9RP2m8l
         xcxjl3uSpxYejlXgIEY0h4FbfbYh87jy2jZsfSoHuvSUzVIEkZTadWr8ZyBS7yrBtelb
         4CbKOj56h7jtP2a0us8K0NoHNnNvdcEYe5bR5qCDkLkLX7A8SDmBiOM0hKAGKOH+PQir
         GMlv31/94EPBEODVtcnqDnmSh5XTlTgTKSQV8FqcN16D339N1vTRhWe4dFjjA7i0K70+
         /ygQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKNo3XwnnUj6l6v8WQ+tsvmF3evGbCx08KF6vVfIEVAwvB0gaxu0A5oxLTpRKREA43jjO1KG47NEJE2Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXH8SluSnu7XVpl2Vu2DrIgMITmxl68fl6501kD3yGFqvslt16
	mp1NPz77r2dtvoscpr6NCy6fJGLThxQBHnVfT/auiQF8qXQ61g0EUz6naC8/TMdm/ixqIAkr/H2
	ilz96N5azVKEG41kSYsqmbigRTck=
X-Google-Smtp-Source: AGHT+IH4p7U8BI8qM9nOTimuqnSbS+S5qyXuAwUt0ggrHsw5MzDW3VuI7I/KNTolIhsdwvjNVcuKUE4Jzn3j95FmQI8=
X-Received: by 2002:a17:90a:bc89:b0:2d8:8991:211f with SMTP id
 98e67ed59e1d1-2d889912298mr9288377a91.28.1725298231390; Mon, 02 Sep 2024
 10:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830232910.1839548-1-namhyung@kernel.org> <20240830232910.1839548-5-namhyung@kernel.org>
 <20240902091232.GB4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240902091232.GB4723@noisy.programming.kicks-ass.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 2 Sep 2024 10:30:19 -0700
Message-ID: <CAM9d7cg-7USE-Ofusc1VDpr3qtviX4xZmoKmBjmEfBDw9XJ+nw@mail.gmail.com>
Subject: Re: [RFC/PATCH 4/4] perf/x86: Relax privilege filter restriction on
 AMD IBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:12=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Aug 30, 2024 at 04:29:10PM -0700, Namhyung Kim wrote:
> > While IBS is available for per-thread profiling, still regular users
> > cannot open an event due to the default paranoid setting (2) which
> > doesn't allow unprivileged users to get kernel samples.  That means
> > it needs to set exclude_kernel bit in the attribute but IBS driver
> > would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> > we want and I've been getting requests to fix this issue.
> >
> > This should be done in the hardware, but until we get the HW fix we may
> > allow exclude_{kernel,user} in the attribute and silently drop the
> > samples in the PMU IRQ handler.  It won't guarantee the sampling
> > frequency or even it'd miss some with fixed period too.  Not ideal,
> > but that'd still be helpful to regular users.
>
> Urgh.... this is really rather bad. And I'm sure a bunch of people are
> going to be spending a lot of time trying to figure out why their
> results don't make sense.

I agree it can be confusing but there are use cases where regular users
want IBS information like memory data source, data address and so on.
Also I realized that software events like cpu-clock use the same logic to
discard samples by privilege mode already.

>
> I realize that having entry hooks to disable/enable the counters is also
> not going to happen, this has a ton of problems too.

Do you mean kernel/user mode change hook?  I guess it'd be too costly.

>
> Also, that PMU passthrough patch set has guest hooks, so you can
> actually do the exclude_host/guest nonsense with those, right?

Oh.. this patch is about exclude_user/kernel not host/guest.  Anyway
it'd be great if IBS could support the guest hooks and allow the exclude
bits.

Thanks,
Namhyung

>
> > This uses perf_exclude_event() which checks regs->cs.  But it should be
> > fine because set_linear_ip() also updates the CS according to the RIP
> > provided by IBS.
> >
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  arch/x86/events/amd/ibs.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> > index e91970b01d62..e40e2255239a 100644
> > --- a/arch/x86/events/amd/ibs.c
> > +++ b/arch/x86/events/amd/ibs.c
> > @@ -290,6 +290,11 @@ static int perf_ibs_init(struct perf_event *event)
> >       if (has_branch_stack(event))
> >               return -EOPNOTSUPP;
> >
> > +     /* handle exclude_{user,kernel} in the IRQ handler */
> > +     if (event->attr.exclude_hv || event->attr.exclude_idle ||
> > +         event->attr.exclude_host || event->attr.exclude_guest)
> > +             return -EINVAL;
> > +
> >       ret =3D validate_group(event);
> >       if (ret)
> >               return ret;
> > @@ -667,7 +672,6 @@ static struct perf_ibs perf_ibs_fetch =3D {
> >               .start          =3D perf_ibs_start,
> >               .stop           =3D perf_ibs_stop,
> >               .read           =3D perf_ibs_read,
> > -             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> >       },
> >       .msr                    =3D MSR_AMD64_IBSFETCHCTL,
> >       .config_mask            =3D IBS_FETCH_CONFIG_MASK,
> > @@ -691,7 +695,6 @@ static struct perf_ibs perf_ibs_op =3D {
> >               .start          =3D perf_ibs_start,
> >               .stop           =3D perf_ibs_stop,
> >               .read           =3D perf_ibs_read,
> > -             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> >       },
> >       .msr                    =3D MSR_AMD64_IBSOPCTL,
> >       .config_mask            =3D IBS_OP_CONFIG_MASK,
> > @@ -1111,6 +1114,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *=
perf_ibs, struct pt_regs *iregs)
> >               regs.flags |=3D PERF_EFLAGS_EXACT;
> >       }
> >
> > +     if (perf_exclude_event(event, &regs)) {
> > +             throttle =3D perf_event_account_interrupt(event);
> > +             atomic64_inc(&event->dropped_samples);
> > +             goto out;
> > +     }
> > +
> >       if (event->attr.sample_type & PERF_SAMPLE_RAW) {
> >               raw =3D (struct perf_raw_record){
> >                       .frag =3D {
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >

