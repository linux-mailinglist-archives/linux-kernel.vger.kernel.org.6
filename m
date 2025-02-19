Return-Path: <linux-kernel+bounces-521622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24DA3C00E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F133A4D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8FD1E5B8F;
	Wed, 19 Feb 2025 13:32:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBC1DF98E;
	Wed, 19 Feb 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971957; cv=none; b=oH1zaDvsoSTTyMvC/r9APLstOiqRh4XWnGC2oTz4IhyaVlaJOSksvGbx7OgpfTzpONZtShBxmNxJbfIea3NfzZX253bkfoHOAST0rXSz7JIDQvm1XLxWu+r6TE8pPA9a/0+FqnfP8m1z5gyaE3Jpma7351hNRrhTLe+uCnUMZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971957; c=relaxed/simple;
	bh=VVXDF2CD+9FKQpyKUCi3mKUgPfv38CPodgBP4DhnKqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7jsfENLrsrc40m2i2ihloGaONTmOctsSzYIeyHzPdcqhfV0JVpORKoZLgBSZuOECJG7yTD42ZU6DdKw72dyhXwcl20hH09sMQsp5CjKxi3eOVn88m8C9alEnRlIiPk1ctb1wtoQ/2PNHrCBJLWNsextKpC1ubtcsYtURSIPiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A61CC1682;
	Wed, 19 Feb 2025 05:32:52 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 864893F59E;
	Wed, 19 Feb 2025 05:32:29 -0800 (PST)
Date: Wed, 19 Feb 2025 13:32:26 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, fenghua.yu@intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
	xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
	andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 14/23] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
Message-ID: <Z7XdagRzP6cX5yn4@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <d0bc17f3f5be4175df34011a366136cddc8df6e2.1737577229.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bc17f3f5be4175df34011a366136cddc8df6e2.1737577229.git.babu.moger@amd.com>

On Wed, Jan 22, 2025 at 02:20:22PM -0600, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as it
> is assigned. The assigned RMID will be tracked by the hardware until the
> user unassigns it manually.
> 
> Implement an architecture-specific handler to assign and unassign the
> counter. Configure counters by writing to the L3_QOS_ABMC_CFG MSR,
> specifying the counter ID, bandwidth source (RMID), and event
> configuration.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

[...]

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f2bf5b13465d..ef836bb69b9b 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1371,3 +1371,45 @@ void resctrl_arch_mon_event_config_set(void *info)

[...]

> +/*
> + * Send an IPI to the domain to assign the counter to RMID, event pair.
> + */
> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			     u32 cntr_id, bool assign)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *am;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +
> +	/* Update the event configuration from the domain */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +	else
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_cfg, 1);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	am = get_arch_mbm_state(hw_dom, rmid, evtid);

Is this necessary when unassigning the counter, or only when assigning?

> +	if (am)
> +		memset(am, 0, sizeof(*am));
> +
> +	return 0;
> +}

[...]

Cheers
---Dave

