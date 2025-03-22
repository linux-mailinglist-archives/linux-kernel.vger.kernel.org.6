Return-Path: <linux-kernel+bounces-572539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0116A6CB40
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543893A9B65
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E322A7E5;
	Sat, 22 Mar 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiPIjyA1"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438222E3E3;
	Sat, 22 Mar 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658310; cv=none; b=IZmSgg8WpGsTe3UGmKXMpVisYsRl9+4G6N0+0Usm8idbA9FLBGt8DbhZ+nmDvaBeY3zlKm+QQcRmi0j30f63II5z7Acm1anFPF+5SikVMCiwsuAA/c8p1qdlhdqdZyiCKqrLnzZRxgjVhuCns99636OOzoSX3xrGq4+qOtNLs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658310; c=relaxed/simple;
	bh=nDLUXGRFqNd6EEGaZY+n5+/p61vEqp+ThCYf8rFxwf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6HnoI8Z94RKBaIk6nB7E3l35fE5xOB2hJkwon38flpCKL0yGdF3In8Jy/Z1voVo9+cQ6o+jhwfXOXS8jKJuFaBTFHhy8nhyTOhl178OxwD1YUIwJ27KtrjyqrmQyUBuQZhkqd32QZwI5EThhlVXTmax9IjvahJno/4AROj2GAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiPIjyA1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2241053582dso29531305ad.1;
        Sat, 22 Mar 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742658308; x=1743263108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mFYU7Iau0Pw4o1yOJlZKvazdG8btcvSQkYIOXm39/RA=;
        b=ZiPIjyA1/yOmSBLS/t+siZSBgrFg3LTu8v8QDPwxNrnyTXLuZV0vX3VXpRSIDWuIP1
         QXilaV0+rdxSUXnZQRQZZbm9Rinh1wwYPQmJBQNobS943wrQSatLwMcXZ5AFlMMXrDq/
         CHMNUqG8QdXjlQBvl+a1V8LXya29MC0bdZwiQmUGmQOJRENYpT/YfZxeYj8B3FoU0Lc1
         wjzfvVwtQCFw6ows46Fr+hZMH2pNE67z4wYxkYfLGTzWQJyRsO4y56XmoY5KLVJraAoZ
         J11OKGCSkDq/1znTcXSQ9vO9D0fGWHm/ajWini/POYktXVISOQ+FjGB0pBWv0BVwTIKb
         zYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742658308; x=1743263108;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFYU7Iau0Pw4o1yOJlZKvazdG8btcvSQkYIOXm39/RA=;
        b=s4y7jvtUnzVtvgiydsdpXF1bguXnYXUDx1tQhHJQLrICKiWsji+784fG5A0Xtj3zEd
         ogqLCzRhhVdRvBBHh30EoVsSmF0n5yf+U/M5HKMu2jzQVzuJ3QU73fmHKiO62n7BKaXP
         r1XycGBX5BotFyH5xmpAMJx21ATp+ExgEsB2un8ANjlJ1jkKrccK9c73qOxyLqisCkYX
         cNNt1se6gm+/G/S1LSBlCosEOOtcDmiRdiDuVyvO9t5tTF51j2h2+WGVWZ5wmgJftRO3
         LAKtmCUDTlECPA3MXfNxsmOeFd2IMKkJFTad+cGBzPYbuyBRLBRLeAt3Bx3M9oRK0XUR
         yWmA==
X-Forwarded-Encrypted: i=1; AJvYcCUJtulxWBkmU5hAkcBUxO6eA5eRdLYMooZLuSX3TS3iaaBzoEWeUAPCqxjGmUruULXNC3gOz9T9aYcPtRIF@vger.kernel.org, AJvYcCWqnVM1QnTxTmrb9zmsaZyr9SW48u7oRt9/3qXZdiYRqPWfrC+ADzUlV18KV0jY303kV6SH0x2b9eDODA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTmuocAcgCGTWEMiTRh+frJhUisMqI7II/SGNwJF5R1Be5CmG
	XJyfdIDfoHDk/PWhfKGIVF/+KOy8JL9TbtTJ5Kg31gXlfARyS0X7vIzY7A==
