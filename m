Return-Path: <linux-kernel+bounces-545905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36350A4F358
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466401890124
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0C5FDA7;
	Wed,  5 Mar 2025 01:17:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F5D531
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137424; cv=none; b=ZvgcZDEngc5cQWHNAS14pFYzlB3HlwFOGSI1A9+J09vKuHMc/5AiPsInrmN2MEFQOS3uFhTm4ihMcdoOErNrwYOlCNg8OKiKSH04QxydHZfM/oZwntYkhWgYSqse08PWbeaDwfMAdH/kT1LcQbYCWMtU16GnDTPHFeCz68a7gsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137424; c=relaxed/simple;
	bh=4JWeZG05MaVeCiEtRd9r9slYa8pA05ks+fbjKrtlAT4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y5d4vF6sJ/H6IQjHY76cXSozMl7wHA45HtfoZIe/dUdLF+YPaMFAgbt1Fjau/LnUTEd63ipJ5Pedd6tLv0R6X75UXInMuXtmsIUeijI+LO59sLDqUbn9tPjqr1+HSXQ9Es3gD30Lqx8Pbu9Om26WlDYeMX9Zq4EfzlEOI+/CXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso49710715ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 17:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137421; x=1741742221;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIbAFDqXhdZl8YX46KxJs47fWz5Vjm50+lQZ0dDlFWg=;
        b=FAzitv7r8+K96goirVaL34cWnFDDXrQGKRMtpp4XIk3TYqXMyaETjzECXyrEdBhDx1
         d0wkpJc9UKoOUwDLxYPz8ku5vO3kmH2fbX6xPvK7Wk7cvzKt+12lY4Fz9j+LzprXj9rg
         3vK/eYVmq668sPITTdsMihdlFl3tOYUWEtEQAkDeMM3PIUV34yhwI7aq9x9Gf8JDlKg7
         akiz9ePDJEUlTaxIVM+d5Jd7MTVx/3s2j4TNjfdNA+/HiJ3dHTeB0RDTXaUUcdfbzABq
         La1TQZmvJgLzV3jxBw7TgYuyl/iQqCk14juMm+vwMZqNMUNdavBaa5v2jlRhyQvlo/C+
         6h7w==
X-Forwarded-Encrypted: i=1; AJvYcCVWZiv8DSNeWJVhOrCGPbtokzWczYeMbXD1usVOEKehP5i5xru4d4o0HWXwD2P9YKTpo7yJDyhS5Ftrr/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJJBmvi+1ddpwiMblueJzr48ZRMeW+1rq12Wm3L1xzsFAcahg
	isfYqdpvm39cOGkGoXheAvw5weo8tct8263PgccZ/0z9ixVRdnKeQiJW4Nw07KsKrRcgWZUG6Me
	hjHGV8bz9bsZe6vD7TEer+/5dZlhSRPspCGlKNhNNWfaS6ktnslaDf0U=
X-Google-Smtp-Source: AGHT+IFUl5NaP8DjXWsG+AZnVRqNt+DIg7BJRJitXIZOX3xvC73OCZ9twLTFoCndKRzloIFvcJ09PXtrxUcHpkwQVSFZ+6JSXHxU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:3d3:e29c:a1a5 with SMTP id
 e9e14a558f8ab-3d42b97b79amr18948455ab.18.1741137421589; Tue, 04 Mar 2025
 17:17:01 -0800 (PST)
Date: Tue, 04 Mar 2025 17:17:01 -0800
In-Reply-To: <tencent_DBDF1933CFD60D9B25D30DB592655DEFDD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c7a60d.050a0220.15b4b9.001a.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in __mm_populate

mm2: 00000000b643f24a, map held lock: 0, vma: 00000000ff43f796, ret: -14, __get_user_pages
mm: 00000000b643f24a, vma: 00000000ff43f796, mmap lock held: 0, locked: 1, ret: -14, mm addr is valid: 1, __mm_populate
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-ge056da87c780-dirty #0 Not tainted
-------------------------------------
syz.0.16/7207 is trying to release lock (&mm->mmap_lock) at:
[<ffff800080a640f0>] mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
[<ffff800080a640f0>] __mm_populate+0x4e0/0x590 mm/gup.c:2055
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.0.16/7207.

stack backtrace:
CPU: 1 UID: 0 PID: 7207 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780-dirty #0
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
 __mm_populate+0x4e0/0x590 mm/gup.c:2055
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
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff0000d9a82be0, owner = 0x1, curr 0xffff0000ca89bd00, list empty
WARNING: CPU: 1 PID: 7207 at kernel/locking/rwsem.c:1346 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
Modules linked in:
CPU: 1 UID: 0 PID: 7207 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
lr : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
sp : ffff80009d6379c0
x29: ffff80009d637a40
 x28: 1ffff00011f780cb x27: ffff80008fbc0000
x26: dfff800000000000 x25: ffffffffffffff00 x24: ffff0000d9a82c38
x23: ffff0000d9a82be0
 x22: ffffffffffffff00
 x21: 0000000000000001
x20: ffff0000ca89bd00 x19: ffff0000d9a82be0 x18: ffff80009d637288
x17: 0000000000000000
 x16: ffff80008b7c56dc
 x15: 0000000000000001
x14: 1ffff00011f8fe00 x13: ffff80009d638000 x12: ffff80009d637490
x11: 0000000000000003 x10: 0000000000ff0100 x9 : ab50c55cae2af500
x8 : ab50c55cae2af500 x7 : 205b5d3439343135 x6 : ffff8000804a97f4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000ca89bd00 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346 (P)
 up_read+0x2c/0x3c kernel/locking/rwsem.c:1620
 mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
 __mm_populate+0x4e0/0x590 mm/gup.c:2055
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
irq event stamp: 73577
hardirqs last  enabled at (73577): [<ffff8000803d4c78>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1533 [inline]
hardirqs last  enabled at (73577): [<ffff8000803d4c78>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5132
hardirqs last disabled at (73576): [<ffff80008b7cfc44>] __schedule+0x2bc/0x257c kernel/sched/core.c:6668
softirqs last  enabled at (73528): [<ffff800080311b48>] softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (73528): [<ffff800080311b48>] handle_softirqs+0xb44/0xd34 kernel/softirq.c:589
softirqs last disabled at (73505): [<ffff800080020dbc>] __do_softirq+0x14/0x20 kernel/softirq.c:595
---[ end trace 0000000000000000 ]---


Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11809c64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1017bc64580000


