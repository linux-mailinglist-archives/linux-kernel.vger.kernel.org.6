Return-Path: <linux-kernel+bounces-522698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25580A3CD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14FA176E24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851AD260A56;
	Wed, 19 Feb 2025 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up5OnCr5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70225EFA0;
	Wed, 19 Feb 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007771; cv=none; b=lxXErHShmW6RRyipI3tn++6H3HEVIUcCMNJMMGStn61j5GB+GMNpXBRT5RRlLbUUGh4zs8wFlOFWnwvTy9bEgvNKayQwwB3nS4NCw+z0BuZjOrPkgwytc4/1N179PSp5LUthO46w/zGoFKWXGn1sA+m8evo/LcF54Sr6rhB3SUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007771; c=relaxed/simple;
	bh=ndKKGhsTzGnerfDLaN9L3bsKjYrHFhs1gwDmnHw9Hvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YONC/IZuTr5ixAiXfnNk302Lwx3IAEHIOel5JLJgGOyYajCE2E0ZcMMIhcD/TX64NxwPObZ6Z+R140DFNaYpeS+b4ZIZgj8b5NmbEpaOeWKgTbOGQwjYugLZSoyrQ5Dp4yqxg5Ct8vBJgGhius86VloeKwx6AcVLyWdeR7h0Gbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up5OnCr5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso168302f8f.2;
        Wed, 19 Feb 2025 15:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007765; x=1740612565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+Z72BjPvgymywo1G2IEaCTWsaSUq22tibKSRVUM8fs=;
        b=Up5OnCr5+C2NQwTW2jZe8m98lTdOgWgdqu8p2Cx4zcyl05YskvGPv6iE6N//DWQRDR
         kjFkFRcri2rFEJ4t+xSZxP2b9sqSf96Gc6ZEcRzbZE/Wlav+TnfU06TMlJK9VVcdzkcU
         dH05Y1wLmP1SblMkz479YnIY0+6fUxxu/DYauxeC7igSCjgwZXGbcQqObUUU58YAnoDG
         Iq2hT4tjc08rI4A2oEoLCho3MMSBodsxKcKj449WG+hQwK/aKuhzPyXvSPyWlkfSSEk1
         /LVfJ73Rtg8exTJr8OZfToaXdIGEmAfy9eyMj5WWi+V3B5LxFKI+THqAC2cgyDuBvJsU
         Bgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007765; x=1740612565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+Z72BjPvgymywo1G2IEaCTWsaSUq22tibKSRVUM8fs=;
        b=KqnWz6aH8Euti7zeHHxTEDCP5WZwuPOrK/yCEMNEEXEQMME3pJNRkAvoiIkCKXPGS0
         wBoLyHoP5ty7OOG5zTK32KED8f+jF7rEskC73h4BvnQ/XExAudq8Ny5gqGwvNTaC4QrQ
         QOid5h4/INV2uU/hlq1ACdWTyVsnWbxgJwK/kP4DFekWSIxzlCxPzwXYDyL33gXcxSfn
         0vBUjKOLS7UGmPxH5BiZjWuF8nO6sw5+KkUEVcyNvbGuHQY7EqZTsShHrykdKwGJEu5j
         BAkL/FyUjI53MZDlvJf+2YnkJObo2skaBvo+4W8Jen+MvSoXSQSG6geFD367Qjy20woz
         FSTw==
X-Forwarded-Encrypted: i=1; AJvYcCW664Z27J58LbOq+LRBfRAf/mg0gRAL6oaYP+KMei4DVTUy62VJJHfkS7/bgROy9kLQAnJicVmR3i8=@vger.kernel.org, AJvYcCWKOXCW+Y5JUxAY7P5z9QUAKouikwswknyMsfZNUwnwmJmyUi40ZxTdzumeQMwsYbJpKhnYgQ/33PGxDyDg@vger.kernel.org
X-Gm-Message-State: AOJu0YzemcUPWxUG8FOoeaEddCw5Z8pvf/ZQXFXQGQvhIznFN+8TFSm9
	OYOO7kah8fYbqWJMqp3z4uH+PUIPeZIvmyJoPtlMDuCvR5PbkJ55yQm1IfpggUiO/nry6MTEvfY
	KJM9HrAP0ch3IS6f0raDLA5CCNaI=
X-Gm-Gg: ASbGncvlFOC3Rswb4TUBzQb6WWRRugD/cTIFbJWbbFx1I+DV+m+zwyNwLsKrisKptF3
	CxsWIJbNooIf4KbEdgAvVCFB3/Imb0gGLoSBQaBrniY9aEmsoa3U58HGijNRpOTzvWd924MoICs
	c=
