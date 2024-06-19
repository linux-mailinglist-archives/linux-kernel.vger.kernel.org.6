Return-Path: <linux-kernel+bounces-220787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E9C90E714
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6486E1F22B57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A321580BFE;
	Wed, 19 Jun 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OqRSsbuR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2188062E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789362; cv=none; b=pwHsIl+JbMgxPCC6STo0C19VXIGLvKsVokryNuq6p8z85jKcrElrrneBPQFTpfntRijejU83N2jYMstRSF4w9HqXhREGYk0ugUtWbDvdUcWP/thTOJVbV5JWAlifPPAKwFO7XSvgkcQ1nU67SflM2LNBurplyrM4t6dUyP3+sis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789362; c=relaxed/simple;
	bh=cv7531rMfIX0TJSEu7BFmlypNRmwdNE0oRm/RjGb3/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPdG1y0VV9rCiTvtfCxIUiVDgMOeXUUQWvnHxiwmpqYEwpmELc97PxhosAnUPPseUSPerOhW4mElBmQB6TRY3BioMzVcwSGaqwQaDgUzaZqP1pacsHtxU7FUhVLKFZL6Q9IZJ3paOq4IvgKUCAPxTyQ/4fwS81XIcmloaF4+DaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=OqRSsbuR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso844745566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718789359; x=1719394159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V60tWSEyq0vsAXnVJoNACpk/lcgOsGBfMMUaz3AVbmM=;
        b=OqRSsbuRDJw5jBxjPZ0FKr4x0fKvRkLKlvDIAEqGzmXFysf2LiAuts6opGqaPE75ec
         DLwWk5UkJUmW6bXdMrMlT42Booprj+xSXjNWAZy4DeTXqPEBVD2WiEV6vuwFaSkcriFk
         jteyvBpJ4aC/4+sS/3zzZiedmCBcoHO2IQO0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789359; x=1719394159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V60tWSEyq0vsAXnVJoNACpk/lcgOsGBfMMUaz3AVbmM=;
        b=ial5t7ydJ9eozPeECBboIeXdgDi2uCir8m3FUBMG4KVLZenJv8tJCQQTic3m1DDkFw
         n3MKMiKSewxjf/rbOrL7mJHDm/Yn0gMgzP3sm9v1TcCfRR9sL8nADISZl9zfa5feEvnR
         nKGQk0RNbnkj1qfZqgO9i0GRkui5GWaADSx6St+K5pBKv3TMyxrct2wxsEmT5/ZBRI5d
         3myunA48GJ1motbQo5VL2t4xMidgnLoFUjaIxYdWK1uuoKpTSKj0FlIJDb7lxbDq5rHD
         KO/7PQUt+9wm6AwFbJoKAdlxFy49EQNJK85H+1iICqPnaZn0gve/JR6pLTVeC/wk94lj
         UmSg==
X-Forwarded-Encrypted: i=1; AJvYcCXZTB8xGRN0DcqnRHDRN/s9/8tDqfoodrBhcBvyoy44sbsQhmUo186wEaXbFUISMpIxUSOKWKZCD0VnXw5Qrz9MXd3mqklskwjmEH+d
X-Gm-Message-State: AOJu0YzMtVcUSCxDfFRP/5wwuEynxiWlwgoVS6LB+h6lXtPODfzXKoG3
	G/WQuyNEPQuzGmzNSwwsynER6I7xrvQ1KgYuvXu4lQvhw0mgkhTMYL5Jm1MA0w4ymtUJ3VUVKJZ
	LtNFkEDAzP2yN5YCDfFxMYZ1V61CMvk1X6eS8TA==
X-Google-Smtp-Source: AGHT+IFb76x7Pucfvd16pWEowxfrmojNsl7zxPiv/9dMvlT25uSbZQ+OJ1X3ubz+svkccGvvchtJv/7pS3EQVnBm5Bk=
X-Received: by 2002:a17:907:a809:b0:a6f:86fe:c495 with SMTP id
 a640c23a62f3a-a6fab7718aemr117097866b.49.1718789359465; Wed, 19 Jun 2024
 02:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com> <CAOf5uwk_i5yA+K=riMcP9r4V9FynRBv2+=P98xUMvmvBtJr4Mg@mail.gmail.com>
In-Reply-To: <CAOf5uwk_i5yA+K=riMcP9r4V9FynRBv2+=P98xUMvmvBtJr4Mg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 11:29:08 +0200
Message-ID: <CAOf5uwkJxpge=JdtQv_nu7zWaN4weD43kBKqM1qAR4h5tuRjfw@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Alberto Secondi <albertosecondi@gmail.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alberto

On Wed, Jun 19, 2024 at 11:23=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Alberto
>
> On Wed, Jun 19, 2024 at 11:20=E2=80=AFAM Alberto Secondi
> <albertosecondi@gmail.com> wrote:
> >
> > From: Alberto Secondi <alberto.secondi@abinsula.com>
> >
> > The kernel assumes that 64-bit systems have 64-bit DMA support through
> > CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, sev=
eral
> > iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit =
support.
> > This results in several drivers requesting DMA_BIT_MASK(64), which caus=
es
> > malfunctions, particularly when systems have more than 3GB of DRAM (ver=
ified
> > with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, =
a new
> > config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems wit=
h 32-bit
> > DMA, which adjusts DMA_BIT_MASK(n) accordingly.
> >
> > Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> > Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> > ---
> >  include/linux/dma-mapping.h | 4 ++++
> >  kernel/dma/Kconfig          | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index f693aafe221f..629220a777e3 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -74,7 +74,11 @@
> >   */
> >  #define DMA_MAPPING_ERROR              (~(dma_addr_t)0)
> >
> > +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> > +#define DMA_BIT_MASK(n)        (((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL=
<<(n))-1))
> > +#else
> >  #define DMA_BIT_MASK(n)        (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))=
-1))
> > +#endif
> >
>
> How can this fit configuration where you want to have one Kernel image
> for several arm64 machine?
>

I'm not an expert here but:

 @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not a=
ll
 *         hardware supports 64-bit addresses for consistent allocations
 *         such descriptors.

This looks more connected to what you are looking for.

Michael


> Michael
>
> >  #ifdef CONFIG_DMA_API_DEBUG
> >  void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c06e56be0ca1..0a27eafed808 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
> >  config ARCH_DMA_ADDR_T_64BIT
> >         def_bool 64BIT || PHYS_ADDR_T_64BIT
> >
> > +config ARCH_64BIT_HAS_DMA32_ONLY
> > +        bool "64bit System has DMA32 only"
> > +        depends on ARCH_DMA_ADDR_T_64BIT
> > +        default n
> > +       help
> > +         This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> > +         64-bit systems that have DMA support limited to 32 bits.
> > +
> >  config ARCH_HAS_DMA_SET_MASK
> >         bool
> >
> > --
> > 2.34.1
> >
> >

