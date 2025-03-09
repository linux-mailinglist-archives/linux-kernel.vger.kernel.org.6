Return-Path: <linux-kernel+bounces-553025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C6A582A4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3393ACFB8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA319DF99;
	Sun,  9 Mar 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYFXFspp"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424CECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512184; cv=none; b=CI3NZzlriGs6xloKRIYM92oyRwqxrPO/uwHP29Fk+/DkaWRm686g9UfO1Y4dkbjOmzrt0XbUEW5h3B7ttVI6TFEhfEAtYZvyK5rrQHp9Sm9cJalPVgUnmKOEHbsmjjWvGmJgSFk+lc9NRPTZqgwf06UzEbG7amuLXGEG8CBUVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512184; c=relaxed/simple;
	bh=wyMnkRcp1Q4wC1S0dfbxMf/xvU3tvTAnQK6pobLfBww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fgmvy78xZXhKMil/4ixmdTHV7VwyowJmjigeQjdHCICjWtI5LGd7wLb5wtIN7scE+2TEHmDZQXqDgcse3J/RuumtFeNgnbPA3isjgfb0Q0R5WgDXJcm6WN8c1exa2Ph8wBq41EmBirNwmwFLUhqmy57p5nFSLMUN6E6GLsPGfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYFXFspp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e609cff9927so2103588276.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741512181; x=1742116981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMh3NDuLrSGAoXMlAYmObZJYcnKtSuzU7ys7GAZPNb4=;
        b=RYFXFsppLatmam/UUyVNeYIdTCgh3FkjoByQgVwc+RF9uS410SYi3O25YkwHZDGvYe
         IX4cNbpr0ZXWBEp85I8lqWztStI/27V+2PN8Xdyn3Ixwi0TVhCb81cRoBUC1OiYjKkZT
         jXV3ZC5PkvJc9oYEH0PpCMvCPFxB6pzXV5mL5Kbpbeh46GrAu/KOLRCbe94e+xhmqNQo
         pjDQNHK6n0cVADdUwuzcqkiTZT0vM+wlZhammjqgFgakGpcXXWNsPTXntpERx1yCLEX6
         yAvmryI8i2o6hKeuzlSmHBhW5w/sJNpDFbbzI24Mlbo0RL95yPpSRP1hFEgrYXxvxsMu
         Aceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512181; x=1742116981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMh3NDuLrSGAoXMlAYmObZJYcnKtSuzU7ys7GAZPNb4=;
        b=m5HXC/bK57RVy0rmZ5J0ITKJtrcpDVhSthTil3oq04h46IzRr2y/s4+BpUV2tB9CLX
         eNVlAD559weaJMfKDlDjoRYL/lPNAk43/dZSMTQSbRTOuyN1605fhubRarZrOXveBrwu
         my9DN1ZBfcnxwzMaUPj0ogzPkRCedzCj6rsJ4kqW6cG03xVdMLcskbz/xk4ERCs5Bom3
         Et7/fwiFbXbBy9bX5S3III52ok17FlsviPvoYlRQy+EcLqcwGMo0pBH0p11wqh9c97EX
         /x5Y3wmpVrPseZ5HxciBfRdfcIC95SfawjBKO2MiEFL5UeqpRximXmlMKaeX3ZHUmrBK
         hF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJEDCdf6JurtcEEA+97yPr4Tq/MHknuRoblxmxWFT8v9b8+FIAL1c3KNrDe1rNyLmyIomz9pF0s5MhQZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUyfawrXPxOBscAFBzoivdsynh0FGfniZqeP3V4jzGixmdl1q
	pYyS7myfbdtPuY8MVxiNjXNmuNCeTZcqF9zJAXRasaLdPegeW/PKxiiN3L/ZO9fHDkSWoI68ado
	9tBDl/LopNVpl17oIcbsGshOaUuw7pcrUnXhehA==