X-Google-Smtp-Source: AGHT+IHQhbxkigsWFSNp+pMl+xBe4TFq46Lu9DevrV6O9cRFq34SPGFThQQAGyNeg5gj4daIwwTt2BdmTyPlRUKOFg8=
X-Received: by 2002:a05:6000:1541:b0:38f:3b9b:6f91 with SMTP id
 ffacd0b85a97d-38f3b9b7389mr13650940f8f.12.1740007764962; Wed, 19 Feb 2025
 15:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:29:14 +0100
X-Gm-Features: AWEUYZki4d9AxVn53RP0a8dYXmP1qdo-p1R_9kMFX3Z6ke5F2uBlC11QXpcsGtE
Message-ID: <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:16=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> From: Samuel Holland <samuel.holland@sifive.com>
>
> Currently, kasan_mem_to_shadow() uses a logical right shift, which turns
> canonical kernel addresses into non-canonical addresses by clearing the
> high KASAN_SHADOW_SCALE_SHIFT bits. The value of KASAN_SHADOW_OFFSET is
> then chosen so that the addition results in a canonical address for the
> shadow memory.
>
> For KASAN_GENERIC, this shift/add combination is ABI with the compiler,
> because KASAN_SHADOW_OFFSET is used in compiler-generated inline tag
> checks[1], which must only attempt to dereference canonical addresses.
>
> However, for KASAN_SW_TAGS we have some freedom to change the algorithm
> without breaking the ABI. Because TBI is enabled for kernel addresses,
> the top bits of shadow memory addresses computed during tag checks are
> irrelevant, and so likewise are the top bits of KASAN_SHADOW_OFFSET.
> This is demonstrated by the fact that LLVM uses a logical right shift
> in the tag check fast path[2] but a sbfx (signed bitfield extract)
> instruction in the slow path[3] without causing any issues.
>
> Using an arithmetic shift in kasan_mem_to_shadow() provides a number of
> benefits:
>
> 1) The memory layout is easier to understand. KASAN_SHADOW_OFFSET
> becomes a canonical memory address, and the shifted pointer becomes a
> negative offset, so KASAN_SHADOW_OFFSET =3D=3D KASAN_SHADOW_END regardles=
s
> of the shift amount or the size of the virtual address space.
>
> 2) KASAN_SHADOW_OFFSET becomes a simpler constant, requiring only one
> instruction to load instead of two. Since it must be loaded in each
> function with a tag check, this decreases kernel text size by 0.5%.
>
> 3) This shift and the sign extension from kasan_reset_tag() can be
> combined into a single sbfx instruction. When this same algorithm change
> is applied to the compiler, it removes an instruction from each inline
> tag check, further reducing kernel text size by an additional 4.6%.
>
> These benefits extend to other architectures as well. On RISC-V, where
> the baseline ISA does not shifted addition or have an equivalent to the
> sbfx instruction, loading KASAN_SHADOW_OFFSET is reduced from 3 to 2
> instructions, and kasan_mem_to_shadow(kasan_reset_tag(addr)) similarly
> combines two consecutive right shifts.
>
> Due to signed memory-to-shadow mapping kasan_non_canonical_hook() needs
> changes - specifically the first part that tries to deduce if a faulty
> address came from kasan_mem_to_shadow(). Previous value of
> KASAN_SHADOW_OFFSET prevented any overflows when trying to map the
> entire linear address space to shadow memory so the check in
> kasan_non_canonical_hook() could consist of only checking whether the
> address isn't below KASAN_SHADOW_OFFSET.
>
> The signed memory-to-shadow conversion means negative addresses will be
> mapped below KASAN_SHADOW_OFFSET and positive addresses will map above
> KASAN_SHADOW_OFFSET. When looking at the mapping of the entire address
> space there will be an overflow when a big enough positive address will
> be passed to kasan_mem_to_shadow(). Then the question of finding
> addresses that couldn't come from kasan_mem_to_shadow() can be reduced
> to figuring out if the address isn't above the highest overflowed value
> (most positive address possible) AND below the most negative address
> possible.

Is there any reason we need this change for x86 SW_TAGS besides the
optimization benefits?

Is it required for the "x86: runtime_const used for KASAN_SHADOW_END"
patch? If so, please check my comment there first.

