Return-Path: <linux-kernel+bounces-236750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582291E6A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3AB1C22096
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C016EB48;
	Mon,  1 Jul 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHHVEhiC"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B246434;
	Mon,  1 Jul 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855023; cv=none; b=sbaUzkkvOiRuS45lXOmSIJIxvbZVMhglwgJ8TEme9cyGIRz1FYyaiIk71DnNA6+XcZfvmOrVdEyzx/Ofl7EmMhfUPhJP1FomT8UOcbFxfKUsspTv8YfQ5TTXyrJfPXC5P+bm/GyctBVozRJ/2K371lilPng2PFM+kYfH/bn9yAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855023; c=relaxed/simple;
	bh=9B3GeytStm6KQQcYRGClzHWWdF4lELSrsW7DZVhGry0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoALporIhg70ZWJNOm7EWMpRYaQHez0rZ562oiYwLw10sU2fbQ6WOPWm/znQW7jV8fxgveC+S4ypncer0hnm01JMveKMjT83sleM265Ns0OIHo8Xw/GGka5CbuCEaJ3i7pdI/h3M0r50RWig0X0WQjGF6XlIUSyFavZ7twDi5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHHVEhiC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066c799382so2721319b3a.3;
        Mon, 01 Jul 2024 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719855022; x=1720459822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uYSIMscRLzxdz7e0rxkejaGUQTT7AfQBN3YKjGG/1O8=;
        b=MHHVEhiCUKGx3gwzdHZilZPzsgYOvZ9nE45PiqXoYPRytMqEP1OKBfnu9cuz4mOJB+
         aHncHbmZcOBdwgwV2oEAIseYzOsvFgmdrceVfratqCg7JCc7T3+iDXQ6U0KXtRayUVIv
         GSnOG4UCYAMSB1FIZ5gzPSRezf3l8AbAYJFUO2GHehoYkrcai0HNebD1TO8mgqx05SCE
         Nm/Uu/xTkdEyjapbpWKWQ2wDfTeNN7ccl21MVppPNAZoLbhn5Ipin6xh2ODpPVkGr0N9
         gjcnykDjNX2vVl+BAcB0eidSFOYVK0cxwCZECnS4NN8kCfWgT5mC/uWVCH6UHAGE4QA+
         EPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719855022; x=1720459822;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYSIMscRLzxdz7e0rxkejaGUQTT7AfQBN3YKjGG/1O8=;
        b=pRD7vLI7CxQsZludnBpJm5hAdl5YOr6ZEMWbfGZ+khk+7hKQcLNLiGkliXyagKjZRz
         3a1QgAEnVvcOy5kOPXhZVsqeghNnDaLmISsQok/Bn5EX5ZQxpQE4r6xP2qccNWak1J3h
         sS6EpEnLIlkW+3HJr742gtSD9zlh1N48J51eUA0+3b0vxHgaWTyJJIGEElxzPJbNYTti
         Ql4OFMKKp9sh0PXDanLhDXQd8zp99Aa4HjJhPLmeemkBF2lchJquSC0pNefIvlEs0w3f
         pFePIsUFVoAv4bUFVXIMttxcARxtuH6GBXGEWcIFXfxBnr/62U1iXS6ei+7MXtoUZGkk
         HedA==
X-Forwarded-Encrypted: i=1; AJvYcCUjhK8UiCTbPROv/Eq7qI3l1ndaoGg1R+qrh1h452Gam5vV3wyQqmwfanQ9PvbY3WW6hKheKPC+pY7tPFirIpi3Dop0y5zlrYJRT1o=
X-Gm-Message-State: AOJu0YwUmQ56P56yVZEB6Vl/hbGjn1UXeA4zikLK69KWVvXbKB8mjg8R
	KDk/viRuiVAz/s/RRQ6MTGIumisYwJumQaYMDur9iFpm372DlQvD4PuXHg==
X-Google-Smtp-Source: AGHT+IGxlI6ltNr75wSTpbDicqo6+EMHbJK+6H8aGeSTokG4V5NB2VpNUrfS+xX5GMlBXL89nHOU1A==
X-Received: by 2002:a05:6a20:9191:b0:1be:d260:93c1 with SMTP id adf61e73a8af0-1bef60fce2bmr10607756637.9.1719855021584;
        Mon, 01 Jul 2024 10:30:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15693f3sm67524775ad.218.2024.07.01.10.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 10:30:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1934f597-9133-4784-9a41-8808a1253376@roeck-us.net>
Date: Mon, 1 Jul 2024 10:30:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hwmon: (amc6821) Convert to use regmap
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-10-linux@roeck-us.net>
 <7a829bf2-c5f6-4234-a224-52328045f581@cherry.de>
 <13b73e86-fed0-4ef0-9815-eda765f2a70c@roeck-us.net>
 <7a1f2916-3e2b-45ee-9681-7327d7b1798a@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7a1f2916-3e2b-45ee-9681-7327d7b1798a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 09:54, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/1/24 3:47 PM, Guenter Roeck wrote:
>> On 7/1/24 06:01, Quentin Schulz wrote:
>>
>>>> -#define AMC6821_CONF1_FDRC1        BIT(7)
>>>> +#define AMC6821_CONF1_FDRC1        BIT(6)
>>>
>>> This should have been squashed with a previous commit.
>>>
>>
>> Yes. I had found the bug but then fixed it in the wrong patch of the series.
>>
>> ...
>>>>   static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
>>>>                char *buf)
>>>>   {
>>>> -    struct amc6821_data *data = amc6821_update_device(dev);
>>>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>>> +    u32 regval;
>>>
>>> Why not a u8 directly here? We know single reads are going to return a u8 so no need to store more?
>>>
>>
>> The parameter of regmap_read is a pointer to unsigned int.
>>
> 
> Eventually through the many indirections, because our regmap_config sets the size of values in registers to 8b, it's a u8. But it's not worth our time to optimize this.
> 
> EDIT: coming back to this after reading the rest... Wouldn't we have a possible endianness issue here? Especially with the int8_t cast or the sign_extend32 (wouldn't the sign bit be at a different index on LE/BE ?). Sorry for the question, endianness really isn't my cup of tea.
> 

The underlying code does an implicit conversion. For example,  see
regmap_smbus_byte_reg_read(). There is no endianness issue because
the returned data is always in host endianness order. Sure, that
could be big endian, but the sign bit is still in bit 7.

Thanks,
Guenter


