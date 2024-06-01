Return-Path: <linux-kernel+bounces-197964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562A58D7149
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB93B222FC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D4B154C0E;
	Sat,  1 Jun 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIHclN3+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76734152E05
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261655; cv=none; b=nr2J/864JDe4wgJuz1G2llD5Xu1UjCnht2gpLhY1ZervomCn7gUa1AkxQPxBZZDD/5WLPh37ycWft7BPjNrz7axolh4WwRkDLE+PknVHTE8qlj/5OuuZbr9Fss+ApdLsbrriosn8MLW+4HY/3ORE8XJ0el3LhjE6jg0wDkwmgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261655; c=relaxed/simple;
	bh=FJvQtiN6SB/Os4Y0B4wBquPAMUbSixz3p8vwv/U6MnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMa8nuzEWxYx1UbmQEpbs8wdfOeOQJDZJJBCycWkXlqwnwv4R0+I6hfXwuprG2og/x8dMbZ3EulSY8pWyC7NeO8mxvNICuwAgNJ9TWmFfB8wBjjCshQEsPdnAWHY7LQ82WdewIwGZqGVnx7sURo16Hix8558wR+WBDtt6PmuIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIHclN3+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717261652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9vmT65+vLdhWsswAz1BZAtl3ZDAdmQSavQkt54YQZE=;
	b=bIHclN3+aEEiF9Zz8fn93X/9HC8vRMtE6EHbmn13j9NS1DUyHZ3fd/I/g6pAAg+qpQHA0S
	QCMo/2Mi+OBRClrSF5nbpPJlSI3wcwStr+NHh8U3NtCeattbNXrEaSRnuXE2ZUt25ezWD7
	/rpYI/oewibsL63ScWkA7BHc4BU90OQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-XDcdQpwjPOW8F0zyO2tVZw-1; Sat, 01 Jun 2024 13:07:31 -0400
X-MC-Unique: XDcdQpwjPOW8F0zyO2tVZw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b953c8364so111952e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 10:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717261649; x=1717866449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9vmT65+vLdhWsswAz1BZAtl3ZDAdmQSavQkt54YQZE=;
        b=peOUG1jjr9zXjWCH4gxewcMBPTKiL7ufq33eM23Y44IbGKLNKTtY/bKcLPURtghUX5
         4cH5yxMYZcDoZ998iUm+dZazoaNx5eX4IkD/3IliVCqNBdS+cbFzMyjXQc8q/j+V+ztO
         EKsl4NtGFX9fLahXHr7HyUm+Njg6MNCa/VqJeSqWSD7w8xM9SXhTgKgm1aTqdrdzEtQE
         RMoBFpiRy9I8vToF8TwLMkG7ajveSCMTEUlByWoImDNnxKrjAjSvwK4VC8mlnoE1zpA1
         zS8uzMomxT5bcC+cql+fGZnG3qq9kDLdiMYzCWuJcuzdc1n+sITZ2Zwu5x95/31BXykq
         Wqcw==
X-Forwarded-Encrypted: i=1; AJvYcCWb0MmN5aYftChQpEksaCiAv4PlmwK/XIoxsZCSyC3M6viguYFzXTuLyozZjJ3GmKxafhNFXBYzlkkclpuw6IS+mofYKyuXV+jDLREf
X-Gm-Message-State: AOJu0YyIoxta2gmcX8YtqW0X1aP0LjOHz+70fAq3IHmZ3cXPHOc3/dBC
	VRnuVdKjhPYC5roNJUk3ESjbXtST0sl5tUKCVERIKOK3KG3jcivmx/4FZybL3qC2szCsKJS5/AU
	uA3fiAGc4c4rHw0fkeAe9nFzNHd+XPIQBV3kncAP5BV+yIp7fQbSfoxw1xdrB2g==
X-Received: by 2002:ac2:5f65:0:b0:52b:8365:2a8f with SMTP id 2adb3069b0e04-52b8954eb9emr3241327e87.25.1717261649261;
        Sat, 01 Jun 2024 10:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtK6IgBx588HNw3PqIbjhZVQRs02OFZvah8rhQ2DMtG3TdxfLO+X6DM9+66LRKhcCSog3HDg==
X-Received: by 2002:ac2:5f65:0:b0:52b:8365:2a8f with SMTP id 2adb3069b0e04-52b8954eb9emr3241310e87.25.1717261648665;
        Sat, 01 Jun 2024 10:07:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb52d285sm219580066b.221.2024.06.01.10.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 10:07:27 -0700 (PDT)
Message-ID: <2b876ece-3b02-493e-ab1d-e5acc40c5d88@redhat.com>
Date: Sat, 1 Jun 2024 19:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Input: novatek-nvt-ts: add support for NT36672A
 touchscreen
To: joelselvaraj.oss@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240601-nvt-ts-devicetree-regulator-support-v4-0-e0c0174464c4@gmail.com>
 <20240601-nvt-ts-devicetree-regulator-support-v4-3-e0c0174464c4@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240601-nvt-ts-devicetree-regulator-support-v4-3-e0c0174464c4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joel,

