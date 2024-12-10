Return-Path: <linux-kernel+bounces-439487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319C9EAFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68B918828F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4919212D85;
	Tue, 10 Dec 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAdMLYgh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2778F24;
	Tue, 10 Dec 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830297; cv=none; b=gqFBVhGrEs/lwIDfCU359sBxQENjhk498kHhAj/H2kkponFhwzIQML7JCscNZ1SqWL60K7Gq+9hq7me4wtMRhkYwSgNHY3U4c4+2hI6z0MCIVZXWdudedMxZCuIO0iz7tRYJTtgf71OfwnhjbyMaztacq7u+K7eoWxPUEYSBOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830297; c=relaxed/simple;
	bh=c0/Kvxahxgc5BU9+Agj9zRUQoG8xPGH+UnRBmIDO2fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5kbgZlAflWk7JTlwuf4CT83c3fritfqBey/xvHSa0RtzIcxlPXcggG2geMX4teIe/XsuNPhModcKxeCJC+8KEokUCQyqXiYy9hpwMENIS1vr9K+gOpLxZMXaQsHqZpI2Wslc+tKRQCBjotyLDU4GO0xgQVLOB0qhbs/otxupR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAdMLYgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F14C4CEE5;
	Tue, 10 Dec 2024 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733830296;
	bh=c0/Kvxahxgc5BU9+Agj9zRUQoG8xPGH+UnRBmIDO2fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAdMLYghmzGQESB8O/bG766ua3RwnQDvvUeRtidNiGqJ8TlfbCRElx/sTeRq75czU
	 3zlwVL9q8G9hLadJBjJc3Rzko3FyKGRlMKDUUrDkuIDBwim+hOFfQiTMsxay+QCkZq
	 dsAC5FAP+jV0quE80qwA4ol9lMd5AF1UYhgaFu0CgsD57mHGPWxDN0Lgy+Uf9C1yYt
	 Dg0oxBHwR6mgEPdoiAY4JcR5TsCFu1Eq1lL52AnYyWlIjgOSlqqnlk0lbeACf2gCBs
	 UmJzUF7qGAXH4lEvPtw1K9GFhr6Mau3FXLNvwd+UUKOWYgUWWpbaXc0eBl6N8ftV0s
	 ezm7ttxPwaAkw==
Date: Tue, 10 Dec 2024 11:31:31 +0000
From: Will Deacon <will@kernel.org>
To: Yabin Cui <yabinc@google.com>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
Message-ID: <20241210113129.GB14735@willie-the-truck>
References: <20241118222540.27495-1-yabinc@google.com>
 <20241209162028.GD12428@willie-the-truck>
 <CAF1bQ=SiHi8oCyo5YnXGpQGofM1zAsnBdqSEet1mS-BYNKVU8A@mail.gmail.com>
 <20241209185623.GA13084@willie-the-truck>
 <CALJ9ZPNfUFF8OrpvziTnTvGU7OxEgyy9ZTc3aF-NhZ5hMbp7RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALJ9ZPNfUFF8OrpvziTnTvGU7OxEgyy9ZTc3aF-NhZ5hMbp7RQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Dec 09, 2024 at 03:51:34PM -0800, Yabin Cui wrote:
>  On Mon, Dec 9, 2024 at 10:56 AM Will Deacon <will@kernel.org> wrote:
> >
> > (Aside: please try to avoid top-posting on the public lists as it messes up
> > the flow of conversation; I'll try to piece this back together.)
> >
> > On Mon, Dec 09, 2024 at 09:30:50AM -0800, Rong Xu wrote:
> > > On Mon, Dec 9, 2024 at 8:20 AM Will Deacon <will@kernel.org> wrote:
> > > > On Mon, Nov 18, 2024 at 02:25:40PM -0800, Yabin Cui wrote:
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index fd9df6dcc593..c3814df5e391 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -103,6 +103,7 @@ config ARM64
> > > > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > > > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > > >       select ARCH_SUPPORTS_RT
> > > > > +     select ARCH_SUPPORTS_AUTOFDO_CLANG
> > > > >       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> > > > >       select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> > > > >       select ARCH_WANT_DEFAULT_BPF_JIT
> > > >
> > > > After this change, both arm64 and x86 select this option unconditionally
> > > > and with no apparent support code being added. So what is actually
> > > > required in order to select ARCH_SUPPORTS_AUTOFDO_CLANG and why isn't
> > > > it just available for all architectures instead?
> 
> I think it's similar to ARCH_SUPPORTS_LTO_CLANG, which also doesn't need any
> support code but requires testing to ensure it works on a specific architecture.
> 
> >
> > > Enabling an AutoFDO build requires users to explicitly set CONFIG_AUTOFDO_CLANG.
> > > The support code is in Commit 315ad8780a129e82 (kbuild: Add AutoFDO
> > > support for Clang build).
> >
> > Yes, that is precisely my point. The user has to enable
> > CONFIG_AUTOFDO_CLANG anyway, so what is the point in having
> > ARCH_SUPPORTS_AUTOFDO_CLANG. Why would an architecture _not_ want to
> > select that?
> >
> > > We are not enabling this for all architectures because AutoFDO's optimized build
> > > relies on Last Branch Records (LBR) which aren't available on all architectures.
> >
> > So? ETM isn't available on all arm64 machines and I doubt whether LBR is
> > available on _all_ x86 machines either. So there's a runtime failure
> > mode that needs to be handled anyway and I don't think the arch-specific
> > Kconfig option is really doing anything useful.
> 
> My understanding of the benefits of ARCH_SUPPORTS_AUTOFDO_CLANG is:
> 1. Generally, we don't prefer to collect an AutoFDO profile on one
> architecture and use it to build the kernel for another architecture.
> This is because the profile misses data for architecture-dependent
> code. ARCH_SUPPORTS_AUTOFDO_CLANG can partially prevent this from
> happening.

Hmm, not really. Once more than one architecture selects the option, you
have the possibility of the mismatch you're trying to avoid.

> 2. Building a kernel with an AutoFDO profile involves using new
> optimization flags for clang.  Having ARCH_SUPPORTS_AUTOFDO_CLANG=y
> for one architecture means someone has tested building a kernel with
> an AutoFDO profile on this architecture.

On the flip side, allowing all architectures to select the option
actually increases your test coverage.

Will

