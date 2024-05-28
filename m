Return-Path: <linux-kernel+bounces-191961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545078D16A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55E71F2211D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453D74BE1;
	Tue, 28 May 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfeSxjh4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1EE17E8FC;
	Tue, 28 May 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886248; cv=none; b=iQ9CISiOYipqMpVgdRU1fQMgIHA5rNNAoAO8uYLULclS/3aieCz6U7OKHYffNwnIr8Tex6wVJmctUenILm6yaCyJCdqg1pBK7OInqVPT47R+3wnFolm3cGnifSCNM5+4HDteH+hcOswOKIMVfl3Tl7jjEY8pKGeYlH3fpNMqtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886248; c=relaxed/simple;
	bh=iaZxrV6e9H/7cCReDqzeOt7CaOGcswPNhmOdF1bmIbI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jh/wJNkSfWdRcmXTW+C8683z7vz7xS1D6ezhQhjv7qdL6tMjftdwgn5Nm40TciBont0fclDr+vSiFWqLYdqob0M3G2RsnF5cvritbQTVqWXjGKWL0LT2A+DZy3I1IhcrV+ottj5BQj59+x5gqRnKqCpHdwfUPQrHKrvGy4Jrjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfeSxjh4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716886246; x=1748422246;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iaZxrV6e9H/7cCReDqzeOt7CaOGcswPNhmOdF1bmIbI=;
  b=DfeSxjh4KJ7s3gQa4MteW89wbEOUGEJP2vAYzljj1wnnKM8D85p1LS+/
   +69SkwjQ413YuoNPjpuU8LkSQSxVOCByYHSeOfPcUW44C5Pzu914ZLRkv
   l+vZNqnAxZZBiU0hELJtnWVNfXJrXsyofGKLMgOr81nijs9FxrvCO7U+G
   vIp0yWnzmJjIxKqFi+quJaUZ9YWLGQbnOKsvQIOfiEXPJngQOzay3Our6
   V+ePzA25XJQZdNSXsI58sE/SqBBLk9PaiDbjnH4yc7sfKRiAMMCUvLbVZ
   eXjhY+NiqcBVpyT08CLC0H5dYmPfImqOGmji0MsieEWKLOUADG0EL7wT1
   A==;
X-CSE-ConnectionGUID: t7hPDP8ZTqSmQBFQtMx+TA==
X-CSE-MsgGUID: toL14cEZTPGkBNRK6Cddbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13063928"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13063928"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:50:45 -0700
X-CSE-ConnectionGUID: 1qHACttARfeD1hlNqIbJiQ==
X-CSE-MsgGUID: MjNp5ndvSgu1tY1HtIYNjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34931417"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:50:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 11:50:37 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] platform/x86: asus-wmi: add macros and expose min/max
 sysfs for ppt tunables
In-Reply-To: <20240528013626.14066-4-luke@ljones.dev>
Message-ID: <f3a7aa72-78fa-5f60-f4b5-2a38025c2936@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev> <20240528013626.14066-4-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Luke D. Jones wrote:

