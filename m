Return-Path: <linux-kernel+bounces-334354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5197D623
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B792E1F24B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C431779B8;
	Fri, 20 Sep 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCKLZcmP"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97214A606;
	Fri, 20 Sep 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838842; cv=none; b=l4t6xXlJBUb0qkDPOs84/mzzdE42twE+5ZmGRziTWGHBVEjxz4SW4HKVkVa0Y1+1EX4jMzCgoRXgWQUp7DQMgqY9jGI+IYqJVJQAXk2qFjwiGXXfigXqIBtVt5K10dmk0XQr1C891ac97LZBUUhxAFEty6X1G55ROrSrPu5CXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838842; c=relaxed/simple;
	bh=rXsPa9xSAdUkk/XFmSkP8bfB9a5uuGwnFASqjAldOeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ0UnPP7Yghjp+Wvhi4cglejCkQ7T7+0RKjuPX4DKHdNafHZTaUcfllFzFQnDKrsa3Kv86zQlkmyCDIwtGeofGRlejrNTPfGV5DoGnS3w6zrKOqnMpNdkUccEkPCut1b9A0/+Tf0z/zUFtUZp6MOf/DSal/pzdECSEfc/Dj6g6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCKLZcmP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1482395a12.2;
        Fri, 20 Sep 2024 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726838839; x=1727443639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t+95CrYRlD3ILIKlPY7ppMRjqe3+c5HDDeYVxNXFlvQ=;
        b=VCKLZcmPmFKwvsMN4/KbBwNsJBpsz9ri5dANQmMeNXNm+nIp9TMsIuCMJDK+71yui6
         33DCMye0MOz3wpaqAbzT3tbBUbfE/VBDfr6X1qXQyZ7IWr5cWcQCbF4AyjNzUtgNtk92
         oLWSbT00PLC1fLB+EqgwEvr8na8/qX4uTwdMcntzsl5egZglmBkmcs7Gt+fdRitHJuf1
         k1mppyR79liZvK2YdOtmO8FFawZyvNWj9NTl7cV6aW4jLPnfXllRQ8WVCzczwEGV8KgC
         UadksCr8dTA1bYZCvKWY5kjaphp8UIDvE/yFrrDymdjCAYW4oKMVT0u2Oi2iUJ0+g/Uo
         X2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726838839; x=1727443639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+95CrYRlD3ILIKlPY7ppMRjqe3+c5HDDeYVxNXFlvQ=;
        b=Y5FOBLJVGX0Mwzvbx9UpHRfnZZq29BCAfvOkDH6MdTaGIgWsWv+Z1EbX5QSLmSKSj8
         ebHXFiczUY5tK2PSUuIuLdvhM+XLyekksdoQ8ADZz4r4DrM9BnZefZZCCAjXBqyu2kKS
         Uog2/GITWDSQf0tj5dRBw0y9E4cTufcUBpAxYjViTpbgIgXM5Fex8Frp7dWyMSxqpAbf
         JvN4VyF27pGjBc9btXyEfKbsNVxxZLcYRQg1WkW6xA9XfmS8YLXZz60QoDkIwP9tr0Go
         YYRZGbRvLtDSuCapZKoilXzH+8ctKnvNLvxxK4pX5twaqBJd9F1RkJAXQO06dS4SYKbJ
         KpuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAkMuMfJsTFv/w/CNHp+fhUV70RLJ5qJmP4jilfO2kw6XRd4j3gVqNmnq4GvQWR9eL9hkcHS0ZdsYqCuPv@vger.kernel.org, AJvYcCUNcNwc6uFDP/WBXEt8V+EGA9o2O3NAHURT4O+40sImeFZhpx7P6pEBns8iU/bfnImfsIwmNpQcbzaqWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mOkzTVrqJ8STbY7Xh6xXunZ64phfM0jmvnb8XRyyNMZjjFr3
	hFGrnXxXkytR7TYJqwjLA3AFS59ZcWFNU/Y0+IIgQeHFU4hMZeHDJUs6AQ==
X-Google-Smtp-Source: AGHT+IFgZjlxeWDh2cFvYTJamGNPYjhnHFeXlrEkhuxYMg7ConqcfSDCdgxDMMjugBSUHH/ceMeyqw==
X-Received: by 2002:a05:6a20:9d92:b0:1d0:3a28:d2a7 with SMTP id adf61e73a8af0-1d30cb6b158mr4399585637.41.1726838839457;
        Fri, 20 Sep 2024 06:27:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97302sm10179124b3a.147.2024.09.20.06.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 06:27:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <85982eb2-388f-488a-8322-9ba44079eba4@roeck-us.net>
Date: Fri, 20 Sep 2024 06:27:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: abituguru: Remove unused
 ABITUGURU_TEMP_NAMES_LENGTH macro
To: Hans de Goede <hdegoede@redhat.com>, Ba Jing <bajing@cmss.chinamobile.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903025037.9711-1-bajing@cmss.chinamobile.com>
 <e893f91f-6f78-46ac-b28d-1e45fab892e2@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e893f91f-6f78-46ac-b28d-1e45fab892e2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 05:10, Hans de Goede wrote:
> Hi,
> 
> On 3-Sep-24 4:50 AM, Ba Jing wrote:
>> The macro ABITUGURU_TEMP_NAMES_LENGTH is never referenced in the code. Remove it.
>>
>> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
>> ---
>>   drivers/hwmon/abituguru.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
>> index 93653ea05430..58072af4676b 100644
>> --- a/drivers/hwmon/abituguru.c
>> +++ b/drivers/hwmon/abituguru.c
>> @@ -95,11 +95,6 @@
>>    * in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0
>>    */
>>   #define ABITUGURU_IN_NAMES_LENGTH	(11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14)
>> -/*
>> - * sum of strlen of: temp??_input\0, temp??_max\0, temp??_crit\0,
>> - * temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0
>> - */
>> -#define ABITUGURU_TEMP_NAMES_LENGTH	(13 + 11 + 12 + 13 + 20 + 12 + 16)
>>   /*
>>    * sum of strlen of: fan?_input\0, fan?_min\0, fan?_alarm\0,
>>    * fan?_alarm_enable\0, fan?_beep\0, fan?_shutdown\0
> 
> ABITUGURU_TEMP_NAMES_LENGTH is used further down buy only in a comment:
> 
> /* IN_NAMES_LENGTH > TEMP_NAMES_LENGTH so assume all bank1 sensors are in */
> #define ABITUGURU_SYSFS_NAMES_LENGTH    ( \
>          ABIT_UGURU_MAX_BANK1_SENSORS * ABITUGURU_IN_NAMES_LENGTH + \
>          ABIT_UGURU_MAX_BANK2_SENSORS * ABITUGURU_FAN_NAMES_LENGTH + \
>          ABIT_UGURU_MAX_PWMS * ABITUGURU_PWM_NAMES_LENGTH)
> 
> So IMHO ABITUGURU_TEMP_NAMES_LENGTH should stay so that someone
> reading the comment will actually be able to understand things,
> removing ABITUGURU_TEMP_NAMES_LENGTH makes the comment very
> hard to understand and we want to keep the comment.
> 
> So NACK from me for this change.
> 

Marked as rejected.

Thanks,
Guenter


