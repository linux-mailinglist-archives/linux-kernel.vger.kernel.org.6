Return-Path: <linux-kernel+bounces-256507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33FF934F72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CD41C218D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CB142E88;
	Thu, 18 Jul 2024 14:55:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20480BFF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314528; cv=none; b=uRoxTJZDjYHEhPXmP2l/cK9nRY2e0rgGlwMZy2iuum85Y5sG6V5Z2YK20xW46XWnE6LsTkPwJNOBV50bD1mVF6ZVASYnvxQVTfYOCYE1OXpFU2FB0fEASN8Ia9XHSvXDZ7jUyUbHyVxS8+iQod1nW2OB3dXLs451zCeH6m3qb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314528; c=relaxed/simple;
	bh=JImStMEgVhfA1T/omRaMJPozV9xnbuj22opdxF9r6Xo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vm9KckuvGs6LRWBRb6NAisGy33tdoO5mh1bR7mHTAEhay3wOKXkEmxxKkV7+HM2gboZCkKbbJPWpXi0LvJmufwSR7ukjVShjv3aLlAvqm6GB1NX1YfuaviQOfSAx5EUssPtQaHrMIRUgFk4sEIcHLisSuy7hlyduq8ghWC2JPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-396fa3fe46cso10143775ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314526; x=1721919326;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHQ736oSN+wFSuoJ4cgow6Bjx4YPkLj7q2P4y7nHB/0=;
        b=J/HckDzVVAhfyalV5r5cjpuLeCfNn8f32jgyrvVcgeM1J7SurMEjvXwEQSNT608ceP
         hiW5bCJdy9LDfcRLE/37WLIQXdvWubTBc93vqCDjaEDGxG2tUrvQi8qXM1Xu2dz+Hi9z
         h4bza4Q1uJsYE3XOghJ944poC1NB5W90BwdsExGX9ani/LHEXYUrX7KxYbx7WIVXN8Zf
         W3ceholMac5kKCfO9QehFLTcVwJv18hDrB4FoT1rWKDPjwPsyyoDTqx1VzaUWu3FyJii
         YZYtjCQ1KUgtB6irWTc8PAhfvMNgIqBHtYLpQsvk0P6QvNG9rbo1Uv3lBcWY6fU+b04g
         XE1g==
X-Forwarded-Encrypted: i=1; AJvYcCW5UqmnFgKLcpFSyJkXu8+4p8UVgNsJeGNKPty3rzXJ7wePdPuKfxjlZQZdClUVNBDGWoSiMTYtaU2OzUDRK+9zX+dA/Tz8j/vT9qXy
X-Gm-Message-State: AOJu0YyPZep2oUcONi6LJ3N37ujbbwr1iZTrLIZeMEUI/iyOWabgRJdq
	4aH9rKISyxaWsjCbENdS0JUPvWPWNi6NzGZ3EGrM4HdAgP9l02bXmxpLb2QQ/an6PivOI5zUBI3
	dJg2xPdWBF8UGUvtY2kqcbJq4mq2mWPRouS6dD6CXRJJp6/zfbMWDlp8=
X-Google-Smtp-Source: AGHT+IHGFup9n9yqbUu2x8LEu66a78cdO08qEn1jlEad66zd76Ah6Sd/GE1vvxQvOONq3GtO2yxyyNIAHQsfMwJRmxG1E1N6oAGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-39557faa29dmr4580955ab.5.1721314526048; Thu, 18 Jul 2024
 07:55:26 -0700 (PDT)
Date: Thu, 18 Jul 2024 07:55:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df3f0b061d86c48f@google.com>
Subject: [syzbot] [arm?] KASAN: invalid-access Write in setup_arch
From: syzbot <syzbot+1aa1114f144c4051c1dd@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9dafbe7b06a9 Merge remote-tracking branch 'kernel/kvmarm/n..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
console output: https://syzkaller.appspot.com/x/log.txt?x=12fd98b1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25f90809fb74c5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=1aa1114f144c4051c1dd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-9dafbe7b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee5f770ee892/vmlinux-9dafbe7b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/817d5b5ba669/Image-9dafbe7b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1aa1114f144c4051c1dd@syzkaller.appspotmail.com

