Return-Path: <linux-kernel+bounces-398519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7769BF254
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641D62840E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8D20513D;
	Wed,  6 Nov 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyGwTmqn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F28204926
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908666; cv=none; b=J3DSpg5wYvvaHuAdCjfz5yboGU1N9RJ4XYD4Wvhe6Y3EUYLXmHx9pCf+Qwh8aKJlAl324NUugtV1d8yvOl8+zuPKE8D/9zXe2eX3oA2ANTMd+if9SzrmwZNyy+BEQLtUTwrgrONvi007gRzkb1XQ1/UkURPMMdRUCJSWTp0y3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908666; c=relaxed/simple;
	bh=/G7nzRpmsKRHkkHRP0eGu41M2dPPtFGVTc5sy7S9GmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkpWxBOigN3j89Gp0JNegI/oHeWhyLjcNsne2grEdoq0JT4wvAjLzJgRpl5nbeTz7m07VF3zTdkyRHJl/Yxmkwfpyadw4XaYlqoKQ0DYlcFScQYwW2layfJJ0gwbxp4oLs3LKUSiqfgSykQoWiIyvEgEgyOspkBaXub3RQ/k0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyGwTmqn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730908665; x=1762444665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/G7nzRpmsKRHkkHRP0eGu41M2dPPtFGVTc5sy7S9GmI=;
  b=nyGwTmqnSFvV60RTUmHeMEMizo3wOUhaBCpM/2y2//pH3klu3KCQcR3m
   LziDyR2QTpM1pf7j6kxVdZ4/ioYjAR7BbBW6uqWS+54pUE1a3TVQEj5K0
   ZphendqpJPEbRMPzycQ1/3r6jkRyYkpGFhMOhDsuDDbSz5eLoO+NmENSI
   9uCqnRNbdV72OVaagW1RIgekGnnxgulZcRqwCNfIwI5NqaPLCA3IHLhby
   2mldcnFtUxFvztJSbv6Og0GDQUUj5cCSGZOtxjfVwsjETffJ4jY9kQofk
   lt4khO9hn6YKYPlPnnVhyA+Bf24ydJ8tClCnYEmqeYIUEBtai2xCp1DgM
   w==;
X-CSE-ConnectionGUID: iznXNfSoRgeeuo0A76EuUw==
X-CSE-MsgGUID: jmmw1NlnR/a5h/k/PI/fSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41307181"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="41307181"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:57:44 -0800
X-CSE-ConnectionGUID: z0c1tEO+TS6vifwYi0IeSA==
X-CSE-MsgGUID: o0Z2mQ9ERUWJLGKEBPC4GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84961930"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:57:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8iPa-0000000ByUZ-0cgF;
	Wed, 06 Nov 2024 17:57:38 +0200
Date: Wed, 6 Nov 2024 17:57:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: gregkh@linuxfoundation.org, quic_jjohnson@quicinc.com,
	jinqian@android.com, jia-cheng.hu@intel.com,
	u.kleine-koenig@pengutronix.de, alan@linux.intel.com,
	linux-kernel@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: Re: [PATCH v2] goldfish: Fix unused const variable
 'goldfish_pipe_acpi_match'
Message-ID: <ZyuR8blW8IScgNl-@smile.fi.intel.com>
References: <20241026070150.3239819-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241026070150.3239819-1-zengheng4@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 03:01:50PM +0800, Zeng Heng wrote:
> Fix the following compilation warning:
> 
> drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
> ‘goldfish_pipe_acpi_match’ defined but not used
> [-Wunused-const-variable=]
>   925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
> 
> The complexity of config guards needed for ACPI_PTR() is not worthwhile
> for the small amount of saved data. So remove the use of ACPI_PTR instead
> and drop now unneeded linux/acpi.h include.

...

>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/mm.h>
> -#include <linux/acpi.h>

Because header inclusions are unsorted, it's unclear if there is
mod_devicetable.h included. If not, you should replace acpi.h with
mod_devicetable.h.

>  #include <linux/bug.h>
>  #include "goldfish_pipe_qemu.h"

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



