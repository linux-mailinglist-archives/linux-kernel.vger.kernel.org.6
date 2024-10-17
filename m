Return-Path: <linux-kernel+bounces-369105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788589A18EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F52EB22914
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22429405;
	Thu, 17 Oct 2024 03:02:47 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B8DF71
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134167; cv=none; b=aVByebwP9iKegDmK+OWH4dKqgVAhs/vC8fJotaQMAJtp/ESXinIgted1LkT7s6DxrTts5GE+iZKxpnw7+qRYIbmETmZjz39k9bU/BYo2/tcWYV3pQX/Dmi1CZepysXz6ROnq5k61RhTqOL3YeNl5q2ozNdHS2ZAseV6i3eEBF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134167; c=relaxed/simple;
	bh=UV1SmY6xFfQqd/NIBdDZ7Xur7hn3pybZcwKtaKlMhbE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bTpcQrE6mgudc5Bx3BrGc5xh1nAGQmyUiKpdQbTjbC3rb0Az3sbYonHZz6I2zRsiHglGKUEqsMEeDt5Gy+6k4pg7lZzv7uPKKq+MSIH11RNwlujEAiDoN+76yT49VqYpS4OFPhuTAiqbDWtrtkexaV8/H8kTosxRwcfCqD9QwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxZYlQfhBnOeghAA--.49052S3;
	Thu, 17 Oct 2024 11:02:40 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAx_9VNfhBnNgQuAA--.35371S3;
	Thu, 17 Oct 2024 11:02:39 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Fix cpu hotplug issue
To: Huacai Chen <chenhuacai@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 lixianglai@loongson.cn, WANG Xuerui <kernel@xen0n.name>
References: <20241014063328.1216497-1-maobibo@loongson.cn>
 <CAAhV-H5_SUnrf0PwOUFOA0EumKvGOmgqUq=Cx61Ub5AW=MPo=A@mail.gmail.com>
 <24ea8b02-8c94-d561-cef0-01044b610a1e@loongson.cn>
 <CAAhV-H7NqzO-FLmYoUySp5KYKJM+aN_s7g4i+qBixx5jwnbW=Q@mail.gmail.com>
 <5c1e0199-24ce-50d2-1cbc-5c9949a17563@loongson.cn>
 <CAAhV-H6JKNBgsLdAsKHp3rttpY+0KGabac2m87-PsT4FH_H=Ew@mail.gmail.com>
 <035be759-3adc-d224-43f8-1888822f6492@loongson.cn>
 <CAAhV-H4esrPeWAM1ExA2xAsUQ_Aitncro-i31e4wJO5OOVcwEQ@mail.gmail.com>
 <0cccad0d-8632-5e3f-ba07-3e96ad5d8263@loongson.cn>
 <CAAhV-H73s=vdremKcJRc_xAcyN2_qZMHvM_aVmzX619Jb52B-Q@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <28523dc2-5fae-cf0f-0bd7-5a1978406356@loongson.cn>
Date: Thu, 17 Oct 2024 11:02:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H73s=vdremKcJRc_xAcyN2_qZMHvM_aVmzX619Jb52B-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAx_9VNfhBnNgQuAA--.35371S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3tFWxJr4fGF4fuF4kJF1DurX_yoWkWw1xpr
	yUCFs8Jr4UJF1UGw10q348Gr1Utr1DGr47X3W7KF15AFn8tr1UJr4UXr15CryUGw48Jr10
	qr15Ja13XF18J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUU
	UUU==



