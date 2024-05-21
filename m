Return-Path: <linux-kernel+bounces-184955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6638CAE69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A0D1F215D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24749762F7;
	Tue, 21 May 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c0sSJIkT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483C28E7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294949; cv=none; b=IUsnnsQWo86z9AwKN2ZwW0XjZ105VPU6J4bvVuT/XFgkevmIxOiWk6eEg9Py89uyGOTfOHtupsAqB00rdBYPugjQ8EgDYdt+m9VDh62ErrYFEdMQy3tSgqvkPEAmLkz4kfqOlz+OJ6OE8ETqTED0fgqK4ETYFTn1PYCjyUhm/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294949; c=relaxed/simple;
	bh=7zabcxtWOV9roTYwMOUwyvCTAijI6gl/R8UqQpEX8Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f483YGludEqxH1Qxpbdsqn00eioelzKmN2GYOPbbDzKdxZFwxp4p8u9jvFYr7NcmzYfMpDUrpjPhi1hhmDUkGnoV7egP9+D1+G5G4MEhji+m6Ea+vAwkOpm4vz5jVVMZwIePs0EeCUQ2O2DYCfrdkKHp+ATRePeAlmc8M6KSLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c0sSJIkT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5d67064885so389039066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716294945; x=1716899745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WWapkkThh/Y99F52WW+zEVSnw2Q3pRRIZyBMEsctj8=;
        b=c0sSJIkTQ2QI0SbKG9a99Y8CCdb4sPyVipO7UMj+yT98bXdf4N2LN+RxE3gd32NSfY
         U7ouk6UUZtrOAMHRnUDaZwBDcgarr8yxfERigfche3f60JZ+qoxX0bkZPrAIfMnFqDha
         4sprGG9xv4HBOE9cdphp9YDN0PfJhl/0HoDYbdCl1qJ8tuBGEIDkIcnr23bF+h+HXiB7
         V1GBMGXG0TgM42vydj0XBW3w1pjclQeI+Nu+kYjX+dhsSAAP8r9w+9mnEVIO1vtzJcri
         w3mlkT6JhmI7GMe94Y+pbGvX2aq9PxQVjSTeKMyBKMhpBMMLHhGk+73wngQ6TMrNGA+3
         hY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294945; x=1716899745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WWapkkThh/Y99F52WW+zEVSnw2Q3pRRIZyBMEsctj8=;
        b=DcJQ+5j7De0wjct7j6iukkIThbzHSAOpGj1Z58WslF5Zy+uBAMNb45uxw6swFqZx4/
         o37Szj6HAJv1JP2fUl/C5BcVge+BZVUA1+xGq4/ycIgWclaaSlX7zdpkHDOJH3Igu7ts
         oRbg80ehbG6T1isxPBirHpVAMOQwFVZv/s8/CJBGXeH8q24iyLum2PQTS4A22vc7bhhD
         zXFPzACp7LELrm7JBP9T6DZXNQ2zBlW19rTcPpXDqJgr4Q6dPl+aLh85PBlyhfNOmX/g
         EatlGKZaqkriwZ73ZawwvdRq+SwMIYvtqWjcDE3NTEwr3uBkCjH56weX3lSJ3RS9cZNN
         WIcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqpNgspQHepQpEbAxpOR8Pnks4HSdEQ5xA25trnYMPudM8oA8KmqLXHW6vnog6epu4QuLqbew/tiqtSXX6s/dCG6L7QtYNQhr2tBnh
X-Gm-Message-State: AOJu0YwlX55OWr0nYm8xkMlMwiDCNVGgd3eai9XO8zJ8KGBNQtFGNFfB
	hn2547ux7TJIUJyjT2O7Dnb3LAhZv/cCkkRvReley+ATXNbt0WmSknYjHG+hyAbc1LuXSVc04uP
	0exL+BuIyDAW303O1IBcA3i333k3Ws8USTDX4uQ==
X-Google-Smtp-Source: AGHT+IEAnwtcawhGsvoiDU5egcp+8BWpo/0gaVCuP0mcubsH7FN3B4W2sdAU3nQcpY7za33qaVUAyqjvbYRuIWmtcsE=
X-Received: by 2002:a17:907:2d13:b0:a59:c577:c5c3 with SMTP id
 a640c23a62f3a-a5a2d57a48emr3475611566b.29.1716294945079; Tue, 21 May 2024
 05:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-4-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-4-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 14:35:34 +0200
Message-ID: <CAHVXubiQ9jg1knGokXfFxbRtapxKg8LqXJB0D2MRR5QifSZFBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] riscv: mm: Change attribute from __init to
 __meminit for page functions
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:48=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Prepare for memory hotplugging support by changing from __init to
> __meminit for the page table functions that are used by the upcoming
> architecture specific callbacks.
>
> Changing the __init attribute to __meminit, avoids that the functions
> are removed after init. The __meminit attribute makes sure the
> functions are kept in the kernel text post init, but only if memory
> hotplugging is enabled for the build.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/mmu.h     |  4 +--
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/riscv/mm/init.c             | 56 ++++++++++++++------------------
>  3 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 947fd60f9051..c9e03e9da3dc 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -31,8 +31,8 @@ typedef struct {
>  #define cntx2asid(cntx)                ((cntx) & SATP_ASID_MASK)
>  #define cntx2version(cntx)     ((cntx) & ~SATP_ASID_MASK)
>
> -void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa=
,
> -                              phys_addr_t sz, pgprot_t prot);
> +void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t=
 pa, phys_addr_t sz,
