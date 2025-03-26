Return-Path: <linux-kernel+bounces-576719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6345A71399
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005E718934B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBE1ABEAC;
	Wed, 26 Mar 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KUZ+ho6a"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254B1A840A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980992; cv=none; b=U68WpLny+luM2h9FU7fM/zx1daLnfNPRENsDnIzGeTt7nz3S/TWvYmo0sA/3v63rpqnS4IuCFuFswezzq72lc92zh20SLi6dRlOL0V3OmDppiGjhWH3gM0JSyYwbY01dIIpZZBw6OCYSF3mrMYuyIbs56kMcZOQDc13njAJUysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980992; c=relaxed/simple;
	bh=a1yTbMw4lHwOX8EKQUFuIMkDpiEYl3gCY4US2ZZclys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSJNF2lUhV6qLH2Y+7qZY1WpXt8PCKvbA9VdDw7jegDOjPOmGZnrwwwOP+3THRIYgwV/F1TGPps6eRKXT/1pEE8G4oQ92eS89rF5ejoILNAR83fBc6uZFck/uLw++MUcZ4JnszpEuiSk/CnT58cGdip6Old50UqbUp99/PYj+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KUZ+ho6a; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A919433F0;
	Wed, 26 Mar 2025 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742980982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rDx2fSJy3Ms3G00Il013uPyrptL0oa5bj9agKMtWMM=;
	b=KUZ+ho6aGeehjv9NG29fFrcshfuYBqofKIemxDQRrRTtkp4I3fB3x9pNMQ8EwnYcN0oNYJ
	TVTQySZwOnB7PvAjIjz2X1CFC6IRNScDQA82WSDuQu7wYu806PG56N/bczmh9xyPkzvwdb
	8LyRj+BMu7w5BEeNl/rW2WeorXASf46PpYp44qU5psIifx/jrIHTRrTXn3mGuUIviYum5T
	Pzd5PAFfGBPLS14Nn3YufCxU8qFPgElH3Yejh6Aw5wkIzpTpE7nbTHBa8Lb3D/ygyiUd1/
	65Vhyqdp15eDe+tyOGwaXpi17x9tfnLAdcbIrBqEYw65Z1JSzZIM7cMa1nDVzg==
Date: Wed, 26 Mar 2025 10:22:59 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/panel: Add new helpers for refcounted panel
 allocatons
Message-ID: <20250326102259.3bdbc22d@booty>
In-Reply-To: <20250325-b4-panel-refcounting-v1-1-4e2bf5d19c5d@redhat.com>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
	<20250325-b4-panel-refcounting-v1-1-4e2bf5d19c5d@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhui
 hgtihhntgdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Anusha,

On Tue, 25 Mar 2025 13:24:08 -0400
Anusha Srivatsa <asrivats@redhat.com> wrote:

> Introduce reference counted allocations for panels to avoid
> use-after-free. The patch adds the macro devm_drm_bridge_alloc()
> to allocate a new refcounted panel. Followed the documentation for
> drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
> implementations for this purpose.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

[...]

> +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
> +			     const struct drm_panel_funcs *funcs,
> +			     int connector_type);
> +
> +/**
> + * devm_drm_panel_alloc - Allocate and initialize an refcounted panel
                                                     ^^
"a refcounted panel"

> + * @dev: struct device of the panel device
> + * @type: the type of the struct which contains struct &drm_panel
> + * @member: the name of the &drm_panel within @type
> + * @funcs: callbacks for this panel
> + * @connector_type: connector type of the driver

I'd say it's the connector type in the hardware, rather than of the
driver (the driver follows what is in the hardware. Maybe you can just
copy the description present in the drm_panel_init kdoc:

 * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
 *      the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)

Other than that it looks good!

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

