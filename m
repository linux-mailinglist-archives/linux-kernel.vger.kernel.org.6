Return-Path: <linux-kernel+bounces-298620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6B95C984
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419D21F2512F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE6185B62;
	Fri, 23 Aug 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PUdUt5AY"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DB18308E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406288; cv=none; b=Yd4vQ1H21ncjIQm3Z4xmyWYWPh4MnIzvBDosXZUxGmZcOUWkiv0BYsB3L7JiWHZwG9drio/EojxlNnGFBnEVE9ZqeQJ9WA7imVHY8t3Bbm3Ipl/aCIDU8GZBG0ZRbLsMOKTCec1ywQlteDogveosO8Fy8QRmv1WLLxjf66sr30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406288; c=relaxed/simple;
	bh=sKa7e76+OSEuMX6VnDb6pVuHu1v7zdLO+4zN50X2fWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGxHJd4dIeaWbX3GSDXE+uQ2svMtdCb/G5Dbvowm193WbcZQik619UxQK75l10hbZiAehHCsX7zHbjKsaWSOEUdyyi+GFJmTP7BjaJgzPdi8R/QC/yH4nGSW+NFLUMm7gEu9NnFefHEkBQvtzPQZNmXcvE9q28OK7hYLgMMmdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PUdUt5AY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m59ZQS/QDynfIUt+BgMJ3Eb7gxjB4w+cjWXYN6zcnN8=; b=PUdUt5AYgU5tkOgHHICNq6tEJi
	Hu9y/5PVd6c2m/0m93NNklZMyErUGm/2kIEA2xr/+JxuteXY42ylHoIKaTjNV862tugM2p0mwqAG1
	/iNZxZDKqQ+pHoLRKzk8iz9lFXrHRGr2eKAn/Gdqpo15pHO8yLLn+B+8434OtaQItdtO1ODfSC1L9
	gG92tGWkzIljD0TN7xcmvHuxQo7Q2RSWS8lwCjZq3baQdMCbLDhM5kH6TZOie9QzOth9lX+aoYFOo
	Bbp8a1kUvzDc+/xZJsyCirjT4MVG+UqMJilqsBRjy7t8+go1/fxsD412j5o100LR09BcqwEeK3YEO
	bWCj+iuw==;
Received: from i5e861933.versanet.de ([94.134.25.51] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1shQqN-0003v9-ET; Fri, 23 Aug 2024 11:44:31 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, jic23@kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ruanjinjie@huawei.com
Subject:
 Re: [PATCH -next 1/5] drm/rockchip: Use for_each_child_of_node_scoped()
Date: Fri, 23 Aug 2024 11:45:12 +0200
Message-ID: <2361547.ECZNHGQPT7@diego>
In-Reply-To: <20240823092053.3170445-2-ruanjinjie@huawei.com>
References:
 <20240823092053.3170445-1-ruanjinjie@huawei.com>
 <20240823092053.3170445-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. August 2024, 11:20:49 CEST schrieb Jinjie Ruan:
> Avoids the need for manual cleanup of_node_put() in early exits
> from the loop.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Not sure if this should go in in one part or individually, but anyway
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 9a01aa450741..f5b3f18794dd 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -548,7 +548,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	struct drm_encoder *encoder;
>  	struct drm_connector *connector;
>  	struct device_node *remote = NULL;
> -	struct device_node  *port, *endpoint;
> +	struct device_node  *port;
>  	int ret = 0, child_count = 0;
>  	const char *name;
>  	u32 endpoint_id = 0;
> @@ -560,15 +560,13 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  			      "can't found port point, please init lvds panel port!\n");
>  		return -EINVAL;
>  	}
> -	for_each_child_of_node(port, endpoint) {
> +	for_each_child_of_node_scoped(port, endpoint) {
>  		child_count++;
>  		of_property_read_u32(endpoint, "reg", &endpoint_id);
>  		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
>  						  &lvds->panel, &lvds->bridge);
> -		if (!ret) {
> -			of_node_put(endpoint);
> +		if (!ret)
>  			break;
> -		}
>  	}
>  	if (!child_count) {
>  		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
> 





