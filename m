Return-Path: <linux-kernel+bounces-550553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C97A5610D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1BA1895DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025319EEBD;
	Fri,  7 Mar 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="j9ZRzaOM";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="OjqWsuB/"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8C1925AC;
	Fri,  7 Mar 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329739; cv=none; b=k9iyIEMKB27sALUDqsmM2OTND43lcH6/6O3zqJSsJXfXaJRt9jMg2tXXtE+AlCAUfP1B0dLz8R5DoWJzab/1v8RDiXPDmbf1weip6jeOQfFdK3BR7dpWGyYTFfLUGM8XHdP13TUA2PGDVcXluuqPNAuusP50RQzQUwCMDQrc/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329739; c=relaxed/simple;
	bh=nbKRa8rE0oqcLHSVyysr2VLKNWVvbQMS6EMeJYsmQrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLFs4LytIhDEyhKgTf/zQrAyNfUGFOit47Dem4QAIDP1bWCaUWENXb7A1TQNLgn5ZmBgg8eK/CD3AlXXipPm52fC8TdOk4OwCQCWuwxjUtgbSLdDNSgYYkBk5WL2RTOMzGG1GQTyCX252Jb1i9mhDHxb/PhctWdXA0R5H7JBb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=j9ZRzaOM; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=OjqWsuB/; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 36B94EC59F8;
	Thu, 06 Mar 2025 22:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741329737; bh=nbKRa8rE0oqcLHSVyysr2VLKNWVvbQMS6EMeJYsmQrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9ZRzaOMCEbuc8R6ZwloksUuFydWNEtGh15LwVoTqKx5tVnAODqyTmLZvdCvrOtgn
	 PxHqMFMdv5beyGG/60UuYTcwI6gQvsWMqgiOq9uOY8GiXOuQ2TMQcFosDtJjzucORy
	 kqWutUOyhmDVwNfq+yT+p+TfKnQnOo/OjdfOwh4Kxel3lnuJeNXuUVNGOUk6BvIjlP
	 X0ej5DPgAl0hb7RdH4jrSKA0/Fnk/zXR2tqoam8f1FXIIJMe3pGcaxlWErZaFNsO8+
	 fnJGP8iCVRbzpboiI7Yb5Qj4SGRZzZguYwUwqS0Jzz8H9WOh9lFdpcDZBGG+tuW5nK
	 qqH0jvuT0NaLA==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0vtihhhkC7FQ; Thu,  6 Mar 2025 22:42:15 -0800 (PST)
