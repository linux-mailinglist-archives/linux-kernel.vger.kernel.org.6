Return-Path: <linux-kernel+bounces-515049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5BA35F17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F3B188F777
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39015264A90;
	Fri, 14 Feb 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDWE/r4g"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310D264A8E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539578; cv=none; b=dzF46dr99Rsof4Bqt+RKSZSw88tSsiglLnFOWhpIsPTje9dJDunx3G0FPElKpucvCBtetb7/tDM9CPCJJC3YmBvT9bu4D27UFcLLe8hlBUSZr5y5YHyNdBR5P2a2PYuGh2Fyz+ydkkmI9SiHs6EpsAmSnwQmexlUKNM2FQmJ+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539578; c=relaxed/simple;
	bh=F2WRjK2c+HGPBI4BrKdG/AtbaKFPV6er+U6NhOCexls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcsOQeb2PIeiJPc5s78XyWEyY7eTWTmCeyPhY/lgN8S1ryc9HfZluxtBgDQWRmSzDGn7blhgfeXtIx+MHk8GpAcLNKSeKBK4vTtR3R3thBK130BkcSS2qmIj/yZDd9s6K9UrieV4S2RoWZpsncTDWjUZ4WptskDDl/C4+0rJAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDWE/r4g; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54524740032so1098510e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539575; x=1740144375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtcyLVKqe8TuXjrm6a7QBmXjMFai0ljcx+mgo7ftSgk=;
        b=CDWE/r4gaEluONpX9ocHAtXNbA6ugMRpxv7Kqmm6IEu4O1gJjrP9J3VMh4q+6tAMkv
         ziSwg0HqOh4KUX0s3RY/npohz1/K34L1TmzQYyL/i8WOOTfiQoZKTBVHFL+RBiObZb1x
         tlC9zgNIDdptZlsUR2uP5GoW4+1fLVh490bt9Wz5nj37yIM0i0IYJ5smOTTXh1NYGlm0
         /UFaJwloQACoTucNBEdO2ynhxBdSe98SgtV24tp9bj6V5xNfzpaROs1N4ogfqYcp4Cbi
         r/SiHMu6Xdoh6M9hVhF5VjJDgIvHGwMmyS9lzTU7XwM4yASbOWSt5Oc3jr3liJwXZsUp
         Ns/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539575; x=1740144375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtcyLVKqe8TuXjrm6a7QBmXjMFai0ljcx+mgo7ftSgk=;
        b=STQtEfY/ZQq1XmYp8fZYae7+uBLO8jnhyful2/I39LuhQBBENkIpMRKmh0sew7YbDJ
         NwzxzUPF4Vr+C/6E1GKzauehZJE+qfJTZG2hs50oU489G2Lsq14xi2AYjRUOGKsk5pC+
         T+rmR5kf7kwvCJ7Z/OUWLV05ca16TQ8JU04mFQ3mJ9frOnwikivwNuucUcpTuMECRK9L
         Zh0kcX9ti5i774Os3W3ACM/xEmotDerqg18LQtQbtgmucTm8mQ/PWjBlauFwq9U6WvXy
         GnV6u9GyQfX15t6vuUPasL4tSfXOlMpR3YblxSY1eb2zfFZhr1KbImzmmRkleMYoMVvX
         ScfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZHbJ98hUTo9cwXmgRJaCIg7+d4sXKi/GTDwsyUjKsFeMgLjOQ4aqlLblWiHE8gAYvSZBlabG+xVP/6Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWy0jM571CjyNCLg2L13AWYRvlCbKpkX6MZesv6vlqVItQaFoR
	HpnP4Oo/hZKUScRpWwEe3LsGd3B61SG7w6RGbywpXvrXvh3FvdZcRVSb/Y/LToc=
X-Gm-Gg: ASbGnct2qjzFAvDjDwMsikxZw3+Dxi5ZGhkX+kYLSRDgwEIXC/n4fnXc4CIIjAcTdVU
	oQQlvqWMy6inGSazcOA7GRqTnXI02b6vp4QL88g1UrDRyueSa3BCn6Tkb6hxopm/QJPrBYERWY8
	Net7KyTHvx20MeoYlA0eUO8SCTTbK9aVYr80+sJ6hsep4adJ4dHxkmHVNjcb/diF4nsUf5JFp0j
	VsAgsGCo/u3RIIT8eKvLRjNBO7q3FjEJxkIGlBFtrmz/wNTtRQpXD4dRXCkZ1KhxjRA8wc8V+rU
	SxRO6ZEC0AFB+bO2b/QYp/bJhUFXZ4XTQMS/PyFr8m5NaAhqvD1QN+ixtxBziSCC6CW8Eyc=
X-Google-Smtp-Source: AGHT+IEEwoEsMm0mqK5dUwUP8dPwEw2WkrSX9yJSXwHrbo3H+703YZ8PIf8yI+CMDaqWEB2Htuehmg==
X-Received: by 2002:a05:6512:1318:b0:545:e2e:844a with SMTP id 2adb3069b0e04-5451ddd7917mr2541333e87.38.1739539574807;
        Fri, 14 Feb 2025 05:26:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09aa9asm535389e87.59.2025.02.14.05.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:26:13 -0800 (PST)
Date: Fri, 14 Feb 2025 15:26:11 +0200
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
Message-ID: <x2qp4dy7gsqns2czx5bml5ofdyfwsl7jhdmy5ptwslvoz3d56z@e7otlhrvmf5f>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-30-e71598f49c8f@kernel.org>
 <vjdpctck2afcjrt2rlgjtzmrkf4a5bg5ihymc53vuw6md576wd@kbb5y27a5woi>
 <20250214-icy-earthworm-of-happiness-6bca70@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-icy-earthworm-of-happiness-6bca70@houat>

On Fri, Feb 14, 2025 at 01:59:01PM +0100, Maxime Ripard wrote:
> On Thu, Feb 13, 2025 at 06:29:46PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Feb 13, 2025 at 03:43:49PM +0100, Maxime Ripard wrote:
> > > The drm_atomic_bridge_check() runs the atomic_check callback if needed,
> > > or falls back to mode_fixup if it's not there.
> > > 
> > > Going forward, we'll need to setup the bridge atomic state even though
> > > drivers might not be implementing atomic_check at all.
> > > 
> > > We can thus switch to using drm_bridge_is_atomic() to take the atomic
> > > path, and do additional things there in the future, or go the mode_fixup
> > > route.
> > 
> > This will break bridges like tc358768, rcar_lvds and mtk_hdmi: they
> > implement atomic_reset() and mode_fixup().
> 
> What is your suggestion then? I kind of did what you were suggesting on
> patch 1, but it wasn't working. Then you want me to roll back to that,
> or something else?

Well, we just need to call mode_fixup. So something like:

	if (drm_bridge_is_atomic(bridge)) {
		bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
							       bridge);
		if (WARN_ON(!bridge_state))
			return -EINVAL;
	}

	if (bridge->funcs->atomic_check) {
		/* drm_bridge_add() returns void, so there is no way to
		 * reject non-atomic bridges with atomic_check()
		 * callback.
		 */
		if (!bridge_state)
			return -EINVAL;
		ret = bridge->funcs->atomic_check(bridge, bridge_state,
						  crtc_state, conn_state);
		if (ret)
			return ret;
	} else if (bridge->funcs->mode_fixup) {
		if (!bridge->funcs->mode_fixup(bridge, &crtc_state->mode,
					       &crtc_state->adjusted_mode))
			return -EINVAL;
	}



-- 
With best wishes
Dmitry

