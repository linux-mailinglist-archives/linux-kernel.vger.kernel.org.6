Return-Path: <linux-kernel+bounces-577474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E26A71DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85033B5930
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38D2405E4;
	Wed, 26 Mar 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5tolS/T"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349A23F41A;
	Wed, 26 Mar 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010928; cv=none; b=NNCnXt9POHaqJsX9V/oPjtLSqtEGJon3lypGvTW9P47tsyXQEeqkJGNImVDRiuTJLUC1FXjx80XgI+Gyhj8HPKYpAhFC3n/uGIFOVcKvVMaAJyZD0wHmXmamhLob8ivOS/tSYtQz0YNUlspVU2uZUHo2gVENyviwp+aSYVunIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010928; c=relaxed/simple;
	bh=lEq4Hd3zWk4SO28GUjXnNOiCchFBKjIMJP+Fa8ijp9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSXPbCnc+LuWw8uOZHVM0SPi5R7hX7mnxX3aVoOcQj5a9gDIhoVALq53eqooOA2VkvyAHIyhqicOO68qiuURpSpHONoFqCXwvFPo5PAGJp6CSJD02ZQqpfvvHe5HL8pqKgPy4d9cja/35cYFySAgNvrdWhym4oBdZciEDaQ2adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5tolS/T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264aefc45dso4782515ad.0;
        Wed, 26 Mar 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743010926; x=1743615726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zOWiUHVlWPAh8Ja5Ly3mS6pLUvyY2sWL0fhMkd73oAY=;
        b=Q5tolS/TpJHrU+WLr/yZTVainp1xquluEgpRhK5zn4X1TTpaQNSMyDunEiOOcus4+Q
         Wn1IA0oqvkJ70Yiwe/njhHhn4Vmo67q2Z009wIbYG8t2S+6JXhtSTUCQscAl1Njtpjxv
         5XpaW7Ta+FxtgU93CnlcFsnLkrdl9rIS4DJfiM/xnEjDjzwq7tSNDegl7OBkYqHLLr6i
         s9NidvRMPh0Rwq2KNLeHQUDQyA+p370y+MD3TLfJ5EwQ+uZoTL3W+03cgONpRmh0qxMO
         lAcOW/ZN4vmHzqO+EOo84TFOcP8IAjP6pxBcY1X4YqDgAApNj/od8a2aE6nA9dnNhviV
         ++2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010926; x=1743615726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOWiUHVlWPAh8Ja5Ly3mS6pLUvyY2sWL0fhMkd73oAY=;
        b=AWaj66xRRx1tk3wHNRQMfV9GoWwwReT3LqGhGsGTB7oM7ifniOzxVonTV7KHQKdAXQ
         Isv5CSeG0koM8vVHxznQmiZkyO5VplthYttyKAP/5L5YYGSxwtlLffRm74DtV3xzRDL2
         6gHtqtyEo81Xv/Sgo+N5wXPiIkEGPCZYrjBgE3nDJPtVHbPB55Lu5TXI5GsDBUwTkXY3
         dbyKa332EThP3DPMfndAnY/wRouYsi5scY96r4IPrHqyV0FwGj029QhKqoFpr9DMsNUq
         hkHl4HEdz33pt+IHUOJBI3vCs60rpZtKy73rd47Fri+qTa7cqV/jsZIVnXRwPR4M3BkZ
         3tPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHdBxA6qutuoHACk8tlAr3XV7nzckIPflbvOydGDFjGNP8vsLIZpuTC521ndxk9zX1OImKGMkbVFT4jQ==@vger.kernel.org, AJvYcCW85dgm14mnvjD6s3VyCA3rID3QsMK9W4sUT8/sIkObF60uwcnpfCbzKjCyNu+7vDb43PDZSEYdjfrl+1La@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpfZNUDTXaSWXYuulHyOBSy+pPYYXDcRUTOb6W8f9GieMF3om
	Zm6JWmGPI3C0vjerc/HH5vI7uLSHoj8w33JeNsRiD+0hwWQPjRiwV0EW/g==
X-Gm-Gg: ASbGncu7QKdOuyaE7sRTOZofLGqQRmWUqfA5NavuiaHQ5qg5O+II/FbaQOoMQiq6wuD
	I5csWer6QCo0sUILsHnFAs2piVhtn4uDseCcv5tFqIhTkm6CaN/iNb3ket4y8Jo+LmeLRCdQ6QH
	d9KmFitlClpI4zv7mfX86VPpIZL+fKKWmxICnBvXzACJSN8VLOSKo68CLBGU0s9g6BftgBhAyqG
	r1CKOkbq++3o3h4EYyOsmwX05YieyVM3d2nu7Z/ObX4LY29RnDzy83PIu7v1fC37eAtLg7RmMnQ
	zPXyNT20X7NzcD7zG3KTLIxrSrr09sw5ZaYwAyf8+DZDZCToiBKPxL+AtmwMHimXSLsRE+vRvhu
	qzaNvuuZvqfPLD81E2g==
X-Google-Smtp-Source: AGHT+IElmHLpRBVbkB5QF3rKWMm7lEAW21LHjJtVfX1ua5AvjBDxnGcIiabUflv6lRNZlSw3zdFhlw==
X-Received: by 2002:a17:902:ce02:b0:224:1c41:a4bc with SMTP id d9443c01a7336-22804839a06mr9211685ad.12.1743010925442;
        Wed, 26 Mar 2025 10:42:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da38asm113120555ad.186.2025.03.26.10.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:42:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <efa85637-7a6b-475c-b7ca-3a3c8fc3429b@roeck-us.net>
