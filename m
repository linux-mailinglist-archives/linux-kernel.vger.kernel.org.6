Return-Path: <linux-kernel+bounces-296594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1668A95AC92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19641F22421
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18723D38E;
	Thu, 22 Aug 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrR6V68Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E481BF2A;
	Thu, 22 Aug 2024 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300815; cv=none; b=uApI+WIbd+53hW4nGrgMtCiK15/+76hQNBeBz7rQzoi7SqbGiMthT9INHXPSCytYH6raX3b6eq0qXJxr5hJtgle7UA5Webt/pvhwMpw/Pl4U8hXiJ5m2q7LFd0OsGAYjkk0K3YlCjOOsS/8G+oDUfUna1qi71pcrINunmPDfY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300815; c=relaxed/simple;
	bh=vH1hkgrRUpB1Fxi+zqhCcwdl2caWcSsBMzt+Av44d8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSgqwv+NzUa5YNyjLlKhQ5kvU1TwqbUWlEtj+8QkMu34785qwmaST0Ah98TvDTp/jAFj/4LFWZiZcQoKOiIpypSY+Ss0+vY9V/J2560sqXMYCvKPBsU0zoyD+xfYcOVokf3HBPod26W4rj7yvdX44DV/xN4QRewjVoGpEm4CAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrR6V68Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CC6C4AF09;
	Thu, 22 Aug 2024 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724300815;
	bh=vH1hkgrRUpB1Fxi+zqhCcwdl2caWcSsBMzt+Av44d8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrR6V68Z8TGghTu18GVdIYBnnYJuF6Y4AgCuC5UHChF2yXmeUGeckuea7LW+e9rkS
	 ta7WlFoiZcX5QOndp2e16UjCVE4V9AEf/2+5ieqxWTtogySnjD3/vcBlSmZDmjXdro
	 BggdDNNagVnfEf0Ix+s1pFWhf6lABC9rktij+kLc=
Date: Thu, 22 Aug 2024 12:26:51 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Neal Liu <neal_liu@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
Message-ID: <2024082240-gallery-stinger-5901@gregkh>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
 <20240821121048.31566-3-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821121048.31566-3-liulei.rjpt@vivo.com>

On Wed, Aug 21, 2024 at 08:10:40PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
> ---
>  drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
> index 1a6317e4b2a3..6e99e75f1acb 100644
> --- a/drivers/usb/gadget/udc/pxa27x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa27x_udc.c
> @@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
>  	if (udc->gpiod)
>  		gpiod_direction_output(udc->gpiod, 0);
>  
> -	udc->clk = devm_clk_get(&pdev->dev, NULL);
> +	udc->clk = clk_prepare_enable(&pdev->dev, NULL);

You didn't test build this code :(


