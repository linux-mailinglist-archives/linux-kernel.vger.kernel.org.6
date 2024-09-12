Return-Path: <linux-kernel+bounces-326642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605B976B34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2112829A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75661ABEC3;
	Thu, 12 Sep 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXDfnSpa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AB19FA91
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149161; cv=none; b=c/oMsTj108uHjtpYRQVRAF5T1zpFtpqVOTJp6b7INryfkFEAAhwuD8TI+WVgezHz9uD97pVMUnXJYgu4IoIhakswSM2dDYV9emWex906L9+eOVjpyUS6YJCFVGvDk1OXV2sK7Yulh1qdgKQEfnt6kwtm+gDNDjgiXdbpljWo0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149161; c=relaxed/simple;
	bh=847eTLZW0MfM6fAAiLbEcfeHHCOcPEU+ymVhnn3BG5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0IeXhUXorF5K7a+gaioMekSWjpJ7HMaUmJvqcNN2DPYRwAk3Q5fPEiS3rsXgI8i+q5nGaputxkTu6M8KVADjpbWisqgWYWefhui2xbqhKZ8PmxcUjd5Qoz4f+EqQP0DYE8p3mhwjhwGBwJuzw3Rlb331YLGtjU6JaLeQqyf/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXDfnSpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726149158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUGx0nxNlp6Ya2u4chOzdjTNWM8SNP7+zCSMGBl0LSw=;
	b=cXDfnSpaAW/RA5vBYC2FBgIrYu5MYjtxn6g6JsFUDsXq1ERLz738YmJuDQfQDvUO02MCqK
	XBaiCMqAR3j1yYSTUcWuepM2VJO8OuBN/Yu3RyLN/FPXyQUuLiqk+cn3WO63RkrxQtVe8W
	APm9fZsk2aESdjAyFywlHdCYw+Ig4qA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-af8rAeMVPYm2tU_d7rK_IQ-1; Thu, 12 Sep 2024 09:52:37 -0400
X-MC-Unique: af8rAeMVPYm2tU_d7rK_IQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5becd2ca7e7so926270a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726149156; x=1726753956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUGx0nxNlp6Ya2u4chOzdjTNWM8SNP7+zCSMGBl0LSw=;
        b=bl4XHHXljHOUPT/wZESadYrptCZJMUAwrjAI7ckTlyWy5FiiUBhAnzzzJzyEege9Rw
         WOX2r+SfZYcu3dCdT3uHHx8QxZUL6+UkSk3mW2XWevmd6bGVC0wklb4nVHeULHQCZFIV
         dpakeWdIFRr9W1TpUb86M5recr7CCoXwibQa+w3kNhJEos6Zvj3ED/587JiSuMhG9fAm
         u8mCrmOrdfnD7k7KYaWcvHQMRDUKA4Z1+OJr4WAJ8gK/56gAXph8JVK83qNs0dL1d26r
         1hEt5QgWhwwmkJ43JPfnEdNGRenOcMAnVwFG2C+jQSWZrX//rtVhpk61kdhkgY5Ew540
         dXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFvu0RxEekbUfhQZsmK/A4rIbEMME5I5LLHBKdTnjoG77p5wrExEgEAfmiy1lDgYqLDDsK3rxqggGgIfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5Bzn/zvnjsSCD3XfQlmQZpdm/HAoF8HEw9XHTBR8L/vojXB/
	N8IzGCi6nRhEgPaf7eTrEKSGjKBRnXLwySLvd4m/daNNWa7xGx7HVvSlDiXPNReZVArs3d2X/pe
	NBkV/ub8EBxjycU8QhC1ePu7tNP84bfyMCfp05QEcrz/41AYalTudzyoE9wdAyA==
X-Received: by 2002:a05:6402:27c7:b0:5c2:7699:92ef with SMTP id 4fb4d7f45d1cf-5c414387344mr3595184a12.16.1726149155968;
        Thu, 12 Sep 2024 06:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIaRkkEE7PI8ImUPDTHW8ksRiH/DOysbU4BTFTMACkOClQFBX7Xr2CoNq6fzXKdFBReixSQ==
X-Received: by 2002:a05:6402:27c7:b0:5c2:7699:92ef with SMTP id 4fb4d7f45d1cf-5c414387344mr3595144a12.16.1726149155453;
        Thu, 12 Sep 2024 06:52:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41c36sm6596555a12.2.2024.09.12.06.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:52:35 -0700 (PDT)
Message-ID: <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
Date: Thu, 12 Sep 2024 15:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 11:31 PM, Andy Shevchenko wrote:
> The commit in question does not proove that ACPI ID exists.
> Quite likely it was a cargo cult addition while doint that
> for DT-based enumeration.  Drop most likely fake ACPI ID.
> 
> Googling for KMX61021L gives no useful results in regard to DSDT.
> Moreover, the official vendor ID in the registry for Kionix is KIOX.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/iio/imu/kmx61.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index c61c012e25bb..2af772775b68 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -7,12 +7,13 @@
>   * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
>   */
>  
> -#include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/acpi.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> @@ -1217,16 +1218,6 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -static const char *kmx61_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -	return dev_name(dev);
> -}
> -
>  static struct iio_dev *kmx61_indiodev_setup(struct kmx61_data *data,
>  					    const struct iio_info *info,
>  					    const struct iio_chan_spec *chan,
> @@ -1293,8 +1284,6 @@ static int kmx61_probe(struct i2c_client *client)
>  
>  	if (id)
>  		name = id->name;
> -	else if (ACPI_HANDLE(&client->dev))
> -		name = kmx61_match_acpi_device(&client->dev);
>  	else
>  		return -ENODEV;
>  
> @@ -1496,13 +1485,6 @@ static const struct dev_pm_ops kmx61_pm_ops = {
>  	RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
>  };
>  
> -static const struct acpi_device_id kmx61_acpi_match[] = {
> -	{"KMX61021", 0},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, kmx61_acpi_match);
> -
>  static const struct i2c_device_id kmx61_id[] = {
>  	{ "kmx611021" },
>  	{}
> @@ -1513,7 +1495,6 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
>  static struct i2c_driver kmx61_driver = {
>  	.driver = {
>  		.name = KMX61_DRV_NAME,
> -		.acpi_match_table = kmx61_acpi_match,
>  		.pm = pm_ptr(&kmx61_pm_ops),
>  	},
>  	.probe		= kmx61_probe,


