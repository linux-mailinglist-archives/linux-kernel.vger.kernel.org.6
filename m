Return-Path: <linux-kernel+bounces-177609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C6D8C4173
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017C0B2359A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE511514D0;
	Mon, 13 May 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oIWNTRP8"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2011509A7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605770; cv=none; b=A0dY/bpVQB2d3hYtVwR+7jZJYpCslM07fRmvathvLJs3XjwBOLZTE1bCjEqPuALF3F70FbkGqXApjKcHEk/+BSUL4BXfKGeTwsdWkYkG8v0rDv5rVUQJ6I7ytC25Jlf4F0wrjv6sPXJFMGYYlpvf/fyLZan+yi6X2CfUKHcxCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605770; c=relaxed/simple;
	bh=zpZGnwRw0RonuhIC/M2/86imsc5RbcnkegqTXx4M9uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqJSX2mcQJj3zM1ACbHZFjmP4umLwl22M2TzmOdzPwlg8D8DNIjlWLjdhX1vo0FQT17h7gYtlqkNpx3LIrq+/a9vQg9FZV+obONzPeTBEYZX/oWALhURIUzJNG8jXJRYnTihp2zg2YRgm/O2fhA8vtUOiGb/K61IkF1sJlJn+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oIWNTRP8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so918761766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715605767; x=1716210567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MKXjMChMNLDQEAHfT5KxNeT5FU7Py9gH+YOnRbraDE=;
        b=oIWNTRP8SAX0NgR/uD+TIJzKATCaaMFzSHJ+PA7E8BLMewYu3rxPP49ebk9L0A5CN0
         xBVOMnjSiKqfsCXXVHbPIPskRV/Zyuj7y+P7uViP4linF+aDvfrEveEhj3HbE1ChGtoQ
         thiDKPrb6OoUw/bvxZfreqsiskOKai9vIiZ+E/fs/w3p43Uyc+2sV4YAnZ4MkKaPfU7q
         weQV34JkQCcHq8DAbTsuRw/J5YTnuT1FFGLXbeiz5D2jxGQCyHn5F4WNxFGbQ9qncg2R
         2v5iOUH6qcD2jspHpO7y4+yyHhMIMUyLsOiWqXWYGLSOp8odBBGc55Trcyhym/YaLC0f
         DCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715605767; x=1716210567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MKXjMChMNLDQEAHfT5KxNeT5FU7Py9gH+YOnRbraDE=;
        b=wBBVv2DJMoLEflnwaYZ+1dKwHNPbaSunPUUjJuyhQTXYCZsNcQj5OJCjOp1YHsrthH
         BsUXG37p2ZnE6tGDRndgxf2m5OtBRMry8f3HWU1yPEBo69JoJumcIar7gKtTq8Z6XLYL
         PFIZ4hY5n8NiglAXBtJSKQEFJelFE4jwE53vUsyJX7T/syFe0jCoPlIHv5izLqUQ8e3K
         Jvl25qypEcbnIbJ+I7oT3piY85CNvkbiBtLqCwDG/vvyycqLtzcexBDA+vTHNIns/un6
         TFHfZQWIJjd/52MwDalYy/abLXGLmayWtqOAtlUqqomQAmBqIZGms3rrYiW+mbJbUJT2
         Q+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqiEYWMGJirWeuKNoH4cd+aE/gitSdH4Rfo9yHsTAUtSfWNHlc0JULj1HrMVmbiS0V2+H3HKDRD60HVb3RrJmavDUkqTadkSNu5gDt
X-Gm-Message-State: AOJu0Ywla1najzoMVCrupa2xkeTlwkPU8DerZTtH3fxTEOF2eht3E8dr
	cBFGTnSM0P5eXlotTKCDnHmWMEfuE29Q1NFDVpcAvv+Jd9fHtCJtwWUoxesZUouwc+clZWZygmS
	aQOohDCfuqVnrnvtqTVZf7Qi/AEwLpSlk4PDcRw==
X-Google-Smtp-Source: AGHT+IE2QlkBf1B/qIqHvwWeBSEoU1R5RwhfvNE59sMHl2qimtxCkyusw1APubthP2zoyId5MUd15f47oIJVMuD1t0A=
X-Received: by 2002:a17:906:ca8e:b0:a5a:7b88:8672 with SMTP id
 a640c23a62f3a-a5a7b888747mr3863166b.16.1715605766892; Mon, 13 May 2024
 06:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508191931.46060-1-alexghiti@rivosinc.com>
 <20240508191931.46060-2-alexghiti@rivosinc.com> <CAGsJ_4xayC4D4y0d7SPXxCvuW4-rJQUCa_-OUDSsOGm_HyPm1w@mail.gmail.com>
In-Reply-To: <CAGsJ_4xayC4D4y0d7SPXxCvuW4-rJQUCa_-OUDSsOGm_HyPm1w@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 13 May 2024 15:09:15 +0200
Message-ID: <CAHVXubiOo3oe0=-qU2kBaFXebPJvmnc+-1UOPEHS2spcCeMzsw@mail.gmail.com>
Subject: Re: [PATCH 01/12] mm, arm64: Rename ARM64_CONTPTE to THP_CONTPTE
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ard Biesheuvel <ardb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