On 2024/10/14 下午6:11, Huacai Chen wrote:
> On Mon, Oct 14, 2024 at 6:01 PM maobibo <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2024/10/14 下午5:29, Huacai Chen wrote:
>>> On Mon, Oct 14, 2024 at 5:12 PM maobibo <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/10/14 下午4:23, Huacai Chen wrote:
>>>>> On Mon, Oct 14, 2024 at 4:01 PM maobibo <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> Huacai,
>>>>>>
>>>>>> On 2024/10/14 下午3:39, Huacai Chen wrote:
>>>>>>> On Mon, Oct 14, 2024 at 3:21 PM maobibo <maobibo@loongson.cn> wrote:
>>>>>>>>
>>>>>>>> Huacai,
>>>>>>>>
>>>>>>>> On 2024/10/14 下午3:05, Huacai Chen wrote:
>>>>>>>>> Hi, Bibo,
>>>>>>>>>
>>>>>>>>> I'm a little confused, so please correct me if I'm wrong.
>>>>>>>>>
>>>>>>>>> On Mon, Oct 14, 2024 at 2:33 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>>>>>
>>>>>>>>>> On LoongArch system, there are two places to set cpu numa node. One
>>>>>>>>>> is in arch specified function smp_prepare_boot_cpu(), the other is
>>>>>>>>>> in generic function early_numa_node_init(). The latter will overwrite
>>>>>>>>>> the numa node information.
>>>>>>>>>>
>>>>>>>>>> However for hot-added cpu, cpu_logical_map() fails to its physical
>>>>>>>>>> cpuid at beginning since it is not enabled in ACPI MADT table. So
>>>>>>>>>> function early_cpu_to_node() also fails to get its numa node for
>>>>>>>>>> hot-added cpu, and generic function early_numa_node_init() will
>>>>>>>>>> overwrite incorrect numa node.
>>>>>>>>> For hot-added cpus, we will call acpi_map_cpu() -->
>>>>>>>>> acpi_map_cpu2node() --> set_cpuid_to_node(), and set_cpuid_to_node()
>>>>>>>>> operates on __cpuid_to_node[]. So I think early_cpu_to_node() should
>>>>>>>>> be correct?
>>>>>>>>
>>>>>>>> __cpuid_to_node[] is correct which is physical cpuid to numa node,
>>>>>>>> however cpu_logical_map(cpu) is not set. It fails to get physical cpuid
>>>>>>>> from logic cpu.
>>>>>>>>
>>>>>>>> int early_cpu_to_node(int cpu)
>>>>>>>> {
>>>>>>>>              int physid = cpu_logical_map(cpu);
>>>>>>>>
>>>>>>>> <<<<<<<<<<< Here physid is -1.
>>>>>>> early_cpu_to_node() is not supposed to be called after boot, and if it
>>>>>> Which calls early_cpu_to_node() after boot?
>>>>>>
>>>>>>> is really needed, I think a better solution is:
>>>>>>>
>>>>>>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
>>>>>>> index f1a74b80f22c..998cf45fd3b7 100644
>>>>>>> --- a/arch/loongarch/kernel/acpi.c
>>>>>>> +++ b/arch/loongarch/kernel/acpi.c
>>>>>>> @@ -311,6 +311,8 @@ static int __ref acpi_map_cpu2node(acpi_handle
>>>>>>> handle, int cpu, int physid)
>>>>>>>
>>>>>>>             nid = acpi_get_node(handle);
>>>>>>>             if (nid != NUMA_NO_NODE) {
>>>>>>> +               __cpu_number_map[physid] = cpu;
>>>>>>> +               __cpu_logical_map[cpu] = physid;
>>>>>> This does not solve the problem. The above has been done in function
>>>>>> cpu = set_processor_mask(physid, ACPI_MADT_ENABLED);
>>>>>>
>>>>>> static int set_processor_mask(u32 id, u32 flags)
>>>>>> {
>>>>>> ...
>>>>>>             if (flags & ACPI_MADT_ENABLED) {
>>>>>>                     num_processors++;
>>>>>>                     set_cpu_present(cpu, true);
>>>>>>                     __cpu_number_map[cpuid] = cpu;
>>>>>>                     __cpu_logical_map[cpu] = cpuid;
>>>>>>             }
>>>>>>
>>>>>> The problem is that
>>>>>>             smp_prepare_boot_cpu(); /* arch-specific boot-cpu hooks */
>>>>>> <<<<<<<<<<<<<<<<
>>>>>> set_cpu_numa_node() is called in function smp_prepare_boot_cpu()
>>>>>>
>>>>>>             early_numa_node_init();
>>>>>>
>>>>>> static void __init early_numa_node_init(void)
>>>>>> {
>>>>>> #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>>>>>> #ifndef cpu_to_node
>>>>>>             int cpu;
>>>>>>
>>>>>>             /* The early_cpu_to_node() should be ready here. */
>>>>>>             for_each_possible_cpu(cpu)
>>>>>>                     set_cpu_numa_node(cpu, early_cpu_to_node(cpu));
>>>>>> <<<<<<<<<<<<<<<<
>>>>>> * however here early_cpu_to_node is -1, so that cpu_to_node(cpu) will
>>>>>> always return -1 in late. *, which causes cpu hotadd problem.
>>>>> Still confused. For ACPI_MADT_ENABLED cpus, everything is right after
>>>>> early_numa_node_init(). For !ACPI_MADT_ENABLED cpus, cpu_to_node()
>>>>> returns -1 after early_numa_node_init() and before hot-add, but if
>>>>> acpi_map_cpu() do things right, cpu_to_node() should still work well
>>>>> after hot-add.
>>>> yes, if "_PXM" information for hot-add cpu handle exist, it works well.
>>>>
>>>> However if "_PXM" information does not exist, it falls back to legacy
>>>> method from smp_prepare_boot_cpu(). However cpu_numa_node information is
>>>> overwritten with -1 by later function early_numa_node_init().
>>> OK, now I finally get the key point. But no _PXM should be treated as
>>> a BIOS bug, right?
>> Currently if no numa information is added in qemu command line, there
>> will be no "_PXM" information for hot-added cpu. Such as for this command:
>>     qemu-system-loongarch64 -m 4096 -smp
>> 1,maxcpus=4,sockets=1,cores=4,threads=1
>>>
>>>   From comments we can see:
>>>
>>>                    * If possible cpus > present cpus here (e.g. some possible
>>>                    * cpus will be added by cpu-hotplug later), for possible but
>>>                    * not present cpus, early_cpu_to_node will return NUMA_NO_NODE,
>>>                    * and we just map them to online nodes in round-robin way.
>>>                    * Once hotplugged, new correct mapping will be built for them.
>>>
>>> This means even with this patch, cpu_to_node() can return a "valid"
>>> node rather than NUMA_NO_NODE, but this round-robin node is still an
>>> incorrect node.
>> The round-robin node is not standard, may it is copied from x86, I do
>> not know how to use it however. At least SRAT tables provides numa
>> information only that there is not logical cpu allocated in SRAT table
>> parsing. How about something like this?
> This looks better, but maybe Jianmin has a best solution?
> 
>>
>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
>> index f1a74b80f22c..bb9fdd318998 100644
>> --- a/arch/loongarch/kernel/acpi.c
>> +++ b/arch/loongarch/kernel/acpi.c
>> @@ -310,6 +310,12 @@ static int __ref acpi_map_cpu2node(acpi_handle
>> handle, int cpu, int physid)
>>           int nid;
>>
>>           nid = acpi_get_node(handle);
>> +       /*
>> +        * Fall back to srat numa node information if _PXM is not provided
> The comments may be wrong? I think SRAT node information is equal to _PXM.

"_PXM" information does not belong to SRAT table, it is in DSDT CPU 
device table.
For numa system "_PXM" information is required, however for uma system 
"_PXM" information is not required since there is only one memory node.

X86 linux uses SRAT table for present cpus and _PXM information in cpu 
device for hot-added cpus. For uma system, _PXM is absent and rr method 
is used for online nodes, its value is correct still since there is only 
one memory node.

Regards
Bibo Mao

>> +        */
>> +       if (nid != NUMA_NO_NODE)
>> +               nid = __cpuid_to_node[physid];
>> +
>>           if (nid != NUMA_NO_NODE) {
> Maybe this condition can be removed now?
> 
> Huacai
> 
>>                   set_cpuid_to_node(physid, nid);
>>                   node_set(nid, numa_nodes_parsed);
>>
>> Regards
>> Bibo Mao
>>>
>>> Huacai
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>>> Huacai
>>>>>>
>>>>>> Regards
>>>>>> Bibo Mao
>>>>>>
>>>>>>
>>>>>>>                     set_cpuid_to_node(physid, nid);
>>>>>>>                     node_set(nid, numa_nodes_parsed);
>>>>>>>                     set_cpu_numa_node(cpu, nid);
>>>>>>>
>>>>>>> Huacai
>>>>>>>
>>>>>>>>
>>>>>>>>              if (physid < 0)
>>>>>>>>                      return NUMA_NO_NODE;
>>>>>>>>
>>>>>>>>              return __cpuid_to_node[physid];
>>>>>>>> }
>>>>>>>>
>>>>>>>> Regards
>>>>>>>> Bibo Mao
>>>>>>>>>
>>>>>>>>> Huacai
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Here static array __cpu_to_node and api set_early_cpu_to_node()
>>>>>>>>>> is added, so that early_cpu_to_node is consistent with function
>>>>>>>>>> cpu_to_node() for hot-added cpu.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>>>>>> ---
>>>>>>>>>>       arch/loongarch/include/asm/numa.h |  2 ++
>>>>>>>>>>       arch/loongarch/kernel/numa.c      | 10 +++++++++-
>>>>>>>>>>       arch/loongarch/kernel/smp.c       |  1 +
>>>>>>>>>>       3 files changed, 12 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
>>>>>>>>>> index b5f9de9f102e..e8e6fcfb006a 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/numa.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/numa.h
>>>>>>>>>> @@ -50,6 +50,7 @@ static inline void set_cpuid_to_node(int cpuid, s16 node)
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>>       extern int early_cpu_to_node(int cpu);
>>>>>>>>>> +extern void set_early_cpu_to_node(int cpu, s16 node);
>>>>>>>>>>
>>>>>>>>>>       #else
>>>>>>>>>>
>>>>>>>>>> @@ -57,6 +58,7 @@ static inline void early_numa_add_cpu(int cpuid, s16 node)    { }
>>>>>>>>>>       static inline void numa_add_cpu(unsigned int cpu)              { }
>>>>>>>>>>       static inline void numa_remove_cpu(unsigned int cpu)           { }
>>>>>>>>>>       static inline void set_cpuid_to_node(int cpuid, s16 node)      { }
>>>>>>>>>> +static inline void set_early_cpu_to_node(int cpu, s16 node)    { }
>>>>>>>>>>
>>>>>>>>>>       static inline int early_cpu_to_node(int cpu)
>>>>>>>>>>       {
>>>>>>>>>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
>>>>>>>>>> index 84fe7f854820..62508aace644 100644
>>>>>>>>>> --- a/arch/loongarch/kernel/numa.c
>>>>>>>>>> +++ b/arch/loongarch/kernel/numa.c
>>>>>>>>>> @@ -34,6 +34,9 @@ static struct numa_meminfo numa_meminfo;
>>>>>>>>>>       cpumask_t cpus_on_node[MAX_NUMNODES];
>>>>>>>>>>       cpumask_t phys_cpus_on_node[MAX_NUMNODES];
>>>>>>>>>>       EXPORT_SYMBOL(cpus_on_node);
>>>>>>>>>> +static s16 __cpu_to_node[NR_CPUS] = {
>>>>>>>>>> +       [0 ... CONFIG_NR_CPUS - 1] = NUMA_NO_NODE
>>>>>>>>>> +};
>>>>>>>>>>
>>>>>>>>>>       /*
>>>>>>>>>>        * apicid, cpu, node mappings
>>>>>>>>>> @@ -117,11 +120,16 @@ int early_cpu_to_node(int cpu)
>>>>>>>>>>              int physid = cpu_logical_map(cpu);
>>>>>>>>>>
>>>>>>>>>>              if (physid < 0)
>>>>>>>>>> -               return NUMA_NO_NODE;
>>>>>>>>>> +               return __cpu_to_node[cpu];
>>>>>>>>>>
>>>>>>>>>>              return __cpuid_to_node[physid];
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> +void set_early_cpu_to_node(int cpu, s16 node)
>>>>>>>>>> +{
>>>>>>>>>> +       __cpu_to_node[cpu] = node;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>       void __init early_numa_add_cpu(int cpuid, s16 node)
>>>>>>>>>>       {
>>>>>>>>>>              int cpu = __cpu_number_map[cpuid];
>>>>>>>>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>>>>>>>>>> index 9afc2d8b3414..998668be858c 100644
>>>>>>>>>> --- a/arch/loongarch/kernel/smp.c
>>>>>>>>>> +++ b/arch/loongarch/kernel/smp.c
>>>>>>>>>> @@ -512,6 +512,7 @@ void __init smp_prepare_boot_cpu(void)
>>>>>>>>>>                              set_cpu_numa_node(cpu, node);
>>>>>>>>>>                      else {
>>>>>>>>>>                              set_cpu_numa_node(cpu, rr_node);
>>>>>>>>>> +                       set_early_cpu_to_node(cpu, rr_node);
>>>>>>>>>>                              rr_node = next_node_in(rr_node, node_online_map);
>>>>>>>>>>                      }
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
>>>>>>>>>> --
>>>>>>>>>> 2.39.3
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>


