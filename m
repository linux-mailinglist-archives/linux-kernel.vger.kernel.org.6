Return-Path: <linux-kernel+bounces-197674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F388D6DB4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4DA28315B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DBAD55;
	Sat,  1 Jun 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd8kvGou"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D577EF;
	Sat,  1 Jun 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213216; cv=none; b=OMfqR4j61qSpGO0eob7rweRYn+XnvGB206j/74fLvUcd2zX/q4MROvA6KhhutxGxrJmzHfo21AXCdFypYRCWMQ+Cp9GYTwQ35ZOoQsTz91lN9BzgyXdVAhxiea6AEBw2WruS1RPlpm6cpjCVpd6TRqtlaGLNZ2chQmnmUI8UVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213216; c=relaxed/simple;
	bh=KEEdPLNVdqfSjyhALp1HJ9qxwPaj8w9dK8cghWNmoGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rV8q1vYzv6GUObRHnp8gYWFBpV7SdGEWOU0m4+MVAF1mQ43TCHoLviu6UPHtSzP8Z+Rkh9HnGFA5tnkJ0DkvaHir/7iXV0rreQHWjjFzqcfhigz9JnGaa8OkzlWcVZaKnq88o/DbsgMEqjcsvr+ky77gnoy9pM+aquFyrGA6bJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd8kvGou; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70244776719so1208383b3a.2;
        Fri, 31 May 2024 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717213214; x=1717818014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1XeGJoDNevKhJ/nivTwO8itGmDdNVe3CxH4h/8/J8AU=;
        b=cd8kvGoubq9IlB/6xCGjTH57hzm0M+2niVrxvKq48xBlQeWcOshQlzzvz4SiAPjL2B
         nC2tEQjOo8KOikn0z3S5Ti6mOZG/zeEHO3j8UPBEyuG77AIEbeFk+Xt+rNJWUTgrlViE
         gB2AglnM0xcjwSmOBjEfwgxoNwJv2Y736f/w69VJhoTdp9tjAn8Qsk4VchraBcjPmbRm
         m0NWyab9jlzv8a173iJ589tW3FVD+Ik31q58r/XTRhXvNZTFZLsMqE7fHmczIq0TWk7D
         eDaMDuuJENtK9UTdlIOGnEGOmggG2FPwTsDnhSPxaIvg8FiWGoFk7bRmkduce2yD/D3P
         oBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717213214; x=1717818014;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XeGJoDNevKhJ/nivTwO8itGmDdNVe3CxH4h/8/J8AU=;
        b=KAfMBuYwpTU2XmYIkpFzbFqCHxFe2FFfMTMsU1YwmJlLuufeIN6Yr7lz0kM+qtCLvg
         RIZsZBdv9Nq2Ovg6RRkX7w2RTuPP6woDF5aLd3CA6sVIhL/RTgPm1N4+PXk89WkQbdXD
         2YfBCkMIFT5VC1NGXRhrQCSglRpmObnyOPvu+fAqNtnthN/wWXitjYkB8KEoCngg5sj3
         MAM3UfQoZT1FH4NfADjn9mw3AjFQIZVPM5+ks/jl1CBDVHb7v777vn5nKR+KAor8YszV
         phtcJmGRQ2+KpfD8vfvEIy79B9QOqgSKFutJd2HEBmXZF9L+ah7XnBJ10gduzuNL/mtH
         9h2g==
X-Forwarded-Encrypted: i=1; AJvYcCXvRii8+4fEuvsPzr++yWU7AJTnelGUHh7iueN5l0f7JRmB9bXID/i0EgBXZbbK0p33N4W8lmgz67FYJqeEPZgNlaTFGyncnAxsRrwRhh0QFxzNg2Sd/DOCPinyOOeKXThF1oqLdFwLl6hdyL8HKEdZYHaXOKwgBLRoPIsMJMstc/5J7OrH
X-Gm-Message-State: AOJu0Ywqp+xpVVsgbR/pdoHCb2JLogZgMx89z5E5dtN0Ma+BGMCuee25
	RjLyx024oJWPsHxSaCU2H1Yxyhm63GfYlKAoehVaWExq4SVuYjqc
X-Google-Smtp-Source: AGHT+IFvHjukOieMX7NMC5qniDmJnLBg8bfLeGcOefmzGReZ8pYVv8tuExMznaQB8aUdcaUgtR0quQ==
X-Received: by 2002:aa7:8893:0:b0:6ed:cd4c:cc11 with SMTP id d2e1a72fcca58-7024789b0abmr4266127b3a.25.1717213214018;
        Fri, 31 May 2024 20:40:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70244246b3bsm1967177b3a.70.2024.05.31.20.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 20:40:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e5d95d3d-1ca5-43f1-8c17-d24bd38f28b7@roeck-us.net>
Date: Fri, 31 May 2024 20:40:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hwmon: Add support for SPD5118 compliant
 temperature sensors
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-3-linux@roeck-us.net>
 <uvikiflwuoz3szchmvke7p3ymqvcngkydehk6cctdv24cxsh6r@7d5vxcvdca6l>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <uvikiflwuoz3szchmvke7p3ymqvcngkydehk6cctdv24cxsh6r@7d5vxcvdca6l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 18:28, Wolfram Sang wrote:
> 
>> +/* Return 0 if detection is successful, -ENODEV otherwise */
>> +static int spd5118_detect(struct i2c_client *client, struct i2c_board_info *info)
>> +{
>> +	struct i2c_adapter *adapter = client->adapter;
>> +	int regval;
>> +
>> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>> +				     I2C_FUNC_SMBUS_WORD_DATA))
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
>> +	if (regval != 0x5118)
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_word_data(client, SPD5118_REG_VENDOR);
>> +	if (regval < 0 || !spd5118_vendor_valid(regval & 0xff, regval >> 8))
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_CAPABILITY);
>> +	if (regval < 0)
>> +		return -ENODEV;
>> +	if (!(regval & SPD5118_CAP_TS_SUPPORT) || (regval & 0xfc))
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CLR);
>> +	if (regval)
>> +		return -ENODEV;
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_ERROR_CLR);
>> +	if (regval)
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_REVISION);
>> +	if (regval < 0 || (regval & 0xc1))
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CONFIG);
>> +	if (regval < 0)
>> +		return -ENODEV;
>> +	if (regval & ~SPD5118_TS_DISABLE)
>> +		return -ENODEV;
>> +
>> +	strscpy(info->type, "spd5118", I2C_NAME_SIZE);
>> +	return 0;
>> +}
> 
> What about adding DDR5 to i2c_register_spd() and dropping this function?
> 

Yes, that should be the next step. I didn't want to do that here because it
would introduce a cross-subsystem dependency. Of course, that depends a bit
on your position about such dependencies. If I do that as part of this series,
would you Ack it, or would you want to handle that through the i2c tree ?

Guenter


