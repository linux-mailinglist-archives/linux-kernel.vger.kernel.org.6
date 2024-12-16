Return-Path: <linux-kernel+bounces-446943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705D9F2B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40D0160FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207A1FF7B6;
	Mon, 16 Dec 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuZNvDLs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A411FF60E;
	Mon, 16 Dec 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335813; cv=none; b=AzXp+9I5nNRpK4/rY9tK/CJF76MVp1BjbEeykY3F1M/wNrbBsI8vLREL9sycsHpRtxigPSPKPwkCT6AEZpiptt04Hv6wmT4cfpFMWQpGZHspxFEYziA2qqIR/b3iaAQkWEODTgj2/bAUG4Lmbua2d8hHbeL9kodraMAe7+Noi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335813; c=relaxed/simple;
	bh=z8TFdYAtNy0T8xlcYZ3y7TVAVuBAhWw6Lq7zhM7gPKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqPyfGb+WESozrSa9JekCLNZjvAI/7E9OLoZIXpVuCb5JCcKtgwNbO5CC83+VdopxgS6rp+ytqDJl2KOIwKHRaR+mYSr4CEQW78kc83kMzWnmUsn39MvmUET8HTEJegE8kvMqrQvqbWca7LJ4Jq983fYIxRLVBA9OSzREb6bW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuZNvDLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F04FC4CED0;
	Mon, 16 Dec 2024 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734335813;
	bh=z8TFdYAtNy0T8xlcYZ3y7TVAVuBAhWw6Lq7zhM7gPKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vuZNvDLs6dN/3OnKBFNwvg3TRXSdWCTQorCrdsPqbcH+KAFcXcEspvbbB2KFO41NJ
	 ZEbVWP8t5lQETthI0Tm8x3kP24rM4q//SVrKGTu87Q8ICBYBsMeDERewJmsrhWznL7
	 IQ7JCFvEUDrvuhkZkhvFX8e2z54gCYFYyKpqiVL4=
Date: Mon, 16 Dec 2024 08:56:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aaro.koskinen@iki.fi, balbi@ti.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] USB: phy: tahvo: Add check for clk_enable()
Message-ID: <2024121649-dreadlock-undesired-d9de@gregkh>
References: <20241215210006.4114454-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215210006.4114454-1-zmw12306@gmail.com>

On Sun, Dec 15, 2024 at 04:00:06PM -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.
> 
> Fixes: 9ba96ae5074c ("usb: omap1: Tahvo USB transceiver driver")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/usb/phy/phy-tahvo.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> index ae7bf3ff89ee..0b8801318cd2 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -342,8 +342,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  	mutex_init(&tu->serialize);
>  
>  	tu->ick = devm_clk_get(&pdev->dev, "usb_l4_ick");
> -	if (!IS_ERR(tu->ick))
> -		clk_enable(tu->ick);
> +	if (!IS_ERR(tu->ick)) {
> +		ret = clk_enable(tu->ick);
> +		if (ret)
> +			return ret;
> +	}

Same questions, why the signed-off-by order and how was this found and
tested?

thanks,

greg k-h