> +                                 pgprot_t prot);
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_MMU_H */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 58fd7b70b903..7933f493db71 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -162,7 +162,7 @@ struct pt_alloc_ops {
>  #endif
>  };
>
> -extern struct pt_alloc_ops pt_ops __initdata;
> +extern struct pt_alloc_ops pt_ops __meminitdata;
>
>  #ifdef CONFIG_MMU
>  /* Number of PGD entries that a user-mode program can use */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c98010ede810..c969427eab88 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -295,7 +295,7 @@ static void __init setup_bootmem(void)
>  }
>
>  #ifdef CONFIG_MMU
> -struct pt_alloc_ops pt_ops __initdata;
> +struct pt_alloc_ops pt_ops __meminitdata;
>
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> @@ -357,7 +357,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_=
addr_t pa)
>         return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
>  }
>
> -static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
> +static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
>  {
>         return (pte_t *) __va(pa);
>  }
> @@ -376,7 +376,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uin=
tptr_t va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t __init alloc_pte_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
>  {
>         struct ptdesc *ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HIG=
HMEM, 0);
>
> @@ -384,9 +384,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va=
)
>         return __pa((pte_t *)ptdesc_address(ptdesc));
>  }
>
> -static void __init create_pte_mapping(pte_t *ptep,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys=
_addr_t pa, phys_addr_t sz,
> +                                        pgprot_t prot)
>  {
>         uintptr_t pte_idx =3D pte_index(va);
>
> @@ -440,7 +439,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t =
pa)
>         return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
>  }
>
> -static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
> +static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
>  {
>         return (pmd_t *) __va(pa);
>  }
> @@ -457,7 +456,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t =
va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t __init alloc_pmd_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
>  {
>         struct ptdesc *ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HIG=
HMEM, 0);
>
> @@ -465,9 +464,9 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va=
)
>         return __pa((pmd_t *)ptdesc_address(ptdesc));
>  }
>
> -static void __init create_pmd_mapping(pmd_t *pmdp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_pmd_mapping(pmd_t *pmdp,
> +                                        uintptr_t va, phys_addr_t pa,
> +                                        phys_addr_t sz, pgprot_t prot)
>  {
>         pte_t *ptep;
>         phys_addr_t pte_phys;
> @@ -503,7 +502,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t =
pa)
>         return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
>  }
>
> -static pud_t *__init get_pud_virt_late(phys_addr_t pa)
> +static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
>  {
>         return (pud_t *)__va(pa);
>  }
> @@ -521,7 +520,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t =
va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t alloc_pud_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
>  {
>         unsigned long vaddr;
>
> @@ -541,7 +540,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t =
pa)
>         return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
>  }
>
> -static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
> +static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
>  {
>         return (p4d_t *)__va(pa);
>  }
> @@ -559,7 +558,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t =
va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t alloc_p4d_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
>  {
>         unsigned long vaddr;
>
> @@ -568,9 +567,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
>         return __pa(vaddr);
>  }
>
> -static void __init create_pud_mapping(pud_t *pudp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys=
_addr_t pa, phys_addr_t sz,
> +                                        pgprot_t prot)
>  {
>         pmd_t *nextp;
>         phys_addr_t next_phys;
> @@ -595,9 +593,8 @@ static void __init create_pud_mapping(pud_t *pudp,
>         create_pmd_mapping(nextp, va, pa, sz, prot);
>  }
>
> -static void __init create_p4d_mapping(p4d_t *p4dp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys=
_addr_t pa, phys_addr_t sz,
> +                                        pgprot_t prot)
>  {
>         pud_t *nextp;
>         phys_addr_t next_phys;
> @@ -653,9 +650,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
>  #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while=
(0)
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> -void __init create_pgd_mapping(pgd_t *pgdp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t=
 pa, phys_addr_t sz,
> +                                 pgprot_t prot)
>  {
>         pgd_next_t *nextp;
>         phys_addr_t next_phys;
> @@ -680,8 +676,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
>         create_pgd_next_mapping(nextp, va, pa, sz, prot);
>  }
>
> -static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
> -                                     phys_addr_t size)
> +static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, p=
hys_addr_t size)
>  {
>         if (pgtable_l5_enabled &&
>             !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >=3D=
 P4D_SIZE)
> @@ -714,7 +709,7 @@ asmlinkage void __init __copy_data(void)
>  #endif
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -static __init pgprot_t pgprot_from_va(uintptr_t va)
> +static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>  {
>         if (is_va_kernel_text(va))
>                 return PAGE_KERNEL_READ_EXEC;
> @@ -739,7 +734,7 @@ void mark_rodata_ro(void)
>                                   set_memory_ro);
>  }
>  #else
> -static __init pgprot_t pgprot_from_va(uintptr_t va)
> +static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>  {
>         if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
>                 return PAGE_KERNEL;
> @@ -1231,9 +1226,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         pt_ops_set_fixmap();
>  }
>
> -static void __init create_linear_mapping_range(phys_addr_t start,
> -                                              phys_addr_t end,
> -                                              uintptr_t fixed_map_size)
> +static void __meminit create_linear_mapping_range(phys_addr_t start, phy=
s_addr_t end,
> +                                                 uintptr_t fixed_map_siz=
e)
>  {
>         phys_addr_t pa;
>         uintptr_t va, map_size;
> --
> 2.40.1
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

