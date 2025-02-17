Return-Path: <linux-kernel+bounces-518079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72CA389AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990E816486F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5522540C;
	Mon, 17 Feb 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VZbUldbW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17ED1531DC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810490; cv=none; b=Ez0EyPHjLopJqHEvNJYe9cUtBfrq3ebfkfps4IDinQdKwJ+XwOe3dItlokVF/En9jbq1KGCGFTDm0RBtxyUZdPsYcb0zS4ad5QZaA1jShjB8pRBlvLKSrsWfZiwZSGutz2nUK1FCZtqd4r6jnMCbwzxDqPx9YnBpg3NMxYfobLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810490; c=relaxed/simple;
	bh=ECuRb0IYed9gtOKCSY+Zrhi/7eDVXqMMGoPWlLKABTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgDyy7n+1jnmSiKUrJiQHbuBe/NaGIl9i3lgYmopSL6xabTpkpIi20VQ498mpOvePB58Hf1V6we/1XgE21I56dSO0o1xsN5rXE1bQiLnZSErYrqj8rl5OYmMiqu2z0L2W09K4I7DltLZL/LdSno72dTWTRkfkx9zb1laz+UGFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VZbUldbW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so2747185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739810487; x=1740415287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH7dByoQjATcMtRNPRz1qJqOaKrEwLdFgaeAEJKWfqY=;
        b=VZbUldbW2OnaNp0UjmMg//hj7VnQmkeIDUQ7RPSUGI/Z64vlrx7HteJs15HQbPNAk3
         vo80jecoof94YGjJCLT6CWIA5Fgz4XBi3j+P/7AkGV4QyQm4flNACbVk3C/uo80QgVTV
         PKab1r9v6ov+ru8QPr8o995VOYHwVgTgL5df0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810487; x=1740415287;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GH7dByoQjATcMtRNPRz1qJqOaKrEwLdFgaeAEJKWfqY=;
        b=Kct6fKW5Tdry56knhG+eJ7frRe84dcC7xPBGjnIycO7GlC8DZ4LfsOuEIofG2y0Kqf
         RrEQW0DQOpygt8vRP85VCVMwhNa4eq8c02w/xQVVPVSLKU+0C9ETBADrKTfKFxf0Eb3v
         ELDEu5Yj0L0mptvN7GvgBy35UMGmgNKFmU2GNh0TprV/2acL0yaG4G53PC8gXk6+oMfb
         XK1CGaMjFuTBYqwKjEycqXMb/XLc+d1CVuvj0RVtECQt7IW+XPBvtbMbovnnzaFvJegT
         pPHTHp/MD3qv6gx6VyFXPULNHcIAmmOXbE1nFSCJLjyF+kP5wCCXkdzDkmY/6tXw4xV+
         3Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfojE5hGXBq+SQBt6WYb78V1/RaIORGw1NTnRLMH+GVZRCIw3Os3RMN6lFzZHyVbFpLttZ+fiQLb7+r6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuhyeUALSn1v0847n1pkYqPuNu40yoT3t7FzaLFBzU5eSMx3x
	rJP/QpqQdsETJ5dW4bFiFOHGRm9X71jtvnGnXnb6yT5HD2F8IEYNu6HaTtmeJck=
X-Gm-Gg: ASbGnctmxqvw5fm1d4HwPuliO6CxLWRttpq/8t7B6uo/JOGq0KAt+lqIClCldoStUWb
	Vqer7BuxApblgwYbZYqflB6loyhqLTuz/KNJrzC6ZoWQ8ibgE0+qwOvAYnaBYaGrvgtxqaWH00S
	7GuCnWXi/K9cj4OYY74Y/1SlSaX6NVgDAowLy8Lq5gVH2/7rdENUs3MjUlCVMDK+Gix5sbJVOhQ
	/zaIkfdoN78eLgewXAcTFsgeMHUoi2SH6S7/B3DZYxUoGQYGHLmARtUAVWr7qJKIZ/efrXyScrO
	ucvsVJ/wwyaMgfGmTUJU9JJlSyY=
