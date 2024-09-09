Return-Path: <linux-kernel+bounces-321042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E1A9713B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25571C2273B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4881B4C45;
	Mon,  9 Sep 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uIlEsOGd"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684771B4C2B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874178; cv=none; b=g1GCmUSdnzCrhGHBIHp7b8OBd1wGNPfO87o6Zh+D9nASQXEfVQHGSZv7FIUy5WFQ7Xq7PLTu72qAYcnwdBU4v4H6/6c3t79fhR23+eqP1uD0/V85Tocxl9ZIkWQ0tX2Dz/+sgSYZNtOd285f8CDdZlyKOF1Jzpw6LEXGh7BSRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874178; c=relaxed/simple;
	bh=BN4tazxh3rpRIAWwNqOVoPdvVfcO1FwnyEStibweItQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJvCUWJiv5CBV+gC/sp3dqMbVkzQaJIcy/EQr5TBlIpraPR8PWcwtEXsGaihPnmRTjLr7AutGGsyOZjQyBO3GUY+8/LxXawCAddyur8COVPhRBY1j90SaCG7VdjA9Im99r4MynpPteuB9m5DzGxI7y0+Ocp9NyLfd242Ah4Qim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uIlEsOGd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4767D3F5B7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725874173;
	bh=1s6ErxBpBnN4TDCj/24ykKeIJzZtbIIx8kz5Yh/iY7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=uIlEsOGdbS0kmKEcS6LJHRWOl7ysI5H7sTrS7MRJLg3qnZAXTWeAu0EBo39seQSJa
	 lrLUIb4yvyymNi35TuprurJzRlxllsyIgh8wqRB8MvdTRa0QZwapM/fp6SQYnGzxwp
	 iwtgHdstNSoNXqGsc0cSxKc4uxHeNYOd0NJzdPO7ltphZ6GsbbV+YSyk0xJehAdk73
	 P2XzY7gnm9xg0y5EdvGfR9jaVnTCGEFCxcnR0FAaXPotfIdJl8jz9Ip+3AGzB9izNA
	 IfHFBXAytuZdIESEjszfEBICTnDmQmriyPtJn0rS1n6HmXgXdtf/qJnFkAmr49Cqnh
	 WL4d724I0r6SA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2053f49d0c9so55672655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874171; x=1726478971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s6ErxBpBnN4TDCj/24ykKeIJzZtbIIx8kz5Yh/iY7Y=;
        b=BYnmcPuFv4DCGfbRlBNh2q4jBrMjki51tugih5smw2auA73Vb83Fult45wsBX09Qlb
         gC4/o1otZCHn89beNvdaBpD3FKbBt0PE1EychRVwD7w8glB9eTJpovsA+Vo9waSkXwm9
         tzRXLWSQLXA+VDODngpywCJzxsuXA7o0L0//XyP8MCdmwtiljRyUlZkmbnzycFxoGR5c
         Dp52WGB/DFc+z66Tw33xc5kJN8epuF9nNQsyIuL6BvzC5g8ADbvR59+VEKAzURbDcl0S
         ni+90WO8uPuAaW7x+MFx+U0pahhtYK8YZS8dWeBBL/Pzdak0T0fdxPO4f31MHh+9SZTx
         KYxw==
X-Forwarded-Encrypted: i=1; AJvYcCXyPQU1tfbhY+XpRnL5DlbTBH1cHNvEextF3ZHzJhk4M6U9CNY/r56X+YoaQSsyCiMQH7oZNZd7f2vROVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQXGsuW/fnUYjeMUz85hVt9oHjZRqLLCVuupG28ERHrreIglc
	C8FBYpiXXsKAopSOj+HDnPYCw9R20d+L6wekbzWR1aaJAfZLrrpxTdVprjtCbMu29LEDVKQN/7g
	nwC2PXEHqM6YT8+mIcLjKkWRgPO2BGJ6ggdmbsimF992ohSGXcyvWSwUtG/2rUVIDyeK14toFWF
	JNir1d2lAQO3nC
X-Received: by 2002:a17:902:ce91:b0:206:b5b8:25dd with SMTP id d9443c01a7336-206eeb7a78bmr170498275ad.23.1725874171065;
        Mon, 09 Sep 2024 02:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOj9jqwDDJjKtB8eNNDnBjTUzIZm4sDUYK04l69QZOWzQRdEeA2WvR6/1IBLED1Y1FZtDrUw==
X-Received: by 2002:a17:902:ce91:b0:206:b5b8:25dd with SMTP id d9443c01a7336-206eeb7a78bmr170497875ad.23.1725874170361;
        Mon, 09 Sep 2024 02:29:30 -0700 (PDT)
