Return-Path: <linux-kernel+bounces-560861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD867A60A43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B667AB657
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252018F2DF;
	Fri, 14 Mar 2025 07:45:12 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318B18A6D2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938312; cv=none; b=Wq3gUpBTMoMrv3bUodgZT9QJ4EVcgIDUwrRF6qYnOPxomXXt+ilkimk8e+1wD6z6KTswHDVgk5QYptB2FCRuz5qJu5hbIN1TLaAwtCbb0Nm8YkSNXqwQ/niumTAYtWTUjeWvQx0NEHllyfel5CJT5XCp0WmZY2BOhfTyYgtDPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938312; c=relaxed/simple;
	bh=dLw1fTtQWhKETOLZRN9EKDbih1kWeJ4Ju5mJsROpm0Q=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XIMIH87kc5algaguFMPe3dGweJIFbS+vcvuJfaE2DaCVlwvA6WdeeRSV/XOgY/N4vEzXkBhUigIxat1nZ6wlz7D2aphJp00iD0Guxsm4OYAFvTmUL4fVtvjfOkMOScgAKKZgHqXYINBrsg3Qf7MzLrIX8jmeBxCn/TWqN46F/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZDbyF55mhz27gbb;
	Fri, 14 Mar 2025 15:45:41 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D5B01A0171;
	Fri, 14 Mar 2025 15:45:06 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 15:45:06 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 15:45:05 +0800
Subject: Re: [PATCH] coresight: Fixes device's owner field for registered
 using coresight_init_driver()
To: Suzuki K Poulose <suzuki.poulose@arm.com>, <james.clark@arm.com>,
	<anshuman.khandual@arm.com>
References: <20240918035327.9710-1-hejunhao3@huawei.com>
 <e2194d2a-0f51-4e59-a1ca-b4563b3389ec@arm.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<prime.zeng@hisilicon.com>, hejunhao <hejunhao3@huawei.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <c3744062-f7c1-82df-2fa1-591da3b2dc5e@huawei.com>
Date: Fri, 14 Mar 2025 15:44:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e2194d2a-0f51-4e59-a1ca-b4563b3389ec@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn500004.china.huawei.com (7.202.194.145)

Hi Suzuki,

Could you confirm if this patch was queued in coresight/next or upstream 
of the mainline?

I couldn't find it in: kernel/git/coresight/linux.git or Kernel v6.14.0-rc4.

Maybe am I missing some information?

Best regards,
Junhao.