Booting Linux on physical CPU 0x0000000000 [0x000f0510]
Linux version 6.10.0-rc6-syzkaller-g9dafbe7b06a9 (syzkaller@syzkaller) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
random: crng init done
Machine model: linux,dummy-virt
efi: UEFI not found.
NUMA: No NUMA configuration found
NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
NUMA: NODE_DATA [mem 0xbfc0d340-0xbfc10fff]
Zone ranges:
  DMA      [mem 0x0000000040000000-0x00000000bfffffff]
  DMA32    empty
  Normal   empty
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000040000000-0x00000000bfffffff]
Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
cma: Reserved 32 MiB at 0x00000000bba00000 on node -1
psci: probing for conduit method from DT.
psci: PSCIv1.1 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: Trusted OS migration not required
psci: SMC Calling Convention v1.0
==================================================================
BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
BUG: KASAN: invalid-access in setup_arch+0x794/0xa7c arch/arm64/kernel/setup.c:356
Write of size 4 at addr 03ff800084947e10 by task swapper/0
Pointer tag: [03], memory tag: [fe]

CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc6-syzkaller-g9dafbe7b06a9 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x128/0x214 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x138/0x1c8 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x118/0x5ac mm/kasan/report.c:488
 kasan_report+0xc8/0x108 mm/kasan/report.c:601
 kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
 __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
 smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
 setup_arch+0x794/0xa7c arch/arm64/kernel/setup.c:356
 start_kernel+0xc0/0xb10 init/main.c:926
 __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243

The buggy address belongs to stack of task swapper/0

Memory state around the buggy address:
 ffff800084947c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00
 ffff800084947d00: 00 00 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe
>ffff800084947e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                      ^
 ffff800084947f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff800084948000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
kasan: KernelAddressSanitizer initialized (sw-tags, stacktrace=on)
percpu: Embedded 35 pages/cpu s103176 r8192 d31992 u143360
Detected PIPT I-cache on CPU0
CPU features: detected: GIC system register CPU interface
CPU features: detected: HCRX_EL2 register
CPU features: detected: 52-bit Virtual Addressing (LPA2)
CPU features: detected: Virtualization Host Extensions
CPU features: detected: Spectre-v4
alternatives: applying boot alternatives
Kernel command line: root=/dev/vda console=ttyAMA0 
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 524288
Policy zone: DMA
mem auto-init: stack:all(zero), heap alloc:on, heap free:off
stackdepot: allocating hash table via alloc_large_system_hash
stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
software IO TLB: SWIOTLB bounce buffer size adjusted to 2MB
software IO TLB: area num 1.
software IO TLB: mapped [mem 0x00000000b1d55000-0x00000000b1f55000] (2MB)
Memory: 1761408K/2097152K available (58944K kernel code, 4788K rwdata, 13864K rodata, 2048K init, 22780K bss, 302976K reserved, 32768K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
allocated 4194304 bytes of page_ext
trace event string verifier disabled
Running RCU self tests
Running RCU synchronous self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
rcu: 	RCU callback double-/use-after-free debug is enabled.
rcu: 	RCU debug extended QS entry/exit.
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
Running RCU synchronous self tests
RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
GICv3: GIC: Using split EOI/Deactivate mode
GICv3: 256 SPIs implemented
GICv3: 0 Extended SPIs implemented
Root IRQ handler: gic_handle_irq
GICv3: GICv3 features: 16 PPIs
GICv3: GICv4 features: 
GICv3: CPU0: found redistributor 0 region 0:0x00000000080a0000
ITS [mem 0x08080000-0x0809ffff]
ITS@0x0000000008080000: Single VMOVP capable
ITS@0x0000000008080000: allocated 8192 Devices @46e20000 (indirect, esz 8, psz 64K, shr 1)
ITS@0x0000000008080000: allocated 8192 Interrupt Collections @46e30000 (flat, esz 8, psz 64K, shr 1)
ITS@0x0000000008080000: allocated 8192 Virtual CPUs @46e40000 (indirect, esz 8, psz 64K, shr 1)
GICv3: using LPI property table @0x0000000046e50000
ITS: Allocated DevID ffff as GICv4 proxy device (2 slots)
ITS: Enabling GICv4 support
GICv3: CPU0: using allocated LPI pending table @0x0000000046e60000
rcu: srcu_init: Setting srcu_struct sizes based on contention.
arch_timer: cp15 timer(s) running at 62.50MHz (phys).
clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     131072
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 11817 kB
 memory used for stack traces: 8320 kB
 per task-struct memory footprint: 1920 bytes
Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,ima,evm
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
SELinux:  Initializing.
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Running RCU synchronous self tests
Running RCU synchronous self tests


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

