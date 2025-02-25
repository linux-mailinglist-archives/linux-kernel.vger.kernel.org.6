Return-Path: <linux-kernel+bounces-531529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51014A44193
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9614E3AE1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3B25EF8A;
	Tue, 25 Feb 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1JQTkvS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48026A1B4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491688; cv=none; b=ICNj/zNUCP7kwDoPV1HpOC778KOOIPWbaa9Ygh+DlUG613rVhsljGelGoe2XutHmXg9yE8l4YX1nrxnJ/mJkkPVw2Is9TEGD+ddEc3KEmyPhOlyGnYbvaBO3/O9fEZgx19iwSx3PMfXmhxn05IPhPRDHMnH0PnS9KXbTWwJCA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491688; c=relaxed/simple;
	bh=vyIMEhoWkDWIhVXis/B4QNwctOWV5r78Ozrs1+TFNB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rycQv1yMi9UxmHCKYYa0BmYBvOmAypBijdkn0rLv5Zdjt/Q9EEZPKBoVTTCT+okFLvMYtbQAjqA9JOKIWfRpvThncm7GNzqxlupTSyDybZpjWxEKMTT3ME13r33GHtHFw8jHQTxDM0AZwPfBZTb8cQ33CZZJCUbasEwPphoDxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1JQTkvS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30737db1ab1so44378361fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491684; x=1741096484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt22Uj9P8EXa9qt4Kxa7Trzk2rmyyCkKWPD6DZLKc/s=;
        b=j1JQTkvSOD50vxHFVuqyvaWnsvTN+2NSjHRm0L78sqcxepmhL3+J7woJ2da+q54YE0
         rndiHwOYWonFHSmviBLXO1rBS+8pmVgnlRxBgVeOZcRUn5Kj5mCRvInmH36Ue3Fh+09x
         J5tFeLz6lWaNXWnLrButDPTpYdunVqC8+H2Cm+eGQmzU4EW3ZtP4QHe0gjWXbdOELzYo
         /jiZ93rQcahDFnPGuFTu46coXgBrBgUZr5xJk1N15UpAD9lRhp1G/MTXewHhItFWEEt/
         bFpGGA8WdxokL2x7kL1p0YqV1LtKDhQRaGY9Aq75IlcDDC81Aqw/uuIXZSLItWOTu2fe
         rT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491684; x=1741096484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nt22Uj9P8EXa9qt4Kxa7Trzk2rmyyCkKWPD6DZLKc/s=;
        b=Axmiv+gOtCSbuYVnqnyBvb6etCK7G18G3GhfYyc/1MVioEdJ0vcf5v1dqD38M6IAjR
         QI7oUPmYoToVkGVfGtDPnqMtnnrqU2zrzv42VkyFIP8TDdtQxiS28I++2fk7a0cwtKU5
         /MdexVRLGesxwyvnXomLD58ToHzPDD6X5bD6LHdi4XupvO5etYbgbVJHVdJavHwTjxZN
         zpRdp9xrQJRKle1ZuwXXrgSfzuRq+3b29PRDdCNkMx+hRmitWikWRm7zskolFoslNmDS
         80bOTishzBzWDhAn97qgpNDh3JBlqvsCwubuyV2LZUVemX+OI/+BcrmwqmU0M4/pOmNV
         6V0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCAfDj3DiyXh+a1vRSw4607uCZsdoWu5o1sxvaAMeQbNpgxVx97p+CveeINJMs+yfzVeC8s6YRKv0YwlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBXFw0/LgmbGA4Avt5rYOF8fD0D4bSSAr5o1kiE7kJDByBMLZ
	nRjNTjqRfRMrEYgfl6az/yi3oHnbqRstQ16emDA0qMFEoCcoB11RKq140/WMoe+TFNh4rOuum+Q
	eSnZx3v/wxlLqCJPKdBdDmj5SW3y6lPd7tDq0
