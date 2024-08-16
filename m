Return-Path: <linux-kernel+bounces-290050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03033954ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28B5283F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B461BE259;
	Fri, 16 Aug 2024 16:30:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519654F87;
	Fri, 16 Aug 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825834; cv=none; b=f5D3kPxomJHPijMloPNgN6969TXXX2voH9NaApr850jqBDlRf35L7uSNBY3gpjZtWBu7iiZwGuObYsReRIsuQatvZJvrE1kMrE05m6o2U05uuRP/MoJUki3HKbcC8UtH9oWn9ydPSmMCxtUDC+qNeB2YThfaeL7fIm/FLznf3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825834; c=relaxed/simple;
	bh=pV5IWBI1/r14Yl3ElmFRBM9NX2ecZgdRGGwYPxFl1cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lcz5oi3OJpm+XjkYMBScKq4Mm9sMr4VpI86lo8pyqeaFtOp0AisLU8xBxpzYkre5G2BvsROWICzjxTWEDLOpNkl+Md+QlxnPzZSxIpSOGTzjKOzCZxL5uSrd4AhAbP7Y3t3Zr4o+W3ti95ATwkW8FW6VFjxPcHlglwc8ssmXRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F275E1516;
	Fri, 16 Aug 2024 09:30:55 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C083F58B;
	Fri, 16 Aug 2024 09:30:26 -0700 (PDT)
Message-ID: <63bdd436-7bc3-4ccb-a182-5ae596fefd5a@arm.com>
Date: Fri, 16 Aug 2024 17:30:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/22] x86/resctrl: Add the interface to assign a
 hardware counter
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
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 06/08/2024 23:00, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> The assigned RMID will be tracked by the hardware until the user unassigns
> it manually.
> 
> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
> specifying the counter id, bandwidth source, and bandwidth types.
> 
> Provide the interface to assign the counter ids to RMID.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 60696b248b56..1ee91a7293a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1864,6 +1864,103 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,

> +/*
> + * Send an IPI to the domain to assign the counter id to RMID.
> + */
> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
> +			     u32 rmid, u32 cntr_id, u32 closid, bool assign)

MPAM ends up with a per-resource array of monitor-ids that it uses to map cntr_id
allocated by resctrl to the underlying hardware id. Could this function pass the struct
rdt_resource too?
(this saves me having to assume its the L3 - adding to the technical debt in this area)

Nit: could closid and rmid appear next to each other, and in that order ... just to fit
with other helpers that take both.


> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +
> +	/* Update the event configuration from the domain */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
> +	} else {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
> +	}
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	if (arch_mbm)
> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +
> +	return 0;
> +}


Thanks,

James

