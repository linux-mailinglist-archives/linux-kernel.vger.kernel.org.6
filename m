Return-Path: <linux-kernel+bounces-262484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E393C792
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F98282C01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE619DF52;
	Thu, 25 Jul 2024 17:14:04 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AC19B3F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927643; cv=none; b=o1F1RMzPxA7DRcAFEFhsQ1SX5zV7Fh5vqcP5OTmAkx5gkwAI17f7b4ionwKL/XXI+YTWaUvIoSiP82tuaUSp2Z0eRuzBMV8HJUti3vXtB7pReh+L6/MhhIL2jSSeoYLV7rCUxIMjceMl6i533vTEkzkPWnIdJweXd48w9JrGc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927643; c=relaxed/simple;
	bh=r2UstB2lT7/5mtxg6sfqC1WKYleOGJHrehMaBtEimP8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nq5FCL74nV+T6XtjkF991mKmsIz+60GjMrZEHYM2RjruQEYv2oXJgPKAPBzzEO+dWKGcFx0tDJHTh+0TC02BAc4XncDchK0T2ZEhmwlkv3YVegDoGxaBmXPE8dSaJbf0kBCMIezVa9Mlu83oOSZZpFjKqvZvB1DK1wffAxNyU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVHVB3DpBz6K8yv;
	Fri, 26 Jul 2024 01:11:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AA9C6140B2F;
	Fri, 26 Jul 2024 01:13:56 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 18:13:56 +0100
Date: Thu, 25 Jul 2024 18:13:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, <linuxarm@huawei.com>
CC: <rafael.j.wysocki@intel.com>, <guohanjun@huawei.com>, <gshan@redhat.com>,
	<miguel.luis@oracle.com>, <catalin.marinas@arm.com>, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, "Linux regressions mailing list"
	<regressions@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Bowman, Terry" <Terry.bowman@amd.com>
Subject: Re: 6.11/regression/bisected - The commit c1385c1f0ba3 caused a new
 possible recursive locking detected warning at computer boot.
Message-ID: <20240725181354.000040bf@huawei.com>
In-Reply-To: <20240723181728.000026b3@huawei.com>
References: <CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com>
	<20240723112456.000053b3@Huawei.com>
	<20240723181728.000026b3@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Jul 2024 18:20:06 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 23 Jul 2024 11:24:56 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>=20
