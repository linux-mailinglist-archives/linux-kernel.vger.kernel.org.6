Return-Path: <linux-kernel+bounces-217142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4090AC16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AE82862C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2B194A50;
	Mon, 17 Jun 2024 10:48:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542C194120
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621285; cv=none; b=nVd6OFmnWMqhlPWpqo9B62/OJ3Fne1f1VNYuKBPTMCLchqb6khP8Iw0Vzt37VeugP2uC4wlAqWnKPcQnFGvUxqaN40ENLJwnLnX4tANlmuGztcfMoFCYlUOSeXQUzY86Q1EeOP6yOzaLfdIZnAqLHOcgxfHKeBZWz94Zj9XHB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621285; c=relaxed/simple;
	bh=VC+pQjFEtsjPc+y2aFrxzn+w9bQgonRAHT1HFLZ357s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIpiPkYo69V5oOO2tPdZxG/UlpT8rj5yfuOIMAUjoH9V3FBKegZVkmldv6zSz2WwxD26uXc0XCSIgmLKIsp36XuwCqlQ+0Im98dvHE+uZnds42ebKrbj9ds+ItVFYB254BC86Rcl60gm6NDU73Ylh9hLMI0HoUT32v5Nrp/jVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1855EDA7;
	Mon, 17 Jun 2024 03:48:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3A43F6A8;
	Mon, 17 Jun 2024 03:48:01 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:47:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, keescook@chromium.org
Cc: paulmck@kernel.org
Subject: Re: [PATCH v2] lkdtm/bugs: add test for hung
 smp_call_function_single()
Message-ID: <ZnAUX37Jdo8OyZGf@J2N7QTR9R3>
References: <20240515120828.375585-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515120828.375585-1-mark.rutland@arm.com>

Hi Kees,

Are you happy to pick this up?

Mark.

