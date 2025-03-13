Return-Path: <linux-kernel+bounces-559107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D933CA5EFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EEB189C935
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC328264617;
	Thu, 13 Mar 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VS3yr2Tl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADB14900B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858616; cv=none; b=TgjIej5s+nFVSQ6f6wllA9qfKjLhz+5iBIkveAJPPJs4sxvnodjTV/6ddmKjeBiyZaGel0moanCK1KsUFwd0uhlhJZDGclvXSqybjQTi7bwEt2ehH9PBNL5jw8qgcWelBfnof99/SD4JV93LDFNy5A0QbBprlBIILB/RKUdeyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858616; c=relaxed/simple;
	bh=IhOhrSlxnKxVcldcxXlp8ols+uH5O4m44LWa+1opQtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIZ6k7EulCh3awZ6e7q2e7HYP+YbFNMZtNzDpazaNpZS1wZqZPwpSScVZ+6m2Srj/9MaeRQbE5uprkz5NDljafTwFMAluZX2Xu1B4/pNyrVNZTBwd0LQGUxPTw13AJAQPOn2HdSIw/MGRvK+3rTsNNpJzXK+QKuHqhA/KDBwaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VS3yr2Tl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 538B240E020E;
	Thu, 13 Mar 2025 09:36:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ezr2xfWOvaST; Thu, 13 Mar 2025 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741858598; bh=uNcgx3nJkSQVLH76uZj0J408nXFmhO/9yySOGft4o9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VS3yr2TlyC0wrfRay563yevuhnuEcvQ5oSspuN37j8AX8eiff3mKoEEioqK1u2Vo6
	 d5wOCcncn0cD7SHD+reNjs+mzXqIZmx1/X6L8uJnQGwWY2Y4N0hGSlcLQ6fAU53oj/
	 xLxgCGOIeVX8DkDXaI36V1nk/u5JkRnOizFq0b+VuD7DaDp0R9WmXfXlEI60b70VMi
	 20Qh4tMtzl/JxtTlp67amw1rPcjqEtDRUrdP5VhzEEG1HE46d6xjDs236nnExqDwfB
	 Y1Oy3CnzIOESjHw/xRIfvCAxn3iw7R9d7hkoO1ymE3ogCNmIPh/grQF/8V/AMxQ5/E
	 i1cGH5CAfLgDKj5dpT6w4RcASMch/IHLC3tGQDLpSdzq+1WKc/oEihH41x+69pCaeU
	 r7oL2zf5ZyheYjyNcQRBcU2JFJp3fWyLNsqhzlT2mASZYF25o0fHz5OI0e4HuaR90R
	 kzST9WKY0DvkMzbfDOGpQGkXKs/BLmQvg8siOj7CNJ7Bx4t+du8RANTrzuvvSlE9+h
	 wvMg8dgPll4mKRzWdM5Ill6ztRj1kcGB3dhz7F/wKj0iCWpbAQsevGvkx8osxmeFj8
	 Upyi/Gzuq3RZYrpymVFAqN4ldvcHwEgqJ9ezZbxIkzUZRLe87ouVKecScDKYydhVzp
	 zLcGavq+hS8cf7tds+eP31nI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E20A40E023C;
	Thu, 13 Mar 2025 09:36:26 +0000 (UTC)
Date: Thu, 13 Mar 2025 10:36:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: [PATCH v4 03/36] x86/bugs: Restructure mmio mitigation
Message-ID: <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310164023.779191-4-david.kaplan@amd.com>

On Mon, Mar 10, 2025 at 11:39:50AM -0500, David Kaplan wrote:
> @@ -511,24 +516,60 @@ static void __init mmio_select_mitigation(void)
>  		return;
>  	}
>  
> -	if (mmio_mitigation == MMIO_MITIGATION_OFF)
> -		return;
> +	/* Microcode will be checked in mmio_update_mitigation(). */
> +	if (mmio_mitigation == MMIO_MITIGATION_AUTO)
> +		mmio_mitigation = MMIO_MITIGATION_VERW;
>  
>  	/*
>  	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
> -	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
> +	 * by MDS or TAA.
>  	 */
> -	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
> -					      boot_cpu_has(X86_FEATURE_RTM)))
> -		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> +	if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
> +		verw_mitigation_selected = true;
> +}

So applied this reads strange:

        if (mmio_mitigation == MMIO_MITIGATION_AUTO)
                mmio_mitigation = MMIO_MITIGATION_VERW;

        if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
                verw_mitigation_selected = true;

I'd expect to see:

	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
                mmio_mitigation = MMIO_MITIGATION_VERW;
		verw_mitigation_selected = true;
	}

        if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
                verw_mitigation_selected = true;

because the above branch already selected MMIO_MITIGATION_VERW so we might as
well set verw_mitigation_selected, right?

> +static void __init mmio_update_mitigation(void)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
> +		return;
> +
> +	if (verw_mitigation_selected)
> +		mmio_mitigation = MMIO_MITIGATION_VERW;

... and the above change would obviate this one.

Looking at that verw_mitigation_selected switch - that seems like the higher
prio thing we should be looking at first as in: *something* selected VERW
mitigation so we must honor it.

And then the *_select_mitigation() functions will simply use the respective
*_mitigation variable to perhaps override it only when really needed.

I think.

Or maybe I'm missing an aspect.

Because if we make verw_mitigation_selected the higher prio thing, we can
remove some of that additional checking.

Or?

> +
> +	if (mmio_mitigation == MMIO_MITIGATION_VERW) {

I.e., in mmio_update_mitigation(), the only check you need to do is:

	if (verw_mitigation_selected)

and then adjust mmio_mitigation depending on microcode presence or not.

> +		/*
> +		 * Check if the system has the right microcode.
> +		 *
> +		 * CPU Fill buffer clear mitigation is enumerated by either an explicit
> +		 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
> +		 * affected systems.
> +		 */
> +		if (!((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
> +		      (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
> +		       boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
> +		     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO))))
> +			mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;

... as you do here.

> +	}
> +
> +	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))

Btw, that UNKNOWN thing is just silly. Looking at git history:

7df548840c49 ("x86/bugs: Add "unknown" reporting for MMIO Stale Data")

this was added just so that it doesn't say "Not affected" about those CPUs but
"unknown."

But

  "Mitigation is not deployed when the status is unknown."

so if it is only about reporting, I think we can synthesize the logic of this:

        if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
                if (cpu_matches(cpu_vuln_blacklist, MMIO))
                        setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
                else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
                        setup_force_cpu_bug(X86_BUG_MMIO_UNKNOWN);
        }

into a separate function and get rid of that X86_BUG_MMIO_UNKNOWN thing.

Pawan?

I'll try to whack it later to see how ugly it gets.

> +		pr_info("Unknown: No mitigations\n");
> +	else
> +		pr_info("%s\n", mmio_strings[mmio_mitigation]);
> +}
> +
> +static void __init mmio_apply_mitigation(void)
> +{
> +	if (mmio_mitigation == MMIO_MITIGATION_OFF)
> +		return;
>  
>  	/*
> -	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
> -	 * mitigations, disable KVM-only mitigation in that case.
> +	 * Only enable the VMM mitigation if the CPU buffer clear mitigation is
> +	 * not being used.

So this comment doesn't fit with what the code now does...

>  	 */
> -	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
> +	if (verw_mitigation_selected) {

... which is to check whether something enabled the VERW mitigation...

> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
>  		static_branch_disable(&mmio_stale_data_clear);
> -	else
> +	} else
>  		static_branch_enable(&mmio_stale_data_clear);

{ } around the else branch too pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

