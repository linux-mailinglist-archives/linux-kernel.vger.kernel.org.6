Return-Path: <linux-kernel+bounces-220554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BA90E397
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323ACB21A39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28E7405F;
	Wed, 19 Jun 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cy8NrbFF"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225B74055
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778973; cv=none; b=h5QVYIdJnQD0rHz7IipGEGPAvCesQnXjspTlpS2igcl6AkAigk5nZqT2IpvnfyhUeux/Cdazmru5RJXQ8tioZQnebRfocyMl5rBzsumwPUai7EaRkZusHfSbyNgcCQzuvDdzxd8yzq2KLQfQACOKQPdMp4QXx56/ENDmmM/URvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778973; c=relaxed/simple;
	bh=nu96u4j4BAOi/H4U19u8USrvvbA6lw7xEAaAW+DdID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJWU3MzN7lqdawzYwlWLQG89u89wVS7vNZLFM8uwwX+JbH7JqRR9LYLr9bJ69IW8sqM50Cwir28WSt+b8EMPcbUwe/oFY3X6NxzBIoWVHKwDEubRpogM/hNYXx8qWz0/hTvfdMFoYiVqCgSNwWERGNio+1GfPqmj/tcjwGaeg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cy8NrbFF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e724bc466fso73153361fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718778970; x=1719383770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVe6/63goKRJc4R8R3+P3luYhbqw7SbXR8og83jLJns=;
        b=Cy8NrbFFUvWe/V/dP1c0qqnpmQsmx/u+JoYgwOI3921KeGqExiaJWo4OaxeASqojfP
         OEQaZJMtLIu085ccIzvLYQyTmbcf8yeOTjN9mwTRJzq/N+xuNxcDhpy1p+0tBLd8zwRC
         2lT/7p1A8LOvJr2rjTUV6nzsxUPumaJHQd4+EiTT1JyTuG36+hqpzOw6h1ISLMBU+UFD
         cwuTDxjmfbsAWCCYwI+tKT7BL/xugv1uVLBVzz9A1MgaFRGjkq2eOzQdk6GMKUTtDb21
         +ekbD9pwPlYxT0WWOH7N/nHNWCu3zmDy9AypN/Iy5GnicN063tHvfedMYd4RWx0tyIsu
         8KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778970; x=1719383770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVe6/63goKRJc4R8R3+P3luYhbqw7SbXR8og83jLJns=;
        b=eMbVXo1ZmxHoNNoVosuKSDtsNXlCg+Ctcuukiuk7M21XhTfst1UH0sZDkC0xZ4Z1ii
         rpot7AUSjkM12aAODhj9HsOTwFDy5JTMecWvKzkwssc6FQkN1xLjm4E21i2ZDIY54Mlw
         3Oe7Xw+qWaHQ0k7YyTqRQYU2h5PFQeE7qdMDaAf/Wm1n4EIXCRhEYpyDJtDKDIuiLXQH
         iA+5sspqezQE07FjZsy8HGHOX4vqj1UUsW0DSPudU6d5zXkqEkce8TinT7h6nAt3txEN
         fXcT6MRFHcvS8Uc1laekcisOxHJBZ3e4uEZvzMQPAKvtWSNeWlFF3GVdgb5V+rK+fZyn
         9edg==
X-Forwarded-Encrypted: i=1; AJvYcCVtXMCD4m7ld1P1KyPLLsJauB4MCP8y+9BE16mqtLMBsrghkloqX3Zb7ajK4544HiEiA9Llvkr6ZKMssAWZohgXJ8iLG6cYDCBM+t4g
X-Gm-Message-State: AOJu0YySuom2SCc3H9tp8Rs+ES0lDUX0uLQD4HCqSTVwJfrGS6lsZkLc
	HxbON7ktoChR/PnLCPVscv3HOuURn2LW9CPfplOKL1YmdhDNGs/TVunSEV7v5ow=
X-Google-Smtp-Source: AGHT+IF72d/eavTJNmZHcMAbqdvAOzyYjLq/Z4SHC58ho5mI8wxqnh64eI3iH73hmEqWAqOH7y90DQ==
X-Received: by 2002:a2e:be8c:0:b0:2ec:3dd4:75fa with SMTP id 38308e7fff4ca-2ec3dd4770cmr9609411fa.44.1718778969928;
        Tue, 18 Jun 2024 23:36:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c07012sm18890531fa.48.2024.06.18.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:36:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:36:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
Message-ID: <mozxxkpqlboh2w7bf55bezgcy5b2jfgepmgullgd24dtmwfva2@mghwg3c5an5y>
References: <20240619033351.230929-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619033351.230929-1-tejasvipin76@gmail.com>

On Wed, Jun 19, 2024 at 09:03:49AM GMT, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> raydium rm692e5 panel.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Change rm692e5_on to return void and take mipi_dsi_multi_context
>       as an argument.
>     - Remove unnecessary warnings.
>     - More efficient error handling in rm692e5_prepare
> 
> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 237 ++++++++----------
>  1 file changed, 99 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> index 21d97f6b8a2f..9936bda61af2 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c

>  static int rm692e5_prepare(struct drm_panel *panel)
>  {
>  	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
>  	struct drm_dsc_picture_parameter_set pps;
> -	struct device *dev = &ctx->dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>  
> -	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> -		return ret;
> -	}
> +	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (dsi_ctx.accum_err)
> +		return dsi_ctx.accum_err;

int ret, please. Let's leave dsi_ctx.accum_err for DSI errors only.
LGTM otherwise.

>  
>  	rm692e5_reset(ctx);
>  
> -	ret = rm692e5_on(ctx);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> -		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -		return ret;
> -	}
> +	rm692e5_on(&dsi_ctx);
>  


-- 
With best wishes
Dmitry

