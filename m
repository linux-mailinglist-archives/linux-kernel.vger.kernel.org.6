Return-Path: <linux-kernel+bounces-236418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B817691E1F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A8DB22629
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6926160865;
	Mon,  1 Jul 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxvKCFyf"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6D1607AD;
	Mon,  1 Jul 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843082; cv=none; b=KZs+tsC405d4F2bpNBd0tR0ccc1IIic/gvnYv/KpBe29tVXY631xqtZPDyZ30qOxTcIcj5NV/cbJpyZwcPzY/LF2I5leE4Z+e/pVHbYW7tQeK4QRmmJ2Njxgn/9bTESgLsmRJXGELndfznwx8wVpKWPLzxmOCUcOvnxDaGKM1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843082; c=relaxed/simple;
	bh=6CEOtsGrhFPLDoewzW5lq5jt//qvPQJNQo5z1GQLZLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTb+X+x/orxLyDKGWVmnmsQ+EnlkX8jufRQWu9rve5J4CY5+xKzPKGZ0+qv1IDrJNk6RfWHHDklR7RJmeeAdA7uQLuMiBr+1GOEjw7GxjOYTkfV+2iYDEzRK1DUTihC/ZnzskyS8CZzadFz9CZwf2yk0D4DoJ/fNXze5WTYfdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxvKCFyf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70683d96d0eso1680211b3a.0;
        Mon, 01 Jul 2024 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719843079; x=1720447879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pu5CC5vhF/R0A2vVFkwivIsgk4tWVCJcrZSVx6Dp8AY=;
        b=WxvKCFyfrUBq1hRJ5/zY0KqKkyNYpz7ug9HdVjV6W8YlKOgP/2l4KNKvTQc+3/p5Mo
         XIJvfkP3yzaUCfSu072iyDjGzOMPnDvdusBleZOBivEzgwdJd76iigJot4y57aH7qnIF
         teHLEtAtXTUgE3NsBMIYrhwlc2v+v82UMpCXAjqBZ31fET/yRc6yxveiDIcr0Qde/Fyi
         +KNgFbn/NDdfTNnla8ZDUE9BTikXXYl/hVmgVIHS+yvXCYD0c6MpQGhBkmEvkzS1//OP
         V3fuVb9WLoz2ZcDIToAIpTf2nXTVADfSbxzyT9+Bam4lH/Om3q2JT1M8OlhMJDTdbE+3
         cT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843079; x=1720447879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu5CC5vhF/R0A2vVFkwivIsgk4tWVCJcrZSVx6Dp8AY=;
        b=GJeYZB4oht0f0W1LFOtyBsyIQfHq8JxXgpabhQZIDoXxhU6qInzpLYpyII4LPBIjMY
         JdwBLMdbPyoUpJBBfEuc2Zr12e3AnK22XRDy0q3VC3GvN/PD651kN5XPGYpqQ9bm9sKt
         8Jvzt5ehlx6N81y814wDsKWxu+yL9d6EW1nbxPKs41/BVeR6haqw45ZRwBFdfuzQChZ6
         jww2KQHZ5NuUdYneAMDj4O0VHkItU/zSQmxGIYhBevc+oIAWXYUSd4moyEn4WZJVveBX
         bew3rDbSQJWAexOIpxwVO3w0Qg+2+FDgyVUtV8Doyq0FNqbtajJDX3Vvh3T0+flYGWvJ
         GiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6uliDsYMjFm1ExBUZur1Sk2YZcboFypoZi7YVjwWHPnOX3Nmo8xwy29lvFZeBYsSaVoWp3UmdkotOOKag6J6McPsvz4Tm+KFEQ1I=
X-Gm-Message-State: AOJu0YxJ5dqzFU1/t7mUgHCsC1qfjVkggbTT1EKl2mv5VnVxKYjakkzU
	LRIGs+K4nzKbp/La5LWvNNcT/edooBtsXhEtisODz7hj82C2vASzDm7JGg==
X-Google-Smtp-Source: AGHT+IEGlifLhxAvN00wV7XN6aNF3blGFC0qmHDyTVxyMc5RCf9DpQVGC7hhtZV9r2oocj7wua513A==
X-Received: by 2002:a05:6a00:1944:b0:6e7:20a7:9fc0 with SMTP id d2e1a72fcca58-70aaaf1de5cmr4668059b3a.34.1719843078646;
        Mon, 01 Jul 2024 07:11:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ae297sm6533531b3a.155.2024.07.01.07.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:11:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9fce6789-edc8-4c44-89c0-ae4ca3ec3315@roeck-us.net>
Date: Mon, 1 Jul 2024 07:11:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hwmon: (amc6821) Make reading and writing fan speed
 limits consistent
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-3-linux@roeck-us.net>
 <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 04:05, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>> The default value of the maximum fan speed limit register is 0,
>> essentially translating to an unlimited fan speed. When reading
>> the limit, a value of 0 is reported in this case. However, writing
>> a value of 0 results in writing a value of 0xffff into the register,
>> which is inconsistent.
>>  > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/amc6821.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 3c614a0bd192..e37257ae1a6b 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -601,7 +601,7 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>>       struct amc6821_data *data = amc6821_update_device(dev);
>>       int ix = to_sensor_dev_attr(devattr)->index;
>>       if (0 == data->fan[ix])
>> -        return sprintf(buf, "0");
>> +        return sprintf(buf, "6000000");
>>       return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>>   }
>> @@ -625,10 +625,10 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>>       int ret = kstrtol(buf, 10, &val);
>>       if (ret)
>>           return ret;
>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>> +    val = val < 1 ? 0xFFFF : 6000000 / val;
>>       mutex_lock(&data->update_lock);
>> -    data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
>> +    data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
> 
> This is an unrelated change I believe and I would therefore have this in its own commit with proper documentation in the commit log. Indeed:
> 
> 1- Change in fan_show handles the default 0x0 register value (which can only currently be achieved via the default value of the registers)
> 2- Allow (re-)setting unlimited fan speed by allowing the user to pass 6000001+ instead of clamping it to 6000000 RPM.
> 

Both changes are related.

The whole point of this commit is to report and permit consistent values when
the register value is 0. But you do have a point - reading it after my changes
returns 6000000, but writing the same value sets the register to 1. So I think
the proper change would be to display 6000001 as speed if the register value is
0, and provide a more detailed explanation. Would that address your concerns ?

Thanks,
Guenter


