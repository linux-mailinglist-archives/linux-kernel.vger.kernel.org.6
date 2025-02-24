Return-Path: <linux-kernel+bounces-529361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD272A42351
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50007189AFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601A158525;
	Mon, 24 Feb 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OtjotwbO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112812E5D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407667; cv=none; b=iD+wfTta9KZhUT4b/SXKATLTyjtt1OqHFgR6h7W9avx/dHC8aU8kvq6j0xvzkzI1mw9mrvAG7h4/5y8Gz6/jZvAK+zrfA89n7Ju6O2Lm0Tna8Pesp/p7Kdi4Gq5vpJPEW4XiIQ4Ig4plK/O/HRG1ew132y6rWw5Cen1J+PCpvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407667; c=relaxed/simple;
	bh=D2U5kxz+iEWEzhKwkkyPwINP2ogpE6Zf5GpbOpbaOEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAVQRIU/dtWiS7AiLBZe3T7SKPSZ6EMZWeMK2HI9yZspi0OPKswi6s+uKZ1usod8tG4unfa0yTjhCKxnLa/5RjNxCRAOy/f31w6tyiRHfE9FHAQHmqIwIzyag/E7HkMgQGHLMfaBwY/yyi2ikefH6nR9IlOKmXJTvrECfN36RWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OtjotwbO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so8028588a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740407663; x=1741012463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkQqnpwYqndRUX8UXmwWgcvggVsTxywAsyTI1tHWoEM=;
        b=OtjotwbO3ZbCAjbzwNmz5T1135xP7WeADK0W1mQVZQwF1wXvbprNUKzVjPiYWXut7Q
         O06u9MelSAcHmRjdBnjD1YFpN9xLQInPjvG1IubnCZaW89FwM+zFtu9mEsl8Q2whmh3X
         IDoVPw2EJKRBqSyrFh3dt7EHsfdpTh2sD4Jk8jnKNa0+4dHZPsIS7q4AQwrCQa2iSTfD
         PKUMmKpmU0EzhW4X0NLY77yLtj3vDSTee4EYAXaAzzKD5yRdUyEOxa08qcTfKFd+g8tU
         c5wImhwnhcYksWeubjTKPN+Jub5g2QdKh6vHiUa6IzLsoexJQDy0X6viLnarwzpvozyH
         Q9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407663; x=1741012463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkQqnpwYqndRUX8UXmwWgcvggVsTxywAsyTI1tHWoEM=;
        b=May8YTDjmk73+7SDF2mWH0OLT4B8pCpnzeddYSldiAO6aYo9U5nwzZuCobMuycqXq6
         dEueHppFSqBeSTt5BRgJBZYERxZRcAbOt6phzIrJKMDBnCA9GQXsCp42Z0I/sU74rbYn
         P8QB8GFCzzyfLMloxLEDaOCfpudLb0d04c5iKpC7MJwb8KLTy9PXy5YT7mpdyq2RfM0r
         8qnMXGFpLTWBf5OxxAXy3FBuVCDDz6gatmBkaFrK/mg/QnT3LW5etkYJQhi7+i1W7uNR
         AAzBiQarQ/LVHD7I7NZuuYYCzUNdlL9Dy5GGNTBPJTb6PCykLot1QUSNCJZt1AQ/Quq3
         hnfw==
X-Forwarded-Encrypted: i=1; AJvYcCWfJhG3z5TrVE2GG1hi6eTH4h+D0AEl4hsQoTptqPZxYpHD0C9VoEW/4UXPAZU1gHS4nGwGybVDQSdij/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUf14LIHoZcMa9xHgfUiXcPZvLzkGhVJaF9NJefdwnPT/7xPA2
	XmYS2COL5q8xYjAXHJX3WAE8AVxdwFxqSaIINskqCUm1Cv1f84qOz/ygbR0AB6kXjz6ATcME2K1
	HZiPr+FEBWk6bXIoARZncz/bJnyzBUqGlezJNffX3EVSvtRqdMFo=
X-Gm-Gg: ASbGncuVKswHnvMCTeOrO7UekB60mrtpbuI8jZWgX9VTW4D+h9J0ZkVhShZD0CJvdYa
	a/yzTvkTfy7cp8vbhZZ0Szle5Wk19Km5XymMoTfpk++hwN4TYR6srkxa7GX+f1zNT04wPkm0++M
	HZeqTnsaI=
