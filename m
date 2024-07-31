Return-Path: <linux-kernel+bounces-269570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51694346C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D5F1F22726
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285661BC099;
	Wed, 31 Jul 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHWmXXXD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383B17BA9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444674; cv=none; b=X2EauXsS9wEO4kltleWpYSWa5EcJCU4NdOMs5Se5TZMH4HJj828RnGjrBcOiU+UL5uCx2vts3zC6m78hdGN64fn3Sc/wzqamnTpC2xwMcWNI+W7JtmNGEE7ayyEaiTkLNOthcaXJfPqCPXlfbcGHCWa2NKwbF0CffHNSHoUOWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444674; c=relaxed/simple;
	bh=RW8l5Bj0UReNwN2mZkzcpLCmaAHXIiKvP7xp8JMnuEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdSmPk1efQSTz+PFQatprSYMYtjd1trGr95hXpKmHA5NazpqMD92pVRURL22hPEmzHadNXOD+LZhXV95XbqjGCdFlDiVa7i09FZPSturqKy8b33Eev5fDnNpboLFOb9r81vZ/9uQYZtY8suBjQFup/4l6+QG/GtTmjNPAd0OP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QHWmXXXD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bqUudBbOH5u06vWeCbLCRoCaWdJq8DA+wQj13Ra52gY=; b=QHWmXXXDauYFsGXZwJgFx1Pxn8
	BjXV2QQJFSiA6uKMVEAXaMdsVjl/BYGflI/hbkX/6h4BvwxtBeJsg0W9bLbiQ3GDly49XwOWgWbjz
	QjOH95kbriz6fK5O1OIA592DimRZFZINI7Av6kE6xCq8XNLVWiI9yADiSQBJZCLrJHJPDEpE3fkV5
	iS38PceIxfF03m0cN4/88VBAq7BD+V0/4WfNG/b1AjjruWFZZyoEigq2oyANTNqNmHZ9eY9xa05Te
	xoKpdJ2rbsoxyKEtV3Smx9N7Ww+bKqKAQqnOCAhuAel8U0g99+iS2zrr8RCSsm13xhoTP2all6WCl
	dl8Uo9TA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZCXd-0000000GLqF-0sgn;
	Wed, 31 Jul 2024 16:51:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9494D300820; Wed, 31 Jul 2024 18:51:08 +0200 (CEST)
Date: Wed, 31 Jul 2024 18:51:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731165108.GH33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731163105.GG33588@noisy.programming.kicks-ass.net>

On Wed, Jul 31, 2024 at 06:31:05PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 09:17:44AM -0700, Linus Torvalds wrote:
> > On Wed, 31 Jul 2024 at 08:55, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Right, so Thomas found that i386-pti fails to map the entire entry text.
> > > Specifically pti_clone_pgtable() hard relies -- and does not verify --
> > > that the start address is aligned to the given granularity.
> > >
> > > Now, i386 does not align __entry_text_start, and so the termination
> > > condition goes sideways and pte_clone_entry() does not always work right
> > > and it becomes a games of code layout roulette.
> > 
> > Lovely.
> 
> :-)
> 
> This fixes the alignment assumptions and makes it all go again.

Thomas, this all still relies on the full text section being PMD mapped,
and since we don't have ALIGN_ENTRY_TEXT_END and _etext has PAGE_SIZE
alignment, can't have a PAGE mapped tail which then doesn't get cloned?

Do we want to make pto_clone_entry_text() use PTI_LEVEL_KERNEL_IMAGE
such that it will clone whatever it has?

> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 2e69abf4f852..bfdf5f45b137 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -374,14 +374,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>  			 */
>  			*target_pmd = *pmd;
>  
> -			addr += PMD_SIZE;
> +			addr = round_up(addr + 1, PMD_SIZE);
>  
>  		} else if (level == PTI_CLONE_PTE) {
>  
>  			/* Walk the page-table down to the pte level */
>  			pte = pte_offset_kernel(pmd, addr);
>  			if (pte_none(*pte)) {
> -				addr += PAGE_SIZE;
> +				addr = round_up(addr + 1, PAGE_SIZE);
>  				continue;
>  			}
>  
> @@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>  			/* Clone the PTE */
>  			*target_pte = *pte;
>  
> -			addr += PAGE_SIZE;
> +			addr = round_up(addr + 1, PAGE_SIZE);
>  
>  		} else {
>  			BUG();

