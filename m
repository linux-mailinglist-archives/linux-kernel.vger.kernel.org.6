Return-Path: <linux-kernel+bounces-426357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8979DF215
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA024280F73
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812D1A265D;
	Sat, 30 Nov 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcYyZQEi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082271922F1;
	Sat, 30 Nov 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732985570; cv=none; b=IOmfqOf+XLlBMyQYQ9QIYj6c9llc87GNTZ+B4djb/di9ODIdmSI5Y3LNA9tmEZ+SnwH0AkhrU0yS/wFXcLVFSGqOcmxnsllN5ZMBfkjrbfzrBw8Ph3ScYs14IK9IsRY/ZlKzJgLvkYUOmeXRa+TKrO2nKOkOh9TZiXb7CLFV4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732985570; c=relaxed/simple;
	bh=qK012MOKjo/DdO+iPYPNzwrb0I9jjlABwSvNAjlnZ1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6DwtWw4Y2xuPFPjQOjKqQWfg6GLM59QnXl/gP2/0h6LPZob6Otb4sqSrihKoO3AnTxxXFT4lE/hUEVSK8ZS0uFiWGtLhtiGDvCbK4SBn11Srd5oePe2bFK2uYI6k0clbch4iQoQJSWgdMXoQlgXiaPp8tpK17FRY3utXmcGRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcYyZQEi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21561af95c3so4312345ad.3;
        Sat, 30 Nov 2024 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732985568; x=1733590368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2F2dTosiAf2t/hqtpNg9kLil//AQHtCi8gSiX9bgYj0=;
        b=HcYyZQEil4d5br5mRvg3s4JVjjW4gNceMGkRGXQPmM/jxw+c+4lAZ/igHXDF0MN31l
         xzq+jAfy2JVIBf3DawWDgFkxl2ySvXPI+NeoKCjsZdY/cGhjVCb/z8hcnUTh8EAxG7U9
         dP4F6w6kwsO8QKee+dIRa7eeMhgCl20FA1n7KUDe5pCxbKwu2iH8nCuLNpMHDe5szeqR
         0BC3xit0J78VXrlbMsvKV4nvWf8V+fCcQ332uP4Op11IO3ruGbKhVblWOnGDVOOTu8wz
         hwg/s6wSPJ6MV0tpzUAWNVx7Vj6V2pLrerhHuSvJv4a/Ti4MPW21y1H6HJ1adifHLy9N
         3C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732985568; x=1733590368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F2dTosiAf2t/hqtpNg9kLil//AQHtCi8gSiX9bgYj0=;
        b=nqIc+cyTlDP4PxhdOyseeSFl1Mkf2ettv6xuIMbopYHzRkPY0qsf8hH9cq2Ukbsn3a
         fOHGFkAQQQ/TazvouLXxu08dYXNQDTnWjAWvLxRQaaC99YpCf+Is7/RlBxk8jmaiVzYl
         rOp0c5vebAkQ+v/w0Xx6LOwNmxkgWwQnnYDsn19O3RPnECxUGU5MjSONx6jol3h2ONyK
         YxR06sNCiWqc6aKpHEqVxJmMA7KVUefY0GYP1jqxXb0QPtZiWsZcO+2X5pP5BFS88jHa
         utuGnTbyan0f5HAFCQV+hx8AfffVRmgP+QGRkpy5v8cycvuuczvDkiNEB/5TFuYu8COH
         1v1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1P+eq6OZU/sGi2A1HdQpr1Fjq/9lxt1QA7bYv0HPBqt4JsoNpQnjX5fofD5xnG09GCFi+YqQvtPeESl/C@vger.kernel.org, AJvYcCWyg+W2WCP8Pw1TeN8l12gpyNGWyGoHd+64MWCsBp0fgM6F1FZp0H3dL3OzmIr51cm05GHGX8zJyIsZcSw=@vger.kernel.org, AJvYcCXDNtm5vN031PrN5uXYnoOsjz8T0TMiL6ZRdUfvVpvQUpAerKxM6Z3a4LQ2OdpVQxE+AkTkolGfqgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQXjm+NSQGALs5fHhwDNvOeskipF7lUKIoAx/rePE7hc5Tw/P
	f3man01k9thaq8i9VbTq0PKAPzaEBZGvxdqqssQ2jJuqZBFsBALt