X-Google-Smtp-Source: AGHT+IGwinAFCE/+cod9Wduw27y3lE5NvmD0zotgNUTu5vxJxVcMXBTXPbgxsG+pETb3Ou9qZ9ES5D869/jPdRTLpmg=
X-Received: by 2002:a05:6402:3788:b0:5dc:8fb1:d43e with SMTP id
 4fb4d7f45d1cf-5e0b70e6a03mr11963042a12.12.1740407663035; Mon, 24 Feb 2025
 06:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127093530.19548-1-alexghiti@rivosinc.com>
 <20250127093530.19548-3-alexghiti@rivosinc.com> <Z5ePZt61CM84Hb36@casper.infradead.org>
 <CAHVXubhf7aMwsKA0H9OvTg2Lk8U7+bwntVT9Cm-7L4o7=LM4TQ@mail.gmail.com>
In-Reply-To: <CAHVXubhf7aMwsKA0H9OvTg2Lk8U7+bwntVT9Cm-7L4o7=LM4TQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Feb 2025 15:34:12 +0100
X-Gm-Features: AWEUYZn3wPoYfPCBnGXzuvofr3D1NoWw4LTFmErwOP5gdYPjvL31yv0cddSq81Q
Message-ID: <CAHVXubjhkDvFKtK4mQDxJrRekOEAF2P9tmQ-4dyyE9A2O8ojGw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] riscv: Restore the pfn in a NAPOT pte when
 manipulated by core mm code
To: Matthew Wilcox <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Fri, Feb 14, 2025 at 1:39=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Matthew,
>
> Sorry for the very late reply, the flu hit me!
>
> On Mon, Jan 27, 2025 at 2:51=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Mon, Jan 27, 2025 at 10:35:23AM +0100, Alexandre Ghiti wrote:
> > > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > > +static inline void set_ptes(struct mm_struct *mm, unsigned long addr=
,
> > > +                         pte_t *ptep, pte_t pteval, unsigned int nr)
> > > +{
> > > +     if (unlikely(pte_valid_napot(pteval))) {
> > > +             unsigned int order =3D ilog2(nr);
> > > +
> > > +             if (!is_napot_order(order)) {
> > > +                     /*
> > > +                      * Something's weird, we are given a NAPOT pte =
but the
> >
> > No, nothing is weird.  This can happen under a lot of different
> > circumstances.  For example, one might mmap() part of a file and the
> > folio containing the data is only partially mapped.
>
> I don't see how/when we would mark a PTE as napot if we try to mmap an
> address that is not aligned on the size of a napot mapping or does not
> have a napot mapping size.
>
> > The filesystem /
> > page cache might choose to use a folio order that isn't one of your
> > magic hardware orders.
> >
> > > +                      * size of the mapping is not a known NAPOT map=
ping
> > > +                      * size, so clear the NAPOT bit and map this wi=
thout
> > > +                      * NAPOT support: core mm only manipulates pte =
with the
> > > +                      * real pfn so we know the pte is valid without=
 the N
> > > +                      * bit.
> > > +                      */
> > > +                     pr_err("Incorrect NAPOT mapping, resetting.\n")=
;
> > > +                     pteval =3D pte_clear_napot(pteval);
> > > +             } else {
> > > +                     /*
> > > +                      * NAPOT ptes that arrive here only have the N =
bit set
> > > +                      * and their pfn does not contain the mapping s=
ize, so
> > > +                      * set that here.
> > > +                      */
> > > +                     pteval =3D pte_mknapot(pteval, order);
> >
> > You're assuming that pteval is aligned to the order that you've
> > calculated, and again that's not true.  For example, the user may have
> > called mmap() on range 0x21000-0x40000 of a file which is covered by
> > a 128kB folio.  You'll be called with a pteval pointing to 0x21000 and
> > calculate that you can put a 64kB entry there ... no.
>
> Yes, I agree with this, then we have to go through the list of ptes
> and check if inside the region we are currently setting, some
> subregions correspond to a napot mapping.

So I looked at that and I think we are safe with the implementation in
this patch because:

- this patchset only deals with hugetlb, which cannot be partially
mapped (right?)
- when we'll add support for THP (upcoming series), we'll use arm64
set_ptes() implementation which splits the region to map using the
contpte mapping size
(https://elixir.bootlin.com/linux/v6.13.4/source/arch/arm64/mm/contpte.c#L2=
68),
so we can't mark an unaligned region with the contpte bit.

Let me know if I missed something,

Thanks again,

Alex

>
> Thanks for your feedback,
>
> Alex
>
>
> >
> > I'd suggest you do some testing with fstests and xfs as your underlying
> > filesystem.  It should catch these kinds of mistakes.

