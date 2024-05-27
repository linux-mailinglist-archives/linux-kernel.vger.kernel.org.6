Return-Path: <linux-kernel+bounces-190399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7718CFDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90462841F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65413AD03;
	Mon, 27 May 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVtaiGLc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234A8830;
	Mon, 27 May 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804308; cv=none; b=e7xLwzJLTKhgfFP6Hr5yYMXCv6iYevbaNaauZ5w0xAxEYAnSB9xVeqQzLeSEIxuTfZfWDEnYTbiO7F9zMi0nAWqM3sXrn+SJrHSm271wiAuJKZHSQkPaa82sgU8gBc36d8LsX2rlPiOSUOyiUSYSCzA/qF+3iMcuNs8SXjaSCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804308; c=relaxed/simple;
	bh=GzwoFusqbe3dYiKCziSJoWgL9tO9Y1oBZvLpS5yQCCE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oa6srNOCjwppG/4Wm2vlXR6pL9IIGthlq7TL26nDpOyYFS+u6e9eg3UUWiq/a4pjYZeCt0EHr2isM8fARwER+dbHNq1hbFq6gT2wJGTfyZY6u/pzMSGPshIn3wznr+71QoTBrHROpGJxma9s16+CjJCi5RA0cLThNf8TpxKO0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVtaiGLc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716804307; x=1748340307;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GzwoFusqbe3dYiKCziSJoWgL9tO9Y1oBZvLpS5yQCCE=;
  b=nVtaiGLcFnMgQp8RE0cSfxKHQaQWdcj5rV8nD1agevPvUCuwUgRE36Tl
   W8QW+gtLzsJ62bJdQMVZYpoUs1u3IIlvvkckHTL6kgywLk6ofts/WEO+z
   Ko5ouEBx9ypiDopBxdw40PiQj5G6Kiu65jpLpKN2NZF963Lh9sn7FwcyE
   2S0+zqdKeov/Mt0KG2bUG85o40oTXlaWtmTK0YIYB/GodVSJIsB+AIweg
   lSc1td117DLsaa4gE2FckemkzJwy5cdyFNQOardbmyfQrpFvCMuSE5FaY
   bYWZ8iX2sFoO3/UFTQxNkn3e5g8FpGvwhRGSkCKy7T/KvHgduNBw+5oca
   g==;
X-CSE-ConnectionGUID: cXI8CmntRC6uq5EfInlGGg==
X-CSE-MsgGUID: DW5q8OFYS3qQ6j3EVnWzYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16937984"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16937984"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:01:14 -0700
X-CSE-ConnectionGUID: iyU++eq1TdmTrpSi0Dtk/w==
X-CSE-MsgGUID: D2LB2epyTIGf0pYUWoT/ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39690873"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:01:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 13:01:07 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: ISST: Add model specific loading for
 common module
In-Reply-To: <20240509230236.1494326-2-srinivas.pandruvada@linux.intel.com>
Message-ID: <0fe40e4c-856f-ec6c-3b62-6721954b1b62@linux.intel.com>
References: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com> <20240509230236.1494326-2-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 May 2024, Srinivas Pandruvada wrote:

