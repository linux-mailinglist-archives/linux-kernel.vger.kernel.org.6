Return-Path: <linux-kernel+bounces-396104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA19BC7DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F72F1C22389
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2B1CCEC9;
	Tue,  5 Nov 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W3XftrgP"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222871CCB44;
	Tue,  5 Nov 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794511; cv=none; b=UfAqK4ZVkhlq5X5yqUW4q4KvMWGlfBJlYbRQmMOqKmRDD3DHgI9RYha00X58CUzU/kvfhLHD2zeMtJ+aE/FxCm/fKlyQtny0NVtsSSpfucDa7lNRrNSMOhr3Z6PdTdQcbIbstBhTC8zQjOwvjFCOxp1qFQbvoq/V4WG6gFdNw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794511; c=relaxed/simple;
	bh=fYWyjnHf/uL70wpODMk6x39rt5fx0lWWLPlSH3nu71E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGZNaeI9RKgV8bl4mof2f5jqlI01i8dAq8jDZBOCLXKQmxnrXvmQHGh669jtc8Mko1Sns6rWQHtDKjDwvua9qxBvoE6NoiHABTq6OdA5YxdWafEz/AbKyjX4EYYVVJkI7vDg6Yo7K8pnCD7+1a+57wIBMuDYQPZvaZTHdx4xBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W3XftrgP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7156C1BF203;
	Tue,  5 Nov 2024 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730794506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ca33zuGwKc/TbJFgjCMVbMBjtlcpXKFtBS6UyUFQZLk=;
	b=W3XftrgP6+DRXeawkAxWFeub2HOvaBi4/cqGthwJk/k0H7dhRZOxkWzoTt2Tf8U/AejxG7
	D9HHEp/3Cy3p2gavw77i4D2i+vGhZkRm9NxwFI9kZpseCPI7ZG5ZESBZ+TteCYlGZyOfJ8
	X0JJwxB5l0qRA2apYixLCQKoPKGSrEdbSM9TeRN8mDMverce6WERW2If7AIwx9Jw+mWwDF
	mpsiIFA6XqjtJfb9akTcFFlbA5/C5XJxLibt3QnTKZ7oGonVgma2JufoLU0Wc5EvJfjjBR
	DZW3PUujGAyCrY9shulkPZHBoNfMMeELax/kQme0AZqz/LirUdUVNig+1gm7nA==
Date: Tue, 5 Nov 2024 09:15:03 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut
 <marex@denx.de>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241105091503.48f69586@bootlin.com>
In-Reply-To: <20241028140913.GG6081@pendragon.ideasonboard.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
	<20241024095539.1637280-3-herve.codina@bootlin.com>
	<20241027162350.GA15853@pendragon.ideasonboard.com>
	<20241028091331.6f67e29e@bootlin.com>
	<20241028112857.GF24052@pendragon.ideasonboard.com>
	<20241028-nebulous-yellow-dragon-2cfb5f@houat>
	<20241028132858.GE6081@pendragon.ideasonboard.com>
	<20241028-great-charming-flounder-23fc9b@houat>
	<20241028140913.GG6081@pendragon.ideasonboard.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Maxime, Laurent,

On Mon, 28 Oct 2024 16:09:13 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Mon, Oct 28, 2024 at 02:55:47PM +0100, Maxime Ripard wrote:
> > On Mon, Oct 28, 2024 at 03:28:58PM +0200, Laurent Pinchart wrote:  
> > > On Mon, Oct 28, 2024 at 01:21:45PM +0100, Maxime Ripard wrote:  
> > > > On Mon, Oct 28, 2024 at 01:28:57PM +0200, Laurent Pinchart wrote:  
> > > > > On Mon, Oct 28, 2024 at 09:13:31AM +0100, Herve Codina wrote:  
> > > > > > On Sun, 27 Oct 2024 18:23:50 +0200 Laurent Pinchart wrote:
> > > > > > 
> > > > > > [...]  
> > > > > > > > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > > > > > > > +{
> > > > > > > > +	struct drm_device *dev = sn65dsi83->bridge.dev;
> > > > > > > > +	struct drm_modeset_acquire_ctx ctx;
> > > > > > > > +	struct drm_atomic_state *state;
> > > > > > > > +	int err;
> > > > > > > > +
> > > > > > > > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > > > > > > > +	 * operation done in drm_atomic_helper_resume() but without releasing
> > > > > > > > +	 * the lock between suspend()/resume()
> > > > > > > > +	 */
> > > > > > > > +
> > > > > > > > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > > > > > > > +
> > > > > > > > +	state = drm_atomic_helper_duplicate_state(dev, &ctx);
> > > > > > > > +	if (IS_ERR(state)) {
> > > > > > > > +		err = PTR_ERR(state);
> > > > > > > > +		goto unlock;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	err = drm_atomic_helper_disable_all(dev, &ctx);
> > > > > > > > +	if (err < 0)
> > > > > > > > +		goto unlock;
> > > > > > > > +
> > > > > > > > +	drm_mode_config_reset(dev);
> > > > > > > > +
> > > > > > > > +	err = drm_atomic_helper_commit_duplicated_state(state, &ctx);    
> > > > > > > 
> > > > > > > Committing a full atomic state from a bridge driver in an asynchronous
> > > > > > > way seems quite uncharted territory, and it worries me. It's also a very
> > > > > > > heavyweight, you disable all outputs here, instead of focussing on the
> > > > > > > output connected to the bridge. Can you either implement something more
> > > > > > > local, resetting the bridge only, or create a core helper to handle this
> > > > > > > kind of situation, on a per-output basis ?  
> > > > > > 
> > > > > > A full restart of the bridge (power off/on) is needed and so we need to
> > > > > > redo the initialization sequence. This initialization sequence has to be
> > > > > > done with the DSI data lanes (bridge inputs) driven in LP11 state and so
> > > > > > without any video stream. Only focussing on bridge outputs will not be
> > > > > > sufficient. That's why I brought the pipeline down and restarted it.  
> > > > > 
> > > > > Fair point.
> > > > >   
> > > > > > Of course, I can copy/paste sn65dsi83_reset_pipeline() to a core helper
> > > > > > function. Is drm_atomic_helper_reset_all() could be a good candidate?  
> > > > > 
> > > > > The helper should operate on a single output, unrelated outputs should
> > > > > not be affected.  
> > > > 
> > > > Also, you don't want to reset anything, you just want the last commit to
> > > > be replayed.  
> > > 
> > > I'm not sure about that. If the last commit is just a page flip, that
> > > won't help, will it ?  
> > 
> > The alternative would be that you start anew with a blank state, which
> > effectively drops every configuration that has been done by userspace.
> > This is terrible.
> > 
> > And a page flip wouldn't have affected the connector and
> > connector->state would still be to the last state that affected it, so
> > it would work.  
> 
> Ah right, you didn't mean replaying the last commit then, but first
> disabling the output and then restoring the current state ? That should
> work.
> 

Thanks for the feedback.

If I understand correctly, I should try to disable the output.
What is the 'output' exactly, the connector?
How can I disable it? Can you give me some pointers?

Further more, is disabling the "output" disable the whole path where the
bridge is located?
I mean, I need to power off/on the bridge and re-init it with its input DSI
lines in LP11.

Best regards,
Hervé

