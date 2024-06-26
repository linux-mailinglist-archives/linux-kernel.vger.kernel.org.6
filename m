Return-Path: <linux-kernel+bounces-230727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D9F918125
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386D71C21746
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73117B4F7;
	Wed, 26 Jun 2024 12:41:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122A181D05
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405686; cv=none; b=nATOlY7QT4fujNQ341547JM2VSbhO7zxsHLGaRG+OJ1VBuPRRtUqtR1r+QmXlDeIOkcVAQaIwxsn/UVGIdBWpqMS9GvE01hTGlNfdVEY8I+MafUTPxlkcMk5D2pc/3yq5hWBq0CpBtbTI0b+RN211a5BgbHTha88/Hu/Zvxrzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405686; c=relaxed/simple;
	bh=Gazlu4yIzIifgnxHiUMGBGc85k5rKrXcsmbWwRoEwPM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YdMv7sq8OHAzqcMAB8smCGgUEh8jfFJ0okuYL51ZWb7zCwl/e67EJTxB22tincUiTFVzsCiJwDWtCM53t85OhVMxYRgCrFEn3HPmJKkkeVlFZRIr9XoS2cdEzEy+9HmRVWB/vQCfjIKR1tiNHU1qLxZMRO/4tI9EFRzWyV1jXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8Lml0TYCzZg1b;
	Wed, 26 Jun 2024 20:36:55 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 7068F18006C;
	Wed, 26 Jun 2024 20:41:19 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 20:41:19 +0800
Message-ID: <5693310f-8706-42e3-89e5-af512a24ff99@huawei.com>
Date: Wed, 26 Jun 2024 20:41:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Dynamically allocate cpumasks and further
 increase range and default value of NR_CPUS
Content-Language: en-US
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<liuyuntao12@huawei.com>
References: <20240614075306.357861-1-liuyuntao12@huawei.com>
 <20240625-c1c3b9fcb6ee148294d4ceb4@orel>
 <8841edbc-dd65-452c-a459-b5ce42e289d9@huawei.com>
In-Reply-To: <8841edbc-dd65-452c-a459-b5ce42e289d9@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/6/25 19:44, liuyuntao (F) wrote:
> 
> 
> On 2024/6/25 19:11, Andrew Jones wrote:
>> On Fri, Jun 14, 2024 at 07:53:06AM GMT, Yuntao Liu wrote:
>>> Currently default NR_CPUS is 64 for riscv64, since the latest QEMU virt
>>> machine supports up to 512 CPUS, so set default NR_CPUS 512 for riscv64.
>>>
>>> Under the promotion of RISC-V International and related chip
>>> manufacturers, RISC-V has also begun to enter the server market, which
>>> demands higher performance. Other major architectures (such as ARM64,
>>> x86_64, MIPS, etc) already have a higher range, so further increase
>>> this range up to 4096 for riscv64.
>>>
>>> Due to the fact that increasing NR_CPUS enlarges the size of cpumasks,
>>> there is a concern that this could significantly impact stack usage,
>>> especially for code that allocates cpumasks on the stack. To address
>>> this, we have the option to enable CPUMASK_OFFSTACK, which prevents
>>> cpumasks from being allocated on the stack. we choose to enable this
>>> feature only when NR_CPUS is greater than 512, why 512, since then
>>> the kernel size with offstack is smaller.
>>
>> This isn't the reason why Arm decided to start at 512, afaict. The reason
>> for Arm was because hackbench did better with onstack for 256. What are
>> the hackbench results for riscv?
> 
> Okay, I will add the test results of hacktest soon.

Benchmark results using hackbench average over 5 runs of
./hackbench -s 512 -l 20 -g 10 -f 50 -P
on Qemu.

NR_CPUS     64      128     256     512     1024    2048
onstack/s   6.9992  6.6112  6.7834  6.6578  6.6646  6.8692
offstack/s  6.5616  6.95    6.5698  6.91    6.663   6.8202
difference  -6.25%  +5.12%  -3.15%  +3.79%  -0.02%  -0.71%

When there are more cores, the fluctuation is minimal, leading to the 
speculation that the performance gap would be smaller with a higher 
number of NR_CPUS.
Since I don't have a RISCV single-board computer, these are the results 
I obtained from testing in QEMU, which may differ from the actual 
situation. Perhaps someone could help with the testing.

Thanks,
Yuntao

> 
>>
>>>
>>> vmlinux size comparison(difference to vmlinux_onstack_NR_CPUS baseline):
>>>
>>> NR_CPUS     256         512         1024        2048        4096
>>> onstack     19814536    19840760    19880584    19969672    20141704
>>> offstack    19819144    19840936    19880480    19968544    20135456
>>> difference  +0.023%     +0.001%     -0.001%     -0.001      -0.031%
>>> is_smaller  n           n           y           y           y
>>
>> Since the savings are almost nothing we must not have too many global
>> cpumasks. But I'm in favor of ensuring stack depths stay under control,
>> so turning on CPUMASK_OFFSTACK sounds good to me in general.
>>
>>>
>>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>>> ---
>>>   arch/riscv/Kconfig | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 0525ee2d63c7..5960713b3bf9 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -77,6 +77,7 @@ config RISCV
>>>       select CLINT_TIMER if RISCV_M_MODE
>>>       select CLONE_BACKWARDS
>>>       select COMMON_CLK
>>> +    select CPUMASK_OFFSTACK if NR_CPUS > 512
>>>       select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
>>>       select EDAC_SUPPORT
>>>       select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && 
>>> !DYNAMIC_FTRACE)
>>> @@ -428,11 +429,11 @@ config SCHED_MC
>>>   config NR_CPUS
>>>       int "Maximum number of CPUs (2-512)"
>>>       depends on SMP
>>> -    range 2 512 if !RISCV_SBI_V01
>>> +    range 2 4096 if !RISCV_SBI_V01
>>>       range 2 32 if RISCV_SBI_V01 && 32BIT
>>>       range 2 64 if RISCV_SBI_V01 && 64BIT
>>>       default "32" if 32BIT
>>> -    default "64" if 64BIT
>>> +    default "512" if 64BIT
>>
>> This is somewhat reasonable, even if nothing is going to use this for
>> quite a while, since it'll help avoid bugs popping up when NR_CPUS gets
>> bumped later, but it feels excessive right now for riscv, so I'm a bit
>> on the fence about it. Maybe if hackbench doesn't show any issues we
>> could turn CPUMASK_OFFSTACK on for a smaller NR_CPUS and also select
>> a smaller default?
>>

It seems that when NR_CPUS is larger, hackbench performs better, and 
which NR_CPUS do you have a preference for?

>> Thanks,
>> drew
>>
>>>   config HOTPLUG_CPU
>>>       bool "Support for hot-pluggable CPUs"
>>> -- 
>>> 2.34.1
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv

