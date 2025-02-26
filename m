Return-Path: <linux-kernel+bounces-533125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDCCA455E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BF216748D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E0269B13;
	Wed, 26 Feb 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClIVWk5/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E12686A5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552204; cv=none; b=kIvVt1b5rKSbfcOmF/z7+KPbL8/UjSDR4d1XhFv6AU9/Orvo5HDZ2lZMVzsK51oRY8rxrDGswAd0xAIAtPAkXtZSXyUNHAxxvHKV9h5bbdcp3Z2Q/P27GtrXL6a0L6/Gbu4YMnyRkCBNMkG60OsKe0dbX+vpf5KbWLDwOpXxJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552204; c=relaxed/simple;
	bh=4uRG5vmsgKg9xItI1Lusgx48V+zeZ1F4H87+zMFXElA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAZ2zKdoZJBjYUrCtlprblA5zipxwlHgGklVbZncabqgHvLEki5NLv1YQ0vF/Vk32MaT4C7iMJN0UWp25TLMnfUDIazhmBw+w1LqlBmDblQXy+pln+Dhj+h95IqcEki41+9FmAQbA2Ef9c/RczQwg2guaaVIGCf+KqFFr/QSVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClIVWk5/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so7395096e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552200; x=1741157000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03hf7cikfkdqLENH/7Oyyab0bBLIcuddQc5/XdxjUHo=;
        b=ClIVWk5/GZA14ApFsufsZ2fw2Rl15Xn1ken6QbN8mTKexdtuF2T/bdyH0pnBx/duOF
         wbRZwwWA1lVXp/qPlenjA+6bDQckox+bECgggLlwQTfPyON4+GNZnHi9Hp7mU1HKeiBa
         VJWioZuOianaH0MdjsCUlOUtDX+PfwzzGPayj+4RplQYYoY5jEsmRTt/VfVq6jdQLE0i
         MGDl3ffEfzfrgHrIJpqtGR59dGsq6pnygtNS7Ynw5uBMdVdDFVBthGjBumVllhWkcARc
         KFa3RWkwoEuFfcRN9yDbeY95Pqm0ki2XZtfo65tRF6Zl6tRD/WKOWlORgK+UAnUPMyAS
         TqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552200; x=1741157000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03hf7cikfkdqLENH/7Oyyab0bBLIcuddQc5/XdxjUHo=;
        b=fEqbqzHVnh/LZoVlT1lZqHN9m7fr5jEl1fz0+RWju2FIOqJI/QFy4/FtFmpuHryKI8
         WQm73lkEZnR6fWH9+yLnAK1c4Jtk/rnJN7Iz0dNsxIQzvLKclPiY4/0tTLdZx7fczTZq
         m9Z5MLqJf5ctpVlO5fLe9PMNoVtrkBUWMeZwe0z+tKwFulFF2bXKRVpOOj2maW4q4J47
         wRtmOdxKaT8ZThrJeaHNsLYBFpO7Dqx+8n7zkyN0OdUL4EFThOEvNE5/fZed+nSTDKGO
         GTqAfzUMQxNmJNTxcz3c/jqSVlwu33hz/YGoqvouDEo4rs7l7tKbEuPPkIFl+ESGbfbP
         Ri5w==
X-Forwarded-Encrypted: i=1; AJvYcCWyihsXtjOYDUv7yAWhVIMCl63M7yXrfeKYHXrOypZy0ZEb+/D2ETFbBpx1t/FxFi2lkleDaL2sunkVq9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87wq844tGzFtjjNTvsSDLPYKHVG4lP8dF2eO/PkV6KRlPNcS+
	6txhLmveBtIqzyTXTZ8fMo4g6pVwToWiciwmEYuOKgZeZF3oLleRbvgJaiKf1eo=
