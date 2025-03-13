Return-Path: <linux-kernel+bounces-559167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C0A5F04C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B9D3B13F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A3264630;
	Thu, 13 Mar 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ORHszdw8"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773971BC5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860598; cv=none; b=I1Abm2z2A2TCulZNh9e59eCVqe6WrxKg+6sFd8cA0QwTyOW7eaWNb0CA9r9+i5L6tq398AbZWkSYLa9FErf3J2pGXipUOeO5PMzUNh+ok78b7ZaWPg7WZZSo5OIJgAw+BsIo+UpdvmlpZtHHAFLorfmuDc14vLK58qFfH9Nn3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860598; c=relaxed/simple;
	bh=2n2JWRZkQ6HjWVLWCICIL5JKa4BIkWjiwytLOc8ZcmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNp/z31nFSZIX4GXCCDCnI7Gu4IYIWGMv2a85u7g3YU+yeSjf4XQM0Zb4hhRLoyqRuDuR+QbwGNmyfP5rj6eVI3jvfVHHIQefrOYvELSlK23LUlzqlRkNW8F37hqGptk8vU9szh1qTFYSPi7Rvx2vUimyidt0b7o9TjVyUFvHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ORHszdw8; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0D6E441FE;
	Thu, 13 Mar 2025 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741860588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHKf+FrIWyyMbY6E5gPIzrY6CJ467svl00OxGCD4cvw=;
	b=ORHszdw8DzNsFfh2eJlXKvCtI12+dhaGWa4XNvq6dLo7mQjOiHSvqGry/UtTYkthCdPIkg
	pGyCf0iExCLm7e9GZcGTzN6XC05ywIIrvTox2tC/QQ9MyF5XDBUI3UW2PbjtlqCZ8QiRuI
	5+rs5+KL7DqeauvxebaXmS4drTRBGnp+680onwTtS+ghg3hBJmTvfVzlOadv3hx1B50H1/
	OEqDdBFnhhY7aR2A+0/hefGzO4PHb2vTyJkx4xQ+bb61F6sa4s2rRkIzdGWL/KIx8zTs/P
	bnJZPqWI/iSbyH8aoCurTRNhnHua8chUV28AEJ7NO50HB3F5UiOzb6kO7rpS1g==
Date: Thu, 13 Mar 2025 11:09:44 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] drm/panel: Add new helpers for refcounted panel
 allocatons
Message-ID: <20250313110944.1c1f7e4e@booty>
In-Reply-To: <20250312-drm-panel-v1-1-e99cd69f6136@redhat.com>
References: <20250312-drm-panel-v1-0-e99cd69f6136@redhat.com>
	<20250312-drm-panel-v1-1-e99cd69f6136@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrshhrihhvrghtshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehquhhit
 ggpjhgvshhsiihhrghnsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Anusha,

On Wed, 12 Mar 2025 20:54:42 -0400
Anusha Srivatsa <asrivats@redhat.com> wrote:

> Introduce reference counted allocations for panels to avoid
> use-after-free. The patch adds the macro devm_drm_bridge_alloc()
> to allocate a new refcounted panel. Followed the documentation for
> drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
> implementations for this purpose.
> 
> Also adding drm_panel_get() and drm_panel_put() to suitably
> increment and decrement the refcount
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

I'm very happy to see the very first step of the panel rework mentioned
by Maxime see the light! :-)

This patch looks mostly good to me, and the similarity with my bridge
refcounting work is by itself reassuring.

I have a few notes, one is relevant and the others are minor details,
see below.

In the Subject line: s/allocatons/allocations/

[...]

> +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
> +			     const struct drm_panel_funcs *funcs)
> +{
> +	void *container;
> +	struct drm_panel *panel;
> +	int err;
> +
> +	if (!funcs) {
> +		dev_warn(dev, "Missing funcs pointer\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	container = kzalloc(size, GFP_KERNEL);
> +	if (!container)
> +		return ERR_PTR(-ENOMEM);
> +
> +	panel = container + offset;
> +	panel->container_offset = offset;
> +	panel->funcs = funcs;
> +	kref_init(&panel->refcount);
> +
> +	err = devm_add_action_or_reset(dev, drm_panel_put_void, panel);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	drm_panel_init(panel, dev, funcs, panel->connector_type);

panel->connector_type here is uninitialized. You are passing
panel->connector_type to drm_panel_init(), which will then copy it into
panel->connector_type itself.

> +
> +	/**
> +	 * @container_offset: Offset of this struct within the container
> +	 * struct embedding it. Used for refcounted panels to free the
> +	 * embeddeing struct when the refcount drops to zero.
> +	 */
> +	size_t container_offset;

While storing the offset obviously works, and that's what I had
implemented in my latest bridge refcounting series, after some
discussion with Maxime we agreed storing a container pointer instead of
the offset is cleaner. I think it would be good here as well.

See: https://lore.kernel.org/lkml/20250227-macho-convivial-tody-cea7dc@houat/

> +/**
> + * drm_panel_get - Acquire a panel reference
> + * @panel: DRM panel
> + *
> + * This function increments the panel's refcount.
> + *
> + */
> +static inline void drm_panel_get(struct drm_panel *panel)
> +{
> +

Remove empty line.

> +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
> +			     const struct drm_panel_funcs *funcs);
> +
> +/**
> + * devm_drm_panel_alloc - Allocate and initialize an refcounted panel

s/an/a/ -- same typo as in my bridge series so I'm fixing it in my
series as well :)

> + * @dev: struct device of the panel device
> + * @type: the type of the struct which contains struct &drm_panel
> + * @member: the name of the &drm_panel within @type
> + * @funcs: callbacks for this panel
> + *
> + * The returned refcount is initialised to 1

In my opinion it is important to clarify that the caller does not have
to explicitly call drm_panel_put() on the returned pointer, because
devm will do it. Without clarifying, a user might think they need to,
and that would result in an extra put, which would be a bug.

Adapting from [0], that would be:

 * The returned refcount is initialized to 1. This reference will be
 * automatically dropped via devm (by calling drm_panel_put()) when @dev
 * is removed.

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

