Return-Path: <linux-kernel+bounces-243296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D494792943C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8950D282E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510613AA46;
	Sat,  6 Jul 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDEObFop"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A124B5B;
	Sat,  6 Jul 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277574; cv=none; b=j6E8e5hHBRrLYO2Owgvo3RG5/aYS+nTi45g8thXzCH12NCuYx284wWdGWVQgrT14L0+vX2xS/2YJdz0Trmj6r/w5Tz0/rY6R2APDMcOyIh+anPnG5655JsgpIVHs9UPmezTjsJHrSGccE+w235jgtyfCn6KLvgciGPfcZOZwRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277574; c=relaxed/simple;
	bh=IaFlaFKV6OfQPyJnlnuZD0nOcjPZM3zsnXFL0cSpP9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjO8i7ilWWocFNk2INl40XeuLsJBZ4zYOm0Y5XpDv8pEnwPhm1TW8QQs1SJM36sUb89IhAG/pdZ4niT0n+641NmBbjmJ4ZL11c2LyYF7d2/ZNKloRYcIrhrFRGaucwjBqLt+IZVxKRgi2A4QxG6OBFp/SzeP2p9GKa79/hrw/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDEObFop; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa244db0b2so17972665ad.3;
        Sat, 06 Jul 2024 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720277571; x=1720882371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0R8NLSXmvQhs3bs/pmF+4wO4ANjtCZ1MDiYGSp3AtXs=;
        b=aDEObFoplSkaNtm4neXZ/qyjwvGNtHTfWEWmhZe5Pnmz9ohzXklHuwiqZiPuph77na
         Odu1gqbzzJzrTI4ncGqbrHJyONwQPMdlEAEz+8A0gQgmWhc+3epkO4ffHVp3QqTb3C6N
         OhnH5RXtaGLYChvJi1Ka1qbV4aD2o3QpwBOt6hSW1ZiuwSopRMRWKGPClv//TuoMzWVr
         dVhB8+qfUXkTCxPXQ2M30H7QWGyf8WHrj5KP1P4ISsjrGavdmQh1MOjiqdsYIQl3jnRF
         NvKeOwbfC9iEUtTOXv2XQVfGvsfDOYORmjEQvLPtQB106sWPt7mGNvhmCDNnZ6C03say
         +zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720277571; x=1720882371;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R8NLSXmvQhs3bs/pmF+4wO4ANjtCZ1MDiYGSp3AtXs=;
        b=MMVyV8DiM4lLF9ICGbUk1Evj2klXuOhUfwx2nToPZQ1H2cker8XYUCNt5vu3Ruc9t9
         SB7uySijrYNABw8qfah8kFuGjRY27CJ/lKEeHAkOt9Xdjn3LvNwVFsR2nMdJkBrh3NH+
         k2985Rir4Iovpid2SZU1+b39SmyO4wfLIBZjqlhXHMrY4qEvrkXzbZigo2e8LaN95Hwd
         P8Z0pZsyV4bNG9RQG11eCcWQFOSr7U6OUM0TgJKnZ8AD2WICQ1Ue9/Ct13PWelGTRYI3
         XtHs9WDHSs7CQOIGV8udrh1rBWfvdGmDzWmEeY4WkMMdN5TOOs2oNZYrsSGIakMi7vVX
         N2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWpm3ioAk+mzFG3LNxUeqdw4m6Wcf1L7wURqOCQ8SlT3jUJvFg2DMOAnriuYS8mleNQxsnHmWuTp/HJ4OjBJZ187vfhh+ObBh7AGzKcbkMazPjMb79tWUPXOaBjmO+UuUZ4pddYaBRtmdVHuqHw2wyfJwciXzbo+34u7LkY5/RP0GEFZg==
X-Gm-Message-State: AOJu0YzKIAOCzinB4V2f6YdxDBTObv2eC4P8iZ9Z9X2WZHoFkuZV5hxy
	9FHla3wH3IbhA0q7iofmMkDsGS5yU9FhCz+rfAuZD5wYvklts+6l
