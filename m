Return-Path: <linux-kernel+bounces-240249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC6926AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2801F213B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688A194AC7;
	Wed,  3 Jul 2024 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcTyJI6t"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC6194A43;
	Wed,  3 Jul 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043334; cv=none; b=O8S2exSKhzmlUMJUJ/WST4uO0SpK0maQ2rZv8n/Z9RjiSRU5hkQQQICcd7rQPT+jzLc1UefP/W9Wg1IApDqJo/apGLC1tatxRbWQxPzi5xz+pjMGi4+vZPa2oNT/7Lv3mmZ1Tmqid7byFi9iRELx1mUYogHEyjTDND1XIKHXzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043334; c=relaxed/simple;
	bh=N32NDO0/HIEfM/TdFnBQODUZPnPhe+ICVnHfYxYC2Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4yprDvNZ72VfdKCy1l32ntLjTK3BQthnNe5+3WTpZSyrPiMqIRumGZcHSOiroOfocTxuNAm8fH+PzIZ9hcrkDNR2kfKE83jPY5wEQ4e08UV9GrNBUmf19rAZDFFYrnWMEXvTkJmixSPF3hthHEnxhUF0Pkix+oazJamf5I7cOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcTyJI6t; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so3414490a12.2;
        Wed, 03 Jul 2024 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043332; x=1720648132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IZJelXmMaiDFYpGA+bEfG1CdOh8nPHcs/JLTHgefJjY=;
        b=LcTyJI6t1VNd9f3ETNKg33Sfd+us3dWy+/Qa7dqGTR8bmoxqRUOHl97d474NP8ebuu
         NFszWyJwZAdcwGB4+CzFEeg8SA6oTlwyKgZ+4u6lkEvmR5DUUhR9JmRgMWM6gPXcWHlW
         zL//qXq+nNbgiW2cdGaWjQ/dNrhSeaxUD/w4FIFbCaikwLUm/dLFaBZlHGCupNk0EEUd
         H93KQ9ROQjvH4X4fl76c1YPdbrUXfBOs/tBNd/X32ml1sJf9E1bQm5ZjdOVZF1ZXkaZR
         1WyhMiB1rq6G9ZY289KklAsjh3SRJdEY7Nz0PuzRYBVLCuXOJ3nddfX2na93kGVJPyma
         qjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043332; x=1720648132;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZJelXmMaiDFYpGA+bEfG1CdOh8nPHcs/JLTHgefJjY=;
        b=lzc4MIICe2633chRvTxAZlTbNPBoQmVA3zOGrMtmdvTAKdfU0ePbcv7dYCa/1EPvU1
         ecsC1Bchbs5p+cVA3NOMZwLrvjVY3bYxM0K9PiNIpniKFLjB0RB8T9nXxEmpJPoTMIXi
         USw17A0FA5k5l2aJWj7pb2XK4xW96zvFfUivFwzH+TcJXeH3wfmynWIGQ7P/PwJTQOr4
         FgsUXnxk6oToTjc+j0VA6JkntfiB8WnLGwuc4UXig4LpiTknwR6O/P3hNXDZptR7xGLE
         oZUVO/p1TOrBlbRvoRCO+ckYAJ1upSlDFy4wasqZMedQzETDoG3kcuK3Wo2SNEZEukww
         RArA==
X-Forwarded-Encrypted: i=1; AJvYcCXVrTovC1vhK6klNJVHoMn1CYgIn8KT/8EpVPikwlMxsRte5RshBAh5BQYrmPkfqNLc6bNdfkLiXwYIsoQJqzYGozSpTy5b9K3RdKQ=
X-Gm-Message-State: AOJu0Yxa6pn+2SUxt08bYDAVNpx0EKQcUGaOayi/hyDkdzHN4P+5tXeu
	OVinaEHRjiKPMkXNlNjl6ib6fqciueyrYEbYhijYBDOSm/udd7yxqtZmdg==
X-Google-Smtp-Source: AGHT+IHiPJNadjh+TVTY7XFT0j1N1EnDTIJVqAoAtkqY6ONufJLxOEQjzp6TODM14IP9y392wr3cQw==
X-Received: by 2002:a05:6a20:a124:b0:1bd:1df4:bd43 with SMTP id adf61e73a8af0-1bef6275a5dmr12677224637.54.1720043332343;
        Wed, 03 Jul 2024 14:48:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1a3d25f1sm18428625ad.139.2024.07.03.14.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:48:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8cb9dc38-499e-4f10-93a4-c07898a776b4@roeck-us.net>
Date: Wed, 3 Jul 2024 14:48:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hwmon: (amc6821) Make reading and writing fan
 speed limits consistent
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-3-linux@roeck-us.net>
 <750d28c7-4d90-4bd6-a910-4d5e73828e55@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <750d28c7-4d90-4bd6-a910-4d5e73828e55@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 07:35, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/1/24 11:23 PM, Guenter Roeck wrote:
>> The default value of the maximum fan speed limit register is 0,
>> essentially translating to an unlimited fan speed. When reading
>> the limit, a value of 0 is reported in this case. However, writing
>> a value of 0 results in writing a value of 0xffff into the register,
>> which is inconsistent.
>>
>> To solve the problem, permit writing a limit of 0 for the maximim fan
>> speed, effectively translating to "no limit". Write 0 into the register
>> if a limit value of 0 is written. Otherwise limit the range to
>> <1..6000000> and write 1..0xffff into the register. This ensures that
>> reading and writing from and to a limit register return the same value
>> while at the same time not changing reported values when reading the
>> speed or limits.
>>
>> While at it, restrict fan limit writes to non-negative numbers; writing
>> a negative limit does not make sense and should be reported instead of
>> being corrected.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Do not accept negative fan speed values
>>      Display fan speed and speed limit as 0 if register value is 0
>>      (instead of 6000000), as in original code.
>>      Only permit writing 0 (unlimited) for the maximum fan speed.
>>
>>   drivers/hwmon/amc6821.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index eb2d5592a41a..9c19d4d278ec 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -617,15 +617,20 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>>   {
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>>       struct i2c_client *client = data->client;
>> -    long val;
>> +    unsigned long val;
>>       int ix = to_sensor_dev_attr(attr)->index;
>> -    int ret = kstrtol(buf, 10, &val);
>> +    int ret = kstrtoul(buf, 10, &val);
>>       if (ret)
>>           return ret;
>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>> +
>> +    /* The minimum fan speed must not be unlimited (0) */
>> +    if (ix == IDX_FAN1_MIN && !val)
>> +        return -EINVAL;
>> +
>> +    val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
> 
> I'm wondering if we shouldn't check !val for min after this line instead? Otherwise we allow 6000001+RPM speeds... which is technically unlimited.
> 

If ix == IDX_FAN1_MIN, val must be positive because of the check above.
The expression "6000000 / clamp_val(val, 1, 6000000)" is therefore always
positive as well because val is clamped. Its minimum result would be
6000000/6000000 = 1. The alternate case of the ternary expression would
never hit because it is guaranteed that val > 0. Am I missing something ?

Thanks,
Guenter


