Return-Path: <linux-kernel+bounces-546709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D4A4FDE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7071888B10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2A238142;
	Wed,  5 Mar 2025 11:42:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5272923372A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174940; cv=none; b=gXgSxONmmIHrC/V1WZ83jGmEeEdrxp0RqaE4a9fJ3vgcd8EyevzHPNDNH4PExHfIXtEkB5ZVQdpoV0nBurZI8a0PtSnxsh9BIuWCGQT82dkFg0lD5q+N32JkjGLpVom8zbYkzAR89bEHKGiWOoKsNMJq81xpU81DrymuK4rhRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174940; c=relaxed/simple;
	bh=K5Hpf0UTpdwiElP9raGvhYNDwuZakiODWqj9pfRuCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndCEyVhabR4yMUL1LSqI+ZgqyG5g8x5Cjs640PQdvrGHgJAOmCUViXaHR/2xvdD53c0cQsMf95l4+wImCwV/YxPFIwGc42IfLLLyufVEy/FXOGcPk5can0wrOzN/bPRvHAhqapsDhDBF2L/WY0cgZoIT3UEcfUflC2SzfGEsrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FE0FEC;
	Wed,  5 Mar 2025 03:42:29 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D36D3F673;
	Wed,  5 Mar 2025 03:42:15 -0800 (PST)
Date: Wed, 5 Mar 2025 11:42:11 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, scclevenger@os.amperecomputing.com,
	yeoreum.yun@arm.com, Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: Add a KUnit test for
 coresight_find_default_sink()
Message-ID: <20250305114211.GG13418@e132581.arm.com>
References: <20241217171132.834943-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217171132.834943-1-james.clark@linaro.org>

On Tue, Dec 17, 2024 at 05:11:31PM +0000, James Clark wrote:
> 
> Add a test to confirm that default sink selection skips over an ETF
> and returns an ETR even if it's further away.
> 
> This also makes it easier to add new unit tests in the future.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig           |  9 ++
>  drivers/hwtracing/coresight/Makefile          |  1 +
>  drivers/hwtracing/coresight/coresight-core.c  |  1 +
>  .../coresight/coresight-kunit-tests.c         | 90 +++++++++++++++++++
>  4 files changed, 101 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-kunit-tests.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 06f0a7594169..056d04bc540a 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -247,4 +247,13 @@ config CORESIGHT_DUMMY
> 
>           To compile this driver as a module, choose M here: the module will be
>           called coresight-dummy.
> +
> +config CORESIGHT_KUNIT_TESTS
> +         tristate "Enable Coresight unit tests"
> +         depends on KUNIT
> +         default KUNIT_ALL_TESTS
> +         help
> +           Enable Coresight unit tests. Only useful for development and not
> +           intended for production.
> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 4ba478211b31..c170a41b3056 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -51,3 +51,4 @@ coresight-cti-y := coresight-cti-core.o       coresight-cti-platform.o \
>                    coresight-cti-sysfs.o
>  obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>  obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> +obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index ea38ecf26fcb..ce63b68d5503 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -869,6 +869,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
>         }
>         return csdev->def_sink;
>  }
> +EXPORT_SYMBOL_GPL(coresight_find_default_sink);
> 
>  static int coresight_remove_sink_ref(struct device *dev, void *data)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> new file mode 100644
> index 000000000000..d022bacc8357
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
> @@ -0,0 +1,90 @@
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
> +       struct coresight_device *csdev = devm_kcalloc(dev, 1,
> +                                                    sizeof(struct coresight_device),
> +                                                    GFP_KERNEL);
> +       csdev->pdata = devm_kcalloc(dev, 1,
> +                                  sizeof(struct coresight_platform_data),
> +                                  GFP_KERNEL);
> +       return csdev;
> +}
> +
> +static void coresight_free_test_device(struct device *dev,
> +                                      struct coresight_device *csdev)
> +{
> +       devm_kfree(dev, csdev->pdata->out_conns);

It will lead memory leaking if we don't release connections pointed by
'out_conns' pointer array.  Something like:

          for (i = 0; i < csdev->pdata->nr_outconns; i++)
               devm_kfree(dev, csdev->pdata->out_conns[i]);
          devm_kfree(dev, csdev->pdata->out_conns);

Otherwise, it looks good to me.

Thanks,
Leo

> +       devm_kfree(dev, csdev->pdata);
> +       devm_kfree(dev, csdev);
> +}
> +
> +static int coresight_test_cpuid(struct coresight_device *csdev)
> +{
> +       return 0;
> +}
> +
> +static void test_default_sink(struct kunit *test)
> +{
> +       /*
> +        * ETM -> ETF -> ETR -> CATU
> +        *                ^
> +        *                | default
> +        */
> +       struct device *dev = kunit_device_register(test, "coresight_kunit");
> +       struct coresight_device *etm = coresight_test_device(dev),
> +                               *etf = coresight_test_device(dev),
> +                               *etr = coresight_test_device(dev),
> +                               *catu = coresight_test_device(dev);
> +       struct coresight_connection conn = {};
> +       struct coresight_ops_source src_ops = {.cpu_id = coresight_test_cpuid };
> +       struct coresight_ops etm_cs_ops = { .source_ops = &src_ops };
> +
> +       etm->type = CORESIGHT_DEV_TYPE_SOURCE;
> +       etm->ops = &etm_cs_ops;
> +       etf->type = CORESIGHT_DEV_TYPE_LINKSINK;
> +       etf->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> +       etr->type = CORESIGHT_DEV_TYPE_SINK;
> +       etr->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
> +       catu->type = CORESIGHT_DEV_TYPE_HELPER;
> +
> +       conn.src_dev = etm;
> +       conn.dest_dev = etf;
> +       coresight_add_out_conn(dev, etm->pdata, &conn);
> +
> +       conn.src_dev = etf;
> +       conn.dest_dev = etr;
> +       coresight_add_out_conn(dev, etf->pdata, &conn);
> +
> +       conn.src_dev = etr;
> +       conn.dest_dev = catu;
> +       coresight_add_out_conn(dev, etr->pdata, &conn);
> +
> +       KUNIT_ASSERT_PTR_EQ(test, coresight_find_default_sink(etm), etr);
> +
> +       coresight_free_test_device(dev, etm);
> +       coresight_free_test_device(dev, etf);
> +       coresight_free_test_device(dev, etr);
> +       coresight_free_test_device(dev, catu);
> +}
> +
> +static struct kunit_case coresight_testcases[] = {
> +       KUNIT_CASE(test_default_sink),
> +       {}
> +};
> +
> +static struct kunit_suite coresight_test_suite = {
> +       .name = "coresight_test_suite",
> +       .test_cases = coresight_testcases,
> +};
> +
> +kunit_test_suites(&coresight_test_suite);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("James Clark <james.clark@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight KUnit tests");
> --
> 2.34.1
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

