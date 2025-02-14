Return-Path: <linux-kernel+bounces-514941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD83FA35DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D161188F329
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5ED263F38;
	Fri, 14 Feb 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KWp/40ZG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D61261567
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536814; cv=none; b=PAxAzF8ma3TAzHSIZe5IH6cT/ovJG6o/oi7WB7q7WkydN2acolc/LSi2TZt6IMMgpV0iT13YLIMS+olEt08Fyilp/rXYjC17vtgheDMiemkph2+WCKgwxH8H7sYAwEAhZQ+CJGCQu0jX3/QzCoLmzHigBe+AaXsvV8CQ61QChcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536814; c=relaxed/simple;
	bh=EMcZ/AMPv0rjVO/FJTVGIEP02YYsESZrVvBPg7jVWx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLcOgi8uWgcjns4kNiiV/P6NokiadbhjAJ4i+5gxkPWg1fJBoQTgnAjjHldI6baGqR2DX/9hUR75rcbXe5Ge4PAHSefjMAKoQcGmvnWt60J0ZI4jnU6XF90T5rRVd2ynC6hDMuhrVQajAU59hMvYAkUnXz8P5hvyK9ebvltPtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KWp/40ZG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3574520a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739536810; x=1740141610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36JVfaYsMA1yjpWbwombcPibEH3++Dm1p834NYi7GjY=;
        b=KWp/40ZGuPz4fhfDVU73bjLT1dJCA6ZTYjmQjxgTCj5tBLdkE7b4sSAwcKEvmw6tQa
         lciKay3mHt1xf8zpY+tpgENyWXATiBXfsN/nfg8pBFmyhcLDpm/g3ugPCvLLN8vJpzKH
         8CIVyuxAP0ALs/dBmT3V9YlfQ/HxF1UjmTW4OpQ3rhyL2r8K0bryhEdIUo3SOsNFpR6N
         5VtiefADpYIZPOOnkyyjhaAEgtch57TiBvQ0Ir/nplkePE0+uY+it7XLEm4yVo2Ne8YM
         uLD2vWY87t72YKBKv98JvwqoUhMp2aWArvGx+PJcZFR6sMekgrFsB5KqjPhv/+f5Shl0
         XCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536810; x=1740141610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36JVfaYsMA1yjpWbwombcPibEH3++Dm1p834NYi7GjY=;
        b=KsntxXasH+P8a+uR5iWgysDnI3ugPtOheOVYW93dJpCtuYia+jhAUO+CdmNrfze+CI
         9OzhT0LgFKrlsSdxZi5V4ecU7IbdJqzNeMWrWFIVFwo/tKE/OnH1gRWrLss3j1rhkKCT
         xm4TmrC1QLT1bEAX/OWgs8zoqW67+0nm1BaOdplNg438XZwq4PruVH+cdITsbNtwcvUJ
         Jq79PtuUJzWfgBFBxXqt2saveGvVEPR9mdf/0DzW26NEgrasoeAIWeuiCSNhfCvdhqsX
         4+JtAz0eHOa+Sa3kpudGIpFZpBGe4RbRYA5IZewQu0+ixRhyHKG6OLOc5Tj3f+m5ib7u
         BI4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNBC0B/A4q2U2oKROxn0xkzSuCRGRdG6qmbGE9OyGa3gY3VdiI8/atLk5Dkjaly38DPsc7NVixTyy3l2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UNKfdxWOa8BpT1OYHN3rdXEMrpS7ptIVGvzznV2b1WoMqEjd
	fTu34ShwqQHcp0h+lbK4eL+5x+4KZ50m/lWVfJRH8Q/Z42pht4PT9haS5zag4dylwDBVCgOwIm0
	aD2ZZ/SLqY6rFLzBPsfSIljaWzHDd41R0KyXDRQ==
