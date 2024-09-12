Return-Path: <linux-kernel+bounces-326640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC5976B30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2CA1F23C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A81A01CC;
	Thu, 12 Sep 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3MUaK3E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3519FA91
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149076; cv=none; b=sC7s4tPPG1bBdulV0fe+SPT3VRwum3vtn7xu2Zjf+HiHvN1jxKUPZv1ycIs2ckP+T79PWdT8SRlfQT1ku17gFXx1UJkGrbF/ArKNIJ6IpqZzemgluiWKmh/BhNJd5iML/gd8/an13kZbJ1zqnuvbAZPw65JIjL5ZDeaTNafaE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149076; c=relaxed/simple;
	bh=mHXRZwn39XNfB4OE9L5AmkZEjp9sEoCwmPggRDBH4q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUcyl3JzpEQujdAnEk/I+M+xxOMbhbPdevwo0Jl9WFaMfnLE3DIlp7RuihaQbhBZoGV92ob2eee4KZT1huyAvKSHQ467WNcEOB6TPhjJyIchdhzLH+UHHawu2s7wbVc+fDmk8+Rma3nKTyF8o09JiZqO/OzRUs1suAkwg+Kx9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3MUaK3E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726149074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJSgGclhv/0uXh5dllwuOUf6TENoJ6IQ0sOECsE/41c=;
	b=K3MUaK3EBnxTrf2iDDlMAu7YlUWjamXaGHKzW8W3dT3Ber3Cflv9WgSuRatNHn376KaLDC
	WcCJfqRP6l74YHT+zS5QUIdkxcj76CbwCvqqd/AlgH1YePJiOaIsOTD8v5akKCXtjVV4Bm
	kihEaNoogF4bsFCaZHWRlE7uqne+AkI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-GyziKHK7NUK2Ap_2arBLBQ-1; Thu, 12 Sep 2024 09:51:12 -0400
X-MC-Unique: GyziKHK7NUK2Ap_2arBLBQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a9094c96cso63353566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726149072; x=1726753872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJSgGclhv/0uXh5dllwuOUf6TENoJ6IQ0sOECsE/41c=;
        b=LFIJs3r0iDN9HvR/Zz1JSIogdKwXLYq1MsfqVDfhDOu4pUmg2B+vxPAWcukEo+Qafn
         QcM6797AcjEZNptLGqjmzTC2kJmig24tKRP2Xywr3dLLhwDbjsyRptwfbGHNhxDJWLbp
         pQVBiwSVQvFVl04UyMcWkBgJ68ct2Um7wKAbT20oieH4Bx7/ZA110wyve7G7e6eeLcyn
         WCcS+GNJD1ye+HIMbNr4V/mh7TVAuBRirVP8U8cnBI0w+DZsb46+ZNwO6D5rCEJcwlFx
         OitSRbVcFwx0rK2zUlmSpzGTCnxiweuki8/1a+X1hz+OZE6oifJjQ2MF7NC/xFZbo+Vg
         JtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKwu8AiiIjWL/hk6QqEHDL66QinTXEUpMxZyrljH0wfiL7luCtuavD2ozRbvwe4MZI5kk9o0z8w7NFfLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEKGchK3/f0IV3cFgu0KBjDJqsbj6f4wsyl9j6o0VuEtc5T9K
	0dxrl1UnXfR81a8jFOflzPVgE+NIUb3vov+gfiCkYkcqrvEQ/4WZy1m9U3jb1rB5drrtYcxuN/5
	h9Cc2pFLYzyNLl9gnWh1dmSr6OIKuIjD5Dm+x4/wOj3TEDc/UZrbP09TV0YKFnQ==
X-Received: by 2002:a17:907:3f8d:b0:a90:1300:e613 with SMTP id a640c23a62f3a-a9029663045mr271615366b.55.1726149071616;
        Thu, 12 Sep 2024 06:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZn6v48IUSrL6GvIoE+fw0K59TC6eFg7FIafeKrAk88evG+6VkWRytIbWqBR+Xxkkjmikkg==
X-Received: by 2002:a17:907:3f8d:b0:a90:1300:e613 with SMTP id a640c23a62f3a-a9029663045mr271611866b.55.1726149071028;
        Thu, 12 Sep 2024 06:51:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2597aca1sm748897266b.74.2024.09.12.06.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:51:10 -0700 (PDT)
Message-ID: <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Date: Thu, 12 Sep 2024 15:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 11:22 PM, Andy Shevchenko wrote:
> The commit in question does not proove that ACPI ID exists.
> Quite likely it was a cargo cult addition while doint that
> for DT-based enumeration.  Drop most likely fake ACPI ID.
> 
> Googling for LTERxxxx gives no useful results in regard to DSDT.
> Moreover, there is no "LTER" official vendor ID in the registry.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/iio/light/ltr501.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 8c516ede9116..0e0420573286 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -15,7 +15,6 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> -#include <linux/acpi.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
> @@ -1422,17 +1421,6 @@ static int ltr501_powerdown(struct ltr501_data *data)
>  				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
>  }
>  
> -static const char *ltr501_match_acpi_device(struct device *dev, int *chip_idx)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -	*chip_idx = id->driver_data;
> -	return dev_name(dev);
> -}
> -
>  static int ltr501_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -1523,8 +1511,6 @@ static int ltr501_probe(struct i2c_client *client)
>  	if (id) {
>  		name = id->name;
>  		chip_idx = id->driver_data;
> -	} else  if (ACPI_HANDLE(&client->dev)) {
> -		name = ltr501_match_acpi_device(&client->dev, &chip_idx);
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -1609,14 +1595,6 @@ static int ltr501_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>  
> -static const struct acpi_device_id ltr_acpi_match[] = {
> -	{ "LTER0501", ltr501 },
> -	{ "LTER0559", ltr559 },
> -	{ "LTER0301", ltr301 },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
> -
>  static const struct i2c_device_id ltr501_id[] = {
>  	{ "ltr501", ltr501 },
>  	{ "ltr559", ltr559 },
> @@ -1640,7 +1618,6 @@ static struct i2c_driver ltr501_driver = {
>  		.name   = LTR501_DRV_NAME,
>  		.of_match_table = ltr501_of_match,
>  		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
> -		.acpi_match_table = ltr_acpi_match,
>  	},
>  	.probe = ltr501_probe,
>  	.remove	= ltr501_remove,


