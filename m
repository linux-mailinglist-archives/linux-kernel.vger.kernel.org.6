Return-Path: <linux-kernel+bounces-556472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A9A5CA46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F517AE054
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253BB25EFBC;
	Tue, 11 Mar 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WshGA6XX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234A25E825
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709197; cv=none; b=U5T/69pjOkg1Lkyqlm1Cj0cjY1YehqU+vRVt4203AM4W8bPKkLClCFPMH1DsgBuMq3Y3ftn+crp9jNZlEua3bn0B68rA4klP1zNT7BVn+MCYtICdW5ftHH3j0bBD0WorT4V/uemB0gF/H6KXqlQ7NrYl0HV0e3O+VJyxARpd8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709197; c=relaxed/simple;
	bh=93Eu+qH7Gk9D2wT5TQuGxgkgE9YqDib5BBP+k0h/J8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4y+yqirdX58JdDgZrgfennfnotnPhwXlCNQOYIcnAc5/cO0WKm7TWdGHGoDFpzbj+/YRHkZIwFadfmWGgHzSyeYeWA6IPF9Bo7qQojgXX3TKSY9T3EbeHnRY5y3DQPhM8W8oZPqkmDuTcfRK5dq7TlFWeoQ4Q1Ky82XVDV1Db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WshGA6XX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1564684f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709193; x=1742313993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXsmviR97V/C+Y6DN95zESwUd4Ub5ygS+7V9sfykhO8=;
        b=WshGA6XXCVznxdQ3ThnTJpSW8riOkFAwRJiIloZmepTdio99nUz6XAQCs7I3y0Whki
         MVexLMZa0Gbtu9y0GE4n0oG7NSVV2/NR7dh9HOorN2fb0PPADQ/zp2G9NPKZLG8ET62e
         74cG9zeozBZepnqVVMdSsKTfZW79ytiVs8A/x3KjSiCkxcBjG6VhSgQIw4qypdiRKjN9
         W8oOzEy9uXIjaVjtJjwV4AGYoCoJ+MsYENqmviYoMKANxa1gHiyikWUYV/D5iIEgScdI
         Yy7vl8qAIc9M+ZEHkQZ+oGvaFeQg+wtEJDPJ3VI59Jp9abxabF511z9SFMLwsEk1eP65
         i4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709193; x=1742313993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXsmviR97V/C+Y6DN95zESwUd4Ub5ygS+7V9sfykhO8=;
        b=OgmZ9T3XzA2VRailjBfCIxHWSl6KePphv4mZFUDE6RMb+iK6mAeWKzSdt4Kpq1vAVP
         nEABGyYv4Y7qGL2jHwsYm8MAfmNlKK4vddxzeiYkxnoUAugemzatXBeepDG6c2UtHPJr
         BPNn7H/RBXx2owcWtf1tbh3r3tVgXYcEs7fKq3ah2XqptO9XpChHtauY525LzfkGrp6N
         ng5V1aEZV93rUqKw9mqNWUGbZbwUjTYOoNboCMc2UsvND3c+0Qceu33EFcnPo+qZsiWA
         txkNBs9GxVTDP8QRLK29OEDI7hj3UJKq6O0VhDjaOUgIa0MXfpONdYke9pE3pT+dh0q2
         d6Uw==
X-Gm-Message-State: AOJu0Yz0hvPpF5uzAT0oqW2uDy7GLEEOG7SNgP+Yn7vuTRYU9aO8CRT5
	I38aggL5DR1TR3i5/EXua6RMJTNhy/AvyLhDDQZ5B1mQ3dUvLOrWUfMiNngp0Q4AK63Az5Y/k4i
	B
X-Gm-Gg: ASbGncvMflzzkdsQHWEkqisk7eLYrzwcIX40PeWRmeb+zJx86jAxr3AlQpIWIjulEob
	W7nefkJrbSVUV86cB83YTjidFsTbAncRFmEJ/Onf9jdFyHzK4dM7fLxg9gNNk1G2fKCxcZ9zKWF
	SxIejR/uPH6sIKRea3V1/BjjdZqYEFNqZf5d6ELu9wZVG1lseeSkVrL4cGjNUsn4HcH3vIWH8Vi
	TOLfauEW0PmYYDOYN/1THFkJ6qbJxxl+b34UCsUqLqD3sS/gn8OFkkaL9HEgpZvEp8xQXNe2vOD
	mUngP6E4v0iZfSVYok/wm/1b4YLaDROngjUoxjvxX6A2Z56nl4hVREmV6KSLI0Q=
X-Google-Smtp-Source: AGHT+IHSsCm8PJOCNTBLbU5hS9VK9UHGVgainULGpG4I1aqQfmscGAZFmbLVme10Qk7EkXAo6AGeDQ==
X-Received: by 2002:a05:6000:1a8f:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-3926c3b8b38mr4616837f8f.9.1741709193494;
        Tue, 11 Mar 2025 09:06:33 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01de21sm18711241f8f.59.2025.03.11.09.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:06:32 -0700 (PDT)
