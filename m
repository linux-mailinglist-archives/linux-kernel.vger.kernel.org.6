Return-Path: <linux-kernel+bounces-512980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E3A3400C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BB97A2478
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A2221738;
	Thu, 13 Feb 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhRSisuz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355A23F420;
	Thu, 13 Feb 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452634; cv=none; b=n1DG42NuhnurANz1cs7xmPgpeCnhF0hKS5xWGSDmSI/Jp8E2Bmtbc8IQ47f/ubNK2X/HlJ1sWEVtmRyJ4kFIVXS8kSI37+2siULkqurhV/pgynbH3VgseMmEK/YFnQde6SoGTveBx17LXmeNd8H7OnP/3xXUAEIFGvgZUlepUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452634; c=relaxed/simple;
	bh=B6LIoz76z42FvSq9wox6H1rI2ql14MAd7eBVBROWw34=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JRU2RptH90i9GgmipTpEK83sXiEsJbPMZTi2d1C2C2kA4Cpew5toRdmhkJY7a5qu1xubzE78ofDuuvvw5Y5GfVkDttlXXnlGgk/8VcTcfQ8g0W/dpAxM+z1IcszyUkd21tYB8G93OQzjtac+qICLSJau1T0W4DoddssQrfvZnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhRSisuz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739452633; x=1770988633;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B6LIoz76z42FvSq9wox6H1rI2ql14MAd7eBVBROWw34=;
  b=QhRSisuzSTH1ZKt4gf4R4WARIYYi/8LNYjVp14KbdxjmabPsscz1nxOw
   ySA15utEHCoSeZWLP+nZZcuws+sh3doTy6qrs/0nX65XtjlUOWI5nXsFn
   4YyD/CnjN+y3yvaeMWKgcew0o352cmXpfY1SIXq/O/Qya4TDWTsTkJ40z
   le4xMaNq/BSz4ciKD6wtYd/XhEIkql0s9zZYLghZuav2Pf0AgmUINrH5j
   4RtTrgesGDZ50d6Cv51FPxOWVRtyf5PHwr1l3aNHozx2XnXEja8EEpG6c
   vzV16563rzTcD2QqcTaJ2RR7geXPBT1t1KzgP7845STqq5Stfq07iOEVb
   g==;
X-CSE-ConnectionGUID: 6tcsXL7xSEeKExQ84x9H2Q==
X-CSE-MsgGUID: eo4kq021QWq3zT7Yjppf9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51134996"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51134996"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:17:12 -0800
X-CSE-ConnectionGUID: Fv40il9nTj+lujsTW6THIw==
X-CSE-MsgGUID: LbHAWfgGQ9SUcGg83Pgv2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113086389"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:17:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Feb 2025 15:17:03 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: james@equiv.tech, markpearson@lenovo.com, jorge.lopez2@hp.com, 
    jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] platform/x86: think-lmi: Use WMI bus API when
 accessing BIOS settings
In-Reply-To: <20250203182322.384883-4-W_Armin@gmx.de>
Message-ID: <0dd7bda3-bf76-228b-27f3-f057e80e3a03@linux.intel.com>
References: <20250203182322.384883-1-W_Armin@gmx.de> <20250203182322.384883-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Feb 2025, Armin Wolf wrote:

> Since the driver already binds to LENOVO_BIOS_SETTING_GUID, using
> wmidev_block_query() inside tlmi_setting() allows for faster
> access to BIOS settings.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/think-lmi.c | 23 +++++++++--------------
>  drivers/platform/x86/think-lmi.h |  2 ++
>  2 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 2c94a4af9a1d..0fc275e461be 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -344,20 +344,14 @@ static int tlmi_opcode_setting(char *setting, const char *value)
>  	return ret;
>  }
> 
> -static int tlmi_setting(int item, char **value, const char *guid_string)
> +static int tlmi_setting(struct wmi_device *wdev, int item, char **value)
>  {
> -	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *obj;
> -	acpi_status status;
>  	int ret;
> 
> -	status = wmi_query_block(guid_string, item, &output);
> -	if (ACPI_FAILURE(status))
> -		return -EIO;
> -
> -	obj = output.pointer;
> +	obj = wmidev_block_query(wdev, item);
>  	if (!obj)
> -		return -ENODATA;
> +		return -EIO;

Hi Armin,

I'm trying to understand why there are these back and forth changes in the 
error code.

It almost looks to me like wmidev_block_query() would want to return the 
error code itself because after you abstracted this code using 
wmidev_block_query(), you had to change the error code because you no 
longer have access to the key detail to decide which error code should be 
returned. That is, use ERR_PTR() inside wmidev_block_query() and the 
callers should just pass that error code on with IS_ERR & friends?

-- 
 i.

>  	ret = tlmi_extract_output_string(obj, value);
>  	kfree(obj);
> @@ -995,7 +989,7 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>  	char *item, *value;
>  	int ret;
> 
> -	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
> +	ret = tlmi_setting(setting->wdev, setting->index, &item);
>  	if (ret)
>  		return ret;
> 
> @@ -1588,7 +1582,7 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
>  	return new_pwd;
>  }
> 
> -static int tlmi_analyze(void)
> +static int tlmi_analyze(struct wmi_device *wdev)
>  {
>  	int i, ret;
> 
> @@ -1625,7 +1619,7 @@ static int tlmi_analyze(void)
>  		char *item = NULL;
> 
>  		tlmi_priv.setting[i] = NULL;
> -		ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> +		ret = tlmi_setting(wdev, i, &item);
>  		if (ret)
>  			break;
>  		if (!item)
> @@ -1648,6 +1642,7 @@ static int tlmi_analyze(void)
>  			kfree(item);
>  			goto fail_clear_attr;
>  		}
> +		setting->wdev = wdev;
>  		setting->index = i;
>  		strscpy(setting->display_name, item);
>  		/* If BIOS selections supported, load those */
> @@ -1666,7 +1661,7 @@ static int tlmi_analyze(void)
>  			 */
>  			char *optitem, *optstart, *optend;
> 
> -			if (!tlmi_setting(setting->index, &optitem, LENOVO_BIOS_SETTING_GUID)) {
> +			if (!tlmi_setting(setting->wdev, setting->index, &optitem)) {
>  				optstart = strstr(optitem, "[Optional:");
>  				if (optstart) {
>  					optstart += strlen("[Optional:");
> @@ -1791,7 +1786,7 @@ static int tlmi_probe(struct wmi_device *wdev, const void *context)
>  {
>  	int ret;
> 
> -	ret = tlmi_analyze();
> +	ret = tlmi_analyze(wdev);
>  	if (ret)
>  		return ret;
> 
> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
> index f267d8b46957..a80452482227 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -4,6 +4,7 @@
>  #define _THINK_LMI_H_
> 
>  #include <linux/types.h>
> +#include <linux/wmi.h>
> 
>  #define TLMI_SETTINGS_COUNT  256
>  #define TLMI_SETTINGS_MAXLEN 512
> @@ -87,6 +88,7 @@ struct tlmi_pwd_setting {
>  /* Attribute setting details */
>  struct tlmi_attr_setting {
>  	struct kobject kobj;
> +	struct wmi_device *wdev;
>  	int index;
>  	char display_name[TLMI_SETTINGS_MAXLEN];
>  	char *possible_values;
> --
> 2.39.5
> 

