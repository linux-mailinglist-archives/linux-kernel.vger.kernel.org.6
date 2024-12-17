Return-Path: <linux-kernel+bounces-449893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC09F577F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0A3188F6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7CE1F9ECC;
	Tue, 17 Dec 2024 20:17:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E93170822
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466624; cv=none; b=EjCZJ8pHblBzfy9Fze/Tppi4HgJ2Bgl57aOdel/egrXlKtcqZ83GeRWzFKWme/TMmXHgAGPfam7jlhUN5ZP4XsbenZMQezUs9CprP/2H5hMskhCQVMlyK1lFwX0eMvWROKkpZkl/r3sy4uzVa87m5sSK5VLQ1JvHOTXCzqhh9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466624; c=relaxed/simple;
	bh=pRypW7KH5HlUlUBUvd5v7lb41TTYS5LmMVimRkSAwU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tp1Xdf+XgIYVVjVyPfD3uHnGLmSuqghIokWLdcN6/IPkTBQfYMzV69QKbG6PdXoQRIWbMVG0NucznbvPdCjiI5Jzr3m26hK5cjc7ttjSOBszKXy5nAsi0OFERFq/8tHx2am+2AzT0LoN4fUrUNXMgvhXtNaE2JhAeE3GyVDrCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082C9497;
	Tue, 17 Dec 2024 12:17:28 -0800 (PST)
Received: from [172.27.42.65] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF93F3F528;
	Tue, 17 Dec 2024 12:16:59 -0800 (PST)
Message-ID: <8ef0a63c-bde2-443b-b2fd-59d24c5e18e6@arm.com>
Date: Tue, 17 Dec 2024 14:16:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
 gshan@redhat.com, steven.price@arm.com, sami.mujawar@arm.com,
 catalin.marinas@arm.com, will@kernel.org, linux-kernel@vger.kernel.org
References: <20241207012128.247522-1-jeremy.linton@arm.com>
 <20241207012128.247522-2-jeremy.linton@arm.com> <Z1Uiz7Hn2XisyP-N@vm3>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <Z1Uiz7Hn2XisyP-N@vm3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/7/24 10:38 PM, Itaru Kitayama wrote:
> Hi Jeremy,
> 
> On Fri, Dec 06, 2024 at 07:21:28PM -0600, Jeremy Linton wrote:
>> The TSM module provides guest identification and attestation when a
>> guest runs in CCA mode. By creating a dummy platform device, let's
> 
> Perhaps could you spell out like; a guest runs in the Realm state?

Thanks for looking at this.

I thought that was evident from the rest of the commits here, but sure.

Thanks again.


> 
> Thanks,
> Itaru.
>   
>> ensure the module is automatically loaded. The udev daemon loads the
>> TSM module after it receives a device addition event. Once that
>> happens, it can be used earlier in the boot process to decrypt the
>> rootfs.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/rsi.h                    |  2 ++
>>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  8 ++++++++
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
>> index 188cbb9b23f5..b42aeac05340 100644
>> --- a/arch/arm64/include/asm/rsi.h
>> +++ b/arch/arm64/include/asm/rsi.h
>> @@ -10,6 +10,8 @@
>>   #include <linux/jump_label.h>
>>   #include <asm/rsi_cmds.h>
>>   
>> +#define RSI_PDEV_NAME "arm-cca-dev"
>> +
>>   DECLARE_STATIC_KEY_FALSE(rsi_present);
>>   
>>   void __init arm64_rsi_init(void);
>> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
>> index 3031f25c32ef..5434e5496ac2 100644
>> --- a/arch/arm64/kernel/rsi.c
>> +++ b/arch/arm64/kernel/rsi.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/psci.h>
>>   #include <linux/swiotlb.h>
>>   #include <linux/cc_platform.h>
>> +#include <linux/platform_device.h>
>>   
>>   #include <asm/io.h>
>>   #include <asm/mem_encrypt.h>
>> @@ -140,3 +141,17 @@ void __init arm64_rsi_init(void)
>>   	static_branch_enable(&rsi_present);
>>   }
>>   
>> +static struct platform_device rsi_dev = {
>> +	.name = RSI_PDEV_NAME,
>> +	.id = PLATFORM_DEVID_NONE
>> +};
>> +
>> +static int __init rsi_init(void)
>> +{
>> +	if (is_realm_world() &&
>> +	    platform_device_register(&rsi_dev))
>> +		pr_err("failed to register rsi platform device\n");
>> +	return 0;
>> +}
>> +
>> +arch_initcall(rsi_init)
>> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>> index 488153879ec9..87f162736b2e 100644
>> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/arm-smccc.h>
>>   #include <linux/cc_platform.h>
>>   #include <linux/kernel.h>
>> +#include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/smp.h>
>>   #include <linux/tsm.h>
>> @@ -219,6 +220,13 @@ static void __exit arm_cca_guest_exit(void)
>>   }
>>   module_exit(arm_cca_guest_exit);
>>   
>> +/* modalias, so userspace can autoload this module when RSI is available */
>> +static const struct platform_device_id arm_cca_match[] __maybe_unused = {
>> +	{ RSI_PDEV_NAME, 0},
>> +	{ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(platform, arm_cca_match);
>>   MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
>>   MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
>>   MODULE_LICENSE("GPL");
>> -- 
>> 2.46.0
>>


