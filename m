Return-Path: <linux-kernel+bounces-513448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CA7A34AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504303B2EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856424BBE5;
	Thu, 13 Feb 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiHRyAMb"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B820013E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464192; cv=none; b=VBaAzJSa0iC2GPGLMVXr5yr+rqzndmia70Qgxsr71+drn+Esj6kZlBCnSc7zlMtbfU+PLMoHIVG9V+xw9LGbale7+A8aLDfnk1ulM+FVMyMwhi1OQYRpFO9w6yXdtAj1gWzAfv7vkq0M41r/Uu78FGk5r7EzbzSCN9M5EJHr49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464192; c=relaxed/simple;
	bh=CfFLAGDo91/5fw12uG8rw36VCtaDxMDS81jU7UtKMg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYwzzK0Fjla5GjxFpulPb7PdA4xNW9JmK0HTtzJLFUyILEM3az/lBZie/FAuaUMnC3szFwIDUEQlx1wofuHrhG+00BUqUOwvqhC43sTEnCnITJMZs95f59NKDjfYglWRhCPlEtmJblGPG0HW1IqWpxWzFYw2quatZLDfxJCvszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiHRyAMb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450b91da41so881949e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464189; x=1740068989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJugKKEOwlREPb+p1Z0P7OAg934ldgSxN+eJwACQfYc=;
        b=RiHRyAMbyqsHGXMXD/HuqJyeRnCK3QwXQG1bnbzdjIHbQ+HkJDDR34C/gM9mc0oEuM
         6MX92y3fwWkzgGiF8Cld5z6pI5NUvHdEKAKR0bnVfto1l5XXQvLsLn+U9zaEpHtQ4kLF
         3oEKhLx4b47HUpFSVkLYki/kdGlGuqKSTE/z4/nUFSY1zZy6MVHzYPVOmrZEd7LtEjhR
         lFJP+7lMVib6J5y2QYxYHTLxTU04QkYOHEspQvmccc5kfBQJhKnjV0iawyzgm/t0/BXG
         lAsQxF3CwM+12SUgNopTv5rL7r26qMicUBqHeSZoAEtR15/ftAZeTQmtFB6NViY3oPy5
         hDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464189; x=1740068989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJugKKEOwlREPb+p1Z0P7OAg934ldgSxN+eJwACQfYc=;
        b=ntzclRzIN1VuJRGippNo7rf3irfrzlChO8KV3TSbnl73GbkD2Tr1rkYPw2dUugl1kj
         FLj7viReL6DOlomdHtvaAwQyEbev1i2gE7ExJA5mhmBExLeH61Rhd+uqtaNuvmB0zp07
         9t/m6DVeaYOmDwwZRGkul9UciYJAaqFyySFG8pK3jUgvzgtbdy+rbYY/EwXv3R5iqL1S
         jSYUONZCGCGuSb+iXOo8rp9Yo91Od+/ZePQtdfXm2f9XoI7vAmuyEwqcXn1wPaHooyr5
         TeBWtusWkKzT1TsbV1ByG9qMB9wWq0HVfgYr79XyqBB/GeGGux4+n7qoTLxNGE39Rw40
         qJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO7Gg+1AOgj8KpHj7MMm9FvXUP96ry6URZEwZeDvSZ2D+rS/YO7FH6T9mBicdJHdh9BX19uH4vqmA1BfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIfVZg+gszgMTBWhsid4649Hz8o+X70/Vfn/Bu2vyQZmeud9G
	o5nr91elgl6XKF0fmX1BCwMq8Va+z4DFSbYoN2UvXvitblgAdE6tQpl3DBJbHV8=
X-Gm-Gg: ASbGnctQm1GAeFCG06ehLns0ayOfSrd98NeNk6xQEZcmAkp1vc+XlnoJNGgIBv6QjZX
	YHN18/c+QRi2Q0UyTN3LW3eBmo8sYKNNirXKJ6eTttDnmnhYN+iYVGOGixaG7fHqiaAFIs/Gk+z
	drANVg6KlVEPKd/+PSbI9viDxA+Rf9jYD/e5OcGJ7P/HUji2AUBeU7Y1ZQTD51tsFRtO4FfrzaD
	OFy5L2lg+HXjYFdCipuA0Fb4jQC62dGhb366Xctyn3BKW8CGwj59zai/CepVI4IBuMKIDfrnrsA
	2CpRC3JEYzzmRwsnXXlBVh+DrEfu5OLb6SZlVSmeCqANGTDlCvudjhJRZAsChstib8UaB9M=
X-Google-Smtp-Source: AGHT+IF+hsft0VbXMNxPd7FKHumPUJvG86RfezAnMtzpnxwfK6f53xvCiC2uO574gIXJvAXy7nelxQ==
X-Received: by 2002:a05:6512:e93:b0:545:2300:924d with SMTP id 2adb3069b0e04-5452300945dmr420589e87.22.1739464188919;
        Thu, 13 Feb 2025 08:29:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11241csm214792e87.206.2025.02.13.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:29:48 -0800 (PST)
Date: Thu, 13 Feb 2025 18:29:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 30/37] drm/bridge: Assume that a bridge is atomic if
 it has atomic_reset
Message-ID: <vjdpctck2afcjrt2rlgjtzmrkf4a5bg5ihymc53vuw6md576wd@kbb5y27a5woi>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-30-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-30-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:49PM +0100, Maxime Ripard wrote:
> The drm_atomic_bridge_check() runs the atomic_check callback if needed,
> or falls back to mode_fixup if it's not there.
> 
> Going forward, we'll need to setup the bridge atomic state even though
> drivers might not be implementing atomic_check at all.
> 
> We can thus switch to using drm_bridge_is_atomic() to take the atomic
> path, and do additional things there in the future, or go the mode_fixup
> route.

This will break bridges like tc358768, rcar_lvds and mtk_hdmi: they
implement atomic_reset() and mode_fixup().

> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index d2525d0b1324cc3a63e32f5bf6ca6c4f9034eb4e..b6d24092674c8fa33d9b6ebab9ece0f91fb8f8ea 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -803,23 +803,25 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
>  
>  static int drm_atomic_bridge_check(struct drm_bridge *bridge,
>  				   struct drm_crtc_state *crtc_state,
>  				   struct drm_connector_state *conn_state)
>  {
> -	if (bridge->funcs->atomic_check) {
> +	if (drm_bridge_is_atomic(bridge)) {
>  		struct drm_bridge_state *bridge_state;
>  		int ret;
>  
>  		bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
>  							       bridge);
>  		if (WARN_ON(!bridge_state))
>  			return -EINVAL;
>  
> -		ret = bridge->funcs->atomic_check(bridge, bridge_state,
> -						  crtc_state, conn_state);
> -		if (ret)
> -			return ret;
> +		if (bridge->funcs->atomic_check) {
> +			ret = bridge->funcs->atomic_check(bridge, bridge_state,
> +							  crtc_state, conn_state);
> +			if (ret)
> +				return ret;
> +		}
>  	} else if (bridge->funcs->mode_fixup) {
>  		if (!bridge->funcs->mode_fixup(bridge, &crtc_state->mode,
>  					       &crtc_state->adjusted_mode))
>  			return -EINVAL;
>  	}
> 
> -- 
> 2.48.0
> 

-- 
With best wishes
Dmitry

