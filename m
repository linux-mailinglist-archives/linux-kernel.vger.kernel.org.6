Return-Path: <linux-kernel+bounces-397682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DD9BDEF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8A51F24792
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AC1922EA;
	Wed,  6 Nov 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="litT7fQY"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D2824A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875371; cv=none; b=Urrvax48QUE79HBVMOpOvL2Ep54e1y/aG9PIn0T6jXVJNjko4GOEKjMzZW+SwAELFwMvT2IIvMIkLElrGf0eK8ZJloXjuu3L0T1I+7LlY/zd8DgG99jw2rtF9Cnn/ZCdw3ZYQ7QMfCfev7YYviKdrImG8lwEp1RW4yMJk2FfCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875371; c=relaxed/simple;
	bh=BCmoA51UnJ3v1QDifMWJ+fG8jUeQoUjiYfVYtpSPBzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByS4fGM+eqVmK3zj0DMkusc6vVNn/KjzjN07n2dUndz99Sjc0MLd+DtuVXv0HmuX6BJgRqH/bHI8Fz7EM2jQ5h5L4Upj9EmTTHYB1mVEPMKXJds8DI4sn+NIe05RSi5k5iYDiMVLQpv8mqiQLZcFTLxw/QgosITMk5w7Q3uY/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=litT7fQY; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc5b4190eso3326747eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730875369; x=1731480169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uqgfmWFtUO+Dj0gj/ZDZ55DmLFvVvhQMks2xq0jpGBY=;
        b=litT7fQYPxhyAnjE/3HUrBLXCaosSmgejIoO8wo9JgrG6nuDoppRnTp7QsRI0g6PuR
         xF+5y72+M0SXYSez/u7lpmUTaXwEEWqO/g45WSoKuTYJS0ot0IrHx+yFs2izOsodgFKS
         bSBZ0NsO9ZSwz1Du7F69RDX1N6m4W5rgzTvou4QQeXG0/0dcNbeNh89oUxUe6mDZk8FC
         HPqrft5SjBGcTltb7H1SN3miglhsz74qFNsATNL4CK9z6u18APUpLyx3FJN8+hrg9SPR
         drBS5bXLRQliZ5hnfdnMBV7mgFd9BrjDb+2jp3GXPu9FKxYhZsISRGcj44pktp10hLnD
         RcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730875369; x=1731480169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqgfmWFtUO+Dj0gj/ZDZ55DmLFvVvhQMks2xq0jpGBY=;
        b=OBSubW62E/WXf57iAgGODg8OajI8kHjIlf3H8H/oBUyCDabW/bsxgK31ZI5bSeGYGG
         9d4ugSIWlYh7TWtPKvCt1YIZOGs/PGoFLkncprtpBQMeTNUgZV4zi/oAdYccp6EMJiPT
         Jfq0BuEhcc5u3GAK5ySxCERavxH3s25cGtwYHErDl4c7+FZ2bE+U6lynsmEQW311/Ipo
         Jb8/AxICeRZ+1iemDqP9kB0qvvGy+BJKPUtDFJFNMVnD2+jzqGMrlPDbxMltLUd94DDy
         cIl7+vxHsMGpgWzUsq59vSE2mm1toeTVUdYMX3w0Mmkx6aEKRkItltIIHm53NsmY1eUx
         FeUg==
X-Forwarded-Encrypted: i=1; AJvYcCWgiKM7AA4xm8qtOCInAWoaBnbLh3JlnWE2/w0KWZ+S+tORKDDp891Y/fTQmlBQT5f/utavCUovWe0F9so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sIQrfflTiVhQiS3aCVdnkERBTMOjF53h9+qd28JQSGpkH5yr
	hsc7uPSw9mwFdbXUtxg4ote7U82MWWqPB7JMWQnlOvavG+u2r9vN8KGlgY+ZPym+WIWCZ/3+r0/
	+Q3E+G1aYgiNgnwKIfImtVW8+xSM=
