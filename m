Return-Path: <linux-kernel+bounces-253256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2459931EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA0F1F21EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361BF9F5;
	Tue, 16 Jul 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMrZcYBP"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5CDDC0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096258; cv=none; b=Wt8M+vj2p4NnRo/er+PHvaGNCrFxA2c9DbXgtmOxOdnQ+tJYuAhN3hW1CJx8qqaLj7SgcCAcJqweGz+BCIkE1042zUhbAcLdDnrCBiwx2AgLGlXPvGHHZ8TspRSHVa4NNoTtExSBkVIj4OxbtHtXj2n3HlLlbcNbB5UyN38TfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096258; c=relaxed/simple;
	bh=OoToNNHALmGJkBV57ahMlKIETKcnluRe1cAwoCY+RPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N95wsNqzLVT21euOgU2zEmBGM0bVrvzvLzw1Qeofu7mISydEYEMRZIl0mva34Xb0SbIdLsayebw3MJGwmYZfEWMzSEvRO2Lbx3eWiAWhxlHf5Mb39TPD+JUGvLGoA1Bv6Qu6SA0mGG6hSCSO1Av54Bnwd90zVLCj5pGL8ahZBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMrZcYBP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e171122fcso2179504fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721096256; x=1721701056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3qG2e5OOr0a9SDC7lHn4BFqHyo95FcZxWbDfNRVBACI=;
        b=ZMrZcYBPrCxSrJCEGB4tFN0UMT2pxKjGcN4+ftlpRFf2hLAYSgrT3WuG/wsWSkKrKy
         fBxqA0nvpO3aBdrACUKT1yyJ/0F6K6S4ao3c+X5iVk2PMHQVerW5bPcvXENSzl1VUu9w
         TxMR5UUAnz6sXmWU/uR8zn3uVjNflS90Ra8R8Ie4aGZDfQRRdAzDt06TG8gtiY8DFTLf
         F80dgc2w9yLNRRbQ4FGRbGXs9xnRS6MSP3PcsZ/gvgfkDbBsrkIuOZ3//CnBTxTfHmCH
         X/5AIQIV01lSpod0DN8D9kUicsgNQ/eX//wAUNiQhlOjmrHNgWLPElh7PFiS1XU02klW
         IHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096256; x=1721701056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qG2e5OOr0a9SDC7lHn4BFqHyo95FcZxWbDfNRVBACI=;
        b=eJy37ZhVpn9Opuj2zoqo6VVqlF1knxWK5JWU2NATmVTkfDSdl4eTUXdog4HoQXYpFQ
         m3+tGQh1HBBKmKkO7ecUJQPwAksx4htTwQ0PycVmr0GSFNiqGYg1UxCCqTRp/qdBO9Pj
         dtKxwC/kjMEXbrx8qcLsxKXQBOxnndtqKFwsQlNPWE6f/8Yeh8Pu/5yDCUb6izsoOx14
         P75fqkkltI6zIUPrj+sL5RMZoso1VXIO/xpNLb0K+nNiqqlvg17KET0pAhn4pjqlwCiI
         HoXjnt/bEvVJldi02JgVKg0GQJehydQezdX2jHvutpNggXjzqKTnSKNVwYSJ5ntAnuuc
         kHLA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsMQyA+IE+Y8ND+tidRw0BWKxOnxQ+dfoP/BAVkMOg1DwTwcAx6FN9VgKaxptc5y6v9m8UkQEuvOffnfew58aGd6MRUHMJ+KIrS5y
X-Gm-Message-State: AOJu0YyLF88fDCkoIYT265xQTUxMQCMMHiEeARl3cLfScfRHwg9sQs0j
	TWT+GfEJVUYn0hZzyE+If0GUW28Ve6lHjifz71AUY+KADmYfd9O3807p3rLjKEwewAKivqzNwvr
	Meh6ajEltknHWmg3YjT/yJ44+oCBtt2F0gg5G+w==
X-Google-Smtp-Source: AGHT+IF2iQvXMWZ+A/wS21lKkIcp4ScrIAImMKmhcq0FvVKMA7n1XTY7UZQNopwH2fOnvWt5n+kBM1ZVCbdtyBlI7Y8=
X-Received: by 2002:a05:6870:9e4d:b0:25e:b74e:e1b8 with SMTP id
 586e51a60fabf-260bf388476mr234928fac.9.1721096256110; Mon, 15 Jul 2024
 19:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710033004.3923527-1-zhangchunyan@iscas.ac.cn> <9bf70f7c-5deb-4fce-b7c1-ec70d78cb5db@ghiti.fr>
In-Reply-To: <9bf70f7c-5deb-4fce-b7c1-ec70d78cb5db@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Tue, 16 Jul 2024 10:16:59 +0800
Message-ID: <CAAfSe-vhhVvP5Sa9bGGSw4ZQvexqUrjdTFjJL-4gLn0jsuk0ew@mail.gmail.com>
Subject: Re: [PATCH] riscv/mm: Add soft-dirty page tracking support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Mon, 15 Jul 2024 at 19:21, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Chunyan,
>
> On 10/07/2024 05:30, Chunyan Zhang wrote:
> > The PTE bit (9) is reserved for software, so we can use it for
> > soft-dirty tracking. This patch adds its standard handlers for
> > PTE, PMD, and swap entry.
>
>
> Unfortunately, ZONE_DEVICE has just used this last bit and should be
> merged in 6.11.

