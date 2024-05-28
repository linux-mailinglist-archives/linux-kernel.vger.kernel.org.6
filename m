Return-Path: <linux-kernel+bounces-191967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33A8D16B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8B7B221EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C1613C81B;
	Tue, 28 May 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbZeZ95+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356346F08A;
	Tue, 28 May 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886542; cv=none; b=h5VExdpNrOGSc+279Eu7PZHIcdJejt7RfyvETuG2vUjUNFIy0SUegrVKoKpm8ZAEaUJ+FqdA4daJogsnaJqvD67rRm0MY44ZiviopXzIB0FMNyKOoPMQls5nv4wJ9tR5fYSPwlCSr1lDSdO8eBY6toc7+yLtw5cDglrwe4yZpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886542; c=relaxed/simple;
	bh=ABMwRbzdN3g+164Yn933dhgZozplmQMQwXpiPuHOHKs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FxzcS9L+s8BNPddf1qik/s9nSsFESCiG2AeTvg/YgnJ6oJ+YH3dZHnxMvsalb3UK8Hdv251oQnZKRkc2yZPwbJxSFSzKtOcwQuwMgaaGGx4xk7tmbpxJ1Hxh30tJdef9i2t6Qdd02bAUzg/vxLT/hFbCI6ohKHAOK8/vU+DCODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbZeZ95+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716886540; x=1748422540;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ABMwRbzdN3g+164Yn933dhgZozplmQMQwXpiPuHOHKs=;
  b=KbZeZ95+Odhbh9jS3JOKdfJDQiaqYOw9l6oc8lgZq2u57A7JaCAMUnn7
   4ZIqlX0O2Y8eyWy4Qgfb5vLgX2j8KPMkd6TNGGstNVz2Mr9a/igTVXF9T
   J6X4o4pSHCFA/8xq/yQye+/7CfuGGZpjBlhKgrAocyEKxANSxmORw7fY1
   iDU6y5s1fBUdf/gj5nj08iYOrY/uFLcoCACCycez3UhuhcNv69UKREUzt
   7+JOcClSYGmlWo4FzmGHAzUPwqnnnxaw+OA/x6syFHWvhGoKIzvQXkzmV
   P7i1gR7bdiMql7C3TpqiLw5PY49Wy9OLkqGPuXCkMbp9SKYXqEbuV1oek
   Q==;
X-CSE-ConnectionGUID: B27HcRSVQLmD+FQRZKLWCQ==
X-CSE-MsgGUID: TNXioVQaQ6GKrtO9JOj3AQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16166245"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="16166245"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:55:39 -0700
X-CSE-ConnectionGUID: idtIwp8QSAiSW5vYka/SkA==
X-CSE-MsgGUID: Tby2MUTOQyWAmWsHJVx+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34989777"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:55:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 11:55:33 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] platform/x86: asus-wmi: reduce code duplication with
 macros
In-Reply-To: <20240528013626.14066-5-luke@ljones.dev>
Message-ID: <af326c59-f79e-63aa-4c3a-70c10f879fc8@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev> <20240528013626.14066-5-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Luke D. Jones wrote:

