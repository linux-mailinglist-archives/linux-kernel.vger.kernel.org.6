Return-Path: <linux-kernel+bounces-278195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A794AD2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A1283318
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6312C522;
	Wed,  7 Aug 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGaMxw2T"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F984D29
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045478; cv=none; b=XiD9m20ODf8D+Zsatp2XyZYBKjC/vsnHQhUOfotMkq4FzHzftaPF72wspN0/vz5E75ygg5MUYXvJnv0bk501/lmdHtHUQBgDt4sAK6Mo1as0DlJKnRRWbxwiYdN91p+o/Q3xdd8JaQMQBc/sfXkhWwNT31kQl8Uzqwk056EDGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045478; c=relaxed/simple;
	bh=d9IYZNLUv9jZ+J25pSNTy8o356pmUdcxeo/Rc6iGoz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSVQ5IMnlKQchnVqdXcAU44eRqR9DRL5bS3R0klCcALJBubNCKfTC4NuiiKxgIwK4YHqTpBmshighUyOVkDKZAGLlv7Gl2hvJTvRNTcNSsZFQ90SAmnZjYw7G0hz4VOvihezt4uhRZn0byC6vpV7YCCUQCZRhuXqJ8I50PoO6cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGaMxw2T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so33189a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723045475; x=1723650275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgojAL76gtXcG5WMdxnB/FzxmrNqVGWIbcYNJ79HH/I=;
        b=lGaMxw2TReB/VenEKVimzJ4fp1p9IlqvQ9XsStts9ggyUBwOEAhMeEtRcVLxg5arvi
         2DGcRutkwcXCipfowaqZSzDYb0c1CMd8TWUjYjCjdm3XvkXJsnP6bCewbUP6vxn0K8is
         IXQCsKHHNieg3SW+mpx8QNLabh+c6MJH0tKzWkSz8RnHILTJtfzNnnIkwyYbHrG1yWFB
         18OXovt8tfeHBtaQaXpHiVgaSsudYl/nKG+OC9Z3uqywxnH0vsMBFTcrVJ8DkPG4CtwN
         0IrJmjBrrxAB8u8o/5wX4pTva27Yr1gkpPiJe2App1JemHTmzCxcGPzn55N6nkq1H+Ao
         O9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045475; x=1723650275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgojAL76gtXcG5WMdxnB/FzxmrNqVGWIbcYNJ79HH/I=;
        b=COMj1rSlxPnT0i+oEwESRIjpWqv1P0yzBw/2+BD8wr7wtNtbcqyhkz6wGyL3KRcMCf
         pBtyM6aAwdspghr+BLs8whdBbiarRVzClOIzMyxFwDolNsrxgamiqNtGe2Efil/s9RQ8
         4/l6TU/7krjscylcfXaEsZqJaryjj7URVRHUluuJaf9M8CO5VKNkByXSCVHy+zcARHsM
         pvY0M4Y0vpvHeZq+1UXc7cl8QosWni2wyJJlYua8sRcj+2ag0ypjwjQbQmnJu7/q2iuY
         ZuLTYdDUkr3qjoQ9AiaBvTF58g7FP7/AHdASIKCvMAb3kYzZXmIWKbKaKh7MaiwApQrs
         pQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2f+zVVw6u3Jo8hVJlvLtAVsp0880lWQfDC9BxujlqQvuyRVSF7lN3On+KT7mqsHRygq6uOJS47jhYiGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEq1F0cy6qaSVJUa5yIvt/leLP8mTnQro68iajsZhraN9jDuYu
	uLs47rHctCOl7HFiUB5WHBNWp5OeLfB45Q6WiDASCQ1WgGomHvO2xpQac9BVtWUTZF8V/iaYctI
	s8w4TzTLAmb6jmQ9+gqzv9NSYie9Qm05GGhmp
X-Google-Smtp-Source: AGHT+IFAd+Y2q73KAR99q5jxhm5yDjlmQ2pPZj6irk4D1k87HYzP34Wk4BrB5n4Gw2L328GhKntkCHZgbPn3JLSGDmI=
X-Received: by 2002:a05:6402:84c:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bba28bb22amr213813a12.4.1723045474408; Wed, 07 Aug 2024
 08:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807124103.85644-1-mpe@ellerman.id.au> <20240807124103.85644-2-mpe@ellerman.id.au>
In-Reply-To: <20240807124103.85644-2-mpe@ellerman.id.au>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 08:43:57 -0700
Message-ID: <CALmYWFsCrMxkA1v58fJxtyGR15ZGxmSP8x7QC=oeKwzcwGL76A@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@chromium.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:41=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.au=
> wrote:
>
> Add a close() callback to the VDSO special mapping to handle unmapping
> of the VDSO. That will make it possible to remove the arch_unmap() hook
> entirely in a subsequent patch.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 ----
>  arch/powerpc/kernel/vdso.c             | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 37bffa0f7918..9b8c1555744e 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -263,10 +263,6 @@ extern void arch_exit_mmap(struct mm_struct *mm);
>  static inline void arch_unmap(struct mm_struct *mm,
>                               unsigned long start, unsigned long end)
>  {
> -       unsigned long vdso_base =3D (unsigned long)mm->context.vdso;
> -
> -       if (start <=3D vdso_base && vdso_base < end)
> -               mm->context.vdso =3D NULL;
>  }
>
>  #ifdef CONFIG_PPC_MEM_KEYS
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 7a2ff9010f17..220a76cae7c1 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -81,6 +81,21 @@ static int vdso64_mremap(const struct vm_special_mappi=
ng *sm, struct vm_area_str
>         return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
>  }
>
> +static void vdso_close(const struct vm_special_mapping *sm, struct vm_ar=
ea_struct *vma)
> +{
> +       struct mm_struct *mm =3D vma->vm_mm;
> +
> +       /*
> +        * close() is called for munmap() but also for mremap(). In the m=
remap()
> +        * case the vdso pointer has already been updated by the mremap()=
 hook
> +        * above, so it must not be set to NULL here.
> +        */
> +       if (vma->vm_start !=3D (unsigned long)mm->context.vdso)
> +               return;
> +
> +       mm->context.vdso =3D NULL;
> +}
> +
>  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>                              struct vm_area_struct *vma, struct vm_fault =
*vmf);
>
> @@ -92,11 +107,13 @@ static struct vm_special_mapping vvar_spec __ro_afte=
r_init =3D {
>  static struct vm_special_mapping vdso32_spec __ro_after_init =3D {
>         .name =3D "[vdso]",
>         .mremap =3D vdso32_mremap,
> +       .close =3D vdso_close,
IIUC, only CHECKPOINT_RESTORE requires this, and
CHECKPOINT_RESTORE is in init/Kconfig, with default N

Can we add #ifdef CONFIG_CHECKPOINT_RESTORE here ?

Thanks
Best regards,
-Jeff

>  };
>
>  static struct vm_special_mapping vdso64_spec __ro_after_init =3D {
>         .name =3D "[vdso]",
>         .mremap =3D vdso64_mremap,
> +       .close =3D vdso_close,
>  };
>
>  #ifdef CONFIG_TIME_NS
> --
> 2.45.2
>

