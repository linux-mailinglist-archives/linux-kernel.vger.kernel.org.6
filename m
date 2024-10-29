Return-Path: <linux-kernel+bounces-387234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323539B4E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FB61F217EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C181194AEB;
	Tue, 29 Oct 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAEb+zbp"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7C191F7C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216600; cv=none; b=I/RFTR6sRpQqn0uyUgVPN9NmxVsmxhF3TrXpdGkQ/XT5BoQV+C7h92gU9r/GzVIxHUv1AkSXbaSG5UndlVcKFELAGhyv89hw7uO56GU31Wg2MnJwM1zUSxPoD6uUab23HKiBQdGe5wnfBl4CrOl2iVbEsQpEeRTFnwiSdzKooP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216600; c=relaxed/simple;
	bh=Wl4mh/rCkjPxDKFdcMywyjwxYYKsD57Ka6rrNntOThk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBM6dr7eKcAarVzONs2G9tQ28CeuQ58ESmRHQyPZ71pRqHQTrYOqb9F6s/ElnFXRNaHf4tGfNeH00kJLbF4q35azn+UosU+biLqk3Eepjlf4Uo6EKTzqOG7jOVRaKgVRSFDXoZT8gZOw+4zij6XHXWOA0Elit4P5LfOWGiDCwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAEb+zbp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso3059301a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216596; x=1730821396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhcIQpJ1IaeKRXa1HnFGErQ2YwEx8j6m+/AxbcPsv0o=;
        b=iAEb+zbpAyhUvPH72VwuncpWe5t1bl6Eu5NC2X+LPvpJkjKROnUdcKtc3DuimVhqnY
         KA2bLTarJkkWJEv0tdtY1W+eBYj9VSCNOQSv0bPex49td2gtenFqmURQi5bG3/nonsY9
         TG0jZoW5hmx3pJom7lNfmee3UjmXlZ85xBpQmF7OOZkv7tczESYINrsXc3gdFGkZAYVx
         9rqhHZwgRlyLpe2UDEmCX+KT19NpeMxzn7JLEB/rawCtIzmal94wm0kEB0eivfU3KhMD
         U4Qmp73aHhBpXBeg7H1c+K4jdVP/AAoEPJlBmtcYyIB5mD3AN2cMW3My7Kpu9PeiPtED
         QVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216596; x=1730821396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhcIQpJ1IaeKRXa1HnFGErQ2YwEx8j6m+/AxbcPsv0o=;
        b=tdDjP5QEX2dAX4SXljbvnH/+Nd81usAtjxtvHSjsFNWd0c8Q2mG9xkg6ymecjas0yD
         pTwj8DyG1TanM1oXaApuonVd9BhVSKtU/PwlSx3F+Nzg6I9OSCKSn2/dXbg6PHI0xQZU
         Ly1JnXH0YHLGJc1oemv30kA0RKO7Vu0DzpL9hUCiFsJBVyUfSLkXaKGBwfqvI8tRO4tx
         aesFVeq3KKseZLtNiFFJAVsudZQ3nqWd5hewaYEmkOqjCLQadz02FqCg0wQeUyQPYF9F
         4QbrxWJNQsgUHeJ/24vsvYUiGQckZlgXZvZo+DI8bw6YRXhLiO4/GXosz3tpnuFgFapH
         o/PA==
X-Forwarded-Encrypted: i=1; AJvYcCXoqb9SY544vjH8yXhaf9xSGeUHcuunju6OQMKMWw6AjKUZ66QM/6UkqKv2w6DUpb1uu/HMsHOCP8Q8Cks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BmVqp8j91WGE5kU/Wdp55RKDqpM+8eHfwSoN2ipJy00/UruE
	R8ERcRgBkK9RBGz3rDhfOeT3EwDsTkwXEfonVQHK5fO7furWGBdRELWjp3NBJvHpycuhJnXV5Ey
	SNV8K3m5l8JtTdbjT9nDhKxttbJRFAxPl
X-Google-Smtp-Source: AGHT+IHb5QK6poBquQTDAvxMF22pm9uNsacla4ytTbbmj5HwMECDKQOCfJeTdzlHxsToe9BWwGmFq9L4dtaIpMl/oDY=
X-Received: by 2002:a05:6402:348f:b0:5c9:34b4:69a8 with SMTP id
 4fb4d7f45d1cf-5cbbf889850mr14400108a12.6.1730216595849; Tue, 29 Oct 2024
 08:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com> <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 29 Oct 2024 08:43:04 -0700
