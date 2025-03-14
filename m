Return-Path: <linux-kernel+bounces-561400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ACFA61112
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F724628ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849161FECDB;
	Fri, 14 Mar 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U9zxT969"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611C18CBF2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955237; cv=none; b=Cg74p6H2k1lF22FVIH1ZmtuPH6i3r6cVtWAm59Zau2NoKyszuOdYxOL9fQf6GY5CqQC+ss8Y7dJWZIM5I0yIrNhtIs+dJglmmBmfL86TcINUYF9nfdIItV4tJzS98VSesHlaqFu7B7ajYZCMzgVpFAhJs44ecCSK1l0ywPpsfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955237; c=relaxed/simple;
	bh=W95j9UIlv8207+MurKTmxLydcqSGNVKErbuGKBkzKKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWnVWi5IZLzrVgrBX0fAD/aTm+nZTFTCwDNJJwdsbQCec4EVMSCpwKF3mB7AfsNpalstorqFMoZAfUX3uKm0Ub3mJIvXJDcnXgsZz/oocqHXHiebz0LA6XoJEZ9GfI/iq465kmB6KTukgo5XWpwMPXbc7rr+0kGVpMxYL/VpSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U9zxT969; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E543442ED;
	Fri, 14 Mar 2025 12:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741955232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWos/lt+uMlzaLTSvHgq990LURjtMSjT7rOx+Xb5F2I=;
	b=U9zxT969s4vNZP+vaN0mLnyNm5VXd5KZq658rtO0Ev9Lihaa8hN1VRPWmzZxgT9itdelyF
	sl9VVkzd1LQFs1pQeRdrcOXwmCzdczSzGXhiNoQzHygLLM11iQAaNxIyGUoi5ayWE3hMR3
	jq8rbExdmaNQYpfjGD8HvHtin3gmr7vUT9iPsaHjF6ATc6rMLo3OFrNchGm9Ggz7p5x36G
	z5MeVrY2m3jKCR7BvX0mSggNa/7Pt163aEI0voJQJwv+W5qbod50h/W9Z1BrjGupXbo5AV
	6lkbewIQy4wY6lCuR8iU7V7pcBxUAVKM1toQodne7cGlNEU8oEugfM0FNVQyZg==
Date: Fri, 14 Mar 2025 13:27:09 +0100
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
Message-ID: <20250314132709.16a38692@booty>
In-Reply-To: <CAN9Xe3TeKTZtcMPtae7h33H=B-veGW93z8nMpHK+pEuNdh4=2A@mail.gmail.com>
References: <20250312-drm-panel-v1-0-e99cd69f6136@redhat.com>
	<20250312-drm-panel-v1-1-e99cd69f6136@redhat.com>
	<20250313110944.1c1f7e4e@booty>
	<CAN9Xe3TeKTZtcMPtae7h33H=B-veGW93z8nMpHK+pEuNdh4=2A@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrshhrihhvrghtshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehquhhit
 ggpjhgvshhsiihhrghnsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Anusha,

On Thu, 13 Mar 2025 16:34:45 -0400
Anusha Srivatsa <asrivats@redhat.com> wrote:

> > > +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t  
> > offset,  
> > > +                          const struct drm_panel_funcs *funcs)
> > > +{
> > > +     void *container;
> > > +     struct drm_panel *panel;
> > > +     int err;
> > > +
> > > +     if (!funcs) {
> > > +             dev_warn(dev, "Missing funcs pointer\n");
> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> > > +
> > > +     container = kzalloc(size, GFP_KERNEL);
> > > +     if (!container)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     panel = container + offset;
> > > +     panel->container_offset = offset;
> > > +     panel->funcs = funcs;
> > > +     kref_init(&panel->refcount);
> > > +
> > > +     err = devm_add_action_or_reset(dev, drm_panel_put_void, panel);
> > > +     if (err)
> > > +             return ERR_PTR(err);
> > > +
> > > +     drm_panel_init(panel, dev, funcs, panel->connector_type);  
> >
> > panel->connector_type here is uninitialized. You are passing
> > panel->connector_type to drm_panel_init(), which will then copy it into
> > panel->connector_type itself.
> >
> > So you mean I pass connector_type from the driver calling the helper, so  
> there is access to the connector type here?

I'm not a panel expert, but I think it makes sense that to create the
panel you need to know the connection type, and that is what Maxime
suggested.

> > > +     /**
> > > +      * @container_offset: Offset of this struct within the container
> > > +      * struct embedding it. Used for refcounted panels to free the
> > > +      * embeddeing struct when the refcount drops to zero.
> > > +      */
> > > +     size_t container_offset;  
> >
> > While storing the offset obviously works, and that's what I had
> > implemented in my latest bridge refcounting series, after some
> > discussion with Maxime we agreed storing a container pointer instead of
> > the offset is cleaner. I think it would be good here as well.
> >
> > See:
> > https://lore.kernel.org/lkml/20250227-macho-convivial-tody-cea7dc@houat/
> >  
> 
> so just void *container instead of size_t container_offset.

Exactly. You can have a look at the patch I sent earlier today:
https://lore.kernel.org/lkml/20250314-drm-bridge-refcount-v7-2-152571f8c694@bootlin.com/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

