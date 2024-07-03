Return-Path: <linux-kernel+bounces-240105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B45926931
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4321F23EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C118E778;
	Wed,  3 Jul 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc2U6igV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6917DA39;
	Wed,  3 Jul 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036647; cv=none; b=m2WAtp3aCBhdcwf11VvXcsYRxZbynjj5Gk7+Sf5naKhqcKzk0fS5GLDoL7qOK7h+zczJ5gdtTlytsFG5cPsoREhQxZCpDe5akyIG9fcFh3tLTBQZTGZl9WR2BQ53TSWgr7FeljVByYOO8EYyqcJ0hLrVo4RA5ooMBo3dQVVcEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036647; c=relaxed/simple;
	bh=B29EQa+mtbSVXg+rbhLNxiaBQ3eymypv1ZXUo7G4/30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB1CwgM5wF46kNRoNaeuIbMNqRtAgJvhfiVGQ+EECIZOOvYUCbhixtrTjR8Ms/gKoRVQYlDGdgHyCz7sB50X8itlBFx91CyYa8NdRKoPLceGlSnqN8nhKuR8UNV5+oVUfaEPsoFPL6ynXhkVUXVqvR7NF5kbopbyjJTuwwq7YAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc2U6igV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FDC2BD10;
	Wed,  3 Jul 2024 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720036646;
	bh=B29EQa+mtbSVXg+rbhLNxiaBQ3eymypv1ZXUo7G4/30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dc2U6igV06Mk6Ler8Jh2sPmW7UsRoYhhDxSIuTcf15aQ0DL0YKjoBXiZwXomQxAmz
	 c3eUbhR9KhK0GcP4044I6b5x6vzKQxVDpmvibULBUyr3FP29rmkiSdKiHZXjYTJHcc
	 httCFkQEEUy/6M74YGUgQ616eSjCoPRV+56H1ZF3pqleuYLp1pihn7zzOZxkIwECgL
	 XzZzf0IU1yUVahJ9qJZ7S2fM0z0BASZGrgZ2N/9iTHj8hrnBI1H8+JYsq/c1uENr2O
	 R23SCmldmTvE5lXA5JFo955y8YWRFoINVQUjVudiUVk0PKeQyWYwOLQTEt/+dWG5jF
	 oNXlZvzz5xymw==
Date: Wed, 3 Jul 2024 12:57:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] cpumask: Switch from inline to __always_inline
Message-ID: <20240703195724.GA292031@thelio-3990X>
References: <20240514204910.1383909-1-briannorris@chromium.org>
 <ZnsML1RYMmEhhdPP@google.com>
 <ZoWhPFJIvGpMGKm4@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWhPFJIvGpMGKm4@yury-ThinkPad>

On Wed, Jul 03, 2024 at 12:06:36PM -0700, Yury Norov wrote:
> On Tue, Jun 25, 2024 at 11:27:59AM -0700, Brian Norris wrote:
> > Hi Yuri, Rasmus,
> > 
> > On Tue, May 14, 2024 at 01:49:01PM -0700, Brian Norris wrote:
> > > On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
> > > configurations [0], I'm finding that (lack of) inlining decisions may
> > > lead to section mismatch warnings like the following:
> > > 
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference:
> > >   cpumask_andnot (section: .text) ->
> > >   cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
> > >   modpost: Section mismatches detected.
> > > 
> > > or more confusingly:
> > > 
> > >   WARNING: modpost: vmlinux: section mismatch in reference:
> > >   cpumask_andnot+0x5f (section: .text) -> efi_systab_phys (section:
> > >   .init.data)
> > > 
> > > The first warning makes a little sense, because
> > > cpuhp_bringup_cpus_parallel() (an __init function) calls
> > > cpumask_andnot() on tmp_mask (an __initdata symbol). If the compiler
> > > doesn't inline cpumask_andnot(), this may appear like a mismatch.
> > > 
> > > The second warning makes less sense, but might be because efi_systab_phys
> > > and cpuhp_bringup_cpus_parallel.tmp_mask are laid out near each other,
> > > and the latter isn't a proper C symbol definition.
> > > 
> > > In any case, it seems a reasonable solution to suggest more strongly to
> > > the compiler that these cpumask macros *must* be inlined, as 'inline' is
> > > just a recommendation.
> > > 
> > > This change (plus more) has been previously proposed for other reasons
> > > -- that some of the bitmask 'const' machinery doesn't work without
> > > inlining -- in the past as:
> > > 
> > >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
> > >   https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
> > > 
> > > It seems like a good idea to at least make all cpumask functions use
> > > __always_inline; several already do.
> > > 
> > > According to bloat-o-meter, my ~29MB vmlinux increases by a total of 61
> > > bytes (0.00%) with this change.
> > > 
> > > [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
> > >     CONFIG_GCOV_PROFILE_ALL.
> > > 
> > > [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
> > >     arch_cpuhp_init_parallel_bringup() and enable it")
> > > 
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > > 
> > >  include/linux/cpumask.h | 214 +++++++++++++++++++++-------------------
> > >  1 file changed, 113 insertions(+), 101 deletions(-)
...
> cpumask_andnot() is a pure wrapper around bitmap_andnot(), and it's
> really surprising that clang decided to make it an outline function.
> Maybe the bitmap_andnot() is one that outlined? Did you apply only
> this patch, or my patch for bitmaps too to fix the warning?
> 
> Clang people are already in CC. Guys, can you please comment if making
> cpumask API __always_inline is OK for you? Why Clang decides to make a
> pure wrapper outlined?

There are a whole host of reasons why Clang's inliner might decide not
to inline a function. There is '-Rpass-missed=inliner', which should
enable optimization remarks for the inliner to maybe see why LLVM
thought it was not profitable to inline these functions, which could be
passed to Kbuild via KCFLAGS=-Rpass-missed=inliner or selectively for a
translation unit by adding 'CFLAGS_<file>.o := -Rpass-missed=inliner' to
whatever translation unit's Makefile that has a warning.

However, given that this appears to only show up when GCOV is enabled,
it is likely just the case that the additional instrumentation makes
certain functions appear unprofitable. Overriding the inliner with
__always_inline is not the end of the world, especially if it is
genuinely beneficial to always inline them. I can see how that would be
the case with these functions.

> I feel that if we decide making cpumask an __always_inline is the
> right way, we also should make underlying bitmap API __always_inline
> just as well. Otherwise, there will be a chance of having outlined
> bitmap helpers, which may confuse clang again.

If this does not result in noticeable bloat, this may not be a bad
idea. I seem to recall this being an issue in the past for us but I
cannot seem to find the issue at this point. Commit 1dc01abad654
("cpumask: Always inline helpers which use bit manipulation functions")
comes to mind.

Cheers,
Nathan

