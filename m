Return-Path: <linux-kernel+bounces-537814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A4A49136
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE44316F197
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2051A8F98;
	Fri, 28 Feb 2025 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFUEVupk"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370A10E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722158; cv=none; b=WHeU1uReRXyeSr3teJ+mRO/DOv1pU0l7eMTd6ThxWZ1+qsHoVbOZou34MfXYCUD5Sl/1Mdt/naNNwFLxujZPYiC0fJJr/Yp62VL5GTOR+EQYozv0VFI65VoPcnQjlEiipp2XAmOnmqpRKg0aTN3N5DOqwIcfnlkIiTy2qFk1jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722158; c=relaxed/simple;
	bh=dczW+l9LXncWc723SUUIQqMmHd4Bb6BTlndiQ9Gm9Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ0reIE3ejybqDH3p5RCsFOq4gIgBGt2nX4xjDSxHkbNbJ/oOkkwyenFyUy6CKuE1OQJMZUmod0XQkQbsjrd+7BspzJJC18bSC6nYoaBHv++RhHQUJn2IJmO/ygcHXwQ/1jnIGRKDzhuFMgIMmpXzkqU/E215nMLyaihx+vHMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFUEVupk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feaca4e99cso2055025a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740722156; x=1741326956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTyDWMq7LuxFszntaa+iD29bxyoweAzlnH0TTz0fmag=;
        b=aFUEVupkzEsv3BERvOsW2XnteCzBv1cz+Fdgc1+kV0EhR5PaVUZXR1gdBKJOhmWfQd
         v+AfXjn9E9Qb1Kdp+HQ0Um7k3OJuv/XXGJRmebjmSMrCITy7MC5ys+oYUDaXI3Uhr3G1
         mciH55PcRSDX3ggxUXYi8aIXpp/dZWmnl6RrMydisUg1fa3FP4zH27zMrUVFyJNguL6r
         1q6PeLoQAtrxLF/udyOrTiyULM3b22HcT5OeiD0VKzIwHtgKEcocPFroxWjdxCc6vX3l
         Cr96uMQItBpqM38PfslgHqCmFgyrExtJBDylvOtjx2q6oIfvuIk6qTDS3dNNckq2ex3c
         iuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722156; x=1741326956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTyDWMq7LuxFszntaa+iD29bxyoweAzlnH0TTz0fmag=;
        b=OoONgsKWMSjVs2JVOK1bi73+umKHib2JpMydjBJveOHq6h/MNKuzcL5M22aHMm1Y1w
         Ahvh3t8N/jeojd5l/oj4dImxSlnqI9rjfvmGJALApGKWv/8PBEoMiFfBW/p34+bylQX5
         Wl7rfOV5UnNU3AX6Ootq1gjRCRD3jIrWajwb4xaWShPMBY4w/LyjlfZgfX5BYsiE0yc+
         wImZ8WFskeeD5DDA7/UhdODiF/5EMGWDgC8dzCxrpLowQpJ/JH/TAQk0BZDOofcDIuO0
         OaQyVzK2l987UFJRZx3MeMLs125JH4zXSg6sEHE0ARXUsv2MT4+PpAQWE7Nrs4sPfHxq
         G1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTktNeY5uhZs2K/Nx/mXmbr7nhYpeTUKLSrU9dpXB5EvoB9CUIvMYX4RWHj3qgWsP1x2h9sTCB4S1t4W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2THxMStctgNCS7oxxVgxjM2Z/kXlPVyBx1SfHnIROQdjh9DS+
	tjQtO0YAemU/Z9NdV2joMEnVXuiGjJW3hVbqqe7fNBfCU7UOf3wUff4pPRKFp/roA3xnE2YvSNj
	f0fJH4t2Roac9hXkswo88jdE8AMQ=
X-Gm-Gg: ASbGncvvu1cppeNrFgeEQtRNbufYd+S6kV+nRo6lvjgLiA60CwBhTwX2cqfQnSaNoN4
	ZTLBcsMEI8YJZ8v1JgzlcXbngPuXsQcP1/Ls97bJLpwMcCivBPyySVfilcF73+5ATDa+/sUTwbH
	wNvt+X0Bw=
X-Google-Smtp-Source: AGHT+IH1kXpO6UtU9fFbMiz1TwsUkVKouvQAhEFuVTY7b3q6gVCZwEbIs13RvSk10ypmcMw3ai6cwMKrN9AtOIdFY5g=
X-Received: by 2002:a17:90b:4f44:b0:2fe:7f40:420a with SMTP id
 98e67ed59e1d1-2febab799f7mr3898280a91.17.1740722156297; Thu, 27 Feb 2025
 21:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224062111.66528-1-kpark3469@gmail.com> <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
 <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com>
In-Reply-To: <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com>
From: Keun-O Park <kpark3469@gmail.com>
Date: Fri, 28 Feb 2025 09:55:44 +0400
X-Gm-Features: AQ5f1Jqv7vZum04ir1zjNFlxNiWh8h_GwAtHGiIdceGOJ9NtD2R77znnZ1Sxpmk
Message-ID: <CA+KhAHYDui3VkebjxZLnN_ijMUzJf2BRMqtPqqos+rCbf8J7Ww@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, Keuno Park <keun-o.park@katim.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How about adding a warning message in case of linear region
randomization failure?
And, there might be two options in my mind by now to consider hotplug memor=
y.
Either giving an option for users to override "parange" as kernel
param or providing the legacy way((memblock_end_of_DRAM() -
memblock_start_of_DRAM()) when CONFIG_MEMORY_HOTPLUG is off.
Users believe KASLR will work fine by enabling CONFIG_RANDOMIZE_BASE.
In case of linear region randomization failure, I think at least users
need to know about this failure.
Can you share your thoughts on this please?

On Tue, Feb 25, 2025 at 12:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Tue, 25 Feb 2025 at 05:48, Keun-O Park <kpark3469@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Keun-O Park <kpark3469@gmail.c=
om> wrote:
> > >
> > > From: Keuno Park <keun-o.park@katim.com>
> > >
> > > On systems using 4KB pages and having 39 VA_BITS, linear_region_size
> > > gets 256GiB space. It was observed that some SoCs such as Qualcomm
> > > QCM8550 returns 40bits of PA range from MMFR0_EL1. This leads range
> > > value to have minus as the variable range is s64, so that all the
> > > calculations for randomizing linear address space are skpped.
> > > As a result of this, the kernel's linear region is not randomized.
> > > For this case, this patch sets the range by calculating memblock
> > > DRAM range to randomize the linear region of kernel.
> > >
> > > Change-Id: Ib29e45f44928937881d514fb87b4cac828b5a3f5
> > > Fixes: 97d6786e0669 ("arm64: mm: account for hotplug memory when rand=
omizing the linear region")
> > > Signed-off-by: Keuno Park <keun-o.park@katim.com>
> > > ---
> > >  arch/arm64/mm/init.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 9c0b8d9558fc..2ee657e2d60f 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -290,6 +290,11 @@ void __init arm64_memblock_init(void)
> > >                 s64 range =3D linear_region_size -
> > >                             BIT(id_aa64mmfr0_parange_to_phys_shift(pa=
range));
> > >
> > > +               if (range < 0) {
> > > +                       range =3D linear_region_size -
> > > +                               (memblock_end_of_DRAM() - memblock_st=
art_of_DRAM());
> > > +               }
> > > +
> ..
> >
> > In most cases, the hotplug memory code will be working the same as befo=
re.
>
> How so? Such memory will usually appear above memblock_end_of_DRAM(),
> and due to the randomization, there may not be any space left there.

