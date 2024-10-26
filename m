Return-Path: <linux-kernel+bounces-383300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10D9B19BA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6AD1C20F68
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A41386B4;
	Sat, 26 Oct 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK5JMhLh"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D31C32;
	Sat, 26 Oct 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729959503; cv=none; b=ldoMASlxQSj3935qAvHgRjcMOYcS6LE2gcOCZOKk1fi2o9J3I/mJEKYQeSE6cNBLgh4UCDHhq2/mCie5fMGAa3cFb6q2cvqkVmmmdDPz7pctVpC4zpTaMO3gJYKPPCpwc1HXttZ+NlC9gXIFm4n2w+Kd34okV3shfP1RdVYihSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729959503; c=relaxed/simple;
	bh=YRA2+QiLHNNG8pdfubF04EZo0MYGCEVriTOrPYrzbdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfFNMgGnrkrN4dsJVjK6DDkA6ch3w2fu/fjnERXX+KhjHhryV6Dd6JXzbK6/MnqqqQ0ti/1xvtfypgDMYNCU1K5BTzG9J8TbjT/cCnZIYNYNj2euj8f4Sn0SAhl5AblT51tHnjBW4xo67dO58/TOC4AbohvypktUcQbUqSTevqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK5JMhLh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca7fc4484so21017945ad.3;
        Sat, 26 Oct 2024 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729959500; x=1730564300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EWIqnxu/JxGht117KjHODOpqIDN18XNbuZizYPff4UM=;
        b=iK5JMhLhffwaH/iPe2edx5UQwaCdPvhNkj7zw7+WWBYgCdpDSmXq5gQm00f5jDiS5S
         yfs3aZSq5GnxyIoTl4bTVqvjlokHQ2g8OSC2KEf+wohZNbryGZH1YlaN50XQrPXpELgs
         HWn2S9r0JW+jVdVVH5JGtVmwBq5182lftljjvD3EYu9qeWJxldAqdIQtcdkJG62XLHHN
         AwKHS/tY/EUpyYv6feVsGkGT5Bi24yM1igX2bF6fS9uk+0kXPizOSc3Rv2fDi5NZALSz
         ClQTFA21O+AW3ulmrfulAJ8LhYi2LkSP9TaUMgoWs+SgdacnYQWO9v18uI0fmsn/ml1n
         EmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729959500; x=1730564300;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWIqnxu/JxGht117KjHODOpqIDN18XNbuZizYPff4UM=;
        b=B+kBsWAxi40oe2Nk2CgfW2EnLf/ASOEjWvoJ61fhHf2U5fdhF0HUJYLyfWrnPOldSW
         +AkSckmZCXETqB0DPaMV5J8VbrJtBQ49w1Z/WzSQ737YhCJQS97YpmGMa9/xnaGHkYmS
         zm21Mw/v1BbjTKiYfwmW1ufM8C4IMCWgqopBeFhga2E9Nzogf6mMRhbxLtbxndjbcEG7
         j9ouT9JSkjheys4ZJnASxgyJsKYH3zdGez/IGWi1bS/eABlFp2+YUrfCjzCM/h09hqY7
         KPg9kyJgAfV1HhpH65858No7h+PlhUgCZvcceHRwKNOyqJWbwvjVeE9gh0w9mE9jCDP4
         QJGw==
X-Forwarded-Encrypted: i=1; AJvYcCUonwdAIQxtTCJ2y3rzd+RiWGN+fk6P5vlSTtXHkbWxc4TsFP9hGwQ+CPUevLdlDaiLBCAimVL4fF9b@vger.kernel.org, AJvYcCXGKjnTUOW6jrSDidtXrqmGJkDHP2kU9J7xebfTK8dk9PKa4VWUsEkh5AXyc2L6WaIWmr0mlufaoJpo8Bcv@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhD6ZN+zyiz5XX1kFkfQ8BPMpY0XPfQXkmtXXqWL9YTOzY4uG
	DC0SGLFfBTbDeEOI+cjJqB1LAdPBeZNuHsNIc6rkJL5zegfCJ2Gk
