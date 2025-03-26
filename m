Return-Path: <linux-kernel+bounces-577371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433AFA71C40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B743BC278
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B011F891D;
	Wed, 26 Mar 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF41UH8+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EC1F8691;
	Wed, 26 Mar 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007749; cv=none; b=DYveaS1GEbKWguRTZQHIy09lSEGnaB47POY7ItllqggZwS2+TdUPKNSZz9cdLh+M5UHP6Dbl1dajo7si3HyWtFJnI63l83XuSVHgCM9n2KkwPzBvAvXcy152dVf5v+c1lwAyvgz1JZdtx6oBxCMvfrMQlyD9L1yHgjM3z65BDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007749; c=relaxed/simple;
	bh=nhmW9Hjs0+zFtt6OvFSEOjxsJlWfaFnfBPPRw0ryUKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRUkfPBAMhcx3ILc9L/Tjm1JEKe04EjLzG+aKRqmwBl3rYCyHE6yYjhLSDzjfmJ0rMBQuETl2OY0HTBIiDH5Cj00URgX752g3MvlYEsqeyMsPC+pUuFoTIWRdxEe5HuO+JQt+EFVxKVQJiLoVrH7a5eZMOsgw+pBv9Hu+xPUK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF41UH8+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224191d92e4so2001155ad.3;
        Wed, 26 Mar 2025 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743007747; x=1743612547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KUO6d0jjnba0ckVkngGpAIGlmyEdZ4QTqAQWQ6PsVsY=;
        b=aF41UH8+SmpqIa33HEVuOHUU8R0BMee6OGLKw2gBXYGKmH2D4977N9TaV018kaTjTt
         ZTy46p3f16rwCYtDT+zjyYSOI25W56tjUmx6zbA/rlT9ifGmoNGXEz38MPOhLWKYcyNF
         QC5uDtssqQyBPOgdP8iVOTqeVxnezCxUzGGOUUTLuwfB7fyu1aN1RwrlPIBRsclj4Wa4
         cnszG+kL+34VGG5Lb4lV+Vk/UW+nKm5aU+B69/HIHCMW9aREhEy4g0mCR/DrW89O/NX4
         QH7MPmitWIXfi0E6DLL2WPEKJunk/NRdoq2W4dDVy8Fze+CaWBo8Ake0edAtw3fhrMF8
         NPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007747; x=1743612547;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUO6d0jjnba0ckVkngGpAIGlmyEdZ4QTqAQWQ6PsVsY=;
        b=EJBtPBtBdPU8fzJ9h+WrXqRWi5ZFFe0mGB0Th9VNWReCssmuCu+i4/TcDSAvmclZI4
         9EnfsuufoiGeo3zjFjwVca5sbmZhn952l1mzQ+IX9CFmp/uOHaPzRW50g0o1OUKDTjEv
         OWOuXnIJcXbYlAKC1ROoE4I6HwWWdahdgeQkJtNWY7UypkvN0BHauHQFxvpuS9CqbqDf
         3HCDLaIHWkClFJ03Ls26ncPxM/ZOOeDnvSLXa1dCq34y9vZ12XDNqZU9dj26M8i9Aeyt
         qjC0F9Xkaogyzu8bnh1cBcX8ygfNj+u3VTiUpE/XoT5ttnQeXDv5dVfRzRY1fJ/fjvhh
         1uiA==
X-Forwarded-Encrypted: i=1; AJvYcCWOz0NbgIXlZOoETrTxymD4FUVwjM9ejNHfEQp0u+ij4UHG0RcSLkuSxeNb3KNvjROtuniH5HstlTYAAShm@vger.kernel.org, AJvYcCWpPYuj8Du/xGm3wwjVmy9Md1kSFc50tOfV5DgSfh8voMJni3LVy03gnYaT2dTMTP9RiXy73D4Uf4w+aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/7eaChcUPW1elSxb3cLJtmhiiV/7Qkg+S7799Bc+OuvsbU1/
	Hpd1tTfs8ySluGiPtc9iqLDsToycZllIa9jiNrHNu2BITdZp3T7Z
X-Gm-Gg: ASbGncuajBTCc3UjO603dgOD0Cg5Jgc6GOE1WYdxYj7gOEtcPkl/WzMQMaWiliur2Sk
	O/tMHlHFBCYN37fopME5A6erlC/eTrB4Yf3h83tGou0X587g0hoZQ6L8hL86PcFVV5PZcb9YyW7
	rH7/W27nzxpOjOolweQcclv3IJkz6WtwkverLk/hhaO5B/1M8bSPSwyu4Pnoxd4U22gRSMpBEzT
	lGcSWDNRUG71T66wxbuwK0kIG1x/aw2TI5TXKGnx6W7W6HmHuak/4nMkG0SkShec79qNDXbehlG
	yiZ4XtXM7Buj+4q+7vYfF0Xh8qXX6ctnFOYKEDDuGFEbYyCPEavoOt+EDw/faZ4Lf5WOksJdkHf
	McnLkT8fdDT5XS3i1GQ==
