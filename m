Return-Path: <linux-kernel+bounces-191985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F48D16E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C938BB20D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016713D265;
	Tue, 28 May 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/4ZaRa1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A513C900;
	Tue, 28 May 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887191; cv=none; b=iHXRhQsVAkO/HM0rzxCwZ/yOO6Yrz11ETcmjmKweTPkdPfcdPouCzbRqTkUpOmsVCHL39fjbM8g5DXyijDZK9LtMSxNRzrQik+UnQrWtvabNkonmsa5KLwVnfUh3l9weCXNJfKCXXPwBGxCQigfpichAsXtRf3XNGMSZxNKOoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887191; c=relaxed/simple;
	bh=97zLPqcch+dKygaOOtSr8G9b0pK6+E1o8OK+hZaJVKA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rnQK+8aiZsL+aW1ZmHn7fZHvBnUe6UwPNBPYIB8GaNT/MMZNXcUghYUKHshHMqH4hFnRq3+yH3ZdNl7kj8oJb1m51Eyip+o8kWdzuCDGQox4AxyGtZ/xTm6qQR1yfPzM8GArwHlfidjeLwHxgZvX+4SvXgOhKt5ozqyUOcgyyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/4ZaRa1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716887190; x=1748423190;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=97zLPqcch+dKygaOOtSr8G9b0pK6+E1o8OK+hZaJVKA=;
  b=G/4ZaRa16A23ZirioT+h9qEIHqM6HeFRqxct4hUSO3A3ZnikeE1SIgdc
   2S/X6J1lmCucSZ/wBahE5aLIG1+HyyFpTPzI/zzFzL8byxY73QOWrtFOg
   HCMTml5At0BP4L+KHlrUey3meQpN+vDLDkmXhwQAA9dxYPZ4CN3yhzfoO
   DkHROtdyHdmnNo7C1O2apO6RA//TD2guyMnqmOc2ewV87GxTwljcaAsnf
   39cszvtTtFqkzaZnDwH/YiEDWaHowpyv3YdV2Sd1cPZRUkyvYY5Mwv1A1
   fk4Vfmwsu/LUXFJW8gPBPPA/cePZ3ver6ue7GGBJ+DkZ/zhIfdleFGk/I
   Q==;
X-CSE-ConnectionGUID: 2GoH1GvXS0aubl/pjodB5A==
X-CSE-MsgGUID: zfnrYMI6QyiSnMQFG+qDYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13089625"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13089625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:06:29 -0700
X-CSE-ConnectionGUID: 3Ix8TPURQ0KJJZ6L33mZ4g==
X-CSE-MsgGUID: aXprAG21RE+PuZXiwYgO+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="65839440"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:06:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 12:06:23 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] platform/x86: asus-wmi: use WMI_SIMPLE_SHOW in more
 places
In-Reply-To: <20240528013626.14066-6-luke@ljones.dev>
Message-ID: <d16db892-7c40-3244-710a-b9f3c64c3e60@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev> <20240528013626.14066-6-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Luke D. Jones wrote:

> Further reduce code duplication by using the new macros in a few more
> places.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 5c03e28ff252..260548aa6a42 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -813,19 +813,6 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
>  }
>  
>  /* dGPU ********************************************************************/
> -static ssize_t dgpu_disable_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> -
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_DGPU);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", result);
> -}
> -
>  /*
>   * A user may be required to store the value twice, typcial store first, then
>   * rescan PCI bus to activate power, then store a second time to save correctly.
> @@ -875,22 +862,11 @@ static ssize_t dgpu_disable_store(struct device *dev,
>  
>  	return count;
>  }
> +
> +WMI_SIMPLE_SHOW(dgpu_disable, "%d\n", ASUS_WMI_DEVID_DGPU);
>  static DEVICE_ATTR_RW(dgpu_disable);
>  
>  /* eGPU ********************************************************************/
> -static ssize_t egpu_enable_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> -
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", result);
> -}
> -
>  /* The ACPI call to enable the eGPU also disables the internal dGPU */
>  static ssize_t egpu_enable_store(struct device *dev,
>  				    struct device_attribute *attr,
> @@ -943,6 +919,8 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  	return count;
>  }
> +
> +WMI_SIMPLE_SHOW(egpu_enable, "%d\n", ASUS_WMI_DEVID_EGPU);
>  static DEVICE_ATTR_RW(egpu_enable);

It seems odd you do this subset in own patch. I think it would be more 
logical if you reorder patches 4 and 5.

-- 
 i.


