Return-Path: <linux-kernel+bounces-443057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9E9EE665
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B71883B89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEF1F238C;
	Thu, 12 Dec 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdGhHk4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E120B806;
	Thu, 12 Dec 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005529; cv=none; b=UYRWLBpkFKF1Mkb6Bz4x+9puaVyDnuCkLiIsmoQd7Jkjtie0TTh7qw3wbWDs4E/xuCKbCt6HiOP8Be7RzY0NPyzFXaAqj8/U0Yz17/U4xokxnwQrVf89mIgvAAiekzd9z17eIpIntpoNrSqnvn8etFYVOGRczy+9X7tLxDlaRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005529; c=relaxed/simple;
	bh=gzhoLnlyhsisr8XXEOVHmn4Ak7Rcg0/vRo9X4jsRgx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Idn+bso3K48hE3pjVLZkQiRp1mrhY+3kFmJpgwF6YB2gmWsbI3R4PpXnPREHpYHNwmpd+a74yJ2KkEn/bc26gje4vkHUNrR/nyuQU3t88tML8S84T5qFZ7dJA4a88WM/dPekzelKwL4/pYzW7i630KliO+iWGVrjgbsHwViCM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdGhHk4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBD6C4CECE;
	Thu, 12 Dec 2024 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734005528;
	bh=gzhoLnlyhsisr8XXEOVHmn4Ak7Rcg0/vRo9X4jsRgx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cdGhHk4+Z8uhoOyG4PSmBnMGT8hucNXHFHN7fB/otFY9h9Bcz1ozZO+5xXRDo0MXD
	 C5rCP5xnP7h+ZHfvODMRXQZyx8xhWWtBYqA9TaVLjocIR23gLkwLjqPgn2xSK/qa60
	 fmQu90Gki5BjZXvJwVmXcApOEOIaUsvAE5DFIW7ePqmX0Qd6h5H2v7TabTGKSSbUk1
	 cKCS4LiScwYbPd1YBXhjRbQkXdGvuN2wUwDB5YYxYv7LdA02X2mXHibn3Wx73iWiWK
	 w7XUniWUanZTetYIUm5dOuvljLhm4ISAg4ieary34SY1xx5FqqkQlwnGN+j/egBCsP
	 R4mO4YOptruEA==
Message-ID: <24a2c881-a322-4985-adb8-c424f08b3cd8@kernel.org>
Date: Thu, 12 Dec 2024 14:12:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] usb: cdns3-ti: move reg writes to separate
 function
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-1-28a17f9715a2@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241210-s2r-cdns-v6-1-28a17f9715a2@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/12/2024 19:13, Théo Lebrun wrote:
> The device probe function mixes management code and hardware
> initialisation code. Extract the latter into an explicitly named
> cdns_ti_reset_and_init_hw() function to clarify intent. It also will
> allow easier transition to using runtime PM for triggering HW init.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 84 ++++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 040bb91e9c017d8298a7e251fd0e192a336e8a52..d704eb39820ad08a8774be7f00aa473c3ff267c0 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -58,6 +58,7 @@ struct cdns_ti {
>  	unsigned vbus_divider:1;
>  	struct clk *usb2_refclk;
>  	struct clk *lpm_clk;
> +	int usb2_refclk_rate_code;
>  };
>  
>  static const int cdns_ti_rate_table[] = {	/* in KHZ */
> @@ -98,15 +99,52 @@ static const struct of_dev_auxdata cdns_ti_auxdata[] = {
>  	{},
>  };
>  
> +static void cdns_ti_reset_and_init_hw(struct cdns_ti *data)
> +{
> +	u32 reg;
> +
> +	/* assert RESET */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +	reg &= ~USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* set static config */
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> +	reg |= data->usb2_refclk_rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> +
> +	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
> +
new line not required?

> +	if (data->vbus_divider)
> +		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> +
> +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +
> +	/* set USB2_ONLY mode if requested */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +
here too?

> +	if (data->usb2_only)
> +		reg |= USBSS_W1_USB2_ONLY;
> +
> +	/* set default modestrap */
> +	reg |= USBSS_W1_MODESTRAP_SEL;
> +	reg &= ~USBSS_W1_MODESTRAP_MASK;
> +	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* de-assert RESET */
> +	reg |= USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +}
> +
>  static int cdns_ti_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = pdev->dev.of_node;
>  	struct cdns_ti *data;
> -	int error;
> -	u32 reg;
> -	int rate_code, i;
>  	unsigned long rate;
> +	int error, i;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -146,7 +184,11 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	rate_code = i;
> +	data->usb2_refclk_rate_code = i;
> +	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> +	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> +
> +	cdns_ti_reset_and_init_hw(data);
>  
>  	pm_runtime_enable(dev);
>  	error = pm_runtime_get_sync(dev);
> @@ -155,40 +197,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	/* assert RESET */
> -	reg = cdns_ti_readl(data, USBSS_W1);
> -	reg &= ~USBSS_W1_PWRUP_RST;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> -
> -	/* set static config */
> -	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> -	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> -	reg |= rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> -
> -	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
> -	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> -	if (data->vbus_divider)
> -		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> -
> -	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> -	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> -
> -	/* set USB2_ONLY mode if requested */
> -	reg = cdns_ti_readl(data, USBSS_W1);
> -	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> -	if (data->usb2_only)
> -		reg |= USBSS_W1_USB2_ONLY;
> -
> -	/* set default modestrap */
> -	reg |= USBSS_W1_MODESTRAP_SEL;
> -	reg &= ~USBSS_W1_MODESTRAP_MASK;
> -	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> -
> -	/* de-assert RESET */
> -	reg |= USBSS_W1_PWRUP_RST;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> -
>  	error = of_platform_populate(node, NULL, cdns_ti_auxdata, dev);
>  	if (error) {
>  		dev_err(dev, "failed to create children: %d\n", error);
> 

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger


