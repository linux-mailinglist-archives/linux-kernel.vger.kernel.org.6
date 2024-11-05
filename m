Return-Path: <linux-kernel+bounces-396223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8199BC985
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41B81F22479
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3E1D097C;
	Tue,  5 Nov 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KuUvxrCs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292D163;
	Tue,  5 Nov 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800040; cv=none; b=X2/rea48IUAZBeFnsOVdsS+OyeaR78bnm0CFBufyG1VLjeh/mvdpOvEL5bbT7jWzSy/CjmbMZvf8xhz2r9scj833vaJKBQwdjS3nf/WoES4QQ3z+o4qwQGyqA4OME9tKfoTGtQpTXTpBV98uXFxn/nlePnBRndngxF9oXQmiCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800040; c=relaxed/simple;
	bh=M0Ut8meL8KY2e62RU+oXfUnPjesd+j3sK9bZgAHcSnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m83VMKOfEL6f4+Z8TgGKayPCC4fQ20FDsVyTrSwCSQVYkkk1jY53U5PSPzcda+uoi+5bh+DgpmRboAcVHsYboGM+fGEfA8iRqePbQ6e+l1ZJB1x6rH9xcsVwsnTolJvIvXfGMlIr/r/dMIZnQFD88VDK/yFh9yYWAeX0jcieiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KuUvxrCs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB00421C;
	Tue,  5 Nov 2024 10:47:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730800029;
	bh=M0Ut8meL8KY2e62RU+oXfUnPjesd+j3sK9bZgAHcSnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuUvxrCsOWLFOWrpuYLTa6ONwajPti3MPpaqogjxRB28dmnc/lEu2WFkSg6pzty52
	 e5uyjWS5qTNVoHlFudoM9Fmz4vgVh4P9ue1K5FqHuGtJNRqUYjLjvpsQy7lc8fX9KN
	 u0EDNXsfRZGr6PxrpvBGQ9m/N/qFow+c9cSo3IsE=
Date: Tue, 5 Nov 2024 11:47:08 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241105094708.GK27775@pendragon.ideasonboard.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <20241027162350.GA15853@pendragon.ideasonboard.com>
 <20241028091331.6f67e29e@bootlin.com>
 <20241028112857.GF24052@pendragon.ideasonboard.com>
 <20241028-nebulous-yellow-dragon-2cfb5f@houat>
 <20241028132858.GE6081@pendragon.ideasonboard.com>
 <20241028-great-charming-flounder-23fc9b@houat>
 <20241028140913.GG6081@pendragon.ideasonboard.com>
 <20241105091503.48f69586@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105091503.48f69586@bootlin.com>

On Tue, Nov 05, 2024 at 09:15:03AM +0100, Herve Codina wrote:
> On Mon, 28 Oct 2024 16:09:13 +0200 Laurent Pinchart wrote:
> > On Mon, Oct 28, 2024 at 02:55:47PM +0100, Maxime Ripard wrote:
> > > On Mon, Oct 28, 2024 at 03:28:58PM +0200, Laurent Pinchart wrote:  
> > > > On Mon, Oct 28, 2024 at 01:21:45PM +0100, Maxime Ripard wrote:  
> > > > > On Mon, Oct 28, 2024 at 01:28:57PM +0200, Laurent Pinchart wrote:  
> > > > > > On Mon, Oct 28, 2024 at 09:13:31AM +0100, Herve Codina wrote:  
> > > > > > > On Sun, 27 Oct 2024 18:23:50 +0200 Laurent Pinchart wrote:
> > > > > > > 
> > > > > > > [...]  
> > > > > > > > > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > > > > > > > > +{
> > > > > > > > > +	struct drm_device *dev = sn65dsi83->bridge.dev;
> > > > > > > > > +	struct drm_modeset_acquire_ctx ctx;
> > > > > > > > > +	struct drm_atomic_state *state;
> > > > > > > > > +	int err;
> > > > > > > > > +
> > > > > > > > > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > > > > > > > > +	 * operation done in drm_atomic_helper_resume() but without releasing
> > > > > > > > > +	 * the lock between suspend()/resume()
> > > > > > > > > +	 */
> > > > > > > > > +
> > > > > > > > > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > > > > > > > > +
> > > > > > > > > +	state = drm_atomic_helper_duplicate_state(dev, &ctx);
> > > > > > > > > +	if (IS_ERR(state)) {
> > > > > > > > > +		err = PTR_ERR(state);
> > > > > > > > > +		goto unlock;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > > +	err = drm_atomic_helper_disable_all(dev, &ctx);
> > > > > > > > > +	if (err < 0)
> > > > > > > > > +		goto unlock;
> > > > > > > > > +
> > > > > > > > > +	drm_mode_config_reset(dev);
> > > > > > > > > +
> > > > > > > > > +	err = drm_atomic_helper_commit_duplicated_state(state, &ctx);    
> > > > > > > > 
> > > > > > > > Committing a full atomic state from a bridge driver in an asynchronous
> > > > > > > > way seems quite uncharted territory, and it worries me. It's also a very
> > > > > > > > heavyweight, you disable all outputs here, instead of focussing on the
> > > > > > > > output connected to the bridge. Can you either implement something more
> > > > > > > > local, resetting the bridge only, or create a core helper to handle this
> > > > > > > > kind of situation, on a per-output basis ?  
> > > > > > > 
> > > > > > > A full restart of the bridge (power off/on) is needed and so we need to
> > > > > > > redo the initialization sequence. This initialization sequence has to be
> > > > > > > done with the DSI data lanes (bridge inputs) driven in LP11 state and so
> > > > > > > without any video stream. Only focussing on bridge outputs will not be
> > > > > > > sufficient. That's why I brought the pipeline down and restarted it.  
> > > > > > 
> > > > > > Fair point.
> > > > > >   
> > > > > > > Of course, I can copy/paste sn65dsi83_reset_pipeline() to a core helper
> > > > > > > function. Is drm_atomic_helper_reset_all() could be a good candidate?  
> > > > > > 
> > > > > > The helper should operate on a single output, unrelated outputs should
> > > > > > not be affected.  
> > > > > 
> > > > > Also, you don't want to reset anything, you just want the last commit to
> > > > > be replayed.  
> > > > 
> > > > I'm not sure about that. If the last commit is just a page flip, that
> > > > won't help, will it ?  
> > > 
> > > The alternative would be that you start anew with a blank state, which
> > > effectively drops every configuration that has been done by userspace.
> > > This is terrible.
> > > 
> > > And a page flip wouldn't have affected the connector and
> > > connector->state would still be to the last state that affected it, so
> > > it would work.  
> > 
> > Ah right, you didn't mean replaying the last commit then, but first
> > disabling the output and then restoring the current state ? That should
> > work.
> 
> Thanks for the feedback.
> 
> If I understand correctly, I should try to disable the output.
> What is the 'output' exactly, the connector?

Yes, the output maps to the connector.

> How can I disable it? Can you give me some pointers?

By creating a commit that disables it :-) Conceptually that's about
setting the same properties you would from userspace. Maybe look at
drm_atomic_helper_disable_all() to see if you can make a version that
operates on a single output.

> Further more, is disabling the "output" disable the whole path where the
> bridge is located?

It should yes.

> I mean, I need to power off/on the bridge and re-init it with its input DSI
> lines in LP11.

-- 
Regards,

Laurent Pinchart

