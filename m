Return-Path: <linux-kernel+bounces-518054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C926A38930
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206F5168271
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A96225391;
	Mon, 17 Feb 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VsaGquXt"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F961531DC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809996; cv=none; b=NStJ2ywlcX4qk0wQ1UEmOjyCDlnB6L51zlQfMkuGe0n4oawjQiCJc1DiGFR1R6VlDyQqFGSqGOzIz5tymAC4YfD9iQ5mMTBURkbVAxNEhWdEPX53EPY7S2aUbqne/9eeaXzvc1aH3FbprEzt6Vpz6HKpPButn8fcQSSrgat+l2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809996; c=relaxed/simple;
	bh=H8l6qCQ+mNtrI8kqGjISP8leCltr9JTRR9DjIJekAQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U19dMv4xDupiyVgdbCdG9M4FGz9Q7MYyldGj7aggZ/+lXHajFvNFO4SEuEIbAW2lyN7t0EGGW0yz19norvrWUhLPE9VgzWsEcY/v6ZtKwaG4/e0Ju+hGlyQnY/Na2TKTXAEzzTQ7H3aU8de+1w/djVMh1Rus0y3mJvcG7AgK4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VsaGquXt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso2099643f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739809993; x=1740414793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czo+abDjGEXjXRngmG8KE7G58bH+0TPX+ShC6kAE364=;
        b=VsaGquXtyP72PHSxl59S+5AbSs9/bnUsF9BWYpG4muKX7c+CzOOVfm4XRsGglolacc
         dAiF4ZRytBZaJMP5EzHwLkLaGxWz23b8E1e4JYBDphfP3UfnJWDquSmCkNvNY9jDWt8Q
         CzqBz/bZSRLmDfY92kqoRpGjl0uF/EZ+97qq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809993; x=1740414793;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Czo+abDjGEXjXRngmG8KE7G58bH+0TPX+ShC6kAE364=;
        b=PxiWHMsX+2+ISdTelDKDUnv8lAg6H3ASrFFdQtTtI9X14nPtscCFrz7cbn8Acid042
         qB7An0r334+MsaB2WyjchaldOQu3eZp3hLHgc90FBmSpwRuAD6TEt1gz1xLTqNM7T2Sa
         JXpPE2w7yO0dZ8TC8B7EpMMhCp+23fDkZTDv9Vu0bmU886L1c7JqdIpFLaByHgZjguzc
         g/YqZNRNNliyREXOFDr/2XCoinDHi3C9TFGdBaYG6IAj+sRAAPiJ4nZdy+L5R9Xan8XS
         A+VjH6ZAoDCfgrumy7fSpdMa98ZjUgfKVRMBV0N40RMIFmdWhqqlC2RU+MrV3avaGWKR
         P63g==
X-Forwarded-Encrypted: i=1; AJvYcCVfLR5c/4CIzJlFTFH//ZbqbWCmUlEVZ3Fbrd9FksUUusmKoyuh8a1xmNFCVXW1EkBMnLRCyFL8y21i4/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8jxIw/gzzEcYBZryFlpTfI+t44rfZaAq/ezY+eK44OCwFhqL
	CEAK5jD5psrggSvurRrj/DnTpQUNwvqz8BTBaBdXM0BwPNQfVxaB2RhzGfR60zisFtu9RFL0pm3
	5
X-Gm-Gg: ASbGncuOmgJfsBgODwhCboGwowx2ACtJmplf4bo6RhQGDEnH5pePsHWAAmXB2toTVrx
	OQlcEHjWwp85MScUVll/eRnzCRX4HC6cGWOwX+/mCULmDu+nlTBa5FTFGy2p+y/AFqybgnYdZ6n
	vD0xGDqg2naIzGJB9aE75/y2JWkNtYsVtar5901f1wR8IMJs3D/ihPM59CHhxwqDPingT6YM9/9
	UOPE9aK8r3iuOYzW48mceSFAspV/p2DfMyE6mDAMKmvRZVmhlDX+qsbRyt6fI0C1G/xCE9/Cz2a
	LINF03HzzkDL2EcC3qv8sxJohIU=
X-Google-Smtp-Source: AGHT+IF/zPnB9i/djSQzx6Nft2LwuPmMRw3hmVUFnih+2dJwvP4POCL/t/vyntRmA+wiKTPgwSfABw==
X-Received: by 2002:a5d:452e:0:b0:385:e1eb:a7af with SMTP id ffacd0b85a97d-38f33f57dc0mr7697565f8f.48.1739809993189;
        Mon, 17 Feb 2025 08:33:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm30572795e9.29.2025.02.17.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:33:11 -0800 (PST)
Date: Mon, 17 Feb 2025 17:33:09 +0100
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v3 01/37] drm/atomic: Document history of drm_atomic_state
Message-ID: <Z7NkxTHVQzzSHv1B@phenom.ffwll.local>
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-1-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-1-e71598f49c8f@kernel.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Feb 13, 2025 at 03:43:20PM +0100, Maxime Ripard wrote:
> After some discussions on the mailing-list for an earlier revision of
> the series, it was suggested to document the evolution of
> drm_atomic_state and its use by drivers to explain some of the confusion
> one might still encounter when reading the framework code.
> 
> Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
> Link: https://lore.kernel.org/dri-devel/Z4jtKHY4qN3RNZNG@phenom.ffwll.local/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Thanks for documenting that little bit of lore!

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima

> ---
>  include/drm/drm_atomic.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 1ded9a8d4e84d7d9879d7f60a876ba9d69785766..4c673f0698fef6b60f77db980378d5e88e0e250e 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -355,10 +355,41 @@ struct __drm_private_objs_state {
>   * these.
>   *
>   * States are added to an atomic update by calling drm_atomic_get_crtc_state(),
>   * drm_atomic_get_plane_state(), drm_atomic_get_connector_state(), or for
>   * private state structures, drm_atomic_get_private_obj_state().
> + *
> + * NOTE: struct drm_atomic_state first started as a single collection of
> + * entities state pointers (drm_plane_state, drm_crtc_state, etc.).
> + *
> + * At atomic_check time, you could get the state about to be committed
> + * from drm_atomic_state, and the one currently running from the
> + * entities state pointer (drm_crtc.state, for example). After the call
> + * to drm_atomic_helper_swap_state(), the entities state pointer would
> + * contain the state previously checked, and the drm_atomic_state
> + * structure the old state.
> + *
> + * Over time, and in order to avoid confusion, drm_atomic_state has
> + * grown to have both the old state (ie, the state we replace) and the
> + * new state (ie, the state we want to apply). Those names are stable
> + * during the commit process, which makes it easier to reason about.
> + *
> + * You can still find some traces of that evolution through some hooks
> + * or callbacks taking a drm_atomic_state parameter called names like
> + * "old_state". This doesn't necessarily mean that the previous
> + * drm_atomic_state is passed, but rather that this used to be the state
> + * collection we were replacing after drm_atomic_helper_swap_state(),
> + * but the variable name was never updated.
> + *
> + * Some atomic operations implementations followed a similar process. We
> + * first started to pass the entity state only. However, it was pretty
> + * cumbersome for drivers, and especially CRTCs, to retrieve the states
> + * of other components. Thus, we switched to passing the whole
> + * drm_atomic_state as a parameter to those operations. Similarly, the
> + * transition isn't complete yet, and one might still find atomic
> + * operations taking a drm_atomic_state pointer, or a component state
> + * pointer. The former is the preferred form.
>   */
>  struct drm_atomic_state {
>  	/**
>  	 * @ref:
>  	 *
> 
> -- 
> 2.48.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

