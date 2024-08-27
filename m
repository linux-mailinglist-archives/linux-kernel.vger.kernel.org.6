Return-Path: <linux-kernel+bounces-303136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E99607E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A4A281B74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A019E825;
	Tue, 27 Aug 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtwuoXbU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762E4C634;
	Tue, 27 Aug 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756025; cv=none; b=cN42hWL8XlIS780vI1mGXGx4I9qCmAWEkwjN0aN1msMvkIbQ8ZMMt8J15PE9KJOlaRbu5icMXH+EbVKytp/8OMNMVE3RgIxn+iERGKqeJrTzdqz1s8HDrn2ringxE+WjrtRmLrb+mIY42ShRWvbEvq5a6yj3TRKub53+d6xKj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756025; c=relaxed/simple;
	bh=0cwnZgpNLcFVVJ9Sb3+sgkuw4pLRegm1J+e48W5+bIc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=soWpU89H7WKxjvY7gExE+jKvYFS4MFSdvFjEuHpzmBdX5KMXY/LwjZsnOS/nCuwEPWV150dfSHzT4Jium/fpo21bGj0pbZ+mIhT3/JN5SARn6tipWpKgRaIP9vCCOftDZ0Gy5RDrWKOqHsGQ2eJRVVWL9INutm+enk7NZR0aOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtwuoXbU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724756024; x=1756292024;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0cwnZgpNLcFVVJ9Sb3+sgkuw4pLRegm1J+e48W5+bIc=;
  b=NtwuoXbUh3mFaw82AccsT+m3+LUw46Zph7f8aeMxqLMB1Lx74osaJ+B4
   VHSIzusyLHafaATS5T+VzPB8njJWx0lHic0DIJzaQLt/DqKCujJIdn4Jr
   Vz20YePGwCv3xa1PHNF5vRGSpIu9u2ZyRKQc5Tpgj6Y1B7WOiyoz3gaIi
   KgFjsRtystQNv2u7y55/DPM2duSvHjfGMLXuK7Q2yyGc9J3m3JmRgTSXm
   YTB4+xyo939kOJxNcxLubEKqp5gnNDIN6aYdGmqJ+5UHjN+fxiXj/sVKe
   GUVSjrvpYfvGJyB0qNATny/GhJPaudMmYqT9EvxdE576XlV0WtugRSbyb
   A==;
X-CSE-ConnectionGUID: yn9r8z3UR/a/1MrQWM7Hvg==
X-CSE-MsgGUID: gaoNVIDvTciAiHr7VKwk1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23378903"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23378903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:53:43 -0700
X-CSE-ConnectionGUID: 2JrTYpy2QAm9jY1+zcY5jw==
X-CSE-MsgGUID: +KdlvFXJSXe7SGJFPdy0tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="100323888"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:53:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 13:53:34 +0300 (EEST)
To: Perry Yuan <perry.yuan@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, Mario.Limonciello@amd.com, 
    Borislav.Petkov@amd.com, kprateek.nayak@amd.com, Alexander.Deucher@amd.com, 
    Xinmei.Huang@amd.com, bharathprabhu.perdoor@amd.com, 
    poonam.aggrwal@amd.com, Li.Meng@amd.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Xiaojian.Du@amd.com
Subject: Re: [PATCH 08/11] platform/x86/: hfi: add online and offline callback
 support
In-Reply-To: <2661e74beceb9198d0baefe1f145080ef2b812cb.1724748733.git.perry.yuan@amd.com>
Message-ID: <0242c3fa-74b8-63d5-dc2d-ae2f2519a281@linux.intel.com>
References: <cover.1724748733.git.perry.yuan@amd.com> <2661e74beceb9198d0baefe1f145080ef2b812cb.1724748733.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Perry Yuan wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> There are some firmware parameters that need to be configured
> when a CPU core is brought online or offline.
> 
> when CPU is online, it will initialize the workload classification
> parameters to CPU firmware which will trigger the workload class ID
> updating function.
> 
> Once the CPU is going to offline, it will need to disable the workload
> classification function and clear the history.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 90 ++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index cd5f2b708ebf..57b642c4c522 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -154,6 +154,7 @@ static int __percpu *amd_hfi_ipcc_scores;
>  
>  static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *info, int cpu);
>  static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data);
> +static int amd_hfi_set_state(unsigned int cpu, bool state);

Unnecessary.

>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
> @@ -318,6 +319,87 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>  	return 0;
>  }
>  
> +static int amd_hfi_set_state(unsigned int cpu, bool state)
> +{
> +	int ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);
> +	if (ret)
> +		return ret;
> +
> +	return wrmsrl_on_cpu(cpu, AMD_WORKLOAD_HRST, 0x1);
> +}
> +
> +/*
> + * amd_hfi_online() - Enable workload classification on @cpu
> + * @cpu: CPU in which the workload classification will be enabled
> + *
> + */
> +static int amd_hfi_online(unsigned int cpu)
> +{
> +	struct amd_hfi_cpuinfo *hfi_info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +	struct amd_hfi_classes *hfi_classes;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!hfi_info))

Can this ever trigger??

> +		return -EINVAL;

Definitely wrong error code to return since this has nothing to do with 
user input being invalid.

> +	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	mutex_lock(&hfi_cpuinfo_lock);

Use guard().

> +	cpumask_set_cpu(cpu, hfi_info->cpus);
> +
> +	/*
> +	 * Check if @cpu as an associated, initialized and ranking data must be filled
> +	 */
> +	hfi_classes = hfi_info->amd_hfi_classes;
> +	if (!hfi_classes)
> +		goto unlock;
> +
> +	/* Enable the workload classification interface */
> +	ret = amd_hfi_set_state(cpu, true);
> +	if (ret)
> +		pr_err("wct enable failed for cpu %d\n", cpu);

Use %u for unsigned int.

> +
> +	mutex_unlock(&hfi_cpuinfo_lock);
> +	return 0;
> +
> +unlock:
> +	free_cpumask_var(hfi_info->cpus);
> +	mutex_unlock(&hfi_cpuinfo_lock);
> +	return ret;
> +}
> +
> +/*
> + * amd_hfi_offline() - Disable workload classification on @cpu
> + * @cpu: CPU in which the workload classification will be disabled
> + *
> + * Remove @cpu from those covered by its HFI instance.
> + *
> + */
> +static int amd_hfi_offline(unsigned int cpu)
> +{
> +	struct amd_hfi_cpuinfo *hfi_info = &per_cpu(amd_hfi_cpuinfo, cpu);
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!hfi_info))
> +		return -EINVAL;
> +
> +	mutex_lock(&hfi_cpuinfo_lock);
> +
> +	/* Disable the workload classification interface */
> +	ret = amd_hfi_set_state(cpu, false);
> +	if (ret)
> +		pr_err("wct disable failed for cpu %d\n", cpu);

%u

> +
> +	mutex_unlock(&hfi_cpuinfo_lock);
> +
> +	free_cpumask_var(hfi_info->cpus);
> +
> +	return 0;
> +}
> +
>  static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
>  {
>  	int cpu;
> @@ -467,6 +549,14 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_exit;
>  
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> +			amd_hfi_online,
> +			amd_hfi_offline);
> +	if (ret < 0) {
> +		pr_warn("failed to setup cpuhp state! (%d)\n", ret);
> +		return ret;
> +	}
> +
>  	dev_dbg(&pdev->dev, "%s driver registered.\n", pdev->name);
>  
>  	return 0;
> 

-- 
 i.


