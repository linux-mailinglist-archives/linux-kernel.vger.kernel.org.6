Return-Path: <linux-kernel+bounces-563988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4112A64B80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F5B7A3050
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BB241683;
	Mon, 17 Mar 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyNIRwDq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C3237709
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209152; cv=none; b=CCY7GYsGSX7hEuPTZ4l5YjUMrJhWPo8+TKsmW2UmPxzKg8c0rte46oODbqb6q08gDdoianmLLyq/7wcDnYUILYaouDEv0iNDtrZQNkIKhoH6BsltRQozIhehtvYkqIvno9rKdbkN0yAHMWSkVmTISINWJjtLoNPdrLayxcHr+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209152; c=relaxed/simple;
	bh=FOo8roRtvW66GjmHTit6ZYSoCrPEG22CujHf1JFzUSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I858U8xjCfbLWIP4TZIBeLOOCylk+/7ATBwBoP8eQhBFoivekcOi9cfmeCOroIGjRagobAacKThUWxT9S3zSu5tymIZyFFtS6CXPZANJLPduXcG/3Q7HzpuOkwVVd8D41aHDuuzFwwgIufoiPneM6IHVqS0ZQwK9bZL4McBVnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyNIRwDq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2816797f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742209148; x=1742813948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK7AhVJ3F7THFxrXb84qbxNbA9ZQJ8dVwTTugtkUz/w=;
        b=WyNIRwDqUtCp1N7i1c5x+0WcTteoAqxTAWnCgQrxJXv6//NaNytsa0ZOlwuNhr8zBI
         BV77tAkrLB4sIwap6kcyOeJG9uJqEGYWYGNn2IWdmg8UYJZG3/QOQc/49DUkKX0JkYF/
         7QznVzMLUSAAzbmvl5IpVCnjC24HS+2IiDPpsWy4PVMUvyryTFEX2pmLwX4PhCQ2WX4F
         1zZx2GFinawNHbJNAFcBjUuiKSlD5xvirgfs/nK9I2hkVqPlwNkzzV4V1UAQ6nsr4Em1
         RFNx4uZAyu+2vRV2v5juGuMesLiLXh+YKBjD8UZL9VIe2XW1GFMbbEHSAdOOQtyhtB6o
         ER4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209148; x=1742813948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK7AhVJ3F7THFxrXb84qbxNbA9ZQJ8dVwTTugtkUz/w=;
        b=ghZJuLCygDwxvfuNzBWTFGo0e3KUIIuNzrL9fyt5H95EDD4VJmKf9n0HN68MZwY46l
         qa8/YmTA/raHGVRLfI34DisemrIo3LzFPLOrlfh0xNu+F3l/d7Du4FWwzuu8YFDoqYp8
         TlEOJMX8Hld1pC/1tz+jYZro44Wj+4tSRjmOVTLurD1bneqistBuk4zy9K0yYw9HhDrd
         fRpJm1AougwkYJ4OxLD9QuA5GHaF4eaSDIqN1hV4mCSPk7hnNDPo+3Ozlaw6ti7CAZPH
         y26unisvGnFh8ZtsKNFzppQmDs5eKYX7NY665QOgh6B+HPPNtCQUcqS4sVGoJq9LpjFp
         sEgg==
X-Gm-Message-State: AOJu0YyD4n62ysDC0EAhRPGoPumRJ1uEYNw1AE//0Wgehh+FzQkrNh/1
	LtxfIE6CN5MiwnxEM4XHhsqHnySZTV/w41qOryM2TWI40QSOq/tXpdSZGGAvTMA=
X-Gm-Gg: ASbGncv0S4Xj1oTjyZLpxRcBy6JSQTiz+nRQFuk2a20RI4pohH6lPOnS7vjfB5rUY1D
	x5H/FTdL6ywGuHZ25NYrzD74Ffh3q/49nuZpuSBINVCQBgLdDU0snN3LxEsbRKTRpl/XXaxWAMX
	bYJqz4CKJ+KN6y+Wef/4ND6DSly1HEst9ySgUgBulMzYinBbRVkf3owNefTG9lEQuSlqbnCYtdx
	AQ80YxGq0srCq/E659gjnFVqEu4NWZbD9JFt+4oJUzm4Zq8tLPvKrNmSsJdzflWabQ2wgx+erJ3
	nkQO36K0r3Ys7q4+O7ghKzixJKN8HZQEIvyy3utVuxHX/4sBf+cWEQ==
X-Google-Smtp-Source: AGHT+IE+pZAT6Zoz4mByy2Kt/0T1l09GR38j2gc34XOf4nGPlW76sJSyy7cY+0y2lLhYLTV7X3IOTQ==
X-Received: by 2002:a05:6000:381:b0:397:8ef9:a143 with SMTP id ffacd0b85a97d-3978ef9a95amr10631556f8f.23.1742209148257;
        Mon, 17 Mar 2025 03:59:08 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm14530404f8f.87.2025.03.17.03.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:59:07 -0700 (PDT)
Message-ID: <919b1fa9-3b95-4be1-a966-9f0cfc166756@linaro.org>
Date: Mon, 17 Mar 2025 10:59:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] coresight: Add a KUnit test for
 coresight_find_default_sink()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>
