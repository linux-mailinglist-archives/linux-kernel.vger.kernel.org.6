Return-Path: <linux-kernel+bounces-198252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDA8D759D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C961F22442
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C433BBEB;
	Sun,  2 Jun 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaiH9ZQ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEA3D551
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333990; cv=none; b=IW6uMUj6W/jEE5mML9DaOeXuQOUdbfzqmtvaD5EeQae6182DLVTRr8R0o/Tqv1TNxB7MvwX/x/gcBij7/OhQFlPevPJgcAbTpd6SekTbkZqdp+rK1a3646dbntxwn6gH2V5vR2vuknap1xNroa+n4YoxgCyZefXxb4zpsOO2rRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333990; c=relaxed/simple;
	bh=u0Tn6DtLoR725gLXmMRCAmJ1aJS7jiEe1amKEOtdaHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqnk3HmUHwH3rJItW5TBaNQWya8kgumGwWgp49SLNdFu9fWPPHTpTw6sw8ahKplWmKdLJiwvgbUQGVt2KVlvTRGTvRydEApm6guPbQvpTcQpZBeU3RB14VSqYjTUkq/32e/MMY+S6YE6XAW9bsUcxh55IPTlpB2kLbVMyUtjBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaiH9ZQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717333988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uUa/nCOW4X2k8bakhkC6hW2h3ccboKPHZuNFCu4LP8=;
	b=ZaiH9ZQ6M2KSTMe6zuA8+zVlhpItKxZuh5noP21MkCuXM2FTZ9QWR21vst49kbqADYBWhl
	ncrp8aWhOvnT7MgrtExsWvj6Gtr3QMT+ks3HqC+6DIALv8/14ci+3Kh9HYunA1gXdUqqT4
	OkS1+Nhec68F59ypZ50+I9bvdUAlDak=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-c2ng35L-OKa9FlIPbK_9NQ-1; Sun, 02 Jun 2024 09:13:03 -0400
X-MC-Unique: c2ng35L-OKa9FlIPbK_9NQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b950b3dc7so512514e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 06:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717333982; x=1717938782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uUa/nCOW4X2k8bakhkC6hW2h3ccboKPHZuNFCu4LP8=;
        b=DRN9TI/AQAGrs9Esqg8DXhduaf7c+PSc+qi3NLsHwX5pJ5G0f/NcrrrYxDtAnPtYBu
         AWwJkrsZ2fJ1qXa7jdl2o4QXrI2eO37dbOj2EDBhXtGMPYE3dXS9cjQDf+QENw7r574l
         UoLfYXSlYz0Tgk18EAo+ja6wKPCRPMCr2UcbIZOYJiqpHRJyQ2s8urOYpyjoO+56TJRg
         1HcI5QlfTb8FlxGcSg39W27KEkPuz6O4VF/jwK76dV4eCYAwMom4Cmu6aXBUnble4YdY
         x7sHw6k5JhC1sWeitPWbDKcFCYwRPD2I9QtiPUsWVqAknk+eHlmeK4IlhiwqnEOkHeYF
         lcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSvgLMX0EFLBrmGuU4QLnGLDaavGwNSIy/+aV3AxJiZHYcxXrgxsjwfxIyGCzsYVD8TakngmT5LSmJYp4PJRr3vVKNEX5thwG4Ophs
X-Gm-Message-State: AOJu0YxtxAuea4uhORKkJYA+zOSGB8/VmGSyVlSo9RlC58XexJKlZaec
	nNOP1AcvxO97HLlpuozAbymVrcECIC75h4PkQIyn4AWDk15d+PFKCkbkVSOQFZckJWM3E5yhJFi
	MEtTqY/JzlHr5YBUsKFpYXjK+6BwhJrI/nIuFOf6hUEL21I9+yeBWTD7Zla7l+eOsrptnPA==
