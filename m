Return-Path: <linux-kernel+bounces-175458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1F8C1FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B71F21C15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3E15ECFA;
	Fri, 10 May 2024 08:45:43 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435977119
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330742; cv=none; b=bXR2SzG6AXFL61E3tiWwQi8L3hrOopqHzTbxSBB2dzL5OvOrnvNCYspzpNSD98wlWInLUPLJspdLCAk9PZkQ2VQNpLInjavWTeu+iY4hK+9UNxXT3edPBpEMybsLA9d6pzBWiNOf/RkTMTbBsH2wolCf7A0qGYHb9tPpR39rbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330742; c=relaxed/simple;
	bh=BDF9cgmrLahewf/VVc/0cj9BYwYmheq0Yy4oWYazeTI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Go/JOFNQMLnvleNa6ErwMEr54DGVuIGVG2j3gkk6bOGcKZjVrbF80X5+3eeZrA4GuGRqEa8tETXBZps3PQkmsFKVbFCFcCIEWD90qATtLhxSSdCrHaVFX2lzif7OUPKTO7KVGWWA/QcuNw9EwLS4+sMKgnr/BAFnw0/sD9kzBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e182885d98so196561939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330740; x=1715935540;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRsm4pB8/VaBHzboVqr2bGRZ82LTcrxc7Q0z4o++KUY=;
        b=EJ+whIYL8iHksEgx+WmRkH1pRZca4dTjQLwBvs+98KJlBcXfg1uB9mhVEAnSmj+ZBP
         kgxHpYsRK8R85HH9IgMYCLriilnYn2FRmCKRDCcC6CZXrzLCCfJs+OhpmYX+VUPJwhyM
         qlOFYpFGrxaVjIGl+mxWZHZVEDypEXitM2YBiO1ymMYGO/We4KilXzo/u2fzkIvQStZT
         +hLEHkw+uEQjQuCxWGp5CcmLRgbLevUhzT2C/NHDEQjD8lWWELgtbZb7KbNzPFzkp0Lk
         W+FESNgEfEFolfU8V/jJwFGqVkasM7DyOAEzNudRIT0QlniajATR4UUYAiwGIzjcVjuV
         86qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7/iP0TAChPNSQMQH38Tb2bOU26d0aJupTGYCngbz5SVchyaMnjBJG2+UZ5NsZnJfbYk+ah2i8wPm81Xo6td8m6AD8UQbopHtzKBeV
X-Gm-Message-State: AOJu0Yx054TkEUk0x2uqgAneHjbgL3WdqbZIycceuzfzaQivuP8Wq0cU
	h0Fd5O+PTvus9oiuLKa4s9Hz0gPjEagSgG+TY4ndht0rWyP9g7FFnATBkbvZN0WLGML3GtnOoz2
	Qk5mvm0/BPrg6rML1G8gZvT9G+fyn+o1Lqnu+JMUsclNqcPvxzKhg49o=
X-Google-Smtp-Source: AGHT+IHg7t9T26F7tFDYRm3DItP+905oKiJVpcbNJ4ZW9d5E0fpbo6m0Ht7oWITbqzPJwRlOCTsoye/G19PU4zI22UqnDD4uW4mN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:488:5ceb:9533 with SMTP id
 8926c6da1cb9f-48957ec306dmr135291173.0.1715330739398; Fri, 10 May 2024
 01:45:39 -0700 (PDT)
Date: Fri, 10 May 2024 01:45:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064f7a40618158fd5@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_checksum_update
From: syzbot <syzbot+8d0e17030490d2299222@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bc7d04980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=8d0e17030490d2299222
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b58970980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/232e7c2a73a5/disk-45db3ab7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e9bf7c936ab/vmlinux-45db3ab7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e8f98ee02d8/bzImage-45db3ab7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3f122e1fb69e/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d0e17030490d2299222@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc64_be+0x202/0x310 lib/crc64.c:59
 crc64_be+0x202/0x310 lib/crc64.c:59
 bch2_checksum_update+0x15e/0x1d0 fs/bcachefs/checksum.c:87
 bch2_checksum+0x3c5/0x7c0 fs/bcachefs/checksum.c:216
 __bch2_btree_node_write+0x528c/0x67c0 fs/bcachefs/btree_io.c:2151
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:829 [inline]
 btree_interior_update_work+0x3e09/0x47f0 fs/bcachefs/btree_update_interior.c:857
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:511 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:46 [inline]
 bch2_sort_keys+0x1b4d/0x2cb0 fs/bcachefs/bkey_sort.c:194
 __bch2_btree_node_write+0x3acd/0x67c0 fs/bcachefs/btree_io.c:2100
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:829 [inline]
 btree_interior_update_work+0x3e09/0x47f0 fs/bcachefs/btree_update_interior.c:857
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3927
 __do_kmalloc_node mm/slub.c:3960 [inline]
 __kmalloc_node+0xb10/0x10c0 mm/slub.c:3979
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 btree_node_data_alloc fs/bcachefs/btree_cache.c:98 [inline]
 __bch2_btree_node_mem_alloc+0x2cf/0x9d0 fs/bcachefs/btree_cache.c:143
 bch2_fs_btree_cache_init+0x4d1/0x960 fs/bcachefs/btree_cache.c:479
 bch2_fs_alloc+0x33ca/0x4210 fs/bcachefs/super.c:923
 bch2_fs_open+0xd9b/0x15f0 fs/bcachefs/super.c:2084
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1903
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 3712 Comm: kworker/u8:21 Not tainted 6.9.0-rc7-syzkaller-00056-g45db3ab70092 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: btree_update btree_interior_update_work
=====================================================


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