>
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/=
Transforms/Instrumentation/AddressSanitizer.cpp#L1316 [1]
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/=
Transforms/Instrumentation/HWAddressSanitizer.cpp#L895 [2]
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/=
Target/AArch64/AArch64AsmPrinter.cpp#L669 [3]
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2: (Maciej)
> - Correct address range that's checked in kasan_non_canonical_hook().
>   Adjust the comment inside.
> - Remove part of comment from arch/arm64/include/asm/memory.h.
> - Append patch message paragraph about the overflow in
>   kasan_non_canonical_hook().
>
>  arch/arm64/Kconfig              | 10 +++++-----
>  arch/arm64/include/asm/memory.h | 14 +++++++++++++-
>  arch/arm64/mm/kasan_init.c      |  7 +++++--
>  include/linux/kasan.h           | 10 ++++++++--
>  mm/kasan/report.c               | 26 ++++++++++++++++++++++----
>  scripts/gdb/linux/mm.py         |  5 +++--
>  6 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fcdd0ed3eca8..fe7d79b447c3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -426,11 +426,11 @@ config KASAN_SHADOW_OFFSET
>         default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
>         default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
>         default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
> -       default 0xefff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS=
_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
> -       default 0xefffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_=
52) && ARM64_16K_PAGES && KASAN_SW_TAGS
> -       default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
> -       default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
> -       default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
> +       default 0xffff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS=
_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
> +       default 0xffffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_=
52) && ARM64_16K_PAGES && KASAN_SW_TAGS
> +       default 0xfffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
> +       default 0xffffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
> +       default 0xfffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS

Ah, we also need to update Documentation/arch/arm64/kasan-offsets.sh,
these offsets are generated by that script.

Let's also point out in the commit message, that this change does not
move the location of the shadow memory but only changes the way that
location is calculated.

