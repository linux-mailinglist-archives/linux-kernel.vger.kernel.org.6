Return-Path: <linux-kernel+bounces-571789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1844A6C24C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774B91B616E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0BB22FDF0;
	Fri, 21 Mar 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M2+aLmXC"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3F22D7B8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581307; cv=none; b=PUIxsFUPgmQByGOmD0gsnUIZMfCfdqdyG4EqZjHQH6hzOMao9Wi9g3MipE2WhAurQHkmUW1oF12h5hSBfkiw4gXpn7lmJBZMm4tx8pv+VPfnlA4gALvoGejR86fxWVZN+FaIa/eT02swlgNUQnKYEFH6Q5JcR2qHb/27JBj2eQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581307; c=relaxed/simple;
	bh=pwPdibPJQed9NnbhGERtZINYpVjrQKL+yWaUc0BWwYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct9yjbVffyhpglz5VEkPrqLTQpF5ejWztST//0mw1urvfdbrlEM2ghYzycg5f6gGyY/6eDnMMCmGfCz38sffDrVzQbega5U81tqqzGLFTyaK85yQLSidWC1xD6BVX7oA7jDWfyP27EJeXnjhjd7G1bxxmQzLE08byPkw5bTynRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M2+aLmXC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B82C4439E;
	Fri, 21 Mar 2025 18:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742581298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT3j5ia3YM4BM/xg+Fw4hf8d8cAPlpEijn+7bl03zsE=;
	b=M2+aLmXCuAkAtEzK22T1y229k0Hx/fEcdMCuVydJ1io66hFVPtiOn7GBAwEYaUnyhjxC94
	ICATURZtPDmh1DBptvQBie4GII1Pm7bGnMArOcVEhyHMLfO4ZtUjzrVAzlXBmLaMCSQJ2o
	v0QxoN+dfKbAxbDnacFwsJVtWQlxGKo8R8MnuogRDC52wuk3izUBlzY9ufJLExiD6tlnKM
	k7rbUwm2fL8rKxFOLoxjROHPAz5M5QHE7vXqivbMecIsaf6TpBAaFZ10mpgP3P7z/SWpQB
	MHkfpgxw9FAok9ZSgsZYepow4fZBN6nB79LgrwrwqCk9UkR+nfFWiaV9ElT8qw==
Date: Fri, 21 Mar 2025 19:21:32 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Anusha Srivatsa"
 <asrivats@redhat.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Fabio Estevam" <festevam@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Paul Kocialkowski" <paulk@sys-base.io>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Robert Foss"
 <rfoss@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn Guo"
 <shawnguo@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Stefan Agner"
 <stefan@agner.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v8 2/5] drm/bridge: add support for refcounting
Message-ID: <20250321192132.211893ec@booty>
In-Reply-To: <400466cd3c229ea6c6cb25e2a58cee27@kernel.org>
References: <20250320-drm-bridge-refcount-v8-2-b3ddaa9f1368@bootlin.com>
	<400466cd3c229ea6c6cb25e2a58cee27@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedukedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvtddtudemsgdtjeemieegieelmegtieguieemgegtudelmeeffeekvgemjegvjegvmegttdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemsgdtjeemieegieelmegtieguieemgegtudelmeeffeekvgemjegvjegvmegttdejuddphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsr
 dhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopegrshhrihhvrghtshesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Maxime,

On Fri, 21 Mar 2025 09:54:55 +0000
"Maxime Ripard" <mripard@kernel.org> wrote:

> On Thu, 20 Mar 2025 16:42:11 +0100, Luca Ceresoli wrote:
> > DRM bridges are currently considered as a fixed element of a DRM card, and
> > thus their lifetime is assumed to extend for as long as the card
> > exists. New use cases, such as hot-pluggable hardware with video bridges,
> > require DRM bridges to be added to and removed from a DRM card without
> > tearing the card down. This is possible for connectors already (used by DP
> > 
> > [ ... ]  
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks a lot for reviewing!

I noticed you haven't replied on patch 3. Being a change you had
suggested, I was wondering whether haven't noticed that. If you are OK
with that patch, the entire series would have a R-by, which would be
great to unlock all the work depending on this series.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

