Return-Path: <linux-kernel+bounces-202089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16ED8FC7B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC311C22BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE05113AD39;
	Wed,  5 Jun 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeHE8zzm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09E19004A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579351; cv=none; b=iFJBv3aN9N9dTPO08K0ebhOPSPNVrz3G4t7x6/XrJ+2SqvQ1SHfJFs7pUng3rdXQYUwhtcIJW+/HpWY2OUUiTi3mSBAR5z6EyOWm3QzA2Ql2Tep60y9C+yCzhAPR9FjVFrKzkNhPgFQWXez+FJz3X/yG16zTjYdcT/QPvbsQqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579351; c=relaxed/simple;
	bh=1YtaV0rlft0FwF0RnhQp6pXzXNMnsqwUp71/8fdJWYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6WwfO8wnXI44AubEwvTMetTWPMProhs4YpjZunsH/JoYQzYbUCUpc22IEFMya41uFhBLPwgT/oAaV4TjGpNenQqZEDN+GLdVINYkKeEGHqluiHxVxgoKq2afdYFG7POZMhtWI2ozeWvXZEXBWZ6srfiSEDzTQ/GKb0VGkLjFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeHE8zzm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaccc0979eso3049591fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579348; x=1718184148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VMsO98g6T+rFoaq3isAVnjASq1OTBZpOaxNXgac48g=;
        b=JeHE8zzmutzeamngTpHuLt522oIJJmKfm3SHMzXO4sczeCIZLjOhmOcd9Pw+twmTEJ
         qjR3X4Qr50Sfw/H1qMv6LCp6tqX02PshBYvzxWuy7/LWma9TLZNSqnldET56yZGhLeR0
         WVbBkdeZ/IdcUAsr6mXVnT9pRfJQZMvkD72lTc0DXZDr2gkFEWLOiOaXsfnyT0hW4Y+e
         vtUOcXXMvR08Pc8tcG2CxXh8R8OGuSzpGGCdcQor92FBXfYNjUboVfLjoGh7OorqI+yn
         tXsXK41Qcdw5I+BXctYfw98phY3Uz/0736beGKNqGBd6ZhMa9Z5SalCFd/lwN7CbD2Tp
         X5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579348; x=1718184148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VMsO98g6T+rFoaq3isAVnjASq1OTBZpOaxNXgac48g=;
        b=nbjIhuZqGH5D9XMOmg+FYtFT5V2tFZDC4k0XfKDndpDFV0POqhmLfjzTdIQ0ccxa3Z
         RHUGlV6glZWh9CtqFbsoDswuddkBzv6gP/h69RKKhKJKb900T18worc7oa8zvzEoREZf
         09Wo9hXpLv2f6Kx/c1wPX3WLYqKVWFL6O5l57UwMvFj7MpASe0qVFoKse2m6NqotOC9f
         QrMd0FuZ+t+8m0rJKcsz1u/QfvhO5vPONcFqeQ6I6H0B/ZB2gd4Qdy2+sgQdCsQts7ek
         lut56GcT2kpOtmFUPNB8hM79NM1+UpCl3BW0+BPPUH6/j+WeR2a2EZdsBZ4BEtBCcb8w
         35vw==
X-Gm-Message-State: AOJu0Yx5XMa5kdl2KP4K+A6pNSpwWfxqY4IyJ5Bug6bHoodzIjZLzASg
	N0RFTufjIMVJ1HF1k7KQSbRnNI3TrVt6Dz5NZn1M7MO8ptOsK9eIQmVOFsfYYwzuwv3DfNjh/gc
	neJUdNsxezQapTmMCpMuEFWAyMJ0=
X-Google-Smtp-Source: AGHT+IHqHTdbgQjlDQRgE5s43tJfb+esbUo0eviuUGiP6JNHiOuTWS7nads1ksv3fHGAiGsZ3qOkVo7oebCk06UJtww=
X-Received: by 2002:ac2:42cf:0:b0:52b:798e:74e8 with SMTP id
 2adb3069b0e04-52bab4e5540mr995815e87.39.1717579347414; Wed, 05 Jun 2024
 02:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605091710.38961-1-david@redhat.com>
In-Reply-To: <20240605091710.38961-1-david@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 17:22:13 +0800
Message-ID: <CAK1f24k5dLX_jTJZR+bBPGN812fQXx85YbcAya+84LgnEscbBg@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "mm: init_mlocked_on_free_v3"
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Wang <00107082@163.com>, Andrew Morton <akpm@linux-foundation.org>, 
	York Jasper Niebuhr <yjnworkstation@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:17=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> There was insufficient review and no agreement that this is the right
