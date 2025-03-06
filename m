Return-Path: <linux-kernel+bounces-549241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E2A54F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F873B08C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BB1DF988;
	Thu,  6 Mar 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c34HdYyH"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7049148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276112; cv=none; b=QssMcubH3GG3vxDIV/K1Lza/ndpl1FxRusBxqSVTLa0Sq8f3sy7wq4lR+KYy1HwsGZwFL8nV2so3YWzGwfUB+rqV1o1vj7y9VrvjZ3BGHYTQayAmDi8YYi9cWTRTq9TjVMaq9R6YmZhS6ttk46IlEilquaL82xaEwJCbMUIn0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276112; c=relaxed/simple;
	bh=yf7T/a3IP7hPYcHXyZeLyZdksDQc4IhVkqRtJTXfFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2OpFVH6skv9kLkcMUa5pO1IJSrkxQwmAwCZT/7Ep+9txV1fvUKrhwGv+DNpZVArh3BzILI9w9UOguMSsI7MpHDapWl+qbxMmpV3hSUJlHBIAQ5F7zkIbF1sE4V1tmg/xpQygqUAo5E1UuH/agMqr1gde4Qa2T4vKNQdQA5a9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=c34HdYyH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390f69e71c8so583362f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741276109; x=1741880909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMlvZVmGmfe9jET5j6AVC1Iu+TuVwvxBrNk+geFYLL4=;
        b=c34HdYyH40XSKtpuxXx6fjCn6UmJODnfumXTt5dRd4d2pX2vDh5e4zuFwUDz412OFw
         XdjZkstBtn1YbZPTFzo8wu0Nr/62ukxUuBDi2BIGUF34si2Usv7tyRHDh4sQBYA5Vi81
         ghek6RolJ6vZ8xdsDsuePcEJ7+D7mmS6832+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276109; x=1741880909;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMlvZVmGmfe9jET5j6AVC1Iu+TuVwvxBrNk+geFYLL4=;
        b=CYxLwcxIsk5B7gpQTPykCxenjf+UYq1+aX0r+RKzedeLlf43RXZNzlaP7xhrBJYUpI
         V67vIgGuq5MgF6Uk+ypDkD3LBJvqdjhU26qCHFNVu7oq+yd9kLMGVFTPPcaHgqRpFRNQ
         rLWR9q3TcXYgM8vZwWo+F1d3bLT6fVbZQUU0swy4kQJ7r+f2rDk0IB4V+5Fyay8kGVQE
         zMK2GNUAdaNVMr3+mX52M4n+yFVKL6b083nx85QqtVKnaYABrmNMNNUF6skjeeuUq2SJ
         GKkg6ZuaC8CCdnZZFct+8phe8ti1eJC2Z5gOgLy/nYSgEtALAXivTnr4vEmzpDTStngx
         tVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm8A3XtfMNicDJNosE9SUmZtg1ZVpFRllU2JYkJKIGfzwZQS73HlkzhhnLk9AzlfyWD5+O7v6j8bHP9FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3H0Ep5LAUZkAvWrRjUBHFmJNmQV7TdXay8zLkvA15Pi1xgXFm
	tacDTeuYP1yiP4lXLJZm/8o9ei/sRshhlGpfuMdPq6MZR8HI6JT83f+xs3+6U8E=
X-Gm-Gg: ASbGncu3suDmt3a4ZlwcuMc2V+XuBB4bnJOlCut9Vwee/bSdTfZBDzgIJNGxOOHawDP
	kiLP++cKgMuLfHUbolbrYwHpuPAO+QgRxaYtV8LjxrsrgWq6Hl2XR7u48kmVf614eI74B926ubF
	TDITd4LvPBf+D3/zBznwzhEWyBs8AIXQfYKcuaoFFuwjyrIHVyGAn1akAGCVNIrDkCSjnanzkD0
	FqGTS1GGkgI9ImIYRXDqDmE8ww6cnMiBzO7nspnH4aVRX60/yaxUGHADKmOOF244G2uz5GiFbif
	BAETkLoUCO+8TY3AKTXiiCGbHQLu8Htrl7Hdo7NxNpN6MpPDnm6gkGCN
X-Google-Smtp-Source: AGHT+IFtOXpx6jiep5HwmWGtbHwDrBT4bMHCGPI0ael0tguvlAKpS/nUPea89z2t6vc5g9hpe7v3ew==
X-Received: by 2002:a05:6000:18a8:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-391296d3cefmr3990555f8f.1.1741276107354;
        Thu, 06 Mar 2025 07:48:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm2433714f8f.99.2025.03.06.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:48:26 -0800 (PST)
Date: Thu, 6 Mar 2025 16:48:24 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 14/16] drm/bridge: tc358768: Stop disabling when
 failing to enable
Message-ID: <Z8nDyNVQ5p007Mw6@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-14-aacf461d2157@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-bridge-connector-v5-14-aacf461d2157@kernel.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Mar 04, 2025 at 12:10:57PM +0100, Maxime Ripard wrote:
> The tc358768 bridge driver, if enabling it fails, tries to disable it.
> This is pretty uncommon in bridge drivers, and also stands in the way
> for further reworks.
> 
> Worse, since pre_enable and enable aren't expected to fail, disable and
> post_disable might be called twice: once to handle the failure, and once
> to actually disable the bridge.
> 
> Since post_disable uses regulators and clocks, this would lead to enable
> count imbalances.
> 
> In order to prevent that imbalance, and to allow further reworks, let's
> drop the calls to disable and post_disable, but keep the warning to let
> users know about what's going on.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Yeah proper way to clear these would be like any other link failure:
- Launch async worker to do a bridge reset with the fancy new helper.
- Set the link-status attribute if you can't automatically fix it and let
  userspace sort out the mess.

Maybe we need to improve the docs a bit more?
-Sima

> ---
>  drivers/gpu/drm/bridge/tc358768.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 6db18d1e8824dd7d387211d6d1e668645cf88bbe..6b65ba8aed86012bc0f464bd5ee44325dae677c6 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -1075,15 +1075,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	val = TC358768_DSI_CONFW_MODE_CLR | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
>  	val |= TC358768_DSI_CONTROL_DIS_MODE; /* DSI mode */
>  	tc358768_write(priv, TC358768_DSI_CONFW, val);
>  
>  	ret = tc358768_clear_error(priv);
> -	if (ret) {
> +	if (ret)
>  		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
> -		tc358768_bridge_disable(bridge);
> -		tc358768_bridge_post_disable(bridge);
> -	}
>  }
>  
>  static void tc358768_bridge_enable(struct drm_bridge *bridge)
>  {
>  	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
> @@ -1099,15 +1096,12 @@ static void tc358768_bridge_enable(struct drm_bridge *bridge)
>  
>  	/* set PP_en */
>  	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(6), BIT(6));
>  
>  	ret = tc358768_clear_error(priv);
> -	if (ret) {
> +	if (ret)
>  		dev_err(priv->dev, "Bridge enable failed: %d\n", ret);
> -		tc358768_bridge_disable(bridge);
> -		tc358768_bridge_post_disable(bridge);
> -	}
>  }
>  
>  #define MAX_INPUT_SEL_FORMATS	1
>  
>  static u32 *
> 
> -- 
> 2.48.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