X-Google-Smtp-Source: AGHT+IHea3xJ9dkyyEN3gm5d7IDOlYMHjHcXSoRhTopXVRinsjGq0sfv29QAs/tqJ4xm4Z9s2FjomA==
X-Received: by 2002:a17:902:da8f:b0:20b:a10c:9be3 with SMTP id d9443c01a7336-210c68ab555mr42230195ad.21.1729959500105;
        Sat, 26 Oct 2024 09:18:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc012eeasm25959865ad.172.2024.10.26.09.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 09:18:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <495cff30-b472-4903-b1b1-e28349061ef9@roeck-us.net>
Date: Sat, 26 Oct 2024 09:18:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: pmbus: Add support for ltc2971
To: Patryk Biel <pbiel7@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
 <20241026-add-ltc2971-v1-1-109ec21687bc@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241026-add-ltc2971-v1-1-109ec21687bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/24 02:08, Patryk Biel wrote:
> LTC2971 is a power manager similar to already supported LTC2972,
> it uses the same register set but supports a different voltage range.
> 
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
>   drivers/hwmon/pmbus/ltc2978.c | 34 +++++++++++++++++++++++++++++++---

Please also update Documentation/hwmon/ltc2978.rst and drivers/hwmon/pmbus/Kconfig.

>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index 73a86f4d647288be97615f19a5c6314e4036e6a3..681e7b811dbcc263fe8f5e4f9da30fcbc7e019ad 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -21,7 +21,8 @@
>   
>   enum chips {
>   	/* Managers */
> -	ltc2972, ltc2974, ltc2975, ltc2977, ltc2978, ltc2979, ltc2980,
> +	ltc2971, ltc2972, ltc2974, ltc2975, ltc2977, ltc2978,
> +	ltc2979, ltc2980,
>   	/* Controllers */
>   	ltc3880, ltc3882, ltc3883, ltc3884, ltc3886, ltc3887, ltc3889, ltc7132, ltc7880,
>   	/* Modules */
> @@ -61,6 +62,7 @@ enum chips {
>   
>   #define LTC2978_ID_MASK			0xfff0
>   
> +#define LTC2971_ID			0x0320
>   #define LTC2972_ID			0x0310
>   #define LTC2974_ID			0x0210
>   #define LTC2975_ID			0x0220
> @@ -533,6 +535,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
>   }
>   
>   static const struct i2c_device_id ltc2978_id[] = {
> +	{"ltc2971", ltc2971},
>   	{"ltc2972", ltc2972},
>   	{"ltc2974", ltc2974},
>   	{"ltc2975", ltc2975},
> @@ -564,11 +567,19 @@ MODULE_DEVICE_TABLE(i2c, ltc2978_id);
>   
>   #if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
>   #define LTC2978_ADC_RES	0xFFFF
> +#define LTC2978_UV_STEP	1000
> +
> +/* Common for most chips */
>   #define LTC2978_N_ADC	122
>   #define LTC2978_MAX_UV	(LTC2978_ADC_RES * LTC2978_N_ADC)
> -#define LTC2978_UV_STEP	1000
>   #define LTC2978_N_VOLTAGES	((LTC2978_MAX_UV / LTC2978_UV_STEP) + 1)
>   

Please just add the chip specific defines as you do below, and don't move
the defines above around. It happens a lot that there are common definitions
followed by chip specific ones. Spelling that out explicitly doesn't really
add much if any value and just results in rearranged code whenever a new
chip with other parameters is added.

> +/* LTC2971 */
> +#define LTC2971_N_ADC	4500
> +#define LTC2971_MAX_UV	(LTC2978_ADC_RES * LTC2971_N_ADC)

I think something is wrong here.

4500 * 65535 uV ~= 295V.

However, the datasheet says that the output voltage is calculated by
(register value / 1024), where the register value is a 16-bit value.
65535 / 1024 ~= 64V. Where does the 4,500 come from ?

> +#define LTC2971_N_VOLTAGES	((LTC2971_MAX_UV / LTC2978_UV_STEP) + 1)

Does the chip really support 294,908 voltages ? That seems impossible since
the VOUT_COMMAND register is only 16 bit wide.

Unless I misunderstand the datasheet, the voltage resolution should be 1/1024V
or 976 uV, and there should be 65,536 voltages. This is from the chip datasheet,
PMBus Command Description, Note 1: Data Formats, for L16 data.

If my understanding is wrong, please explain and document your numbers.

Thanks,
Guenter


