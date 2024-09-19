Return-Path: <linux-kernel+bounces-333618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D197CB76
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F921C24D33
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F31A38E4;
	Thu, 19 Sep 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ac6qqGxv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946861A2C17
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758831; cv=none; b=ke5xxUJfZg1hPkM46j28TILykY/SuGnEeAP8paAj3SKsFZ3+7EyTeOBNr7NGKhFEbVqQwdv96oMKNhhy2qaF+UVN9GviaoZ+CdeM5Q1Udx8OfbIwbCmL3CTabw33vJeZ3DIUaui6VV5ldH41hmNnDNuX8XAXhx5aC9doR172UXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758831; c=relaxed/simple;
	bh=l5hXmzpmSQx6Kam368NPtUvlj3riI+zJkbdxyAH0Gh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ML3W3c8L2fwLZt4AcBQ/2D14imMg3PjD83lEgxURZgZEzyzY7O5y6usLnnzmsYBjHTzPC8GW5yUffgZ4Fk89tl1P2jIdLJ0AM60qSJoMAz9fMRJgrg3ysnld1Qt3aGT7RW/GyTzciYBC7juFhMrnLzMBDjbbg1g86lf5rvxTtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ac6qqGxv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IV8+8ZWHAALvR0hrP9GkXzZ6zlc7DVgRJqAHVxnUbpg=; b=ac6qqGxvt1gafK8Q8SSddwk8CV
	i813GDlasoPimS5/br/9eVXM8B3XwduoYG7rfTWGdlzTiSyFVBUHhxlijWtZ9sKaBGgDPVkVB03I6
	3UEUjoRvEkl2a0hmFoqnhEg9m9O/kX48Mf9hKxUXtGNUyTL3NR4hUTxjgrzLTbTLsFls1/XkP4BJX
	6hfu5YZVQyT3T/qqcbs+d/07g1Eaw3N4/Bjp+TsDEt2GcwA8jI93/2hCgzR7Xs8enTqiiXz+gpqEf
	ikjqpGQM47/56Jq+Nrfz6Yy+dbh7Uf8dRnQdr6f7zyxxI3E5OrRy8WEvdh/8PfvztLc0cjz4Q2opv
	YCgRRCGQ==;
Received: from ip092042140082.rev.nessus.at ([92.42.140.82] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1srIp0-0003k7-8X; Thu, 19 Sep 2024 17:11:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, jic23@kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ruanjinjie@huawei.com
Subject:
 Re: [PATCH -next v2 2/3] drm/rockchip: Simplified with dev_err() and __free()
Date: Thu, 19 Sep 2024 17:11:53 +0200
Message-ID: <2234687.1BCLMh4Saa@phil>
In-Reply-To: <20240827030357.1006220-3-ruanjinjie@huawei.com>
References:
 <20240827030357.1006220-1-ruanjinjie@huawei.com>
 <20240827030357.1006220-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Dienstag, 27. August 2024, 05:03:56 CEST schrieb Jinjie Ruan:
> Avoid need to manually handle of_node_put() by using __free(), and use
> dev_err() to replace deprecated() DRM_DEV_ERROR(), which can simplfy
> code.

please make that two separate commits, one for the dev_err conversion
and one for the __free() thing.

The general rule of thumb is that if you need an "and" to describe your
changes it's somewhat likely that things should be split.

Also patch subject should be "drm/rockchip: lvds: ...."


Thanks
Heiko

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 38 ++++++++----------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index f5b3f18794dd..700ac730887d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -548,16 +548,14 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	struct drm_encoder *encoder;
>  	struct drm_connector *connector;
>  	struct device_node *remote = NULL;
> -	struct device_node  *port;
>  	int ret = 0, child_count = 0;
>  	const char *name;
>  	u32 endpoint_id = 0;
>  
>  	lvds->drm_dev = drm_dev;
> -	port = of_graph_get_port_by_id(dev->of_node, 1);
> +	struct device_node *port __free(device_node) = of_graph_get_port_by_id(dev->of_node, 1);
>  	if (!port) {
> -		DRM_DEV_ERROR(dev,
> -			      "can't found port point, please init lvds panel port!\n");
> +		dev_err(dev, "can't found port point, please init lvds panel port!\n");
>  		return -EINVAL;
>  	}
>  	for_each_child_of_node_scoped(port, endpoint) {
> @@ -569,13 +567,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  			break;
>  	}
>  	if (!child_count) {
> -		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
> -		ret = -EINVAL;
> -		goto err_put_port;
> -	} else if (ret) {
> -		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
> -		goto err_put_port;
> -	}
> +		dev_err(dev, "lvds port does not have any children\n");
> +		return -EINVAL;
> +	} else if (ret)
> +		return dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
>  	else
> @@ -587,7 +582,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  		lvds->output = rockchip_lvds_name_to_output(name);
>  
>  	if (lvds->output < 0) {
> -		DRM_DEV_ERROR(dev, "invalid output type [%s]\n", name);
> +		dev_err(dev, "invalid output type [%s]\n", name);
>  		ret = lvds->output;
>  		goto err_put_remote;
>  	}
> @@ -599,7 +594,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  		lvds->format = rockchip_lvds_name_to_format(name);
>  
>  	if (lvds->format < 0) {
> -		DRM_DEV_ERROR(dev, "invalid data-mapping format [%s]\n", name);
> +		dev_err(dev, "invalid data-mapping format [%s]\n", name);
>  		ret = lvds->format;
>  		goto err_put_remote;
>  	}
> @@ -610,8 +605,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  
>  	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(drm_dev->dev,
> -			      "failed to initialize encoder: %d\n", ret);
> +		dev_err(drm_dev->dev, "failed to initialize encoder: %d\n", ret);
>  		goto err_put_remote;
>  	}
>  
> @@ -624,8 +618,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  					 &rockchip_lvds_connector_funcs,
>  					 DRM_MODE_CONNECTOR_LVDS);
>  		if (ret < 0) {
> -			DRM_DEV_ERROR(drm_dev->dev,
> -				      "failed to initialize connector: %d\n", ret);
> +			dev_err(drm_dev->dev, "failed to initialize connector: %d\n", ret);
>  			goto err_free_encoder;
>  		}
>  
> @@ -639,9 +632,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  
>  		connector = drm_bridge_connector_init(lvds->drm_dev, encoder);
>  		if (IS_ERR(connector)) {
> -			DRM_DEV_ERROR(drm_dev->dev,
> -				      "failed to initialize bridge connector: %pe\n",
> -				      connector);
> +			dev_err(drm_dev->dev, "failed to initialize bridge connector: %pe\n",
> +				connector);
>  			ret = PTR_ERR(connector);
>  			goto err_free_encoder;
>  		}
> @@ -649,14 +641,12 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  
>  	ret = drm_connector_attach_encoder(connector, encoder);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(drm_dev->dev,
> -			      "failed to attach encoder: %d\n", ret);
> +		dev_err(drm_dev->dev, "failed to attach encoder: %d\n", ret);
>  		goto err_free_connector;
>  	}
>  
>  	pm_runtime_enable(dev);
>  	of_node_put(remote);
> -	of_node_put(port);
>  
>  	return 0;
>  
> @@ -666,8 +656,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	drm_encoder_cleanup(encoder);
>  err_put_remote:
>  	of_node_put(remote);
> -err_put_port:
> -	of_node_put(port);
>  
>  	return ret;
>  }
> 