> SST common module is loaded when model specific or TPMI SST driver
> registers for services. There are model specific features used in SST
> common modules which are checked with a CPU model list. So, this module
> is model specific.
> 
> There are some use cases where loading the common module independently
> only on the supported CPU models helps. The first use case is for
> preventing SST TPMI module loading if the model specific features are
> not implemented. The second use case for presenting information to
> user space when SST is used in OOB (Out of Band) mode.
> 
> 1.
> With TPMI, SST interface is architectural. This means that no need to add
> new PCI device IDs for new CPU models. This means that there can be lag
> in adding CPU models for the model specific features in the common
> module. For example, before adding CPU model to GRANITERAPIDS_D to
> hpm_cpu_ids[], SST is still functional for some features and but will
> get/set wrong data for features like SST-CP. This is because IOCTL
> ISST_IF_GET_PHY_ID, will not give correct mapping for newer CPU models.
> So adding explicit model check during load time will prevent such cases.
> For unsupported CPU models, common driver will fail to load and hence
> dependent modules will not be loaded.
> 
> 2.
> When the SST TPMI features are controlled by some OOB agent (not from OS
> interface), even if the CPU model is supported, there will be no user
> space interface available for tools as SST TPMI modules will not
> be loaded. User space interface is registered when TPMI modules call
> isst_if_cdev_register(). Even in this case user space orchestrator
> software needs to get power domain information to schedule workload and
> get/set turbo ratio limits. This information is exposed by the common
> module using IOCTLs ISST_IF_GET_PHY_ID and ISST_IF_MSR_COMMAND
> respectively. Since the user space MSR access can be locked, direct MSR
> access from the user space is not an option using /dev/cpu/*/msr.
> 
> Converge all the existing model checks to one common place and
> use driver data to differentiate. On successful model check
> call isst_misc_reg().
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com
> ---
> Note:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Andy's Reviewed-by was for one version before Rafael and Rui's
> comments were addressed. So didn't add it before "---". 
> We can add it if there is no issue from Andy.
> 
> Also incorporated changes suggested by "Wysocki, Rafael J"
> <rafael.j.wysocki@intel.com>.
> 
> We have all the models supported till date are already in 6.9
> kernel. So this is more for future proofing for the first use case.
> 
> 
>  .../intel/speed_select_if/isst_if_common.c    | 80 +++++++++++++------
>  1 file changed, 56 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index 88a17be7cb7e..f886f9369fad 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -718,12 +718,6 @@ static struct miscdevice isst_if_char_driver = {
>  	.fops		= &isst_if_char_driver_ops,
>  };
>  
> -static const struct x86_cpu_id hpm_cpu_ids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
> -	{}
> -};
> -
>  static int isst_misc_reg(void)
>  {
>  	mutex_lock(&punit_misc_dev_reg_lock);
> @@ -731,12 +725,6 @@ static int isst_misc_reg(void)
>  		goto unlock_exit;
>  
>  	if (!misc_usage_count) {
> -		const struct x86_cpu_id *id;
> -
> -		id = x86_match_cpu(hpm_cpu_ids);
> -		if (id)
> -			isst_hpm_support = true;
> -
>  		misc_device_ret = isst_if_cpu_info_init();
>  		if (misc_device_ret)
>  			goto unlock_exit;
> @@ -784,8 +772,6 @@ static void isst_misc_unreg(void)
>   */
>  int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
>  {
> -	int ret;
> -
>  	if (device_type >= ISST_IF_DEV_MAX)
>  		return -EINVAL;
>  
> @@ -803,15 +789,6 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
>  	punit_callbacks[device_type].registered = 1;
>  	mutex_unlock(&punit_misc_dev_open_lock);
>  
> -	ret = isst_misc_reg();
> -	if (ret) {
> -		/*
> -		 * No need of mutex as the misc device register failed
> -		 * as no one can open device yet. Hence no contention.
> -		 */
> -		punit_callbacks[device_type].registered = 0;
> -		return ret;
> -	}
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(isst_if_cdev_register);
> @@ -827,7 +804,6 @@ EXPORT_SYMBOL_GPL(isst_if_cdev_register);
>   */
>  void isst_if_cdev_unregister(int device_type)
>  {
> -	isst_misc_unreg();
>  	mutex_lock(&punit_misc_dev_open_lock);
>  	punit_callbacks[device_type].def_ioctl = NULL;
>  	punit_callbacks[device_type].registered = 0;
> @@ -837,5 +813,61 @@ void isst_if_cdev_unregister(int device_type)
>  }
>  EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
>  
> +#define SST_HPM_SUPPORTED		0x01
> +#define SST_MBOX_SUPPORTED		0x02
> +
> +#define MSR_OS_MAILBOX_INTERFACE        0xB0
> +#define MSR_OS_MAILBOX_DATA             0xB1
> +
> +static const struct x86_cpu_id isst_cpu_ids[] = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	SST_HPM_SUPPORTED),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	SST_HPM_SUPPORTED),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	0),
> +	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	SST_HPM_SUPPORTED),
> +	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		SST_MBOX_SUPPORTED),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, isst_cpu_ids);
> +
> +static int __init isst_if_common_init(void)
> +{
> +	const struct x86_cpu_id *id;
> +
> +	id = x86_match_cpu(isst_cpu_ids);
> +	if (!id)
> +		return -ENODEV;
> +
> +	if (!id->driver_data)
> +		goto misc_reg;
> +
> +	if (id->driver_data == SST_HPM_SUPPORTED) {
> +		isst_hpm_support = true;
> +		goto misc_reg;
> +	}
> +
> +	if (id->driver_data == SST_MBOX_SUPPORTED) {
> +		u64 data;
> +
> +		/* Can fail only on some Skylake-X generations */
> +		if (rdmsrl_safe(MSR_OS_MAILBOX_INTERFACE, &data) ||
> +		    rdmsrl_safe(MSR_OS_MAILBOX_DATA, &data))
> +			return -ENODEV;

This Skylake bit seems to come out of nowhere which is odd for a refactor 
patch, can it be in own patch with proper commit message written for it?

-- 
 i.

> +	}
> +
> +misc_reg:
> +	return isst_misc_reg();
> +}
> +module_init(isst_if_common_init)
> +
> +static void __exit isst_if_common_exit(void)
> +{
> +	isst_misc_unreg();
> +}
> +module_exit(isst_if_common_exit)
> +
>  MODULE_DESCRIPTION("ISST common interface module");
>  MODULE_LICENSE("GPL v2");
> 

