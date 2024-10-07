Return-Path: <linux-kernel+bounces-354081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37B993780
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72BBB22925
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904D1DE3DD;
	Mon,  7 Oct 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1aCc3eY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC01DE3CB;
	Mon,  7 Oct 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329848; cv=none; b=XU8pfvCDQAknp6QFt7vO8gFORx2W/TGntvniXgg31zKh9ivd1RzrZT6W0TTnLWfX5kPgOyPO4JkrfGzI3BSH89xp1rASb9YmfjNwdyidRL+Oy/nxbD7GduIwprp3qnrMw/SS77qz5GGE/g3ZNX0m0l/QW8Uqp3uCJCGPGsImR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329848; c=relaxed/simple;
	bh=N0+CyQW9jKjqf3GOtNNz46BXlyceq3i2an+kE+Tla8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml9dsCk7Z3QrFmMWzukjK5NvltBEcN0Y7pWl/uxoekgHYFlq+rF97NCYx5YWu2JLc9fWNlVua2U3Sm+L6ku0+QbckkGItfQvWocv6vF8vEESp9QmrdWe4Umw6npnOeE3vTfyjqHNbLk+Mh2F9lMvePsXbyC8+IPohdxjV4B1D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1aCc3eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6053C4CECF;
	Mon,  7 Oct 2024 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728329848;
	bh=N0+CyQW9jKjqf3GOtNNz46BXlyceq3i2an+kE+Tla8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1aCc3eYBxqqKqd+HKJMwhaB9Okw3Z/n/cV6lRVaIX+tsqFIOAUczV3H0GHOKMySt
	 ENZp3x6zDuUA4x0Ws+WAPhhjvqQvAhADil94fFxZ95OmQvb1An7TsRbByHza73qRS9
	 j6f9AIjE7FsjQhajkMNc3m5O57A+NOlhuF2oHa4AODAilrwdTp6JdnfHkguxA2J/EP
	 OGLADRuy6Bn/ED2V1odkr6dxRJgz1/GYX9jqFO9Fxq0sdEJfYnDsPGUy5siS6rVSpS
	 S1aI1Y99csUG+nbFHpDsvZXcJrqKwIoO4MFYi+iuhLik9NWpvhqDWFRrepiDS3nR1i
	 R8B9oNNGqR0NQ==
Date: Mon, 7 Oct 2024 12:37:26 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 6/6] x86/bugs: Clean-up verw mitigations
Message-ID: <20241007193726.m5mzkjjy4yscge6x@treble>
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
 <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>

On Tue, Sep 24, 2024 at 03:31:40PM -0700, Daniel Sneddon wrote:
> +static void __init md_clear_select_mitigation(void)
> +{
>  	/*
> -	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
> -	 * Stale Data mitigation, if necessary.
> +	 * If no CPU bug needs VERW, all VERW mitigations are disabled, or all
> +	 * mitigations are disabled we bail.
>  	 */

It's already clear what the code is doing, no comment necessary.

> -	if (mds_mitigation == MDS_MITIGATION_OFF &&
> -	    boot_cpu_has_bug(X86_BUG_MDS)) {
> +	if (!cpu_bug_needs_verw() || verw_mitigations_disabled() ||
> +	    cpu_mitigations_off()) {
> +		mds_mitigation = MDS_MITIGATION_OFF;
> +		taa_mitigation = TAA_MITIGATION_OFF;
> +		mmio_mitigation = MMIO_MITIGATION_OFF;
> +		rfds_mitigation = RFDS_MITIGATION_OFF;
> +		goto out;
> +	}

In the case of verw_mitigations_disabled() it's weird to write the
variables again if they're already OFF.  That should be a separate
check.

> +
> +	/* Check that at least one mitigation is using the verw mitigaiton.
> +	 * If the cpu doesn't have the correct ucode or if the BUG_* is mitigated
> +	 * by disabling a feature we won't want to use verw. Ignore MMIO
> +	 * for now since it depends on what the others choose.
> +	 */

Again I think this comment isn't needed as the code is pretty
straightforward.  The only surprise is the MMIO dependency on
X86_FEATURE_CLEAR_CPU_BUF, but that's called out below.

> +
> +	if (boot_cpu_has_bug(X86_BUG_MDS)) {
>  		mds_mitigation = MDS_MITIGATION_FULL;
>  		mds_select_mitigation();
> +	}  else {
> +		mds_mitigation = MDS_MITIGATION_OFF;
>  	}
> -	if (taa_mitigation == TAA_MITIGATION_OFF &&
> -	    boot_cpu_has_bug(X86_BUG_TAA)) {
> +	if (boot_cpu_has_bug(X86_BUG_TAA)) {
>  		taa_mitigation = TAA_MITIGATION_VERW;
>  		taa_select_mitigation();
> +	} else {
> +		taa_mitigation = TAA_MITIGATION_OFF;
>  	}
> -	/*
> -	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
> -	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
> -	 */
> +	if (boot_cpu_has_bug(X86_BUG_RFDS)) {
> +		rfds_mitigation = RFDS_MITIGATION_VERW;
> +		rfds_select_mitigation();
> +	} else {
> +		rfds_mitigation = RFDS_MITIGATION_OFF;
> +	}

This spaghetti can be simplifed by relying on *_select_mitigation() to
set the mitigation, for example:

static void __init mds_select_mitigation(void)
{
	if (!boot_cpu_has_bug(X86_BUG_MDS))
		mds_mitigation = MDS_MITIGATION_OFF;
	else if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
		mds_mitigation = MDS_MITIGATION_VERW;
	else
		mds_mitigation = MDS_MITIGATION_VMWERV;
}

Then you can just do:

	mds_select_mitigation();
	taa_select_mitigation();
	rfds_select_mitigation();


> +	if (mds_mitigation == MDS_MITIGATION_FULL ||
> +	    taa_mitigation == TAA_MITIGATION_VERW ||
> +	    rfds_mitigation == RFDS_MITIGATION_VERW)

For consistency can we rename MDS_MITIGATION_FULL to
MDS_MITIGATION_VERW?

> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> +
> +	/* Now handle MMIO since it may not use X86_FEATURE_CLEAR_CPU_BUF */

I would clarify this a bit, something like:

	/*
	 * The MMIO mitigation has a dependency on
	 * X86_FEATURE_CLEAR_CPU_BUF so this must be called after it
	 * gets set.
	 */

>  	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
>  		mmio_mitigation = MMIO_MITIGATION_VERW;
>  		mmio_select_mitigation();
> +	} else {
> +		mmio_mitigation = MMIO_MITIGATION_OFF;
>  	}
> -	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
> -	    boot_cpu_has_bug(X86_BUG_RFDS)) {
> -		rfds_mitigation = RFDS_MITIGATION_VERW;
> -		rfds_select_mitigation();
> -	}
> +
> +	/* handle nosmt */

Again I think this comment is superfluous.

> +	if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
> +	    (mds_nosmt || cpu_mitigations_auto_nosmt()))
> +		cpu_smt_disable(false);
> +
> +	if (taa_nosmt || mmio_nosmt || cpu_mitigations_auto_nosmt())
> +		cpu_smt_disable(false);
> +

-- 
Josh