X-Google-Smtp-Source: AGHT+IEph6eYi+0zbmVM85emUOUphemcuyl++r2hiTAsXc0RWHwV01x9FREUMlgudM3gFG830AV7yg==
X-Received: by 2002:a17:902:c40e:b0:1fa:487:d930 with SMTP id d9443c01a7336-1fb33f0b0e4mr57966475ad.56.1720277570731;
        Sat, 06 Jul 2024 07:52:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb5f9cab84sm16211185ad.64.2024.07.06.07.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 07:52:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2ecc9fd-93cf-4175-8074-b44c06b58313@roeck-us.net>
Date: Sat, 6 Jul 2024 07:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 19:30, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
> 
> Add driver support for the onboard MCU of SG2042.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   Documentation/hwmon/index.rst |   1 +
>   Documentation/hwmon/sgmcu.rst |  44 +++
>   drivers/hwmon/Kconfig         |  11 +
>   drivers/hwmon/Makefile        |   1 +
>   drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
>   5 files changed, 642 insertions(+)
>   create mode 100644 Documentation/hwmon/sgmcu.rst
>   create mode 100644 drivers/hwmon/sgmcu.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 03d313af469a..189626b3a055 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
>      sch5636
>      scpi-hwmon
>      sfctemp
> +   sgmcu
>      sht15
>      sht21
>      sht3x
> diff --git a/Documentation/hwmon/sgmcu.rst b/Documentation/hwmon/sgmcu.rst
> new file mode 100644
> index 000000000000..5669dcfb2a33
> --- /dev/null
> +++ b/Documentation/hwmon/sgmcu.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver sgmcu
> +=====================
> +
> +Supported chips:
> +
> +  * Onboard MCU for sg2042
> +
> +    Addresses scanned: -
> +
> +    Prefix: 'sgmcu'
> +
> +Authors:
> +
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +Description
> +-----------
> +
> +This driver supprts hardware monitoring for onboard MCU with
> +PMBus interface.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate
> +the devices explicitly.
> +Please see Documentation/i2c/instantiating-devices.rst for details.
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +

It doesn't. Where does PMBus come into play ? Is this a cut-and-paste problem ?

> +Sysfs Attributes
> +----------------
> +
> +================= =============================================
> +temp1_input       Measured temperature of SoC
> +temp1_crit        Critical high temperature
> +temp1_crit_hyst   hysteresis temperature restore from Critical
> +temp2_input       Measured temperature of the base board
> +================= =============================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e14ae18a973b..1100dd11f7f5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2079,6 +2079,17 @@ config SENSORS_SFCTEMP
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called sfctemp.
> 
> +config SENSORS_SGMCU
> +	tristate "Sophgo onboard MCU support"
> +	depends on I2C
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Support for onboard MCU of Sophgo SoCs. This mcu provides power
> +	  control and some basic information.
> +
> +	  This driver can be built as a module. If so, the module
> +	  will be called sgmcu.
> +
>   config SENSORS_SURFACE_FAN
>   	tristate "Surface Fan Driver"
>   	depends on SURFACE_AGGREGATOR
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e3f25475d1f0..e9b78ff8338e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -195,6 +195,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>   obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
>   obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> +obj-$(CONFIG_SENSORS_SGMCU)	+= sgmcu.o
>   obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> diff --git a/drivers/hwmon/sgmcu.c b/drivers/hwmon/sgmcu.c
> new file mode 100644
> index 000000000000..d941d6fe741f
> --- /dev/null
> +++ b/drivers/hwmon/sgmcu.c
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> + *
> + * Sophgo power control mcu for SG2042
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +
Alphabetic include file order, please.