> > On Tue, 23 Jul 2024 00:36:18 +0500
> > Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:
> >  =20
> > > Hi,
> > > The first Fedora update to the 6.11 kernel
> > > (kernel-debug-6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64)
> > > brings a new warning: possible recursive locking detected.   =20
> >=20
> > Hi Mikhail,
> >=20
> > Thanks for the report.
> >=20
> > This is an interesting corner and perhaps reflects a flawed
> > assumption we were making that for this path anything that can happen f=
or an
> > initially present CPU can also happen for a hotplugged one. On the hotp=
lugged
> > path the lock was always held and hence the static_key_enable() would
> > have failed.
> >=20
> > I'm somewhat stumped on working out why this path couldn't happen
> > for a hotplugged CPU so why this is a new problem?
> >=20
> > Maybe this is just a case of no one is providing _CPC for CPUs in virtu=
al
> > machines so the path wasn't seen? QEMU doesn't generate ACPI tables with
> > _CPC today, so maybe that's it.
> >=20
> > So maybe this is has revealed an existing latent  bug.  There have been
> > QEMU patches for _CPC in the past but never merged. I'll hack them
> > into an x86 virtual machine and see if we hit the same bug you have
> > here before and after the series.
> >=20
> > Either way obviously we need to fix it for the current kernel (and maybe
> > backport the fix if I can verify it's a latent bug).  I'll get a test
> > setup running asap and see if I can replicate.
> >=20
> > +CC x86 maintainers. =20
>=20
> It will take me a little longer to emulate a suitable setup to hit the
> AMD case on (I have it run on arm64 now, but no similar issue occurs)
>=20
> Ultimately the problem is occurring in arch_init_invariance_cppc
> I note that the arm64 version of that topology_init_cpu_capacity_cppc
> delays some activity via a work queue specifically to avoid some
> locking issues.
>=20
> On AMD systems arch_init_invariance_cppc is defined
> as init_freq_invariance_cppc which calls amd_set_max_freq_ratio just
> once (there is a static bool) which in turn calls
> freq_invariance_set_perf_ratio() / freq_invariance_enable()
>=20
> Until I have a setup to test on I'm not going to draw firm conclusions
> but how much would it matter if we set that static key a bit late
> via a workqueue?  In the meantime go with a default value similar to
> that disable_freq_invariance_work sets (which is done via a workqueue).
>=20
> The intel equivalent is called via an early_init() so not
> the hotplug path.
>=20
> Any hints on from people familiar with this code would be most
> welcome.  Whilst git suggests tglx touched these paths most recently that
> was in tidying them up to split the Intel and AMD paths.
>=20

Hi Mikhail.

So the short story, ignoring the journey (which should only be described
with beer in hand), is that I now have an emulated test setup in QEMU
that fakes enough of the previously missing bits to bring up this path
and can trigger the splat you shared.  With the below fix I can get to
something approaching a running system.

However, without more work the emulation isn't actually doing any control
of frequency etc so I have no idea if the code actually works after this
patch.

If you are in a position to test a patch, could you try the following?

One bit I need to check out tomorrow is to make sure this doesn't race with=
 the
workfn that is used to tear down the same static key on error.

=46rom 8f7ad4c73954aae74265a3ec50a1d56e0c56050d Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 25 Jul 2024 17:56:00 +0100
Subject: [RFC PATCH] x86/aperfmperf: Push static_branch_enable(&arch_scale_=
freq_key) onto work queue

This to avoid a deadlock reported by lockdep.

TODO: Fix up this commit message before posting to actually give
some details and tags etc.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmp=
erf.c
index b3fa61d45352..41c729d3517c 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -300,15 +300,22 @@ static void register_freq_invariance_syscore_ops(void)
 static inline void register_freq_invariance_syscore_ops(void) {}
 #endif
=20
+static void enable_freq_invariance_workfn(struct work_struct *work)
+{
+	static_branch_enable(&arch_scale_freq_key);
+	register_freq_invariance_syscore_ops();
+	pr_info("Estimated ratio of average max frequency by base frequency (time=
s 1024): %llu\n", arch_max_freq_ratio);
+}
+static DECLARE_WORK(enable_freq_invariance_work,
+		    enable_freq_invariance_workfn);
+
 static void freq_invariance_enable(void)
 {
 	if (static_branch_unlikely(&arch_scale_freq_key)) {
 		WARN_ON_ONCE(1);
 		return;
 	}
-	static_branch_enable(&arch_scale_freq_key);
-	register_freq_invariance_syscore_ops();
-	pr_info("Estimated ratio of average max frequency by base frequency (time=
s 1024): %llu\n", arch_max_freq_ratio);
+	schedule_work(&enable_freq_invariance_work);
 }
=20
 void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled)
--=20
2.43.0


