Return-Path: <linux-kernel+bounces-397681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C619BDEF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1B2843DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A01922F9;
	Wed,  6 Nov 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDZ+GVcK"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF0824A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875314; cv=none; b=RjkWqz88GdG0LNe+2yzU8JM9fpzaq0idZsv9siSJZxBszNdNGSRKv+YNhQM/Dk9srTlmbkAysgDIo+02/YfO3ozL1Lv1hacnvCubWWwnphACRycS18ydk3uhkgar1xJp0qIuD5PM34iNpcwywj8PgwwsJKcCjVYI4ZWwk1s+N0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875314; c=relaxed/simple;
	bh=lOE35RVTIto5A8zD6I0KZuMgDjtvLWbDwSaky862M28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djXoiqJjteVLm57NuoGd2vVaEHACy3fsf3oA623W46Jdfrs4Pe6AP3a9oDA5Z010lyul6baT293xp9H+VBs90iOQpceqa5l/+yTJ0d87sweUR68zKbKGMWcOC9xrm9wQxiPabne09lu7p7dn7z6O9ZdCP4Op7YSsG19OxSrp73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDZ+GVcK; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc22e6362so2971722eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730875312; x=1731480112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwfjbaQj0C7OoPelXON1Odzj9eUCq/W/+YYPFoCA8v8=;
        b=WDZ+GVcKj9Qd+XibpRZLduAvUPNYNB2JsrzmvWsuKGTVb84Fn+Ba00BKDjUWum/ISX
         qcaqYohJBQwVIS9Xlfvq72FBgdUDdYMERPfnNbbdLCdtS0l1fSoarVUmJklfSBBMk1mW
         H63GN7QTeI68zx11wtlgLMpXpohlqPGLnym4Ya/2RFCTnxQQGWeMi6edE1vSOZx2Qmfy
         tdV2OZbPXJbFadNP/NZHxXHaepHK+a4vyORKzxgoR1SitbY3nBZlaOalhLahetj+HBSx
         JLv4IToIL42WOqpXqtnH2SuKGfRKCWALoefBBhzL8HYwSuJg7AP2RsLXCQxCLPw67hQM
         Jjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730875312; x=1731480112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwfjbaQj0C7OoPelXON1Odzj9eUCq/W/+YYPFoCA8v8=;
        b=kYu3gE961RmoH4iE6fKA+3kmQPUTZBH2biHfY65B5Rknl944ATVRbkla1ULAA1pxk3
         BTqoaaS6QdK+QFaKI+sdawBZs7FSxoeNJdQ/0r/m/hJburuBRbYZ135EXkNCHwGyxgtj
         1Bo3IMTbLads+bOgYLJGF9QVe7YovOuBWkbM+Ta72PB0EsoH93eJFO4Uy3yGH3HJWvYX
         ok3t5H4nZO6X4QENkTky79NVeCG8qocaD18Dns+qYaPCdM6W6I7to69JSi8KgzxvAEYr
         77LKgU8YOHhN0x97cKdWna/S3hxkkM++APeSada9mZIW3MGxoMj+Sh4HKQzkfcfyp6qw
         OqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsWFu4chO0fnGe7sXm3VGdk3ugs8th8mGuSw9KHW0M73u4v/VcYy1hJdoKKBQH6nxXd1eF5iY4dJ9m0U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+S7t2S9YL3AOcRPTCiLVSlKY/6pZXlKMiBA//uFtsU1dbqa8
	SmZG1rhgQmhoZ6WQy1+YmHZgAb3f5SwgR0qVzWXTM62RuD9H2EUfFwp1HlqtWmi2T/UZ6KopPKY
	Suy3dNwYuczNRoIdwWGcUDwJWTKI=
X-Google-Smtp-Source: AGHT+IHpYlfDI//yEEbA3IrsO0gyODwzS+9567kfgG5iImiDVNudXOqoY50MdBNL9wmX6Ry7CEMu0dA/Hf8P/3G5txw=
X-Received: by 2002:a05:6820:1b94:b0:5ec:5eb6:1acc with SMTP id
 006d021491bc7-5ec6db9a003mr13142561eaf.5.1730875311818; Tue, 05 Nov 2024
 22:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn> <97898777-8129-4ce9-8ae4-9d4bbc2a5a26@ghiti.fr>
