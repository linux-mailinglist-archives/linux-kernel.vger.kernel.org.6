Return-Path: <linux-kernel+bounces-177255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D78C3C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28DBB20DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4B146D74;
	Mon, 13 May 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgYfy9Y9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E801474A0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585153; cv=none; b=XyejlzO5MSfaG5OrPHWPzq99mM8BEIgRqnE0VPFik+c4UguR2WUJ1Cc1v6XOuKjUor44IqDFqzilHuIWYR4ZKPxfNpSLcmmxeamioX8hrptWTPDxalEvCoHNrDM5Qb+X3fgptYKtV0f1UGH8AJJWu6+KiK26/MqmVLk3yDAlHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585153; c=relaxed/simple;
	bh=wMEuAI0hnZW1lo/a7h1KVjA6PRjEKyLoM0M7DADEqcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fg3PSqxlRU/euWI6uGjpaBBP+SwmEYyS/vSfQ6Yx7Ltw5q24wRPRQCQ8f9GFk5bn5e8Va2u4MZeCevKTtgFyoVDfqfCGd9CE55fTeZYtWK0XRCYB5QgWsxPHsEYycjm7v49g2KCII5p0p81Dm/INho7xYXXkznn9o3lntRfccWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgYfy9Y9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715585152; x=1747121152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wMEuAI0hnZW1lo/a7h1KVjA6PRjEKyLoM0M7DADEqcA=;
  b=MgYfy9Y9g11Cah784Hk+WlIdRkfZQM0eiMDGhdnAkSzp89iNXySOZJru
   yQVvF541+HGUFR5rhKpFySaLzrTLVSa9ENVXf3P3sVtPISufs1+yMGMlb
   z1fx2tE7tbVFDreioIxjfuLNq/kZPwqk47oCC25HfloV2d+w+qRvG44Ka
   Q8IRGfSms0AO2Zo1TTtvxLBf5EoMCkK+Y+M4zYRCjuOkrgGVVukfv8192
   ymKhXGf034WHILqDXivolT7K6satuFlhLrX9s2goRWK5qww0jpKksw8ph
   qmhUERN+PulRGSkElDgintGcp+HTnkKzEtnZi4xy5KUE2kR+CCoK6+/9C
   Q==;
X-CSE-ConnectionGUID: mEuip9srQ5WCHEGzJojjZA==
X-CSE-MsgGUID: Xy0PrlOjSD+xq69pCpSS7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29019684"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="29019684"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 00:25:51 -0700
X-CSE-ConnectionGUID: B0o9cwonRVSGhjNXnaLsSw==
X-CSE-MsgGUID: VSbT3SNNQ2mbkjbrR83ESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="34761360"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.246.50.245]) ([10.246.50.245])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 00:25:50 -0700
Message-ID: <ce1e1097-2e7d-475b-ac17-3b84aec473e2@linux.intel.com>
Date: Mon, 13 May 2024 09:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Correct error handler
To: Jiasheng Jiang <jiashengjiangcool@outlook.com>,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 daniel@ffwll.ch, chris@chris-wilson.co.uk
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <BYAPR03MB41680146FAD88A8F26C3827BADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <BYAPR03MB41680146FAD88A8F26C3827BADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/11/2024 5:48 PM, Jiasheng Jiang wrote:
> Replace "slab_priorities" with "slab_dependencies" in the error handler to avoid memory leak.

Nice catch. I would make the subject more like:

drm/i915: Fix memory leak by correcting cache object name in error handler

>
> Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")

Also need Cc: <stable@vger.kernel.org> # v5.2+

With those:

Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>


Nirmoy

> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
> ---
>   drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
> index 762127dd56c5..70a854557e6e 100644
> --- a/drivers/gpu/drm/i915/i915_scheduler.c
> +++ b/drivers/gpu/drm/i915/i915_scheduler.c
> @@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)
>   	return 0;
>   
>   err_priorities:
> -	kmem_cache_destroy(slab_priorities);
> +	kmem_cache_destroy(slab_dependencies);
>   	return -ENOMEM;
>   }

