Return-Path: <linux-kernel+bounces-385044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8AF9B31B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8941C214E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599521DC18F;
	Mon, 28 Oct 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B6w6wwQL"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBD1DD0D4;
	Mon, 28 Oct 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122157; cv=none; b=g+EdyZt7yXxCZBVaQmbv358e30EdG3fQXa8ygmrQX9Er/asMDo5fchi/JFbLYYmQNwo3HmjxGzDBxBNE+lT4kYcPIUjRWOX6Gv+zWucl9qAEFZmpH6SneWFbADWd8fKS0Xmv0m7WfE3jfrDaQk0GW0Xw39fiE5DHpaKJDXd+CHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122157; c=relaxed/simple;
	bh=DMmxlKMEdktOdfKpfuiQaifeYi5aarkRCjz9qJVIe9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4J07SJ8QBO47GXcAbYl8H2N3/9ijBJFqZx0ifFXpKv6cE+dhVU/QzFRmLDXi+IbyVzlwpFpqnPpp3/njwrCBsbFkOvCgOdDDAsdmanPjVnVquc2s9NpimyGQk++aR6yXcP+1MCyXplzD7uLpCqsK/gtmyI3kCJjoPkUadViZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B6w6wwQL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEE4A10C4;
	Mon, 28 Oct 2024 14:29:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730122145;
	bh=DMmxlKMEdktOdfKpfuiQaifeYi5aarkRCjz9qJVIe9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6w6wwQLc0E4rqMCWKkKZ7Dca5bKw8TjNqztrfipdQMc54WB1levWCjgVTV3ySv8l
	 6BBx19QErgZeCCOlrIXHBRPqUL+ibZBMqwsX50P0H84nSGF3s3KrhKeJCqAhJ5DNAH
	 5yJoELKr+vtw6pW8WLP/pgor+D0mO6cSuTH4DjNM=
Date: Mon, 28 Oct 2024 15:28:58 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <20241028132858.GE6081@pendragon.ideasonboard.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <20241027162350.GA15853@pendragon.ideasonboard.com>
 <20241028091331.6f67e29e@bootlin.com>
 <20241028112857.GF24052@pendragon.ideasonboard.com>
 <20241028-nebulous-yellow-dragon-2cfb5f@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028-nebulous-yellow-dragon-2cfb5f@houat>

On Mon, Oct 28, 2024 at 01:21:45PM +0100, Maxime Ripard wrote:
> On Mon, Oct 28, 2024 at 01:28:57PM +0200, Laurent Pinchart wrote:
> > On Mon, Oct 28, 2024 at 09:13:31AM +0100, Herve Codina wrote:
> > > On Sun, 27 Oct 2024 18:23:50 +0200 Laurent Pinchart wrote:
> > > 
> > > [...]
> > > > > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > > > > +{
> > > > > +	struct drm_device *dev = sn65dsi83->bridge.dev;
> > > > > +	struct drm_modeset_acquire_ctx ctx;
> > > > > +	struct drm_atomic_state *state;
> > > > > +	int err;
> > > > > +
> > > > > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > > > > +	 * operation done in drm_atomic_helper_resume() but without releasing
> > > > > +	 * the lock between suspend()/resume()
> > > > > +	 */
> > > > > +
> > > > > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > > > > +
> > > > > +	state = drm_atomic_helper_duplicate_state(dev, &ctx);
> > > > > +	if (IS_ERR(state)) {
> > > > > +		err = PTR_ERR(state);
> > > > > +		goto unlock;
> > > > > +	}
> > > > > +
> > > > > +	err = drm_atomic_helper_disable_all(dev, &ctx);
> > > > > +	if (err < 0)
> > > > > +		goto unlock;
> > > > > +
> > > > > +	drm_mode_config_reset(dev);
> > > > > +
> > > > > +	err = drm_atomic_helper_commit_duplicated_state(state, &ctx);  
> > > > 
> > > > Committing a full atomic state from a bridge driver in an asynchronous
> > > > way seems quite uncharted territory, and it worries me. It's also a very
> > > > heavyweight, you disable all outputs here, instead of focussing on the
> > > > output connected to the bridge. Can you either implement something more
> > > > local, resetting the bridge only, or create a core helper to handle this
> > > > kind of situation, on a per-output basis ?
> > > 
> > > A full restart of the bridge (power off/on) is needed and so we need to
> > > redo the initialization sequence. This initialization sequence has to be
> > > done with the DSI data lanes (bridge inputs) driven in LP11 state and so
> > > without any video stream. Only focussing on bridge outputs will not be
> > > sufficient. That's why I brought the pipeline down and restarted it.
> > 
> > Fair point.
> > 
> > > Of course, I can copy/paste sn65dsi83_reset_pipeline() to a core helper
> > > function. Is drm_atomic_helper_reset_all() could be a good candidate?
> > 
> > The helper should operate on a single output, unrelated outputs should
> > not be affected.
> 
> Also, you don't want to reset anything, you just want the last commit to
> be replayed.

I'm not sure about that. If the last commit is just a page flip, that
won't help, will it ?

-- 
Regards,

Laurent Pinchart

