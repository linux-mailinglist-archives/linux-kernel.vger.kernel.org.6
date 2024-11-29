Return-Path: <linux-kernel+bounces-425405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F69DC1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356CC164B74
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDC17C7BD;
	Fri, 29 Nov 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm9gViXh"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B71607B4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873543; cv=none; b=fYpLu9DzXcCWwMbf8w99eovsIwfZqm+6sGIPSKOFHUzivX2yBzwgxnmp6eHP/iHO7Incgs1WB+IIv4wIiIWmWw9GM5NBxiv9yrydQqRNkYvZCxAsgKnNPvIm+R09vaMAEQx2he9K/FcyifJOUYnLl2moSemNNByLxqP4rc/SDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873543; c=relaxed/simple;
	bh=kYTOdYLfumByQtT4lm725ivrBjreeVTVPxGOeWmX+/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fe0X2HqzymeXBWml/3CMbgYzcVAhQQBFlGycZGr4/1Yjwc3zXemB0XO6LdGIr8cZ3+mMghjipgox6dc5L/oiHrwzz0GuX9blrgV91Q/1HfqwjrQXbUlqscbMZURTw8tD3B1rLpmnOfAedDUIvRQ6/q5+oBlQ5kWfR4be2BMrOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wm9gViXh; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f201a932b2so677866eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732873540; x=1733478340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/VnXj0xSm64G+xnhmGLSxnRi7eiVgvL2X5pSK2r9No=;
        b=Wm9gViXhsZyJNbf9g5OwcrHY/H7XIEoTUjZf2h5O+fnnA7yi/TbH3WGRkSUZZ18+7/
         7uiNhWnhTbpTr32Uy4Pw8A0a81GWTAemukRRYQbWiNIFy+oSgqVj85s6lqeiW9oJWAAb
         zaEy4Ww9p6uErf/4DLAFgKXyU318c1GTj88lACZmIwytsco45J+G/cr33NFG1tiXGT62
         z+h1/TVzl59xKQQInqdGfEHuI5l5O/SQ1LlRLYgQCDofC81A9ATWxecwtpDBG+IID/YG
         QkpNsSabIy08xx+l75sVe0/li+2oAaCgxlTfWFAAsww1YLRvt9pbPFDQj7+BarRhuNaE
         Jxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873540; x=1733478340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/VnXj0xSm64G+xnhmGLSxnRi7eiVgvL2X5pSK2r9No=;
        b=tanuhkTj8Ob//3SBtjXIsC++n/D/hYoXUp9asgp3Q4an8mVzqjXBSwG70KHD66XLNQ
         Mkx/ent8IsgTGsatclZVI30ljl5GDF3hhZ6syPrKuDZyh6zgh/9fr2AFKbu0DfdC8ZYi
         6zXfB7wKobZVtCrZEuzYIukn9ECzvr6esv3E6q+hRm9pAmfNEd6gX2wkoYfIYkzwloGB
         smes7C1NlmCTGaXLKZbXrb49+QoVFXio85sHG+fvK9oJkAaNmWk4X1PQNcINM7X0dGZI
         M+95THdDn02fhGFgSQvh6kQ5qMohkO6KwgnVtBvFKDeya1yY3SKy/oYCKlmSIpWk68jS
         E2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFicZ6lK+3r4uJXADFI/x9vZaeP9gbPVNU0BbvFSa2XJ4j3vSEURYhsz9TpB4C4mBSb6K8sTpLlmxvhXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SFgd3SwpMkNYFi5W64jzNTg0SCVNLuMgtIsOYx/X+irYOOBR
	RJOPjpBKL5t4dUcVGUhop7dCI4KT7fa2EyODn10afyRZZ6UyteypOlRO3smGEfb29HYlAeqD1SQ
	ksJBRf7czUpeY0hm5fylBQPRPQzBwkiDXEeEeIw==
X-Gm-Gg: ASbGncsC0Ecc0oa7NYD/vLdUhebGWkNXvMkyRn8T2dRB/CmjLmCu6XoOissKyUTqU/h
	RxyIuOHsuicOZxeMuyJtFf3M1Hyd66ngC
