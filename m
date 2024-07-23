Return-Path: <linux-kernel+bounces-260117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774CE93A33E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC781F22D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB7156C63;
	Tue, 23 Jul 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwc+93ye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0D155CAB;
	Tue, 23 Jul 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746340; cv=none; b=USUoFjbmrXbDYJvFwtE3aFVFMcKmZzDYFE12a+WacZiac4qEr6GG7ufw1Z/vD8ENTWkTVyeXMluM1JCfykPqBCiZRlqEi8pZLEr3JJL0I01VA9qoD6T9SWB0IbIDST98V3v/MvI5fEl+6Mtd2WbeDWabxN//x3sg1+tZ6UaBhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746340; c=relaxed/simple;
	bh=VmnqdqKrCSERHIJ0PvMmGjnUHXIweS/FQWmsghwZbII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNJt3+3VbF2R/jOPDfPeQAAvX8wjT0SxWdvbv00BsdlKtxd1NsutoHDJzvXoZNu1OIG/5F9T8XYZOESeqIjgh+CVlMxMK8dF4nRm3HA+ODENBRf6MnBu/u2kGl/5gcS34bzWUfZ92R4r2xBgnK+NNNKdm2mnUE2nchqPtgtOZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwc+93ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5473C4AF0C;
	Tue, 23 Jul 2024 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721746339;
	bh=VmnqdqKrCSERHIJ0PvMmGjnUHXIweS/FQWmsghwZbII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hwc+93yeX5UV1/+k3tTab46N7ZDq0h3tDis+AbYCW6zO6s6Kg5YYCT8hj7fx/RSqz
	 L0vpArbLio8Hti2WaRX3QCvv5YZnNj693B6ndRzJcvHmeC+IX68eWTWeJvwt442hOo
	 vwQCx/Yf014Q8KvMr7YcwSBhmjBr3YG/saAwRXxq7oZxRS3h0eltbmQK6ISJtid53X
	 lAv3nm5Zm/vlBGodG3xpLV9M0Mjxo9YES4kh/nIS+dEjM1Y/ak5CwEz1q4iXxH3KrQ
	 bav3DJHKd88Zcz0BjQnFfnKGyniHTO6ArU5UOsvtFtKh9PSGsbQQcvlQ5iOOOn6W6q
	 vDDPdW0E+3FJQ==
Date: Tue, 23 Jul 2024 15:52:14 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com,
	mark.rutland@arm.com
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
Message-ID: <20240723145214.GA26403@willie-the-truck>
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck>
 <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Ard,

On Fri, Jul 19, 2024 at 11:02:29AM -0700, Ard Biesheuvel wrote:
> Thanks for the cc, and thanks to Lina for the excellent diagnosis -
> this is really helpful.
> 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index f8efbc128446..3afe624a39e1 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
> >
> >  #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
> >
> > +static inline
> > +p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> 
> This is in the wrong place, I think - we already define this for the
> 5-level case (around line 1760).

Hmm, I'm a bit confused. In my tree, we have one definition at line 1012,
which is for the 5-level case (i.e. guarded by
'#if CONFIG_PGTABLE_LEVELS > 4'). I'm adding a new one at line 1065,
which puts it in the '#else' block and means we use an override instead
of the problematic generic version when we're folding.

> We'll need to introduce another version for the 4-level case, so
> perhaps, to reduce the risk of confusion, we might define it as
> 
> static inline
> p4d_t *p4d_offset_lockless_folded(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> {
> ...
> }
> #ifdef __PAGETABLE_P4D_FOLDED
> #define p4d_offset_lockless p4d_offset_lockless_folded
> #endif

Renaming will definitely make this easier on the eye, so I'll do that.
I don't think I need the 'ifdef' though.

> > +{
> 
> We might add
> 
> if (pgtable_l4_enabled())
>     pgdp = &pgd;
> 
> here to preserve the existing 'lockless' behavior when PUDs are not
> folded.

The code still needs to be 'lockless' for the 5-level case, so I don't
think this is necessary. Yes, we'll load the same entry multiple times,
but it should be fine because they're in the context of a different
(albeit folded) level.

> > +       return p4d_offset(pgdp, addr);
> > +}
> > +#define p4d_offset_lockless p4d_offset_lockless
> > +
> >  #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
> >
> 
> I suggest we also add something like the below so we can catch these
> issues more easily
> 
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -874,9 +874,26 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
> 
>  static inline pud_t *p4d_to_folded_pud(p4d_t *p4dp, unsigned long addr)
>  {
> +       /*
> +        * The transformation below does not work correctly for descriptors
> +        * copied to the stack.
> +        */
> +       VM_WARN_ON((u64)p4dp >= VMALLOC_START && !__is_kernel((u64)p4dp));

Hmm, this is a bit coarse. Does it work properly with the fixmap?

Will

