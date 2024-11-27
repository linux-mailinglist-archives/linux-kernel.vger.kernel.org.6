Return-Path: <linux-kernel+bounces-423883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514549DADD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C42B27108
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF541201116;
	Wed, 27 Nov 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fD2zUlVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5pOV3yH"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA012E1E0;
	Wed, 27 Nov 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735832; cv=none; b=A9zp4sxKW5feynABNgbXGehHtDVvwTbTY0TTESsu2PLa955eYc89b+NqqTY/5IJMfIL4YJHI6rFR/1TvVB6qyH0NWwYmCPTj68BEXh8yGt+L3a2rB8RGZAH1xaFeuTNHmg8qOmaDcZl9ZwseRZWSI9HfiAFSYxcwVP4/UWMcMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735832; c=relaxed/simple;
	bh=Bj/s6PT34SkAI6ztbW67uRqPMcWds4OjshAmxkBD6/s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IrvnbMyKeHXYYgCf0qsa/x9GtrHweDvbfFwI9bJ38YrN4XdZtJ3JtR+2EhfxzMuTUvU4H1sffHdXfJaACj5zLbVv6fn625XLixTZVgsFcB/393o7TA8/SXkRCteUdiO6a37wrUr7SpBCT4gKB+EaXjNwyVOtIfGJg0LkY5gpHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fD2zUlVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5pOV3yH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A9F51380756;
	Wed, 27 Nov 2024 14:30:29 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 27 Nov 2024 14:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732735829;
	 x=1732822229; bh=PMTKICLAk8Ul19wYWrq/UHHGVaNn10wFQLO8Ht338L4=; b=
	fD2zUlVDRIa6UFm+LgOzMT9Zp9jJvynzA2AtXaUueyiT1VXO0MHD0GHhMHfyCICt
	mTeuNlqUl2p6BX3M9tcPG4Egw8L4SYmcdKDrQQxYPy8sE+oE08fj9cPUUJzBEbRh
	Gf51HgGfDcJE+O2czHENn4LQ4HuyXQ3SL2XwQ8xbZDXIfORO9Xe3M+H0B3sIFWeR
	9uM1TD9ufZsT4WzTwdiODGBNs/mSXV+R9I2/8/OvcoJYnYYBxQ/PoBj4cSLEE+5/
	lqMS9+GVWRWyKrbhC6RPqb0JB5roS41BjNUtwpUhij4FdMSUiemlSNU0XnRfxKg9
	4dtkBKPpqKxE6QhBAoGBGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732735829; x=
	1732822229; bh=PMTKICLAk8Ul19wYWrq/UHHGVaNn10wFQLO8Ht338L4=; b=H
	5pOV3yHAV1aXVBIGJ8YQfrresq2YqIFjtLtk/Fvp/XOj+Kv4v1SPbk3zFZRySLBV
	LJcxdnyBlc+keML7Yn5jCPmXjKvygEp16dKnymIdFyOk74Gs0ynICO/sgEe5zL2r
	uOZhhiiKEjnhGDs4YMmtakiqoEF8axEJHBcZllBkP5WCO+GlnfzSQZQV6LqJAJ+P
	CWGCdpkfmrbn2mykq1XNq06ss2ZhtsKFMB+yWhInrf6KT9WEfz9HLzw4krbu5gGy
	HwA2rlysZk3IV2LH+eeQtjHEZlw/AR5pjR9ZkQLKV4Pjar9J1I3ZokxEJEiz8Ipr
	GaC6aK8AiK4LyB6I8NcrA==
X-ME-Sender: <xms:VHNHZymJ-B8FSBgSfNQtcO69NdeQHxiqYGUcfnlKXKRESNgSDlNTXA>
    <xme:VHNHZ51Yzy9o5AQpK6W2dCEGc1soTxW8zeBaqrdPpNhc9-IcaqEG3TdqRQAHTyHCq
    O5SkLpHzd23bbilMpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsghruhhnvghtsegsrgihlhhisg
    hrvgdrtghomhdprhgtphhtthhopehkhhhilhhmrghnsegsrgihlhhisghrvgdrtghomhdp
    rhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpth
    htohepmhgrrhhtihhnrdgslhhumhgvnhhsthhinhhglhesghhoohhglhgvmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshht
    rhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrmhhlohhgih
    gtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    rghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:VHNHZwohAnM6qcGvYt57x8rZYujNQDRAXuOvGZJFQ7FzDqB3MRsTTg>
    <xmx:VHNHZ2l5skdIkAlbpfZ3uoruVk1hadaOboTgL5v2EayCDq2mudDMKg>
    <xmx:VHNHZw3MIRdevzqJejuGzilVwfBFRQvJJD21Nq8Tcdx4pbpz708zvA>
    <xmx:VHNHZ9srmhntVifpTVlUnu8iACTzYA1YER8tWYne4F4_YrwFUAa9Ww>
    <xmx:VHNHZ5t7dwmXGd_wtkgHJ4-mlfxy7bHCgRhToztkEPC_dHMpKqOizRo3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D7EF2220071; Wed, 27 Nov 2024 14:30:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 20:30:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
In-Reply-To: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
References: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 27, 2024, at 19:47, Jerome Brunet wrote:
> Depending on RESET_MESON_AUX result in axg-audio support being turned
> off by default for the users of arm64 defconfig, which is kind of a
> regression for them.
>
> RESET_MESON_AUX is not in directly the defconfig, so depending on it turn
> COMMON_CLK_AXG_AUDIO off. The clock provided by this module are
> necessary for every axg audio devices. Those are now deferring.
>
> Select RESET_MESON_AUX rather than just depending on it.
> With this, the audio subsystem of the affected platform should probe
> correctly again
>
> Cc: Mark Brown <broonie@kernel.org>
> Fixes: 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency 
> on RESET_MESON_AUX")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>


febb5d7348ff07c2da0cb5fd41d2ad2607e5bd5d..ea16bfde0df2d7bfebb041161f6b96bbb35003ed 
> 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -106,7 +106,7 @@ config COMMON_CLK_AXG_AUDIO
>  	select COMMON_CLK_MESON_SCLK_DIV
>  	select COMMON_CLK_MESON_CLKC_UTILS
>  	select REGMAP_MMIO
> -	depends on RESET_MESON_AUX
> +	select RESET_MESON_AUX
>  	help
>  	  Support for the audio clock controller on AmLogic A113D devices,
>  	  aka axg, Say Y if you want audio subsystem to work.

You should generally not 'select' a symbol from another
subsystem, as this risks introducing dependency loops,
and missing dependencies.

It looks like RESET_MESON_AUX is a user-visible symbol,
so you can simply ask users to turn it on, and add it to
the defconfig.

I also see some silliness going on in the
include/soc/amlogic/reset-meson-aux.h, which has a
non-working 'static inline' definition of the exported
function. Before my fix, that would have caused the
problem auf a non-working audio driver.

      Arnd

