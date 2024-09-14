Return-Path: <linux-kernel+bounces-329421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E74A97911D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AE91F22C66
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A081CF7DD;
	Sat, 14 Sep 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyC5Olzs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9843ABD
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321568; cv=none; b=l7LRlgatNDWpgRshm4vXGZopcsYvIawSR6QL6MEl9mNJlleec8B+ffnp1AC79LwhHe50SFNirT6CgKD21ME6lcHBmHFQmXKKNN9Jan4xsab56ulQo8zuvN7wcDH31fHV/HeO7LzRsZtGdkbzCPaT1iPkx01PcrKv+wEe5U0gGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321568; c=relaxed/simple;
	bh=7LIgMNt/HYMs9JMX58x8rEKmnOParwufdKZfl4X/AQk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cNuWoLN3QonGr1gClE6kO9a2YFDVSJhRd1Bo2+d6Z2Ijm4qOcqOdhwQVGMPWjOUR7+WWo4CPNXeIq6nD26IGjdVFLtVH7/ZpscgneU8G6/w4MfoIV7UWzcd4/VthzsHfwow4kZAjJMdr0SCK3RlxnjIeCt0eJiwOvdtQfNc/c4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyC5Olzs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726321565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcbH6xKjPio0d3vBUKsMg5DSPgp+NCqhlSRBuQiAMdA=;
	b=dyC5OlzsWourNSLz5G1mJ2YgoBh6ZsflM9ZofK2/w9SoOtCdO4GMEgZNUvf9hATCJJUP65
	N3Czx2JOjJnJVIx1gqVbZUigBIT6T0rYZ0PnkyKPmhZTQHFjVW3wCQypDJ6FMx3t+mUIBi
	tMukqSAMXm/BLJUzQuVNLvPv7h9r1hM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-OlZXgsLXOOeMPZcX04YHuw-1; Sat, 14 Sep 2024 09:46:02 -0400
X-MC-Unique: OlZXgsLXOOeMPZcX04YHuw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c269f277eeso2098103a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726321561; x=1726926361;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcbH6xKjPio0d3vBUKsMg5DSPgp+NCqhlSRBuQiAMdA=;
        b=mgFMdtPmVyscKCdGbrIaOoG9HCoaKv1O8IznKaSpqeM5QFEyQDUEZd6k0OwbuGk3Wj
         uznBjl6o2r6o/s/JkmvdNwDhykLC1GGp59PGm25eh0BS6YPwalNiG9yZjUkHP1LQisDr
         QAaJZM/gZitf2EKOzIkf8+H4LoFZAT+v6DL6ziQzpKJyUtF3SiKme2XLD9G2iyPIrNsL
         rSDMab8dAZaG9UxWJOV1bCpclTSQRCkKWTn9PKem5VGGsmkXbKQ6ReHYfuCEJqMvjigG
         1rzrBawG6M0IhbP4guiiM1zIdAp5DqqelZDNgNY/+v8ep0o4fb247e0dhHRgp8hX+EI2
         JU8g==
X-Forwarded-Encrypted: i=1; AJvYcCXJhAJyzIW1735rPGVKEFmyEEBLp0X+UVj1HB3+9PrKtGXebqCXZuCHt5gLguwPWA5ZILV/qoxieUqt3WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwpFtQ1dLw+EzoBobjt7xf2mMR0JHflNR2NMXYoqwjIug1ACz
	awniSDDD7L1bOdaBWvODiF/ziiDcQhed4ATkK6lCXcy79KF7XEY4JgGelOK8Ap3VRmgee0+xJAz
	KWKPXjIw1MJckaYIzDnXACAPXV1RlFMEukE/tzRdsw6ogVog3p2HOu7K98/cNaA==
X-Received: by 2002:a05:6402:278b:b0:5c2:480e:7960 with SMTP id 4fb4d7f45d1cf-5c413cbc723mr8706912a12.0.1726321560606;
        Sat, 14 Sep 2024 06:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgr+Inr50L4KRA7VVQODXZub0jVSMHk2Ur9cSfsqmJ1S2LbHYM3ln4qatBW8FyycvFp6pErw==
