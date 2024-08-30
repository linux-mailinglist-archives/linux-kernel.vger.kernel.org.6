Return-Path: <linux-kernel+bounces-307942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06835965542
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B271D282D84
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79A55C29;
	Fri, 30 Aug 2024 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEjmObX4"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCF29CA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985154; cv=none; b=T79H58c+adz1MAbfJaGVAB6bH+84jrdkpr/At/ggVRwSYEx35a116nw+BRaLS085opRg+yzbtOTxrdchMnzHm7/3KuKw82DKEnL28PPRMrFoHe19m4EY9QNNbfAuVWbiKPWoR6/NBeCCl9uxzeQqxNDW+MXF8vmoGJgcNR0lxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985154; c=relaxed/simple;
	bh=I8PwBL0yWJ3OA2kkz8NKRY6auJfmwDwOasuoDQAn66U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukh0jja+GG0BCV1RGcNQSyci9lMtbGRHH6+oE+3095M6oapJ0OD7LO2JENwIFM5M+nBkJ9qJlsursecsSjNphPBb7EwWjDOQMB8i1M2ggcy09R/l6NHi4FyINzz3/jxB9yzCnOAGhj7PQqZ7j555fIhhW5B8iv9K6fwH0nUw7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEjmObX4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5dfabdbef52so269938eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724985151; x=1725589951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8H1XHGk6DBwD7+T/dz3bKwogv4tRlivx16JZ0iTQKkc=;
        b=QEjmObX4oY9WQAWEhz+ZLPenMsAhJm3MYJ2AdyT081KDr0Shb0lSRyYAD8GdB0VqBP
         IW5TgEK1Nn1dVDEBdmGdKlgXtH/EelDD1ppf5kjgfqcpCzDuG6fiIc31lBqvl3YU3F49
         bQaiGjdWfHMTxNxzk/1BQViRwilDB/2fFF84/oBZ07ZSTBgd7aaXRQUGJGwbEQ4E6GOV
         co2tSCPU2kfOk+M9qptimvVqhBoYELXWl0ADcO24HNZw3z3OfZW2y3gUZuPThWGi05RT
         YR8W3snEP3bI3JeN9cU+vqnq5OoJrEfhYvGdKykd1Z/wC+5FiyobCE7Y19/n9F8fB3lX
         NmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985151; x=1725589951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H1XHGk6DBwD7+T/dz3bKwogv4tRlivx16JZ0iTQKkc=;
        b=aEs1jzzSX5HtYGnVBYWhcTS3csCo8idjZrJL0ejzyGoBSuudK+ZTJbu4DFu2KgRj3X
         l63uS7IUolztc/KhzcJOxoR8fpsgREN7Dt1f4PfzFgXvyJTb+SjpACsM4i+jHtIzb0NK
         cQfFrtFh5s6ZlVLXrUSlyyeCa+fUYYJO5eSwrfQDKZJGdsBPqxWe67zjGVyfIIblUILL
         P3XDRzWAtRRJ/x6xhdIepmRzqnVh9O+quvBg4lA6r3ird71d/NqRRRDyfA6NphfMpHrg
         GShnvnT9o0dZC6xn8mrciGFrp6Y8vAUCjbf3eyYDNrzvvrf9yWvw9b3XNZDcgfwfR7qu
         pZJA==
X-Forwarded-Encrypted: i=1; AJvYcCUenegythHE3ZWaRJVtuwmqD+p/psGPoQv5oif8NlSoNyL5KtBw32RJvec2hRn4mDqQdchWz2MeMxANWdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUuOFkrGxUKgncZdFYI5CqfKtus8NACcGLJvhejVJCdGncgYJs
	dyzARekzTdPFn4p27PjipHHlOg3Zlgh02L5nnCxfZZYOu5oTcvbH3D0qQsiekEfeC11Z7Ovdfh+
	jL+crnjhItakl4KhNIShYCXz90qc=
X-Google-Smtp-Source: AGHT+IG8QUAZe6FQPfgmdw29iRX8njvTaGMPS6R3Mhi8SJu5yaKKeoLIn6geS9QQmmHtsViMhYKdAm/xAmLsBTG1FyI=
X-Received: by 2002:a05:687c:2c59:b0:260:ffaf:8126 with SMTP id
 586e51a60fabf-27790080e78mr4545688fac.9.1724985151524; Thu, 29 Aug 2024
 19:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-3-zhangchunyan@iscas.ac.cn> <c4fbc62f-e398-1229-c1b1-7bab30e4460e@huawei.com>
