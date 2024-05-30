Return-Path: <linux-kernel+bounces-195895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CCA8D5400
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6292328425B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFBC84E1F;
	Thu, 30 May 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIIYnpTB"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7818756A;
	Thu, 30 May 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102013; cv=none; b=D2eLweYTTsQakBfuDcI9MgcP96qlt4NxGt5X4WuSxMUVFImHaSMGm9/LOPtAF8ZeY6T02vYSNfKwsg2/ziFsrzjzpRe/dYqG7HUesjRNMPDFDDuT1UJf/M64u1bzNLuQepzqJSgO4aeM/y1sN7m1j9+z0XbHSKyuVdRB1PIGilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102013; c=relaxed/simple;
	bh=nOJFQWqNKzm+GdzgNB2fOL4HWWjcT4f0uqIrqikqFwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkFsThViEIU74agmvQBmn88qsag2oEfLQZwe2vMyaMsOpEXaPuZChwyqG50zteRUiWurDG6pIyF8wuULHHJOzSp7HEI9upUtsirzczszfjJTHhpwnfQxQOYMf21F5SkWkqT4BDSayh1Uk73rjMoZb+o8JSE6CjrACJUnzC3Ck24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIIYnpTB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-701d854b8dfso1195450b3a.0;
        Thu, 30 May 2024 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717102011; x=1717706811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E8+qAtTovxBphlFz5Q9kg2Dc3KRxfx07X1VODQucJoI=;
        b=HIIYnpTBUuGtArxdgt+j4/n4YHUHRJrPlNOI5d7ZTVakmmnTlspXAL82eiwsLJ/afX
         UcPnJkbnjB/Xlx+wrrnvc/f1ct4AKRP2XkngZsDS0PP5DvPYX7YG6W9RryaoY7+x/rAG
         ApKhs8zlL1lngG1DBP+DjQxKyzWKlmLCq7SaRVqb+tTEwHj1QbaV+gn/oPCfYDsE6gl5
         tYjvtmo/NlVK81cGQYp6yc3z3xkEMfyU77IUmS7rEuqsjjxTkRqwXgo3HqAtAGxVNy/b
         9NlLpon+lbS5QuQPxF1BMnulNXI6DlE/8TqpFc63+e4eIWFIpPCChbuv0rvDAcU5Rd/K
         BBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717102011; x=1717706811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8+qAtTovxBphlFz5Q9kg2Dc3KRxfx07X1VODQucJoI=;
        b=ew6eizoi8O4rxvzhx6xV2zt+rTuUjyAgnpjuNGL1GSi+CIfdSEyRfC2JcEL1z7IN1D
         thzUEtiP9H+gFk7oiTwssx/BMAaj4vyBwo4IifsOcdlttfZmYSWzJZ60FKaYNrrURQCu
         dxT8SD7S2J4dpgo5f/IAfRr9jRq742LIwpi26GQjkRavOU+UAAU89I0CbetU0U9B2bTd
         Wo4wAu2B1k7A7z5u2vn8ZBM/BvdHh2lkzmaLAz+6EGN9F5+nSx7QRXI+yqHq9z5TNrnH
         JKoWDJQfYj/WFbK6j1ESsGTCnY33mkv5Q/0AruOdRtUr2WVoqgVjMyKa/Yo/v710nFup
         x36A==
X-Forwarded-Encrypted: i=1; AJvYcCWAbavR1TqrbfL5CDVoeXnDNXWb5FUSAz5S4efqybVtxQwr0nmBQ9Q425yXckhUF4kWaCoOkTB3al/DgJo29vNTBNgFoXPa78gc4GzbRs0/gR34pPLqRXr5KDVxPIjjeio0l6MeXvsnSA==
X-Gm-Message-State: AOJu0YxRNsFWsh6akgtEakFGZ51GstXBsCGGALnTO8al6V1KVO+IePBF
	qGcsOdZaUFipA53LQDBMXtdUDIlqEVut7e5wkUUUJHeAYkP++K1f
X-Google-Smtp-Source: AGHT+IFShCqcNSDKlp0Dx6ANbT6Kuu9MGYb6cJi9/4Ggz9XKAikrrbK6oyNY0ksXg4lxCEwBk6reCw==
X-Received: by 2002:a05:6a00:1f0e:b0:6f8:d4b8:b215 with SMTP id d2e1a72fcca58-702310ec3dbmr3108892b3a.6.1717102010983;
        Thu, 30 May 2024 13:46:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c26bbasm141513b3a.217.2024.05.30.13.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 13:46:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
Date: Thu, 30 May 2024 13:46:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 13:20, Thomas Weißschuh wrote:
> On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
>> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
>> sensors. Such sensors are typically found on DDR5 memory modules.
> 
> I can get the module to automatically probe with this change:
> 
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 97f338b123b1..8d9218f755d7 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -382,6 +386,10 @@ void i2c_register_spd(struct i2c_adapter *adap)
>          case 0x1E:      /* LPDDR4 */
>                  name = "ee1004";
>                  break;
> +       case 0x22:      /* DDR5 */
> +       case 0x23:      /* LPDDR5 */
> +               name = "spd5118";
> +               break;
>          default:
>                  dev_info(&adap->dev,
>                           "Memory type 0x%02x not supported yet, not instantiating SPD\n",
> 
> (Credits go to Paul Menzel [0])
> 
> Maybe you can add that to your series.
> 

That is specifically for SPD (eeprom) support, which I didn't provide
in the driver. It does not register the equivalent jc42.4 temperature
sensor either. Given that, using the code to register a temperature
sensor seems inappropriate.

I didn't include accessing the SPD eeprom to the driver because I don't
have a use case. I don't mind adding it, though, if others think that it is
important.

> To also work with my PIIX4 I2C bus, I also need:
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index fe6e8a1bb607..ff66e883b348 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -195,6 +195,7 @@ config I2C_ISMT
>   config I2C_PIIX4
>          tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
>          depends on PCI && HAS_IOPORT
> +       select I2C_SMBUS
>          help
>            If you say yes to this option, support will be included for the Intel
>            PIIX4 family of mainboard I2C interfaces.  Specifically, the following
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 6a0392172b2f..f8d81f8c0cb3 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -29,6 +29,7 @@
>   #include <linux/stddef.h>
>   #include <linux/ioport.h>
>   #include <linux/i2c.h>
> +#include <linux/i2c-smbus.h>
>   #include <linux/slab.h>
>   #include <linux/dmi.h>
>   #include <linux/acpi.h>
> @@ -982,6 +983,8 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
>                  return retval;
>          }
> 
> +       i2c_register_spd(adap);
> +
>          *padap = adap;
>          return 0;
>   }
> 
> Though I guess it's not the right place to call i2c_register_sdp(),
> I'll look at it some more and then submit it.
> 

Hmm, I didn't find a better place though.

Please copy me when you submit a patch; I can test it on an AMD system with
DDR4.

Thanks,
Guenter