> +/* fixed MCU registers */
> +#define REG_BOARD_TYPE				0x00
> +#define REG_MCU_FIRMWARE_VERSION		0x01
> +#define REG_PCB_VERSION				0x02
> +#define REG_PWR_CTRL				0x03
> +#define REG_SOC_TEMP				0x04
> +#define REG_BOARD_TEMP				0x05
> +#define REG_RST_COUNT				0x0a
> +#define REG_UPTIME				0x0b
> +#define REG_RESET_REASON			0x0d
> +#define REG_MCU_TYPE				0x18
> +#define REG_CRITICAL_ACTIONS			0x65
> +#define REG_CRITICAL_TEMP			0x66
> +#define REG_REPOWER_TEMP			0x67
> +
> +#define CRITICAL_ACTION_REBOOT			0x1
> +#define CRITICAL_ACTION_POWEROFF		0x2
> +

Please use BIT() for bit masks.

> +#define DEFAULT_REPOWER_TEMP			60
> +#define MAX_REPOWER_TEMP			100
> +
> +#define sg2042_mcu_read_byte(client, reg)			\
> +	i2c_smbus_read_byte_data(client, reg)
> +#define sg2042_mcu_write_byte(client, reg, value)		\
> +	i2c_smbus_write_byte_data(client, reg, value)
> +#define sg2042_mcu_read_block(client, reg, array)		\
> +	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
> +

Pointless defines. See below.

> +#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
> +	static ssize_t _name##_show(struct device *dev,			\
> +				    struct device_attribute *attr,	\
> +				    char *buf)				\
> +	{								\
> +		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
> +		_type ret;						\
> +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> +		if (ret < 0)						\
> +			return ret;					\
> +		return sprintf(buf, _format "\n", ret);			\
> +	}
> +
> +#define DEFINE_MCU_DEBUG_ATTR_READ_FUNC(_name, _type, _format)		\
> +	static int _name##_show(struct seq_file *seqf,			\
> +				    void *unused)			\
> +	{								\
> +		struct sg2042_mcu_data *mcu = seqf->private;		\
> +		_type ret;						\
> +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> +		if (ret < 0)						\
> +			return ret;					\
> +		seq_printf(seqf, _format "\n", ret);			\
> +		return 0;						\
> +	}
> +
> +#define _CREATE_DEBUG_ENTRY(name, perm, d, data)			\
> +	debugfs_create_file(#name, perm, d, data, &name##_fops)
> +

Pointless define. Please do not replace API function names with your own;
that just makes it harder to find callers.

> +struct sg2042_mcu_board_data {
> +	u8		id;
> +	const char	*name;
> +};
> +
> +struct sg2042_mcu_data {
> +	struct i2c_client			*client;
> +	const struct sg2042_mcu_board_data	*board_info;
> +	struct dentry				*debugfs;
> +};
> +
> +static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> +	{
> +		.id = 0x80,
> +		.name = "SG2042 evb x8",
> +	},
> +	{
> +		.id = 0x81,
> +		.name = "SG2042R evb",
> +	},
> +	{
> +		.id = 0x83,
> +		.name = "SG2042 evb x4",
> +	},
> +	{
> +		.id = 0x90,
> +		.name = "Milk-V Pioneer",
> +	},
> +};
> +
> +static const char *sg2042_mcu_reset_reason[8] = {
> +	"Power supply overheat",
> +	"Power supply failure",
> +	"12V power supply failure",
> +	"Reset commant",

command

> +	"Unknown",
> +	"Unknown",
> +	"Unknown",
> +	"SoC overheat",
> +};
> +
> +static struct dentry *sgmcu_debugfs;
> +
> +static int sg2042_mcu_get_board_type(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
> +}
> +
> +static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
> +}
> +
> +static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
> +}
> +
> +static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
> +}
> +
> +static int sg2042_mcu_get_board_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
> +}
> +
> +static int sg2042_mcu_get_reset_count(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
> +}
> +

Those one-line functions are just as pointless.
	i2c_smbus_read_byte_data(client, REG_RST_COUNT);
does exactly the same without extra function and define.

> +static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
> +{
> +	int ret;
> +	u8 time_val[2];
> +
> +	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
> +}
> +

This is the only one of those functions which adds at least some value.

