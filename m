Return-Path: <linux-kernel+bounces-263503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A938793D6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F4F1F24A82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CF217BB1F;
	Fri, 26 Jul 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="b/E26HGD"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A62E64A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011761; cv=none; b=ajOLzcazB99gmzI98fkDCLQeaf01+T5oIFdqc41TUaSTVRNYqUNkV1Cz0mUg0WRZ6FpvgYEWleWWya37WSqWfi2bOdsww0QlwuyEVMT+AuiQZYM/OOEtmsL6BTOr9UuozMRjZyQtPsYJmpEUtcyWDr2bcr43Md1Wb78OUF9XdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011761; c=relaxed/simple;
	bh=BUdENbSZvNfphqnfRsqLz5HIB/kvhlcAtKnqfnFm/0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOh56w8gSeVlo/FMRXdLySq0K2oDnmz5KDDVjKfJqpe6gGDFF+WdvfKdIt9V3fHEHhj1W1g4UX7asPkorS0J/enKKcL2yVgsf9jQdDstJriySmKATssosRZjQJOA5fLzkDtka4qB5BNOSmTX0k40/cnHCq+BmcSLTbGYSu4DZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=b/E26HGD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ef95ec938so1932678e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1722011758; x=1722616558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47UoFBedUGrddRztnJZpYQBii5NU6LPNq061vWvaiIk=;
        b=b/E26HGDUCe1LuaORugtodflVOPU6hlxy5zcXeEGnmOE/QdpdBCarPWCVKRMnmQV9Q
         tf0kbSdzJvoVuoHjEPTGWh5zxiJ+RNqud5jafFDSlMaLom+JVYbcsLAlzh/ozDkBz8w3
         RfmA4AneWWtC4kLsAHMWH3ILDrgAorQpZR/E2ag0R1nkpHbD7vp1BatNIyiyou0YFzg+
         BMSdD8BOhyj9Ap/9+dApNr2w7zmeRCW4CDAC8im9MO1L8Pdzo/PymdhZIaiQ1ICLYmX4
         jSIl+GZraEp0JegITJznzftunU8vhsTcc03SeW8d3GfrS/S0TJB6t6fust1tauvw74+t
         p0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011758; x=1722616558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47UoFBedUGrddRztnJZpYQBii5NU6LPNq061vWvaiIk=;
        b=Hj+BfbQo/mNgLhLMYkcXYY85xiKPXVSw0j22i/OU7Mc7RNcyTEIgmgbpsyYg4ws88F
         roBfrABPaRjkNNk/N0fNoaFb056YllKSylWTPfIAFqWmkKJvyWYdHb1+YCNFveDQ0eul
         bzSxuE7Dd/37/C7xfzoeoo/EKozgD2bdM0/1atsX3Ojnn5gym0hiRl3dkG1+CqEbIUbi
         JXgLKlYFwIbGt3l32XrRkgc84eaRR7ruFJYBV8iDt+tGea7mK0/coZak+LYhACbGQkkQ
         yoCMtd5cZOal2rn5iqBzg67worIYqO+DMj1ai74p/yeBcuAGGDnVIocBFWNVwtEMoc4l
         v7tg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8PVc1YQAW/PBif7N40cGAeeOwgSwkO7nj4wJc1AEcShqV4XHLTEnp7F63oqGsP4o7eD43J2XOKsYTFX3rgcG5QPL3tM62XKyRYKG
X-Gm-Message-State: AOJu0YxJhNbMmwJkKrSUJuSO/yPHPsNCkYDyGZEej5u0/07J2D54N9er
	D0xtlz9sCPnlzuxE9cTZFDcns/O0pAdl2uiIowcuigkuqpwS4B0fiMX+E307u/Ruo4Z8r0svoZw
	ndUNMJTqvUsCX1U9c0svj3sP4nqwWMzuXc4mo
X-Google-Smtp-Source: AGHT+IFvqtpRRyLvec0NkzJMgZQnsqA/Jq1F9gE7Oy0fL+CqbT0j7cJKBTQrXyLvg57PrVmau43R+BVGdnKtQ5XE57c=
X-Received: by 2002:a05:6512:2513:b0:52c:b479:902d with SMTP id
 2adb3069b0e04-5309b259c26mr250971e87.4.1722011757881; Fri, 26 Jul 2024
 09:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net> <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net> <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava> <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
 <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com> <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
In-Reply-To: <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 26 Jul 2024 09:35:43 -0700
Message-ID: <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Will do.

- Kyle

On Fri, Jul 26, 2024 at 9:34=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 26, 2024 at 5:37=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > On Fri, Jul 19, 2024 at 11:26=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.co=
m> wrote:
> > > >
> > > > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > > > On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@in=
fradead.org> wrote:
> > > > > >
> > > > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > > > > >
> > > > > > > I think this would probably work but stealing the bit seems f=
ar more
> > > > > > > complicated than just gating on perf_event_is_tracing().
> > > > > >
> > > > > > perf_event_is_tracing() is something like 3 branches. It is not=
 a simple
> > > > > > conditional. Combined with that re-load and the wrong return va=
lue, this
> > > > > > all wants a cleanup.
> > > > > >
> > > > > > Using that LSB works, it's just that the code aint pretty.
> > > > >
> > > > > Maybe we could gate on !event->tp_event instead. Somebody who is =
more
> > > > > familiar with this code than me should probably confirm that tp_e=
vent
> > > > > being non-null and perf_event_is_tracing() being true are equival=
ent
> > > > > though.
> > > > >
> > > >
> > > > it looks like that's the case, AFAICS tracepoint/kprobe/uprobe even=
ts
> > > > are the only ones having the tp_event pointer set, Masami?
> > > >
> > > > fwiw I tried to run bpf selftests with that and it's fine
> > >
> > > Why can't we do the most straightforward thing in this case?
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index ab6c4c942f79..cf4645b26c90 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> > >
> > >         ret =3D __perf_event_account_interrupt(event, throttle);
> > >
> > > -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> > > +       if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PER=
F_EVENT &&
> > > +           !bpf_overflow_handler(event, data, regs))
> > >                 return ret;
> > >
> > >
> > > >
> > > > jirka
> > > >
> >
> > Yes, that's effectively equivalent to calling perf_event_is_tracing()
> > and would work too. Do you want to land that patch? It needs to go to
> > 6.10 stable too.
>
> I'd appreciate it if you can just incorporate that into your patch and
> resend it, thank you!
>
> >
> > - Kyle

