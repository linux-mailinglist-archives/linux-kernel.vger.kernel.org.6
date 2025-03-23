Return-Path: <linux-kernel+bounces-572895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0FA6D000
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD4A16DB04
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5BA13CF9C;
	Sun, 23 Mar 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieWnvGZI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8894C8F;
	Sun, 23 Mar 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742746933; cv=none; b=o0LekWljNIe0sZsu1q98sVx6rm17kTZQnsaCZCXgn4iWQu7xqrDi+l8ScTCIlfW9eayi4EYGId3vqRsnzkeuzAcXtTHb6b8UKzUvb468yQywbitBtbrWl6N2D0TIPiGBelI+i9GGrNHNj0ewUvYmjnPy/c92qjS+o9LMYkzURGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742746933; c=relaxed/simple;
	bh=q036Fe1iv7cT4AB1zv/nFiTHRNdV9yUpdS90/TLI2GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGNSdkJfBc0AMfesphYkXjWelI5ohR+fifUEvFfC7ZuwTW8TCQT2gN9fL8/9uYPXGrKAh1YHyltufpvxdRWODJ5zGQOtDsZI6AJj7TvnBqU9HSiiVTkS/ij60xEhkSHqmlL1PDq+yvdqiVLkQiT0VazJLE98KJfzZ8k7d2t4Eek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieWnvGZI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so60096295ad.1;
        Sun, 23 Mar 2025 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742746929; x=1743351729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pTdAK/wKY7jfSKtQEJkVe+qAv5L7d4bZvz1PDGMc/tU=;
        b=ieWnvGZIBFGv5qRA2QMYcdChKJitimu6k3VQY1ySB3RLc+HFYWAtwZYesMzc9lF2F9
         3vBUv0Zu1+w1pImAfeVroiXcJ+NVNy3/GSQTUx3OrWl0H+sD9l9UVtsywPjrXPfZrJVb
         V7AzctbwtdAaHHpqJLoHojGnYxb8fA6CBkxgerc5KMe9/bbQUvFqIRRY86+YoE4AXmb5
         F9ahCyVGSe2cxukRORvaOzXKBGD0GYYldeB9XY/uxnYbk5k1TWtWa8en+baJPN+5X1ib
         gExFf+U7lZ7RxsXS757IMIZdJe/jLv2e8bj5pulIPjyGYyxHx+6afgDBqNf1A6SrY9rD
         VwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742746929; x=1743351729;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTdAK/wKY7jfSKtQEJkVe+qAv5L7d4bZvz1PDGMc/tU=;
        b=j5Dh5JnmotKQK1ChDT/UD1NKgIV2PWVtGt37D6vjLVD1hAIzqwV0T2TCQRGN7ZzGIJ
         d4ez3VM2iHYr4Fb1ur4zYr8moLOnMyBFp32UFga6QG475US7D1qeu8qRVdS37ElxCr3J
         0+uATlwi+LoecCCJwgCkv2r8F8w0SLxNI2R6tDpB9qve4m/LqSITXEveCe8fMS/t7ak/
         QvzrEqeH0750IgGE76p3yu+L/B3yf8kvD3R2c/MHUnACMcN9gRtOaRtQTz9u1ensOnDn
         wK4UaJfVVKhKewtc32E0CO98MYBij21iBmPXf6EExyVCyLAoIHFji06c51wpOfPHbik1
         m6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUVxk+pd2xeyswcC1t7EbqFJcAowQTcH5uXVm7EYtPn3TBAK+ro0GSqV4Ks5OJ6VAo6BcQJzJUN96NUMz80@vger.kernel.org, AJvYcCVIefYMzz62tIkErWBR2UXEqgeb3zc5AFRlyBu6GmeO5LiYqI206xt8fku9em0varwG6ym8JhPgKAUlIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywkk0T+PPCrvOxPEeRp3tTe83PMekX5OF+PSka7MQt12phhSnG
	U1TVutyiKMdjS4poDhdUdK6idKbolfWYjbbMqHz4n7dGuPRFc4BS
X-Gm-Gg: ASbGncsMa0Q7Ouy9R+kDiE2Ne40ZOPqzRGMFIDFg6pEY/V9o/uwlyEKHR4yNpq7gIce
	wB/kOfo4l8FurHbMBuoX3OIEaBSFfWRGCFxuuMKMx4cm7UcHcwbtGj/+pVGySPCPEtZ1srFSjYN
	GNI1sRM2jJ3U3GxAfA9J5UILNRzguXbQvSPSOBAXvNpBr0qON+fGYszLV/6DK752cHTUYuknt5y
	zWEkFczd1X3B2WAAy0rb1F9HRvzdLqlCsgmIJoawU0mdy/ADDBoxPYr71sDf5mqaz5D0Rwk7qn3
	irM+uFSbGPH6v04YXKpRSIRWymwJKvvS5qSGEmulbbQIQ3laWwyMPUZjwCMBY7xZm4EKMLIyPb8
	yLvIFe7w+q5kaFYqYrw==
