Return-Path: <linux-kernel+bounces-538622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3617A49B06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C407174851
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70726D5D3;
	Fri, 28 Feb 2025 13:54:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572426D5D1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750853; cv=none; b=QBG9agyX5UHsyfgZ+db6xXItm8HsnPJ8S/XNbv0Tuf7c+/w3etiMUF/EgwAZaqvZ914UrVoH0PketgdkBveZN3h/+Zs+O0lPBkDTTYvW9V+qhNumxataAE/503Fg5RxafaTbQ9j1akSkEicKBQCfzA9jpxgy9gxBGtkueR3czTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750853; c=relaxed/simple;
	bh=Zij1RfWvcW9CfTWDrQo484NfSxCmd921GcQOPuf4Acs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMVhfMizdXRV3grJQK21voOritPDxwyvlYRf6d68Fa8Ox7RThpu3zYkvF51qrVLJQK+RMgKEKWrGGRdHs13J6zzjiO1QpPuIHudys0FRwsQRtYzPyZdEKRGbC799REKyiXJfeyf++XLV+yuZR1n/5T5+eLOc6SOf17cD25++VdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DCFE1515;
	Fri, 28 Feb 2025 05:54:26 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281E33F6A8;
	Fri, 28 Feb 2025 05:54:07 -0800 (PST)
Date: Fri, 28 Feb 2025 13:54:04 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
	Sudeep Holla <sudeep.holla@arm.com>, <peterz@infradead.org>,
	<mpe@ellerman.id.au>, <linux-arm-kernel@lists.infradead.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<pierre.gondois@arm.com>, <dietmar.eggemann@arm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>, <sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
Message-ID: <Z8G__C7n4zwje2MW@bogus>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-2-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218141018.18082-2-yangyicong@huawei.com>

On Tue, Feb 18, 2025 at 10:10:15PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently if architectures want to support HOTPLUG_SMT they need to
> provide a topology_is_primary_thread() telling the framework which
> thread in the SMT cannot offline. However arm64 doesn't have a
> restriction on which thread in the SMT cannot offline, a simplest
> choice is that just make 1st thread as the "primary" thread. So
> just make this as the default implementation in the framework and
> let architectures like x86 that have special primary thread to
> override this function (which they've already done).
> 
> There's no need to provide a stub function if !CONFIG_SMP or
> !CONFIG_HOTPLUG_SMT. In such case the testing CPU is already
> the 1st CPU in the SMT so it's always the primary thread.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Pre questioned in v9 [1] whether this works on architectures not using
> CONFIG_GENERIC_ARCH_TOPOLOGY, See [2] for demonstration hacking on LoongArch
> VM and this also works. Architectures should use this on their own situation.
> [1] https://lore.kernel.org/linux-arm-kernel/427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com/
> [2] https://lore.kernel.org/linux-arm-kernel/a5690fee-3019-f26c-8bad-1d95e388e877@huawei.com/
> 
>  arch/powerpc/include/asm/topology.h |  1 +
>  arch/x86/include/asm/topology.h     |  2 +-
>  include/linux/topology.h            | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 16bacfe8c7a2..da15b5efe807 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -152,6 +152,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>  {
>  	return cpu == cpu_first_thread_sibling(cpu);
>  }
> +#define topology_is_primary_thread topology_is_primary_thread
>  
>  static inline bool topology_smt_thread_allowed(unsigned int cpu)
>  {
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index ec134b719144..6c79ee7c0957 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -229,11 +229,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>  {
>  	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
>  }
> +#define topology_is_primary_thread topology_is_primary_thread
>  
>  #else /* CONFIG_SMP */
>  static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
>  static inline int topology_max_smt_threads(void) { return 1; }
> -static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
>  static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
>  #endif /* !CONFIG_SMP */
>  
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3..b3aba443c4eb 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -240,6 +240,28 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>  }
>  #endif
>  
> +#ifndef topology_is_primary_thread
> +
> +#define topology_is_primary_thread topology_is_primary_thread
> +
> +static inline bool topology_is_primary_thread(unsigned int cpu)
> +{
> +	/*
> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.

I may be misunderstanding the term "SMT hotplug" above. For me it is
comparable with logical CPU hotplug, so the above statement may be
misleading. IIUC, what you mean above is if SMT is disabled, the
primary thread will always remain enabled/active. Does that make sense
or am I missing something ?

--
Regards,
Sudeep

