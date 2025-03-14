Return-Path: <linux-kernel+bounces-561416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A06A61175
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074DA3BCF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD711FDE3D;
	Fri, 14 Mar 2025 12:35:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC91FDA89
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955743; cv=none; b=saXK858EsqYHKHjDYRgLYYo2Q8yKJAwKlLe68XNbwx4r4GpCrNstclE/fCOPj/fLHJn7wSDrt9j7rpuqTOYN5AdPMerfrVTJQW0pkiHSXqwavimRLI7AdwFXDrMQak0qLz1qhfMx6aUL1fDaoBWVT0c/ml20POfKLQA1Q3sWje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955743; c=relaxed/simple;
	bh=NMTO657J4UIh5+/0d0sL51VHAlIUtDaFJeCLbfry3+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIaUtLEIUVx1hrAISS9mLPOs0w6P4KwM128dSPfsRdxtIzO/93i0wnqnc8zOc3lkF2v/H7FMwcOVSoZDQhpRvA9ogWIJ/z0omYzowxUd85AWg9ouePusNKCFVkO42UxxCltOM8fe+a0lr7BbmG/W+sUoM1pUqJtLrfzg58LdZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C831424;
	Fri, 14 Mar 2025 05:35:51 -0700 (PDT)
Received: from [10.163.40.244] (unknown [10.163.40.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A96EA3F5A1;
	Fri, 14 Mar 2025 05:35:38 -0700 (PDT)
Message-ID: <48b192c7-4250-4e11-8dcd-b147dd8c0a28@arm.com>
Date: Fri, 14 Mar 2025 18:05:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] coresight: Add a KUnit test for
 coresight_find_default_sink()
To: James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
References: <20250312-james-cs-kunit-test-v4-1-ae3dd718a26a@linaro.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250312-james-cs-kunit-test-v4-1-ae3dd718a26a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 16:01, James Clark wrote:
> Add a test to confirm that default sink selection skips over an ETF
> and returns an ETR even if it's further away.
> 
> This also makes it easier to add new unit tests in the future.

The test overall looks good but there are some comments below.

> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v4:
> - Rename etm to src now that it's not CORESIGHT_DEV_SUBTYPE_SOURCE_PROC
> - Remove the now empty src_ops too
> - Fix a rebase mistake in the Makefile that removed CTCU
> - Link to v3: https://lore.kernel.org/r/20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org
> 
> Changes in v3:
> - Use CORESIGHT_DEV_SUBTYPE_SOURCE_BUS type instead of the default
>   (CORESIGHT_DEV_SUBTYPE_SOURCE_PROC) so that the test still works even
>   when TRBE sinks are registered. This also removes the need for the
>   fake CPU ID callback.
> - Link to v2: https://lore.kernel.org/r/20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org
> 
> Changes in v2:
> - Let devm free everything rather than doing individual kfrees:
>   "Like with managed drivers, KUnit-managed fake devices are
>   automatically cleaned up when the test finishes, but can be manually
>   cleaned up early with kunit_device_unregister()."
> - Link to v1: https://lore.kernel.org/r/20250225164639.522741-1-james.clark@linaro.org
> ---
>  drivers/hwtracing/coresight/Kconfig                |  9 +++
>  drivers/hwtracing/coresight/Makefile               |  1 +
>  drivers/hwtracing/coresight/coresight-core.c       |  1 +
>  .../hwtracing/coresight/coresight-kunit-tests.c    | 74 ++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ecd7086a5b83..f064e3d172b3 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -259,4 +259,13 @@ config CORESIGHT_DUMMY
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called coresight-dummy.
> +
> +config CORESIGHT_KUNIT_TESTS
> +	  tristate "Enable Coresight unit tests"
> +	  depends on KUNIT
> +	  default KUNIT_ALL_TESTS
> +	  help
> +	    Enable Coresight unit tests. Only useful for development and not
> +	    intended for production.

The description sounds adequate given that more unit tests might be added later.

> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 8e62c3150aeb..4e6ea5b05b01 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>  obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>  obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
>  coresight-ctcu-y := coresight-ctcu-core.o
> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fb43ef6a3b1f..47af75ba7a00 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -959,6 +959,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
>  	}
>  	return csdev->def_sink;
>  }
> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);

This symbol needs exporting given that the kunit test here can also be built
as a module.

>  
>  static int coresight_remove_sink_ref(struct device *dev, void *data)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> new file mode 100644
> index 000000000000..c8f361767c45
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> @@ -0,0 +1,74 @@
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

Guess both these memory allocations gets freed up here automatically
via kunit_device's device framework when the test suit exits ?

> +	return csdev;
> +}
> +
> +static void test_default_sink(struct kunit *test)
> +{
> +	/*
> +	 * Source -> ETF -> ETR -> CATU
> +	 *                   ^
> +	 *                   | default
> +	 */

Should some more random path combinations involving ETR and ETF along with
other coresight devices also be tested where ETR gets selected as default ?

> +	struct device *dev = kunit_device_register(test, "coresight_kunit");
> +	struct coresight_device *src = coresight_test_device(dev),
> +				*etf = coresight_test_device(dev),
> +				*etr = coresight_test_device(dev),
> +				*catu = coresight_test_device(dev);
> +	struct coresight_connection conn = {};
> +
> +	src->type = CORESIGHT_DEV_TYPE_SOURCE;
> +	/*
> +	 * Don't use CORESIGHT_DEV_SUBTYPE_SOURCE_PROC, that would always return
> +	 * a TRBE sink if one is registered.

Probably this should be tested as well i.e when TRBE sink is also available
and it gets picked up as a default.

> +	 */
> +	src->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_BUS;
> +	etf->type = CORESIGHT_DEV_TYPE_LINKSINK;
> +	etf->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> +	etr->type = CORESIGHT_DEV_TYPE_SINK;
> +	etr->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
> +	catu->type = CORESIGHT_DEV_TYPE_HELPER;
> +
> +	conn.src_dev = src;
> +	conn.dest_dev = etf;
> +	coresight_add_out_conn(dev, src->pdata, &conn);
> +
> +	conn.src_dev = etf;
> +	conn.dest_dev = etr;
> +	coresight_add_out_conn(dev, etf->pdata, &conn);
> +
> +	conn.src_dev = etr;
> +	conn.dest_dev = catu;
> +	coresight_add_out_conn(dev, etr->pdata, &conn);
> +
> +	KUNIT_ASSERT_PTR_EQ(test, coresight_find_default_sink(src), etr);
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
> base-commit: 3eadce8308bc8d808fd9e3a9d211c84215087451
> change-id: 20250305-james-cs-kunit-test-3af1df2401e6
> 
> Best regards,

