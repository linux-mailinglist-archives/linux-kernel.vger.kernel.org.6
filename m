Return-Path: <linux-kernel+bounces-556525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873A0A5CB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A8188DD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFEB25FA3B;
	Tue, 11 Mar 2025 16:48:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1119E975
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711723; cv=none; b=DeGpOgQzYTFxi5fnLP8tZnsmdLoMHBjE2Tc6XVvLTFa3CJGqFPeF5qrL+jE84QrdXNZU6dQTn6XiApaNMTrw1svp7aO1GxVEzBGBg9ukv8K4Oy6FM59VwQva6IFxHxqNTPWcjGwXmbwp6JpEOaBP9zKsxLv4f4XaOaB/OoqBYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711723; c=relaxed/simple;
	bh=lrsYFyN5cyDzQN9b2siw60UJaH8NKK/eMwzXKsXix6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7ElAN15J1gC8ykKPVfdjSFmrZ9fa+Ul/nqKgyAiSPNTi7Jf22NtD+QsnaCcrBO8l9D+UQyidFZ2yOthLc4OlJ2DLkFhcXRm9lM6T0ZPAvP5aWnc2VWsYEhJMQ8fBgLfqV/d9ZQPmoDXn05y9vzZjuoPJS77XSAMbBuqqlnpRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564BB152B;
	Tue, 11 Mar 2025 09:48:51 -0700 (PDT)
