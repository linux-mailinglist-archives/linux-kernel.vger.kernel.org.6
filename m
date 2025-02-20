Return-Path: <linux-kernel+bounces-524087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F345A3DEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6C8178EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498D1FA84F;
	Thu, 20 Feb 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btOCRGjY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE571F8917;
	Thu, 20 Feb 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066120; cv=none; b=F3f6L5gwgPJbTkVnL7zAPJ2nHiEe3AieqN9gRfXQeC7AdybOgMTcrKrtzX0VpCZHs1hXtIwubX+ra17DYS8Am3MKKIeM5S6CJznq5QYWu2fU0yiLKKOtvAS2CbFW6qSeiYVe/fR/fgMc1ZLUdlJhxdmqFmSSPku571e/JWt/atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066120; c=relaxed/simple;
	bh=rLDdqL4LhGKAjsGNUH/kcLvHKcVzqtPa5ndSZ+UTsbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+4jCoaY9LO4zvkRNXDF4zs73sr/tSo15zJq6F0O9x1gCw/6faq5OEBcRv3poPIEOINgQ1kEXWXENCV0BrpNw4yQ5r+WROJzHkbyoBGacUvyJQMMjabMhQCGuMhk5D/fkjFE6TLNq3YzdZ2WPQAwRO6Sa/emhOfTH6VezryDmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btOCRGjY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a331d981so9422005e9.3;
        Thu, 20 Feb 2025 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066117; x=1740670917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyIVLkT28r4TU0EMijOb+j2RXpDTj6f3sAkEcVbKSk0=;
        b=btOCRGjYk5IeZVowJWGeJLTvmPJREHCnWaHFpC2skdFcgn4ko6sHr+ZjJcSUWNg1yl
         mAeb1iEq6ZvL0k0gUiy8C3QGTN6QxnMEWx3kanDzL4V6+MeW2Z5b1cbN0yTPZShAsXYF
         9H/KcKMDYn7wqbqUOxuVOM7qfCKbyJUqjs6PFpTr/1V5NIJsbfuA+w1xKqPB78IC9/5B
         9cIAD/ltwBsGBnnUk7rI1qFtrnU8jTqS+Z4pPAbBy4QFB1Q4nh7ryFseTqdy/Ibrs01d
         rDEiVe6B5HQu01vE8nWoq8ImwFOIqoR1+d/rIAb8Z+BWlZeb0UsMkBrB78Gm1KaE/7vz
         F4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066117; x=1740670917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyIVLkT28r4TU0EMijOb+j2RXpDTj6f3sAkEcVbKSk0=;
        b=NWQbX4UDTw5RDiI7YbDS54O863+cabJpuZ0MahnscLrlbGIyqv8SKii+gMmLsjOMYV
         gXONiK2vBgXTHsOXGwADDkPxije02kmHndK7DnmOwyO+dgUZQB0373e4vKgKi5MBuFP9
         1BSinOh6lIhW5sj/Bvq0d/XOmoX+yBYZcnpKg6XO8oCjN2IMDxBZVO9/I2Ubl14IzPNW
         I8BNJKRMRYkYExriTGDuAUSJvru9N2q39ztIM+3M3ZgzKSDPRaphMyGM+7lHqHbXxgBV
         XojwijpElK90SZ1deRSVu2qjkhh8uahuABWTB1I+siUJ0IsSonAit8p3NBYDiOVF6yj2
         kIng==
X-Forwarded-Encrypted: i=1; AJvYcCVmbEdF9kVUk3DsOyOhOI7/OW3lPKHAFxZGRc6KAZTQtGJlidq/uZi9YuUDRTznvmx63XfvCcfy57kPV/mo@vger.kernel.org, AJvYcCW2C1cvrmpPGCMbYBhbK3Za8oiGG6s4FAKkb9bcq6TPDq7ak6lBtxrONEwgx0NR9tTDoMx8OoooxwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIol7iY24rZ9Gh8oNlLOp19WCs7u1oACTeAzSrDQ75rBVmPU2d
	R7e26uWCMTDsiK7xp9ZuGfQXkabr30y6TsVPczaGRfNltErOYulN
X-Gm-Gg: ASbGnctpGHexWtDDg7yklJXqNWTDJ/IFtdSuH0BNvWT3bYeQVIn2ROmw5criwvjmEzo
	8MQDsC9BHbnWyx1u4SSim9zBYrtyJ+7JQ0xkiDNEVr3baTUbU+AFhfo1GcTMNOp820bCm2rz0Bu
	l+WubkuK5daFTStzzTS8s/Z4awnnxvQwZlDGnvAqSB6fWYGC/NEmokUdRsD3BK9nUYlKsSzwTw4
	xCYSRMC6MacT/kbfWv2Bh+F2LCHa5wUFw9T/668UfBSQ6rfbVBnZ8lI3a3rwFjWt4VDl07mWzGW
	ctlSMTVihtVV29lLo21cjZgIryRHzxa7RC7zgdxeIkYKYQRAeDqed3XmKacB5LKV1L8=
