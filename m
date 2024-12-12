Return-Path: <linux-kernel+bounces-442470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5989EDD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2DA167F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9DF7DA9E;
	Thu, 12 Dec 2024 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lboBbF0D"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C5B640;
	Thu, 12 Dec 2024 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968296; cv=none; b=Oc96aa8cfNtHeN48CnTbaw5d9laRSCGo9zU/Z+CrnzxTPLp7p4Ge46fhf5FWv8N7xitF1aGN11YzoXjJa1+6jauZUNaG51nZzFsUgP5nIxAkdHc0bRcl89S7q5SUiZ0PHTecEyDN8oX4LjhJ8PNOHK45AjrxWK0D1fU8HEIRl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968296; c=relaxed/simple;
	bh=UNLifyfxzCxMmNwl/YMiB9jAqkysMUR9EL/zKKa0ZG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P35RtGv7lgnNfGGicDgkDDAbVWZ9vYeDXrWxxk1zZGQluC63SX7GRgEc36PMr5mjRUiW2BDJOLJbtqOFzC+gpAbiWQUGEsZybiHCMxCJxLw1MyVe7fo+eYoUTBfjlLV1EolKwyUQOlwFACzqsG6BEBpx9045LcIBIzrpBx2haag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lboBbF0D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21619108a6bso528985ad.3;
        Wed, 11 Dec 2024 17:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733968293; x=1734573093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+/baYc9+/5YHEQbru5HlOF83FUIUjixUDP3gGc+iCIw=;
        b=lboBbF0D++ULjdubNQygLE/yZCcbvow86XhnHx6yMpXiVOo+n4FwFAAxZkxGz4elya
         yBCTW7QMQH+MrZYN+KIT/K2dB9/DzizHst5+B9LVL3/GFG5gWeUfB3dGmkoMBqZPpms4
         WJjb/eR25p99o/Y1+dySGLJlFdyxu5bm2qi+gMpCkLhOupsUFZH6P8KQYL8pKm7X7TrS
         7p7fmaIItroXZyZUtA00JAF0CKvwbikXkbV0jcDSDKVUPZFDpjmzRQ5elKfiRhhZrFsv
         zTqBI4JHC7zfm/ttp0rQNBn7yiF79GUIzvSp1yadtViIxNwm331wpwsBPvlk42wYMr0L
         CjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733968293; x=1734573093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/baYc9+/5YHEQbru5HlOF83FUIUjixUDP3gGc+iCIw=;
        b=sqRIHnMuIiPNxLAURiRRTmVtdVpKhYk8Z/+4Hlv12PaeyfPgClEA6bHAe4kTYVqWfT
         euBAhHpMWU+a8BEphAmE/JIGMceawElAwQElC5L8PWUe8tV4qtigFWtqgmYwrORo5jSl
         6lF0+Puv76eHvwGXQcyCAVXlBDv72uMk+AhdrOTqa8g54TfZl5rosqJfxARumFVJvakz
         k3374R/UDK5iuxfLVEr7a/XxI/ClE0GUTkA/k0fKAmTIEHe9vh+mV+ER5iXl5JcdD0Yh
         C1viMhVGXg6JiDbUM9ne0nh6GcZwFZ+jm2dogDRldPrtPu4Knc3p2/8Nj3BHrhqiHREG
         xd1A==
X-Forwarded-Encrypted: i=1; AJvYcCWLqML6NEwCkjpX+6UGWL3n49ERV95YI+JxjfvN6BSib6z+lBrIPb5mpWn1v/4noS9KD9P+bXVXIdN6Wa26@vger.kernel.org, AJvYcCXYiPHKU9s8HbvHw3hvo0erVpq3AeT+4+nEOJJQEDUohmqCWBhzDsu3kBqx1mLyNd13shB37zKnstxIwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjN2awHa5V2pS5wPSiAO/Y3jvnHFVXZDUoA1/fFUoM+4/MFHi
	YJgcL9HkOhHZ/usXQig3lLGFueFoccED0bg0J5ncxatsaDSHOPILa/PXsg==
