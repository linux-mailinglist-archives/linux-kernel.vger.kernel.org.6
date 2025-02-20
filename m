Return-Path: <linux-kernel+bounces-523351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09DA3D556
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3726A7A9B94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D91F0E48;
	Thu, 20 Feb 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Cs1UL0rf"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90A1F03E0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044999; cv=none; b=I5mSyHY0X8YyTY73aZ/ZKZzS8FfB2apLnftqTuIm5w5ApvkjPZCrlL+VFAbUcCEO9EP/0HcyFojVO1nBfxxIiK7E13p+b/5U+YzTTNJUugEamL87R4p6rUMjRFyFLJgLJWqhPk5rtFp5hpjd2Os3fpfJgk1nYKcbyVeS2okyplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044999; c=relaxed/simple;
	bh=gLrdVTM/31gaRQa+WjgnRFidn/3PsESlygiB84pi/7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6KxgV7Q6oOQCgfd5wQfd5i/29EGr838fGmPhct+uCVj/PQnKaekQKurjmmQ2Ed8zp3SI26/qLyiD3wgxC2GsTRkTCH1m2QJu0JxaUbib5Wl+DL1TOcml+t3jGJQlREvuJHpXQuDvO9lyB+QSK7MbmhEwfl9klnagam8XVZ2dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Cs1UL0rf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so372250f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740044996; x=1740649796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7SecTuWmwnoGQvx5fWAJpnW1FaqciuMmH5iox49O5c=;
        b=Cs1UL0rfsz/XrG7BLPD4VWxczCQGaDfzYJGPaaLlNjh+D7XTcSC9TuwnrYUWGvQLd4
         fTt90GLPXWZ8Ow35AEivPXMGaKrdzfAIJDOYLoqZH9Us7xOLv8vbv50FSgCliytIrMRu
         5EtVNxNiNpn6hP/PwzecxxMkfRiyRGt5HhECk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044996; x=1740649796;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7SecTuWmwnoGQvx5fWAJpnW1FaqciuMmH5iox49O5c=;
        b=UgNa+lnnez3OR/4ZFVPH1uF+W47Ka0HBfwUnfqStxtt/N6RtviapA38e+Rq2Oh7OCS
         CyVjCwRgIexkqob85uwwdryzuwL9iw46WwWV3tESyNoCZJyDQ0TXP1ilaU6YFYEgsytR
         BiTcNABjX2WH5pSLB6wmP0ZZaHMKw25y63f6YY1c5iCtEKXaBr7uVE7Q6pKM5mcJqELd
         G378K+kovdOY8045sRmhjpckifk0cUBmMfvEig2ttNh6optDnhjVt9Z/NXHZz6IaJrZo
         0p98TsDVzF3tU28DQsy92t5fmW7z04kCt7iHQC9XTiyO8yow0GKKjfZGwtjHR3n1+KWV
         9U7A==
X-Forwarded-Encrypted: i=1; AJvYcCW+YJjBpghZSQH0ysmfJys5h8Voc9/bAS58caMagLqqMDoM4Ta2LLAAnyEDyuEXab6O9GDTV32VWcQDvIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuo28CTwUR8kAIshS8IIpMW03cED+IghJrVZH/xLmZWsCryFrD
	V6PIGVflzAFvi5jumUlrZg3YV8eNox4jLC0XvFVuKBvZDD0MHHQ1xMsMh11Z+3I=
X-Gm-Gg: ASbGncvDF73oSlxIwGfeyjXK8pul6nEzjtBJSjFE2ikp1uO9BpKjc2JHHwCvTFmhhwG
	v73b0LXsrMo+3/4wHJt98JrtHCN1N39jkOA63YQOjROHjN4D22XhyIlo+IvNTdUc/7OLn5LqAEk
	Ze1FN6zCJJJd5bEOMI5uME62PJ7ElCzFAtrC3CRHF3fk7+6WdWmcCJc3FgRFEfCuspQfFgZAm6j
	8xzuFNhTbt+/fAYYe04LT/QhK4aiyi+XP1Lip9AUbKX1KQAQVbVcqk/AJrXi69YRMAZqBqI3hmH
	0ZyUS7/2O4JxYCiQGGSlJBHvOnA=
