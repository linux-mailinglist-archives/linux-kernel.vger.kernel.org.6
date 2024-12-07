Return-Path: <linux-kernel+bounces-436056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67D9E808B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F66D1883280
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223B14A614;
	Sat,  7 Dec 2024 16:13:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89913AD26
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588007; cv=none; b=ZEbp1uVItNuPGdjoFy2SWBIZsUEzmHTn5AdmUcQT7ThuPSWvY20RLKKp9OjY3exIrZ24CqnN1fteBE/Vv5vFHgjaeeD4koZgslTed9hXR/j3gWZwgFJC3Wv9ypQcoZnfHbIYtQin0JRlD9Tk/GPCih4ql6IM1gZGm/SKJz+TFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588007; c=relaxed/simple;
	bh=mY37gv4cU4bTKCHgtCPxbbI8gj1NRpocdKIr8KdKw7Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gLrHcbahmE4STOZr9veNelLtoiX6UqpCrD+mAoJBX6/y25MF/te6K/n7Ugfux0RvxlmcTHkH9Jgcs43/4SjEkgbgqWmRNMgeVz+Qnny+D3Ih8OjzCUxou8eImVU+b2X4SR/8c02sUAJc29PfLjt69nJmUXpdTigPk9iisfwWQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so60001575ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588005; x=1734192805;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUrQDzN9AHJLh25wRvT6z1yEx9G9wmlZLgboaQ8qVgs=;
        b=phCtI42vz6zSpvB0s0LJFWGvfWIS76xkZGBWkcyK4ksKBDEHJQWUgk1Vy+bGyrj/sl
         ToWNJ6pAWguHbfVz1ltUXUt5vUhoH8epmgCK+CMoFr/p5vgaUT4Egs3BwDbMXA78zAAJ
         zQl0A08Mw6tkHTx3ZvKsXlF2NFJbsG4WCy4S8+21UbzEn30jmPYf2nPSzEDsYFi5kdc1
         9SJnbJuGX7unOGwvnlM4GKIvQsUC/EuhPYVFNPETvaDdpgt1C/fGb+E/PXOKpR0xeh8l
         Hzf8f2Z3FqkCi514utxwJnNZejrJ2yryDG5Qnw/xOXTUt4l26tQ/RcKWJgwno/DTnItp
         lTnA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Aj1zaBt54kiF+mSXPdnQS0h+B7uueVQhMgnE9uPq/8cM4hZTTc4x4jeHSuQUPmMOwbo3tI8+fr9nQJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimjS00TX71NgvL/T76bav7/7XI+Y89IFJiP+oCd5YbCSKeGsl
	waovS7sTYDPzKcrybuXFntuHHzlMP4zHxLpMXq6X+4w2Ia5LgjJ/dFa5hrAsy2NXawxP/nNr6sd
	O0qprKiMbd0rCtcZynjEWK0Lm+j5RTD8D9+2yRrpuAwWpb2IXERwK4XU=
X-Google-Smtp-Source: AGHT+IElodjuH2b5YmzrBcZ3q9FTmZSsCrhZxwFxI1VC92k+k0Nij7Rw2YWUYNtcDvQIqX4jnyhO/HfZDDPB4i1hYDkgzrCxFcep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:3a7:81d6:c177 with SMTP id
 e9e14a558f8ab-3a811dc98afmr76675455ab.14.1733588004903; Sat, 07 Dec 2024
 08:13:24 -0800 (PST)
Date: Sat, 07 Dec 2024 08:13:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67547424.050a0220.2477f.0018.GAE@google.com>
Subject: [syzbot] [bluetooth?] BUG: unable to handle kernel paging request in hci_release_dev
From: syzbot <syzbot+e95a6bdd366a24c1bd70@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13c76fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bc44a6de1ceb5d6
dashboard link: https://syzkaller.appspot.com/bug?extid=e95a6bdd366a24c1bd70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d4a0162c7c3/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8c47a4be472/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e173b91f83e/Image-7b1d1d4c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e95a6bdd366a24c1bd70@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 001f7fe000185fc1
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[001f7fe000185fc1] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6614 Comm: syz.4.9 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0xfc/0x77c8 kernel/locking/lockdep.c:5065
lr : lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
sp : ffff8000a26d73a0
x29: ffff8000a26d7660 x28: ffff80008025d2e8 x27: 0000000000000000
x26: ffff0001b36404c0 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: 1ffff00011f1a0bc x21: 00ffff0000c2fe08
x20: 0000000000000001 x19: 0000000000000000 x18: ffff8000a26d72e0
x17: 0000000000023976 x16: ffff8000831615b0 x15: 0000000000000001
x14: 1fffe000185fbe00 x13: dfff800000000000 x12: ffff7000144dae9c
x11: ffff800080359554 x10: ffff80008f8d05e4 x9 : 00000000000000f3
x8 : 001fffe000185fc1 x7 : ffff80008025d2e8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00ffff0000c2fe08
Call trace:
 __lock_acquire+0xfc/0x77c8 kernel/locking/lockdep.c:5065 (P)
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825 (L)
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x58/0x70 kernel/locking/spinlock.c:170
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 destroy_workqueue+0x8d8/0xdc0 kernel/workqueue.c:5883
 hci_release_dev+0x118/0x11a4 net/bluetooth/hci_core.c:2733
 bt_host_release+0x70/0x88 net/bluetooth/hci_sysfs.c:94
 device_release+0x8c/0x1ac
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2a8/0x41c lib/kobject.c:737
 put_device+0x28/0x40 drivers/base/core.c:3780
 hci_free_dev+0x24/0x34 net/bluetooth/hci_core.c:2565
 hci_uart_tty_close+0x184/0x2a0 drivers/bluetooth/hci_ldisc.c:555
 tty_ldisc_close drivers/tty/tty_ldisc.c:455 [inline]
 tty_ldisc_kill+0x1b0/0x300 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x190/0x23c drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x34/0xd4 drivers/tty/tty_io.c:1690
 tty_release+0xb64/0x1014 drivers/tty/tty_io.c:1861
 __fput+0x1bc/0x75c fs/file_table.c:431
 ____fput+0x20/0x30 fs/file_table.c:459
 task_work_run+0x230/0x2e0 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: f007aba8 b945e508 34008c88 d343fea8 (386d6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f007aba8 	adrp	x8, 0xf577000
   4:	b945e508 	ldr	w8, [x8, #1508]
   8:	34008c88 	cbz	w8, 0x1198
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	386d6908 	ldrb	w8, [x8, x13] <-- trapping instruction


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

