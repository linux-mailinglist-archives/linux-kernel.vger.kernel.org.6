Return-Path: <linux-kernel+bounces-517901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDE8A3872C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51BC18891F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31072248A5;
	Mon, 17 Feb 2025 15:01:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D136217722
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804487; cv=none; b=fO8wvKNcToLcur+fX37MCXc+lddobsAtc3xuBUq6uUoX5YQfZUtMka1ikOk/Pm7lB/WnQ278O8tGirU1IFW9oq1IZjl17dyCDvpq59gBoh3idQxBoiBNdSSfVpQl3If6rD9n4aQ3nVns5PmWhnSehsbakGL6KbnuHkxZtPiLsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804487; c=relaxed/simple;
	bh=nzXdQGhsyBPvSJ7maXdl05NaS5obRVwjLbzc+jEVw4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0ss2KnY9ATRTv5A9a4520oq8xTxjfR5om5d9Ju7iAxcSR+Fu3y8TTYaAztN7XDc+ji6z9xatRlxNVYeWx+/acDn+zGzujAS7eXIEJ/JZSHa71/nu4lyvrzx4NdOmZXXAALs1ZsZ8Hy8DLeC0bqdWrcnW6r4gX549ImBgsjRsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFB5152B;
	Mon, 17 Feb 2025 07:01:44 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D9CD3F6A8;
	Mon, 17 Feb 2025 07:01:25 -0800 (PST)
Date: Mon, 17 Feb 2025 15:01:23 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, beata.michalska@arm.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
	pierre.gondois@arm.com
Subject: Re: [PATCH] arch_topology: init capacity_freq_ref to 0
Message-ID: <Z7NPEic3jxLAQBTd@arm.com>
References: <20240827154818.1195849-1-ionela.voinescu@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827154818.1195849-1-ionela.voinescu@arm.com>

Hi folks,

I just wanted to mention that this patch still applies cleanly on
next-20250217 as well, and it still builds/boots/works as expected.

I've rechecked it given that the patches at [1] seem ready to be picked
up, and those patches depend on this one.

Thanks,
Ionela.

[1] https://lore.kernel.org/lkml/20250131162439.3843071-1-beata.michalska@arm.com/

On Tuesday 27 Aug 2024 at 16:48:18 (+0100), Ionela Voinescu wrote:
> It's useful to have capacity_freq_ref initialized to 0 for users of
> arch_scale_freq_ref() to detect when capacity_freq_ref was not
> yet set.
> 
> The only scenario affected by this change in the init value is when a
> cpufreq driver is never loaded. As a result, the only setter of a
> cpu scale factor remains the call of topology_normalize_cpu_scale()
> from parse_dt_topology(). There we cannot use the value 0 of
> capacity_freq_ref so we have to compensate for its uninitialized state.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> 
> Hi,
> 
> This patch was previously part of the patch-set at [1], but we thought
> it's best to separate the standalone patches in that set to make
> further review easier on the remaining topics.
> 
> Based on v6.11-rc5 and tested on Juno with and without a cpufreq driver.
> 
> [1] https://lore.kernel.org/lkml/20240603082154.3830591-2-beata.michalska@arm.com/
> 
> Thanks,
> Ionela.
> 
>  drivers/base/arch_topology.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75fcb75d5515..c49ef1a712f4 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -28,7 +28,7 @@
>  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
> -DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
> +DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 0;
>  EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
>  
>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
> @@ -293,13 +293,15 @@ void topology_normalize_cpu_scale(void)
>  
>  	capacity_scale = 1;
>  	for_each_possible_cpu(cpu) {
> -		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> +		capacity = raw_capacity[cpu] *
> +			   (per_cpu(capacity_freq_ref, cpu) ?: 1);
>  		capacity_scale = max(capacity, capacity_scale);
>  	}
>  
>  	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
>  	for_each_possible_cpu(cpu) {
> -		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> +		capacity = raw_capacity[cpu] *
> +			   (per_cpu(capacity_freq_ref, cpu) ?: 1);
>  		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
>  			capacity_scale);
>  		topology_set_cpu_scale(cpu, capacity);
> -- 
> 2.25.1
> 
> 

