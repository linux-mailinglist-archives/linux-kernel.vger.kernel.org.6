Return-Path: <linux-kernel+bounces-290045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A5954ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DCD1F23FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866B1BF31A;
	Fri, 16 Aug 2024 16:29:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F661136E30;
	Fri, 16 Aug 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825752; cv=none; b=mR0I/hG6zSItSRXWtQ4MEeoB5d3BAOivfoE5ki63Wqtar8Nt9vh5W8ldihMJDvrAKn3h8e49yGpqfk1wvma/73ApISrqRLvUIih4YhitnKoXD69e/Kv0OGSSwDIqZ4sowPcag/r88dQWSHcCe/Uruhv/PsMALsp7zPn/DLAmJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825752; c=relaxed/simple;
	bh=2XJ/XkwV9lZLxjyiQYBv3uZTI78Gs5kgTyG+M9zjy1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtIr9OTKKM7AnQojGo8XdkACWUWusPNFj3TJEReEe1OzGFTjiEe2tIYAqgmFxUQfaK6C6Do3YG9/Sh6FajA6UvkAl0ml0mnbz66ZxPpbGGYF6A/2S463AsbQNmOxFhnAle9Jc4yLuaJaVcR20umUvSVhYot/8tLNtlW2d0+Cvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C02D143D;
	Fri, 16 Aug 2024 09:29:35 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 610B23F58B;
	Fri, 16 Aug 2024 09:29:05 -0700 (PDT)
Message-ID: <20500833-44a0-4fd4-ae6a-729bb906abda@arm.com>
Date: Fri, 16 Aug 2024 17:29:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/22] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com, corbet@lwn.net,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, reinette.chatre@intel.com, mingo@redhat.com,
 fenghua.yu@intel.com, tglx@linutronix.de, bp@alien8.de
References: <cover.1722981659.git.babu.moger@amd.com>
 <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

Some boring comments about where the code goes...

On 06/08/2024 23:00, Babu Moger wrote:
> Add the functionality to enable/disable AMD ABMC feature.
> 
> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
> to be updated on all the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed. Reset the
> architectural state so that reading of hardware counter is not considered
> as an overflow in next update.
> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2bd207624eec..154983a67646 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h

> @@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>  
>  void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
>  
> +static inline bool resctrl_arch_get_abmc_enabled(void)
> +{
> +	return rdt_resources_all[RDT_RESOURCE_L3].mbm_cntr_assign_enabled;
> +}

Once the filesystem code moves to /fs/resctrl, this can't be inlined from the
architectures internal.h. Accessing rdt_resources_all[] from asm/resctrl.h isn't something
that is done today... could you move this to be a non-inline function in core.c?

(this saves me moving it later!)


> +int resctrl_arch_mbm_cntr_assign_enable(void);
> +void resctrl_arch_mbm_cntr_assign_disable(void);

Please add these in linux/resctrl.h - it saves me moving them later!


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7e76f8d839fc..6075b1e5bb77 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2402,6 +2402,63 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)

> +static void _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
> +{
> +	struct rdt_mon_domain *d;


> +	/*
> +	 * Hardware counters will reset after switching the monitor mode.
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in the next update.
> +	 */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		on_each_cpu_mask(&d->hdr.cpu_mask,
> +				 resctrl_abmc_set_one_amd, &enable, 1);
> +		resctrl_arch_reset_rmid_all(r, d);
> +	}

Is there any mileage in getting resctrl_arch_mbm_cntr_assign_enable()'s caller to do this?
Every architecture that supports this will have to do this, and neither x86 nor arm64 are
able to do it atomically, or quicker than calling resctrl_arch_reset_rmid_all() for each
domain.

> +}


> +int resctrl_arch_mbm_cntr_assign_enable(void)

Could we pass the struct rdt_resource in - instead of hard coding it to be the L3 - you
already check hw_res->mbm_cntr_assign_enabled so no additional check is needed...

Background: I'd like to reduce the amount of "I magically know its the L3" to reduce the
work for whoever has to add monitor support for something other than the L3.
(I've currently no plans - but someone is going to build it!)


> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);

> +	lockdep_assert_held(&rdtgroup_mutex);

After the split between the architecture and filesystem code - this lock is private to the
filesystem. If you need to prevent concurrent enable/disable calls the architecture should
take its own mutex.

| static DEFINE_MUTEX(abmc_lock);
?


> +	if (r->mon.mbm_cntr_assignable && !hw_res->mbm_cntr_assign_enabled) {
> +		_resctrl_abmc_enable(r, true);
> +		hw_res->mbm_cntr_assign_enabled = true;
> +	}
> +
> +	return 0;
> +}
> +
> +void resctrl_arch_mbm_cntr_assign_disable(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +
> +	lockdep_assert_held(&rdtgroup_mutex);

(same plea for passing the resource in, and not referring to the filesystem's locks)


> +	if (hw_res->mbm_cntr_assign_enabled) {
> +		_resctrl_abmc_enable(r, false);
> +		hw_res->mbm_cntr_assign_enabled = false;
> +	}
> +}


The work you do in these functions is pretty symmetric. Is it worth combining them into:
| resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable) {
|	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
|
|	if (hw_res->mbm_cntr_assign_enabled != enable) {
|		_resctrl_abmc_enable(r, enable
|		hw_res->mbm_cntr_assign_enabled = enable;
|	}
| }

I think you need a resctrl_arch_mbm_cntr_assign_test() too - I'll comment on that patch...


Thanks,

James