Received: from [10.57.40.127] (unknown [10.57.40.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02C043F673;
	Tue, 11 Mar 2025 09:48:38 -0700 (PDT)
Message-ID: <3f6dcb62-f9ba-4bed-9863-2d4569bafcf1@arm.com>
Date: Tue, 11 Mar 2025 16:48:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: Add a KUnit test for
 coresight_find_default_sink()
Content-Language: en-GB
To: James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>
References: <20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org>
 <c31de6cb-f8f5-432c-b99e-68b10a24bc5e@arm.com>
 <16fd2023-1ffa-4e87-ad89-a7ccdd8ba458@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <16fd2023-1ffa-4e87-ad89-a7ccdd8ba458@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/2025 16:06, James Clark wrote:
> 
> 
> On 11/03/2025 3:00 pm, Suzuki K Poulose wrote:
>> On 05/03/2025 15:07, James Clark wrote:
>>> Add a test to confirm that default sink selection skips over an ETF
>>> and returns an ETR even if it's further away.
>>>
>>> This also makes it easier to add new unit tests in the future.
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>> Changes in v2:
>>> - Let devm free everything rather than doing individual kfrees:
>>>    "Like with managed drivers, KUnit-managed fake devices are
>>>    automatically cleaned up when the test finishes, but can be manually
>>>    cleaned up early with kunit_device_unregister()."
>>> - Link to v1: https://lore.kernel.org/r/20250225164639.522741-1- 
>>> james.clark@linaro.org
>>> ---
>>>   drivers/hwtracing/coresight/Kconfig                |  9 +++
>>>   drivers/hwtracing/coresight/Makefile               |  3 +-
>>>   drivers/hwtracing/coresight/coresight-core.c       |  1 +
>>>   .../hwtracing/coresight/coresight-kunit-tests.c    | 77 +++++++++++ 
>>> + ++++++++++
>>>   4 files changed, 88 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/ 
>>> coresight/Kconfig
>>> index ecd7086a5b83..f064e3d172b3 100644
>>> --- a/drivers/hwtracing/coresight/Kconfig
>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>> @@ -259,4 +259,13 @@ config CORESIGHT_DUMMY
>>>         To compile this driver as a module, choose M here: the module 
>>> will be
>>>         called coresight-dummy.
>>> +
>>> +config CORESIGHT_KUNIT_TESTS
>>> +      tristate "Enable Coresight unit tests"
>>> +      depends on KUNIT
>>> +      default KUNIT_ALL_TESTS
>>> +      help
>>> +        Enable Coresight unit tests. Only useful for development and 
>>> not
>>> +        intended for production.
>>> +
>>>   endif
>>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/ 
>>> hwtracing/ coresight/Makefile
>>> index 8e62c3150aeb..96f0dfedb1bf 100644
>>> --- a/drivers/hwtracing/coresight/Makefile
>>> +++ b/drivers/hwtracing/coresight/Makefile
>>> @@ -51,5 +51,4 @@ coresight-cti-y := coresight-cti-core.o coresight- 
>>> cti-platform.o \
>>>              coresight-cti-sysfs.o
>>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>>> -obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
>>> -coresight-ctcu-y := coresight-ctcu-core.o
>>> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>>> hwtracing/coresight/coresight-core.c
>>> index bd0a7edd38c9..b101aa133ceb 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -959,6 +959,7 @@ coresight_find_default_sink(struct 
>>> coresight_device *csdev)
>>>       }
>>>       return csdev->def_sink;
>>>   }
>>> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
>>>   static int coresight_remove_sink_ref(struct device *dev, void *data)
>>>   {
>>> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/ 
>>> drivers/hwtracing/coresight/coresight-kunit-tests.c
>>> new file mode 100644
>>> index 000000000000..a136af05eaf4
>>> --- /dev/null
>>> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
>>> @@ -0,0 +1,77 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <kunit/test.h>
>>> +#include <kunit/device.h>
>>> +#include <linux/coresight.h>
>>> +
>>> +#include "coresight-priv.h"
>>> +
>>> +static struct coresight_device *coresight_test_device(struct device 
>>> *dev)
>>> +{
>>> +    struct coresight_device *csdev = devm_kcalloc(dev, 1,
>>> +                             sizeof(struct coresight_device),
>>> +                             GFP_KERNEL);
>>> +    csdev->pdata = devm_kcalloc(dev, 1,
>>> +                   sizeof(struct coresight_platform_data),
>>> +                   GFP_KERNEL);
>>> +    return csdev;
>>> +}
>>> +
>>> +static int coresight_test_cpuid(struct coresight_device *csdev)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static void test_default_sink(struct kunit *test)
>>> +{
>>> +    /*
>>> +     * ETM -> ETF -> ETR -> CATU
>>> +     *                ^
>>> +     *                | default
>>> +     */
>>> +    struct device *dev = kunit_device_register(test, 
>>> "coresight_kunit");
>>> +    struct coresight_device *etm = coresight_test_device(dev),
>>> +                *etf = coresight_test_device(dev),
>>> +                *etr = coresight_test_device(dev),
>>> +                *catu = coresight_test_device(dev);
>>> +    struct coresight_connection conn = {};
>>> +    struct coresight_ops_source src_ops = {.cpu_id = 
>>> coresight_test_cpuid };
>>
>> Do we need the trace_id() ? Why is this required ?
>>
>> Suzuki
>>
> 
> Because it tests with per-cpu sources so it checks if any of the TRBE 
> sinks have been assigned first:
> 
>   /* look for a default sink if we have not found for this device */
>     if (!csdev->def_sink) {
>        if (coresight_is_percpu_source(csdev))
>       csdev->def_sink = per_cpu(csdev_sink,
>                                     source_ops(csdev)->cpu_id(csdev));
> 
> I think this test would probably fail if run somewhere TRBE was already 
> probed. I can make the source subtype to be 
> CORESIGHT_DEV_SUBTYPE_SOURCE_BUS for the test to work around it. Any 
> value other than CORESIGHT_DEV_SUBTYPE_SOURCE_PROC will work. And then I 
> can drop the fake cpu_id() callback.

If the purpose is to detect the ETR, then I guess we could make this a 
non-ETM source

TBH, I don't see any value in the test as such. But it is a good 
starting point for adding further cases. So, lets keep this in.

Suzuki

> 


