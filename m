Return-Path: <linux-kernel+bounces-170128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D298BD232
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ECD285A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55A156227;
	Mon,  6 May 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juXAToHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F56155A57;
	Mon,  6 May 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011977; cv=none; b=q8QGSoaVVDPb/8GjzUpTTpBbzvg7+a9f//Xu3oQK73bVeOsOrLcP3dh7BFkM6/LLYZ55fLpPaXZ6WUjY1Ww9V4irhAhWveARDVnMMqm+OZo9s0OqfoPY+13BQaEYV7ELMoDW10/jSTIIC5OOuUFY1OV+13+Jjj90xa8GkEnWqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011977; c=relaxed/simple;
	bh=6WL8Sjyjx9eJ7K+zXFfyOq+hI9vi3mF7je4WnOEK4K0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkSzh9Ca/6PYnJMwCXvPPwCQJrWfLR/r3Wh4MD/JORykMiwWDPqi2OPGuHpWOuAWBdjV5k3EUkvMJMnM6U9i+0LViBMYssBnOcF53sYWpUfVxukCDTya0rF+cmP2Bi8EoZqOE2D8POvafAliPlUgiNOC45y+JWyIHCOhteRblxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juXAToHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2BBC116B1;
	Mon,  6 May 2024 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715011976;
	bh=6WL8Sjyjx9eJ7K+zXFfyOq+hI9vi3mF7je4WnOEK4K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=juXAToHNoHXZx1uMNflWMouZ8TRAhvvKW1uPHoNpUw8YNnf81uAceUgVBYBU5rE1b
	 zKsbY3wHdKDfUjq6HKSqw7Oo6GFO7JPRpDZ7brdWtrB1WLTWebHyAv1gdzKi9MvZFz
	 Hjuo7RFAzoJmR0DODpQT5sByjRMGAfgMVypTMZE+1BVBzMs1pnotw9If9zgDFpTYOh
	 IpALmsFXg0O7FmpS/iIdgTdSMWbT+Ch9rzeGYsIRsmSP3hwqNglQuLo2dkzPuctQYk
	 KGEvvKG6moxZCbTdqKT47frpE80X4CL/2urRxzr/U6IV5wKHW/6MDk+fBpDwFzJ5z1
	 DKyNQcSyU7MYw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1s40xR-00B1eK-P5;
	Mon, 06 May 2024 17:12:53 +0100
Date: Mon, 06 May 2024 17:12:53 +0100
Message-ID: <86y18mq5q2.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sergio Lopez Pascual <slp@redhat.com>
Cc: Eric Curtin <ecurtin@redhat.com>,
	Will Deacon <will@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Zayd Qumsieh <zayd_qumsieh@apple.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>,
	Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>,
	Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
In-Reply-To: <CAAiTLFW8DWH-ejNgcXgr2tQxxF4pp7BNUFGyUq99BfrYx1kScQ@mail.gmail.com>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
	<20240411132853.GA26481@willie-the-truck>
	<28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
	<20240419165809.GA4020@willie-the-truck>
	<CAOgh=Fykg3Xb8Y59R_tJ7_jXe-ozXRMQjU+qVy5DdmFn3pkcPw@mail.gmail.com>
	<CAAiTLFW8DWH-ejNgcXgr2tQxxF4pp7BNUFGyUq99BfrYx1kScQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: slp@redhat.com, ecurtin@redhat.com, will@kernel.org, marcan@marcan.st, catalin.marinas@arm.com, mark.rutland@arm.com, zayd_qumsieh@apple.com, ih_justin@apple.com, Houdek.Ryan@fex-emu.org, broonie@kernel.org, ardb@kernel.org, mjguzik@gmail.com, anshuman.khandual@arm.com, oliver.upton@linux.dev, miguel.luis@oracle.com, joey.gouly@arm.com, cpaasch@apple.com, keescook@chromium.org, samitolvanen@google.com, bhe@redhat.com, j.granados@samsung.com, dawei.li@shingroup.cn, akpm@linux-foundation.org, revest@chromium.org, david@redhat.com, shr@devkernel.io, andy.chiu@sifive.com, josh@joshtriplett.org, oleg@redhat.com, deller@gmx.de, zev@bewilderbeest.net, omosnace@redhat.com, ojeda@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 06 May 2024 12:21:40 +0100,