> +static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
> +}
> +
> +static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
> +}
> +
> +static int sg2042_mcu_get_soc_crit_action(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
> +}
> +
> +static int sg2042_mcu_get_soc_crit_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
> +}
> +
> +static int sg2042_mcu_get_soc_hyst_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
> +}
> +
> +static int sg2042_mcu_set_soc_crit_action(struct i2c_client *client,
> +					  u8 value)
> +{
> +	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
> +}
> +
> +static int sg2042_mcu_set_soc_crit_temp(struct i2c_client *client,
> +					u8 value)
> +{
> +	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
> +}
> +
> +static int sg2042_mcu_set_soc_hyst_temp(struct i2c_client *client,
> +					u8 value)
> +{
> +	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
> +}
> +
> +DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
> +DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
> +
> +static ssize_t reset_reason_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret, val, i;
> +
> +	val = sg2042_mcu_get_reset_reason(mcu->client);
> +	if (val < 0)
> +		return val;
> +
> +	ret = sprintf(buf, "Reason: 0x%02x\n", val);
> +
> +	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
> +		if (val & BIT(i))
> +			ret += sprintf(buf + ret, "bit %d: %s\n", i,
> +						  sg2042_mcu_reset_reason[i]);
> +	}
> +
> +	return ret;
> +}

This violates sysfs standards (one word only). If you want that level of detail,
add it to debugfs.

