Return-Path: <linux-kernel+bounces-561568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F2BA61392
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727C61779BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095E200BB7;
	Fri, 14 Mar 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObRxrdCh"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F21FF5EB;
	Fri, 14 Mar 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962207; cv=none; b=I6oOTflpoFVcaG4DWsxMkUjgE/XJ+7ZwymB83wBPfAlko9NK6Pqe+k8OpH1u/J/rwtqwtTrMr/F5iynx7WXwX2xccpSHDbn4ijTeJUy8nvOov/BRrhTAhLFS2UiiyTUO7bqeS38hQv7SJAT0Z862rPZYZcupFNOx3uNhBQT+qVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962207; c=relaxed/simple;
	bh=pEjdX24R2qOQHhHO8GtjN8hy9iBx/vf7c+ERVnPYw0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGfcPBxD4IV7LGgXYoXZyY3AzT3BI4ziDnqTcsdblcm1wMTizwrDAahewxkIXeXxPdhjs5/L7hAU2up+W4vwqHo+NeEQoiDf0xLTPk3xrlhGJQXbWR5qLvybA+TmUEWflBNck9Oa51V9ctNKwxz3q6+SvFPWdtVcjqGvdk+XDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObRxrdCh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso4439337a91.1;
        Fri, 14 Mar 2025 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741962204; x=1742567004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uNJToVRxkj9gSN78UZ+8BwUBvD3Z5JHkelp5nFBUOE0=;
        b=ObRxrdChT4YPF50OAKJKvnmc1RuLq1ercnDR6a8VE4/eMOfAFUtou2SSbfyu2wGd3e
         nHolZnJhNU91KOe/FdGpc6OiHgaxN9Pmt/EHXkHK2qVSPj/NF3to5EzE0RhWGW9elL5a
         alTfL77FzofQlpGgOASrnud7qJztGgQAso2SZRZ43TsCt/Pix91Ab9XjO7Bx4UstJkS/
         UkPc1C/6R+84WiwEyBbIxshQH/NCzy8edi+ewOQD8zZOizlx8gqjPebre5h8MmUX4F6o
         xdkfZ9MKRtWfPbbTj+hutKMD3IPf3NR7acsU7+rfuUguax3ZMt/q3iu9tryY3oaoo/c7
         fI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962204; x=1742567004;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNJToVRxkj9gSN78UZ+8BwUBvD3Z5JHkelp5nFBUOE0=;
        b=pn4yj15z4rJEszjWRFaoU82qJFMgFjordtb0MlqlsIVjGfPpQymA9fCf/o9do/KCZe
         9oIuB9mNmopVqJLgStBGZUCuAbXRLcXmP9Ak18GXuMUHCL9e8pXzyoSPBjd5zr/YkH0N
         t/7yjTY9w7YroXfxmG1IRajDN02aRxGScCcwdODYD1WZ5e+WmLgLwj+CnxaApqBHv91+
         r9RCux2zmbObfrFe4s5/8750TLqaPrjlVO15btV08PYYNS3lGF0eAsIVt9xl8977sHLa
         Y0LhrRdJyEfA1rDOb385WUw/iAv5yumOmx0xWUXW4njo8kkijqCHDe8dQ/UNN68xZJJh
         7YBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGGsjbv6UOUi5HUF505t+3pN9Wu5iuaR721b6mR1cMdBYiJ6gE5xCHTofpUkvVkciDK5LXTbGYw+oYGHT@vger.kernel.org, AJvYcCVYXm2MxTsKdMFvj1C8e497YdS651TZYhXbv4PRsMKJMIALKc5H8A7OHcD8wndnCWed/ANPWop6JoRX1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZEjSkMqpTKovTVahHIlkTW4cz5jsujM3804EdjwggYxsbAiu
	71v9hNZ34/oQr2zN/2o/cJAv96lXFYHEqWOn3vSq2qgZogwlf5qu
X-Gm-Gg: ASbGncsTAcyFmBJW3U481iLw2AFekRUVstT95w1KzUnjofbSPfPkOxlmXyq4ui8pQrM
	dDNqbovLGnCZhswTq7HGwRVwTEXa+q4EblZmk+Uy65UWRDqtHA0vvVAGsa4YgQiQlG4UXnr1ZWL
	Sna98kGEZSNRkMZgb7eOl/JkY8Aibs0Bj9gbQGR9DR4gyRV++E3n1faT9wbJxkWSUpYc5mkZoDC
	iAYZg3oC2LrP4Ye+5KiZhmx1QrGCyL6n3T38FGGBgYUpzzP2H6PaJny72f6EPSWTBCDsSmv0lsM
	bhIQcPFSMVyPIYMWix7QjC1Dann0D12JalPOzY1f6NlM2i05DzVsRu5hhkQYlOzj8rev6SDz8pj
	l1emKmuoDMQc7Iqk8rg==
X-Google-Smtp-Source: AGHT+IGyKSHsBl3vQIbkGe1tj6XJ5FsfEJXyyChd8Wl6/UgHQoCRuL4PFEak/DRtGbx+aaAvVsfZmA==
X-Received: by 2002:a17:90b:5144:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-30151cff08emr3314697a91.21.1741962204416;
        Fri, 14 Mar 2025 07:23:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301534f477csm1064747a91.5.2025.03.14.07.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:23:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b9301c9b-9fac-46c4-ae6a-95029a1a2668@roeck-us.net>
Date: Fri, 14 Mar 2025 07:23:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: Sung-Chi Li <lschyi@chromium.org>, Jean Delvare <jdelvare@suse.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
 <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
 <523fe47a-73da-4eec-80b7-61408e0ba27b@roeck-us.net>
 <5cb816c0-c445-4a23-82de-e3d9cbce54ee@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5cb816c0-c445-4a23-82de-e3d9cbce54ee@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/25 01:52, Thomas Weißschuh wrote:
> On 2025-03-13 16:36:54-0700, Guenter Roeck wrote:
>> On 3/13/25 09:24, Thomas Weißschuh wrote:
>>> On 2025-03-13 12:47:43+0800, Sung-Chi Li wrote:
>>>> Implement the functionality of reading the target fan RPM setting from
>>>> ChromeOS embedded controller under framework.
>>>>
>>>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
>>>> ---
>>>>    drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
>>>> index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
>>>> --- a/drivers/hwmon/cros_ec_hwmon.c
>>>> +++ b/drivers/hwmon/cros_ec_hwmon.c
>>>> @@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
>>>>    	return 0;
>>>>    }
>>>> +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
>>>
>>> int32_t is a userspace type. In the kernel use i32, or even better u32.
>>>
>>
>> Seems to be pretty widely used to complain about.
> 
> There is even a checkpatch.pl test for it, which should have triggered:
> PREFER_KERNEL_TYPES.
> 
>> $ git grep int32_t drivers/ | wc
>>    43662  192381 3555402
> 
> 33k of those are in generated amdgpu headers.
> This search also happens to include the more frequently used uint32_t.
> 
>> Also, in comparison:
>>
>> $ git grep i32 drivers/ | wc
>>      820    4009   68486
> 
> The numbers for u32 look a bit different:
> 
> $ git grep u32 drivers/ | wc
>      234768 1137059 17410570
> 
> 
> Also this specific driver already consistently uses uNN.
> This does look wrong:
> 
> 	int32_t target_rpm;
>   	u16 speed;
>   	u8 temp;
> 
_That_ is a much better argument.

Thanks,
Guenter


