Return-Path: <linux-kernel+bounces-522705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED90A3CDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C7B189C395
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66651DFD9E;
	Wed, 19 Feb 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPelM+Y7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBCE1D63E6;
	Wed, 19 Feb 2025 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007882; cv=none; b=XhCp3UvWf9bW7lGec9UoyZNN6Fr3PTPvfV+k7dc7scF9+lEkECdnv3T/zCPhyrfb/zIMiXlh5b6+LVJbKm3rBYg9JRsA4feLhylxqsAgMa2V0cHvWxE0ZxqECLmCbiNXXVaBrGwYQKhjaoEJuVp5JQ7vuHIOxzRaFPjZMO9yNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007882; c=relaxed/simple;
	bh=rMgKxZ4ZahTbglHoNqDFuMUuM02hCXLuuITwQ77HEZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnLHVF0B8NsZAvQj+45Fbb0vwnmDlPQPa+werkJ7DyoFcAFrm6hyzDcPchv1lJRPn+/VPPdC2Z6st/bAfXr/elbWMBNIvTUf2li3zZak91Ui7t0HqzlWg4Wi3LYkKNIHFKujjmmb2k9/NIxvDbucsMQgkkmw3DmINxzeunmuE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPelM+Y7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so1795715e9.1;
        Wed, 19 Feb 2025 15:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007879; x=1740612679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTgTbeY1aqQKxUER4SE5xysBw6pVVMa23Uc6KxK62yU=;
        b=JPelM+Y7ij3GccqmNr5ndw6GYO1v1sqmkd38Kfi6rQnUfk0BDvo3uZQXIjMJS711mu
         hNlYJJSltHR1BcFPHGj9vd+7AyYeAAyi4haS47R1raPgxUqymHAswRjvREsAlsBgOy3O
         96TpDV077VLJE/Pi4TqtWrqH6Psp/GNYjlzD3VmPdxQYD9rhkbefT5EoNWkUE073z0VJ
         U68Jl5UGRLQMweyd+y/C24uoR+uqywx6GhT7r2jaCjJVlr4FLQT1/yManQDCU64I9udy
         K3TmPlqXVVL58KN1tRZDp8YjUZtAe8/xt0GLJ8/MM6R6EHj6tII13xne8ryUJ+gBVp1t
         14qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007879; x=1740612679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTgTbeY1aqQKxUER4SE5xysBw6pVVMa23Uc6KxK62yU=;
        b=Jwp07sJkuGdocqZz6oVNVF8o4WP3ZSnSevid+k4QKXHFpIySpIx6sPtBFbr2DYU0nn
         SSMacT8vSU3YP1Rr9ZntJ9sQukjXTShYsF5+AeFMt5A3Vp29BPynPiJQy02GaMWl73hb
         ZjvFuWE3k2xrDP8w8HxDWUky4C+8zsjiBNKNykiDDylarZX/8rU5EHX0LXSOeGBncfcX
         ttDXE5WrUB/CNfC70kyrSplxZnd0mPt6LfTBZUrBxyC36wNcCqqADifo18bBckBsA8kP
         PwioAq9XF70nHUogbM+uUDXpO9gLBIG9SPHaYn8tOTHWgcgSyfaXbZ8cXvyxB4/uA3nf
         aQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2PTqUW4FWbY9a4IOCkp35Pkiv21jv+fvweLs+HGSKoo+QeHRQlIprp9zmOe2gjwme5+PmtMr1CYs=@vger.kernel.org, AJvYcCXMn0ljcHP2hmupStSAFWdFMCIImp3eh+nF/sdU9KeYY23LzD1/CdUJMhj84ozg5UQ5xx2kmeqlxa8NZZj3@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtMEI6KYXOrrsvV4ITib+jq58AdnpCinzHcNsl8bkELRkCdJP
	XCYwQooBnxKcrgxf586puzGlc/GsFMqk12OEx/kTgJ2EyJ2Jys9vsGniBRnXfSXXqVr0LhFfc3a
	wS4JBUEF5ndZTqjpTiPObVpt9u3g=