X-Gm-Gg: ASbGncuF/5dqHTixMYmjZ1usX0TQU7zQ0pzMNZSx+q3ZjV5QvxljPqDXrnc/mnFp7FU
	cLy3uV5iswGJFA9/YHLe+5hhn0upyCiWDRXDudyPy2ZYB+3klycPJk0TQgMaEbjjuYkJQZhaEFG
	bwWBFnP9jf8qqkv5ciunFnqZTDfAh1VSS5Xz2T9zz3
X-Google-Smtp-Source: AGHT+IE099rUEGDw84GZyKd+gxB5rpzp/kJT0cLkZw0eYuYqQNzKRFVJCCD2h2DL90YwMlYaabqZk53ofWC+VEYL5Og=
X-Received: by 2002:a2e:9089:0:b0:30a:4428:dea5 with SMTP id
 38308e7fff4ca-30a5b17138emr51865441fa.8.1740491684169; Tue, 25 Feb 2025
 05:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com> <68427864e0ca38af06482c96728216c3e0973418.1740403209.git.dvyukov@google.com>
 <c13c626d-344f-4d4b-a495-5006613f9bad@efficios.com>
In-Reply-To: <c13c626d-344f-4d4b-a495-5006613f9bad@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 25 Feb 2025 14:54:31 +0100
X-Gm-Features: AQ5f1Jqztd86z-kDvB4_cLfYwnMiKRq49kihcu9Cy6fteftkNoAF6jW8nZ2YwXg
Message-ID: <CACT4Y+Zq0MQ4cDHHpEEzEQenehzjX-qBw54htG8=yMwoKU=F2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pkeys: add API to switch to permissive/zero pkey register
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:04, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-24 08:20, Dmitry Vyukov wrote:
> > The API allows to switch to permissive pkey register that allows accesses
> > to all PKEYs, and to a value that allows acccess to the 0 (default) PKEY.
> > This functionality is already used in x86 signal delivery, and will be
> > needed for rseq.
>
> AFAIU the signal delivery uses the "allow access to all PKEYs"
> approach only, not the "allow access to 0-pkey". It would be
> good to clarify this in the commit message.

Done in v5.

> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >
> > ---
> > Changes in v4:
> >   - Added Fixes tag
> >
> > Changes in v3:
> >   - Renamed API functions to write_permissive_pkey_val/write_pkey_val
> >   - Added enable_zero_pkey_val for rseq
> >   - Added Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > Changes in v2:
> >   - Fixed typo in commit description
> > ---
> >   arch/x86/Kconfig             |  1 +
> >   arch/x86/include/asm/pkeys.h | 33 +++++++++++++++++++++++++++++++++
> >   arch/x86/include/asm/pkru.h  | 10 +++++++---
> >   include/linux/pkeys.h        | 31 +++++++++++++++++++++++++++++++
> >   mm/Kconfig                   |  2 ++
> >   5 files changed, 74 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index be2c311f5118d..43af2840d098f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1881,6 +1881,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
> >       depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> >       select ARCH_USES_HIGH_VMA_FLAGS
> >       select ARCH_HAS_PKEYS
> > +     select ARCH_HAS_PERMISSIVE_PKEY
> >       help
> >         Memory Protection Keys provides a mechanism for enforcing
> >         page-based protections, but without requiring modification of the
> > diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> > index 2e6c04d8a45b4..d6e35ab5c3d22 100644
> > --- a/arch/x86/include/asm/pkeys.h
> > +++ b/arch/x86/include/asm/pkeys.h
> > @@ -2,6 +2,8 @@
> >   #ifndef _ASM_X86_PKEYS_H
> >   #define _ASM_X86_PKEYS_H
> >
> > +#include "pkru.h"
> > +
> >   /*
> >    * If more than 16 keys are ever supported, a thorough audit
> >    * will be necessary to ensure that the types that store key
> > @@ -123,4 +125,35 @@ static inline int vma_pkey(struct vm_area_struct *vma)
> >       return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
> >   }
> >
> > +typedef u32 pkey_reg_t;
> > +
> > +static inline pkey_reg_t write_permissive_pkey_val(void)
> > +{
> > +     return write_pkru(0);
> > +}
> > +
> > +static inline pkey_reg_t enable_zero_pkey_val(void)
> > +{
> > +     u32 pkru;
> > +
> > +     if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> > +             return 0;
> > +     /*
> > +      * WRPKRU is relatively expensive compared to RDPKRU,
> > +      * avoid it if possible.
> > +      */
> > +     pkru = rdpkru();
> > +     if ((pkru & (PKRU_AD_BIT|PKRU_WD_BIT)) != 0)
> > +             wrpkru(pkru & ~(PKRU_AD_BIT|PKRU_WD_BIT));
> > +     return pkru;
> > +
> > +
> > +     return write_pkru(0);
>
> This is dead code. What I am missing ?

