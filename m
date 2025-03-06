Return-Path: <linux-kernel+bounces-549237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14ABA54F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3306116A863
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783B20FA94;
	Thu,  6 Mar 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OUThtrQy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9250148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275891; cv=none; b=HoVETvw/s8ToClcQiceF15PsNfNVhRcTZsxBLwmznL/1McQhSieoqaIPeVzWQlnD0n6nfvMnYgZndpvdQ4HfPvwWw6Vrdu9JdKcsAgvlvBQ9Kt33WLP6xa2sRupJ6T/AJpRaI8JvMWLkaRxIvdeXt7QjrKOwN1cSE1RAw+S/FFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275891; c=relaxed/simple;
	bh=bXFKQe4WoxNHZ+6obi9HIs4+sdZvwVJabvZcc/p/g3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9jiQ/TP/wqfMCg4U7pTnq2BqXfN1w+fRTB/DUhScyvCvsmMS+uAvd3ibXn/3Nk7w3V1NICz6VD5rtYkNTkcV+8TH7DKoItd0XMBAThHDQwiKcZx8igoCzxkj4otS+yRFAz91JhCvbnn6piJpf4LXb32W0SU/fsNOlo/cFN6La4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=OUThtrQy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso6491665e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741275888; x=1741880688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK1gxOOdk1W8a/AML1mTmpzyOYKpVlqd16ntLPX8srY=;
        b=OUThtrQyEawnHXjF+6fsBA1H015Tqvc/5IdXMnQkOvPi7F/pj5O1I6GElw/qOrSj6q
         rmRkQ0aMaOgG8HEvZhkezVvrNO+ZL6ks1yJb7wHWiWB3RoVtr51RlthAreZJ6N6DIeS0
         g9JuZLTajdNX2NF+c93IjMU0LYEy03K2D97CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275888; x=1741880688;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wK1gxOOdk1W8a/AML1mTmpzyOYKpVlqd16ntLPX8srY=;
        b=awaE3eV3x/IgfKVsQp6C7uS+lqmfXm4OcRW8GrKogRF8CoL9Vbq96uVYCHxhCy98jX
         TwNjeP6wpHuWc4NaIowfnIfBGdNN9Iag7kENvsNhWmt3b73ihOlhi5dbJJjVRi5VyXwf
         rtRJnkSHLd6TjZWxNXDxwlFrQSdnGEbL4aAj5Q2a+Vzr6zPJZ4xC5ulHQdWbt8Ueq4t2
         LWLsSwoAwtuRg7eCnAPmqngoARoQe22EAryOIBonUpCwETReRrU/lz5f55fcgvZ30wYI
         DLURjqcyP139c8EsILIPf4YOaAduQxbOKhNFY6I7Tj+rK2GS3gxaYwF2bzU3VesjqoIm
         YRPA==
X-Forwarded-Encrypted: i=1; AJvYcCWCEQBZrv50GUYuvEER7Koin8v7HIWyRe99jC9rKNdITlljF7bCosLhR2Cz0ygQssQBNGRshTY6l8dgm7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wSq4JQiVPEvuSAc967nO1Y6t14Dx6wjKItVop/CTdsNTrFzQ
	SPKv8RVWVzrne9XROgSFGw9nf6l3jWd7wQVdSsT3fiCLp0dLZ2DdBF5rYO+DJrg=
X-Gm-Gg: ASbGncsXDGdBrBe6umgG93QiJkI+22uZRmyz0bSsg8GrnreZX59T94vBsUyha8OMED+
	nJkqZ+r9ZpgtpeatkRhtP4kGjmd6PNDNaIjBjVco2rZ9vsQEKZKXRi/asHEHTbF9NEJCy9n4tya
	HB1Pk/Qm3JQJt1ZuiDvGJdfsyoiAOC6ixjTAPFJpkc+l0U1ImcTORjjVYh5lcrJrQ9bni3blSln
	pwef0QvOyICs8cFcFnGfJ/TEHEwdRwM7iFphFGErdS+AhMlJecYqZIu2fxfpPMRcptlDE8AceEH
	/CPOAYhl3LgHmcaMRLnN/JtqH9Y6ctBv7RQPl4iOn17Moom7hjDSxw1V
