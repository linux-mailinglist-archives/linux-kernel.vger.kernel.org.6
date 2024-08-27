Return-Path: <linux-kernel+bounces-303110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5A960783
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E61C22B76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C219D897;
	Tue, 27 Aug 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HefUqh7l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE3182B2;
	Tue, 27 Aug 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754784; cv=none; b=u/R6GfpdpXsGdnLeky8+gKw6pcrXULIoG0RaKG+qq9Tqr5b6/Rmmd4Avt6E3HB7jcVIO/tJFtBzLFoM35W0e6W7DIJAKrEnP2BvCkpr5t3rPu9AwTSdbh2ao8s5Hgde7wS60YAc4SrlXFRfstaXLVW0PQx0r8JJl9CKikjkBEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754784; c=relaxed/simple;
	bh=XKrROJB0xH11nSWZB7HwBkAn4vyjBq3hOmThW6LISgg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UlMRpROeKeTKGvsHSI51oRSctLQZjz8D9+3A6FIAYvkcuHWyC+dF3YIFCB03Pqv6YUIyXO+X3WjgB6lzKxILp5RS2XmLTWFIgp2HQI+XjGFr/RAnkNqdovY6yYFCFvN7UhqotsjQ8vnYI8Y+jE8hXXn5NoKobVpa0XLI/4olNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HefUqh7l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724754782; x=1756290782;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XKrROJB0xH11nSWZB7HwBkAn4vyjBq3hOmThW6LISgg=;
  b=HefUqh7lZHNFpR5p6IgUs43WIHg4xSVfa1fc76fH7Ab72xpu8UJDrw3h
   LE+bPnTHrfv5OISYxBSpqHwyM25xbIc9xqdzK+IDBJM7INFINfXb9X/Nv
   6z0qN7dIZBjElhWZnIwxfTlDi2ZJwXJ5H6p1sasbgaqNAi6brBlX+Q+OF
   WH+mUAqAXLK1UGzVgIcIDpS1/gZDzewqmyuVI73c20c4ImieoKnxVIhx2
   ICUB5pSZIesIrHrZUVQIpKE5/uccSeSKXIIe104jgZkUBPa5xEpKk4ykJ
   eNqg7/SyedN1eRaELyvsY0Qcq0P2pbQ/Ub8JMQ39ctxOTAtnOhTw/oREN
   A==;
X-CSE-ConnectionGUID: VIm32m6+SuaBsAzTXU+Crw==
X-CSE-MsgGUID: plPoBSyZTQOby4wao4GXZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27102893"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27102893"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:33:02 -0700
X-CSE-ConnectionGUID: NAmmIA8cRam6GOvsnLdwAA==
X-CSE-MsgGUID: 2E2d8ggLRP+S1L6nKp9xgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="86004060"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:32:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 13:32:53 +0300 (EEST)
To: Perry Yuan <perry.yuan@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, Mario.Limonciello@amd.com, 
    Borislav.Petkov@amd.com, kprateek.nayak@amd.com, Alexander.Deucher@amd.com, 
    Xinmei.Huang@amd.com, bharathprabhu.perdoor@amd.com, 
    poonam.aggrwal@amd.com, Li.Meng@amd.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Xiaojian.Du@amd.com
Subject: Re: [PATCH 07/11] platform/x86/: hfi: init per-cpu scores for each
 class
