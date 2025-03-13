Return-Path: <linux-kernel+bounces-559403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C6A5F365
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE8E1892029
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7B266EFF;
	Thu, 13 Mar 2025 11:46:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6942661BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866417; cv=none; b=PNKSsJ3jFGzVY+U7+PZazIc9ocXTLBIVDFnuJvFy2asn0MqwNzZiiJYgvpKTL+nvQ1mFTZOTPLp/p3C4Lmr9/sZ1eftFMQOPTMdS5m5q1P5MM3AO2ubM6/uKqDBFL03AFePVwpNQxX60iLTT6J26o8jR70WT0INjZ2PR8lBX8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866417; c=relaxed/simple;
	bh=OtYANFqaujww9ZZTHTTD+vbz9SrkhoWb7Wt+gG+2TaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIZbTD8MvSvXQZq5JUv2WDe4edcVW5VM+Y+MNmifCM+J3monYji6mukY+JIeGvafB8GrhPZLoVd5StNgCWaJ5hRrRzDUzrIczwkXVvVts8h74VXZVHnnHTweMQaHkXmOPBvFTUjrBpjJ1OkGB8D66c4FNBxcV+a7zuLY89bAMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3DE01C00;
	Thu, 13 Mar 2025 04:47:04 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 041C33F673;
	Thu, 13 Mar 2025 04:46:53 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:46:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/7] coresight: Only check bottom two claim bits
Message-ID: <20250313114649.GP9682@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-4-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103945.967495-4-james.clark@linaro.org>

On Tue, Feb 11, 2025 at 10:39:39AM +0000, James Clark wrote:
> 
> The use of the whole register and == could break the claim mechanism if
> any of the other bits are used in the future. The referenced doc "PSCI -
> ARM DEN 0022D" also says to only read and clear the bottom two bits.
> 
> Use FIELD_GET() to extract only the relevant part.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

I checked the latest PSCI spec DEN0022F.b, which has no change for
for only using lowest two bits in claim register.

Reviewed-by: Leo Yan <leo.yan@arm.com>


> ---
>  drivers/hwtracing/coresight/coresight-core.c | 3 ++-
>  drivers/hwtracing/coresight/coresight-priv.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index a669872b4118..7b53165c93af 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -129,7 +129,8 @@ coresight_find_out_connection(struct coresight_device *csdev,
> 
>  static inline u32 coresight_read_claim_tags(struct csdev_access *csa)
>  {
> -       return csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMCLR);
> +       return FIELD_GET(CORESIGHT_CLAIM_MASK,
> +                        csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMCLR));
>  }
> 
>  static inline bool coresight_is_claimed_self_hosted(struct csdev_access *csa)
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 05f891ca6b5c..cc7ff1e36ef4 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -35,6 +35,7 @@ extern const struct device_type coresight_dev_type[];
>   * Coresight device CLAIM protocol.
>   * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
>   */
> +#define CORESIGHT_CLAIM_MASK           GENMASK(1, 0)
>  #define CORESIGHT_CLAIM_SELF_HOSTED    BIT(1)
> 
>  #define TIMEOUT_US             100
> --
> 2.34.1
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

