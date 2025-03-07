Return-Path: <linux-kernel+bounces-550980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A33A5669B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7605A161B89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660621C161;
	Fri,  7 Mar 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETBkZftx"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FD21B9C1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346551; cv=none; b=SWInv5ovS4f6klGaJG1qFU29hIoVOidMEVDhv2+c359QKldW2Xx47DGmNVc+/yn4tA2uvAYx30wdCZp3GRzJF2ljtDdXK4nRoTqk/PMnJ25/gv4laZa5DvmJOjx2dAGkiGZKutnmCPJ2aT7aKNb+WfSsYxCxglhjnrlT9ZhxF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346551; c=relaxed/simple;
	bh=retfJEUproaIVtJ0aph8p5peNEwjzc8GVxcXOdXFmYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg5FaMYtr6uuvJKDxfHKECsEQ3cJQJPLVQSyUxn6F4y6oVjRokj9U9AMdJzUb0+5Hb9jIfBwH06ESyH4aNbn4ExIRTHr9QRtgqvazkgIRx9f+/25I6gkXzAN9gT4SFtjfB/9xkd3sYY1anIOdZxi8flIfi2cOavdly81H3YJnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETBkZftx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EEB6204CF;
	Fri,  7 Mar 2025 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741346542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxndagyuSyQnITMEU+TwaPzjTPF9RLgN9Xn4fVO+J9w=;
	b=ETBkZftxNSRbSCpnvNJLgZCm6uYH7wRURKZQ53twEq6VPZdqG0co4DxFgBVVPcF6BJlGvj
	bk7PB5Df6DrUhFLDgeLxBLR7A3/ZVV2rPzXRI8TTS+NQ+wL+lzhwXSPIGQfcUzpPiSK+BU
	s1cbWckhlm/xi9DsRcEhCXw40G/3A7vOfn3JHEhr+AE93+4yElMHjMAog7Vx+EsBHlWFrf
	bee6DHHWKcluIZe0gOIvaEPcYo515jiyku5XJhHEWRxvZlZp++XDi3fzwQsuc/m12TqZp9
	DeG189CBmwiN0m1y/nlP3+ZZMJ1AZi9cwnaUvr3L2+Sfu5MHaIycBDAVloJMzA==
Date: Fri, 7 Mar 2025 12:22:17 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: imx8qxp-ldb: cleanup return value
Message-ID: <20250307122217.158b24d6@booty>
In-Reply-To: <71c44221-b18b-4928-8faf-00893ec4a109@nxp.com>
References: <20250306-drm-two-ldb-improvements-v1-0-f139d768b92c@bootlin.com>
	<20250306-drm-two-ldb-improvements-v1-1-f139d768b92c@bootlin.com>
	<71c44221-b18b-4928-8faf-00893ec4a109@nxp.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepvhhitghtohhrrdhlihhusehngihprdgtohhmpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrr
 hhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Liu,

On Fri, 7 Mar 2025 14:42:12 +0800
Liu Ying <victor.liu@nxp.com> wrote:

> On 03/07/2025, Luca Ceresoli wrote:
> > 'ret' can only be 0 at this point, being preceded by a 'if (ret) return
> > ret;'. So return 0 for clarity.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > index 7bce2305d676714cdec7ce085cb53b25ce42f8e7..bee1c6002d5f84dc33b6d5dc123726703baa427e 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > @@ -665,7 +665,7 @@ static int imx8qxp_ldb_probe(struct platform_device *pdev)
> >  
> >  	ldb_add_bridge_helper(ldb, &imx8qxp_ldb_bridge_funcs);
> >  
> > -	return ret;
> > +	return 0;  
> 
> I guess this is not the only place across the kernel tree where this cleanup
> could be done.  So, maybe use some tools to cleanup them all?

I had stumbled upon this as I was doing some changes to this function,
and needed to understand the code flow. Definitely 'ret 0' would have
made it  immediately clear that all the code between the last 'if (ret)
return ret;' and the final 'return ret' is not allowed to fail.

I think this change would (slightly, but still) improve future readers'
life.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

