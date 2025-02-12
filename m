Return-Path: <linux-kernel+bounces-510276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4072FA31A95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D093A761B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6A27182B;
	Wed, 12 Feb 2025 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwuYWeIQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14461172A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320739; cv=none; b=Z9ePN0oF93SpbvRXlEgvaMxn1dzXhH+oAI1qcZeEjjwODrY1iOFILZOtqHyCiX7PE12P3vHZiO52vqD8YQaXXzF0Xcs1hbytHU4yEyH8DWARFpKv0u3Sao+Cma7t6Kd59dPOFJfgapwbgulWbAoo8xRjm2lcnprShmiAHl8sHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320739; c=relaxed/simple;
	bh=W8nPvRrhsFj4vjpJWQbBurER9EbJjQcRkhUphV03EoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMvH68RrMlmw86IsNuPiiRHP2hlto3j65kav6c/I8Gh5aRGlvz5e6BFAPw988mCHXL/1P/+XQ2RXPXYdVFrF4fzoJ2HDcZBoWfKe3cf6AW+nYHasWricjpszPHQIyj4uwEr9S6YcfM7D4arWjz6zqEL3GhOYwMICNVvvRuCwUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DwuYWeIQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54508b026d1so2885353e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739320736; x=1739925536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czMy4XGzgzOziSIiMmQSPFWId2I629I8Sv1+VTv4Uos=;
        b=DwuYWeIQO1bwL3BruHZUAhOJ0hW/I+VQJuNUDLtkIWCl6xEKBKPF+RyjExn0Q88Ivm
         26JnxY9U68qvELjOy3C52ryYMuvBNHrranNx7CABdcORa4CyWgkEK0u90DVj3Zgdfp39
         IN4ExJ2nqpcgVHEucq5rV+Hds6Gbp4wk5XtGIKejQ9vW/DozIpr3BGtIP4D9nNOeJsF6
         1PH1/nAnsGW6vHfuIjwuNeLJjC5C+uVFptoGXEfTklw7LrGQv14GxmuGd048OylP6KQB
         MN3693/ejL2hT/QzmGQHkl0ECvPrdJDLn2laULocDrszOh0cNg93lDs9jocrVeUUzDva
         zQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739320736; x=1739925536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czMy4XGzgzOziSIiMmQSPFWId2I629I8Sv1+VTv4Uos=;
        b=Id5rQax8C8aqPOWuoG7kFrwdw6W6oXkgQ+E8KKgHGXkwpIsfUUDANTzW0oYhoQYfwc
         Hao6WN8xHCfT2tOA/D/TvKsM+eYaCQG+7yLl1GdPomltAuJMnneyaKDmTVJpinFeYQ/E
         54bmNcFX1pkWop98inAvLREbmukYPE27J2/gnG8UNXacpvlVP4P7vPDr/c8wnqHxbJBY
         j7fSAhqC7zjhBmfn9vgKuwaIJsMCvq91s3K7W5FOl/cTuY70UT7/U2MeMo4xZEiosUq8
         nMDdEdnYzS9G+U71T/GY5sZaRb1hcjlsZ+TXC3cDMyej42QBm0yc7ptq6d0UloTwHbXM
         1Pxw==
X-Forwarded-Encrypted: i=1; AJvYcCXCPV6wE4xskcePbK0nAuzqVqPyZjM4ndp5+MSh1Agfk14DYPryWz5Ks69tFtLnDYdBD6iQlPwiWMcl+dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMrXJfR1dYUYdVH+AGFaqHmyhkpr5Mqa4E6zgrjZ5xMetflnO
	GacP7ohOI5wwKDFNagWHH0+7/r+RpM37Xe57hBVZlj5ehMyK9N8tX/HLxzqZEdY=
