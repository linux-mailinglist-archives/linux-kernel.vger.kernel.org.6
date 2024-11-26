Return-Path: <linux-kernel+bounces-421792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95199D9035
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D762859EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96815E96;
	Tue, 26 Nov 2024 01:59:59 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533E12E5D;
	Tue, 26 Nov 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586399; cv=none; b=eBNjGJ9SQxrZsB/Q4mpdBTxTrNWjIC/mjjblFpLQRv43gJfxjTjIMf1o0SK4fMPdbXYfXB49QtrT+xb+sD9wVuvozRIHJy+5n/nICkFUiLCv7EcLsnwJE/KxFpaoYSYfi4TfZviQoflhbXlhykohWHyNGr9W/ZlyczchnMMvwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586399; c=relaxed/simple;
	bh=Q2S+4BSo3pDWJrhc7vNRBQEA08WGMWc9iZhxucQd8OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XRNtMzEbI10aFjaeQkZhM835o0hNL1b+YXAOF4N0w54+FTF1X10P5lGh/htGYL9yRIDqXb1YtYfSpv5U+XaMnYk1dhJc8TdcCNI4yskwX/62vO3kRIeC1fHbySYCJuTK9P/w/q7msoSYqqTxq+flce6OKFYXisfI3Ld6PhXFlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xy5PM1Sgtz1yqxJ;
	Tue, 26 Nov 2024 10:00:07 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 33D651A0188;
	Tue, 26 Nov 2024 09:59:53 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 09:59:52 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 09:59:52 +0800
Message-ID: <4a1ff82f-f79c-6b3d-975f-4bd0cff5c42d@huawei.com>
Date: Tue, 26 Nov 2024 09:59:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/4] hwmon: (acpi_power_meter) Fix update the power
 trip points on failure
To: Guenter Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jdelvare@suse.com>, <liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-3-lihuisong@huawei.com>
 <7acbc41a-f822-4464-8bcb-b7379fa78a86@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <7acbc41a-f822-4464-8bcb-b7379fa78a86@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2024/11/25 23:22, Guenter Roeck 写道:
> On 11/25/24 01:34, Huisong Li wrote:
>> The power trip points maintained in local should not be updated when 
>> '_PTP'
>> method fails to evaluate.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/acpi_power_meter.c 
>> b/drivers/hwmon/acpi_power_meter.c
>> index 4c3314e35d30..95da73858a0b 100644
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
>> @@ -292,8 +292,8 @@ static ssize_t set_trip(struct device *dev, 
>> struct device_attribute *devattr,
>>       struct sensor_device_attribute *attr = 
>> to_sensor_dev_attr(devattr);
>>       struct acpi_device *acpi_dev = to_acpi_device(dev);
>>       struct acpi_power_meter_resource *resource = 
>> acpi_dev->driver_data;
>> +    unsigned long temp, trip_bk;
>>       int res;
>> -    unsigned long temp;
>>         res = kstrtoul(buf, 10, &temp);
>>       if (res)
>> @@ -302,8 +302,11 @@ static ssize_t set_trip(struct device *dev, 
>> struct device_attribute *devattr,
>>       temp = DIV_ROUND_CLOSEST(temp, 1000);
>>         mutex_lock(&resource->lock);
>> +    trip_bk = resource->trip[attr->index - 7];
>>       resource->trip[attr->index - 7] = temp;
>>       res = set_acpi_trip(resource);
>> +    if (!res)
>> +        resource->trip[attr->index - 7] = trip_bk;
>
> Unless I am missing something, this restores the old value if setting
> the new value succeeded. Please explain.
>
Yes, you are right.
Restore the old value on faiure. will fix it.
>
>> mutex_unlock(&resource->lock);
>>         if (res)
>
> .

