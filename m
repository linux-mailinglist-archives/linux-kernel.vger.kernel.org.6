Return-Path: <linux-kernel+bounces-289999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B9954E46
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E007A1C245D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4951BE222;
	Fri, 16 Aug 2024 15:55:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753711B86FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823727; cv=none; b=QJHQ2ZqIGDB9NR7vC5F+F391BGTADvjK/5MlcpGh0cbsUfKMMOmTNEZgyYKpEV9JYYMeVaSuUBZIwdLJP7FLBHlXSxj3F+hJhls4jiVi+BZfZpllJweGCsaVzAPlsmdN1XzbUeOU7Qt7mtOzNE8NaeLuQuy2tfKKgVVPiNNKszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823727; c=relaxed/simple;
	bh=4CFe3HSW6dnfThEP4R3gU1Ag56Dz1J8UFvd+9x72fSA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RIymjz6HTYcdACpyQIhYgtX+ussE1eeHM9w6qqTjqm159fDT7isQZr30UcISzDEQ2IUSo0AF8EF4IMmrweYoJAya9gkY6V5UXZ2gt+7WAJItMRqtNgfe8IJ8mi6RUfEm16S9518JCeX6Ni+jbONI2fg3ST3iow9AhASWKk6iTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF51913D5;
	Fri, 16 Aug 2024 08:55:50 -0700 (PDT)
Received: from [192.168.181.244] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACE5A3F58B;
	Fri, 16 Aug 2024 08:55:20 -0700 (PDT)
Message-ID: <a7636c4b-f449-4018-a890-08412e3ec779@arm.com>
Date: Fri, 16 Aug 2024 17:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v5 2/4] arch_topology: Support SMT control for OF based
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
 <20240806085320.63514-3-yangyicong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240806085320.63514-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 10:53, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On building the topology from the devicetree, we've already
> gotten the SMT thread number of each core. Update the largest
> SMT thread number to enable the SMT control.

Do we have SMT Device Tree (DT) systems out there? But you right that DT
at least supports SMT.

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/base/arch_topology.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75fcb75d5515..95513abd664f 100644
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
> @@ -531,6 +532,16 @@ static int __init get_cpu_for_node(struct device_node *node)
>  	return cpu;
>  }
>  
> +static void __init update_smt_num_threads(unsigned int num_threads)
> +{
> +	static unsigned int max_smt_thread_num = 1;
> +
> +	if (num_threads > max_smt_thread_num) {
> +		max_smt_thread_num = num_threads;
> +		cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +	}

This could theoretically (unlikely though) call
cpu_smt_set_num_threads() multiple times (on heterogeneous systems with
different numbers of SMT threads).
> +}
> +
>  static int __init parse_core(struct device_node *core, int package_id,
>  			     int cluster_id, int core_id)
>  {
> @@ -561,6 +572,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>  		i++;
>  	} while (1);
>  
> +	update_smt_num_threads(i);
> +
>  	cpu = get_cpu_for_node(core);
>  	if (cpu >= 0) {
>  		if (!leaf) {

Why not simply do this:

-->8--

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 75fcb75d5515..806537419715 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -30,6 +30,7 @@ static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
 DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
 EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
+static unsigned int max_smt_thread_num = 1;
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -577,6 +578,9 @@ static int __init parse_core(struct device_node *core, int package_id,
 		return -EINVAL;
 	}
 
+	if (max_smt_thread_num < i)
+		max_smt_thread_num = i;
+
 	return 0;
 }
 
@@ -673,6 +677,9 @@ static int __init parse_socket(struct device_node *socket)
 	if (!has_socket)
 		ret = parse_cluster(socket, 0, -1, 0);
 
+	if (max_smt_thread_num > 1)
+		cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
+
 	return ret;
 }