Thank you for the new version.

On 6/1/24 5:30 PM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> 
> Extend the novatek touchscreen driver to support NT36672A chip which
> is found in phones like qcom/sdm845-xiaomi-beryllium-tianma.dts.
> Added devicetree support for the driver and used i2c chip data to handle
> the variation in chip id and wake type. Also added vcc and iovcc
> regulators which are used to power the touchscreen hardware.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> ---
>  drivers/input/touchscreen/novatek-nvt-ts.c | 70 +++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
> index 9bee3a0c122fb..c24c33f609eb8 100644
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
> @@ -51,11 +48,18 @@ static const int nvt_ts_irq_type[4] = {
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
> +	const struct nvt_ts_i2c_chip_data *chip;

Almost there. I have one remark which requires fixing below,
so since a v5 will be necessary anyways I also spotted another
small possible improvement:

Since you only use chip->wake_type and chip->chip_id
inside probe() you can make this chip pointer a local
variable in probe(). This saves having this stored
on the kernel heap even though it is never used again.

>  	int max_touches;
>  	u8 buf[NVT_TS_TOUCH_SIZE * NVT_TS_MAX_TOUCHES];
>  };
> @@ -142,6 +146,13 @@ static irqreturn_t nvt_ts_irq(int irq, void *dev_id)
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
> @@ -155,6 +166,7 @@ static void nvt_ts_stop(struct input_dev *dev)
>  
>  	disable_irq(data->client->irq);
>  	gpiod_set_value_cansleep(data->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  }
>  
>  static int nvt_ts_suspend(struct device *dev)
> @@ -199,9 +211,31 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	data->chip = device_get_match_data(&client->dev);
> +	if (!data->chip)
> +		return -EINVAL;
> +

As mentioned above instead of data->chip you can use a local
"chip" variable here.

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

Almost there. You need to disable the regulators when probe fails to
avoid an error from the regulator core about unbalanced enable/disable
of the regulators when the devm framework releases them.

So you need to add a regulator_bulk_disable() call in
the "if (error) {" branch here:

  	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
  	error = PTR_ERR_OR_ZERO(data->reset_gpio);
  	if (error) {
		regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
		dev_err(dev, "failed to request reset GPIO: %d\n", error);
		return error;
	}

And ... (continued below)

> @@ -216,6 +250,11 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	gpiod_set_value_cansleep(data->reset_gpio, 1); /* Put back in reset */
>  	if (error)
>  		return error;
> +	error = regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);

I would not error check this, just like how it is not error checked
in void nvt_ts_stop() and then I would move it to above the error
checking for the nvt_ts_read_data(...NVT_TS_PARAMETERS...), to avoid
the need for an extra regulator_bulk_disable() call in the if (error)
path for the nvt_ts_read_data() call.

So make the code look like this:

        error = nvt_ts_read_data(data->client, NVT_TS_PARAMETERS_START,
                                 data->buf, NVT_TS_PARAMS_SIZE);
        gpiod_set_value_cansleep(data->reset_gpio, 1); /* Put back in reset */
	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
        if (error)
                return error;

        width  = get_unaligned_be16(&data->buf[NVT_TS_PARAMS_WIDTH]);
        height = get_unaligned_be16(&data->buf[NVT_TS_PARAMS_HEIGHT]);
	...

This way you only need one extra regulator_bulk_disable() call for
error-exit paths in the case of devm_gpiod_get(dev, "reset", ...)
failing.

Regards,

Hans






> @@ -225,8 +264,8 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	if (width > NVT_TS_MAX_SIZE || height >= NVT_TS_MAX_SIZE ||
>  	    data->max_touches > NVT_TS_MAX_TOUCHES ||
>  	    irq_type >= ARRAY_SIZE(nvt_ts_irq_type) ||
> -	    data->buf[NVT_TS_PARAMS_WAKE_TYPE] != NVT_TS_SUPPORTED_WAKE_TYPE ||
> -	    data->buf[NVT_TS_PARAMS_CHIP_ID] != NVT_TS_SUPPORTED_CHIP_ID) {
> +	    data->buf[NVT_TS_PARAMS_WAKE_TYPE] != data->chip->wake_type ||
> +	    data->buf[NVT_TS_PARAMS_CHIP_ID] != data->chip->chip_id) {
>  		dev_err(dev, "Unsupported touchscreen parameters: %*ph\n",
>  			NVT_TS_PARAMS_SIZE, data->buf);
>  		return -EIO;
> @@ -277,8 +316,26 @@ static int nvt_ts_probe(struct i2c_client *client)
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
> @@ -287,6 +344,7 @@ static struct i2c_driver nvt_ts_driver = {
>  	.driver = {
>  		.name	= "novatek-nvt-ts",
>  		.pm	= pm_sleep_ptr(&nvt_ts_pm_ops),
> +		.of_match_table = nvt_ts_of_match,
>  	},
>  	.probe = nvt_ts_probe,
>  	.id_table = nvt_ts_i2c_id,
> 


