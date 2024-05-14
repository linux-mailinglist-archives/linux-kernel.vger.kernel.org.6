Return-Path: <linux-kernel+bounces-178992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E98F8C5A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36FE1F2285C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD117F39F;
	Tue, 14 May 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cHnbW5CP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E817F378
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707038; cv=none; b=kwqO4VSk1yDndAOI/CyXNuaPTEmjCqbPFfWqoP6pvL4iN8sFXMQxl/eHIDmCnIHg5Ylu8FR4YRHrO1xnookLRNMq6s+X05bqLJZPvwqEMOhVw6+5UFFYy5wY8m+bI1E4PhmwXD+vD+E0S+NU6LM/EedfZiJFhT1Nt6g5stCoIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707038; c=relaxed/simple;
	bh=/W0h0ideA0iOTYMlfYNefL1apNLq6LHL18WKr7fKkRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oo0iI0VXZOQ3ZQV2lFS616A1i4ancM/G/I2F/MftMIgNLe9ezh3Tds29ivxL5M5oncvolMpeIgKhaMzGkJWXJYyIRnBzgrRRAm5nKGC6C/sOTTQrIfxVKEtmv8pavU1yMWfWo8ONZ92ESlGpf7uxG53rbM1v986/U/iWnNfDHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cHnbW5CP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso507190a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715707035; x=1716311835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN/K+9boHAhauCx5TFHKaUKLLLYkMuKUXNq8tR95Jh4=;
        b=cHnbW5CPdDePwfSokOCwr3k21U+Imfq/7/lFRCCm3aWys9tL6QWBod/nudopVDXCMZ
         TtuLkVfLVWnGA5M6tVzv3ID1WQyR0Lb7Atr8K9mWpL5V98pKZyAa/m3+lqdDYAKGHNCp
         ttirGNNDB9iDKjWlSdWAtJNwvOlcSs70EyuV3pgDMmXKF7n3iRN2DvDPjjqHUcFpV/fp
         cAYb+6XnpOwHfC+DjoSaH5sGiy8Vtrdnpk14cWlY+uscdjRWgMauelVdrslzYQDJdVtE
         3A8pte7WVYfkdbSKyt1vYrLS3hvBfY1z1C2qvBkj6Caj6D91PQy7QahuyIqAqXrXX8/u
         Zlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707035; x=1716311835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN/K+9boHAhauCx5TFHKaUKLLLYkMuKUXNq8tR95Jh4=;
        b=v3EHa35NIA/gljId/tds79lcwazzYUQebnqlQCJ3dnjX1D6Vw8h4XWGy7QF9/XZPeR
         h65RglDADwTMwF68T5KeGPI+yDPEX/YJO2EgB+t0CfeTosMxMpkbm5ul9sIJNAgDwug6
         ZES6Sx+WhseBGmGWOpZN9VNkFYstcLZJvyUYqvKP0dyFw8HqQnLrqMJK2iDLnQ78HJnX
         yr4uuZnnTq6z1SYpOJvbO+UdgGSJVzjQEv/Owj8FKH4nx2MsieUw5H0/EztS7gtL8UYd
         6UapN/SWLHecbX0j4SfczAGaE0OOUZJXSqKfJoINQ7u2qVKwF+u1iBCEzy0W/5DzFxSO
         RLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCULSnlEEAmWRSFicO5OJlxEyR+0W7JeevqTmd3sRq6QOdIqoglklH/1THDf5sdr8SVCKYtiYdJvutt+05FZZ46/W8hJwaOu9b1XsUL3
X-Gm-Message-State: AOJu0YzYxhFyAwyjr7MqC0nsgw9Ty2U5Av0u6hhdLrrhkfs4ISgGvyBc
	IXvUMmBhRFZ7KmgWVp2Pzfmu3Cw2VgFZV5CPnBkgE82zRUFn3mKaA+ve7cdaHZg/2lZf320t2qC
	nxV1MC9RR3mbDsBxy9T5uLu6HS0S7H6SXgUYlWA==
X-Google-Smtp-Source: AGHT+IGbLQMoI29kbZ5BuS8XsBelFObdcttwZdyM0fKXvOohQx42kTnJH/5E3IGhVsnh7MYJMHQ+ylOiZR7wfAMouuA=
X-Received: by 2002:a50:cdd3:0:b0:56e:63d3:cb3e with SMTP id
 4fb4d7f45d1cf-5734d6dff0bmr8140102a12.41.1715707035034; Tue, 14 May 2024
 10:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-3-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-3-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 19:17:04 +0200
Message-ID: <CAHVXubgYfi6hNjUAGeXoOcAbAS8Bvd_TtrTD8FhJP1EpPGDKMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] riscv: mm: Change attribute from __init to
 __meminit for page functions
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
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
> Also, make sure that the altmap parameter is properly passed on to
> vmemmap_populate_hugepages().
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/mmu.h     |  4 +--
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/riscv/mm/init.c             | 58 ++++++++++++++------------------
>  3 files changed, 29 insertions(+), 35 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 60be458e94da..c09c3c79f496 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -28,8 +28,8 @@ typedef struct {
>  #endif
>  } mm_context_t;
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
> index 5b8cdfafb52a..c969427eab88 100644
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
> @@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start,=
 unsigned long end, int node,
>          * memory hotplug, we are not able to update all the page tables =
with
>          * the new PMDs.
>          */
> -       return vmemmap_populate_hugepages(start, end, node, NULL);
> +       return vmemmap_populate_hugepages(start, end, node, altmap);

Is this a fix? Does this deserve to be split into another patch then?

>  }
>  #endif
>
> --
> 2.40.1
>

