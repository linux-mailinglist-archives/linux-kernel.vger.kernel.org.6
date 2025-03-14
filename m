Return-Path: <linux-kernel+bounces-560911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0AA60AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57B7460706
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9D1A316D;
	Fri, 14 Mar 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fIoKFoKE"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566619F42D;
	Fri, 14 Mar 2025 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939893; cv=none; b=Mg1vyQcBy+Q3tU3/0ts7pZd0yrazbgeRLDsIPCqS1oReDfUg7dcnne2MVY5sMtc6CM+o4q48nQrAJPoquR4B8Ws9ZAGBezukqsWV2MyS7DfOzFSEqmGccxmjjP7YTUlbDKU0Jyn8EXnawxqPx+bjTCEzq1vkYkyhhB4932Nii1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939893; c=relaxed/simple;
	bh=wLR9kA7YRBMcXE+WRSSPf8qb6kdsUh2P55EgbJ5oQmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRPUfXnoxTwpyRI4fsgohpYO4gcVpt74ZBkAmAX+L7Ww9y46NNiWVSmN35/ADW+OLZYl8UELxZDbg0NRi0GiRb50wmXQugXifmu8mIdJg3zK+jrWuXCNvjZYpbxDRSSLySIx+s/V23xrpmSXLndgrASFAG8H9QmGowuY75qe2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fIoKFoKE; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39CB844166;
	Fri, 14 Mar 2025 08:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741939888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shPwwGXfHVuV1VEQPB00+dQj+dOnHg7agqnzcuOae+g=;
	b=fIoKFoKELP4821UfIVCOJ7r0oRx+ErLefYKp9XTh7WSH4cEVUWJiedNkCtFuxYms4hSMxu
	eERv4eaCRm7eD7vTzxbo2Yd5bpPbOXvkc8n7yoNaqR/GDSYlOh3ZY0Mx8ebCY7BAlbndwl
	nqqshu+8ScypJK0eDaRsnNPkAlXHe+LRax8aMccBkZiJXYcf78fa/sf3HpuSxb/Q36bK43
	EeepcpWqgGZZL1WGsf5AjGG+Xv2hXIhFvMlEdcdRP8Sb3c9HVSYIJgg7a/dMsNkABQaI8j
	pNdL7J5N3VFrE0/URRC9+BNzsRU1UslrHOsivGUh+9vbsKwQ8UbRq5kvRIBpeg==
Date: Fri, 14 Mar 2025 09:11:20 +0100
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
Message-ID: <20250314091120.366b5fd7@booty>
In-Reply-To: <20250313-flying-crab-of-diversity-fa1db0@houat>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
	<20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
	<20250207-ingenious-daffodil-dugong-51be57@houat>
	<20250313125656.70448d09@booty>
	<20250313-flying-crab-of-diversity-fa1db0@houat>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgdttddvmedusggrjeemgeekfhejmedulegtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgdttddvmedusggrjeemgeekfhejmedulegthedphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeejpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehinhhkihdruggrvgesshgrmhhsuhhnghdrtghomhdprhgtphhtt
 hhopehjrghgrghnsegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Maxime,

On Thu, 13 Mar 2025 19:07:17 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Thu, Mar 13, 2025 at 12:56:56PM +0100, Luca Ceresoli wrote:
> > Hello Maxime,
> > 
> > On Fri, 7 Feb 2025 12:47:51 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:  
> > > On Thu, Feb 06, 2025 at 07:14:29PM +0100, Luca Ceresoli wrote:  
> > > > DRM bridges are currently considered as a fixed element of a DRM card, and
> > > > thus their lifetime is assumed to extend for as long as the card
> > > > exists. New use cases, such as hot-pluggable hardware with video bridges,
> > > > require DRM bridges to be added and removed to a DRM card without tearing
> > > > the card down. This is possible for connectors already (used by DP MST), so
> > > > add this possibility to DRM bridges as well.
> > > > 
> > > > Implementation is based on drm_connector_init() as far as it makes sense,
> > > > and differs when it doesn't. A difference is that bridges are not exposed
> > > > to userspace, hence struct drm_bridge does not embed a struct
> > > > drm_mode_object which would provide the refcount. Instead we add to struct
> > > > drm_bridge a refcount field (we don't need other struct drm_mode_object
> > > > fields here) and instead of using the drm_mode_object_*() functions we
> > > > reimplement from those functions the few lines that drm_bridge needs for
> > > > refcounting.
> > > > 
> > > > Also add a new devm_drm_bridge_alloc() macro to allocate a new refcounted
> > > > bridge.
> > > > 
> > > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>    
> > > 
> > > So, a couple of general comments:
> > > 
> > > - I've said it a couple of times already, but I really think you're
> > >   making it harder than necessary for you here. This (and only this!)
> > >   should be the very first series you should be pushing. The rest can
> > >   only ever work if that work goes through, and it's already hard enough
> > >   as it is. So, split that patch into a series of its own, get that
> > >   merged, and then we will be able to deal with panels conversion and
> > >   whatever. That's even more true with panels since there's ongoing work
> > >   that will make it easier for you too. So the best thing here is
> > >   probably to wait.
> > > 
> > > - This patch really needs to be split into several patches, something
> > >   along the lines of:
> > > 
> > >   + Creating devm_drm_bridge_alloc()
> > >   + Adding refcounting
> > >   + Taking the references in all the needed places
> > >   + Converting a bunch of drivers  
> > 
> > After reading Anusha's "[PATCH RFC 0/2] drm/panel: Refcounted panel
> > allocation" [0] I think I need a clarification about the 4 steps you had
> > outlined in the above quoted text. Are you suggesting those are four
> > _series_, and you'd want to see a series only creating
> > devm_drm_bridge_alloc() as a first step, similarly to Anusha's work?
> > 
> > That was not my understanding so far, and so I've been working on a
> > series containing all 4 items, and it's growing very long due to item 3
> > needing to touch many dozen drivers which need to put a bridge (many
> > are identical oneliner patches though).  
> 
> I believe I've clarified it already in Anusha's series, but I think a

Yes, you have...

> reasonable series for *early* work would be the bullet points 1, 2, a
> bit of 3 and a bit of 4.

...but thanks for the extra clarification.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

