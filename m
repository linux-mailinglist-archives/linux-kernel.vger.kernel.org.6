Return-Path: <linux-kernel+bounces-422819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DE9D9E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7584D2840F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F391DF253;
	Tue, 26 Nov 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="QtAInAKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJeUt1TR"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892A1865EB;
	Tue, 26 Nov 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654837; cv=none; b=GTtAKw+j4tkKTFBFK/my1fyrDsd1PVa0dHeYPYxETv4B9rapuN3gM7LSFeLMQmDZ3BTE1kEyJij+/Ihcddyq1Rj964dIjHSaJkiRY3ZyQwpyKBvXQO85pamtfmORrRfk71tCAsIq67NGZMXzqPktVkNA1flSU5Ahjfr9n4J9qBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654837; c=relaxed/simple;
	bh=RvOKn3FWonQ1vytMWP99NuB5b/vpEQBQWAy2pQ3UqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ0qZsGMgaRTxT9wMZmLbjbiwy9pAVtorPW42Vcwa5lP69UsyA9kp631COwX1SmtvnVfLi4SqnASrDsiX0Bf9AIfvvyltk5IrrO5Bj6jsurvqXEV/Yzb/kR0N7xpBE3tQghCkTe0HJBNIgn80iD1WqTp4uoVQ/OoXUIlzj4JfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=QtAInAKL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJeUt1TR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 974941140226;
	Tue, 26 Nov 2024 16:00:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 26 Nov 2024 16:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732654833; x=1732741233; bh=RvOKn3FWon
	Q1vytMWP99NuB5b/vpEQBQWAy2pQ3UqLY=; b=QtAInAKLVh8IhK2o0Yavq5Sam/
	007JMzqW7kgzDQxp8xvsv3VjUGVmKLWv2y+8eHTr74T/HFsizpOWs9IXKCGFJmYK
	J/ABleV6Ua53WEfzCk5nLiBsaqOHTNO25GTniKUhwBOIW4rbHlyJRziwED7ibY12
	lgfknspkjz77WcF2KEwnK0vSVDH9NH5w57Ps+n44AsMVpujnkhNQ7yd9h5WxTG2L
	bicZkid1OsYfAhelwJE47/VVCO6p/0V0iI9UsGCNdA2c3nUxzjcnQOxaOecOOSGy
	mps7iCjevbO5D98hk+VzBGEPi/S+3rwJYmTWeVded81RaIJPH0BEgE7XEISQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732654833; x=1732741233; bh=RvOKn3FWonQ1vytMWP99NuB5b/vpEQBQWAy
	2pQ3UqLY=; b=ZJeUt1TR04OISTSlgp3y9VjVCWQWSZ8IzdNzrLKF60iDE+c7aXt
	f0WYH/l7TXprSkgMxKbR5OkO/YyxtNYiigSUgQycr9zYr4x2v4lEaL6O5iL5nDVE
	VXFdWx0JapWk32Cnmu4Idw8YGI800TfPUh1TgiHV3idlaSM/dw5Sxk/ndFCFkV4f
	0pUMsh1KbklGrAwF3g6epI5bxJImlCJQmIsJc1vefj9M9V128e/mkHFwZddYcMJh
	dYb7jNglk5NDXxTFpYlWVHcl8n2kISRGsrmvhRE7F2S7EIFuKyjqE4lOIALe1QPT
	hcl3/Q4/Npeog4y/22/JEMvJCeYIk1QT+kA==
X-ME-Sender: <xms:7jZGZ2cRhrGcTUATnZvKeEDVfxoUoPOHsRJAie2dx5QupQGdENXCww>
    <xme:7jZGZwMPoq6OUru8v3baoS1CsCr0gsrFLCLzyaIMVdCFSrKNuK5q9q6xGlo0x9Lut
    x-3H07a-EUJkT1Gkw>
X-ME-Received: <xmr:7jZGZ3huoVw3MqcD5LT-LK4MvZz8rSEj3vGvzAoKV-oVMs6O9rX0c0BQGOc70sVXkX_rQu_hV2nTdrL6akqBdpywzY0J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvden
    ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
    ftrfgrthhtvghrnheptdejueetkeehfeeuleeugfevieffkefhteefiedvfeehuefhjeeg
    vdeiffeihfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedvtddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtth
    hopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhnkhhlrdhkvghr
    nhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprh
    gtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhr
    iihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhrihhprghrugeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:7zZGZz9Ff6XB1Q6tqpYjOs9Y_We3EwHQfkfNEjUlvFpjI4yx9BqoQQ>
    <xmx:7zZGZyvavoNsNwe7tI_iMjgpjUr19vCrZ9XVFNFOe3OFuY2W70-g3Q>
    <xmx:7zZGZ6Ei0Hpu9P8UFhgR1F47FBUZPDXVEUsQhqTG3BzLnrYTrtiWZQ>
    <xmx:7zZGZxP2xEZuMJ2MCNDPPuU7XsuLXpQZ0SUNMy5lVweckyhAAO3pbw>
    <xmx:8TZGZzWQ2V5hpF3nLfowBxG7-0NbVXfRsZucObqxl5O2aFIl_8kBKqib>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 16:00:30 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id B9A37ACF1; Tue, 26 Nov 2024 22:00:27 +0100 (CET)
Date: Tue, 26 Nov 2024 22:00:27 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2 2/5] drm: adp: Add Apple Display Pipe driver
Message-ID: <47h3usia2ynafi3dfprkwlnjkacbh7gnvtb2g5opcdsoc6hwcq@cjb2kprh34d4>
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
 <20241126-adpdrm-v2-2-c90485336c09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7uafsirddgzhtoqx"
Content-Disposition: inline
In-Reply-To: <20241126-adpdrm-v2-2-c90485336c09@gmail.com>


--7uafsirddgzhtoqx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/5] drm: adp: Add Apple Display Pipe driver
MIME-Version: 1.0

On Tue, Nov 26, 2024 at 05:34:21PM +0100, Sasha Finkelstein via B4 Relay wrote:
> +module_platform_driver(adp_mipi_platform_driver);

This is part of the same driver as adp_drv.c, so I don't think there's
supposed to be another module_platform_driver() call here?

/nix/store/hni09p7jhc8szjr2h5j5m0lhi2x0djjg-binutils-2.43.1/bin/ld: drivers/gpu/drm/adp/adp-mipi.o: in function `adp_mipi_platform_driver_init':
adp-mipi.c:(.init.text+0x0): multiple definition of `init_module'; drivers/gpu/drm/adp/adp_drv.o:adp_drv.c:(.init.text+0x0): first defined here
/nix/store/hni09p7jhc8szjr2h5j5m0lhi2x0djjg-binutils-2.43.1/bin/ld: drivers/gpu/drm/adp/adp-mipi.o: in function `adp_mipi_platform_driver_exit':
adp-mipi.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/gpu/drm/adp/adp_drv.o:adp_drv.c:(.exit.text+0x0): first defined here

BTW: would have been nice to have been CCed, given I provided feedback
on the previous version of this patch.

--7uafsirddgzhtoqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ0Y26AAKCRBbRZGEIw/w
osfvAP96HKpOl5z7lFMD3Cl0MuxmQDdg3qYwLVXxxv66M23v9gEAjUbYvvVv0y0/
yE42jEn2VG++qwJs2Fp0Q0LZqTKv+gU=
=uFji
-----END PGP SIGNATURE-----

--7uafsirddgzhtoqx--

