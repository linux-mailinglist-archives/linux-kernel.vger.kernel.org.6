Return-Path: <linux-kernel+bounces-333627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87297CB97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBECB23437
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E91A19D093;
	Thu, 19 Sep 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="u9qx8ymc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9041922C9
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759541; cv=none; b=jhDwc8xgoI0RTYIKBWUn5Jspb5Tefn/3L0/h8vGsrW0SsoS662/rmK13Lqlh5BuAEGLFonZ9VyhpOkgvmyw7rLnmfaznUBHFYojbV8zsrCQObj7u27zQeQHl7rQz+ZtBw5YTEt2gjiHX2MR1i+1ipMDzJabkL5XpOX3ORzGaVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759541; c=relaxed/simple;
	bh=UhY9WHEQtVy9iPbGYSpbaAx7Z+9Fciq5ientJ4KqJhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKLwUVAzbGoNvGQz5KyNukuTro+pwuaYHgBk4po30WUM2atWE8qQFxRSAUEJEuwFuBdY83bibNLSrKC7vuzk4UFZgvT2+eA6XazcOdmFYg3vIbNKMNhgCKtz9dtYWcImYfVldllt76XuZl3gnEGAeHNPZ/7opJoj64hTECfUZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=u9qx8ymc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LjaYF2Z7w5SmD4vG50lRcgoF9Gjve69ED8MY5XqnnmA=; b=u9qx8ymcS9UCr0AQBPfuSNE+g0
	ITiUNc9P4vJpYL9d6SHPt9tm4fL6piac8lVSWFrkRuDPlWgiCLACnDcSsIb+UlgHG+BEV2IIAXfJC
	JHuCNNRNDgqPszBAxH2VFW7LpA0s4AfSyqCGEqbmHnXrOx3UZoTCkiI9spGvj4Gs3RX2mr9LGy6G9
	zBadwW8MiYVMBJJrk4dzriLsCR59Xuegiq3OVbEJxaw6kRAvXX6QPPa1hPeb0kETITwYVGuonRtwP
	ikwG2blpwLdBwyolWOkR73evTtQ/Za6W/ChGzYX86Rcgtm2JunOuM/G3QJxfzh2b9DnA3sO7ehX0F
	NrO27rJA==;
Received: from ip092042140082.rev.nessus.at ([92.42.140.82] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1srJ1w-0003ot-1F; Thu, 19 Sep 2024 17:25:19 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, jic23@kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ruanjinjie@huawei.com
Subject:
 Re: [PATCH -next v2 3/3] drm/rockchip: Simplified with dev_err_probe()
Date: Thu, 19 Sep 2024 17:25:06 +0200
Message-ID: <2013930.8hb0ThOEGa@phil>
In-Reply-To: <20240827030357.1006220-4-ruanjinjie@huawei.com>
References:
 <20240827030357.1006220-1-ruanjinjie@huawei.com>
 <20240827030357.1006220-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 27. August 2024, 05:03:57 CEST schrieb Jinjie Ruan:
> Use dev_err_probe to replace deprecated() DRM_DEV_ERROR(), which
> can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 30 +++++++++---------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 700ac730887d..92679e54c71d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c

> @@ -467,24 +465,22 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
>  
>  	lvds->pins->p = devm_pinctrl_get(lvds->dev);
>  	if (IS_ERR(lvds->pins->p)) {
> -		DRM_DEV_ERROR(lvds->dev, "no pinctrl handle\n");
> +		dev_err(lvds->dev, "no pinctrl handle\n");

you're mixing things here.

The commit message talks about dev_err_probe but you're doing
here and below a DRM_DEV_ERROR to dev_err conversion, which also
partially happens in patch 2 of this series.

Please structure things in a way that the patch content matches
the patch description :-)


Thanks a lot
Heiko

>  		devm_kfree(lvds->dev, lvds->pins);
>  		lvds->pins = NULL;
>  	} else {
>  		lvds->pins->default_state =
>  			pinctrl_lookup_state(lvds->pins->p, "lcdc");
>  		if (IS_ERR(lvds->pins->default_state)) {
> -			DRM_DEV_ERROR(lvds->dev, "no default pinctrl state\n");
> +			dev_err(lvds->dev, "no default pinctrl state\n");
>  			devm_kfree(lvds->dev, lvds->pins);
>  			lvds->pins = NULL;
>  		}
>  	}
>  
>  	ret = clk_prepare(lvds->pclk);
> -	if (ret < 0) {
> -		DRM_DEV_ERROR(lvds->dev, "failed to prepare pclk_lvds\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(lvds->dev, ret, "failed to prepare pclk_lvds\n");
>  
>  	return 0;
>  }
> @@ -700,22 +696,18 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
>  
>  	lvds->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						    "rockchip,grf");
> -	if (IS_ERR(lvds->grf)) {
> -		DRM_DEV_ERROR(dev, "missing rockchip,grf property\n");
> -		return PTR_ERR(lvds->grf);
> -	}
> +	if (IS_ERR(lvds->grf))
> +		return dev_err_probe(dev, PTR_ERR(lvds->grf), "missing rockchip,grf property\n");
>  
>  	ret = lvds->soc_data->probe(pdev, lvds);
> -	if (ret) {
> -		DRM_DEV_ERROR(dev, "Platform initialization failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Platform initialization failed\n");
>  
>  	dev_set_drvdata(dev, lvds);
>  
>  	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dev, "failed to add component\n");
> +		dev_err(dev, "failed to add component\n");
>  		clk_unprepare(lvds->pclk);
>  	}
>  
> 