In-Reply-To: <97898777-8129-4ce9-8ae4-9d4bbc2a5a26@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 6 Nov 2024 14:41:15 +0800
Message-ID: <CAAfSe-tN8OwPfq+7OJ-QZmPKnu6_YO3J+bR5R8HWENMA-n-J9A@mail.gmail.com>
Subject: Re: [RESEND PATCH V4 2/3] riscv: mm: Add soft-dirty page tracking support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 21:13, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On 30/08/2024 03:11, Chunyan Zhang wrote:
> > The PTE bit(9) is reserved for software, now used by DEVMAP,
> > this patch reuse bit(9) for soft-dirty which is enabled only
>
>
> s/reuse/reuses
>
>
> > if !CONFIG_ARCH_HAS_PTE_DEVMAP, in other words, soft-dirty
> > and devmap will be mutually exclusive on RISC-V.
> >
> > To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> > available for swap PTEs on RISC-V systems.
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >   arch/riscv/Kconfig                    | 27 ++++++++++-
> >   arch/riscv/include/asm/pgtable-bits.h | 12 +++++
> >   arch/riscv/include/asm/pgtable.h      | 69 ++++++++++++++++++++++++++-
> >   3 files changed, 106 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0f3cd7c3a436..f1460fc01cd4 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -39,7 +39,6 @@ config RISCV
> >       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >       select ARCH_HAS_PMEM_API
> >       select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> > -     select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
> >       select ARCH_HAS_PTE_SPECIAL
> >       select ARCH_HAS_SET_DIRECT_MAP if MMU
> >       select ARCH_HAS_SET_MEMORY if MMU
> > @@ -948,6 +947,32 @@ config RANDOMIZE_BASE
> >
> >             If unsure, say N.
> >
> > +choice
> > +     prompt "PET RSW Bit(9) used for"
>
>
> I would say: "PTE RSW bit(9) usage"
>
>
> > +     default RISCV_HAS_PTE_DEVMEP
>
>
> s/DEVMEP/DEVMAP
>
>
> > +     depends on MMU && 64BIT
> > +     help
> > +       RISC-V PTE bit(9) is reserved for software, and used by more than
> > +       one kernel features which cannot be supported at the same time.
>
>
> s/features/feature
>
>
> > +       So we have to select one for it.
> > +
> > +config RISCV_HAS_PTE_DEVMEP
> > +     bool "DEVMAP mark"
>
>
> I would say simply "devmap"

Ok, only "devmap" without the following "mark", right?

>
>
> > +     select ARCH_HAS_PTE_DEVMAP
> > +     help
> > +       The PTE bit(9) is used for DEVMAP mark. ZONE_DEVICE pages need DEVMAP
>
>
> "is used for devmap...pages need devmap"
>
>
> > +       PTEs support to function.
> > +
> > +       So if you want to use ZONE_DEVICE, select this.
> > +
> > +config RISCV_HAS_SOFT_DIRTY
> > +     bool "soft dirty"
>
>
> s/soft dirty/soft-dirty
>
>
> > +     select HAVE_ARCH_SOFT_DIRTY
> > +     help
> > +       The PTE bit(9) is used for soft-dirty tracking.
> > +
> > +endchoice
> > +
> >   endmenu # "Kernel features"
> >
> >   menu "Boot options"
> > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> > index 5bcc73430829..c6d51fe9fc6f 100644
> > --- a/arch/riscv/include/asm/pgtable-bits.h
> > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > @@ -26,6 +26,18 @@
> >   #define _PAGE_DEVMAP        0
> >   #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> >
> > +#ifdef CONFIG_MEM_SOFT_DIRTY
>
>
> For consistency with CONFIG_ARCH_HAS_PTE_DEVMAP, I would use
> CONFIG_HAVE_ARCH_SOFT_DIRTY

CONFIG_MEM_SOFT_DIRTY is not equal to the CONFIG_HAVE_ARCH_SOFT_DIRTY,
 the latter is one of its dependencies.

If CONFIG_HAVE_ARCH_SOFT_DIRTY  is selected, but CONFIG_MEM_SOFT_DIRTY
is not, the bit(9) should not be set/cleared by pte soft_dirty APIs?

Also considering x86 is using CONFIG_MEM_SOFT_DIRTY here, should we
keep the same?

>
>
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
>
>
> Same here.
>
>
> > +
> >   #define _PAGE_TABLE     _PAGE_PRESENT
> >
> >   /*
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 089f3c9f56a3..d41507919ef2 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -428,7 +428,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
> >
> >   static inline pte_t pte_mkdirty(pte_t pte)
> >   {
> > -     return __pte(pte_val(pte) | _PAGE_DIRTY);
> > +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> >   }
> >
> >   static inline pte_t pte_mkclean(pte_t pte)
> > @@ -461,6 +461,38 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >       return pte;
> >   }
> >
> > +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
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
> > +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
> > +
> >   #ifdef CONFIG_RISCV_ISA_SVNAPOT
> >   #define pte_leaf_size(pte)  (pte_napot(pte) ?                               \
> >                                       napot_cont_size(napot_cont_order(pte)) :\
> > @@ -751,6 +783,40 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> >       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> >   }
> >
> > +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
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
> > +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
> > +
> >   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> >                               pmd_t *pmdp, pmd_t pmd)
> >   {
> > @@ -841,6 +907,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> >    * Format of swap PTE:
> >    *  bit            0:       _PAGE_PRESENT (zero)
> >    *  bit       1 to 3:       _PAGE_LEAF (zero)
> > + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
> >    *  bit            5:       _PAGE_PROT_NONE (zero)
> >    *  bit            6:       exclusive marker
> >    *  bits      7 to 11:      swap type
>
>
> Apart from the minor things above, the rest looks good so you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the review,
Chunyan