X-Gm-Gg: ASbGncsXy8HrZQETEOkunFp/OcDZMxhDoGupcjCJ7RGE9OfAiSEOTKpixHm9akZNyVR
	V1BrnkulnxEfoalfpKIPZYu5BclC5pMhDw2G9DdtO/Gb0PVzsElrFMAaC2QSqpj8Dxo5b57oHVH
	HHBcGQwDWi8W4zItmE33WlbUkrEMkwDdIt2r+BmcqxCK0crQtN/DlWsj5f2oGU/iXOt6vdFMZvr
	iVpib6OZRCGNwqhbAyz+0+1hcUyS+kyanxPR83jAy5pQOdyxsXAseYt7rd2DanyqLhasTEwMLwA
	ruZhRGT1urH6y3l9v1FLyh0=
X-Google-Smtp-Source: AGHT+IHRR/Wg8MSXoSRf2ZFdLhRQhbHbJEkx/6NanZPZJt+34nJu3TBALCItle0ZULBIi/ZTjg2jAA==
X-Received: by 2002:a17:902:dac8:b0:20c:70ab:b9c3 with SMTP id d9443c01a7336-21501a44acfmr219881885ad.34.1732985568321;
        Sat, 30 Nov 2024 08:52:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm41270945ad.52.2024.11.30.08.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 08:52:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <72181994-c982-49e8-beae-4ee16a789f4a@roeck-us.net>
Date: Sat, 30 Nov 2024 08:52:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Li XingYang <yanhuoguifan@gmail.com>, corbet@lwn.net, jdelvare@suse.com,
 linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
 <20241130144733.51627-1-yanhuoguifan@gmail.com>
 <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
 <CAB95QATeOynGJ=MMJrsMXatMms0u9ec+qJbh6QfAEUTnjNmZdA@mail.gmail.com>
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
In-Reply-To: <CAB95QATeOynGJ=MMJrsMXatMms0u9ec+qJbh6QfAEUTnjNmZdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/30/24 07:47, Eugene Shalygin wrote:
> Hi Günter,
> 
>>> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
>>> index ca38922f4ec5..d049a62719b0 100644
>>> --- a/Documentation/hwmon/asus_ec_sensors.rst
>>> +++ b/Documentation/hwmon/asus_ec_sensors.rst
>>> @@ -17,6 +17,7 @@ Supported boards:
>>>     * ROG CROSSHAIR VIII IMPACT
>>>     * ROG CROSSHAIR X670E HERO
>>>     * ROG CROSSHAIR X670E GENE
>>> + * TUF GAMING X670E PLUS
>>>     * ROG MAXIMUS XI HERO
>>>     * ROG MAXIMUS XI HERO (WI-FI)
>>>     * ROG STRIX B550-E GAMING
>>
>> I don't understand how this is "sorted". What is the sorting criteria ?
> 
> I believe the list in  static const struct dmi_system_id dmi_table[]
> and the list in the .rst file are in the same order, and I want the
> board declarations to follow that.
> 

So you don't care about alphabetic order, just about using the same order
in both files ? Fine with me, and I don't have to understand it, but it is a
deviation from the current model and should be documented for reference to
ensure that I don't call out people for not using non-alphabetic order
in the future. If there is some other order, it would be even more important
to document it to help people understand what it is supposed to be.

>>> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
>>> index 9555366aeaf0..f02e4f5cc6db 100644
>>> --- a/drivers/hwmon/asus-ec-sensors.c
>>> +++ b/drivers/hwmon/asus-ec-sensors.c
>>> @@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
>>>                EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
>>>        [ec_sensor_temp_water_out] =
>>>                EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
>>> +     [ec_sensor_fan_cpu_opt] =
>>> +             EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
>>
>> This is an unrelated change. It affects other boards of the same family.
>> It needs to be a separate patch, it needs to be explained, and it needs to
>> get some confirmation that it works on the other boards of the same series.
> 
> Well, it is the same register as in the previous generation, and while
> it would be nice to confirm that it works in other models of the 600th
> family, I can't see how XingYang can do that. I can check with the AMD
> 800th series though...
> 

Ok with me if you confirm it, but it still needs to be a separate patch
since it it not about adding support for a specific board.

Guenter