Date: Wed, 26 Mar 2025 10:42:03 -0700
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
 <be099cf4-338b-45c8-b0d3-24b2cefe386e@roeck-us.net>
 <CABqG17gZV7ZBKOz0gTsrfsuHQENF3VM2T-=O27sWdc1PP9OmPA@mail.gmail.com>
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
In-Reply-To: <CABqG17gZV7ZBKOz0gTsrfsuHQENF3VM2T-=O27sWdc1PP9OmPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 09:59, Naresh Solanki wrote:
> Hi Guenter,
> 
> On Wed, 26 Mar 2025 at 22:19, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/26/25 09:36, Naresh Solanki wrote:
>>> Hi Guenter,
>>>
>>> On Tue, 25 Mar 2025 at 05:00, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 3/24/25 11:57, Your Name wrote:
>>>>> From: Naresh Solanki <naresh.solanki@9elements.com>
>>>>>
>>>>> Currently, during startup, the fan is set to its maximum RPM by default,
>>>>> which may not be suitable for all use cases.
>>>>> This patch introduces support for specifying a target RPM via the Device
>>>>> Tree property "target-rpm".
>>>>>
>>>>> Changes:
>>>>> - Added `target_rpm` field to `max6639_data` structure to store the
>>>>>      target RPM for each fan channel.
>>>>> - Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
>>>>>      property from the Device Tree and set `target_rpm` accordingly.
>>>>> - Updated `max6639_init_client()` to use `target_rpm` to compute the
>>>>>      initial PWM duty cycle instead of defaulting to full speed (120/120).
>>>>>
>>>>> Behavior:
>>>>> - If `"target-rpm"` is specified, the fan speed is set accordingly.
>>>>> - If `"target-rpm"` is not specified, the previous behavior (full speed
>>>>>      at startup) is retained.
>>>>>
>>>>
>>>> Unless I am missing something, that is not really correct. See below.
>>>>
>>>>> This allows better control over fan speed during system initialization.
>>>>>
>>>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>>>> ---
>>>>>     drivers/hwmon/max6639.c | 15 ++++++++++++---
>>>>>     1 file changed, 12 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
>>>>> index 32b4d54b2076..ca8a8f58d133 100644
>>>>> --- a/drivers/hwmon/max6639.c
>>>>> +++ b/drivers/hwmon/max6639.c
>>>>> @@ -80,6 +80,7 @@ struct max6639_data {
>>>>>         /* Register values initialized only once */
>>>>>         u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
>>>>>         u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
>>>>> +     u32 target_rpm[MAX6639_NUM_CHANNELS];
>>>>>
>>>>>         /* Optional regulator for FAN supply */
>>>>>         struct regulator *reg;
>>>>> @@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
>>>>>         }
>>>>>
>>>>
>>>> target_rpm[] is 0 here.
>>>>
>>>>>         err = of_property_read_u32(child, "max-rpm", &val);
>>>>> -     if (!err)
>>>>> +     if (!err) {
>>>>>                 data->rpm_range[i] = rpm_range_to_reg(val);
>>>>> +             data->target_rpm[i] = val;
>>>>> +     }
>>>>
>>>> If there is no max-rpm property, or if there is no devicetree support,
>>>> target_rpm[i] is still 0.
>>>>
>>>>> +
>>>>> +     err = of_property_read_u32(child, "target-rpm", &val);
>>>>> +     if (!err)
>>>>> +             data->target_rpm[i] = val;
>>>>
>>>> If there is neither max-rpm nor target-rpm, target_rpm[i] is still 0.
>>>>
>>>>>
>>>>>         return 0;
>>>>>     }
>>>>> @@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
>>>>>         const struct device_node *np = dev->of_node;
>>>>>         struct device_node *child;
>>>>>         int i, err;
>>>>> +     u8 target_duty;
>>>>>
>>>>>         /* Reset chip to default values, see below for GCONFIG setup */
>>>>>         err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
>>>>> @@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
>>>>>                 if (err)
>>>>>                         return err;
>>>>>
>>>>> -             /* PWM 120/120 (i.e. 100%) */
>>>>> -             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
>>>>> +             /* Set PWM based on target RPM if specified */
>>>>> +             target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
>>>>
>>>> If there is no devicetree support, or if neither max-rpm nor target-rpm are
>>>> provided, target_duty will be 0, and the fans will stop.
>>>>
>>>> Maybe my interpretation is wrong, but I think both target_rpm[] and rpm_range[]
>>>> will need to be initialized. Also, it seems to me that there will need to be an
>>>> upper bound for target_rpm[]; without it, it is possible that target_duty > 120,
>>>> which would probably not be a good idea.
>>> Yes you're right. I missed it in my analysis.
>>>
>>> Here is the logic that would address:
>>>                   target_rpm = 120;
>>>                   /* Set PWM based on target RPM if specified */
>>>                   if (data->target_rpm[i] != 0 &&
>>>                       data->target_rpm[i]  <= rpm_ranges[data->rpm_range[i]]) {
>>>
>>>                           target_duty = 120 * data->target_rpm[i] /
>>> rpm_ranges[data->rpm_range[i]];
>>>                   }
>>>
>>> Please let me know your thoughts & suggestions.
>>>
>>
>> I would prefer if target_rpm[] and rpm_range[] were pre-initialized with default
>> values in the probe function. That would avoid runtime checks.
> rpm_range is pre-initialized to 4000 RPM [1]
> I can also init target_rpm[] to 4000 RPM as default along with above init.
> 
Yes.

> But still there might be a case wherein DT doesn't provide max-rpm but
> target-rpm is set to greater than 4000 RPM
> Thus there will be a need to check to cover this kind of scenario.
> 
> Please let me know your thoughts & will implement that.
> 

You'll need to validate target_rpm against max-rpm either way,
to make sure that target_rpm <= max_rpm.

Thanks,
Guenter