X-Google-Smtp-Source: AGHT+IFRhKctt5xCG+FRKWC52l+K41KeexQa204yjGmhr/2wp4/LnFs1TbG9nQwuRUmQ3E8RWifHQw==
X-Received: by 2002:a05:600c:2d03:b0:439:7ef0:a112 with SMTP id 5b1f17b1804b1-4397ef0a282mr45449985e9.10.1739810486832;
        Mon, 17 Feb 2025 08:41:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm12453272f8f.7.2025.02.17.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:41:26 -0800 (PST)
Date: Mon, 17 Feb 2025 17:41:24 +0100
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <Z7NmtF83adILfasi@phenom.ffwll.local>
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
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> Now that connectors are no longer necessarily created by the bridges
> drivers themselves but might be created by drm_bridge_connector, it's
> pretty hard for bridge drivers to retrieve pointers to the connector and
> CRTC they are attached to.
> 
> Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> encoder field, and then the drm_encoder crtc field, both of them being
> deprecated.

Eh, this isn't quite how this works. So unless bridges have become very
dynamic and gained flexible routing the bridge(->bridge->...)->encoder
chain is static. And the crtc for an encoder you find by walking the
connector states in a drm_atomic_state, finding the right one that points
at your encoder, and then return the ->crtc pointer from that connector
state.

It's a bit bonkers, but I think it's better to compute this than adding
more pointers that potentially diverge. Unless there's a grand plan here,
but then I think we want some safety checks that all the pointers never
get out of sync here.
-Sima

> 
> And for the connector, since we can have multiple connectors attached to
> a CRTC, we don't really have a reliable way to get it.
> 
> Let's provide both pointers in the drm_bridge_state structure so we
> don't have to follow deprecated, non-atomic, pointers, and be more
> consistent with the other KMS entities.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  5 +++++
>  drivers/gpu/drm/drm_bridge.c              |  5 +++++
>  include/drm/drm_atomic.h                  | 14 ++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 519228eb109533d2596e899a57b571fa0995824f..66661dca077215b78dffca7bc1712f56d35e3918 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -777,10 +777,15 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_duplicate_state);
>   * that don't subclass the bridge state.
>   */
>  void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>  					    struct drm_bridge_state *state)
>  {
> +	if (state->connector) {
> +		drm_connector_put(state->connector);
> +		state->connector = NULL;
> +	}
> +
>  	kfree(state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index b6d24092674c8fa33d9b6ebab9ece0f91fb8f8ea..db2e9834939217d65720ab7a2f82a9ca3db796b0 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -812,10 +812,15 @@ static int drm_atomic_bridge_check(struct drm_bridge *bridge,
>  		bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
>  							       bridge);
>  		if (WARN_ON(!bridge_state))
>  			return -EINVAL;
>  
> +		bridge_state->crtc = crtc_state->crtc;
> +
> +		drm_connector_get(conn_state->connector);
> +		bridge_state->connector = conn_state->connector;
> +
>  		if (bridge->funcs->atomic_check) {
>  			ret = bridge->funcs->atomic_check(bridge, bridge_state,
>  							  crtc_state, conn_state);
>  			if (ret)
>  				return ret;
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 4c673f0698fef6b60f77db980378d5e88e0e250e..293e2538a428bc14013d7fabea57a6b858ed7b47 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1216,10 +1216,24 @@ struct drm_bridge_state {
>  	/**
>  	 * @bridge: the bridge this state refers to
>  	 */
>  	struct drm_bridge *bridge;
>  
> +	/**
> +	 * @crtc: CRTC the bridge is connected to, NULL if disabled.
> +	 *
> +	 * Do not change this directly.
> +	 */
> +	struct drm_crtc *crtc;
> +
> +	/**
> +	 * @connector: The connector the bridge is connected to, NULL if disabled.
> +	 *
> +	 * Do not change this directly.
> +	 */
> +	struct drm_connector *connector;
> +
>  	/**
>  	 * @input_bus_cfg: input bus configuration
>  	 */
>  	struct drm_bus_cfg input_bus_cfg;
>  
> 
> -- 
> 2.48.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

