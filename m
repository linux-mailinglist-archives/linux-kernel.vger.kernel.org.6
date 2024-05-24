Return-Path: <linux-kernel+bounces-188589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AC8CE3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9651C21981
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC884A54;
	Fri, 24 May 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/YqjomP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6884E09
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544973; cv=none; b=QzE9VLHH2xNGW2EFHOejjILGplyco3mcEyzpDMDiP5ApIqMUY5DSEydfIrep+W85Do+mKNzd/V6UYPEzeyI9B9sBWPBwg1xwGO2PiAIbjHahZuLXitNXRH+Bn9kh9YhkrV6VhEDw+NC7E4zxzFCsA3mHzDGZ52ylGaKhkAzwZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544973; c=relaxed/simple;
	bh=VUu5Pay3EO3zPdwqRprm8VMWydnN34K4Iz8Y0oqkzmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiX2aWieJO6QZPRgv/RRECcQ4p81DhwGubSVc6iO5T1IpNzhvLTWAQGk21ge5aPkuIPadmsmVDIi70cdges9tnmPDIttvroxsw59ULGpZZFN/XcpXIApS9SdXiFr1hoyoObkFEHHBQde/ul79dtsA0lwupIRD8xZkPb/PLv7IqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/YqjomP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716544970; x=1748080970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VUu5Pay3EO3zPdwqRprm8VMWydnN34K4Iz8Y0oqkzmk=;
  b=P/YqjomPTL6Rr4gHUe4lvKp4OTCa+THG3D+i5lmqACmAzSi8UkmSQbl4
   ehZFUXpAZOiytTnZ2Eh7XJrWOK7I5N35WWfPVn3bQvp+mO9Bvnfu3TW9g
   DhLi1KgWvZQfJVxow/jgx16LfmB82IUoxBEEKqf+9AivbpzzpHTDLt1s6
   /QShxeiEtMvpwvoH7N9AVm02vdp+YWiEa4qKcI8TmOuerkW6rLgN70ugP
   d2Lgpat98/rYNRnK5/fRyXf16qSROFId+MGxXgeS933vry0DFPFTC4TMy
   4vmEznJOYHtGgry/OFnK7XZH2TlMfZDqRFzej8veRyyqu8c0pD8kjI3D3
   Q==;
X-CSE-ConnectionGUID: vjIWjvRkRmmb4JMt0rgf5A==
X-CSE-MsgGUID: 6UgexX2NTH+wVicYRN+Hiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23523255"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="23523255"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 03:02:50 -0700
X-CSE-ConnectionGUID: 9aLuoKRSQAGD6ECmK24pqA==
X-CSE-MsgGUID: Syj9UzUwTkGRyAopLCNsMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="38769660"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 03:02:48 -0700
Message-ID: <85229f77-e5d1-498f-900a-e10b4de5f358@intel.com>
Date: Fri, 24 May 2024 13:02:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [timekeeping] e84f43e34f:
 BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <202405241607.d3fd7eb0-lkp@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202405241607.d3fd7eb0-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/24 11:36, kernel test robot wrote:
> 
> hi Adrian Hunter,
> 
> we sent the similar report
>   "[tip:timers/core] [timekeeping]  e84f43e34f: BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns"
> when this commit is in tip:timers/core [1]
> 
> we noticed you made some comments, but we don't have enough knowledge it there
> will be or need some fix.

AFAICT, it is a false positive.

KCSAN requires annotation to know where a seqlock critical section
is.  This annotation does not work if a seqlock is nested within
another seqlock because KCSAN considers that the critical section
finishes after the inner seqlock.

Marco Elver was cc'ed because they introduced the annotations:

	commit 88ecd153be9519f259b87a9f6f4c8383a8b3bbf1
	Author: Marco Elver <elver@google.com>
	Date:   Thu Nov 14 19:02:59 2019 +0100

	    seqlock, kcsan: Add annotations for KCSAN

But neither they nor Dmitry Vyukov <dvyukov@google.com> nor anyone
on the kasan-dev@googlegroups.com, seem to have taken an interest.

They should be the ones to know best how to fix the annotation.

Would you be willing to follow this up?  Perhaps reply to

	https://lore.kernel.org/all/cb8ae96c-12a6-4945-96ed-7f68f01d69aa@intel.com/

and ask explicitly if they can help.

