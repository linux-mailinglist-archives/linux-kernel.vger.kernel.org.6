Return-Path: <linux-kernel+bounces-544701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633BA4E42B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BEF19C32AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4A2620E6;
	Tue,  4 Mar 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMlf2K7m"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B99292F86;
	Tue,  4 Mar 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102134; cv=none; b=k58zz/OQpRKOwlqYtTt9Zg2oNFI84M6ZU/CsLGPH50EsL5MdyAK7mIlwtjC5TFK8B2c66WZ6hH+r+IFQpIdcUrfhMZD8/pUBxhM3pGZ63Ge90yjsWJxSD60FzKWEe6SbW8MriSpFJJCrb3068tZ/69CRZZk8qBgrvYvjkhkGMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102134; c=relaxed/simple;
	bh=JD81ilNYFouAKsUXwRzwNxXUtg6eNoEjBJCvikF5+Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYzTyLPn+0QzAMqqkUS3SMJJOf2jQZcUnmVRU4RHceJqyJv++fh+awFfmwjr4egY7iNvyzcVaYG3oOdRhqFsRkOuMGOFBTr74dnQx3Vr5IqaIuC2ja32az3pR3tEJCUH7Wv9T8Ocy27iasD9flmjyj40gb80j+UXS9RoqNJrOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMlf2K7m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so13559875e9.0;
        Tue, 04 Mar 2025 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741102131; x=1741706931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GJGl+C+XNyqfDThAEBolXrcWZxVz5MRHfSv1hTEwQU=;
        b=OMlf2K7mb9amZfSPX3NVYvY4v9/yCPhWh4SUiQucP8cNxHgRpzANMHRAdV3IXMjeJo
         ajdW8GBXqVcfAR6hBCJX6tXZhpXY/5iR8AhwigO21yUFXZ7T5h5/A+xAcKSij3Aiq9Rb
         z1yMohdtS9fWD48E1eM8npwVqPUp2kdhuFdE/3NyObZJE1cw0jkllWWk48C6fzSuNNsw
         PL854D0mwCdGoG+tyVpByi9XwtmB80n/wVWa/7hhz+GwwLRvbiNizll3zeEHKvcTsLzm
         Y2Jjhe21y4hLJ9UafBHNgoxXGDZmsWf7wCKXW7goK5VxmLpJDDWk2+Cc5srGztVk+AB3
         JYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102131; x=1741706931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GJGl+C+XNyqfDThAEBolXrcWZxVz5MRHfSv1hTEwQU=;
        b=tnUfdmbcHs+zF69EQmJCD9aNwvYP26Fvm17hPSE39xZzqN9ZQ9uNgTP413eGmBql9C
         pLboYzQsT9cwXEWeWsQP48u0E3PEIvtpeVfdYbELGmmInPewevtUNiqSRkIdZ65HUOnt
         It370mS8tYqaP+hIcHl74x2rqPhKqBVSX/iKg3hkqi6OWToGw1OQ9rEuApXol0cVzteP
         sq4EWTrv9bBIsQ0LB2oMjLWtykapIPp1D+pOGfCmhOL+XOmeNTgG3+Vq8oslqEhkyvno
         knz4K1Rok7KRdruf3OMDKf7vsiM8X8eEdIyC2qM8NCNSInbHyECrTxKnW9TedSWzufPj
         6u+w==
X-Forwarded-Encrypted: i=1; AJvYcCU8Gx54TiOYcbvH4b68nIKLQr8VuFXQPVvMLPixQPLKvs+Rn/RhqAn4MozxHpV/lSh9R3nk93R2mzTmRoK2@vger.kernel.org, AJvYcCW4BDM3M7jHSxNJwsahSe2wLKz5/LaZvCzyLaggQkgPO2eQOk+lD0O6QHQdw+GYzGfNrq8onJRhfaL8@vger.kernel.org, AJvYcCXmXb6WN3IriZGwWZ+DGxMbkzJM5NP+zB0VCzCHvAYxXNMW1A7jtgwVwcAgU7Smo5J9sKXD4xhirjhS@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLYNn0FQ+sr5m/B77Zyr/Etd0mUhVTIx/yOcBCFdzv0PrYbos
	fLS60vk+pQ/T6CWYsFqpd3BovcRfJ4Q5y2tcXUrSqWAndNyoBOAJ
X-Gm-Gg: ASbGncuCJdOw30BVeU7VrkP0LQ0oReJCqYrm92uPbwYEkTHLyqQVqLdQfdnBC74EFbX
	bss4VZYl3w9SNjHG2SZlKg9hRekMUHSBN8Ss+VizKhRDVRscUS3HQD3TepE8qBzQEhauCJq2fzh
	1hCqXZJVbai4QtHGDnDJ6XezmNnFv3Mf68jT7oPLUUL+LSN1JHwnese7i7xcLGMBTmV2eHl849b
	M/i+COpV5IB5sQLuC6Li33uKawB8nERinhZGXsBCEl4sVjfCQdx26mU6TTPk4MTTB3lpTNXGV49
	mHvAVnuuehqiMl7/rff1Wdv2sTzaMva74ahNvb5ZB2CaZ8zys7vI2ItLlINZncrUwwRA10HCzuw
	fiNnFi+E5Md40DQxHHyk7