X-Gm-Gg: ASbGnct2mS7wfRs6EJROSUV87PxzmhPaPVuwmDqRAZWy770pU/cO0kSIKzfOciwLu83
	34J340Q4bKLAOyyPsjJTuAF+knwtKDCV6aE4J8AkI5mIqOwL1uVvrRsQcLxVyT3yhNBelmazDE2
	0YKk1adryXISbPBHk9e7Gd6RgDd5bjWQSQW5ji4paEPh3X7cqdF8zwRBtd5NQIVfLEPcd6R9+e0
	DQyPle/PVTgmDFZWA5aRjcToRTgq7W9zL+V6dMJeJqVu3V/TaN3k57ldDCyDDz7MGyxygSSWp5F
	cKZilsPt3L1NzJHBR4CtvwY5mMCGRsBjAqPFWi/X3hfO7sJIV/Rhsi16Jm9P7CRMrOLFQYK2XJH
	tDQfLvQ==
X-Google-Smtp-Source: AGHT+IFEQVjB/Rb0FAYpcYL2VJZKpn7jnf0itAzWlDQxr8WDDIYbvg6zpyGA3H8ls+OgOMlkXjdtfg==
X-Received: by 2002:a05:6512:1194:b0:545:3031:40aa with SMTP id 2adb3069b0e04-5493c570f6dmr2016310e87.9.1740552200410;
        Tue, 25 Feb 2025 22:43:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9e3fsm362600e87.217.2025.02.25.22.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:43:19 -0800 (PST)
Date: Wed, 26 Feb 2025 08:43:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/15] drm/tests: bridge: Provide tests for
 drm_bridge_reset_crtc
Message-ID: <gf36bwz5kpoetdnmwu4xfupxrxciojw3yebfylbwwwu4dhdxkf@6hh5sc5ts3pa>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-8-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-8-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:56PM +0100, Maxime Ripard wrote:
> Let's provide a bunch of kunit tests to make sure
> drm_bridge_reset_crtc() works as expected.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_bridge_test.c | 168 +++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
> index c0a05c459d957c3f9d281957f002f6bd36cce367..4bcc761b3ba70bfa0ccc56b0685e35f86bde63fd 100644
> --- a/drivers/gpu/drm/tests/drm_bridge_test.c
> +++ b/drivers/gpu/drm/tests/drm_bridge_test.c
> @@ -14,17 +14,57 @@ struct drm_bridge_init_priv {
>  	struct drm_plane *plane;
>  	struct drm_crtc *crtc;
>  	struct drm_encoder encoder;
>  	struct drm_bridge bridge;
>  	struct drm_connector *connector;
> +	unsigned int enable_count;
> +	unsigned int disable_count;
>  };
>  
> +static void drm_test_bridge_enable(struct drm_bridge *bridge)
> +{
> +	struct drm_bridge_init_priv *priv =
> +		container_of(bridge, struct drm_bridge_init_priv, bridge);
> +
> +	priv->enable_count++;
> +}
> +
> +static void drm_test_bridge_disable(struct drm_bridge *bridge)
> +{
> +	struct drm_bridge_init_priv *priv =
> +		container_of(bridge, struct drm_bridge_init_priv, bridge);
> +
> +	priv->disable_count++;
> +}
> +
>  static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
> +	.enable			= drm_test_bridge_enable,
> +	.disable		= drm_test_bridge_disable,
>  };
>  
> +static void drm_test_bridge_atomic_enable(struct drm_bridge *bridge,
> +					  struct drm_atomic_state *state)
> +{
> +	struct drm_bridge_init_priv *priv =
> +		container_of(bridge, struct drm_bridge_init_priv, bridge);
> +
> +	priv->enable_count++;
> +}
> +
> +static void drm_test_bridge_atomic_disable(struct drm_bridge *bridge,
> +					   struct drm_atomic_state *state)
> +{
> +	struct drm_bridge_init_priv *priv =
> +		container_of(bridge, struct drm_bridge_init_priv, bridge);
> +
> +	priv->disable_count++;
> +}
> +
>  static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
> +	.atomic_enable		= drm_test_bridge_atomic_enable,
>  	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> +	.atomic_disable		= drm_test_bridge_atomic_disable,

I think we usually use paired order rather than just ordering those
alphabetically. It makese sense to group .atomic_enable with
.atomic_disable.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_reset		= drm_atomic_helper_bridge_reset,
>  };
>  
>  KUNIT_DEFINE_ACTION_WRAPPER(drm_bridge_remove_wrapper,

-- 
With best wishes
Dmitry

