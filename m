Return-Path: <linux-kernel+bounces-220150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC790DD84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837F5284C34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7B1741E5;
	Tue, 18 Jun 2024 20:38:34 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CA53E24;
	Tue, 18 Jun 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743114; cv=none; b=i1+THyeUT+eIHND+m7VnT7Nt/0m9hrnCNJQXRiGGJae4+Ja1nRo2uqOmrLJEGvA2Op/WlQqNVO8IQwggFmrNEP2l/Hj4x8cCuuTx029nzMaBZdBF/VlNQyf4GJN0JXHAVc5BijPoqBVNJUmkyWiYZZvQaKXK+Bxez9WDJ/gccKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743114; c=relaxed/simple;
	bh=QAG/FKCaoV8xgpJogK/nDPJ9vvUtjjWPfSUKbY72FQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sjz9+LzCxvDzarEttdaTV+ysz7CFij7i9stbBq+gfJ2ugAgV5zwtbRpriOxX3B5r0/tBwyA4HSF97P8kjCMaWNXYKfyJLuT8uNj+BLTrKEyqKDEcGuNt+bb+d8Nhaq4ES0yXBd0ZBelXu0JT207C++a6IESt8Sh3txRqrMR7DLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4b2.dynamic.kabel-deutschland.de [95.90.244.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 18E7261E5FE01;
	Tue, 18 Jun 2024 22:37:48 +0200 (CEST)
Message-ID: <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
Date: Tue, 18 Jun 2024 22:37:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Armin Wolf <W_Armin@gmx.de>, Stephen Horvath <s.horvath@outlook.com.au>,
 Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>,
 Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240618195348.1670547-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[continue tests from thread *Re: [PATCH v4 5/6] i2c: smbus: Support DDR5 
SPD EEPROMs* [1] here]

[Cc: +Jean Delvare]

Dear Guenter,


Am 18.06.24 um 21:53 schrieb Guenter Roeck:
> regmap write operations on i801 controllers were observed to fail with
> -ENXIO errors. It appears that the i801 controller and/or at least some
> spd5118 compatible chips do not support the I2C_FUNC_SMBUS_I2C_BLOCK
> operation used by the regmap-i2c core if I2C_FUNC_SMBUS_I2C_BLOCK is
> supported by the I2C/SMBus controller.
> 
> Stop using the regmap-i2c core and always use basic SMBus operations
> instead.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/linux-hwmon/33f369c1-1098-458e-9398-30037bd8c5aa@molgen.mpg.de/
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Added patch
> 
>   drivers/hwmon/Kconfig   |  2 +-
>   drivers/hwmon/spd5118.c | 28 +++++++++++++++++++++++++++-
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index d5eced417fc3..fdfa778a965d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2184,7 +2184,7 @@ config SENSORS_INA3221
>   config SENSORS_SPD5118
>   	tristate "SPD5118 Compliant Temperature Sensors"
>   	depends on I2C
> -	select REGMAP_I2C
> +	select REGMAP
>   	help
>   	  If you say yes here you get support for SPD5118 (JEDEC JESD300)
>   	  compliant temperature sensors. Such sensors are found on DDR5 memory
> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
> index d405c5ef755d..995c45e2a997 100644
> --- a/drivers/hwmon/spd5118.c
> +++ b/drivers/hwmon/spd5118.c
> @@ -489,6 +489,31 @@ static bool spd5118_volatile_reg(struct device *dev, unsigned int reg)
>   	}
>   }
>   
> +static int spd5118_regmap_reg_read(void *context, unsigned int reg,
> +				   unsigned int *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(context, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +
> +	return 0;
> +}
> +
> +static int spd5118_regmap_reg_write(void *context, unsigned int reg,
> +				    unsigned int val)
> +{
> +	return i2c_smbus_write_byte_data(context, reg, val);
> +}
> +
> +static const struct regmap_bus spd5118_regmap_bus = {
> +	.reg_write = spd5118_regmap_reg_write,
> +	.reg_read = spd5118_regmap_reg_read,
> +};
> +
>   static const struct regmap_range_cfg spd5118_regmap_range_cfg[] = {
>   	{
>   	.selector_reg   = SPD5118_REG_I2C_LEGACY_MODE,
> @@ -526,7 +551,8 @@ static int spd5118_probe(struct i2c_client *client)
>   	if (!data)
>   		return -ENOMEM;
>   
> -	regmap = devm_regmap_init_i2c(client, &spd5118_regmap_config);
> +	regmap = devm_regmap_init(dev, &spd5118_regmap_bus, client,
> +				  &spd5118_regmap_config);
>   	if (IS_ERR(regmap))
>   		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
>   

Unfortunately, it still fails:

     $ git log --no-decorate --oneline -4
     7ddcff2d44ae3 hwmon: (spd5118) Add support for Renesas/ITD SPD5118 
hub controllers
     e89136743324f hwmon: (spd5118) Use spd5118 specific read/write 
operations
     0fcc7279f0cc4 hwmon: (spd5118) Use regmap to implement paging
     801b6aad6fa7a hwmon: (spd5118) Add configuration option for 
auto-detection

     $ uname -r
     6.10.0-rc4.mx64.461-00050-g7ddcff2d44ae
     $ sudo bash -c 'echo 56000 > /sys/class/hwmon/hwmon3/temp1_max'
     bash: line 1: echo: write error: No such device or address


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/342dae24-56c5-4b81-9591-dc23ddbb2806@roeck-us.net/

