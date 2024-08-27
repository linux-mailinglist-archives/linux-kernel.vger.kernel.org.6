Return-Path: <linux-kernel+bounces-303652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13D961311
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050F11F24596
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D61C8719;
	Tue, 27 Aug 2024 15:41:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2EE19EEA2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773262; cv=none; b=WlHqStCAIWJEwI9qMoTnMr4UpQ/TYNNTQnGmrTisEYhJcQVe8Fh8yUqJqggVwy3ccc4Sv+L3Kh0t5FhxQ293+/DGAvahX7u0VBvbM868LAqh1LwIW1w0kkMY8o8h/5Bw8f/UXpqlLhwdC4QqNnjfmhoaI0Dj+aLiaAH7ZIyOUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773262; c=relaxed/simple;
	bh=3gLfo//X8ziZ7Qaz69kPcY1/j7R8E8lrAIYonW6oDcQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h2DB5Es3UuSTwK+Z6Z+75bPvMBanEDM7l4PBaJ3shsSMnhbIl95MUWjjQ+JA3/xaL3N7iZJDZH9SMfQkKhBAEWhSjyXKfJTMLvEF5CCGurMxXz2dvnMNDTDOTD/21aNWW9xYAbYCHO7cUDnwFAufsWu40IFQssKA8CNsw0XKbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C2811FB;
	Tue, 27 Aug 2024 08:41:25 -0700 (PDT)
Received: from [10.34.129.45] (e126645.nice.arm.com [10.34.129.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41763F762;
	Tue, 27 Aug 2024 08:40:54 -0700 (PDT)
Message-ID: <a998c723-7451-439a-9c88-7c8b5c1b890b@arm.com>
Date: Tue, 27 Aug 2024 17:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Yicong Yang <yangyicong@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, bp@alien8.de, dave.hansen@linux.intel.com,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
 peterz@infradead.org, tglx@linutronix.de, sudeep.holla@arm.com,
 will@kernel.org, catalin.marinas@arm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240806085320.63514-4-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yicong,
IIUC we are looking for the maximum number of threads a CPU can have
in the platform. But is is actually possible to have a platform with
CPUs not having the same number of threads ?

For instance kernel/cpu.c::cpu_smt_num_threads_valid() will check
that the number of threads is either 1 or cpu_smt_max_threads (as
CONFIG_SMT_NUM_THREADS_DYNAMIC is not enabled for arm64). However
a (hypothetical) platform with:
- CPU0: 2 threads
- CPU1: 4 threads
should not be able to set the number of threads to 2, as
1 < 2 < cpu_smt_max_threads (cf. cpu_smt_num_threads_valid()).

So if there is an assumption that all the CPUs have the same number of
threads, it should be sufficient to count the number of threads for one
CPU right ?

In the other (unlikely) case (i.e. CPUs can have various number of threads),
I think we should either:
- use your method and check that all the CPUs have the same number of threads
- get the number of threads for one CPU and check that all the CPUs are
    identical using the ACPI_PPTT_ACPI_IDENTICAL tag
- have a per-cpu cpu_smt_max_threads value ?

Same comment for the DT patch. If there is an assumption that all CPUs have
the same number of threads, then update_smt_num_threads() could only be called
once I suppose,

Regards,
Pierre


On 8/6/24 10:53, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> For ACPI we'll build the topology from PPTT and we cannot directly
> get the SMT number of each core. Instead using a temporary xarray
> to record the SMT number of each core when building the topology
> and we can know the largest SMT number in the system. Then we can
> enable the support of SMT control.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/arm64/kernel/topology.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..f72e1e55b05e 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -15,8 +15,10 @@
>   #include <linux/arch_topology.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpufreq.h>
> +#include <linux/cpu_smt.h>
>   #include <linux/init.h>
>   #include <linux/percpu.h>
> +#include <linux/xarray.h>
>   
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
> @@ -43,11 +45,16 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>    */
>   int __init parse_acpi_topology(void)
>   {
> +	int thread_num, max_smt_thread_num = 1;
> +	struct xarray core_threads;
>   	int cpu, topology_id;
> +	void *entry;
>   
>   	if (acpi_disabled)
>   		return 0;
>   
> +	xa_init(&core_threads);
> +
>   	for_each_possible_cpu(cpu) {
>   		topology_id = find_acpi_cpu_topology(cpu, 0);
>   		if (topology_id < 0)
> @@ -57,6 +64,20 @@ int __init parse_acpi_topology(void)
>   			cpu_topology[cpu].thread_id = topology_id;
>   			topology_id = find_acpi_cpu_topology(cpu, 1);
>   			cpu_topology[cpu].core_id   = topology_id;
> +
> +			entry = xa_load(&core_threads, topology_id);
> +			if (!entry) {
> +				xa_store(&core_threads, topology_id,
> +					 xa_mk_value(1), GFP_KERNEL);
> +			} else {
> +				thread_num = xa_to_value(entry);
> +				thread_num++;
> +				xa_store(&core_threads, topology_id,
> +					 xa_mk_value(thread_num), GFP_KERNEL);
> +
> +				if (thread_num > max_smt_thread_num)
> +					max_smt_thread_num = thread_num;
> +			}
>   		} else {
>   			cpu_topology[cpu].thread_id  = -1;
>   			cpu_topology[cpu].core_id    = topology_id;
> @@ -67,6 +88,9 @@ int __init parse_acpi_topology(void)
>   		cpu_topology[cpu].package_id = topology_id;
>   	}
>   
> +	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +
> +	xa_destroy(&core_threads);
>   	return 0;
>   }
>   #endif

