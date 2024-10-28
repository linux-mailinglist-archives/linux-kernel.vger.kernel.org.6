Return-Path: <linux-kernel+bounces-384432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BB9B2A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22E51F20595
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190518FDA9;
	Mon, 28 Oct 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vd3Deyy8"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3B8472;
	Mon, 28 Oct 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103217; cv=none; b=KmFY+t68CoMMZzbsK3tzjU9Y8oGfeFooDflHTA27+NG3DsFDFBx7PDQPjI0xlk0UHPQP3qCtu2+NoX7w3mDkcS/SKjA0Ix57o336+aj1I8J29RQzn4pxH/htkMNLyxW8icUJfw9Qu8OdbudNUkcL3PZZtAHS07p4SRuvyXMqcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103217; c=relaxed/simple;
	bh=MNH+2CCeJjB+cw62GkUvxpkynf/ch6xltva3NsWETQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVrFgv/lNK4hhekWcVJRe/hHuBJt9MmnjIzhHwu/5Dgchm1yZv1N5mH37PjtY2ZI7O20SwK+0+4n59qRe/1hHD8RpXfyRfdhwvVfErmEse/1sFsQXdhqboMyi2FCrvbVv31mcnbt8oDIdCqo0zpIdcdDbVeDpw02afFAFJ6YZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vd3Deyy8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EDF01BF203;
	Mon, 28 Oct 2024 08:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730103213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftAOobpcZtzREeqCUhcS3Bfuff8MNGFDmOerJINyz3M=;
	b=Vd3Deyy840DvizNWpyDBvqibEFEkpd4AH+xicihGDAQA60P8hMm0HHdtxC6zbGcY+186/d
	aNMY/TrPzeMgXvQEova4qJvpmyMrP7DRpIzcenWvcZSEaJNbcrEf8aZDFl0gYdRgu6mFGZ
	zFCSOuswcdp5zB6nMvRaDHQfW5jbzzD1b8ji10pPbpcljnsuvTAIiwzjM+7+TpcOugDW3r
	hj+8aloU7gBSbVilWF2AbDd3V4epwnhjmkdNdnw+CEPN7cwL111wBjEgdW5uR6a2yt0pYR
	TeRYFFnXQt8nZjuPMQluPrb6TpjTIK7UZUxGn00pX1QSk55TNCfK7URTRvOWUw==
Date: Mon, 28 Oct 2024 09:13:31 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241028091331.6f67e29e@bootlin.com>
In-Reply-To: <20241027162350.GA15853@pendragon.ideasonboard.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
	<20241024095539.1637280-3-herve.codina@bootlin.com>
	<20241027162350.GA15853@pendragon.ideasonboard.com>
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

Hi Laurent,

On Sun, 27 Oct 2024 18:23:50 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

[...]
> > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > +{
> > +	struct drm_device *dev = sn65dsi83->bridge.dev;
> > +	struct drm_modeset_acquire_ctx ctx;
> > +	struct drm_atomic_state *state;
> > +	int err;
> > +
> > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > +	 * operation done in drm_atomic_helper_resume() but without releasing
> > +	 * the lock between suspend()/resume()
> > +	 */
> > +
> > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > +
> > +	state = drm_atomic_helper_duplicate_state(dev, &ctx);
> > +	if (IS_ERR(state)) {
> > +		err = PTR_ERR(state);
> > +		goto unlock;
> > +	}
> > +
> > +	err = drm_atomic_helper_disable_all(dev, &ctx);
> > +	if (err < 0)
> > +		goto unlock;
> > +
> > +	drm_mode_config_reset(dev);
> > +
> > +	err = drm_atomic_helper_commit_duplicated_state(state, &ctx);  
> 
> Committing a full atomic state from a bridge driver in an asynchronous
> way seems quite uncharted territory, and it worries me. It's also a very
> heavyweight, you disable all outputs here, instead of focussing on the
> output connected to the bridge. Can you either implement something more
> local, resetting the bridge only, or create a core helper to handle this
> kind of situation, on a per-output basis ?

A full restart of the bridge (power off/on) is needed and so we need to
redo the initialization sequence. This initialization sequence has to be
done with the DSI data lanes (bridge inputs) driven in LP11 state and so
without any video stream. Only focussing on bridge outputs will not be
sufficient. That's why I brought the pipeline down and restarted it.

Of course, I can copy/paste sn65dsi83_reset_pipeline() to a core helper
function. Is drm_atomic_helper_reset_all() could be a good candidate?

Best regards,
Hervé

