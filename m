Return-Path: <linux-kernel+bounces-538394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128AFA4981A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D483AC4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577926136B;
	Fri, 28 Feb 2025 11:11:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADA26038A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741085; cv=none; b=NmrF0TyOjlbx49Bhl+Qs4ciVCZrjQu+xZMLZKNpg7rFDs3M3++XWTnYH57GzzGSuQIV7IN1zPgR4koY3GY48nXV4xLWAmnlfKgZtiXCRhO0fcowaAzKRDuDq9EYGu0z9gFotri4ecntN216jxi/CixZe+A+iwaE6hSWZzJiZ0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741085; c=relaxed/simple;
	bh=7xX93+lkSlo5Sne3y3D0bT0neC4O8hkBvJFr1CncfxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAAPdiMX+XiNH6XSI2FhzzGdEnbe2ACQk4BlZvgMUFe7Z5fwBuZ1fRoqf2gur+g1P1sxgeyjavmfomBo5a6ae7G0yGKaVgr16ApYFQ5L2TJE7hkFk2gIjcKFmI25yi+d9Sz0uyOiQO8EmIxv1pwhuIRuDtU/WdTO5av98/Ut298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED191063;
	Fri, 28 Feb 2025 03:11:38 -0800 (PST)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F72A3F673;
	Fri, 28 Feb 2025 03:11:18 -0800 (PST)
Message-ID: <8a9aedef-08d7-445f-9b67-85e74ec6bd50@arm.com>
Date: Fri, 28 Feb 2025 12:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/4] arch_topology: Support SMT control for OF based
 system
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, pierre.gondois@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com, sshegde@linux.ibm.com
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-3-yangyicong@huawei.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20250218141018.18082-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 15:10, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On building the topology from the devicetree, we've already
> gotten the SMT thread number of each core. Update the largest
> SMT thread number and enable the SMT control by the end of
> topology parsing.
> 
> The core's SMT control provides two interface to the users [1]:
> 1) enable/disable SMT by writing on/off
> 2) enable/disable SMT by writing thread number 1/max_thread_number

1/max_thread_number stands for '1 or max_thread_number', right ?

Aren't the two interfaces:

(a) /sys/devices/system/cpu/smt/active
(b) /sys/devices/system/cpu/smt/control

and you write 1) or 2) (or 'forceoff') into (b)?

> If a system have more than one SMT thread number the 2) may

s/have/has

> not handle it well, since there're multiple thread numbers in the

multiple thread numbers other than 1, right?

> system and 2) only accept 1/max_thread_number. So issue a warning
> to notify the users if such system detected.

This paragraph seems to be about heterogeneous systems. Maybe mention this?

Heterogeneous system with SMT only on a subset of cores (like Intel
Hybrid): This one works (N threads per core with N=1 and N=2) just fine.

But on Arm64 (default) we would still see:

[0.075782] Heterogeneous SMT topology is partly supported by SMT control

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/base/arch_topology.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 3ebe77566788..23f425a9d77a 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -11,6 +11,7 @@
>  #include <linux/cleanup.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_smt.h>
>  #include <linux/device.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> @@ -506,6 +507,10 @@ core_initcall(free_raw_capacity);
>  #endif
>  
>  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> +
> +/* Maximum SMT thread number detected used to enable the SMT control */

maybe shorter ?

/* used to enable SMT control */

> +static unsigned int max_smt_thread_num;
> +
>  /*
>   * This function returns the logic cpu number of the node.
>   * There are basically three kinds of return values:
> @@ -565,6 +570,16 @@ static int __init parse_core(struct device_node *core, int package_id,
>  		i++;
>  	} while (1);
>  
> +	/*
> +	 * If max_smt_thread_num has been initialized and doesn't match
> +	 * the thread number of this entry, then the system has
> +	 * heterogeneous SMT topology.
> +	 */
> +	if (max_smt_thread_num && max_smt_thread_num != i)
> +		pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
> +
> +	max_smt_thread_num = max_t(unsigned int, max_smt_thread_num, i);
> +
>  	cpu = get_cpu_for_node(core);
>  	if (cpu >= 0) {
>  		if (!leaf) {
> @@ -677,6 +692,18 @@ static int __init parse_socket(struct device_node *socket)
>  	if (!has_socket)
>  		ret = parse_cluster(socket, 0, -1, 0);
>  
> +	/*
> +	 * Notify the CPU framework of the SMT support. Initialize the
> +	 * max_smt_thread_num to 1 if no SMT support detected or failed
> +	 * to parse the topology. A thread number of 1 can be handled by
> +	 * the framework so we don't need to check max_smt_thread_num to
> +	 * see we support SMT or not.

Not sure whether the last sentence is needed here?

[...]