On Wed, May 15, 2024 at 01:08:28PM +0100, Mark Rutland wrote:
> The CONFIG_CSD_LOCK_WAIT_DEBUG option enables debugging of hung
> smp_call_function*() calls (e.g. when the target CPU gets stuck within
> the callback function). Testing this option requires triggering such
> hangs.
> 
> This patch adds an lkdtm test with a hung smp_call_function_single()
> callback, which can be used to test CONFIG_CSD_LOCK_WAIT_DEBUG and NMI
> backtraces (as CONFIG_CSD_LOCK_WAIT_DEBUG will attempt an NMI backtrace
> of the hung target CPU).
> 
> On arm64 using pseudo-NMI, this looks like:
> 
> | # mount -t debugfs none /sys/kernel/debug/
> | # echo SMP_CALL_LOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry SMP_CALL_LOCKUP
> | smp: csd: Detected non-responsive CSD lock (#1) on CPU#1, waiting 5000000176 ns for CPU#00 __lkdtm_SMP_CALL_LOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> | Sending NMI from CPU 1 to CPUs 0:
> | NMI backtrace for cpu 0
> | CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-rc4-00001-gfdfd281212ec #1
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> | pc : __lkdtm_SMP_CALL_LOCKUP+0x0/0x8
> | lr : __flush_smp_call_function_queue+0x1b0/0x290
> | sp : ffff800080003f30
> | pmr_save: 00000060
> | x29: ffff800080003f30 x28: ffffa4ce961a4900 x27: 0000000000000000
> | x26: fff000003fcfa0c0 x25: ffffa4ce961a4900 x24: ffffa4ce959aa140
> | x23: ffffa4ce959aa140 x22: 0000000000000000 x21: ffff800080523c40
> | x20: 0000000000000000 x19: 0000000000000000 x18: fff05b31aa323000
> | x17: fff05b31aa323000 x16: ffff800080000000 x15: 0000330fc3fe6b2c
> | x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000279
> | x11: 0000000000000040 x10: fff000000302d0a8 x9 : fff000000302d0a0
> | x8 : fff0000003400270 x7 : 0000000000000000 x6 : ffffa4ce9451b810
> | x5 : 0000000000000000 x4 : fff05b31aa323000 x3 : ffff800080003f30
> | x2 : fff05b31aa323000 x1 : ffffa4ce959aa140 x0 : 0000000000000000
> | Call trace:
> |  __lkdtm_SMP_CALL_LOCKUP+0x0/0x8
> |  generic_smp_call_function_single_interrupt+0x14/0x20
> |  ipi_handler+0xb8/0x178
> |  handle_percpu_devid_irq+0x84/0x130
> |  generic_handle_domain_irq+0x2c/0x44
> |  gic_handle_irq+0x118/0x240
> |  call_on_irq_stack+0x24/0x4c
> |  do_interrupt_handler+0x80/0x84
> |  el1_interrupt+0x44/0xc0
> |  el1h_64_irq_handler+0x18/0x24
> |  el1h_64_irq+0x78/0x7c
> |  default_idle_call+0x40/0x60
> |  do_idle+0x23c/0x2d0
> |  cpu_startup_entry+0x38/0x3c
> |  kernel_init+0x0/0x1d8
> |  start_kernel+0x51c/0x608
> |  __primary_switched+0x80/0x88
> | CPU: 1 PID: 128 Comm: sh Not tainted 6.9.0-rc4-00001-gfdfd281212ec #1
> | Hardware name: linux,dummy-virt (DT)
> | Call trace:
> |  dump_backtrace+0x90/0xe8
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0xac/0xe8
> |  dump_stack+0x18/0x24
> |  csd_lock_wait_toolong+0x268/0x338
> |  smp_call_function_single+0x1dc/0x2f0
> |  lkdtm_SMP_CALL_LOCKUP+0xcc/0xfc
> |  lkdtm_do_action+0x1c/0x38
> |  direct_entry+0xbc/0x14c
> |  full_proxy_write+0x60/0xb4
> |  vfs_write+0xd0/0x35c
> |  ksys_write+0x70/0x104
> |  __arm64_sys_write+0x1c/0x28
> |  invoke_syscall+0x48/0x114
> |  el0_svc_common.constprop.0+0x40/0xe0
> |  do_el0_svc+0x1c/0x28
> |  el0_svc+0x38/0x108
> |  el0t_64_sync_handler+0x120/0x12c
> |  el0t_64_sync+0x1a4/0x1a8
> | smp: csd: Continued non-responsive CSD lock (#1) on CPU#1, waiting 10000064272 ns for CPU#00 __lkdtm_SMP_CALL_LOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> | smp: csd: Continued non-responsive CSD lock (#1) on CPU#1, waiting 15000064384 ns for CPU#00 __lkdtm_SMP_CALL_LOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/lkdtm/bugs.c               | 30 +++++++++++++++++++++++++
>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>  2 files changed, 31 insertions(+)
> 
> Since v1 [1]:
> * Rename option CSDLOCKUP -> SMP_CALL_LOCKUP
> * Add entry to tests.txt
> * Fix typo in commit message
> * Add Paul's Acked-by tag
> 
> [1] https://lore.kernel.org/lkml/20240419103452.3530155-1-mark.rutland@arm.com/
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 5178c02b21eba..62ba015254797 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -286,6 +286,35 @@ static void lkdtm_HARDLOCKUP(void)
>  		cpu_relax();
>  }
>  
> +static void __lkdtm_SMP_CALL_LOCKUP(void *unused)
> +{
> +	for (;;)
> +		cpu_relax();
> +}
> +
> +static void lkdtm_SMP_CALL_LOCKUP(void)
> +{
> +	unsigned int cpu, target;
> +
> +	cpus_read_lock();
> +
> +	cpu = get_cpu();
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +
> +	if (target >= nr_cpu_ids) {
> +		pr_err("FAIL: no other online CPUs\n");
> +		goto out_put_cpus;
> +	}
> +
> +	smp_call_function_single(target, __lkdtm_SMP_CALL_LOCKUP, NULL, 1);
> +
> +	pr_err("FAIL: did not hang\n");
> +
> +out_put_cpus:
> +	put_cpu();
> +	cpus_read_unlock();
> +}
> +
>  static void lkdtm_SPINLOCKUP(void)
>  {
>  	/* Must be called twice to trigger. */
> @@ -680,6 +709,7 @@ static struct crashtype crashtypes[] = {
>  	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
>  	CRASHTYPE(SOFTLOCKUP),
>  	CRASHTYPE(HARDLOCKUP),
> +	CRASHTYPE(SMP_CALL_LOCKUP),
>  	CRASHTYPE(SPINLOCKUP),
>  	CRASHTYPE(HUNG_TASK),
>  	CRASHTYPE(OVERFLOW_SIGNED),
> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> index 368973f05250f..cff124c1eddd3 100644
> --- a/tools/testing/selftests/lkdtm/tests.txt
> +++ b/tools/testing/selftests/lkdtm/tests.txt
> @@ -31,6 +31,7 @@ SLAB_FREE_CROSS
>  SLAB_FREE_PAGE
>  #SOFTLOCKUP Hangs the system
>  #HARDLOCKUP Hangs the system
> +#SMP_CALL_LOCKUP Hangs the system
>  #SPINLOCKUP Hangs the system
>  #HUNG_TASK Hangs the system
>  EXEC_DATA
> -- 
> 2.30.2
> 