On 2024/9/18 16:29, Suzuki K Poulose wrote:
> On 18/09/2024 04:53, Junhao He wrote:
>> The coresight_init_driver() of the coresight-core module is called from
>> the sub coresgiht device (such as tmc/stm/funnle/...) module. It calls
>> amba_driver_register() and Platform_driver_register(), which are macro
>> functions that use the coresight-core's module to initialize the 
>> caller's
>> owner field.  Therefore, when the sub coresight device calls
>> coresight_init_driver(), an incorrect THIS_MODULE value is captured.
>>
>> The sub coesgiht modules can be removed while their callbacks are
>> running, resulting in a general protection failure.
>>
>> Add module parameter to coresight_init_driver() so can be called
>> with the module of the callback.
>>
>> Fixes: 075b7cd7ad7d ("coresight: Add helpers registering/removing 
>> both AMBA and platform drivers")
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>
> Thanks for the fix, looks good to me. I will queue this for v6.13
>
> Suzuki
>
>> ---
>>   drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
>>   drivers/hwtracing/coresight/coresight-core.c       | 6 +++---
>>   drivers/hwtracing/coresight/coresight-cpu-debug.c  | 3 ++-
>>   drivers/hwtracing/coresight/coresight-funnel.c     | 3 ++-
>>   drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
>>   drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
>>   drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
>>   drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
>>   include/linux/coresight.h                          | 2 +-
>>   9 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c 
>> b/drivers/hwtracing/coresight/coresight-catu.c
>> index bfea880d6dfb..337668f9cfd4 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>> @@ -702,7 +702,7 @@ static int __init catu_init(void)
>>   {
>>       int ret;
>>   -    ret = coresight_init_driver("catu", &catu_driver, 
>> &catu_platform_driver);
>> +    ret = coresight_init_driver("catu", &catu_driver, 
>> &catu_platform_driver, THIS_MODULE);
>>       tmc_etr_set_catu_ops(&etr_catu_buf_ops);
>>       return ret;
>>   }
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 9fc6f6b863e0..c546a417836c 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1399,17 +1399,17 @@ module_init(coresight_init);
>>   module_exit(coresight_exit);
>>     int coresight_init_driver(const char *drv, struct amba_driver 
>> *amba_drv,
>> -              struct platform_driver *pdev_drv)
>> +              struct platform_driver *pdev_drv, struct module *owner)
>>   {
>>       int ret;
>>   -    ret = amba_driver_register(amba_drv);
>> +    ret = __amba_driver_register(amba_drv, owner);
>>       if (ret) {
>>           pr_err("%s: error registering AMBA driver\n", drv);
>>           return ret;
>>       }
>>   -    ret = platform_driver_register(pdev_drv);
>> +    ret = __platform_driver_register(pdev_drv, owner);
>>       if (!ret)
>>           return 0;
>>   diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c 
>> b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> index 75962dae9aa1..cc599c5ef4b2 100644
>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> @@ -774,7 +774,8 @@ static struct platform_driver 
>> debug_platform_driver = {
>>     static int __init debug_init(void)
>>   {
>> -    return coresight_init_driver("debug", &debug_driver, 
>> &debug_platform_driver);
>> +    return coresight_init_driver("debug", &debug_driver, 
>> &debug_platform_driver,
>> +                     THIS_MODULE);
>>   }
>>     static void __exit debug_exit(void)
>> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c 
>> b/drivers/hwtracing/coresight/coresight-funnel.c
>> index 5a819c8970fb..8f451b051ddc 100644
>> --- a/drivers/hwtracing/coresight/coresight-funnel.c
>> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
>> @@ -433,7 +433,8 @@ static struct amba_driver dynamic_funnel_driver = {
>>     static int __init funnel_init(void)
>>   {
>> -    return coresight_init_driver("funnel", &dynamic_funnel_driver, 
>> &funnel_driver);
>> +    return coresight_init_driver("funnel", &dynamic_funnel_driver, 
>> &funnel_driver,
>> +                     THIS_MODULE);
>>   }
>>     static void __exit funnel_exit(void)
>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c 
>> b/drivers/hwtracing/coresight/coresight-replicator.c
>> index 3e55be9c8418..f7607c72857c 100644
>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>> @@ -438,7 +438,8 @@ static struct amba_driver 
>> dynamic_replicator_driver = {
>>     static int __init replicator_init(void)
>>   {
>> -    return coresight_init_driver("replicator", 
>> &dynamic_replicator_driver, &replicator_driver);
>> +    return coresight_init_driver("replicator", 
>> &dynamic_replicator_driver, &replicator_driver,
>> +                     THIS_MODULE);
>>   }
>>     static void __exit replicator_exit(void)
>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c 
>> b/drivers/hwtracing/coresight/coresight-stm.c
>> index 117dbb484543..403eea8f95d4 100644
>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>> @@ -1046,7 +1046,7 @@ static struct platform_driver 
>> stm_platform_driver = {
>>     static int __init stm_init(void)
>>   {
>> -    return coresight_init_driver("stm", &stm_driver, 
>> &stm_platform_driver);
>> +    return coresight_init_driver("stm", &stm_driver, 
>> &stm_platform_driver, THIS_MODULE);
>>   }
>>     static void __exit stm_exit(void)
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c 
>> b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index b54562f392f3..e31e36635394 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -742,7 +742,7 @@ static struct platform_driver tmc_platform_driver 
>> = {
>>     static int __init tmc_init(void)
>>   {
>> -    return coresight_init_driver("tmc", &tmc_driver, 
>> &tmc_platform_driver);
>> +    return coresight_init_driver("tmc", &tmc_driver, 
>> &tmc_platform_driver, THIS_MODULE);
>>   }
>>     static void __exit tmc_exit(void)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c 
>> b/drivers/hwtracing/coresight/coresight-tpiu.c
>> index b048e146fbb1..f9ecd05cbe5c 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
>> @@ -318,7 +318,7 @@ static struct platform_driver 
>> tpiu_platform_driver = {
>>     static int __init tpiu_init(void)
>>   {
>> -    return coresight_init_driver("tpiu", &tpiu_driver, 
>> &tpiu_platform_driver);
>> +    return coresight_init_driver("tpiu", &tpiu_driver, 
>> &tpiu_platform_driver, THIS_MODULE);
>>   }
>>     static void __exit tpiu_exit(void)
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index f09ace92176e..e6c26952ddc2 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -660,7 +660,7 @@ coresight_find_output_type(struct 
>> coresight_platform_data *pdata,
>>                  union coresight_dev_subtype subtype);
>>     int coresight_init_driver(const char *drv, struct amba_driver 
>> *amba_drv,
>> -              struct platform_driver *pdev_drv);
>> +              struct platform_driver *pdev_drv, struct module *owner);
>>     void coresight_remove_driver(struct amba_driver *amba_drv,
>>                    struct platform_driver *pdev_drv);
>
>
> .
>