> In most cases the safe min and max values of the various PPT tunables are
> known for various ASUS ROG (and other) laptop models. We can match the
> DMI string for these and expose min/max sysfs points, plus set some sane
> default values.
> 
> As part of the addition of the min/max and defaults, to reduce the amount
> of code copy/paste and introduce some sanity a group of macros were added
> specific to the PPT and NV tunables. The code becomes much cleaner and
> easier to read.
> 
> This makes the PPT functions much more usable and safe.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  23 +-
>  drivers/platform/x86/asus-wmi.c               | 561 ++++++++----------
>  2 files changed, 245 insertions(+), 339 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 28144371a0f1..984a04f32fd0 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -142,8 +142,8 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
>  		Shown on Intel+Nvidia or AMD+Nvidia based systems:
> -
> -			* min=5, max=250
> +            * min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/ppt_pl2_sppt
>  Date:		Jun 2023
> @@ -152,8 +152,8 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
>  		on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems:
> -
> -			* min=5, max=250
> +            * min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/ppt_fppt
>  Date:		Jun 2023
> @@ -161,7 +161,8 @@ KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only:
> -			* min=5, max=250
> +			* min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/ppt_apu_sppt
>  Date:		Jun 2023
> @@ -169,7 +170,8 @@ KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the APU SPPT limit. Shown on full AMD systems only:
> -			* min=5, max=130
> +			* min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/ppt_platform_sppt
>  Date:		Jun 2023
> @@ -177,7 +179,8 @@ KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the platform SPPT limit. Shown on full AMD systems only:
> -			* min=5, max=130
> +			* min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/nv_dynamic_boost
>  Date:		Jun 2023
> @@ -185,7 +188,8 @@ KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the dynamic boost limit of the Nvidia dGPU:
> -			* min=5, max=25
> +			* min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/nv_temp_target
>  Date:		Jun 2023
> @@ -193,7 +197,8 @@ KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the target temperature limit of the Nvidia dGPU:
> -			* min=75, max=87
> +			* min/max varies, read *_min/*_max sysfs entries
> +			* -1 resets to default
>  
>  What:		/sys/devices/platform/<platform>/boot_sound
>  Date:		Apr 2024
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 999cd658ec8b..d016acb23789 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -112,11 +112,13 @@ module_param(fnlock_default, bool, 0444);
>  /* Mask to determine if setting temperature or percentage */
>  #define FAN_CURVE_PWM_MASK		0x04
>  
> -/* Limits for tunables available on ASUS ROG laptops */
> -#define PPT_TOTAL_MIN		5
> -#define PPT_TOTAL_MAX		250
> -#define PPT_CPU_MIN			5
> -#define PPT_CPU_MAX			130
> +/* Default limits for tunables available on ASUS ROG laptops */
> +#define PPT_CPU_LIMIT_MIN	5
> +#define PPT_CPU_LIMIT_MAX	150
> +#define PPT_CPU_LIMIT_DEFAULT	80
> +#define PPT_PLATFORM_MIN	5
> +#define PPT_PLATFORM_MAX	100
> +#define PPT_PLATFORM_DEFAULT	80
>  #define NVIDIA_BOOST_MIN	5
>  #define NVIDIA_BOOST_MAX	25
>  #define NVIDIA_TEMP_MIN		75
> @@ -219,6 +221,29 @@ struct fan_curve_data {
>  	u8 percents[FAN_CURVE_POINTS];
>  };
>  
> +/* Tunables provided by ASUS for gaming laptops */
> +struct rog_tunables {
> +	u32 cpu_default;
> +	u32 cpu_max;
> +
> +	u32 platform_default;
> +	u32 platform_max;
> +
> +	u32 ppt_pl1_spl; // total
> +	u32 ppt_pl2_sppt; // total
> +	u32 ppt_apu_sppt; // cpu
> +	u32 ppt_platform_sppt; // cpu
> +	u32 ppt_fppt; // total
> +
> +	u32 nv_boost_default;
> +	u32 nv_boost_max;
> +	u32 nv_dynamic_boost;
> +
> +	u32 nv_temp_default;
> +	u32 nv_temp_max;
> +	u32 nv_temp_target;
> +};
> +
>  struct asus_wmi {
>  	int dsts_id;
>  	int spec;
> @@ -273,14 +298,7 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	u32 gpu_mux_dev;
>  
> -	/* Tunables provided by ASUS for gaming laptops */
> -	u32 ppt_pl2_sppt;
> -	u32 ppt_pl1_spl;
> -	u32 ppt_apu_sppt;
> -	u32 ppt_platform_sppt;
> -	u32 ppt_fppt;
> -	u32 nv_dynamic_boost;
> -	u32 nv_temp_target;
> +	struct rog_tunables rog_tunables;
>  
>  	u32 kbd_rgb_dev;
>  	bool kbd_rgb_state_available;
> @@ -652,6 +670,98 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
>  	asus->inputdev = NULL;
>  }
>  
> +/* Helper macros for generalised WMI calls */
> +
> +/* Generic store function for use with many ROG tunables */
> +static ssize_t rog_tunable_store(struct asus_wmi *asus,
> +				struct attribute *attr,
> +				const char *buf, size_t count,
> +				u32 min, u32 max, u32 defaultv,
> +				u32 *store_value, u32 wmi_dev)
> +{
> +	int result, err, value;
> +
> +	result = kstrtoint(buf, 10, &value);
> +	if (result)
> +		return result;
> +
> +	if (value == -1 )

Remove the extra space.

> +		value = defaultv;
> +	if (value < min || value > max)
> +		return -EINVAL;
> +
> +	err = asus_wmi_set_devstate(wmi_dev, value, &result);
> +	if (err) {
> +		pr_err("Failed to set %s: %d\n", attr->name, err);
> +		return err;
> +	}
> +
> +	if (result > 1) {

Remove the empty line in between since this is still the error handling of 
the same call.

> +		pr_err("Failed to set %s (result): 0x%x\n", attr->name, result);
> +		return -EIO;
> +	}
> +
> +	if (store_value != NULL)
> +		*store_value = value;
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, attr->name);
> +
> +	return count;
> +}
> +
> +#define ROG_TUNABLE_STORE(_fname, _min, _max, _default, _wmi) \
> +static ssize_t _fname##_store(struct device *dev, \
> +	struct device_attribute *attr, const char *buf, size_t count) \
> +{ \
> +	struct asus_wmi *asus = dev_get_drvdata(dev); \
> +	return rog_tunable_store(asus, &attr->attr, buf, count, \
> +			_min, asus->rog_tunables._max, asus->rog_tunables._default, \
> +			&asus->rog_tunables._fname, _wmi); \
> +}

