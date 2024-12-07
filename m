Return-Path: <linux-kernel+bounces-435947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E629E7F0A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D116718833E4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B2A137742;
	Sat,  7 Dec 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+/h+HNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50618638
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560561; cv=none; b=gMQxgSnAeZ5XSQDSW8b6xTgUqGYwLpwCrl6G4CjlHzo/EvMFMUovlSArHZp6BTKpM00R9vY1OhVzzLWIjSwoLgUerWPY1Rp/anwOdoYsS3PDvIwKNcFGobzk/7FUwf3yWo1/BBSxC+7AoXSVEWyKrl76/aUr9rVQXYhlgYKcKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560561; c=relaxed/simple;
	bh=PAcYF18OxG50KDr3VtbUg2vEcUejrokwbgsxgRd6Y0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd16x4Z/sLjJYdvzaFqSvRLxKWiryifXQ3upyK9dQC5HEOUV09RSPf+G+M8nXqhodBCJV3krmvXF+2OWsf0tBijGqiiz0RiQzr1CcHUeZbs0jyZlLlPdpRoFkullAHHFuYftwmQ5qfk1xoZ+uOD1+lVMe5T4kUR+Bt4lNZ3Q52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+/h+HNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5907EC4CECD;
	Sat,  7 Dec 2024 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733560560;
	bh=PAcYF18OxG50KDr3VtbUg2vEcUejrokwbgsxgRd6Y0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+/h+HNtsKqCNosDVSlVzMTx4e++Q4HAw7LwosSdQUoM1mr09+tGsn6JL1//Qd6DT
	 Dnj9ebuLqOj1KcSgVhB5dy97W+kAkE7zp5eQKuZbM3iEK/TqdSQLVPbJfUvGqqlhBv
	 V4G74H8IqiJIGfLrJNBmPdqyRECbHCjmMuUYgRc4V5uxBPZ1iwFEcqG1OKPbvdGJDO
	 HkQsQ4ECEEJasWNANUci+Lz3tcp4fJguI7kxmRu/HqWvYvqlaiRBawYuwKq0TyAKyN
	 fygmlNbyXSLX278JG3dtB2ZfYXDwEwQblaw7ip+dbdKWqN8xwzi8w9wXp+1+QM9VOD
	 bU6koTg4B7KGg==
Date: Sat, 7 Dec 2024 09:35:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
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
Subject: Re: [PATCH v3 2/2] x86/cpufeature: Add a debug print for unmet
 dependencies
Message-ID: <Z1QI6UukVy9uJLrs@gmail.com>
References: <20241207004126.2054658-1-sohil.mehta@intel.com>
 <20241207004126.2054658-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207004126.2054658-2-sohil.mehta@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> Instead of silently disabling features, add a print which might be
> useful to users if their favorite feature gets unexpectedly disabled.
> 
> Features are typically represented through unsigned integers though some
> of them have user friendly names if they are exposed via cpuinfo.  Show
> the friendlier name if available otherwise display the X86_FEATURE_*
> numerals to make it easier to identify the feature.
> 
> Use pr_debug() to avoid spamming the kernel log and generating false
> alarms. Note that the print will occur once per disabled feature on
> every CPU. Show this information only when someone is really looking for
> it.
> 
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> Sent as a separate patch to make it easier to review and drop if it
> feels unnecessary.
> 
> I can see both sides of the argument. The pr_debug() serves a
> compromise between the two.
> 
> v3: New patch.
> 
> ---
>  arch/x86/kernel/cpu/cpuid-deps.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index 8bea5c5e4fd2..c72f2dd77d72 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -147,12 +147,32 @@ void setup_clear_cpu_cap(unsigned int feature)
>  	do_clear_cpu_cap(NULL, feature);
>  }
>  
> +/*
> + * Return the feature "name" if available otherwise return
> + * the X86_FEATURE_* numerals to make it easier to identify
> + * the feature.
> + */
> +static const char *x86_feature_name(unsigned int feature, char *buf)
> +{
> +	if (x86_cap_flags[feature])
> +		return x86_cap_flags[feature];
> +
> +	snprintf(buf, 12, "%d*32+%2d", feature / 32, feature % 32);
> +
> +	return buf;
> +}
> +
>  void filter_feature_dependencies(struct cpuinfo_x86 *c)
>  {
> +	char feature_buf[12], depends_buf[12];
>  	const struct cpuid_dep *d;
>  
>  	for (d = cpuid_deps; d->feature; d++) {
> -		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
> +			pr_debug("x86/cpu: Disabling feature %s since feature %s is missing\n",
> +				 x86_feature_name(d->feature, feature_buf),
> +				 x86_feature_name(d->depends, depends_buf));
>  			do_clear_cpu_cap(c, d->feature);

So why not make this a pr_info() at minimum?

Since this new logic will disable certain feature bits on random 
machines, I'm sure there will be some surprises. I'd sure like to see 
this printed in the system log of my machine if it happens.

It might also inform firmware & distro testers that something wasn't 
set up properly on the firmware (or virtualization) side.

Thanks,

	Ingo

