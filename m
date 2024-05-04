Return-Path: <linux-kernel+bounces-168695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B68BBC4C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC981F21D4E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94F39FEB;
	Sat,  4 May 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BB+6xw/u"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE924B2A
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714830889; cv=none; b=a7JBmNeExvxQBCMwh86enlsKjjFThBhII6iOXI+T1sGnNCyzoNKyx9Qq9MYNPT+n2V0UUplQlymXOJ7mHw6JKXvxyk6A3BzOFOmVyAKHWYxfHfDIpZvVtjJXmg+35fAw5LzxjaAdfbrppzDJqBeF69Sj4o7eeWPt2hNWWHEtVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714830889; c=relaxed/simple;
	bh=3iKg45ushSHq8F9OfPaFQFgDANImax1q6EdgzZEUgmY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1E+0z3UJ728WyJlChl+5/RARfAcEnTxS8vbWyrvHIEnTPRhDRz3UWu2+5SFMMIBlvFXtQ1fcvulmjQIaktMdy27vmfuAFbPNkcmpZywLHLhJfDW/nqBVzmWC44zusG/Ap2/Av57x1Cdd6z/k+BTFVJVoyaqIf5oyhjj2a3c3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BB+6xw/u; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 340C83FE4F
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714830880;
	bh=0WjRr/tkWkr3Xh5WFmNS0edjBe9cmHkmJf/+9+FPMJg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BB+6xw/uWxLkIzEvgENzaWGM8KqG7FVp0MsjiXSevEnYiZj5GAFm+YoYWWZhpZNBT
	 2f9IUJ+hU9HQaELEY/jrfxrGrjUnbP2JcRTDUDl+eszJMUXkmyC4xmrbxrO0ffW1m5
	 kjNhKaMU/LCMFowSnAPF8X+oJbEdio90phQby4Mzp+ej7Y6wLoYqjIdyd8ooIX0yL2
	 zN6C+x1QaQCcWgoGp0Nkh8aSrqQgpHKKpoXzISuMeAmdoiPVHVl/9sKmoL8i9RcnLl
	 GV0xWXuLOvZnkLKloR2qpHrPPykIyH7LIp3oo1sjDzfPk5NVA79szNzzkNevUBm/Ic
	 fNkkB32YHjv+g==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43d1c57e0b2so4963321cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 06:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714830879; x=1715435679;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0WjRr/tkWkr3Xh5WFmNS0edjBe9cmHkmJf/+9+FPMJg=;
        b=n0KJizGPnmCRzUQizHGGKZbahjlAnRM/lngMLaWFMMk5xmswgWH8PmTVtlfy1tIJEy
         bEmmCQ80rZB9xGtbW3vz2F4XVH4arBkuhFaSDzXh7p9r69HmENlSYOfMZWnzU1EW768r
         ZKvEeIffHXBgS3C2+SaEM3lgC6O7CcxBrj9n7zjUOrmQadDh78KM2rn/ClhVMiu6w3d+
         7trjLAPfK8csYjrXtW8RrTGCRlu6taMTSvwrizcCvfRuf07bkrH+G6BFPoEOrfVTdewZ
         NrAmBoHyFCRqljHHOkh4AnpTzYdB2WyP2DrnHL08nI02C0iodIZs+8cJ9UCTZ4Cq+8tR
         mr3g==
X-Forwarded-Encrypted: i=1; AJvYcCUsrN8QF9xOcbsiL3wdBtM+lDeNLE6b+oq+XH4dMEdI7DOTcDyvHyXn72ow/fS5z/kalDccHg32CGnuzd0ILDY5WU4U/mkoE/uOj6Pf
X-Gm-Message-State: AOJu0YzHRGiBA+Yr2l6p3cdFZBoLWXyYB7759BBqUOvryJKBT0tRlH8y
	Jn9sNeN1UjNVeUZAjcbOzRm5V/g2EjEeUbDuL7dO8Y6wjPVwzAjELy/1FuDd0P5Z6o05Ed2pZa8
	abOsBAm5E2yDFsRJS3Nb9S2Suq7dwT4zZ/t841sbfK1nJ2tu2zvguj7k5PmgRS/lf3yz01FZUa7
	1QKirqDcgCJjCaC0qIH89NXaPfCjqlGZ+3qcJJtPronipqHDmz/Z2f
X-Received: by 2002:a05:622a:296:b0:43a:b15c:e9cd with SMTP id z22-20020a05622a029600b0043ab15ce9cdmr5704950qtw.29.1714830878938;
        Sat, 04 May 2024 06:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgNUPmd8Omg8BY6DSgks9Q18f2l7AQMWWDiPcpdB91lbabuImXrnY7zD1n0VbloJMoBfZD97i+xKm67tXuC4k=
