Return-Path: <linux-kernel+bounces-421791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD39D9031
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE91622B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4497314012;
	Tue, 26 Nov 2024 01:56:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BBDF60;
	Tue, 26 Nov 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586202; cv=none; b=JMFswWWdvsYUE5IWh61fuV+y6cbI1lzZ/zVokX0NkXed/OXoegP1M1zX987gI4KAtf1rZjORw02IXFrbssfJYlB8dK8yuXwI+XBDuCnNk625caVXnuRM8d4b7P3pKEGSY4Noi2ZvA3kzrxMr9R1XAo2fEdY1JuzdR3ydpN5PKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586202; c=relaxed/simple;
	bh=OxJe9T4YNUqcUJuE7w/XKLYO21BA2S9yyd1HdvrUy0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aUZ7hhm4YIvASQRyuAsz6yByOclbGYb5538A8a9Ffmi0YWqgYGXUgS9ZoNbqgdI5tOw3pstj+VtLaKnvbvS0Ee8Om1Df0P/i0zo4oYta3i5qlM/q40/9Cv0hm5l7JNF3HiccWlfa6UrwoWlkCvAwYQNzwbeDzea9Ko0HC9U6D0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xy5G54WVVzxT1x;
	Tue, 26 Nov 2024 09:53:49 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 86C88140154;
	Tue, 26 Nov 2024 09:56:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 09:56:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 09:56:34 +0800
Message-ID: <b801388b-6bc7-5e96-dd29-e68ed8c970df@huawei.com>
Date: Tue, 26 Nov 2024 09:56:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/4] hwmon: (acpi_power_meter) Fix using uninitialized
 variables
To: Guenter Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jdelvare@suse.com>, <liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-2-lihuisong@huawei.com>
 <aa6e1c02-b8bf-4d25-ad21-2018af72e16f@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <aa6e1c02-b8bf-4d25-ad21-2018af72e16f@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Guente,

Thanks for your timely review.

在 2024/11/26 0:03, Guenter Roeck 写道:
> On 11/25/24 01:34, Huisong Li wrote:
>> The 'power1_alarm' attribute uses the 'power' and 'cap' in the
>> acpi_power_meter_resource structure. However, these two fields are just
>> updated when user query 'power' and 'cap' attribute, or hardware 
>> enforced
>> limit. If user directly query the 'power1_alarm' attribute without 
>> queryng
>> above two attributes, driver will use the uninitialized variables to 
>> judge.
>> In addition, the 'power1_alarm' attribute needs to update power and 
>> cap to
>> show the real state.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/hwmon/acpi_power_meter.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/hwmon/acpi_power_meter.c 
>> b/drivers/hwmon/acpi_power_meter.c
>> index 2f1c9d97ad21..4c3314e35d30 100644
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
>> @@ -396,6 +396,9 @@ static ssize_t show_val(struct device *dev,
>>       struct acpi_device *acpi_dev = to_acpi_device(dev);
>>       struct acpi_power_meter_resource *resource = 
>> acpi_dev->driver_data;
>>       u64 val = 0;
>> +    int ret;
>> +
>> +    guard(mutex)(&resource->lock);
>>         switch (attr->index) {
>>       case 0:
>> @@ -423,6 +426,13 @@ static ssize_t show_val(struct device *dev,
>>               val = 0;
>>           break;
>>       case 6:
>> +        ret = update_meter(resource);
>> +        if (ret)
>> +            return ret;
>> +        ret = update_cap(resource);
>> +        if (ret)
>> +            return ret;
>> +
>>           if (resource->power > resource->cap)
>>               val = 1;
>>           else
>
>
> While technically correct, the implementation of this attribute 
> defeats its
> purpose. It is supposed to reflect the current status as reported by the
> hardware. A real fix would be to use the associated notification to 
> set or
> reset a status flag, and to report the current value of that flag as 
> reported
> by the hardware.
I know what you mean.
The Notify(power_meter, 0x83) is supposed to meet your proposal IIUC.
It's good, but it depands on hardware support notification.
>
> If there is no notification support, the attribute should not even exist,
> unless there is a means to retrieve its value from ACPI (the status 
> itself,
> not by comparing temperature values).
Currently, the 'power1_alarm' attribute is created just when platform 
support the power meter meassurement(bit0 of the supported capabilities 
in _PMC).
And it doesn't see if the platform support notifications.
 From the current implementation of this driver, this sysfs can also 
reflect the status by comparing power and cap,
which is good to the platform that support hardware limit from some 
out-of-band mechanism but doesn't support any notification.

