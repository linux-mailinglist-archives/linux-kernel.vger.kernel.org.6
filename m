Return-Path: <linux-kernel+bounces-181952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66E8C840F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ABF1C22638
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F92C6B2;
	Fri, 17 May 2024 09:44:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D28DB7
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939044; cv=none; b=CPuyfKOvnUa5yGXjQYfJiZjjblP5ewe6Tm8ecSQB8rJn7PIOQOatptsGwcW3afhSFY9fG15q2jnT4oJig8OAIc7bcmtWa4G1pnqPo8Ai8edE/7cagfnQn8R+VFVSjxgVK3b6xLm7HnXHKswwL6f4mcqswBZiVkjdxTFgHsIKdfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939044; c=relaxed/simple;
	bh=Z2N2Ra6+OOg7P8u4zHqK6onGAoDxfqJTe68/K3So4Aw=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZYJPyHxGx9wWB8Jww7QtaxEdYly2Jx/JeRor22Up3D39xa45VJ6vK3IQlxZHp7YxQtAWtFyJ1bqjQl+YLpbPEPmodt6eoycnQMZfr4M7KmQViTNVRSi6oe+LfgCYSEeQ5n22T5o5ilypQHQ/49/cd8vBgnLFdjD5B7zoFqEXvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vghlj1L1xz1j59x;
	Fri, 17 May 2024 17:40:33 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 79FE618005F;
	Fri, 17 May 2024 17:43:57 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 17:43:56 +0800
CC: Will Deacon <will@kernel.org>, <yangyicong@hisilicon.com>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
To: Dongli Zhang <dongli.zhang@oracle.com>
References: <20240410095833.63934-1-yangyicong@huawei.com>
 <20240410153419.GA25171@willie-the-truck>
 <d7c4da97-92ba-4cb7-ecd5-5edc4f52fd8a@huawei.com>
 <109dada9-3164-9a04-5b7e-1031ff399017@oracle.com>
 <87a01991-3631-431c-8654-5b757b03e2e0@oracle.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <1a67439f-6418-203a-37d8-1682ceb1cb93@huawei.com>
Date: Fri, 17 May 2024 17:43:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a01991-3631-431c-8654-5b757b03e2e0@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi Dongli,

Since it's merge window now, I can resend this along with the userspace perf handling in
next cycle. We can continue the discussion then.

Thanks.

On 2024/5/16 6:10, Dongli Zhang wrote:
> Ping? Is there any plan to move forward with the patch from Yicong?
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 4/18/24 9:32 AM, Dongli Zhang wrote:
>>
>>
>> On 4/11/24 01:55, Yicong Yang wrote:
>>> On 2024/4/10 23:34, Will Deacon wrote:
>>>> On Wed, Apr 10, 2024 at 05:58:32PM +0800, Yicong Yang wrote:
>>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>>
>>>>> When there're CPUs offline after system booting, perf will failed:
>>>>> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
>>>>> Error:
>>>>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
>>>>> /bin/dmesg | grep -i perf may provide additional information.
>>>>>
>>>>> This is due to PMU's "cpus" is not updated and still contains offline
>>>>> CPUs and perf will try to open perf event on the offlined CPUs.
>>>>>
>>>>> Make "cpus" attribute only shows online CPUs and introduced a new
>>>>> "supported_cpus" where users can get the range of the CPUs this
>>>>> PMU supported monitoring.
>>>>>
>>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>> ---
>>>>>  drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
>>>>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> Hmm. Is the complexity in the driver really worth it here? CPUs can be
>>>> onlined and offlined after the perf_event_open() syscall has been
>>>> executed, 
>>>
>>> Yes. So we have cpuhp callbacks to handle the cpu online/offline
>>> and migrate the perf context.
>>>
>>>> so this feels like something userspace should be aware of and
>>>> handle on a best-effort basis anyway.
>>>>
>>>
>>> Looks like it's a convention for a PMU device to provide a "cpus" attribute (for core
>>> PMUs) or "cpumask" attribute (for uncore PMUs) to indicates the CPUs on which the
>>> events can be opened. If no such attributes provided, all online CPUs indicated. Perf
>>> will check this and if user doesn't specify a certian range of CPUs the events will
>>> be opened on all the CPUs PMU indicated.
>>>
>>>> Does x86 get away with this because CPU0 is never offlined?
>>>>
>>>
>>> Checked on my x86 server there's no "cpus" or "cpumask" provided so perf will try
>>> to open the events on all the online CPUs if no CPU range specified. But for their
>>> hybrid platform there do have a "cpus" attribute[1] and it'll be updated when CPU
>>> offline[2].
>>>
>>> The arm-cspmu also provides a "cpumask" to indicate supported online CPUs and an
>>> "associated_cpus" to indicated the CPUs related to the PMU.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n5931
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n4949
>>>
>>> Thanks.
>>>
>>>
>>
>>
>> The arm_dsu has the concepts of 'cpumask' as well. It also has 'associated_cpus'.
>>
>> When the current cpumask offline, the cpuhp handler will migrate the cpumask to
>> other associated_cpus.
>>
>> # cat /sys/devices/arm_dsu_26/associated_cpus
>> 4-5
>> [root@lse-aarch64-bm-ol8 opc]# cat /sys/devices/arm_dsu_26/cpumask
>> 4
>>
>> 812 static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>> 813 {
>> 814         struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
>> 815                                                    cpuhp_node);
>> 816
>> 817         if (!cpumask_test_cpu(cpu, &dsu_pmu->associated_cpus))
>> 818                 return 0;
>> 819
>> 820         /* If the PMU is already managed, there is nothing to do */
>> 821         if (!cpumask_empty(&dsu_pmu->active_cpu))
>> 822                 return 0;
>> 823
>> 824         dsu_pmu_init_pmu(dsu_pmu);
>> 825         dsu_pmu_set_active_cpu(cpu, dsu_pmu);
>> 826
>> 827         return 0;
>> 828 }
>> 829
>> 830 static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> 831 {
>> 832         int dst;
>> 833         struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
>> 834                                                    cpuhp_node);
>> 835
>> 836         if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
>> 837                 return 0;
>> 838
>> 839         dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
>> 840         /* If there are no active CPUs in the DSU, leave IRQ disabled */
>> 841         if (dst >= nr_cpu_ids)
>> 842                 return 0;
>> 843
>> 844         perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
>> 845         dsu_pmu_set_active_cpu(dst, dsu_pmu);
>> 846
>> 847         return 0;
>> 848 }
>>
>>
>> However, I think the userspace perf tool looks more friendly (just return <not
>> supported>) in this case when I offline all CPUs from cpumask of a DSU. Perhaps
>> because it is NULL now.
>>
>> # perf stat -e arm_dsu_26/l3d_cache_wb/
>> ^C
>>  Performance counter stats for 'system wide':
>>
>>    <not supported>      arm_dsu_26/l3d_cache_wb/
>>
>>        0.553294766 seconds time elapsed
>>
>>
>> # cat /sys/devices/arm_dsu_26/associated_cpus
>> 4-5
>> # cat /sys/devices/arm_dsu_26/cpumask
>> 4
>> # echo 0 > /sys/devices/system/cpu/cpu4/online
>> # cat /sys/devices/arm_dsu_26/cpumask
>> 5
>> # echo 0 > /sys/devices/system/cpu/cpu5/online
>> # cat /sys/devices/arm_dsu_26/cpumask
>>
>> #
>>
>> Dongli Zhang
> .
> 

