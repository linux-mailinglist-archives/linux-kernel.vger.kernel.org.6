Return-Path: <linux-kernel+bounces-399022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A989E9BF9AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6651F2220E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8FE20CCF0;
	Wed,  6 Nov 2024 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlniAT2i"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F613A244
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934230; cv=none; b=HoY4P1JsdRyKeoUD1IKnLGLn5Bv8sTVJFoAIeJNNyw9sDF5YelgqS7tfuggQz/b6VNr877RCzkXFboCj32s0F7Gb1yVEk1upVdfkQ3hY80EqPIosXIbzWdsyLdq9HS99h/66D7ao2GZZ442E+DOraCMHlulBK0rx/pe6luBbzXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934230; c=relaxed/simple;
	bh=2m3lGSb0KPE5zZ2Db41fVxKYqG6pSElwHvTQFR4SvdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3lOJMIl0+r9wVkgUknyAPXaKWMsACDs5cQjUE+QlFRWMkjcrwkzXGdRQLUEWGuj1Dj4ytTBlNY1gPE8nh6xerDzL0Ztg/b4fgPWtlXbYGewJE+Atb9otMv6zK4JuWhKWfJEeG+UXcwy2cr1gzIOSYBGCziFF1BOBweTfe1Vk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlniAT2i; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83a9be2c028so13370439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730934226; x=1731539026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9d2gmeIZhRgxPs/QSdKvrnEtcel9X904K+JgPPLUDA=;
        b=YlniAT2iuNJrph7yBz94aFd9UJiJZImS+7hgRg/eFHykZLsr0oeawH86WgDVeWF0Bn
         hUs4jj2b3vvR0Z8teu5jXa1Wo61Q2JwK98QfOxJnHEGbltma5oF3O3ofbVFMKhl8cnfg
         CX3E70KrXAY9EBONXHa2KHr5YXQa6G8pmTn9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730934226; x=1731539026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9d2gmeIZhRgxPs/QSdKvrnEtcel9X904K+JgPPLUDA=;
        b=Qpv3haHygtrrSDsfh3cu8rWWp80cOYe2YPI9l74RL6AduCG0r3RpzOUuL5S+4BXLvC
         y9+c5z5TQyDmu4AKkPaCWXuULEb0ULMqGmaYeGK/Fj4I0RT5cAFvMfxdr0hL+z2o7w9u
         TUCXyJmSA/My9UoNuZJ0pQ+Mm5gWPHMALaFCXu+lMnkX7sQeQwyuGFH2SblBg72VY80q
         hnd/D3Ovjo2QA8YmmpjQgfJQ6TBdcdJ2xaPnp3S07UAWYtt/HybuGbxvN0vHiyYflg7H
         JYP5/kzEJ1gsJX+p6tOTK0RaWpCXVDWxi75z5NXknV0K2GAqoCXiA1Qj4A4ZzeIP6h9I
         Fj8A==
X-Forwarded-Encrypted: i=1; AJvYcCWyu3VhpC9F/FYoi77sprucClIzcnSobmxZ6cQ0Lcj0ynXUPcAjuGarRY2U+lzCwF6Dgt5GwTUT8Xvioag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PINFEaImu1PtPsKUOwhqMTjjN1d29tk8cMkPl+kD7QK+mYb+
	4n0kdBwWqON8wX1yDuW91qzoqf51KV2vDm9BlIzVr4R0qlu9MvKsmtVPEFRGsW8=
X-Google-Smtp-Source: AGHT+IG7HfSv2eyFIIKMy444jXmnmiWXPCH2AIv/dcp59B3nkjEgN8YGo6DZoIeWAXAVpXt23BaENQ==
X-Received: by 2002:a92:cd86:0:b0:3a3:35f0:4c19 with SMTP id e9e14a558f8ab-3a6b03b0cd2mr218205245ab.21.1730934226357;
        Wed, 06 Nov 2024 15:03:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f83286fsm33597173.77.2024.11.06.15.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 15:03:45 -0800 (PST)
Message-ID: <a18a7906-b213-4dde-abfc-2503250ad1bf@linuxfoundation.org>
Date: Wed, 6 Nov 2024 16:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: omap-usb-tll: handle clk_prepare return code in
 usbtll_omap_probe
To: Karol Przybylski <karprzy7@gmail.com>, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, lee@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106223324.479341-1-karprzy7@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106223324.479341-1-karprzy7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 15:33, Karol Przybylski wrote:
> clk_prepare() is called in usbtll_omap_probe to fill clk array.
> Return code is not checked, leaving possible error condition unhandled.
> 
> Added variable to hold return value from clk_prepare() and return statement
> when it's not successful.
> 
> Found in coverity scan, CID 1594680
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>   drivers/mfd/omap-usb-tll.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 0f7fdb99c809..28446b082c85 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -202,7 +202,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>   	struct device				*dev =  &pdev->dev;
>   	struct usbtll_omap			*tll;
>   	void __iomem				*base;
> -	int					i, nch, ver;
> +	int					i, nch, ver, err;
>   
>   	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
>   
> @@ -251,7 +251,11 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>   		if (IS_ERR(tll->ch_clk[i]))
>   			dev_dbg(dev, "can't get clock : %s\n", clkname);
>   		else
> -			clk_prepare(tll->ch_clk[i]);

Braces for the conditional don't looks right.

> +			err = clk_prepare(tll->ch_clk[i]);
> +			if (err) {
> +				dev_err(dev, "Unable to prepare clock\n");
> +				return err;

Did you check to see if callers handle this new error return
in this path?

> +	}

Same here

>   	}
>   

Same here
>   	pm_runtime_put_sync(dev);

thanks,
-- Shuah


