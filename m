Return-Path: <linux-kernel+bounces-275986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13555948CDC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FAA1C235C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13FA1BE85D;
	Tue,  6 Aug 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SftJdPiZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07A15A4AF;
	Tue,  6 Aug 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940384; cv=none; b=Pyq0EEChDrktS3e8wEOj4cqunjzA0vg3MAJLrxw+NhfMACX8MjN2Lny1X9vKRsnTPMbEG9G/OU8Ut1XTtxRhfXMUSKlC43UZefYZUkHOk0evQ+SVV1zLnXaGOk+rXhRhM93aW3LyoJZdWNUo1ltIb2gGDvsh2Lefoav152whsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940384; c=relaxed/simple;
	bh=WK0yUyd4B3A4zEVchWwC5BxaLN9zllyCeQGwlVdV5f4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sdPCg27R8lm/iq0hz5g0GsiWhERmgXITKUKIfDLq2k4MvXdh6+En0jl9R17ri6/+T2OSyewxZ8+4dvdVc1Vr9jcDfF4jSQ1/tbKoExRliLApwWYIof/FqgjNDAkU5IOpMdwiv/W78CJNNUL7U1iJy6CuISG9oI0gV5dfLQahYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SftJdPiZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722940383; x=1754476383;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WK0yUyd4B3A4zEVchWwC5BxaLN9zllyCeQGwlVdV5f4=;
  b=SftJdPiZ50qKdhye9oqhHBshQb4UnKbxEUa/CcwFk/RuiYDEVwpYCcb4
   4BK2dUc+1m8DSdb0e+TWSDPzkAdOe107Sg0tuVpxl5ve2EseUNtlPKnRn
   gOWWIXoMwtWZewjtw0JAdS3nvSeIG/3vL7Pr/4N36WSccFmtwZNjjoJIm
   kvBToStg0juLxg+wqqPoF4sLKOciQyJhJxDveS+argqS8wcCbZ6tZZSsv
   Gv3Utq6P7rTV3KetmVAWbgiW/qDKvbxYCup05yAfSnSlmbVHZ1ypNauG7
   ZoAVBNjwX3s0jO2jZm6U4IsBPzhEpwPt2njaTg5HCGGmaQMcBlDFwveTi
   A==;
X-CSE-ConnectionGUID: W1KF13huQQGdlKJpQtZsRw==
X-CSE-MsgGUID: H0FrApNdTAymrZ0sj1ZfDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38400432"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="38400432"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:33:03 -0700
X-CSE-ConnectionGUID: U7OxoXkfQr2WWptWQaWupQ==
X-CSE-MsgGUID: L8BvsL50QCW5Ngn9ZtkC1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="93999273"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:33:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 13:32:56 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 5/6] platform/x86: asus-armoury: add core count
 control
In-Reply-To: <20240806020747.365042-6-luke@ljones.dev>
Message-ID: <b29283ba-22c1-95dc-dbaa-69bd4fc2dd3a@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-6-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Aug 2024, Luke D. Jones wrote:

