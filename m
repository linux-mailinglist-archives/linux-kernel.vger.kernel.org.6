Return-Path: <linux-kernel+bounces-442825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE79EE27C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C81886A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63C20E01B;
	Thu, 12 Dec 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKENARD9"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376D2204C36
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995106; cv=none; b=oO8lNqAzgWhHl97Nqv67cPWnm9TLzJqMRx2DJkFbOV04c95GTKg8X2KQZDAhcLYpOWT68fAG9+JSmPv6S3W4wkZjrLMjKcxKeCDrBgQyVvbX1/el7OdQ/wzMgS4W3TkSAqza1aAkW10b2DyTWk5jqRgaSme0RsLgQ2YDbZ+CuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995106; c=relaxed/simple;
	bh=6qKrpe3+y2KjL5rliSgwC0hGkGAif3rAve6L620C768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0KrGvcgMwfHtWTzP9ChBeX2sBEE+LcBeSzkt9XIT72Fy8I008FYRG8H9fSmM33k0Wn9MnlD3fDREedrzdzajzLtHd6+0jwUCfPyH8hGQi9oSVPbLIspml0vu2emSOG5oapNghgovVWkskCFVVOo8mnKsFQZfaotFa/iXWVLeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dKENARD9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df80eeeedso369941e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733995102; x=1734599902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvOLGgu+RtTzazwHxmT0a+oMtvGtLbiK35Nxn71eTwk=;
        b=dKENARD9t+EsIAic20MKva/SZ2p9QHFQCY+X7zhoN4zVbzeS/T1WrSc3G0KZIJcmog
         Yd2M8MxsPos5vz5PMOrkIRgLF1BbKKQU/ht4yuK4OTp0oQD75VDyei3XmE1yAIQftpJ8
         n7UGSzJhODDXAOXwoiHFO7HHrWREMSGisldBctP6DuYgI0duKt3JX3EkCRIGts4jhJCZ
         ZxqaGp81YHnwH09t4TDZaN6HUNadVt6YaPHgWEhR7e2ANBSv5Koq5t1j12IeFULzTUET
         UWzBhaRpeiBVvdUaIqApz+iF8E5pYi/swVqZQivz7+HQmlhEVB32BZsugw+7q5TnZDe/
         i58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995102; x=1734599902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvOLGgu+RtTzazwHxmT0a+oMtvGtLbiK35Nxn71eTwk=;
        b=YaNupHu9jtxqijnLYssED4PcNB0+ZxzQtWXYheq15NQREzEHnFuMw+EkbeAfwVHqkc
         lii+kShTILkGsn/jjlDnPEsuowbSznxJXv7TP7SAx5+0NR7q1BLd1J9eZPIY+XLroZ+4
         R5xV+jWg39Hp26O8hKCp+uXDeklkbSVmCIWcYL5kOUR5YsPnYGPGJvFbopiqXXF9pv+n
         sTNPRiIltkHZhamUvvh/Kir6t7nLsRV/9hHcXZDSu6iytBPh1MVcNXKIgMA/qcKmo97m
         7GySvsG3X8gM/9fuq5RTsWWFv3Z1o2kiiF7sDAacQyl5IKUOH0QeQiu+JK+aUhvQxPJ/
         xZgw==
X-Forwarded-Encrypted: i=1; AJvYcCV9TNICqAAvmmU9XkzSEBeIVlxydX4yZi4cALEy2mEQPrneHFWeDVlr+2G3sPeWrCoAM0OHTUG3+WZXaMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NPapPm2AyeGQ/E2ICOTLNtN48Xm4imB45XIRW1vsxwfqGUg+
	LkSQ4ImG3vBTNbQpxhhaMZJ2VGpWi+EVfAJpBSIZjAAOEioNpGMH27PpKaN4TQ0=
X-Gm-Gg: ASbGncuCNggq/pLOeZ3BPkpa8cnTRiaIGlReuFnbwCyfuTK8nuPdTXyXfbgUpb15mCL
	7c4QNGkVJaMvUntB4wEX2spWb+s0/8hTLzL+SvypGV6GpvauKW4SrhD6hL+e3uKDZv7uldg0EqD
	cnML82xKb8kA800U+UfT15A6PmjsW6ZeO1eSePJQEE7/9WJMAaEdHaofG2nd6R2n86m0UejBSno
	zXTYA8ku5BjnhmYznq1cCgHXV9Z+Vb2s8aA2IogT+d7al3dtEsYOEu48hNjTQ1yO0KC8jdTLOn8
	gh3M5pebfsxaP5PTpuy0YWWYp6R9B927zM6O
X-Google-Smtp-Source: AGHT+IFa4qzzNpW/mOzSbufvxsnMziRCXTlbdkN6AxAUpz/Lu22DHLGc6saz2iXswDPN9Ey7Hybn8Q==
X-Received: by 2002:a05:6512:2384:b0:53e:23ec:b2e7 with SMTP id 2adb3069b0e04-54032d3c271mr236824e87.34.1733995102250;
        Thu, 12 Dec 2024 01:18:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3022397e845sm11998941fa.66.2024.12.12.01.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:18:21 -0800 (PST)