X-Google-Smtp-Source: AGHT+IGLMBgWAS8md1eWr3QLcZNc7eKtGIVV3ogJUweYOTxfA509OyXxG3f6PzbwI1nZtFPUxbjlgg==
X-Received: by 2002:a05:600c:4f48:b0:439:8bb1:14b1 with SMTP id 5b1f17b1804b1-43999d91255mr100404625e9.11.1740066116912;
        Thu, 20 Feb 2025 07:41:56 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7e0sm20646011f8f.48.2025.02.20.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:41:56 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Simons <simons.philippe@gmail.com>
Cc: Philippe Simons <simons.philippe@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject:
 Re: [PATCH v3 1/1] clk: sunxi-ng: h616: Reparent GPU clock during frequency
 changes
Date: Thu, 20 Feb 2025 16:41:54 +0100
Message-ID: <3297157.aV6nBDHxoP@jernej-laptop>
In-Reply-To: <20250220113808.1122414-2-simons.philippe@gmail.com>
References:
 <20250220113808.1122414-1-simons.philippe@gmail.com>
 <20250220113808.1122414-2-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 20. februar 2025 ob 12:38:08 Srednjeevropski standardni =
=C4=8Das je Philippe Simons napisal(a):
> The H616 manual does not state that the GPU PLL supports
> dynamic frequency configuration, so we must take extra care when changing
> the frequency. Currently any attempt to do device DVFS on the GPU lead
> to panfrost various ooops, and GPU hangs.
>=20
> The manual describes the algorithm for changing the PLL
> frequency, which the CPU PLL notifier code already support, so we reuse
> that to reparent the GPU clock to GPU1 clock during frequency
> changes.
>=20
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 36 +++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Changelog is missing here. What's changed?

In any case, this patch isn't useful on its own. What about PPU and GPU DT =
node?

Best regards,
Jernej

>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-h616.c
> index 190816c35..6050cbfa9 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> @@ -328,10 +328,16 @@ static SUNXI_CCU_M_WITH_MUX_GATE(gpu0_clk, "gpu0", =
gpu0_parents, 0x670,
>  				       24, 1,	/* mux */
>  				       BIT(31),	/* gate */
>  				       CLK_SET_RATE_PARENT);
> +
> +/*
> + * This clk is needed as a temporary fall back during GPU PLL freq chang=
es.
> + * Set CLK_IS_CRITICAL flag to prevent from being disabled.
> + */
> +#define SUN50I_H616_GPU_CLK1_REG        0x674
>  static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
>  					0, 2,	/* M */
>  					BIT(31),/* gate */
> -					0);
> +					CLK_IS_CRITICAL);
> =20
>  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
>  		      0x67c, BIT(0), 0);
> @@ -1120,6 +1126,19 @@ static struct ccu_pll_nb sun50i_h616_pll_cpu_nb =
=3D {
>  	.lock		=3D BIT(28),
>  };
> =20
> +static struct ccu_mux_nb sun50i_h616_gpu_nb =3D {
> +	.common		=3D &gpu0_clk.common,
> +	.cm		=3D &gpu0_clk.mux,
> +	.delay_us	=3D 1, /* manual doesn't really say */
> +	.bypass_index	=3D 1, /* GPU_CLK1@400MHz */
> +};
> +
> +static struct ccu_pll_nb sun50i_h616_pll_gpu_nb =3D {
> +	.common		=3D &pll_gpu_clk.common,
> +	.enable		=3D BIT(29),	/* LOCK_ENABLE */
> +	.lock		=3D BIT(28),
> +};
> +
>  static int sun50i_h616_ccu_probe(struct platform_device *pdev)
>  {
>  	void __iomem *reg;
> @@ -1170,6 +1189,14 @@ static int sun50i_h616_ccu_probe(struct platform_d=
evice *pdev)
>  	val |=3D BIT(0);
>  	writel(val, reg + SUN50I_H616_PLL_AUDIO_REG);
> =20
> +	/*
> +	 * Set the input-divider for the gpu1 clock to 3, to reach a safe 400 M=
Hz.
> +	 */
> +	val =3D readl(reg + SUN50I_H616_GPU_CLK1_REG);
> +	val &=3D ~GENMASK(1, 0);
> +	val |=3D 2;
> +	writel(val, reg + SUN50I_H616_GPU_CLK1_REG);
> +
>  	/*
>  	 * First clock parent (osc32K) is unusable for CEC. But since there
>  	 * is no good way to force parent switch (both run with same frequency),
> @@ -1190,6 +1217,13 @@ static int sun50i_h616_ccu_probe(struct platform_d=
evice *pdev)
>  	/* Re-lock the CPU PLL after any rate changes */
>  	ccu_pll_notifier_register(&sun50i_h616_pll_cpu_nb);
> =20
> +	/* Reparent GPU during GPU PLL rate changes */
> +	ccu_mux_notifier_register(pll_gpu_clk.common.hw.clk,
> +				  &sun50i_h616_gpu_nb);
> +
> +	/* Re-lock the GPU PLL after any rate changes */
> +	ccu_pll_notifier_register(&sun50i_h616_pll_gpu_nb);
> +
>  	return 0;
>  }
> =20
>=20