X-Gm-Gg: ASbGncuPRmg/jFX+AI8FE6OdEFfDOIcuOEQbsDa0IcOd7L87EXBudrrzv+liZ9lUCDS
	cS0K3qJ8qgZc5rZcsY8DjCZgYnXrue5ZnNV8VwnqJWws+ph+6p67K60wrqATTaStX0IooBfK2Ah
	MRr9B9MyXuKukyHgX6lVN5utpSTQjYHDmxc6hDIfEnRZv+6+w6jC+Tmyozd9Y0adkzmTiyelBVs
	B4MfANTfx9T/2ehmZ688j18turxR2Y/o6FXJwPoGeexmx7Fqtk1X7ZmzoRS3tCWf8eKFzq14zO/
	FQEXCH9ZbUKgc1eOyq1jiA2WpteMHg==
X-Google-Smtp-Source: AGHT+IGg+FkiSq56WSqAJG4YnracV/GEV59G3xoSRqeBNbWoLyWmBakZ8opuxKIl3wsYJtbnXvV6Bg==
X-Received: by 2002:a17:902:ecc8:b0:216:6fbc:3904 with SMTP id d9443c01a7336-217783b5c8dmr81863715ad.13.1733968291703;
        Wed, 11 Dec 2024 17:51:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163c258958sm67765455ad.137.2024.12.11.17.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 17:51:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1ce7718c-0bf8-4009-9240-fc6e2363ed54@roeck-us.net>
Date: Wed, 11 Dec 2024 17:51:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hwmon: (acpi_power_meter) Fix using uninitialized
 variables
To: "lihuisong (C)" <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-2-lihuisong@huawei.com>
 <aa6e1c02-b8bf-4d25-ad21-2018af72e16f@roeck-us.net>
 <b801388b-6bc7-5e96-dd29-e68ed8c970df@huawei.com>
 <f9fc4989-f416-4d88-bc3e-ab7b9fddb4d9@roeck-us.net>
 <c66d312a-098a-84d3-0895-02d78ae3ecc9@huawei.com>
 <77fce1aa-96eb-4c3c-ab0a-a33de46b333b@roeck-us.net>
 <87367d88-b10e-29d6-2712-f8f5c24e52a4@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87367d88-b10e-29d6-2712-f8f5c24e52a4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/24 19:43, lihuisong (C) wrote:
> Hi Guenter，
> 
> How about the modification as below? But driver doesn't know what the time is to set resource->power_alarm to false.
> 
It's a start, but incomplete because power_alarm must be reset.

See below.