X-Gm-Gg: ASbGncugMF8D5/SkQpxUWFFm3u1Hy0wXTb1E2drlilKr1aiQIzvZRfJSdURAkA4K27i
	VjwOHz/HPamGLUBQXf2v8LwpPD6nXzazILBy6s2EPGbaBjBrfJX1y9gkwAR8KW8dm1BKBPu5dXI
	mUEaiZ2BgYyI7ShLZJ63kUPYLwtHtn3haIC9Xr4jN3ESjAkQDGxCrluUOeSVh2qJyWCmLqPgH00
	qiGF+h0nL4wxuhsNRCeHSc1Ec7BNLAsA95kA9fvfihVeTY64DGD3SnsyKttY9m3X92VHDkrMwJo
	+N88Mycm+Uj3N4rHzIA58FnkN2kfSFfBFPk55GZ888qyds2vf4MOLXhvQv1ECp4jinAb7rs=
X-Google-Smtp-Source: AGHT+IE0R9s5EbTp2hypzARdUk83hsK/GvBuTLYE+EmInEQl+LSG5FC1N0b213UOW2tBegrVy9Dl8Q==
X-Received: by 2002:a05:6512:1288:b0:545:1104:617d with SMTP id 2adb3069b0e04-545180ea318mr257971e87.11.1739320735950;
        Tue, 11 Feb 2025 16:38:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053eb53sm1689954e87.36.2025.02.11.16.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:38:54 -0800 (PST)
Date: Wed, 12 Feb 2025 02:38:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/35] drm/bridge: tc358768: Convert to atomic helpers
Message-ID: <btehhpvkv6iqd4pofumspqbxzr5gxwp6vs5oh7vflbcmzqj5wz@s6yem2ryw6vs>
References: <20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org>
 <20250204-bridge-connector-v2-34-35dd6c834e08@kernel.org>
 <nbghrrl74xsuzomp7d6qjfosxfiooezipppjhxkx2ibnlpi6rj@b6ovgosmpuhl>
 <20250211-solemn-meticulous-angelfish-85d1ce@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-solemn-meticulous-angelfish-85d1ce@houat>

On Tue, Feb 11, 2025 at 03:33:58PM +0100, Maxime Ripard wrote:
> On Sun, Feb 09, 2025 at 09:13:36AM +0200, Dmitry Baryshkov wrote:
> > On Tue, Feb 04, 2025 at 03:58:02PM +0100, Maxime Ripard wrote:
> > > The tc358768 driver follows the drm_encoder->crtc pointer that is
> > > deprecated and shouldn't be used by atomic drivers.
> > > 
> > > This was due to the fact that we did't have any other alternative to
> > > retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
> > > in the bridge state, so we can move to atomic callbacks and drop that
> > > deprecated pointer usage.
> > > 
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > >  drivers/gpu/drm/bridge/tc358768.c | 30 +++++++++++++++++++++++-------
> > >  1 file changed, 23 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> > > index 6db18d1e8824dd7d387211d6d1e668645cf88bbe..6ff6b29e8075d7c6fa0b74b4fec83c5230512d96 100644
> > > --- a/drivers/gpu/drm/bridge/tc358768.c
> > > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > > @@ -601,17 +601,29 @@ static void tc358768_bridge_disable(struct drm_bridge *bridge)
> > >  	ret = tc358768_clear_error(priv);
> > >  	if (ret)
> > >  		dev_warn(priv->dev, "Software disable failed: %d\n", ret);
> > >  }
> > >  
> > > +static void tc358768_bridge_atomic_disable(struct drm_bridge *bridge,
> > > +					   struct drm_atomic_state *state)
> > > +{
> > > +	tc358768_bridge_disable(bridge);
> > > +}
> > > +
> > 
> > Please change corresponding functions into atomic_disable() and
> > atomic_post_disable(). Calling sites have access to the atomic state, so
> > there is no need to have yet another wrapper.
> 
> It's pretty hard to do (at least without the hardware), both
> tc358768_bridge_disable() and tc358768_bridge_post_disable() have
> multiple call sites in the driver, and passing a state enabling the
> bridge doesn't make sense for those.

I think it makes sense. The function knows that the bridge needs to be
disabled. The state is totally unused (or it can be used to get
connectors / CRTC / etc).

> 
> I guess I can still drop that patch.
> 
> Maxime



-- 
With best wishes
Dmitry

