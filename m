Return-Path: <linux-kernel+bounces-389019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB749B679D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8301F22651
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5754121C160;
	Wed, 30 Oct 2024 15:16:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1921BAEC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301410; cv=none; b=nB0Vo6etoyMGcf0u3oxocPcTpu0tfROdqDybZhaP6FAGuXv4aOy//iwqxsMu7z2jszgDrVKS3Y1rDvYEIVonWqiLVdmGDoTI0grU3dQOjeTQwHOXwTBPp9+kZS9X2DM7o+0l8T6K0308oSq9Z1ApFQtfZrTaoDiTIVdCIg10Y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301410; c=relaxed/simple;
	bh=CQTlpv6yhjHEbV/CJ9VbmZBbzh8yiW0nnuG8pOBOO9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZRWJZf2HcMKOoRFYpBn7UyBPPTO9lorxD2GEWzhbrwQYW6+uVUxe/4dceFTZvxRsUO/zUt2WPRnsKDET7jAzvcB5DyGkXCdZNWA0gNXKRH2G3V0FpQpPCYKhu5wuzf633UxAwcAAZLlMHJNjOSbw5WwyPoD4gSnCk/EemSPB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5462113E;
	Wed, 30 Oct 2024 08:17:16 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 247943F66E;
	Wed, 30 Oct 2024 08:16:44 -0700 (PDT)
Message-ID: <b62b9ba4-eaf9-4533-9a97-7d5e2929b1e8@arm.com>
Date: Wed, 30 Oct 2024 10:16:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, sami.mujawar@arm.com, linux-kernel@vger.kernel.org
References: <20241029141114.7207-1-jeremy.linton@arm.com>
 <32211eb5-eed5-4c71-b62a-362d32e1af47@redhat.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <32211eb5-eed5-4c71-b62a-362d32e1af47@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gavin,

Thanks for looking at this!

On 10/29/24 7:23 PM, Gavin Shan wrote:
> Hi Jeremy,
> 
> On 10/30/24 12:11 AM, Jeremy Linton wrote:
>> The TSM module provides both guest identification as well as
>> attestation when a guest is run in CCA mode. Lets assure by creating a
>> dummy platform device that the module is automatically loaded during
>> boot. Once it is in place it can be used earlier in the boot process
>> to say decrypt a LUKS rootfs.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/rsi.h                    |  2 ++
>>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  7 +++++++
>>   3 files changed, 24 insertions(+)
>>
> 
> I don't understand how the TSM module is automatically loaded and 
> arm_cca_guest_init()
> is triggered because of the newly introduced platform device. Could you 
> please provide
> more details? Apart from it, some nick-picks as below.

I think your asking how the module boilerplate here works, AKA how the 
standard uevent/udev/modalias/kmod stuff works? The short version is 
that the platform bus uevents an add device with a modalias and 
userspace udev + kmod finds matching modules, and their dependencies, 
and loads them which triggers the module_init() calls.

The suse folks have a detailed description of how this works:
https://doc.opensuse.org/documentation/leap/reference/html/book-reference/cha-udev.html#sec-udev-kernel

So, this is a fairly common misuse of the platform bus, in this case to 
avoid needing a HWCAP. Assuring the module exists in the initrd will 
then result in it being loaded along any other modules required for the 
rootfs pivot.


> 
>> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
>> index 188cbb9b23f5..1b14a4c4257a 100644
>> --- a/arch/arm64/include/asm/rsi.h
>> +++ b/arch/arm64/include/asm/rsi.h
>> @@ -10,6 +10,8 @@
>>   #include <linux/jump_label.h>
>>   #include <asm/rsi_cmds.h>
>> +#define ARMV9_RSI_PDEV_NAME "arm-cca-dev"
>> +
> 
> Maybe 'ARMV9' can be avoided since RSI is the specific feature to ARMv9.
> Besides, we already had @rsi_present there. So I would suggest to rename
> it to RSI_PDEV_NAME

This and the remainder of the comments below look reasonable to me, thanks!
> 
>>   DECLARE_STATIC_KEY_FALSE(rsi_present);
>>   void __init arm64_rsi_init(void);
>> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
>> index 3031f25c32ef..ad963eb12921 100644
>> --- a/arch/arm64/kernel/rsi.c
>> +++ b/arch/arm64/kernel/rsi.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/psci.h>
>>   #include <linux/swiotlb.h>
>>   #include <linux/cc_platform.h>
>> +#include <linux/platform_device.h>
>>   #include <asm/io.h>
>>   #include <asm/mem_encrypt.h>
>> @@ -140,3 +141,17 @@ void __init arm64_rsi_init(void)
>>       static_branch_enable(&rsi_present);
>>   }
>> +static struct platform_device rsi_dev = {
>> +    .name = ARMV9_RSI_PDEV_NAME,
>> +    .id = -1
>> +};
>> +
> 
>          .id = PLATFORM_DEVID_NONE,
> 
>> +static int __init rsi_init(void)
>> +{
>> +    if (is_realm_world())
>> +        if (platform_device_register(&rsi_dev))
>> +            pr_err("failed to register rsi platform device");
>> +    return 0;
>> +}
>> +
> 
> Those two checks can be connected with '&&' and '\n' seems missed in the
> error message.
> 
>          if (is_realm_world() && platform_device_register(&rsi_dev))
>              pr_err("Failed to register RSI platform device\n");
> 
>> +arch_initcall(rsi_init)
>> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/ 
>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>> index 488153879ec9..e7ef3b83d5d9 100644
>> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/arm-smccc.h>
>>   #include <linux/cc_platform.h>
>>   #include <linux/kernel.h>
>> +#include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/smp.h>
>>   #include <linux/tsm.h>
>> @@ -219,6 +220,12 @@ static void __exit arm_cca_guest_exit(void)
>>   }
>>   module_exit(arm_cca_guest_exit);
>> +static const struct platform_device_id arm_cca_match[] = {
>> +    { ARMV9_RSI_PDEV_NAME, 0},
>> +    { }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(platform, arm_cca_match);
> 
> 
> /* Comments here to explain why @arm_cca_dev_ids[] is needed */
> static const struct platform_device_id arm_cca_dev_ids[] = {
>         ...
> };
> 
> MODULE_DEVICE_TABLE(platform, arm_cca_dev_ids);
> 
>>   MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
>>   MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
>>   MODULE_LICENSE("GPL");
> 
> Thanks,
> Gavin
> 


