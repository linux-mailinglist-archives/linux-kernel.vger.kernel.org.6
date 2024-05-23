Return-Path: <linux-kernel+bounces-186986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F948CCB86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0996F280E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530AA13A41C;
	Thu, 23 May 2024 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO0+pQy8"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BA33FE;
	Thu, 23 May 2024 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440002; cv=none; b=beS4HWLYmTHrBO/GEF/Amj1GpgmsDSn7NTvwqsPlvktJcN71vYwaKlnp8+HxpyDgkoDjj1J17c6IVedJ8g7Iavb90UxEBtB0CFSy+5ZUGPiAFKirLaH7mR/NkzJkySVGv/8z8gwHtb/aFox9tMTSqoEeEz2oJh2Btp3KLf89NhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440002; c=relaxed/simple;
	bh=1d+eOxxTLTC6cEGMQ0IcUiIluoFQRKoPJoQ6060QEQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WcrYMLdSQx3M8lXVoK+KRt3ldRnhahwPmtiGOeOr0Z0mKmS//AEDQQFxGgAI9h/chHckFOvK3UQZqSY4nrd8B7xXAzUWkTIiU3DmoH22GMdjA//glGRRm4Umd9w89alBKzdPtLETbOCkMy7SliaJbRHMd+JTjxsSpKgaN22P288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO0+pQy8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bd816ecaf5so1678816a91.2;
        Wed, 22 May 2024 21:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716440000; x=1717044800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OvUrI2aaLqa4vMMuqwLUI/YBgeybzl+iDFgIbYUPxuE=;
        b=EO0+pQy8rLXbFwnx9UgknyMvS8t0l4g74DtArq34QkkNVM49n4q948Z8ZLNqTNABdY
         H2WlShXVpjLtTPQ+eaQVMG3NyfAihWbQw/6fvMkj8gGClfTa5w2XkIW7kL8ElqcmbQTA
         18a18kUGee/pBEg0Ch/OCLrpKa0+YIyIeoy883nTc/dMcRNfUXDKKXkfFYbf0BGthJ1G
         XYbThCb5ztQmPvbK0KnyQcahpjw8ZaTlu12JcyxMWJZ5vn7nQdwL7PVxlRUEeAfjMF6i
         +rr1iys0d3yBqmPtLE/eNBvhQAr7yZvmyZafgCDlUQfKKhEA+CRI6pnbWcBEx/4xiAG3
         pV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440000; x=1717044800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvUrI2aaLqa4vMMuqwLUI/YBgeybzl+iDFgIbYUPxuE=;
        b=YzQMXGrgMBjqKCrChit3lSpMzp15TFLPo63QJuBUqbv7KistfMzVM33mAq/2PIHE2q
         tUW/E2WJYh9BB2mOmD6nm+kTfXixJpMMYngyyYf8JVRVKhuF1b1YMDTuJQ4r3dswEyyN
         ooDC5pvxWIoQ+QtR0wbqafuMsPEKAMDgaGVpH5o8OJO3lrOmWis598+FT3JBqOarI/yC
         rcmRA9l7H/OF+LVFok/lrgrjxC2Uv4bR75ymc87t354Yijhd5m3y1O7/XfdA1JOQqVK+
         O8UR685jrREvj4+HlDPfKuJOuC8gPGjuTZxoWYG4mSwPqaaS4cRH6RMWGa1gHeJfuaBU
         5pfw==
X-Forwarded-Encrypted: i=1; AJvYcCUnJFZrOJ8ovbdakx/gbNi1s7iZOq4iuTIWDqyX8KGZrFm+0WCMoT4qHg8WooOc+WLwJhycDzHwuBkmh30INlNMSQ4z4+R/NyoXseqiU25inpE1RCGRYW9Eu5fr0ghbYhFZn7bj9+SaHyjQY9dXhIwppSmQhjIn3cwvG1wADEwnHVOQGfY=
X-Gm-Message-State: AOJu0YweR4y2T1FAu9PKW+BWD/tIpkOvgUHiwsHqP3Su5DUj8vbT7HGz
	f7IuKdS/CB9VQNiQRX5MppARyoiKUPBuo2ScgghObMat/CdYCejR
X-Google-Smtp-Source: AGHT+IGklDZzKNjNMJEcgH7FTYYErWCrr80DTjtZ65w2wbKWTZox3n6geeSo+mL6fhvQlkMCR7vHmw==
X-Received: by 2002:a17:90a:ae03:b0:2b6:ab87:5e5b with SMTP id 98e67ed59e1d1-2bd9f45f37bmr3996717a91.9.1716440000028;
        Wed, 22 May 2024 21:53:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdef6bcc14sm140184a91.13.2024.05.22.21.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 21:53:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1589de8b-3b81-422b-9b6f-e1b260b0a594@roeck-us.net>
Date: Wed, 22 May 2024 21:53:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: hwmon: max31827: Add debugfs support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522123923.22320-1-radu.sabau@analog.com>
 <20240522123923.22320-3-radu.sabau@analog.com>
 <1c1519649f9c99ad73854b70efe286d68d200029.camel@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1c1519649f9c99ad73854b70efe286d68d200029.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/24 06:10, Nuno Sá wrote:
> On Wed, 2024-05-22 at 15:39 +0300, Radu Sabau wrote:
>> Add debugfs support by creating directory in sys-fs which includes
>> debugfs specific files used for configuring the device by
>> preference.
>>
>> Signed-off-b: Radu Sabau <radu.sabau@analog.com>
>> ---
>>   Documentation/hwmon/max31827.rst |  25 ++++
>>   drivers/hwmon/max31827.c         | 202 ++++++++++++++++++++++++++++++-
>>   2 files changed, 225 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
>> index 9c11a9518c67..940310be6075 100644
>> --- a/Documentation/hwmon/max31827.rst
>> +++ b/Documentation/hwmon/max31827.rst
>> @@ -142,3 +142,28 @@ usage (+33% for both write and reads) in normal conditions.
>>   Since this operation implies there will be an extra delay to each
>>   transaction, PEC can be disabled or enabled through sysfs.
>>   Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
>> +
>> +DebugFs entries
>> +---------------
>> +
>> +The chip also has a configuration register where each bit stands for a specific
>> +functionality to be configured. Hence as one would like to have access to these
>> +features, we give access to them in debugfs.
>> +
>> +.. warning:: The debugfs interface is subject to change without notice
>> +             and is only available when the kernel is compiled with
>> +             ``CONFIG_DEBUG_FS`` defined.
>> +
>> +``/sys/kernel/debug/max31827/``
>> +contains the following attributes:
>> +
>> +==============  ===============================================================
>> +alarm_polarity  Write 1 for ALARM pin active state is low, 0 otherwise
>> +comp_int        Set to 1 if OT and UT status bits are in interrupt mode
>> +fault_queue     Number of consecutive temperature faults until OT and UT faults
>> +                are indicated in status bits
>> +pec_error       Set to 1 if PEC Enable bit is set, 0 otherwise
>> +resolution      2-bit value that select the conversion resolution, please see
>> +                datasheet for corresponding values
>> +timeout         Write 1 do disable bus timeout, 0 otherwise
> 
>>From the description, the above really don't look like they belong into a debug
> interface...
> 

Correct. The chip should be configured using firmware properties, which for the
most part is already supported. An acceptable exception is PEC, but that
configuration flag, if implemented as attribute, should be attached to the
i2c client interface to match other drivers.

Guenter


