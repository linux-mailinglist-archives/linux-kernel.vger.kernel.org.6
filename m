Return-Path: <linux-kernel+bounces-375389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF89A955C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AC1280F58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5E558A5;
	Tue, 22 Oct 2024 01:17:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1A85C5E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559857; cv=none; b=EnctLA0cwGFClGdyLmUbjClI25zf/6BaVJF7lwX3vGZ3qSlA7j1SItx1gDVUqd7e76yNW9Nxe1eBA38PAlhZVhSE/gIly1AUn0AI2ypZmJ0bcSuXXUn661a74eB/s6/FFaToxu1d5KzP+08kOr0NH04bq2yKVO76sHNrjvMJOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559857; c=relaxed/simple;
	bh=YxzuQAOrLSTk+5x6q7VsK5p4zqLg2qOaEcjDotNLHNI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e3qOWh6CgziwAPdJMRzDGUAIYKcHj8FusZDdc966Y0W2+x2DjDRX7xKxLj0goNiH4uaQ8/JQaRHDu3jLEJ8exMpI2J9XQ+jh2H8iv97xF6Rz4WhVckNCaOSpTOxuXWe7fhayCuCGMOnUHO4ZMgVs0VZKD6gAuJz66rLoOMpG8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxCeEr_RZn98MDAA--.8844S3;
	Tue, 22 Oct 2024 09:17:31 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCxDuEo_RZn+tQFAA--.35230S3;
	Tue, 22 Oct 2024 09:17:30 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Fix cpu hotplug issue
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, lixianglai@loongson.cn,
 WANG Xuerui <kernel@xen0n.name>
References: <20241021080418.644342-1-maobibo@loongson.cn>
 <CAAhV-H4anpgfiAnPgm9h-m9pKCW0KUio+E72r1Q3F_0vm+zMRg@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <8c55c680-48c8-0ba3-c2a1-56dc72929a8d@loongson.cn>
Date: Tue, 22 Oct 2024 09:17:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4anpgfiAnPgm9h-m9pKCW0KUio+E72r1Q3F_0vm+zMRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxDuEo_RZn+tQFAA--.35230S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4xAw4rJF47tw15Kr1kXrc_yoW3uFW3pr
	y8Ca98Wrs5WFnrW3sav3y0gryrtr1kKa17Wa43KFyrAF1DZrn7Xr4vgr9xuFyrWw48GF10
	vF1rWFsFgF4DJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUU
	UUU==



On 2024/10/21 下午10:32, Huacai Chen wrote:
> Hi, Bibo,
> 
> This version still doesn't touch the round-robin method, but it
> doesn't matter, I think I misunderstood something since V1...
I do not understand why round-robin method need be modified, SRAT may be 
disabled with general function disable_srat(). Then round-robin method 
is required.

> 
> Please correct me if I'm wrong: For cpus without ACPI_MADT_ENABLED, in
> smp_prepare_boot_cpu() the round-robin node ids only apply to
> cpu_to_node(), but __cpuid_to_node[] still record the right node ids.
> early_cpu_to_node() returns NUMA_NO_NODE not because
> __cpuid_to_node[] records NUMA_NO_NODE, but because cpu_logical_map()
> < 0.
> 
> If the above is correct, we don't need so complicated, because the
> correct and simplest way is:
> https://lore.kernel.org/loongarch/6b2b3e89-5a46-2d20-3dfb-7aae33839f49@loongson.cn/T/#m950eead5250e5992cc703bbe69622348cecfa465
> 
It works also. Only that LoongArch kernel parsing about SRAT/MADT is 
badly. If you do not mind, I do not mind neither. It is not my duty for 
kernel side.

