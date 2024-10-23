Return-Path: <linux-kernel+bounces-378691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE879AD423
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7C8282EED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143E1D14E1;
	Wed, 23 Oct 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClfSawbj"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A631CC170
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708932; cv=none; b=GX+z9uEDe/6KOshNiyI6iNoBnL+bFrlGQlRTjzBt2ZR8QTuzBqzeHXbdvJZeD/yeF25Rj5NWL4AffrUBYLurGfDiMGdNAiMPHsv7PYtVd25XP2CnJOyw9o6KqbTTVIXEu4ohnZFkmvZpGcp5c0t5kJSNCUzdd7r1hcYNQD6HVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708932; c=relaxed/simple;
	bh=WLbdJgOrR1zIhVlKpiURLXtl/ud8TCDsGSsPBVapp40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br4ogLXet654tC8AJM1mu2Mf7ytkC/h0lk6UjQc5fmIF+MoVi/o/renJxnCe4FQ1XjwC3ov6vq/mf0ICG0KuXknpB5DdaSdzrbiIx4WfPFRiTiLvnAMlVlLtcbPpgnnpWm1BSAWqqx7H9QJaIJq8rqOCFLmcp4W2j3Yp0/FvM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClfSawbj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d51055097so7888f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708929; x=1730313729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnCz4Gz0DfA3iJQbcwkn7pdP+4IKH3HjV3Yhmz6VCSY=;
        b=ClfSawbjypELjLtKEF7+iLzkCHQGuJbxgdFFvxPK2jlSzA00CSbfgiWtrZjMC7cEoZ
         hQeCtGr26bO3K+El+3dAegU1Qdw1buSFUbXnrjFEPTveyB1SU2KfcdkD4x96C/xowk9h
         pwSaYe3PdxUCYOmuO9MTPWFa2I53eugs6uMr1drRGvIIwpoP34FaDJ8rbljaHxM7McBy
         2RwlUgFLLB5imv344M6F0KXi+Hwu5p+21YODtWxVHswYcVneqfOd0j83c421lsX4LmDD
         rvvHtes1Vy0GGVpzXYJA7tlkhDdtReBMT+FMiDSgBLxam1qltYX4aiIRj8IYic/RA4eX
         8FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708929; x=1730313729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnCz4Gz0DfA3iJQbcwkn7pdP+4IKH3HjV3Yhmz6VCSY=;
        b=cSSaqZuXmr+PHulUHZb0kSa0FhsBvy1e1+pPeKiCz3tw0cmeSTuFAomNz5uPENfl7n
         B2jPFIMjMc5SmIJ8rmaBrERoflC/1IfM2mO9kk7jCj6j9dxd4VASNfW03NZxHpxghzi5
         h7l/s9b08IDWM0DK/l1ZXFVibexEQRwjMKziVkgvwq7Ix+4byFRp+rjHmjGzJEplLUK2
         RjATlMGxUV2viHIs2KVd3sZmvtpntW52OI+wfgYXUE3nEgt8kSC3bAdv09FCkY+Yt5Pn
         QZFlf6jLzcFaYSlAKgptAzxGb9flgBhkcrf9e0eTVngR5AI677bkNMj6lzBOtS7ZKRuw
         bO/g==
X-Forwarded-Encrypted: i=1; AJvYcCXNOD/vVC8pj/87uBo9Sill4NSNsN+tk85BTcLpJJv62kb+G8rLMDaO00zLC0JNYNIo/hmCknbsVrBMqwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1Yebplkoyjtp1mCbZgKu4FU9vjNUUuN0sRwS7IJfYpqN5uTq
	R2PPQmp57gNxRUf9qmXhqM8RpQP/+JhZGUlfj01RHgQmDMlFZlBc0jd/pJ7ihjSoVyzJtZZCPTL
	oueYLCMZ7M62B1nbjTxewPPSmpjw=
X-Google-Smtp-Source: AGHT+IGg7n7i3SyqRuIa/xhUMj1hN55mZB4j6qxgVsau7X+77BU2sb51xczx42QYuNHR1RsEnbwZOc1YeDhSyzlxoHQ=
X-Received: by 2002:a5d:5257:0:b0:37d:614e:2bc5 with SMTP id
 ffacd0b85a97d-37efcf1dbb3mr2066652f8f.29.1729708928528; Wed, 23 Oct 2024
 11:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022015913.3524425-1-samuel.holland@sifive.com> <20241022015913.3524425-2-samuel.holland@sifive.com>
