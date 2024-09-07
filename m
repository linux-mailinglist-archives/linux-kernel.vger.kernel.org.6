Return-Path: <linux-kernel+bounces-319733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF0970182
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB791C21A39
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A802814BF87;
	Sat,  7 Sep 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="h0YZ17tv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwngUz/K"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C354656
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725703454; cv=none; b=ZA9sikEmNGx7+ndBiPJUq1po2W7JlGB9OE2PVbnYmohXQvpLTaabBL4mJy/p/KLm5ekNhI9i4fnj5dFO2LY3rhxncrqSv+v4AcpFt0UTTQ4/WhHFt1vOuYQjDZcWxBfdFE6FlXHiuHEjUWTiCSKzclh/QgDkXP+mkw0mYTT43kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725703454; c=relaxed/simple;
	bh=2EetRAMR4q0JVBaGK/wdZJn/Iftt+edE/rWPFd+mlBY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rwRM6DmRF4+Dfj7p/AnHp+gchrqgKnAHTj/GEiC8mt+oW/D1+1iPQellLr6oIeSriMLmSfNP1gACTkQaQPrY4UOz28uMWaYY2Q5RT2MJAb4ndGiyq97UdgJOkGEc4+twd1p/rcJgAqOJiIDN0+GU3IqiP4rxX/MczotPCw9WdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=h0YZ17tv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwngUz/K; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A1D4913802F1;
	Sat,  7 Sep 2024 06:04:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 07 Sep 2024 06:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725703450;
	 x=1725789850; bh=kX3YmhzK/ICnpF5lfCu9l4NjU7cdpvO528pAiHw6zc8=; b=
	h0YZ17tvy/1uM9vl5Pta/JwgbQgU5eJGbO0tX+3rcA1y5Hfb2dG5cyn/XsSUPEPl
	AkKDxTiv8hPsAeOipS06+fY3bP349RPTbdtKfLP5/Y3MhcFqp0nUV9Ey/3/beQNC
	/1sTRSVdAuYzcMm9wc1iRELBkcaXYWx14fhHkY7cXLtkTWVnr1cbOY5t54aaBxvW
	EyrltWVv+3xrrkUKaD+BJ03FyUNFBk1n1SG2KsNpRppDHTXlE/rcOGR28X0aN1AX
	7OXnwvCmbO938gwFFd0Vp3UxRPkY001j7cnQsjAItQ8p+6Ts2HI2t1mSWcvunz+X
	gxuC20FQcB2HtRO0MqCx5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725703450; x=
	1725789850; bh=kX3YmhzK/ICnpF5lfCu9l4NjU7cdpvO528pAiHw6zc8=; b=n
	wngUz/KUJnGn+/ikpVXQQlGqp1vrjTlNe8zqRr4FTllChKgMVYhXqLRowKvNdS6I
	Zhe0tB61+J9rN3jV/kEaKyRdTsYy94EekVeT2MvAfC2/OND/RtRJSXy2n13tM5YH
	rljL+JcnF2iRy9U5e2qY+g+fzKnVls7Sv4pj/2Gjiiemm7wO/mXCNSRB5P3bHSFv
	s03CUoPXDEc57sysJRsuGryt3LLgTIfsidvJmqI4+GNesL1tiOQgFNHHfqi04rGf
	9R9umUFBLMDdgKGV0IC1BHVhKWnW694/VNL9KHx6Iqdc3yG4J7D0hzd5ykkpETVO
	NXJfJKG5JWibUD3JjdsnQ==
X-ME-Sender: <xms:GSXcZrCzqotcz-xjmF4FhIvr6d6zM9p3QhUs2ma3ES3mSi9_ZiskaQ>
    <xme:GSXcZhi-VGNqqu4L_tYdzQFevMLbfN5ln6h_0PnbIEgeiT-KzxF5XnnVhloV6d1Ei
    KIotrg_9IDT2R-afvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeifedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugi
    drohhrghdruhhkpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhho
    rggutghomhdrtghomhdprhgtphhtthhopegvthhivghnnhgvrdgtrghrrhhivghrvgesfh
    hoshhsrdhsthdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhi
    uggvrhdrsggvpdhrtghpthhtohepthifohgvrhhnvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriiih
    shiithhofhdrkhhoiihlohifshhkiheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplh
    hinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:GSXcZmnYXnMAlPLAC1fGbf7QvbWxPSiyxhCj6V3OL9G-JMKuNJTNPQ>
    <xmx:GSXcZtzmfyn5H24B6FoRWWytDw_mB9Cw-br7LHJZVV5WwBZ7DQ3jpg>
    <xmx:GSXcZgS48mufuz1TkyEYASaZuwX_4V5F57Oez5yUtjtEXdDGnA_SOQ>
    <xmx:GSXcZgaOQqRmOJ9fUv-1mfhRre-NC4ptUBvcp4ohtYKmnAzvQpYcNA>
    <xmx:GiXcZnIbCYgqWQuasqpjHoHbQH8-BFnExewnh9I5_3L3tzDKA89_Pgxf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5915E222006F; Sat,  7 Sep 2024 06:04:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 07 Sep 2024 12:03:48 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Florian Fainelli" <florian.fainelli@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Andrew Davis" <afd@ti.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Mark Brown" <broonie@kernel.org>,
 "Etienne Carriere" <etienne.carriere@foss.st.com>,
 "Trevor Woerner" <twoerner@gmail.com>,
 "Javier Carrasco" <javier.carrasco@wolfvision.net>,
 "open list" <linux-kernel@vger.kernel.org>
Message-Id: <40412179-9bc2-409b-ab12-11149a3e4f5f@app.fastmail.com>
In-Reply-To: <20240906213907.611684-1-florian.fainelli@broadcom.com>
References: <20240906213907.611684-1-florian.fainelli@broadcom.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable debugging symbols by default
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2024, at 21:39, Florian Fainelli wrote:
> Similarly to the ARM64 defconfig, enable debugging symbols and rely upon
> the toolchain's default DWARF implementation.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

I usually build with debug info disabled when I'm build testing,
but turn it on explicitly when I try to actually debug a problem.

Depending on the configuration, adding debug info can significantly
increase the build time and file size. I've tried to record exact
data here, building the arm defconfig on gcc-14 with and without
debug info, which doesn't seem too bad, especially with the
reduced debug info:

config         vmlinux time    total time   vmlinux size
disabled-gcc9  49s             81s          35MB
reduced-gcc9   55s             98s          148MB
full-gcc9      66s             105s         443MB
disabled-gcc14 55s             90s          34MB
reduced-gcc14  60s             99s          124MB
full-gcc14     68s             115s         349MB

There is still added disk usage for build testing, but
the time overhead seems fine. I'd like to hear what others
think about the tradeoff.

      Arnd