In-Reply-To: <c4fbc62f-e398-1229-c1b1-7bab30e4460e@huawei.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 30 Aug 2024 10:31:55 +0800
Message-ID: <CAAfSe-vDtJKeSeUgpeJM0ZQe4XKdKz_Rgz2TQkPb4giPBLsOdw@mail.gmail.com>
Subject: Re: [RESEND PATCH V4 2/3] riscv: mm: Add soft-dirty page tracking support
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jinjie,

On Fri, 30 Aug 2024 at 09:31, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/8/30 9:11, Chunyan Zhang wrote:
> > The PTE bit(9) is reserved for software, now used by DEVMAP,
> > this patch reuse bit(9) for soft-dirty which is enabled only
> > if !CONFIG_ARCH_HAS_PTE_DEVMAP, in other words, soft-dirty
> > and devmap will be mutually exclusive on RISC-V.
> >
> > To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> > available for swap PTEs on RISC-V systems.
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >  arch/riscv/Kconfig                    | 27 ++++++++++-
> >  arch/riscv/include/asm/pgtable-bits.h | 12 +++++
> >  arch/riscv/include/asm/pgtable.h      | 69 ++++++++++++++++++++++++++-
> >  3 files changed, 106 insertions(+), 2 deletions(-)
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
> >            If unsure, say N.
> >
> > +choice
> > +     prompt "PET RSW Bit(9) used for"
> > +     default RISCV_HAS_PTE_DEVMEP
> > +     depends on MMU && 64BIT
> > +     help
> > +       RISC-V PTE bit(9) is reserved for software, and used by more than
> > +       one kernel features which cannot be supported at the same time.
> > +       So we have to select one for it.
> > +
> > +config RISCV_HAS_PTE_DEVMEP
> > +     bool "DEVMAP mark"
> > +     select ARCH_HAS_PTE_DEVMAP
> > +     help
> > +       The PTE bit(9) is used for DEVMAP mark. ZONE_DEVICE pages need DEVMAP
> > +       PTEs support to function.
> > +
> > +       So if you want to use ZONE_DEVICE, select this.
> > +
> > +config RISCV_HAS_SOFT_DIRTY
> > +     bool "soft dirty"
> > +     select HAVE_ARCH_SOFT_DIRTY
> > +     help
> > +       The PTE bit(9) is used for soft-dirty tracking.
> > +
> > +endchoice
> > +
>
> Hi, ARCH_HAS_PTE_DEVMAP will be removed in following patch, I guess
> riscv will too:
>
> https://lore.kernel.org/all/47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com/

Thanks for sharing, I didn't notice this.
It looks like we should remove PTE_DEVMAP first and then add soft
dirty and uffd_wp.

Thanks,
Chunyan

>
> >  endmenu # "Kernel features"
> >
> >  menu "Boot options"
> > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> > index 5bcc73430829..c6d51fe9fc6f 100644
> > --- a/arch/riscv/include/asm/pgtable-bits.h
> > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > @@ -26,6 +26,18 @@
> >  #define _PAGE_DEVMAP 0
> >  #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> >
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
> >  #define _PAGE_TABLE     _PAGE_PRESENT
> >
> >  /*
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 089f3c9f56a3..d41507919ef2 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -428,7 +428,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
> >
> >  static inline pte_t pte_mkdirty(pte_t pte)
> >  {
> > -     return __pte(pte_val(pte) | _PAGE_DIRTY);
> > +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> >  }
> >
> >  static inline pte_t pte_mkclean(pte_t pte)
> > @@ -461,6 +461,38 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >       return pte;
> >  }
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
> >  #ifdef CONFIG_RISCV_ISA_SVNAPOT
> >  #define pte_leaf_size(pte)   (pte_napot(pte) ?                               \
> >                                       napot_cont_size(napot_cont_order(pte)) :\
> > @@ -751,6 +783,40 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> >       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> >  }
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
> >  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> >                               pmd_t *pmdp, pmd_t pmd)
> >  {
> > @@ -841,6 +907,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> >   * Format of swap PTE:
> >   *   bit            0:       _PAGE_PRESENT (zero)
> >   *   bit       1 to 3:       _PAGE_LEAF (zero)
> > + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
> >   *   bit            5:       _PAGE_PROT_NONE (zero)
> >   *   bit            6:       exclusive marker
> >   *   bits      7 to 11:      swap type