Sergio Lopez Pascual <slp@redhat.com> wrote:
> 
> Eric Curtin <ecurtin@redhat.com> writes:
> 
> > On Fri, 19 Apr 2024 at 18:08, Will Deacon <will@kernel.org> wrote:
> >>
> >> On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> >> > On 2024/04/11 22:28, Will Deacon wrote:
> >> > >   * Some binaries in a distribution exhibit instability which goes away
> >> > >     in TSO mode, so a taskset-like program is used to run them with TSO
> >> > >     enabled.
> >> >
> >> > Since the flag is cleared on execve, this third one isn't generally
> >> > possible as far as I know.
> >>
> >> Ah ok, I'd missed that. Thanks.
> >>
> >> > > In all these cases, we end up with native arm64 applications that will
> >> > > either fail to load or will crash in subtle ways on CPUs without the TSO
> >> > > feature. Assuming that the application cannot be fixed, a better
> >> > > approach would be to recompile using stronger instructions (e.g.
> >> > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> >> > > true that some existing CPUs are TSO by design (this is a perfectly
> >> > > valid implementation of the arm64 memory model), but I think there's a
> >> > > big difference between quietly providing more ordering guarantees than
> >> > > software may be relying on and providing a mechanism to discover,
> >> > > request and ultimately rely upon the stronger behaviour.
> >> >
> >> > The problem is "just" using stronger instructions is much more
> >> > expensive, as emulators have demonstrated. If TSO didn't serve a
> >> > practical purpose I wouldn't be submitting this, but it does. This is
> >> > basically non-negotiable for x86 emulation; if this is rejected
> >> > upstream, it will forever live as a downstream patch used by the entire
> >> > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> >> > explicitly targeting, given our efforts with microVMs for 4K page size
> >> > support and the upcoming Vulkan drivers).
> 
> In addition to the use case Hector exposed here, there's another,
> potentially larger one, which is running x86_64 containers on aarch64
> systems, using a combination of both Virtualization and emulation.
> 
> In this scenario, both not being able to use TSO for emulation
> and having to enable it all the time for the whole VM have a very large
> impact on performance (~25% on some workloads).

Well, there is always a price to pay somewhere, and this is the usual
trade-off between performance and maintainability.

> I understand the concern about the risk of userspace fragmentation, but
> I was wondering if we could minimize it to an acceptable level by
> narrowing down the context. For instance, since both use cases we're
> bringing to the table imply the use of Virtualization, we should be able
> to restrict PR_SET_MEM_MODEL to only be accepted when running on EL1
> (and not in nVHE nor pKVM), returning EINVAL otherwise. This would
> heavily discourage users from relying on this feature for native
> applications that can run on arbitrary contexts, hence drastically
> reducing the fragmentation risk.

As I explained in another sub-thread[1], I am not prepared to allow
non architectural state to be exposed to a guest.  I'm also not
prepared to make significant ABI differences between VHE, nVHE, hVHE,
with or without pKVM, because the job of the kernel is to abstract
those differences.

> We would still need a way to ensure the trap gets to the VMM and for
> the VMM to operate on the impdef ACTLR_EL12, but that should be dealt on
> a different series.

The VMM can't use ACTLR_EL12, by the very definition of this register
(the clue is in the name).  You'd have to proxy the write in the
kernel and context-switch it, which means adding non-architectural
state to KVM, breaking VM migration and adding more kludges to the
existing Apple-specific host crap.

Also, let's realise that we are talking about making significant
changes to the arm64 ABI for a platform that is still not fully
supported in the upstream kernel. I have the feeling that changing the
memory model dynamically may not be of the utmost priority until then.

Thanks,

	M.

[1] https://lore.kernel.org/all/867cgcqrb9.wl-maz@kernel.org

-- 
Without deviation from the norm, progress is not possible.

