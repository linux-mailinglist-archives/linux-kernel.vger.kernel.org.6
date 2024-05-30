Return-Path: <linux-kernel+bounces-195481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F608D4D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A051F2176D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18A2176248;
	Thu, 30 May 2024 14:03:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9917622F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077833; cv=none; b=C+92EyzPDCNEX9fME7PDhiFpX4kP+gr3d4gpS3DjxNZcgjqL1XlqnfO/ypCOjO1ONjEmkf3zPntR/usjx5DW44xEFc2wFKJvmm80ZyVs/Sr0+MNNf6XCW4Foi4crQnvHUbFMPLemdXgFdWp3jxfz7pZzz4Id/63jNyImBTATM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077833; c=relaxed/simple;
	bh=kzmhKj7L3gIDjQkwNH7MJkSmvIqXHr3h1zvdlIWqmzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnrATlBGWW2mObQMrO9yAwFuMRZSjSSanELUUqOpYLahelMDT5EDKa8t7SwTXdXl1kHhwYDmCgSWWLHq19JWfJuVNxZxDCaa/1PzBNIprRPlRD2Ty8+BwzOLdD4NIMsf4HNcXmvsWt6kipgNy0XiR5/hkgk8FUpbl4RKJp3IrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD514339;
	Thu, 30 May 2024 07:04:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9602E3F641;
	Thu, 30 May 2024 07:03:47 -0700 (PDT)
Date: Thu, 30 May 2024 15:03:42 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Message-ID: <ZliFrIRcH1zbOeiU@e133380.arm.com>
References: <20240529-arm64-sve-trap-mitigation-v6-1-c2037be6aced@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-arm64-sve-trap-mitigation-v6-1-c2037be6aced@kernel.org>

Hi Mark,

On Wed, May 29, 2024 at 08:46:23PM +0100, Mark Brown wrote:
> When we are in a syscall we take the opportunity to discard the SVE state,
> saving only the FPSIMD subset of the register state. When we reload the
> state from memory we reenable SVE access traps, stopping tracking SVE until
> the task takes another SVE access trap. This means that for a task which is
> actively using SVE many blocking system calls will have the additional
> overhead of a SVE access trap.

Playing devil's advocate here: doesn't a blocking syscall already imply
a high overhead (at least in terms of latency for the thread concerned)?

i.e., does letting TIF_SVE linger across some blocking syscalls make a
meaningful difference in some known use case?


(For non-blocking syscalls the argument for allowing TIF_SVE to linger
seems a lot stronger.)

