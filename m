Return-Path: <linux-kernel+bounces-532103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB21A448FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEAE3BC97D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04EB20B814;
	Tue, 25 Feb 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b1bgoAoK"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EF1A5BAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504989; cv=none; b=Y8KLbnEAY1M3x5SQjK6fNh/6ymOSkdeoVh+C+bOPwa9zi9G+UmrvGkn3roqJ7bcZa3Uyx3srqyw7LD/cFkxlVYDSQtW+NE/6Rdz+anHbONCdStdwBcga2I4NRB48BJLFCGqxJvDO5XQ1WX9p9Ha7u8aFdsaAGoc9YTayv+P9xcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504989; c=relaxed/simple;
	bh=wjyJdMeZ3XtiUqcsjPl3/9q8Gj0lBxCZzql4SD2VkA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNQC/fxPNdL/7M7XzyTC0wJ7ZgyDWLTgRnQ0UUMysOAar5ieEjwXl9atorKAWLfXqjFOuwiAStOxTjBq3DcF1lc4Nimxfsp8dbcDdMYypFg8AaMTVE4TErsHHqA5o/B4BuGrGOkWA4WJppxYLou6Xuhzomeno18BTTivhOOdZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b1bgoAoK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D72644327;
	Tue, 25 Feb 2025 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740504984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pET0nVdSZvklJ9U7JwmtwIZwaF754aOJaksS3akpOXw=;
	b=b1bgoAoKCCoulVZ/+hkYrikGXdLVW+PYWXdFsYAHmUtmv+7fXhORJWESQsS+FW0nXnWcJ4
	m+FzZnZGqmBhnovsC0Dm32A5o5yQGtniD1TYq95llftKOeKwLwaaUJk3NxWhV5jubYErLx
	IHq+CS6PHy2FbUxz0IJDJdCj//oiFw1PDdjbohLjWNSpVWtArHcfh2AxGA6GOvgpQZhOqn
	1/2RbLRMuDk+Tn5XV97FMznO0VKfG6rsibEbgUKMDyGyPOcOqG5iLFV37pR29WVy8Mg5n7
	qu6D/POsD6AZG4dvNeK1bI87bgOwT3hIPBe2HiSYA1igxbCl2uxGX/06g1wxFA==
Date: Tue, 25 Feb 2025 18:36:21 +0100
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
Message-ID: <20250225183621.6b33684b@booty>
In-Reply-To: <878qpu56cm.fsf@intel.com>
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
	<20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
	<878qpu56cm.fsf@intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhro
 hhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Jani,

On Tue, 25 Feb 2025 18:36:41 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> > In preparation to expose more info about bridges in debugfs, which will
> > require more insight into drm_bridge data structures, move the bridges_show
> > code to drm_bridge.c.
> >
> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> 
> I hate myself for doing this on a patch that's at v7... but here goes.

Please don't! :-) This patch is new in v7, and a different (and
definitely worse) approach was present in v6, but there was nothing
before.

> Perhaps consider moving the bridges debugfs creation and fops to
> drm_bridge.c instead of just adding
> drm_bridge_debugfs_show_encoder_bridges().
> 
> For example, add drm_bridge_debugfs_add(struct drm_encoder *encoder),
> which then contains the debugfs_create_file() call.

I think it should go in drm_encoder.c, not drm_bridge.c, right? Here we
are showing the bridges attached to an encoder, so the entry point is
each encoder.

On the other hand in patch 2 we should move the
drm_debugfs_global_add() code to drm_bridge.c, as it's showing bridges
ina encoder-independent way.

And finally drm_bridge should export the common
drm_bridge_debugfs_show_bridge() function to drm_encoder.c.

Do you think this is correct?

> Interestingly, this lets you drop a lot of #ifdef CONFIG_DEBUG_FS. The
> compiler optimizes the fops struct and the functions away when
> debugfs_create_file() becomes a stub for CONFIG_DEBUG_FS=n. It becomes
> all around cleaner.

This surely makes the idea interesting. Cleaner code is always welcome.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

