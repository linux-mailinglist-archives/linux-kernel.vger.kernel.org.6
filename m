Return-Path: <linux-kernel+bounces-571255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB54EA6BAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407723AED02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59322A4D8;
	Fri, 21 Mar 2025 12:42:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F722A4EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560944; cv=none; b=mu06IeZpFL4UhYf9yLuybwak2ZIkHCx9BrxnyXc9sZrg9biLrJrSourVzV+ljkS21wQ86btyWFmkEQI/gkQm+g+4VB+8KJ5dFKw8hSZDehbZ3IV4QzTwsM8kVcrc5mxBt36mit8lt+/3GiS/LZmvSA0jSseB8bEyBeaAlk34Ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560944; c=relaxed/simple;
	bh=yYwWy5OjSgbAVglZIiAmZmO1hX3sdR6fSJwBShFfrTA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IQce8vepmN4mhwh/mvfAwXo6GZG32JDyfnhyaAL6CFWVAZ0udT7/FNBGTc1GAyx/TFpPah5EOSauPE/KdSd9pjehFrMLmrYtrbv6woWe14B9FAgypAsRazKwfTdD+c7cU7E7DbSzVKqNT4rnHTxVsWwdaC1HmeGLAWTy2eA88ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFBA3106F;
	Fri, 21 Mar 2025 05:42:27 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23F393F63F;
	Fri, 21 Mar 2025 05:42:19 -0700 (PDT)
Message-ID: <2d3fb704-172c-4632-9e95-02bbfb8c0f90@arm.com>
Date: Fri, 21 Mar 2025 12:42:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] coresight: Convert tag clear function to take a
 struct cs_access
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
 <20250320-james-coresight-claim-tags-v3-1-d3145c153820@linaro.org>
 <3bbf8aee-7b84-405a-8a3f-648c74196c2c@arm.com>
Content-Language: en-US
In-Reply-To: <3bbf8aee-7b84-405a-8a3f-648c74196c2c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/03/2025 11:02, Suzuki K Poulose wrote:
> On 20/03/2025 14:34, James Clark wrote:
>> The self hosted claim tag will be reset on device probe in a later
>> commit. We'll want to do this before coresight_register() is called so
>> won't have a coresight_device and have to use cs_access instead.
>>
>> Also make them public and create locked and unlocked versions for
>> later use.
>>
>> These look functions look like they set the whole tags register as one
>> value, but they only set and clear the self hosted bit using a SET/CLR
>> bits mechanism so also rename the functions to reflect this better.
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 27 ++++++++++++++++++ 
>> +--------
>>   include/linux/coresight.h                    |  3 ++-
>>   2 files changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>> hwtracing/coresight/coresight-core.c
>> index fb43ef6a3b1f..8471aefeac76 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -144,19 +144,30 @@ static inline bool 
>> coresight_is_claimed_any(struct coresight_device *csdev)
>>       return coresight_read_claim_tags(csdev) != 0;
>>   }
>> -static inline void coresight_set_claim_tags(struct coresight_device 
>> *csdev)
>> +static inline void coresight_set_self_claim_tag(struct 
>> coresight_device *csdev)
> 
> nit: For consistency, this should be renamed to _unlocked ?
> 

minor nit on the subject;

s/cs_access/csdev_access/

Suzuki


> 

Rest looks fine to me
> 
> Suzuki
> 
> 
>>   {
>>       csdev_access_relaxed_write32(&csdev->access, 
>> CORESIGHT_CLAIM_SELF_HOSTED,
>>                        CORESIGHT_CLAIMSET);
>>       isb();
>>   }
>> -static inline void coresight_clear_claim_tags(struct coresight_device 
>> *csdev)
>> +void coresight_clear_self_claim_tag(struct csdev_access *csa)
>>   {
>> -    csdev_access_relaxed_write32(&csdev->access, 
>> CORESIGHT_CLAIM_SELF_HOSTED,
>> +    if (csa->io_mem)
>> +        CS_UNLOCK(csa->base);
>> +    coresight_clear_self_claim_tag_unlocked(csa);
>> +    if (csa->io_mem)
>> +        CS_LOCK(csa->base);
>> +}
>> +EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
>> +
>> +void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
>> +{
>> +    csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>>                        CORESIGHT_CLAIMCLR);
>>       isb();
>>   }
>> +EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
>>   /*
>>    * coresight_claim_device_unlocked : Claim the device for self- 
>> hosted usage
>> @@ -176,11 +187,11 @@ int coresight_claim_device_unlocked(struct 
>> coresight_device *csdev)
>>       if (coresight_is_claimed_any(csdev))
>>           return -EBUSY;
>> -    coresight_set_claim_tags(csdev);
>> +    coresight_set_self_claim_tag(csdev);
>>       if (coresight_is_claimed_self_hosted(csdev))
>>           return 0;
>> -    /* There was a race setting the tags, clean up and fail */
>> -    coresight_clear_claim_tags(csdev);
>> +    /* There was a race setting the tag, clean up and fail */
>> +    coresight_clear_self_claim_tag_unlocked(&csdev->access);
>>       return -EBUSY;
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
>> @@ -201,7 +212,7 @@ int coresight_claim_device(struct coresight_device 
>> *csdev)
>>   EXPORT_SYMBOL_GPL(coresight_claim_device);
>>   /*
>> - * coresight_disclaim_device_unlocked : Clear the claim tags for the 
>> device.
>> + * coresight_disclaim_device_unlocked : Clear the claim tag for the 
>> device.
>>    * Called with CS_UNLOCKed for the component.
>>    */
>>   void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>> @@ -211,7 +222,7 @@ void coresight_disclaim_device_unlocked(struct 
>> coresight_device *csdev)
>>           return;
>>       if (coresight_is_claimed_self_hosted(csdev))
>> -        coresight_clear_claim_tags(csdev);
>> +        coresight_clear_self_claim_tag_unlocked(&csdev->access);
>>       else
>>           /*
>>            * The external agent may have not honoured our claim
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index d79a242b271d..00134a80d358 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -685,7 +685,8 @@ extern int coresight_timeout_action(struct 
>> csdev_access *csa, u32 offset,
>>   extern int coresight_claim_device(struct coresight_device *csdev);
>>   extern int coresight_claim_device_unlocked(struct coresight_device 
>> *csdev);
>> -
>> +void coresight_clear_self_claim_tag(struct csdev_access *csa);
>> +void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa);
>>   extern void coresight_disclaim_device(struct coresight_device *csdev);
>>   extern void coresight_disclaim_device_unlocked(struct 
>> coresight_device *csdev);
>>   extern char *coresight_alloc_device_name(struct coresight_dev_list 
>> *devs,
>>
> 


