Return-Path: <linux-kernel+bounces-290000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CC954E47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341561F23F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBB1BE222;
	Fri, 16 Aug 2024 15:55:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBECF1B86FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823736; cv=none; b=qHykGWnVAaq1MlZb6NM03/20tFlBWp9vAKvl+0o8HpUU6dQrUapbyJCfxk9qSyrZLJeuhr2cVln6guCkrUcpBgoCWkMk4WNDo90gjFEhHJSkvSIRaUOl5xjASkW3II1c131YGmviTvkkbNIC8G/X0tzSsJa4KoxMP1CiSfVQWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823736; c=relaxed/simple;
	bh=qCvxCQ6XANiLz/yQSy6Th+ygFJB0beMKAtWWbD+KoA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOr2PuTUxtfdh85fN/qCC5yFyGcBrkxmR+Flt9BZRoYA7Pzy6boejZQFkK1TglaFkak7CpaAw8z5EM9W2squOMZQhFhBD9zDaLUt0ZVQr4jwX8eXaDf+wxKsrVQVVV/cRdRhHQHzZDS8KAm/ljRdDt+9V/3EmWJOVhQhiKo8nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4609B143D;
	Fri, 16 Aug 2024 08:56:00 -0700 (PDT)
Received: from [192.168.181.244] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218603F58B;
	Fri, 16 Aug 2024 08:55:29 -0700 (PDT)
Message-ID: <ec8c46f2-d819-43d7-a866-d272169178d3@arm.com>
Date: Fri, 16 Aug 2024 17:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com,
 yangyicong@hisilicon.com, xuwei5@huawei.com, guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240806085320.63514-4-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 10:53, Yicong Yang wrote:
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
>  arch/arm64/kernel/topology.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..f72e1e55b05e 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -15,8 +15,10 @@
>  #include <linux/arch_topology.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_smt.h>
>  #include <linux/init.h>
>  #include <linux/percpu.h>
> +#include <linux/xarray.h>
>  
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
> @@ -43,11 +45,16 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>   */
>  int __init parse_acpi_topology(void)
>  {
> +	int thread_num, max_smt_thread_num = 1;
> +	struct xarray core_threads;
>  	int cpu, topology_id;
> +	void *entry;
>  
>  	if (acpi_disabled)
>  		return 0;
>  
> +	xa_init(&core_threads);
> +
>  	for_each_possible_cpu(cpu) {
>  		topology_id = find_acpi_cpu_topology(cpu, 0);
>  		if (topology_id < 0)
> @@ -57,6 +64,20 @@ int __init parse_acpi_topology(void)
>  			cpu_topology[cpu].thread_id = topology_id;
>  			topology_id = find_acpi_cpu_topology(cpu, 1);
>  			cpu_topology[cpu].core_id   = topology_id;
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

So the xarray contains one element for each core_id with the information
how often the core_id occurs? I assume you have to iterate over all
possible CPUs since you don't know which logical CPUs belong to the same
core_id.

>  		} else {
>  			cpu_topology[cpu].thread_id  = -1;
>  			cpu_topology[cpu].core_id    = topology_id;
> @@ -67,6 +88,9 @@ int __init parse_acpi_topology(void)
>  		cpu_topology[cpu].package_id = topology_id;
>  	}
>  
> +	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +
> +	xa_destroy(&core_threads);
>  	return 0;
>  }
>  #endif

Tested on ThunderX2:

$ cat /proc/schedstat | head -6 | tail -4 | awk '{ print $1, $2 }'
cpu0 0
domain0 00000000,00000000,00000000,00000000,00000001,00000001,00000001,00000001
                                                   ^        ^        ^        ^
domain1 00000000,00000000,00000000,00000000,ffffffff,ffffffff,ffffffff,ffffffff
domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff

detecting 'max_smt_thread_num = 4' correctly.

