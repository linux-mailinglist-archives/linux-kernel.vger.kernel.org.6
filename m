Return-Path: <linux-kernel+bounces-275974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81985948CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD78CB23436
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE451BF31F;
	Tue,  6 Aug 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbxqOpNz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC21BE85C;
	Tue,  6 Aug 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939483; cv=none; b=UVbfxm4ItxuoUZ1w7BDSvGZ14FSdkX2Na0WjZSffCtyr2M87cXKitPB/in8DaSmIacItRgmYspqzFwEqM+jqfBbc2IsiC54VknHgGSSto6TImmbFfm8uZtBuSsig0YFsxfVVipPdB3mfU4STBBl8mcLonma5B+41k7zWHOeer9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939483; c=relaxed/simple;
	bh=Q095l2RJzFBWigA3KKIRl76L9+fcP+Cmv7Gryw1bd/c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H6gUDvkbKYFabeBtcSpZv+ITRuug9zDkh/NVgK3hBY0igu1gNk2GKaCyeHLWU2bmzsuE72BXmeYlX5j6/+QNkRbXSQL03KZIQkbpv8U9PZe+ownXfJuUJpbRSKqVnAQtdh8kqjPIRDgY0O8Z6WlG3qDg7N9ApjTEXM30AWxdSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbxqOpNz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722939482; x=1754475482;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q095l2RJzFBWigA3KKIRl76L9+fcP+Cmv7Gryw1bd/c=;
  b=JbxqOpNzBKpB7kxGWUR4Z9D/w+Qc2lUlN8ZWHOuz9E0pAfTu6jyrGHNH
   gGLGVH8GR1vOtAKvRew4QmxYPAe3/sUYIvWFd7ERwiZaP394stbMFL/W6
   dLB/iZQSd0MvRRk8NT0DkPFTEdT2thTnzhF/+Ci7qVXYGhtifnH8E6JuA
   9ompQCUbUx1mWWG80u8bpX5Ve6H4YXi7X/DX1izjFPLyxhxBhWwMGz9Kh
   dOahTXaGdAu0BcfFXj/bOmAMuTa+EVnvbwcQHeKXvWLcUqNp1O/tW8S5e
   d539+Hm4pCHckYB4tyXLy5k6KBykwonalxqIT9pFHkkHUFWDz2gTu70b/
   g==;
X-CSE-ConnectionGUID: PVBFQHgRSE2GiilHjMDtxw==
X-CSE-MsgGUID: Bmd3b4qCQ4ecst5oUfCbzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31608442"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="31608442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:18:01 -0700
X-CSE-ConnectionGUID: vK8Qoj0xRL2FspnVYrpeVA==
X-CSE-MsgGUID: OX5t62IBR7KAe/e+H31b8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56161762"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:17:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 13:17:56 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 3/6] platform/x86: asus-armoury: add dgpu tgp
 control
In-Reply-To: <20240806020747.365042-4-luke@ljones.dev>
Message-ID: <a9005405-bd70-28c3-f8f3-4b6f68846898@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-4-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Aug 2024, Luke D. Jones wrote:

> Implement the dgpu TGP control under the asus-armoury module using the
> fw_attributes class.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-armoury.c        | 20 ++++++++++++++++++++
>  drivers/platform/x86/asus-armoury.h        | 17 +++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 +++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index bb049ead00f9..31dbdacd8978 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -50,6 +50,9 @@
>  #define NVIDIA_BOOST_MAX 25
>  #define NVIDIA_TEMP_MIN 75
>  #define NVIDIA_TEMP_MAX 87
> +#define NVIDIA_POWER_MIN 0
> +#define NVIDIA_POWER_MAX 70
> +#define NVIDIA_POWER_DEFAULT 70
>  
>  /* Tunables provided by ASUS for gaming laptops */
>  struct rog_tunables {
> @@ -76,6 +79,11 @@ struct rog_tunables {
>  	u32 nv_temp_min;
>  	u32 nv_temp_max;
>  	u32 nv_temp_target;
> +
> +	u32 dgpu_tgp_default;
> +	u32 dgpu_tgp_min;
> +	u32 dgpu_tgp_max;
> +	u32 dgpu_tgp;
>  };
>  
>  static const struct class *fw_attr_class;
> @@ -474,6 +482,11 @@ ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_D
>  ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
>  		       nv_temp_default, nv_boost_min, nv_temp_max, 1,
>  		       "Set the Nvidia max thermal limit");
> +ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +			     "Read the base TGP value");
> +ATTR_GROUP_ROG_TUNABLE(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP, dgpu_tgp_default,
> +		       dgpu_tgp_min, dgpu_tgp_max, 1,
> +		       "Set the additional TGP on top of the base TGP");
>  
>  ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>  		       "Show the current mode of charging");
> @@ -501,6 +514,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
>  	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
>  	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> +	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
>  
>  	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>  	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> @@ -660,6 +675,11 @@ static void init_rog_tunables(struct rog_tunables *rog)
>  	rog->nv_temp_max = NVIDIA_TEMP_MIN;
>  	rog->nv_temp_max = NVIDIA_TEMP_MAX;
>  	rog->nv_temp_target = NVIDIA_TEMP_MIN;
> +
> +	rog->dgpu_tgp_default = NVIDIA_POWER_DEFAULT;
> +	rog->dgpu_tgp_min = NVIDIA_POWER_MIN;
> +	rog->dgpu_tgp_max = NVIDIA_POWER_MAX;
> +	rog->dgpu_tgp = NVIDIA_POWER_MAX;
>  }
>  
>  static int __init asus_fw_init(void)
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> index 146170f91e69..96d991383b8a 100644
> --- a/drivers/platform/x86/asus-armoury.h
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -83,6 +83,19 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>  	static struct kobj_attribute attr_##_attrname##_##_prop =                         \
>  		__ASUS_ATTR_RO(_attrname, _prop)
>  
> +/* Requires current_value show&|store */

"&|" ??

-- 
 i.


> +#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)                             \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);                           \
> +	static struct kobj_attribute attr_##_attrname##_type =                                 \
> +		__ASUS_ATTR_RO_AS(type, int_type_show);                                        \
> +	static struct attribute *_attrname##_attrs[] = {                                       \
> +		&attr_##_attrname##_current_value.attr, &attr_##_attrname##_display_name.attr, \
> +		&attr_##_attrname##_type.attr, NULL                                            \
> +	};                                                                                     \
> +	static const struct attribute_group _attrname##_attr_group = {                         \
> +		.name = _fsname, .attrs = _attrname##_attrs                                    \
> +	}
> +
>  /* Boolean style enumeration, base macro. Requires adding show/store */
>  #define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)                            \
>  	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);                           \
> @@ -97,6 +110,10 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>  		.name = _fsname, .attrs = _attrname##_attrs                                    \
>  	}
>  
> +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname) \
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                           \
> +	__ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)
> +
>  #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
>  	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
>  	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index c164e656ae0b..3ce0c63be4c1 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -133,6 +133,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
> +#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +
>  /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>  #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>  #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
> 

