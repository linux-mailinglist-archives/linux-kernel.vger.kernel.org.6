Return-Path: <linux-kernel+bounces-533650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE2A45D34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF4618975DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F619CD16;
	Wed, 26 Feb 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Td3icDVM"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16604322A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569537; cv=none; b=tQLNult0Zi4Z8qT/R+9C5hScErX3dvoFpm+WlaQGjIefDW2abDj8DbrRo5j5y+2mv8uBvb8W3Uudsc1It4F/a8dpOxos/2yS8GNq0DX4rGdQJCVKf3ts/+1qMzzyOnfltUZvCfCmwSvO46Dx05ltZE8wc6sB1HSLgjIlQ0CIZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569537; c=relaxed/simple;
	bh=B+iJEktDwmaRqvtBpDBg1SuXWEYGg9GsOnpJDl+ds9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY6LULponnyH4qX+81PabIZSSqMFS5wswItHWs2qbkYVECYh7gv4PgRe48/4HBZz93Di6VjyeGVO8JZHG6DIaxtPlRHrJMq4/RgSTowxlemCKRirRCFCr8zQaOkwb1ELEFShM05SKUjUZqVIjknf2CQRNTPFucx+jStv+ourIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Td3icDVM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94DDA43427;
	Wed, 26 Feb 2025 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740569532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH5TLqPmHN4KHoh4+pmfs4/A09QxMx7XTAwVuGzjhTM=;
	b=Td3icDVMjfODTdz85wp+A9sqtpo5jnYcHFQiTsczw97eA0Q8BUpWznYBtWeKUOeZYI7u5h
	w26SzXlsnJZGs+H7yLiPOWaW1eSFh0mM8HXQDroR2XzUvIkwajVVEa3pWH6cPEXFpZvAx0
	jaeXR6YmzNVBkf7T95z2pRdlRRFnLKJZ8YkepVulLaKLtn1jb4BStR4ADeAInFJnrSSfyE
	GreRQUtd5snefUyi32TrLlJLWv9r2Yt7xBNJNUFGqMtnHO/Awy6zPovYDyvoa3CZCDU8dC
	MCmF4kUJi0m5fc7Glz5TYL4qtsvRqpqfti2/r///uSXpKyCADmpUnZc+Ee9d1g==
Date: Wed, 26 Feb 2025 12:32:08 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
Message-ID: <20250226123208.272e7766@booty>
In-Reply-To: <871pvl6g1t.fsf@intel.com>
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
	<20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
	<878qpu56cm.fsf@intel.com>
	<20250225183621.6b33684b@booty>
	<871pvl6g1t.fsf@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhro
 hhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Jani,

On Tue, 25 Feb 2025 20:21:50 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> > Hello Jani,
> >
> > On Tue, 25 Feb 2025 18:36:41 +0200
> > Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >  
> >> On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:  
> >> > In preparation to expose more info about bridges in debugfs, which will
> >> > require more insight into drm_bridge data structures, move the bridges_show
> >> > code to drm_bridge.c.
> >> >
> >> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>    
> >> 
> >> I hate myself for doing this on a patch that's at v7... but here goes.  
> >
> > Please don't! :-) This patch is new in v7, and a different (and
> > definitely worse) approach was present in v6, but there was nothing
> > before.
> >  
> >> Perhaps consider moving the bridges debugfs creation and fops to
> >> drm_bridge.c instead of just adding
> >> drm_bridge_debugfs_show_encoder_bridges().
> >> 
> >> For example, add drm_bridge_debugfs_add(struct drm_encoder *encoder),
> >> which then contains the debugfs_create_file() call.  
> >
> > I think it should go in drm_encoder.c, not drm_bridge.c, right? Here we
> > are showing the bridges attached to an encoder, so the entry point is
> > each encoder.  
> 
> I'm still thinking drm_bridge.c, because it's about bridges and their
> details. The encoder shouldn't care about bridge implementation details.

Ah, I think I now get what you mean.

Current code is:

drm_encoder_register_all()                             [drm_encoder.c]
 -> drm_debugfs_encoder_add                            [drm_debugfs.c]
   -> debugfs_create_file("bridges"...  &bridges_fops) [drm_debugfs.c]
                                    [bridges_fops is in drm_debugfs.c]

Moving the last 2 lines to drm_bridge.c and into a new function we'd
have:

drm_encoder_register_all()                             [drm_encoder.c]
 -> drm_debugfs_encoder_add [*]                        [drm_debugfs.c]
  -> drm_bridge_debugfs_add_encoder_bridges_file (NEW) [drm_bridge.c]
   -> debugfs_create_file("bridges"...  &bridges_fops) [drm_bridge.c]
                                    [bridges_fops is in drm_bridge.c]

Potentially [*] could be moved to drm_encoder.c, but that is not bridge
related and can be done as a future step.

Is this what you had in mind?

> > On the other hand in patch 2 we should move the
> > drm_debugfs_global_add() code to drm_bridge.c, as it's showing bridges
> > ina encoder-independent way.  
> 
> Agreed on that.
> 
> > And finally drm_bridge should export the common
> > drm_bridge_debugfs_show_bridge() function to drm_encoder.c.  
> 
> Disagree. That will still require the EXPORT and #ifdefs around
> CONFIG_DEBUG_FS.

With the above-sketched idea I agree we wouldn't need to export
drm_bridge_debugfs_show_bridge().

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

