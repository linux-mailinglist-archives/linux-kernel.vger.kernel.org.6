Return-Path: <linux-kernel+bounces-376254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F59AA237
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7111C21A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769819D098;
	Tue, 22 Oct 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfZr6ZAC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28645945
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600683; cv=none; b=KCJ9jQDRehIrJWPRqjfvPKGq07K6zkJoVPpP+BHhLpVRU54TzfezFKys6MCsFtuvUw736eKWirytIcLvZL4V1fvpBb/R43WaVK2OPpVguuygfVc+iVJi4VqogSXzE68L6dmjykGmFqgSaYVR0r7iktTfSlwR6k1/Qo/j8H4CN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600683; c=relaxed/simple;
	bh=80p6TRDDaANp9oY3sQKNQll+cOAp0yaPI45072gADSY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AZBKYr6tvb1HnBNG1B6D0Wff9jnPH5fUoX0EcUSk2teQo31OvuYwYc8z2g6ZYIvCSCRMAxjbffspJjnpB8NjgejWFza6Gz4xTl/AvddceNhzMx2ey9C8xFn7DO5wDiEjBHAmEB7xH/qt9j8Sx2ztaQAUZIuvEdDi3Iuxzvd3MvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfZr6ZAC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729600681; x=1761136681;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=80p6TRDDaANp9oY3sQKNQll+cOAp0yaPI45072gADSY=;
  b=lfZr6ZACVFeIdoNcYKBR+9DWHj9VpfVcJYRUNvE/lVVPVITinkCf6oC0
   AR8lG1zilckpxNZddM7QjJSca4Unei83/Xx3cZNbmr0m7KJOdva1YBLrD
   6UUC0gspDy6KMtjSNPE+A1luMDR18G+Cng8CLKpz4lo0Gfn03ewlVw2FW
   LxRKmY4kaPe9F5Nwx4x0BgeSK2yTGra2GuyuRsRYw1SJ9zfI8oVWY5Sew
   13eLwsZ5Xb9swAFRR5ZlV1D77OMlagU77XRW1yIlefxvvxKvzbSaWTJXQ
   A2Cnrd/5qwien8x/jHf/SveZOqQwjmpxiqf+rC/7yo0m4DvixS3HvaHoN
   w==;
X-CSE-ConnectionGUID: YO98F/ppQQaXPwbjIjC/xA==
X-CSE-MsgGUID: r367l5IVRJ2c+4hs2F6iTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31992801"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="31992801"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 05:38:00 -0700
X-CSE-ConnectionGUID: uTkioghMSPeSgkaqkuHPFQ==
X-CSE-MsgGUID: wbCudxrTR2u/40qpP7IZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79418016"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 05:37:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Oct 2024 15:37:55 +0300 (EEST)
To: chen zhang <chenzhang@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    luke@ljones.dev, LKML <linux-kernel@vger.kernel.org>, 
    chenzhang_0901@163.com
Subject: Re: [PATCH] platform/x86: eeepc-laptop: use sysfs_emit() instead of
 sprintf()
In-Reply-To: <20241018095547.46006-1-chenzhang@kylinos.cn>
Message-ID: <85fa60c9-0627-20c2-f101-ba367fd1cf37@linux.intel.com>
References: <20241018095547.46006-1-chenzhang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Oct 2024, chen zhang wrote:

> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
>  drivers/platform/x86/eeepc-laptop.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 03319a80e114..ba36b7bf6dc4 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -285,7 +285,7 @@ static ssize_t show_sys_acpi(struct device *dev, int cm, char *buf)
>  
>  	if (value < 0)
>  		return -EIO;
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);

Please add also #include <linux/sysfs.h> and include the correct list 
among receipients when sending v2.

-- 
 i.


>  }
>  
>  #define EEEPC_ACPI_SHOW_FUNC(_name, _cm)				\
> @@ -361,7 +361,7 @@ static ssize_t cpufv_show(struct device *dev,
>  
>  	if (get_cpufv(eeepc, &c))
>  		return -ENODEV;
> -	return sprintf(buf, "%#x\n", (c.num << 8) | c.cur);
> +	return sysfs_emit(buf, "%#x\n", (c.num << 8) | c.cur);
>  }
>  
>  static ssize_t cpufv_store(struct device *dev,
> @@ -393,7 +393,7 @@ static ssize_t cpufv_disabled_show(struct device *dev,
>  {
>  	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", eeepc->cpufv_disabled);
> +	return sysfs_emit(buf, "%d\n", eeepc->cpufv_disabled);
>  }
>  
>  static ssize_t cpufv_disabled_store(struct device *dev,
> @@ -1025,7 +1025,7 @@ static ssize_t store_sys_hwmon(void (*set)(int), const char *buf, size_t count)
>  
>  static ssize_t show_sys_hwmon(int (*get)(void), char *buf)
>  {
> -	return sprintf(buf, "%d\n", get());
> +	return sysfs_emit(buf, "%d\n", get());
>  }
>  
>  #define EEEPC_SENSOR_SHOW_FUNC(_name, _get)				\
> 



