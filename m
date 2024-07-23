Return-Path: <linux-kernel+bounces-260240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB9093A4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA207283DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46DF158219;
	Tue, 23 Jul 2024 17:20:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC63157A74
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755219; cv=none; b=MLjfbfxLygtiRwxgpdak1N5pndqag4MZK2w5fDyhwqOLcPoZY/8PxhtKWRjqw3ShMvNlBv8q0Xp3E3ZDNuUVpC09CTMWrQ12Pv8HaRf/kl/6u5KCzS0wJn0p3x9gzxIDI5YGHnd8jz5a7cxUqFf0vYKEKOHY+MQhdkrPUVoI3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755219; c=relaxed/simple;
	bh=ALzOvwDcXyrngBuUTiANEYPBoeafYpBhWEfp4sHbrfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjZnNml/PVgkEsbV3V68+XuBKaLVHu7TKOLjrQZ8OPy6ttpHDh5X48VaO8uDri9a9mJ1W6mmsGaGBpg/dAUSWqHIgTtdtMGgxy44fuWCR7zSfJafcUE2ILZTWSsPx46tKpyb0CZmbas8kS6pyoexSVVum6DdkPcirQwv82AWNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WT3kc6v7Wz6K6ps;
	Wed, 24 Jul 2024 01:18:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 48D48140518;
	Wed, 24 Jul 2024 01:20:08 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 23 Jul
 2024 18:20:07 +0100
Date: Tue, 23 Jul 2024 18:20:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, <linuxarm@huawei.com>
CC: <rafael.j.wysocki@intel.com>, <guohanjun@huawei.com>, <gshan@redhat.com>,
	<miguel.luis@oracle.com>, <catalin.marinas@arm.com>, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, "Linux regressions mailing list"
	<regressions@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
Subject: Re: 6.11/regression/bisected - The commit c1385c1f0ba3 caused a new
 possible recursive locking detected warning at computer boot.
Message-ID: <20240723181728.000026b3@huawei.com>
In-Reply-To: <20240723112456.000053b3@Huawei.com>
References: <CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com>
	<20240723112456.000053b3@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Jul 2024 11:24:56 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 23 Jul 2024 00:36:18 +0500
> Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:
> 
> > Hi,
> > The first Fedora update to the 6.11 kernel
> > (kernel-debug-6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64)
> > brings a new warning: possible recursive locking detected.  
> 
> Hi Mikhail,
> 
> Thanks for the report.
> 
> This is an interesting corner and perhaps reflects a flawed
> assumption we were making that for this path anything that can happen for an
> initially present CPU can also happen for a hotplugged one. On the hotplugged
> path the lock was always held and hence the static_key_enable() would
> have failed.
> 
> I'm somewhat stumped on working out why this path couldn't happen
> for a hotplugged CPU so why this is a new problem?
> 
> Maybe this is just a case of no one is providing _CPC for CPUs in virtual
> machines so the path wasn't seen? QEMU doesn't generate ACPI tables with
> _CPC today, so maybe that's it.
> 
> So maybe this is has revealed an existing latent  bug.  There have been
> QEMU patches for _CPC in the past but never merged. I'll hack them
> into an x86 virtual machine and see if we hit the same bug you have
> here before and after the series.
> 
> Either way obviously we need to fix it for the current kernel (and maybe
> backport the fix if I can verify it's a latent bug).  I'll get a test
> setup running asap and see if I can replicate.
> 
> +CC x86 maintainers.

It will take me a little longer to emulate a suitable setup to hit the
AMD case on (I have it run on arm64 now, but no similar issue occurs)

Ultimately the problem is occurring in arch_init_invariance_cppc
I note that the arm64 version of that topology_init_cpu_capacity_cppc
delays some activity via a work queue specifically to avoid some
locking issues.

On AMD systems arch_init_invariance_cppc is defined
as init_freq_invariance_cppc which calls amd_set_max_freq_ratio just
once (there is a static bool) which in turn calls
freq_invariance_set_perf_ratio() / freq_invariance_enable()

Until I have a setup to test on I'm not going to draw firm conclusions
but how much would it matter if we set that static key a bit late
via a workqueue?  In the meantime go with a default value similar to
that disable_freq_invariance_work sets (which is done via a workqueue).

The intel equivalent is called via an early_init() so not
the hotplug path.

Any hints on from people familiar with this code would be most
welcome.  Whilst git suggests tglx touched these paths most recently that
was in tidying them up to split the Intel and AMD paths.

Jonathan



> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> 
> > The trace looks like:
> > ACPI: button: Power Button [PWRF]
> > 
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64+debug #1 Not tainted
> > --------------------------------------------
> > cpuhp/0/22 is trying to acquire lock:
> > ffffffffb7f9cb40 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x12/0x20
> > 
> > but task is already holding lock:
> > ffffffffb7f9cb40 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0xcd/0x6f0
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(cpu_hotplug_lock);
> >   lock(cpu_hotplug_lock);
> > 
> >  *** DEADLOCK ***
> > 
> >  May be due to missing lock nesting notation
> > 
> > 3 locks held by cpuhp/0/22:
> >  #0: ffffffffb7f9cb40 (cpu_hotplug_lock){++++}-{0:0}, at:
> > cpuhp_thread_fun+0xcd/0x6f0
> >  #1: ffffffffb7f9f2e0 (cpuhp_state-up){+.+.}-{0:0}, at:
> > cpuhp_thread_fun+0xcd/0x6f0
> >  #2: ffffffffb7f1d650 (freq_invariance_lock){+.+.}-{3:3}, at:
> > init_freq_invariance_cppc+0xf4/0x1e0
> > 
> > stack backtrace:
> > CPU: 0 PID: 22 Comm: cpuhp/0 Not tainted
> > 6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64+debug #1
> > Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
> > BIOS 2611 04/07/2024
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x84/0xd0
> >  __lock_acquire+0x27e3/0x5c70
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? cppc_get_perf_caps+0x64f/0xf60
> >  lock_acquire+0x1ae/0x540
> >  ? static_key_enable+0x12/0x20
> >  ? __pfx_lock_acquire+0x10/0x10
> >  ? __pfx___might_resched+0x10/0x10
> >  cpus_read_lock+0x40/0xe0
> >  ? static_key_enable+0x12/0x20
> >  static_key_enable+0x12/0x20
> >  freq_invariance_enable+0x13/0x40
> >  init_freq_invariance_cppc+0x17e/0x1e0
> >  ? __pfx_init_freq_invariance_cppc+0x10/0x10
> >  ? acpi_cppc_processor_probe+0x1046/0x2300
> >  acpi_cppc_processor_probe+0x11ae/0x2300
> >  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> >  ? __pfx_acpi_cppc_processor_probe+0x10/0x10
> >  ? __pfx_acpi_scan_drop_device+0x10/0x10
> >  ? acpi_fetch_acpi_dev+0x79/0xe0
> >  ? __pfx_acpi_fetch_acpi_dev+0x10/0x10
> >  ? __pfx_acpi_soft_cpu_online+0x10/0x10
> >  acpi_soft_cpu_online+0x114/0x330
> >  cpuhp_invoke_callback+0x2c7/0xa40
> >  ? __pfx_lock_release+0x10/0x10
> >  ? __pfx_lock_release+0x10/0x10
> >  ? cpuhp_thread_fun+0xcd/0x6f0
> >  cpuhp_thread_fun+0x33a/0x6f0
> >  ? smpboot_thread_fn+0x56/0x930
> >  smpboot_thread_fn+0x54b/0x930
> >  ? __pfx_smpboot_thread_fn+0x10/0x10
> >  ? __pfx_smpboot_thread_fn+0x10/0x10
> >  kthread+0x2d2/0x3a0
> >  ? _raw_spin_unlock_irq+0x28/0x60
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork+0x31/0x70
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > Bisect is pointed to commit
> > commit c1385c1f0ba3b80bd12f26c440612175088c664c (HEAD)
> > Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Date:   Wed May 29 14:34:28 2024 +0100
> > 
> >     ACPI: processor: Simplify initial onlining to use same path for
> > cold and hotplug
> > 
> >     Separate code paths, combined with a flag set in acpi_processor.c to
> >     indicate a struct acpi_processor was for a hotplugged CPU ensured that
> >     per CPU data was only set up the first time that a CPU was initialized.
> >     This appears to be unnecessary as the paths can be combined by letting
> >     the online logic also handle any CPUs online at the time of driver load.
> > 
> >     Motivation for this change, beyond simplification, is that ARM64
> >     virtual CPU HP uses the same code paths for hotplug and cold path in
> >     acpi_processor.c so had no easy way to set the flag for hotplug only.
> >     Removing this necessity will enable ARM64 vCPU HP to reuse the existing
> >     code paths.
> > 
> >     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> >     Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >     Reviewed-by: Gavin Shan <gshan@redhat.com>
> >     Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
> >     Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >     Link: https://lore.kernel.org/r/20240529133446.28446-2-Jonathan.Cameron@huawei.com
> >     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> >  drivers/acpi/acpi_processor.c   |  7 +++----
> >  drivers/acpi/processor_driver.c | 43
> > ++++++++++++-------------------------------
> >  include/acpi/processor.h        |  2 +-
> >  3 files changed, 16 insertions(+), 36 deletions(-)
> > 
> > And I can confirm that after reverting c1385c1f0ba3 the issue is gone.
> > 
> > I also attach here a full kernel log and build config.
> > 
> > My hardware specs: https://linux-hardware.org/?probe=c6de14f5b8
> > 
> > Jonathan, can you look into this, please?
> >   
> 