> +
> +static ssize_t critical_action_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +	const char *action;
> +
> +	ret = sg2042_mcu_get_soc_crit_action(mcu->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == CRITICAL_ACTION_REBOOT)
> +		action = "reboot";
> +	else if (ret == CRITICAL_ACTION_POWEROFF)
> +		action = "poweroff";
> +	else
> +		action = "unknown";
> +
> +	return sprintf(buf, "%s\n", action);
> +}
> +
> +static ssize_t critical_action_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int value;
> +
> +	if (sysfs_streq("reboot", buf))
> +		value = CRITICAL_ACTION_REBOOT;
> +	else if (sysfs_streq("poweroff", buf))
> +		value = CRITICAL_ACTION_POWEROFF;
> +	else
> +		return -EINVAL;
> +
> +	return sg2042_mcu_set_soc_crit_action(mcu->client, value);
> +}
> +
> +static DEVICE_ATTR_RO(reset_count);
> +static DEVICE_ATTR_RO(uptime);
> +static DEVICE_ATTR_RO(reset_reason);
> +static DEVICE_ATTR_RW(critical_action);
> +
> +DEFINE_MCU_DEBUG_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
> +
> +static int board_type_show(struct seq_file *seqf, void *unused)
> +{
> +	struct sg2042_mcu_data *mcu = seqf->private;
> +
> +	seq_printf(seqf, "%s\n", mcu->board_info->name ?: "Unknown");
> +
> +	return 0;
> +}
> +
> +static int mcu_type_show(struct seq_file *seqf, void *unused)
> +{
> +	struct sg2042_mcu_data *mcu = seqf->private;
> +	int ret;
> +
> +	ret = sg2042_mcu_get_mcu_type(mcu->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	seq_puts(seqf, ret ? "GD32\n" : "STM32\n");
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(firmware_version);
> +DEFINE_SHOW_ATTRIBUTE(pcb_version);
> +DEFINE_SHOW_ATTRIBUTE(mcu_type);
> +DEFINE_SHOW_ATTRIBUTE(board_type);
> +
> +// TODO: to debugfs
> +

If there is a TODO left, move the driver to drivers/staging/
and keep it there until it is complete.

> +static struct attribute *sg2042_mcu_attrs[] = {
> +	&dev_attr_reset_count.attr,
> +	&dev_attr_uptime.attr,
> +	&dev_attr_reset_reason.attr,
> +	&dev_attr_critical_action.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sg2042_mcu_attr_group = {
> +	.attrs	= sg2042_mcu_attrs,
> +};
> +
> +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> +					HWMON_T_CRIT_HYST,
> +				 HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static int sg2042_mcu_read_temp(struct device *dev,
> +				u32 attr, int channel,
> +				long *val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	long tmp;

Why long ?

> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		switch (channel) {
> +		case 0:
> +			tmp = sg2042_mcu_get_soc_temp(mcu->client);
> +			if (tmp < 0)
> +				return tmp;
> +			*val = tmp * 1000;
> +			break;
> +		case 1:
> +			tmp = sg2042_mcu_get_board_temp(mcu->client);
> +			if (tmp < 0)
> +				return tmp;
> +			*val = tmp * 1000;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}

This would be much simpler written with something like
		tmp = i2c_smbus_read_byte_data(client, channel ? REG_SOC_TEMP : REG_BOARD_TEMP);
or even
		reg = channel ? REG_SOC_TEMP : REG_BOARD_TEMP;
followed by unified read handling below.

> +		break;
> +	case hwmon_temp_crit:
> +		if (channel)
> +			return -EOPNOTSUPP;
> +

Those checks are unnecessary if the is_visible() function
does its job. If it doesn't, it is broken and needs to be fixed.
Returning -EOPNOTSUPP is ok for default: cases, because _something_
needs to be done, but not as result of extra and unnecessary checks
like this one.

> +		tmp = sg2042_mcu_get_soc_crit_temp(mcu->client);
> +		if (tmp < 0)
> +			return tmp;
> +		*val = tmp * 1000;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		if (channel)
> +			return -EOPNOTSUPP;
> +
> +		tmp = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> +		if (tmp < 0)
> +			return tmp;
> +		*val = tmp * 1000;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}

There is a lot of repetition here. Setting the register in the switch statement, followed
by
	tmp = i2c_smbus_read_byte_data(client, reg);
	if (tmp < 0)
		return tmp;
	*val = tmp * 1000;
would be much simpler.


> +	return 0;
> +}
> +
> +static int sg2042_mcu_read(struct device *dev,
> +			   enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		if (attr != hwmon_chip_update_interval)
> +			return -EOPNOTSUPP;
> +		*val = 1000;
> +		break;

Pointless attribute. Attributes are only valuable if 1) used and
2) written into the chip. This one isn't used for anything.

> +	case hwmon_temp:
> +		return sg2042_mcu_read_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int sg2042_mcu_write(struct device *dev,
> +			    enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	u8 down_temp, repower_temp;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
> +		return -EOPNOTSUPP;
> +
Pointless check if the is_visible() function does its job.

Also, this is inconsistent: It only accepts writes if channel > 0,
but the is_visible code only makes the attributes available for
channel 0. On top of that, how does this expession ever allow writing
hwmon_temp_crit_hyst ?

Either I am missing something, or you did not test this code.

> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		ret = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> +		if (ret < 0)
> +			repower_temp = DEFAULT_REPOWER_TEMP;

Why is this not an error ? If some of the supported boards
don't support it, the value should not be read in the first place,
and the hyst attribute should not be there.

> +		else
> +			repower_temp = ret;
> +
> +		down_temp = val / 1000;

val needs to be range checked.

> +		if (down_temp < repower_temp)
> +			return -EINVAL;
> +
> +		return sg2042_mcu_set_soc_crit_temp(mcu->client,
> +						    (u8)(val / 1000));

A read followed by a write needs to be mutex protected because the other value
could be changed at the same time from another process. I am not sure if those
checks are valuable or even make sense, but if you want that compexity you'll
have to add mutex protection.

Also, what is the point of recalculating down_temp ?

> +	case hwmon_temp_crit_hyst:
> +		ret = sg2042_mcu_get_soc_crit_temp(mcu->client);
> +		if (ret < 0)
> +			return -ENODEV;
> +

Do not overwrite error codes. If the attribute does not exist for some of the
boards, it should not be created in the first place, and no attempt should be
made to read it.

> +		down_temp = ret;
> +		repower_temp = val / 1000;

val needs to be range checked.

> +		if (down_temp < repower_temp)
> +			return -EINVAL;
> +
> +		return sg2042_mcu_set_soc_hyst_temp(mcu->client,
> +						    (u8)(val / 1000));

What is the point of recalculating repower_temp ?

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t sg2042_mcu_is_visible(const void *_data,
> +				     enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		if (attr == hwmon_chip_update_interval)
> +			return 0444;
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			if (channel < 2)
> +				return 0444;

channel is always < 2.

> +			break;
> +		case hwmon_temp_crit:
> +		case hwmon_temp_crit_hyst:
> +			if (channel == 0)
> +				return 0664;
> +			break;
> +		default:
> +			return 0;
> +		}
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops sg2042_mcu_ops = {
> +	.is_visible = sg2042_mcu_is_visible,
> +	.read = sg2042_mcu_read,
> +	.write = sg2042_mcu_write,
> +};
> +
> +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> +	.ops = &sg2042_mcu_ops,
> +	.info = sg2042_mcu_info,
> +};
> +
> +static void sg2042_mcu_debugfs_init(struct sg2042_mcu_data *mcu,
> +				    struct device *dev)
> +{
> +	mcu->debugfs = debugfs_create_dir(dev_name(dev), sgmcu_debugfs);
> +	if (mcu->debugfs) {
> +		_CREATE_DEBUG_ENTRY(firmware_version, 0444, mcu->debugfs, mcu);
> +		_CREATE_DEBUG_ENTRY(pcb_version, 0444, mcu->debugfs, mcu);
> +		_CREATE_DEBUG_ENTRY(mcu_type, 0444, mcu->debugfs, mcu);
> +		_CREATE_DEBUG_ENTRY(board_type, 0444, mcu->debugfs, mcu);
> +	}
> +}
> +
> +static int sg2042_mcu_check_board(u8 id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
> +		if (sg2042_boards_data[i].id == id)
> +			return i;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct device *dev = &client->dev;
> +	struct sg2042_mcu_data *mcu;
> +	struct device *hwmon_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -EIO;
> +
> +	ret = sg2042_mcu_get_board_type(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sg2042_mcu_check_board(ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> +	if (!mcu)
> +		return -ENOMEM;
> +
> +	mcu->client = client;
> +	mcu->board_info = &sg2042_boards_data[ret];
> +
> +	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
> +	if (ret < 0)
> +		return ret;
> +

Why not use .dev_groups provided by struct device_driver ?

> +	i2c_set_clientdata(client, mcu);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 mcu,
> +							 &sg2042_mcu_chip_info,
> +							 NULL);
> +
> +	sg2042_mcu_debugfs_init(mcu, dev);
> +

This leaves the debugfs files orphan if the device (not the driver) is removed.
Also, it is still created even if devm_hwmon_device_register_with_info() returned
an error.

> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +
> +	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
> +}
> +
> +static const struct i2c_device_id sg2042_mcu_id[] = {
> +	{ "sg2042_hwmon_mcu", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> +
> +static const struct of_device_id sg2042_mcu_of_id[] = {
> +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },

Based on sg2042_boards_data, this seems wrong. Devicetree data should distinguish the supported
boards. That is its whole point. The same is true for sg2042_mcu_id; there should be separate
entries for each of the supported boards.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> +
> +static struct i2c_driver sg2042_mcu_driver = {
> +	.driver = {
> +		.name = "sg2042-mcu",
> +		.of_match_table = sg2042_mcu_of_id,
> +	},
> +	.probe = sg2042_mcu_i2c_probe,
> +	.remove = sg2042_mcu_i2c_remove,
> +	.id_table = sg2042_mcu_id,
> +};
> +
> +static int __init sg2042_mcu_init(void)
> +{
> +	sgmcu_debugfs = debugfs_create_dir("sgmcu", NULL);
> +	return i2c_add_driver(&sg2042_mcu_driver);
> +}
> +
> +static void __exit sg2042_mcu_exit(void)
> +{
> +	debugfs_remove_recursive(sgmcu_debugfs);
> +	i2c_del_driver(&sg2042_mcu_driver);
> +}
> +
> +module_init(sg2042_mcu_init);
> +module_exit(sg2042_mcu_exit);
> +
> +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> +MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
> +MODULE_LICENSE("GPL");
> --
> 2.45.2
> 
> 