X-Received: by 2002:a05:622a:296:b0:43a:b15c:e9cd with SMTP id
 z22-20020a05622a029600b0043ab15ce9cdmr5704920qtw.29.1714830878391; Sat, 04
 May 2024 06:54:38 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 May 2024 13:54:37 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAK7LNASqwN1gd8TovcR3RDkxkE_M=BSDD5GoOoLOkDQnuNDAcA@mail.gmail.com>
References: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
 <20240502111613.1380453-2-emil.renner.berthing@canonical.com>
 <87ttjgcqjv.fsf@all.your.base.are.belong.to.us> <CAK7LNASqwN1gd8TovcR3RDkxkE_M=BSDD5GoOoLOkDQnuNDAcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 4 May 2024 13:54:37 +0000
Message-ID: <CAJM55Z-dorP1MgiCu=+VV_D+b6XXKWacUjT04QAsKvdmQtNv3g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] riscv: make image compression configurable
To: Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Masahiro Yamada wrote:
> On Thu, May 2, 2024 at 10:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
> >
> > Emil Renner Berthing <emil.renner.berthing@canonical.com> writes:
> >
> > > Previously the build process would always set KBUILD_IMAGE to the
> > > uncompressed Image file (unless XIP_KERNEL or EFI_ZBOOT was enabled) =
and
> > > unconditionally compress it into Image.gz. However there are already
> > > build targets for Image.bz2, Image.lz4, Image.lzma, Image.lzo and
> > > Image.zstd, so let's make use of those, make the compression method
> > > configurable and set KBUILD_IMAGE accordingly so that targets like
> > > 'make install' and 'make bindeb-pkg' will use the chosen image.
> > >
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> > > ---
> > >  arch/riscv/Kconfig         |  7 +++++++
> > >  arch/riscv/Makefile        | 43 ++++++++++++++++++++----------------=
--
> > >  arch/riscv/boot/install.sh |  9 +++++---
> > >  3 files changed, 36 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index be09c8836d56..6c092d1ea7db 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -138,6 +138,13 @@ config RISCV
> > >       select HAVE_GCC_PLUGINS
> > >       select HAVE_GENERIC_VDSO if MMU && 64BIT
> > >       select HAVE_IRQ_TIME_ACCOUNTING
> > > +     select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
> > > +     select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
> > > +     select HAVE_KERNEL_LZ4 if !XIP_KERNEL && !EFI_ZBOOT
> > > +     select HAVE_KERNEL_LZMA if !XIP_KERNEL && !EFI_ZBOOT
> > > +     select HAVE_KERNEL_LZO if !XIP_KERNEL && !EFI_ZBOOT
> > > +     select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
> > > +     select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
> > >       select HAVE_KPROBES if !XIP_KERNEL
> > >       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > >       select HAVE_KRETPROBES if !XIP_KERNEL
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 5b3115a19852..29be676415d6 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -129,11 +129,27 @@ endif
> > >  CHECKFLAGS +=3D -D__riscv -D__riscv_xlen=3D$(BITS)
> > >
> > >  # Default target when executing plain make
> > > -boot         :=3D arch/riscv/boot
> > > +boot :=3D arch/riscv/boot
> > >  ifeq ($(CONFIG_XIP_KERNEL),y)
> > >  KBUILD_IMAGE :=3D $(boot)/xipImage
> > > +else ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> > > +KBUILD_IMAGE :=3D $(boot)/loader.bin
> > > +else ifeq ($(CONFIG_EFI_ZBOOT),y)
> > > +KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
> > > +else ifeq ($(CONFIG_KERNEL_GZIP),y)
> > > +KBUILD_IMAGE :=3D $(boot)/Image.gz
> > > +else ifeq ($(CONFIG_KERNEL_BZIP2),y)
> > > +KBUILD_IMAGE :=3D $(boot)/Image.bz2
> > > +else ifeq ($(CONFIG_KERNEL_LZ4),y)
> > > +KBUILD_IMAGE :=3D $(boot)/Image.lz4
> > > +else ifeq ($(CONFIG_KERNEL_LZMA),y)
> > > +KBUILD_IMAGE :=3D $(boot)/Image.lzma
> > > +else ifeq ($(CONFIG_KERNEL_LZO),y)
> > > +KBUILD_IMAGE :=3D $(boot)/Image.lzo
> > > +else ifeq ($(CONFIG_KERNEL_ZSTD),y)
> > > +KBUILD_IMAGE :=3D $(boot)/Image.zst
> > >  else
> > > -KBUILD_IMAGE :=3D $(boot)/Image.gz
> > > +KBUILD_IMAGE :=3D $(boot)/Image
> > >  endif
> >
> > Really a nit/change if you want, but maybe doing something like
> > arch/s390/boot/Makefile does is easier to read:
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 024482c68835..70f08e9999b4 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -128,6 +128,14 @@ endif
> >  # arch specific predefines for sparse
> >  CHECKFLAGS +=3D -D__riscv -D__riscv_xlen=3D$(BITS)
> >
> > +suffix-$(CONFIG_KERNEL_GZIP)  :=3D .gz
> > +suffix-$(CONFIG_KERNEL_BZIP2) :=3D .bz2
> > +suffix-$(CONFIG_KERNEL_LZ4)  :=3D .lz4
> > +suffix-$(CONFIG_KERNEL_LZMA)  :=3D .lzma
> > +suffix-$(CONFIG_KERNEL_LZO)  :=3D .lzo
> > +suffix-$(CONFIG_KERNEL_XZ)  :=3D .xz
> > +suffix-$(CONFIG_KERNEL_ZSTD)  :=3D .zst
> > +
> >  # Default target when executing plain make
> >  boot :=3D arch/riscv/boot
> >  ifeq ($(CONFIG_XIP_KERNEL),y)
> > @@ -136,20 +144,8 @@ else ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CAN=
AAN),yy)
> >  KBUILD_IMAGE :=3D $(boot)/loader.bin
> >  else ifeq ($(CONFIG_EFI_ZBOOT),y)
> >  KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
> > -else ifeq ($(CONFIG_KERNEL_GZIP),y)
> > -KBUILD_IMAGE :=3D $(boot)/Image.gz
> > -else ifeq ($(CONFIG_KERNEL_BZIP2),y)
> > -KBUILD_IMAGE :=3D $(boot)/Image.bz2
> > -else ifeq ($(CONFIG_KERNEL_LZ4),y)
> > -KBUILD_IMAGE :=3D $(boot)/Image.lz4
> > -else ifeq ($(CONFIG_KERNEL_LZMA),y)
> > -KBUILD_IMAGE :=3D $(boot)/Image.lzma
> > -else ifeq ($(CONFIG_KERNEL_LZO),y)
> > -KBUILD_IMAGE :=3D $(boot)/Image.lzo
> > -else ifeq ($(CONFIG_KERNEL_ZSTD),y)
> > -KBUILD_IMAGE :=3D $(boot)/Image.zst
> >  else
> > -KBUILD_IMAGE :=3D $(boot)/Image
> > +KBUILD_IMAGE :=3D $(boot)/Image$(suffix-y)
> >  endif
>
>
>
>
> Good idea.
>
>
> If you avoid the 'else ifeq' chain completely,
> you also could do like this:
>
>
>
> boot-image-$(CONFIG_KERNEL_GZIP)         :=3D Image.gz
>    ...
> boot-image-$(CONFIG_KERNEL_ZSTD)         :=3D Image.zst
> boot-image-$(CONFIG_KERNEL_UNCOMPRESSED) :=3D Image
> boot-image-$(CONFIG_RISCV_M_MODE)        :=3D loader.bin
> boot-image-$(CONFIG_ARCH_CANAAN)         :=3D loader.bin
> boot-image-$(CONFIG_EFI_ZBOOT)           :=3D vmlinuz.efi
> boot-image-$(CONFIG_XIP_KERNEL)          :=3D xipImage
>
> KBUILD_IMAGE :=3D $(boot)/$(boot-image-y)

Hi Masahiro and Bj=C3=B6rn.

I like this approach. But I think it doesn't quite do the same when fx.
CONFIG_RISCV_M_MODE=3Dn but CONFIG_ARCH_CANAAN=3Dy which I think is a valid
configuration for the new Kendryte K230 support. In this case boot-image-y
would be overwritten with the loader.bin value even for S-mode kernels.

To keep the previous behaviour we'd need something like

  boot-image-$(CONFIG_RISCV_M_MODE *and* CONFIG_ARCH_CANAAN) :=3D loader.bi=
n

Maybe just

  ifeq ($(CONFIG_RISCV_M_MODE),y)
  boot-image-$(CONFIG_ARCH_CANAAN) :=3D loader.bin
  endif

Do you guys have a better solution?

/Emil

>
>
>
> Emil's current patch will work, of course.
>
>
>
>
> BTW, this patch will conflict with
> 3b938e231b660a278de2988ee77b832d665c5326
> It lands in riscv subsystem.

Oh, you're right. I'll rebase on that for v2, thanks.

/Emil

