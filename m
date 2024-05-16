Return-Path: <linux-kernel+bounces-180969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1E8C7599
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A67B219F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDC145A17;
	Thu, 16 May 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="baUf73iz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CD145A06
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861111; cv=none; b=nVcD+F5GrsGpAbVVXyy0AEZKk8LF9dZgeFIy/yw1Q/CvVmFo5tDjd7VsgT/MSy6OoiKqvoOpJFiTWdl2BQxq9lBEJ4EM0yC3h6t/h0JDosU2P20wOKmp8F4yaLi5qz6erRg9QQI5nv93vuSssnAUpR0vxpd6pEOS2RmW65TBqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861111; c=relaxed/simple;
	bh=IXQl1Ir2eCpl/tztd4C+Y8VsP94NsB4rmj7IRBHnvZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIzX73tCNdpqaDEg/HOiXNw675WrO/dEqGbNCAYaEFiDarvsrVUqxaAfiXbrJXWy89KppRgdexCpnovsjx3Qg/uO8lY16cAhuva/ZhSB85zP+3HqRhbgcelFbLW3dTEdu7vraB0GNbbCq6Vw6ofjERXWzJV3gis+9e8943t6HEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=baUf73iz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43994327;
	Thu, 16 May 2024 14:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715861098;
	bh=IXQl1Ir2eCpl/tztd4C+Y8VsP94NsB4rmj7IRBHnvZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baUf73iziANfW3jJ06dxbk3jmZrVvaUUSw90ypx0XKvumQsx5h3on7yDyzWVw/HsY
	 bHc8SpMAhIXgGzicQ1veuytxgUmEiY2tZomKL4/QLWv6+auyy3juk9sTbrXHz73FQk
	 NbxbiXjZZDfp4cQq8oCuFmWZ6HgH/iKPrBGAT3N0=
Date: Thu, 16 May 2024 15:04:58 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
	biju.das.jz@bp.renesas.com, aford173@gmail.com, bli@bang-olufsen.dk,
	robh@kernel.org, jani.nikula@intel.com
Subject: Re: drm/bridge: adv7511: Attach next bridge without creating
 connector
Message-ID: <20240516120458.GC6640@pendragon.ideasonboard.com>
References: <20240513080243.3952292-1-victor.liu@nxp.com>
 <4b6e49ee-d2fd-4e54-88d5-ab06d8ebf644@bosc.ac.cn>
 <20240514151211.GG32013@pendragon.ideasonboard.com>
 <83f4289d-3e73-49fb-9be4-93961d3e051b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83f4289d-3e73-49fb-9be4-93961d3e051b@linux.dev>

Hi Sui,

On Thu, May 16, 2024 at 12:13:03AM +0800, Sui Jingfeng wrote:
> On 5/14/24 23:12, Laurent Pinchart wrote:
> > On Tue, May 14, 2024 at 12:26:15AM +0800, Sui Jingfeng wrote:
> >> On 5/13/24 16:02, Liu Ying wrote:
> >>> The connector is created by either this ADV7511 bridge driver or
> >>> any DRM device driver/previous bridge driver, so this ADV7511
> >>> bridge driver should not let the next bridge driver create connector.
> >>>
> >>> If the next bridge is a HDMI connector, the next bridge driver
> >>> would fail to attach bridge from display_connector_attach() without
> >>> the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> > 
> > In theory we could have another HDMI-to-something bridge connected to
> > the ADV7511 output, and that bridge could create a connector. However,
> > before commit 14b3cdbd0e5b the adv7511 driver didn't try to attach to
> > the next bridge, so it's clear that no platform support in mainline had
> > such a setup. It should be safe to set DRM_BRIDGE_ATTACH_NO_CONNECTOR
> > unconditionally here.
> 
> But what if there is a drm bridge prior to adv7511 but after the KMS
> engine? Even though we are still safe if it doesn't create connector
> by obeying modern rule.

