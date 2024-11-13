Return-Path: <linux-kernel+bounces-407914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC839C77DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89280B251A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C920400B;
	Wed, 13 Nov 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b/FbUQUs"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152F1632F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511895; cv=none; b=muoJOA4e+FCrZaACG0ifSoGLnWsVGQl3pfrzuMbqxfwznrICfyQu54+XzgxZ0a4ifqPfRjcz256BZ3WkFaC+kNmjeEFL96KrAgPPQ0VCpHJQs71s+vm6FqDo63dMk0TjcOG6pUEOwxLS02+lhXnXmzpVIZyCQsCHVYBQ0evjGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511895; c=relaxed/simple;
	bh=xVtF/xCpeCsZFZRp+tvi5UlLAjLwLoWAy/YaVnClyFs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=DAsnq6DZziJyVCPmpP00y0ZtdxCI6U02WL7iDc4T2lPMKPjTYCXxPeN3EfMeNNl1UjSIkZPhdQKKwshZlXDKHhpH8Hz1eSXs8VkKXXSQbXk4/6p1vLpRCtVlZ/n3oq2FNRodi5s9NFDObSCFD+Y0ArbkcOrgLPYjhbbyunG8Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b/FbUQUs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE5A13F2BC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731511888;
	bh=QlPgmr9lfODDlfP2omT7i0R89fEaKNKJt4cjbSvbt1E=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Content-Type;
	b=b/FbUQUsTtgFbc0PvxQjPi9j3kj5AoDPxZuB0MYmfVxEsLqDUvJ/paNCpLTBh/FiI
	 +iROOw8R90RlCcsXOHsAIae+NAI5ETUaEra2D0g5Z2RkDimbgM4E5Bu8wpl2hDIgZY
	 s4EOoyb/nPBjVKqzaLCiKsfo8xR48ElOIWJ5qKiXnCDsnLwvGK5E3FbV51NVE0UxXL
	 FTcCSgN0oTwIUug5y+szH6rU1a/IzalbueiqdeseNSa36/UbhM58EnQCnXjLEv+X2b
	 mvTk9rJsVxgtu6UaPbagTX96qGR3aq47bG4lNiaXhzEFz7okJ+CjmUew4C2HOqbRqa
	 EJWjXm6auaf8g==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-288b904d3d3so4687685fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511887; x=1732116687;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlPgmr9lfODDlfP2omT7i0R89fEaKNKJt4cjbSvbt1E=;
        b=xKXU2mHCs8JLDS4hPASJryUxcZ4mNLFZ6QAqDegjGFDmA/0Sh74hO2Ftjwprc+zZne
         ieqdNH/kkPS2jsaXQcRrVBPTgazavfplhDadkqgHmxaP3p2fJDuMOkbCT8leqRqKyv4u
         qneednVjhi3dwVTLmeVQ+KMltH4eZ0iPKIAfWYcQYRMFllNf3EkXYzDScZpG68qMiA6G
         Hu3xzBqaizvI0KhuGyfD149IyE+dZD7wn9XePqT+Sgcj+pospwj+9dyiCp0Rt+Tdb5Hq
         CjiWOJnGO3fKOUtw+4gKo6Abk3lKQBlDW81mC1ia5Lnnd/wzPAjHgpCjziksmapkBRK5
         w75Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG5k2kgMAQy7RlQItRYOxUcGZE/tTGaGzkJnKlPqf4QgydVtBmVPKNU0u1VH5/qHenRSgB7gGGVUhbmC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuehJ3zKm+mY7YNSPaQmbQzkxIpS3SU+dxN6Se2pm5p1LDea48
	IRFbZBozSKIbg2G8GSjTrwS6Qr9nKiAYHQwcqfsiPr+z+6lWdY2NkbrZqHrg9yTp40441sfenNF
	5V6sQgx6k3Eh9+nA20n8oZI/fKK1SOgemYbnp76tCkVteE4ZY25X/eyCd1ra2mcGVhZnVH2QlBu
	UOAON1N81MI/TyvjxPxvfabzwRJt6itW40o9p2npzbyN2+f7oehYOqEQ9HaQaA3+k=
X-Received: by 2002:a05:6871:589a:b0:260:f883:95f9 with SMTP id 586e51a60fabf-295602ff7d0mr17159846fac.42.1731511887444;
        Wed, 13 Nov 2024 07:31:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0z7Jp0XMyjRAbohYkAVIhRcQh3YSYeIYiseo4qNrUcHEZ2QHWzle0ceQ/e/Hjh0uVmlig9StAflHiJoVTYzM=
X-Received: by 2002:a05:6871:589a:b0:260:f883:95f9 with SMTP id
 586e51a60fabf-295602ff7d0mr17159785fac.42.1731511886807; Wed, 13 Nov 2024
 07:31:26 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Nov 2024 07:31:26 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241110054405.667779-1-drew@pdp7.com>
References: <20241110054405.667779-1-drew@pdp7.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 13 Nov 2024 07:31:26 -0800
Message-ID: <CAJM55Z9o0JyJnw6C3=eGmgduK92M3nthKSLCB3-N5QD0YkLwyQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: defconfig: enable pinctrl and dwmac support for TH1520
To: Drew Fustini <drew@pdp7.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> Enable pinctrl and ethernet dwmac driver for the TH1520 SoC boards like
> the BeagleV Ahead and the Sipeed LicheePi 4A.
>
> Signed-off-by: Drew Fustini <drew@pdp7.com>
> ---
> Note: the th1520 pinctrl driver and thead dwmac ethernet driver have
> been applied by their respective subsystems and are in linux-next.
> I've successfully tested next on both the ahead and lpi4a boards.
> This patch is based on next-20241108.
>
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index b4a37345703e..99a11142c03c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -167,6 +167,7 @@ CONFIG_PINCTRL_SOPHGO_CV1800B=y
>  CONFIG_PINCTRL_SOPHGO_CV1812H=y
>  CONFIG_PINCTRL_SOPHGO_SG2000=y
>  CONFIG_PINCTRL_SOPHGO_SG2002=y
> +CONFIG_PINCTRL_TH1520=y
>  CONFIG_GPIO_DWAPB=y
>  CONFIG_GPIO_SIFIVE=y
>  CONFIG_POWER_RESET_GPIO_RESTART=y
> @@ -242,6 +243,7 @@ CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_DMADEVICES=y
>  CONFIG_DMA_SUN6I=m
>  CONFIG_DW_AXI_DMAC=y
> +CONFIG_DWMAC_THEAD=y

The network driver doesn't seem like something that's essential to boot the
board. I'd suggest just enabling it as a module.

/Emil

>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

