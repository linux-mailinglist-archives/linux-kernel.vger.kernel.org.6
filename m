Return-Path: <linux-kernel+bounces-374144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF739A65E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E621B25A02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1055A1E47BD;
	Mon, 21 Oct 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGO1hDlj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCB194A74;
	Mon, 21 Oct 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507868; cv=none; b=IJslDpo6bSOD6jiSJ+p9rPs6Z5G6rsIn2j7bhEuzobx+nnYNpa4CCE3N2Jg0m4GUsb7h6IxUe4BBSjMNiL9rEe+ettibRyRguniqoK5TDMeu84D2wnDXxtVqST8GCdqQ8WJTE7D2rbyIXlkUMH7WmrGH9q3GO5n5eE4FLkSuPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507868; c=relaxed/simple;
	bh=TgyolvhVwv8fitRtIMfKtIsfY4sjGZH8mmcZRwhWC7g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=So596hKoeYV7zRt7qtM0W+wxhrK6fx36KRCISgl3OW8cv5DWAkgdVr3UputifIwYUma4Sw8hs1RB3TAhFHJeZOfSo6apsCeu94GVeYYvJK+kpJDhcdK02oi/iFSWHI0k3gCnhYebpCG2QpAGbKBJ/BaHYvzFP5r2mx5YnVVzl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGO1hDlj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729507867; x=1761043867;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TgyolvhVwv8fitRtIMfKtIsfY4sjGZH8mmcZRwhWC7g=;
  b=eGO1hDlj6bm6MsfcwpErwoXfD3t8zMnhMewCWOJNr7xrh1Ys6uN6H45C
   /EpplVxUDx32ltLaVuFLU+VTrvs8dqyIiwbOiPOIbiGuj2tKPQ9wnxwGv
   IxO+5P7pyaiOL6F4UlLjOg1m+mWrUNU4rVeJvflkml+wYZxwf/nlQqLyd
   ruS8tlRs+Krf/lsdS/0XOJaiFP/m+x5qfsy3xYxT3t9yywrREAhnrUYci
   ZozVaF3ph8EEwr6VuvtThIIBr0dkNUF6FWGvR/UQoZGo5y4+0/CVBaK5F
   75xKjrxxJImAqIRiMX/TELkq4fT0G4zLiZYwy2OzcfkuDGdYtGqQbrYUX
   g==;
X-CSE-ConnectionGUID: Ln3rj/YARXCTi8cH6oey+w==
X-CSE-MsgGUID: oUttFyjSSsavbE/x213p+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32790428"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32790428"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:51:06 -0700
X-CSE-ConnectionGUID: EB+9RMxVTcWQCH2JOPb67g==
X-CSE-MsgGUID: MDcoQlByQiidbMDdefR8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79493665"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:51:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 13:51:01 +0300 (EEST)
To: Hongling Zeng <zenghongling@kylinos.cn>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    cascardo@holoscopio.com, Hans de Goede <hdegoede@redhat.com>, 
    zhongling0719@126.com
Subject: Re: [PATCH v1] platform/x86: classmate-laptop: Replace snprintf in
 show functions with sysfs_emit
In-Reply-To: <20241019054426.8182-1-zenghongling@kylinos.cn>
Message-ID: <b584bfe3-59bd-f79c-c540-ec3f29eb7841@linux.intel.com>
References: <20241019054426.8182-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 19 Oct 2024, Hongling Zeng wrote:

>   show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Hi,

I've applied this with modifications:

- I had to cleanup the extra spaces before show() in the text above which
  I had already earlier noted you should fix. :-(
- Added #include <linux/sysfs.h>

-- 
 i.

> ---
>  drivers/platform/x86/classmate-laptop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index cb6fce6..14c238f 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -208,7 +208,7 @@ static ssize_t cmpc_accel_sensitivity_show_v4(struct device *dev,
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	accel = dev_get_drvdata(&inputdev->dev);
>  
> -	return sprintf(buf, "%d\n", accel->sensitivity);
> +	return sysfs_emit(buf, "%d\n", accel->sensitivity);
>  }
>  
>  static ssize_t cmpc_accel_sensitivity_store_v4(struct device *dev,
> @@ -257,7 +257,7 @@ static ssize_t cmpc_accel_g_select_show_v4(struct device *dev,
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	accel = dev_get_drvdata(&inputdev->dev);
>  
> -	return sprintf(buf, "%d\n", accel->g_select);
> +	return sysfs_emit(buf, "%d\n", accel->g_select);
>  }
>  
>  static ssize_t cmpc_accel_g_select_store_v4(struct device *dev,
> @@ -550,7 +550,7 @@ static ssize_t cmpc_accel_sensitivity_show(struct device *dev,
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	accel = dev_get_drvdata(&inputdev->dev);
>  
> -	return sprintf(buf, "%d\n", accel->sensitivity);
> +	return sysfs_emit(buf, "%d\n", accel->sensitivity);
>  }
>  
>  static ssize_t cmpc_accel_sensitivity_store(struct device *dev,
> 


