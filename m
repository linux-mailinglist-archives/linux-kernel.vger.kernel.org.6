Return-Path: <linux-kernel+bounces-188564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185ED8CE3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C440B281253
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BB85284;
	Fri, 24 May 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdRdXOdW"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2127E59A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543541; cv=none; b=dfLBjtAm2Nlgg21orjllhTjEps5g5mJzy4cfPTAHfSfqiVteE8fKo0obFHZq3gTDs1DNQ3DExXnUmpqL/j7KHKWtgyENntHh3ugEnBq8kF0Pm+u/QtjBUxCJvlj2QOTvxeO1ZuBNE1CAskilPwxOUc1eNTZIHW8THthd8glZMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543541; c=relaxed/simple;
	bh=GmWImFgq9J49et93BAlYsF5C83pzreMe6llxbDGa1GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8gvJnARaF68jPxOf+l3TX03ipu6KTgAD3U0psGkDxhKdatLFtXpInET35w1Sy8KQBKC3sr2leuF1G23FvYRrO7B5iLYYbAw60liayb+768yh3g/4VRe1yDIz5OgggwNFeA6MicEW5rao7MwRaDoTQrmDb1kEwHHatvvRyqU8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdRdXOdW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295d509178so674468e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716543538; x=1717148338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UiVMlQXjply1VngH6o2XoUEZglHfPuzLqUP2/PP/7Y=;
        b=DdRdXOdW5VHoV1c+wVPAnI2rEpNXxcR16mIvpJDMiyjbpaJlK2wBA5o209ZGzTe5fk
         uGImuEcIq04NjZGjjm7Tuqot9P4RgYwqnnrHh8mmgUaTWpCZJ8/B9j+Y1YPLUFZn1kB1
         FdAAJyqc+hUJOLJlokcwEWCxzwUHRvZF/5l5mo31J90oY7wMc6iX5L8icM3cG0Sq2NhS
         Jn2SqljRILiIGOIVgNn6ZOgdAhUXeTq2R4klR/X1Ll5/DQFjFtRP2vaAy30iwGEzFIhK
         Cz+Mgsmy1Vj52evL4F85/XtozRUmOVA6+33bKl24/y5LErgbfAyRh4UW6Aik5XPhBsLC
         cAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543538; x=1717148338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UiVMlQXjply1VngH6o2XoUEZglHfPuzLqUP2/PP/7Y=;
        b=TQGgbmKae9B/n5OITKW8Vw9C2MUw5jVcL7Rl6Yr8PPXEpSQHcaH+VjqYY5RnZ3jn3v
         vD3D5sB470Vr3VI6r5OHjIh+7Qo9bLBj2U9LT+sDYlJN1EHMnt28utmT0zu9xPpikSWj
         7caQG1adO3PoVVIaJRo4Px9nHd6i3dhtJ6Kha4/T4Gaj5TZR93f5T6AVEP/X9gvxK4v1
         Wk/hO73qTITxpARr+shKTEF2IcPiDk984Yw6H9RzX5SXMK0dF/hlAA3EAlCOsWiILuq5
         qpMMrLOoQ1S83QMZkQ4N7CZmKT3pyPmI7lpVDMuPc5wTDtB/ayFfKtOBSO5iOma7OEP8
         LCAA==
X-Gm-Message-State: AOJu0YzXbcDCni0843Pq7Tlub9LoQil74I9BRhr7qEOFL32rFXXjBWHX
	1IPI3ir6YKUEVUkSlWUUheRQPQbWzoS/+QYA8FF6MXTcM+IK4BXLvJQkz5QRolA=
X-Google-Smtp-Source: AGHT+IE4TTyrwkC+wTvXlOzD5CzFSyyWoJsL8cfv3TMk9wFDEcVkoiyKpWFB6joTttF+9lXtGcsMjg==
X-Received: by 2002:a05:6512:2fa:b0:51c:d05b:6b8d with SMTP id 2adb3069b0e04-5296547ae1dmr1416752e87.23.1716543537852;
        Fri, 24 May 2024 02:38:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529713e8c7bsm137617e87.284.2024.05.24.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:38:57 -0700 (PDT)
Date: Fri, 24 May 2024 12:38:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	mripard@kernel.org, dri-devel@lists.freedesktop.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com
Subject: Re: [PATCH v2 1/2] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <gcfssxqggszg4tc6o5jx7swtpw3fwdaynnqvndrhleaap4jrld@cp2pjxwf3gqn>
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

If you have a mode_valid for the bridge, I don't think you need to
perform the same check for the connector.

>  }
>  
>  static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
> @@ -499,11 +521,22 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>  	 * There might be flags negotiation supported in future but
>  	 * set the bus flags in atomic_check statically for now.
>  	 */
> +
>  	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
>  
>  	return 0;
>  }
>  
> +static enum drm_mode_status
> +sii902x_bridge_mode_valid(struct drm_bridge *bridge,
> +			  const struct drm_display_info *info,
> +			  const struct drm_display_mode *mode)
> +{
> +	struct sii902x *sii902x = bridge_to_sii902x(bridge);
> +
> +	return sii902x_validate(sii902x, mode);
> +}
> +
>  static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>  	.attach = sii902x_bridge_attach,
>  	.mode_set = sii902x_bridge_mode_set,
> @@ -516,6 +549,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
>  	.atomic_check = sii902x_bridge_atomic_check,
> +	.mode_valid = sii902x_bridge_mode_valid,
>  };
>  
>  static int sii902x_mute(struct sii902x *sii902x, bool mute)
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

