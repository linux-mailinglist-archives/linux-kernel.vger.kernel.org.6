Return-Path: <linux-kernel+bounces-551032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC14A5672F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A88618991C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B1218593;
	Fri,  7 Mar 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSdft9mI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B020C00C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348536; cv=none; b=dSNKq/n0nLdYlYWO2wWjKBhVZTqX9w1BF8mC7HJbmcRTQS5sEsWHVCHEw7L1OOb2FBHrixCF4P9WLh2EWlK0uXmbN9Sh1zuviSGYcIVcjMJIhVwZDXZqEYV/nxxdXHLhKO2bmFhki4bKXHIusRf3V33EUb6hUHcMcwQzaGLKiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348536; c=relaxed/simple;
	bh=3FDhKx5oaBuiHt/2PqyKgEYi+QoTrNq29sFGPTWN/hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWUfFghT1Udq+KbhJLeI5L7uCP5boQh9wewMjaZwty6Vq+LGJsmsm6fhv4Eg8VGfaAqtSabIVl9R2hEmZ26i2OZnm35EvwUBwtqV7XLsEWNtyKkSOkG4wusTruJXqNFlB5fUCtsCtrLSWbP3gcbfeRkXzPxEa+1saKnCLohrbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSdft9mI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D28C4CEE7;
	Fri,  7 Mar 2025 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741348536;
	bh=3FDhKx5oaBuiHt/2PqyKgEYi+QoTrNq29sFGPTWN/hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSdft9mIO1tx3oGczY2Bkk5TVQiYd3t6hGRLTCgpFm/5JwZSFI21RFx4Cr7/i6g0B
	 CPYWHWzn3WQ0OyQlK4iqQi9abPluxDBvKBq8zb88BqctyeA3j8zBScVZZjWAN5COQJ
	 KzLQnlJWo1LPuAyBT4/Hu/iJzv60BllciQUljJ7gRqYd4A3mNsqOEGdlX08Qoi36XM
	 gH2Kmtn2braqzelTUu9dqLq7+M+rCRtiM5ziESlfqxhKIbx7R3mcetXOylVDGZqZga
	 vHm8YmaUsiRlTw9DHZ5FJVT5qLFi8E74HFTCS16F6m7ECBVOjIJyYN8YWRx/XAUr87
	 D4FQlLwGqGfbA==
Date: Fri, 7 Mar 2025 12:55:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Eric Biggers <ebiggers@google.com>, Xin Li <xin3.li@intel.com>,
	Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] x86/cpufeature: Warn about unmet feature dependencies
Message-ID: <Z8resWzgtZaTuzEN@gmail.com>
References: <20250307000204.3581369-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307000204.3581369-1-sohil.mehta@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> Currently, the cpuid_deps[] table is only exercised when a particular
> feature gets explicitly disabled and clear_cpu_cap() is called. However,
> some of these listed dependencies might already be missing during boot.
> 
> These types of errors shouldn't generally happen in production
> environments but they could sometimes sneak through, especially when VMs
> and Kconfigs are in the mix. Also, the kernel might introduce artificial
> dependencies between unrelated features such as making LAM depend on
> LASS.
> 
> Unexpected failures can occur when the kernel tries to use such a
> feature. Add a simple boot time scan of the cpuid_deps[] table to detect
> the missing dependencies. One option is to disable all of such features
> during boot but that may cause regressions in existing systems. For now,
> just warn about the missing dependencies to create awareness.
> 
> As a trade-off between spamming the kernel log and keeping track of all
> the features that have been warned about, only warn about the first
> missing dependency. Any subsequent unmet dependency will only be logged
> after the first one has been resolved.
> 
> Features are typically represented through unsigned integers within the
> kernel though some of them have user friendly names if they are exposed
> via cpuinfo.  Show the friendlier name if available otherwise display
> the X86_FEATURE_* numerals to make it easier to identify the feature.
> 
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v5: Don't disable features with unmet dependencies (Ingo)
>     Use pr_warn_once() for the warning (Ingo)
> 
> v4: https://lore.kernel.org/lkml/20241210224037.3052555-1-sohil.mehta@intel.com/
>     Update the log level to pr_info() (Ingo)
>     Update the char buffer size to 16 (0day warning)
>     Dropped Dave's review tag since the code has changed a bit more
>     than usual.
> 
> v3: Picked up the review tag.
>     Reworded the commit message.
> 
> v2: Use cpu_has() instead of boot_cpu_has() (Sean)
> ---
>  arch/x86/include/asm/cpufeature.h |  1 +
>  arch/x86/kernel/cpu/common.c      |  4 ++++
>  arch/x86/kernel/cpu/cpuid-deps.c  | 35 +++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index de1ad09fe8d7..1bb30e82ea77 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -149,6 +149,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  
>  extern void setup_clear_cpu_cap(unsigned int bit);
>  extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
> +void scan_feature_dependencies(struct cpuinfo_x86 *c);
>  
>  #define setup_force_cpu_cap(bit) do {			\
>  							\
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 7cce91b19fb2..52111d97c8ae 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1610,6 +1610,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  
>  		c->cpu_index = 0;
>  		filter_cpuid_features(c, false);
> +		scan_feature_dependencies(c);
>  
>  		if (this_cpu->c_bsp_init)
>  			this_cpu->c_bsp_init(c);
> @@ -1870,6 +1871,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	/* Filter out anything that depends on CPUID levels we don't have */
>  	filter_cpuid_features(c, true);
>  
> +	/* Scan for unmet dependencies based on the CPUID dependency table */
> +	scan_feature_dependencies(c);

s/scane_feature_dependencies
 /x86_check_cpufeature_deps

or so.

> +/*
> + * Return the feature "name" if available otherwise return
> + * the X86_FEATURE_* numerals to make it easier to identify
> + * the feature.

s/available otherwise
 /available, otherwise

> + */
> +static const char *x86_feature_name(unsigned int feature, char *buf)
> +{
> +	if (x86_cap_flags[feature])
> +		return x86_cap_flags[feature];
> +
> +	snprintf(buf, 16, "%d*32+%2d", feature / 32, feature % 32);
> +
> +	return buf;
> +}
> +
> +void scan_feature_dependencies(struct cpuinfo_x86 *c)
> +{
> +	char feature_buf[16], depends_buf[16];
> +	const struct cpuid_dep *d;
> +
> +	for (d = cpuid_deps; d->feature; d++) {
> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
> +			/*
> +			 * Only warn about the first unmet dependency on the
> +			 * first CPU where it is encountered to avoid spamming
> +			 * the kernel log.
> +			 */
> +			pr_warn_once("CPU%d: feature:%s may not work properly without feature:%s\n",
> +				     smp_processor_id(),
> +				     x86_feature_name(d->feature, feature_buf),
> +				     x86_feature_name(d->depends, depends_buf));

I'd make this a bit less passive-aggressive, something like:

     x86 CPU feature dependency check failure: CPU%d has '%s' enabled but '%s' disabled. Kernel might be fine, but no guarantees.

Because initially most of these warnings will be about quirks and 
oddities that happen to work fine in the current code.

Thanks,

	Ingo