> Implement Intel core enablement under the asus-armoury module using the
> fw_attributes class.
> 
> This allows users to enable or disable preformance or efficiency cores
> depending on their requirements. After change a reboot is required.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-armoury.c        | 208 ++++++++++++++++++++-
>  drivers/platform/x86/asus-armoury.h        |  29 +++
>  include/linux/platform_data/x86/asus-wmi.h |   4 +
>  3 files changed, 240 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 412e75c652a4..592ebea35ad5 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -39,6 +39,18 @@
>  #define ASUS_MINI_LED_2024_STRONG 0x01
>  #define ASUS_MINI_LED_2024_OFF 0x02
>  
> +enum cpu_core_type {
> +	CPU_CORE_PERF = 0,
> +	CPU_CORE_POWER,
> +};
> +
> +enum cpu_core_value {
> +	CPU_CORE_DEFAULT = 0,
> +	CPU_CORE_MIN,
> +	CPU_CORE_MAX,
> +	CPU_CORE_CURRENT,
> +};
> +
>  /* Default limits for tunables available on ASUS ROG laptops */
>  #define PPT_CPU_LIMIT_MIN 5
>  #define PPT_CPU_LIMIT_MAX 150
> @@ -84,6 +96,10 @@ struct rog_tunables {
>  	u32 dgpu_tgp_min;
>  	u32 dgpu_tgp_max;
>  	u32 dgpu_tgp;
> +
> +	u32 min_perf_cores;
> +	u32 max_perf_cores;
> +	u32 max_power_cores;
>  };
>  
>  static const struct class *fw_attr_class;
> @@ -148,7 +164,9 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
>  static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
>  {
>  	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
> -	       !strcmp(attr->attr.name, "panel_hd_mode");
> +		!strcmp(attr->attr.name, "cores_performance") ||
> +		!strcmp(attr->attr.name, "cores_efficiency") ||
> +		!strcmp(attr->attr.name, "panel_hd_mode");
>  }
>  
>  /**
> @@ -576,6 +594,191 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
>  }
>  ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
>  
> +static int init_max_cpu_cores(void)
> +{
> +	u32 cores;
> +	int err;
> +
> +	asus_armoury.rog_tunables->min_perf_cores = 4;
> +	asus_armoury.rog_tunables->max_perf_cores = 4;
> +	asus_armoury.rog_tunables->max_power_cores = 8;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
> +	if (err)
> +		return err;
> +
> +	cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
> +	asus_armoury.rog_tunables->max_power_cores = (cores & 0xff00) >> 8;
> +	asus_armoury.rog_tunables->max_perf_cores = cores & 0xff;

Define names for the fields returned in 'cores' using GENMASK() and use 
FIELD_GET() here to extract them.

> +
> +	return 0;
> +}
> +
> +static ssize_t cores_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf,
> +					enum cpu_core_type core_type,
> +					enum cpu_core_value core_value)
> +{
> +	u32 cores;
> +	int err;
> +
> +	switch (core_value) {
> +	case CPU_CORE_DEFAULT:
> +	case CPU_CORE_MAX:
> +		if (core_type == CPU_CORE_PERF)
> +			return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->max_perf_cores);

%u for u32, please check all %d, I won't mark the rest.

> +		else
> +			return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->max_power_cores);
> +	case CPU_CORE_MIN:
> +		if (core_type == CPU_CORE_PERF)
> +			return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->min_perf_cores);
> +		else
> +			return sysfs_emit(buf, "%d\n", 0);
> +	default:
> +	break;

Misindented.

> +	}
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
> +	if (err)
> +		return err;
> +
> +	cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
> +	if (core_type == CPU_CORE_PERF)
> +		cores &= 0xff;
> +	else
> +		cores = (cores & 0xff00) >> 8;

Perhaps create a helper which takes two pointers for core types as this 
code is similar to the one in init_max_cpu_cores().

> +	return sysfs_emit(buf, "%d\n", cores);
> +}
> +
> +static ssize_t cores_current_value_store(struct kobject *kobj,
> +				struct kobj_attribute *attr, const char *buf,
> +				enum cpu_core_type core_type)
> +{
> +	int result, err;
> +	u32 cores, currentv, min, max;
> +
> +	result = kstrtou32(buf, 10, &cores);
> +	if (result)
> +		return result;
> +
> +	if (core_type == CPU_CORE_PERF) {
> +		min = asus_armoury.rog_tunables->min_perf_cores;
> +		max = asus_armoury.rog_tunables->max_perf_cores;
> +	} else {
> +		min = 0;
> +		max = asus_armoury.rog_tunables->max_power_cores;
> +	}
> +	if (cores < min || cores > max)
> +		return -EINVAL;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &currentv);
> +	if (err)
> +		return err;
> +
> +	if (core_type == CPU_CORE_PERF)
> +		cores |= (currentv & 0xff00);
> +	else
> +		cores |= currentv & 0xff;

Use normal pattern to alter a field:
	xx &= ~YY;
	xx |= FIELD_PREP(YY, cores);

Alternatively you could just recalculate it fully since you've cached the 
values?

> +
> +	if (cores == currentv)
> +		return 0;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, cores, &result);
> +	if (err) {
> +		pr_warn("Failed to set CPU core count: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result > 1) {
> +		pr_warn("Failed to set CPU core count (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	pr_info("CPU core count changed, reboot required\n");
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +	asus_set_reboot_and_signal_event();

What prevents two change requests racing with each other?

-- 
 i.

> +	return 0;
> +}
> +
> +static ssize_t cores_performance_min_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MIN);
> +}
> +
> +static ssize_t cores_performance_max_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MAX);
> +}
> +
> +static ssize_t cores_performance_default_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_DEFAULT);
> +}
> +
> +static ssize_t cores_performance_current_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_CURRENT);
> +}
> +
> +static ssize_t cores_performance_current_value_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	int err;
> +
> +	err = cores_current_value_store(kobj, attr, buf, CPU_CORE_PERF);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +ATTR_GROUP_CORES_RW(cores_performance, "cores_performance",
> +		"Set the max available performance cores");
> +
> +static ssize_t cores_efficiency_min_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MIN);
> +}
> +
> +static ssize_t cores_efficiency_max_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MAX);
> +}
> +
> +static ssize_t cores_efficiency_default_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_DEFAULT);
> +}
> +
> +static ssize_t cores_efficiency_current_value_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_CURRENT);
> +}
> +
> +static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	int err;
> +
> +	err = cores_current_value_store(kobj, attr, buf, CPU_CORE_POWER);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
> +		"Set the max available efficiency cores");
> +
>  /* Simple attribute creation */
>  ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
>  		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> @@ -631,6 +834,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
>  	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
>  	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
> +	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
> +	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>  
>  	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>  	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> @@ -811,6 +1016,7 @@ static int __init asus_fw_init(void)
>  		return -ENOMEM;
>  	}
>  	init_rog_tunables(asus_armoury.rog_tunables);
> +	init_max_cpu_cores();
>  
>  	err = asus_fw_attr_add();
>  	mutex_unlock(&asus_armoury.mutex);
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> index 96d991383b8a..da585a180125 100644
> --- a/drivers/platform/x86/asus-armoury.h
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -154,6 +154,35 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>  		.name = _fsname, .attrs = _attrname##_attrs                                    \
>  	}
>  
> +/* CPU core attributes need a little different in setup */
> +#define ATTR_GROUP_CORES_RW(_attrname, _fsname, _dispname)	\
> +__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
> +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
> +static struct kobj_attribute attr_##_attrname##_current_value = \
> +	__ASUS_ATTR_RW(_attrname, current_value);		\
> +static struct kobj_attribute attr_##_attrname##_default_value = \
> +	__ASUS_ATTR_RO(_attrname, default_value);		\
> +static struct kobj_attribute attr_##_attrname##_min_value =	\
> +	__ASUS_ATTR_RO(_attrname, min_value);			\
> +static struct kobj_attribute attr_##_attrname##_max_value =	\
> +	__ASUS_ATTR_RO(_attrname, max_value);			\
> +static struct kobj_attribute attr_##_attrname##_type =		\
> +	__ASUS_ATTR_RO_AS(type, int_type_show);			\
> +static struct attribute *_attrname##_attrs[] = {		\
> +		&attr_##_attrname##_current_value.attr,		\
> +		&attr_##_attrname##_default_value.attr,		\
> +		&attr_##_attrname##_min_value.attr,		\
> +		&attr_##_attrname##_max_value.attr,		\
> +		&attr_##_attrname##_scalar_increment.attr,	\
> +		&attr_##_attrname##_display_name.attr,		\
> +		&attr_##_attrname##_type.attr,			\
> +		NULL						\
> +};								\
> +static const struct attribute_group _attrname##_attr_group = {	\
> +		.name = _fsname,				\
> +		.attrs = _attrname##_attrs			\
> +}
> +
>  /*
>   * ROG PPT attributes need a little different in setup as they
>   * require rog_tunables members.
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 287206a03763..2e7509ab5be0 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -133,6 +133,10 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +/* Intel E-core and P-core configuration in a format 0x0[E]0[P] */
> +#define ASUS_WMI_DEVID_CORES		0x001200D2
> + /* Maximum Intel E-core and P-core availability */
> +#define ASUS_WMI_DEVID_CORES_MAX	0x001200D3
>  #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
>  #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
>  #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
> 

