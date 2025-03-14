Return-Path: <linux-kernel+bounces-561243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12557A60F29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488BE16CAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386931F4734;
	Fri, 14 Mar 2025 10:39:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917741F1312
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948745; cv=none; b=pMsS8bHIgyfBa5sDgpW6Q4G71NJMLt3G+dFfw3ZZU+9yva1HKs/JVFjbprGn3Rob6o897AyI4ZfMKUxPeABmlOaQnNzFt+DoYzTRru2IYJpJXVhgezzFs5QFRj1fNwX6fbLn+gaCcrz9WfTPY3bH7AQ5CR4Bc9yMIQkXS56Lkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948745; c=relaxed/simple;
	bh=Hzz8qkLIPIAiklL9xN8FJ41TAUgzGpX5DELPOXnzBdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z82Eg1hhBsZUZiRD+XPqEhMZCzxY4caLIm5hawiGlwGVt1KAhIB8zRXEQSpZi7dfeLt13HdkNaYzaYFknpDdQMzGGQDlAiI6KKlVeQqiKD1rmjCCiFI0CVx3urArqOgXpQHjsabD+pzhCBpeGZTTOifb7wSrBIozTjqLdtQdCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E58981424;
	Fri, 14 Mar 2025 03:39:11 -0700 (PDT)
