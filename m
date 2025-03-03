Return-Path: <linux-kernel+bounces-542364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E7A4C8C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAA57A31AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C225BADF;
	Mon,  3 Mar 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jBcHt+hu"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FB22CBE9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020623; cv=none; b=Qm7E4KP5m53Ms/G7zMxnMp64lUHBwo/drxDuTY2tJ/EA2Xs4a7xTt6ivnMbR4OQImOaakpNlNggIw0BsY6A5990HlJSu2JElzDxx03zVjksARsrprmRhV2qKNAuwAM2oQmvfRdnR0M86xeEyHHBYOLh4mSWIXuF9pojdX7JlsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020623; c=relaxed/simple;
	bh=3olsaads0hJRXoLcXDm6bQjRDab5p8IKCJQ2rzmNJlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llk5Fi3uN2I2x2RSEzutkp5tp+Iou5AnmVV52kzfOf52VMAyg9yWNNq1ekv0sy38ojnns4ov7N8Sai/HB2oipuNslsERq1hR36orFpjbRViLenqJUfI/FsxYqOHb0eEmP4N5dKEgAlL16HP4OYWfPQSG8YzYdXFw5BZgT5TUDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jBcHt+hu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1927444309;
	Mon,  3 Mar 2025 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741020614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/VKy7RNZe04O3Ukil/E1YnYwXSSFhvFI8FQ/Orueu8=;
	b=jBcHt+hurhYQWG8MXM+6Q18iiRl00Kb8LtZaruiTkOJxYoRg6Tsu7WQ3EZJr9iTLlUQ1vG
	nv7evnIrAsOAYK3a99Ni9hxflAOy6GxeAqgOFFPgO+JPFAmSdc2RG6HfHK9CrOZBIeRhU2
	m3lt5bhjmtFhn6/zbY90dUpd1Ho6i7yazVoBVkWF43pZpXbdIVte8bcpStAVY1GCXPAzIc
	8JG+X8LStqmqMDH7m8bA/a8BiEHTH/L4KHdT8Q8Ukv2HyJd58nAbJbjtT4P7sQVsGPO5yc
	Mx7gpuh+lh/N46j4ABfHJO/biPY3j6RPqmMl13tR9HpgoPKE/gdhIxfL7DG3eA==
Date: Mon, 3 Mar 2025 17:50:11 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas
 Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4 00/15] drm/bridge: Various quality of life
 improvements
Message-ID: <20250303175011.3f79a8c0@bootlin.com>
In-Reply-To: <20250303-idealistic-camouflaged-mandrill-4fb5f8@houat>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
	<20250227120004.77814e09@bootlin.com>
	<20250303-urban-trout-of-vastness-f8d0e7@houat>
	<20250303143404.623a3178@bootlin.com>
	<20250303-idealistic-camouflaged-mandrill-4fb5f8@houat>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejffelhfeiudetgeffieefgefgffdvuedvuedtvdefudduueekffelheehffekteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnr
 gesfhhffihllhdrtghhpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

On Mon, 3 Mar 2025 16:00:33 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Mon, Mar 03, 2025 at 02:34:04PM +0100, Herve Codina wrote:
> > Hi Maxime,
> > 
> > On Mon, 3 Mar 2025 14:11:05 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:
> >   
> > > On Thu, Feb 27, 2025 at 12:00:04PM +0100, Herve Codina wrote:  
> > > > Hi Maxime,
> > > > 
> > > > On Tue, 25 Feb 2025 17:43:48 +0100
> > > > Maxime Ripard <mripard@kernel.org> wrote:
> > > >     
> > > > > Hi,
> > > > > 
> > > > > Here's a series of changes after to the KMS helpers and bridge API
> > > > > following a bunch of reviews I did.
> > > > > 
> > > > > It's mostly centered across providing an easier time to deal with bridge
> > > > > states, and a somewhat consistent with the other entities API.
> > > > > 
> > > > > It's build tested only, with arm64 allmodconfig.
> > > > > 
> > > > > Maxime
> > > > > 
> > > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > > > ---    
> > > > 
> > > > I Tried to test this series on my system but I've got a compilation issue.
> > > >      depmod: ERROR: Cycle detected: drm -> drm_kms_helper -> drm
> > > >      depmod: ERROR: Found 2 modules in dependency cycles!
> > > > 
> > > > CONFIG_DRM=m in my configuration.    
> > > 
> > > Could you share your configuration? it doesn't happen with allmodconfig.
> > >   
> > 
> > Here is a defconfig that leads to the issue on my side:  
> 
> I still can't reproduce it, sorry. Is this based on linux-next /
> drm-misc-next, or a private branch?
> 
> Maxime

Got it with this git history (based on 72d0af4accd9 available in
drm-misc-next):

f86431f9d3fc (HEAD -> test_maxime_series_drm_next_clean_v4) drm/bridge: ti-sn65dsi86: Use bridge_state crtc pointer
27b49a4a713f drm/bridge: tc358768: Convert to atomic helpers
f3f203c823e3 drm/bridge: tc358768: Stop disabling when failing to enable
89f4b115b1ca drm/bridge: tc358775: Switch to atomic commit
142be5c7910a drm/bridge: cdns-csi: Switch to atomic helpers
e6db675d871a drm/bridge: Introduce drm_bridge_is_atomic() helper
1745511b7394 drm/bridge: ti-sn65dsi83: Switch to drm_bridge_reset_crtc
e44654d4c9bd drm/tests: bridge: Provide tests for drm_bridge_reset_crtc
671a94f57f99 drm/bridge: Add helper to reset bridge pipeline
bcf02dc7fb61 drm/tests: Create tests for drm_atomic
f7b479b6f283 drm/atomic: Introduce helper to lookup connector by encoder
56d9fa19b833 drm/tests: Add kunit tests for bridges
9c86d5205422 drm/bridge: Provide a helper to retrieve current bridge state
3e0010915240 drm/bridge: Add encoder parameter to drm_bridge_funcs.attach
72d0af4accd9 (upstream_drm/for-linux-next, upstream_drm/drm-misc-next) drm/msm/dp: Add support for LTTPR handling
6dcc3c5121b7 drm/i915/dp: Use the generic helper to control LTTPR transparent mode
226a0baf9098 drm/nouveau/dp: Use the generic helper to control LTTPR transparent mode
...

Best regards
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

