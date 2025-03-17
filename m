Return-Path: <linux-kernel+bounces-564425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2644A654A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062933A832B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B40248865;
	Mon, 17 Mar 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X29XjBsF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82167240608
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223461; cv=none; b=rPvvFX1eSO8QvRyvUCpd1hNY/0gh6jJ1ffKRk8sNK5vm+ctPI/+cH+dz9Fk1U07eJcD8M52vPGsnOI7SNM6b8bMudkTwcojJz92Gf7xi1Q7ocRoBOfJCBl++VpJJXm9nC+AevfsjC1ghMEwELLHf8T98q1XM0AAN2Z/pQH96M+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223461; c=relaxed/simple;
	bh=25KeBO3LinajIWSHJvuhTdoZgOpkTKqjJjTe7DGfM8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CviMfybce2CMfktgrXHeO/Tp0dLTXBam4fGINRVTuDMQIptuFdl5aeC6wuOVILjuI0p9jWDs4gwO4PQ6jp8MCyunW/6t46wbvSGId3y6biI2dS8BwpLz2qLh7tIJSbfivPSDp1jGcRShPJ0D7ghtPvOBsEOMlvdmqDy3kvSqizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X29XjBsF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7619344392;
	Mon, 17 Mar 2025 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742223455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkuh0DXp7wkpHA4U/hr9xccHxf9FKIYItr2z+4BB6U4=;
	b=X29XjBsFlNR58JFDPaXDWBtoy2+6wpXwLjV2W3cfhdB4282VWXOG529KYxBPs5pWRmlIIW
	u/TrZ78MytSw6ORQc1VrhWz/rwOCPypN7pYhSWRQXfLcBmgdwSiaQTe82xL1ENk6vJqJR7
	xS8abVRKrgePsPb37BG29GSWoGqMwFUvCaPKoQ8OaCTAyC3aXqgElZNlyKvCr96YaLBpdN
	xf/4Rl0IBl37YG6Y1bYieiEolFgJPieiJx8Hn9rEA7m3d2XezvYu1AzLmfBJagrJUDinJ3
	uRIQQhiNfFAEZV4sKFhKazELb0EAvzIrVrlu1pJaKi30UdKV84cTb1+gwQxzBg==
Date: Mon, 17 Mar 2025 15:57:30 +0100
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
Subject: Re: [PATCH v7 06/11] drm/bridge: get the bridge returned by
 drm_bridge_chain_get_first_bridge()
Message-ID: <20250317155730.4a328641@booty>
In-Reply-To: <20250314-aspiring-myrtle-husky-a5f4ac@houat>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
	<20250314-drm-bridge-refcount-v7-6-152571f8c694@bootlin.com>
	<20250314-aspiring-myrtle-husky-a5f4ac@houat>
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

On Fri, 14 Mar 2025 19:10:41 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Fri, Mar 14, 2025 at 11:31:19AM +0100, Luca Ceresoli wrote:
> > drm_bridge_chain_get_first_bridge() returns a bridge pointer that the
> > caller could hold for a long time. Increment the refcount of the returned
> > bridge and document it must be put by the caller.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

...

> > @@ -1112,8 +1115,8 @@ drm_bridge_get_prev_bridge(struct drm_bridge *bridge)
> >  static inline struct drm_bridge *
> >  drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
> >  {
> > -	return list_first_entry_or_null(&encoder->bridge_chain,
> > -					struct drm_bridge, chain_node);
> > +	return drm_bridge_get(list_first_entry_or_null(&encoder->bridge_chain,
> > +						       struct drm_bridge, chain_node));
> >  }  
> 
> We'll need to modify drm_bridge_get_next_bridge, drm_bridge_get_prev_bridge, and
> drm_for_each_bridge_in_chain in a similar manner, but for this one

Sure. I'm discussing this in the cover letter.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

