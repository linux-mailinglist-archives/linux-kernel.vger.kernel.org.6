Return-Path: <linux-kernel+bounces-291578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D59956441
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D181C2160B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D615852F;
	Mon, 19 Aug 2024 07:18:51 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03701552FA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051931; cv=none; b=TMoxw28cLB+tU1A3nYYmWzv7PPy5iopI03t/R3/0FfjaMUnwX85TwOOCChlBF1JUwsqZMVVlS6K5IAK6ZoMiDnMRygnhFL3cNb0uJz7uBzuwT4Y5iqp134lt4rZTzZttaTCapi2kXsOA/NAi9kAMDT/yC9VwI2lUEPhPBz6F/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051931; c=relaxed/simple;
	bh=CVLezzhbyCEpXGfdnCtbTbgnRuWDk7/0Y/HnDIkk0Pg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R0JCPM9JvWyxhtNQppprpkvpO7xzAAWBa7TmRNa1YRx2oGIkuuy7DiLrDskqzDnQAhcsdh1yohbGcNUZju8MHYuWBvvfuW+VgiyfMwnkuSd/AA8oThxo1uTYJp1KWc/FEbl6jyMZ6l8Y4ytv7yLPuKF+XWMeSjq+eZ5Zft7HXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnP2q02Xfz1j6dL;
	Mon, 19 Aug 2024 15:13:39 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 1176114022E;
	Mon, 19 Aug 2024 15:18:37 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 19 Aug 2024 15:18:36 +0800
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <yangyicong@hisilicon.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>
Subject: Re: [PATCH v5 2/4] arch_topology: Support SMT control for OF based
 system
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-3-yangyicong@huawei.com>
 <a7636c4b-f449-4018-a890-08412e3ec779@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <85c1501c-f398-bf96-f8b9-383fbb32d12f@huawei.com>
Date: Mon, 19 Aug 2024 15:18:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a7636c4b-f449-4018-a890-08412e3ec779@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/8/16 23:55, Dietmar Eggemann wrote:
> On 06/08/2024 10:53, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> On building the topology from the devicetree, we've already
>> gotten the SMT thread number of each core. Update the largest
>> SMT thread number to enable the SMT control.
> 
> Do we have SMT Device Tree (DT) systems out there? But you right that DT
> at least supports SMT.
> 

My system's based on ACPI. For DT part it's emulated and tested on the QEMU VM.

>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/base/arch_topology.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 75fcb75d5515..95513abd664f 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/cleanup.h>
>>  #include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/cpu_smt.h>
>>  #include <linux/device.h>
>>  #include <linux/of.h>
>>  #include <linux/slab.h>
>> @@ -531,6 +532,16 @@ static int __init get_cpu_for_node(struct device_node *node)
>>  	return cpu;
>>  }
>>  
>> +static void __init update_smt_num_threads(unsigned int num_threads)
>> +{
>> +	static unsigned int max_smt_thread_num = 1;
>> +
>> +	if (num_threads > max_smt_thread_num) {
>> +		max_smt_thread_num = num_threads;
>> +		cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
>> +	}
> 
> This could theoretically (unlikely though) call
> cpu_smt_set_num_threads() multiple times (on heterogeneous systems with
> different numbers of SMT threads).

Yes indeed. Was doing this purposely since I think this doing nothing unexpectedly but
only update the max threads recorded in the framework.

>> +}
>> +
>>  static int __init parse_core(struct device_node *core, int package_id,
>>  			     int cluster_id, int core_id)
>>  {
>> @@ -561,6 +572,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>>  		i++;
>>  	} while (1);
>>  
>> +	update_smt_num_threads(i);
>> +
>>  	cpu = get_cpu_for_node(core);
>>  	if (cpu >= 0) {
>>  		if (!leaf) {
> 
> Why not simply do this:
> 
> -->8--
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75fcb75d5515..806537419715 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -30,6 +30,7 @@ static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
>  DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
>  EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
> +static unsigned int max_smt_thread_num = 1;
>  

This fine with me and this avoid calling cpu_smt_set_num_threads() multiple
times. We can switch to this implementation.

Thanks.

>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
>  {
> @@ -577,6 +578,9 @@ static int __init parse_core(struct device_node *core, int package_id,
>  		return -EINVAL;
>  	}
>  
> +	if (max_smt_thread_num < i)
> +		max_smt_thread_num = i;
> +
>  	return 0;
>  }
>  
> @@ -673,6 +677,9 @@ static int __init parse_socket(struct device_node *socket)
>  	if (!has_socket)
>  		ret = parse_cluster(socket, 0, -1, 0);
>  
> +	if (max_smt_thread_num > 1)
> +		cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +
>  	return ret;
>  }
> 
> 
> .
> 

