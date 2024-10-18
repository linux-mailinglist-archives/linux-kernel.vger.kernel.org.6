Return-Path: <linux-kernel+bounces-371249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC49A3893
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C72281F35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111218E742;
	Fri, 18 Oct 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCiiF7vM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE7183CA9;
	Fri, 18 Oct 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240361; cv=none; b=K0x0XaXcqEWnWhXpAGwyUAlaEE6DMv+irAWcofqLtcQWqTwJkiGD8neU75hVvlQRi2keaJ9uYErY8RaqHgkk8imJjMKr8BUyVIrvC4VdqSG3ih8pYRixd6OwcXUD11nHlTefkzOMXez7MKTNvEHFZcIS6u1hBG/5iFZp+F69qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240361; c=relaxed/simple;
	bh=zAFwoIA3GXjx+22x5jVh9znKGpgtsZNIXDFzUEQUaQs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dx8yx7T0nJ1CHtkdMFcUJNaK5kX6MuzvEMg8DZl8a+C3qkXOeQYCTv91iNT2ZVtaTHQT7uRcWYWSB7986CZ62yJsYHMRUBSprmsOCiY3AAnBRp870N8XcZDoerjJ6YxmuHf+qD+f868nhOzkMc8RGQQLx4BED5aVKVZWXTjjU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCiiF7vM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729240359; x=1760776359;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zAFwoIA3GXjx+22x5jVh9znKGpgtsZNIXDFzUEQUaQs=;
  b=QCiiF7vM00LYlUfQTvAiQVmbCrmRJZS5bQ6C58WCTGkschaUyur6/Wcv
   d6b7YO7WzqDYIZCaZiNNVt7ssPhTSJzC8r1FqREcu3nuuMsugQPoWTzHv
   vFIASsvY9vsKDRyiRvR2rmMgrest/eVc18AZEoIYO+jRWfdVG3tUaeVnE
   o9nUAt55qjrJiEjlK3nm3sxU1tXyZQSnev4cAjcQWiatjgvMY/uuLAAvr
   /L/YH+syM2v0SP8zY6yy9J9C37dL7AohVkq1ru0K49paHqLfboUcs/AuY
   iJ/ZIt/9um6lfcfMe3kIrrU05T8MYZgQE4VkH2f5o8nLJcxaQhkVJKbz4
   w==;
X-CSE-ConnectionGUID: r4HRh7gfTFmvK2XHtHshxw==
X-CSE-MsgGUID: IPxKnCVaRYKsLaKkS7VlDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46218915"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46218915"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:32:38 -0700
X-CSE-ConnectionGUID: lgT5oHjdQquyFZs4yxYOig==
X-CSE-MsgGUID: cTAoJ9n/Rtuoo+qSFvXxYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="83447065"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:32:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 11:32:32 +0300 (EEST)
To: zenghongling <zenghongling@kylinos.cn>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    cascardo@holoscopio.com, Hans de Goede <hdegoede@redhat.com>, 
    zhongling0719@126.com
Subject: Re: [PATH] platform/x86: classmate-laptop: Replace snprintf in show
 functions with sysfs_emit
In-Reply-To: <20241018072217.97909-1-zenghongling@kylinos.cn>
Message-ID: <23436525-d90d-d08b-fbce-872d633d52d5@linux.intel.com>
References: <20241018072217.97909-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Oct 2024, zenghongling wrote:

>   show() must not use snprintf() when formatting the value to be

Extra spaces.

> returned to user space.
> 
> Signed-off-by: zenghongling <zenghongling@kylinos.cn>

Could you please add spaces and the usual capitalization to your name 
(both into the Signed-off-by and From).

It is possible to use git config to set up your user.name to get the name 
formatting to stick.

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

-- 
 i.