On Thu, May 9, 2024 at 2:46=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, May 9, 2024 at 7:20=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > The ARM64_CONTPTE config represents the capability to transparently use
> > contpte mappings for THP userspace mappings, which will be implemented
> > in the next commits for riscv, so make this config more generic and mov=
e
> > it to mm.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/arm64/Kconfig               | 9 ---------
> >  arch/arm64/include/asm/pgtable.h | 6 +++---
> >  arch/arm64/mm/Makefile           | 2 +-
> >  mm/Kconfig                       | 9 +++++++++
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index ac2f6d906cc3..9d823015b4e5 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -2227,15 +2227,6 @@ config UNWIND_PATCH_PAC_INTO_SCS
> >         select UNWIND_TABLES
> >         select DYNAMIC_SCS
> >
> > -config ARM64_CONTPTE
> > -       bool "Contiguous PTE mappings for user memory" if EXPERT
> > -       depends on TRANSPARENT_HUGEPAGE
> > -       default y
> > -       help
> > -         When enabled, user mappings are configured using the PTE cont=
iguous
> > -         bit, for any mappings that meet the size and alignment requir=
ements.
> > -         This reduces TLB pressure and improves performance.
> > -
> >  endmenu # "Kernel Features"
> >
> >  menu "Boot options"
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 7c2938cb70b9..1758ce71fae9 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1369,7 +1369,7 @@ extern void ptep_modify_prot_commit(struct vm_are=
a_struct *vma,
> >                                     unsigned long addr, pte_t *ptep,
> >                                     pte_t old_pte, pte_t new_pte);
> >
> > -#ifdef CONFIG_ARM64_CONTPTE
> > +#ifdef CONFIG_THP_CONTPTE
>
> Is it necessarily THP? can't be hugetlb or others? I feel THP_CONTPTE
> isn't a good name.

This does not target hugetlbfs (see my other patchset for that here
https://lore.kernel.org/linux-riscv/7504a525-8211-48b3-becb-a6e838c1b42e@ar=
m.com/T/#m57d273d680fc531b3aa1074e6f8558a52ba5badc).

What could be "others" here?

Thanks for your comment,

Alex

>
> >
> >  /*
> >   * The contpte APIs are used to transparently manage the contiguous bi=
t in ptes
> > @@ -1622,7 +1622,7 @@ static inline int ptep_set_access_flags(struct vm=
_area_struct *vma,
> >         return contpte_ptep_set_access_flags(vma, addr, ptep, entry, di=
rty);
> >  }
> >
> > -#else /* CONFIG_ARM64_CONTPTE */
> > +#else /* CONFIG_THP_CONTPTE */
> >
> >  #define ptep_get                               __ptep_get
> >  #define set_pte                                        __set_pte
> > @@ -1642,7 +1642,7 @@ static inline int ptep_set_access_flags(struct vm=
_area_struct *vma,
> >  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> >  #define ptep_set_access_flags                  __ptep_set_access_flags
> >
> > -#endif /* CONFIG_ARM64_CONTPTE */
> > +#endif /* CONFIG_THP_CONTPTE */
> >
> >  int find_num_contig(struct mm_struct *mm, unsigned long addr,
> >                     pte_t *ptep, size_t *pgsize);
> > diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> > index 60454256945b..52a1b2082627 100644
> > --- a/arch/arm64/mm/Makefile
> > +++ b/arch/arm64/mm/Makefile
> > @@ -3,7 +3,7 @@ obj-y                           :=3D dma-mapping.o exta=
ble.o fault.o init.o \
> >                                    cache.o copypage.o flush.o \
> >                                    ioremap.o mmap.o pgd.o mmu.o \
> >                                    context.o proc.o pageattr.o fixmap.o
> > -obj-$(CONFIG_ARM64_CONTPTE)    +=3D contpte.o
> > +obj-$(CONFIG_THP_CONTPTE)      +=3D contpte.o
> >  obj-$(CONFIG_HUGETLB_PAGE)     +=3D hugetlbpage.o
> >  obj-$(CONFIG_PTDUMP_CORE)      +=3D ptdump.o
> >  obj-$(CONFIG_PTDUMP_DEBUGFS)   +=3D ptdump_debugfs.o
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index c325003d6552..fd4de221a1c6 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -984,6 +984,15 @@ config ARCH_HAS_CACHE_LINE_SIZE
> >  config ARCH_HAS_CONTPTE
> >         bool
> >
> > +config THP_CONTPTE
> > +       bool "Contiguous PTE mappings for user memory" if EXPERT
> > +       depends on ARCH_HAS_CONTPTE && TRANSPARENT_HUGEPAGE
> > +       default y
> > +       help
> > +         When enabled, user mappings are configured using the PTE cont=
iguous
> > +         bit, for any mappings that meet the size and alignment requir=
ements.
> > +         This reduces TLB pressure and improves performance.
> > +
> >  config ARCH_HAS_CURRENT_STACK_POINTER
> >         bool
> >         help
> > --
> > 2.39.2
>
> Thanks
> Barry

