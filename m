Return-Path: <linux-kernel+bounces-537076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C174A487CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738EB3B0FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715A1F584C;
	Thu, 27 Feb 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAi1QQPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B371E521C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680866; cv=none; b=TEZrLu9hWcC9cBDBFlNMhNrXdakqWUnh4wDueGyajJVgkz9AoZwmV4+/9HotwKzDWq8n3b0Rm1z3iRk09Pbmh60aI5HSR876W4CzCLczykLlCjkg0ZuI2xmwK4MSOi5mCstgTTPOaNCOOkxLkbXBgECXOrJKr771jBYuo+/kobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680866; c=relaxed/simple;
	bh=hNmnbUSTHmV0H243U8/9PejpskpGVKllufD74FbCwJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSZSW8g9YA4hnJ5NXk4thasDCBb6gn6LwF6uYR6pr1ag09S7g6275tfWb2De2KR9TabeCNWHzscX3/UIzI75rHNPy/dB2sRjPnRuNQbbgeYJCLKhfnpH/HyQiSsXCuHMMCkLxmmJz80/uLf6Sl9Q3xWsUb1W7DRoMXhyqhqLYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAi1QQPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895DEC4CEDD;
	Thu, 27 Feb 2025 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740680865;
	bh=hNmnbUSTHmV0H243U8/9PejpskpGVKllufD74FbCwJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAi1QQPyLZT8I1dyOVPO25l8fn3mnurXKe4JGrFZN+V75Abs2eq/QPv+PiE07UlAz
	 chHsQB6mEnDQG7rPJWs3obY/XgduP5q5UV3ppojUdRqPbp6fvDbNL9eGQpAvrOsN+e
	 UWiHGH/3R7dFjvWWEw90/F0syQ0D6kjMDLP5/qAWwnL5smclwsUlG1IpboETKg0oxJ
	 hl9wAJASgeffly3B++pkZgeLUcD0w0bduwF0P/I8jhEXgRUslGKB62PQ+lEOpYZdnM
	 8/6P1zTMb2lbKDgeflerUTPujm0P1eObAcPdx/mwBRrBdzB1zcB/5jegTpMDAlIkC6
	 63EGN835eqglw==
Date: Thu, 27 Feb 2025 19:27:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Jakub Jelinek <jakub@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
Message-ID: <Z8Cul8cbnYTFzMoK@gmail.com>
References: <20241213190119.3449103-1-matt@readmodwrite.com>
 <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
 <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
 <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com>
 <Z8BY_AZPQQm0BJTu@gmail.com>
 <CAFULd4aCBMXcco_GdTYu9Zmc5A6+Z=J4XrsjLXWe1dydRD0oDQ@mail.gmail.com>
 <Z8BekITYkuc4F4b1@gmail.com>
 <CAFULd4YsMAqqVApUdtib-n6JuaFzyOXmi3fBuUNKdnnNKK=iig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4YsMAqqVApUdtib-n6JuaFzyOXmi3fBuUNKdnnNKK=iig@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Thu, Feb 27, 2025 at 1:46 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > On Thu, Feb 27, 2025 at 1:22 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > > On Mon, Dec 16, 2024 at 5:20 PM Matt Fleming <matt@readmodwrite.com> wrote:
> > > > > >
> > > > > > On Sat, Dec 14, 2024 at 1:17 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> > > > > > >
> > > > > > > Does your config include CONFIG_UBSAN_BOOL=y ?
> > > > > >
> > > > > > Yes, it does!
> > > > > >
> > > > > > > There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_BOOL
> > > > > > > (aka -fsanitize=bool), reported in [1] and fixed for gcc-14.2 in [2].
> > > > > > >
> > > > > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736#c42
> > > > > > >
> > > > > > > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=115172
> > > > > > >
> > > > > > > Otherwise, please attach your .config, and I'll look into this issue.
> > > > > >
> > > > > > Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels boot again.
> > > > > >
> > > > > > Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?
> > > > >
> > > > > No, this is a very rare Oops that triggers only with gcc-14.1 version
> > > > > and only when both KASAN and UBSAN are enabled. This is actually the
> > > > > problem with sanitization of the percpu address when named address
> > > > > spaces are enabled (IOW, sanitization of __seg_gs prefixed address).
> > > > > UBSAN creates a temporary in memory, but forgets to copy memory tags,
> > > > > including named address space qualifier from the original. Later ASAN
> > > > > sanitizes this location as a normal variable (due to missing
> > > > > qualifier), but actually should be disabled for __seg_gs prefixed
> > > > > addresses.
> > > > >
> > > > > Your report is only *the second* since sanitizers were re-enabled with
> > > > > named address spaces. gcc-14.2 that includes the fix is available
> > > > > since August 2024, and since sanitizers are strictly development
> > > > > tools, my proposed solution would be to simply upgrade the compiler to
> > > > > gcc-14.2 release.
> > > >
> > > > So unless this is difficult to test for, it would be nice to have a
> > > > compiler version cutoff for the feature. Especially if it's been
> > > > reported twice already, chances are that a lot more people have
> > > > experienced it already.
> > > >
> > > > The kernel build should avoid this known oops automatically.
> > >
> > > The patch could be as simple as:
> > >
> > > --cut here--
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 95ea2b4b95db..c94c37889917 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2370,7 +2370,7 @@ config CC_HAS_NAMED_AS
> > >      depends on CC_IS_GCC
> > >
> > >  config CC_HAS_NAMED_AS_FIXED_SANITIZERS
> > > -    def_bool CC_IS_GCC && GCC_VERSION >= 130300
> > > +    def_bool CC_IS_GCC && GCC_VERSION >= 140200
> > >
> > >  config USE_X86_SEG_SUPPORT
> > >      def_bool y
> > > --cut here--
> > >
> > > but it will disable all sanitizers for a very rare Oops that needs the
> > > combination of CONFIG_KASAN and CONFIG_UBSAN_BOOL.
> >
> > Can we not limit the version quirk to KASAN && UBSAN_BOOL?
> 
> I am testing the attached patch that resolves the issue.

Thank you!

	Ingo