> Jonathan
>=20
>=20
>=20
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> >=20
> >=20
> >  =20
> > > The trace looks like:
> > > ACPI: button: Power Button [PWRF]
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > WARNING: possible recursive locking detected
> > > 6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64+debug #1 Not taint=
ed
> > > --------------------------------------------
> > > cpuhp/0/22 is trying to acquire lock:
> > > ffffffffb7f9cb40 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enabl=
e+0x12/0x20
> > >=20
> > > but task is already holding lock:
> > > ffffffffb7f9cb40 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun=
+0xcd/0x6f0
> > >=20
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >=20
> > >        CPU0
> > >        ----
> > >   lock(cpu_hotplug_lock);
> > >   lock(cpu_hotplug_lock);
> > >=20
> > >  *** DEADLOCK ***
> > >=20
> > >  May be due to missing lock nesting notation
> > >=20
> > > 3 locks held by cpuhp/0/22:
> > >  #0: ffffffffb7f9cb40 (cpu_hotplug_lock){++++}-{0:0}, at:
> > > cpuhp_thread_fun+0xcd/0x6f0
> > >  #1: ffffffffb7f9f2e0 (cpuhp_state-up){+.+.}-{0:0}, at:
> > > cpuhp_thread_fun+0xcd/0x6f0
> > >  #2: ffffffffb7f1d650 (freq_invariance_lock){+.+.}-{3:3}, at:
> > > init_freq_invariance_cppc+0xf4/0x1e0
> > >=20
> > > stack backtrace:
> > > CPU: 0 PID: 22 Comm: cpuhp/0 Not tainted
> > > 6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64+debug #1
> > > Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
> > > BIOS 2611 04/07/2024
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x84/0xd0
> > >  __lock_acquire+0x27e3/0x5c70
> > >  ? __pfx___lock_acquire+0x10/0x10
> > >  ? cppc_get_perf_caps+0x64f/0xf60
> > >  lock_acquire+0x1ae/0x540
> > >  ? static_key_enable+0x12/0x20
> > >  ? __pfx_lock_acquire+0x10/0x10
> > >  ? __pfx___might_resched+0x10/0x10
> > >  cpus_read_lock+0x40/0xe0
> > >  ? static_key_enable+0x12/0x20
> > >  static_key_enable+0x12/0x20
> > >  freq_invariance_enable+0x13/0x40
> > >  init_freq_invariance_cppc+0x17e/0x1e0
> > >  ? __pfx_init_freq_invariance_cppc+0x10/0x10
> > >  ? acpi_cppc_processor_probe+0x1046/0x2300
> > >  acpi_cppc_processor_probe+0x11ae/0x2300
> > >  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> > >  ? __pfx_acpi_cppc_processor_probe+0x10/0x10
> > >  ? __pfx_acpi_scan_drop_device+0x10/0x10
> > >  ? acpi_fetch_acpi_dev+0x79/0xe0
> > >  ? __pfx_acpi_fetch_acpi_dev+0x10/0x10
> > >  ? __pfx_acpi_soft_cpu_online+0x10/0x10
> > >  acpi_soft_cpu_online+0x114/0x330
> > >  cpuhp_invoke_callback+0x2c7/0xa40
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? __pfx_lock_release+0x10/0x10
> > >  ? cpuhp_thread_fun+0xcd/0x6f0
> > >  cpuhp_thread_fun+0x33a/0x6f0
> > >  ? smpboot_thread_fn+0x56/0x930
> > >  smpboot_thread_fn+0x54b/0x930
> > >  ? __pfx_smpboot_thread_fn+0x10/0x10
> > >  ? __pfx_smpboot_thread_fn+0x10/0x10
> > >  kthread+0x2d2/0x3a0
> > >  ? _raw_spin_unlock_irq+0x28/0x60
> > >  ? __pfx_kthread+0x10/0x10
> > >  ret_from_fork+0x31/0x70
> > >  ? __pfx_kthread+0x10/0x10
> > >  ret_from_fork_asm+0x1a/0x30
> > >  </TASK>
> > >=20
> > > Bisect is pointed to commit
> > > commit c1385c1f0ba3b80bd12f26c440612175088c664c (HEAD)
> > > Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Date:   Wed May 29 14:34:28 2024 +0100
> > >=20
> > >     ACPI: processor: Simplify initial onlining to use same path for
> > > cold and hotplug
> > >=20
> > >     Separate code paths, combined with a flag set in acpi_processor.c=
 to
> > >     indicate a struct acpi_processor was for a hotplugged CPU ensured=
 that
> > >     per CPU data was only set up the first time that a CPU was initia=
lized.
> > >     This appears to be unnecessary as the paths can be combined by le=
tting
> > >     the online logic also handle any CPUs online at the time of drive=
r load.
> > >=20
> > >     Motivation for this change, beyond simplification, is that ARM64
> > >     virtual CPU HP uses the same code paths for hotplug and cold path=
 in
> > >     acpi_processor.c so had no easy way to set the flag for hotplug o=
nly.
> > >     Removing this necessity will enable ARM64 vCPU HP to reuse the ex=
isting
> > >     code paths.
> > >=20
> > >     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >     Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> > >     Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > >     Reviewed-by: Gavin Shan <gshan@redhat.com>
> > >     Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
> > >     Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >     Link: https://lore.kernel.org/r/20240529133446.28446-2-Jonathan.C=
ameron@huawei.com
> > >     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > >=20
> > >  drivers/acpi/acpi_processor.c   |  7 +++----
> > >  drivers/acpi/processor_driver.c | 43
> > > ++++++++++++-------------------------------
> > >  include/acpi/processor.h        |  2 +-
> > >  3 files changed, 16 insertions(+), 36 deletions(-)
> > >=20
> > > And I can confirm that after reverting c1385c1f0ba3 the issue is gone.
> > >=20
> > > I also attach here a full kernel log and build config.
> > >=20
> > > My hardware specs: https://linux-hardware.org/?probe=3Dc6de14f5b8
> > >=20
> > > Jonathan, can you look into this, please?
> > >    =20
> >  =20
>=20