Received: from ketchup (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 9340EEC59F2;
	Thu, 06 Mar 2025 22:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741329735; bh=nbKRa8rE0oqcLHSVyysr2VLKNWVvbQMS6EMeJYsmQrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjqWsuB/gYig3SZZwnOSvRfEAlxrE6c+5OAeVJrL5TzYn0O8i0v+cZBfGjV8/eRTr
	 ycReyAiGZyy42W8ajkOUMyRr2fSvFT0E5VlIufVI2iozFMPnRmEWvofyFaa1Bj786P
	 pwOHWQ/2t5WqP7hB0DPIaTusuHravbH4d8+e1IRQnlJdWX8tzH5oM24AlJyfaXqTtv
	 UQD2SwiievEOW556J+xCsRSGXKzFj3sqxHWYoeFHMU8q8HLJBKsEb9N1IlZ/Vy2llk
	 2QYWu2Fr/yU7bCPYMBuS6x0TeSlR6pT1M0dLgQaBgRfxUzQB3L/fQ/9MOyTeq7Acyl
	 suu6g6yGqL+Jg==
Date: Fri, 7 Mar 2025 06:42:02 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <Z8qVOssDHaVDQmLY@ketchup>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
 <20250307005149-GYA66361@gentoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307005149-GYA66361@gentoo>

On Fri, Mar 07, 2025 at 12:51:49AM +0000, Yixun Lan wrote:
> On 17:57 Thu 06 Mar     , Haylen Chu wrote:
> > The clock tree of K1 SoC contains three main types of clock hardware
> > (PLL/DDN/MIX) and has control registers split into several multifunction
> > devices: APBS (PLLs), MPMU, APBC and APMU.
> > 
> > All register operations are done through regmap to ensure atomiciy
> > between concurrent operations of clock driver and reset,
> > power-domain driver that will be introduced in the future.
> > 
> > Signed-off-by: Haylen Chu <heylenay@4d2.org>
> > ---
> >  drivers/clk/Kconfig               |    1 +
> >  drivers/clk/Makefile              |    1 +
> >  drivers/clk/spacemit/Kconfig      |   20 +
> >  drivers/clk/spacemit/Makefile     |    5 +
> >  drivers/clk/spacemit/ccu-k1.c     | 1714 +++++++++++++++++++++++++++++
> >  drivers/clk/spacemit/ccu_common.h |   47 +
> >  drivers/clk/spacemit/ccu_ddn.c    |   80 ++
> >  drivers/clk/spacemit/ccu_ddn.h    |   48 +
> >  drivers/clk/spacemit/ccu_mix.c    |  284 +++++
> >  drivers/clk/spacemit/ccu_mix.h    |  246 +++++
> >  drivers/clk/spacemit/ccu_pll.c    |  146 +++
> >  drivers/clk/spacemit/ccu_pll.h    |   76 ++
> >  12 files changed, 2668 insertions(+)
> >  create mode 100644 drivers/clk/spacemit/Kconfig
> >  create mode 100644 drivers/clk/spacemit/Makefile
> >  create mode 100644 drivers/clk/spacemit/ccu-k1.c
> >  create mode 100644 drivers/clk/spacemit/ccu_common.h
> >  create mode 100644 drivers/clk/spacemit/ccu_ddn.c
> >  create mode 100644 drivers/clk/spacemit/ccu_ddn.h
> >  create mode 100644 drivers/clk/spacemit/ccu_mix.c
> >  create mode 100644 drivers/clk/spacemit/ccu_mix.h
> >  create mode 100644 drivers/clk/spacemit/ccu_pll.c
> >  create mode 100644 drivers/clk/spacemit/ccu_pll.h
> > 
> ..
> > +static int k1_ccu_probe(struct platform_device *pdev)
> > +{
> > +	struct regmap *base_regmap, *lock_regmap = NULL;
> > +	struct device *dev = &pdev->dev;
> > +	int ret;
> > +
> > +	base_regmap = device_node_to_regmap(dev->of_node);
> > +	if (IS_ERR(base_regmap))
> > +		return dev_err_probe(dev, PTR_ERR(base_regmap),
> > +				     "failed to get regmap\n");
> > +
> > +	if (of_device_is_compatible(dev->of_node, "spacemit,k1-pll")) {
> ..
> > +		struct device_node *mpmu = of_parse_phandle(dev->of_node,
> > +							    "spacemit,mpmu", 0);
> > +		if (!mpmu)
> > +			return dev_err_probe(dev, -ENODEV,
> > +					     "Cannot parse MPMU region\n");
> > +
> > +		lock_regmap = device_node_to_regmap(mpmu);
> > +		of_node_put(mpmu);
> > +
> you can simplify above with syscon_regmap_lookup_by_phandle(), which
> would save a few lines
> 
> or further, just call syscon_regmap_lookup_by_compatible()? then
> won't be necessary to introduce the "spacemit,mpmu" property..
> 

These syscon_* functions differ a little from device_node_to_regmap():
they get and enable the first item in "clocks" property when
instantiating a regmap, which isn't desired for a clock controller.

> > +		if (IS_ERR(lock_regmap))
> > +			return dev_err_probe(dev, PTR_ERR(lock_regmap),
> > +					     "failed to get lock regmap\n");
> > +	}
> > +
> > +	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
> > +				    of_device_get_match_data(dev));
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to register clocks\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id of_k1_ccu_match[] = {
> > +	{
> > +		.compatible	= "spacemit,k1-pll",
> > +		.data		= k1_ccu_apbs_clks,
> > +	},
> > +	{
> > +		.compatible	= "spacemit,k1-syscon-mpmu",
> > +		.data		= k1_ccu_mpmu_clks,
> > +	},
> > +	{
> > +		.compatible	= "spacemit,k1-syscon-apbc",
> > +		.data		= k1_ccu_apbc_clks,
> > +	},
> > +	{
> > +		.compatible	= "spacemit,k1-syscon-apmu",
> > +		.data		= k1_ccu_apmu_clks,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
> > +
> > +static struct platform_driver k1_ccu_driver = {
> > +	.driver = {
> > +		.name		= "spacemit,k1-ccu",
> > +		.of_match_table = of_k1_ccu_match,
> > +	},
> > +	.probe	= k1_ccu_probe,
> > +};
> > +module_platform_driver(k1_ccu_driver);
> > +
> > +MODULE_DESCRIPTION("Spacemit K1 CCU driver");
> > +MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
> > +MODULE_LICENSE("GPL");
> 

...

> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

Best regards,
Haylen Chu

