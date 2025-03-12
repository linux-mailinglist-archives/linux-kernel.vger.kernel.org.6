Return-Path: <linux-kernel+bounces-557523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86057A5DA59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2936918976ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BF723E357;
	Wed, 12 Mar 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Naa11bcb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662A23E342
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774776; cv=none; b=e1ZFyelN1ODVzZjM7ab1YdoLTK/RrTR54XgE0b8GuTpB+rsBxoM/4C/CzxIQ0ehVbfTqLKY6dP1Zh2vLD+bJ5dcGBV8J9V38WTI4v6qj0iWC+zmJH7rIdkuC68SzW894q8MnZ5KecQIx4pCM7gAAlpF71U69pA9b0AC15aeUX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774776; c=relaxed/simple;
	bh=4PnXVo/oullR/m+/uJCKBVHMjnOz39bvjEAJfAd50h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXKGjx5ZtDkstFeE3MLZhaBUr0hDSIhy93x0v2gYLyEU4my30A42K3c3aIlxv2hzpAJxOhtbUrAx+umA51mOqD4I0T0N83pqBjUq36nEnuDi5VxJu2ySwx9+t2dV+SHmiQfy2YdepQo8iiEBPfCUx2bJ2yZaPCXHQAzhRuhyrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Naa11bcb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390fdaf2897so6084578f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741774772; x=1742379572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAnXaXan8q+eIeBPOO4LIWIu74EXVlerHh73XPW6Gr0=;
        b=Naa11bcboIb5hmNqOHXNk8D0haVYHKB46w15qfRc3Fyx7xPDYqT4uwedUOVTgXDH8y
         /eBnEQ8PBPY79PjkKQpu6+a1us+iogScLSkc9NB3r8psfz81PHKs2tySNJEgX9YwwfMW
         xo9pN8xyM3kbYGH43SFWxX6aURr1kOJOYmds1PL7mYR26w1mtQ6YckvV4CmUSuibQxUO
         sMUE+b95+6pp/xR6Syf0juwlsWGL99dwYphVDa0dHVBzk5IJ8gqWK/Y0H9lgkhdGADMj
         HqSb8h4WgO+pwagE+rdO3KTbU1IOw0d2CYd6ldXOUmnRtyg742ab1a8xoa6+v737VJn1
         QI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774772; x=1742379572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAnXaXan8q+eIeBPOO4LIWIu74EXVlerHh73XPW6Gr0=;
        b=Yud23J8U2wtPs9ep2xLdxTF0a9qmu+Joa9shw73WK63eHs1FGpR2tYrqr8HRujI7BJ
         yMcmFQ8IVRX5sozhxHMWK5tnezgkVVpxd4egvjH2I0l5pRJPnDYZz6FsZD35YfTQyECO
         l0zuDDhYtGRlpzyEHrFtBuOY+dpUnreral4g11ujGXN+78NEDxoMsBlz/AZUs2FGOJas
         15QG6GXlpwnUcNUlJxcyeMJ8rFCF6phZPH98Q9Gjrk1umpu6MKlo20cX29Xj8XVfe6zo
         pMYrAbG+arc9SyRWbpz9b9Hfqw9DNxPHXsIDVfhUAeHRDqJ1ilv6tBjlun9oEuYG92XM
         va9Q==
X-Gm-Message-State: AOJu0Yyc2vc7VeXhLr8HVErCXp9nfZn5kY+GY+NIIcIp7EV6K2aq67OV
	nENjczfzC9H5LmCtT1SuRtpS2RjKhxK2jBiobIgaR1nkTctrQC8kHolNGyQbHLFhDV50HtE0Ipu
	g
X-Gm-Gg: ASbGnctwCXqBbNV1sxn9lhy912gh3WM8HV7F21Hnd8y21n5lSnotn+n5QunXHfeYmzG
	fpFZ0k7BjMYF9/ynzlZHQDLiFTLu3DaB5MsD+kiXJgNY8JL7JHxs1RLs5LRiOFrxVLrWTlhpkCr
	XlTY+se5X1ypz+1CDm3fhxKDZQaFE+3DDtrxrzt2+RZcb8MIHnImtIrH2QY1GXS3BTLaIRjoeaS
	2t7vpqbEKnaMJqBp3AYA9ad6SFyDTzYZ4BcysHYkBQP+VhaSj4qsaZnXzAmshFzMU37rywAzIht
	0lMp3stLhOENNX1yKte+ZI3Pq7flGmcnYASzSj3U41pTzeuX6HMtiw==
X-Google-Smtp-Source: AGHT+IGR/07Qmf9smabg6S6zn97UBtsm5Jw10Ieg0WIleNha8nV/NH57N3KXiYK+7r8Klg1AgUB0Eg==
X-Received: by 2002:a5d:6d8f:0:b0:38d:d9e4:9ba6 with SMTP id ffacd0b85a97d-39132d090b1mr18246613f8f.3.1741774772405;
        Wed, 12 Mar 2025 03:19:32 -0700 (PDT)
Received: from [192.168.1.247] ([209.198.129.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm21058822f8f.19.2025.03.12.03.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 03:19:32 -0700 (PDT)
Message-ID: <4d058a15-376a-4e9a-bfc0-06bd4ffbd71a@linaro.org>
Date: Wed, 12 Mar 2025 10:19:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: Add a KUnit test for
 coresight_find_default_sink()
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
References: <20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org>
 <d6194071-bc52-4f67-a36e-fc8d9d1be94c@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <d6194071-bc52-4f67-a36e-fc8d9d1be94c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/03/2025 10:14 am, Suzuki K Poulose wrote:
> Hi James
> 
> 
> On 12/03/2025 10:11, James Clark wrote:
>> Add a test to confirm that default sink selection skips over an ETF
>> and returns an ETR even if it's further away.
>>
>> This also makes it easier to add new unit tests in the future.
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes in v3:
>> - Use CORESIGHT_DEV_SUBTYPE_SOURCE_BUS type instead of the default
>>    (CORESIGHT_DEV_SUBTYPE_SOURCE_PROC) so that the test still works even
>>    when TRBE sinks are registered. This also removes the need for the
>>    fake CPU ID callback.
>> - Link to v2: https://lore.kernel.org/r/20250305-james-cs-kunit-test- 
>> v2-1-83ba682b976c@linaro.org
>>
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
>> index 000000000000..87439769207c
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
>> +static void test_default_sink(struct kunit *test)
>> +{
>> +    /*
>> +     * ETM -> ETF -> ETR -> CATU
>> +     *                ^
>> +     *                | default
> 
> minor nit: Using ETM here is going to be confusing, with the SUBTYPE we
> are using. Please could we rename it something else and also rename the 
> variable "etm" ? Say, "source" ?
> 
> Rest looks good to me.
> 
> Suzuki
> 
> 

Yeah good point, "Source" makes sense.


