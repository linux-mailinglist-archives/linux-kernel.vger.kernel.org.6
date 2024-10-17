Return-Path: <linux-kernel+bounces-369606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E359A1F80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9D41F27FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD61DA0E3;
	Thu, 17 Oct 2024 10:10:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7ED1D9665
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159820; cv=none; b=FlqWFY5FMcUsTsZv3jymXcvsglmF2aZrouPef6CVLq/4wyDScTakKd6IUOuqWE6KW25oVb0BBhBc3NS3yl/yznOMhuTFnwpuQ2YRRz5aiVuykLe+/lF0Ij4P9Gq8xq3D7pl6rwrIMD59IW+mU9u9zQcr7Ne/h/ToXCBvfql6weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159820; c=relaxed/simple;
	bh=5MmganSkY9EwYM+hJwn2kIIvfvkeRpb5Bzkji/bpPzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnL9ePW6huyOq4mJ/BbXiVgmBKubVSnTaQX5lDWjQpIEGYM1WMDDWeuo2Gwqled85rXYIeadZCsBaG/8BkrmVuCDKAwFOBaai9iinOUbp5SwklW1MP6Mxsa27WJwDplMw+nG/d92EsC1iRkemvSCjVc9mnif0W/u89vG9xaoso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 775E9FEC;
	Thu, 17 Oct 2024 03:10:45 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0D5D3F71E;
	Thu, 17 Oct 2024 03:10:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:09:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Antonio Borneo <antonio.borneo@foss.st.com>
Subject: Re: Crash on armv7-a using KASAN
Message-ID: <ZxDh9biUbf9W8gNN@J2N7QTR9R3>
References: <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
 <Zw9_imsl2KLf7_GY@J2N7QTR9R3>
 <CACRpkda8tO=QLF_zznoNjdNfNZJVntY_3+247E=qK6zNqRnVSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda8tO=QLF_zznoNjdNfNZJVntY_3+247E=qK6zNqRnVSA@mail.gmail.com>

On Wed, Oct 16, 2024 at 09:00:22PM +0200, Linus Walleij wrote:
> On Wed, Oct 16, 2024 at 10:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > I believe that's necessary for the lazy TLB switch, at least for SMP:
> >
> >         // CPU 0                        // CPU 1
> >
> >         << switches to task X's mm >>
> >
> >                                         << creates kthread task Y >>
> >                                         << maps task Y's new stack >>
> >                                         << maps task Y's new shadow >>
> >
> >                                         // Y switched out
> >                                         context_switch(..., Y, ..., ...);
> >
> >         // Switch from X to Y
> >         context_switch(..., X, Y, ...) {
> >                 // prev = X
> >                 // next = Y
> >
> >                 if (!next->mm) {
> >                         // Y has no mm
> >                         // No switch_mm() here
> >                         // ... so no check_vmalloc_seq()
> >                 } else {
> >                         // not taken
> >                 }
> >
> >                 ...
> >
> >                 // X's mm still lacks Y's stack + shadow here
> >
> >                 switch_to(prev, next, prev);
> >         }
> >
> > ... so probably worth a comment that we're faulting in the new
> > stack+shadow for for lazy tlb when switching to a task with no mm?
> 
> Switching to a task with no mm == switching to a kernel daemon.

A common misconception, but not always true:

* A kernel thread can have an mm: see kthread_use_mm() and
  kthread_unuse_mm().

* A user thread can lose its mm while exiting: see how do_exit() calls
  exit_mm(), and how hte task remains preemptible for a while
  thereafter.

... so we really do just mean "a task with no mm".

> And those only use the kernel memory and relies on that always
> being mapped in any previous mm context, right.

A task with no mm only uses kernel memory. Anything it uses must be
mapped in init_mm, but *might* not have been copied into every other mm,
and hence might not be in the previous mm context as per the example
above.

> But where do we put that comment? In kernel/sched/core.c
> context_switch()?

I was trying to suggest we update the existing comment in switch_to() to
be more explicit. e.g. expand the existing comment:

	@
	@ Do a dummy read from the new stack while running from the old one so
	@ that we can rely on do_translation_fault() to fix up any stale PMD
	@ entries covering the vmalloc region.
	@

... with:

	@
	@ For a non-lazy mm switch, check_vmalloc_seq() has ensured that
	@ that the active mm's page tables have mappings for the prev
	@ task's stack and the next task's stack.
	@
	@ For a lazy mm switch the active mm's page tables have mappings
	@ for the prev task's stack but might not have mappings for the
	@ new taks stack. Do a dummy read from the new stack while
	@ running from the old stack so that we can rely on
	@ do_translation_fault() to fix up any stale PMD entries
	@ covering the vmalloc region.
	@

Ard, does that sound good to you?

Mark.

