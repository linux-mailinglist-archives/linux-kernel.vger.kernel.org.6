Return-Path: <linux-kernel+bounces-445178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DE9F1258
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620AB1881D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B71DFD8D;
	Fri, 13 Dec 2024 16:38:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E39A15573A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107892; cv=none; b=X8tJnyuiaa53Zs9KQlDYmowFwG343k/EBlatjLhCOWQDqlX4UNhscq5d7fbe7DdPHQyH/b1nGmjxGcmGisWayuu16rCOQ0xAvh4NiRFeufGVefRhzCJQjMPaP5jyaRMcX7qjrnG6BdGXk2PNxD4CUh3vRnk+yMyUrAYoYfLcK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107892; c=relaxed/simple;
	bh=5NQsTyFemAQQsoPPsauz5ZpTyVva4LUTZGS7lV4En6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0U6ihWQY5Kmnc+CKTkRrpwsx+lz1UIg4RMDEG4QCfPjuUoVYTY97w2ok69FDCjzwjBEf+8N2RcGh8O4kSxBRX1I1UquHzLmJc6TX593mNPlREbDDexaPAYyhGwLxphl/OqZgraaeQgSnvwnuu2HHdu0CqYAMJbkQgP/iKbQd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87061480;
	Fri, 13 Dec 2024 08:38:37 -0800 (PST)
Received: from [10.57.71.247] (unknown [10.57.71.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC4C43F5A1;
	Fri, 13 Dec 2024 08:38:08 -0800 (PST)
Message-ID: <0c13fbf6-3023-4f9e-9571-a9e8ca6e3402@arm.com>
Date: Fri, 13 Dec 2024 16:38:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] coresight: Update timeout functions to allow
 return of test register value
Content-Language: en-GB
To: Mike Leach <mike.leach@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc: james.clark@linaro.org, alexander.shishkin@linux.intel.com
References: <20241213144919.110642-1-mike.leach@linaro.org>
 <20241213144919.110642-2-mike.leach@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241213144919.110642-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mike

On 13/12/2024 14:49, Mike Leach wrote:
> Current coresight_timeout function spins on a bit on a test register,
> till bit value achieved or timeout hit.
> 
> Add another function to return the full value of the register being
> tested.
> 

The patch looks good to me. However, this change doesn't bring much 
value, other than avoiding a read at the caller side. I guess it is
simpler to leave things as is and let the caller read the register value
while logging rather than providing another variant.

I am inclined to keep the interface simpler.


> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 50 +++++++++++++++-----
>   include/linux/coresight.h                    |  2 +
>   2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index ea38ecf26fcb..feb1a1db355f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1017,32 +1017,37 @@ static void coresight_remove_conns(struct coresight_device *csdev)
>   }
>   
>   /**
> - * coresight_timeout - loop until a bit has changed to a specific register
> - *			state.
> + * coresight_timeout_retval - loop until a bit has changed to a specific register
> + *			      state. Return final register value
>    * @csa: coresight device access for the device
>    * @offset: Offset of the register from the base of the device.
>    * @position: the position of the bit of interest.
>    * @value: the value the bit should have.
> + * @rval:  the last read value of the register being tested.
>    *
>    * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
>    * TIMEOUT_US has elapsed, which ever happens first.
>    */
> -int coresight_timeout(struct csdev_access *csa, u32 offset,
> -		      int position, int value)
> +int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
> +			     int position, int value, u32 *rval)
>   {
> -	int i;
> -	u32 val;
> +	int i, rc = -EAGAIN;
> +	u32 val = 0;
>   
>   	for (i = TIMEOUT_US; i > 0; i--) {
>   		val = csdev_access_read32(csa, offset);
>   		/* waiting on the bit to go from 0 to 1 */
>   		if (value) {
> -			if (val & BIT(position))
> -				return 0;
> +			if (val & BIT(position)) {
> +				rc = 0;
> +				goto return_rval;
> +			}
>   		/* waiting on the bit to go from 1 to 0 */
>   		} else {
> -			if (!(val & BIT(position)))
> -				return 0;
> +			if (!(val & BIT(position))) {
> +				rc = 0;
> +				goto return_rval;
> +			}
>   		}
>   
>   		/*
> @@ -1054,7 +1059,30 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
>   			udelay(1);
>   	}
>   
> -	return -EAGAIN;
> +return_rval:
> +	*rval = val;

super minor nit: we could be flexible in accepting a "NULL" rval and 
thus keep the normal variants pass the NULL straight in. i.e,

	if (rval)
		*rval = val;

> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(coresight_timeout_retval);
> +
> +/**
> + * coresight_timeout - loop until a bit has changed to a specific register
> + *		       state
> + * @csa: coresight device access for the device
> + * @offset: Offset of the register from the base of the device.
> + * @position: the position of the bit of interest.
> + * @value: the value the bit should have.
> + *
> + * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
> + * TIMEOUT_US has elapsed, which ever happens first.
> + */
> +int coresight_timeout(struct csdev_access *csa, u32 offset,
> +		      int position, int value)
> +{
> +	u32 rval = 0;
> +
> +	return coresight_timeout_retval(csa, offset, position, value, &rval);

	return core_timeout_retval(csa, offset, position, value, NULL);

Suzuki

>   }
>   EXPORT_SYMBOL_GPL(coresight_timeout);
>   
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 055ce5cd5c44..29cb71e82b0b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -639,6 +639,8 @@ extern int coresight_enable_sysfs(struct coresight_device *csdev);
>   extern void coresight_disable_sysfs(struct coresight_device *csdev);
>   extern int coresight_timeout(struct csdev_access *csa, u32 offset,
>   			     int position, int value);
> +extern int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
> +				    int position, int value, u32 *rval);
>   
>   extern int coresight_claim_device(struct coresight_device *csdev);
>   extern int coresight_claim_device_unlocked(struct coresight_device *csdev);


