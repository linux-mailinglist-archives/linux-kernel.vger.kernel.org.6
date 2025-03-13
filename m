Return-Path: <linux-kernel+bounces-559317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB59A5F245
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF96417AB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68B26618D;
	Thu, 13 Mar 2025 11:25:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F570264FBD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865103; cv=none; b=asc7xMGlgTBLKxSR6xPiO8OP/arMx+wGIDS8QS4DywVSK7dcvo6pkipqkPEB4mx0a5mjs+6KMvt+R76Q1X1muLCR45yEt7kkg5GrSiPMfyE5+T9ToNTNOdJgOwejh2vL8b5iwRI8zH0xCfxvgMaVWb10FeS1QwjooAotlvh30kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865103; c=relaxed/simple;
	bh=nj3mpAAoTqpi1ygZizkDbVeRUy80Y+7BlQ9IB1CgBGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM6Ic0nZdt6DYp+p5yPvxCYu0t+lUJgRAtlVX/mOh4EaahdyNxQBP5bv+tL/h5luvtY3xq9onydp5bz1bjQZnkRMjQTVTb/3pw3U6doLNR//551sX5ky7PensLoBKLceroDWcz0Bq2iqk6PaFOPobWagZxWPWgZhh4tziFaMVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1664A1F02;
	Thu, 13 Mar 2025 04:25:12 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B0E3F673;
	Thu, 13 Mar 2025 04:25:01 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:24:57 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/7] coresight: Rename coresight_{set,clear}_claim_tags()
Message-ID: <20250313112457.GO9682@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-2-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103945.967495-2-james.clark@linaro.org>

On Tue, Feb 11, 2025 at 10:39:37AM +0000, James Clark wrote:
> 
> These look like they set the whole tags register as one value, but they
> only set and clear the self hosted bit using a SET/CLR bits mechanism.
> Rename the functions to reflect this better.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0a9380350fb5..523dbb381f90 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -142,14 +142,14 @@ static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
>         return coresight_read_claim_tags(csdev) != 0;
>  }
> 
> -static inline void coresight_set_claim_tags(struct coresight_device *csdev)
> +static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
>  {
>         csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
>                                      CORESIGHT_CLAIMSET);
>         isb();
>  }
> 
> -static inline void coresight_clear_claim_tags(struct coresight_device *csdev)
> +static inline void coresight_clear_self_claim_tag(struct coresight_device *csdev)
>  {
>         csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
>                                      CORESIGHT_CLAIMCLR);
> @@ -174,11 +174,11 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
>         if (coresight_is_claimed_any(csdev))
>                 return -EBUSY;
> 
> -       coresight_set_claim_tags(csdev);
> +       coresight_set_self_claim_tag(csdev);
>         if (coresight_is_claimed_self_hosted(csdev))
>                 return 0;
> -       /* There was a race setting the tags, clean up and fail */
> -       coresight_clear_claim_tags(csdev);
> +       /* There was a race setting the tag, clean up and fail */
> +       coresight_clear_self_claim_tag(csdev);
>         return -EBUSY;
>  }
>  EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
> @@ -199,7 +199,7 @@ int coresight_claim_device(struct coresight_device *csdev)
>  EXPORT_SYMBOL_GPL(coresight_claim_device);
> 
>  /*
> - * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
> + * coresight_disclaim_device_unlocked : Clear the claim tag for the device.
>   * Called with CS_UNLOCKed for the component.
>   */
>  void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
> @@ -209,7 +209,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>                 return;
> 
>         if (coresight_is_claimed_self_hosted(csdev))
> -               coresight_clear_claim_tags(csdev);
> +               coresight_clear_self_claim_tag(csdev);
>         else
>                 /*
>                  * The external agent may have not honoured our claim
> --
> 2.34.1
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

