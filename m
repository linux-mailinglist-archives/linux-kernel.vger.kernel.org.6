Return-Path: <linux-kernel+bounces-260124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31393A370
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8191C227D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C5154BE3;
	Tue, 23 Jul 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2oNYfiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BE13B599
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746949; cv=none; b=WxhL3vIfu5KJqUnK1PQO5SiZl3YszKDE6+mjkn/y0cAm22+aumMqhZodW3IfF69h1R7qolptWPHjLryq3C4SIUNLjf03ohESn/ONbk+oYbrehNP+8R469wGOoqVn1qPfiHb8dihBaNSKT1y8s9g6Ib8uh4opVvwrRW2yp7wrf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746949; c=relaxed/simple;
	bh=xb2br442o0CzRVEGoDDCnvZdYGa/Zy7goBOWiolJR/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9sHfNnGhfblH5XjNyeq7yfZg1aK5gmI4+TU2zdKyoyRr5O3jWmeSu/ByuGSeFm5LujKshytj0acFKEWpkpyg9Ot2826gtUlEo5ATV/q29bmair8K7VUg/mEL+r53nSTq8TWfi1m6Qf1z71SKmNgLqkmbCWoSO5fDaeDRbVxwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2oNYfiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660DAC4AF11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721746949;
	bh=xb2br442o0CzRVEGoDDCnvZdYGa/Zy7goBOWiolJR/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f2oNYfiUjEB+9IAi4WC+t7UZyHm+fQH/uzO/M1VeLiu5MPJVIv1GSZyHTYDVqLSiy
	 B9ybHoLD78ZSgXyQ+aLLjXe2wfpK4ajcKpNHbjZBP+1BHTQ07ph/nrcx9JJzD+1uHL
	 Mtp8xfgd9VlEujKpRtWSxPI6FXB5YD1YZE/nVZqrmJ4Ah1GkRwkAr1yW2Jk3iAEMhX
	 9f6R4+fY2T56uKkkBp+subo/mUpMiZ5ysH9V9dScLUJ/3vNz699m9zns5wAGirMrXN
	 NK3k0MmcY3dbdHlpOHBBBqTezTeewl2rjXPEyHBNwndRHEFEEXUoYjdWDngwtlMWp4
	 iyRiY/jN0FPeQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so32012771fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:02:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2awm2xf+9hYwDpzkNWFf2xOHU9fQZ24pGgTeJYgmSyXxePlEo/NdtoRg++hyYhdRQON8g9UI+nxzDKyyinZLwyQA8OHzaKcXFQ+YT
X-Gm-Message-State: AOJu0YwCU5Hz9Io7z/xRysFXat6qt+lHhfZaoLWvzz8LodJyyHBXzVLB
	iLY/bGPZPoUkrxEg5mW6l2PZwJut2u6q1xoJf9mL1QEuFRQUmaJgBU3DfGFsp95p/Opll8/Fz1s
	LkN2Opxyl84GVn30a9/JNNxhziXM=
X-Google-Smtp-Source: AGHT+IFhuDrUuAIaLprKGCMnkYvkdJ7xMDPkYihA099ElTqnhewJF7rPpzY+SAsjsnx51wHA9zO5EDGDguIS8RDugZI=
X-Received: by 2002:a05:651c:1a2c:b0:2ef:2b56:36a9 with SMTP id
 38308e7fff4ca-2ef2b563725mr68364231fa.16.1721746947037; Tue, 23 Jul 2024
 08:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck> <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
 <20240723145214.GA26403@willie-the-truck>
In-Reply-To: <20240723145214.GA26403@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jul 2024 17:02:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEkHKtFKFS3ejeDsg1Q+2NY1JibzurzqgwVGqb+1=XrRg@mail.gmail.com>
Message-ID: <CAMj1kXEkHKtFKFS3ejeDsg1Q+2NY1JibzurzqgwVGqb+1=XrRg@mail.gmail.com>
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
To: Will Deacon <will@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 16:52, Will Deacon <will@kernel.org> wrote:
>
> Hey Ard,
>
> On Fri, Jul 19, 2024 at 11:02:29AM -0700, Ard Biesheuvel wrote:
> > Thanks for the cc, and thanks to Lina for the excellent diagnosis -
> > this is really helpful.
> >
> > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > index f8efbc128446..3afe624a39e1 100644
> > > --- a/arch/arm64/include/asm/pgtable.h
> > > +++ b/arch/arm64/include/asm/pgtable.h
> > > @@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
> > >
> > >  #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
> > >
> > > +static inline
> > > +p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> >
> > This is in the wrong place, I think - we already define this for the
> > 5-level case (around line 1760).
>
> Hmm, I'm a bit confused. In my tree, we have one definition at line 1012,
> which is for the 5-level case (i.e. guarded by
> '#if CONFIG_PGTABLE_LEVELS > 4'). I'm adding a new one at line 1065,
> which puts it in the '#else' block and means we use an override instead
> of the problematic generic version when we're folding.
>

Indeed. I failed to spot from the context (which is there in the diff)
that this is in the else branch.

> > We'll need to introduce another version for the 4-level case, so
> > perhaps, to reduce the risk of confusion, we might define it as
> >
> > static inline
> > p4d_t *p4d_offset_lockless_folded(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> > {
> > ...
> > }
> > #ifdef __PAGETABLE_P4D_FOLDED
> > #define p4d_offset_lockless p4d_offset_lockless_folded
> > #endif
>
> Renaming will definitely make this easier on the eye, so I'll do that.
> I don't think I need the 'ifdef' though.
>

Indeed.

> > > +{
> >
> > We might add
> >
> > if (pgtable_l4_enabled())
> >     pgdp = &pgd;
> >
> > here to preserve the existing 'lockless' behavior when PUDs are not
> > folded.
>
> The code still needs to be 'lockless' for the 5-level case, so I don't
> think this is necessary.

The 5-level case is never handled here.

There is the 3-level case, where the runtime PUD folding needs the
actual address in order to recalculate the descriptor address using
the correct shift. In this case, we don't dereference the pointer
anyway so the 'lockless' thing doesn't matter (afaict)

In the 4-level case, we want to preserve the original behavior, where
pgd is not reloaded from pgdp. Setting pgdp to &pgd achieves that.

> Yes, we'll load the same entry multiple times,
> but it should be fine because they're in the context of a different
> (albeit folded) level.
>

I don't understand what you are saying here. Why is that fine?

> > > +       return p4d_offset(pgdp, addr);
> > > +}
> > > +#define p4d_offset_lockless p4d_offset_lockless
> > > +
> > >  #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
> > >
> >
> > I suggest we also add something like the below so we can catch these
> > issues more easily
> >
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -874,9 +874,26 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
> >
> >  static inline pud_t *p4d_to_folded_pud(p4d_t *p4dp, unsigned long addr)
> >  {
> > +       /*
> > +        * The transformation below does not work correctly for descriptors
> > +        * copied to the stack.
> > +        */
> > +       VM_WARN_ON((u64)p4dp >= VMALLOC_START && !__is_kernel((u64)p4dp));
>
> Hmm, this is a bit coarse. Does it work properly with the fixmap?
>

Good point. I did some boot tests with this but I'm not sure if it is
100% safe with the fixmap.

