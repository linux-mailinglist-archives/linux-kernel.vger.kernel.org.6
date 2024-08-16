Return-Path: <linux-kernel+bounces-290053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C11954EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDB4B21DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2E1BC9EF;
	Fri, 16 Aug 2024 16:32:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D91BE241;
	Fri, 16 Aug 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825939; cv=none; b=ARV+j2eR7uoSwvmbJ6bZDNux/AerDye45P+89ESTD5ke/9UdCo3nGi/QE+2DZoZT56aAsxGiplMs3Hsl6GDvOdHPkRswIlrN7EyKTg27yyi7OfSnlNscf08ap7U890MohOTTOsmPEs03ktS8LIlEPTVCqHvcGO0x7k45LhVIZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825939; c=relaxed/simple;
	bh=+0QMLewbM/WTE0dMzqm5v68v1oUXlFZqdkASOILwHkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUTif7sKZS7uHRpFceGIjf8jS2ybgvWWMVRmUiWsrN5I0kSkL0AsBXVm4Bw/ZpbWaRBwkr3HaGbt9kzoBIVZ0khere24Qxdn9yBbSI4rJI7ONa/w7cnE7ZD8klMxb/49riATrrdtVQFm0cK48hlPPeuo2plywhM+r2LWIxzAMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0922153B;
	Fri, 16 Aug 2024 09:32:42 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9850B3F58B;
	Fri, 16 Aug 2024 09:32:11 -0700 (PDT)
Message-ID: <df0c32ef-a694-4e5a-9d93-54ae2b93e452@arm.com>
Date: Fri, 16 Aug 2024 17:32:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, mingo@redhat.com,
 bp@alien8.de, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, dave.hansen@linux.intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 06/08/2024 23:00, Babu Moger wrote:
> Enable ABMC by default when supported during the boot up.
> 
> Users will not see any difference in the behavior when resctrl is
> mounted. With automatic assignment everything will work as running
> in the legacy monitor mode.

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6fb0cfdb5529..a7980f84c487 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>  		d = container_of(hdr, struct rdt_mon_domain, hdr);
>  
>  		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +		resctrl_arch_mbm_cntr_assign_configure();
>  		return;
>  	}
>  
> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>  	arch_mon_domain_online(r, d);
>  
>  	resctrl_mbm_evt_config_init(hw_dom);
> +	resctrl_arch_mbm_cntr_assign_configure();
>  
>  	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>  		mon_domain_free(hw_dom);

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 66febff2a3d3..d15fd1bde5f4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>  	}
>  }
>  
> +void resctrl_arch_mbm_cntr_assign_configure(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	bool enable = true;
> +
> +	mutex_lock(&rdtgroup_mutex);

As before - this lock isn't available to the architecture code after the filesystem code
moves to /fs/. To prevent concurrent calls to resctrl_abmc_set_one_amd() I think you need
your own mutex.


> +	if (r->mon.mbm_cntr_assignable) {
> +		if (!hw_res->mbm_cntr_assign_enabled)
> +			hw_res->mbm_cntr_assign_enabled = true;
> +		resctrl_abmc_set_one_amd(&enable);
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}

Neither of this functions callers are in filesystem code, could you drop the 'arch' from
the name - it isn't part of the fs/arch interface.


Thanks,

James

