Return-Path: <linux-kernel+bounces-378695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A89AD429
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DD0282D28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED01E1027;
	Wed, 23 Oct 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEmwlGat"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7D1D14EA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708946; cv=none; b=dkzO8oZre0jTDn7J7zNtstysUQeEal+BfQFPw2lVGF8Qh4CK/oKNlBhY+phb2jBCYBlhC6MVdjglKkGtJ3fsgDXPRtv1ljqmwI8nlRuaS+SpYgFHvufhtg0ayk38grsc/LGb06z7mj8Db3jHUdEGkfH7bHr1UEm/TK0569VOtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708946; c=relaxed/simple;
	bh=qpFOcXinZnHIVprgCSLGPnCEGYvo7NdRuIfqs4sCjiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hai5dmdxJs9r4Ajj28C4Jaqit3rJ+Dmw6AuodtTXF8RHugaWEJVDqRK8Jf0j8Ru0b3izHWbWnr7l48uymhZJ5kBpBs8HEVhXZ9HrhA6ye7+XUK5EvBpgWMVACKhLipGjix/LTS+s23L3sYJPWR3gBxS6yIUNjCZfYV+nOmG3Ejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEmwlGat; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso943435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708942; x=1730313742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk6I7i6lxVXlFus2LX683LvbeBFc4hf03we1CgN8ers=;
        b=fEmwlGatC/nDwFHxIiN+N8XmcNGZJhwGXm9Fw7Oe66lbidLVdiLkeAAmagq8Qt0hjs
         nkKdHXMxz8dOrN4/dgCl5BdH0PE2cdXcT7LA91+KJMrf2TUxhx3smve+BnWyfkk00/TH
         PocmYrETqUAlLYOrIc9Fe5Kwbh+62/C8xiv77cSvjcCFVJqLow2evr19awv2TbHP57l4
         3qd+rDL+znrZYB0s2+g3Od+Pnfo0Z0Fj3wf2zDYffoZMD/6t2AiiWpP4eNEsJz05cj13
         kqj9Yu2izc4tKumdDM6xRDxMcFDrVIqBb45OjeTBOZbWx+F2viOHV6j+MHWkzwr54S5v
         hjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708942; x=1730313742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk6I7i6lxVXlFus2LX683LvbeBFc4hf03we1CgN8ers=;
        b=Fma0UbKqQKcu6HQ1fFL7aSIIV+30QVNhQ9SSyJ3CEuYhS0YTx1wB1uC4T/N8hzh83D
         oQcVZpAt/HmnmjVZrT6UiJ2jMOrMcZ0sr/uRu6yd+2/g9Xi8jCJjJD2YgweMs2E6MYrm
         GfrWWqJvZELxYpa4RH1Ii97YrC7gxe61TOCRkrp7USbfu8guFrVsnKF9o3U4hxfODKA4
         qjHJOEICigakvgS1kY6Q9hQRKu8Rxj3VXadS4yAT4stVvCtkb1FAnHPnN/Z2hY8GZ9dK
         rIXsu2RbnduBJeSDZEOC5ez/fdsf4nau3ppwmVKLqj6Qsa8Z/zx+U4kgSVJOMB5/RF1A
         Sqxg==
X-Forwarded-Encrypted: i=1; AJvYcCWmH9XJWQuZvL0mlyeb00oQVveW7NGlu4pinGaDAVqnxtOSuvaVvXyUIpgy4Z8RFkXn1yU4irtuq8ki/vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsERUz2IC0V02Gt22z629Z61iBFoPm9mMrZ/o4TYJK3lodHIQ
	N0oUZ8WmLmfa7H4PBvb0v8TthEYMk8pdOyHhvo1PKu3Gu2itkDXM9O5siSsJ89+xvzI1h1KFe2Y
	vYOkoCfE8ngvggTv71LibTJWoPRY=
