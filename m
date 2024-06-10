Return-Path: <linux-kernel+bounces-208443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 147C2902546
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D91EB253B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51713DDCE;
	Mon, 10 Jun 2024 15:15:45 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB956140E29
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032545; cv=none; b=qUrdgs6giH3o8XjwZ8SIfpy9G+PbS3TQYQDw2jEDug2y42mKjbBMmb0NcvWH6nLdeWmZMLd19APneMGcetn36+Jn8JT+QYwW8d+dM+9AdeEOXUEA3+KOzAK75cuPOKXBRiqv95CXeudgGMVW6ycNW7LuVqfRHB+csiXoF57l9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032545; c=relaxed/simple;
	bh=8KtWSjxLbsgn32+Bg/uorKQ1tVssn2+9i3jD0uQL6OM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWVvMSMpzpIGIQytojRpJjsfz8m6r6xU/Qhq7o1h+cY0kiQerdmZxF9Mwzri7SRAvE4lqCPQ/MhfJUabXVWvSuWO9Tj8jPFz3P0rI4UXL3uBmxRFtSrxVwWXyyhONcOrjrSp92zKqL/dpQIM1jo7XyZjlvSb8ioG9RIGYbeCd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 4c993003-273c-11ef-8e54-005056bdf889;
	Mon, 10 Jun 2024 18:15:41 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jun 2024 18:15:40 +0300
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <ZmcYnDf0YIWA9A85@surfacebook.localdomain>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-4-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608141633.2562-4-laurent.pinchart@ideasonboard.com>

Sat, Jun 08, 2024 at 05:16:32PM +0300, Laurent Pinchart kirjoitti:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the GPIO function using the platform device
> registered by the core MFD driver.
> 
> The driver is derived from an initial implementation from NXP, available
> in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> adp5585-gpio support") in their BSP kernel tree. It has been extensively
> rewritten.

...

> +static const struct platform_device_id adp5585_gpio_id_table[] = {
> +	{ "adp5585-gpio" },

> +	{ /* Sentinel */ },

Drop the comma.

> +};

-- 
With Best Regards,
Andy Shevchenko