References: <20250312-james-cs-kunit-test-v4-1-ae3dd718a26a@linaro.org>
 <48b192c7-4250-4e11-8dcd-b147dd8c0a28@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <48b192c7-4250-4e11-8dcd-b147dd8c0a28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/03/2025 12:35 pm, Anshuman Khandual wrote:
> On 3/12/25 16:01, James Clark wrote:
>> Add a test to confirm that default sink selection skips over an ETF
>> and returns an ETR even if it's further away.
>>
>> This also makes it easier to add new unit tests in the future.
> 
> The test overall looks good but there are some comments below.
> 
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes in v4:
>> - Rename etm to src now that it's not CORESIGHT_DEV_SUBTYPE_SOURCE_PROC
>> - Remove the now empty src_ops too
>> - Fix a rebase mistake in the Makefile that removed CTCU
>> - Link to v3: https://lore.kernel.org/r/20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org
>>
>> Changes in v3:
>> - Use CORESIGHT_DEV_SUBTYPE_SOURCE_BUS type instead of the default
>>    (CORESIGHT_DEV_SUBTYPE_SOURCE_PROC) so that the test still works even
>>    when TRBE sinks are registered. This also removes the need for the
>>    fake CPU ID callback.
>> - Link to v2: https://lore.kernel.org/r/20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org
>>
>> Changes in v2:
>> - Let devm free everything rather than doing individual kfrees:
>>    "Like with managed drivers, KUnit-managed fake devices are
>>    automatically cleaned up when the test finishes, but can be manually
>>    cleaned up early with kunit_device_unregister()."
>> - Link to v1: https://lore.kernel.org/r/20250225164639.522741-1-james.clark@linaro.org
>> ---
>>   drivers/hwtracing/coresight/Kconfig                |  9 +++
>>   drivers/hwtracing/coresight/Makefile               |  1 +
>>   drivers/hwtracing/coresight/coresight-core.c       |  1 +
>>   .../hwtracing/coresight/coresight-kunit-tests.c    | 74 ++++++++++++++++++++++
>>   4 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index ecd7086a5b83..f064e3d172b3 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -259,4 +259,13 @@ config CORESIGHT_DUMMY
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-dummy.
>> +
>> +config CORESIGHT_KUNIT_TESTS
>> +	  tristate "Enable Coresight unit tests"
>> +	  depends on KUNIT
>> +	  default KUNIT_ALL_TESTS
>> +	  help
>> +	    Enable Coresight unit tests. Only useful for development and not
>> +	    intended for production.
> 
> The description sounds adequate given that more unit tests might be added later.
> 
>> +
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index 8e62c3150aeb..4e6ea5b05b01 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -53,3 +53,4 @@ obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>>   obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
>>   coresight-ctcu-y := coresight-ctcu-core.o
>> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index fb43ef6a3b1f..47af75ba7a00 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -959,6 +959,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
>>   	}
>>   	return csdev->def_sink;
>>   }
>> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
> 
> This symbol needs exporting given that the kunit test here can also be built
> as a module.
> 
>>   
>>   static int coresight_remove_sink_ref(struct device *dev, void *data)
>>   {
>> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
>> new file mode 100644
>> index 000000000000..c8f361767c45
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <kunit/test.h>
>> +#include <kunit/device.h>
>> +#include <linux/coresight.h>
>> +
>> +#include "coresight-priv.h"
>> +
>> +static struct coresight_device *coresight_test_device(struct device *dev)
>> +{
>> +	struct coresight_device *csdev = devm_kcalloc(dev, 1,
>> +						     sizeof(struct coresight_device),
>> +						     GFP_KERNEL);
>> +	csdev->pdata = devm_kcalloc(dev, 1,
>> +				   sizeof(struct coresight_platform_data),
>> +				   GFP_KERNEL);
> 
> Guess both these memory allocations gets freed up here automatically
> via kunit_device's device framework when the test suit exits ?
> 

Yes, see the change log in the cover letter.

>> +	return csdev;
>> +}
>> +
>> +static void test_default_sink(struct kunit *test)
>> +{
>> +	/*
>> +	 * Source -> ETF -> ETR -> CATU
>> +	 *                   ^
>> +	 *                   | default
>> +	 */
> 
> Should some more random path combinations involving ETR and ETF along with
> other coresight devices also be tested where ETR gets selected as default ?
> 

Probably, but I only added what was required to test Steve's original 
bug report. We can add more tests for coresight_find_default_sink() if 
when it gets changed or refactored in the future. At the moment without 
any changes in sight there wouldn't be any benefit.

>> +	struct device *dev = kunit_device_register(test, "coresight_kunit");
>> +	struct coresight_device *src = coresight_test_device(dev),
>> +				*etf = coresight_test_device(dev),
>> +				*etr = coresight_test_device(dev),
>> +				*catu = coresight_test_device(dev);
>> +	struct coresight_connection conn = {};
>> +
>> +	src->type = CORESIGHT_DEV_TYPE_SOURCE;
>> +	/*
>> +	 * Don't use CORESIGHT_DEV_SUBTYPE_SOURCE_PROC, that would always return
>> +	 * a TRBE sink if one is registered.
> 
> Probably this should be tested as well i.e when TRBE sink is also available
> and it gets picked up as a default.
> 

This is quite simple logic so it's probably even less of a valuable 
test. I only added a test for the other sinks because the recursive 
search for them is not easy code to follow by eye.


