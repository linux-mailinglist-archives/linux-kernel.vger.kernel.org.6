Return-Path: <linux-kernel+bounces-366216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828699F24D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E22B210D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476931EB9E6;
	Tue, 15 Oct 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcHw95Oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971081CB9EB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008433; cv=none; b=JyzbkMSA4EWFp84gzBlXEu1m4HWBKrWHOco+3uI9wExlPwC/s674t0WwmZHsLE0q8SMGxHNJu6UAHglrHzK9n4ippXY6rCNMwM29ixV4k40I2RsiJvMv79N946bjioMRfaUiUFh9yQb1AR8+9R/651uM0mtLDbRsvucaGpxwnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008433; c=relaxed/simple;
	bh=D7JyEOlwv7WG/d5IV3rEXIgpdsFELO1WX45XePGFoRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuOMZHCZJ1fxMPUuhktSjzIgmj4aX1AH1ypG5zsGRJE28I3xVCldRgSPlw4zITaLWpgjmgg6dowm9bcWBNg/Sb/n/Jh2UghMFx92gLX+JVQTsPgIzFqHI8FOYASbq8SFLp3BJ6eYR5rySq54DKO7kmmiJkalcFqnQUL6/OOhNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcHw95Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED80C4CECD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008433;
	bh=D7JyEOlwv7WG/d5IV3rEXIgpdsFELO1WX45XePGFoRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BcHw95OqEetqK+AIcrg8jY24AQZrA4JWT/u9EQs5kVDD8X5Ld1SIO8faBBUelRvJ8
	 B+MUH2Dx0NAT2q6jFLbY5UBCvVNz+p46VhlRKvMXet3+zAj7bTLYmyVMbdg6ZADNAn
	 x2owNcWSh6mjLDbkMA/F68BZJ4gTiSmu9U/lMlQfyDlI42dMJ3SZw6VrT9Bt9xNdR/
	 hQ18frBTq5YOwnr6Pbteq1W0dGEPMNFxhzabEf226Me1bFQS6e+6Fo1UrE+R/dl9D+
	 iD7Qhnn9yQo/i6L+GGQ1pfbyzY7LLLlwir+hZT/LnRIuwy8MqoGeGaPKvhPga+ibB5
	 sSBXc/CDvt0qw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f6e1f756so2619717e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:07:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXY+X7k0H9NCWJniirUHfDjfATKrtsVseoXVfcpCKDvxql0ipes7/d1zkiwW2Bty35B5tu1h1N1HqmfDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzluyQYWMP/IZUI2WeD0USDUcS/ZmZxKYTcHzpjvyhdYTdyEC
	8ajhR6QyP50BqUFLrNQFSowqDqygCORqOQVkT5K5V+BRYoOHXGHU7iwZKRFaf6xhOHWzhaNTmf1
	ZAwG8I/vrPkAcPH7eH/JJsIubrUk=
X-Google-Smtp-Source: AGHT+IHzzQVqqolf9ERW72m7zA2TZMqTrNbIF8nK7gXzM+liLJ/+eIDKS0f4wIrQ+zaQmKdMqDvYpV5KLtGuVaCQW4I=
X-Received: by 2002:a05:6512:1382:b0:539:f675:84d7 with SMTP id
 2adb3069b0e04-53a03f484e6mr680756e87.32.1729008431443; Tue, 15 Oct 2024
 09:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 18:07:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
Message-ID: <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
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

On Tue, 15 Oct 2024 at 17:26, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 15, 2024 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> > On Tue, 15 Oct 2024 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > >
> > > On Tue, Oct 15, 2024 at 04:22:20PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 15 Oct 2024 at 16:00, Mark Rutland <mark.rutland@arm.com> w=
rote:
> > > > >
> > > > > On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> > > > > > On Tue, Oct 15, 2024 at 12:28=E2=80=AFPM Mark Rutland <mark.rut=
land@arm.com> wrote:
> > > > > > > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC w=
rote:
> > > > > >
> > > > > > > I think what's happening here is that when switching from pre=
v to next
> > > > > > > in the scheduler, we switch to next's mm before we actually s=
witch to
> > > > > > > next's register state, and there's a transient window where p=
rev is
> > > > > > > executed using next's mm. AFAICT we don't map prev's KASAN st=
ack shadow
> > > > > > > into next's mm anywhere, and so inlined KASAN_STACK checks re=
cursively
> > > > > > > fault on this until we switch to the overflow stack.
> > >
> > > [...]
> > >
> > > > > > Yeah it looks like a spot-on identification of the problem, I c=
an try to
> > > > > > think about how we could fix this if I can reproduce it, I keep=
 trying
> > > > > > to provoke the crash :/
> > > > >
> > > > > It's a bit grotty -- AFAICT you'd either need to prefault in the
> > > > > specific part of the vmalloc space when switching tasks, or we'd =
need to
> > > > > preallocate all the shared vmalloc tables at the start of time so=
 that
> > > > > they're always up-to-date.
> > > > >
> > > > > While we could disable KASAN_STACK, that's only going to mask the
> > > > > problem until this happens for any other vmalloc shadow...
> > > >
> > > > Is the other vmalloc shadow not covered by the ordinary on-demand f=
aulting?
> > >
> > > It depends on what the vmalloc memory is used for; if it's anything e=
lse
> > > used in the fault handling path, that'll fault recursively, and it's
> > > possible that'll happen indirectly via other instrumentation.
> > >
> > > > When I implemented VMAP_STACK for ARM, I added an explicit load fro=
m
> > > > the new stack while still running from the old one (in __switch_to)=
 so
> > > > that the ordinary faulting code can deal with it. Couldn't we do th=
e
> > > > same for the vmalloc shadow of the new stack?
> > >
> > > We could do something similar, but note that it's backwards: we need =
to
> > > ensure that the old/current stack shadow will be mapped in the new mm=
.
> > >
> > > So the usual fault handling can't handle that as-is, because you need=
 to
> > > fault-in pages for an mm which isn't yet in use. That logic could be
> > > factored out and shared, though.
> >
> > Not sure I follow you here. The crash is in the kernel, no?
>
> Yep; I'm referring to the vmalloc space being lazily faulted-in and
> copied from init_mm into the active pgd under do_translation_fault().
>
> Looking some more, I don't see how VMAP_STACK guarantees that the
> old/active stack is mapped in the new mm when switching from the old mm
> to the new mm (which happens before __switch_to()).
>
> Either I'm missing something, or we have a latent bug. Maybe we have
> some explicit copying/prefaulting elsewhere I'm missing?
>

We bump the vmalloc_seq counter for that. Given that the top-level
page table can only gain entries covering the kernel space, this
should be sufficient for the old task's stack to be mapped in the new
task's page tables.

> What happens when switching between two tasks whose stacks happen to be
> in distinct sub-trees of the vmalloc tables?
>
> > So there is only a single vmalloc space where all the mappings should
> > reside, but each process has its own copy of the top level page table,
> > which needs to be synced up when it goes stale.
>
> Yep -- the problem is when we can safely do that syncing up, since the
> lazy syncing in do_translation_fault() can't safely be used to sync
> anything that's used during do_translation_fault(), including the stack,
> etc.
>

Indeed.

