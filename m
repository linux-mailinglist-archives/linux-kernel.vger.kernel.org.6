Return-Path: <linux-kernel+bounces-513456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201EDA34A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CD97A42A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C082222D1;
	Thu, 13 Feb 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITm4ubeQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE32222C7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464366; cv=none; b=RNFojTGMN9y/varaSoNRKNLv0L0lW36cqEKmXOyRTyQhvQezaLBtoisoNYPWox6C+QoJxTNvSr0R21Kk1IoVZjQ6fykn2FXlQ4Dx03IXEpYF5BQLdPsPk0jTWpseRjAtzLJ+6NmTpHxK/MuuP5WEjhwH1w9uAyV5AP9NVsZ3aLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464366; c=relaxed/simple;
	bh=Dt6WBmud37ktmJ4HGPJhRrTyTyR42hN2MTosdkdlT7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEUvIOUeU/B7jqtwnfi+vQvVmb7TmbGshDB/oEYlqy/eQlXdDMiHqIf5qRgGamKB8Qkhvu6ZL5OKELSzeBf3H5EUfRhhg10s3Wk4cHY1HrJmE/JKXmMO3dgTnk3OhefxbBF1adB+scVhrKSuLRMiPENgIiWadDNxSTI2TNK5d6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITm4ubeQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543e49a10f5so1116976e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464363; x=1740069163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPHPNoshl1RcqwcSXICHqKvooCShtbqpBD0+IwmXNA4=;
        b=ITm4ubeQ/y088sYqtRuaBlzyhmJ2ekqCfe7+4FmrI3XM+V+8EIxDEMBnRN3o6qnXJH
         QoxVSlvaH5n1nH+AbnKusOu4huRVEGMdOf6YCdo5x1xm79zqeJjfP2KK3WubT91c2cXn
         2JNVI3BEUPWTszc5wL4i3LVXVDR7MbJpHM19nt1lG6b3Zc2sK2GdlM1DB7pMkhM8oHt/
         rryH5vd8077bCmst65AKVk3wADPOMHBWrLvdVQV2ZAWw82UviDAcMjrTeKl/DUTt5/TH
         XHpYX7qO2jxWvZGJSH18qw7wTukXYfsttlcUOAfi3TUVntpsy5IGduV40XssZwkWV56+
         9wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464363; x=1740069163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPHPNoshl1RcqwcSXICHqKvooCShtbqpBD0+IwmXNA4=;
        b=Qa7L269ZMwXVoFkdQ5i86t4EC2zsn+sJyUBxyHpUMW9IdkoUbywNrleNiRd6KxtThs
         aOBDuo586OEv8V2UgERpn7Ukwvjt39g3DfNWxI1lMX2IMc2fT9ZWLzPik93GdBkUNpdl
         zGc/hmWaYUFJy7jx5iklVtILMbqW+KEUdifw55vn6ruIKoqPtHs2yqcl/SzmaOmZbchz
         36CNtVqAD7s9ycFq/APOCq+dHXQ7SelZiwdViHv4dPEYyTxcForgW/+kDRFUB18Tlu04
         ZNxwQGTjDlseihvqVBRQAcvQRztO37pzWGVf7LdCQpm5sasgxN7MAqFwp+XAh3FpEgEV
         kRVA==
X-Forwarded-Encrypted: i=1; AJvYcCV8WSRny8MYKyPm5itRmtlBaaliU3lyAsISoM6/zHw6pJd00HRzrrOoenxXrMgvhBFIgIWrYtNTI8JAY5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTx0qp1tgiSIaw4AaS8tAxR/rqTSGWCNx1DmnPZJmOeuuxfzx+
	pu1EGFdgK4OQNRm+D4DTvr7++ODnIOlbbdF5pMfVbkYwJQVuaWjxrgI/YnL8p1U=
X-Gm-Gg: ASbGncsk7SABoR9H/d56I4RAAOpY598zg+PZLkHzF6/fBgl3exWiiD1R/TjMHvsVoye
	AaWNxQJPVDlbzARuCMxyG4VR5oLAtKCYXEnkJWqbt9uDjjba+fuhsc/SWZq9x+4ZOKrVduIFqcZ
	8OwK+/r9TN+BX02ADi9qzjJnk0wxrk0S70Q4JsM56upIwQAz1c6IQuu2M6KIkzb+jceNQcESXon
	P1hTsFO7AXQeC0iosgVrkokJDbMTPdSSEwZq7jTOwLvQPeCRC0oEbWW9oX6RmQN9amfWSkEMay/
	uFNJiiirtAPmG6kEpIM3Vi/Lhf4B4/h7B0Nj59v35SLv4bVIy6j1I9hR/Mzte2thx4gKMEk=
X-Google-Smtp-Source: AGHT+IHYWp+sMLAjjpwVQxvBUjGuUYEk19nenxTiG1/XVXYJCYHZpVNR+G42KEVOd0IkKtkXJD85fg==
X-Received: by 2002:a05:6512:3c96:b0:545:d35:6be2 with SMTP id 2adb3069b0e04-54518155288mr2789477e87.34.1739464362577;
        Thu, 13 Feb 2025 08:32:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f0834d3sm215968e87.11.2025.02.13.08.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:32:42 -0800 (PST)
Date: Thu, 13 Feb 2025 18:32:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <gyfchljgrqamb26sot4c26gcwupbst2zuu5fw6el5wsl6gl5xp@ruqbpsn4lpvx>
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

On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> Now that connectors are no longer necessarily created by the bridges
> drivers themselves but might be created by drm_bridge_connector, it's
> pretty hard for bridge drivers to retrieve pointers to the connector and
> CRTC they are attached to.
> 
> Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> encoder field, and then the drm_encoder crtc field, both of them being
> deprecated.
> 
> And for the connector, since we can have multiple connectors attached to
> a CRTC, we don't really have a reliable way to get it.

The same comment as for v2:

It's not very precise:

 connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);

Is that unreliable somehow?

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
With best wishes
Dmitry