Message-ID: <16fd2023-1ffa-4e87-ad89-a7ccdd8ba458@linaro.org>
Date: Tue, 11 Mar 2025 16:06:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: Add a KUnit test for
 coresight_find_default_sink()
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>
References: <20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org>
 <c31de6cb-f8f5-432c-b99e-68b10a24bc5e@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <c31de6cb-f8f5-432c-b99e-68b10a24bc5e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/03/2025 3:00 pm, Suzuki K Poulose wrote:
> On 05/03/2025 15:07, James Clark wrote:
>> Add a test to confirm that default sink selection skips over an ETF
>> and returns an ETR even if it's further away.
>>
>> This also makes it easier to add new unit tests in the future.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes in v2:
>> - Let devm free everything rather than doing individual kfrees:
>>    "Like with managed drivers, KUnit-managed fake devices are
>>    automatically cleaned up when the test finishes, but can be manually
>>    cleaned up early with kunit_device_unregister()."
>> - Link to v1: https://lore.kernel.org/r/20250225164639.522741-1- 
>> james.clark@linaro.org
>> ---
>>   drivers/hwtracing/coresight/Kconfig                |  9 +++
>>   drivers/hwtracing/coresight/Makefile               |  3 +-
>>   drivers/hwtracing/coresight/coresight-core.c       |  1 +
>>   .../hwtracing/coresight/coresight-kunit-tests.c    | 77 ++++++++++++ 
>> ++++++++++
>>   4 files changed, 88 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/ 
>> coresight/Kconfig
>> index ecd7086a5b83..f064e3d172b3 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -259,4 +259,13 @@ config CORESIGHT_DUMMY
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called coresight-dummy.
>> +
>> +config CORESIGHT_KUNIT_TESTS
>> +      tristate "Enable Coresight unit tests"
>> +      depends on KUNIT
>> +      default KUNIT_ALL_TESTS
>> +      help
>> +        Enable Coresight unit tests. Only useful for development and not
>> +        intended for production.
>> +
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/ 
>> coresight/Makefile
>> index 8e62c3150aeb..96f0dfedb1bf 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -51,5 +51,4 @@ coresight-cti-y := coresight-cti-core.o    
>> coresight-cti-platform.o \
>>              coresight-cti-sysfs.o
>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>> -obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
>> -coresight-ctcu-y := coresight-ctcu-core.o
>> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>> hwtracing/coresight/coresight-core.c
>> index bd0a7edd38c9..b101aa133ceb 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -959,6 +959,7 @@ coresight_find_default_sink(struct 
>> coresight_device *csdev)
>>       }
>>       return csdev->def_sink;
>>   }
>> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
>>   static int coresight_remove_sink_ref(struct device *dev, void *data)
>>   {
>> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/ 
>> drivers/hwtracing/coresight/coresight-kunit-tests.c
>> new file mode 100644
>> index 000000000000..a136af05eaf4
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <kunit/test.h>
>> +#include <kunit/device.h>
>> +#include <linux/coresight.h>
>> +
>> +#include "coresight-priv.h"
>> +
>> +static struct coresight_device *coresight_test_device(struct device 
>> *dev)
>> +{
>> +    struct coresight_device *csdev = devm_kcalloc(dev, 1,
>> +                             sizeof(struct coresight_device),
>> +                             GFP_KERNEL);
>> +    csdev->pdata = devm_kcalloc(dev, 1,
>> +                   sizeof(struct coresight_platform_data),
>> +                   GFP_KERNEL);
>> +    return csdev;
>> +}
>> +
>> +static int coresight_test_cpuid(struct coresight_device *csdev)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void test_default_sink(struct kunit *test)
>> +{
>> +    /*
>> +     * ETM -> ETF -> ETR -> CATU
>> +     *                ^
>> +     *                | default
>> +     */
>> +    struct device *dev = kunit_device_register(test, "coresight_kunit");
>> +    struct coresight_device *etm = coresight_test_device(dev),
>> +                *etf = coresight_test_device(dev),
>> +                *etr = coresight_test_device(dev),
>> +                *catu = coresight_test_device(dev);
>> +    struct coresight_connection conn = {};
>> +    struct coresight_ops_source src_ops = {.cpu_id = 
>> coresight_test_cpuid };
> 
> Do we need the trace_id() ? Why is this required ?
> 
> Suzuki
> 

Because it tests with per-cpu sources so it checks if any of the TRBE 
sinks have been assigned first:

  /* look for a default sink if we have not found for this device */
    if (!csdev->def_sink) {
       if (coresight_is_percpu_source(csdev))
	 csdev->def_sink = per_cpu(csdev_sink,
                                    source_ops(csdev)->cpu_id(csdev));

I think this test would probably fail if run somewhere TRBE was already 
probed. I can make the source subtype to be 
CORESIGHT_DEV_SUBTYPE_SOURCE_BUS for the test to work around it. Any 
value other than CORESIGHT_DEV_SUBTYPE_SOURCE_PROC will work. And then I 
can drop the fake cpu_id() callback.