Received: from [127.0.0.1] ([103.172.41.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e3757csm30355605ad.112.2024.09.09.02.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:29:29 -0700 (PDT)
Message-ID: <9fddd930-21ae-4e7d-86ee-c586af3b50e0@canonical.com>
Date: Mon, 9 Sep 2024 17:29:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] usb: musb: mediatek: Simplify code with
 dev_err_probe()
To: Lin Ruifeng <linruifeng4@huawei.com>, b-liu@ti.com,
 gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240907081351.19879-1-linruifeng4@huawei.com>
Content-Language: en-US
From: Guoqing Jiang <guoqing.jiang@canonical.com>
In-Reply-To: <20240907081351.19879-1-linruifeng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/24 16:13, Lin Ruifeng wrote:
> The combination of dev_err() and the returned error code could be
> replaced by dev_err_probe() in driver's probe function. Let's,
> converting to dev_err_probe() to make code more simple.
>
> Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
> ---
> v2:
> - The wrong message is modified.
>   drivers/usb/musb/mediatek.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> index 0a35aab3ab81..63c86c046b98 100644
> --- a/drivers/usb/musb/mediatek.c
> +++ b/drivers/usb/musb/mediatek.c
> @@ -416,10 +416,9 @@ static int mtk_musb_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ret = of_platform_populate(np, NULL, NULL, dev);
> -	if (ret) {
> -		dev_err(dev, "failed to create child devices at %p\n", np);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"failed to create child devices at %p\n", np);
>   
>   	ret = mtk_musb_clks_get(glue);
>   	if (ret)
> @@ -448,23 +447,19 @@ static int mtk_musb_probe(struct platform_device *pdev)
>   		glue->role = USB_ROLE_NONE;
>   		break;
>   	default:
> -		dev_err(&pdev->dev, "Error 'dr_mode' property\n");
> -		return -EINVAL;
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				"Error 'dr_mode' property\n");
>   	}
>   
>   	glue->phy = devm_of_phy_get_by_index(dev, np, 0);
> -	if (IS_ERR(glue->phy)) {
> -		dev_err(dev, "fail to getting phy %ld\n",
> -			PTR_ERR(glue->phy));
> -		return PTR_ERR(glue->phy);
> -	}
> +	if (IS_ERR(glue->phy))
> +		return dev_err_probe(dev, PTR_ERR(glue->phy),
> +				"fail to getting phy\n");
>   
>   	glue->usb_phy = usb_phy_generic_register();
> -	if (IS_ERR(glue->usb_phy)) {
> -		dev_err(dev, "fail to registering usb-phy %ld\n",
> -			PTR_ERR(glue->usb_phy));
> -		return PTR_ERR(glue->usb_phy);
> -	}
> +	if (IS_ERR(glue->usb_phy))
> +		return dev_err_probe(dev, PTR_ERR(glue->usb_phy),
> +				"fail to registering usb-phy\n");
>   
>   	glue->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>   	if (IS_ERR(glue->xceiv)) {

Sorry, this is probably out of topic. I had seen one relevant kmemleak 
report (probably false
positive) which is related to dev_err_probe.

[<ffff800083692200>] kmemleak_alloc+0xe0/0x120
[<ffff800080a1d7f4>] __kmalloc_node_track_caller+0x354/0x4d0
[<ffff800081443520>] kvasprintf+0xd0/0x1a0
[<ffff8000814438bc>] kasprintf+0xac/0x120
[<ffff8000820b5578>] device_set_deferred_probe_reason+0x68/0x148
[<ffff8000820a1844>] dev_err_probe+0x164/0x1b0
[<ffff800081ba00a8>] __clk_bulk_get+0x108/0x238
[<ffff800081ba0248>] clk_bulk_get_optional+0x20/0x50
[<ffff800081b9f294>] devm_clk_bulk_get_optional+0x6c/0x160
[<ffff800081791efc>] mtk_tphy_probe+0x38c/0x7a8
[<ffff8000820bbe98>] platform_probe+0xd0/0x240
[<ffff8000820b35c8>] really_probe+0x368/0xa10
[<ffff8000820b3de0>] __driver_probe_device+0x170/0x420
[<ffff8000820b40f8>] driver_probe_device+0x68/0x1f0
[<ffff8000820b47fc>] __driver_attach+0x234/0x558
[<ffff8000820ae1b8>] bus_for_each_dev+0x108/0x1c8

Not sure if this patch could trigger the same report.

Thanks,
Guoqing