X-Received: by 2002:ac2:4354:0:b0:52b:404:914f with SMTP id 2adb3069b0e04-52b8958aed8mr4306147e87.34.1717333981672;
        Sun, 02 Jun 2024 06:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkJHE+nRdUJQxCTnTWsyAtsqZ+PhGKClQ4LUTFRkrk/JWIis3dm9gkamECgv6e5p29GYZ5mg==
X-Received: by 2002:ac2:4354:0:b0:52b:404:914f with SMTP id 2adb3069b0e04-52b8958aed8mr4306121e87.34.1717333981083;
        Sun, 02 Jun 2024 06:13:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a52f5cbd3sm1435903a12.12.2024.06.02.06.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 06:13:00 -0700 (PDT)
Message-ID: <3a62bda5-0fdd-46b8-94c5-b049d7e8fe09@redhat.com>
Date: Sun, 2 Jun 2024 15:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] Input: novatek-nvt-ts: add support for NT36672A
 touchscreen
To: joelselvaraj.oss@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240601-nvt-ts-devicetree-regulator-support-v5-0-aa9bf986347d@gmail.com>
 <20240601-nvt-ts-devicetree-regulator-support-v5-3-aa9bf986347d@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240601-nvt-ts-devicetree-regulator-support-v5-3-aa9bf986347d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/1/24 10:44 PM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> 