Received: from [10.57.67.32] (unknown [10.57.67.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 57ABF3F5A1;
	Fri, 14 Mar 2025 03:39:00 -0700 (PDT)
Message-ID: <1a030491-5bc6-4122-baed-faf123f0f872@arm.com>
Date: Fri, 14 Mar 2025 10:38:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fixes device's owner field for registered
 using coresight_init_driver()
Content-Language: en-GB
To: hejunhao <hejunhao3@huawei.com>, james.clark@arm.com,
 anshuman.khandual@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20240918035327.9710-1-hejunhao3@huawei.com>
 <e2194d2a-0f51-4e59-a1ca-b4563b3389ec@arm.com>
 <c3744062-f7c1-82df-2fa1-591da3b2dc5e@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <c3744062-f7c1-82df-2fa1-591da3b2dc5e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

On 14/03/2025 07:44, hejunhao wrote:
> Hi Suzuki,
> 
> Could you confirm if this patch was queued in coresight/next or upstream 
> of the mainline?
> 
> I couldn't find it in: kernel/git/coresight/linux.git or Kernel v6.14.0- 
> rc4.
> 
> Maybe am I missing some information?

Apologies, I missed queueing this. That said, I have a minor comment on 
the patch below.

> 
> Best regards,
> Junhao.
> 
> 
> On 2024/9/18 16:29, Suzuki K Poulose wrote:
>> On 18/09/2024 04:53, Junhao He wrote:
>>> The coresight_init_driver() of the coresight-core module is called from
>>> the sub coresgiht device (such as tmc/stm/funnle/...) module. It calls
>>> amba_driver_register() and Platform_driver_register(), which are macro
>>> functions that use the coresight-core's module to initialize the 
>>> caller's
>>> owner field.  Therefore, when the sub coresight device calls
>>> coresight_init_driver(), an incorrect THIS_MODULE value is captured.
>>>
>>> The sub coesgiht modules can be removed while their callbacks are
>>> running, resulting in a general protection failure.
>>>
>>> Add module parameter to coresight_init_driver() so can be called
>>> with the module of the callback.
>>>
>>> Fixes: 075b7cd7ad7d ("coresight: Add helpers registering/removing 
>>> both AMBA and platform drivers")
>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>
>> Thanks for the fix, looks good to me. I will queue this for v6.13
>>
>> Suzuki
>>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
>>>   drivers/hwtracing/coresight/coresight-core.c       | 6 +++---
>>>   drivers/hwtracing/coresight/coresight-cpu-debug.c  | 3 ++-
>>>   drivers/hwtracing/coresight/coresight-funnel.c     | 3 ++-
>>>   drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
>>>   drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
>>>   drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
>>>   drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
>>>   include/linux/coresight.h                          | 2 +-
>>>   9 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/ 
>>> hwtracing/coresight/coresight-catu.c
>>> index bfea880d6dfb..337668f9cfd4 100644
>>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>>> @@ -702,7 +702,7 @@ static int __init catu_init(void)
>>>   {
>>>       int ret;
>>>   -    ret = coresight_init_driver("catu", &catu_driver, 
>>> &catu_platform_driver);
>>> +    ret = coresight_init_driver("catu", &catu_driver, 
>>> &catu_platform_driver, THIS_MODULE);
>>>       tmc_etr_set_catu_ops(&etr_catu_buf_ops);
>>>       return ret;
>>>   }
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>>> hwtracing/coresight/coresight-core.c
>>> index 9fc6f6b863e0..c546a417836c 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1399,17 +1399,17 @@ module_init(coresight_init);
>>>   module_exit(coresight_exit);
>>>     int coresight_init_driver(const char *drv, struct amba_driver 
>>> *amba_drv,
>>> -              struct platform_driver *pdev_drv)
>>> +              struct platform_driver *pdev_drv, struct module *owner)
>>>   {
>>>       int ret;
>>>   -    ret = amba_driver_register(amba_drv);
>>> +    ret = __amba_driver_register(amba_drv, owner);
>>>       if (ret) {
>>>           pr_err("%s: error registering AMBA driver\n", drv);
>>>           return ret;
>>>       }
>>>   -    ret = platform_driver_register(pdev_drv);
>>> +    ret = __platform_driver_register(pdev_drv, owner);
>>>       if (!ret)
>>>           return 0;
>>>   diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/ 
>>> drivers/hwtracing/coresight/coresight-cpu-debug.c
>>> index 75962dae9aa1..cc599c5ef4b2 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>>> @@ -774,7 +774,8 @@ static struct platform_driver 
>>> debug_platform_driver = {
>>>     static int __init debug_init(void)
>>>   {
>>> -    return coresight_init_driver("debug", &debug_driver, 
>>> &debug_platform_driver);
>>> +    return coresight_init_driver("debug", &debug_driver, 
>>> &debug_platform_driver,
>>> +                     THIS_MODULE);

minor nit:

Could we make the coresight_init_driver() a static inline or even a
macro to automatically add the THIS_MODULE param ?

Something like:

#define coresight_init_driver(name, amba_drv, pdev_drv)
	coresight_init_driver_owner(name, amba_drv, pdev_drv, THIS_MODULE)

I could respin this and queue the change.


Suzuki


>>>   }
>>>     static void __exit debug_exit(void)
>>> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/ 
>>> drivers/hwtracing/coresight/coresight-funnel.c
>>> index 5a819c8970fb..8f451b051ddc 100644
>>> --- a/drivers/hwtracing/coresight/coresight-funnel.c
>>> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
>>> @@ -433,7 +433,8 @@ static struct amba_driver dynamic_funnel_driver = {
>>>     static int __init funnel_init(void)
>>>   {
>>> -    return coresight_init_driver("funnel", &dynamic_funnel_driver, 
>>> &funnel_driver);
>>> +    return coresight_init_driver("funnel", &dynamic_funnel_driver, 
>>> &funnel_driver,
>>> +                     THIS_MODULE);
>>>   }
>>>     static void __exit funnel_exit(void)
>>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/ 
>>> drivers/hwtracing/coresight/coresight-replicator.c
>>> index 3e55be9c8418..f7607c72857c 100644
>>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>>> @@ -438,7 +438,8 @@ static struct amba_driver 
>>> dynamic_replicator_driver = {
>>>     static int __init replicator_init(void)
>>>   {
>>> -    return coresight_init_driver("replicator", 
>>> &dynamic_replicator_driver, &replicator_driver);
>>> +    return coresight_init_driver("replicator", 
>>> &dynamic_replicator_driver, &replicator_driver,
>>> +                     THIS_MODULE);
>>>   }
>>>     static void __exit replicator_exit(void)
>>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/ 
>>> hwtracing/coresight/coresight-stm.c
>>> index 117dbb484543..403eea8f95d4 100644
>>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>>> @@ -1046,7 +1046,7 @@ static struct platform_driver 
>>> stm_platform_driver = {
>>>     static int __init stm_init(void)
>>>   {
>>> -    return coresight_init_driver("stm", &stm_driver, 
>>> &stm_platform_driver);
>>> +    return coresight_init_driver("stm", &stm_driver, 
>>> &stm_platform_driver, THIS_MODULE);
>>>   }
>>>     static void __exit stm_exit(void)
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/ 
>>> drivers/hwtracing/coresight/coresight-tmc-core.c
>>> index b54562f392f3..e31e36635394 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> @@ -742,7 +742,7 @@ static struct platform_driver tmc_platform_driver 
>>> = {
>>>     static int __init tmc_init(void)
>>>   {
>>> -    return coresight_init_driver("tmc", &tmc_driver, 
>>> &tmc_platform_driver);
>>> +    return coresight_init_driver("tmc", &tmc_driver, 
>>> &tmc_platform_driver, THIS_MODULE);
>>>   }
>>>     static void __exit tmc_exit(void)
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/ 
>>> hwtracing/coresight/coresight-tpiu.c
>>> index b048e146fbb1..f9ecd05cbe5c 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
>>> @@ -318,7 +318,7 @@ static struct platform_driver 
>>> tpiu_platform_driver = {
>>>     static int __init tpiu_init(void)
>>>   {
>>> -    return coresight_init_driver("tpiu", &tpiu_driver, 
>>> &tpiu_platform_driver);
>>> +    return coresight_init_driver("tpiu", &tpiu_driver, 
>>> &tpiu_platform_driver, THIS_MODULE);
>>>   }
>>>     static void __exit tpiu_exit(void)
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index f09ace92176e..e6c26952ddc2 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -660,7 +660,7 @@ coresight_find_output_type(struct 
>>> coresight_platform_data *pdata,
>>>                  union coresight_dev_subtype subtype);
>>>     int coresight_init_driver(const char *drv, struct amba_driver 
>>> *amba_drv,
>>> -              struct platform_driver *pdev_drv);
>>> +              struct platform_driver *pdev_drv, struct module *owner);
>>>     void coresight_remove_driver(struct amba_driver *amba_drv,
>>>                    struct platform_driver *pdev_drv);
>>
>>
>> .
>>
> 


