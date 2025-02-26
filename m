Return-Path: <linux-kernel+bounces-534139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D92A46349
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2663B1888
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C93221724;
	Wed, 26 Feb 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YVmqFcjk"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF321D3FE;
	Wed, 26 Feb 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580972; cv=none; b=kwHM3vWvW4A3NPsH2r5Lo6jR7+SZafK7nnnNqlOCPGRRPTuYJHPFlK7vWMo9ZVNYHpppoUb0eC+TVTjKIbk6rEy1Gm2SiQpmhmobJMI/xAZnjM8Tjbvxr6qGDP64LL+UVktCkZzTiRsqG5VphLLJyR+R2Dg38g9HCH1FWzLhO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580972; c=relaxed/simple;
	bh=L80fYVFGV8j/KWuiRZ66wUrLJVUXLJ2i31oOoMautDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyEgVsIK7rb8JpqwXT4p/DzgOX6y0nMOQ6B5Yt4F5dFVeN1k7zfh8TIIwPCR+h4L45ZqJdraXhtXE5nGqZhN20AqEcgWPYGLk3zreW8NnSKKMwhVj8v1ZdixQLsKieV/xjNb3b6rZxxu19Py2n0vxh24nnEz/WSmNNavL8PYJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YVmqFcjk; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id B39B558146B;
	Wed, 26 Feb 2025 14:28:27 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85F5844279;
	Wed, 26 Feb 2025 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740580100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srlQpvYJmp4WGJbQ2gOhstlghcIxLLDbBOH3Hms1G1E=;
	b=YVmqFcjk0U4E+e7zKuj6Rpt4rxnNlmQ/mknWE7cS2QlmyRYYG1pX0skomC3EzGSFK0+D0F
	LofQCcAcczK0rToLqkgTL6IcBlrchx6Td+Em78I4vSLNbZiWK81HGy3XvZ4r9UK2BY2m+s
	t4y9WnK03LesL2wCljRBBavDBr7cQcUGTVz+SqalkLwcf72W6+PuUyj9YfmeNtygDQ7AL2
	mQM1gdT5t/e1zEh2tTHsacPJtCQUZfENXAk/U235HEbS8uFItYZ5vSwAM2o94jAhPbDzwS
	EC5ezudhpnVxZ2B1Yw5qFD9iXvELunSAI9SqyWyf+7aI5kLws9yeteiVn2k+6w==
Date: Wed, 26 Feb 2025 15:28:13 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, Jagan
 Teki <jagan@amarulasolutions.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Paul Kocialkowski
 <contact@paulk.fr>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, =?UTF-8?B?SGVy?=
 =?UTF-8?B?dsOp?= Codina <herve.codina@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
Message-ID: <20250226152813.4a1ad218@booty>
In-Reply-To: <20250211-merciful-nyala-of-justice-a4fabb@houat>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
	<20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
	<20250207-ingenious-daffodil-dugong-51be57@houat>
	<20250210181252.5ee028d4@booty>
	<20250211-merciful-nyala-of-justice-a4fabb@houat>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefjedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepihhnkhhirdgurggvsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepj
 hgrghgrnhesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Tue, 11 Feb 2025 14:10:50 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Mon, Feb 10, 2025 at 06:12:52PM +0100, Luca Ceresoli wrote:
> > Hello Maxime,
> > 
> > On Fri, 7 Feb 2025 12:47:51 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:
> >   
> > > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > > > index ad7ba444a13e5ecf16f996de3742e4ac67dc21f1..43cef0f6ccd36034f64ad2babfebea62db1d9e43 100644
> > > > --- a/include/drm/drm_bridge.h
> > > > +++ b/include/drm/drm_bridge.h
> > > > @@ -31,6 +31,7 @@
> > > >  #include <drm/drm_encoder.h>
> > > >  #include <drm/drm_mode_object.h>
> > > >  #include <drm/drm_modes.h>
> > > > +#include <drm/drm_print.h>
> > > >  
> > > >  struct device_node;
> > > >  
> > > > @@ -863,6 +864,22 @@ struct drm_bridge {
> > > >  	const struct drm_bridge_timings *timings;
> > > >  	/** @funcs: control functions */
> > > >  	const struct drm_bridge_funcs *funcs;
> > > > +
> > > > +	/**
> > > > +	 * @container_offset: Offset of this struct within the container
> > > > +	 * struct embedding it. Used for refcounted bridges to free the
> > > > +	 * embeddeing struct when the refcount drops to zero. Unused on
> > > > +	 * legacy bridges.
> > > > +	 */
> > > > +	size_t container_offset;    
> > > 
> > > This shouldn't be in there. You can create an intermediate structure and
> > > store both pointers for the action to consume.  
> > 
> > You mean to store container_offset + refcount + is_refcounted?  
> 
> No, I meant for the private structure pointer and the drm_bridge
> pointer. refcount should be in drm_bridge, and I think is_refcounted
> should be dropped.

Storing the container pointer instead of the offset is a good idea, it
will allow to get rid of is_refcounted: drm_bridge_is_refcounted() can
just return "container != NULL" instead of "bridge->is_refcounted". So
far so good.

I'm not sure about the intermediate struct you have in mind though.

Do you mean:

struct drm_bridge_pointers {
    struct drm_bridge *bridge;
    void              *container;
}

?

If that's what you mean, should it be embedded in drm_struct or
allocated separately?

If you mean to embed that struct in drm_bridge, then I the drm_bridge
pointer inside the intermediate struct would be useless.

If instead you mean to embed it in drm_struct: I'm not sure I see much
benefit except maybe not exposing the container pointer to drm_bridge
users, but I see a drawbacks: at the last put we need to find the
container pointer to free from a struct kref pointer, which can work
only if the container pointer is in the same struct as struct kref.

Additionally, the consuming action for that struct just needs a
drm_bridge pointer:

     static void drm_bridge_put_void(void *data)
     {
	struct drm_bridge *bridge = (struct drm_bridge *)data;

	drm_bridge_put(bridge);
     }

Can you clarify this? I'd love to have this cleanup in the next
iteration.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