In-Reply-To: <b913765989396d62f5184d32932250ee434cd0da.1724748733.git.perry.yuan@amd.com>
Message-ID: <2c1a18c9-6ceb-e135-876f-f832f5696124@linux.intel.com>
References: <cover.1724748733.git.perry.yuan@amd.com> <b913765989396d62f5184d32932250ee434cd0da.1724748733.git.perry.yuan@amd.com>
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
> Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
> and performance score data for each class.
> 
> `Classic core` and `Dense core` are ranked according to those values as
> energy efficiency capability or performance capability.
> OS scheduler will pick cores from the ranking list on each class ID for
> the thread which provide the class id got from hardware feedback
> interface.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 65 ++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 50f6ca9c148a..cd5f2b708ebf 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -111,6 +111,7 @@ struct amd_hfi_data {
>  	raw_spinlock_t		table_lock;
>  	struct acpi_subtable_header	*pcct_entry;
>  	struct amd_hfi_metadata		*hfi_meta;
> +	raw_spinlock_t		hfi_data_lock;
>  };
>  
>  /**
> @@ -130,6 +131,7 @@ struct amd_hfi_classes {
>   * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>   * @cpu:		cpu index
>   * @cpus:		cpu mask of cpus
> + * @apic_id:		apic id of the current cpu
>   * @class_index:	workload class ID index
>   * @nr_classa:		max number of workload class supported
>   * @amd_hfi_classes:	current cpu workload class ranking data
> @@ -139,6 +141,7 @@ struct amd_hfi_classes {
>  struct amd_hfi_cpuinfo {
>  	int		cpu;
>  	cpumask_var_t	cpus;
> +	u32		apic_id;
>  	s16		class_index;
>  	u8		nr_class;
>  	struct amd_hfi_classes	*amd_hfi_classes;
> @@ -146,6 +149,12 @@ struct amd_hfi_cpuinfo {
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static DEFINE_MUTEX(hfi_cpuinfo_lock);
> +static int __percpu *amd_hfi_ipcc_scores;
> +
> +static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *info, int cpu);
> +static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data);

Looks unnecessary forward declarations. In general, we try to arrange code 
so that forward declarations are not required.

> +
>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
>  	int cpu_index;
> @@ -293,6 +302,40 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  
>  	mutex_destroy(&dev->lock);
>  }
> +
> +static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
> +{
> +	int i, *hfi_scores;
> +	u8 nr_classes = hfi_cpuinfo->nr_class;

Reverse xmas tree order.

> +
> +	hfi_scores = per_cpu_ptr(amd_hfi_ipcc_scores, cpu);
> +	if (!hfi_scores)
> +		return -ENODEV;
> +
> +	for (i = 0;  i < nr_classes; i++)

Extra space.

> +		WRITE_ONCE(hfi_scores[i], hfi_cpuinfo->amd_hfi_classes[i].perf);
> +
> +	return 0;
> +}
> +
> +static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
> +{
> +	int cpu;
> +	int ret;
> +
> +	raw_spin_lock_irq(&amd_hfi_data->hfi_data_lock);

Again, this is called from .probe so why you need a raw spinlock???

> +	for_each_online_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +	raw_spin_unlock_irq(&amd_hfi_data->hfi_data_lock);
> +
> +	return 0;
> +}
> +
>  static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  		struct amd_hfi_data *amd_hfi_data)
>  {
> @@ -344,6 +387,19 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int alloc_amd_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
> +{
> +	struct amd_hfi_metadata *hfi_meta = amd_hfi_data->hfi_meta;
> +
> +	amd_hfi_ipcc_scores = __alloc_percpu(sizeof(*amd_hfi_ipcc_scores) *
> +			hfi_meta->n_classes,
> +			sizeof(*amd_hfi_ipcc_scores));

Align these continuation lines better.

-- 
 i.

> +	if (WARN_ON(!amd_hfi_ipcc_scores))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static const struct acpi_device_id amd_hfi_platform_match[] = {
>  	{ "AMDI0104", 0},
>  	{ }
> @@ -385,6 +441,7 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	amd_hfi_data->dhandle = dhandle;
>  
>  	raw_spin_lock_init(&amd_hfi_data->table_lock);
> +	raw_spin_lock_init(&amd_hfi_data->hfi_data_lock);
>  	mutex_init(&amd_hfi_data->lock);
>  
>  	platform_set_drvdata(pdev, amd_hfi_data);
> @@ -402,6 +459,14 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  
>  	amd_hfi_data->hfi_meta->dynamic_rank_feature =
>  					cpuid_ebx(AMD_HETERO_CPUID_27) & 0xF;
> +
> +	if (alloc_amd_hfi_ipcc_scores(amd_hfi_data))
> +		goto err_exit;
> +
> +	ret = update_hfi_ipcc_scores(amd_hfi_data);
> +	if (ret)
> +		goto err_exit;
> +
>  	dev_dbg(&pdev->dev, "%s driver registered.\n", pdev->name);
>  
>  	return 0;
> 

