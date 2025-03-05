Return-Path: <linux-kernel+bounces-546952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57682A50119
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871C63AB98C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16356241115;
	Wed,  5 Mar 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq29/xTW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E6D1D540
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182772; cv=none; b=SdP4hLgg7DnROLDm3Cvwg7TPam+K5pGaxfdWUoa1adUTPn4MSVKdJODDFnwlMeRB4OFb9ycY8X1syclhgWLHky5kFCyk3zEhJfp8nZ3r0FLdlrZccz3cm76W9GTTHsAibY/Nw3EfhF+euSuoO7K6HprbLRi8R9r0iL57CFbgE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182772; c=relaxed/simple;
	bh=ZpJyRqvzV7w2VCR5R7CDaKrnoXiO/aMQpyH7eigEDqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRoxTDD4HWG64JB+9tJJLwheyT2dPKzVcn+fPy6vtGjjtsT4Qe29et501JcadzTCM0eUWv+/AW9u+NCW3kjfY/SyNvU5Sm7l/ihYEEXOXs0UpB0fVqQ5hzk1/Z3cp+EMuF1msWlMUFRBBZbLuC39fGmv5K87KA88m2yexbxyEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wq29/xTW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso21364105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741182768; x=1741787568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6j1u5Jf2C5SefjcHLkuoR9oF+Ietx4rrZSc7vUCYjk=;
        b=Wq29/xTWIlNyIy5EsSDCtKXEtpIKYIuHDaa6LxYzelj5IVSsRW5JFuQ901kOxZF4fv
         6fTF9+FSaC2LALC8+7I/cQAQxoDU4XVKcjYQ/K0knrnMS74RQ1CwGTmWcd9/nGE+KBIZ
         YhdYzCxMb+kUswq+QwP0X++4CakGHzyQVI3Li2Yk5lgCa+GS4EaRwk+axkDxMDS7/JTa
         ddqB4MzC3HEGiF99nyw4W5fgGGHNCia1bl+tgVrBe5fyLppfOydQlnqQcXI+TvsP1s2A
         jm2GBdK/JNDaZwc2LytD1DNyGQ2VnRSzLlUn9LkctLr3ajv+4kO1rOPkpXVt3rDWYcN/
         zxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182768; x=1741787568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6j1u5Jf2C5SefjcHLkuoR9oF+Ietx4rrZSc7vUCYjk=;
        b=s+OQU9L1/gKs6dOnaOjamvN11w9YBAFpiy/BZ0seJnmlmPDdPJKJYm+rMVaknqWl8E
         JR7z5NcecEgZw7eGQw64VgXOqRv9oaHCWXLSr8MYundHNz8O0IfCOpnatuvXWHiwZfRq
         lRGHmtmowL+5IEOzqhJQ7pD3BTukGziDtvYJ05F/tKUTs9E4LEgrLbStIvzsFeUy3Pgq
         zTpFi2eMu8kNdM4d4gGJcHQIEMuy+SK1+8+S/pgQ4IO8PBqULO+dhC+JDh+/IYtsQksZ
         8O/S4RQBuP1lNfAdEtJM6wiDRqyWmPqMOKp8HbvgxHwsC3y27EyJXZNQyR9LkgVHxL6b
         xfbw==
X-Forwarded-Encrypted: i=1; AJvYcCWhkIadjKg/0o/u9OVcUOPHeSh4khCU1Eq8T5mUw2mfu3iwtzZJF/qA+S57ucGJwL8hK/vvtVbCDufbQWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKtdMm1S1L2t/81pIJ8go6BaR5o+JzKwfwvryg92t6lz0Am0i
	RbV1Soz5htxnWtg6O9ytIJ+aTg135gpQ7OYUapm6cziV6+TfeOfSX0H+g3uIlFU=
X-Gm-Gg: ASbGncuCDObtVqFLDGylUE4Y1dUEEftTvWK3n8OmzqWGso5m0Dj7XTAiIm/TRc/6xB5
	z6dwfuqJbwGDxFci+KDggGVgld7512lcwSX6Zq4ZRR+HWsQvKO4eF/q3xX7JFaBWCtXiWj6U38O
	U65gDqEnd3QlM8eyBtmW/JYks/6G7ArmiGkX0NgLPRLQsgJOmdPgJTmoUSYS/DnmyRGqdjiIt5w
	4PHDql0CNqV9Qmp8DekA3PJsFEPi7weno3ax8uICn84jBj0PGVI4gfWHChJSN1jk7mqBEclt/2Z
	UsOgfyYp99nYzKr0x4DlC97r+KOytv/mB5X3YSpWXH9IpM0CWfhfEC0=