For all function macros like this, align all the continuation backslashed 
with tabs somewhere far right so they don't interfere with the code.

> +#define ROG_TUNABLE_SHOW(_fname) \
> +static ssize_t _fname##_show(struct device *dev, struct device_attribute *attr, char *buf) \
> +{ \
> +	struct asus_wmi *asus = dev_get_drvdata(dev); \
> +	return sysfs_emit(buf, "%u\n", asus->rog_tunables._fname); \
> +}
> +
> +#define ROG_TUNABLE_MIN_SHOW(_fname, _minv) \
> +static ssize_t _fname##_min_show(struct device *dev, struct device_attribute *attr, char *buf) \
> +{ \
> +	return sysfs_emit(buf, "%u\n", _minv); \
> +}
> +
> +#define ROG_TUNABLE_MAX_SHOW(_fname, _maxv) \
> +static ssize_t _fname##_max_show(struct device *dev, struct device_attribute *attr, char *buf) \
> +{ \
> +	struct asus_wmi *asus = dev_get_drvdata(dev); \
> +	return sysfs_emit(buf, "%u\n", asus->rog_tunables._maxv); \
> +}
> +
> +#define ROG_ATTR_RW(_fname, _minv, _maxv, _defaultv, _wmi) \
> +ROG_TUNABLE_MIN_SHOW(_fname, _minv); \
> +ROG_TUNABLE_MAX_SHOW(_fname, _maxv); \
> +ROG_TUNABLE_STORE(_fname, _minv, _maxv, _defaultv, _wmi);\
> +ROG_TUNABLE_SHOW(_fname); \
> +static DEVICE_ATTR_RO(_fname##_min); \
> +static DEVICE_ATTR_RO(_fname##_max); \
> +static DEVICE_ATTR_RW(_fname)

Also here, align \ to right with \ so it doesn't interfere with the real 
content of the macro.

> +
> +ROG_ATTR_RW(ppt_platform_sppt,
> +	PPT_PLATFORM_MIN, platform_max, platform_default, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
> +ROG_ATTR_RW(ppt_pl2_sppt,
> +	PPT_CPU_LIMIT_MIN, cpu_max, cpu_default, ASUS_WMI_DEVID_PPT_PL2_SPPT);
> +ROG_ATTR_RW(ppt_apu_sppt,
> +	PPT_PLATFORM_MIN, platform_max, platform_default, ASUS_WMI_DEVID_PPT_APU_SPPT);
> +ROG_ATTR_RW(ppt_pl1_spl,
> +	PPT_CPU_LIMIT_MIN, cpu_max, cpu_default, ASUS_WMI_DEVID_PPT_PL1_SPL);
> +ROG_ATTR_RW(ppt_fppt,
> +	PPT_CPU_LIMIT_MIN, cpu_max, cpu_default, ASUS_WMI_DEVID_PPT_FPPT);
> +ROG_ATTR_RW(nv_dynamic_boost,
> +	NVIDIA_BOOST_MIN, nv_boost_max, nv_boost_default, ASUS_WMI_DEVID_NV_DYN_BOOST);
> +ROG_ATTR_RW(nv_temp_target,
> +	NVIDIA_TEMP_MIN, nv_temp_max, nv_temp_default, ASUS_WMI_DEVID_NV_THERM_TARGET);
> +
>  /* Tablet mode ****************************************************************/
>  
>  static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
> @@ -1018,306 +1128,6 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
>  	NULL,
>  };
>  
> -/* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
> -static ssize_t ppt_pl2_sppt_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL2_SPPT, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set ppt_pl2_sppt: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set ppt_pl2_sppt (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->ppt_pl2_sppt = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl2_sppt");
> -
> -	return count;
> -}
> -
> -static ssize_t ppt_pl2_sppt_show(struct device *dev,
> -				       struct device_attribute *attr,
> -				       char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
> -}
> -static DEVICE_ATTR_RW(ppt_pl2_sppt);
> -
> -/* Tunable: PPT, Intel=PL1, AMD=SPL ******************************************/
> -static ssize_t ppt_pl1_spl_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL1_SPL, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set ppt_pl1_spl: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set ppt_pl1_spl (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->ppt_pl1_spl = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl1_spl");
> -
> -	return count;
> -}
> -static ssize_t ppt_pl1_spl_show(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
> -}
> -static DEVICE_ATTR_RW(ppt_pl1_spl);
> -
> -/* Tunable: PPT APU FPPT ******************************************************/
> -static ssize_t ppt_fppt_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_FPPT, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set ppt_fppt: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set ppt_fppt (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->ppt_fppt = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_fpu_sppt");
> -
> -	return count;
> -}
> -
> -static ssize_t ppt_fppt_show(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
> -}
> -static DEVICE_ATTR_RW(ppt_fppt);
> -
> -/* Tunable: PPT APU SPPT *****************************************************/
> -static ssize_t ppt_apu_sppt_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < PPT_CPU_MIN || value > PPT_CPU_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_APU_SPPT, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set ppt_apu_sppt: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set ppt_apu_sppt (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->ppt_apu_sppt = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_apu_sppt");
> -
> -	return count;
> -}
> -
> -static ssize_t ppt_apu_sppt_show(struct device *dev,
> -			     struct device_attribute *attr,
> -			     char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
> -}
> -static DEVICE_ATTR_RW(ppt_apu_sppt);
> -
> -/* Tunable: PPT platform SPPT ************************************************/
> -static ssize_t ppt_platform_sppt_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < PPT_CPU_MIN || value > PPT_CPU_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PLAT_SPPT, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set ppt_platform_sppt: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set ppt_platform_sppt (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->ppt_platform_sppt = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_platform_sppt");
> -
> -	return count;
> -}
> -
> -static ssize_t ppt_platform_sppt_show(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
> -}
> -static DEVICE_ATTR_RW(ppt_platform_sppt);
> -
> -/* Tunable: NVIDIA dynamic boost *********************************************/
> -static ssize_t nv_dynamic_boost_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < NVIDIA_BOOST_MIN || value > NVIDIA_BOOST_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_DYN_BOOST, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set nv_dynamic_boost: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set nv_dynamic_boost (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->nv_dynamic_boost = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_dynamic_boost");
> -
> -	return count;
> -}
> -
> -static ssize_t nv_dynamic_boost_show(struct device *dev,
> -				      struct device_attribute *attr,
> -				      char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
> -}
> -static DEVICE_ATTR_RW(nv_dynamic_boost);
> -
> -/* Tunable: NVIDIA temperature target ****************************************/
> -static ssize_t nv_temp_target_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result, err;
> -	u32 value;
> -
> -	result = kstrtou32(buf, 10, &value);
> -	if (result)
> -		return result;
> -
> -	if (value < NVIDIA_TEMP_MIN || value > NVIDIA_TEMP_MAX)
> -		return -EINVAL;
> -
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_THERM_TARGET, value, &result);
> -	if (err) {
> -		pr_warn("Failed to set nv_temp_target: %d\n", err);
> -		return err;
> -	}
> -
> -	if (result > 1) {
> -		pr_warn("Failed to set nv_temp_target (result): 0x%x\n", result);
> -		return -EIO;
> -	}
> -
> -	asus->nv_temp_target = value;
> -	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_temp_target");
> -
> -	return count;
> -}
> -
> -static ssize_t nv_temp_target_show(struct device *dev,
> -				     struct device_attribute *attr,
> -				     char *buf)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -
> -	return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
> -}
> -static DEVICE_ATTR_RW(nv_temp_target);
> -
>  /* Ally MCU Powersave ********************************************************/
>  static ssize_t mcu_powersave_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> @@ -4367,13 +4177,27 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
>  	&dev_attr_throttle_thermal_policy.attr,
> -	&dev_attr_ppt_pl2_sppt.attr,
>  	&dev_attr_ppt_pl1_spl.attr,
> +	&dev_attr_ppt_pl1_spl_min.attr,
> +	&dev_attr_ppt_pl1_spl_max.attr,
> +	&dev_attr_ppt_pl2_sppt.attr,
> +	&dev_attr_ppt_pl2_sppt_min.attr,
> +	&dev_attr_ppt_pl2_sppt_max.attr,
>  	&dev_attr_ppt_fppt.attr,
> +	&dev_attr_ppt_fppt_min.attr,
> +	&dev_attr_ppt_fppt_max.attr,
>  	&dev_attr_ppt_apu_sppt.attr,
> +	&dev_attr_ppt_apu_sppt_min.attr,
> +	&dev_attr_ppt_apu_sppt_max.attr,
>  	&dev_attr_ppt_platform_sppt.attr,
> +	&dev_attr_ppt_platform_sppt_min.attr,
> +	&dev_attr_ppt_platform_sppt_max.attr,
>  	&dev_attr_nv_dynamic_boost.attr,
> +	&dev_attr_nv_dynamic_boost_min.attr,
> +	&dev_attr_nv_dynamic_boost_max.attr,
>  	&dev_attr_nv_temp_target.attr,
> +	&dev_attr_nv_temp_target_min.attr,
> +	&dev_attr_nv_temp_target_max.attr,
>  	&dev_attr_mcu_powersave.attr,
>  	&dev_attr_boot_sound.attr,
>  	&dev_attr_panel_od.attr,
> @@ -4414,19 +4238,33 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
>  		ok = asus->throttle_thermal_policy_available;
> -	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
> +	else if (attr == &dev_attr_ppt_pl2_sppt.attr
> +		|| attr == &dev_attr_ppt_pl2_sppt_min.attr
> +		|| attr == &dev_attr_ppt_pl2_sppt_max.attr)
>  		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;