X-Google-Smtp-Source: AGHT+IGPXss10gz0X/i61yF6230qlud8oKXWAERwmUM5ye6hN8TGfr1HpMcjgIq5P9dOyklUPRYBMQ==
X-Received: by 2002:a05:6a00:3cc9:b0:730:9946:5973 with SMTP id d2e1a72fcca58-73960e10bebmr423774b3a.5.1743007746321;
        Wed, 26 Mar 2025 09:49:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd7a3fsm12903893b3a.67.2025.03.26.09.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:49:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <be099cf4-338b-45c8-b0d3-24b2cefe386e@roeck-us.net>
Date: Wed, 26 Mar 2025 09:49:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max6639) : Allow setting target RPM
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324185744.2421462-1-you@example.com>
 <b6668968-897f-4864-913c-d4d557f1d7cc@roeck-us.net>
 <CABqG17h8cpnFkdD-nnqyr+UnwADU9XWK6TGBxj_FCH37Y3Q1Lw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17h8cpnFkdD-nnqyr+UnwADU9XWK6TGBxj_FCH37Y3Q1Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 09:36, Naresh Solanki wrote:
> Hi Guenter,
> 
> On Tue, 25 Mar 2025 at 05:00, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/24/25 11:57, Your Name wrote:
>>> From: Naresh Solanki <naresh.solanki@9elements.com>
>>>
>>> Currently, during startup, the fan is set to its maximum RPM by default,
>>> which may not be suitable for all use cases.
>>> This patch introduces support for specifying a target RPM via the Device
>>> Tree property "target-rpm".
>>>
>>> Changes:
>>> - Added `target_rpm` field to `max6639_data` structure to store the
>>>     target RPM for each fan channel.
>>> - Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
>>>     property from the Device Tree and set `target_rpm` accordingly.
>>> - Updated `max6639_init_client()` to use `target_rpm` to compute the
>>>     initial PWM duty cycle instead of defaulting to full speed (120/120).
>>>
>>> Behavior:
>>> - If `"target-rpm"` is specified, the fan speed is set accordingly.
>>> - If `"target-rpm"` is not specified, the previous behavior (full speed
>>>     at startup) is retained.
>>>
>>
>> Unless I am missing something, that is not really correct. See below.
>>
>>> This allows better control over fan speed during system initialization.
>>>
>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>> ---
>>>    drivers/hwmon/max6639.c | 15 ++++++++++++---
>>>    1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
>>> index 32b4d54b2076..ca8a8f58d133 100644
>>> --- a/drivers/hwmon/max6639.c
>>> +++ b/drivers/hwmon/max6639.c
>>> @@ -80,6 +80,7 @@ struct max6639_data {
>>>        /* Register values initialized only once */
>>>        u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
>>>        u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
>>> +     u32 target_rpm[MAX6639_NUM_CHANNELS];
>>>
>>>        /* Optional regulator for FAN supply */
>>>        struct regulator *reg;
>>> @@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
>>>        }
>>>
>>
>> target_rpm[] is 0 here.
>>
>>>        err = of_property_read_u32(child, "max-rpm", &val);
>>> -     if (!err)
>>> +     if (!err) {
>>>                data->rpm_range[i] = rpm_range_to_reg(val);
>>> +             data->target_rpm[i] = val;
>>> +     }
>>
>> If there is no max-rpm property, or if there is no devicetree support,
>> target_rpm[i] is still 0.
>>
>>> +
>>> +     err = of_property_read_u32(child, "target-rpm", &val);
>>> +     if (!err)
>>> +             data->target_rpm[i] = val;
>>
>> If there is neither max-rpm nor target-rpm, target_rpm[i] is still 0.
>>
>>>
>>>        return 0;
>>>    }
>>> @@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
>>>        const struct device_node *np = dev->of_node;
>>>        struct device_node *child;
>>>        int i, err;
>>> +     u8 target_duty;
>>>
>>>        /* Reset chip to default values, see below for GCONFIG setup */
>>>        err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
>>> @@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
>>>                if (err)
>>>                        return err;
>>>
>>> -             /* PWM 120/120 (i.e. 100%) */
>>> -             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
>>> +             /* Set PWM based on target RPM if specified */
>>> +             target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
>>
>> If there is no devicetree support, or if neither max-rpm nor target-rpm are
>> provided, target_duty will be 0, and the fans will stop.
>>
>> Maybe my interpretation is wrong, but I think both target_rpm[] and rpm_range[]
>> will need to be initialized. Also, it seems to me that there will need to be an
>> upper bound for target_rpm[]; without it, it is possible that target_duty > 120,
>> which would probably not be a good idea.
> Yes you're right. I missed it in my analysis.
> 
> Here is the logic that would address:
>                  target_rpm = 120;
>                  /* Set PWM based on target RPM if specified */
>                  if (data->target_rpm[i] != 0 &&
>                      data->target_rpm[i]  <= rpm_ranges[data->rpm_range[i]]) {
> 
>                          target_duty = 120 * data->target_rpm[i] /
> rpm_ranges[data->rpm_range[i]];
>                  }
> 
> Please let me know your thoughts & suggestions.
> 

I would prefer if target_rpm[] and rpm_range[] were pre-initialized with default
values in the probe function. That would avoid runtime checks.

Thanks,
Guenter