X-Gm-Gg: ASbGnctEfBnvoTYG475lZ1QRgtwFIQY+rEVnVSXzYGp3WswsiB5K1bsJ8pMrM6xaJlB
	r8vUaHXQWo9F+DY/FT0S2LTVOW99AwW2jgIs3vw4SZv+DF87WZhdDWlggCdM5kwbMRp2tTWY2Qi
	Q=
X-Google-Smtp-Source: AGHT+IEl3UvjpiwtEnmlDQTet+PBKHLtJ16WAlVVzlEf6w0KVNsCxCG+Ab88rtPhr5IPReIvRJDIdU/sadxjpPRNqdc=
X-Received: by 2002:a05:6000:1844:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-38f4d400751mr11293670f8f.9.1740007878898; Wed, 19 Feb 2025
 15:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:31:08 +0100
X-Gm-Features: AWEUYZkbmdm-WfLa0PA56ZfKvrD8Lj6e3So80KOsOkQ_JlKSdX3epi4Hoik-GnA
Message-ID: <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
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

On Tue, Feb 18, 2025 at 9:20=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> On x86, generic KASAN is setup in a way that needs a single
> KASAN_SHADOW_OFFSET value for both 4 and 5 level paging. It's required
> to facilitate boot time switching and it's a compiler ABI so it can't be
> changed during runtime.
>
> Software tag-based mode doesn't tie shadow start and end to any linear
> addresses as part of the compiler ABI so it can be changed during
> runtime.

KASAN_SHADOW_OFFSET is passed to the compiler via
hwasan-mapping-offset, see scripts/Makefile.kasan (for the INLINE
mode). So while we can change its value, it has to be known at compile
time. So I don't think using a runtime constant would work.

Which means that KASAN_SHADOW_OFFSET has to have such a value that
works for both 4 and 5 level page tables. This possibly means we might
need something different than the first patch in this series.

But in case I'm wrong, I left comments for the current code below.

> This notion, for KASAN purposes, allows to optimize out macros
> such us pgtable_l5_enabled() which would otherwise be used in every
> single KASAN related function.
>
> Use runtime_const infrastructure with pgtable_l5_enabled() to initialize
> the end address of KASAN's shadow address space. It's a good choice
> since in software tag based mode KASAN_SHADOW_OFFSET and
> KASAN_SHADOW_END refer to the same value and the offset in
> kasan_mem_to_shadow() is a signed negative value.
>
> Setup KASAN_SHADOW_END values so that they're aligned to 4TB in 4-level
> paging mode and to 2PB in 5-level paging mode. Also update x86 memory
> map documentation.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Change documentation kasan start address to non-dense values.
>
>  Documentation/arch/x86/x86_64/mm.rst |  6 ++++--
>  arch/x86/Kconfig                     |  3 +--
>  arch/x86/include/asm/kasan.h         | 14 +++++++++++++-
>  arch/x86/kernel/vmlinux.lds.S        |  1 +
>  arch/x86/mm/kasan_init_64.c          |  5 ++++-
>  5 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/arch/x86/x86_64/mm.rst b/Documentation/arch/x8=
6/x86_64/mm.rst
> index f2db178b353f..5014ec322e19 100644
> --- a/Documentation/arch/x86/x86_64/mm.rst
> +++ b/Documentation/arch/x86/x86_64/mm.rst
> @@ -60,7 +60,8 @@ Complete virtual memory map with 4-level page tables
>     ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unus=
ed hole
>     ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual =
memory map (vmemmap_base)
>     ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unus=
ed hole
> -   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN sh=
adow memory
> +   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN sh=
adow memory (generic mode)
> +   fffff40000000000 |   -8    TB | fffffc0000000000 |    8 TB | KASAN sh=
adow memory (software tag-based mode)
>    __________________|____________|__________________|_________|_________=
___________________________________________________
>                                                                |
>                                                                | Identica=
l layout to the 56-bit one from here on:
> @@ -130,7 +131,8 @@ Complete virtual memory map with 5-level page tables
>     ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unus=
ed hole
>     ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual =
memory map (vmemmap_base)
>     ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unus=
ed hole
> -   ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN sh=
adow memory
> +   ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN sh=
adow memory (generic mode)
> +   ffe0000000000000 |   -6    PB | fff0000000000000 |    4 PB | KASAN sh=
adow memory (software tag-based mode)
>    __________________|____________|__________________|_________|_________=
___________________________________________________
>                                                                |
>                                                                | Identica=
l layout to the 47-bit one from here on:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6df7779ed6da..f4ef64bf824a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -400,8 +400,7 @@ config AUDIT_ARCH
>
>  config KASAN_SHADOW_OFFSET
>         hex
> -       depends on KASAN
> -       default 0xdffffc0000000000
> +       default 0xdffffc0000000000 if KASAN_GENERIC