Date: Thu, 12 Dec 2024 11:18:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, bliang@analogixsemi.com, 
	qwen@analogixsemi.com, treapking@google.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
 atomic_enable()
Message-ID: <vkrl7om7hepboovp2uivcnernia3ygqwrj3y3kkjydeclwvrk5@7tkdc4etkcjs>
References: <20241212055110.1862487-1-xji@analogixsemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212055110.1862487-1-xji@analogixsemi.com>

On Thu, Dec 12, 2024 at 01:51:10PM +0800, Xin Ji wrote:
> When user enabled HDCP feature, userspace will set HDCP content
> to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will update
> HDCP content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down stream
> support HDCP feature.
> 
> However once HDCP content turn to DRM_MODE_CONTENT_PROTECTION_ENABLED
> userspace will not update the HDCP content to
> DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor disconnect.

It seems you've ingored a part of the previous review comment. It's the
userspace who triggers the ENABLED -> UNDESIRED transition, not the
kernel side. The change to move HDCP handling to atomic_enable() looks
fine, the change to disable HDCP is not (unless I misunderstand
something).

> 
> So, anx7625 driver move hdcp content value checking from bridge
> interface .atomic_check() to .atomic_enable(), then update hdcp content
> according from currently HDCP status. And also disabled HDCP in bridge
> interface .atomic_disable().
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 74 ++++++++++++++---------
>  1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index a2675b121fe4..f96ce5665e8d 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data *ctx)
>  				 TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
>  }
>  
> +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ctx)
> +{
> +	struct device *dev = ctx->dev;
> +
> +	if (!ctx->connector)
> +		return;
> +
> +	anx7625_hdcp_disable(ctx);
> +
> +	ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> +	drm_hdcp_update_content_protection(ctx->connector,
> +					   ctx->hdcp_cp);
> +
> +	dev_dbg(dev, "update CP to UNDESIRE\n");
> +}
> +
>  static int anx7625_hdcp_enable(struct anx7625_data *ctx)
>  {
>  	u8 bcap;
> @@ -2149,34 +2165,6 @@ static int anx7625_connector_atomic_check(struct anx7625_data *ctx,
>  	if (cp == ctx->hdcp_cp)
>  		return 0;
>  
> -	if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> -		if (ctx->dp_en) {
> -			dev_dbg(dev, "enable HDCP\n");
> -			anx7625_hdcp_enable(ctx);
> -
> -			queue_delayed_work(ctx->hdcp_workqueue,
> -					   &ctx->hdcp_work,
> -					   msecs_to_jiffies(2000));
> -		}
> -	}
> -
> -	if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> -		if (ctx->hdcp_cp != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> -			dev_err(dev, "current CP is not ENABLED\n");
> -			return -EINVAL;
> -		}
> -		anx7625_hdcp_disable(ctx);
> -		ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> -		drm_hdcp_update_content_protection(ctx->connector,
> -						   ctx->hdcp_cp);
> -		dev_dbg(dev, "update CP to UNDESIRE\n");
> -	}
> -
> -	if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> -		dev_err(dev, "Userspace illegal set to PROTECTION ENABLE\n");
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -2425,6 +2413,8 @@ static void anx7625_bridge_atomic_enable(struct drm_bridge *bridge,
>  	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
>  	struct device *dev = ctx->dev;
>  	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state;
> +	int cp;
>  
>  	dev_dbg(dev, "drm atomic enable\n");
>  
> @@ -2439,6 +2429,32 @@ static void anx7625_bridge_atomic_enable(struct drm_bridge *bridge,
>  	_anx7625_hpd_polling(ctx, 5000 * 100);
>  
>  	anx7625_dp_start(ctx);
> +
> +	conn_state = drm_atomic_get_new_connector_state(state->base.state, connector);
> +
> +	if (WARN_ON(!conn_state))
> +		return;
> +
> +	cp = conn_state->content_protection;
> +	if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> +		if (ctx->dp_en) {
> +			dev_dbg(dev, "enable HDCP\n");
> +			anx7625_hdcp_enable(ctx);
> +
> +			queue_delayed_work(ctx->hdcp_workqueue,
> +					   &ctx->hdcp_work,
> +					   msecs_to_jiffies(2000));
> +		}
> +	}
> +
> +	if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> +		if (ctx->hdcp_cp != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> +			dev_err(dev, "current CP is not ENABLED\n");
> +			return;
> +		}
> +
> +		anx7625_hdcp_disable_and_update_cp(ctx);
> +	}
>  }
>  
>  static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
> @@ -2449,6 +2465,8 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
>  
>  	dev_dbg(dev, "drm atomic disable\n");
>  
> +	anx7625_hdcp_disable_and_update_cp(ctx);
> +
>  	ctx->connector = NULL;
>  	anx7625_dp_stop(ctx);
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

