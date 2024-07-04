Return-Path: <linux-kernel+bounces-240854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487899273B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71C41F27B17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF91AB904;
	Thu,  4 Jul 2024 10:10:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D01A0730
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087823; cv=none; b=AQ0eienE1twOFPf1yxqHLkyyNaANcjt9Z+ivE7SEP9BHumLTc17i+l1IduZkr3Rx3iGtuE/NCcTCqTZlvwfXutt2rWYoi37o4qDDz41T9l8HjoRbBnKsD5LnelOhZ5hq9Q4qCPzvgy/Ih8zQArCd+EKtPhlevAxajigc5HrYKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087823; c=relaxed/simple;
	bh=hJ1Bk/xgm4CPrnlEYx3plzA9vyEWqLjVawgQNs/dZgM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B4C0SzhjHda7Fk+pTMLTRJ+Pghoc6lo5G4RQCuvnPc7lsz9rITo4GJ/G2jJ1zvwg+Y/mtGhTAjrhCvlWzB0dvvFlj0aTyWjogLwr2dCzcRB67Ag9ckzY5agUEgSj9xC/2xt/kOWfcwzcvOknInuK66GGM9Byi6+XUsWc3RwiN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f667a2a677so44532139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720087821; x=1720692621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2go9SCcWszQ2l9IgjzhShfimZA/zfWBZeVZpbKeZKQ=;
        b=pLZajTM7Sew5g1MtRT1COKTREn2gAku4JQ3n1hiCL+unHIopVgKZ2jZauxA1NtiRAF
         96jhsAvOHOv2NlrcttiSnjeIbULPfpEAfEYnhP2krrCJ+O91EFX/ix4vKuNNdXrxnSCr
         pnrym7YTCkBjcC8849TpVRbYpNjamVjAXEZnfC77SEMXldvKfCSlTcuEzdI/vojOmRej
         DkbYj3+dW2ROaYRhBk4oToes+Ca9HNokic3lHEvebjhAXECh9Vm0xRS1VW5mWBixeYJm
         LHIHSAaIcTG+RwwPmJuanIVr5AORFyfan4SjKKWWAkTVS41KihgO+OUetLLnBpKf6kF3
         QRKw==
X-Forwarded-Encrypted: i=1; AJvYcCUWbAd/xwgf0M2HNGvcdMqTWul0ryYGw5S5e9Nfxio9zB9ssjg9xyxpYhhBoeMMNRERySU183K//ZRZ7YwxmlF63uFO3lczJhU0xfYW
X-Gm-Message-State: AOJu0YxPOruLSwWFSfEuAXjVHFl4pn5e85vClAoX9ye/apWpNfxDleuH
	zxuxCBugC2k8qECtrxEJM8sqjJzPza9+nI0J62B1TgjVx8Z3sshzg/ge2vEznmxXd/Db6jCxS50
	BzxRYwq62V9lxHv0Dx0jYwhpFxuPYnepZ25WDxSB0WZdMoszI/GEviXc=
X-Google-Smtp-Source: AGHT+IEI4PP+gcrzVqiULFpZGal0zBX4dKtFFUhfEoKhgo2keaRWO5ln/2d5uxv18wXhtNrNEJlOrPNIeQ80yZIf+2DJ5ora4i4j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:376:3fad:bb7c with SMTP id
 e9e14a558f8ab-383caf44c67mr458905ab.1.1720087820941; Thu, 04 Jul 2024
 03:10:20 -0700 (PDT)
Date: Thu, 04 Jul 2024 03:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ccc65061c6927f5@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __virt_to_phys (4)
From: syzbot <syzbot+53a6240f92421be04a12@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5e456a31d1ac Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=105c2e71980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94594c6c92300e
dashboard link: https://syzkaller.appspot.com/bug?extid=53a6240f92421be04a12
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a86fa6980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1069e4be980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f89c6438e363/disk-5e456a31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39d1dcfa82c4/vmlinux-5e456a31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6bbd2a0d874f/Image-5e456a31.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3e164c5b3bcc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53a6240f92421be04a12@syzkaller.appspotmail.com

bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
virt_to_phys used for non-linear address: fffffffffffffff2 (0xfffffffffffffff2)
WARNING: CPU: 0 PID: 6287 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
Modules linked in:
CPU: 0 PID: 6287 Comm: syz-executor202 Not tainted 6.10.0-rc5-syzkaller-g5e456a31d1ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
lr : __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
sp : ffff80009af36c00
x29: ffff80009af36c00 x28: 0000000000000002 x27: 1ffff000135e6d98
x26: 1ffff000135e6d94 x25: dfff800000000000 x24: fffffffffffffff2
x23: ffff0000db557a20 x22: 000f600000000000 x21: 000000000000002d
x20: fffffffffffffff2 x19: 000ffffffffffff2 x18: 0000000000000008
x17: 6666783028203266 x16: ffff800082fca0f0 x15: 0000000000000001
x14: 1fffe000367a9e4a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 6df737eb5149e300
x8 : 6df737eb5149e300 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009af36358 x4 : ffff80008f295100 x3 : ffff8000805f0fe4
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
 virt_to_phys arch/arm64/include/asm/memory.h:368 [inline]
 virt_to_pfn arch/arm64/include/asm/memory.h:382 [inline]
 virt_to_folio include/linux/mm.h:1313 [inline]
 kfree+0x9c/0x3e0 mm/slub.c:4550
 bch2_ioctl_fsck_online+0x358/0x580 fs/bcachefs/chardev.c:853
 bch2_fs_ioctl+0x23ec/0x3980 fs/bcachefs/chardev.c:927
 bch2_fs_file_ioctl+0x78c/0x2334 fs/bcachefs/fs-ioctl.c:532
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 76418
hardirqs last  enabled at (76417): [<ffff8000803798a0>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (76417): [<ffff8000803798a0>] __console_unlock kernel/printk/printk.c:2746 [inline]
hardirqs last  enabled at (76417): [<ffff8000803798a0>] console_unlock+0x18c/0x3d4 kernel/printk/printk.c:3065
hardirqs last disabled at (76418): [<ffff80008b06f39c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (76054): [<ffff8000800307e0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (76052): [<ffff8000800307ac>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address ffffffffc377ffc8
KASAN: maybe wild-memory-access in range [0x0003fffe1bbffe40-0x0003fffe1bbffe47]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001acce6000
[ffffffffc377ffc8] pgd=0000000000000000, p4d=00000001b058e003, pud=00000001b058f003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6287 Comm: syz-executor202 Tainted: G        W          6.10.0-rc5-syzkaller-g5e456a31d1ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:245 [inline]
pc : virt_to_folio include/linux/mm.h:1315 [inline]
pc : kfree+0xb4/0x3e0 mm/slub.c:4550
lr : virt_to_phys arch/arm64/include/asm/memory.h:368 [inline]
lr : virt_to_pfn arch/arm64/include/asm/memory.h:382 [inline]
lr : virt_to_folio include/linux/mm.h:1313 [inline]
lr : kfree+0x9c/0x3e0 mm/slub.c:4550
sp : ffff80009af36c30
x29: ffff80009af36c40 x28: 0000000000000002 x27: 1ffff000135e6d98
x26: 1ffff000135e6d94 x25: dfff800000000000 x24: fffffffffffffff2
x23: ffff0000db557a20 x22: ffff0000dd64a2d0 x21: fffffffffffffff2
x20: ffffffffc377ffc0 x19: ffff800082801fec x18: 0000000000000008
x17: 6666783028203266 x16: ffff800082fca0f0 x15: 0000000000000001
x14: 1fffe000367a9e4a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : 00003e000377ffc0
x8 : ffffc1ffc0000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009af36358 x4 : ffff80008f295100 x3 : ffff8000805f0fe4
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000080011dfffff2
Call trace:
 virt_to_folio include/linux/mm.h:1313 [inline]
 kfree+0xb4/0x3e0 mm/slub.c:4550
 bch2_ioctl_fsck_online+0x358/0x580 fs/bcachefs/chardev.c:853
 bch2_fs_ioctl+0x23ec/0x3980 fs/bcachefs/chardev.c:927
 bch2_fs_file_ioctl+0x78c/0x2334 fs/bcachefs/fs-ioctl.c:532
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 927acd29 f2d83fe8 cb141929 8b080134 (f9400688) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	927acd29 	and	x9, x9, #0x3ffffffffffffc0
   4:	f2d83fe8 	movk	x8, #0xc1ff, lsl #32
   8:	cb141929 	sub	x9, x9, x20, lsl #6
   c:	8b080134 	add	x20, x9, x8
* 10:	f9400688 	ldr	x8, [x20, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