In-Reply-To: <20241022015913.3524425-2-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 23 Oct 2024 20:41:57 +0200
Message-ID: <CA+fCnZeBEe3VWm=VfYvG-f4eh2jAFP-p4Xn4SLEeFCGTudVuEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] kasan: sw_tags: Use arithmetic shift for shadow computation
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
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/=
Transforms/Instrumentation/AddressSanitizer.cpp#L1316 [1]
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/=
Transforms/Instrumentation/HWAddressSanitizer.cpp#L895 [2]
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/=
Target/AArch64/AArch64AsmPrinter.cpp#L669 [3]
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Improve the explanation for how KASAN_SHADOW_END is derived
>  - Update the range check in kasan_non_canonical_hook()
>
>  arch/arm64/Kconfig              | 10 +++++-----
>  arch/arm64/include/asm/memory.h | 17 +++++++++++++++--
>  arch/arm64/mm/kasan_init.c      |  7 +++++--
>  include/linux/kasan.h           | 10 ++++++++--
>  mm/kasan/report.c               | 22 ++++++++++++++++++----
>  scripts/gdb/linux/mm.py         |  5 +++--
>  6 files changed, 54 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd9df6dcc593..6a326908c941 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -418,11 +418,11 @@ config KASAN_SHADOW_OFFSET
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
>         default 0xffffffffffffffff
>
>  config UNWIND_TABLES
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 0480c61dbb4f..a93fc9dc16f3 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -80,7 +80,8 @@
>   * where KASAN_SHADOW_SCALE_SHIFT is the order of the number of bits tha=
t map
>   * to a single shadow byte and KASAN_SHADOW_OFFSET is a constant that of=
fsets
>   * the mapping. Note that KASAN_SHADOW_OFFSET does not point to the star=
t of
> - * the shadow memory region.
> + * the shadow memory region, since not all possible addresses have shado=
w
> + * memory allocated for them.

I'm not sure this addition makes sense: the original statement was to
point out that KASAN_SHADOW_OFFSET and KASAN_SHADOW_START are
different values. Even if we were to map shadow for userspace,
KASAN_SHADOW_OFFSET would still be a weird offset value for Generic
KASAN.

>   *
>   * Based on this mapping, we define two constants:
>   *
> @@ -89,7 +90,15 @@
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

This looks good!

>   *
>   * KASAN_SHADOW_START is defined second based on KASAN_SHADOW_END. The s=
hadow
>   * memory start must map to the lowest possible kernel virtual memory ad=
dress
> @@ -100,7 +109,11 @@
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
> index 00a3bf7c0d8f..03b440658817 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -58,8 +58,14 @@ int kasan_populate_early_shadow(const void *shadow_sta=
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
> index b48c768acc84..c08097715686 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -644,15 +644,29 @@ void kasan_report_async(void)
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
> +        * For Generic KASAN, the displacement is unsigned, so
> +        * KASAN_SHADOW_OFFSET is the smallest possible shadow address. F=
or

This part of the comment doesn't seem correct: KASAN_SHADOW_OFFSET is
still a weird offset value for Generic KASAN, not the smallest
possible shadow address.

> +        * Software Tag-Based KASAN, the displacement is signed, so
> +        * KASAN_SHADOW_OFFSET is the center of the range.
>          */
> -       if (addr < KASAN_SHADOW_OFFSET)
> -               return;
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               if (addr < KASAN_SHADOW_OFFSET ||
> +                   addr >=3D KASAN_SHADOW_OFFSET + max_shadow_size)
> +                       return;
> +       } else {
> +               if (addr < KASAN_SHADOW_OFFSET - max_shadow_size / 2 ||
> +                   addr >=3D KASAN_SHADOW_OFFSET + max_shadow_size / 2)
> +                       return;

Hm, I might be wrong, but I think this check does not work.

Let's say we have non-canonical address 0x4242424242424242 and number
of VA bits is 48.

Then:

KASAN_SHADOW_OFFSET =3D=3D 0xffff800000000000
kasan_mem_to_shadow(0x4242424242424242) =3D=3D 0x0423a42424242424
max_shadow_size =3D=3D 0x1000000000000000
KASAN_SHADOW_OFFSET - max_shadow_size / 2 =3D=3D 0xf7ff800000000000
KASAN_SHADOW_OFFSET + max_shadow_size / 2 =3D=3D 0x07ff800000000000 (overfl=
ows)

0x0423a42424242424 is < than 0xf7ff800000000000, so the function will
wrongly return.

> +       }
>
>         orig_addr =3D (unsigned long)kasan_shadow_to_mem((void *)addr);
>

Just to double-check: kasan_shadow_to_mem() and addr_has_metadata()
don't need any changes, right?

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
> --
> 2.45.1
>

Could you also check that everything works when CONFIG_KASAN_SW_TAGS +
CONFIG_KASAN_OUTLINE? I think it should, be makes sense to confirm.

Thank you!

