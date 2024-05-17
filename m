Return-Path: <linux-kernel+bounces-181697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329A88C7FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E559A1F2230E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA75748E;
	Fri, 17 May 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1s9TQL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAB8F45;
	Fri, 17 May 2024 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912473; cv=none; b=eN9n3noCYn1InJa5F/5ApAX4ibBp0JMRg9nBZndWXh4Y1B7fjo/GojH94+QhSykPIk5+D4iRePTucL2b+KSJOaECbhyGCvNuS3wB8pwxPdgjxsuLMzFrspwYRBQZy74nQE7UAkbJRNHCcAJ1YRtY4e328E9qe+gtP86/AZjAeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912473; c=relaxed/simple;
	bh=lv+BFypM/MGqDiKUng9ESU1q6Q2cfSZHaaPNHlF+Oag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hnf0a3RR7n6SUdGxXmnVoH51OzPG8knLuj8K4g9J4x1lDY0HO2k7C9sRRAqauLtxKyJD8SMthudL/392/tUgj1phFarEyOefPj00idG3+608xVyH1TxbZIiMn0ROWUpDhYPOp2gDYPbQE0bkFIcbDSJxNdE/0OjeLcUPpccTwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1s9TQL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A26CC113CC;
	Fri, 17 May 2024 02:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715912472;
	bh=lv+BFypM/MGqDiKUng9ESU1q6Q2cfSZHaaPNHlF+Oag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1s9TQL3sXeZUGIgQ0N8ea49nwiSCidex/mkoBxvb4jzbsiMMIWhQARLbw/X+ISen
	 B8GdLbQg7db8QieZoZSH32NwKOVaw6R7ciO7RoOuSlS91OJStRCXjpcBdnbsWLA4Eu
	 98Uf6pWJcgrqd+D2bGXXeRsmuEXKfySJ4pRA8hoD5uV9bWh3N4jHhD+b8B5qbAQC/2
	 FfUlXyeE+v7dyHXk0OGB0orJTwFA1HlNCy95Ejohl60D5wwCjFR5Ch7UgN7xKKznx6
	 VxsaNZI1hoS8/POF6WFIbGEg9cBx7qmj1IaOf/Bzf7w3PloEkujhI9TMLOhT+sttlt
	 XO3rIQ4akm2hQ==
Date: Fri, 17 May 2024 10:21:04 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH v3 2/2] usb: cdns3-ti: Add workaround for Errata i2409
Message-ID: <20240517022104.GB3458484@nchen-desktop>
References: <20240516044537.16801-1-r-gunasekaran@ti.com>
 <20240516044537.16801-3-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516044537.16801-3-r-gunasekaran@ti.com>

On 24-05-16 10:15:37, Ravi Gunasekaran wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> TI USB2 PHY is known to have a lockup issue on very short
> suspend intervals. Enable the Suspend Residency quirk flag to
> workaround this as described in Errata i2409 [1].
> 
> [1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> Change log:
> ----------
> Changes since v2:
> ----------------
> * No change
> 
> Changes since v1:
> ----------------
> * No change
> 
> v2: https://lore.kernel.org/all/20240516042845.31211-1-r-gunasekaran@ti.com/
> v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t
> 
>  drivers/usb/cdns3/cdns3-ti.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 5945c4b1e11f..cfabc12ee0e3 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include "core.h"
>  
>  /* USB Wrapper register offsets */
>  #define USBSS_PID		0x0
> @@ -85,6 +86,18 @@ static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
>  	writel(value, data->usbss + offset);
>  }
>  
> +static struct cdns3_platform_data cdns_ti_pdata = {
> +	.quirks = CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
> +};
> +
> +static const struct of_dev_auxdata cdns_ti_auxdata[] = {
> +	{
> +		.compatible = "cdns,usb3",
> +		.platform_data = &cdns_ti_pdata,
> +	},
> +	{},
> +};
> +
>  static int cdns_ti_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -176,7 +189,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  	reg |= USBSS_W1_PWRUP_RST;
>  	cdns_ti_writel(data, USBSS_W1, reg);
>  
> -	error = of_platform_populate(node, NULL, NULL, dev);
> +	error = of_platform_populate(node, NULL, cdns_ti_auxdata, dev);
>  	if (error) {
>  		dev_err(dev, "failed to create children: %d\n", error);
>  		goto err;
> -- 
> 2.17.1
> 

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen

