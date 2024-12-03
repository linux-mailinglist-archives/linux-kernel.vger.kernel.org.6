Return-Path: <linux-kernel+bounces-429218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3709E1A61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD8BB2CBA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF91E0E16;
	Tue,  3 Dec 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQyMNd24"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBC1E0E1C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220831; cv=none; b=lodwGpaG6S1EvoSgo60vKLNwfnEFW004Kg2g9Vphq+WfTSwgdfwMk+JPeSXZ1nBn9EFCBctHg0B3/0xacZmdp7UdxhkU1OMe46hc2TrrsAFlB42k9OM/vpRRXcEcxXijPFwP/THK/sdWDMbqH05E9ay3fPJdJ9AjdLXMlTJ5sOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220831; c=relaxed/simple;
	bh=MbiUR/ecPE3TxOcuSPOUivoOgwv1lpxDKtA5OUkYnFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV50Ahlhi3cZIzu+v+uaWuNVSSnsW7E4LL6NpfeZpelZRqW/yjNxapCBrr0lE1lZg6V2xEP9obPKBcqAYgHL/4XAUltcjBWEP2gwUrBCwsVEBHZSS0a0cpjFOEFXhX4D+V1U3fM40K3fOflBpPAcCrBFa6eSk8i9fjcoa4t4FMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQyMNd24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733220825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gD5FYt1/eddOzn+zXb0esVob8V7beW2eiojXtAtmws=;
	b=VQyMNd24vrdB7A9K+WVEpQPncmjhImFIi+JsYQ22UOyrVYJCTiKx5gjk6UFiAExUnf8xo6
	ZUdfegQCG36UkFWB03vjv88ku+YZSiPehuvGDwdp5kLACMm/W2Qbdov4uU54YcFO4ZvLUd
	JM6fUV79Hw+YSU90BZ3VZK0Jemj0n9s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-f5kbEBrcNK-evAUKfNcePA-1; Tue, 03 Dec 2024 05:13:43 -0500
X-MC-Unique: f5kbEBrcNK-evAUKfNcePA-1
X-Mimecast-MFC-AGG-ID: f5kbEBrcNK-evAUKfNcePA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa52bfbdfebso355385866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220821; x=1733825621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gD5FYt1/eddOzn+zXb0esVob8V7beW2eiojXtAtmws=;
        b=XjPewf3E6Yk6Js2aso5RrBRatZcL3aBYl14IZcCMZIap7sjEANG9jYc9Mh0sSuKgfx
         SyDiLB4tM4istZxnuOSJzo5ALuXYF1ULZ62q0cRLcQlz6ih6um2RRhZYXKvJ2fYeSSz1
         Y84hnZq4sDgb7HOFF6lhewonSslWw6N+0QOjBOlOc+aiCVL0tcifzGRbzs5LV0KBqFAJ
         W+Sfv6TfuyH5rZziDE2GBkoHZcnomEhzj/8iYMLeV7FHHRN3jtaWAjZSQf7IajJjwZO0
         p5cWRHqFv43hOiiRSolEhAXhFts4yeNzR990m+v5JgAy/zCjFhujPnb/ed0BBBbn/vnp
         D3bg==
X-Forwarded-Encrypted: i=1; AJvYcCWh8jWf6sziRacqlfaLrSIH5vL2ia/6yLvcg03M0rsnu27Nn892mWNyJ5KXz1r8ZBe3NXDRhl89XJM+uVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6MunvCX7Kh5dUzDJA7enZmBMR0YDknQa+KVzwCGFvRG+8f3n
	9AFdMVehubQhGefbx1MVPV+pFySuoqu8VylWP6x+Qv6WdK291AaBl95+HowCtOa86pIsP7zca4L
	yuzvHFH2qFjALnTVsJYU5VaB7M5UcVGAZe9kvwTk4ZseE6NMQwb9SRlZ9I9bS3A==
X-Gm-Gg: ASbGncsKG/lLZOso10UKtXaf3sQvXoxYKZNvhGSXxlngutGnXva5tzQCBoyzef5omh0
	edwxZyhD/YUSzuBzQ4LMCHbc3XkmcoZYVvWCrnaIxX8QJNTETL9cPdvPd4aeHbBnaMG3BybeawK
	z6925/lCsOYjmazXO0I1xaodNod4r+SWA/AzkzJVtJjdd2HqCmaGh1AO7Sp9x10mFB4J1YogkDY
	Sk2UzbsDPhxjp00AJ+2RqQkwjmOKtXAcq77XnvdEcgpvkbgFXJ3r420lKUIqtWf3zz4o59sHFGc
	l13e0G1hX+egAQzsn/pvxf6cIZs7Q3KbHB/WG3pQ2bhDmJgEO0exqnzxRkvaTlcvHTzSvUpFaYM
	CmC8Jtah1vIEZ0zdCXE0aBlUV
X-Received: by 2002:a17:907:7841:b0:a9f:4f7:f064 with SMTP id a640c23a62f3a-aa5f7cc2a04mr137747066b.3.1733220820833;
        Tue, 03 Dec 2024 02:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJjBemiZA1JA6td7ZtEW4FdLaoA9XqQ/Yo0vCezDXhxc2MCbJKB4nnkSo7NdapACzQPwkwww==
X-Received: by 2002:a17:907:7841:b0:a9f:4f7:f064 with SMTP id a640c23a62f3a-aa5f7cc2a04mr137745266b.3.1733220820482;
        Tue, 03 Dec 2024 02:13:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996df78csm602815466b.67.2024.12.03.02.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:13:40 -0800 (PST)
Message-ID: <81a63f9d-afe4-4a29-ae98-5c5837bcd7cb@redhat.com>
Date: Tue, 3 Dec 2024 11:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/staging/media/atomisp: replace legacy GPIO APIs
 in atomisp_gmin_platform
To: Song Chen <chensong_2000@189.cn>, andy@kernel.org, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
 bergh.jonathan@gmail.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev
References: <20241203091436.203745-1-chensong_2000@189.cn>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241203091436.203745-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Dec-24 10:14 AM, Song Chen wrote:
> In atomisp_gmin_platform, gpio0 and gpio1 have moved to descriptor-based
> GPIO APIs, but v1p8_gpio and v2p8_gpio still remain calling legacy ones,
> such as gpio_request.
> 
> This patch replaces old with new, also removes including gpio.h.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>

Thank you for your patch, this is already addresses by this patch
which I plan to merge soon:

https://lore.kernel.org/linux-media/20241107221134.596149-1-hdegoede@redhat.com/

Regards,

Hans


> ---
>  .../media/atomisp/pci/atomisp_gmin_platform.c | 63 ++++++++-----------
>  1 file changed, 25 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> index e176483df301..7ff548ac3171 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> @@ -11,7 +11,6 @@
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include "../../include/linux/atomisp_platform.h"
>  #include "../../include/linux/atomisp_gmin_platform.h"
> @@ -85,8 +84,8 @@ struct gmin_subdev {
>  	bool v2p8_on;
>  	bool v1p2_on;
>  
> -	int v1p8_gpio;
> -	int v2p8_gpio;
> +	struct gpio_desc *v1p8_gpiod;
> +	struct gpio_desc *v2p8_gpiod;
>  
>  	u8 pwm_i2c_addr;
>  
> @@ -548,23 +547,6 @@ static int gmin_subdev_add(struct gmin_subdev *gs)
>  	else
>  		dev_info(dev, "will handle gpio1 via ACPI\n");
>  
> -	/*
> -	 * Those are used only when there is an external regulator apart
> -	 * from the PMIC that would be providing power supply, like on the
> -	 * two cases below:
> -	 *
> -	 * The ECS E7 board drives camera 2.8v from an external regulator
> -	 * instead of the PMIC.  There's a gmin_CamV2P8 config variable
> -	 * that specifies the GPIO to handle this particular case,
> -	 * but this needs a broader architecture for handling camera power.
> -	 *
> -	 * The CHT RVP board drives camera 1.8v from an* external regulator
> -	 * instead of the PMIC just like ECS E7 board.
> -	 */
> -
> -	gs->v1p8_gpio = gmin_get_var_int(dev, true, "V1P8GPIO", -1);
> -	gs->v2p8_gpio = gmin_get_var_int(dev, true, "V2P8GPIO", -1);
> -
>  	/*
>  	 * FIXME:
>  	 *
> @@ -830,21 +812,23 @@ static int gmin_v1p2_ctrl(struct v4l2_subdev *subdev, int on)
>  static int gmin_v1p8_ctrl(struct v4l2_subdev *subdev, int on)
>  {
>  	struct gmin_subdev *gs = find_gmin_subdev(subdev);
> +	struct i2c_client *client = v4l2_get_subdevdata(gs->subdev);
> +	struct device *dev = &client->dev;
>  	int ret;
>  	int value;
>  	int reg;
> +	int v1p8_gpio;
>  
>  	if (!gs || gs->v1p8_on == on)
>  		return 0;
>  
> -	if (gs->v1p8_gpio >= 0) {
> -		pr_info("atomisp_gmin_platform: 1.8v power on GPIO %d\n",
> -			gs->v1p8_gpio);
> -		ret = gpio_request(gs->v1p8_gpio, "camera_v1p8_en");
> -		if (!ret)
> -			ret = gpio_direction_output(gs->v1p8_gpio, 0);
> -		if (ret)
> +	v1p8_gpio = gmin_get_var_int(dev, true, "V1P8GPIO", -1);
> +	if (v1p8_gpio >= 0) {
> +		gs->v1p8_gpiod = gpiod_get_index(dev, "camera_v1p8", v1p8_gpio, GPIOD_ASIS);
> +		if (IS_ERR(gs->v1p8_gpiod))
>  			pr_err("V1P8 GPIO initialization failed\n");
> +		else
> +			gpiod_direction_output(gs->v1p8_gpiod, 0);
>  	}
>  
>  	gs->v1p8_on = on;
> @@ -861,8 +845,8 @@ static int gmin_v1p8_ctrl(struct v4l2_subdev *subdev, int on)
>  			goto out; /* Still needed */
>  	}
>  
> -	if (gs->v1p8_gpio >= 0)
> -		gpio_set_value(gs->v1p8_gpio, on);
> +	if (v1p8_gpio >= 0)
> +		gpiod_set_value(gs->v1p8_gpiod, on);
>  
>  	if (gs->v1p8_reg) {
>  		regulator_set_voltage(gs->v1p8_reg, 1800000, 1800000);
> @@ -911,21 +895,24 @@ static int gmin_v1p8_ctrl(struct v4l2_subdev *subdev, int on)
>  static int gmin_v2p8_ctrl(struct v4l2_subdev *subdev, int on)
>  {
>  	struct gmin_subdev *gs = find_gmin_subdev(subdev);
> +	struct i2c_client *client = v4l2_get_subdevdata(gs->subdev);
> +	struct device *dev = &client->dev;
>  	int ret;
>  	int value;
>  	int reg;
> +	int v2p8_gpio;
>  
>  	if (WARN_ON(!gs))
>  		return -ENODEV;
>  
> -	if (gs->v2p8_gpio >= 0) {
> -		pr_info("atomisp_gmin_platform: 2.8v power on GPIO %d\n",
> -			gs->v2p8_gpio);
> -		ret = gpio_request(gs->v2p8_gpio, "camera_v2p8");
> -		if (!ret)
> -			ret = gpio_direction_output(gs->v2p8_gpio, 0);
> -		if (ret)
> +	v2p8_gpio = gmin_get_var_int(dev, true, "V2P8GPIO", -1);
> +	if (v2p8_gpio >= 0) {
> +		pr_info("atomisp_gmin_platform: 2.8v power on GPIO %d\n", v2p8_gpio);
> +		gs->v2p8_gpiod = gpiod_get_index(dev, "camera_v2p8", v2p8_gpio, GPIOD_ASIS);
> +		if (IS_ERR(gs->v2p8_gpiod))
>  			pr_err("V2P8 GPIO initialization failed\n");
> +		else
> +			gpiod_direction_output(gs->v2p8_gpiod, 0);
>  	}
>  
>  	if (gs->v2p8_on == on)
> @@ -944,8 +931,8 @@ static int gmin_v2p8_ctrl(struct v4l2_subdev *subdev, int on)
>  			goto out; /* Still needed */
>  	}
>  
> -	if (gs->v2p8_gpio >= 0)
> -		gpio_set_value(gs->v2p8_gpio, on);
> +	if (v2p8_gpio >= 0)
> +		gpiod_set_value(gs->v2p8_gpiod, on);
>  
>  	if (gs->v2p8_reg) {
>  		regulator_set_voltage(gs->v2p8_reg, 2900000, 2900000);


