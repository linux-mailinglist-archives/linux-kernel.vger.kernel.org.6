Return-Path: <linux-kernel+bounces-248201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19992D9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38971F23118
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0088195F3A;
	Wed, 10 Jul 2024 20:10:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE54F1E2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642257; cv=none; b=FwM2e0EjbPUZ4/p7s0XfB73PEKqJHNGkp5TWkpDhb8XtRd2RguVCvrJY+OV1WJyZRoW9fqIYPm1CCvQHgQRUG3e6SyZb1O7SP9kMlWCRUk2TwP5DRbqwTylAgw3684CPluUNBuo6J5Gj5P6Gm794fWRzc+C9jj8rrNPicQqnKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642257; c=relaxed/simple;
	bh=nY6/CuM/tSFOBIl6dKardcRXuBru7M7Pala5zyOQUAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnaWemNrJUp5GpGkMzXvvP5ILRwM4W7l5juTqiAVpc4s98phGkFwaB9s1iK11b8zPIJjy0HP+JETGlO5H+DuBIo1GizsaEyjX0PYD+VBgDa3p/KgKC/C8y5XRuHvcKhCxBw6XoMvsscwmbxPdSrmRjU08iINugxtnw0mJJfuYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC0C32781;
	Wed, 10 Jul 2024 20:10:55 +0000 (UTC)
Date: Wed, 10 Jul 2024 21:10:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Message-ID: <Zo7qzWVXRWulVtCT@arm.com>
References: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>

+ Mark R, he commented on the other patch.

On Tue, Jun 18, 2024 at 02:57:42PM +0100, Mark Brown wrote:
> When we enter the kernel we currently don't update any of the floating
> point register state until either something else uses floating point or we
> get a CPU_PM_ENTER notification during suspend or cpuidle. This means that
> for a system which has been configured with both suspend and cpuidle
> disabled we will leave whatever floating point state was loaded in the
> registers present while a CPU is idling.
> 
> For SME this may cause an idling CPU to interfere with the operation of
> other CPUs, SME may be implemented as a SMCU shared with between multiple
> CPUs. Leaving ZA or especially streaming mode enabled may be taken by
> the hardware as an indication that SME is active use by the CPU and cause
> resources to be allocated to it at the expense of other CPUs.
> 
> Add an arch_cpu_idle_enter() implementation which disables SME if it is
> active when we idle the CPU, ensuring that we don't create any spurious
> contention even if cpuidle is not enabled.

I guess this approach is useful when the kernel does a light WFI rather
than going all the way to firmware for a deep sleep state. In general,
the shallower the sleep state is, the more CPU state is retained. From a
power perspective, I wonder whether we should leave the decision to drop
the SME state to a cpuidle driver.

If SME is implemented as a shared unit, doing an SMSTOP could be a
useful indication that other tasks can use it.

Which situations should we consider for such idle scenario (we discussed
them offline briefly)? I think:

1. Thread migration: a thread using SME is moved to a different CPU.
   Here SMSTOP makes sense because a new thread scheduled eventually
   will need a different SME state.

2. Thread page fault followed by waiting for I/O etc. and the kernel may
   switch to idle. Here it's probably less beneficial to do an SMSTOP.

Any other cases? Blocking syscalls don't matter since we don't preserve
the state between calls.

The trade-off is for case (2) above and it depends on whether it happens
sufficiently often to be noticeable. I wouldn't think so.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h |  2 ++
>  arch/arm64/kernel/fpsimd.c      | 14 ++++++++++++++
>  arch/arm64/kernel/process.c     |  5 +++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index bc69ac368d73..e1453a1d261d 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -82,6 +82,8 @@ extern void fpsimd_restore_current_state(void);
>  extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
>  extern void fpsimd_kvm_prepare(void);
>  
> +extern void fpsimd_idle_enter(void);
> +
>  struct cpu_fp_state {
>  	struct user_fpsimd_state *st;
>  	void *sve_state;
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 82e8a6017382..400eaad374a2 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -2126,6 +2126,20 @@ static void __init fpsimd_pm_init(void)
>  static inline void fpsimd_pm_init(void) { }
>  #endif /* CONFIG_CPU_PM */
>  
> +void fpsimd_idle_enter(void)
> +{
> +	/*
> +	 * Leaving SME enabled may leave this core contending with
> +	 * other cores if we have a SMCU, disable whenever we enter
> +	 * idle to avoid this.  Only do this if they're actually
> +	 * enabled to avoid overhead in cases where we don't enter a
> +	 * low enough power state to loose register state.
> +	 */
> +	if (system_supports_sme() &&
> +	    (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)))
> +		fpsimd_save_and_flush_cpu_state();
> +}

Do we always enter here via the idle thread? If we already had a thread
switch we probably don't need to save the SME state again, only flush
the state.

>  #ifdef CONFIG_HOTPLUG_CPU
>  static int fpsimd_cpu_dead(unsigned int cpu)
>  {
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 4ae31b7af6c3..fd616882cd49 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -68,6 +68,11 @@ EXPORT_SYMBOL(__stack_chk_guard);
>  void (*pm_power_off)(void);
>  EXPORT_SYMBOL_GPL(pm_power_off);
>  
> +void arch_cpu_idle_enter(void)
> +{
> +       fpsimd_idle_enter();
> +}
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  void __noreturn arch_cpu_idle_dead(void)
>  {

-- 
Catalin