X-Google-Smtp-Source: AGHT+IF+OP1m6N2NRlqRxXPcdnpiGaljyJNWNJD2jmlHRQgxL/lDCGN6jKQkAkmz62i3TD8F4sCz7tm/c47DwTPJhpg=
X-Received: by 2002:a05:6820:1689:b0:5eb:c72e:e29b with SMTP id
 006d021491bc7-5ec6dbd8ff8mr12733521eaf.7.1730875368731; Tue, 05 Nov 2024
 22:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn> <c4fbc62f-e398-1229-c1b1-7bab30e4460e@huawei.com>
 <CAAfSe-vDtJKeSeUgpeJM0ZQe4XKdKz_Rgz2TQkPb4giPBLsOdw@mail.gmail.com> <d1a84096-9722-47f1-ad8e-671144a3d109@ghiti.fr>
In-Reply-To: <d1a84096-9722-47f1-ad8e-671144a3d109@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 6 Nov 2024 14:42:12 +0800
Message-ID: <CAAfSe-vidGeJVvqhdNrP7iv+ShYocseQ1PFkfaJ33ZFmjghgVQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V4 2/3] riscv: mm: Add soft-dirty page tracking support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Chunyan Zhang <zhangchunyan@iscas.ac.cn>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Tue, 5 Nov 2024 at 21:14, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On 30/08/2024 04:31, Chunyan Zhang wrote:
> > Hi Jinjie,
> >
> > On Fri, 30 Aug 2024 at 09:31, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>
> >>
> >> On 2024/8/30 9:11, Chunyan Zhang wrote:
> >>> The PTE bit(9) is reserved for software, now used by DEVMAP,
> >>> this patch reuse bit(9) for soft-dirty which is enabled only
> >>> if !CONFIG_ARCH_HAS_PTE_DEVMAP, in other words, soft-dirty
> >>> and devmap will be mutually exclusive on RISC-V.
> >>>
> >>> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> >>> available for swap PTEs on RISC-V systems.
> >>>
> >>> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> >>> ---
> >>>   arch/riscv/Kconfig                    | 27 ++++++++++-
> >>>   arch/riscv/include/asm/pgtable-bits.h | 12 +++++
> >>>   arch/riscv/include/asm/pgtable.h      | 69 ++++++++++++++++++++++++++-
> >>>   3 files changed, 106 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index 0f3cd7c3a436..f1460fc01cd4 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -39,7 +39,6 @@ config RISCV
> >>>        select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >>>        select ARCH_HAS_PMEM_API
> >>>        select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> >>> -     select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
> >>>        select ARCH_HAS_PTE_SPECIAL
> >>>        select ARCH_HAS_SET_DIRECT_MAP if MMU
> >>>        select ARCH_HAS_SET_MEMORY if MMU
> >>> @@ -948,6 +947,32 @@ config RANDOMIZE_BASE
> >>>
> >>>             If unsure, say N.
> >>>
> >>> +choice
> >>> +     prompt "PET RSW Bit(9) used for"
> >>> +     default RISCV_HAS_PTE_DEVMEP
> >>> +     depends on MMU && 64BIT
> >>> +     help
> >>> +       RISC-V PTE bit(9) is reserved for software, and used by more than
> >>> +       one kernel features which cannot be supported at the same time.
> >>> +       So we have to select one for it.
> >>> +
> >>> +config RISCV_HAS_PTE_DEVMEP
> >>> +     bool "DEVMAP mark"
> >>> +     select ARCH_HAS_PTE_DEVMAP
> >>> +     help
> >>> +       The PTE bit(9) is used for DEVMAP mark. ZONE_DEVICE pages need DEVMAP
> >>> +       PTEs support to function.
> >>> +
> >>> +       So if you want to use ZONE_DEVICE, select this.
> >>> +
> >>> +config RISCV_HAS_SOFT_DIRTY
> >>> +     bool "soft dirty"
> >>> +     select HAVE_ARCH_SOFT_DIRTY
> >>> +     help
> >>> +       The PTE bit(9) is used for soft-dirty tracking.
> >>> +
> >>> +endchoice
> >>> +
> >> Hi, ARCH_HAS_PTE_DEVMAP will be removed in following patch, I guess
> >> riscv will too:
> >>
> >> https://lore.kernel.org/all/47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com/
> > Thanks for sharing, I didn't notice this.
> > It looks like we should remove PTE_DEVMAP first and then add soft
> > dirty and uffd_wp.
>
>
> I have not seen any progress in the removal of PTE_DEVMAP so I'd say we
> should keep going with your patchset and we can still remove devmap later.

