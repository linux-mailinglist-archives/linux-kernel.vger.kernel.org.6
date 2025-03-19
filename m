Return-Path: <linux-kernel+bounces-567944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30997A68C41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC023BE28E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA025525D;
	Wed, 19 Mar 2025 12:00:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC01DE898
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385610; cv=none; b=EnXD4gmkvrH5j4EKf+HV2sNrlDEHO4yDj2np+cL3Ffx1TVpgVvpinC8co6y80CrY6oUTUI2DfRc3MKdkfmFvdTlk3K/4oSoHAtXcfN3VCuNL14zQCciQtOJQvoaNP6bhUf1jA+D2ucjCPNd3VU1LGLkJSCcukj5ENQEnzOKCXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385610; c=relaxed/simple;
	bh=24lcW5zOfWDuG73b4qHfegpsI78oGlIAvqlsb5P2HrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhU2bDCV0J4gJfvQKZLSxgwBjdTdzwK1K9D8bh8QYmUlY1QkSzkDsiczdSpusnNiagSVBucK2mUAW4VC8854zyMVng8U3XtjWx6hUgAaqh5mmeZ6+GrKA47cwzbRIRIqEE+YhdYYW60gGDoSWbwdaQ4mNca8Nd7m5XZJPc/3cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C7D5113E;
	Wed, 19 Mar 2025 05:00:16 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0F3B3F694;
	Wed, 19 Mar 2025 05:00:06 -0700 (PDT)
Message-ID: <cc68d43f-4719-4f57-a38c-fb5afe8d29cc@arm.com>
Date: Wed, 19 Mar 2025 12:00:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] coresight: Convert tag clear function to take a
 struct cs_access
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
 <20250318-james-coresight-claim-tags-v2-2-e9c8a9cde84e@linaro.org>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250318-james-coresight-claim-tags-v2-2-e9c8a9cde84e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 16:21, James Clark wrote:
> The self hosted claim tag will be reset on device probe in a later
> commit. We'll want to do this before coresight_register() is called so
> won't have a coresight_device and have to use cs_access instead.
> 
> Also make them public and create locked and unlocked versions for
> later use.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

minor nit:

The restructuring looks a bit confusing. Could we start with :

coresight_{set,clear}_self_claim_tag_unlocked in Patch 1. Rather
than rename what we renamed in patch 1 again here.


> ---
>   drivers/hwtracing/coresight/coresight-core.c | 17 +++++++++++++----
>   include/linux/coresight.h                    |  3 ++-
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 3f1c996d668a..9ff601e2415a 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -151,12 +151,21 @@ static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
>   	isb();
>   }
>   
> -static inline void coresight_clear_self_claim_tag(struct coresight_device *csdev)
> +void coresight_clear_self_claim_tag(struct csdev_access *csa)
>   {
> -	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
> +	CS_UNLOCK(csa->base);

This looks to be hard coding MMIO based access ? Should we abstract it 
based on the csdev_access_** ?


Suzuki


> +	coresight_clear_self_claim_tag_unlocked(csa);
> +	CS_LOCK(csa->base);
> +}
> +EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
> +
> +void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
> +{
> +	csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>   				     CORESIGHT_CLAIMCLR);
>   	isb();
>   }
> +EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
>   
>   /*
>    * coresight_claim_device_unlocked : Claim the device for self-hosted usage
> @@ -180,7 +189,7 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
>   	if (coresight_is_claimed_self_hosted(csdev))
>   		return 0;
>   	/* There was a race setting the tag, clean up and fail */
> -	coresight_clear_self_claim_tag(csdev);
> +	coresight_clear_self_claim_tag_unlocked(&csdev->access);
>   	return -EBUSY;
>   }
>   EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
> @@ -211,7 +220,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>   		return;
>   
>   	if (coresight_is_claimed_self_hosted(csdev))
> -		coresight_clear_self_claim_tag(csdev);
> +		coresight_clear_self_claim_tag_unlocked(&csdev->access);
>   	else
>   		/*
>   		 * The external agent may have not honoured our claim
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d79a242b271d..00134a80d358 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -685,7 +685,8 @@ extern int coresight_timeout_action(struct csdev_access *csa, u32 offset,
>   
>   extern int coresight_claim_device(struct coresight_device *csdev);
>   extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
> -
> +void coresight_clear_self_claim_tag(struct csdev_access *csa);
> +void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa);
>   extern void coresight_disclaim_device(struct coresight_device *csdev);
>   extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
>   extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
> 