>         default 0xffffffffffffffff
>
>  config UNWIND_TABLES
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 717829df294e..e71cdf036287 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -89,7 +89,15 @@
>   *
>   * KASAN_SHADOW_END is defined first as the shadow address that correspo=
nds to
>   * the upper bound of possible virtual kernel memory addresses UL(1) << =
64
> - * according to the mapping formula.
> + * according to the mapping formula. For Generic KASAN, the address in t=
he
> + * mapping formula is treated as unsigned (part of the compiler's ABI), =
so the
> + * end of the shadow memory region is at a large positive offset from
> + * KASAN_SHADOW_OFFSET. For Software Tag-Based KASAN, the address in the
> + * formula is treated as signed. Since all kernel addresses are negative=
, they
> + * map to shadow memory below KASAN_SHADOW_OFFSET, making KASAN_SHADOW_O=
FFSET
> + * itself the end of the shadow memory region. (User pointers are positi=
ve and
> + * would map to shadow memory above KASAN_SHADOW_OFFSET, but shadow memo=
ry is
> + * not allocated for them.)
>   *
>   * KASAN_SHADOW_START is defined second based on KASAN_SHADOW_END. The s=
hadow
>   * memory start must map to the lowest possible kernel virtual memory ad=
dress
> @@ -100,7 +108,11 @@
>   */
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +#ifdef CONFIG_KASAN_GENERIC
>  #define KASAN_SHADOW_END       ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT=
)) + KASAN_SHADOW_OFFSET)
> +#else
> +#define KASAN_SHADOW_END       KASAN_SHADOW_OFFSET
> +#endif
>  #define _KASAN_SHADOW_START(va)        (KASAN_SHADOW_END - (UL(1) << ((v=
a) - KASAN_SHADOW_SCALE_SHIFT)))
>  #define KASAN_SHADOW_START     _KASAN_SHADOW_START(vabits_actual)
>  #define PAGE_END               KASAN_SHADOW_START
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index b65a29440a0c..6836e571555c 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -198,8 +198,11 @@ static bool __init root_level_aligned(u64 addr)
>  /* The early shadow maps everything to a single page of zeroes */
>  asmlinkage void __init kasan_early_init(void)
>  {
> -       BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=3D
> -               KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT=
)));
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=3D
> +                       KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCA=
LE_SHIFT)));
> +       else
> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=3D KASAN_SHADOW_END);
>         BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), SHADOW_ALI=
GN));
>         BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), SHADOW=
_ALIGN));
>         BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, SHADOW_ALIGN));
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 890011071f2b..b396feca714f 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -61,8 +61,14 @@ int kasan_populate_early_shadow(const void *shadow_sta=
rt,
>  #ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
> -       return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> -               + KASAN_SHADOW_OFFSET;
> +       void *scaled;
> +
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               scaled =3D (void *)((unsigned long)addr >> KASAN_SHADOW_S=
CALE_SHIFT);
> +       else
> +               scaled =3D (void *)((long)addr >> KASAN_SHADOW_SCALE_SHIF=
T);
> +
> +       return KASAN_SHADOW_OFFSET + scaled;
>  }
>  #endif
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..5766714872d3 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -645,15 +645,33 @@ void kasan_report_async(void)
>   */
>  void kasan_non_canonical_hook(unsigned long addr)
>  {
> +       unsigned long max_shadow_size =3D BIT(BITS_PER_LONG - KASAN_SHADO=
W_SCALE_SHIFT);
>         unsigned long orig_addr;
>         const char *bug_type;
>
>         /*
> -        * All addresses that came as a result of the memory-to-shadow ma=
pping
> -        * (even for bogus pointers) must be >=3D KASAN_SHADOW_OFFSET.
> +        * With the default kasan_mem_to_shadow() algorithm, all addresse=
s
> +        * returned by the memory-to-shadow mapping (even for bogus point=
ers)
> +        * must be within a certain displacement from KASAN_SHADOW_OFFSET=
.
> +        *
> +        * For Generic KASAN the displacement is unsigned so the mapping =
from zero
> +        * to the last kernel address needs checking.
> +        *
> +        * For Software Tag-Based KASAN, the displacement is signed, so
> +        * KASAN_SHADOW_OFFSET is the center of the range. Higher positiv=
e
> +        * addresses overflow, so the range that can't be part of
> +        * memory-to-shadow mapping is above the biggest positive address
> +        * mapping and below the lowest possible one.
>          */
> -       if (addr < KASAN_SHADOW_OFFSET)
> -               return;
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               if (addr < KASAN_SHADOW_OFFSET ||
> +                   addr >=3D KASAN_SHADOW_OFFSET + max_shadow_size)
> +                       return;
> +       } else {
> +               if (addr < KASAN_SHADOW_OFFSET - max_shadow_size / 2 &&
> +                   addr >=3D KASAN_SHADOW_OFFSET + max_shadow_size / 2)
> +                       return;

Ok, I think this would work for what I had in mind.

However, I just realized that this check is not entirely precise. When
doing the memory-to-shadow mapping, the memory address always has its
top byte set to 0xff: both the inlined compiler code and the outline
KASAN code do this. Thus, the possible values a shadow address can
take are the result of the memory-to-shadow mapping applied to
[0xff00000000000000, 0xffffffffffffffff], not to the whole address
space. So we can make this check more precise.

> +       }
>
>         orig_addr =3D (unsigned long)kasan_shadow_to_mem((void *)addr);
>
> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
> index 7571aebbe650..2e63f3dedd53 100644
> --- a/scripts/gdb/linux/mm.py
> +++ b/scripts/gdb/linux/mm.py
> @@ -110,12 +110,13 @@ class aarch64_page_ops():
>          self.KERNEL_END =3D gdb.parse_and_eval("_end")
>
>          if constants.LX_CONFIG_KASAN_GENERIC or constants.LX_CONFIG_KASA=
N_SW_TAGS:
> +            self.KASAN_SHADOW_OFFSET =3D constants.LX_CONFIG_KASAN_SHADO=
W_OFFSET
>              if constants.LX_CONFIG_KASAN_GENERIC:
>                  self.KASAN_SHADOW_SCALE_SHIFT =3D 3
> +                self.KASAN_SHADOW_END =3D (1 << (64 - self.KASAN_SHADOW_=
SCALE_SHIFT)) + self.KASAN_SHADOW_OFFSET
>              else:
>                  self.KASAN_SHADOW_SCALE_SHIFT =3D 4
> -            self.KASAN_SHADOW_OFFSET =3D constants.LX_CONFIG_KASAN_SHADO=
W_OFFSET
> -            self.KASAN_SHADOW_END =3D (1 << (64 - self.KASAN_SHADOW_SCAL=
E_SHIFT)) + self.KASAN_SHADOW_OFFSET
> +                self.KASAN_SHADOW_END =3D self.KASAN_SHADOW_OFFSET
>              self.PAGE_END =3D self.KASAN_SHADOW_END - (1 << (self.vabits=
_actual - self.KASAN_SHADOW_SCALE_SHIFT))
>          else:
>              self.PAGE_END =3D self._PAGE_END(self.VA_BITS_MIN)

We likely also need to update scripts/gdb/linux/kasan.py.

Also, later in the series, you change KASAN_SHADOW_OFFSET from a
config option into a runtime_const, which AFAIU would make these
scripts stop working.