Okay, then I will update the patchset with addressing your comments.

Thanks for the review,
Chunyan


>
> Thanks,
>
> Alex
>
>
> >
> > Thanks,
> > Chunyan
> >
> >>>   endmenu # "Kernel features"
> >>>
> >>>   menu "Boot options"
> >>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> >>> index 5bcc73430829..c6d51fe9fc6f 100644
> >>> --- a/arch/riscv/include/asm/pgtable-bits.h
> >>> +++ b/arch/riscv/include/asm/pgtable-bits.h
> >>> @@ -26,6 +26,18 @@
> >>>   #define _PAGE_DEVMAP 0
> >>>   #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> >>>
> >>> +#ifdef CONFIG_MEM_SOFT_DIRTY
> >>> +#define _PAGE_SOFT_DIRTY     (1 << 9)    /* RSW: 0x2 for software dirty tracking */
> >>> +/*
> >>> + * BIT 4 is not involved into swap entry computation, so we
> >>> + * can borrow it for swap page soft-dirty tracking.
> >>> + */
> >>> +#define _PAGE_SWP_SOFT_DIRTY _PAGE_USER
> >>> +#else
> >>> +#define _PAGE_SOFT_DIRTY     0
> >>> +#define _PAGE_SWP_SOFT_DIRTY 0
> >>> +#endif /* CONFIG_MEM_SOFT_DIRTY */
> >>> +
> >>>   #define _PAGE_TABLE     _PAGE_PRESENT
> >>>
> >>>   /*
> >>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> >>> index 089f3c9f56a3..d41507919ef2 100644
> >>> --- a/arch/riscv/include/asm/pgtable.h
> >>> +++ b/arch/riscv/include/asm/pgtable.h
> >>> @@ -428,7 +428,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
> >>>
> >>>   static inline pte_t pte_mkdirty(pte_t pte)
> >>>   {
> >>> -     return __pte(pte_val(pte) | _PAGE_DIRTY);
> >>> +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> >>>   }
> >>>
> >>>   static inline pte_t pte_mkclean(pte_t pte)
> >>> @@ -461,6 +461,38 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >>>        return pte;
> >>>   }
> >>>
> >>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> >>> +static inline int pte_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return pte_val(pte) & _PAGE_SOFT_DIRTY;
> >>> +}
> >>> +
> >>> +static inline pte_t pte_mksoft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
> >>> +}
> >>> +
> >>> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) & ~(_PAGE_SOFT_DIRTY));
> >>> +}
> >>> +
> >>> +static inline int pte_swp_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
> >>> +}
> >>> +
> >>> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
> >>> +}
> >>> +
> >>> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) & ~(_PAGE_SWP_SOFT_DIRTY));
> >>> +}
> >>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
> >>> +
> >>>   #ifdef CONFIG_RISCV_ISA_SVNAPOT
> >>>   #define pte_leaf_size(pte)   (pte_napot(pte) ?                               \
> >>>                                        napot_cont_size(napot_cont_order(pte)) :\
> >>> @@ -751,6 +783,40 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> >>>        return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> >>>   }
> >>>
> >>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> >>> +static inline int pmd_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_soft_dirty(pmd_pte(pmd));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>> +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_swp_soft_dirty(pmd_pte(pmd));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> >>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
> >>> +
> >>>   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> >>>                                pmd_t *pmdp, pmd_t pmd)
> >>>   {
> >>> @@ -841,6 +907,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> >>>    * Format of swap PTE:
> >>>    *   bit            0:       _PAGE_PRESENT (zero)
> >>>    *   bit       1 to 3:       _PAGE_LEAF (zero)
> >>> + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
> >>>    *   bit            5:       _PAGE_PROT_NONE (zero)
> >>>    *   bit            6:       exclusive marker
> >>>    *   bits      7 to 11:      swap type
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

