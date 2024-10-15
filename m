Return-Path: <linux-kernel+bounces-366013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E83C099EFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CEBB22BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8F1B21BF;
	Tue, 15 Oct 2024 14:35:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC271FC7D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002958; cv=none; b=TKr9DRgWmEyEreuiNzuvQoQ5jHLqS9NZiX9RIShiuIo3jJxqS/iGSx54+sOHa8r2lJTkoHTVvoPYhn8OgySYkwu8g404+86gNe5j7zv9VH56BJ8boeKt61twI9d3PEnifOyRAXIzKMHYdDGrFENqvX9OWkD5H8mzZQ84GxS5JxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002958; c=relaxed/simple;
	bh=/qF9LjHhXfoXqAH8MpAcqPtVoNTl7hz5XNjJnyX+BmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzWVV9FPF6JwQ14ZdOkhb6QLTyXmf5IFGeA8DcfwXVMEcnHSUV9AEKYE8GmowCVGFhFX9u0NOsuElF8vIlRRdzKZrLQ/7C4qfwoeVTOYDvjUAE4Sk0cuO5/+fZeUqgcbwcSUDXZCMCjAisRRYhpaXtiSnQtWLnf986DpTes5Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53B29FEC;
	Tue, 15 Oct 2024 07:36:25 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F993F71E;
	Tue, 15 Oct 2024 07:35:53 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:35:51 +0100
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
Message-ID: <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
 <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:22:20PM +0200, Ard Biesheuvel wrote:
> On Tue, 15 Oct 2024 at 16:00, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> > > On Tue, Oct 15, 2024 at 12:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote:
> > >
> > > > I think what's happening here is that when switching from prev to next
> > > > in the scheduler, we switch to next's mm before we actually switch to
> > > > next's register state, and there's a transient window where prev is
> > > > executed using next's mm. AFAICT we don't map prev's KASAN stack shadow
> > > > into next's mm anywhere, and so inlined KASAN_STACK checks recursively
> > > > fault on this until we switch to the overflow stack.

[...]

> > > Yeah it looks like a spot-on identification of the problem, I can try to
> > > think about how we could fix this if I can reproduce it, I keep trying
> > > to provoke the crash :/
> >
> > It's a bit grotty -- AFAICT you'd either need to prefault in the
> > specific part of the vmalloc space when switching tasks, or we'd need to
> > preallocate all the shared vmalloc tables at the start of time so that
> > they're always up-to-date.
> >
> > While we could disable KASAN_STACK, that's only going to mask the
> > problem until this happens for any other vmalloc shadow...
> 
> Is the other vmalloc shadow not covered by the ordinary on-demand faulting?

It depends on what the vmalloc memory is used for; if it's anything else
used in the fault handling path, that'll fault recursively, and it's
possible that'll happen indirectly via other instrumentation.

> When I implemented VMAP_STACK for ARM, I added an explicit load from
> the new stack while still running from the old one (in __switch_to) so
> that the ordinary faulting code can deal with it. Couldn't we do the
> same for the vmalloc shadow of the new stack?

We could do something similar, but note that it's backwards: we need to
ensure that the old/current stack shadow will be mapped in the new mm.

So the usual fault handling can't handle that as-is, because you need to
fault-in pages for an mm which isn't yet in use. That logic could be
factored out and shared, though.

Mark.