> 
> now the commit is in mainline now, we just report again FYI.
> 
> similar as mentioned in [1], we only observed the
>   dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
> upon e84f43e34f at the ~50% rate.
> 
> but parent has other KCSAN issues (also ~50% rate) which doesn't happen on
> e84f43e34f.
> 
> e8e9d21a5df655a6 e84f43e34faf85816587f805945
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           9:20         -45%            :20    dmesg.BUG:KCSAN:data-race_in_ktime_get/timekeeping_advance
>           9:20         -45%            :20    dmesg.BUG:KCSAN:data-race_in_ktime_get_update_offsets_now/timekeeping_advance
>            :20          55%          11:20    dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
> 
> 
> [1] https://lore.kernel.org/all/202404161050.38f1c92e-lkp@intel.com/
> 
> 
> below is the full report.
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns" on:
> 
> commit: e84f43e34faf85816587f80594541ec978449d6e ("timekeeping: Consolidate timekeeping helpers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      0450d2083be6bdcd18c9535ac50c55266499b2df]
> [test failed on linux-next/master c75962170e49f24399141276ae119e6a879f36dc]
> 
> in testcase: boot
> 
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405241607.d3fd7eb0-lkp@intel.com
> 
> 
> [  106.344081][    C0] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
> [  106.345565][    C0]
> [  106.346110][    C0] write to 0xffffffff83dfe578 of 296 bytes by interrupt on cpu 1:
> [ 106.347495][ C0] timekeeping_advance (kernel/time/timekeeping.c:2207 (discriminator 1)) 
> [ 106.348455][ C0] update_wall_time (kernel/time/timekeeping.c:2222 (discriminator 1)) 
> [ 106.349310][ C0] tick_do_update_jiffies64 (kernel/time/tick-sched.c:149) 
> [ 106.350321][ C0] tick_nohz_lowres_handler (kernel/time/tick-sched.c:229 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
> [ 106.351343][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
> [ 106.352397][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
> [ 106.353427][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [ 106.354479][ C0] _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:94 (discriminator 1) include/linux/spinlock_api_smp.h:152 (discriminator 1) kernel/locking/spinlock.c:194 (discriminator 1)) 
> [ 106.355503][ C0] get_partial_node+0xaf/0x300 
> [ 106.356480][ C0] get_partial (mm/slub.c:2702) 
> [ 106.357291][ C0] ___slab_alloc (mm/slub.c:3506) 
> [ 106.358162][ C0] kmem_cache_alloc (mm/slub.c:3610 mm/slub.c:3663 mm/slub.c:3835 mm/slub.c:3852) 
> [ 106.359084][ C0] getname_flags (fs/namei.c:140 (discriminator 1)) 
> [ 106.359916][ C0] getname (fs/namei.c:219) 
> [ 106.360669][ C0] do_sys_openat2 (fs/open.c:1400) 
> [ 106.361540][ C0] __ia32_compat_sys_openat (fs/open.c:1479) 
> [ 106.362526][ C0] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
> [ 106.363487][ C0] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
> [ 106.364392][ C0] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
> [ 106.365229][ C0] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
> [  106.366347][    C0]
> [  106.366895][    C0] read to 0xffffffff83dfe598 of 8 bytes by interrupt on cpu 0:
> [ 106.368257][ C0] timekeeping_debug_get_ns (kernel/time/timekeeping.c:373 kernel/time/timekeeping.c:383 kernel/time/timekeeping.c:280) 
> [ 106.369256][ C0] ktime_get (kernel/time/timekeeping.c:394 kernel/time/timekeeping.c:838) 
> [ 106.370061][ C0] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
> [ 106.371062][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
> [ 106.372099][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
> [ 106.373091][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [ 106.374155][ C0] __tsan_read8 (kernel/kcsan/core.c:787 (discriminator 1) kernel/kcsan/core.c:1025 (discriminator 1)) 
> [ 106.375033][ C0] __d_lookup_rcu (fs/dcache.c:2172) 
> [ 106.375897][ C0] d_alloc_parallel (fs/dcache.c:2473) 
> [ 106.376807][ C0] lookup_open+0x5f1/0x8a0 
> [ 106.377759][ C0] open_last_lookups (fs/namei.c:3566) 
> [ 106.378687][ C0] path_openat (fs/namei.c:3796) 
> [ 106.379520][ C0] do_filp_open (fs/namei.c:3826) 
> [ 106.380375][ C0] do_sys_openat2 (fs/open.c:1406) 
> [ 106.381236][ C0] __ia32_compat_sys_openat (fs/open.c:1479) 
> [ 106.382243][ C0] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
> [ 106.388006][ C0] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
> [ 106.388925][ C0] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
> [ 106.389787][ C0] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
> [  106.391298][    C0]
> [  106.392364][    C0] value changed: 0x0014811664800000 -> 0x00149f9ae4800000
> [  106.394806][    C0]
> [  106.396026][    C0] Reported by Kernel Concurrency Sanitizer on:
> [  106.398293][    C0] CPU: 0 PID: 126 Comm: (mount) Tainted: G            E    N 6.9.0-rc3-00015-ge84f43e34faf #1
> [  106.401465][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  106.404332][    C0] ==================================================================
> Mounting Kernel Configuration File System...
> Starting Load/Save Random Seed...
> Starting Apply Kernel Variables...
> Starting Create System Users...
> [  OK  ] Started Journal Service.
> [  OK  ] Mounted FUSE Control File System.
> [  OK  ] Mounted Kernel Configuration File System.
> [  OK  ] Finished Load/Save Random Seed.
> [  OK  ] Finished Apply Kernel Variables.
> Starting Flush Journal to Persistent Storage...
> [  OK  ] Finished Create System Users.
> Starting Create Static Device Nodes in /dev...
> [  OK  ] Finished Flush Journal to Persistent Storage.
> [  OK  ] Finished Create Static Device Nodes in /dev.
> [  OK  ] Reached target Local File Systems (Pre).
> [  OK  ] Reached target Local File Systems.
> Starting Preprocess NFS configuration...
> Starting Create Volatile Files and Directories...
> [  OK  ] Finished Preprocess NFS configuration.
> [  OK  ] Started Rule-based Manager for Device Events and Files.
> [  OK  ] Finished Create Volatile Files and Directories.
> Starting RPC bind portmap service...
> Starting Update UTMP about System Boot/Shutdown...
> [  OK  ] Started RPC bind portmap service.
> [  OK  ] Finished Update UTMP about System Boot/Shutdown.
> [  OK  ] Reached target Remote File Systems (Pre).
> [  OK  ] Reached target Remote File Systems.
> [  OK  ] Reached target RPC Port Mapper.
> [*     ] A start job is running for Coldplug All udev Devices (6s / no limit)
> [  113.764048][  T153] parport_pc 00:03: reported by Plug and Play ACPI
> [  113.776436][  T153] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
> [  113.952514][  T139] Linux agpgart interface v0.103
> [  114.090513][    C1] ==================================================================
> [  114.091583][    C1] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
> [  114.092597][    C1]
> [  114.092970][    C1] write to 0xffffffff83dfe578 of 296 bytes by interrupt on cpu 0:
> [ 114.093933][ C1] timekeeping_advance (kernel/time/timekeeping.c:2207 (discriminator 1)) 
> [ 114.094583][ C1] update_wall_time (kernel/time/timekeeping.c:2222 (discriminator 1)) 
> [ 114.095166][ C1] tick_do_update_jiffies64 (kernel/time/tick-sched.c:149) 
> [ 114.095849][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:229 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
> [ 114.096537][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
> [ 114.097280][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
> [ 114.097994][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [ 114.098736][ C1] __orc_find (arch/x86/kernel/unwind_orc.c:100 (discriminator 3)) 
> [ 114.099285][ C1] unwind_next_frame (arch/x86/kernel/unwind_orc.c:494 (discriminator 4)) 
> [ 114.099925][ C1] arch_stack_walk (arch/x86/kernel/stacktrace.c:24 (discriminator 1)) 
> [ 114.100549][ C1] stack_trace_save (kernel/stacktrace.c:123) 
> [ 114.101154][ C1] set_track_prepare (mm/slub.c:886) 
> [ 114.101768][ C1] __alloc_object (mm/kmemleak.c:681 (discriminator 1)) 
> [ 114.102377][ C1] __create_object (mm/kmemleak.c:750) 
> [ 114.102967][ C1] __kmalloc_node (include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3965 mm/slub.c:3973) 
> [ 114.103566][ C1] kvmalloc_node (mm/util.c:662) 
> [ 114.104150][ C1] seq_read_iter (fs/seq_file.c:210 (discriminator 1)) 
> [ 114.104748][ C1] kernfs_fop_read_iter (fs/kernfs/file.c:281) 
> [ 114.105388][ C1] vfs_read (include/linux/fs.h:2104 fs/read_write.c:395 fs/read_write.c:476) 
> [ 114.105938][ C1] ksys_read (fs/read_write.c:619) 
> [ 114.106485][ C1] __ia32_sys_read (fs/read_write.c:627) 
> [ 114.107082][ C1] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
> [ 114.107729][ C1] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
> [ 114.108364][ C1] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
> [ 114.108943][ C1] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
> [  114.109697][    C1]
> [  114.110062][    C1] read to 0xffffffff83dfe588 of 8 bytes by interrupt on cpu 1:
> [ 114.110988][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping_internal.h:21 kernel/time/timekeeping.c:381 kernel/time/timekeeping.c:280) 
> [ 114.111685][ C1] ktime_get (kernel/time/timekeeping.c:394 kernel/time/timekeeping.c:838) 
> [ 114.112236][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
> [ 114.112924][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
> [ 114.113647][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
> [ 114.114332][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [ 114.115063][ C1] _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:94 (discriminator 1) include/linux/spinlock_api_smp.h:152 (discriminator 1) kernel/locking/spinlock.c:194 (discriminator 1)) 
> [ 114.115753][ C1] __create_object (mm/kmemleak.c:756) 
> [ 114.116355][ C1] kmem_cache_alloc (include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3852) 
> [ 114.116993][ C1] skb_clone (net/core/skbuff.c:2063) 
> [ 114.117535][ C1] do_one_broadcast (net/netlink/af_netlink.c:1466 (discriminator 1)) 
> [ 114.118170][ C1] netlink_broadcast_filtered (net/netlink/af_netlink.c:1543 (discriminator 11)) 
> [ 114.118883][ C1] netlink_broadcast (net/netlink/af_netlink.c:1568 (discriminator 1)) 
> [ 114.119493][ C1] kobject_uevent_net_broadcast (lib/kobject_uevent.c:331 (discriminator 1) lib/kobject_uevent.c:410 (discriminator 1)) 
> [ 114.120211][ C1] kobject_uevent_env (lib/kobject_uevent.c:593) 
> [ 114.120844][ C1] kobject_uevent (lib/kobject_uevent.c:642) 
> [ 114.121414][ C1] driver_register (drivers/base/driver.c:255) 
> [ 114.122024][ C1] __parport_register_driver (drivers/parport/share.c:289) parport
> [ 114.122833][ C1] ppdev_init (drivers/char/ppdev.c:811) ppdev
> [ 114.123470][ C1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1239) 
> [ 114.124079][ C1] do_init_module (kernel/module/main.c:2538) 
> [ 114.124700][ C1] load_module (kernel/module/main.c:3001) 
> [ 114.125281][ C1] init_module_from_file (kernel/module/main.c:3169) 
> [ 114.125945][ C1] idempotent_init_module (kernel/module/main.c:3185) 
> [ 114.126610][ C1] __ia32_sys_finit_module (include/linux/file.h:47 kernel/module/main.c:3207 kernel/module/main.c:3189 kernel/module/main.c:3189) 
> [ 114.127271][ C1] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
> [ 114.127912][ C1] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
> [ 114.128530][ C1] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
> [ 114.129117][ C1] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
> [  114.129880][    C1]
> [  114.130247][    C1] value changed: 0x0000001ac6927aaf -> 0x0000001ac6cf83af
> [  114.131074][    C1]
> [  114.131445][    C1] Reported by Kernel Concurrency Sanitizer on:
> [  114.132179][    C1] CPU: 1 PID: 144 Comm: systemd-udevd Tainted: G            E    N 6.9.0-rc3-00015-ge84f43e34faf #1
> [  114.133442][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  114.134654][    C1] ==================================================================
> [  114.141741][  T144] ppdev: user-space parallel port driver
> [  114.556211][  T153] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
> [  114.791100][   T95] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
> [  114.842626][  T139] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
> [  114.849602][  T139] Console: switching to colour dummy device 80x25
> [  114.934666][  T139] [drm] Found bochs VGA, ID 0xb0c5.
> [  114.934674][  T139] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
> [  115.023240][  T139] [drm] Found EDID data blob.
> [  115.104489][  T139] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 0
> [  115.223445][  T158] mousedev: PS/2 mouse device common for all mice
> [K[  OK  ] Reached target System Initialization.
> [  OK  ] Started Daily apt download activities.
> [  OK  ] Started Daily apt upgrade and clean activities.
> [  OK  ] Started Discard unused blocks once a week.
> [  OK  ] Started Daily rotation of log files.
> [  OK  ] Started Daily Cleanup of Temporary Directories.
> [  OK  ] Reached target Timers.
> [  OK  ] Listening on D-Bus System Message Bus Socket.
> [  OK  ] Reached target Sockets.
> [  OK  ] Reached target Basic System.
> [  OK  ] Started Regular background program processing daemon.
> [  OK  ] Started D-Bus System Message Bus.
> Starting Helper to synchronize boot up for ifupdown...
> Starting LSB: OpenIPMI Driver init script...
> Starting System Logging Service...
> Starting User Login Management...
> [  OK  ] Finished Helper to synchronize boot up for ifupdown.
> Starting Raise network interfaces...
> Starting LSB: Load kernel image with kexec...
> [  120.559025][  T225] IPMI message handler: version 39.2
> [  OK  ] Started LSB: Load kernel image with kexec.
> [  120.991196][  T239] ipmi_si: IPMI System Interface driver
> [  121.000344][  T239] ipmi_si: Unable to find any System Interface(s)
> [  OK  ] Finished Raise network interfaces.
> [  OK  ] Started User Login Management.
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240524/202405241607.d3fd7eb0-lkp@intel.com
> 
> 
> 


