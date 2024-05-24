Return-Path: <linux-kernel+bounces-188455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4978CE23F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12B5B22494
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4A1292C1;
	Fri, 24 May 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="QPc2lvSj";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Oha+eVIq"
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2887433D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538781; cv=none; b=o2TFkhMK2U4T0MmD3z3EjubGb85Gxc1qpOI3C27Noc67XL0kYJ0A3+r2+3/HWIo97pAsfW2C8oqExDhxyDTBTRw1m2VBRrkAEcalGT/qPcDj4YAOL8QRqqdVjXR/EKh5AEF78ut/EZDqZ1A5Mj7/joRsP74YQD4BPQCKY2FNZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538781; c=relaxed/simple;
	bh=2rSuMo11Bn/Dyzw3QcuMaSHQIVX7mjZ2J8bRZDnBbgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFyo+3Adc4QraYHCuX7TuYQDze8dMfupFCA/r2M/PLQYfN/WKK4shWVmbuf6cnhWpdSbdmMGvPcelnAVlfJ8xrPeSsumOE7s7GU4nwqUbBGaCLe3sgrLuEYL3ootkuXQrhV2iZJmuvFMgS5R4MTpxq00lh8fI2zz96EjfbWO98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=QPc2lvSj; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Oha+eVIq; arc=none smtp.client-ip=46.30.211.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=WDsnsc5BF7LaWXnzxviI75o6u35R944PtHEiU+AMfa4=;
	b=QPc2lvSjvTvdM3EZ82lwNLtg7w2CmIEfMPBxOJrRMFhDEqPbHJRGlJE1DLaVqEP0Vz/LLVy/YFj2Y
	 +byA/49C0hSpmJqWDTLWYwnG2cXTQPh6adWaXvdhEV4mAfFcQAzUGQhqZ7/UVjMzopzH1LHE2Qi9f0
	 2rWXyACTZh5kEvwu8ezDmZfB/csRMp9TVx8R8Y4shJX4zqoejaEZNQXtfL18/j/plZen2QchXfl34H
	 Sd2PCC+OnU5K3mTBmJBITMSjQ3Tf92bYeL2h9JEjDtcI+ZDIkNZxToRtI5rW4pxjBsdhKYZHi4TNJA
	 dqh5i8Y28aDjhqvZr7HNipFkm8huJag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=WDsnsc5BF7LaWXnzxviI75o6u35R944PtHEiU+AMfa4=;
	b=Oha+eVIqCjGc1bf3/x4uLgjogbGIpBgq47NGEZQuPvo3uIX3ttkciDviTBQ3792h0lIYiUgQmPpFg
	 NLSRcORAw==
X-HalOne-ID: 30760f29-19a6-11ef-a05e-2778176e2c98
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 30760f29-19a6-11ef-a05e-2778176e2c98;
	Fri, 24 May 2024 08:18:26 +0000 (UTC)
Date: Fri, 24 May 2024 10:18:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, mripard@kernel.org,
	dri-devel@lists.freedesktop.org, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	a-bhatia1@ti.com
Subject: Re: [PATCH v2 1/2] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <20240524081824.GA615138@ravnborg.org>
References: <20240524073305.107293-1-j-choudhary@ti.com>
 <20240524073305.107293-2-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524073305.107293-2-j-choudhary@ti.com>

Hi Jayesh,

On Fri, May 24, 2024 at 01:03:04PM +0530, Jayesh Choudhary wrote:
> Currently, mode_valid hook returns all mode as valid and it is
> defined only in drm_connector_helper_funcs. With the introduction of
> 'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
> bridge_attach call for cases when the encoder has this flag enabled.
> So add the mode_valid hook in drm_bridge_funcs as well with proper
> clock checks for maximum and minimum pixel clock supported by the
> bridge.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 2fbeda9025bf..ef7c3ab3386c 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -163,6 +163,14 @@
>  
>  #define SII902X_AUDIO_PORT_INDEX		3
>  
> +/*
> + * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
> + * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
> + * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
> + */
> +#define SII902X_MIN_PIXEL_CLOCK_KHZ		25000
> +#define SII902X_MAX_PIXEL_CLOCK_KHZ		165000
> +
>  struct sii902x {
>  	struct i2c_client *i2c;
>  	struct regmap *regmap;
> @@ -310,12 +318,26 @@ static int sii902x_get_modes(struct drm_connector *connector)
>  	return num;
>  }
>  
> +static enum
> +drm_mode_status sii902x_validate(struct sii902x *sii902x,
> +				 const struct drm_display_mode *mode)
> +{
> +	if (mode->clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_LOW;
> +
> +	if (mode->clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_HIGH;
> +
> +	return MODE_OK;
> +}
> +
>  static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
>  					       struct drm_display_mode *mode)
>  {
> -	/* TODO: check mode */
> +	struct sii902x *sii902x = connector_to_sii902x(connector);
> +	const struct drm_display_mode *mod = mode;
>  
> -	return MODE_OK;
> +	return sii902x_validate(sii902x, mod);
>  }
>  
>  static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
> @@ -499,11 +521,22 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>  	 * There might be flags negotiation supported in future but
>  	 * set the bus flags in atomic_check statically for now.
>  	 */
> +
>  	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;

If you spin a v2 then drop the above change as you delete the line again
in the next patch.

	Sam

