Return-Path: <linux-kernel+bounces-518263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5CA38C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF883AB831
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0AF236445;
	Mon, 17 Feb 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Le6O+yGV"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0E1624F9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821002; cv=none; b=ELiL1tGpsz7fA9DaGzr1JFKMdpN0Ek3aUNpLBzJ4ebnXTYOSRDtWxrEfR/FU+tvp45Bp9b76HxrQd8M7ZN2ZeXG1Dff6thXtOWxZR8VKxP4KdDb+s91NbAsL63oXC5iZXqbOFZg7g4auOg8qFZFW0IbkmIFnGj7RNJVIa6yU8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821002; c=relaxed/simple;
	bh=60PFGG12FD4LfhgXzEu6cajXfPzroPfKxKTFCURYqFE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL5mn8UJtYZOPpLHgtHqLXXVB6xyftDKtOFTnKPL6DejM/WA3UYVQAvJuw4hYK9NwbdCax021jAKP/6N3AOX1IOCpwt7TW5bw288lf7niXDSWTSFXGBInlTg3A34FUFiqyHGT5E/oyh/ltCD3NZcgPGXEofnyFnIyEzyKzHM5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Le6O+yGV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-545284eac3bso3920118e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739820999; x=1740425799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3U8NlgfYRWr/by2t3l1latdwmUYOB232O9kLWODXzV4=;
        b=Le6O+yGV0uOOCB6WXSiEz7JTAPqebthZBPeS86KGCIFUTtBVAQTUE32KlCs93CxbcI
         F27WebaaEYYUU34rzs8577EOQJIkhFr+X9JgEhCEiXMGVJuOhFTjIfCoeIYEecDhwOvE
         VEPqvFQJMZPGBSL4QSMIYrK1K6ewixI0Z5Wfb8nP4hyUIZH4IKiNuUqIHsGnaI+M/oot
         FG+huQ07HIqL989c5wfOghGq/fctg62PIaYQ52mAnDBCfoX1AneDR5ZypMtX3pQbxCqt
         /DnZBxZ2Y7yZxkNijkC2rSpbnS4UauYgDUClbzA5YUP0naEjneZpb7qbX8+ZgGy8He7R
         tF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820999; x=1740425799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U8NlgfYRWr/by2t3l1latdwmUYOB232O9kLWODXzV4=;
        b=sIRaREQrWSWoN8fNRp/0og/N2b9sKkBUGg1Q/9W0ISNPJdnGs4kHnpFtocf94kElab
         Kihr2/r8wdskrRGgtqjaxcJyqR5J/JrL+hBZvtarLo4CDuKzQIsDpFzzPphO9T4m+dbv
         grJRp1SE8ggh5rjd80kT00ePcMzWyAfezyhjJR2RVIEjoSq5+k0luVMcSqcCLvhG6XxG
         1OR6FNtq/UslUQs4E8piMD1URjCznlaQTgu/+AddwTnGZS2EkOmY4QVBePkFRvL10JXm
         MllSIYdr5oz0Vbwh9woUaDXZa6jYygnXfzoBtQ6n7v0TIgVSb9iTPzyFemT10WIjWNi5
         Otkw==
X-Forwarded-Encrypted: i=1; AJvYcCVeJy5D7QgX7aXRfD4xuMIxiNoJUApjgVMQ0cJg4yOqh72XKIxc3vjEZ1jpGwVblZkK9kHHX5K+/Wj0wV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFhTAZ2I4RVGwltAwQDjQmXzh9qEqorF5nYSy39g1KihjaIPL
	pHHgKfPavzx3/qv4UIPEJSuohkdeYWsP3f56M7KKyHUGTcDCF/xRzoiPimkuXfM=
X-Gm-Gg: ASbGncv39UA696rDcshvRZuNaSwnmJSporesL4tWiIC4L4LrQbyhdvPG7Vh5gNsHOPt
	UZpT/CKjFg2ihn8yhC+rvcAuxV8vS2EUYFVZEMgA5M7n8nDKkcrc7zHun8oYBvWwCuyk00zrfAE
	YJk/kJefRZCwoDckcr1i9uyJuKC4tGqkgTri6f0qf7g5K+uQn9c9QmAM0c353gzMiaSieNyL17h
	XCgp4ykvkQgJroBdD1ueVtLaKjKHw2SrUKiiq69+KV5t9VgFsDjIuUoQ8yXUD1YlCTpOo2EE5BG
	Dwj+Ld2aYCbnazRVC6RUxUDrSESKGPAVcLOgY5YJqcMtIFiLwhBrkQyfrccjKIEsXmJaVlc=
X-Google-Smtp-Source: AGHT+IHBoAKRkAWdvnSRijUiodJjyY3mQNvX+jrwcj4p/1bCSHT6mAHiZoJ693muG+FtPkbJa7m+EQ==
X-Received: by 2002:a05:6512:4005:b0:545:22ec:8b51 with SMTP id 2adb3069b0e04-5452fe80338mr2687830e87.41.1739820998825;
        Mon, 17 Feb 2025 11:36:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461c964313sm726047e87.233.2025.02.17.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:36:37 -0800 (PST)
