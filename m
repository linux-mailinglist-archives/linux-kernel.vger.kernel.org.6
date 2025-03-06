Return-Path: <linux-kernel+bounces-548585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAAA546B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35BD7A630F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491120ADF9;
	Thu,  6 Mar 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIWme3yQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F3199935
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254213; cv=none; b=pS0OY1mVZrwUGdsEpjM+F7cE1yCW/K+/eu0Z72x5vY/Sxd08Vxrhq+dKIQjBjpTTxlIWTKmfJmKnGi3VWVmh0kHT3/GE9oBJF8m6Fhj96sOO4u7X6mnm5hGaCZJuHgwQGa2L18VSMR5TG416W5iYfr+ykF83apMBPb0NRocSxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254213; c=relaxed/simple;
	bh=jw6s+y+D9IZycuqaU4Du3dwxt58LD9HEaTS2UQM4s48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFv/TZVZNlJZ66XZHQ9yFoy8bacKAt+v5dQDfGENNoXnMOgk6Phd8HZDrAF65oPV41XfU2uUYjfxopZKw3T6Js3xqZWG/9hD+HKIH2a62SEkSx+mgzQ8zb/C7Ef2ZcMLLLsaPUPgFbpl2CvFnu8mymS6+sMmxL3nFaG7pBw37D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIWme3yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83D4C4CEE4;
	Thu,  6 Mar 2025 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254212;
	bh=jw6s+y+D9IZycuqaU4Du3dwxt58LD9HEaTS2UQM4s48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIWme3yQ6WAIuhaYRixCD9n/Bf0aFcP6DydhjYqkHv9b+YTndXLcex94E0nrwVXmj
	 R6j5qCeBII6GEYoa/RrieeI7NYoMOD2WNGxBVVIat9HRWGk8Resg6aueur3c857VoD
	 XDWp63EFzIWRRSaDc1htA/cJz7UmB8TN0qAtpvOTAfIBPWRncr55HE8GkruMz3Vnj1
	 hShWxgZeWj9fjkU1t/XNdLFJLaaldZde10Xr3NWN8vlmyWise6b1g1g9Z/flOQeMQj
	 aPTzAxoXS1ebFBg5sPzB4MYSyNN1PG69CJStEofh5H8Tm0XMrSZ2WUEbDQIA4tjPyE
	 HdRPJTR616Aww==
Date: Thu, 6 Mar 2025 10:43:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: kernel: Current status of CONFIG_CC_OPTIMIZE_FOR_SIZE=y (was: Re:
 [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic locking insns)
Message-ID: <Z8luPgXr9hcO7jDz@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local>
 <20250305212638.GC35526@noisy.programming.kicks-ass.net>
 <CAFULd4ZsHKA4Yh9CsxPjdoW-fa7yD1-Ov7xDN4E3J3c8O8yQ7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZsHKA4Yh9CsxPjdoW-fa7yD1-Ov7xDN4E3J3c8O8yQ7g@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Wed, Mar 5, 2025 at 10:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 05, 2025 at 09:36:33PM +0100, Borislav Petkov wrote:
> > > On Wed, Mar 05, 2025 at 09:54:11AM +0100, Uros Bizjak wrote:
> > > > The -Os argument was to show the effect of the patch when the compiler
> > > > is instructed to take care of the overall size. Giving the compiler
> > > > -O2 and then looking at the overall size of the produced binary is
> > > > just wrong.
> > >
> > > No one cares about -Os AFAICT. It might as well be non-existent. So the effect
> > > doesn't matter.
> >
> > Well, more people would care if it didn't stand for -Ostupid I suppose.
> > That is, traditionally GCC made some very questionable choices with -Os,
> > quite horrendous code-gen.
> 
> Size optimizations result in 15% code size reduction (x86_64
> defconfig, gcc-14.2), so they reflect what user wanted:
> 
>   text    data     bss     dec     hex filename
> 27478996        4635807  814660 32929463        1f676b7 vmlinux-O2.o
> 23859143        4617419  814724 29291286        1bef316 vmlinux-Os.o
> 
> The compiler heuristics depend on tradeoffs, and -Os uses different
> tradeoffs than -O2. Unfortunately, there is no
> -Os-but-I-really-want-performace switch, but OTOH, tradeoffs can be
> adjusted. The compiler is open-source, and these adjustments can be
> discussed in public spaces (mailing lists and bugzilla) and eventually
> re-tuned. We are aware that the world around us changes, so tunings
> are not set in stone, but we also depend on user feedback.

So the best way to drive -Os forward is not to insist that it's good 
(it might still be crap), and not to insist that it's crap (it might 
have become better), but to dig out old problems and to look at what 
kind of code current compilers generate in the kernel with -Os.

There's been a few pathological GCC optimizations in the past, but also 
other problems, such as this one 9 years ago that hid useful warnings:

  =================>
  877417e6ffb9 Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
  =================>

  From: Arnd Bergmann <arnd@arndb.de>
  Date: Mon, 25 Apr 2016 17:35:27 +0200
  Subject: [PATCH] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition

    CC_OPTIMIZE_FOR_SIZE disables the often useful -Wmaybe-unused warning,
    because that causes a ridiculous amount of false positives when combined
    with -Os. 
      
    This means a lot of warnings don't show up in testing by the developers
    that should see them with an 'allmodconfig' kernel that has
    CC_OPTIMIZE_FOR_SIZE enabled, but only later in randconfig builds
    that don't.

And this one by Linus, 14 years ago:

  =================>
  281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
  =================>

  From: Linus Torvalds <torvalds@linux-foundation.org>
  Date: Sun, 22 May 2011 14:30:36 -0700
  Subject: [PATCH] Give up on pushing CC_OPTIMIZE_FOR_SIZE

    I still happen to believe that I$ miss costs are a major thing, but
    sadly, -Os doesn't seem to be the solution.  With or without it, gcc
    will miss some obvious code size improvements, and with it enabled gcc
    will sometimes make choices that aren't good even with high I$ miss
    ratios.

    For example, with -Os, gcc on x86 will turn a 20-byte constant memcpy
    into a "rep movsl".  While I sincerely hope that x86 CPU's will some day
    do a good job at that, they certainly don't do it yet, and the cost is
    higher than a L1 I$ miss would be.

    Some day I hope we can re-enable this.

    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

I'm quite sure there were more, but these were that popped up in a 
quick Git archeology.

And yeah, it was me who pushed for -Os originally 17 years ago, due to 
the positive I$ impact, in theory:

  =================>
  96fffeb4b413 ("make CC_OPTIMIZE_FOR_SIZE non-experimental")
  =================>

  From: Ingo Molnar <mingo@elte.hu>
  Date: Mon, 28 Apr 2008 01:39:43 +0200
  Subject: [PATCH] make CC_OPTIMIZE_FOR_SIZE non-experimental

    this option has been the default on a wide range of distributions
    for a long time - time to make it non-experimental.

    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

But practice disagreed with theory, and obviously in the kernel 
practice has supremacy.

But yes, I'd cautiously agree that reduced kernel size with a -Os build 
is a stochastic proxy metric for better code and better performance - 
but it comes with caveats and needs to be backed by other data or 
robust first principles arguments too.

Thanks,

	Ingo

