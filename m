Return-Path: <linux-kernel+bounces-258620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA9938A98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94604B2115B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809D16087B;
	Mon, 22 Jul 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2HyqMpG"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F215FD01;
	Mon, 22 Jul 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635200; cv=none; b=W+F1M0yKBfIPyY3B5aCLiNOVRuSqusNoyrgDAApZ006uQ0H20aU9LcYHuoX4G6394qJiModWEGOZDpZl220VydTwXh52lnQGjyLhoFFrBKhC/VfF3yRJX/57OMx9CD4c6q+BlMsbGy7ra8zN4aPcnHydoZzi6pj2kARG8M9FpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635200; c=relaxed/simple;
	bh=DETe9cqRl472ht2Rv9JHngPeg4K1nkxpvGkPc2r2hGw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=psPb0jBChHzRWFwx4xjvyhAx/+A2zFMR/xiyGYIMq05qCJcguQNd7yb5eCySrpylQyzN3HV6d43L7CQmkEBQpZX3iyEIQkOb3DOLBe5EDFf+1JzbVEAtkSinF2nyGfufTLpW0h4P2Bd1aMKeZxoKoDt8kabh+dUf0gOk0kv6/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2HyqMpG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa9ecfb321so25681785ad.0;
        Mon, 22 Jul 2024 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721635198; x=1722239998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYfE/3PpByzsoGwhv8BBvxXbgN0ILya8G+Bi1D7Wfn8=;
        b=P2HyqMpGtsl4g9+JyhlYfycNz652hC8U5CQRs7Q2q9jKNcr/h/s5F0TQLZHRnIwg97
         tdmYnpt4FmD9WZ2lW6IWXb28uJZo57n+duLzaQ61i+pXjrN4OMix5aXBbWR+MaBSNP5Z
         KyHBdwuIkajWcE2n7FPWBj4yVWqQ9tFS5nZMo1J/8WIj4YHGigIv4CJLzI4eMFpfK8j5
         ZCWLRfuirF0O9X9aYtRapcbl3eHpFOOpunrmg+bCk16XL61GkutrKlp2l02S6AYtM5Xi
         rSrLOUovJy8XBK3w4AYcQmsO34/Ac4la9KwsbEnChhfrTiVLO7cfdnjtwX0lZTKOkk9d
         112w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635198; x=1722239998;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYfE/3PpByzsoGwhv8BBvxXbgN0ILya8G+Bi1D7Wfn8=;
        b=P362MH3/83uToK5I3fekwxuCAuu4leykmn9vJHweYHlBpvi74esYGmUIBvCC2jw4kj
         Agjq85p7CAJZLaDAK21HukNAYpfu+Dlywrjt5ArRHQdTqK20tWfCXsXtXB6zJ+j3gJds
         r8HshK089qpAvThI1FGoiIODvDF1/LnPSef63U81BBgz5cU2TyPioqkh7aBp0xa85t35
         Eg9sqkXYxHXuwE1JBqpVMhzPer67le5wnYNRbvuAhnSP4bJzYnX/yHPZbzavn/42Dm8n
         mB1SPQ2r5TlFixYHFCluiIT9jgv+oJ8ptZ614cjlyMHEjoREPzUkpMdl99m3KqVZB/Fd
         Sh2w==
X-Forwarded-Encrypted: i=1; AJvYcCU7uSJpJjqPhStP9S9vQKiHam8++8JOy29b87mkuOVUR9r37aYuBnq/mHmWJ2PQtKpi+YMpq8uE1JbJm0mv+hNA106Vz9G9GBzQNG7II8yta7wYNS2oXpRXd1lMJCJaXz+uSzr1EyKr/c4rW55XePqUVhHSedmPf1+qyfu0IQqUwU4r4eU=
X-Gm-Message-State: AOJu0YzF1migHdvPIYXqrpP6HEHX/toXipKBZly7EMlOfCKq6KxuFNAs
	ctC859EsXf5xl+hEagym42VfBFGMUp15bGI9WXM6CmSKIcaG+puT
X-Google-Smtp-Source: AGHT+IH1/q7piFxaPApp/nFcftg2U5jv2fki91ORtk9udTyWHUR7dl8pWdRwBt/h+VS8LKQYhXu4fw==
X-Received: by 2002:a17:902:f549:b0:1fb:3e8c:95a6 with SMTP id d9443c01a7336-1fd7465ba9amr33047925ad.40.1721635197623;
        Mon, 22 Jul 2024 00:59:57 -0700 (PDT)