In the "old world", that bridge wouln't have created a connector,
because it would detect that there's a next bridge. With modern KMS
drivers, DRM_BRIDGE_ATTACH_NO_CONNECTOR is passed by the
drm_bridge_connector helper to the very first bridge when attaching to
it, so no bridge will create a connector. Modern bridge drivers should
not support the !DRM_BRIDGE_ATTACH_NO_CONNECTOR case at all, they should
not offer the option of creating a connector.

> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> >>>
> >>> Add that flag to drm_bridge_attach() function call in
> >>> adv7511_bridge_attach() to fix the issue.
> >>>
> >>> This fixes the issue where the HDMI connector bridge fails to attach
> >>> to the previous ADV7535 bridge on i.MX8MP EVK platform:
> >>>
> >>> [    2.216442] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /hdmi-connector to encoder None-37: -22
> >>> [    2.220675] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
> >>> [    2.226262] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/i2c@30a30000/hdmi@3d to encoder None-37: -22
> >>> [    2.245204] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c00000/dsi@32e60000 to encoder None-37: -22
> >>> [    2.256445] imx-lcdif 32e80000.display-controller: error -EINVAL: Failed to attach bridge for endpoint0
> >>> [    2.265850] imx-lcdif 32e80000.display-controller: error -EINVAL: Cannot connect bridge
> >>> [    2.274009] imx-lcdif 32e80000.display-controller: probe with driver imx-lcdif failed with error -22
> >>>
> >>> Fixes: 14b3cdbd0e5b ("drm/bridge: adv7511: make it honour next bridge in DT")
> >>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >>> ---
> >>>    drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>> index dd21b81bd28f..66ccb61e2a66 100644
> >>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>> @@ -953,7 +953,8 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge,
> >>>    	int ret = 0;
> >>>    
> >>>    	if (adv->next_bridge) {
> >>> -		ret = drm_bridge_attach(bridge->encoder, adv->next_bridge, bridge, flags);
> >>> +		ret = drm_bridge_attach(bridge->encoder, adv->next_bridge, bridge,
> >>> +					flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >>
> >> As a side note, I think, maybe you could do better in the future.
> >>
> >> If we know that the KMS display driver side has the HDMI connector
> >> already created for us, we should pass DRM_BRIDGE_ATTACH_NO_CONNECTOR
> >> from the root KMS driver side. Which is to forbidden all potential
> >> drm bridge drivers to create a connector in the middle.
> > 
> > That's the recommended way for new drivers. Using the
> > drm_bridge_connector helper handles all this for you.
> > 
> >> The KMS display driver side could parse the DT to know if there is
> >> a hdmi connector, or merely just hdmi connector device node, or
> >> something else.
> > 
> > No, that would violate the basic principle of not peeking into the DT of
> > devices you know nothing about. The display engine driver can't walk the
> > pipeline in DT and expect to understand all the DT nodes on the path,
> > and what their properties mean.
> 
> The (next) bridge at the remote port is not necessary a display bridge.
> Or it is a bridge from the perspective of hardware viewpoint, but under
> controlled by a more complex foreign driver which generic drm bridge
> driver has no authority to attach.
> 
> > What KMS drivers should do is to use the drm_bridge_connector helper.
> > Calling drm_bridge_connector_init() will create a connector for a chain
> > of bridges. The KMS driver should then attach to the first bridge with
> > DRM_BRIDGE_ATTACH_NO_CONNECTOR, unconditionally.
> 
> OK, thanks for teaching us the modern way to use drm_bridge_connector
> helper, also thanks Ying for providing the patch.
> 
> >> However, other maintainer and/or reviewer's opinion are of cause
> >> more valuable. I send a A-b because I thought the bug is urgency
> >> and it's probably more important to solve this bug first. And
> >> maybe you can Cc: <stable@vger.kernel.org> if you like.
> >>
> >>>    		if (ret)
> >>>    			return ret;
> >>>    	}

-- 
Regards,

Laurent Pinchart

