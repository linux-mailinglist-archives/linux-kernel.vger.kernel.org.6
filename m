Return-Path: <linux-kernel+bounces-512513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9159A33A54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C9A7A3699
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248D20CCD2;
	Thu, 13 Feb 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgFwiH1/"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E920C49E;
	Thu, 13 Feb 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436952; cv=none; b=NnUGNX8qgNOgJdm6k/vpOKan2H4XEpM91W1d3fVzI70jYPeWLm2Jdn6xobYduXr23TzA4Ocwgvu8FBDOVkriDuSAsQRaRHS1JOYOTMDDxrm/jzUvMk9QBmg1+qNymkM6S+OiTs64AMP5cSxpV1p4Dgoh+wU3RrCQVpXXPDJYb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436952; c=relaxed/simple;
	bh=b9Piwl1nQzB7vJzY0MVy96I/7TITjuMOl/dFawyQO+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAC1nqsGiw8Q3b0lO2CpL2Ppqtefj+rkKEJznLWdL5R1dcV9V9h7R+rdwsMsGXAKUaYxA4iJytUi+LEY0HQkL+BLrUJUEGzIAccFSRoOVScFyYtF1NGYSJmxKzJ/gOhW8dPTDKCWKwb9oDHdpre86AZqpP7ldTT6mMuNf4X5lUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgFwiH1/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307bc125e2eso6948241fa.3;
        Thu, 13 Feb 2025 00:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739436948; x=1740041748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISvOoc8ZLh2lLWyF+k1j00TNjsRMMcy7FI/7Z6/03RE=;
        b=NgFwiH1/f8kLzy9k7IRglRyuXKRV6jWAWxI5bZlgMQ8bnXhnhHn2d1sDU+Og0jE9FM
         oXrNE7RmvHnToZAVzerp79w7giPNpy300Ph74U69H5fso+bGBhqiDMOX4x37IPgiFhe7
         UkzblpJW6WItOvx65yomcupr7IwJulko79/BOL2dBOAblJHRZKdiv7+HqRyHUW/DxKBP
         ZaxJK/yzylh5lPZcaCAisy9ybiWPZ+df5ZrigBQbX43GsYhEz8ebYOO39GlvA9A5X13/
         HZWNwhrntZEPS6m+5aEJ+iJ8eZ+w4NdbM2QuH/lw+MWyZEnx7pnYhPJg173KKorvnPSL
         NEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739436948; x=1740041748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISvOoc8ZLh2lLWyF+k1j00TNjsRMMcy7FI/7Z6/03RE=;
        b=DyUrSvGkoHpJYVp+IrGjuUSE/Q/nzGSBRgSdAft+WvFi1PRtefnLIRTJ+c3fDBySop
         Xr9nWAe9Wtlgl6M6j7TKdb5Rh3A/4pHJsKAMYRe5JcbYF8hmnco33XZJ6/2T2QPU+SjI
         yTn7pVBnPsHeD/oMi/8SSdhe8thrRvEK4032T+uP0hCfxmmmit8anIj9rBqD5ZxokSfw
         W2O6TxgelJZCugvYwh+3azVRqQGYP56+tRAUDZITkIN/juJQxbgfkbAOlVYNgm6jE6XE
         3QPITqf/hz2dxR4qdZa3dw31BacWtSzPuBoxF+rvNiynx4tPclEsI2b5ZUtxtcwYM1+5
         085g==
X-Forwarded-Encrypted: i=1; AJvYcCW+rtbmzZugtO1WzUtqk48TRgHUb1Br5md10ylNiieUqrplIw0GHkv35CfduFhig+YlXneT8488FiDUo5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf02yGFuvs8+ZeXTlsenBxDuVeD6YFrrUvl6M7zUzntqco3BJM
	YGYN5WwtBNGc19fHWks0+41PEmxniYDTgKyTOTWFXMmAKtK7KJ9QWqpxEQ==
X-Gm-Gg: ASbGncuaMCdybX+WaONKVhk27RJCJkb4G5trmtONTe6qwiowNT+iACR38B+R2ft0flz
	BHPyRedljXUqsFboIokKSg9lgm+V7Jk5mPdZCHtaz/sN0GThER2OperoMQCB2Lcz2758jGxVlDg
	WOvyKXIlu84JJrQ87U9GUoLym33lGEH7HjEoU7D9mN2CNarmWJubVpTpTaUXvh0PnlerGJ3IAmR
	F1l3rR48ZCqhprgAQsVQKVom9IIJlBr3/s5yoy5CItWwrYJkSMb0YnOKaezF7W238cum4dpjH+Q
	zJSd3GaDYrxlGE6UczRCHXYGw+/VAzLaHkYX8FCAIKLvs+PlRR//8f1sPwBbZBBfjLmMOD7W
X-Google-Smtp-Source: AGHT+IGW8hG4ZSdW4/ynvfOmGmfyG4J7bnB6/czfWfePjml4V4zcl/kwzU92567pa0MdZPlL5FAAdw==
X-Received: by 2002:a05:651c:2106:b0:305:d86a:4f01 with SMTP id 38308e7fff4ca-3090ddc6cf8mr7698091fa.31.1739436947507;
        Thu, 13 Feb 2025 00:55:47 -0800 (PST)
Received: from ?IPV6:2a00:1fa0:48f0:1acb:121e:9475:d238:84ad? ([2a00:1fa0:48f0:1acb:121e:9475:d238:84ad])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011ed97sm1375651fa.48.2025.02.13.00.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 00:55:46 -0800 (PST)
Message-ID: <309b356f-a7b8-4f1f-92b7-ed5b144bd039@gmail.com>
Date: Thu, 13 Feb 2025 11:55:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: fix error while OF and ACPI all config Y
To: 412574090@163.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 weiyufeng <weiyufeng@kylinos.cn>
References: <20250213060804.114558-1-412574090@163.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20250213060804.114558-1-412574090@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 9:08 AM, 412574090@163.com wrote:

> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> When both OF and ACPI are configured as Y simultaneously，this may
> cause error while install os with usb disk，while reading data from
> the usb disk, the onboard_ hub driver will reinitialize the
> hub, causing system installation exceptions.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> ---
>  drivers/usb/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 6497c4e81e95..9ffb51191621 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
>  
>  config USB_ONBOARD_DEV
>  	tristate "Onboard USB device support"
> -	depends on OF
> +	depends on (OF && !ACPI)

   I don't think () are needed here.

[...]

MBR, Sergey