X-Google-Smtp-Source: AGHT+IFilgJRtKQ5ENiKr5EJJJviK0Aaz3KKXswEzV5EpGM3o8Y3qyTu3AeFjVHnPRBLB4pMjg/HwswZ366QSD0EZyg=
X-Received: by 2002:adf:e848:0:b0:37d:4fe9:b6a4 with SMTP id
 ffacd0b85a97d-37efcf897aamr2289592f8f.50.1729708942078; Wed, 23 Oct 2024
 11:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022015913.3524425-1-samuel.holland@sifive.com> <20241022015913.3524425-10-samuel.holland@sifive.com>
In-Reply-To: <20241022015913.3524425-10-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 23 Oct 2024 20:42:11 +0200
Message-ID: <CA+fCnZcX2AWOu3h2hb-WGK4NQBrvbeEPPUcMd3cNvYPZBQD_yw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] riscv: Implement KASAN_SW_TAGS
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:59=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Implement support for software tag-based KASAN using the RISC-V pointer
> masking extension, which supports 7 and/or 16-bit tags. This implemen-
> tation uses 7-bit tags, so it is compatible with either hardware mode.
>
> Pointer masking is an optional ISA extension, and it must be enabled
> using an SBI call to firmware on each CPU. This SBI call must be made
> very early in smp_callin(), as dereferencing any tagged pointers before
> that point will crash the kernel. If the SBI call fails on the boot CPU,
> then KASAN is globally disabled, and the kernel boots normally (unless
> stack tagging is enabled). If the SBI call fails on any other CPU, that
> CPU is excluded from the system.
>
> When pointer masking is enabled for the kernel's privilege mode, it must
> be more careful about accepting tagged pointers from userspace.
> Normally, __access_ok() accepts tagged aliases of kernel memory as long
> as the MSB is zero, since those addresses cannot be dereferenced -- they
> will cause a page fault in the uaccess routines. But when the kernel is
> using pointer masking, those addresses are dereferenceable, so
> __access_ok() must specifically check the most-significant non-tag bit
> instead of the MSB.
>
> Pointer masking does not apply to the operands of fence instructions, so
> software is responsible for untagging those addresses.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Fix build error with KASAN_GENERIC
>  - Use symbolic definitons for SBI firmware features call
>  - Update indentation in scripts/Makefile.kasan
>  - Use kasan_params to set hwasan-generate-tags-with-calls=3D1
>
>  Documentation/dev-tools/kasan.rst | 14 ++++---
>  arch/riscv/Kconfig                |  4 +-
>  arch/riscv/include/asm/cache.h    |  4 ++
>  arch/riscv/include/asm/kasan.h    | 20 ++++++++++
>  arch/riscv/include/asm/page.h     | 19 ++++++++--
>  arch/riscv/include/asm/pgtable.h  |  6 +++
>  arch/riscv/include/asm/tlbflush.h |  4 +-
>  arch/riscv/kernel/setup.c         |  6 +++
>  arch/riscv/kernel/smpboot.c       |  8 +++-
>  arch/riscv/lib/Makefile           |  2 +
>  arch/riscv/lib/kasan_sw_tags.S    | 61 +++++++++++++++++++++++++++++++
>  arch/riscv/mm/kasan_init.c        | 32 +++++++++++++++-
>  arch/riscv/mm/physaddr.c          |  4 ++
>  scripts/Makefile.kasan            |  5 +++
>  14 files changed, 174 insertions(+), 15 deletions(-)
>  create mode 100644 arch/riscv/lib/kasan_sw_tags.S
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index d7de44f5339d..6548aebac57f 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -22,8 +22,8 @@ architectures, but it has significant performance and m=
emory overheads.
>
>  Software Tag-Based KASAN or SW_TAGS KASAN, enabled with CONFIG_KASAN_SW_=
TAGS,
>  can be used for both debugging and dogfood testing, similar to userspace=
 HWASan.
> -This mode is only supported for arm64, but its moderate memory overhead =
allows
> -using it for testing on memory-restricted devices with real workloads.
> +This mode is only supported on arm64 and riscv, but its moderate memory =
overhead
> +allows using it for testing on memory-restricted devices with real workl=
oads.
>
>  Hardware Tag-Based KASAN or HW_TAGS KASAN, enabled with CONFIG_KASAN_HW_=
TAGS,
>  is the mode intended to be used as an in-field memory bug detector or as=
 a
