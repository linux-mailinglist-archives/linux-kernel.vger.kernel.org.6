Return-Path: <linux-kernel+bounces-308331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F9965A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8F11F24360
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914D16D31B;
	Fri, 30 Aug 2024 08:35:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB114F13A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006926; cv=none; b=fLfj0C8XIisk9rQzUGUxl1Ud3x95m7rUBOOWckjWuFRDHHl06PmNiWW1+//CKaWwUkRcoV5CBwmn+WHBfEVG/qO1UXGKWcg25cyDFAyqf80wIo3tBgBQQX5blx53FW/UoMq+wEXWqFBwIlFnmmKymCPu0hSua82OCIR4GimHvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006926; c=relaxed/simple;
	bh=gcLYlAfCzN5f+fDtR7iMNKcVv3XXOqlakMWTLn9D2Jo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bNexlzWa3NCkMSCwiKuIkwxSoFlcd+qzuppMxktI6mTuUmRH+eMRNSDS/uTuwyRoDZ32Q4huVeWHmtysST4AJsuN1or57MRUR4HZIEXL64qxh+wB62gcVLEGxF4pGiD9Xh7+fw1iCzqHNPM6eLqGo0ro13rOLhCbKokGb8QaziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a1fbaba4aso97845039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006924; x=1725611724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08bYYDtl54g8YG5N0jPLtkiF8GCFfkqFJ9+zWKcLwOg=;
        b=oHDsuiByQlNXzAopv+KybvT9IALrIW+BIXHGATGhjCDqhbVw3xXUcTmJ71yKBgDN8i
         0tQGuVDmak4BhcOV4N/0JGwR5JvTvP0yyHw03lUyGeyZjn/LlWy3U1ppLy1g+R0d/4lo
         2rdILrrxSQHZ0uzeUmeFknbBhTb7TGtF4laI8QVm4EP34B5Ji63YqQxA62NjyKALNgSg
         GddviNSPHO7aY3xxlwg2ekYET2qlEPGXu5pLh6kxKzkmkzqqXZkuNt0nbBlQ9zM2IkQ6
         m2d/leRnF80cmuLP934B7o8x3CAonP6D7YY5XxE+n43N/v+fsclwZgOXZ+UI5btxXsxg
         D4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV1cCiCBukqnu0AroifTLBN6JqAN3DeXQgYApqmLna1SLsN3CzX9aeBQcLuI0+GW5Pm9sWvRen2PejzBu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22vZrzTF3fznZnujCMgNZqHuPqL0cY75W6B8yq0489vO3TqUV
	b2WVRxqr5pV6pgIlPFyM9Nsqn1kqnug4MKeRT5KH2SyVOMQzkb+6dgvcDe1lUzHLrz3afiFN1bj
	tso7AEITd4twj4DNT60rMNQ8PEKLCru7YR/b7oL+R7i0yp3ta+s2O3Mc=
X-Google-Smtp-Source: AGHT+IEDOvYTG6xFi/zvWp0m9/5vDWS2xWIsecZ4vO5m+ptFZnXGj6ynkz1Kh00Pd+aGyKZCU00yF9Cq3WmWXd5jhYBoXXGpRe3p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:39d:268a:e920 with SMTP id
 e9e14a558f8ab-39f413ce342mr883155ab.3.1725006924172; Fri, 30 Aug 2024
 01:35:24 -0700 (PDT)
Date: Fri, 30 Aug 2024 01:35:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f362e80620e27859@google.com>
Subject: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write in setup_arch
From: syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvmarm-m..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
console output: https://syzkaller.appspot.com/x/log.txt?x=1398420b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b7b31c9aa1397ca
dashboard link: https://syzkaller.appspot.com/bug?extid=908886656a02769af987
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-33faa93b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9093742fcee9/vmlinux-33faa93b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1f599907931/Image-33faa93b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com

Booting Linux on physical CPU 0x0000000000 [0x000f0510]
Linux version 6.11.0-rc5-syzkaller-g33faa93bc856 (syzkaller@syzkaller) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
random: crng init done
Machine model: linux,dummy-virt
efi: UEFI not found.
NUMA: No NUMA configuration found
NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
NUMA: NODE_DATA [mem 0xbfc1d340-0xbfc20fff]
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
BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
Write of size 4 at addr 03ff800086867e00 by task swapper/0
Pointer tag: [03], memory tag: [fe]

CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller-g33faa93bc856 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x204/0x3b8 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x260/0x3b4 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x118/0x5ac mm/kasan/report.c:488
 kasan_report+0xc8/0x108 mm/kasan/report.c:601
 kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
 __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
 smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
 setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
 start_kernel+0xe0/0xff0 init/main.c:926
 __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243

The buggy address belongs to stack of task swapper/0

Memory state around the buggy address:
 ffff800086867c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff800086867d00: 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe fe fe
>ffff800086867e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff800086867f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff800086868000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
percpu: Embedded 35 pages/cpu s104840 r8192 d30328 u143360
Detected PIPT I-cache on CPU0
CPU features: detected: GIC system register CPU interface
CPU features: detected: HCRX_EL2 register
CPU features: detected: 52-bit Virtual Addressing (LPA2)
CPU features: detected: Virtualization Host Extensions
CPU features: detected: Spectre-v4
alternatives: applying boot alternatives
kasan: KernelAddressSanitizer initialized (sw-tags, stacktrace=on)
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
software IO TLB: mapped [mem 0x00000000b1a29000-0x00000000b1c29000] (2MB)
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
GICv3: GICD_CTRL.DS=1, SCR_EL3.FIQ=0
GICv3: CPU0: found redistributor 0 region 0:0x00000000080a0000
ITS [mem 0x08080000-0x0809ffff]
ITS@0x0000000008080000: Single VMOVP capable
ITS@0x0000000008080000: allocated 8192 Devices @4a230000 (indirect, esz 8, psz 64K, shr 1)
ITS@0x0000000008080000: allocated 8192 Interrupt Collections @4a240000 (flat, esz 8, psz 64K, shr 1)
ITS@0x0000000008080000: allocated 8192 Virtual CPUs @4a250000 (indirect, esz 8, psz 64K, shr 1)
GICv3: using LPI property table @0x000000004a260000
ITS: Allocated DevID ffff as GICv4 proxy device (2 slots)
ITS: Enabling GICv4 support
GICv3: CPU0: using allocated LPI pending table @0x000000004a270000
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

