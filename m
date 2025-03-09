Return-Path: <linux-kernel+bounces-553066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D01A582F6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A8E3AE419
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81731A840D;
	Sun,  9 Mar 2025 10:19:23 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0389EAC7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515563; cv=none; b=BMFRvQfpQQWWK6YrHD42wCm0xr7gYOH+wBC0T3LHmo0c2k9abVB3vUkibMJ8LxAQrn0cUfKFzgWVqjNW350rBtYhwWcOkfefKtT5b7tLsKTixK2GSX5IU+5RdFqgGWRxB6uscktGtdSNRpgu/6Jb7OFQiX8KiBg4/5DIUYbEdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515563; c=relaxed/simple;
	bh=P3w9VELhttHHLA5S72L9ssLnAB9ai/XhYofAnXm2ax4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i/TfkzAP1FFzIc2wmawJs+HMp7ptQ46sb0b7KaLoWoVwoopna1Px5Eh8oPn/SzlwXeiQGLhAy65GYcnRI8LPQSSTRhJxgb3XbuKWq3rcs5W6w8qUaDgG/N39+Z0zGX5LX4J+WyPsVJ5nHUEb0Aq/NV44BHEyCNu9+6kWPIbzBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso26635065ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515561; x=1742120361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAxv8kiv3mmXBiHZOc3sflvV1FtjTdvV5UgG/FYak5M=;
        b=s0yN/IwdIDR3BxCtQ0LrcyAT4+giJF/tlZBfN9Nn6x0dDmGuKjD9y3VG3qYUTKKxLY
         I4gc5R2NSiDeuBCMQy1rKMz67pBL5v78cnor3kkIjPsGHexsDR8VDJBF8tUv8hNEJpI+
         /xHbmc5Wyt1JCkS8zOa9t9DIkyJ77gbvS8HwuPJ0i5Qo4FYODwSiBAlm5iI328UJoCXM
         T+kzquVkbSNcFZQ1cDW9oHvprIBFa2zjumLy8Xsic8fP+VNZPR+1S+WSg7JicEE7GMEh
         +gPe2+ajjE0PmbAAz15pVU+bqnvS3wbdKQgQJK6YYXR6gHfB27cZmdZ4G3T+WWzLxYAn
         9XUA==
X-Gm-Message-State: AOJu0Yy08KU7iwZ+ZetJesZsDhRWATJcIBI9lWnlD1FACk6DFGgvtrmd
	lrhVyb6QCJwYIDapjHlanUu+4qtoIbMFoERZLJujiQYJ5DxMXCX5WtOyVa/FM7cl73jBAc47F6w
	ijZhnWhUiGJYKMXTkXk/Q8Kb26Il51aWNLFATa3z+fl9cD1YstzjliiBpog==
X-Google-Smtp-Source: AGHT+IGMAYT/0tknWFOM0eABwtpAw4Q6cD/tgjurgtJE/6IHt5anmpJCHEgiQjf2m4pWJHsBwytorRq072k7ZZO0qwuwNsGRo87a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3d4:2a4e:1272 with SMTP id
 e9e14a558f8ab-3d441a46c62mr117794165ab.19.1741515561024; Sun, 09 Mar 2025
 03:19:21 -0700 (PDT)
Date: Sun, 09 Mar 2025 03:19:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd6b29.050a0220.24a339.00c9.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in alloc_pid
From: syzbot <syzbot+21e941390e11695ad9e1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1103d7a0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=21e941390e11695ad9e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d8b1b7cc4c0/disk-e056da87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b84c04cff235/vmlinux-e056da87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ae4d0525881/Image-e056da87.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21e941390e11695ad9e1@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "->lock" with key init_kmem_cache_cpus.__key, but found a different class "&c->lock" with the same key
WARNING: CPU: 1 PID: 7232 at kernel/locking/lockdep.c:941 look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 1 UID: 0 PID: 7232 Comm: syz.1.161 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:938
lr : look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:938
sp : ffff80009edc7120
x29: ffff80009edc7120 x28: dfff800000000000 x27: 0000000000000000
x26: ffff800097797900 x25: ffff800097797000 x24: 0000000000000001
x23: 0000000000000000 x22: 1ffff00011f780cb x21: ffff8000977f86e0
x20: fffffdffbf7049e0 x19: ffff80009326a528 x18: 0000000000000008
x17: 202c79656b5f5f2e x16: ffff8000832b5180 x15: 0000000000000001
x14: 1fffe000366f60f2 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000080000 x10: 000000000007e053 x9 : 97b380b684c48600
x8 : 97b380b684c48600 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009edc68d8 x4 : ffff80008fcaf780 x3 : ffff800080741744
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:938 (P)
 register_lock_class+0x8c/0x6b4 kernel/locking/lockdep.c:1292
 __lock_acquire+0x18c/0x7904 kernel/locking/lockdep.c:5103
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5851
 local_lock_acquire+0x3c/0x98 include/linux/local_lock_internal.h:29
 ___slab_alloc+0xcd0/0xf4c mm/slub.c:3875
 __slab_alloc+0x74/0xd0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0x300/0x410 mm/slub.c:4171
 alloc_pid+0xac/0xba8 kernel/pid.c:184
 copy_process+0x1a4c/0x322c kernel/fork.c:2419
 kernel_clone+0x1d8/0x82c kernel/fork.c:2815
 __do_sys_clone kernel/fork.c:2958 [inline]
 __se_sys_clone kernel/fork.c:2926 [inline]
 __arm64_sys_clone+0x1f8/0x270 kernel/fork.c:2926
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x1e0/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 1218
hardirqs last  enabled at (1217): [<ffff80008b7e75f8>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1217): [<ffff80008b7e75f8>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (1218): [<ffff800080b57dc8>] ___slab_alloc+0xca4/0xf4c mm/slub.c:3875
softirqs last  enabled at (800): [<ffff800080311b48>] softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (800): [<ffff800080311b48>] handle_softirqs+0xb44/0xd34 kernel/softirq.c:589
softirqs last disabled at (777): [<ffff800080020dbc>] __do_softirq+0x14/0x20 kernel/softirq.c:595
---[ end trace 0000000000000000 ]---


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

