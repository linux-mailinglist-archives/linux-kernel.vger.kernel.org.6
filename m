Return-Path: <linux-kernel+bounces-366120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D135699F121
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70921C23031
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A61B3954;
	Tue, 15 Oct 2024 15:26:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5AC1CBA1D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005978; cv=none; b=Xs2aNKRnolVJG++Dp2TI4BA2iUcrDi811ye0Yvv8tH5DLCkI8HLFQ0AK9UR8xls8oNNMc+L4eGFnHl1u80PJR0buJdbFcX2BJMc0qfc2BXdvO0W/TqqcxR7fclRNDeex7sTdQNC3A3xWckdiljjoHxsLO+JmhzvgsuU17HRPgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005978; c=relaxed/simple;
	bh=bqwtlhzJ3wh01w6QEQuywq4iwW9mt1CLvMHit2Oma5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft3ohWGzB1ggZYtNLtHiGg5fYPBXEhZKyMa2saIlf6BoVvh+ie1wR+sfllf87Lz387jOIe/iFt89JrIklFI4YCeAdMfbK6ofIGJzyva+xANO59hcJrE+u7vUZk0cSgwNX5+iEtjpB9TBAFEQ5O/ofniFZ+cF3+qLD4GVztliGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0FB1007;
	Tue, 15 Oct 2024 08:26:45 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBA0B3F528;
	Tue, 15 Oct 2024 08:26:13 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:26:11 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Antonio Borneo <antonio.borneo@foss.st.com>
Subject: Re: Crash on armv7-a using KASAN
Message-ID: <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com>
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
 <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> On Tue, 15 Oct 2024 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 04:22:20PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 15 Oct 2024 at 16:00, Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> > > > > On Tue, Oct 15, 2024 at 12:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote:
> > > > >
> > > > > > I think what's happening here is that when switching from prev to next
> > > > > > in the scheduler, we switch to next's mm before we actually switch to
> > > > > > next's register state, and there's a transient window where prev is
> > > > > > executed using next's mm. AFAICT we don't map prev's KASAN stack shadow
> > > > > > into next's mm anywhere, and so inlined KASAN_STACK checks recursively
> > > > > > fault on this until we switch to the overflow stack.
> >
> > [...]
> >
> > > > > Yeah it looks like a spot-on identification of the problem, I can try to
> > > > > think about how we could fix this if I can reproduce it, I keep trying
> > > > > to provoke the crash :/
> > > >
> > > > It's a bit grotty -- AFAICT you'd either need to prefault in the
> > > > specific part of the vmalloc space when switching tasks, or we'd need to
> > > > preallocate all the shared vmalloc tables at the start of time so that
> > > > they're always up-to-date.
> > > >
> > > > While we could disable KASAN_STACK, that's only going to mask the
> > > > problem until this happens for any other vmalloc shadow...
> > >
> > > Is the other vmalloc shadow not covered by the ordinary on-demand faulting?
> >
> > It depends on what the vmalloc memory is used for; if it's anything else
> > used in the fault handling path, that'll fault recursively, and it's
> > possible that'll happen indirectly via other instrumentation.
> >
> > > When I implemented VMAP_STACK for ARM, I added an explicit load from
> > > the new stack while still running from the old one (in __switch_to) so
> > > that the ordinary faulting code can deal with it. Couldn't we do the
> > > same for the vmalloc shadow of the new stack?
> >
> > We could do something similar, but note that it's backwards: we need to
> > ensure that the old/current stack shadow will be mapped in the new mm.
> >
> > So the usual fault handling can't handle that as-is, because you need to
> > fault-in pages for an mm which isn't yet in use. That logic could be
> > factored out and shared, though.
> 
> Not sure I follow you here. The crash is in the kernel, no?

Yep; I'm referring to the vmalloc space being lazily faulted-in and
copied from init_mm into the active pgd under do_translation_fault().

Looking some more, I don't see how VMAP_STACK guarantees that the
old/active stack is mapped in the new mm when switching from the old mm
to the new mm (which happens before __switch_to()).

Either I'm missing something, or we have a latent bug. Maybe we have
some explicit copying/prefaulting elsewhere I'm missing?

What happens when switching between two tasks whose stacks happen to be
in distinct sub-trees of the vmalloc tables?

> So there is only a single vmalloc space where all the mappings should
> reside, but each process has its own copy of the top level page table,
> which needs to be synced up when it goes stale.

Yep -- the problem is when we can safely do that syncing up, since the
lazy syncing in do_translation_fault() can't safely be used to sync
anything that's used during do_translation_fault(), including the stack,
etc.

Mark.

