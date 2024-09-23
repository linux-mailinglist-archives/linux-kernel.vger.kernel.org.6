Return-Path: <linux-kernel+bounces-335353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9097E485
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C0A1C20F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACC31361;
	Mon, 23 Sep 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdkR87Hp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7661C27
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054141; cv=none; b=cRPpnc0A80CXk9weFjYBGhco1Ip1+00BFYZUJKe7LNC0tN40C7ZjlfC5pOCzhiQLY9xpbBP/W+gpr3lkvfW8QHgu5qSXgchvY2/CaT5CcfCI00vKeA0WTRejdzeRQSus6nWCwoErVy0NOsMYYVdWugMoJ8yxKT2Mq2R074HIuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054141; c=relaxed/simple;
	bh=XtrWLrGEzNEKqPnr72xHFgHWMRUCTXXxS55VET45zuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReqoIoQuHYbucDxThJCuDudr0bP9MLd/ZYWXw0rJzLqYMX2sXENH3pnizuYxrPFu5Z9iAM50h4l3U0Upcbe0+icUTEwVpFhKOFJKiejSwZFEWBiTlAGjYF3FrFECG5XlJdR31IiEO18b0FuF2dNQVMqnHDd79NP2aQE6tKCNW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdkR87Hp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727054140; x=1758590140;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XtrWLrGEzNEKqPnr72xHFgHWMRUCTXXxS55VET45zuM=;
  b=VdkR87Hpm0+cHoTfUWpCYIW5737jnAZdWA+Sa3Lc7uuJPqZo94vpl+Xy
   fes0ak1y21NbczXV9oqe7uyUz/5VLdUv7KF4ZG6v8d+oZmvywz3bGSIJQ
   grHaLszX5+B/oaiLMVSvhqgAxk32fEmW8135/dyYg1/53O7Kc3RhLwBPi
   hmkROK7urUs/oJFmmWlO+GFnKinizAHxcTrIiltny4T+rbX7ClY4E5wsX
   pc1oM9HKHvWr4cNISfaCalK9ZvZVvAxrXol9rb+F8XJ0W3fbBSznO5giB
   xXvbVjmrZHg2NYqtwPvnlJbKjTKgQZdggcPGIChfPcprOM+cDck5YOXal
   Q==;
X-CSE-ConnectionGUID: h9/UhuewS0WOsO3VfKJqtg==
X-CSE-MsgGUID: MLy3wF1MR5Gx5OTE29+6Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29775244"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="29775244"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 18:15:29 -0700
X-CSE-ConnectionGUID: h6xh7cSvRYyQ48f6NYt5Aw==
X-CSE-MsgGUID: ocLcRsgNT9aDt4tpytGmrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71226184"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 18:15:28 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>, "Naresh
 Kamboju" <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
In-Reply-To: <20240922225041.603186-1-linux@roeck-us.net> (Guenter Roeck's
	message of "Sun, 22 Sep 2024 15:50:41 -0700")
References: <20240922225041.603186-1-linux@roeck-us.net>
Date: Mon, 23 Sep 2024 09:11:54 +0800
Message-ID: <8734lruqat.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Guenter Roeck <linux@roeck-us.net> writes:

> Building allmodconfig images on systems with SPARSEMEM=n results in
> the following message.
>
> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>   Depends on [n]: SPARSEMEM [=n]
>   Selected by [m]:
>   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
>
> and the build ultimately fails.
>
> GET_FREE_REGION depends on SPARSEMEM, so any configuration selecting it
> also depends on SPARSEMEM. Add the missing dependency.
>
> Effectively that means that RESOURCE_KUNIT_TEST is now restricted to
> systems with SPARSEMEM=y, but that can not be helped.
>
> Fixes: 99185c10d5d9 ("resource, kunit: add test case for region_intersects()")
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks for fixing.  It's better to fix this via remove dependency of
SPARSEMEM from GET_FREE_REGION.  However, we need to sort out some merge
conflict before that.  So, I think this patch is good as a quick fix.

Acked-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index bc8faa4509e1..52184c51b6dc 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2635,7 +2635,7 @@ config HASH_KUNIT_TEST
>  
>  config RESOURCE_KUNIT_TEST
>  	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
> -	depends on KUNIT
> +	depends on KUNIT && SPARSEMEM
>  	default KUNIT_ALL_TESTS
>  	select GET_FREE_REGION
>  	help

