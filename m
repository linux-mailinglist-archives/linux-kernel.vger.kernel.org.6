Return-Path: <linux-kernel+bounces-333621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CFE97CB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C1E1F260CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2B819EEC0;
	Thu, 19 Sep 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWMW1dx8"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF01A01D8;
	Thu, 19 Sep 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758909; cv=none; b=WreRwFPKSfuku/tm1q1oNalrHH0pJdQxl5apaHqIpfATg4KIryBbm+kHN4ib2O7+u+HgyReU/d2vFvvI/Xxp4P3rtJBiWRtAq3f/olQYG/DiwnsKUJI+U8tsZEg1m06nNRTk2Qp7h81F3KysmjSl6BurD+58s3HHE99x3C+F7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758909; c=relaxed/simple;
	bh=B2/FOVC9v9i8iEw2MGpo6NCNky8mexa2QIr8h7pOLIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/0Kj6J5dtDF6bshcXx0cZWP0EBmqhiTmsjmlK0sR361xIV/k4HTeYQyJ3/IjnyxYaieWOhKX0gs6lQLTkBLLbXjC1Tq7Jp9Th8er13TJdHJ1DTP0mfM9NMNYNeBaC9PMsEoNOP510LXrBtPBpDQMiO0hCi7R6DTkC4ksqpuzMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWMW1dx8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so794643a91.0;
        Thu, 19 Sep 2024 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726758875; x=1727363675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kNWssd1E6Jef4MU7zQ3uq+JxdfhSZWwf9f7R1jt9wF0=;
        b=LWMW1dx8RvVXT33CxxEHPzoIgYTK/DJSGXFo42a2udOc4uiorLL1sPuY1YFq2rSScw
         oNkpkc1nvqJPWS3p9a50G6Z53t4pPp7zD3cmLM5tkCtT9YR7ir0llj/FTTb0ASDiKXVJ
         rR4ylmJxjK3A9CjcXULPSCcTyl8FngmU/3agOVM04mIW1swcM+fTxu8gQrZmPuDnyP8d
         CnHB4DuyRPBnjI8jX/yP1fYNLp/pArEokQfc+R3I1GOL9ZIX5gqZqFjjYVOtO23VSKeu
         Ghnjmeyo/rI5QZasYVMv1IDYz4W8ZVMlYCGpgwmLRUGpRbtVLpG90aY5uxFMQJTH0nEs
         I4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726758875; x=1727363675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNWssd1E6Jef4MU7zQ3uq+JxdfhSZWwf9f7R1jt9wF0=;
        b=WAgDFK87EBTY5ekYQOD912/Uwiaa4KB7Q4rnmgKj7DxWbsPv5BMQm1aUZBBd4x1rAA
         3myk5+DH5mQuqcI0O5RSwN8NVElH40WalqAni6qexs98rMW8/dEE/n5SlCjXuQc0Fk6P
         FVQmjkAn8QYRqdVMVvW/Ir8OegZg5Wg3BwkLxPDAaqxPUTp+h5iHy9NJN8AeIagaeEfa
         j+Z8mMK0cZVGz5YIoKZLC+mjLxl3IhY2XuWYa0adSOWX9b6a6ffjleuFcKMwz5fA5NNz
         wYVWpl+eJb2ZASGH8PID16TJiSFXUKxj842zUm5apdpiDDb624nopt42BGdn2GGCzC6o
         ruNg==
X-Forwarded-Encrypted: i=1; AJvYcCU8OMOPZqMsP/5QBtAkflg2rJFe8KyPNQLOWvptZUHN9uv+WZaSyjhjX8tWXuxIDcxHdmCpxiw8OaBDp0+A@vger.kernel.org, AJvYcCUTOLzBvfFi+kyd5B95060802fOkDKRe8HFr6Yzq4hPIlkp3gc7Vg6C3/V8A3OnxDaJvZFopWF9G7my@vger.kernel.org, AJvYcCWIfl+e8CjLcxTCmAFy4HzTyH+pusuYGhgKVNrc3HgJfnYyBHPkZh9+4cIstcAAaNi1GKz3V9SymMA2Hgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0eFr3r0qfDRBskfProjeMHLe411j7fV/UYkKuoxbW/K/jigG
	cEXddfac4BKQMyUOj4fPpCxKYNHyaW7TAAok4/ulAb5NW6LKQUFA
X-Google-Smtp-Source: AGHT+IEi3AowNzO8i9uDs0sXoc447ClTKz2IawdQrcWq92LMtho7EyBxNfabXKon3xWwbNordYRlVw==
X-Received: by 2002:a17:90a:684a:b0:2d3:babf:f9a3 with SMTP id 98e67ed59e1d1-2db9ff79c75mr26073042a91.2.1726758874968;
        Thu, 19 Sep 2024 08:14:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee984f0sm1990263a91.19.2024.09.19.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:14:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9c4749a-cb15-44a6-ba6b-59beede257df@roeck-us.net>
Date: Thu, 19 Sep 2024 08:14:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: hwmon: Add adt7462
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Khanh Pham <khpham@amperecomputing.com>
References: <20240918103212.591204-1-chanh@os.amperecomputing.com>
 <20240918220553.GA2216504-robh@kernel.org>
 <d825a93f-be5c-45b9-a8d4-5c412ddec232@amperemail.onmicrosoft.com>
 <2229b659-c753-4f56-a1ab-7e8984f9147f@kernel.org>
 <d1a2133e-92d2-492b-9a82-047a9fe80cf6@amperemail.onmicrosoft.com>
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
In-Reply-To: <d1a2133e-92d2-492b-9a82-047a9fe80cf6@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/24 08:02, Chanh Nguyen wrote:
> 
> 
> On 19/09/2024 17:39, Krzysztof Kozlowski wrote:
>> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>>
>>
>> On 19/09/2024 11:43, Chanh Nguyen wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: onnn,adt7462
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  resets:
>>>>> +    maxItems: 1
>>>>
>>>> How would this work? 'resets' generally is used for on-chip devices and
>>>> a reset controller. That doesn't exist at the board level. A standalone
>>>> device typically uses a GPIO lines if there's a s/w controlled reset.
>>>> That would be the 'reset-gpios' property.
>>>>
>>>
>>> Thank Rob for your comments! The ADT7462 includes an active low reset
>>> pin (Pin #14).
>>>
>>> I'll change 'resets' into the 'reset-gpios' property.
>>>
>>> The example in the binding will be
>>
>> The question how did it work in the first place is still valid... I
>> think we might benefit from asking people to post their upstreamed DTS.
>> Otherwise we will take broken or half-baked bindings, because we never
>> saw the bigger picture. :(
>>
> 
> Thank Krzysztof,
> 
> I saw the ADT7462 includes an active low reset pin (Pin #14) to reset device via I/O pin. So, I introduced a reset property follow the device datasheet.
> 
> But the adt7462 driver has not yet implemented this property. My platform also doesn't design this pin on board, so I don't need it at least now.
> 
> Anyway, I hope Rob, Guenter and Krzysztof can give me advice on whether I should add this property to the binding?
> 

Not from my perspective, and I won't let you add it to the driver unless you can
actually test it. Really, this is such an old chip that it would make more sense
to just leave its driver alone unless there is a problem with it. Why didn't you
just add the chip to the list of trivial devices ?

Guenter


