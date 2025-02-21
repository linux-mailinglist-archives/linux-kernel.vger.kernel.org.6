Return-Path: <linux-kernel+bounces-526407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F6A3FE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047664281D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A92512CC;
	Fri, 21 Feb 2025 18:07:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD871E5702;
	Fri, 21 Feb 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161226; cv=none; b=l4VL8I0HrFB/VffujzglYdTt9N0+6W0So7eNcUNAcbAVU08aTFgeM0oHMT/MSdcSmTCQHHkU/W1snM7xKaTfiNAgWpzuZeBsEjdFRim7zgTBZ8IoXuEJ/uX/oXKYkwX+r3gmg4MQ5nzmpCZ0X6HntDWSe59CmJZA/ITYichiZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161226; c=relaxed/simple;
	bh=yCAX+NU23vhHF9Q4fJ4rlICslJ+5lxs6vk2ojv2dF4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAmYQfz9ApZpalt9TXjjrO8XdWeXBm6y8POyO4STB8vavuC/KrowdERedBEUCBRGVTq//i5wR16zsfn1nYw6ZF1dtDfonm8lE69f2Hj1A0Im7oG8S/yQzf5PCZk/YYI04b/Y3XYnzME4bx38kg1Y/3D9UkkqdhLbUSEaWA7TSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BA3C1EA6;
	Fri, 21 Feb 2025 10:07:21 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23F1F3F59E;
	Fri, 21 Feb 2025 10:07:00 -0800 (PST)
Message-ID: <b3dc2fc5-4ee6-414d-90bb-97baa0d67dc5@arm.com>
Date: Fri, 21 Feb 2025 18:06:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/23] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
 peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <4a48aabf502897bec1e015305d7b0b826bb20841.1737577229.git.babu.moger@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <4a48aabf502897bec1e015305d7b0b826bb20841.1737577229.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 22/01/2025 20:20, Babu Moger wrote:
> Configure mbm_cntr_assign mode on AMD platforms. On AMD platforms, it
> is recommended to use mbm_cntr_assign mode if supported, because
> reading "mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable'
> if there is no counter associated with that event.

(If you agree with my comment on patch 7, it would be good to update this
wording to match.)


> The mbm_cntr_assign mode, referred to as ABMC (Assignable Bandwidth
> Monitoring Counters) on AMD, is enabled by default when supported by the
> system.
> 
> Update ABMC across all logical processors within the resctrl domain to
> ensure proper functionality.
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c006c4d8d6ff..2480698b643d 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -734,4 +734,5 @@ int resctrl_unassign_cntr_event(struct rdt_resource *r, struct rdt_mon_domain *d
>  void mbm_cntr_reset(struct rdt_resource *r);
>  int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>  		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
> +void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */

Could this be put in include/linux/resctrl.h, its where it needs to end up eventually.



This sequence has me confused:

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3d748fdbcb5f..a9a5dc626a1e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1233,6 +1233,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			r->mon.mbm_cntr_assignable = true;
>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;

> +			hw_res->mbm_cntr_assign_enabled = true;

Here the arch code sets ABMC to be enabled by default at boot.


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6922173c4f8f..515969c5f64f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4302,9 +4302,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>  
>  void resctrl_online_cpu(unsigned int cpu)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
>  	mutex_lock(&rdtgroup_mutex);
>  	/* The CPU is set in default rdtgroup after online. */
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	if (r->mon_capable && r->mon.mbm_cntr_assignable)
> +		resctrl_arch_mbm_cntr_assign_set_one(r);
>  	mutex_unlock(&rdtgroup_mutex);
>  }

But here, resctrl has to call back to the arch code to make sure the hardware is in the
same state as hw_res->mbm_cntr_assign_enabled.

Could this be done in resctrl_arch_online_cpu() instead? That way resctrl doesn't get CPUs
in an inconsistent state that it has to fix up...


Thanks,

James