Let's put a comment here explaining what happens if !KASAN_GENERIC.

Also, as I mentioned in the first patch, we need to figure out what to
do with scripts/gdb/linux/kasan.py.

>
>  config HAVE_INTEL_TXT
>         def_bool y
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index a75f0748a4b6..4bfd3641af84 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -5,7 +5,7 @@
>  #include <linux/const.h>
>  #include <linux/kasan-tags.h>
>  #include <linux/types.h>
> -#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +
>  #define KASAN_SHADOW_SCALE_SHIFT 3
>
>  /*
> @@ -14,6 +14,8 @@
>   * for kernel really starts from compiler's shadow offset +
>   * 'kernel address space start' >> KASAN_SHADOW_SCALE_SHIFT
>   */
> +#ifdef CONFIG_KASAN_GENERIC
> +#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>  #define KASAN_SHADOW_START      (KASAN_SHADOW_OFFSET + \
>                                         ((-1UL << __VIRTUAL_MASK_SHIFT) >=
> \
>                                                 KASAN_SHADOW_SCALE_SHIFT)=
)
> @@ -24,12 +26,22 @@
>  #define KASAN_SHADOW_END        (KASAN_SHADOW_START + \
>                                         (1ULL << (__VIRTUAL_MASK_SHIFT - =
\
>                                                   KASAN_SHADOW_SCALE_SHIF=
T)))
> +#endif
> +
>
>  #ifndef __ASSEMBLY__
> +#include <asm/runtime-const.h>
>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +extern unsigned long KASAN_SHADOW_END_RC;
> +#define KASAN_SHADOW_END       runtime_const_ptr(KASAN_SHADOW_END_RC)
> +#define KASAN_SHADOW_OFFSET    KASAN_SHADOW_END
> +#define KASAN_SHADOW_START     (KASAN_SHADOW_END - ((UL(1)) << (__VIRTUA=
L_MASK_SHIFT - KASAN_SHADOW_SCALE_SHIFT)))

Any reason these are under __ASSEMBLY__? They seem to belong better
together with the CONFIG_KASAN_GENERIC definitions above.

> +#endif
> +
>  #define arch_kasan_set_tag(addr, tag)  __tag_set(addr, tag)
>  #define arch_kasan_reset_tag(addr)     __tag_reset(addr)
>  #define arch_kasan_get_tag(addr)       __tag_get(addr)
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 0deb4887d6e9..df6c85f8f48f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -353,6 +353,7 @@ SECTIONS
>
>         RUNTIME_CONST_VARIABLES
>         RUNTIME_CONST(ptr, USER_PTR_MAX)
> +       RUNTIME_CONST(ptr, KASAN_SHADOW_END_RC)
>
>         . =3D ALIGN(PAGE_SIZE);
>
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index 299a2144dac4..5ca5862a5cd6 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -358,6 +358,9 @@ void __init kasan_init(void)
>         int i;
>
>         memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
> +       unsigned long KASAN_SHADOW_END_RC =3D pgtable_l5_enabled() ? 0xff=
f0000000000000 : 0xfffffc0000000000;

I think defining these constants in arch/x86/include/asm/kasan.h is
cleaner than hardcoding them here.







> +
> +       runtime_const_init(ptr, KASAN_SHADOW_END_RC);
>
>         /*
>          * We use the same shadow offset for 4- and 5-level paging to
> @@ -372,7 +375,7 @@ void __init kasan_init(void)
>          * bunch of things like kernel code, modules, EFI mapping, etc.
>          * We need to take extra steps to not overwrite them.
>          */
> -       if (pgtable_l5_enabled()) {
> +       if (pgtable_l5_enabled() && !IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
>                 void *ptr;
>
>                 ptr =3D (void *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW=
_END));
> --
> 2.47.1
>

