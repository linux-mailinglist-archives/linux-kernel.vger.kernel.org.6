Return-Path: <linux-kernel+bounces-521627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110EEA3C00C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBE18895E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27A1E3769;
	Wed, 19 Feb 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QvGOoVym"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAB1E32D3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972131; cv=none; b=HE9oEiukICjDu5v5/9TzRkJMVBEYPxsamUVrJMGxYRRHp/pdk9FK2slTXsGxhujm7Xw6xykvd2YPuYfmKFow1HmT23g7fMwNqHvCQYgH65CXEiiODysmQ5SeR9AzIWk02lFnwQtM2MMMkUvyG0FlmvnsTETPvyE4h/x2TTqgGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972131; c=relaxed/simple;
	bh=AKqYCwpdcsdPYvGcXxkdi1cTguj2kVjE5fHt8GYF0Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Pnb3IIZbc/axLkd3UFGjaeMd3Fl9wtGK4mKAbFBaUt0zlBC4X7qjmTw+ekM5nndhSbs5WskGkXRHyIuU83jtC/sYf4DGwPmxcWskTPy2UScGIcPfCHRZS83m8cfD5GB7bhV0V7tYxjHW8oUA4mopaEvXQ5mkPAzYxg2OrP8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QvGOoVym; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4396f579634so27111415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739972128; x=1740576928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/HDFDILYx7rzMW3nshuh5AQhUvdQzF7q7CNPi9LQXw=;
        b=QvGOoVymaiimwvYoB+Wpe3uRkSvAL2U1XpSg29m5yD62rjMtUInpzJCldBTIUdk/bu
         kxKYW/xYihFbAZ/UoxVZewqhwNKSI/rhsXc5n7Bsgz92gU5TlyTSa/6vHwnXZkb6z+iB
         CHee2Mu/V455NYiM6C9J7GWbm8gr5qYo8fpbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972128; x=1740576928;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/HDFDILYx7rzMW3nshuh5AQhUvdQzF7q7CNPi9LQXw=;
        b=ndWQCX5T8iLM/i/qhE9lgc+JfNws8H+sm/qyhTtzkWRMGCbByyzgD8moShwdPKdrtm
         49zhwFLWGi0m8EqgMurR9FspBRMrYpCMWXd2JtEHkmcbWrUFXaA+n2p+pD0ghwmY0jW5
         9JW2TODbcxzt7Gc7QoetATToZtjrT4eAPadmjz4O1xkvVd6c6gEorEV6SKha51H2GOcO
         faUtq2fUm0/7r1FfS8O8RHvM1RsDYHjQjYbFLoRGHMqqeZDDJC2KTC9a5QsM/ZCjRxo7
         zm/GuqBmQQLoIIjI0k4Du7mDkj8OmCgjtS4udu0qlp7Y19kmeah5xP02MkBhvBEoIch5
         zuEA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6HPLCGeERS4pq2kX/RiZ2DhxYNX7X2WlyEVsTsB0QlHQ+BFMNDVAuCav9alYdXavJtqo6PHGebqmRTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/utnQYIsLVC9otD180E0RwDMdn+2UWHrk2Z30O2VjUFlp47fN
	pWnhDhvgBil1d23GB9nECj04UYlfkWJOn5X4SvP4eO8nGjHXmIIcNU03Ah4/R5M=
X-Gm-Gg: ASbGncuRBNffO443uiclWoCva03RBTT4NkAVRYyZOtJkNhBHeEFVPveUB6317waiPI7
	iamowht3P0f9sxgdZ0Bse7zM6UcTmpQJhrMt+QL38GhiHJ0Q1qhr5EmlvzeFu3L15NNuZV8mHaB
	JGN0HmAjI4VG6VZsUyBXhhJSbUmk84n4YE9v1xflaQLJp4yTQfV6kIEKmQTqGw/F4xnA1H1NLsj
	C4CBZb/RYZ+1yVaGTFY3xGhi+e+QxSYK21Xc3lx6KDe7e9bBaP76AGWspAug5mwJ+Xzh1mbPPOQ
	0RTGUXnxvtIevkxAc+kLPDutkik=
X-Google-Smtp-Source: AGHT+IGBsXJy4TW3NzQtnHG+441AuJVg+sFRbAo/Yk1ZcOffGOO9VyBDKzMqA723pRTlMbWhiqtsiA==
X-Received: by 2002:a05:600c:45ca:b0:439:967b:46f4 with SMTP id 5b1f17b1804b1-43999ddb0c7mr29219535e9.26.1739972128402;
        Wed, 19 Feb 2025 05:35:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8397sm212510785e9.36.2025.02.19.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:35:27 -0800 (PST)
Date: Wed, 19 Feb 2025 14:35:25 +0100
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
Message-ID: <Z7XeHaTmtS8ClOV-@phenom.ffwll.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-adamant-translucent-civet-aebcc5@houat>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Feb 18, 2025 at 11:23:00AM +0100, Maxime Ripard wrote:
> Hi,
> 
> Thanks for your answer
> 
> On Mon, Feb 17, 2025 at 05:41:24PM +0100, Simona Vetter wrote:
> > On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > > Now that connectors are no longer necessarily created by the bridges
> > > drivers themselves but might be created by drm_bridge_connector, it's
> > > pretty hard for bridge drivers to retrieve pointers to the connector and
> > > CRTC they are attached to.
> > > 
> > > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > > encoder field, and then the drm_encoder crtc field, both of them being
> > > deprecated.
> > 
> > Eh, this isn't quite how this works. So unless bridges have become very
> > dynamic and gained flexible routing the bridge(->bridge->...)->encoder
> > chain is static. And the crtc for an encoder you find by walking the
> > connector states in a drm_atomic_state, finding the right one that points
> > at your encoder, and then return the ->crtc pointer from that connector
> > state.
> > 
> > It's a bit bonkers, but I think it's better to compute this than adding
> > more pointers that potentially diverge. Unless there's a grand plan here,
> > but then I think we want some safety checks that all the pointers never
> > get out of sync here.
> 
> That work stemed from this series
> https://lore.kernel.org/all/20250210132620.42263-1-herve.codina@bootlin.com/
> 
> and in particular:
> https://lore.kernel.org/all/20250210132620.42263-5-herve.codina@bootlin.com/
> 
> Bridges, outside of the modesetting code path, don't have a way to
> access the drm_atomic_state since drm_bridge_state->state is typically
> cleared after swap_state. So accessing the connectors and CRTCs don't
> work anymore.
> 
> In this particular case, we needed to access those from the bridge
> interrupt handler.

Uh for interrupt handler you can't use anything stored in state objects
anyway. So I'm even more confused.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