> Over time many default patterns have emerged while adding functionality.
> This patch consolidates those patterns in to a few macros to remove a lot
> of copy/paste, and make it easier to add more of the same style of
> features in the future.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 215 ++++++--------------------------
>  1 file changed, 38 insertions(+), 177 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index d016acb23789..5c03e28ff252 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -676,7 +676,7 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
>  static ssize_t rog_tunable_store(struct asus_wmi *asus,
>  				struct attribute *attr,
>  				const char *buf, size_t count,
> -				u32 min, u32 max, u32 defaultv,
> +				u32 min, u32 max, int defaultv,

You just introduced this code in the previous patch and you're already 
changing the type, please don't do that but go to the right type right 
from the start.

Now that I of this more. This "reset to default" is a new feature and IMO 
it should be put into own patch and not mixed with the other refactoring.

-- 
 i.

>  				u32 *store_value, u32 wmi_dev)
>  {
>  	int result, err, value;
> @@ -685,7 +685,7 @@ static ssize_t rog_tunable_store(struct asus_wmi *asus,
>  	if (result)
>  		return result;
>  
> -	if (value == -1 )
> +	if (value == -1 && defaultv != -1)
>  		value = defaultv;
>  	if (value < min || value > max)
>  		return -EINVAL;
> @@ -708,6 +708,36 @@ static ssize_t rog_tunable_store(struct asus_wmi *asus,
>  	return count;
>  }
>  
> +#define WMI_SIMPLE_STORE(_fname, _min, _max, _wmi) \
> +static ssize_t _fname##_store(struct device *dev, \
> +	struct device_attribute *attr, const char *buf, size_t count) \
> +{ \
> +	struct asus_wmi *asus = dev_get_drvdata(dev); \
> +	return rog_tunable_store(asus, &attr->attr, buf, count, \
> +				_min, _max, -1, NULL, _wmi); \
> +}
> +
> +#define WMI_SIMPLE_SHOW(_fname, _fmt, _wmi) \
> +static ssize_t _fname##_show(struct device *dev, \
> +	struct device_attribute *attr, char *buf) \
> +{ \
> +	struct asus_wmi *asus = dev_get_drvdata(dev); \
> +	u32 result; \
> +	asus_wmi_get_devstate(asus, _wmi, &result); \
> +	if (result < 0) \
> +		return result; \
> +	return sysfs_emit(buf, _fmt, result & ~ASUS_WMI_DSTS_PRESENCE_BIT); \
> +}
> +
> +#define WMI_ATTR_SIMPLE_RW(_fname, _minv, _maxv, _wmi) \
> +WMI_SIMPLE_STORE(_fname, _minv, _maxv, _wmi); \
> +WMI_SIMPLE_SHOW(_fname, "%d\n", _wmi); \
> +static DEVICE_ATTR_RW(_fname)
> +
> +#define WMI_ATTR_SIMPLE_RO(_fname, _wmi) \
> +WMI_SIMPLE_SHOW(_fname, "%d\n", _wmi); \
> +static DEVICE_ATTR_RO(_fname)
> +
>  #define ROG_TUNABLE_STORE(_fname, _min, _max, _default, _wmi) \
>  static ssize_t _fname##_store(struct device *dev, \
>  	struct device_attribute *attr, const char *buf, size_t count) \
> @@ -761,6 +791,12 @@ ROG_ATTR_RW(nv_dynamic_boost,
>  	NVIDIA_BOOST_MIN, nv_boost_max, nv_boost_default, ASUS_WMI_DEVID_NV_DYN_BOOST);
>  ROG_ATTR_RW(nv_temp_target,
>  	NVIDIA_TEMP_MIN, nv_temp_max, nv_temp_default, ASUS_WMI_DEVID_NV_THERM_TARGET);
> +/* Ally MCU Powersave */
> +WMI_ATTR_SIMPLE_RW(mcu_powersave, 0, 1, ASUS_WMI_DEVID_MCU_POWERSAVE);
> +WMI_ATTR_SIMPLE_RO(egpu_connected, ASUS_WMI_DEVID_EGPU_CONNECTED);
> +WMI_ATTR_SIMPLE_RW(panel_od, 0, 1, ASUS_WMI_DEVID_PANEL_OD);
> +WMI_ATTR_SIMPLE_RW(boot_sound, 0, 1, ASUS_WMI_DEVID_BOOT_SOUND);
> +WMI_ATTR_SIMPLE_RO(charge_mode, ASUS_WMI_DEVID_CHARGE_MODE);
>  
>  /* Tablet mode ****************************************************************/
>  
> @@ -776,22 +812,6 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
>  		asus_wmi_tablet_sw_report(asus, result);
>  }
>  
> -/* Charging mode, 1=Barrel, 2=USB ******************************************/
> -static ssize_t charge_mode_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, value;
> -
> -	result = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CHARGE_MODE, &value);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", value & 0xff);
> -}
> -
> -static DEVICE_ATTR_RO(charge_mode);
> -
>  /* dGPU ********************************************************************/
>  static ssize_t dgpu_disable_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> @@ -925,22 +945,6 @@ static ssize_t egpu_enable_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(egpu_enable);
>  
> -/* Is eGPU connected? *********************************************************/
> -static ssize_t egpu_connected_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> -
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", result);
> -}
> -
> -static DEVICE_ATTR_RO(egpu_connected);
> -
>  /* gpu mux switch *************************************************************/
>  static ssize_t gpu_mux_mode_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
> @@ -1128,53 +1132,6 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
>  	NULL,
>  };
>  
> -/* Ally MCU Powersave ********************************************************/
> -static ssize_t mcu_powersave_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> -
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", result);
> -}
> -
> -static ssize_t mcu_powersave_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	int result, err;
> -	u32 enable;
> -
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	result = kstrtou32(buf, 10, &enable);
> -	if (result)
> -		return result;
> -
> -	if (enable > 1)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, enable, &result);
> -	if (err) {
> -		pr_warn("Failed to set MCU powersave: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set MCU powersave (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "mcu_powersave");
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(mcu_powersave);
> -
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -2002,102 +1959,6 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
>  	return result;
>  }
>  
> -/* Panel Overdrive ************************************************************/
> -static ssize_t panel_od_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> -
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_PANEL_OD);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", result);
> -}
> -
> -static ssize_t panel_od_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	int result, err;
> -	u32 overdrive;
> -
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	result = kstrtou32(buf, 10, &overdrive);
> -	if (result)
> -		return result;
> -
> -	if (overdrive > 1)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, overdrive, &result);
> -
> -	if (err) {
> -		pr_warn("Failed to set panel overdrive: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set panel overdrive (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "panel_od");
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(panel_od);
> -
> -/* Bootup sound ***************************************************************/
> -
> -static ssize_t boot_sound_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> -
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_SOUND);
> -	if (result < 0)
> -		return result;
> -
> -	return sysfs_emit(buf, "%d\n", result);
> -}
> -
> -static ssize_t boot_sound_store(struct device *dev,
> -			      struct device_attribute *attr,
> -			      const char *buf, size_t count)
> -{
> -	int result, err;
> -	u32 snd;
> -
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	result = kstrtou32(buf, 10, &snd);
> -	if (result)
> -		return result;
> -
> -	if (snd > 1)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &result);
> -	if (err) {
> -		pr_warn("Failed to set boot sound: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(boot_sound);
> -
>  /* Mini-LED mode **************************************************************/
>  static ssize_t mini_led_mode_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> 

