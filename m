Return-Path: <linux-kernel+bounces-311612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB1968B26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9363B219FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BF1A2643;
	Mon,  2 Sep 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK+/DZTG"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379C1CB51D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291354; cv=none; b=j2DKhekKTk3GAogxnfZqIkJBXX+4xDJtXHLzjQMNmIWSyB4IwBRD/bzvXLMS8QsLnzi5ezsR8LzLs7N6wlD3mcxMaKBucCSnEfmAy9pzly2VQw2utPd8x9BFqibkcSBiA0HY17V+dcFhMdSah4j+Vqrm3NV+8eNJeeocaczPrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291354; c=relaxed/simple;
	bh=4+TcXigTdt/8hkbj2N+6CM9RgDscVrVC2mjY5DaTgeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1MnKnBJS3fuLTFQQ3T36zPO/aYTJ5hXY5jjpwTTdNKvKFDcs3ScXsTovYa5UoJwWTF1oo65Nw+Pk2zjCfP5aPhS3FpPf7vMon6/GTtQjINh7bkRxJe6BxZ8wzRn/XT0LBXyOTjBlop5nIA4JnRG/bp0wOBfBaM85FcI8kHhRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK+/DZTG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d3cd4fa49so14130515ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725291352; x=1725896152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oatbIoqJeiz1r5S9oalVSgxEcEqEqUpERpHFaw/Rf+I=;
        b=kK+/DZTGV857LWmsCwA35KLVXyZAO7n2ns8GhyGLRMihG/2KoV/pj+KW/eK64lUe8E
         B8iVrGsudA4bHwyRhvb6cHIUUwiQ499VJ4Ots8lB39zyD9C2lV+Uvt6MKljNkRzslrUi
         9briyxQfcs6VZN9DRgPeoXRAyqwOIWST1r8DIIbA559mzp/07uy3Ft5XnON+Qp4d+LXG
         PLhIU2fQebwqZLah0zLQL7unMvt2ANA9wqDWDlCoCK88UAV8fu04vUhW83HPGfUQpIYG
         wbADgzqMSVdkZSEjdI4uzDpjPZTOEVu0TCFSPsVEFi+IEFwS4MTEfhN3zstqCrhav21R
         SPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291352; x=1725896152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oatbIoqJeiz1r5S9oalVSgxEcEqEqUpERpHFaw/Rf+I=;
        b=VUu0qJVu1rusBNFZ9aFhLH2/zWrhsgWzhEAcwQKC94qE0CEfQV/wfynAGgBKLUhDtu
         1SxxCZXhuvl4ux+grOaze3PS7yGxIeqgceXAco4o3DgpTlV6uSYTu7hSPU9m9IRHmpRD
         bV09h3g8msCGyloQCpnIcjY6Xs5b+dIGB3arPa1qgIZJVKHV60Hx0Ne6MOextIBanQoP
         z7qr7U8Go/RSagoO/ium30MXo+owA+bMwTZng7hXeurHwGy6kdMHLaBkdpGVVf/N+m4w
         HC1748aiu0KpwA74TY2+qahOFW2HU4CIQ8g488870wqbOFtTnuZ48i9HPBz3uQsZDbnI
         GV0A==
X-Gm-Message-State: AOJu0Yz2UpyDmVuDM/GajGAsXUkfQuOLTxbFAZ+q3WslSV22lqCDO235
	uIooBoT8+89GgX3ClcZBYdG8JVan07LaiJQZgX0klh3X5F0KEwSNPCZm/w==
X-Google-Smtp-Source: AGHT+IGYxXRE9ElJTBYT03Z4rxLGq3EvcKdSNQ9rIPxYV0YnvW8G3doE+O8CiwFNbCLGCtAIAComvw==
X-Received: by 2002:a05:6e02:1ca8:b0:39b:35d8:dc37 with SMTP id e9e14a558f8ab-39f413ff0fcmr64430575ab.13.1725291352363;
        Mon, 02 Sep 2024 08:35:52 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f51aa0a6fsm14393165ab.54.2024.09.02.08.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:35:51 -0700 (PDT)
Message-ID: <0cd84a80-589c-4706-b798-0d7808488ee2@gmail.com>
Date: Mon, 2 Sep 2024 17:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: mediatek: mtk-mmsys: Simplify with
 dev_err_probe()
To: Yan Zhen <yanzhen@vivo.com>, angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, opensource.kernel@vivo.com
References: <20240902053001.930379-1-yanzhen@vivo.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240902053001.930379-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/09/2024 07:30, Yan Zhen wrote:
> Use dev_err_probe() to simplify the error path and unify a
> message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
> 
> Changes in v3:
> - Modify the message.
> - Add the '\n' at the end of the string.
> 
>   drivers/soc/mediatek/mtk-mmsys.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 938240714e54..170319163c28 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -397,11 +397,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	mmsys->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(mmsys->regs)) {
> -		ret = PTR_ERR(mmsys->regs);
> -		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(mmsys->regs))
> +		return dev_err_probe(dev, PTR_ERR(mmsys->regs),
> +				     "Failed to ioremap mmsys registers\n");
>   
>   	mmsys->data = of_device_get_match_data(&pdev->dev);
>   
> @@ -413,10 +411,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   		mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
>   		mmsys->rcdev.of_node = pdev->dev.of_node;
>   		ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
> -			return ret;
> -		}
> +		if (ret)
> +			dev_err_probe(&pdev->dev, ret,
> +				      "Couldn't register mmsys reset controller\n");

Your missing return of the error value.

>   	}
>   
>   	/* CMDQ is optional */

