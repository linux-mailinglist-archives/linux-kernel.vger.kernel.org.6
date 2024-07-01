Return-Path: <linux-kernel+bounces-236459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB491E29E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB928DC91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C316B3AB;
	Mon,  1 Jul 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCBSiOoY"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB716A950;
	Mon,  1 Jul 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844662; cv=none; b=CwApHBIalVinSrZI3VxHomt/QJoznm/jqsbF9r4ovykqGDUzRK3jAmT5bjIQlSthwIvfmplDrPaM8lSRC03cHsXZIhvWf3QGBIjpRWBBGIL6z5l0WhZWXBXstXkhck2xGtmm4FlEQX6kj/SVttS0d03ENmuaWdbq+SYgHzHAD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844662; c=relaxed/simple;
	bh=wFygjrw+03MVkih0LnEQYVyGmtKD2135VhE5JF8Lgis=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U1VkKjt95SOg554H1LI/BHB7EIFgDKsnMyyFo+VhIKchxi0p2JBoj7IcdouvLzORuz+U9dILXRScwPnX36tTq4PjZxBr2/hF8GvIXDLfiF0/wHdpD7Gx49UkwstTObQIFlDFVS6Tkq2W8uJgfw6Stu339UgBjB6zFMef8CU2z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCBSiOoY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-726d9b3bcf8so2040882a12.0;
        Mon, 01 Jul 2024 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719844660; x=1720449460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4W7aGgE3bwlAgmVAT8Os13+TJFUopHhRByibpmBWhzI=;
        b=RCBSiOoYRmfh5e1m9O9UKfJQP1V7nA663cxFlWhKlpEQVerA+MrMZf8as9cwGnawJD
         +3H1rhwfDnM/7sMRS7Mq28ZT6QRO2f2ri8X2A42U9Qk3cJV7J67ZpSQh4431sAgNok4u
         lTwOsKebqNsNG1k4YwTV3Hm931kAsPHc/jQxOD6snpBaBcsl1x0JYqZglc35llHH8Ie7
         7It6TZRwuTJ2CNnxEj48BTtZ6VsQZKxoiwnfaaY8U2eUtSMv6nKSMk1ph0gWpAE2rvOF
         G0GVR+mWdlWb7ktTTp4ZiSSAyNaS1tVrOFZh2nD2eNDYeo8uxu1g1cmCJDFQYvS9VLzn
         ayxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719844660; x=1720449460;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W7aGgE3bwlAgmVAT8Os13+TJFUopHhRByibpmBWhzI=;
        b=P2Iy3suuwpPqzjzxkczjj7RBkY9jiQn5tufcU0TkpKD1REIUMDK/5RzltbOw6+pOEG
         S4OWLN6W4w+3P6VKJke4vSvsja4KiQWOCu4RvVqncyVobw0oj78MC45sIQY3z/HUtGRc
         LFQOpjouiSGlmZuSQIS3kOJ3okXMGz72NcYeC7amTQay1tLA7N+lq1WHDUDj3KYQDZ8q
         1ASzwiwSB7luNH11navDgFSUeWkwoY3iSOpReFd2EBNSvp/wx/15hrk3dBJAiHK3YPGr
         xzeilgAPAbAjsAesHnhAq3JvEFLFSk+m1mEvNyIWUoXoWK+u2l+8xFt2z2EqAD4VqsGC
         gWYw==
X-Forwarded-Encrypted: i=1; AJvYcCXw+gqGa4e+oP1QQ4hmPM1j8wc0bm4olh6KcJ4dQkBkY+rdbNFjwOpmpEgu83ucCz4+qW4u0Y4NGSvA9/CQL3ZAMt2ijgWXf/ZarNY=
X-Gm-Message-State: AOJu0YxlV+b69t4MGFBT3/CRQpHHAprQnxioNChTOv4nc83SBqCF3sZS
	Xe1gEj/m8GvklcjEpQ69evzMjd0xv2ajgmL1StKeYcy8z7PDxC0HJqQ9qA==
X-Google-Smtp-Source: AGHT+IEQF02p3y8OFOzzKeUh5j9ACccBn3wvbJLst9pFynEQYARoGnUEwN5iGjbw1AVel3fjJpYtzw==
X-Received: by 2002:a17:90a:128d:b0:2c3:236e:473c with SMTP id 98e67ed59e1d1-2c93d710aacmr3236445a91.21.1719844659948;
        Mon, 01 Jul 2024 07:37:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5469dsm6863021a91.23.2024.07.01.07.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:37:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <80a7f733-655e-4b00-a802-825d3acaafcb@roeck-us.net>
Date: Mon, 1 Jul 2024 07:37:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hwmon: (amc6821) Make reading and writing fan speed
 limits consistent
From: Guenter Roeck <linux@roeck-us.net>
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-3-linux@roeck-us.net>
 <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
 <9fce6789-edc8-4c44-89c0-ae4ca3ec3315@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9fce6789-edc8-4c44-89c0-ae4ca3ec3315@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 07:11, Guenter Roeck wrote:
> On 7/1/24 04:05, Quentin Schulz wrote:
>> Hi Guenter,
>>
>> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>>> The default value of the maximum fan speed limit register is 0,
>>> essentially translating to an unlimited fan speed. When reading
>>> the limit, a value of 0 is reported in this case. However, writing
>>> a value of 0 results in writing a value of 0xffff into the register,
>>> which is inconsistent.
>>>  > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   drivers/hwmon/amc6821.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>> index 3c614a0bd192..e37257ae1a6b 100644
>>> --- a/drivers/hwmon/amc6821.c
>>> +++ b/drivers/hwmon/amc6821.c
>>> @@ -601,7 +601,7 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>>>       struct amc6821_data *data = amc6821_update_device(dev);
>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>>       if (0 == data->fan[ix])
>>> -        return sprintf(buf, "0");
>>> +        return sprintf(buf, "6000000");
>>>       return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>>>   }
>>> @@ -625,10 +625,10 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>>>       int ret = kstrtol(buf, 10, &val);
>>>       if (ret)
>>>           return ret;
>>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>>> +    val = val < 1 ? 0xFFFF : 6000000 / val;
>>>       mutex_lock(&data->update_lock);
>>> -    data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
>>> +    data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
>>
>> This is an unrelated change I believe and I would therefore have this in its own commit with proper documentation in the commit log. Indeed:
>>
>> 1- Change in fan_show handles the default 0x0 register value (which can only currently be achieved via the default value of the registers)
>> 2- Allow (re-)setting unlimited fan speed by allowing the user to pass 6000001+ instead of clamping it to 6000000 RPM.
>>
> 
> Both changes are related.
> 
> The whole point of this commit is to report and permit consistent values when
> the register value is 0. But you do have a point - reading it after my changes
> returns 6000000, but writing the same value sets the register to 1. So I think
> the proper change would be to display 6000001 as speed if the register value is
> 0, and provide a more detailed explanation. Would that address your concerns ?
> 

Ah, never  mind, I'll do it differently:

- If the register value is 0, keep reporting 0.
- If the value written is 0, write 0, otherwise limit the range to 1..6000000
   and write clamp_val(6000000 / val, 1, 0xffff)

This minimizes user visibility of the changes, and also ensures that
the reported fan speed is 0 if the register value is 0 when reading the fan
speed.

Guenter


