Return-Path: <linux-kernel+bounces-171626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38FE8BE69D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29661C22340
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2912161911;
	Tue,  7 May 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQzhVbB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CA15FD1D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093586; cv=none; b=VwdVbv2v2DMX4oXRXvbqY8I3Y4AR6iKnQfGYGft2dcOkvr5DAX+GvdRBFqgA5/FEpRcqNSQApgfvC59F3PFHoqPXffyLqnLGPfKILMMf5322ijPEFF55It33+pxNom+CIyCXo5Aar49k4BLJxIWixVg0HJzaSTNrFaMaJB0IiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093586; c=relaxed/simple;
	bh=SM4uZsG+ZWU6pdCh+KmiT6fjGXAk/BqY7E2j+X8XI4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+Z8GRS1/OvZ2FG19N5T4gAtAh1m2eIk3FORBd0AWAumKyqAt4bf/Qwt3foyQW8dyaFQoeonwrwgXCF4EL7bclRWayjrdW/XZg5Sehkk85lLmyqeB4RpAe8BQxo+QBucoGpgWx4QAAzMSV6cb+v+FjRQRTGqZwwZ4rfhvGPzbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQzhVbB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DBAC4AF18
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093586;
	bh=SM4uZsG+ZWU6pdCh+KmiT6fjGXAk/BqY7E2j+X8XI4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WQzhVbB/fda7TB78952CC1FEynnAydSEv8hqNeH4gltwW5b4TL0e3A0nCSQ3xOqy6
	 Y8F2H780LQc6R5wOIMk2gU7xTgHzC6y7F99/bqvdUMvVVZYh4SIRwr1v+9K7ZuL0Je
	 Vi73J5KiYQ4zXQxxSH3OQplyxA5vgkxxKIDxOx/8PcCtjriqLBTLPkI1UdJS334dAW
	 iweDOTMO30pkPMFhylJk44bSxlYmsiNcu0yAWBCSuaUlSj3+VjdcT1XZFpNaXUX3FP
	 zWTA8uZsaLiPxskSEy4kc+0HarFmYtu6Gu9t5V4vcv/GenV1mKnOJxdrqofn+VacbZ
	 jUk/BSvjVHuRw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so8986611fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:53:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVutT3PO7kRVgek5P+IKZJVrInqnrUmKygLn1eCxQSKkwsV9CEqfaAk8vj4xq1u9QgDBVWi6cdUJBkXeWjoETLK9jL1WKK5r1LdHync
X-Gm-Message-State: AOJu0Yz2Yzoz0897vvOCKKbMQ5mvPIDXxtGEkcu7YcRXcAPuV6HyW5gD
	yIxuHB+rxwipvzwCS7pSrT34kmoKNFHjaoILxgwFyNkkcT4wl38GgXls7XIqK03z/Pjk4IlatC+
	3QHT9uPbEcN5EoJmwvdlVp73BY3Y=
X-Google-Smtp-Source: AGHT+IG8+gtXhNlZpJi3zCkLvurmd/IHF8T50fiTAvbZuF34/Xyr06janW6+OswVbMpvYUgdeNn0GONt0kX59Ir1Gk8=
X-Received: by 2002:a2e:a41a:0:b0:2e2:b716:e67c with SMTP id
 p26-20020a2ea41a000000b002e2b716e67cmr6828012ljn.7.1715093564082; Tue, 07 May
 2024 07:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-tso-v1-0-754f11abfbff@marcan.st> <20240411132853.GA26481@willie-the-truck>
 <87seythqct.fsf@draig.linaro.org>
In-Reply-To: <87seythqct.fsf@draig.linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 7 May 2024 16:52:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqG7D2Q_T_NXZ-y3NYOjK6d8bP8ihJTeFz8TUJ77W7tw@mail.gmail.com>
Message-ID: <CAMj1kXFqG7D2Q_T_NXZ-y3NYOjK6d8bP8ihJTeFz8TUJ77W7tw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>, 
	Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>, 
	Mark Brown <broonie@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>, 
	Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>, 
	Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Florent Revest <revest@chromium.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
	Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>, 
	Zev Weiss <zev@bewilderbeest.net>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 May 2024 at 12:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Will Deacon <will@kernel.org> writes:
>
> > Hi Hector,
> >
> > On Thu, Apr 11, 2024 at 09:51:19AM +0900, Hector Martin wrote:
> >> x86 CPUs implement a stricter memory modern than ARM64 (TSO). For this
> >> reason, x86 emulation on baseline ARM64 systems requires very expensiv=
e
> >> memory model emulation. Having hardware that supports this natively is
> >> therefore very attractive. Such hardware, in fact, exists. This series
> >> adds support for userspace to identify when TSO is available and
> >> toggle it on, if supported.
> >
> > I'm probably going to make myself hugely unpopular here, but I have a
> > strong objection to this patch series as it stands. I firmly believe
> > that providing a prctl() to query and toggle the memory model to/from
> > TSO is going to lead to subtle fragmentation of arm64 Linux userspace.
> >
> > It's not difficult to envisage this TSO switch being abused for native
> > arm64 applications:
> >
> >   * A program no longer crashes when TSO is enabled, so the developer
> >     just toggles TSO to meet a deadline.
> >
> >   * Some legacy x86 sources are being ported to arm64 but concurrency
> >     is hard so the developer just enables TSO to (mostly) avoid thinkin=
g
> >     about it.
> >
> >   * Some binaries in a distribution exhibit instability which goes away
> >     in TSO mode, so a taskset-like program is used to run them with TSO
> >     enabled.
>
> These all just seem like cases of engineers hiding from their very real
> problems. I don't know if its really the kernels place to avoid giving
> them the foot gun. Would it assuage your concerns at all if we set a
> taint flag so bug reports/core dumps indicated we were in a
> non-architectural memory mode?
>
> > In all these cases, we end up with native arm64 applications that will
> > either fail to load or will crash in subtle ways on CPUs without the TS=
O
> > feature. Assuming that the application cannot be fixed, a better
> > approach would be to recompile using stronger instructions (e.g.
> > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > true that some existing CPUs are TSO by design (this is a perfectly
> > valid implementation of the arm64 memory model), but I think there's a
> > big difference between quietly providing more ordering guarantees than
> > software may be relying on and providing a mechanism to discover,
> > request and ultimately rely upon the stronger behaviour.
>
> I think the main use case here is for emulation. When we run x86-on-arm
> in QEMU we do currently insert lots of extra barrier instructions on
> every load and store. If we can probe and set a TSO mode I can assure
> you we'll do the right thing ;-)
>

Without a public specification of what TSO mode actually entails,
deciding which of those barriers can be dropped is not going to be as
straight-forward as you make it out to be.

Apple's TSO mode is vertically integrated with Rosetta, which means
that TSO mode provides whatever Rosetta needs to run x86 code
correctly, and that it could mean different things on different
generations of the micro-architecture. And whether Apple's TSO is the
same as Fujitsu's is anyone's guess afaik.

Running a game and seeing it perform better is great, but it is not
the kind of rigor we usually attempt to apply when adding support for
architectural features. Hopefully, there will be some architectural
support for this in the future, but without any spec that defines the
memory model it implements, I am not convinced we should merge this.

