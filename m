Return-Path: <linux-kernel+bounces-177022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD68C388C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225D6281CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C681556459;
	Sun, 12 May 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TXKD5RQV"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67156443
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548702; cv=none; b=ur3nN+qGEkoICcIfj2Tqynn/qdwD3mqXEiyOr/jOTVfw2foo6TidqPu8w1DdITvBC30iE+Abcfx7MtkcsPMeWt3uK5oULJZI62xe5QUL46+GuIKybqTfdiIVcdDQc9OSlI3+PX61GBbPEm0P4DT5Dw3+gJJpDIwEuSvNYKN5KiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548702; c=relaxed/simple;
	bh=RDUZ8+FocGX8YVEG5nU4EkYFd9O449ehrN3FKTWnLK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKdmzpZd7bqub+wSmXrq94p8FHaqvWLFM+6Exth3ATe9ofBTfHBFKZfbEGXXOyOhxxT8J6rFTcJImFnTjU+CMSGrfxWrSaZZPWRRon9uBQWqet7WcpZMnV31P2ZG8LSIzBAqUZCHUx2863qI/x47lzMHbbe5qZ9aumnMIXgbHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TXKD5RQV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7914A8BE;
	Sun, 12 May 2024 23:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548693;
	bh=RDUZ8+FocGX8YVEG5nU4EkYFd9O449ehrN3FKTWnLK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXKD5RQVNPAMLy89fHsB+1Btre0gQHgdcxBRhUPPjYvw/pc56g3Zx1qqaz9B4ocKW
	 gUtvoCUqf6EF1eNrM0XrMRuE953FJADPfBUDZ12KvG6OmA4UPes3N4PoqouIMDdTRn
	 7BUGne6QYrf0h+IUzmEeGrtqTJ82pwBO7N1R82Es=
Date: Mon, 13 May 2024 00:18:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: adv7511: Remove a redundant check on
 existence of bridge->encoder
Message-ID: <20240512211811.GP17158@pendragon.ideasonboard.com>
References: <20240511142308.319541-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511142308.319541-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:23:08PM +0800, Sui Jingfeng wrote:
> In the adv7511_connector_init() function, the check on the existence
> of bridge->encoder is not necessary, as it has already been done in the
> drm_bridge_attach() function. And the check on the drm bridge core
> happens before check in the implementation. Hence, it is guaranteed that
> the .encoder member of the struct drm_bridge is not NULL when
> adv7511_bridge_attach() function is called.
> 
> Remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index b5518ff97165..1a0e614e0fd3 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -871,11 +871,6 @@ static int adv7511_connector_init(struct adv7511 *adv)
>  	struct drm_bridge *bridge = &adv->bridge;
>  	int ret;
>  
> -	if (!bridge->encoder) {
> -		DRM_ERROR("Parent encoder object not found");
> -		return -ENODEV;
> -	}
> -
>  	if (adv->i2c_main->irq)
>  		adv->connector.polled = DRM_CONNECTOR_POLL_HPD;
>  	else

-- 
Regards,

Laurent Pinchart

