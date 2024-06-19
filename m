Return-Path: <linux-kernel+bounces-220775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D790E6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC2F1F219B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB4580025;
	Wed, 19 Jun 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cemrlbqu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AC7D3EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789021; cv=none; b=lBVwkRLOc7VgOE8uhELu7z8Ot/MfCr4dNSAoYywrNcElNHDsUeSU1YMi/YlGJlYMghrN//FkZZguMH9f5omOBrLcHRUg61d1ZYeqdnM6Q2HQw80WbijpXCSfijAW/ULdxK4eG4zAzHoWdMQ8B1cVGRVxwYoM6kT3vr96XFJg9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789021; c=relaxed/simple;
	bh=c6mCFLDwnEj0M0yPmsIQCRB4t/fBDoZ4qwONT/Fjbec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXR6OSXx9s53gAC8riQhvuLE33ZuuedExRHoQeWr6KlFeI2RSrSGGOmRlMSESod8HzQyFAz4DSfXfgSzSuYRmO2ZZak7gUi8sCBt8eZL5qX4qUC4rkBYi0QKyx/JlL7mCne2TU3ZGnQnoCNsqBubKnuKCFn76xapC5zLnly3DEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=cemrlbqu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so760259466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718789017; x=1719393817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E02jv30Jn5KEyH9ZDrmzhOXntMuebj1OtVrel1S6NPY=;
        b=cemrlbquzeqpeZAK2qByaFC1iCJUr6TQBSUbMHVCZPrZNxaXwLHB0QLrjoNRGGUg1q
         uhY3IERk1r8bWmpq4DDrAG61bSCfDE1vkRbOIg7dtYecw/LelD0PtyaNNyk+nh4rjHh3
         xynmSSlN9Gu7BrGi26GgVfBUyqpGCCN/PF7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789017; x=1719393817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E02jv30Jn5KEyH9ZDrmzhOXntMuebj1OtVrel1S6NPY=;
        b=LbKKodCiU7rA8YdyEfNZhbXmpsRQ8C/DAk+SNQmH35NXI2ctqBcucdF8F+5djx01vl
         AHBJetpH6hvQLkT4b5HA9TftOlOBhq8NYqqEo3aMYOyjAbZc1eUvH53lzeHZ8a0v1cfC
         8CAFTRz1oNuRLg+Z+zIhyvH3a4PWM9kr0acFVkqHeKUOi8C7xSZ0i23diHUJHJ6BaDx4
         jtKBo2WZLi4mGPVlp6c0gA79VXjvihMetKwtsVvofZdMuJCqV2Ex/15vpu+w4PtY70Bd
         cuHbccc4KYKz32fujQN68a+K31zXMISWVksoBliB4bnVnjd5cXzV+0CXav6C3JG88lyR
         ydXA==
X-Forwarded-Encrypted: i=1; AJvYcCXJbboicbG+4uAKX+/XV1/5VfYz/JAcDddpubiAREJp5xnt4JYMfiOEDH50DAVJ22xgQBBPdEWdzAuLDkaE2rfyL+tt7CvAo1ZLwpjo
X-Gm-Message-State: AOJu0YxJlseH6kD1x1IsNcuIGMEw/Gbr6Kz6F1n8XK2tfXu6SbtWFh8y
	kUC8f0axbDmNkDRBYMHvXs71kDeql0uiJIw3l4ryO3WxUTme/53t7X/kRWf8/jekY5u2BFTjh8a
	Yh3oHeLibuQnoHrWO+PJFAPaCUxRZb2vrRv2I6HesF4aNoRJMV/c=
X-Google-Smtp-Source: AGHT+IFKQvk8lAQ+nFDkshiq3A/6mD+WFlIPkfhgxOHvbp51SeWW3bgS+ClQyEOwinwc3A2jk5hQBWZfiwOzdNFxXfc=
X-Received: by 2002:a17:906:130a:b0:a6f:97b4:d1a5 with SMTP id
 a640c23a62f3a-a6fab648ac6mr95888166b.40.1718789016391; Wed, 19 Jun 2024
 02:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com>
In-Reply-To: <20240619091737.669040-1-albertosecondi@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 11:23:24 +0200
Message-ID: <CAOf5uwk_i5yA+K=riMcP9r4V9FynRBv2+=P98xUMvmvBtJr4Mg@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Alberto Secondi <albertosecondi@gmail.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alberto

On Wed, Jun 19, 2024 at 11:20=E2=80=AFAM Alberto Secondi
<albertosecondi@gmail.com> wrote:
>
> From: Alberto Secondi <alberto.secondi@abinsula.com>
>
> The kernel assumes that 64-bit systems have 64-bit DMA support through
> CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, sever=
al
> iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit su=
pport.
> This results in several drivers requesting DMA_BIT_MASK(64), which causes
> malfunctions, particularly when systems have more than 3GB of DRAM (verif=
ied
> with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, a =
new
> config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems with =
32-bit
> DMA, which adjusts DMA_BIT_MASK(n) accordingly.
>
> Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> ---
>  include/linux/dma-mapping.h | 4 ++++
>  kernel/dma/Kconfig          | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f693aafe221f..629220a777e3 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -74,7 +74,11 @@
>   */
>  #define DMA_MAPPING_ERROR              (~(dma_addr_t)0)
>
> +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> +#define DMA_BIT_MASK(n)        (((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<=
(n))-1))
> +#else
>  #define DMA_BIT_MASK(n)        (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1=
))
> +#endif
>

How can this fit configuration where you want to have one Kernel image
for several arm64 machine?

Michael

>  #ifdef CONFIG_DMA_API_DEBUG
>  void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c06e56be0ca1..0a27eafed808 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
>  config ARCH_DMA_ADDR_T_64BIT
>         def_bool 64BIT || PHYS_ADDR_T_64BIT
>
> +config ARCH_64BIT_HAS_DMA32_ONLY
> +        bool "64bit System has DMA32 only"
> +        depends on ARCH_DMA_ADDR_T_64BIT
> +        default n
> +       help
> +         This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> +         64-bit systems that have DMA support limited to 32 bits.
> +
>  config ARCH_HAS_DMA_SET_MASK
>         bool
>
> --
> 2.34.1
>
>

