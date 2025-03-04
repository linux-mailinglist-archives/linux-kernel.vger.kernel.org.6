Return-Path: <linux-kernel+bounces-544600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64903A4E2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FC042097E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB627E1A7;
	Tue,  4 Mar 2025 15:09:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA327D791
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100947; cv=none; b=eDVXMWsDQta3QZdK9iMnoLvy6gbkIefxBDv/p/FzDGUblG77L4AbNZBttUnlGcWTnay3vmo5pS8WS0yVlYOZUDYhvXDICxnDNiKHKwb0gk23t/xzF03gm+3h3AXoNp5JqHXhWPltb+jbrfZEv8tWjAb8DP29XQpa0Rdf4cg2Onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100947; c=relaxed/simple;
	bh=yxgJZ1WCtkDglJ+LjgRiE8IU2dc94GX/mwaVgTcbTVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SahNdLF1nN/T2/LVobVjsKP14pcK+6U4Qgob9l7P82ZF/MQYl4DIuZyY72f/qt2LnpC5BZxIBRFI6qxWKOtLg8U2OQR0h4y6MhcoR90snufh0ex+hCag0CLEWdDBCIIjwXjJXvZ1H/H7af6iu+4kOpulCqYJ56PI+iLOkftZXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85adc96a75fso175564239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100944; x=1741705744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0C9k5UtlIUzWolLK5AZ09SbJh9Of0qlLQYk1Kv1Qms=;
        b=bH6SUIe56Q18n0BP6l0I/ypsZtFKcwsA6/ZPjpxd1fKDKNRJ/ir7zZ0b16p0rV94cI
         szDjvk1JqLaxIPPl7RUcjbFmJcihSUUI1EcRK4Ca0TB/JVRojO4nmWfJK+TiG2qFBeMN
         3RNv2JK3aGRAxpNASKUXHELXlk3HKFc4mHyxB9x7yX994S+5VJCrEAdbJGL+KupsVNrR
         rVswzcwJ23GOyXJuieX31Dwv6RGdbNkslp9UQZ920Mz/vRICBuQD+8U/Z41TaCqpYvuo
         svZbyfK1GkxonAv1Scn7FiEfurenQcwY4MpJnvqCXP7KfevdjC9C0N6TBihIxEfNWb5q
         mnjw==
X-Forwarded-Encrypted: i=1; AJvYcCW7WbPlT3gsG3UDFsyBvybZRxnGN/WL0GSijTLb377d44WE7tIyTUNYwrwU/3KiFPHbc3RoRbnHJ8lh+ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22J/QwaRwNItBnyFms+jGUzWxwNHeccp4TExL4UZRuEzS2XH3
	MBnA24HXW9JgzQR6rXgaoZApne579ozqkXpNCj0k9LTfYeRKcTsdG+keaQwC2QgqTNocTD5ev+k
	QTKWlN+wrzWrWpYySV0bwTmem265v02yKe34wr+2qKGQS9FAaxMxfF5s=
X-Google-Smtp-Source: AGHT+IHOthu7SnghHJVzCg9DXcNCmS8r63VCSIm+OEIjNf8VoYaIHdA146lKNfCwt9nWMGgBRuaCFe6NO3Fa7gduUcRNJw0J6t74
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:3d1:863e:5536 with SMTP id
 e9e14a558f8ab-3d3e6f28e56mr181837725ab.18.1741100944719; Tue, 04 Mar 2025
 07:09:04 -0800 (PST)
Date: Tue, 04 Mar 2025 07:09:04 -0800
In-Reply-To: <tencent_46109430EBAEEFDACC98796A6F202EDD6C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c71790.050a0220.15b4b9.000f.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in __mm_populate

mm: 00000000b67e0d34, vma: 00000000f29ded2b, mmap lock held: 0, locked: 1, ret: -14, mm addr is valid: 1, __mm_populate
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-ge056da87c780-dirty #0 Not tainted
-------------------------------------
syz.0.16/7282 is trying to release lock (&mm->mmap_lock
) at:
[<ffff800080a62f10>] mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
[<ffff800080a62f10>] __mm_populate+0x5a0/0x670 mm/gup.c:2052
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.0.16/7282.

stack backtrace:
CPU: 0 UID: 0 PID: 7282 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_unlock_imbalance_bug+0x254/0x2ac kernel/locking/lockdep.c:5289
 __lock_release kernel/locking/lockdep.c:5518 [inline]
 lock_release+0x410/0x9e4 kernel/locking/lockdep.c:5872
 up_read+0x24/0x3c kernel/locking/rwsem.c:1619
 mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
 __mm_populate+0x5a0/0x670 mm/gup.c:2052
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x398/0x408 mm/util.c:581
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff0000d743e760, owner = 0x1, curr 0xffff0000c4563d00, list empty
WARNING: CPU: 0 PID: 7282 at kernel/locking/rwsem.c:1346 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
Modules linked in:
CPU: 0 UID: 0 PID: 7282 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
lr : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
sp : ffff8000a42a79a0
x29: ffff8000a42a7a20
 x28: 1ffff00011f760cb x27: ffff80008fbb0000
x26: dfff800000000000 x25: ffffffffffffff00 x24: ffff0000d743e7b8
x23: ffff0000d743e760 x22: ffffffffffffff00 x21: 0000000000000001
x20: ffff0000c4563d00 x19: ffff0000d743e760
 x18: ffff8000a42a7268
x17: 0000000000000000
 x16: ffff8000832b3460 x15: 0000000000000001
x14: 1ffff00014854e8c x13: 0000000000000000
 x12: 0000000000000000
x11: 0000000000000003
 x10: 0000000000ff0100 x9 : 5249a055953baa00
x8 : 5249a055953baa00 x7 : 205b5d3236333836 x6 : ffff8000804a97f4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800083245474

x2 : 0000000000000001
 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346 (P)
 up_read+0x2c/0x3c kernel/locking/rwsem.c:1620
 mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
 __mm_populate+0x5a0/0x670 mm/gup.c:2052
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x398/0x408 mm/util.c:581
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 76619
hardirqs last  enabled at (76619): [<ffff8000804afb08>] console_emit_next_record kernel/printk/printk.c:3130 [inline]
hardirqs last  enabled at (76619): [<ffff8000804afb08>] console_flush_all+0x678/0xb90 kernel/printk/printk.c:3210
hardirqs last disabled at (76618): [<ffff8000804afa44>] console_emit_next_record kernel/printk/printk.c:3115 [inline]
hardirqs last disabled at (76618): [<ffff8000804afa44>] console_flush_all+0x5b4/0xb90 kernel/printk/printk.c:3210
softirqs last  enabled at (76520): [<ffff800080311b48>] softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (76520): [<ffff800080311b48>] handle_softirqs+0xb44/0xd34 kernel/softirq.c:589
softirqs last disabled at (76395): [<ffff800080020dbc>] __do_softirq+0x14/0x20 kernel/softirq.c:595
---[ end trace 0000000000000000 ]---


Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14d2b5a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126b58b7980000


