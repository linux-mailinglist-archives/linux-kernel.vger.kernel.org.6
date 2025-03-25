Return-Path: <linux-kernel+bounces-576264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A3A70CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747FF7A62A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29118269D17;
	Tue, 25 Mar 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1fchmnu"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA61E1E05;
	Tue, 25 Mar 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942179; cv=none; b=AhFpxIkxKgjFQKJ8TXcR43tFWYwAvVPv/e2JJQhnRAZH7eRHJRnYW/fPiD05nPqv0zWFG1Z6HsdwtPIZsq16aTmyGATyxG0LzcmfOAjm7Z16kEPOOt24qVM2zmH+HbQeNxi5IxlBWxH3IJHQqGkEjz03vT9grPdtJ+Jj5wpFz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942179; c=relaxed/simple;
	bh=gf0QVH3ClfVnh9TAPZXKqyK/98W4k+fNIruViGOwN08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaSGXaJKfXdK8Wc72hIOWWdLJS8WM/R3rZKZQzgEkFQzRjmAY5DvlZtEA6J6COXbVyLWWoZuumeBfJRtjR7fUlJwGRTz+Atd59Lsyvv68U7L3f+Bdkz3SCO02WG6dKBdheUNvfFWl670g+qlfgOSoR71eRHOl+RWnBChCN/pRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1fchmnu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301e05b90caso9585458a91.2;
        Tue, 25 Mar 2025 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742942177; x=1743546977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JLVF8BBcCX9EFNyurFh/9xV8/0ZaAQTFAX4iYbHSE7Q=;
        b=Q1fchmnuyUQbJWnc++6fDZNZmZLPXS672gqueAo3noAhxpL+BveX/d8TLhehXhCgco
         lJMvreGXrpVE6L+rVxfGRmGkgdSa+AkcNBBnOlaB5hln6GudZQJe3yM7mzq3R/0O6rnA
         885OdHnlcXeeE1ajlkt2LYOQ3IcOUw5Ls1GUkGhU4qMNI0JiaIY5iE7C4CAixuOhAQBV
         RK56OWC8NQmHI4VxkMmtaL5Z41lMZY1MTAs+zByHHhq1X9W+c9oaxcMXR0NvqRtbYSd1
         sKf9AUIz5shQ5zOLjUWHyRdxDT7WXr2YNmT47hO37imqFLY5lOXzZdg7kuL3LNxTfvA3
         AzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942177; x=1743546977;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLVF8BBcCX9EFNyurFh/9xV8/0ZaAQTFAX4iYbHSE7Q=;
        b=MdQ7BwzaVKV35qaBoVDoA7fJt207BOhXFp741QZa2bLPCHi/9+lDg9U44za4bmg6iS
         HzPlb1+Vmd42n0MiKqFKIILhHLUp9hI32MlXOBYp5ZlmMnVGszOhOs4O+vJKubZDjUZY
         Szx1zUjgkjnFy7/pKH1IzFrTlI35MSGB0J2T7qIU+CFUGl4J4dl4YHiE5rz1a+XmEgt4
         Q6FNTfaQFCQ0iGFtAF4f3Uk/ILOZCJJdoj7exYKrdMCXZ2qVKC3oUTnjXKABimwLAqif
         cv1lZOZ7GkxITNhWT2j/SlrEr1hOqPC9qenGenXLHiP02d+++mtfbeiVH8XQzZgNieFl
         4q8A==
X-Forwarded-Encrypted: i=1; AJvYcCVPzswMG1EPGLLrinTQDjvKOhx4RPGJPmqC/e7tW237QMEI+cWbog72bqlq2udJXbXy++yCJRaSGg4GTkCk@vger.kernel.org, AJvYcCVRpu8TEufXmDC9ytatnAjkYzH0gx9BvJBFpweWquN3qwxg3iYaFTmlRwdE6BMWvV/cnc0xHZC5WIMQ9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw024+OMzZiGfQWWFvDyWjMFOJCdUTxnW/vVJjm1AwblIiVm+l7
	uDf1a1GBKzP6wDQT1PhuncBj0HnK5nyq+tFymebfxygnsIHZRRMegRH5tw==