Yes, I read the patch just now.

> I'm currently discussing internally how we can get 2 other PTE bits from
> RVI in order to have the same number of available bits as x86 and arm64.

Yes I noticed that PTE bits reserved for software are too limited on RISC-V.

Besides softdirty, we probably can support uffd write-protect on
RISC-V if we will have two PTE bits for use.

> I guess that for now, if we really have a usecase for softdirty (and I
> think we do with CRIU), we'll have to make ZONE_DEVICE and soft-dirty
> mutually exclusive.

Yes, I also learned that CRIU uses soft-dirty.

> >
> > To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> > available for swap PTEs on RISC-V systems.
> >
> > This patch has been tested with the kselftest mm suite in which
> > soft-dirty and madv_populate run and pass, and no regressions
> > are observed in any of the other tests.
>
>
> Did you give CRIU a try?

I haven't tried CRIU, actually I found soft-dirty was missing on
RISC-V by the way of running mm selftest cases.

I can cook a new patch to implement soft-dirty and ZONE_DEVICE share
the PTE bit(9), and make both features mutually exclusive if this
solution is accepted.

Or not to add soft-dirty until we have more other PTE bits that can be
used for software.

I'm open to listen to suggestions.

Thanks,
Chunyan

>
> Thanks,
>
> Alex
>
>
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >   arch/riscv/Kconfig                    |  1 +
> >   arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
> >   arch/riscv/include/asm/pgtable.h      | 65 ++++++++++++++++++++++++++-
> >   3 files changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b94176e25be1..2e3ad2925a6b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -118,6 +118,7 @@ config RISCV
> >       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> >       select HAVE_ARCH_SECCOMP_FILTER
> > +     select HAVE_ARCH_SOFT_DIRTY
> >       select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >       select HAVE_ARCH_TRACEHOOK
> >       select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> > index 179bd4afece4..bab48f5fd1e2 100644
> > --- a/arch/riscv/include/asm/pgtable-bits.h
> > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > @@ -19,6 +19,19 @@
> >   #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
> >
> >   #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> > +
> > +#ifdef CONFIG_MEM_SOFT_DIRTY
> > +#define _PAGE_SOFT_DIRTY     (1 << 9)    /* RSW: 0x2 for software dirty tracking */
> > +/*
> > + * BIT 4 is not involved into swap entry computation, so we
> > + * can borrow it for swap page soft-dirty tracking.
> > + */
> > +#define _PAGE_SWP_SOFT_DIRTY _PAGE_USER
> > +#else
> > +#define _PAGE_SOFT_DIRTY     0
> > +#define _PAGE_SWP_SOFT_DIRTY 0
> > +#endif /* CONFIG_MEM_SOFT_DIRTY */
> > +
> >   #define _PAGE_TABLE     _PAGE_PRESENT
> >
> >   /*
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index aad8b8ca51f1..46f512f52580 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -408,7 +408,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
> >
> >   static inline pte_t pte_mkdirty(pte_t pte)
> >   {
> > -     return __pte(pte_val(pte) | _PAGE_DIRTY);
> > +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> >   }
> >
> >   static inline pte_t pte_mkclean(pte_t pte)
> > @@ -436,6 +436,36 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >       return pte;
> >   }
> >
> > +static inline int pte_soft_dirty(pte_t pte)
> > +{
> > +     return pte_val(pte) & _PAGE_SOFT_DIRTY;
> > +}
> > +
> > +static inline pte_t pte_mksoft_dirty(pte_t pte)
> > +{
> > +     return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
> > +}
> > +
> > +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> > +{
> > +     return __pte(pte_val(pte) & ~(_PAGE_SOFT_DIRTY));
> > +}
> > +
> > +static inline int pte_swp_soft_dirty(pte_t pte)
> > +{
> > +     return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
> > +}
> > +
> > +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> > +{
> > +     return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
> > +}
> > +
> > +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> > +{
> > +     return __pte(pte_val(pte) & ~(_PAGE_SWP_SOFT_DIRTY));
> > +}
> > +
> >   #ifdef CONFIG_RISCV_ISA_SVNAPOT
> >   #define pte_leaf_size(pte)  (pte_napot(pte) ?                               \
> >                                       napot_cont_size(napot_cont_order(pte)) :\
> > @@ -721,6 +751,38 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
> >       return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
> >   }
> >
> > +static inline int pmd_soft_dirty(pmd_t pmd)
> > +{
> > +     return pte_soft_dirty(pmd_pte(pmd));
> > +}
> > +
> > +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> > +{
> > +     return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> > +}
> > +
> > +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> > +{
> > +     return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> > +}
> > +
> > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> > +{
> > +     return pte_swp_soft_dirty(pmd_pte(pmd));
> > +}
> > +
> > +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> > +{
> > +     return pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)));
> > +}
> > +
> > +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> > +{
> > +     return pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)));
> > +}
> > +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> > +
> >   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> >                               pmd_t *pmdp, pmd_t pmd)
> >   {
> > @@ -811,6 +873,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> >    * Format of swap PTE:
> >    *  bit            0:       _PAGE_PRESENT (zero)
> >    *  bit       1 to 3:       _PAGE_LEAF (zero)
> > + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
> >    *  bit            5:       _PAGE_PROT_NONE (zero)
> >    *  bit            6:       exclusive marker
> >    *  bits      7 to 11:      swap type