X-Google-Smtp-Source: AGHT+IGNwGXre2668VQaI30m9O+IxSUr+emK+omtD1NUQBDyo+CUvESLBwBEmYF+kbGkg+9EZo3PhQ==
X-Received: by 2002:a5d:6d0d:0:b0:390:de66:cc0c with SMTP id ffacd0b85a97d-3911f7c750fmr2590694f8f.46.1741182768584;
        Wed, 05 Mar 2025 05:52:48 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ceesm20813720f8f.45.2025.03.05.05.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:52:48 -0800 (PST)
Message-ID: <67c484d7-6929-4a65-b89c-f3fb85682028@linaro.org>
Date: Wed, 5 Mar 2025 13:52:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Add a KUnit test for
 coresight_find_default_sink()
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, scclevenger@os.amperecomputing.com,
 yeoreum.yun@arm.com, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241217171132.834943-1-james.clark@linaro.org>
 <20250305114211.GG13418@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250305114211.GG13418@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 11:42 am, Leo Yan wrote:
> On Tue, Dec 17, 2024 at 05:11:31PM +0000, James Clark wrote:
>>
>> Add a test to confirm that default sink selection skips over an ETF
>> and returns an ETR even if it's further away.
>>
>> This also makes it easier to add new unit tests in the future.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/Kconfig           |  9 ++
>>   drivers/hwtracing/coresight/Makefile          |  1 +
>>   drivers/hwtracing/coresight/coresight-core.c  |  1 +
>>   .../coresight/coresight-kunit-tests.c         | 90 +++++++++++++++++++
>>   4 files changed, 101 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-kunit-tests.c
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 06f0a7594169..056d04bc540a 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -247,4 +247,13 @@ config CORESIGHT_DUMMY
>>
>>            To compile this driver as a module, choose M here: the module will be
>>            called coresight-dummy.
>> +
>> +config CORESIGHT_KUNIT_TESTS
>> +         tristate "Enable Coresight unit tests"
>> +         depends on KUNIT
>> +         default KUNIT_ALL_TESTS
>> +         help
>> +           Enable Coresight unit tests. Only useful for development and not
>> +           intended for production.
>> +
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index 4ba478211b31..c170a41b3056 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -51,3 +51,4 @@ coresight-cti-y := coresight-cti-core.o       coresight-cti-platform.o \
>>                     coresight-cti-sysfs.o
>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index ea38ecf26fcb..ce63b68d5503 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -869,6 +869,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
>>          }
>>          return csdev->def_sink;
>>   }
>> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
>>
>>   static int coresight_remove_sink_ref(struct device *dev, void *data)
>>   {
>> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
>> new file mode 100644
>> index 000000000000..d022bacc8357
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
>> @@ -0,0 +1,90 @@
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
>> +       struct coresight_device *csdev = devm_kcalloc(dev, 1,
>> +                                                    sizeof(struct coresight_device),
>> +                                                    GFP_KERNEL);
>> +       csdev->pdata = devm_kcalloc(dev, 1,
>> +                                  sizeof(struct coresight_platform_data),
>> +                                  GFP_KERNEL);
>> +       return csdev;
>> +}
>> +
>> +static void coresight_free_test_device(struct device *dev,
>> +                                      struct coresight_device *csdev)
>> +{
>> +       devm_kfree(dev, csdev->pdata->out_conns);
> 
> It will lead memory leaking if we don't release connections pointed by
> 'out_conns' pointer array.  Something like:
> 
>            for (i = 0; i < csdev->pdata->nr_outconns; i++)
>                 devm_kfree(dev, csdev->pdata->out_conns[i]);
>            devm_kfree(dev, csdev->pdata->out_conns);
> 
> Otherwise, it looks good to me.
> 
> Thanks,
> Leo
> 

Ah yeah, I'll just free the whole device instead of the individual 
kfrees then and let devm handle it.


