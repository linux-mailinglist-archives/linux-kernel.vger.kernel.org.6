Return-Path: <linux-kernel+bounces-446941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B482D9F2B38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BFF166370
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23291FF7A4;
	Mon, 16 Dec 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WaWU2szI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFF433C8;
	Mon, 16 Dec 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335781; cv=none; b=uGQrU3ObHwZgppDn3Cpw5Gt46ZPHrvCR6RQSdpl2DuUXUq6fjrwBwtt7imvfb/urNWQ1Krapxfq2Ejmen2zNGib8yf34xcL+9Rzuufu5AoVhokBPLrxUUalkXP1jmcqBUxOJi58zxRiuLj2xQY4VMoE8LJZpV+q2mRx4xf0EjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335781; c=relaxed/simple;
	bh=BaowDHCk84fcpAj3I+us/tU7AhDJ3g/6unYBqiPNb8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb/Z4f6ClaXDpeuT9HZ4MaNqAKPYOoxXPlUCRajX7yuHhl3c63WxXuzN0Pw6Lqow4XZT7DJVkVrs8ioEG71Uk2WIDuWnRCOFH3Po+8AhG2XvgBU6gIfc6AucyrSyky76EWxi6AASfswuF1URpQOPRddKUVmimPSwh2PUQU2dW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WaWU2szI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E24C4CED0;
	Mon, 16 Dec 2024 07:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734335780;
	bh=BaowDHCk84fcpAj3I+us/tU7AhDJ3g/6unYBqiPNb8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaWU2szIWTCvVUoSZZisx5kTaVYa2C4tqbvss44GLPqIRVX122d/25W5AhqlXuTyD
	 IUTYO8niQNQn4hnb5VH1KY8rrpVSkrQwgWUh083QFeyKARuNoxi+frUigCiatNMyp7
	 3WSsjovA2S5/3cxaoCXcpDy1E0xl9/mHrgWJtJ7c=
Date: Mon, 16 Dec 2024 08:55:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: u.kleine-koenig@baylibre.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] usb: gadget: m66592-udc: Add check for clk_enable()
Message-ID: <2024121606-preflight-lure-e02c@gregkh>
References: <20241215205358.4100142-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215205358.4100142-1-zmw12306@gmail.com>

On Sun, Dec 15, 2024 at 03:53:58PM -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.
> 
> Fixes: b4822e2317e8 ("usb: gadget: m66592-udc: Convert to use module_platform_driver()")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Why this order of signed-off-by lines?  Shouldn't yours be last?  Who
wrote this patch?

> ---
>  drivers/usb/gadget/udc/m66592-udc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
> index a938b2af0944..bf408476a24c 100644
> --- a/drivers/usb/gadget/udc/m66592-udc.c
> +++ b/drivers/usb/gadget/udc/m66592-udc.c
> @@ -1606,7 +1606,11 @@ static int m66592_probe(struct platform_device *pdev)
>  			ret = PTR_ERR(m66592->clk);
>  			goto clean_up2;
>  		}
> -		clk_enable(m66592->clk);
> +		ret = clk_enable(m66592->clk);
> +		if (ret) {
> +			clk_put(m66592->clk);
> +			goto clean_up2;
> +		}

How did you find this and how was it tested?

thanks,

greg k-h

