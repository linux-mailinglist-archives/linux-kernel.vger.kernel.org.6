Return-Path: <linux-kernel+bounces-218820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6A90C68B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DB82838D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1F13DB8C;
	Tue, 18 Jun 2024 07:55:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA178676;
	Tue, 18 Jun 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697324; cv=none; b=NG6K0fXrkmksDMkNxotshs2KWuAfzcY2GaI1fZ29oD2iaGijhTCR3BSm84sU5NeOjQEgWyIDJDywwuD0wdWe8Jx/7AU3Nk2ukBmudMMonx1Y/XggYgBBMHzX5SWEpD5AeiUW2f4C26Ggoy7EWc/1Rb+0W9lO2YMF7kDhwJShqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697324; c=relaxed/simple;
	bh=sZKR+sLy+bRXAGE9o4OiZW8e6Z1WBQIJ4iiceusdjtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpCVjjG9Zm6PGYj2QXvAtcc680q0+my0eVU69Jy2gkBmj9twl7ZbaADVD9CIQ54/dF7YqEp3SczD7fuQXGbJ54k17sqwZ8rhJWeRPFEJMpb/pSP7VdD/flKmp86pPi7ZZFCu2bCnIQkF2f8GzncPzCG5ZVfqnJ1l39wlxjBLGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJTgP-0006QI-C0; Tue, 18 Jun 2024 09:55:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Algea Cao <algea.cao@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH 4/4] phy: phy-rockchip-samsung-hdptx: Add clock provider support
Date: Tue, 18 Jun 2024 09:55:12 +0200
Message-ID: <2910644.FA0FI3ke8A@diego>
In-Reply-To: <20240618-rk3588-hdmiphy-clkprov-v1-4-80e4aa12177e@collabora.com>
References:
 <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
 <20240618-rk3588-hdmiphy-clkprov-v1-4-80e4aa12177e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 17. Juni 2024, 23:48:12 CEST schrieb Cristian Ciocaltea:
> The HDMI PHY PLL can be used as an alternative dclk source to RK3588 SoC
> CRU. It provides more accurate clock rates required by VOP2 to improve
> existing support for display modes handling, which is known to be
> problematic when dealing with non-integer refresh rates, among others.
> 
> It is worth noting this only works for HDMI 2.0 or below, e.g. cannot be
> used to support HDMI 2.1 4K@120Hz mode.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 189 +++++++++++++++++++---
>  1 file changed, 167 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 72de287282eb..ad3fd4084377 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c

>  static int rk_hdptx_phy_power_on(struct phy *phy)
>  {
>  	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
>  	int bus_width = phy_get_bus_width(hdptx->phy);
> +	int ret;
> +
>  	/*
>  	 * FIXME: Temporary workaround to pass pixel_clk_rate
>  	 * from the HDMI bridge driver until phy_configure_opts_hdmi
> @@ -871,20 +925,18 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
>  	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
>  		__func__, bus_width, rate);
>  
> -	return rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
> +	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
> +	if (!ret)
> +		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);

I think this will need a put if _mode_config fails?

> +
> +	return ret;
>  }


Heiko



