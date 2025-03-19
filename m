Return-Path: <linux-kernel+bounces-567485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ABAA686B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ED119C7508
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC96250C1B;
	Wed, 19 Mar 2025 08:24:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABE250C0E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372669; cv=none; b=N3l20wyIyZSieNma8+Ve/MayyIaMCJzm7FxCxbOZ/6V1v3RLjiO9lSU2ZkMs8ibvlrJrTR0SiW9PupHGQ1/7D+BnyC/pAIr7mJDYvWiGyKW8+rU7T2xzNzClqRy0aO54dGbZfB4VYQ85Df0e3ihnHqcyQ+rg6k4DBTrrVppd6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372669; c=relaxed/simple;
	bh=alKdS6KuFDzkExqV7zlx2lpo61ocL9FXAC3lIsvn1cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqYX5jrmJ1heuUQbvX1+GfCrPkownR7EkA4sg8jAcLB2ksKDKspl1fkxzV74PH4thQp9GkHhBhd1Jy1eEDZ4rkwln/PIvSrLKYGNHeUszo7r62nCQXEbca1IVa0AzM+O6D79xs7QKOXPJaYYOVF43cxNZltv9ga/ydEXi/WgsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC7412FC;
	Wed, 19 Mar 2025 01:24:33 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112F93F694;
	Wed, 19 Mar 2025 01:24:24 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:24:23 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/8] coresight: Convert tag clear function to take a
 struct cs_access
Message-ID: <20250319082423.GC2860028@e132581.arm.com>
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
 <20250318-james-coresight-claim-tags-v2-2-e9c8a9cde84e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-james-coresight-claim-tags-v2-2-e9c8a9cde84e@linaro.org>

On Tue, Mar 18, 2025 at 04:21:56PM +0000, James Clark wrote:
> The self hosted claim tag will be reset on device probe in a later
> commit. We'll want to do this before coresight_register() is called so
> won't have a coresight_device and have to use cs_access instead.
> 
> Also make them public and create locked and unlocked versions for
> later use.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-core.c | 17 +++++++++++++----
>  include/linux/coresight.h                    |  3 ++-
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 3f1c996d668a..9ff601e2415a 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -151,12 +151,21 @@ static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
>  	isb();
>  }
>  
> -static inline void coresight_clear_self_claim_tag(struct coresight_device *csdev)
> +void coresight_clear_self_claim_tag(struct csdev_access *csa)
>  {
> -	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
> +	CS_UNLOCK(csa->base);
> +	coresight_clear_self_claim_tag_unlocked(csa);
> +	CS_LOCK(csa->base);
> +}
> +EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
> +
> +void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
> +{
> +	csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>  				     CORESIGHT_CLAIMCLR);
>  	isb();
>  }
> +EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
>  
>  /*
>   * coresight_claim_device_unlocked : Claim the device for self-hosted usage
> @@ -180,7 +189,7 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  	if (coresight_is_claimed_self_hosted(csdev))
>  		return 0;
>  	/* There was a race setting the tag, clean up and fail */
> -	coresight_clear_self_claim_tag(csdev);
> +	coresight_clear_self_claim_tag_unlocked(&csdev->access);
>  	return -EBUSY;
>  }
>  EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
> @@ -211,7 +220,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>  		return;
>  
>  	if (coresight_is_claimed_self_hosted(csdev))
> -		coresight_clear_self_claim_tag(csdev);
> +		coresight_clear_self_claim_tag_unlocked(&csdev->access);
>  	else
>  		/*
>  		 * The external agent may have not honoured our claim
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d79a242b271d..00134a80d358 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -685,7 +685,8 @@ extern int coresight_timeout_action(struct csdev_access *csa, u32 offset,
>  
>  extern int coresight_claim_device(struct coresight_device *csdev);
>  extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
> -
> +void coresight_clear_self_claim_tag(struct csdev_access *csa);
> +void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa);
>  extern void coresight_disclaim_device(struct coresight_device *csdev);
>  extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
>  extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
> 
> -- 
> 2.34.1
> 