X-Gm-Gg: ASbGncsy4ZgfbMZINE0iLVIiujw8Aq8RNpDKXN9HSPDX/n1Fv7MpgsFNkGiNmlVBtDa
	ozXWFK70l+xUR5oEJ3u+hjb1moPWyD0/IGDfft1vmaZ9nPoTOWIYlzkU/jISZ0G8k/MC0owuC7w
	N2Vehq4dpQxsiZwISOsGNSDmtdC4sWlg==
X-Google-Smtp-Source: AGHT+IFINGXcloPLWY70sK+aKs3hrkvh5XEIarAY+7Qnm9+bPaz2Y4r4q5IenGXk077X8b2/k5JVm3DlphyYM3UHP04=
X-Received: by 2002:a05:6402:2788:b0:5db:f26d:fff8 with SMTP id
 4fb4d7f45d1cf-5dec9ffa08emr5908259a12.22.1739536810465; Fri, 14 Feb 2025
 04:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127093530.19548-1-alexghiti@rivosinc.com>
 <20250127093530.19548-3-alexghiti@rivosinc.com> <Z5ePZt61CM84Hb36@casper.infradead.org>
In-Reply-To: <Z5ePZt61CM84Hb36@casper.infradead.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 14 Feb 2025 13:39:59 +0100
X-Gm-Features: AWEUYZnHz0DxGK1Ovcy4paeZs4bS-kYqEUuZDZsciI4W-HbFUkIFcKN0yQFuh38
Message-ID: <CAHVXubhf7aMwsKA0H9OvTg2Lk8U7+bwntVT9Cm-7L4o7=LM4TQ@mail.gmail.com>
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

Sorry for the very late reply, the flu hit me!

On Mon, Jan 27, 2025 at 2:51=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Jan 27, 2025 at 10:35:23AM +0100, Alexandre Ghiti wrote:
> > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> > +                         pte_t *ptep, pte_t pteval, unsigned int nr)
> > +{
> > +     if (unlikely(pte_valid_napot(pteval))) {
> > +             unsigned int order =3D ilog2(nr);
> > +
> > +             if (!is_napot_order(order)) {
> > +                     /*
> > +                      * Something's weird, we are given a NAPOT pte bu=
t the
>
> No, nothing is weird.  This can happen under a lot of different
> circumstances.  For example, one might mmap() part of a file and the
> folio containing the data is only partially mapped.

I don't see how/when we would mark a PTE as napot if we try to mmap an
address that is not aligned on the size of a napot mapping or does not
have a napot mapping size.

> The filesystem /
> page cache might choose to use a folio order that isn't one of your
> magic hardware orders.
>
> > +                      * size of the mapping is not a known NAPOT mappi=
ng
> > +                      * size, so clear the NAPOT bit and map this with=
out
> > +                      * NAPOT support: core mm only manipulates pte wi=
th the
> > +                      * real pfn so we know the pte is valid without t=
he N
> > +                      * bit.
> > +                      */
> > +                     pr_err("Incorrect NAPOT mapping, resetting.\n");
> > +                     pteval =3D pte_clear_napot(pteval);
> > +             } else {
> > +                     /*
> > +                      * NAPOT ptes that arrive here only have the N bi=
t set
> > +                      * and their pfn does not contain the mapping siz=
e, so
> > +                      * set that here.
> > +                      */
> > +                     pteval =3D pte_mknapot(pteval, order);
>
> You're assuming that pteval is aligned to the order that you've
> calculated, and again that's not true.  For example, the user may have
> called mmap() on range 0x21000-0x40000 of a file which is covered by
> a 128kB folio.  You'll be called with a pteval pointing to 0x21000 and
> calculate that you can put a 64kB entry there ... no.

Yes, I agree with this, then we have to go through the list of ptes
and check if inside the region we are currently setting, some
subregions correspond to a napot mapping.

Thanks for your feedback,

Alex


>
> I'd suggest you do some testing with fstests and xfs as your underlying
> filesystem.  It should catch these kinds of mistakes.

