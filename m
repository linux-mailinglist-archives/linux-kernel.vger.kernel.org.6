Return-Path: <linux-kernel+bounces-366035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04C99EFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A21F249E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418621B21A9;
	Tue, 15 Oct 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv68rJqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543579CD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003509; cv=none; b=KS5SnvRW0TLOh7uBPM8zvH24F9hjx4BwtXflB1PwnjTQY8scjSzit68PwALS1Hpc4GZE2XGdi0r1jTUmiqU2mQgRKjDjbr2sLtordUHIaEwQ+sudqiHwM+4gAu17tF0W0ivhUZO7C+JYoU7qzb9cDyr2OGFksY6WJixQ3ozkUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003509; c=relaxed/simple;
	bh=HcTOrdcxs92yz13WTmjFYQWdwbrGivh2PfWBFaqAVa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duCLSL81fD051nBlfjPuyBI7qGPjphZtIt8IeBoTFsAxDU+b3cJP3ZdCesY/Pyk7gwtXz1Ezd9rEvESp1jf7RZudfJ5BrsY561cii4Xgvbt5OxxUHBBJfYbXfysSisOaZyO951yzR3og1z3QuBn0aTr3OvZEzjoewYbt8xcb5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv68rJqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1338AC4CECE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729003509;
	bh=HcTOrdcxs92yz13WTmjFYQWdwbrGivh2PfWBFaqAVa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lv68rJqM4qhNv47qSFj3wauONMjnwRwqE6iTV0SCjLpPJXJ5OpydnGW90KR6qL6iT
	 49PRUynad771L54n22W+SXslz1yns5q7GIrnDDBYrZBRSFJTrqOM3KXIQQEHLtZVD9
	 kZS9vlUwPQfmhGOD/3GMkQG8y5JuzH4Rwk03l5GK1iJpc+oPLdPviU8InH3Td7miTN
	 B9L2B4T1Db8QP4ix1FbH3LgLWmjdny2u97MdNa9dt6bugcgS0G6pDBGyh2HOywe+tq
	 kITJEIShAhrQ35uIkpPFd0UDpLq1+K4PQzjVB4A5gQf+bdiTNXEQ0LFrcFDg+Wdwev
	 H+PEljKFOEDyQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e4b7409fso3222907e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:45:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbBbAdDY73iKdWQWvJEx/pJXtN0wI/fmP1poOfS01FmbtITLfVmUjqBqWv649ikz9NbiXoCv6e4d9j8Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVZ62IaftPSCMLkBlk/JF1bqimK8auWA0DayNsIYFZJ3NjX1M
	w2EG1DuvJMGFQCHTh8aL/P7n50qbT0wKGRPOGi5g7AaLnNuKaok0ztwu6NMBYLlWKq/mPX827k1
	ibFDAHuq4JfJKp7xYwGTUm2M76t8=
X-Google-Smtp-Source: AGHT+IEQF2v9j6i4yu+3HsOsvdSTSU8aXXA0XaJrl3VwhE9kbJn/uTGwWFbBRQ/Jd6awHUdpNb9iGRphdoRWBmT1gSQ=
X-Received: by 2002:a05:6512:3b96:b0:539:e453:d90c with SMTP id
 2adb3069b0e04-539e453da3amr4092913e87.2.1729003507421; Tue, 15 Oct 2024
 07:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 16:44:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
Message-ID: <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 15, 2024 at 04:22:20PM +0200, Ard Biesheuvel wrote:
> > On Tue, 15 Oct 2024 at 16:00, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > >
> > > On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> > > > On Tue, Oct 15, 2024 at 12:28=E2=80=AFPM Mark Rutland <mark.rutland=
@arm.com> wrote:
> > > > > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote=
:
> > > >
> > > > > I think what's happening here is that when switching from prev to=
 next
> > > > > in the scheduler, we switch to next's mm before we actually switc=
h to
> > > > > next's register state, and there's a transient window where prev =
is
> > > > > executed using next's mm. AFAICT we don't map prev's KASAN stack =
shadow
> > > > > into next's mm anywhere, and so inlined KASAN_STACK checks recurs=
ively
> > > > > fault on this until we switch to the overflow stack.
>
> [...]
>
> > > > Yeah it looks like a spot-on identification of the problem, I can t=
ry to
> > > > think about how we could fix this if I can reproduce it, I keep try=
ing
> > > > to provoke the crash :/
> > >
> > > It's a bit grotty -- AFAICT you'd either need to prefault in the
> > > specific part of the vmalloc space when switching tasks, or we'd need=
 to
> > > preallocate all the shared vmalloc tables at the start of time so tha=
t
> > > they're always up-to-date.
> > >
> > > While we could disable KASAN_STACK, that's only going to mask the
> > > problem until this happens for any other vmalloc shadow...
> >
> > Is the other vmalloc shadow not covered by the ordinary on-demand fault=
ing?
>
> It depends on what the vmalloc memory is used for; if it's anything else
> used in the fault handling path, that'll fault recursively, and it's
> possible that'll happen indirectly via other instrumentation.
>
> > When I implemented VMAP_STACK for ARM, I added an explicit load from
> > the new stack while still running from the old one (in __switch_to) so
> > that the ordinary faulting code can deal with it. Couldn't we do the
> > same for the vmalloc shadow of the new stack?
>
> We could do something similar, but note that it's backwards: we need to
> ensure that the old/current stack shadow will be mapped in the new mm.
>
> So the usual fault handling can't handle that as-is, because you need to
> fault-in pages for an mm which isn't yet in use. That logic could be
> factored out and shared, though.
>

Not sure I follow you here. The crash is in the kernel, no?

So there is only a single vmalloc space where all the mappings should
reside, but each process has its own copy of the top level page table,
which needs to be synced up when it goes stale.