> Extend the novatek touchscreen driver to support NT36672A chip which
> is found in phones like qcom/sdm845-xiaomi-beryllium-tianma.dts.
> Added devicetree support for the driver and used i2c chip data to handle
> the variation in chip id and wake type. Also added vcc and iovcc
> regulators which are used to power the touchscreen hardware.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/input/touchscreen/novatek-nvt-ts.c | 67 +++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
> index 9bee3a0c122fb..b9ff97bf4d880 100644
> --- a/drivers/input/touchscreen/novatek-nvt-ts.c
> +++ b/drivers/input/touchscreen/novatek-nvt-ts.c
> @@ -31,9 +31,6 @@
>  #define NVT_TS_PARAMS_CHIP_ID		0x0e
>  #define NVT_TS_PARAMS_SIZE		0x0f
>  
> -#define NVT_TS_SUPPORTED_WAKE_TYPE	0x05
> -#define NVT_TS_SUPPORTED_CHIP_ID	0x05
> -
>  #define NVT_TS_MAX_TOUCHES		10
>  #define NVT_TS_MAX_SIZE			4096
>  
> @@ -51,10 +48,16 @@ static const int nvt_ts_irq_type[4] = {
>  	IRQF_TRIGGER_HIGH
>  };
>  
> +struct nvt_ts_i2c_chip_data {
> +	u8 wake_type;
> +	u8 chip_id;
> +};
> +
>  struct nvt_ts_data {
>  	struct i2c_client *client;
>  	struct input_dev *input;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data regulators[2];
>  	struct touchscreen_properties prop;
>  	int max_touches;
>  	u8 buf[NVT_TS_TOUCH_SIZE * NVT_TS_MAX_TOUCHES];
> @@ -142,6 +145,13 @@ static irqreturn_t nvt_ts_irq(int irq, void *dev_id)
>  static int nvt_ts_start(struct input_dev *dev)
>  {
>  	struct nvt_ts_data *data = input_get_drvdata(dev);
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators), data->regulators);
> +	if (error) {
> +		dev_err(&data->client->dev, "failed to enable regulators\n");
> +		return error;
> +	}
>  
>  	enable_irq(data->client->irq);
>  	gpiod_set_value_cansleep(data->reset_gpio, 0);
> @@ -155,6 +165,7 @@ static void nvt_ts_stop(struct input_dev *dev)
>  
>  	disable_irq(data->client->irq);
>  	gpiod_set_value_cansleep(data->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  }
>  
>  static int nvt_ts_suspend(struct device *dev)
> @@ -188,6 +199,7 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	int error, width, height, irq_type;
>  	struct nvt_ts_data *data;
> +	const struct nvt_ts_i2c_chip_data *chip;
>  	struct input_dev *input;
>  
>  	if (!client->irq) {
> @@ -199,12 +211,35 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	chip = device_get_match_data(&client->dev);
> +	if (!chip)
> +		return -EINVAL;
> +
>  	data->client = client;
>  	i2c_set_clientdata(client, data);
>  
> +	/*
> +	 * VCC is the analog voltage supply
> +	 * IOVCC is the digital voltage supply
> +	 */
> +	data->regulators[0].supply = "vcc";
> +	data->regulators[1].supply = "iovcc";
> +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators), data->regulators);
> +	if (error) {
> +		dev_err(dev, "cannot get regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators), data->regulators);
> +	if (error) {
> +		dev_err(dev, "failed to enable regulators: %d\n", error);
> +		return error;
> +	}
> +
>  	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>  	error = PTR_ERR_OR_ZERO(data->reset_gpio);
>  	if (error) {
> +		regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  		dev_err(dev, "failed to request reset GPIO: %d\n", error);
>  		return error;
>  	}
> @@ -214,6 +249,7 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	error = nvt_ts_read_data(data->client, NVT_TS_PARAMETERS_START,
>  				 data->buf, NVT_TS_PARAMS_SIZE);
>  	gpiod_set_value_cansleep(data->reset_gpio, 1); /* Put back in reset */
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  	if (error)
>  		return error;
>  
> @@ -225,8 +261,8 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	if (width > NVT_TS_MAX_SIZE || height >= NVT_TS_MAX_SIZE ||
>  	    data->max_touches > NVT_TS_MAX_TOUCHES ||
>  	    irq_type >= ARRAY_SIZE(nvt_ts_irq_type) ||
> -	    data->buf[NVT_TS_PARAMS_WAKE_TYPE] != NVT_TS_SUPPORTED_WAKE_TYPE ||
> -	    data->buf[NVT_TS_PARAMS_CHIP_ID] != NVT_TS_SUPPORTED_CHIP_ID) {
> +	    data->buf[NVT_TS_PARAMS_WAKE_TYPE] != chip->wake_type ||
> +	    data->buf[NVT_TS_PARAMS_CHIP_ID] != chip->chip_id) {
>  		dev_err(dev, "Unsupported touchscreen parameters: %*ph\n",
>  			NVT_TS_PARAMS_SIZE, data->buf);
>  		return -EIO;
> @@ -277,8 +313,26 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct nvt_ts_i2c_chip_data nvt_nt11205_ts_data = {
> +	.wake_type = 0x05,
> +	.chip_id = 0x05,
> +};
> +
> +static const struct nvt_ts_i2c_chip_data nvt_nt36672a_ts_data = {
> +	.wake_type = 0x01,
> +	.chip_id = 0x08,
> +};
> +
> +static const struct of_device_id nvt_ts_of_match[] = {
> +	{ .compatible = "novatek,nt11205-ts", .data = &nvt_nt11205_ts_data },
> +	{ .compatible = "novatek,nt36672a-ts", .data = &nvt_nt36672a_ts_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
> +
>  static const struct i2c_device_id nvt_ts_i2c_id[] = {
> -	{ "nt11205-ts" },
> +	{ "nt11205-ts", (unsigned long) &nvt_nt11205_ts_data },
> +	{ "nt36672a-ts", (unsigned long) &nvt_nt36672a_ts_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, nvt_ts_i2c_id);
> @@ -287,6 +341,7 @@ static struct i2c_driver nvt_ts_driver = {
>  	.driver = {
>  		.name	= "novatek-nvt-ts",
>  		.pm	= pm_sleep_ptr(&nvt_ts_pm_ops),
> +		.of_match_table = nvt_ts_of_match,
>  	},
>  	.probe = nvt_ts_probe,
>  	.id_table = nvt_ts_i2c_id,
> 