X-Gm-Gg: ASbGnct26g6XK2X++NIRaoyB07yjKXYHS6ki0rzLuXNBYVpbZBarHLLqT0zkns8Ouw6
	G7DxWLbcUL0rjOL49A9UK568E7eLUeY3aoX3x0vrzqjuC17/OtRl9UthLd1C15DVK2z7bYPcUQN
	i+IY2P8/zujC8v5sb7K5Ac8MNPU5V1q8xOSq2ofTzV3VYOx+tVdf8quq92Kvx0AX0n1qCwg40jJ
	Om2e4gw1IB62E5zFuK4F6Xae0EqFbDTHo7UP+1kDdOfcZthFSKbwOlTqEup9/YnUfdWaz/WZk/9
	oD9E1SP+Ic0ZqJkRUkyjK1QxWqv5TOgeyVU2a2iIAOyxNPzQddD6Egh+ivBLFZZ3Q+VGy3Y0kPc
	sxnO1GMcaw9gE69EabA==
X-Google-Smtp-Source: AGHT+IEGd+EpJ3Wf8373iGZbDBFfSUQwBg7eI7Z3WqNGHtOim/pUz7ee9RUCygrhpkRtidtf8Oe+Eg==
X-Received: by 2002:a17:902:d2d0:b0:224:1001:677c with SMTP id d9443c01a7336-22780c526b7mr94227915ad.9.1742658307993;
        Sat, 22 Mar 2025 08:45:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d9ea9sm37005465ad.176.2025.03.22.08.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 08:45:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dae402fc-4b3e-4a5e-adb1-59f0697d9d61@roeck-us.net>
Date: Sat, 22 Mar 2025 08:45:06 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <780ce6e8-11fc-42be-b4a7-9cffbf811d78@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/22/25 08:23, Thomas Weißschuh wrote:
> On 2025-03-22 07:12:48-0700, Guenter Roeck wrote:
>> On 3/22/25 06:55, Thomas Weißschuh wrote:
>>> On 2025-03-18 15:45:23+0800, Sung-Chi Li wrote:
>>>> The ChromeOS embedded controller (EC) supports closed loop fan speed
>>>> control, so add the fan target attribute under hwmon framework, such
>>>> that kernel can expose reading and specifying the desired fan RPM for
>>>> fans connected to the EC.
>>>>
>>>> When probing the cros_ec hwmon module, we also check the supported
>>>> command version of setting target fan RPM. This commit implements the
>>>> version 0 of getting the target fan RPM, which can only read the target
>>>> RPM of the first fan. This commit also implements the version 1 of
>>>> setting the target fan RPM to each fan respectively.
>>>>
>>>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
>>>> ---
>>>> ChromeOS embedded controller (EC) supports closed-loop fan control. We
>>>> anticipate to have the fan related control from the kernel side, so this
>>>> series register the HWMON_F_TARGET attribute, and implement the read and
>>>> write function for setting/reading the target fan RPM from the EC side.
>>>
>>> Should it be possible to switch back to automatic control?
>>> I can't find anything in the hwmon ABI about it.
>>> And neither in the CrOS EC source.
>>>
>>> Am I missing something?
>>>
>>
>> Not sure I understand the context, but the fan control method is normally
>> selected with pwmX_enable, which is defined as
>>
>>                  Fan speed control method:
>>
>>                  - 0: no fan speed control (i.e. fan at full speed)
>>                  - 1: manual fan speed control enabled (using `pwmY`)
>>                  - 2+: automatic fan speed control enabled
> 
> So far I associated pwmY_enable = 1 with the pwmY attribute.
> Also controlling it through fanY_target does make sense though.
> It could be clearer from the docs IMHO.

That is chip specific, and needs to be documented in the chip documentation.

> 
> That also means that the patch under discussion needs to implement the
> pwmY_enable attribute.
> 
> One more thing I have wondered about before:
> Is pwmY always refering to the same thing as the matching fanY?
> 

That used to be the case when the ABI was defined, and it is for the most part
still the case. However, nowadays there are chips which permit dynamic assignment
of pwm channels to fan tachometer channels. Recent Aspeed SoCs are a perfect
example. On those, the pwm <->fan mapping is completely dynamic. How to handle
and express that in devicetree (which is where it is really needed) is still
being worked out, though I think we are slowly getting there.

Of course that means that the correlation isn't typically spelled out explicitly
since it _used_ to be implicit.

Guenter