> 在 2024/11/27 0:19, Guenter Roeck 写道:
>> On 11/25/24 23:03, lihuisong (C) wrote:
>>>
>>> 在 2024/11/26 12:04, Guenter Roeck 写道:
>>>> On 11/25/24 17:56, lihuisong (C) wrote:
>>>>> Hi Guente,
>>>>>
>>>>> Thanks for your timely review.
>>>>>
>>>>> 在 2024/11/26 0:03, Guenter Roeck 写道:
>>>>>> On 11/25/24 01:34, Huisong Li wrote:
>>>>>>> The 'power1_alarm' attribute uses the 'power' and 'cap' in the
>>>>>>> acpi_power_meter_resource structure. However, these two fields are just
>>>>>>> updated when user query 'power' and 'cap' attribute, or hardware enforced
>>>>>>> limit. If user directly query the 'power1_alarm' attribute without queryng
>>>>>>> above two attributes, driver will use the uninitialized variables to judge.
>>>>>>> In addition, the 'power1_alarm' attribute needs to update power and cap to
>>>>>>> show the real state.
>>>>>>>
>>>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>>>> ---
>>>>>>>   drivers/hwmon/acpi_power_meter.c | 10 ++++++++++
>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>>>>>> index 2f1c9d97ad21..4c3314e35d30 100644
>>>>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>>>>> @@ -396,6 +396,9 @@ static ssize_t show_val(struct device *dev,
>>>>>>>       struct acpi_device *acpi_dev = to_acpi_device(dev);
>>>>>>>       struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>>>>>>>       u64 val = 0;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    guard(mutex)(&resource->lock);
>>>>>>>         switch (attr->index) {
>>>>>>>       case 0:
>>>>>>> @@ -423,6 +426,13 @@ static ssize_t show_val(struct device *dev,
>>>>>>>               val = 0;
>>>>>>>           break;
>>>>>>>       case 6:
>>>>>>> +        ret = update_meter(resource);
>>>>>>> +        if (ret)
>>>>>>> +            return ret;
>>>>>>> +        ret = update_cap(resource);
>>>>>>> +        if (ret)
>>>>>>> +            return ret;
>>>>>>> +
>>>>>>>           if (resource->power > resource->cap)
>>>>>>>               val = 1;
>>>>>>>           else
>>>>>>
>>>>>>
>>>>>> While technically correct, the implementation of this attribute defeats its
>>>>>> purpose. It is supposed to reflect the current status as reported by the
>>>>>> hardware. A real fix would be to use the associated notification to set or
>>>>>> reset a status flag, and to report the current value of that flag as reported
>>>>>> by the hardware.
>>>>> I know what you mean.
>>>>> The Notify(power_meter, 0x83) is supposed to meet your proposal IIUC.
>>>>> It's good, but it depands on hardware support notification.
>>>>>>
>>>>>> If there is no notification support, the attribute should not even exist,
>>>>>> unless there is a means to retrieve its value from ACPI (the status itself,
>>>>>> not by comparing temperature values).
>>>>> Currently, the 'power1_alarm' attribute is created just when platform support the power meter meassurement(bit0 of the supported capabilities in _PMC).
>>>>> And it doesn't see if the platform support notifications.
>>>>>  From the current implementation of this driver, this sysfs can also reflect the status by comparing power and cap,
>>>>> which is good to the platform that support hardware limit from some out-of-band mechanism but doesn't support any notification.
>>>>>
>>>>
>>>> The point is that this can also be done from userspace. Hardware monitoring drivers
>>>> are supposed to provide hardware attributes, not software attributes derived from it.
>>>>
>>> So this 'power1_alarm' attribute can be exposed when platform supports hardware enforced limit and notifcations when the hardware limit is enforced, right?
>>> If so, we have to change the condition that driver creates this sysfs interface.
>>
>> This isn't about enforcing anything, it is about reporting an alarm
>> if the power consumed exceeds the maximum configured.
>>
> -->
> 
> index 2f1c9d97ad21..b436ebd863e6
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -84,6 +84,7 @@ struct acpi_power_meter_resource {
>          u64             power;
>          u64             cap;
>          u64             avg_interval;
> +       bool            power_alarm;
>          int                     sensors_valid;
>          unsigned long           sensors_last_updated;
>          struct sensor_device_attribute  sensors[NUM_SENSORS];
> @@ -396,6 +397,9 @@ static ssize_t show_val(struct device *dev,
>          struct acpi_device *acpi_dev = to_acpi_device(dev);
>          struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>          u64 val = 0;
> +       int ret;
> +
> +       guard(mutex)(&resource->lock);
> 
>          switch (attr->index) {
>          case 0:
> @@ -423,10 +427,21 @@ static ssize_t show_val(struct device *dev,
>                          val = 0;
>                  break;
>          case 6:
> -               if (resource->power > resource->cap)
> -                       val = 1;
> -               else
> -                       val = 0;
> +               /* report alarm status based on the notification if support. */
> +               if (resource->caps.flags & POWER_METER_CAN_NOTIFY) {
> +                       val = resource->power_alarm;
> +               } else {
> +                       ret = update_meter(resource);
> +                       if (ret)
> +                               return ret;
> +                       ret = update_cap(resource);
> +                       if (ret)
> +                               return ret;
> +                       if (resource->power > resource->cap)
> +                               val = 1;
> +                       else
> +                               val = 0;
> +               }

It would have to be something like

		ret = update_meter(resource);
		if (ret)
			return ret;

		val = resource->power_alarm || resource->power > resource->cap;
		/* clear alarm if no longer active */
		resource->power_alarm &= resource->power > resource->cap;

This ensures that alarms are cached if supported, and that cached values are
reported at once. It is far from perfect but the best I can think of since
there is no notification that the alarm is cleared.

Guenter
		
>                  break;
>          case 7:
>          case 8:
> @@ -853,6 +868,7 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>                  sysfs_notify(&device->dev.kobj, NULL, POWER_AVG_INTERVAL_NAME);
>                  break;
>          case METER_NOTIFY_CAPPING:
> +               resource->power_alarm = true;
>                  sysfs_notify(&device->dev.kobj, NULL, POWER_ALARM_NAME);
>                  dev_info(&device->dev, "Capping in progress.\n");
>                  break;
> 
>> .
> 