X-Google-Smtp-Source: AGHT+IHfwko9Ji9irJrgL1EBwlqRzGHasGafHablHdNgq8tmEYde/T8Ypz9EwGHvzSxuCg4wRc+qhQ==
X-Received: by 2002:a05:6000:2a3:b0:390:f641:53f2 with SMTP id ffacd0b85a97d-3911f727717mr7201316f8f.10.1741275887887;
        Thu, 06 Mar 2025 07:44:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfca1sm2337382f8f.22.2025.03.06.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:44:46 -0800 (PST)
Date: Thu, 6 Mar 2025 16:44:44 +0100
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <Z8nC7JcaK2Vqs_LP@phenom.ffwll.local>
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
 <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Mar 04, 2025 at 12:10:47PM +0100, Maxime Ripard wrote:
> With the bridges switching over to drm_bridge_connector, the direct
> association between a bridge driver and its connector was lost.
> 
> This is mitigated for atomic bridge drivers by the fact you can access
> the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> 
> This was also made easier by providing drm_atomic_state directly to all
> atomic hooks bridges can implement.
> 
> However, bridge drivers don't have a way to access drm_atomic_state
> outside of the modeset path, like from the hotplug interrupt path or any
> interrupt handler.
> 
> Let's introduce a function to retrieve the connector currently assigned
> to an encoder, without using drm_atomic_state, to make these drivers'
> life easier.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic.h     |  3 +++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41d48eb4da4bccf170ee236 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
>  
>  	return NULL;
>  }
>  EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
>  
> +/**
> + * drm_atomic_get_connector_for_encoder - Get connector currently assigned to an encoder
> + * @encoder: The encoder to find the connector of
> + * @ctx: Modeset locking context
> + *
> + * This function finds and returns the connector currently assigned to
> + * an @encoder.

I think it'd be good to link to the other atomic connector functions like
drm_atomic_get_old/new_connector_for_encoder and explain when to use them.
So also add links to the kerneldoc of these other functions pointing to
here.

- This function is for detect, link repair or anything else that comes
  from the hardware. Or in general, anything that's not in atomic
  commit/check code paths.

- In atomic check/commit code you want to use the other functions.

Otherwise people will have an even harder time finding the right variant
in this maze of look-alikes :-)

With the kerneldoc suitably polished:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Simona Vetter <simona.vetter@intel.com>

> + *
> + * Returns:
> + * The connector connected to @encoder, or an error pointer otherwise.
> + * When the error is EDEADLK, a deadlock has been detected and the
> + * sequence must be restarted.
> + */
> +struct drm_connector *
> +drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
> +				     struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
> +	struct drm_connector *connector;
> +	struct drm_device *dev = encoder->dev;
> +	int ret;
> +
> +	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (!connector->state)
> +			continue;
> +
> +		if (encoder == connector->state->best_encoder) {
> +			out_connector = connector;
> +			break;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	return out_connector;
> +}
> +EXPORT_SYMBOL(drm_atomic_get_connector_for_encoder);
> +
> +
>  /**
>   * drm_atomic_get_old_crtc_for_encoder - Get old crtc for an encoder
>   * @state: Atomic state
>   * @encoder: The encoder to fetch the crtc state for
>   *
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 4c673f0698fef6b60f77db980378d5e88e0e250e..38636a593c9d98cadda85ccd67326cb152f0dd27 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -623,10 +623,13 @@ struct drm_connector *
>  drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_state *state,
>  					 struct drm_encoder *encoder);
>  struct drm_connector *
>  drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
>  					 struct drm_encoder *encoder);
> +struct drm_connector *
> +drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
> +				     struct drm_modeset_acquire_ctx *ctx);
>  
>  struct drm_crtc *
>  drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
>  					 struct drm_encoder *encoder);
>  struct drm_crtc *
> 
> -- 
> 2.48.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

