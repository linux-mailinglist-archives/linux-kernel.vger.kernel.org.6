Return-Path: <linux-kernel+bounces-576721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BECA7139F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5481517806A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E91BD03F;
	Wed, 26 Mar 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KLu2vuse"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA741ACEC6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980995; cv=none; b=q0p/hdWWhFaHURA51DeAqGRgmWpz2Us+43IW9eavxb/f2QufcDCcM1v25nvZewFmU+NPdbgyqDgmUT8p80nXC+25enJnGYzWjmsd6lLrY0SftoW+Dxfkb+9PnWIbVfIlWCHxJEFsNXSMC9coVypGZsMPese4efOmH8381KhZhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980995; c=relaxed/simple;
	bh=fDEagyklU36acP9gWnzlOwhHIcNzCkAKnAd1SrSbpew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rblBqCaFp3w1DMgW9TJIITvXL5IXbnd0CqH89FIW8e9glRDLEKJ2riiH0iOUGhiK2tT1RSR+nX4KRBwWz4tDlGLhE24Xl8xx0P+QFTw8DyFDwZhJ5mdreXzuSz1Xfnm2FB9BpToHBThaV9xkjwDlxu6dIG3aEoMurQIBC6T2OmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KLu2vuse; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 566884341A;
	Wed, 26 Mar 2025 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742980986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsEyj+lTR3bdUdE++96P2r98RujtLyXQv06vTnGR8p4=;
	b=KLu2vuse3BgDkRGWJCGipYhivSvJ1dwKmjSCBREKhVNVvVY75CiZU6rOIByUexIPRPG0eC
	3QHPZlMeN/SBMMb74hwbCR8JnqJ74bKO4+YQNQmbzum9Fg2KSpmWOZY/TZHehv3fjk6a0j
	k1RPq+uoF3KosMgRfxi7ehli9J77pL3vijKfjYpLfhtL5qdDve3IZj6ubs1E9tjZsd1aNa
	GwwC1fFllKG6AZQb3705XmfVHjNwpYuhlO+FipY7evaD4yrUr9AbvsfH8+wQ6va1sVcfrQ
	DxcWwcJExrF2dL+7wty8DCwT9DQUJPw49fEDTV6Kk9zvDK+csegTkW39ZiTqzg==
Date: Wed, 26 Mar 2025 10:23:04 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/panel: Add refcount support
Message-ID: <20250326102304.49510630@booty>
In-Reply-To: <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
	<20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeeftdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeehffejffekudfhkeeklefgjeeuheekffelheejgfeijeehieelkedttdfhjedtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhui
 hgtihhntgdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-GND-Sasl: luca.ceresoli@bootlin.com

On Tue, 25 Mar 2025 13:24:09 -0400
Anusha Srivatsa <asrivats@redhat.com> wrote:

> Allocate panel via reference counting.
> Add _get() and _put() helper functions
> to ensure panel allocations are refcounted.
> Avoid use after free by ensuring panel is
> valid and can be usable till the last reference
> is put. This avoids use-after-free

"panel is valid and can be usable" is not totally correct. When there
are still references held, you ensure the panel struct is still
_allocated_, not necessarily valid and usable.

Minor nit: you are wrapping at less than 50 columns, which is a bit
tight. I think 75 is the expected value for wrapping.

> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

[...]

> +/**
> + * drm_panel_get - Acquire a panel reference
> + * @panel: DRM panel
> + *
> + * This function increments the panel's refcount.
> + *
> + */

Not sure it's mandatory, but documenting the returned value is good
practice , e.g.:

 * Returns:
 * Pointer to @panel.

> +/**
> + * drm_panel_put - Release a panel reference
> + * @panel: DRM panel
> + *
> + * This function decrements the panel's reference count and frees the
> + * object if the reference count drops to zero.
> + */
> +struct drm_panel *drm_panel_put(struct drm_panel *panel)
> +{
> +	if (!panel)
> +		return panel;
> +
> +	kref_put(&panel->refcount, __drm_panel_free);
> +
> +	return panel;

While this is using the same structure as my bridge work, I now realize
the _put() should probably not return the panel (or bridge) pointer, it
should just be a void function. The reason is the pointer might have
been freed when _put() returns (depending on the refcount) so that
pointer value might be dangling and whoever calls _put() must not use
that pointer anymore.

Other get/put APIs do this, e.g. of_node_get/put().

So I'm going to change drm_bridge_put() to return void, unless there
are good reasons to keep it and that I'm missing.

> @@ -280,7 +291,10 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
>   * @member: the name of the &drm_panel within @type
>   * @funcs: callbacks for this panel
>   * @connector_type: connector type of the driver
> - * The returned refcount is initialised to 1
> + *
> + * The returned refcount is initialised to 1. This  reference will
> + * be automatically dropped via devm (by calling
> + * drm_bridge_put()) when @dev is removed.
          ^^^^^^
"panel". Same in a few other places in this patch. Please search in all
this series in case there are more. It's easy to forget about replacing
some of those in the comments. :)

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

