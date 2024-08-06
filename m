Return-Path: <linux-kernel+bounces-275975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6267948CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E343B2426E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151C1BE250;
	Tue,  6 Aug 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGiuozis"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D51BDA86;
	Tue,  6 Aug 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939627; cv=none; b=RAkzv62+1G5kZJnw69KjuogYE/G8Dev6sHJur949nsboSnAqMCwOP9MH4/K2mF7o1LBkkY5YV+jvCyPO0hnVwqii3DOvTPKtqWPXMDP0XtUeuaif3HipMQ9LQvsnRFPnminQ9/h3nfmd6wUMCuub1vlICROx76nkGixFrZk+ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939627; c=relaxed/simple;
	bh=U+g0GIU8RRfE++oqN+BfWKyYtmzIe0pYd55mBqOrJ/0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xvdypf70ibVDjvKDsN8ZOj1E/x33oKu7U9ZNw0I+Wv4eNKQ7ksvfpY9V0LHgngwtIaM5/hz+BRXSbd1k5Csz7T5pXQ+mN9wNP52HmWcf04jh+dnIZkpx2RbaaPcS90r28L7h3oC0InKN2Jf7jqsjd6kW6EQMChlbTCpB+K8e23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGiuozis; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722939626; x=1754475626;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U+g0GIU8RRfE++oqN+BfWKyYtmzIe0pYd55mBqOrJ/0=;
  b=lGiuozisie0j5WaxWMBZUcnDGnvnwR9F+KBod5hPe68MJ/LoVzEed1Un
   6aVlGXBty98qlnt2SzMgpf1WBr8OV9Kw16E5JBbFcJNUUI4xC9lkqOFKW
   BMoy2FnQBiwYIE1WS0b7B2BgfTZms4lGoAtNLBewS3XiqMy6oiwipkx4J
   SXPpIrcFKa+EBQmdjhFfuBmGpl/Fxwl2RuZPP7adlC/x11e81ppGjtcPC
   incX75JUtOH9s8Z9FaNqzpba9ldXnOA4fsBCfHIXEVBuIiT5wLud0Wr8b
   iQh6crUK8sLcbnO18Wk9LqZdyV2Zv/ZEwN4vop7RB/c9sjLjRdfsOMQAi
   w==;
X-CSE-ConnectionGUID: CQDK6zFrS7yassX/sRcflw==
X-CSE-MsgGUID: +HMG9xnvQoCH28YZYCNsyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="24811567"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="24811567"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:20:25 -0700
X-CSE-ConnectionGUID: Etuog58sTNKD8CSRUAYHdQ==
X-CSE-MsgGUID: 3+2a+bDWSWOMXF8BUsiNWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56411439"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:20:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 13:20:19 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 4/6] platform/x86: asus-armoury: add apu-mem control
 support
In-Reply-To: <20240806020747.365042-5-luke@ljones.dev>
Message-ID: <c7080912-7772-96df-0ae0-07903edbba1a@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-5-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Aug 2024, Luke D. Jones wrote:

> Implement the APU memory size control under the asus-armoury module using
> the fw_attributes class.
> 
> This allows the APU allocated memory size to be adjusted depending on
> the users priority. A reboot is required after change.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-armoury.c        | 115 +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   1 +
>  2 files changed, 116 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 31dbdacd8978..412e75c652a4 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -462,6 +462,120 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj,
>  WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
>  ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
>  
> +/* Device memory available to APU */
> +
> +static ssize_t apu_mem_current_value_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	int err;
> +	u32 mem;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
> +	if (err)
> +		return err;
> +
> +	switch (mem) {
> +	case 256:
> +		mem = 0;
> +		break;
> +	case 258:
> +		mem = 1;
> +		break;
> +	case 259:
> +		mem = 2;
> +		break;
> +	case 260:
> +		mem = 3;
> +		break;
> +	case 261:
> +		mem = 4;
> +		break;
> +	case 262:
> +		/* This is out of order and looks wrong but is correct */
> +		mem = 8;
> +		break;
> +	case 263:
> +		mem = 5;
> +		break;
> +	case 264:
> +		mem = 6;
> +		break;
> +	case 265:
> +		mem = 7;
> +		break;
> +	default:
> +		mem = 4;
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%d\n", mem);

%u

> +}
> +
> +static ssize_t apu_mem_current_value_store(struct kobject *kobj,
> +				struct kobj_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 requested, mem;
> +
> +	result = kstrtou32(buf, 10, &requested);
> +	if (result)
> +		return result;
> +
> +	switch (requested) {
> +	case 0:
> +		mem = 0;
> +		break;
> +	case 1:
> +		mem = 258;
> +		break;
> +	case 2:
> +		mem = 259;
> +		break;
> +	case 3:
> +		mem = 260;
> +		break;
> +	case 4:
> +		mem = 261;
> +		break;
> +	case 5:
> +		mem = 263;
> +		break;
> +	case 6:
> +		mem = 264;
> +		break;
> +	case 7:
> +		mem = 265;
> +		break;
> +	case 8:
> +		/* This is outof order and looks wrong but is correct */

outof -> out of

> +		mem = 262;
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> +	if (err) {
> +		pr_warn("Failed to set apu_mem: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("APU memory changed to %dGB, reboot required\n", requested);

%u

> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +
> +static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");

IIRC, space or newline is the usual separator for possible values sysfs 
files. I don't think I've ever seen ; used.

-- 
 i.

> +}
> +ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
> +
>  /* Simple attribute creation */
>  ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
>  		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> @@ -516,6 +630,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
>  	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
>  	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> +	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
>  
>  	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>  	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 3ce0c63be4c1..287206a03763 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -135,6 +135,7 @@
>  
>  #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
>  #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
>  
>  /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>  #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
> 