Done in v5.

> With those fixed, please keep my reviewed-by :)
>
> Thanks,
>
> Mathieu
>
> > +}
> > +
> > +static inline void write_pkey_val(pkey_reg_t val)
> > +{
> > +     write_pkru(val);
> > +}
> > +
> >   #endif /*_ASM_X86_PKEYS_H */
> > diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
> > index 74f0a2d34ffdd..b9bf9b7f2753b 100644
> > --- a/arch/x86/include/asm/pkru.h
> > +++ b/arch/x86/include/asm/pkru.h
> > @@ -39,16 +39,20 @@ static inline u32 read_pkru(void)
> >       return 0;
> >   }
> >
> > -static inline void write_pkru(u32 pkru)
> > +static inline u32 write_pkru(u32 pkru)
> >   {
> > +     u32 old_pkru;
> > +
> >       if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> > -             return;
> > +             return 0;
> >       /*
> >        * WRPKRU is relatively expensive compared to RDPKRU.
> >        * Avoid WRPKRU when it would not change the value.
> >        */
> > -     if (pkru != rdpkru())
> > +     old_pkru = rdpkru();
> > +     if (pkru != old_pkru)
> >               wrpkru(pkru);
> > +     return old_pkru;
> >   }
> >
> >   static inline void pkru_write_default(void)
> > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > index 86be8bf27b41b..262d60f6a15f8 100644
> > --- a/include/linux/pkeys.h
> > +++ b/include/linux/pkeys.h
> > @@ -48,4 +48,35 @@ static inline bool arch_pkeys_enabled(void)
> >
> >   #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> >
> > +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> > +
> > +/*
> > + * Common name for value of the register that controls access to PKEYs
> > + * (called differently on different arches: PKRU, POR, AMR).
> > + */
> > +typedef char pkey_reg_t;
> > +
> > +/*
> > + * Sets PKEY access register to the most permissive value that allows
> > + * accesses to all PKEYs. Returns the current value of PKEY register.
> > + * Code should generally arrange switching back to the old value
> > + * using write_pkey_val(old_value).
> > + */
> > +static inline pkey_reg_t write_permissive_pkey_val(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Sets PKEY access register to a value that allows access to the 0 (default)
> > + * PKEY. Returns the current value of PKEY register.
> > + */
> > +static inline pkey_reg_t enable_zero_pkey_val(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void write_pkey_val(pkey_reg_t val) {}
> > +#endif /* ! CONFIG_ARCH_HAS_PERMISSIVE_PKEY */
> > +
> >   #endif /* _LINUX_PKEYS_H */
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 1b501db064172..9e874f7713a2b 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1147,6 +1147,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
> >       bool
> >   config ARCH_HAS_PKEYS
> >       bool
> > +config ARCH_HAS_PERMISSIVE_PKEY
> > +     bool
> >
> >   config ARCH_USES_PG_ARCH_2
> >       bool
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

