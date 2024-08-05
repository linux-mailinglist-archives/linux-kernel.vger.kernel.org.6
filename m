Return-Path: <linux-kernel+bounces-274607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C623947AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601E11C2120B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B14156980;
	Mon,  5 Aug 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AaFiPWTf"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7E155C91
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858922; cv=none; b=ROVXtkXb3ZQd17JofzlPjz7H3jg0sEp7uuFzQ6uBYEE63ROyAQbT6gk8jNphMdoZmq/JvHz3ORP5tlvhVMso9f7P2zGGlIri6I0zmYh95A4f/mUlFraQZneNJPjKh8Nq0L4wCGSr3pe2K6z8VDTXFf1usTe44yRGBPXcM1OnUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858922; c=relaxed/simple;
	bh=ZbLlIzxxYDPFIYyF3cjeehmzOBwHkwsjudapvSV5ayo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZGFE7V+5Q8NN7wcRF41/2IccKq2dKMcEalkwLR3qsLZoREG3iCzJcqJZuoqYq/3nLEKUS7V59SvavMGDxCW0gMAU9gB0WA3juY9/pJgAsYkP0QzEhkZunM15CIGU9nZtNt2Mzc8PGSvPVErVVbMB9+E5dx0worlVkVhkewwO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AaFiPWTf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso64695845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722858918; x=1723463718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k607eE+sU23kDmyW6jG14/IGhv43fCVDENewedmfdPw=;
        b=AaFiPWTf6TUEKH+wI5sIEhOF/uO0VnmHRK/ux0OIqVKeSSVa4h5oy2a6mMejS5o/Sa
         +ByabBDtZb/9DwGH6z+Jn4ZJjCEStIiHgXeQWDhcufiz/7M1SWlhD93pel07G2uvgxpg
         oOYqAJBbApi0r9MoyU7x2KO0U0ThSG6/zZlg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722858918; x=1723463718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k607eE+sU23kDmyW6jG14/IGhv43fCVDENewedmfdPw=;
        b=env1Oyh2rg5hqzYN/HxRG5hEIwpUsgqh9DnlgiAaLWYednBMOXCSIw7AoBYUWYGRgq
         oieWIlWbPE2eF03c0ynsIc75qklsMXAG0i+0qWnvdbQGPZDSAqbBB5s0fzr/emI1Tfqw
         8znDH0M8VFcrhiNB5l1Y464QnsMAaob+PQK5b8A8p1PUw88CHYmKyhw0az4gBYjeXEJO
         rUIGBC00KHxEUNvSb2DGp/CXYjEw36/HgBy3+qfncU1xqWq0oGf+0BDQMa+wsDlADSIv
         l9cNZLWkCOG9bZx41yXshScwXXeMiUQ0PZD2EcAxFq5v7SWcQnaaFX4azWeuKYtETrTY
         9Vig==
X-Forwarded-Encrypted: i=1; AJvYcCXqJlvBWJz57s4ja6fKORxk58NfyVG2CJMQWRIsjLCPqrS9J+qkg/tNbz2BdfLrtyrEwIzvmfMXUdx4nVZMnyXelA552mL/nfsa66n0
X-Gm-Message-State: AOJu0YwwOy0YkswgKIfS/l82fHts/9sWPNMNDDg7lqZLgoORUs0fIcP3
	hes5TNGZy6a/YtlMDICy705yenNq1buQAJDcxveA2NRznD3TRU8MD1jn7Q50Ig0=
X-Google-Smtp-Source: AGHT+IHezxs01d5kcwmted0mGR9db6XQJ8DPNJKKcSHGwequvX0hG8wypDlJ6PrTsz5uy59h4wPu7A==
X-Received: by 2002:a05:600c:4fc9:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-428e6b2f79fmr83890145e9.20.1722858917705;
        Mon, 05 Aug 2024 04:55:17 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:8d0e:f0af:9e74:240a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d786sm196573695e9.44.2024.08.05.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:55:17 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:55:15 +0100
From: Joe Damato <jdamato@fastly.com>
To: Kyle Huey <me@kylehuey.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	robert@ocallahan.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-ID: <ZrC9oxIcKebAKpx3@LQ3V64L9R2.home>
References: <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
 <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net>
 <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava>
 <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
 <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
 <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
 <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 09:35:43AM -0700, Kyle Huey wrote:
> Will do.
> 
> - Kyle
> 
> On Fri, Jul 26, 2024 at 9:34 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 5:37 AM Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 11:26 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 16, 2024 at 12:25 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > > > > On Mon, Jul 15, 2024 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > > > > > >
> > > > > > > > I think this would probably work but stealing the bit seems far more
> > > > > > > > complicated than just gating on perf_event_is_tracing().
> > > > > > >
> > > > > > > perf_event_is_tracing() is something like 3 branches. It is not a simple
> > > > > > > conditional. Combined with that re-load and the wrong return value, this
> > > > > > > all wants a cleanup.
> > > > > > >
> > > > > > > Using that LSB works, it's just that the code aint pretty.
> > > > > >
> > > > > > Maybe we could gate on !event->tp_event instead. Somebody who is more
> > > > > > familiar with this code than me should probably confirm that tp_event
> > > > > > being non-null and perf_event_is_tracing() being true are equivalent
> > > > > > though.
> > > > > >
> > > > >
> > > > > it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> > > > > are the only ones having the tp_event pointer set, Masami?
> > > > >
> > > > > fwiw I tried to run bpf selftests with that and it's fine
> > > >
> > > > Why can't we do the most straightforward thing in this case?
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index ab6c4c942f79..cf4645b26c90 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_event *event,
> > > >
> > > >         ret = __perf_event_account_interrupt(event, throttle);
> > > >
> > > > -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> > > > +       if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > > > +           !bpf_overflow_handler(event, data, regs))
> > > >                 return ret;
> > > >
> > > >
> > > > >
> > > > > jirka
> > > > >
> > >
> > > Yes, that's effectively equivalent to calling perf_event_is_tracing()
> > > and would work too. Do you want to land that patch? It needs to go to
> > > 6.10 stable too.
> >
> > I'd appreciate it if you can just incorporate that into your patch and
> > resend it, thank you!
> >
> > >
> > > - Kyle

I probably missed the updated patch, but I am happy to test any new
versions, if needed, to ensure that the bug I hit is fixed.

Kyle: please let me know if there's a patch you'd like me to test?

- Joe

