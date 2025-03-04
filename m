Return-Path: <linux-kernel+bounces-543037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02FA4D0CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BA93ABE02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA413C3F2;
	Tue,  4 Mar 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NT2a4Trf"
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD2273FD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051804; cv=none; b=o7RGZzLqk6ZPj4M/IU5YFis3lOichYo2+1zlMvlXdl7wO/hRnbOjx8ImcdO7OdYCAvuEdU73ZWclSTNQVuhG6PKzCXF+66x8WzyE56n7m/2Gx03dIS+E02IQmr5FqlHEejNGVGvYcAlFz/j5b5gNaHC0/Z88q6M0AWamTXDOWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051804; c=relaxed/simple;
	bh=uS3WUoIBtz/nvyCJX966UBSWGGTVqCapRG/lzejnNTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV/7HHJfKggX1igdm/HuQV+Yd4N4IRJJS+ywivCFdWGwwn+B4rjruKXZeo1p2abnnUTfE7vw4gmMUMDPUZrd7ay49npS+uxYPgOIeoC20yjS4sWDmqIqA9LTR0yoid8lWMF3/kQGhkE3Psk3BgE4bo+SU/ZsarDHRQiRXYzkpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NT2a4Trf; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.69] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id ccfe72ea;
	Tue, 4 Mar 2025 09:29:50 +0800 (GMT+08:00)
Message-ID: <23e1ecc4-3386-426a-aa54-4d4c082cbf8a@rock-chips.com>
Date: Tue, 4 Mar 2025 09:29:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/rockchip: lvds: move pclk preparation in with
 clk_get
To: Heiko Stuebner <heiko@sntech.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250301173547.710245-1-heiko@sntech.de>
 <20250301173547.710245-2-heiko@sntech.de>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20250301173547.710245-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0geSVZKGUxLGRgdT0tPGkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a955ec605ff09d6kunmccfe72ea
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6Ohw4MjIPTk5RDQMfFEw1
	STgwCTRVSlVKTE9KS05KTEJKQklKVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSUJPSTcG
DKIM-Signature:a=rsa-sha256;
	b=NT2a4TrfNHveU0WKU0cAELmP0ljXkFKmbmR1ctBGcFyu8WLiCoZsht0anu77GUKa5AtccuUkg1Me+L2dL+poI0ykVjLI+LutYB7K+KG5u8sQMvSIduszgTMLG9FivW+E7QpVxiy89qyzPWbzqPg9t5tc4hfPn5Fd9TziaYTgS7s=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Q0Ngh3SqeCfbqYhzI50INne4PhUBwlC2LXyaQjmjVK8=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko,


On 3/2/25 01:35, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The LVDS block needs a separate pclk only on some socs, so currently
> requests and prepares it in the soc-specific probe function, but common
> code is required to unprepare it in the error path or on driver remove.
> 
> While this works because clk_unprepare just does nothing if clk is NULL,
> this mismatch of who is responsible still is not very nice.
> The clock-framework already has a helper for clk-get-and-prepare even
> with devres support in devm_clk_get_prepared().
> 
> This will get and prepare the clock and also unprepare it on driver
> removal, saving the driver from having to handle it "manually".
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

   Reviewed-by: Andy Yan <andy.yan@rock-chips.com>

> ---
>   drivers/gpu/drm/rockchip/rockchip_lvds.c | 19 +++----------------
>   1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 385cf6881504..ecfae8d5da89 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -448,15 +448,13 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
>   static int rk3288_lvds_probe(struct platform_device *pdev,
>   			     struct rockchip_lvds *lvds)
>   {
> -	int ret;
> -
>   	lvds->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(lvds->regs))
>   		return PTR_ERR(lvds->regs);
>   
> -	lvds->pclk = devm_clk_get(lvds->dev, "pclk_lvds");
> +	lvds->pclk = devm_clk_get_prepared(lvds->dev, "pclk_lvds");
>   	if (IS_ERR(lvds->pclk)) {
> -		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
> +		DRM_DEV_ERROR(lvds->dev, "could not get or prepare pclk_lvds\n");
>   		return PTR_ERR(lvds->pclk);
>   	}
>   
> @@ -480,12 +478,6 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
>   		}
>   	}
>   
> -	ret = clk_prepare(lvds->pclk);
> -	if (ret < 0) {
> -		DRM_DEV_ERROR(lvds->dev, "failed to prepare pclk_lvds\n");
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   
> @@ -728,20 +720,15 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
>   	dev_set_drvdata(dev, lvds);
>   
>   	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
> -	if (ret < 0) {
> +	if (ret < 0)
>   		DRM_DEV_ERROR(dev, "failed to add component\n");
> -		clk_unprepare(lvds->pclk);
> -	}
>   
>   	return ret;
>   }
>   
>   static void rockchip_lvds_remove(struct platform_device *pdev)
>   {
> -	struct rockchip_lvds *lvds = platform_get_drvdata(pdev);
> -
>   	component_del(&pdev->dev, &rockchip_lvds_component_ops);
> -	clk_unprepare(lvds->pclk);
>   }
>   
>   struct platform_driver rockchip_lvds_driver = {