> @@ -340,12 +340,14 @@ Software Tag-Based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
>  Software Tag-Based KASAN uses a software memory tagging approach to chec=
king
> -access validity. It is currently only implemented for the arm64 architec=
ture.
> +access validity. It is currently only implemented for the arm64 and risc=
v
> +architectures.
>
>  Software Tag-Based KASAN uses the Top Byte Ignore (TBI) feature of arm64=
 CPUs
> -to store a pointer tag in the top byte of kernel pointers. It uses shado=
w memory
> -to store memory tags associated with each 16-byte memory cell (therefore=
, it
> -dedicates 1/16th of the kernel memory for shadow memory).
> +or the pointer masking (Sspm) feature of RISC-V CPUs to store a pointer =
tag in
> +the top byte of kernel pointers. It uses shadow memory to store memory t=
ags
> +associated with each 16-byte memory cell (therefore, it dedicates 1/16th=
 of the
> +kernel memory for shadow memory).
>
>  On each memory allocation, Software Tag-Based KASAN generates a random t=
ag, tags
>  the allocated memory with this tag, and embeds the same tag into the ret=
urned
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 62545946ecf4..d08b99f6bf76 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -121,6 +121,7 @@ config RISCV
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>         select HAVE_ARCH_KASAN if MMU && 64BIT
> +       select HAVE_ARCH_KASAN_SW_TAGS if MMU && 64BIT
>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>         select HAVE_ARCH_KFENCE if MMU && 64BIT
>         select HAVE_ARCH_KGDB if !XIP_KERNEL
> @@ -291,7 +292,8 @@ config PAGE_OFFSET
>
>  config KASAN_SHADOW_OFFSET
>         hex
> -       depends on KASAN_GENERIC
> +       depends on KASAN
> +       default 0xffffffff00000000 if KASAN_SW_TAGS
>         default 0xdfffffff00000000 if 64BIT
>         default 0xffffffff if 32BIT
>
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cach=
e.h
> index 570e9d8acad1..232288a060c6 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -16,6 +16,10 @@
>  #define ARCH_KMALLOC_MINALIGN  (8)
>  #endif
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define ARCH_SLAB_MINALIGN     (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> +#endif
> +
>  /*
>   * RISC-V requires the stack pointer to be 16-byte aligned, so ensure th=
at
>   * the flat loader aligns it accordingly.
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasa=
n.h
> index a4e92ce9fa31..f6b378ba936d 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -25,7 +25,11 @@
>   *      KASAN_SHADOW_OFFSET =3D KASAN_SHADOW_END -
>   *                              (1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT)=
)
>   */
> +#if defined(CONFIG_KASAN_GENERIC)
>  #define KASAN_SHADOW_SCALE_SHIFT       3
> +#elif defined(CONFIG_KASAN_SW_TAGS)
> +#define KASAN_SHADOW_SCALE_SHIFT       4
> +#endif
>
>  #define KASAN_SHADOW_SIZE      (UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_S=
CALE_SHIFT))
>  /*
> @@ -37,6 +41,14 @@
>
>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define KASAN_TAG_KERNEL       0x7f /* native kernel pointers tag */
> +#endif
> +
> +#define arch_kasan_set_tag(addr, tag)  __tag_set(addr, tag)
> +#define arch_kasan_reset_tag(addr)     __tag_reset(addr)
> +#define arch_kasan_get_tag(addr)       __tag_get(addr)
> +
>  void kasan_init(void);
>  asmlinkage void kasan_early_init(void);
>  void kasan_swapper_init(void);
> @@ -48,5 +60,13 @@ void kasan_swapper_init(void);
>
>  #endif /* CONFIG_KASAN */
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +bool kasan_boot_cpu_enabled(void);
> +int kasan_cpu_enable(void);
> +#else
> +static inline bool kasan_boot_cpu_enabled(void) { return false; }
> +static inline int kasan_cpu_enable(void) { return 0; }
> +#endif
> +
>  #endif
>  #endif /* __ASM_KASAN_H */
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 6e2f79cf77c5..43c625a4894d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -89,6 +89,16 @@ typedef struct page *pgtable_t;
>  #define PTE_FMT "%08lx"
>  #endif
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define __tag_set(addr, tag)   ((void *)((((u64)(addr) << 7) >> 7) | ((u=
64)(tag) << 57)))
> +#define __tag_reset(addr)      ((void *)((s64)((u64)(addr) << 7) >> 7))
> +#define __tag_get(addr)                ((u8)((u64)(addr) >> 57))
> +#else
> +#define __tag_set(addr, tag)   (addr)
> +#define __tag_reset(addr)      (addr)
> +#define __tag_get(addr)                0
> +#endif
> +
>  #if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>  /*
>   * We override this value as its generic definition uses __pa too early =
in
> @@ -168,7 +178,7 @@ phys_addr_t linear_mapping_va_to_pa(unsigned long x);
>  #endif
>
>  #define __va_to_pa_nodebug(x)  ({                                       =
       \
