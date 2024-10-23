Return-Path: <linux-kernel+bounces-378025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979EB9ACA35
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9446B1C21478
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0A1A76C7;
	Wed, 23 Oct 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N666WkG0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C31AAE31;
	Wed, 23 Oct 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687207; cv=none; b=ZFRIqY8ZwGwZqWZNUN2R/CDU5ZdJTnkIMHXwD0KMTRbrVNJygwMoCPJdpUH80dE6/LQmpyo2fNUkb64cIsAmfJ77M5FE6XdOzPFT0H/SWAnE1Zsalark3dKaX8IdlhrLFg8VIF84+s9RRqyHfV5Nh8ctVAIQSwsKH0TAeps59LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687207; c=relaxed/simple;
	bh=EfZfesLhAqZ2/DFQ5gBYEl0Z1TY++HUKvZoSySkWsfA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sDEbaFDNzJ0U9pbi7xgLmxeSwvBHRbekc5761BpyfLHe/E/L5dnP9we940X8AbrJWD1Hd03koVJLnb1Kc4sAB1xHMz/zck5nrzFogk+PnmUWxF6KRMTcIqAsF0+oBNc8ASapvj1KbqznpYgiqs8fA5+OMOwavQ6UlT1XuIyivrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N666WkG0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729687207; x=1761223207;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EfZfesLhAqZ2/DFQ5gBYEl0Z1TY++HUKvZoSySkWsfA=;
  b=N666WkG0WLTV+8+7Wv8opKzJrof05O7uoiRrC4IU3xEH106msRTrEJfY
   dGzeDEGPFFHSoYwzQE6NRZs4mYJu6KxDLzWByH1lqYApj0wiKuCWhMAyr
   pK1LY/0EfqTHqOwCSpj9J+T2lxPkAFRSJ2df8tLVogbmdXYq7GUrjpw15
   APwS+JxxQm3jZwjGCtBvMj1lFkG93fHy9OhtPHEUtPdGj4pCJKaBNSNQG
   g4YE3m3Fph+NC1IRYMShhtpo4Ldz+tM4tUzwKqbblRg8+7bDI16dQhki5
   V82w9RpE8vXae0hWt+fJ9shHivBHSUF8z0Xt0XVTZmweCg59jwZjpR8mC
   A==;
X-CSE-ConnectionGUID: EBd0DiOGTIaTqW5Km2VTaQ==
X-CSE-MsgGUID: G0EQA/2RSLusqA6VBFoyxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39885643"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="39885643"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:40:06 -0700
X-CSE-ConnectionGUID: eCURXG+KSpyMlxc40pEhtg==
X-CSE-MsgGUID: aMmb14VRSBePorMv2FMorw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="110980037"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:40:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Oct 2024 15:39:59 +0300 (EEST)
To: chen zhang <chenzhang@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, cascardo@holoscopio.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    chenzhang_0901@163.com
Subject: Re: [PATCH v2] platform/x86: classmate-laptop: use sysfs_emit()
 instead of sprintf()
In-Reply-To: <20241023014201.16359-1-chenzhang@kylinos.cn>
Message-ID: <8aad63f7-9d38-034f-3857-02aabffa4738@linux.intel.com>
References: <20241023014201.16359-1-chenzhang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Oct 2024, chen zhang wrote:

> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
> v2: add #include <linux/sysfs.h>
> ---
>  drivers/platform/x86/classmate-laptop.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index cb6fce655e35..6b1b8e444e24 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -12,6 +12,7 @@
>  #include <linux/backlight.h>
>  #include <linux/input.h>
>  #include <linux/rfkill.h>
> +#include <linux/sysfs.h>
>  
>  struct cmpc_accel {
>  	int sensitivity;
> @@ -208,7 +209,7 @@ static ssize_t cmpc_accel_sensitivity_show_v4(struct device *dev,
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	accel = dev_get_drvdata(&inputdev->dev);
>  
> -	return sprintf(buf, "%d\n", accel->sensitivity);
> +	return sysfs_emit(buf, "%d\n", accel->sensitivity);
>  }
>  
>  static ssize_t cmpc_accel_sensitivity_store_v4(struct device *dev,
> @@ -257,7 +258,7 @@ static ssize_t cmpc_accel_g_select_show_v4(struct device *dev,
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	accel = dev_get_drvdata(&inputdev->dev);
>  
> -	return sprintf(buf, "%d\n", accel->g_select);
> +	return sysfs_emit(buf, "%d\n", accel->g_select);
>  }
>  
>  static ssize_t cmpc_accel_g_select_store_v4(struct device *dev,
> @@ -550,7 +551,7 @@ static ssize_t cmpc_accel_sensitivity_show(struct device *dev,
>  	inputdev = dev_get_drvdata(&acpi->dev);
>  	accel = dev_get_drvdata(&inputdev->dev);
>  
> -	return sprintf(buf, "%d\n", accel->sensitivity);
> +	return sysfs_emit(buf, "%d\n", accel->sensitivity);
>  }
>  
>  static ssize_t cmpc_accel_sensitivity_store(struct device *dev,
> 

Hi,

Thank you for your patch, however, a similar patch (from somebody else) 
has been already applied so I dropped this one.

-- 
 i.