X-Google-Smtp-Source: AGHT+IFPb9waA98CjEsodSk/NmmLQ1ZnBzxU9eF7fwwfV3+Lk/QdrRxr//FWTFj6LpiihIZeVHwMXg==
X-Received: by 2002:a05:600c:4917:b0:43b:c824:97fa with SMTP id 5b1f17b1804b1-43bcb04f0e3mr27784975e9.14.1741102130656;
        Tue, 04 Mar 2025 07:28:50 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238381775e9.26.2025.03.04.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:28:50 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] clk: sunxi-ng: Add support for update bit
Date: Tue, 04 Mar 2025 16:28:48 +0100
Message-ID: <3616088.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20250304012805.28594-4-andre.przywara@arm.com>
References:
 <20250304012805.28594-1-andre.przywara@arm.com>
 <20250304012805.28594-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 4. marec 2025 ob 02:27:53 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Some clocks in the Allwinner A523 SoC contain an "update bit" (bit 27),
> which must be set to apply any register changes, namely the mux
> selector, the divider and the gate bit.
>=20
> Add a new CCU feature bit to mark those clocks, and set bit 27 whenever
> we are applying any changes.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu_common.h | 4 ++++
>  drivers/clk/sunxi-ng/ccu_div.c    | 2 ++
>  drivers/clk/sunxi-ng/ccu_gate.c   | 4 ++++
>  drivers/clk/sunxi-ng/ccu_mux.c    | 2 ++
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu=
_common.h
> index 50fd268329671..d41d33bdff470 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -20,10 +20,14 @@
>  #define CCU_FEATURE_KEY_FIELD		BIT(8)
>  #define CCU_FEATURE_CLOSEST_RATE	BIT(9)
>  #define CCU_FEATURE_DUAL_DIV		BIT(10)
> +#define CCU_FEATURE_UPDATE_BIT27	BIT(11)

There is no reason to have "BIT27" in the name of the macro. This is similar
to KEY_FIELD, which is generic name and doesn't specify either key or posit=
ion
of this key field. Maybe just CCU_FEATURE_UPDATE_BIT or something equaly
generic.

With that fixed:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> =20
>  /* MMC timing mode switch bit */
>  #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
> =20
> +/* Some clocks need this bit to actually apply register changes */
> +#define CCU_SUNXI_UPDATE_BIT		BIT(27)
> +
>  struct device_node;
> =20
>  struct ccu_common {
> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_di=
v.c
> index 7f4691f09e01f..2d8b98fe4b13a 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.c
> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> @@ -106,6 +106,8 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsign=
ed long rate,
> =20
>  	reg =3D readl(cd->common.base + cd->common.reg);
>  	reg &=3D ~GENMASK(cd->div.width + cd->div.shift - 1, cd->div.shift);
> +	if (cd->common.features & CCU_FEATURE_UPDATE_BIT27)
> +		reg |=3D CCU_SUNXI_UPDATE_BIT;
> =20
>  	writel(reg | (val << cd->div.shift),
>  	       cd->common.base + cd->common.reg);
> diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_g=
ate.c
> index ac52fd6bff677..0490f95781361 100644
> --- a/drivers/clk/sunxi-ng/ccu_gate.c
> +++ b/drivers/clk/sunxi-ng/ccu_gate.c
> @@ -20,6 +20,8 @@ void ccu_gate_helper_disable(struct ccu_common *common,=
 u32 gate)
>  	spin_lock_irqsave(common->lock, flags);
> =20
>  	reg =3D readl(common->base + common->reg);
> +	if (common->features & CCU_FEATURE_UPDATE_BIT27)
> +		reg |=3D CCU_SUNXI_UPDATE_BIT;
>  	writel(reg & ~gate, common->base + common->reg);
> =20
>  	spin_unlock_irqrestore(common->lock, flags);
> @@ -44,6 +46,8 @@ int ccu_gate_helper_enable(struct ccu_common *common, u=
32 gate)
>  	spin_lock_irqsave(common->lock, flags);
> =20
>  	reg =3D readl(common->base + common->reg);
> +	if (common->features & CCU_FEATURE_UPDATE_BIT27)
> +		reg |=3D CCU_SUNXI_UPDATE_BIT;
>  	writel(reg | gate, common->base + common->reg);
> =20
>  	spin_unlock_irqrestore(common->lock, flags);
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index d7ffbdeee9e04..82ee21e0d3a68 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -197,6 +197,8 @@ int ccu_mux_helper_set_parent(struct ccu_common *comm=
on,
>  	/* The key field always reads as zero. */
>  	if (common->features & CCU_FEATURE_KEY_FIELD)
>  		reg |=3D CCU_MUX_KEY_VALUE;
> +	if (common->features & CCU_FEATURE_UPDATE_BIT27)
> +		reg |=3D CCU_SUNXI_UPDATE_BIT;
> =20
>  	reg &=3D ~GENMASK(cm->width + cm->shift - 1, cm->shift);
>  	writel(reg | (index << cm->shift), common->base + common->reg);
>=20





