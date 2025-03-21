Return-Path: <linux-kernel+bounces-571206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61BA6BA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0214A07DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333F227EB2;
	Fri, 21 Mar 2025 12:10:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C7122C35C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559053; cv=none; b=gWW1QeROAB2+S0DsTMZUilQLRd9ElvWMOtBQ8wMbv9z13pXm8mGn/SiW/i2IaGd8lXJckf64T6Kbqt5azkDSI9Xw3LgyS4vscV7MyTx55wO6WIVM3l/PzQpPyWKyxaatdDupoxsiWTB1kQahek6iPUJsmxUSNYNCN59Ix4KprIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559053; c=relaxed/simple;
	bh=Fj/mFVxvwlXZdVqani1oVd1laqrJFziVRQAVU16QOXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndjqgz0O4YKk7xAj4NvKOv5vgKZCu+RgHMkFnmm+nHojCDtYN+YrjvYSS6vdCjdlGBHK5QEy7jpUeSOaAKxqZN5UIfrhy+q2/pajpZh2kzRh0fv5jRafW33jsplB3fmn7/s/SqA9FtX2vwnZHji7ZOz86Ti4FC5mMiZWV/UE9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56E60106F;
	Fri, 21 Mar 2025 05:10:57 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A813F694;
	Fri, 21 Mar 2025 05:10:48 -0700 (PDT)
Message-ID: <40e30ec8-a7ea-46b9-b687-aa7efa8cf0e1@arm.com>
Date: Fri, 21 Mar 2025 12:10:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] coresight: Only check bottom two claim bits
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
 <20250320-james-coresight-claim-tags-v3-2-d3145c153820@linaro.org>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250320-james-coresight-claim-tags-v3-2-d3145c153820@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 14:34, James Clark wrote:
> The use of the whole register and == could break the claim mechanism if
> any of the other bits are used in the future. The referenced doc "PSCI -
> ARM DEN 0022D" also says to only read and clear the bottom two bits.
> 
> Use FIELD_GET() to extract only the relevant part.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 3 ++-
>   drivers/hwtracing/coresight/coresight-priv.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 8471aefeac76..26d149a4c579 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -131,7 +131,8 @@ coresight_find_out_connection(struct coresight_device *csdev,
>   
>   static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
>   {
> -	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
> +	return FIELD_GET(CORESIGHT_CLAIM_MASK,
> +			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
>   }
>   
>   static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 82644aff8d2b..38bb4e8b50ef 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -35,6 +35,7 @@ extern const struct device_type coresight_dev_type[];
>    * Coresight device CLAIM protocol.
>    * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
>    */
> +#define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
>   #define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)

I am checking with the Arm CoreSight architects on this. This is
problematic, if another agent is assigned, say BIT(2) and we wouldn't
forward compatible.

Suzuki


>   
>   #define TIMEOUT_US		100
> 


