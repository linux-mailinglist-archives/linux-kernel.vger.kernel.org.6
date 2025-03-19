Return-Path: <linux-kernel+bounces-567489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311FAA686C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53C37A49B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94323250C18;
	Wed, 19 Mar 2025 08:27:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A524E4C6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372841; cv=none; b=a8O70OOGp0220uUfD0JK4kX4xc53zmg7kmO9sALOWYewEzLgitXIk+ds1I1NyxjnpbNe+RrmwYmk2I6bHUvSEomXBO1Xrguzl+aVT3yhRNnKSRNp4WplRbxwHGigf6Pm9balB5lO6KB/m+5FVleKZySPC1C4k8VDDf6G3QkZZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372841; c=relaxed/simple;
	bh=sUy6oNsqyNJ/wkQ7zEjM6AO5KaKA9CAxoK4SUobhJM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QayB5/EcszSjc/bdU5gZyiuJRJU45nuy793dcsPOW0bwJI9HB5BR1sSkHKHrtMn9qJctuyVriACUViBGoi7SoDyTxQyqMsZCseTZW9fTaq87lQLkC71BKC5RxACiXpjfpU7tacWUCaOSQBumHx6+GkSD13VfsJfEn4f4QMgN+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7635312FC;
	Wed, 19 Mar 2025 01:27:25 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFABE3F694;
	Wed, 19 Mar 2025 01:27:16 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:27:15 +0000
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
Subject: Re: [PATCH v2 4/8] coresight: Add claim tag warnings and debug
 messages
Message-ID: <20250319082715.GD2860028@e132581.arm.com>
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
 <20250318-james-coresight-claim-tags-v2-4-e9c8a9cde84e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-james-coresight-claim-tags-v2-4-e9c8a9cde84e@linaro.org>

On Tue, Mar 18, 2025 at 04:21:58PM +0000, James Clark wrote:
> Add a dev_dbg() message so that external debugger conflicts are more
> visible. There are multiple reasons for -EBUSY so a message for this
> particular one could be helpful. Add errors for and enumerate all the
> other cases that are impossible.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-core.c | 51 +++++++++++++++++-----------
>  drivers/hwtracing/coresight/coresight-priv.h |  5 ++-
>  2 files changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index e39043a9551f..5f08845faf0d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -135,16 +135,6 @@ static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
>  			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
>  }
>  
> -static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
> -{
> -	return coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
> -}
> -
> -static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
> -{
> -	return coresight_read_claim_tags(csdev) != 0;
> -}
> -
>  static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
>  {
>  	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
> @@ -180,18 +170,41 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
>   */
>  int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
> +	int tag;
> +	struct csdev_access *csa;
> +
>  	if (WARN_ON(!csdev))
>  		return -EINVAL;
>  
> -	if (coresight_is_claimed_any(csdev))
> +	csa = &csdev->access;
> +	tag = coresight_read_claim_tags(csdev);
> +
> +	switch (tag) {
> +	case CORESIGHT_CLAIM_FREE:
> +		coresight_set_self_claim_tag(csdev);
> +		if (coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
> +			return 0;
> +
> +		/* There was a race setting the tag, clean up and fail */
> +		coresight_clear_self_claim_tag_unlocked(csa);
> +		dev_dbg(&csdev->dev, "Busy: Couldn't set self claim tag");
>  		return -EBUSY;
>  
> -	coresight_set_self_claim_tag(csdev);
> -	if (coresight_is_claimed_self_hosted(csdev))
> -		return 0;
> -	/* There was a race setting the tag, clean up and fail */
> -	coresight_clear_self_claim_tag_unlocked(&csdev->access);
> -	return -EBUSY;
> +	case CORESIGHT_CLAIM_EXTERNAL:
> +		/* External debug is an expected state, so log and report BUSY */
> +		dev_dbg(&csdev->dev, "Busy: Claimed by external debugger");
> +		return -EBUSY;
> +
> +	default:
> +	case CORESIGHT_CLAIM_SELF_HOSTED:
> +	case CORESIGHT_CLAIM_INVALID:
> +		/*
> +		 * Warn here because we clear a lingering self hosted tag
> +		 * on probe, so other tag combinations are impossible.
> +		 */
> +		dev_err_once(&csdev->dev, "Invalid claim tag state: %x", tag);
> +		return -EBUSY;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
>  
> @@ -220,7 +233,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>  	if (WARN_ON(!csdev))
>  		return;
>  
> -	if (coresight_is_claimed_self_hosted(csdev))
> +	if (coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
>  		coresight_clear_self_claim_tag_unlocked(&csdev->access);
>  	else
>  		/*
> @@ -228,7 +241,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>  		 * and has manipulated it. Or something else has seriously
>  		 * gone wrong in our driver.
>  		 */
> -		WARN_ON_ONCE(1);
> +		dev_WARN_ONCE(&csdev->dev, 1, "External agent took claim tag");
>  }
>  EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 38bb4e8b50ef..6e8cf55aee0a 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -36,7 +36,10 @@ extern const struct device_type coresight_dev_type[];
>   * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
>   */
>  #define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
> -#define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
> +#define CORESIGHT_CLAIM_FREE		0
> +#define CORESIGHT_CLAIM_EXTERNAL	1
> +#define CORESIGHT_CLAIM_SELF_HOSTED	2
> +#define CORESIGHT_CLAIM_INVALID		3
>  
>  #define TIMEOUT_US		100
>  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
> 
> -- 
> 2.34.1
> 

