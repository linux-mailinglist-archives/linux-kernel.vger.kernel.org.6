Return-Path: <linux-kernel+bounces-332468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD097BA29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B511F25045
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32517BECB;
	Wed, 18 Sep 2024 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y10UaXby"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3517A59B;
	Wed, 18 Sep 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651796; cv=none; b=nHoQ6MnJPPaippa86JgrmXq5ULSvLZJC7Dx4f64QdM3i2f5SSAZPrx9qMlNNFG5r4tL/dPJGUM8R3mtGLAh1TBfd9T/XTol8cJ1fJbnp/r6vxfQZKAfClN0VLVcQrZypmyDcOeb3KQxTGjd5xqR0/gY2w7czsV23OuRu2iZrBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651796; c=relaxed/simple;
	bh=JeafycqQxEl4VvkrF3w8mPrUTJJvNEmTotRgPXPeDCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=io4EdOj8gkGkkgEdzSfAgzk5mBkK+cVkbU8yfFPNPbMQSYNBMxBfY6kRD9BDblERte3/+2tyaIRhyUKOdhL2XL6XU2HeuQs/uq3cj5gIApdUtB/nVdyOEGbTqtjLnfAwUsQNPurhkCx3HKNArGZuLbrX0tmMZI9CVNbpQuLI1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y10UaXby; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726651794; x=1758187794;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JeafycqQxEl4VvkrF3w8mPrUTJJvNEmTotRgPXPeDCE=;
  b=Y10UaXbycaXdeUDje2mw2DacnLUEtMNikBBO3jXj4l+jNPngCRhkHRRN
   4+O5PK4eQ+iTciZ/xrr2EiPsFcVXcxyj8nasLt/FOoCVT9TZptwc1kpw7
   WBVV7us3ZrGbJy94kYMqXWNsg4zEotJWSJiuSgma6FWxgj5915Z5H15ns
   N0KaziV4AObjtPlVYug2O1QdR4M4O6k4U+N/ZdH+SkTSLTV8gmm0cbczS
   NNZIS8SUzd/k7oTE9RqLbZRZDQgPMkCcqntAdZ4v43u8jpjHUMuDZTxn5
   tMargWTURi6+1exUvcOpLNzgakIN7FR2c684Hr4FVTlou8x6EkHxHlKvZ
   A==;
X-CSE-ConnectionGUID: ZucXK3GeS1at4vQ0pnEUGA==
X-CSE-MsgGUID: qzgFCnzARDeAEROkTxjCEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="43024080"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="43024080"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 02:29:54 -0700
X-CSE-ConnectionGUID: M6XzF8VwRy+CDitQq/cZrw==
X-CSE-MsgGUID: clrNjX+sRay4U6eosKHC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="70272235"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 02:29:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, Daniel
 Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, Faith
 Ekstrand <faith.ekstrand@collabora.com>, Francois Dugast
 <francois.dugast@intel.com>, =?utf-8?Q?Jos=C3=A9?= Roberto de Souza
 <jose.souza@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nirmoy Das <nirmoy.das@intel.com>, Philippe Lecluse
 <philippe.lecluse@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/query: Refactor copy_to_user() usage in four
 functions
In-Reply-To: <d1f1eb7f-1de7-4d73-a7d0-00cc1eac3d5d@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <d1f1eb7f-1de7-4d73-a7d0-00cc1eac3d5d@web.de>
Date: Wed, 18 Sep 2024 12:29:42 +0300
Message-ID: <87plp1b989.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 18 Sep 2024, Markus Elfring <Markus.Elfring@web.de> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2024 09:43:07 +0200
>
> Assign return values from copy_to_user() calls to additional local variables
> so that four kfree() calls and return statements can be omitted accordingly.
>
> This issue was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/xe/xe_query.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index 5246a4a2740e..6195e720176d 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -220,13 +220,11 @@ static int query_engines(struct xe_device *xe,
>
>  	engines->num_engines = i;
>
> -	if (copy_to_user(query_ptr, engines, size)) {
> +	{

Please don't leave blocks like this behind when you remove the if.

BR,
Jani.

> +		unsigned long ctu = copy_to_user(query_ptr, engines, size);
>  		kfree(engines);
> -		return -EFAULT;
> +		return ctu ? -EFAULT : 0;
>  	}
> -	kfree(engines);
> -
> -	return 0;
>  }
>
>  static size_t calc_mem_regions_size(struct xe_device *xe)
> @@ -344,13 +342,11 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
>  	config->info[DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY] =
>  		xe_exec_queue_device_get_max_priority(xe);
>
> -	if (copy_to_user(query_ptr, config, size)) {
> +	{
> +		unsigned long ctu = copy_to_user(query_ptr, config, size);
>  		kfree(config);
> -		return -EFAULT;
> +		return ctu ? -EFAULT : 0;
>  	}
> -	kfree(config);
> -
> -	return 0;
>  }
>
>  static int query_gt_list(struct xe_device *xe, struct drm_xe_device_query *query)
> @@ -414,13 +410,11 @@ static int query_gt_list(struct xe_device *xe, struct drm_xe_device_query *query
>  			REG_FIELD_GET(GMD_ID_REVID, gt->info.gmdid);
>  	}
>
> -	if (copy_to_user(query_ptr, gt_list, size)) {
> +	{
> +		unsigned long ctu = copy_to_user(query_ptr, gt_list, size);
>  		kfree(gt_list);
> -		return -EFAULT;
> +		return ctu ? -EFAULT : 0;
>  	}
> -	kfree(gt_list);
> -
> -	return 0;
>  }
>
>  static int query_hwconfig(struct xe_device *xe,
> @@ -444,13 +438,11 @@ static int query_hwconfig(struct xe_device *xe,
>
>  	xe_guc_hwconfig_copy(&gt->uc.guc, hwconfig);
>
> -	if (copy_to_user(query_ptr, hwconfig, size)) {
> +	{
> +		unsigned long ctu = copy_to_user(query_ptr, hwconfig, size);
>  		kfree(hwconfig);
> -		return -EFAULT;
> +		return ctu ? -EFAULT : 0;
>  	}
> -	kfree(hwconfig);
> -
> -	return 0;
>  }
>
>  static size_t calc_topo_query_size(struct xe_device *xe)
> --
> 2.46.0
>

-- 
Jani Nikula, Intel

