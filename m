Return-Path: <linux-kernel+bounces-177026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A668C3894
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78B01C20C41
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFE54750;
	Sun, 12 May 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YxcMJYwZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5F381DA
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715548951; cv=none; b=mCES4tY2CCMNgFURuYuFdfbQUiznBAGE5ifSvrqK0UpOAYH3ifNZTpiPXvZLduXtbg70HOrpFRq4t1pkXd/8BUBG9LXzLeseT9hatyCU56i5rU8mw8oTVnShrGPJJEgBIoE0E8v6ER2gvk9WIKIY29WCgYyF+15DJsL0Aw6oCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715548951; c=relaxed/simple;
	bh=IpE/1z4h7esQnfB3BIM9qsCQl4xVSuaOIPmnyTRgaBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p41QumzkWziqX2zSrpSvpgpWw4acPO+fbDQkRWdAT95YRQwpkUGnnetQfwqNwvoj5yA4njqzQiPFe6JJAIWgDtl575da6KiN90s+9Pp487DSAfn42ItU82UxcKi93OLmAs9LfdthYbKe/sTo6/AwdWyknUv1Xp5Q9l14KUq/DXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YxcMJYwZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB2BB8BE;
	Sun, 12 May 2024 23:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715548942;
	bh=IpE/1z4h7esQnfB3BIM9qsCQl4xVSuaOIPmnyTRgaBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxcMJYwZCxTQu53OrYfLQOFrMUZazvyfuG++c0347NxPAvHlz6JXv4gaeKHyFGh0Z
	 t1LZGBRV58ZdFi4eHbd163FJPs/SZz9lz8P1XCMVp8bFSjxx6bvtl4FQ8AYydovExq
	 pCKoKqeaq0FmSJDKMIqNl7Ry8EIQjv2ccgvwKxDI=
Date: Mon, 13 May 2024 00:22:15 +0300
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
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: Remove a redundant check on
 existence of bridge->encoder
Message-ID: <20240512212215.GT17158@pendragon.ideasonboard.com>
References: <20240511143027.320180-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511143027.320180-1-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Sat, May 11, 2024 at 10:30:27PM +0800, Sui Jingfeng wrote:
> In the cdns_mhdp_connector_init() function, the check on the existence
> of bridge->encoder is not necessary, as it has already been done in the
> drm_bridge_attach() function. And the check on the drm bridge core
> happens before check in the implementation. Hence, it is guaranteed that
> the .encoder member of the struct drm_bridge is not NULL when
> adv7511_bridge_attach() function gets called.
> 
> Remove the redundant checking codes "if (!bridge->encoder) { ... }".
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index e226acc5c15e..16b58a7dcc54 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1697,11 +1697,6 @@ static int cdns_mhdp_connector_init(struct cdns_mhdp_device *mhdp)
>  	struct drm_bridge *bridge = &mhdp->bridge;
>  	int ret;
>  
> -	if (!bridge->encoder) {
> -		dev_err(mhdp->dev, "Parent encoder object not found");
> -		return -ENODEV;
> -	}
> -
>  	conn->polled = DRM_CONNECTOR_POLL_HPD;
>  
>  	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,

-- 
Regards,

Laurent Pinchart

