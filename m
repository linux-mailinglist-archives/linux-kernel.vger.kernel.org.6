Return-Path: <linux-kernel+bounces-278527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41594B17B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D71B21222
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797B145B39;
	Wed,  7 Aug 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7E7yvIs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E722A1D1;
	Wed,  7 Aug 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063051; cv=none; b=tRI2QLwdG44211vxsH2eeUiAf4pjH0iotm8i3vRHnVAAw9KOrEkplBTL+6j2RmNbVglZV8ktzrSG+z3nEC7aV29D6mjh6SxKnmOowZAHl6PwuM1oQZ8XuYJBHXW77vo3BYS61PTcvvJxrA9uA122Yv60QiEFJT6bo9B8zctLcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063051; c=relaxed/simple;
	bh=aNhzcM3qZlOzw/JxDeHUcVfAK2why/8/BhEkN4dhV94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MT24E3/bpdK3e58oomYPn1mbCR7tIjJpZcwgt0VGY77t3oN4l/cqkqgAjxMI6sYaX1loDI+NGr9AAh0GjnOgVQALHLpFLpkPZl5EHSezRWP4hUfk9gCYGrB2MPdxNdy2dMo7CFg+NVtQpPLhk7KH8EsIyqpbj6gA91ZsMblHOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7E7yvIs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc587361b6so3338155ad.2;
        Wed, 07 Aug 2024 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723063049; x=1723667849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bPGZnObTKqFY4g52t/pXggfeZcskYzfqDzOTNaR5jHE=;
        b=a7E7yvIsWtZXbOlfmFF5+V/XzQdvPHj3T7uUWfPucBzo6lz3YfGzE2w31Mo4EaBD0n
         /UcKH9GGXh/X4U1M1aAztl/iTNs+wUrzWkT9A6bxjI+alPSjIF8E/yI5zrGKkIFr20xe
         El5/b1AwFftP2A3nJvGA1KPUioaGtCUsc4tnWNC37VvBPNb8Iv5Zu8NgD3BHoXxMFmIh
         jKlRfr0cGLeMkqtzh4prNozOSFHS586VUV9qwd6oHfqAKTGnrhmZqT4lDTo3b22ly6MN
         HKQVt3wBDQ15nTZvElIJf4kfO8EyJHjcJZBunAby5uWn6I43VHm2g0s9+iTggRx6jAO0
         VA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063049; x=1723667849;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPGZnObTKqFY4g52t/pXggfeZcskYzfqDzOTNaR5jHE=;
        b=KVpwl49J6NguXA+aBJ/E/TBEcQP4fP2FlkLVi+C7Njpfe/imiGk4B9Se3EDKyI03qh
         mY+ayuKVoZBg7wYZWl3+D1RutGR9ZJ5LcZmxtg6hocNrOrO2PYl09GTiiMk/uNAASt1s
         jTvpu8+VOOW7NnpYQ5BxwCkzB/Gg34jl/9pIr8AXEaGUixtimmNJPFh2yY6wrhukMR1m
         Er4fQLT77v8Wq/didfMG5UD8z2/sRfdvR/2Qhu6S8SdQicviNtTt14+3dc8I9tUSZ3pe
         tvW2kaxt6+jLxlIpBWwXNBqs2EVSKEdspk8V1r7EwPL3SosufhK22M4X9xYgsu+QbZvI
         CkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYL2rW43Y0kjXkZjm84pRvM6z0is8/oMvtpO+iGQ6yqMj0lbte40tohyCy+bJqLQ6w6TOnJE+ldwRFjIAh7WnVxnS4ebSXvmjCaL/jMTFemOqal9oXaALiiU7LmC6doiFflvgm+AAq4os=
X-Gm-Message-State: AOJu0YwOxF9X02PcqTTzFVF5HXzAv35FPtF0vsDDnytosl9kGETbN3Aj
	+8uheH+Sa0Wgqvamui6NuS6F9/3m9FsDCNNwKL4oqy5nSc7j2nesxYzKRw==
