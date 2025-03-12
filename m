Return-Path: <linux-kernel+bounces-557515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD92A5DA45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056313AACB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FC23DE80;
	Wed, 12 Mar 2025 10:14:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8691DC184
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774470; cv=none; b=hr8I3rWGdMCEQc/VjFb1M9bzCq5QuTS/obQspVdqQJZUcZNVIk/2JVMYUK47fvVW4MoZX2DuDmZU1fxXR3RJFa03MBBdrbGq2gm63aKooI+Q1nP3EOPBW7PxIOQBOdd9mUYqxu1Z3orsTvcbH9Iw9oNpwP6iSKXe8yOIu80dwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774470; c=relaxed/simple;
	bh=HFj/Mok25bjP9exvb6pDoIL9eZY5WC0sW3ff/Jqzavs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuN0bz24yVsBY0zx8L9vj9GgMLn+holhhUX1z8t5sGNz4XGzrlVOWWdj7JPZb3FLB1nGgIFrEhN9K+JO2LkuQUtjM3OpR1UpwVq2Wu0ATWLX2sbjjdfBwHdoDhrmLeSunhVfy3/JSg/J5moO/QqmL9HxU9oytl6Ft7ydPiYxZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE9E152B;
	Wed, 12 Mar 2025 03:14:39 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D933F5A1;
	Wed, 12 Mar 2025 03:14:27 -0700 (PDT)
Message-ID: <d6194071-bc52-4f67-a36e-fc8d9d1be94c@arm.com>
Date: Wed, 12 Mar 2025 10:14:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: Add a KUnit test for
 coresight_find_default_sink()
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
References: <20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James


On 12/03/2025 10:11, James Clark wrote:
> Add a test to confirm that default sink selection skips over an ETF
> and returns an ETR even if it's further away.
> 
> This also makes it easier to add new unit tests in the future.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v3:
> - Use CORESIGHT_DEV_SUBTYPE_SOURCE_BUS type instead of the default
>    (CORESIGHT_DEV_SUBTYPE_SOURCE_PROC) so that the test still works even
>    when TRBE sinks are registered. This also removes the need for the
>    fake CPU ID callback.
> - Link to v2: https://lore.kernel.org/r/20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org
> 
> Changes in v2:
> - Let devm free everything rather than doing individual kfrees:
>    "Like with managed drivers, KUnit-managed fake devices are
>    automatically cleaned up when the test finishes, but can be manually
>    cleaned up early with kunit_device_unregister()."
> - Link to v1: https://lore.kernel.org/r/20250225164639.522741-1-james.clark@linaro.org
> ---
>   drivers/hwtracing/coresight/Kconfig                |  9 +++
>   drivers/hwtracing/coresight/Makefile               |  3 +-
>   drivers/hwtracing/coresight/coresight-core.c       |  1 +
>   .../hwtracing/coresight/coresight-kunit-tests.c    | 77 ++++++++++++++++++++++
>   4 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ecd7086a5b83..f064e3d172b3 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -259,4 +259,13 @@ config CORESIGHT_DUMMY
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-dummy.
> +
> +config CORESIGHT_KUNIT_TESTS
> +	  tristate "Enable Coresight unit tests"
> +	  depends on KUNIT
> +	  default KUNIT_ALL_TESTS
> +	  help
> +	    Enable Coresight unit tests. Only useful for development and not
> +	    intended for production.
> +
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 8e62c3150aeb..96f0dfedb1bf 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -51,5 +51,4 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> -obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
> -coresight-ctcu-y := coresight-ctcu-core.o
> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index bd0a7edd38c9..b101aa133ceb 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -959,6 +959,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
>   	}
>   	return csdev->def_sink;
>   }
> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
>   
>   static int coresight_remove_sink_ref(struct device *dev, void *data)
>   {
> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> new file mode 100644
> index 000000000000..87439769207c
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test.h>
> +#include <kunit/device.h>
> +#include <linux/coresight.h>
> +
> +#include "coresight-priv.h"
> +
> +static struct coresight_device *coresight_test_device(struct device *dev)
> +{
> +	struct coresight_device *csdev = devm_kcalloc(dev, 1,
> +						     sizeof(struct coresight_device),
> +						     GFP_KERNEL);
> +	csdev->pdata = devm_kcalloc(dev, 1,
> +				   sizeof(struct coresight_platform_data),
> +				   GFP_KERNEL);
> +	return csdev;
> +}
> +
> +static void test_default_sink(struct kunit *test)
> +{
> +	/*
> +	 * ETM -> ETF -> ETR -> CATU
> +	 *                ^
> +	 *                | default

minor nit: Using ETM here is going to be confusing, with the SUBTYPE we
are using. Please could we rename it something else and also rename the 
variable "etm" ? Say, "source" ?

Rest looks good to me.

Suzuki


> +	 */
> +	struct device *dev = kunit_device_register(test, "coresight_kunit");
> +	struct coresight_device *etm = coresight_test_device(dev),
> +				*etf = coresight_test_device(dev),
> +				*etr = coresight_test_device(dev),
> +				*catu = coresight_test_device(dev);
> +	struct coresight_connection conn = {};
> +	struct coresight_ops_source src_ops = {};
> +	struct coresight_ops etm_cs_ops = { .source_ops	= &src_ops };
> +
> +	etm->type = CORESIGHT_DEV_TYPE_SOURCE;
> +	/*
> +	 * Don't use CORESIGHT_DEV_SUBTYPE_SOURCE_PROC, that would always return
> +	 * a TRBE sink if one is registered.
> +	 */
> +	etm->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_BUS;
> +	etm->ops = &etm_cs_ops;
> +	etf->type = CORESIGHT_DEV_TYPE_LINKSINK;
> +	etf->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> +	etr->type = CORESIGHT_DEV_TYPE_SINK;
> +	etr->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
> +	catu->type = CORESIGHT_DEV_TYPE_HELPER;
> +
> +	conn.src_dev = etm;
> +	conn.dest_dev = etf;
> +	coresight_add_out_conn(dev, etm->pdata, &conn);
> +
> +	conn.src_dev = etf;
> +	conn.dest_dev = etr;
> +	coresight_add_out_conn(dev, etf->pdata, &conn);
> +
> +	conn.src_dev = etr;
> +	conn.dest_dev = catu;
> +	coresight_add_out_conn(dev, etr->pdata, &conn);
> +
> +	KUNIT_ASSERT_PTR_EQ(test, coresight_find_default_sink(etm), etr);
> +}
> +
> +static struct kunit_case coresight_testcases[] = {
> +	KUNIT_CASE(test_default_sink),
> +	{}
> +};
> +
> +static struct kunit_suite coresight_test_suite = {
> +	.name = "coresight_test_suite",
> +	.test_cases = coresight_testcases,
> +};
> +
> +kunit_test_suites(&coresight_test_suite);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("James Clark <james.clark@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight KUnit tests");
> 
> ---
> base-commit: eeafe6a8790ea125252ca2e23c1a2469eaff1d9a
> change-id: 20250305-james-cs-kunit-test-3af1df2401e6
> 
> Best regards,


