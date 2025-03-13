Return-Path: <linux-kernel+bounces-559731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB65A5F8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5209D189070F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD665267F4E;
	Thu, 13 Mar 2025 14:40:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A140267B1D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876814; cv=none; b=bKsZdaTu/gt6MMG52g/cVa5vwI9DcJJ5dDuAf4bMjv4oxQP8KbhXqggpSgIcubtspVabRFqETp49I6g15eFT9Ip4trZsvt3+78lVL1QNQagoitwQZL/D2KKsR+qtPYO7dntrNo6jEhcz65Mg76k0Ffk4yYlAhnLIXVq67XoTmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876814; c=relaxed/simple;
	bh=+5jrqBadBYmMgCgP8Cdie+m8WJz5Zy9v8JEmOHEDw2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW0p1SOEyN3oAV4V5rVAvkt3+/OgBQ3O1ZyKOoaK5jnqelAeJHz8PqG0Ld5pAL01DVjUjo9dw+i6MzEKaRPREvT9ydcQaCgoRF9wYqdtZLppCtppS5r54NOauXT7jXviC7TsPnSnHsRs6pzITmQrUL2qKcd+2It6ojaEwS0hK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2134150C;
	Thu, 13 Mar 2025 07:40:20 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F048D3F694;
	Thu, 13 Mar 2025 07:40:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:40:05 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/7] coresight: Add claim tag warnings and debug messages
Message-ID: <20250313144005.GQ9682@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-5-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103945.967495-5-james.clark@linaro.org>

On Tue, Feb 11, 2025 at 10:39:40AM +0000, James Clark wrote:
> 
> Add a dev_dbg() message so that external debugger conflicts are more
> visible. There are multiple reasons for -EBUSY so a message for this
> particular one could be helpful. Add errors for and enumerate all the
> other cases that are impossible.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 48 ++++++++++++--------
>  drivers/hwtracing/coresight/coresight-priv.h |  5 +-
>  2 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 7b53165c93af..7fe5d5d432c4 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -133,16 +133,6 @@ static inline u32 coresight_read_claim_tags(struct csdev_access *csa)
>                          csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMCLR));
>  }
> 
> -static inline bool coresight_is_claimed_self_hosted(struct csdev_access *csa)
> -{
> -       return coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED;
> -}
> -
> -static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
> -{
> -       return coresight_read_claim_tags(&csdev->access) != 0;
> -}
> -
>  static inline void coresight_set_self_claim_tag(struct csdev_access *csa)
>  {
>         csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
> @@ -169,18 +159,40 @@ static inline void coresight_clear_self_claim_tag(struct csdev_access *csa)
>   */
>  int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
> +       int tag;
> +       struct csdev_access *csa;
> +
>         if (WARN_ON(!csdev))
>                 return -EINVAL;
> 
> -       if (coresight_is_claimed_any(csdev))
> +       csa = &csdev->access;
> +       tag = coresight_read_claim_tags(csa);
> +
> +       switch (tag) {
> +       case CORESIGHT_CLAIM_FREE:
> +               coresight_set_self_claim_tag(csa);
> +               if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED)
> +                       return 0;
> +

It would be a rare case if a failure happens here.  Seems to me, it
would be valuable to print a log for this edge case.

Otherwise, looks good to me.

> +               /* There was a race setting the tag, clean up and fail */
> +               coresight_clear_self_claim_tag(csa);
>                 return -EBUSY;
> 
> -       coresight_set_self_claim_tag(&csdev->access);
> -       if (coresight_is_claimed_self_hosted(&csdev->access))
> -               return 0;
> -       /* There was a race setting the tag, clean up and fail */
> -       coresight_clear_self_claim_tag(&csdev->access);
> -       return -EBUSY;
> +       case CORESIGHT_CLAIM_EXTERNAL:
> +               /* External debug is an expected state, so log and report BUSY */
> +               dev_dbg(&csdev->dev, "Busy: Claimed by external debugger");
> +               return -EBUSY;
> +
> +       default:
> +       case CORESIGHT_CLAIM_SELF_HOSTED:
> +       case CORESIGHT_CLAIM_INVALID:
> +               /*
> +                * Warn here because we clear a lingering self hosted tag
> +                * on probe, so other tag combinations are impossible.
> +                */
> +               dev_err_once(&csdev->dev, "Invalid claim tag state: %x", tag);
> +               return -EBUSY;
> +       }
>  }
>  EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
> 
> @@ -205,7 +217,7 @@ EXPORT_SYMBOL_GPL(coresight_claim_device);
>   */
>  void coresight_disclaim_device_unlocked(struct csdev_access *csa)
>  {
> -       if (coresight_is_claimed_self_hosted(csa))
> +       if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED)
>                 coresight_clear_self_claim_tag(csa);
>         else
>                 /*
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index cc7ff1e36ef4..a83113225797 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -36,7 +36,10 @@ extern const struct device_type coresight_dev_type[];
>   * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
>   */
>  #define CORESIGHT_CLAIM_MASK           GENMASK(1, 0)
> -#define CORESIGHT_CLAIM_SELF_HOSTED    BIT(1)
> +#define CORESIGHT_CLAIM_FREE           0
> +#define CORESIGHT_CLAIM_EXTERNAL       1
> +#define CORESIGHT_CLAIM_SELF_HOSTED    2
> +#define CORESIGHT_CLAIM_INVALID                3
> 
>  #define TIMEOUT_US             100
>  #define BMVAL(val, lsb, msb)   ((val & GENMASK(msb, lsb)) >> lsb)
> --
> 2.34.1
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

