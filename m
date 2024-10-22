Return-Path: <linux-kernel+bounces-375860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E09A9C04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CC51F22AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128515B11D;
	Tue, 22 Oct 2024 08:07:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E41514F6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584425; cv=none; b=WlZRkTP2VnWyAZBG/pxxegUdYsqo4JKe265/oUaE7/pnoIgYW0yxE1hugDk1YfSxSOgXLerkcTdA+moNC4KWxxZ/tS7pJwMpVczrxDLT2xstOTVLHu/vhPbvzj0XzV25THMTPy4qkicVkUtMIRVJtg6cFGZNFfSk8MMwHBAzHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584425; c=relaxed/simple;
	bh=sNyYjiOFpa7u/nFtAzcNS9/5z39H1LMRfpCFsDTfYj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BGosYzMbayPzdHSmorWWnqaUE+rhOWxEiAHo4w6yRM1dflgBDzyrLraeAxH5N0Xe/K3BiMFQNFEJ4G1C9F7GCK1x96EYxCJF4ZHNJu56Du4XMzDWEebSR/BoizqwnEGpLL1tl5oOvdVfcdu2orrhcnwLCKUCxo5nSO6LzMz5U7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8353599024bso508126939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729584422; x=1730189222;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG/sA7TvBWAOwGCGhENjc+e89W+D0a7X7+CKJvdF3HQ=;
        b=v6J4gXQPFvRnMvajFuy23JXpv43WP/5eXZgOORkDvsfK0k1I+vxqRdF17j5Hie0i8K
         bPgBuPHQ32hKh/5lCUiaL5K3ytaBgUt7lVQi4rGg5ODMpFJ0pN6n2bOzzsRMwJv8qPOA
         bDTTkNRHwbMBu7ZIVvGL3yEykg/upOA5pqQje2AUy//2IgAkkkOt6drDnkBpwY2QWkjy
         6cf4V/dMPnf+0ABDeESamfzrbRovi4a5aU0OE1UEaWoKOTyUVObfod2utbumaPfPhHXu
         Sk5uvgvFGKH8xaNcdDykieOEBLJn/qo21Mr5PvX278/4sfrDUMES8Jt0sk1My40QIb6w
         rRAw==
X-Forwarded-Encrypted: i=1; AJvYcCUp01MTG59n6ohYSg9PTJZU/OFVvhkIW7z5LkKhFuTAlHKRLq/9fEaduRBaBhrtMw7GARZNVBdJzGjygnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPssjC8fsXTnBFzlIpmGil/yIL0pNUDJBGwXEqmqJOwR6jnM3A
	wc8onyB20MVZlYhGhNZwPOGXZySEenay7czv3f6l7XXnqA6MivnHe0FsqbrhEbmQuwgYiTYMkdt
	68LrBUWdyjKsCfxjNS53/p4t7By5Ab8Cl34Sy8A7cZ7WZIz/0JD+SkNg=
X-Google-Smtp-Source: AGHT+IFTybLHtXoxF715xzI1Cfmb54Em21NV/fdt0m/XAQvFOxnNk/Ezh+LLw6rjzVdDM+wnbwK6vVZG3wN+mHgYHeUnci+Cg4Q7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f94:b0:835:45f9:c2ee with SMTP id
 ca18e2360f4ac-83aba5cca5amr1272408239f.4.1729584422272; Tue, 22 Oct 2024
 01:07:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 01:07:02 -0700
In-Reply-To: <tencent_85E3BD8449176BF76DA6DE736BA36E097705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67175d26.050a0220.1e4b4d.0072.GAE@google.com>
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
From: syzbot <syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

