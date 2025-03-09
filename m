Return-Path: <linux-kernel+bounces-553017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF66A58298
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A9188D5F1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF619F103;
	Sun,  9 Mar 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7bST9Sl"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2017ADE8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511879; cv=none; b=lCmDkBPlujfkP6O9s6hzbqIAM/W9L38y773zQRtulBT09K4glEYrKibyr1kn3hAxTk+aiSYFrJ1bbrL6dbmwdyPIMgpiK07UN1FkIUKo9sFIKVS4wpQ7jfswMTmSu2IjkXIosp6qGhIv06l5G9OvL2JyZU/+ipkxlBXnEh2g2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511879; c=relaxed/simple;
	bh=1WAfpS9djc2Vef9uTMYeMxtcZmvL1He6joBABBwhNuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHTknWQUt0Stsppb8xkQzyDZmzhobWSYxg/XA5q7Jsv7FWRWxnLB3Fc6Dhh8Fc273nvk0Kttqz8/pp8uscOQq0637YogpNdnqY3LKg/V9+nKSaWJB+zn/PN703CcBy5F+HRirx84K7pORCvOABeBLyCan/8QoTHKTm2lb236cvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7bST9Sl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fda22908d9so23784337b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741511877; x=1742116677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIwW4mMqcjhikStJ4LuoRwMzffSHbBGrUJN18yF51J4=;
        b=u7bST9SlY8RxR7TzzH58lXgnA3Y86bspba1JrnXWb8UStHY6uhH1hWFsdL1Wyp+1qM
         S6y/7wY4D+ByFOV1jGK6T0XnMe6OwDca6r7xZSGNm/Iv9XXjC1vjJtOgSg3IquEMuDWD
         +3sokkUl6QFSt+O/a04fmA2yKDNDbhwtM1xMM7cmf2/z691ieJ/PDdaMV0X+O97592eo
         dXwEFo8L12Jfcddwy7dm5eHPh958mX53KgFjFkER2n1phezsoKPsjiJOfTNbQg6zy+/E
         pwN+AwDSKbUJyWAp/57Bu5ky61HJPcbs9c9EcmjMYiEsqf/hQG1LP8CQON2XRSGK4Qn0
         zJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741511877; x=1742116677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIwW4mMqcjhikStJ4LuoRwMzffSHbBGrUJN18yF51J4=;
        b=rhBomTmrV3Uzb+GD2NtFmjUggikRZNP1ZufIia1f9GEzpLa+rZtMcF1eg27yYWjfwE
         vzUzZaHILUcpV1X0/hUCLx817pOs+ORkAYeMsAiEXZed+bl2GJRHhSi67HmjjuzIA5iK
         8da/bYRCrFuMZob3FmZygnxlQV2OE2NQPYDSaI3rXUCemw1WmKbDGdq4eFKEdvwHS08u
         TLzEMU8y14WYMKiD79L29CAeI7Yd8O8dYgkeaVyDvMOgByscRnO+b3MXs1FIPzzQK2YN
         uWdZcEfWn9nSRdd7x+xWkRmwnFp+38GczFIleEEEdVIH02DJTCS/SLLAs0yLzjsH9XWf
         200A==
X-Forwarded-Encrypted: i=1; AJvYcCWps1LsJxwZrXR7yJW4SEDoH0BCsiySgkaEl5E5Ps6q9tFP82iQkpLRzPY3tQzMDvGPRp8DW94H4wTN3MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzpQ91Sze3mydS2a0S5kwLjwc0ie+dXnW5vf41VcTZCyp82Kxu
	MRujaW8IN0gNEs51JBF8QSFiHt6s4oUFC8e91GTgeYV4GIt8/BYSd+d5oTjbzqLYbo8x6pFJGvv
	nvitB18Hs+kggEIdITl3AdRl4RaWMTkJkbkJr1A==
X-Gm-Gg: ASbGncv3JalhToWEqnSbw4j0VbuEPjR0X7hOLFlgtB/wU7KZLHXll9G3GMpMYqfkfGi
	tRVvBZ9PewdWk5rlFVXAohxmEPvWat5zk2G1WS7SGGTYnA5dWOAmk/dhlDX6/YjltQDLZEqJa/4
	fi8QzU4gF4i5QTjMCPcfHb7P/fuMwjHKQ2N2U29wOf
X-Google-Smtp-Source: AGHT+IF5EPBAwX/vFFn1MyOCNXGFDeVtGYDbOKvZ8oN+itZnMpk7nJvsL5ZhfsKbFo9VQ/c2bu3NL+W9hdt3Gt+ff7Q=
X-Received: by 2002:a05:690c:3612:b0:6fd:2192:cf3c with SMTP id
 00721157ae682-6febf3b7663mr133674427b3.34.1741511876931; Sun, 09 Mar 2025
 01:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-3-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-3-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:17:46 +0200
X-Gm-Features: AQ5f1Jo12FGGsHm8kzdQ4xf0NIPejEccC7plOVJMbEqHfZYKsXU52PdjyJ4Y43Q
Message-ID: <CAA8EJprBcGz0tZ5SDVC_WK2bzjXZAtOj+LfGnSxmwktvaQw=VQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio setup
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
> and not before.

Am I correct that the only functional change is a switch from
greater-or-equal to simple greater?

>
> While at it, introduce a define for this rate limit constant.
>
> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index f88369864c50e4563834ccbb26f1f9f440e99271..cf2c3a46604cb9d8c26fe5ec8346904e0b62848f 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -320,6 +320,7 @@
>  #define LN3_TX_SER_RATE_SEL_HBR2_MASK  BIT(3)
>  #define LN3_TX_SER_RATE_SEL_HBR3_MASK  BIT(2)
>
> +#define HDMI14_MAX_RATE                        340000000
>  #define HDMI20_MAX_RATE                        600000000
>
>  enum dp_link_rate {
> @@ -1072,7 +1073,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
>
>         regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
>
> -       if (rate >= 3400000) {
> +       if (rate > HDMI14_MAX_RATE / 100) {
>                 /* For 1/40 bitrate clk */
>                 rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
>         } else {
>
> --
> 2.48.1
>


-- 
With best wishes
Dmitry

