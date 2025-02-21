Return-Path: <linux-kernel+bounces-526406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA17A3FE49
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCAD4278C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143442512F2;
	Fri, 21 Feb 2025 18:06:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCF2512D6;
	Fri, 21 Feb 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161185; cv=none; b=R4hST8sqgYM0LLO48HgGg4VuMuXQ9el8BdFR98Fe5qwpwqjeNpiOEIaGJW4vRVxcjIJ8NQLW2xJZEQVJYLPrWOYQfwIShXOUfVk7zMGT6cLu2w4hsZ92jd4YGZ4DIKabLcf4XtCGjiKNKsdpXfK22lbmnVVwKPRwY7rgqBFoQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161185; c=relaxed/simple;
	bh=xjfGB/YiuXnY5S6iTPB4u67ss8rB8wvBhFhCxptOizk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djqhGOfqH/Ny9BGyF9LuHwcfK7mrKywF/oeIS1rdc0Qtaqnh2LEEMwcLoh54LqMa98ZOrinijf4O7tKlyFy5sXaT1g21BnrxL9qb3jiYeMkYTNYDOJrOCrgwVwc+T75vDS53EIOKRd0zai0WQSh/qQBZEqN8OHuRpKdnnYogLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CE1F1EA6;
	Fri, 21 Feb 2025 10:06:41 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E0ED3F59E;
	Fri, 21 Feb 2025 10:06:19 -0800 (PST)
Message-ID: <21666e6f-9886-4657-bc14-af472bc878c8@arm.com>
Date: Fri, 21 Feb 2025 18:06:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/23] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <d0bc17f3f5be4175df34011a366136cddc8df6e2.1737577229.git.babu.moger@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <d0bc17f3f5be4175df34011a366136cddc8df6e2.1737577229.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 22/01/2025 20:20, Babu Moger wrote:
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

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index acac7972cea4..161d3feb567c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -724,4 +724,7 @@ unsigned int mon_event_config_index_get(u32 evtid);
>  void resctrl_arch_mon_event_config_set(void *info);
>  u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>  				      enum resctrl_event_id eventid);
> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			     u32 cntr_id, bool assign);
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */


Could this be added to include/linux/resctrl.h instead? Its where it needs to end up
eventually.


Thanks,

James