RAT 00000001 GOOG 00000001)
[    0.046496][    T0] ACPI: APIC 0x00000000BFFFFDB0 000076 (v05 Google GOO=
GAPIC 00000001 GOOG 00000001)
[    0.048654][    T0] ACPI: SSDT 0x00000000BFFFF430 000980 (v01 Google GOO=
GSSDT 00000001 GOOG 00000001)
[    0.051656][    T0] ACPI: WAET 0x00000000BFFFFE30 000028 (v01 Google GOO=
GWAET 00000001 GOOG 00000001)
[    0.053804][    T0] ACPI: Reserving FACP table memory at [mem 0xbffff330=
-0xbffff423]
[    0.055989][    T0] ACPI: Reserving DSDT table memory at [mem 0xbfffd8c0=
-0xbffff323]
[    0.057616][    T0] ACPI: Reserving FACS table memory at [mem 0xbfffd880=
-0xbfffd8bf]
[    0.058943][    T0] ACPI: Reserving FACS table memory at [mem 0xbfffd880=
-0xbfffd8bf]
[    0.060591][    T0] ACPI: Reserving SRAT table memory at [mem 0xbffffe60=
-0xbfffff27]
[    0.062145][    T0] ACPI: Reserving APIC table memory at [mem 0xbffffdb0=
-0xbffffe25]
[    0.064394][    T0] ACPI: Reserving SSDT table memory at [mem 0xbffff430=
-0xbffffdaf]
[    0.065814][    T0] ACPI: Reserving WAET table memory at [mem 0xbffffe30=
-0xbffffe57]
[    0.067863][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.070253][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.071420][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x23ffffff=
f]
[    0.073158][    T0] NUMA: Node 0 [mem 0x00001000-0x0009ffff] + [mem 0x00=
100000-0xbfffffff] -> [mem 0x00001000-0xbfffffff]
[    0.075325][    T0] NUMA: Node 0 [mem 0x00001000-0xbfffffff] + [mem 0x10=
0000000-0x23fffffff] -> [mem 0x00001000-0x23fffffff]
[    0.078325][    T0] NODE_DATA(0) allocated [mem 0x23fff9e00-0x23fffddff]
[    0.117884][    T0] Zone ranges:
[    0.118729][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.120123][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.121166][    T0]   Normal   [mem 0x0000000100000000-0x000000023ffffff=
f]
[    0.122385][    T0] Movable zone start for each node
[    0.123307][    T0] Early memory node ranges
[    0.124149][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]
[    0.125227][    T0]   node   0: [mem 0x0000000000100000-0x00000000bfffcf=
ff]
[    0.126650][    T0]   node   0: [mem 0x0000000100000000-0x000000023fffff=
ff]
[    0.128118][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0023fffffff]
[    0.130187][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.132026][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.272214][    T0] On node 0, zone Normal: 3 pages in unavailable range=
s
[    0.591782][    T0] kasan: KernelAddressSanitizer initialized
[    0.594155][    T0] ACPI: PM-Timer IO Port: 0xb008
[    0.595456][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.596918][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.598543][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.600551][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.602046][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.604180][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.606070][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.607926][    T0] CPU topo: Max. logical packages:   1
[    0.608974][    T0] CPU topo: Max. logical dies:       1
[    0.610008][    T0] CPU topo: Max. dies per package:   1
[    0.610933][    T0] CPU topo: Max. threads per core:   2
[    0.612361][    T0] CPU topo: Num. cores per package:     1
[    0.613460][    T0] CPU topo: Num. threads per package:   2
[    0.614535][    T0] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPU=
s
[    0.616471][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.618396][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x0009ffff]
[    0.620038][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
0a0000-0x000effff]
[    0.621426][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
0f0000-0x000fffff]
[    0.622954][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
ffd000-0xbfffffff]
[    0.624961][    T0] PM: hibernation: Registered nosave memory: [mem 0xc0=
000000-0xfffbbfff]
[    0.626150][    T0] PM: hibernation: Registered nosave memory: [mem 0xff=
fbc000-0xffffffff]
[    0.627592][    T0] [mem 0xc0000000-0xfffbbfff] available for PCI device=
s
[    0.629426][    T0] Booting paravirtualized kernel on KVM
[    0.630453][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.677816][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids=
:2 nr_node_ids:1
[    0.680682][    T0] percpu: Embedded 72 pages/cpu s258000 r8192 d28720 u=
1048576
[    0.682715][    T0] kvm-guest: PV spinlocks enabled
[    0.683539][    T0] PV qspinlock hash table entries: 256 (order: 0, 4096=
 bytes, linear)
[    0.685241][    T0] Kernel command line: earlyprintk=3Dserial net.ifname=
s=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-con=
ntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.p=
orts=3D20000 nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000=
 binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cp=
utime=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysct=
l.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_=
to_panic=3D1 msr.allow_writes=3Doff coredump_filter=3D0xffff root=3D/dev/sd=
a console=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 sp=
ec_store_bypass_disable=3Dprctl nopcid vivid.n_devs=3D16 vivid.multiplanar=
=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D16 rose.rose_ndevs=3D1=
6 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thr=
esh=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.nu=
m=3D8 panic_on_warn=3D1 BOOT_IMAGE=3D/boot/bzImage root=3D/dev/sda1 console=
=3DttyS0
[    0.706673][    T0] Unknown kernel command line parameters "ima_policy=
=3Dtcb spec_store_bypass_disable=3Dprctl BOOT_IMAGE=3D/boot/bzImage", will =
be passed to user space.
[    0.710164][    T0] random: crng init done
[    0.714069][    T0] Dentry cache hash table entries: 1048576 (order: 11,=
 8388608 bytes, linear)
[    0.717136][    T0] Inode-cache hash table entries: 524288 (order: 10, 4=
194304 bytes, linear)
[    0.719528][    T0] Fallback order for Node 0: 0=20
[    0.719568][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 2097051
[    0.721930][    T0] Policy zone: Normal
[    0.723098][    T0] mem auto-init: stack:all(zero), heap alloc:on, heap =
free:off
[    0.724900][    T0] stackdepot: allocating hash table via alloc_large_sy=
stem_hash
[    0.727068][    T0] stackdepot hash table entries: 1048576 (order: 12, 1=
6777216 bytes, linear)
[    0.733916][    T0] software IO TLB: area num 2.
[    0.908126][    T0] ------------[ cut here ]------------
[    0.909262][    T0] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
[    0.909305][    T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4=
393 lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.911749][    T0] Modules linked in:
[    0.912323][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.=
0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[    0.913743][    T0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    0.915988][    T0] RIP: 0010:lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.917185][    T0] Code: c7 c7 40 f1 27 87 e8 19 97 e7 ff 90 0f 0b 90 9=
0 e9 7a ff ff ff 90 48 c7 c6 e0 21 28 87 48 c7 c7 40 f1 27 87 e8 fb 96 e7 f=
f 90 <0f> 0b 90 90 eb a3 e8 0f 63 7b 00 e9 09 fd ff ff e8 f5 63 7b 00 e9
[    0.920840][    T0] RSP: 0000:ffffffff88c07be0 EFLAGS: 00010082
[    0.922264][    T0] RAX: 0000000000000000 RBX: 0000000000000003 RCX: fff=
fffff811aafe9
[    0.924240][    T0] RDX: ffffffff88c2c7c0 RSI: ffffffff811aaff6 RDI: 000=
0000000000001
[    0.925353][    T0] RBP: ffffffff88c07d38 R08: 0000000000000001 R09: 000=
0000000000000
[    0.926922][    T0] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888000100000
[    0.928419][    T0] R13: ffffffff9357fc30 R14: 0000000000000000 R15: 000=
0000000000000
[    0.929557][    T0] FS:  0000000000000000(0000) GS:ffff8881f5800000(0000=
) knlGS:0000000000000000
[    0.930911][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.931966][    T0] CR2: ffff88823ffff000 CR3: 0000000008ca0000 CR4: 000=
00000000000b0
[    0.933236][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    0.934520][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    0.935652][    T0] Call Trace:
[    0.936173][    T0]  <TASK>
[    0.936605][    T0]  ? __warn+0xea/0x3d0
[    0.937268][    T0]  ? lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.938086][    T0]  ? report_bug+0x3c0/0x580
[    0.938791][    T0]  ? handle_bug+0x54/0xa0
[    0.939424][    T0]  ? exc_invalid_op+0x17/0x50
[    0.940087][    T0]  ? asm_exc_invalid_op+0x1a/0x20
[    0.941088][    T0]  ? __warn_printk+0x199/0x350
[    0.942223][    T0]  ? __warn_printk+0x1a6/0x350
[    0.942904][    T0]  ? lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.943814][    T0]  trace_hardirqs_on+0x14/0x40
[    0.944477][    T0]  _raw_spin_unlock_irq+0x23/0x50
[    0.945145][    T0]  debug_check_no_obj_freed+0x31e/0x5f0
[    0.945900][    T0]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[    0.947024][    T0]  ? should_skip_region.isra.0+0x117/0x130
[    0.947907][    T0]  __free_pages_ok+0x244/0xa20
[    0.948674][    T0]  memblock_free_all+0x43c/0x610
[    0.949511][    T0]  ? __pfx_memblock_free_all+0x10/0x10
[    0.950569][    T0]  ? __asan_memset+0x23/0x50
[    0.951210][    T0]  ? swiotlb_init_io_tlb_pool.constprop.0+0x256/0x2c0
[    0.952133][    T0]  ? swiotlb_init_remap+0x2fc/0x470
[    0.952838][    T0]  mem_init+0x1d/0x370
[    0.953390][    T0]  mm_core_init+0x10a/0x240
[    0.954116][    T0]  start_kernel+0x197/0x4c0
[    0.954708][    T0]  x86_64_start_reservations+0x18/0x30
[    0.955496][    T0]  x86_64_start_kernel+0xb2/0xc0
[    0.956225][    T0]  common_startup_64+0x12c/0x138
[    0.956879][    T0]  </TASK>
[    0.957305][    T0] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    0.958450][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.=
0-rc4-syzkaller-gc6d9e43954bf-dirty #0
[    0.960114][    T0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    0.961655][    T0] Call Trace:
[    0.962225][    T0]  <TASK>
[    0.962632][    T0]  dump_stack_lvl+0x3d/0x1f0
[    0.963277][    T0]  panic+0x71d/0x800
[    0.963801][    T0]  ? __pfx_panic+0x10/0x10
[    0.964467][    T0]  ? show_trace_log_lvl+0x29d/0x3d0
[    0.965214][    T0]  ? check_panic_on_warn+0x1f/0xb0
[    0.966102][    T0]  ? lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.967262][    T0]  check_panic_on_warn+0xab/0xb0
[    0.967984][    T0]  __warn+0xf6/0x3d0
[    0.968518][    T0]  ? lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.969391][    T0]  report_bug+0x3c0/0x580
[    0.970077][    T0]  handle_bug+0x54/0xa0
[    0.970688][    T0]  exc_invalid_op+0x17/0x50
[    0.971472][    T0]  asm_exc_invalid_op+0x1a/0x20
[    0.972430][    T0] RIP: 0010:lockdep_hardirqs_on_prepare+0x3c6/0x420
[    0.973347][    T0] Code: c7 c7 40 f1 27 87 e8 19 97 e7 ff 90 0f 0b 90 9=
0 e9 7a ff ff ff 90 48 c7 c6 e0 21 28 87 48 c7 c7 40 f1 27 87 e8 fb 96 e7 f=
f 90 <0f> 0b 90 90 eb a3 e8 0f 63 7b 00 e9 09 fd ff ff e8 f5 63 7b 00 e9
[    0.976395][    T0] RSP: 0000:ffffffff88c07be0 EFLAGS: 00010082
[    0.977327][    T0] RAX: 0000000000000000 RBX: 0000000000000003 RCX: fff=
fffff811aafe9
[    0.978440][    T0] RDX: ffffffff88c2c7c0 RSI: ffffffff811aaff6 RDI: 000=
0000000000001
[    0.979776][    T0] RBP: ffffffff88c07d38 R08: 0000000000000001 R09: 000=
0000000000000
[    0.980888][    T0] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888000100000
[    0.982105][    T0] R13: ffffffff9357fc30 R14: 0000000000000000 R15: 000=
0000000000000
[    0.983253][    T0]  ? __warn_printk+0x199/0x350
[    0.983911][    T0]  ? __warn_printk+0x1a6/0x350
[    0.984601][    T0]  trace_hardirqs_on+0x14/0x40
[    0.985321][    T0]  _raw_spin_unlock_irq+0x23/0x50
[    0.986072][    T0]  debug_check_no_obj_freed+0x31e/0x5f0
[    0.986989][    T0]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[    0.988219][    T0]  ? should_skip_region.isra.0+0x117/0x130
[    0.989179][    T0]  __free_pages_ok+0x244/0xa20
[    0.990210][    T0]  memblock_free_all+0x43c/0x610
[    0.990970][    T0]  ? __pfx_memblock_free_all+0x10/0x10
[    0.991836][    T0]  ? __asan_memset+0x23/0x50
[    0.992725][    T0]  ? swiotlb_init_io_tlb_pool.constprop.0+0x256/0x2c0
[    0.993707][    T0]  ? swiotlb_init_remap+0x2fc/0x470
[    0.994498][    T0]  mem_init+0x1d/0x370
[    0.995089][    T0]  mm_core_init+0x10a/0x240
[    0.995747][    T0]  start_kernel+0x197/0x4c0
[    0.996490][    T0]  x86_64_start_reservations+0x18/0x30
[    0.997404][    T0]  x86_64_start_kernel+0xb2/0xc0
[    0.998318][    T0]  common_startup_64+0x12c/0x138
[    0.999061][    T0]  </TASK>
[    0.999501][    T0] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2571341281=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at cd6fc0a301
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dcd6fc0a3018e5d793bdcca6530622493f5e88307 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241018-123137'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"cd6fc0a3018e5d793bdcca6530622493f5=
e88307\"
/usr/bin/ld: /tmp/ccoP4YcL.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccoP4YcL.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10828a5f980000


Tested on:

commit:         c6d9e439 Merge 6.12-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.=
git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4a2bb21f91d75c6=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da234c2d63e0c171ca=
10e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13ac8a5f9800=
00