X-Google-Smtp-Source: AGHT+IHB+lsh0dkUJkehqVokWruFXbpxii4EAJzveBsadG+YCKV/+Wx14Yoapx/XB5TXzH/zc85zrw==
X-Received: by 2002:a17:903:1251:b0:1fd:d7a7:f581 with SMTP id d9443c01a7336-1ff57258148mr224717305ad.7.1723063049190;
        Wed, 07 Aug 2024 13:37:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592aac09sm110106045ad.273.2024.08.07.13.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:37:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <851fe373-471e-4892-addb-343d84334daa@roeck-us.net>
Date: Wed, 7 Aug 2024 13:37:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
 <5d11350f-71b0-44fc-8631-01e1740581d6@gmail.com>
 <5208afb1-92dc-43d3-b6ed-36a2fdd40ec7@roeck-us.net>
 <b66f1fed-20a2-4de3-85c5-bf6fb90c2649@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b66f1fed-20a2-4de3-85c5-bf6fb90c2649@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 13:11, Maximilian Luz wrote:
> On 8/7/24 9:50 PM, Guenter Roeck wrote:
>> On 8/7/24 12:25, Maximilian Luz wrote:
>>> On 8/7/24 2:32 AM, Guenter Roeck wrote:
>>>> On 8/4/24 16:08, Maximilian Luz wrote:
>>>
>>> [...]
>>>
>>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>>> index b60fe2e58ad6..70c6385f0ed6 100644
>>>>> --- a/drivers/hwmon/Kconfig
>>>>> +++ b/drivers/hwmon/Kconfig
>>>>> @@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
>>>>>         Select M or Y here, if you want to be able to read the fan's speed.
>>>>> +config SENSORS_SURFACE_TEMP
>>>>> +    tristate "Microsoft Surface Thermal Sensor Driver"
>>>>> +    depends on SURFACE_AGGREGATOR
>>>>
>>>> As the kernel test robot points out, this dependency is wrong.
>>>> __ssam_device_driver_register() is only available
>>>> if SURFACE_AGGREGATOR_BUS is enabled.
>>>
>>> Right, I should have spotted this before submission, sorry. This should
>>> be
>>>
>>>    depends on SURFACE_AGGREGATOR
>>>    depends on SURFACE_AGGREGATOR_BUS
>>>
>>
>> SURFACE_AGGREGATOR_BUS already depends on SURFACE_AGGREGATOR, so the extra
>> dependency is not needed.
> 
> Unfortunately, SURFACE_AGGREGATOR_BUS is a bool and SURFACE_AGGREGATOR
> tri-state, and the inference of whether SURFACE_AGGREGATOR needs to be
> built in or not breaks because of that. Meaning we could have something
> like
> 
>      SENSORS_SURFACE_TEMP=y      (tri-state, module)
>      SURFACE_AGGREGATOR_BUS=y    (bool, optional-code-flag)
>      SURFACE_AGGREGATOR=m        (tri-state, module)
> 
> because SURFACE_AGGREGATOR_BUS is fine with either m or y. But in
> reality, SENSORS_SURFACE_TEMP=y would require SURFACE_AGGREGATOR=y.
> 

Ah yes, I can see that the double dependency is there everywhere. Normally I'd
have assumed that to be handled with SURFACE_AGGREGATOR_BUS as non-configurable
option and its users selecting it, i.e.,

	depends on SURFACE_AGGREGATOR
	select SURFACE_AGGREGATOR_BUS

but, sure, it is your call to make SURFACE_AGGREGATOR_BUS a configurable
(instead of selectable) option. I don't understand the benefit of being able
to enable SURFACE_AGGREGATOR_BUS without any users, but then maybe I just
don't have sufficient understanding of the context.

Thanks,
Guenter