> As SVE deployment is progressing we are seeing much wider use of the SVE
> instruction set, including performance optimised implementations of
> operations like memset() and memcpy(), which mean that even tasks which are
> not obviously floating point based can end up with substantial SVE usage.
> 
> It does not, however, make sense to just unconditionally use the full SVE
> register state all the time since it is larger than the FPSIMD register
> state so there is overhead saving and restoring it on context switch and
> our requirement to flush the register state not shared with FPSIMD on
> syscall also creates a noticeable overhead on system call.
> 
> I did some instrumentation which counted the number of SVE access traps
> and the number of times we loaded FPSIMD only register state for each task.
> Testing with Debian Bookworm this showed that during boot the overwhelming
> majority of tasks triggered another SVE access trap more than 50% of the
> time after loading FPSIMD only state with a substantial number near 100%,
> though some programs had a very small number of SVE accesses most likely
> from startup. There were few tasks in the range 5-45%, most tasks either
> used SVE frequently or used it only a tiny proportion of times. As expected
> older distributions which do not have the SVE performance work available
> showed no SVE usage in general applications.
> 
> This indicates that there should be some useful benefit from reducing the
> number of SVE access traps for blocking system calls like we did for non
> blocking system calls in commit 8c845e273104 ("arm64/sve: Leave SVE enabled
> on syscall if we don't context switch"). Let's do this with a timeout, when
> we take a SVE access trap record a jiffies after which we'll reeanble SVE
> traps then check this whenver we load a FPSIMD only floating point state
> from memory. If the time has passed then we reenable traps, otherwise we
> leave traps disabled and flush the non-shared register state like we would
> on trap.
> 
> The timeout is currently set to a second, I pulled this number out of thin
> air so there is doubtless some room for tuning. This means that for a
> task which is actively using SVE the number of SVE access traps will be
> substantially reduced but applications which use SVE only very
> infrequently will avoid the overheads associated with tracking SVE state
> after a second. The extra cost from additional tracking of SVE state
> only occurs when a task is preempted so short running tasks should be
> minimally affected.

Could your instrumentation be extended to build a histogram of the delay
between successive SVE traps per task?

There's a difference here between a task that takes a lot of traps in a
burst (perhaps due to startup or a specific library call), versus a task
that uses SVE sporadically for all time.

I wonder whether the sweet spot for the timeout may be quite a lot
shorter than a second.  Still, once we have something we can tune, we
can always tune it later as you suggest.

> 
> There should be no functional change resulting from this, it is purely a
> performance optimisation.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v6:
> - Rebase onto v6.10-rc1.
> - Link to v5: https://lore.kernel.org/r/20240405-arm64-sve-trap-mitigation-v5-1-126fe2515ef1@kernel.org
> 
> Changes in v5:
> - Rebase onto v6.9-rc1.
> - Use a timeout rather than number of state loads to decide when to
>   reenable traps.
> - Link to v4: https://lore.kernel.org/r/20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org
> 
> Changes in v4:
> - Rebase onto v6.8-rc1.
> - Link to v3: https://lore.kernel.org/r/20231113-arm64-sve-trap-mitigation-v3-1-4779c9382483@kernel.org
> 
> Changes in v3:
> - Rebase onto v6.7-rc1.
> - Link to v2: https://lore.kernel.org/r/20230913-arm64-sve-trap-mitigation-v2-1-1bdeff382171@kernel.org
> 
> Changes in v2:
> - Rebase onto v6.6-rc1.
> - Link to v1: https://lore.kernel.org/r/20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org
> ---
>  arch/arm64/include/asm/processor.h |  1 +
>  arch/arm64/kernel/fpsimd.c         | 42 ++++++++++++++++++++++++++++++++------
>  2 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index f77371232d8c..7a6ed0551291 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -164,6 +164,7 @@ struct thread_struct {
>  	unsigned int		fpsimd_cpu;
>  	void			*sve_state;	/* SVE registers, if any */
>  	void			*sme_state;	/* ZA and ZT state, if any */
> +	unsigned long		sve_timeout;    /* jiffies to drop TIF_SVE */
>  	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
>  	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
>  	unsigned long		fault_address;	/* fault info */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 82e8a6017382..4741e4fb612a 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -354,6 +354,7 @@ static void task_fpsimd_load(void)
>  {
>  	bool restore_sve_regs = false;
>  	bool restore_ffr;
> +	unsigned long sve_vq_minus_one;
>  
>  	WARN_ON(!system_supports_fpsimd());
>  	WARN_ON(preemptible());
> @@ -365,18 +366,12 @@ static void task_fpsimd_load(void)
>  	if (system_supports_sve() || system_supports_sme()) {
>  		switch (current->thread.fp_type) {
>  		case FP_STATE_FPSIMD:
> -			/* Stop tracking SVE for this task until next use. */
> -			if (test_and_clear_thread_flag(TIF_SVE))
> -				sve_user_disable();
>  			break;
>  		case FP_STATE_SVE:
>  			if (!thread_sm_enabled(&current->thread) &&
>  			    !WARN_ON_ONCE(!test_and_set_thread_flag(TIF_SVE)))
>  				sve_user_enable();
>  
> -			if (test_thread_flag(TIF_SVE))
> -				sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
> -
>  			restore_sve_regs = true;
>  			restore_ffr = true;
>  			break;
> @@ -395,6 +390,15 @@ static void task_fpsimd_load(void)
>  		}
>  	}
>  
> +	/*
> +	 * If SVE has been enabled we may keep it enabled even if
> +	 * loading only FPSIMD state, so always set the VL.
> +	 */
> +	if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
> +		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
> +		sve_set_vq(sve_vq_minus_one);
> +	}
> +
>  	/* Restore SME, override SVE register configuration if needed */
>  	if (system_supports_sme()) {
>  		unsigned long sme_vl = task_get_sme_vl(current);
> @@ -421,6 +425,25 @@ static void task_fpsimd_load(void)
>  	} else {
>  		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
>  		fpsimd_load_state(&current->thread.uw.fpsimd_state);
> +
> +		/*
> +		 * If the task had been using SVE we keep it enabled
> +		 * when loading FPSIMD only state for a period to
> +		 * minimise overhead for tasks actively using SVE,
> +		 * disabling it periodicaly to ensure that tasks that
> +		 * use SVE intermittently do eventually avoid the
> +		 * overhead of carrying SVE state.  The timeout is
> +		 * initialised when we take a SVE trap in in
> +		 * do_sve_acc().
> +		 */
> +		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
> +			if (time_after(jiffies, current->thread.sve_timeout)) {
> +				clear_thread_flag(TIF_SVE);
> +				sve_user_disable();
> +			} else {
> +				sve_flush_live(true, sve_vq_minus_one);

Didn't we already flush Zn[max:128] as a side-effect of loading the
V-regs in fpsimd_load_state() above?

Also, unless I'm missing something, prior to this patch we could just
fall through this code with TIF_SVE still set, suggesting that either
this flush is not needed for some reason, or it is shadowed by another
flush done somewhere else, or a flush is currenly needed but missing.
Am I just getting myself confused here?

(Or, do the deletions from the switch in the earlier hunk cancel this
out?)

> +			}
> +		}
>  	}
>  }
>  
> @@ -1397,6 +1420,13 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
>  
>  	get_cpu_fpsimd_context();
>  
> +	/*
> +	 * We will keep SVE enabled when loading FPSIMD only state for
> +	 * the next second to minimise traps when userspace is
> +	 * actively using SVE.
> +	 */
> +	current->thread.sve_timeout = jiffies + HZ;
> +
>  	if (test_and_set_thread_flag(TIF_SVE))
>  		WARN_ON(1); /* SVE access shouldn't have trapped */
>  
> 
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20230807-arm64-sve-trap-mitigation-2e7e2663c849
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>

[...]

Cheers
---Dave