> -       unsigned long _x =3D x;                                          =
         \
> +       unsigned long _x =3D (unsigned long)__tag_reset(x);              =
         \
>         is_linear_mapping(_x) ?                                          =
       \
>                 linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x)=
;      \
>         })
> @@ -192,7 +202,10 @@ extern phys_addr_t __phys_addr_symbol(unsigned long =
x);
>  #define pfn_to_virt(pfn)       (__va(pfn_to_phys(pfn)))
>
>  #define virt_to_page(vaddr)    (pfn_to_page(virt_to_pfn(vaddr)))
> -#define page_to_virt(page)     (pfn_to_virt(page_to_pfn(page)))
> +#define page_to_virt(page)     ({                                       =
       \
> +       __typeof__(page) __page =3D page;                                =
         \
> +       __tag_set(pfn_to_virt(page_to_pfn(__page)), page_kasan_tag(__page=
));    \
> +})
>
>  #define page_to_phys(page)     (pfn_to_phys(page_to_pfn(page)))
>  #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))
> @@ -209,7 +222,7 @@ static __always_inline void *pfn_to_kaddr(unsigned lo=
ng pfn)
>  #endif /* __ASSEMBLY__ */
>
>  #define virt_addr_valid(vaddr) ({                                       =
       \
> -       unsigned long _addr =3D (unsigned long)vaddr;                    =
         \
> +       unsigned long _addr =3D (unsigned long)__tag_reset(vaddr);       =
         \
