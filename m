Return-Path: <linux-kernel+bounces-554227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31386A594F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF3D1887A15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDC1C07D9;
	Mon, 10 Mar 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k27IqJEy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C822172D;
	Mon, 10 Mar 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610640; cv=none; b=b56Gtpq6no/yvXTlp50hgaa9ik0qj7xukjq2PMzeJ88hh2KypyZfJDuQ/xnVv4jKptY8chIWx1SsSb2Zk5nzQTPu6hiUREyoKWVW4d2ZLYmZRyXN+N6fz7kpdi1WS1bh3b4ZPywnXj1XieKtRVYO+dMdKF5M0pETpugqxAVc5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610640; c=relaxed/simple;
	bh=itK42hXJovQ7FgvIGOp3LK5q0cp2Lj+aDQwPYA0OCOE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kO8TiXSINAgBrHr1ZSExEJGWF0rkgWrDbU500iEdAfv8M0AT8xHZNhuV6zeUbs3tFBlsFNxur7Rq8fuejum/ZrnZK8N30nWCDP2N8xhtdYXB60JoVZs+l39xliWP/QTstLqhH0mZ5x8ngRKRUs0VXlYuSD8Jp+1XrP39jaiSuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k27IqJEy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741610639; x=1773146639;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=itK42hXJovQ7FgvIGOp3LK5q0cp2Lj+aDQwPYA0OCOE=;
  b=k27IqJEy6tv+RuAOTYkNYHhYwHTVXn6k90re4R70ueZvTqMP17giCjRn
   7zwb9fmwatiS7jd8gWCenJDv51m5nD9uB8a9WL4L070/Vp4BWtUa8/tUw
   oJQjqJL8Myg6TVYfZWRMCzu1R/S1urlxX+D2kZpJ8BZCQa335xBUD61F9
   fA6SpFrpF9lW52aSb5LrvzKqSLSnjg2ATRjf9n/IesU8bmEs+M4WRVJrm
   KYC4b3XsnJwkgXDvVOTjxZw3PKQeYOyIVHihkNat/9c7ULmLC0W5NYdUs
   tRy/zpLHxJiV+gXgXE/6CGzeBmFAEto9iotAJtxlygHONYqAbOGimszDi
   A==;
X-CSE-ConnectionGUID: 1aDPYXqLTy6Bo3EyCnSDhg==
X-CSE-MsgGUID: Uyu1VEKMQ8G5S0/Z6mtiuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46389628"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46389628"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:43:58 -0700
X-CSE-ConnectionGUID: kacdkcfmSJCeL3HCWhhDpg==
X-CSE-MsgGUID: 4C8DnNblQ0y/k9Q3Nm/FPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="150931819"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:43:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Mar 2025 14:43:51 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Patil Rajesh Reddy <Patil.Reddy@amd.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/pmf: fix cleanup in
 amd_pmf_init_smart_pc()
In-Reply-To: <43ad5358-f5b2-4cfc-85b4-e7ab8c7cf329@stanley.mountain>
Message-ID: <32c6c456-94f0-f077-040c-09f67d60953a@linux.intel.com>
References: <43ad5358-f5b2-4cfc-85b4-e7ab8c7cf329@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Mar 2025, Dan Carpenter wrote:

> There are a couple problems in this code:
> 
> First, if amd_pmf_tee_init() fails then the function returns directly
> instead of cleaning up.  We cannot simply do a "goto error;" because
> that would lead to a double free.  I have re-written this code to
> use an unwind ladder to free the allocations.

Thanks Dan,

Could you please amend this with the information of what is getting 
double freed, it took considerable amount of time for me to figure out.
I assume it's ->fw_shm_pool ?

> Second, if amd_pmf_start_policy_engine() fails on every iteration though
> the loop then the code calls amd_pmf_tee_deinit() twice which is also a
> double free.  Call amd_pmf_tee_deinit() inside the loop for each failed
> iteration.  Also on that path the error codes are not necessarily
> negative kernel error codes.  Set the error code to -EINVAL.

Maybe I should start to consistently reject any attempt to use 
cleanup/deinit helper functions instead of a proper rollback. It 
seems a pattern that is very prone to errors like this.

> Fixes: 376a8c2a1443 ("platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 36 +++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index ceaff1ebb7b9..a1e43873a07b 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -510,18 +510,18 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>  
>  	ret = amd_pmf_set_dram_addr(dev, true);
>  	if (ret)
> -		goto error;
> +		goto err_cancel_work;
>  
>  	dev->policy_base = devm_ioremap_resource(dev->dev, dev->res);
>  	if (IS_ERR(dev->policy_base)) {
>  		ret = PTR_ERR(dev->policy_base);
> -		goto error;
> +		goto err_free_dram_buf;
>  	}
>  
>  	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
>  	if (!dev->policy_buf) {
>  		ret = -ENOMEM;
> -		goto error;
> +		goto err_free_dram_buf;
>  	}
>  
>  	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
> @@ -531,13 +531,13 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>  	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
>  	if (!dev->prev_data) {
>  		ret = -ENOMEM;
> -		goto error;
> +		goto err_free_policy;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(amd_pmf_ta_uuid); i++) {
>  		ret = amd_pmf_tee_init(dev, &amd_pmf_ta_uuid[i]);
>  		if (ret)
> -			return ret;
> +			goto err_free_prev_data;
>  
>  		ret = amd_pmf_start_policy_engine(dev);
>  		switch (ret) {
> @@ -550,27 +550,41 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>  			status = false;
>  			break;
>  		default:
> -			goto error;
> +			ret = -EINVAL;
> +			amd_pmf_tee_deinit(dev);
> +			goto err_free_prev_data;
>  		}
>  
>  		if (status)
>  			break;
>  	}
>  
> -	if (!status && !pb_side_load)
> -		goto error;
> +	if (!status && !pb_side_load) {
> +		ret = -EINVAL;
> +		goto err_free_prev_data;
> +	}
>  
>  	if (pb_side_load)
>  		amd_pmf_open_pb(dev, dev->dbgfs_dir);
>  
>  	ret = amd_pmf_register_input_device(dev);
>  	if (ret)
> -		goto error;
> +		goto err_pmf_remove_pb;
>  
>  	return 0;
>  
> -error:
> -	amd_pmf_deinit_smart_pc(dev);
> +err_pmf_remove_pb:
> +	if (pb_side_load && dev->esbin)
> +		amd_pmf_remove_pb(dev);
> +	amd_pmf_tee_deinit(dev);
> +err_free_prev_data:
> +	kfree(dev->prev_data);
> +err_free_policy:
> +	kfree(dev->policy_buf);
> +err_free_dram_buf:
> +	kfree(dev->buf);
> +err_cancel_work:
> +	cancel_delayed_work_sync(&dev->pb_work);
>  
>  	return ret;
>  }
> 

-- 
 i.


