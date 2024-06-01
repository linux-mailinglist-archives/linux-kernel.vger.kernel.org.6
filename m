Return-Path: <linux-kernel+bounces-197622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD58D6D30
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1856CB21303
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9A3FD4;
	Sat,  1 Jun 2024 00:41:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F84EDC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717202493; cv=none; b=PKcw+LYtdQ5wakpAzg0JY9CTbvpBBXmXuiyFkpK5zfyCOEQCpIV3X3Le+5204/UqDU91sAtkTiG8TfYJXo00MXoocInwvv4PV1hxX5P22/la5VB8tO/XbrQu1obcC2HNZtYunqPMVOljjsUtB4FFTll/48tU49mP4jZkxAL89Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717202493; c=relaxed/simple;
	bh=vUrwq7sd2xeiNVZqLgkVDgGIKKEMGZ2n9hE00kFAA44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dhgSt25GC3VydE0iYKntulY3gmRrPwwchgVBeNgTEA/jWCG3x4JNWOu+5F9JPE4ADrdRaVikI7k6a2S8KMokHOj2MeihybCZsaxi8UJJrhEJGcTSbSsaqgoU43rHLfCxUP8AEoI1bgdUgEOmhvy6jdOT/6g/WGkrj2cpEmSbPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ead7796052so190416339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717202491; x=1717807291;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9QALdIBFHCSriayow4WnHAWcVdi9xd6Oro0yxB4VrI=;
        b=MiAEpatewFsDnoWsoKwV6wKYcrQ6Lm/Xj/80q4HzWC4nh4PY2qxz01hvi/5b2ySC4y
         +hPz6rR5sXutygeF0+1eKbiwuPRLuBgzWHnjh7KZMsIjV7dXRk6dwHf1lRpNwtsLfPc5
         3s68YLxX7GbTuDJCZv/W04C4xCxguXBPENkXHN6amHNyVoaD2HGUHpkNbsr+4LOhAl6Q
         OJVZrtCIjRW7HhPsgaaXznAtJdg1Mj9MwQ8gzPX36NhzdEXTEdgvAmANJbmsIsb00L5w
         zVdC2EY6oAR0Y2U3QGh+BekgmXtW52CHUaXGU8mCcXkFJkNhxZjZvj01r0/JfeJEAc8v
         O6cQ==
X-Gm-Message-State: AOJu0YyNz2Kxbyr3fjppFrki4ZJT+5kRCMvJ+3R8achmn3hiLOvOisjS
	wQzkWe06cKOJfX8jCfLIo+NSw/IIS/plrVBAhbus2R03DQda8a84biwERxkTkSLnAJ7fSy9vyaE
	FEqnM7cxSzfdvCLOeI+SRiuZve04t3PXuPwuOls3jGKb+lPod1SbPGaIaig==
X-Google-Smtp-Source: AGHT+IFF85fvSbelK272na/V5WTfASVIJss+I8h5X7hFkTKjU3xodjaEYw40P3OjS98T6md/1eeHOcVLuL+z5iJqstGL2uSZBsiR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d05:b0:374:88de:795d with SMTP id
 e9e14a558f8ab-3748b98186bmr2223695ab.1.1717202490973; Fri, 31 May 2024
 17:41:30 -0700 (PDT)
Date: Fri, 31 May 2024 17:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b6c740619c95c71@google.com>
Subject: [syzbot] [kernel?] kernel panic: corrupted stack end in kernel_init
From: syzbot <syzbot+959d626e72881bce20fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7932b172ac7e Revert "riscv: mm: accelerate pagefault when ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=10d49ef2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71e27a66e3476b52
dashboard link: https://syzkaller.appspot.com/bug?extid=959d626e72881bce20fd
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-7932b172.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/484dae64ac53/vmlinux-7932b172.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0917f9215e08/Image-7932b172.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+959d626e72881bce20fd@syzkaller.appspotmail.com

NET: Registered PF_SMC protocol family
9pnet: Installing 9P2000 support
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
NET: Registered PF_VSOCK protocol family
Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 68b23e9aa2c7f658111149b173edb408693104cb'
zswap: loaded using pool lzo/zsmalloc
Demotion targets for Node 0: null
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Key type .fscrypt registered
Key type fscrypt-provisioning registered
Key type big_key registered
Key type encrypted registered
AppArmor: AppArmor sha256 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 68b23e9aa2c7f658111149b173edb408693104cb'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
printk: legacy console [netcon0] enabled
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 128 bytes)
rdma_rxe: loaded
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
EXT4-fs (vda): mounted filesystem 34b94c48-234b-4869-b990-1f782e29954a ro with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 253:0.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 2500K
Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
Run /sbin/init as init process
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 1 PID: 1 Comm: init Not tainted 6.10.0-rc1-syzkaller-g7932b172ac7e #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000f6f8>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:129
[<ffffffff85c29e64>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:135
[<ffffffff85c83b52>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff85c83b52>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:114
[<ffffffff85c83bfc>] dump_stack+0x1c/0x24 lib/dump_stack.c:123
[<ffffffff85c2aa2a>] panic+0x382/0x800 kernel/panic.c:347
[<ffffffff85c92b00>] schedule_debug kernel/sched/core.c:5962 [inline]
[<ffffffff85c92b00>] __schedule+0x342e/0x3486 kernel/sched/core.c:6628
[<ffffffff85c93af8>] preempt_schedule_irq+0x7a/0x1a8 kernel/sched/core.c:7067
[<ffffffff85c872de>] raw_irqentry_exit_cond_resched kernel/entry/common.c:311 [inline]
[<ffffffff85c872de>] raw_irqentry_exit_cond_resched kernel/entry/common.c:303 [inline]
[<ffffffff85c872de>] irqentry_exit+0x138/0x17a kernel/entry/common.c:354
[<ffffffff85c85f76>] do_irq+0x34/0x4a arch/riscv/kernel/traps.c:390
[<ffffffff85ca872c>] ret_from_exception+0x0/0x64 arch/riscv/kernel/entry.S:112
[<ffffffff8041fac0>] arch_local_irq_restore arch/riscv/include/asm/irqflags.h:51 [inline]
[<ffffffff8041fac0>] acct_update_integrals+0x26e/0x3e0 kernel/tsacct.c:160
[<ffffffff809d9f1a>] bprm_execve fs/exec.c:1901 [inline]
[<ffffffff809d9f1a>] bprm_execve+0x143a/0x18f0 fs/exec.c:1867
[<ffffffff809dcf2a>] kernel_execve+0x364/0x450 fs/exec.c:2058
[<ffffffff85c28f14>] run_init_process+0x194/0x1a8 init/main.c:1388
[<ffffffff85c28f46>] try_to_run_init_process+0x1e/0x66 init/main.c:1395
[<ffffffff85c89940>] kernel_init+0x180/0x224 init/main.c:1523
[<ffffffff85ca8836>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:232
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


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

