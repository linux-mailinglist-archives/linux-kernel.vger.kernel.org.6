Return-Path: <linux-kernel+bounces-378376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE2F9ACF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F551F21FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273F1BFE0D;
	Wed, 23 Oct 2024 15:43:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B353A1DA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698220; cv=none; b=tHJGxN8EUsUJgfh02PbHWuFlsOHKVITeNI10OcLWNUPL9vbFOMFRg/5DBCZp+qsqI5kXUIJfFBeHngz4XX1ay//aKdAjdtutVy+Ui9bEq1O/b2FbocAClUqlNWh/4TL7gT9jc7cow9kc61n1OGJmfRz16caj4l6jCQMt5wdKKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698220; c=relaxed/simple;
	bh=b78lij0mPvhA4GTViSeAwz4P0GFEcEQMxGp+5r+BBtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phpkYDJbWnUruV1TTqvMUGm6hB75lDd1fIuyJobfIYYw2Lm6s4Twsf8L46lALWRi+Y4bM8nB0Be2KjR/8DbCFD7RaoAvH7zb4h9Ix3eYwfoGoQt3lXECEhDj0BIVcLjc5r1rPwQMqOlbK2la3lUzRxzlqvVBXgVuQMh/I4e/VXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84DA9339;
	Wed, 23 Oct 2024 08:44:06 -0700 (PDT)
Received: from [10.57.79.135] (unknown [10.57.79.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C592E3F528;
	Wed, 23 Oct 2024 08:43:31 -0700 (PDT)
Message-ID: <eb7ec4c3-5995-4040-8992-bb95f4b9f923@arm.com>
Date: Wed, 23 Oct 2024 17:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] arch_topology: Support SMT control for OF based
 system
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com
References: <20241015021841.35713-1-yangyicong@huawei.com>
 <20241015021841.35713-3-yangyicong@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241015021841.35713-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yicong,

On 10/15/24 04:18, Yicong Yang wrote:
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
> 
> If a system have more than one SMT thread number the 2) may
> not handle it well, since there're multiple thread numbers in the
> system and 2) only accept 1/max_thread_number. So issue a warning
> to notify the users if such system detected.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   drivers/base/arch_topology.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75fcb75d5515..5eed864df5e6 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -11,6 +11,7 @@
>   #include <linux/cleanup.h>
>   #include <linux/cpu.h>
>   #include <linux/cpufreq.h>
> +#include <linux/cpu_smt.h>
>   #include <linux/device.h>
>   #include <linux/of.h>
>   #include <linux/slab.h>
> @@ -28,6 +29,7 @@
>   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>   static struct cpumask scale_freq_counters_mask;
>   static bool scale_freq_invariant;
> +static unsigned int max_smt_thread_num;
>   DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
>   EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
>   
> @@ -561,6 +563,17 @@ static int __init parse_core(struct device_node *core, int package_id,
>   		i++;
>   	} while (1);
>   
> +	if (max_smt_thread_num < i)
> +		max_smt_thread_num = i;

Shouldn't the conditions above/below be inverted ?
I.e. (max_smt_thread_num != i) should never be true if there is
   max_smt_thread_num = i;
just before

> +
> +	/*
> +	 * If max_smt_thread_num has been initialized and doesn't match
> +	 * the thread number of this entry, then the system has
> +	 * heterogeneous SMT topology.
> +	 */
> +	if (max_smt_thread_num && max_smt_thread_num != i)
> +		pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
> +
>   	cpu = get_cpu_for_node(core);
>   	if (cpu >= 0) {
>   		if (!leaf) {
> @@ -673,6 +686,14 @@ static int __init parse_socket(struct device_node *socket)
>   	if (!has_socket)
>   		ret = parse_cluster(socket, 0, -1, 0);
>   
> +	/*
> +	 * Notify the CPU framework of the SMT support. A thread number of 1
> +	 * can be handled by the framework so we don't need to check
> +	 * max_smt_thread_num to see we support SMT or not.
> +	 */
> +	if (max_smt_thread_num)
> +		cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +
>   	return ret;
>   }
>   

