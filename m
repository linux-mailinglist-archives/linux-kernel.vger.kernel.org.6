Return-Path: <linux-kernel+bounces-177019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 751678C3885
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B79B20E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619A25467F;
	Sun, 12 May 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gKMkrveb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADD3233
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548516; cv=none; b=FMR1fBy0rpxN/ktwKO/q6eAdeEzeYEWsQlABZpg0rJR2TcszUFkSoddZFsjwHigvtgcpdU1oi30V/4pLkyfZxrIetQucfNdp1CNukHDrxaOL22MmOhaq6jrZjEpaA/gKlfCJCpLq1KuYyzHk4p6RBtzXm47t2wcrTQDOmR2mviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548516; c=relaxed/simple;
	bh=Rkze3iANAO8ka/TqH6bLFED6WH90fpw+Xj1Fk1AxUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSJ9ILyOA+ILirIdaLgaql2KWM9zb+JWiI+FZ+ONPDtSuLKgAWm0dasTWOLFzZYLlLaeZNJuT68l2WewYYyvhFdDfP0jsNI3jHyRs6G73y5ArLEZ1DVLh0HR4NfNwxrULFC2Pc9wSV/XbiwdYsOYZV/nk/P+8f3Fpclb36ginCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gKMkrveb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4B00A98;
	Sun, 12 May 2024 23:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548508;
	bh=Rkze3iANAO8ka/TqH6bLFED6WH90fpw+Xj1Fk1AxUKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKMkrvebfwOotaJNVHsGOpFLDbvnJALxqRtA0XsmJx84n+aUG7NAs4As0rccyepL0
	 ZNswEqH95lgUyUMn2EpaN29pQ+G9U3WqYA0c4gUAqBv1t2vkI3ej001e3y0fD4++0v
	 ocpuaDA87oX/zBbooTsDYliElX7NW54ddNtsaadc=
Date: Mon, 13 May 2024 00:15:06 +0300
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
Subject: Re: [PATCH] drm/bridge: it6505: Remove a redundant check on
 existence of bridge->encoder
Message-ID: <20240512211506.GM17158@pendragon.ideasonboard.com>
References: <20240511141056.318679-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511141056.318679-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:10:56PM +0800, Sui Jingfeng wrote:
> In it6505_bridge_attach(), the check on the existence of bridge->encoder
> has already been done in the implementation of drm_bridge_attach(). And
> it is done before the bridge->funcs->attach function hook is called. Hence,
> it is guaranteed that the .encoder member of the struct drm_bridge is not
> NULL when the panel_bridge_attach() is called.
> 
> There is no need to check the existence of bridge->encoder another time,
> remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 27334173e911..494030a75dba 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2881,11 +2881,6 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
>  		return -EINVAL;
>  	}
>  
> -	if (!bridge->encoder) {
> -		dev_err(dev, "Parent encoder object not found");
> -		return -ENODEV;
> -	}
> -
>  	/* Register aux channel */
>  	it6505->aux.drm_dev = bridge->dev;
>  

-- 
Regards,

Laurent Pinchart