> approach.
>
> There are serious flaws with the implementation that make processes using
> mlock() not even work with simple fork() [1] and we get reliable crashes
> when rebooting.
>
> Further, simply because we might be unmapping a single PTE of a large
> mlocked folio, we shouldn't zero out the whole folio.
>
> ... especially because the code can also *corrupt* urelated memory becaus=
e
>         kernel_init_pages(page, folio_nr_pages(folio));
>
> Could end up writing outside of the actual folio if we work with a
> tail page.
>
> Let's revert it. Once there is agreement that this is the right approach,
> the issues were fixed and there was reasonable review and proper
> testing, we can consider it again.
>
> [1] https://lkml.kernel.org/r/4da9da2f-73e4-45fd-b62f-a8a513314057@redhat=
.com
>
> Fixes: ba42b524a040 ("mm: init_mlocked_on_free_v3")
> Reported-by: David Wang <00107082@163.com>
> Closes: https://lore.kernel.org/lkml/20240528151340.4282-1-00107082@163.c=
om/
> Reported-by: Lance Yang <ioworker0@gmail.com>
> Closes: https://lkml.kernel.org/r/20240601140917.43562-1-ioworker0@gmail.=
com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: York Jasper Niebuhr <yjnworkstation@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM.

Acked-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ---
>  include/linux/mm.h                            |  9 +---
>  mm/internal.h                                 |  1 -
>  mm/memory.c                                   |  6 ---
>  mm/mm_init.c                                  | 43 +++----------------
>  mm/page_alloc.c                               |  2 +-
>  security/Kconfig.hardening                    | 15 -------
>  7 files changed, 9 insertions(+), 73 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b600df82669db..11e57ba2985cc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2192,12 +2192,6 @@
>                         Format: 0 | 1
>                         Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
>
> -       init_mlocked_on_free=3D   [MM] Fill freed userspace memory with z=
eroes if
> -                               it was mlock'ed and not explicitly munloc=
k'ed
> -                               afterwards.
> -                               Format: 0 | 1
> -                               Default set by CONFIG_INIT_MLOCKED_ON_FRE=
E_DEFAULT_ON
> -
>         init_pkru=3D      [X86] Specify the default memory protection key=
s rights
>                         register contents for all processes.  0x55555554 =
by
>                         default (disallow access to all but pkey 0).  Can
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d43..9a5652c5fadd5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3776,14 +3776,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAU=
LT_ON, init_on_free);
>  static inline bool want_init_on_free(void)
>  {
>         return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
> -                               &init_on_free);
> -}
> -
> -DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_ml=
ocked_on_free);
> -static inline bool want_init_mlocked_on_free(void)
> -{
> -       return static_branch_maybe(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON=
,
> -                               &init_mlocked_on_free);
> +                                  &init_on_free);
>  }
>
>  extern bool _debug_pagealloc_enabled_early;
> diff --git a/mm/internal.h b/mm/internal.h
> index b2c75b12014e7..c72c306761a48 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -588,7 +588,6 @@ extern void __putback_isolated_page(struct page *page=
, unsigned int order,
>  extern void memblock_free_pages(struct page *page, unsigned long pfn,
>                                         unsigned int order);
>  extern void __free_pages_core(struct page *page, unsigned int order);
> -extern void kernel_init_pages(struct page *page, int numpages);
>
>  /*
>   * This will have no effect, other than possibly generating a warning, i=
f the
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f47a533014e4..2bc8032a30a2f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1507,12 +1507,6 @@ static __always_inline void zap_present_folio_ptes=
(struct mmu_gather *tlb,
>                 if (unlikely(folio_mapcount(folio) < 0))
>                         print_bad_pte(vma, addr, ptent, page);
>         }
> -
> -       if (want_init_mlocked_on_free() && folio_test_mlocked(folio) &&
> -           !delay_rmap && folio_test_anon(folio)) {
> -               kernel_init_pages(page, folio_nr_pages(folio));
> -       }
> -
>         if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))=
) {
>                 *force_flush =3D true;
>                 *force_break =3D true;
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f72b852bd5b8e..3ec04933f7fd8 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2523,9 +2523,6 @@ EXPORT_SYMBOL(init_on_alloc);
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
>  EXPORT_SYMBOL(init_on_free);
>
> -DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlo=
cked_on_free);
> -EXPORT_SYMBOL(init_mlocked_on_free);
> -
>  static bool _init_on_alloc_enabled_early __read_mostly
>                                 =3D IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAU=
LT_ON);
>  static int __init early_init_on_alloc(char *buf)
> @@ -2543,14 +2540,6 @@ static int __init early_init_on_free(char *buf)
>  }
>  early_param("init_on_free", early_init_on_free);
>
> -static bool _init_mlocked_on_free_enabled_early __read_mostly
> -                               =3D IS_ENABLED(CONFIG_INIT_MLOCKED_ON_FRE=
E_DEFAULT_ON);
> -static int __init early_init_mlocked_on_free(char *buf)
> -{
> -       return kstrtobool(buf, &_init_mlocked_on_free_enabled_early);
> -}
> -early_param("init_mlocked_on_free", early_init_mlocked_on_free);
> -
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
>
>  /*
> @@ -2578,21 +2567,12 @@ static void __init mem_debugging_and_hardening_in=
it(void)
>         }
>  #endif
>
> -       if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early =
||
> -           _init_mlocked_on_free_enabled_early) &&
> +       if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early)=
 &&
>             page_poisoning_requested) {
>                 pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -                       "will take precedence over init_on_alloc, init_on=
_free "
> -                       "and init_mlocked_on_free\n");
> +                       "will take precedence over init_on_alloc and init=
_on_free\n");
>                 _init_on_alloc_enabled_early =3D false;
>                 _init_on_free_enabled_early =3D false;
> -               _init_mlocked_on_free_enabled_early =3D false;
> -       }
> -
> -       if (_init_mlocked_on_free_enabled_early && _init_on_free_enabled_=
early) {
> -               pr_info("mem auto-init: init_on_free is on, "
> -                       "will take precedence over init_mlocked_on_free\n=
");
> -               _init_mlocked_on_free_enabled_early =3D false;
>         }
>
>         if (_init_on_alloc_enabled_early) {
> @@ -2609,17 +2589,9 @@ static void __init mem_debugging_and_hardening_ini=
t(void)
>                 static_branch_disable(&init_on_free);
>         }
>
> -       if (_init_mlocked_on_free_enabled_early) {
> -               want_check_pages =3D true;
> -               static_branch_enable(&init_mlocked_on_free);
> -       } else {
> -               static_branch_disable(&init_mlocked_on_free);
> -       }
> -
> -       if (IS_ENABLED(CONFIG_KMSAN) && (_init_on_alloc_enabled_early ||
> -           _init_on_free_enabled_early || _init_mlocked_on_free_enabled_=
early))
> -               pr_info("mem auto-init: please make sure init_on_alloc, i=
nit_on_free and "
> -                       "init_mlocked_on_free are disabled when running K=
MSAN\n");
> +       if (IS_ENABLED(CONFIG_KMSAN) &&
> +           (_init_on_alloc_enabled_early || _init_on_free_enabled_early)=
)
> +               pr_info("mem auto-init: please make sure init_on_alloc an=
d init_on_free are disabled when running KMSAN\n");
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>         if (debug_pagealloc_enabled()) {
> @@ -2658,10 +2630,9 @@ static void __init report_meminit(void)
>         else
>                 stack =3D "off";
>
> -       pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s, ml=
ocked free:%s\n",
> +       pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
>                 stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
> -               want_init_on_free() ? "on" : "off",
> -               want_init_mlocked_on_free() ? "on" : "off");
> +               want_init_on_free() ? "on" : "off");
>         if (want_init_on_free())
>                 pr_info("mem auto-init: clearing system memory may take s=
ome time...\n");
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e22ce5675ca1..a264eac20d1de 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1016,7 +1016,7 @@ static inline bool should_skip_kasan_poison(struct =
page *page)
>         return page_kasan_tag(page) =3D=3D KASAN_TAG_KERNEL;
>  }
>
> -void kernel_init_pages(struct page *page, int numpages)
> +static void kernel_init_pages(struct page *page, int numpages)
>  {
>         int i;
>
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index effbf5982be10..2cff851ebfd7e 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -255,21 +255,6 @@ config INIT_ON_FREE_DEFAULT_ON
>           touching "cold" memory areas. Most cases see 3-5% impact. Some
>           synthetic workloads have measured as high as 8%.
>
> -config INIT_MLOCKED_ON_FREE_DEFAULT_ON
> -       bool "Enable mlocked memory zeroing on free"
> -       depends on !KMSAN
> -       help
> -         This config has the effect of setting "init_mlocked_on_free=3D1=
"
> -         on the kernel command line. If it is enabled, all mlocked proce=
ss
> -         memory is zeroed when freed. This restriction to mlocked memory
> -         improves performance over "init_on_free" but can still be used =
to
> -         protect confidential data like key material from content exposu=
res
> -         to other processes, as well as live forensics and cold boot att=
acks.
> -         Any non-mlocked memory is not cleared before it is reassigned. =
This
> -         configuration can be overwritten by setting "init_mlocked_on_fr=
ee=3D0"
> -         on the command line. The "init_on_free" boot option takes
> -         precedence over "init_mlocked_on_free".
> -
>  config CC_HAS_ZERO_CALL_USED_REGS
>         def_bool $(cc-option,-fzero-call-used-regs=3Dused-gpr)
>         # https://github.com/ClangBuiltLinux/linux/issues/1766
>
> base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
> --
> 2.45.1
>