X-Gm-Gg: ASbGnctI3GwdS9uJ8okdApbdnonW2fln23P8K7LS2k4u9EhmQ2h5Cfi35u5iXC1s4Sg
	t4U8DhqY6l6gD99eg9T3uHJruJ1uOhL26YwQTQkptc2TDCZ4ufyBYyCPXabZEjUkSunKh9Iyr2W
	DO82uJQGnSB4OpmZFTGo3mxCt1BA1vztQoTfnpie+pXgEHdOBFIoJ0tPDZi+qRTmrAXoeua/DUA
	mq2R/qAid8VgTg4Xnj7KDFa43bFlx8fRiIFhBg/CWySmGoIPR2sY02Y/vJPXeZVW1J2Hdvz4atq
	iX0v8YbuKZZzcAoE6RtlqVpbix8jw66lv2VsTtwoqs99/kN7mE6h5LldZSsNBGdFqWMhPhMZ/TQ
	+ShTzY3iTjFl3dhNQRA==
X-Google-Smtp-Source: AGHT+IECppBUFTKZnbtSW5oPIU1oodXvMxlmlCTZ6HDx4Xw6gCkWYaBd8LLsNdAIigl3L90Mm9EVcg==
X-Received: by 2002:a17:90b:1d46:b0:2fa:1851:a023 with SMTP id 98e67ed59e1d1-3030ff11268mr30422717a91.35.1742942176619;
        Tue, 25 Mar 2025 15:36:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a48fsm14933743a91.33.2025.03.25.15.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:36:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e6301e40-b925-4dcf-9306-d8b4ae6b70ce@roeck-us.net>
Date: Tue, 25 Mar 2025 15:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add support for CCD temperatures in AMD 1Ah CPUs model
 0x40..0x4f
To: David Hows <david@hows.id.au>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <78352732-6494-4c29-a79b-879a8898bac5@roeck-us.net>
 <AB8136A4-472C-47E4-A783-3C1CBD67D869@hows.id.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <AB8136A4-472C-47E4-A783-3C1CBD67D869@hows.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/25 12:04, David Hows wrote:
> Thank you.
> 
> Should i make changes and re-submit?
> 

Yes, please.

Thanks,
Guenter

>> On 25 Mar 2025, at 11:46 pm, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> ﻿Hi,
>>
>>> On 3/25/25 04:14, David Hows wrote:
>>> ---
>>
>> The subject should start with "hwmon: (k10temp)". Also, it should really say
>> something like "Add support for Zen5 Ryzen Desktop" or similar to better
>> describe what it actually does.
>>
>> Every patch needs a description. Please see
>> Documentation/process/submitting-patches.rst for guidance.
>>
>> Thanks,
>> Guenter
>>
>>>   drivers/hwmon/k10temp.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>>> index d0b4cc9a5011..cc2ad7a324f9 100644
>>> --- a/drivers/hwmon/k10temp.c
>>> +++ b/drivers/hwmon/k10temp.c
>>> @@ -502,6 +502,13 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>               k10temp_get_ccd_support(data, 12);
>>>               break;
>>>           }
>>> +    } else if (boot_cpu_data.x86 == 0x1a) {
>>> +        switch (boot_cpu_data.x86_model) {
>>> +        case 0x40 ... 0x4f:    /* Zen5 Ryzen Desktop*/
>>> +            data->ccd_offset = 0x308;
>>> +            k10temp_get_ccd_support(data, 8);
>>> +            break;
>>> +        }
>>>       }
>>>         for (i = 0; i < ARRAY_SIZE(tctl_offset_table); i++) {


