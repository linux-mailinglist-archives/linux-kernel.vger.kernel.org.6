Return-Path: <linux-kernel+bounces-401746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152199C1EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66362845B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E451EF09F;
	Fri,  8 Nov 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dNH0V0t0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F99137E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074233; cv=none; b=MygdXDknOnsf2FifgOhnQbXKQ96BdUXRkp42chcSSyD9xP9d8pOdoo1w4G5xUqqMvKzou7f/ZQ2MpkfF81WispgoFOCoBASxSXFUYuQ5Kls6qF6ei+gJzSxubCFDGRZK3HG6V6TACUBAz5afGm+gez4PLp/IEuxC/MSkouGRfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074233; c=relaxed/simple;
	bh=opquHHEhGVzb/p/HawUauY5ToayMMxCRznSV/zndxqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvEkB90jrCKW/QkGRoWbwRRS9pX4tmAl1Aa5KxYBL1PxrSXyHfYljgor7W0Qykc9TySbB5i0T5XtRQDbVe2sHfDyYY0bIGLtNmGbXvIPfWyrq3IBV63A12K1u6jJzErfkEMnzksUpk58wL0JWYfczewb3RM1Wx7+vfXZPzj/zRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dNH0V0t0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=78Y1JoVFkZuBkpLjUlEv4mMs5Q6hmXPT2whCgK1XDTI=; b=dNH0V0t0Ayw9j/OiJ5WjyYGdWj
	mgfTW3GzzqcQswfje4C5TAasrSb+TvY2D33GEfMuGWYB1q8scJuDIM+NhmKdS2Yf0lMjnnUee/ciq
	FPnaC0sBjtxxeIGnt8ZEDCldJVjR0n13xL5clhOpGd7MCnMFjCu0/BQ5DDXcCkwrS5on9J+s/I8lm
	BgMwWBvkx+3GVj3MA4nl8gzCBm1ulNgT+jz0ShHueQFUF1ntkovIwwCyBsyQe8pLcktDz7WlDchDG
	8VORumLcPYxc8deZHJY5qK7coYFae+JkFPxXS39Nsp74RSqh/VzuNWkVZYMFnkMJTWQjAbbAei0yK
	A14m9Eag==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9PTb-0006UM-JH; Fri, 08 Nov 2024 14:56:39 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Perform trivial code cleanups
Date: Fri, 08 Nov 2024 14:56:38 +0100
Message-ID: <13633881.uLZWGnKmhe@diego>
In-Reply-To:
 <35555b58a7284450fb16281514e4e6a3eb9c7b82.1731073565.git.dsimic@manjaro.org>
References:
 <cover.1731073565.git.dsimic@manjaro.org>
 <35555b58a7284450fb16281514e4e6a3eb9c7b82.1731073565.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Dragan,

Am Freitag, 8. November 2024, 14:53:57 CET schrieb Dragan Simic:
> Perform a few trivial code cleanups, to make one logged message a bit more
> consistent with the other logged messages by capitalizing its first word, and
> to avoid line wrapping by using the 100-column width better.
> 
> No intended functional changes are introduced by these code cleanups.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 58a44af0e9ad..f451e70efbdd 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -1379,7 +1379,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!dsi->cdata) {
> -		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> +		DRM_DEV_ERROR(dev, "No dsi-config for %s node\n", np->name);

this is all probe-related, why not convert to dev_err_probe?

As the doc states [0], DRM_DEV_ERROR is deprecated in favor of dev_err.
So dev_err_probe would be the correct way to go?



[0] https://elixir.bootlin.com/linux/v6.11.6/source/include/drm/drm_print.h#L431

>  		return -EINVAL;
>  	}
>  
> @@ -1408,19 +1408,16 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>  			dsi->pllref_clk = NULL;
>  		} else {
>  			ret = PTR_ERR(dsi->pllref_clk);
> -			DRM_DEV_ERROR(dev,
> -				      "Unable to get pll reference clock: %d\n",
> -				      ret);
> +			DRM_DEV_ERROR(dev, "Unable to get pll reference clock: %d\n", ret);
>  			return ret;
>  		}
>  	}
>  
>  	if (dsi->cdata->flags & DW_MIPI_NEEDS_PHY_CFG_CLK) {
>  		dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
>  		if (IS_ERR(dsi->phy_cfg_clk)) {
>  			ret = PTR_ERR(dsi->phy_cfg_clk);
> -			DRM_DEV_ERROR(dev,
> -				      "Unable to get phy_cfg_clk: %d\n", ret);
> +			DRM_DEV_ERROR(dev, "Unable to get phy_cfg_clk: %d\n", ret);
>  			return ret;
>  		}
>  	}
> @@ -1465,8 +1462,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>  	if (IS_ERR(dsi->dmd)) {
>  		ret = PTR_ERR(dsi->dmd);
>  		if (ret != -EPROBE_DEFER)
> -			DRM_DEV_ERROR(dev,
> -				      "Failed to probe dw_mipi_dsi: %d\n", ret);
> +			DRM_DEV_ERROR(dev, "Failed to probe dw_mipi_dsi: %d\n", ret);
>  		return ret;
>  	}
>  
> 