X-Gm-Gg: ASbGncvYnK03jLArV0BWBIfo+fgt8qG+XaFrYge4dbpOpFFgCzz2iLY4bYWalO5Z2lq
	vGxGkp0QJUxuD72f/CnJQu62JjOz7Lq+lxTWhvrpmSWMuNiz6l6YhNvU7LbmeqJPnoEQ7V2WrB9
	4y47MuH8GKhxW6qYLmv0HdMxMYLL1TtHU/voCOf4BiNp+4dykPjQI=
X-Google-Smtp-Source: AGHT+IGwSjssMypxWMqlAgIxRqvqFw5zCtjXcKaNH8uFEv6oSpbLLZZrkI9ebpcft3vvy7bHOrWbWh76EUn4+31AvMw=
X-Received: by 2002:a05:6902:2702:b0:e5a:e897:2846 with SMTP id
 3f1490d57ef6-e635c13dc87mr11588234276.16.1741512181600; Sun, 09 Mar 2025
 01:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-7-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-7-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:22:50 +0200
X-Gm-Features: AQ5f1JoAeZL47fdNQ51_XRbhIwKgmeJzZ78g4SD2gNds-cV7TO45RQfFMkCcCBs
Message-ID: <CAA8EJpoQbvFbNXQ2RB1qY2gHnwZaU-PT-DMLnZkrxkqs2wkXqQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] phy: rockchip: samsung-hdptx: Avoid Hz<->hHz
 unit conversion overhead
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
> The ropll_tmds_cfg table used to identify the configuration params for
> the supported rates expects the search key, i.e. bit_rate member of
> struct ropll_config, to be provided in hHz rather than Hz (1 hHz = 100
> Hz).  This requires multiple conversions between these units being
> performed at runtime.
>
> Improve implementation clarity and efficiency by consistently using the
> Hz unit throughout driver's internal data structures and functions.
> Also rename the rather misleading struct member.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 79 +++++++++++------------
>  1 file changed, 39 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 2bf525514c1991a1299265d12e1e85f66333c604..e58a01bdb3ce82d66acdcb02c06de2816288b574 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -330,7 +330,7 @@ enum dp_link_rate {
>  };
>
>  struct ropll_config {
> -       u32 bit_rate;
> +       u32 rate;

unsigned long long, please, to match the tmds_char_rate type.

>         u8 pms_mdiv;
>         u8 pms_mdiv_afc;
>         u8 pms_pdiv;
> @@ -410,45 +410,45 @@ struct rk_hdptx_phy {
>  };
>
>  static const struct ropll_config ropll_tmds_cfg[] = {
> -       { 5940000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +       { 594000000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,

Use ULL suffix

>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 3712500, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +       { 371250000, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 2970000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +       { 297000000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1620000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
> +       { 162000000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1856250, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +       { 185625000, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1540000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
> +       { 154000000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1485000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
> +       { 148500000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
>           0x10, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1462500, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
> +       { 146250000, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1190000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
> +       { 119000000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1065000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
> +       { 106500000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 1080000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +       { 108000000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
>           0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 855000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
> +       { 85500000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 835000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
> +       { 83500000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 928125, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +       { 92812500, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 742500, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +       { 74250000, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 650000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
> +       { 65000000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
>           1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 337500, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
> +       { 33750000, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
>           1, 1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 400000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +       { 40000000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
>           0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 270000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +       { 27000000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
>           0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> -       { 251750, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
> +       { 25175000, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
>           1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
>  };
>
> @@ -894,10 +894,10 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
>         regmap_write(hdptx->grf, GRF_HDPTX_CON0, val);
>  }
>
> -static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
> +static bool rk_hdptx_phy_clk_pll_calc(unsigned long rate,

here and further, unsigned long long
Also, is it tmds_char_rate?

>                                       struct ropll_config *cfg)
>  {
> -       const unsigned int fout = data_rate / 2, fref = 24000;
> +       const unsigned int fout = rate / 200, fref = 24000;
>         unsigned long k = 0, lc, k_sub, lc_sub;
>         unsigned int fvco, sdc;
>         u32 mdiv, sdiv, n = 8;

-- 
With best wishes
Dmitry