Message-ID: <CAHbLzkqmDyOb9kwLKyKkThjT41UNCwb6p8XL6rEHVmvEbJEXZw@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 v3 4/5] mm: refactor arch_validate_flags() and
 arm64 MTE handling
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 6:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Currently MTE is permitted in two circumstances (desiring to use MTE havi=
ng
> been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
> checked by arch_calc_vm_flag_bits() and actualised by setting the
> VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in whic=
h
> case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activate=
d
> in mmap_region().
>
> The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also s=
et
> is the arm64 implementation of arch_validate_flags().
>
> Unfortunately, we intend to refactor mmap_region() to perform this check
> earlier, meaning that in the case of a shmem backing we will not have
> invoked shmem_mmap() yet, causing the mapping to fail spuriously.
>
> It is inappropriate to set this architecture-specific flag in general mm
> code anyway, so a sensible resolution of this issue is to instead move th=
e
> check to arch_validate_flags() itself.
>
> This requires a modification to the arch_validate_flags() signature to pa=
ss
> in a pointer to the struct file associated with the mapping, however this
> is not too egregious as this is only used by two architectures anyway -
> arm64 and sparc.
>
> So this patch performs this adjustment and moves the check to
> arch_validate_flags() which resolves the issue.
>
> We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, b=
ut
> we risk inadvertently changing behaviour as we do not have mmap() flags
> available at the point of the arch_validate_flags() check and a MAP_ANON =
|
> MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
> MAP_HUGETLB would not.
>
> This is likely an oversight but we want to try to keep behaviour identica=
l
> to before in this patch.
>
> So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets i=
f
> MAP_ANON.
>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() f=
ails")
> Cc: stable <stable@kernel.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/arm64/include/asm/mman.h | 29 +++++++++++++++++++++++++----
>  arch/sparc/include/asm/mman.h |  5 +++--
>  include/linux/mman.h          |  2 +-
>  mm/mmap.c                     |  2 +-
>  mm/mprotect.c                 |  2 +-
>  mm/shmem.c                    |  3 ---
>  6 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.=
h
> index 9e39217b4afb..94925a0482e3 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -6,7 +6,9 @@
>
>  #ifndef BUILD_VDSO
>  #include <linux/compiler.h>
> +#include <linux/fs.h>
>  #include <linux/types.h>
> +#include <linux/shmem_fs.h>
>
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>         unsigned long pkey)
> @@ -60,15 +62,34 @@ static inline bool arch_validate_prot(unsigned long p=
rot,
>  }
>  #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
>
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long =
vm_flags)
>  {
>         if (!system_supports_mte())
>                 return true;
>
> -       /* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
> -       return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
> +       if (!(vm_flags & VM_MTE))
> +               return true;
> +
> +       /*
> +        * We explicitly permit MAP_ANONYMOUS and shmem backed mappings t=
o use
> +        * MTE. We check for shmem explicitly here.
> +        *
> +        * The MAP_ANONYMOUS case is handled by arch_calc_vm_flag_bits() =
which
> +        * explicitly sets VM_MTE_ALLOWED which we check for here also.
> +        *
> +        * Ideally we'd perform both checks here but existing semantics s=
upport
> +        * hugetlb in MAP_ANONYMOUS mode but not a MAP_SHARED mapping, wh=
ich is
> +        * likely unintended but we maintain identical behaviour for
> +        * consistency.
> +        */
> +       if (vm_flags & VM_MTE_ALLOWED)
> +               return true;
> +       if (shmem_file(file))
> +               return true;

Sorry for chiming in late. This looks problematic IIUC. The patch 5/5
moved arch_validate_flags() before call_mmap() as the commit log said.
But shmem_file() does this check:
mapping->a_ops =3D=3D &shmem_aops

But mapping->a_ops is not initialized until shmem_mmap(), which is
called by call_mmap().

So shmem_file() should always return false here. Did I miss something?

> +
> +       return false;
>  }
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm=
_flags)
>
>  #endif /* !BUILD_VDSO */
>
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.=
h
> index af9c10c83dc5..d426e1f7c2c1 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -10,6 +10,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long =
len);
>
>  #ifdef CONFIG_SPARC64
>  #include <asm/adi_64.h>
> +#include <linux/fs.h>
>
>  static inline void ipi_set_tstate_mcde(void *arg)
>  {
> @@ -54,11 +55,11 @@ static inline int sparc_validate_prot(unsigned long p=
rot, unsigned long addr)
>         return 1;
>  }
>
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm=
_flags)
>  /* arch_validate_flags() - Ensure combination of flags is valid for a
>   *     VMA.
>   */
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long =
vm_flags)
>  {
>         /* If ADI is being enabled on this VMA, check for ADI
>          * capability on the platform and ensure VMA is suitable
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 8ddca62d6460..82e6488026b7 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -117,7 +117,7 @@ static inline bool arch_validate_prot(unsigned long p=
rot, unsigned long addr)
>   *
>   * Returns true if the VM_* flags are valid.
>   */
> -static inline bool arch_validate_flags(unsigned long flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long =
flags)
>  {
>         return true;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ab71d4c3464c..40b5858ae875 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1511,7 +1511,7 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>         }
>
>         /* Allow architectures to sanity-check the vm_flags */
> -       if (!arch_validate_flags(vma->vm_flags)) {
> +       if (!arch_validate_flags(file, vma->vm_flags)) {
>                 error =3D -EINVAL;
>                 goto close_and_free_vma;
>         }
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6f450af3252e..c6db98b893fc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -816,7 +816,7 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
>                 }
>
>                 /* Allow architectures to sanity-check the new flags */
> -               if (!arch_validate_flags(newflags)) {
> +               if (!arch_validate_flags(vma->vm_file, newflags)) {
>                         error =3D -EINVAL;
>                         break;
>                 }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ba1d00fabda..e87f5d6799a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_=
area_struct *vma)
>         if (ret)
>                 return ret;
>
> -       /* arm64 - allow memory tagging on RAM-based files */
> -       vm_flags_set(vma, VM_MTE_ALLOWED);
> -
>         file_accessed(file);
>         /* This is anonymous shared memory if it is unlinked at the time =
of mmap */
>         if (inode->i_nlink)
> --
> 2.47.0
>

