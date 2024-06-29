Return-Path: <linux-kernel+bounces-235068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964BE91CF4A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 00:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568CF1F219B8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8E137747;
	Sat, 29 Jun 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZUaAhSk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3E2594
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719698430; cv=none; b=CsvfxH/fJuf54axwbRfH6mlumwfehNsZxWrYofVd5ANIzUOavSJKZlyczb8FCEBBIa6bRgRXWxNkszaAlt9TCBjjqxADdCimlCvN3F8eHukJGr0zA9W6IWzdaBwSktu4Kp+xlfXlaY2ztC1g3aba1b8ShClFJHF6hiLnr6ECLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719698430; c=relaxed/simple;
	bh=2zBVv9x/nwKpUra8KgXXSHN+8EYs14NVDZYKvLDofH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPp8cCyhtDY6SQbMg+N14bUePkyd/5DCmRKHkISRwOVdoKLSCQICN3tsfSvFgPevQ2Z5STR2wAeTDBgTVOt/4BZJxoUfZU3/sFi29nll5o0vZndBwjuyXkhTwoIa4kHzAC1itYvlPXBEgdXI19bJxThxbwecwbIopfI5C7dXavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZUaAhSk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so20137111fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719698427; x=1720303227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tTD0nASi/IhDl3ouNDZR9ACzcnXLKeS+7jLy0rheN9o=;
        b=RZUaAhSkcorm7ROEtI4XIhOutJSNFKRJtXVEfHkqJZ5dHSZmnC9B7vJF3dNtZOfstp
         inevGHAfD74BAmbntpxNPLRdaSdFSCu1I9NI6ttdCOPKz/0TAYS7g7mjDZ++kUnQWENh
         0geeKUeZE1LefN525U5GMGBMvOBynETN9a84DF9ZV5WiJe2M77Cf81PToCy0hN/lV9R4
         nYaRRj/LNnT3QwwVaT+0JtVYYsjuZoUPKfCPyX6elElSoQ2DU00S3jVAr2RpbX4fAQUR
         Z8IfBOiQVcvcxVjEc25Y00JpHLyIm/4rajqdA9UtEukHej98IlsWOKjOpyuxm33u8WrG
         Q5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719698427; x=1720303227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTD0nASi/IhDl3ouNDZR9ACzcnXLKeS+7jLy0rheN9o=;
        b=ZVVBpdQUjMv1DyzkgMnsWw46I4+8wLB6WNiZuuHrC12ECvstmQK60e3wNO6CKrsVE9
         IrBTAkAlcFIzRF3Ht/uZG1u8B6CyQxtz8WmBpjYwUidNBLLs6evWA6Q6QgjlFn0vWeuL
         UTGv6DnzmZJPGPeHTSFvE5feDrA96/gmVfcFhkj5EW6sBuUY9SuUZJk0kV8y4V2Qhowc
         mzEXWDilzRVYvsYMkeNqi2ay04+KaFhL1AyH02fGzIEwknaKlsFMgmBO4VPR2McFo3PV
         TyWVlvh23xJfEbGrg4nuZ3IRrKM93UsVXwRTcH1MSJrFyrYu0+La60v0sTumsMd643me
         4eng==
X-Forwarded-Encrypted: i=1; AJvYcCWO5CFev6sSIK3ilN45VVC9mEMG4ncM7RztHQTJQQ32GoKlI7k0+dkSnz4KVLvCQiPL5LN0OL4zTmeC/2fc98tXMTlvAmaI7dY2YWQa
X-Gm-Message-State: AOJu0YzC1gnQE7m7rL7XaaDK7T1aoq+WpfPbad6+Fa8UJkwIkLqwA1KX
	yH3ZMjwr8mTpnzMGR67xxkVYvuXiUAokGdWwtPRqCiLd9Ddocw0XHDw8sQ==
X-Google-Smtp-Source: AGHT+IHPm6BKIoRHnZKrKcIvBn11MyhH5OPhZKQ7VipxkJzty4WLPqPoyUtl9GYZsWDBKhh0CUwCDw==
X-Received: by 2002:a05:651c:1509:b0:2ec:5603:41a with SMTP id 38308e7fff4ca-2ee5e345927mr13156551fa.2.1719698426609;
        Sat, 29 Jun 2024 15:00:26 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c588:e100:b576:b9a1:a7cb:98f6? (dynamic-2a01-0c23-c588-e100-b576-b9a1-a7cb-98f6.c23.pool.telefonica.de. [2a01:c23:c588:e100:b576:b9a1:a7cb:98f6])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-586138163e1sm2660147a12.48.2024.06.29.15.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 15:00:26 -0700 (PDT)
Message-ID: <e519e9f2-5e25-4ec3-afb4-42d15da941aa@gmail.com>
Date: Sun, 30 Jun 2024 00:00:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] eeprom: ee1004: Call i2c_new_scanned_device to
 instantiate thermal sensor
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20240629173716.20389-1-linux@roeck-us.net>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240629173716.20389-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.06.2024 19:37, Guenter Roeck wrote:
> Instantiating a device by calling i2c_new_client_device() assumes that the
> device is not already instantiated. If that is not the case, it will return
> an error and generate a misleading kernel log message.
> 
> i2c i2c-0: Failed to register i2c client jc42 at 0x18 (-16)
> 
> This can be reproduced by unloading the ee1004 driver and loading it again.
> 
> Avoid this by calling i2c_new_scanned_device() instead, which returns
> silently if a device is already instantiated or does not exist.
> 
However i2c_new_scanned_device() runs i2c_default_probe() on the device,
whilst i2c_new_client_device() doesn't access the i2c bus.
If possible I'd like to avoid this overhead.

> Fixes: 393bd1000f81 ("eeprom: ee1004: add support for temperature sensor")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/misc/eeprom/ee1004.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index 21feebc3044c..71ca66d1df82 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -185,6 +185,8 @@ BIN_ATTRIBUTE_GROUPS(ee1004);
>  static void ee1004_probe_temp_sensor(struct i2c_client *client)
>  {
>  	struct i2c_board_info info = { .type = "jc42" };
> +	unsigned short addr = 0x18 | (client->addr & 7);
> +	unsigned short addr_list[] = { addr, I2C_CLIENT_END };
>  	u8 byte14;
>  	int ret;
>  
> @@ -193,9 +195,7 @@ static void ee1004_probe_temp_sensor(struct i2c_client *client)
>  	if (ret != 1 || !(byte14 & BIT(7)))
>  		return;
>  
> -	info.addr = 0x18 | (client->addr & 7);
> -
> -	i2c_new_client_device(client->adapter, &info);
> +	i2c_new_scanned_device(client->adapter, &info, addr_list, NULL);
>  }
>  
>  static void ee1004_cleanup(int idx, struct ee1004_bus_data *bd)


