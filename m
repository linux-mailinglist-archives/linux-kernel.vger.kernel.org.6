Return-Path: <linux-kernel+bounces-544225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F7A4DF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F12D188C88F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE662040A8;
	Tue,  4 Mar 2025 13:19:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14865202977
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094344; cv=none; b=efMP7hC1hMMdD0i8rUgM4XKEqaeqdWm4hHpcjzUHRnv1blkPNqjyleq+uPDKS34ksiMz25YAG0jwZDmeFAMVa27cx4xXy8wFn5Xm5nLSBVvEH9YQCzsXhShQdu7zguS7gT/w4wIYXt144L+vsQrJuIr6vdpwMafhNZlnRxMIiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094344; c=relaxed/simple;
	bh=Ib6Bkhe2dkdXNKo65leYaRGh+Z38gPJe6OAGqV39zAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TKCVU2BMsE6VLKF1pwoTvPhFRhH1ELOdjZLzKGSKWYqG8169vokI4M+qHRHBlPRNmVOrU20YbSXXmUMtqGmRDSinTK5IPcK4gi4xKHsS7n3oAUlvBREv0uW5BSbM41VsbwivJuTIaURwZa+ZUWpXdzyJauSwXYxvD++Sp3NeL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a6102c1aso132813155ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094342; x=1741699142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pd5Z1XscTEg5Eg98KWcCxo/rxj6KfcqY4fBd0WTbbsE=;
        b=qhqMHT9xljHxtn2fc1+H4jVBEi3469DnMEPjo8nG3I5yGj0cMg8rQMeslr8keV56kW
         Z4D56xjBXybIidWiDvwd6EVAWLYP9ZHCBSMshGyqS2tq/5R3MFpoLScTzlQZX0rccepO
         V+8oGnhQMwbVzyr+dZdXIHsnPLRsMsSwPx95zf40K8cehcPnw75xi7FMWVKPmYN/QVJJ
         WGPtIUQ6YAoy3sZc4/fwJV/el1oFJs5vyjrHqmaYd6QIn9vKK9PdHBpPo5iwxMnf4OvY
         n6abmylPYu0vMxrCAnwTMnxdiFarmMVcGqpggEFS68OgH9lvGwTl069w9tg9nHUR73Pr
         0ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCW+uCR0H1nMRNKa8W/AJdilfBvPV9aOUytXm5cik3p9V5ZtWRC94ERu4ciirarmhXfSUGA1JrAtUdMiOlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDOWcP0iFkrCsj/cLh/C9JGxRsuXttwa+jv9Hxx1dYJp7b7Cm
	CzgU3E7RANmlmHLLVi3ryFk0b0z9wlquMRQmvuf8uxGe9EgLmUxUE2atIrC7leuW693Z0WxQIY1
	t8EbGn6dWBUcUV/fbgs5xBNjhrng1Dy681P8NSgrChlkKH3HEJ9+p7wU=
X-Google-Smtp-Source: AGHT+IF0R4uDy07nerIOy+Dzz3yHkgHtlR/3CAI6xvFGoLKw2aliIfqP8J9jOtimY7G3uJMFo+uCKaEzO/JlFXAGDnac1LdLSyIp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:3d2:b0f1:f5b5 with SMTP id
 e9e14a558f8ab-3d3e6e64ceemr178654645ab.3.1741094342127; Tue, 04 Mar 2025
 05:19:02 -0800 (PST)
Date: Tue, 04 Mar 2025 05:19:02 -0800
In-Reply-To: <tencent_D86ED06EEDCC9767C7C6E012F1065F09AA06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c6fdc6.050a0220.38b91b.0180.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in __mm_populate

XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
mm: 000000001ba89fe1, mmap lock held: 0, locked: 1, __mm_populate
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-00034-ge056da87c780-dirty #0 Not tainted
-------------------------------------
syz.0.16/7463 is trying to release lock (&mm->mmap_lock) at:
[<ffff800080a63ca4>] mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
[<ffff800080a63ca4>] __mm_populate+0x378/0x42c mm/gup.c:2045
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.0.16/7463.

stack backtrace:
CPU: 1 UID: 0 PID: 7463 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-00034-ge056da87c780-dirty #0
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
 __mm_populate+0x378/0x42c mm/gup.c:2045
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x304/0x3c4 mm/util.c:580
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
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff0000d584dee0, owner = 0x1, curr 0xffff0000c4da5b80, list empty
WARNING: CPU: 1 PID: 7463 at kernel/locking/rwsem.c:1346 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
Modules linked in:
CPU: 1 UID: 0 PID: 7463 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-00034-ge056da87c780-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
lr : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
sp : ffff80009e0979e0
x29: ffff80009e097a60 x28: 1ffff00011f760cb x27: ffff80008fbb0000
x26: dfff800000000000 x25: ffffffffffffff00 x24: ffff0000d584df38
x23: ffff0000d584dee0 x22: ffffffffffffff00 x21: 0000000000000001
x20: ffff0000c4da5b80 x19: ffff0000d584dee0 x18: 0000000000000008
x17: 0000000000000000 x16: ffff8000832b41c0 x15: 0000000000000001
x14: 1ffff00013c12e94 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 3ef51d0da1723500
x8 : 3ef51d0da1723500 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009e097198 x4 : ffff80008fc9f780 x3 : ffff8000832461d4
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346 (P)
 up_read+0x2c/0x3c kernel/locking/rwsem.c:1620
 mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
 __mm_populate+0x378/0x42c mm/gup.c:2045
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x304/0x3c4 mm/util.c:580
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
irq event stamp: 75153
hardirqs last  enabled at (75153): [<ffff8000804aebf4>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (75153): [<ffff8000804aebf4>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2869
hardirqs last disabled at (75152): [<ffff8000804aebdc>] __up_console_sem kernel/printk/printk.c:342 [inline]
hardirqs last disabled at (75152): [<ffff8000804aebdc>] __console_unlock+0x58/0xc4 kernel/printk/printk.c:2869
softirqs last  enabled at (74970): [<ffff8000801283e0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (74968): [<ffff8000801283ac>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11f31464580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f51464580000