X-Google-Smtp-Source: AGHT+IG1XNq+yvNmwPgumPAiB8sDygsjgkleurSBqiGod07eF/zDW+EUm3aE6kOmPHgxFKCHHicsIA==
X-Received: by 2002:a5d:6486:0:b0:38f:6149:9235 with SMTP id ffacd0b85a97d-38f614992eemr2689445f8f.16.1740044995913;
        Thu, 20 Feb 2025 01:49:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8c1sm239212715e9.8.2025.02.20.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:49:54 -0800 (PST)
Date: Thu, 20 Feb 2025 10:49:52 +0100
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
Message-ID: <Z7b6wBF9VNwYkB5w@phenom.ffwll.local>
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
 <Z7NmtF83adILfasi@phenom.ffwll.local>
 <20250218-adamant-translucent-civet-aebcc5@houat>
 <Z7XeHaTmtS8ClOV-@phenom.ffwll.local>
 <20250219-gregarious-condor-of-prestige-a6ce0c@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-gregarious-condor-of-prestige-a6ce0c@houat>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Feb 19, 2025 at 04:56:11PM +0100, Maxime Ripard wrote:
> On Wed, Feb 19, 2025 at 02:35:25PM +0100, Simona Vetter wrote:
> > On Tue, Feb 18, 2025 at 11:23:00AM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > Thanks for your answer
> > > 
> > > On Mon, Feb 17, 2025 at 05:41:24PM +0100, Simona Vetter wrote:
> > > > On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > > > > Now that connectors are no longer necessarily created by the bridges
> > > > > drivers themselves but might be created by drm_bridge_connector, it's
> > > > > pretty hard for bridge drivers to retrieve pointers to the connector and
> > > > > CRTC they are attached to.
> > > > > 
> > > > > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > > > > encoder field, and then the drm_encoder crtc field, both of them being
> > > > > deprecated.
> > > > 
> > > > Eh, this isn't quite how this works. So unless bridges have become very
> > > > dynamic and gained flexible routing the bridge(->bridge->...)->encoder
> > > > chain is static. And the crtc for an encoder you find by walking the
> > > > connector states in a drm_atomic_state, finding the right one that points
> > > > at your encoder, and then return the ->crtc pointer from that connector
> > > > state.
> > > > 
> > > > It's a bit bonkers, but I think it's better to compute this than adding
> > > > more pointers that potentially diverge. Unless there's a grand plan here,
> > > > but then I think we want some safety checks that all the pointers never
> > > > get out of sync here.
> > > 
> > > That work stemed from this series
> > > https://lore.kernel.org/all/20250210132620.42263-1-herve.codina@bootlin.com/
> > > 
> > > and in particular:
> > > https://lore.kernel.org/all/20250210132620.42263-5-herve.codina@bootlin.com/
> > > 
> > > Bridges, outside of the modesetting code path, don't have a way to
> > > access the drm_atomic_state since drm_bridge_state->state is typically
> > > cleared after swap_state. So accessing the connectors and CRTCs don't
> > > work anymore.
> > > 
> > > In this particular case, we needed to access those from the bridge
> > > interrupt handler.
> > 
> > Uh for interrupt handler you can't use anything stored in state objects
> > anyway. So I'm even more confused.
> 
> Why not? As long as we're in a threaded handler, and take the proper
> locks, what's wrong with it, and how is it fundamentally different than,
> idk, cec or audio hooks?

Well, _threaded_ interrupt handler is a quite important distinction. Then
it's indeed fine from a locking pov. I'm still not sure it's actually what
you want, because obj->state is the logical state. It does not reflect the
hw state, and grabbing a lock won't change that. You can do nonblocking
atomic modeset changes after all. So you might still run the risk that
your irq handler is looking at state which does not reflect the actual hw
configuration. And if it's then messing around with it, you're racing
against a concurrent atomic commit work.

This is why all the vblank state is protected by separate spinlocks, and
copied over to that separate state at the appropriate time within the
atomic commit sequence. So if you need something like this for bridges,
you probably need still need the spinlock (or a mutex, for threaded
interrupt handlers) and separate state.

Meaning: I'm still rather skeptical of what you're doing here ...
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

