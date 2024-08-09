Return-Path: <linux-kernel+bounces-280272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A3B94C7FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5697B2396F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD1A8F66;
	Fri,  9 Aug 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd4cEORz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F68BFC;
	Fri,  9 Aug 2024 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166477; cv=none; b=MQBgtgKwJvK2qhVlsM5AizQ1qTclzvXb3n8oI1+kXC/p0CIBjA4p4zEwwjlHfdcpc4OU7vwkeUPq5ognKNXo4B5EMTe3nJR/AhG0S+kmLshuiIFGh+vWf55zXqUHs0h5mrpsnSh0mUZnLtck3q6FSSYfKxq5WqEz6hEwwS19CEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166477; c=relaxed/simple;
	bh=LCyBe1tA4zdG2wJLz9kV+ZRo3NmRqgcBAdqMq7ml4tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzTby+I0pRcgnmze4iP0kq5wSU9pZHNqy7pD5wIZ6kChvfNxM9YMXCfpPgm8lq2VJOR4qbwOjnGQ9JoqAcE8gnZ21NaRD89RRjc2Zia42Gu+FsxuJluM3pmRTsrpf6KWEIoISoYxx4dnqOMeMIQndXTdw5cXiDZq6wWfeqOPChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd4cEORz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33153C32782;
	Fri,  9 Aug 2024 01:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723166477;
	bh=LCyBe1tA4zdG2wJLz9kV+ZRo3NmRqgcBAdqMq7ml4tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd4cEORzJr17CaXC+6578qIZqPq7psqloTUI5ZGW9jUWp8qxGH4rddchWVoFj7eXJ
	 YMTcVKup14nkRvtFgGmZg4xbD0s8wqpgOmGN/JKoncAisA4Q0yIEFxmlvNsrJfi8zF
	 t1Z/fucCQlggn0UoWHFNqchkqLjLaMDhwIyaKZb+/2nMpsSVao0aWLlPDSR+YXLYKb
	 AYhK+JT95/YO1mIV4O6UYnCv6Wu1Mk802NICgHI+hQfg0BViOEYw8kijkaKGBcYDps
	 0p7t3NZbkwUkKd50SEbs5lJu9yKknhvFz5lArHLHpMQRxISoUL3VaR5sdOi3KH7EEr
	 zoAMqB5FVMz7A==
Date: Fri, 9 Aug 2024 09:21:09 +0800
From: Peter Chen <peter.chen@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: Use of_property_present()
Message-ID: <20240809012109.GB2673490@nchen-desktop>
References: <20240731191312.1710417-18-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-18-robh@kernel.org>

On 24-07-31 13:12:56, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index bdc04ce919f7..c64ab0e07ea0 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -128,7 +128,7 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
>  	 * In case the fsl,usbmisc property is not present this device doesn't
>  	 * need usbmisc. Return NULL (which is no error here)
>  	 */
> -	if (!of_get_property(np, "fsl,usbmisc", NULL))
> +	if (!of_property_present(np, "fsl,usbmisc"))
>  		return NULL;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -- 
> 2.43.0
> 

