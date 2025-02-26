Return-Path: <linux-kernel+bounces-532720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3597CA4515D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47AE16C9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175C199BC;
	Wed, 26 Feb 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwAiiBn6"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CF611E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529285; cv=none; b=UAo1tEcg1Z7OwYqFxcgbKGaMXxSKolFoMOH3wag6X+nwfw1j/3DaaVa/xlWcidwvanmAE1ItthmcOaK2v6k9/qcsTPNanEtXnYJmeRLLKvTSlIWm5dj6Tyqe4R6w6HrnmHi1gzPUISroER91FIMWJQ9gazsZYMYlgfOyOi7Zack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529285; c=relaxed/simple;
	bh=voH9uXstSCKOftUa1R587pOuaD+6gGvBypetLTqzM74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjBfN+TZFdt4qeFZw0Sf08u+9hboQ9dgxR+qeU5Hzv9tFaxc9Qqy8GCbVBnI6fBUjPqto6L/SK9AHuqq5ovieT7nHR0fTW97h63GRzTOHu03qdnlp2rLQlMdP1KJKjQZHkLqgrTEjR8A6iMuQ9flOwfyZ9E1NohIvNPYpeS/NHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EwAiiBn6; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72726a5db1aso739817a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740529283; x=1741134083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7+1raIMQPaglzaGTumlpv6MCHAyLD6+J+LQuyLHZvQ=;
        b=EwAiiBn6NyiST56bliqfuICdzCmr0GuBtklB12GzY+3gBR41JEJZkBPUjUKjeVt6uk
         sGY3X6mRcb6Z6VBquFqC2Oy4JBfZC7w6+xFhvFSSVHmYJNoG9lqxfrCN9+/VLxo0W7B+
         Fuwe0oAGdAkKCkTW6hwSE9aEJ04r0sl4tiHjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740529283; x=1741134083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7+1raIMQPaglzaGTumlpv6MCHAyLD6+J+LQuyLHZvQ=;
        b=nBynBa4ulZAH3vpEzwGzeRhJtVJ5jPtTFrBV5UrhfCwrEsFe9F0sPg8M7H5tx1HBXP
         sP3mGyC/g0/946QOQ8+0wkdxHEjFYV0LCgUiidruCSHasws6BzegBOio//Q6AUYJ0gpo
         /kqIzFj0POK6xGntV2xX2s9BIVmL4MxNMfaRKQ9WzT14DJZMgVnZKniVi6WEYZDDDran
         XGUojAQK8Nut+Bdc2CrYZNRM9asyyiDN/e6TGYNZkpuIp4+efi7IkZvTTA978qvDqya3
         GeogXE0odZ7umLpArIhGTFYoQMQnt2Se339d7TjnRQYCAODGbJCcgYIizTppFhpM4DYx
         3wEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW924tcKLM2IzUWxoCkxd0P0DqMFQpd0/NXhgb3oNoe1wrs3kgGg+UVZ7NhRzpNPrYe0XTP2vJl2Mt6CWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwyV3q+cTAUFBMu92hWx1DJRJ4VOZ9k7AaKgltwDR7lzL/IUa
	EFvgYnVmKmS6DhpXKZ44yZb5g2Pwna5BzHbRIYF9PYmENOF7iPKFLJgv7bLgQ95rAScdpSFrXIh
	s6CqlCAjFGutwuqkZaHv69y9hdAanAj3yRsSF
X-Gm-Gg: ASbGncv4E8iy1Z1IHmqmyZWPVux4PR4ELnTpwHRDSXonEvwnE8hwppvizYR17nxiaL/
	b3x3H7L2PgG2f6C2nx0rCAugAsbW33e10053v497ddKa8f+ChUWbt8UjW5MNWyCOWMWv/S/P0+4
	rSRo4PzJhp5i62QsPvz2qGJde22w5xO3Zo/no=
X-Google-Smtp-Source: AGHT+IGY/afTPtHGu3S9iFPRBYMWvaVmp6AOJZ4waE968ELeWN3y78jCxYbne0VvSzzQbPe0wN0b9EYK+1gcKFKzcP8=
X-Received: by 2002:a05:6808:13c4:b0:3f4:1ba:9e89 with SMTP id
 5614622812f47-3f4246a145amr5505459b6e.1.1740529283456; Tue, 25 Feb 2025
 16:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-4-jeffxu@google.com>
 <202502241703.10E2F5926F@keescook>
In-Reply-To: <202502241703.10E2F5926F@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:21:11 -0800
X-Gm-Features: AQ5f1JraoweAReTNFgpv0N_8SgvtS5K7ko3SUH-S4TdSE7f4swI_E-wKBY547fU
Message-ID: <CABi2SkXEkhkQmO32GzR_3k1R7tNfLK_mM_4ekr-XwgrNqMFjOQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] mseal, system mappings: enable x86-64
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:03=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 10:52:42PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > covering the vdso, vvar, vvar_vclock.
> >
> > Production release testing passes on Android and Chrome OS.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  arch/x86/Kconfig          |  1 +
> >  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 87198d957e2f..8fa17032ca46 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -26,6 +26,7 @@ config X86_64
> >       depends on 64BIT
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> > +     select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > index 39e6efc1a9ca..1b1c009f20a8 100644
> > --- a/arch/x86/entry/vdso/vma.c
> > +++ b/arch/x86/entry/vdso/vma.c
> > @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >       struct mm_struct *mm =3D current->mm;
> >       struct vm_area_struct *vma;
> >       unsigned long text_start;
> > +     unsigned long vm_flags;
> >       int ret =3D 0;
> >
> >       if (mmap_write_lock_killable(mm))
> > @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *imag=
e, unsigned long addr)
> >       /*
> >        * MAYWRITE to allow gdb to COW and set breakpoints
> >        */
> > +     vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> > +     vm_flags |=3D VM_SEALED_SYSMAP;
> >       vma =3D _install_special_mapping(mm,
> >                                      text_start,
> >                                      image->size,
> > -                                    VM_READ|VM_EXEC|
> > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > +                                    vm_flags,
> >                                      &vdso_mapping);
>
> I think these (in all patches) were supposed to be reworked without the
> "vm_flags" variable addition?
>
OK.

> --
> Kees Cook

