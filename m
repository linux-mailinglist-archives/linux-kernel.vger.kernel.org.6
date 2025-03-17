Return-Path: <linux-kernel+bounces-564424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B37A6549F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B7E1896500
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B0245038;
	Mon, 17 Mar 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d5YRz8HS"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0122417F8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223443; cv=none; b=AxbyY0W7NkNvrFWzMvIM2RfpVpYpTSHKf9AjfqA55xERTwt0MPuoEvjt1M81yJRxWP9ni9Ni5qWeA5FLAD6zdRhib0+e/4fU9mioW6zgfrg6O9GNan0F6V8h2Sr/iq3YNY/0tlxyqrMPYADhUVPmm9wvYy9nHRmER7oyNBNRxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223443; c=relaxed/simple;
	bh=KahH2BFzKy8K/En9Dg7Vn2VE/YObM+zuwkb7zQcGRxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLBwgcTKQwCgyjhPofiy1FZK6jECvpD7Z7H0HjZVrigejykde8UVHiVVHjDLVRBExrCRdFS9qXkz8AP3Tc784cisJMBKV9ryOITyqTzt3ogLO9/3jQR+uhMSZeU0yzPuUAq5mCNUEhwMrS9aSvMLBJzXQEgItN9wRU4kfVk5K/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d5YRz8HS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DD3B441B5;
	Mon, 17 Mar 2025 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742223433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TiX423mBFM8qXe3BKnP5N39kMu5CYkpjLnn2bYTEEK0=;
	b=d5YRz8HSm0HZdUtqDQdw8FIEIb3CfRMXBcpqaXQPcgtSJcJwgCRtMF/ovIx6w8TqAZWUJt
	LQVOlsrmiudnVIVAtu/k5Y5snjGuPCCEQbxy2klAm8+Z0h7dEqV/D8nkoICX57wwSsCZll
	lAgH6XOiR3VnUj+NSDACP2UbDQGMXS+CK5qas+di2FFuiVLwnwBKVC20rwb5hYQrQXWSgJ
	1hM6MAw82+ez1Iym6NgQByoSg1R1A7sRsdf7cgMk6mhrkgurKRNCzdf7cITOg6qbiaA0C9
	E1aUSxA0/ywLU4xMLINWGKrXyCenpSBFdeBhkbgO1Wpvr3x0nc6D0x1IBta26w==
Date: Mon, 17 Mar 2025 15:57:07 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Marek Vasut <marex@denx.de>, Stefan Agner
 <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Inki Dae <inki.dae@samsung.com>, Jagan
 Teki <jagan@amarulasolutions.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Anusha Srivatsa <asrivats@redhat.com>, Paul
 Kocialkowski <paulk@sys-base.io>, Dmitry Baryshkov <lumag@kernel.org>,
 =?UTF-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 05/11] drm/bridge: add a cleanup action for
 scope-based drm_bridge_put() invocation
Message-ID: <20250317155707.6d1055f1@booty>
In-Reply-To: <20250314-banana-toucanet-of-masquerade-8eeb4e@houat>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
 <20250314-drm-bridge-refcount-v7-5-152571f8c694@bootlin.com>
 <20250314-banana-toucanet-of-masquerade-8eeb4e@houat>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrr
 hhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

On Fri, 14 Mar 2025 19:08:22 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Fri, Mar 14, 2025 at 11:31:18AM +0100, Luca Ceresoli wrote:
> > Many functions get a drm_bridge pointer, only use it in the function body
> > (or a smaller scope such as a loop body), and don't store it. In these
> > cases they always need to drm_bridge_put() it before returning (or exiting
> > the scope).
> > 
> > Some of those functions have complex code paths with multiple return points
> > or loop break/continue. This makes adding drm_bridge_put() in the right
> > places tricky, ugly and error prone in case of future code changes.
> > 
> > Others use the bridge pointer in the return statement and would need to
> > split the return line to fit the drm_bridge_put, which is a bit annoying:
> > 
> >   -return some_thing(bridge);
> >   +ret = some_thing(bridge);
> >   +drm_bridge_put(bridge);
> >   +return ret;
> > 
> > To make it easier for all of them to put the bridge reference correctly
> > without complicating code, define a scope-based cleanup action to be used
> > with __free().
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > ---
> > 
> > This patch was added in v7.
> > ---
> >  include/drm/drm_bridge.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index 5c1e2b9cafb12eb429d1f5d3ef312e6cf9b54f47..a5accd64c364ebb57903ae1e7459034ad9ebf4f3 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -23,6 +23,7 @@
> >  #ifndef __DRM_BRIDGE_H__
> >  #define __DRM_BRIDGE_H__
> >  
> > +#include <linux/cleanup.h>
> >  #include <linux/ctype.h>
> >  #include <linux/list.h>
> >  #include <linux/mutex.h>
> > @@ -995,6 +996,9 @@ static inline struct drm_bridge *drm_bridge_put(struct drm_bridge *bridge)
> >  	return bridge;
> >  }
> >  
> > +/* Cleanup action for use with __free() */
> > +DEFINE_FREE(drm_bridge_put, struct drm_bridge *, if (_T) drm_bridge_put(_T))
> > +  
> 
> IIRC, drm_bridge_put already checks for the pointer being null before
> dereferencing it, right? Then we can probably simplify the macro here.

drm_bridge_put() does the NULL-check, yes. However I have kept the 'if'
here for consistency with all other DEFINE_FREE()s in the kernel which
also have an 'if' even when the called function does it as well.

Moreover, as per discussion after patch 2, in the next iteration I'm
moving drm_bridge_put() back to a an exported symbol instead of an
inline. So the 'if' here will save a useless function call on NULL.

For the two above reasons I'm rather inclined to keeping this line as
is.

> Either way,
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