>         (unsigned long)(_addr) >=3D PAGE_OFFSET && pfn_valid(virt_to_pfn(=
_addr)); \
>  })
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index e79f15293492..ae6fa9dba0fc 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -916,7 +916,13 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pt=
e)
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE_64   (PGDIR_SIZE * PTRS_PER_PGD / 2)
> +/*
> + * When pointer masking is enabled for the kernel's privilege mode,
> + * __access_ok() must reject tagged aliases of kernel memory.
> + */
> +#ifndef CONFIG_KASAN_SW_TAGS
>  #define TASK_SIZE_MAX  LONG_MAX
> +#endif
>
>  #ifdef CONFIG_COMPAT
>  #define TASK_SIZE_32   (_AC(0x80000000, UL) - PAGE_SIZE)
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 72e559934952..68b3a85c6960 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -31,14 +31,14 @@ static inline void local_flush_tlb_all_asid(unsigned =
long asid)
>  /* Flush one page from local TLB */
>  static inline void local_flush_tlb_page(unsigned long addr)
>  {
> -       ALT_SFENCE_VMA_ADDR(addr);
> +       ALT_SFENCE_VMA_ADDR(__tag_reset(addr));
>  }
>
>  static inline void local_flush_tlb_page_asid(unsigned long addr,
>                                              unsigned long asid)
>  {
>         if (asid !=3D FLUSH_TLB_NO_ASID)
> -               ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
> +               ALT_SFENCE_VMA_ADDR_ASID(__tag_reset(addr), asid);
>         else
>                 local_flush_tlb_page(addr);
>  }
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a2cde65b69e9..fdc72edc4857 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -299,6 +299,12 @@ void __init setup_arch(char **cmdline_p)
>         riscv_user_isa_enable();
>  }
>
> +void __init smp_prepare_boot_cpu(void)
> +{
> +       if (kasan_boot_cpu_enabled())
> +               kasan_init_sw_tags();
> +}
> +
>  bool arch_cpu_is_hotpluggable(int cpu)
>  {
>         return cpu_has_hotplug(cpu);
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 0f8f1c95ac38..a1cc555691b0 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -29,6 +29,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/irq.h>
> +#include <asm/kasan.h>
>  #include <asm/mmu_context.h>
>  #include <asm/numa.h>
>  #include <asm/tlbflush.h>
> @@ -210,7 +211,11 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  asmlinkage __visible void smp_callin(void)
>  {
>         struct mm_struct *mm =3D &init_mm;
> -       unsigned int curr_cpuid =3D smp_processor_id();
> +       unsigned int curr_cpuid;
> +
> +       /* Must be called first, before referencing any dynamic allocatio=
ns */
> +       if (kasan_boot_cpu_enabled() && kasan_cpu_enable())
> +               return;
>
>         if (has_vector()) {
>                 /*
> @@ -225,6 +230,7 @@ asmlinkage __visible void smp_callin(void)
>         mmgrab(mm);
>         current->active_mm =3D mm;
>
> +       curr_cpuid =3D smp_processor_id();
>         store_cpu_topology(curr_cpuid);
>         notify_cpu_starting(curr_cpuid);
>
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 8eec6b69a875..ae36616fe1f5 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -20,3 +20,5 @@ lib-$(CONFIG_RISCV_ISA_ZBC)   +=3D crc32.o
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
>  lib-$(CONFIG_RISCV_ISA_V)      +=3D xor.o
>  lib-$(CONFIG_RISCV_ISA_V)      +=3D riscv_v_helpers.o
> +
> +obj-$(CONFIG_KASAN_SW_TAGS) +=3D kasan_sw_tags.o
> diff --git a/arch/riscv/lib/kasan_sw_tags.S b/arch/riscv/lib/kasan_sw_tag=
s.S
> new file mode 100644
> index 000000000000..f7d3e0acba6a
> --- /dev/null
> +++ b/arch/riscv/lib/kasan_sw_tags.S
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Google LLC
> + * Copyright (C) 2024 SiFive
> + */
> +
> +#include <linux/linkage.h>
> +
> +/*
> + * Report a tag mismatch detected by tag-based KASAN.
> + *
> + * A compiler-generated thunk calls this with a custom calling conventio=
n.
> + * Upon entry to this function, the following registers have been modifi=
ed:
> + *
> + *   x1/ra:     clobbered by call to this function
> + *   x2/sp:     decremented by 256
> + *   x6/t1:     tag from shadow memory
> + *   x7/t2:     tag from pointer
> + *   x10/a0:    fault address
> + *   x11/a1:    fault description
> + *   x28/t3:    clobbered by thunk
> + *   x29/t4:    clobbered by thunk
> + *   x30/t5:    clobbered by thunk
> + *   x31/t6:    clobbered by thunk
> + *
> + * The caller has decremented the SP by 256 bytes, and stored the follow=
ing
> + * registers in slots on the stack according to their number (sp + 8 * x=
N):
> + *
> + *   x1/ra:     return address to user code
> + *   x8/s0/fp:  saved value from user code
> + *   x10/a0:    saved value from user code
> + *   x11/a1:    saved value from user code
> + */
> +SYM_CODE_START(__hwasan_tag_mismatch)
> +       /* Store the remaining unclobbered caller-saved regs */
> +       sd      t0, (8 *  5)(sp)
> +       sd      a2, (8 * 12)(sp)
> +       sd      a3, (8 * 13)(sp)
> +       sd      a4, (8 * 14)(sp)
> +       sd      a5, (8 * 15)(sp)
> +       sd      a6, (8 * 16)(sp)
> +       sd      a7, (8 * 17)(sp)
> +
> +       /* a0 and a1 are already set by the thunk */
> +       ld      a2, (8 *  1)(sp)
> +       call    kasan_tag_mismatch
> +
> +       ld      ra, (8 *  1)(sp)
> +       ld      t0, (8 *  5)(sp)
> +       ld      a0, (8 * 10)(sp)
> +       ld      a1, (8 * 11)(sp)
> +       ld      a2, (8 * 12)(sp)
> +       ld      a3, (8 * 13)(sp)
> +       ld      a4, (8 * 14)(sp)
> +       ld      a5, (8 * 15)(sp)
> +       ld      a6, (8 * 16)(sp)
> +       ld      a7, (8 * 17)(sp)
> +       addi    sp, sp, 256
> +       ret
> +SYM_CODE_END(__hwasan_tag_mismatch)
> +EXPORT_SYMBOL(__hwasan_tag_mismatch)
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index c301c8d291d2..50f0e7a03cc8 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -11,6 +11,10 @@
>  #include <asm/fixmap.h>
>  #include <asm/pgalloc.h>
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +static bool __kasan_boot_cpu_enabled __ro_after_init;
> +#endif
> +
>  /*
>   * Kasan shadow region must lie at a fixed address across sv39, sv48 and=
 sv57
>   * which is right before the kernel.
> @@ -323,8 +327,11 @@ asmlinkage void __init kasan_early_init(void)
>  {
>         uintptr_t i;
>
> -       BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=3D
> -               KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT=
)));
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=3D
> +                       KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCA=
LE_SHIFT)));
> +       else
> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=3D KASAN_SHADOW_END);
>
>         for (i =3D 0; i < PTRS_PER_PTE; ++i)
>                 set_pte(kasan_early_shadow_pte + i,
> @@ -356,6 +363,10 @@ asmlinkage void __init kasan_early_init(void)
>                                  KASAN_SHADOW_START, KASAN_SHADOW_END);
>
>         local_flush_tlb_all();
> +
> +#ifdef CONFIG_KASAN_SW_TAGS
> +       __kasan_boot_cpu_enabled =3D !kasan_cpu_enable();
> +#endif
>  }
>
>  void __init kasan_swapper_init(void)
> @@ -534,3 +545,20 @@ void __init kasan_init(void)
>         csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
>         local_flush_tlb_all();
>  }
> +
> +#ifdef CONFIG_KASAN_SW_TAGS
> +bool kasan_boot_cpu_enabled(void)
> +{
> +       return __kasan_boot_cpu_enabled;
> +}
> +
> +int kasan_cpu_enable(void)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
> +                       SBI_FWFT_POINTER_MASKING_PMLEN, 7, 0, 0, 0, 0);
> +
> +       return sbi_err_map_linux_errno(ret.error);
> +}
> +#endif
> diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
> index 18706f457da7..6d1cf6ffd54e 100644
> --- a/arch/riscv/mm/physaddr.c
> +++ b/arch/riscv/mm/physaddr.c
> @@ -8,6 +8,8 @@
>
>  phys_addr_t __virt_to_phys(unsigned long x)
>  {
> +       x =3D __tag_reset(x);
> +
>         /*
>          * Boundary checking aginst the kernel linear mapping space.
>          */
> @@ -24,6 +26,8 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
>         unsigned long kernel_start =3D kernel_map.virt_addr;
>         unsigned long kernel_end =3D kernel_start + kernel_map.size;
>
> +       x =3D __tag_reset(x);
> +
>         /*
>          * Boundary checking aginst the kernel image mapping.
>          * __pa_symbol should only be used on kernel symbol addresses.
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 693dbbebebba..72a8c9d5fb0e 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -91,6 +91,11 @@ ifeq ($(call clang-min-version, 150000)$(call gcc-min-=
version, 130000),y)
>         kasan_params +=3D hwasan-kernel-mem-intrinsic-prefix=3D1
>  endif
>
> +# RISC-V requires dynamically determining if stack tagging can be enable=
d.

Please be more explicit here, something like: "RISC-V requires
dynamically determining if stack tagging can be enabled and thus
cannot allow the compiler to generate tags via inlined code."


> +ifdef CONFIG_RISCV
> +       kasan_params +=3D hwasan-generate-tags-with-calls=3D1
> +endif
> +
>  endif # CONFIG_KASAN_SW_TAGS
>
>  # Add all as-supported KASAN LLVM parameters requested by the configurat=
ion.
> --
> 2.45.1
>