Please don't align if condition and the code block to same level but add 
the one space to make it obvious it's inside the opening (. The usual 
coding style is to put || at the end of the line and align attr to the 
same column which I think would be beneficial especially on lines which 
begin the same like here.

> -	else if (attr == &dev_attr_ppt_pl1_spl.attr)
> +	else if (attr == &dev_attr_ppt_pl1_spl.attr
> +		|| attr == &dev_attr_ppt_pl1_spl_min.attr
> +		|| attr == &dev_attr_ppt_pl1_spl_max.attr)
>  		devid = ASUS_WMI_DEVID_PPT_PL1_SPL;
> -	else if (attr == &dev_attr_ppt_fppt.attr)
> +	else if (attr == &dev_attr_ppt_fppt.attr
> +		|| attr == &dev_attr_ppt_fppt_min.attr
> +		|| attr == &dev_attr_ppt_fppt_max.attr)
>  		devid = ASUS_WMI_DEVID_PPT_FPPT;
> -	else if (attr == &dev_attr_ppt_apu_sppt.attr)
> +	else if (attr == &dev_attr_ppt_apu_sppt.attr
> +		|| attr == &dev_attr_ppt_apu_sppt_min.attr
> +		|| attr == &dev_attr_ppt_apu_sppt_max.attr)
>  		devid = ASUS_WMI_DEVID_PPT_APU_SPPT;
> -	else if (attr == &dev_attr_ppt_platform_sppt.attr)
> +	else if (attr == &dev_attr_ppt_platform_sppt.attr
> +		|| attr == &dev_attr_ppt_platform_sppt_min.attr
> +		|| attr == &dev_attr_ppt_platform_sppt_max.attr)
>  		devid = ASUS_WMI_DEVID_PPT_PLAT_SPPT;
> -	else if (attr == &dev_attr_nv_dynamic_boost.attr)
> +	else if (attr == &dev_attr_nv_dynamic_boost.attr
> +		|| attr == &dev_attr_nv_dynamic_boost_min.attr
> +		|| attr == &dev_attr_nv_dynamic_boost_max.attr)
>  		devid = ASUS_WMI_DEVID_NV_DYN_BOOST;
> -	else if (attr == &dev_attr_nv_temp_target.attr)
> +	else if (attr == &dev_attr_nv_temp_target.attr
> +		|| attr == &dev_attr_nv_temp_target_min.attr
> +		|| attr == &dev_attr_nv_temp_target_max.attr)
>  		devid = ASUS_WMI_DEVID_NV_THERM_TARGET;
>  	else if (attr == &dev_attr_mcu_powersave.attr)
>  		devid = ASUS_WMI_DEVID_MCU_POWERSAVE;
> @@ -4652,6 +4490,77 @@ static void asus_wmi_debugfs_init(struct asus_wmi *asus)
>  
>  /* Init / exit ****************************************************************/
>  
> +/* Set up the min/max and defaults for ROG tunables */
> +static void init_rog_tunables(struct asus_wmi *asus)
> +{
> +	const char *product;
> +	u32 max_boost = NVIDIA_BOOST_MAX;
> +	u32 cpu_default = PPT_CPU_LIMIT_DEFAULT;
> +	u32 cpu_max = PPT_CPU_LIMIT_MAX;
> +	u32 platform_default = PPT_PLATFORM_DEFAULT;
> +	u32 platform_max = PPT_PLATFORM_MAX;
> +
> +	/*
> +	 * ASUS product_name contains everything required, e.g,
> +	 * "ROG Flow X16 GV601VV_GV601VV_00185149B"
> +	 */
> +	product = dmi_get_system_info(DMI_PRODUCT_NAME);
> +
> +	if (strstr(product, "GA402R")) {
> +		cpu_default = 125;
> +	} else if (strstr(product, "13QY")) {
> +		cpu_max = 250;
> +	} else if (strstr(product, "X13")) {
> +		cpu_max = 75;
> +		cpu_default = 50;
> +	} else if (strstr(product, "RC71")) {
> +		cpu_max = 50;
> +		cpu_default = 30;
> +	} else if (strstr(product, "G814")
> +		|| strstr(product, "G614")
> +		|| strstr(product, "G834")
> +		|| strstr(product, "G634")) {
> +		cpu_max = 175;

Here the unusual placement of || made you even intentionally break the 
alignment to match strstr(). This is a clear proof to me it's not a good 
idea to put || at the beginning of the line because it incentivizes you 
to do this kind of misalignment.

The contination of if condition should start from the column after the 
opening parenthesis (which will make strstr() jumpy, which is why the
usual style with || at the end of the previous line seems clearly better).

> +	} else if (strstr(product, "GA402X")
> +		|| strstr(product, "GA403")
> +		|| strstr(product, "FA507N")
> +		|| strstr(product, "FA507X")
> +		|| strstr(product, "FA707N")
> +		|| strstr(product, "FA707X")) {
> +		cpu_max = 90;

Ditto.

> +	}
> +
> +	if (strstr(product, "GZ301ZE"))
> +		max_boost = 5;
> +	else if (strstr(product, "FX507ZC4"))
> +		max_boost = 15;
> +	else if (strstr(product, "GU605"))
> +		max_boost = 20;
> +
> +	/* ensure defaults for tunables */
> +	asus->rog_tunables.cpu_default = cpu_default;
> +	asus->rog_tunables.cpu_max = cpu_max;
> +
> +	asus->rog_tunables.platform_default = platform_default;
> +	asus->rog_tunables.platform_max = platform_max;
> +
> +	asus->rog_tunables.ppt_pl1_spl = cpu_default;
> +	asus->rog_tunables.ppt_pl2_sppt = cpu_default;
> +	asus->rog_tunables.ppt_apu_sppt = cpu_default;
> +
> +	asus->rog_tunables.ppt_platform_sppt = platform_default;
> +	asus->rog_tunables.ppt_fppt = platform_default;
> +
> +	asus->rog_tunables.nv_boost_default = NVIDIA_BOOST_MAX;
> +	asus->rog_tunables.nv_boost_max = max_boost;
> +	asus->rog_tunables.nv_dynamic_boost = NVIDIA_BOOST_MIN;
> +
> +	asus->rog_tunables.nv_temp_default = NVIDIA_TEMP_MAX;
> +	asus->rog_tunables.nv_temp_max = NVIDIA_TEMP_MAX;
> +	asus->rog_tunables.nv_temp_target = NVIDIA_TEMP_MIN;
> +
> +}
> +
>  static int asus_wmi_add(struct platform_device *pdev)
>  {
>  	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
> @@ -4677,15 +4586,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	if (err)
>  		goto fail_platform;
>  
> -	/* ensure defaults for tunables */
> -	asus->ppt_pl2_sppt = 5;
> -	asus->ppt_pl1_spl = 5;
> -	asus->ppt_apu_sppt = 5;
> -	asus->ppt_platform_sppt = 5;
> -	asus->ppt_fppt = 5;
> -	asus->nv_dynamic_boost = 5;
> -	asus->nv_temp_target = 75;
> -
> +	init_rog_tunables(asus);
>  	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
>  	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>  	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
> 

-- 
 i.


