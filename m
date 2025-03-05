Return-Path: <linux-kernel+bounces-545927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A0A4F3D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB97D16B3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BF1465AD;
	Wed,  5 Mar 2025 01:33:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE7143736
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138435; cv=none; b=rLrO1Ug1gMUG89g5BOZRjyzH/0Beu9cAXBmQnVR+MVwYh+PaYchp+0f8P6iwdITi/GkXuJNyp96kl3cTpajmrV6B6bn0l5caLDS8hlQ2Ez6fkys+yS4n+cqTpN+A+ZjdVYZiJ9gh6/mnez+qGaL/g2NsQ+TOPKDtpEX0sLeSeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138435; c=relaxed/simple;
	bh=RJSsvUkwE1psIq7jswRIkOyjYBcD9wsUQCVHvA2sFwc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NF7v2EC4tIhBwNDSh3U9E4s2Lg6MWbkwF3rMsilflP9fK3H3SWNBIZx5l08oQ/ce2zZONsqa7qssCvxLlJDcw2izvFMyNfwwWNSJ3bdrZ9QrCXdbHWl+MHK3QeQdFejl3cae21V6h32YOXD4ppj7IloeIp3PJmzVjxbfQTk2gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxYa_8qcdnPrGKAA--.64530S3;
	Wed, 05 Mar 2025 09:33:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDxPcX5qcdnIbg2AA--.4576S3;
	Wed, 05 Mar 2025 09:33:47 +0800 (CST)
Subject: Re: [PATCH] LoongArch: mm: Set max_pfn with the PFN of the last page
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250304112708.1810033-1-maobibo@loongson.cn>
 <CAAhV-H7ZAK15ob3M=5eQrOhPvkSFhkrmVHd-mn6RXgQqQV_Ebg@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <3a04b960-e3ad-0656-d69d-6e85079d305a@loongson.cn>
Date: Wed, 5 Mar 2025 09:33:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7ZAK15ob3M=5eQrOhPvkSFhkrmVHd-mn6RXgQqQV_Ebg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPcX5qcdnIbg2AA--.4576S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1UWr1xXr1xXr1fXr4xGrX_yoW5Zry5pr
	W8AF1DWr4UGr1xC34Fqw1kuryfW3s0k3y3Wa1rKF1Syr15Xrn3Xw40qrnxuF1qqw4xJa1F
	qrZ0gFyqvFWUtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUU
	U



On 2025/3/4 下午8:25, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Mar 4, 2025 at 7:27 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> The current max_pfn equals to zero. In this case, it caused users cannot
>> get some page information through /proc such as kpagecount. The following
>> message is displayed by stress-ng test suite with the command
>> "stress-ng --verbose --physpage 1 -t 1".
>>
>>   # stress-ng --verbose --physpage 1 -t 1
>>   stress-ng: error: [1691] physpage: cannot read page count for address 0x134ac000 in /proc/kpagecount, errno=22 (Invalid argument)
>>   stress-ng: error: [1691] physpage: cannot read page count for address 0x7ffff207c3a8 in /proc/kpagecount, errno=22 (Invalid argument)
>>   stress-ng: error: [1691] physpage: cannot read page count for address 0x134b0000 in /proc/kpagecount, errno=22 (Invalid argument)
>>   ...
>>
>> After applying this patch, the kernel can pass the test.
>>   # stress-ng --verbose --physpage 1 -t 1
>>   stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU 3)
>>   stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU 3)
>>   stress-ng: debug: [1700] physpage: [1701] terminated (success)
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> I think this patch are mainly fix commit
> ff6c3d81f2e86b63a3a530683f89ef39 ("NUMA: optimize detection of memory
> with no node id assigned by firmware"). So it is better to add a
> Fixes: tag and Cc stable.
> 
> And the patch itself can be improved. there are three cases of
> calculating max_low_pfn:
> ACPI with NUMA, handled in numa.c
> ACPI without NUMA, handled in mem.c
> FDT, handled in setup.c
> 
> You have missed the 2nd case. The simplest way is add "max_pfn =
> max_low_pfn" at the beginning of arch_mem_init() because all cases can
> be handled here.
yes, that is actually one problem:)  Will do this simply in 
arch_mem_init() in next patch.

Regards
Bibo Mao
> 
> Huacai
> 
>> ---
>>   arch/loongarch/kernel/numa.c  | 2 +-
>>   arch/loongarch/kernel/setup.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
>> index 84fe7f854820..002dbe62b329 100644
>> --- a/arch/loongarch/kernel/numa.c
>> +++ b/arch/loongarch/kernel/numa.c
>> @@ -356,7 +356,7 @@ int __init init_numa_memory(void)
>>                  node_mem_init(node);
>>                  node_set_online(node);
>>          }
>> -       max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
>> +       max_low_pfn = max_pfn = PHYS_PFN(memblock_end_of_DRAM());
>>
>>          setup_nr_node_ids();
>>          loongson_sysconf.nr_nodes = nr_node_ids;
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index edcfdfcad7d2..ab8c9336d8f5 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -294,7 +294,7 @@ static void __init fdt_setup(void)
>>          early_init_dt_scan(fdt_pointer, __pa(fdt_pointer));
>>          early_init_fdt_reserve_self();
>>
>> -       max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());
>> +       max_low_pfn = max_pfn = PFN_PHYS(memblock_end_of_DRAM());
>>   #endif
>>   }
>>
>> --
>> 2.39.3
>>