X-Received: by 2002:a05:6402:278b:b0:5c2:480e:7960 with SMTP id 4fb4d7f45d1cf-5c413cbc723mr8706886a12.0.1726321559975;
        Sat, 14 Sep 2024 06:45:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e97sm679519a12.65.2024.09.14.06.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 06:45:59 -0700 (PDT)
Message-ID: <9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com>
Date: Sat, 14 Sep 2024 15:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
 <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 9/12/24 3:51 PM, Hans de Goede wrote:
> Hi,
> 
> On 9/11/24 11:22 PM, Andy Shevchenko wrote:
>> The commit in question does not proove that ACPI ID exists.
>> Quite likely it was a cargo cult addition while doint that
>> for DT-based enumeration.  Drop most likely fake ACPI ID.
>>
>> Googling for LTERxxxx gives no useful results in regard to DSDT.
>> Moreover, there is no "LTER" official vendor ID in the registry.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 9/13/24 11:31 AM, Andy Shevchenko wrote:
> Have you grepped over your collection of real DSDTs?

Yes I did, but I just double-checked looking for only LTER and there
are several DSDTs using LTER0303 for an ambient light sensor.

duckduckgo-ing for LTER0303 finds:

https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303

which is actually quite an interesting URL to search for ACPI
HID-s used in any Windows drivers.

Checking for LTER0301:

https://www.catalog.update.microsoft.com/Search.aspx?q=lter0301

Shows that that HID is also actually used, so:

> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Correction, at least the LTER0301 ACPI id seems to actually be real:

https://www.catalog.update.microsoft.com/Search.aspx?q=lter0301

So NACK for dropping all 3 HIDs.

It seems to me that the LTER05xx HIDs can be dropped and
a LTER0303 HID should be added instead of dropping all HIDs.

Note I do not have any hw with a ltr303 light sensor, so
I cannot test this.

Regards,

Hans




>> ---
>>  drivers/iio/light/ltr501.c | 23 -----------------------
>>  1 file changed, 23 deletions(-)
>>
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 8c516ede9116..0e0420573286 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -15,7 +15,6 @@
>>  #include <linux/err.h>
>>  #include <linux/delay.h>
>>  #include <linux/regmap.h>
>> -#include <linux/acpi.h>
>>  #include <linux/regulator/consumer.h>
>>  
>>  #include <linux/iio/iio.h>
>> @@ -1422,17 +1421,6 @@ static int ltr501_powerdown(struct ltr501_data *data)
>>  				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
>>  }
>>  
>> -static const char *ltr501_match_acpi_device(struct device *dev, int *chip_idx)
>> -{
>> -	const struct acpi_device_id *id;
>> -
>> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>> -	if (!id)
>> -		return NULL;
>> -	*chip_idx = id->driver_data;
>> -	return dev_name(dev);
>> -}
>> -
>>  static int ltr501_probe(struct i2c_client *client)
>>  {
>>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>> @@ -1523,8 +1511,6 @@ static int ltr501_probe(struct i2c_client *client)
>>  	if (id) {
>>  		name = id->name;
>>  		chip_idx = id->driver_data;
>> -	} else  if (ACPI_HANDLE(&client->dev)) {
>> -		name = ltr501_match_acpi_device(&client->dev, &chip_idx);
>>  	} else {
>>  		return -ENODEV;
>>  	}
>> @@ -1609,14 +1595,6 @@ static int ltr501_resume(struct device *dev)
>>  
>>  static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>>  
>> -static const struct acpi_device_id ltr_acpi_match[] = {
>> -	{ "LTER0501", ltr501 },
>> -	{ "LTER0559", ltr559 },
>> -	{ "LTER0301", ltr301 },
>> -	{ },
>> -};
>> -MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
>> -
>>  static const struct i2c_device_id ltr501_id[] = {
>>  	{ "ltr501", ltr501 },
>>  	{ "ltr559", ltr559 },
>> @@ -1640,7 +1618,6 @@ static struct i2c_driver ltr501_driver = {
>>  		.name   = LTR501_DRV_NAME,
>>  		.of_match_table = ltr501_of_match,
>>  		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
>> -		.acpi_match_table = ltr_acpi_match,
>>  	},
>>  	.probe = ltr501_probe,
>>  	.remove	= ltr501_remove,
> 


