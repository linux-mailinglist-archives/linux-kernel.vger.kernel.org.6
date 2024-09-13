Return-Path: <linux-kernel+bounces-328456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6797847A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E9281526
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38B1C3F16;
	Fri, 13 Sep 2024 15:09:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFC1C2DB2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240170; cv=none; b=mS5HFaRfyRLyyBNMG9XhEIA1rhyJIU+Vea1rCtiLucNayVJ7UZL271ijYxkG6pDiGaiAzxhzA4kjfQWBaEPYyFLw4zsQ2RW+kE39BNVPtpmFLXEUF5T1Jmm90nW1SQ5ZYLMxbgEKZSRXRLp2HTp3y/LxAYxoClZeG7xY82GKyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240170; c=relaxed/simple;
	bh=/mfPXuGUjWoK95rEJEj+oT92WLzibx1CBpWAkHAq+ks=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gPsovTUhWnBbC//fqZE00d6VqzCIZMllB07sib2qxmdHMt47DWX5CCq+zrwkeqqYcdKYCOY0XTvBx0Y/4TrapfgLL5EIRaOJFoPIkF66/jbMq7YLx9aIJQ28ca6jQXI+pkbiN3Nszs8CFDvb8U9QQbVuMWlxH6HqjAd2fzLpXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ad45d6dc7so45839439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240167; x=1726844967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwZk2Mnqq2cweJX6bDDtcGnk53Z7SnCzW4WXDuHomAE=;
        b=kdtzvMiAsK7ivZqVQnGlpEc/6OkIBEc1XCioeX3PDWCKZJI/7PO2xZ2u9Ctv7TFLiF
         WiSDSTNiChB1cUD+mQx25oSwUFXPHOH2hsG04RNeiZHy9W2t+mhGMWebG+50VBurHMug
         i03QVLo+JEBJPk1RsghHYzSymSpK/Fs813AgLIxQZPWjixTu9kSdaIgri7yJ82gqLBft
         2kbsnVmtCEPTOuHHeEGkqPQC9iHUzDiplNiNZzYrMXtwZbhk7qRHReIjlZ+YkXtwBERD
         jirHzd1VZTCLHdgkuteG5LgLbnL2WnZEoNWePW1KN7poj/rYVuTYB3XLNdiQEPn+9i9H
         pHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOpTnlj1zQPUiDQflFOCnM1+bUPxF1h4IYDMe2nleLWgmV9TBFwJl1T5PnTWbZeN/zYr5+lgV56ZjKjn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRhJwHh31XM1EfA3Tjf3jwpBMfBCyVhnPyUYcIFvdDBHTu+QJ
	mRiSCWP/NVyAIsmgJlB3zSDAzZ/kccr4UyTR5ymKj90IohVf3ZDKEQcb3S9e5Rv6rwvnSnypvIO
	znpvu4Lltk6u6xoHQ0FMOkI1dbqkhmoA6IRXaiM9Ubp3ysY+nSxN+H7M=
X-Google-Smtp-Source: AGHT+IEQoJRcIrzGUkN4aBBAUJBtrxkYArlv+beaDll8QIp9cBUcHhnYeXB1rLxxTrg7K/KJ8rD2bB4D+8ClBawnxtz5KWwC9PT7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:3a0:57b5:6e08 with SMTP id
 e9e14a558f8ab-3a08497522cmr17636745ab.7.1726240167434; Fri, 13 Sep 2024
 08:09:27 -0700 (PDT)
Date: Fri, 13 Sep 2024 08:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa38f30622019b6e@google.com>
Subject: [syzbot] [riscv?] kernel panic: corrupted stack end in
 handle_page_fault (2)
From: syzbot <syzbot+5a364b90a40e8fe8ab78@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1ff95eb2bebd riscv: Fix RISCV_ALTERNATIVE_EARLY
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=119b27c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79e90d7b2f5b364
dashboard link: https://syzkaller.appspot.com/bug?extid=5a364b90a40e8fe8ab78
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-1ff95eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1491182abe4e/vmlinux-1ff95eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/926302c5c645/Image-1ff95eb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a364b90a40e8fe8ab78@syzkaller.appspotmail.com

Registered RDS/tcp transport
NET: Registered PF_SMC protocol family
9pnet: Installing 9P2000 support
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
NET: Registered PF_VSOCK protocol family
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: f2a59455c4296818b28c73c1d87b1152c8ec3b9d'
zswap: loaded using pool 842/z3fold
Demotion targets for Node 0: null
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Key type .fscrypt registered
Key type fscrypt-provisioning registered
Key type big_key registered
Key type encrypted registered
AppArmor: AppArmor sha256 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: f2a59455c4296818b28c73c1d87b1152c8ec3b9d'
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
Freeing unused kernel image (initmem) memory: 2532K
Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
Run /sbin/init as init process
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 6.11.0-rc2-syzkaller-g1ff95eb2bebd #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80010216>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
[<ffffffff85edbc4e>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
[<ffffffff85f3714c>] __dump_stack lib/dump_stack.c:93 [inline]
[<ffffffff85f3714c>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:119
[<ffffffff85f371f6>] dump_stack+0x1c/0x24 lib/dump_stack.c:128
[<ffffffff85edc812>] panic+0x388/0x806 kernel/panic.c:348
[<ffffffff85f4533a>] schedule_debug kernel/sched/core.c:5745 [inline]
[<ffffffff85f4533a>] __schedule+0x3230/0x3288 kernel/sched/core.c:6411
[<ffffffff85f4585c>] preempt_schedule_common kernel/sched/core.c:6708 [inline]
[<ffffffff85f4585c>] preempt_schedule+0xd2/0x1e2 kernel/sched/core.c:6732
[<ffffffff85f5a472>] __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
[<ffffffff85f5a472>] _raw_spin_unlock+0x88/0xa8 kernel/locking/spinlock.c:186
[<ffffffff806c89e0>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffffffff806c89e0>] filemap_map_pages+0xa4a/0xf70 mm/filemap.c:3655
[<ffffffff807efa7c>] do_fault_around mm/memory.c:5019 [inline]
[<ffffffff807efa7c>] do_read_fault mm/memory.c:5052 [inline]
[<ffffffff807efa7c>] do_fault mm/memory.c:5191 [inline]
[<ffffffff807efa7c>] do_pte_missing mm/memory.c:3947 [inline]
[<ffffffff807efa7c>] handle_pte_fault mm/memory.c:5522 [inline]
[<ffffffff807efa7c>] __handle_mm_fault+0x1cbe/0x3998 mm/memory.c:5665
[<ffffffff807f1d08>] handle_mm_fault+0x5b2/0xb36 mm/memory.c:5833
[<ffffffff8002350a>] handle_page_fault+0x2ba/0x1588 arch/riscv/mm/fault.c:302
[<ffffffff85f3950a>] do_page_fault+0x20/0x56 arch/riscv/kernel/traps.c:362
[<ffffffff85f5b85a>] handle_exception+0xca/0xd6 arch/riscv/kernel/entry.S:110
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

