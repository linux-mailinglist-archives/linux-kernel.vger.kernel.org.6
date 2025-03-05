Return-Path: <linux-kernel+bounces-547137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB43A50353
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62227A6F90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A924EF74;
	Wed,  5 Mar 2025 15:20:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2524E005
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188018; cv=none; b=ZWek0ZJpdfI9SYi1oIbfVkC2QrvX3pQWkRmibghBvJ/LjO+f1LddAt0yOXs+7ZJS1zL3YQMgpmB8ebTyO4gKrfAzQmoW1k5OKLZws3xJoWisKK8TqOiHAU8aCYounMf3A1FSQjN4gcUBNfLvAOmCmTM+s7fOnPgas49rxrGrT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188018; c=relaxed/simple;
	bh=fkE57f6jwWdplqc4O/wQERskiE21bEGUDUnWXab1FEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC6p4ibfV5rrb3ZKIT00AinN1D1bRMZ64Sj1MylWO1BZ5x3RsX1gvr18g//ydXxmum7Jjqzd5jUvnxIjgGk6kRJDEMDeozhE0evFFQZ02VOC9gDxQSqsqrXW5MLcTJjv/77BHVrZD3ZIi8d1fflSrzUcK+cd26ZbWFgdi8QDhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39BFFFEC;
	Wed,  5 Mar 2025 07:20:28 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852853F673;
	Wed,  5 Mar 2025 07:20:14 -0800 (PST)
Date: Wed, 5 Mar 2025 15:20:09 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] coresight: Add a KUnit test for
 coresight_find_default_sink()
Message-ID: <20250305152009.GH13418@e132581.arm.com>
References: <20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org>

On Wed, Mar 05, 2025 at 03:07:19PM +0000, James Clark wrote:
> Add a test to confirm that default sink selection skips over an ETF
> and returns an ETR even if it's further away.
> 
> This also makes it easier to add new unit tests in the future.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
> Changes in v2:
> - Let devm free everything rather than doing individual kfrees:
>   "Like with managed drivers, KUnit-managed fake devices are
>   automatically cleaned up when the test finishes, but can be manually
>   cleaned up early with kunit_device_unregister()."
> - Link to v1: https://lore.kernel.org/r/20250225164639.522741-1-james.clark@linaro.org
> ---
>  drivers/hwtracing/coresight/Kconfig                |  9 +++
>  drivers/hwtracing/coresight/Makefile               |  3 +-
>  drivers/hwtracing/coresight/coresight-core.c       |  1 +
>  .../hwtracing/coresight/coresight-kunit-tests.c    | 77 ++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 2 deletions(-)
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
> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 8e62c3150aeb..96f0dfedb1bf 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -51,5 +51,4 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>  		   coresight-cti-sysfs.o
>  obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>  obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> -obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
> -coresight-ctcu-y := coresight-ctcu-core.o
> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index bd0a7edd38c9..b101aa133ceb 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -959,6 +959,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
>  	}
>  	return csdev->def_sink;
>  }
> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
>  
>  static int coresight_remove_sink_ref(struct device *dev, void *data)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> new file mode 100644
> index 000000000000..a136af05eaf4
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
> +static int coresight_test_cpuid(struct coresight_device *csdev)
> +{
> +	return 0;
> +}
> +
> +static void test_default_sink(struct kunit *test)
> +{
> +	/*
> +	 * ETM -> ETF -> ETR -> CATU
> +	 *                ^
> +	 *                | default
> +	 */
> +	struct device *dev = kunit_device_register(test, "coresight_kunit");
> +	struct coresight_device *etm = coresight_test_device(dev),
> +				*etf = coresight_test_device(dev),
> +				*etr = coresight_test_device(dev),
> +				*catu = coresight_test_device(dev);
> +	struct coresight_connection conn = {};
> +	struct coresight_ops_source src_ops = {.cpu_id = coresight_test_cpuid };
> +	struct coresight_ops etm_cs_ops = { .source_ops	= &src_ops };
> +
> +	etm->type = CORESIGHT_DEV_TYPE_SOURCE;
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
> -- 
> James Clark <james.clark@linaro.org>
> 

