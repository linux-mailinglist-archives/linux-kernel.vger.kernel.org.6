Return-Path: <linux-kernel+bounces-188566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D78CE3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0C31C21596
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6BE8528D;
	Fri, 24 May 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZ1JdAFn"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259485275
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543684; cv=none; b=S2UtuYwQ3hdRIx680e6CiRYVBsBOi4Er4iSQYOMx9yF7Pr4wg1iwjAP5r/y8JMTKmdg6wLrIJ1fzxu2cmQAwUWN7bzWqalx+ow/q/sHityIr0gytAnnYYSqA1AsIU6HcEZFTJJrKd5HVi0++KQp4M9Sgg4NDzHoYvw79M0gefB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543684; c=relaxed/simple;
	bh=qgqj8Y3S0dJy4j6IWDM6K9Y/ZVJQc7t4LatK61RFuw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQSjQ9COO/9I9dNZ7T//97gf8pfNGSmrSSp61dLjQ8Tzh9SQWe1aU+wAU53Qg9r7NRt6NtYRfe2qu9XJqSQ5dPDs/wtUOmDG6NpNk6yhgnPMiRBD9Toeaa/RPctETcL9fpBT2/rrZtZnVdomeiY7+/pCunS26NsLC2qWCKHRHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZ1JdAFn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295f201979so708496e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716543681; x=1717148481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oY7M7YZjt3nSc9aAtwKQQ6ONpLbdvzagMOQYIR5S90=;
        b=RZ1JdAFn5CYnuys3/OWrN71cQ+ExL1mNvoBHnGsf1iimKqYOtsHCX8ynWffd/oazkh
         R/IJoZn2izsnW2vt5VkTw2rP2oYNc+23mAdiFJlCTxMYQDyc6PlRPB2V3050MRdsYjGH
         ZqQatcmBo99QSJzvUC1qOK/+x/sBl6ylJPlhshKEIavRiypQLh3sAAf4vWDL4e9s9Utn
         bQyh83bJzfPxm6GVfeCW1ZZFB7ASiu+Tc4S/UrHWZQdw5LPDfFIguHC5SCI/K7rPmge9
         cID9QFaDR9pB2JMzCBsaAOeyxTkklSiYmCeNo8UAMEyjwADiW3wR1SwzFj7aXz57NMY0
         CyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543681; x=1717148481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oY7M7YZjt3nSc9aAtwKQQ6ONpLbdvzagMOQYIR5S90=;
        b=gstzW0F/GEfBSkJjDIDIDm5HPmnqwWA9lkwcXrac9K1q0f+aklSFIpMnR0WY8yrfgz
         bG0UUdjNX1oK9ke09JdoNAUsBoolX4Rt0nJB91Pi+1b93jkC+XPqjXTd6iDRUv8l1+zH
         BuhAK0ZOBAEf6bDLD/VnNS1iJh6yZv2dn3540FnFagw45Y3EnUhisC2UGlM3BeNM8wH5
         f/rDos/qPjZjiDfZOpFojkrhUKoI4H4YArGg6KC9aak93kKpDj5Fv9BndeuFfUorGcC2
         7gPoaAWkBC5XJoyuJ4qsd6b+mv1UsGJ/aoBbZZhevrf1e5Q7sKAGiyQdAKkWtvqjyJrZ
         H7bA==
X-Gm-Message-State: AOJu0Yy5yS62RhFP7tIJV6SzbswvjUDKSYCBmnBdFvkeoMB8otHSkbD3
	gSNk/QccbPIZX+yp8e3As8uM62N7MtR2gIwogqVb/SCpTorEk/X6n2DWPOqL88E=
X-Google-Smtp-Source: AGHT+IFphI7dLNDBXoZCYGKNm7IhUn6LAbs1T5hWe8EjxPXqehUTVm8QYNnVsSO9sqL42C2JsYW2rw==
X-Received: by 2002:a05:6512:36d3:b0:51b:18f7:6a9e with SMTP id 2adb3069b0e04-529666d5df3mr886961e87.45.1716543680630;
        Fri, 24 May 2024 02:41:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529712f0a9asm137698e87.273.2024.05.24.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:41:20 -0700 (PDT)
Date: Fri, 24 May 2024 12:41:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	sam@ravnborg.org, mripard@kernel.org, dri-devel@lists.freedesktop.org, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com
Subject: Re: [PATCH v3 1/2] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <y6ersd72tp2d6k4i2hja7bg37lahnvye2qion67urxeakw6rju@dher7oomt2ks>
References: <20240524093509.127189-1-j-choudhary@ti.com>
 <20240524093509.127189-2-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524093509.127189-2-j-choudhary@ti.com>

On Fri, May 24, 2024 at 03:05:08PM +0530, Jayesh Choudhary wrote:
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
>  drivers/gpu/drm/bridge/sii902x.c | 37 ++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 2fbeda9025bf..bae551e107f9 100644
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

There is no need to. The drm_bridge_chain_mode_valid() should take care
of calling bridge's mode_valid callback and rejecting the mode if it is
not accepted.

>  }
>  
>  static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
> @@ -504,6 +526,16 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
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
> @@ -516,6 +548,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
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

