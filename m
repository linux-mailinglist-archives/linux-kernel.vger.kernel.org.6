Return-Path: <linux-kernel+bounces-319695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D49700C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C707285752
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80214A619;
	Sat,  7 Sep 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAXFqDdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1D13A863;
	Sat,  7 Sep 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697042; cv=none; b=dHhcFyJFGCgHEYXxPDgRANY6eQDM+wRf30PC6rYpWh3x9U+JjBUw9kWzvKAUw1ILHpA7dLWegFUuWhkRaZvW4krlFIAyOrJyxxjDNvkYpxEZ5S6bG8Kc4OLjgGIZdxkiir+BqzY3Rsw1FMU+qaU9vJskR6shMf3fZqycL2fUmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697042; c=relaxed/simple;
	bh=huYN6+MlW4CvxdcII51CVqGSD+IQZTvKcJcE+Wu8Tpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC94BoEUr+sTp7tAQ6a4k1D2wxTJSpkL2tGaOu0XDLVgPnB0RdHj8kyffQSn0kirmU0Jcod9fAcXi5WWUFkbC43yLlJFBZiHLyEdnycy36pL25Km9WXtyde2W3+t05mNmqsKBZgMUY6LfBckVCznR7Pf79GIXrzFTLpNUnnrud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAXFqDdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B7CC4CEC2;
	Sat,  7 Sep 2024 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725697041;
	bh=huYN6+MlW4CvxdcII51CVqGSD+IQZTvKcJcE+Wu8Tpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAXFqDdEXiYpfLW+ebN3NkO1UDKgBJyiF56peYQp+dxd6PzkZNmCKHFEd2siokpoX
	 2oNAjQO6S2QVy89MuxCM5Lh3VZ3ZwxBXWGoZtoymEJQyzMy9AdP4EJWMQBL/2dNuDS
	 z+/ClfuecoUhMLU0NrV4CImTbcbn+RFg4rOF337w=
Date: Sat, 7 Sep 2024 10:17:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Ruifeng <linruifeng4@huawei.com>
Cc: b-liu@ti.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH -next] usb: musb: mediatek: Simplify code with
 dev_err_probe()
Message-ID: <2024090704-jingle-playroom-7411@gregkh>
References: <20240907075508.79889-1-linruifeng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907075508.79889-1-linruifeng4@huawei.com>

On Sat, Sep 07, 2024 at 03:55:08PM +0800, Lin Ruifeng wrote:
> The combination of dev_err() and the returned error code could be
> replaced by dev_err_probe() in driver's probe function. Let's,
> converting to dev_err_probe() to make code more simple.
> 
> Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
> ---
>  drivers/usb/musb/mediatek.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> index 0a35aab3ab81..63c86c046b98 100644
> --- a/drivers/usb/musb/mediatek.c
> +++ b/drivers/usb/musb/mediatek.c
> @@ -416,10 +416,9 @@ static int mtk_musb_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ret = of_platform_populate(np, NULL, NULL, dev);
> -	if (ret) {
> -		dev_err(dev, "failed to create child devices at %p\n", np);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"failed to create child devices at %p\n", np);
>  
>  	ret = mtk_musb_clks_get(glue);
>  	if (ret)
> @@ -448,23 +447,19 @@ static int mtk_musb_probe(struct platform_device *pdev)
>  		glue->role = USB_ROLE_NONE;
>  		break;
>  	default:
> -		dev_err(&pdev->dev, "Error 'dr_mode' property\n");
> -		return -EINVAL;
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				"Error 'dr_mode' property\n");
>  	}
>  
>  	glue->phy = devm_of_phy_get_by_index(dev, np, 0);
> -	if (IS_ERR(glue->phy)) {
> -		dev_err(dev, "fail to getting phy %ld\n",
> -			PTR_ERR(glue->phy));
> -		return PTR_ERR(glue->phy);
> -	}
> +	if (IS_ERR(glue->phy))
> +		return dev_err_probe(dev, PTR_ERR(glue->phy),
> +				"fail to getting phy\n");
>  
>  	glue->usb_phy = usb_phy_generic_register();
> -	if (IS_ERR(glue->usb_phy)) {
> -		dev_err(dev, "fail to registering usb-phy %ld\n",
> -			PTR_ERR(glue->usb_phy));
> -		return PTR_ERR(glue->usb_phy);
> -	}
> +	if (IS_ERR(glue->usb_phy))
> +		return dev_err_probe(dev, PTR_ERR(glue->usb_phy),
> +				"fail to registering usb-phy\n");
>  
>  	glue->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>  	if (IS_ERR(glue->xceiv)) {
> -- 
> 2.17.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