X-Google-Smtp-Source: AGHT+IG6VUBxkvp+7lvxHnroaakUBVaLpnjcK/uvgzdR3iT+X6iOcICEAXpe7ZWNj+UCrT+OXfH2xg==
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr188255455ad.48.1742746928770;
        Sun, 23 Mar 2025 09:22:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811c1b8fsm53154905ad.154.2025.03.23.09.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 09:22:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7b5c4001-1a5b-4ea0-aca9-e0c88ec7a98b@roeck-us.net>
Date: Sun, 23 Mar 2025 09:22:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
 <e4da28be-66ca-45d3-9ccf-34819460b463@t-8ch.de>
 <f50221fd-1d76-465b-ba53-62c08c6f8536@roeck-us.net>
 <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
 <42c49b0b-cef0-49ca-a5b2-5bb05eae8dec@roeck-us.net>
 <45d0681d-3446-409c-8d9b-0309dbb93ff8@t-8ch.de>
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
In-Reply-To: <45d0681d-3446-409c-8d9b-0309dbb93ff8@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/23/25 09:05, Thomas Weißschuh wrote:
> On 2025-03-22 09:10:40-0700, Guenter Roeck wrote:
>> On 3/22/25 08:23, Thomas Weißschuh wrote:
>>> On 2025-03-22 07:12:48-0700, Guenter Roeck wrote:
>>>> On 3/22/25 06:55, Thomas Weißschuh wrote:
>>>>> On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
>>>>>> The ChromeOS embedded controller (EC) supports closed loop fan speed
>>>>>> control, so add the fan target attribute under hwmon framework, such
>>>>>> that kernel can expose reading and specifying the desired fan RPM for
>>>>>> fans connected to the EC.
>>>>>>
>>>>>> When probing the cros_ec hwmon module, we also check the supported
>>>>>> command version of setting target fan RPM. This commit implements the
>>>>>> version 0 of getting the target fan RPM, which can only read the target
>>>>>> RPM of the first fan. This commit also implements the version 1 of
>>>>>> setting the target fan RPM to each fan respectively.
>>>>>>
>>>>>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
>>>>>> ---
>>>>>> ChromeOS embedded controller (EC) supports closed-loop fan control. We
>>>>>> anticipate to have the fan related control from the kernel side, so this
>>>>>> series register the HWMON_F_TARGET attribute, and implement the read and
>>>>>> write function for setting/reading the target fan RPM from the EC side.
>>>>>
>>>>> Should it be possible to switch back to automatic control?
>>>>> I can't find anything in the hwmon ABI about it.
>>>>> And neither in the CrOS EC source.
>>>>>
>>>>> Am I missing something?
>>>>>
>>>>
>>>> Not sure I understand the context, but the fan control method is normally
>>>> selected with pwmX_enable, which is defined as
>>>>
>>>>                   Fan speed control method:
>>>>
>>>>                   - 0: no fan speed control (i.e. fan at full speed)
>>>>                   - 1: manual fan speed control enabled (using `pwmY`)
>>>>                   - 2+: automatic fan speed control enabled
>>>
>>> So far I associated pwmY_enable = 1 with the pwmY attribute.
>>> Also controlling it through fanY_target does make sense though.
>>> It could be clearer from the docs IMHO.
>>>
>>> That also means that the patch under discussion needs to implement the
>>> pwmY_enable attribute.
>>>
>>
>> Does it ? Does setting the target fan speed automatically change the fan
>> control method ? Normally that is orthogonal: One does not necessarily
>> want to enable a specific fan control method after setting a single related
>> attribute, but do that only after all attributes have been set.
> 
> With the currently proposed patch setting fanY_target automatically
> switches to manual control. And then there is no way to go back to
> automatic control.
> 

The driver should not do that.

>> For example, there could be another attribute specifying how fast the fan
>> speed should be adjusted, or there could be minimum and/or maximum permitted
>> pwm values. I am not saying that this is the case here, but setting a target
>> fan speed should not automatically change the fan control method.
> 
> Makes sense.
> This goes back to my original question: If pwmY_enable is *not*
> implemented, how would it be possible to switch between the different
> mechanisms?

It isn't. However, as I said above, the driver should not change the fan control
method when writing fanX_target. If that happens in the EC, the driver would need
to check first if it is in manual mode and only permit setting fanX_target if
that is the case.

Guenter