X-Google-Smtp-Source: AGHT+IHnxS6dF7DDI6r75yOFHU8KPB1OwTru3sBOUtig1dAA1cBoVlmH0MuchExTRQ+k+9Oap9bXnNBRkMu1gCqUvYY=
X-Received: by 2002:a05:6820:2183:b0:5ee:ebcb:e6e9 with SMTP id
 006d021491bc7-5f20a168f5cmr5503129eaf.5.1732873540094; Fri, 29 Nov 2024
 01:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
 <20241127-gs101-phy-lanes-orientation-phy-v1-7-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-7-1b7fce24960b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 29 Nov 2024 09:45:29 +0000
Message-ID: <CADrjBPpZgmE-rwRmbB3BFAL+s0G0rwBiPJ-ZMEVF8BNQ=tviVg@mail.gmail.com>
Subject: Re: [PATCH 7/9] phy: exynos5-usbdrd: gs101: configure SS lanes based
 on orientation
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 27 Nov 2024 at 10:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> USB SS lanes need to be configured based the connector orientation -

small nit: "based the" -> "based on the"

> at most two lanes will be in use for USB (and the remaining two for
> alternate modes like DP).
>
> For the USB link to come up in SS, the lane configuration registers
> have to be programmed accordingly.
>
> While we still need a way to be notified of the actual connector
> orientation and then reprogram the registers accordingly (at the moment
> the configuration happens just once during phy_init() and never again),
> we can prepare the code doing the configuration to take the orientation
> into account.
>
> Do so.
>
> Note: the mutex is needed to synchronize this with the upcoming
> connector orientation callback.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 72 ++++++++++++++++++++++----=
------
>  1 file changed, 51 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index c1ce6fdeef31..1a34e9b4618a 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -23,6 +23,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/soc/samsung/exynos-regs-pmu.h>
> +#include <linux/usb/typec_mux.h>
>
>  /* Exynos USB PHY registers */
>  #define EXYNOS5_FSEL_9MHZ6             0x0
> @@ -209,6 +210,10 @@
>
>  #define EXYNOS9_PMA_USBDP_CMN_REG00B8          0x02e0
>  #define CMN_REG00B8_LANE_MUX_SEL_DP            GENMASK(3, 0)
> +#define CMN_REG00B8_LANE_MUX_SEL_DP_LANE3      BIT(3)
> +#define CMN_REG00B8_LANE_MUX_SEL_DP_LANE2      BIT(2)
> +#define CMN_REG00B8_LANE_MUX_SEL_DP_LANE1      BIT(1)
> +#define CMN_REG00B8_LANE_MUX_SEL_DP_LANE0      BIT(0)
>
>  #define EXYNOS9_PMA_USBDP_CMN_REG01C0          0x0700
>  #define CMN_REG01C0_ANA_LCPLL_LOCK_DONE                BIT(7)
> @@ -383,11 +388,13 @@ struct exynos5_usbdrd_phy_drvdata {
>   * @clks: clocks for register access
>   * @core_clks: core clocks for phy (ref, pipe3, utmi+, ITP, etc. as requ=
ired)
>   * @drv_data: pointer to SoC level driver data structure
> + * @phy_mutex: mutex protecting phy_init/exit & TCPC callbacks
>   * @phys: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
>   *         instances each with its 'phy' and 'phy_cfg'.
>   * @extrefclk: frequency select settings when using 'separate
>   *            reference clocks' for SS and HS operations
>   * @regulators: regulators for phy
> + * @orientation: TypeC connector orientation - normal or flipped
>   */
>  struct exynos5_usbdrd_phy {
>         struct device *dev;
> @@ -397,6 +404,7 @@ struct exynos5_usbdrd_phy {
>         struct clk_bulk_data *clks;
>         struct clk_bulk_data *core_clks;
>         const struct exynos5_usbdrd_phy_drvdata *drv_data;
> +       struct mutex phy_mutex;
>         struct phy_usb_instance {
>                 struct phy *phy;
>                 u32 index;
> @@ -406,6 +414,8 @@ struct exynos5_usbdrd_phy {
>         } phys[EXYNOS5_DRDPHYS_NUM];
>         u32 extrefclk;
>         struct regulator_bulk_data *regulators;
> +
> +       enum typec_orientation orientation;

typec_orientation is defined in #include <linux/usb/typec.h> so it
should be added to the includes

Apart from that

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Validated that a super-speed USB link is established between Pixel 6
phone and my laptop with this patch applied and that adb works.

regards,

Peter

