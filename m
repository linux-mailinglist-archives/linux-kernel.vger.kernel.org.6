Return-Path: <linux-kernel+bounces-536323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FBA47E28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A733A764D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F422F15E;
	Thu, 27 Feb 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0M4CXfg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B922E3F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660378; cv=none; b=uYSuQDzfHxlbyUSMrBFY6HrHSLUzgURL0XMCv630CQ42gHSRjuVWo7fq5B8ZicUYXfvIWLMJSG8JbALNnEWb+taQjz/YmV7lUcl4hIIwEWIcaf5vuDU44h+o85r3mG6IpZ3kFW5fMO75WQKQWNNn/reSLqeG99fvsvb7MCLMvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660378; c=relaxed/simple;
	bh=OhtrBRrKlb3Qef4DHwRD6iN0oY2M43cwK6JI9Sk+Xiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7vXZJf0hhLQjfb27WDwGM5sciGD7lNXDBkwYGnm/bLabJZsvEEtxSuf+jrAj6dMmdGodezd96Ss1R++Bfagxyx3rjTimYbndQltiK1p7HWXyaHsgzwmwhFG5fngGoN4TEQbY/RUNgZTXnecspZy14WIB2V0nndLPL0JfzO3DMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0M4CXfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71957C4CEDD;
	Thu, 27 Feb 2025 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740660377;
	bh=OhtrBRrKlb3Qef4DHwRD6iN0oY2M43cwK6JI9Sk+Xiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0M4CXfgdyQYCtyhp3pdYnP7f9uQa3pcSIxV4Rpl05lzL3TxFuD51e5G1fDbzFNhA
	 P6vYZ9osauXfRPYB2VwapqX6LkSeJcRRPVFVkXuZWeHzZRzLwanpwRP8GG/vaj4xkp
	 bL68H4GzUSD25+Aa5XDB5PkleP3R9t2MKYlpiF9aOGDRw91DBrIxmSAnC56XAnIUPE
	 GK0oLjIS8/uFdMsAYrSpLZA0feAHpwLTwRWkifqTVyFgGa6FY6RVpYzrNWWYXRrEED
	 Vpz65t/JTrNIHtHw4yw1dfRIE3UvTI5OdNZp1EFAa1gEiFT1sBY43ocoVOr9TBD9Y4
	 PaMfAhqZg7wLg==
Date: Thu, 27 Feb 2025 13:46:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Jakub Jelinek <jakub@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
Message-ID: <Z8BekITYkuc4F4b1@gmail.com>
References: <20241213190119.3449103-1-matt@readmodwrite.com>
 <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
 <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
 <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com>
 <Z8BY_AZPQQm0BJTu@gmail.com>
 <CAFULd4aCBMXcco_GdTYu9Zmc5A6+Z=J4XrsjLXWe1dydRD0oDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4aCBMXcco_GdTYu9Zmc5A6+Z=J4XrsjLXWe1dydRD0oDQ@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Thu, Feb 27, 2025 at 1:22 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > On Mon, Dec 16, 2024 at 5:20 PM Matt Fleming <matt@readmodwrite.com> wrote:
> > > >
> > > > On Sat, Dec 14, 2024 at 1:17 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> > > > >
> > > > > Does your config include CONFIG_UBSAN_BOOL=y ?
> > > >
> > > > Yes, it does!
> > > >
> > > > > There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_BOOL
> > > > > (aka -fsanitize=bool), reported in [1] and fixed for gcc-14.2 in [2].
> > > > >
> > > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736#c42
> > > > >
> > > > > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=115172
> > > > >
> > > > > Otherwise, please attach your .config, and I'll look into this issue.
> > > >
> > > > Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels boot again.
> > > >
> > > > Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?
> > >
> > > No, this is a very rare Oops that triggers only with gcc-14.1 version
> > > and only when both KASAN and UBSAN are enabled. This is actually the
> > > problem with sanitization of the percpu address when named address
> > > spaces are enabled (IOW, sanitization of __seg_gs prefixed address).
> > > UBSAN creates a temporary in memory, but forgets to copy memory tags,
> > > including named address space qualifier from the original. Later ASAN
> > > sanitizes this location as a normal variable (due to missing
> > > qualifier), but actually should be disabled for __seg_gs prefixed
> > > addresses.
> > >
> > > Your report is only *the second* since sanitizers were re-enabled with
> > > named address spaces. gcc-14.2 that includes the fix is available
> > > since August 2024, and since sanitizers are strictly development
> > > tools, my proposed solution would be to simply upgrade the compiler to
> > > gcc-14.2 release.
> >
> > So unless this is difficult to test for, it would be nice to have a
> > compiler version cutoff for the feature. Especially if it's been
> > reported twice already, chances are that a lot more people have
> > experienced it already.
> >
> > The kernel build should avoid this known oops automatically.
> 
> The patch could be as simple as:
> 
> --cut here--
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 95ea2b4b95db..c94c37889917 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2370,7 +2370,7 @@ config CC_HAS_NAMED_AS
>      depends on CC_IS_GCC
> 
>  config CC_HAS_NAMED_AS_FIXED_SANITIZERS
> -    def_bool CC_IS_GCC && GCC_VERSION >= 130300
> +    def_bool CC_IS_GCC && GCC_VERSION >= 140200
> 
>  config USE_X86_SEG_SUPPORT
>      def_bool y
> --cut here--
> 
> but it will disable all sanitizers for a very rare Oops that needs the
> combination of CONFIG_KASAN and CONFIG_UBSAN_BOOL.

Can we not limit the version quirk to KASAN && UBSAN_BOOL?

> The fix is available in gcc-14.2, released in August 2024.

And this is a contradictory argument: if the fix is so available then 
it shouldn't really matter whether we have to quirk or not? Everyone 
should have the fix already and the quirk shouldn't affect them, right?

Thanks,

	Ingo