Received: from [198.18.0.1] ([2401:d9c0:2902::c2eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f3181f4sm48696385ad.163.2024.07.22.00.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 00:59:57 -0700 (PDT)
From: Cryolitia PukNgae <cryolitia@gmail.com>
X-Google-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Message-ID: <3e1db249-f89e-4cc4-9e92-1f00f2e262f9@gmail.com>
Date: Mon, 22 Jul 2024 15:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hwmon: add GPD devices sensor driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, =?UTF-8?Q?Marcin_Str=C4=85gowski?=
 <marcin@stragowski.com>
References: <20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com>
 <20240718-gpd_fan-v4-1-116e5431a9fe@gmail.com>
 <cf41c18f-8b35-4970-a274-2834a15c9f08@roeck-us.net>
Content-Language: en-US
In-Reply-To: <cf41c18f-8b35-4970-a274-2834a15c9f08@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/7/19 09:41, Guenter Roeck wrote:
> I am havng a hard time reviewing this driver. I am going to pint out a few
> issues, but this is far from a complete review.

I'm new to kernel development, so please forgive my mistakes and thank 
you for your patience.

I am modifying the source code of this driver according to your 
suggestions, and I would like to discuss some of your comments first.

>> +static const struct gpd_model_quirk gpd_win4_quirk = {
>> +	.model_name	= "win4",
>> +	.address	= {
>> +				.addr_port		= 0x2E,
>> +				.data_port		= 0x2F,
>> +				.manual_control_enable	= 0xC311,
>> +				.rpm_read		= 0xC880,
>> +				.pwm_write		= 0xC311,
>> +				.pwm_max		= 127,
>> +			},
>> +	.read_rpm	= gpd_win4_read_rpm,
>> +	// same as GPD Win Mini
>> +	.set_pwm_enable	= gpd_win_mini_set_pwm_enable,
>> +	.read_pwm	= gpd_read_pwm,
>> +	// same as GPD Win Mini
> I do not see te value in those comments.

It's the struct of win4, but it's part of functions are the same as 
win_mini's.

The comment is to remind that, it's by design to use win_mini's 
function, not by mistake.

>> +
>> +static int gpd_fan_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct gpd_driver_priv *data;
>> +	const struct resource *plat_res;
>> +	const struct device *dev_reg;
>> +	const struct resource *region_res;
>> +
>> +	data = dev_get_platdata(&pdev->dev);
>> +	if (IS_ERR(data))
>> +		return -ENODEV;
>> +
> With all the "const" spread through the driver, this one is really odd.
> I have never seen a driver there the _platform data_ is used to store
> instance-specific information. Normally _that_ information is considered
> constant and not modified by a driver.  I really have to say that it is
> extremely odd to have the init function
> declare values such as pwm enable and pwm value and use it in the driver.
>
> Please provide a rationale for this unusual approach.
I don't know how to pass which model the init function found. Is it a 
good idea the use a global pointer to point to the instance-specific 
information?
>> +	plat_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> +	if (IS_ERR(plat_res))
>> +		return dev_err_probe(dev, PTR_ERR(plat_res),
>> +				     "Failed to get platform resource\n");
>> +
>> +	region_res = devm_request_region(dev, plat_res->start,
>> +					 resource_size(plat_res), DRIVER_NAME);
>> +	if (IS_ERR(region_res))
>> +		return dev_err_probe(dev, PTR_ERR(region_res),
>> +				     "Failed to request region\n");
>> +
>> +	dev_reg = devm_hwmon_device_register_with_info(
>> +		dev, DRIVER_NAME, data, &gpd_fan_chip_info, NULL);
> CHECK: Lines should not end with a '('
> #756: FILE: drivers/hwmon/gpd-fan.c:593:
> +	dev_reg = devm_hwmon_device_register_with_info(
>
> Plus on top of that multi-line code should be aligned with '('.

The source code has been formatted by clang-format with kernel's 
`.clang-format` file.

But I would be glad to manually adjust it's style if needed.

>> +static int gpd_fan_remove(struct platform_device *pdev)
>> +{
>> +	struct gpd_driver_priv *data = dev_get_platdata(&pdev->dev);
>> +
>> +	data->pwm_enable = AUTOMATIC;
>> +	data->quirk->set_pwm_enable(data, AUTOMATIC);
>> +
> This is even more unusual. Can you point me to other drivers in the kernel
> using that same approach for handling device specific private data ?

It's to set EC back to default status if user rmmod the driver, to 
prevent a hardware damage.

For example, they may use a userspace program to adjusting the fan 
curve, setting the EC to manually control mode. It happened that the 
device was in low power consumption and fan speed during rmmod, and the 
user remove the module and then performed some tasks that generated a 
lot of heat. Since the module was uninstalled and the EC was still in 
manual mode, there was nothing to protect the device.

I don't know how to implement this part elegantly

>> +
>> +	struct gpd_driver_priv data = {
>> +		.pwm_enable		= AUTOMATIC,
>> +		.pwm_value		= 255,
> This is unusual, to say it mildly. Since the pwm value is never read
> from the controller/chip, this is just a random value.

We cannot read pwm out on win_mini, only wm2 support it.

It's also to prevent the device from damaging.

Assuming the user switches to manual control mode immediately after 
loading the module, the fan will always run at full speed until the user 
specifies the fan speed.