Bibo Mao
> 
> Huacai
> 
> On Mon, Oct 21, 2024 at 4:04 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> On LoongArch system, there are two places to set cpu numa node. One
>> is in arch specified function smp_prepare_boot_cpu(), the other is
>> in generic function early_numa_node_init(). The latter will overwrite
>> the numa node information.
>>
>> With hot-added cpu without numa information, cpu_logical_map() fails
>> to its physical cpuid at beginning since it is not enabled in ACPI
>> MADT table. So function early_cpu_to_node() also fails to get its
>> numa node for hot-added cpu, and generic function
>> early_numa_node_init() will overwrite with incorrect numa node.
>>
>> APIs topo_get_cpu() and topo_add_cpu() is added here, like other
>> architectures logic cpu is allocated when parsing MADT table. When
>> parsing SRAT table or hot-add cpu, logic cpu is acquired by searching
>> all allocated logical cpu with matched physical id. It solves such
>> problems such as:
>>    1. Boot cpu is not the first entry in MADT table, the first entry
>> will be overwritten with later boot cpu.
>>    2. Physical cpu id not presented in MADT table is invalid, in later
>> SRAT/hot-add cpu parsing, invalid physical cpu detected is added
>>    3. For hot-add cpu, its logic cpu is allocated in MADT table parsing,
>> so early_cpu_to_node() can be used for hot-add cpu and cpu_to_node()
>> is correct for hot-add cpu.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>> v1 ... v2:
>>    1. Like other architectures, allocate logic cpu when parsing MADT table.
>>    2. Add invalid or duplicated physical cpuid parsing with SRAT table or
>> hot-add cpu DSDT information.
>> ---
>>   arch/loongarch/include/asm/smp.h |  3 ++
>>   arch/loongarch/kernel/acpi.c     | 24 ++++++++++------
>>   arch/loongarch/kernel/setup.c    | 47 ++++++++++++++++++++++++++++++++
>>   arch/loongarch/kernel/smp.c      |  9 +++---
>>   4 files changed, 70 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
>> index 3383c9d24e94..c61b75937a77 100644
>> --- a/arch/loongarch/include/asm/smp.h
>> +++ b/arch/loongarch/include/asm/smp.h
>> @@ -119,4 +119,7 @@ static inline void __cpu_die(unsigned int cpu)
>>   #define cpu_logical_map(cpu)   0
>>   #endif /* CONFIG_SMP */
>>
>> +int topo_add_cpu(int physid);
>> +int topo_get_cpu(int physid);
>> +
>>   #endif /* __ASM_SMP_H */
>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
>> index f1a74b80f22c..84d9812d5f38 100644
>> --- a/arch/loongarch/kernel/acpi.c
>> +++ b/arch/loongarch/kernel/acpi.c
>> @@ -78,10 +78,10 @@ static int set_processor_mask(u32 id, u32 flags)
>>                  return -ENODEV;
>>
>>          }
>> -       if (cpuid == loongson_sysconf.boot_cpu_id)
>> -               cpu = 0;
>> -       else
>> -               cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
>> +
>> +       cpu = topo_add_cpu(cpuid);
>> +       if (cpu < 0)
>> +               return -EEXIST;
>>
>>          if (!cpu_enumerated)
>>                  set_cpu_possible(cpu, true);
>> @@ -203,8 +203,6 @@ void __init acpi_boot_table_init(void)
>>                  goto fdt_earlycon;
>>          }
>>
>> -       loongson_sysconf.boot_cpu_id = read_csr_cpuid();
>> -
>>          /*
>>           * Process the Multiple APIC Description Table (MADT), if present
>>           */
>> @@ -257,7 +255,7 @@ void __init numa_set_distance(int from, int to, int distance)
>>   void __init
>>   acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
>>   {
>> -       int pxm, node;
>> +       int pxm, node, cpu;
>>
>>          if (srat_disabled())
>>                  return;
>> @@ -286,6 +284,11 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
>>                  return;
>>          }
>>
>> +       cpu = topo_get_cpu(pa->apic_id);
>> +       /* Check whether apic_id exists in MADT table */
>> +       if (cpu < 0)
>> +               return;
>> +
>>          early_numa_add_cpu(pa->apic_id, node);
>>
>>          set_cpuid_to_node(pa->apic_id, node);
>> @@ -324,12 +327,17 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu
>>   {
>>          int cpu;
>>
>> -       cpu = set_processor_mask(physid, ACPI_MADT_ENABLED);
>> +       cpu = topo_get_cpu(physid);
>> +       /* Check whether apic_id exists in MADT table */
>>          if (cpu < 0) {
>>                  pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
>>                  return cpu;
>>          }
>>
>> +       num_processors++;
>> +       set_cpu_present(cpu, true);
>> +       __cpu_number_map[physid] = cpu;
>> +       __cpu_logical_map[cpu] = physid;
>>          acpi_map_cpu2node(handle, cpu, physid);
>>
>>          *pcpu = cpu;
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index 00e307203ddb..649e98640076 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -65,6 +65,8 @@ EXPORT_SYMBOL(cpu_data);
>>
>>   struct loongson_board_info b_info;
>>   static const char dmi_empty_string[] = "        ";
>> +static int possible_cpus;
>> +static bool bsp_added;
>>
>>   /*
>>    * Setup information
>> @@ -346,10 +348,55 @@ static void __init bootcmdline_init(char **cmdline_p)
>>          *cmdline_p = boot_command_line;
>>   }
>>
>> +int topo_get_cpu(int physid)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < possible_cpus; i++)
>> +               if (cpu_logical_map(i) == physid)
>> +                       break;
>> +
>> +       if (i == possible_cpus)
>> +               return -ENOENT;
>> +
>> +       return i;
>> +}
>> +
>> +int topo_add_cpu(int physid)
>> +{
>> +       int cpu;
>> +
>> +       if (!bsp_added && (physid == loongson_sysconf.boot_cpu_id)) {
>> +               bsp_added = true;
>> +               return 0;
>> +       }
>> +
>> +       cpu = topo_get_cpu(physid);
>> +       if (cpu >= 0) {
>> +               pr_warn("Adding duplicated physical cpuid 0x%x\n", physid);
>> +               return -EEXIST;
>> +       }
>> +
>> +       if (possible_cpus >= nr_cpu_ids)
>> +               return -ERANGE;
>> +
>> +       __cpu_logical_map[possible_cpus] = physid;
>> +       cpu = possible_cpus++;
>> +       return cpu;
>> +}
>> +
>> +static void __init topo_init(void)
>> +{
>> +       loongson_sysconf.boot_cpu_id = read_csr_cpuid();
>> +       __cpu_logical_map[0] = loongson_sysconf.boot_cpu_id;
>> +       possible_cpus++;
>> +}
>> +
>>   void __init platform_init(void)
>>   {
>>          arch_reserve_vmcore();
>>          arch_reserve_crashkernel();
>> +       topo_init();
>>
>>   #ifdef CONFIG_ACPI
>>          acpi_table_upgrade();
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index 9afc2d8b3414..a3f466b89179 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c
>> @@ -291,10 +291,9 @@ static void __init fdt_smp_setup(void)
>>                  if (cpuid >= nr_cpu_ids)
>>                          continue;
>>
>> -               if (cpuid == loongson_sysconf.boot_cpu_id)
>> -                       cpu = 0;
>> -               else
>> -                       cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
>> +               cpu = topo_add_cpu(cpuid);
>> +               if (cpu < 0)
>> +                       continue;
>>
>>                  num_processors++;
>>                  set_cpu_possible(cpu, true);
>> @@ -302,7 +301,7 @@ static void __init fdt_smp_setup(void)
>>                  __cpu_number_map[cpuid] = cpu;
>>                  __cpu_logical_map[cpu] = cpuid;
>>
>> -               early_numa_add_cpu(cpu, 0);
>> +               early_numa_add_cpu(cpuid, 0);
>>                  set_cpuid_to_node(cpuid, 0);
>>          }
>>
>>
>> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
>> --
>> 2.39.3
>>


