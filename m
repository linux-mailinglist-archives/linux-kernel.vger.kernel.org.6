Return-Path: <linux-kernel+bounces-438231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981479E9EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342E9280CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3281B19E7E3;
	Mon,  9 Dec 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p519Aw5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78907198A37;
	Mon,  9 Dec 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770590; cv=none; b=oqTxX6N7Hc511zxFay0zalohJr11ioubZ3BhEDUGGAa0Yoafv+QzQVxtKKQq26eMkQmaeKqna65zP2HGp7lB6ByYsXRPJmDPHoqRFqUx3pygfye77nQ6SZvlBvbi+ERl4q9J6HlfAKz3PDrev+smCMqEdDVZStDVTACsKGTAWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770590; c=relaxed/simple;
	bh=jWitqbI3BToGLZp+6qWZmYRLd+6j/B93+eI3CbU4/Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNZR55U71i2IgDewaON44ET2Gq2cKdRfsEqCf1EY8k3qYPHzXRm08ZWMFemVcKADA1bPBTiFW2kpdzw7gznmReEWMuUrqD0+xJUOULWnAQjV8XTHZDw/oVA5npzqdbESVyxN853qStQsrOlg/0yrJZ4IBUpVQDWevyRBx10YrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p519Aw5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6431C4CED1;
	Mon,  9 Dec 2024 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770590;
	bh=jWitqbI3BToGLZp+6qWZmYRLd+6j/B93+eI3CbU4/Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p519Aw5jPWzqrzBFSTv91Bmk6wjee690Qpps0g/UQj0hE3dtph47dJtKsHJu+98dP
	 jCjDpI3BYoG1hMUaaKN3RHQ0NXXJ3qZTnM4TeRBhQy6g25VjNT0oLUScszmLxFltJT
	 OUhzlgSL4aSJQJLgUebHnoggFhyNsK8/RYe14LdK6F6fLXhg6T56JdTMy5VFSdNIeO
	 FeWRcfUZ1XcLAJgDgx3ArhqhUzGwLECc8tZtQd1YVxOkgDfloR5vs9DSA5v2D5kdQB
	 gzLxWWdQ7pi3w6K3MTRJNXGZFjN8NvG02r9Jy59wXvMAKlLoqzeBmNUowRndSdoJHy
	 MdMjsFTSCEPxA==
Date: Mon, 9 Dec 2024 18:56:24 +0000
From: Will Deacon <will@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Yabin Cui <yabinc@google.com>, Han Shen <shenhan@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
Message-ID: <20241209185623.GA13084@willie-the-truck>
References: <20241118222540.27495-1-yabinc@google.com>
 <20241209162028.GD12428@willie-the-truck>
 <CAF1bQ=SiHi8oCyo5YnXGpQGofM1zAsnBdqSEet1mS-BYNKVU8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1bQ=SiHi8oCyo5YnXGpQGofM1zAsnBdqSEet1mS-BYNKVU8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

(Aside: please try to avoid top-posting on the public lists as it messes up
the flow of conversation; I'll try to piece this back together.)

On Mon, Dec 09, 2024 at 09:30:50AM -0800, Rong Xu wrote:
> On Mon, Dec 9, 2024 at 8:20 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Nov 18, 2024 at 02:25:40PM -0800, Yabin Cui wrote:
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index fd9df6dcc593..c3814df5e391 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -103,6 +103,7 @@ config ARM64
> > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > >       select ARCH_SUPPORTS_RT
> > > +     select ARCH_SUPPORTS_AUTOFDO_CLANG
> > >       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> > >       select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> > >       select ARCH_WANT_DEFAULT_BPF_JIT
> >
> > After this change, both arm64 and x86 select this option unconditionally
> > and with no apparent support code being added. So what is actually
> > required in order to select ARCH_SUPPORTS_AUTOFDO_CLANG and why isn't
> > it just available for all architectures instead?

> Enabling an AutoFDO build requires users to explicitly set CONFIG_AUTOFDO_CLANG.
> The support code is in Commit 315ad8780a129e82 (kbuild: Add AutoFDO
> support for Clang build).

Yes, that is precisely my point. The user has to enable
CONFIG_AUTOFDO_CLANG anyway, so what is the point in having
ARCH_SUPPORTS_AUTOFDO_CLANG. Why would an architecture _not_ want to
select that?

> We are not enabling this for all architectures because AutoFDO's optimized build
> relies on Last Branch Records (LBR) which aren't available on all architectures.

So? ETM isn't available on all arm64 machines and I doubt whether LBR is
available on _all_ x86 machines either. So there's a runtime failure
mode that needs to be handled anyway and I don't think the arch-specific
Kconfig option is really doing anything useful.

Will