Date: Mon, 17 Feb 2025 21:36:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <padhzkj5astckiltvxkcs4xq335crrhf2m6bvii6cezyoyfypq@t535fgjwqzqg>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
 <Z7NmtF83adILfasi@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NmtF83adILfasi@phenom.ffwll.local>

On Mon, Feb 17, 2025 at 05:41:24PM +0100, Simona Vetter wrote:
> On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > Now that connectors are no longer necessarily created by the bridges
> > drivers themselves but might be created by drm_bridge_connector, it's
> > pretty hard for bridge drivers to retrieve pointers to the connector and
> > CRTC they are attached to.
> > 
> > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > encoder field, and then the drm_encoder crtc field, both of them being
> > deprecated.
> 
> Eh, this isn't quite how this works. So unless bridges have become very
> dynamic and gained flexible routing the bridge(->bridge->...)->encoder
> chain is static. And the crtc for an encoder you find by walking the
> connector states in a drm_atomic_state, finding the right one that points
> at your encoder, and then return the ->crtc pointer from that connector
> state.
> 
> It's a bit bonkers, but I think it's better to compute this than adding
> more pointers that potentially diverge. Unless there's a grand plan here,
> but then I think we want some safety checks that all the pointers never
> get out of sync here.

Luca is working on bridges hotplug, so connectors are dynamic now. And
at least my humble opinion is that we'd better provide the corresponding
pointers rather than having a lot of boilerplate code in the drivers.
(there are enough drivers which look up connector and/or CRTC) and there
are even more drivers (I think, I haven't actually checked the source
tree) that could have benefited from thaving the connector or CRTC in
the state. Instead they store a pointer to the connector or perform
other fancy tricks.

> -Sima
> 
> > 
> > And for the connector, since we can have multiple connectors attached to
> > a CRTC, we don't really have a reliable way to get it.
> > 
> > Let's provide both pointers in the drm_bridge_state structure so we
> > don't have to follow deprecated, non-atomic, pointers, and be more
> > consistent with the other KMS entities.
> > 
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_state_helper.c |  5 +++++
> >  drivers/gpu/drm/drm_bridge.c              |  5 +++++
> >  include/drm/drm_atomic.h                  | 14 ++++++++++++++
> >  3 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> > index 519228eb109533d2596e899a57b571fa0995824f..66661dca077215b78dffca7bc1712f56d35e3918 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -777,10 +777,15 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_duplicate_state);
> >   * that don't subclass the bridge state.
> >   */
> >  void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
> >  					    struct drm_bridge_state *state)
> >  {
> > +	if (state->connector) {
> > +		drm_connector_put(state->connector);
> > +		state->connector = NULL;
> > +	}
> > +
> >  	kfree(state);
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
> >  
> >  /**
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index b6d24092674c8fa33d9b6ebab9ece0f91fb8f8ea..db2e9834939217d65720ab7a2f82a9ca3db796b0 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -812,10 +812,15 @@ static int drm_atomic_bridge_check(struct drm_bridge *bridge,
> >  		bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
> >  							       bridge);
> >  		if (WARN_ON(!bridge_state))
> >  			return -EINVAL;
> >  
> > +		bridge_state->crtc = crtc_state->crtc;
> > +
> > +		drm_connector_get(conn_state->connector);
> > +		bridge_state->connector = conn_state->connector;
> > +
> >  		if (bridge->funcs->atomic_check) {
> >  			ret = bridge->funcs->atomic_check(bridge, bridge_state,
> >  							  crtc_state, conn_state);
> >  			if (ret)
> >  				return ret;
> > diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> > index 4c673f0698fef6b60f77db980378d5e88e0e250e..293e2538a428bc14013d7fabea57a6b858ed7b47 100644
> > --- a/include/drm/drm_atomic.h
> > +++ b/include/drm/drm_atomic.h
> > @@ -1216,10 +1216,24 @@ struct drm_bridge_state {
> >  	/**
> >  	 * @bridge: the bridge this state refers to
> >  	 */
> >  	struct drm_bridge *bridge;
> >  
> > +	/**
> > +	 * @crtc: CRTC the bridge is connected to, NULL if disabled.
> > +	 *
> > +	 * Do not change this directly.
> > +	 */
> > +	struct drm_crtc *crtc;
> > +
> > +	/**
> > +	 * @connector: The connector the bridge is connected to, NULL if disabled.
> > +	 *
> > +	 * Do not change this directly.
> > +	 */
> > +	struct drm_connector *connector;
> > +
> >  	/**
> >  	 * @input_bus_cfg: input bus configuration
> >  	 */
> >  	struct drm_bus_cfg input_bus_cfg;
> >  
> > 
> > -- 
> > 2.48.0
> > 
> 
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
With best wishes
Dmitry

