Return-Path: <linux-kernel+bounces-178232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8228C4AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A38B22D55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53621878;
	Tue, 14 May 2024 01:10:29 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93D17CD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649029; cv=none; b=bIiH0KnIJcgryYBF300CeKoAKi+31A2eyE7BKnWnv1NvOpQliLBxM2zL66cf4T7H87TZqRxaxOTzDkw5MAqvEiG7EfawZNOEXKGPc0vlW72u7ssSH42u9+qRqR5aCs+LzllY0D2ZvmM33v7ymdYwW3vAlhPNEZ6j9wizgL1502M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649029; c=relaxed/simple;
	bh=9Hc909+0M5FP5KmSKA//JtVHEwXLd4+BakwThkuIvt4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I7fXdSVzHZ8o4NcIaBeKtVzDBPrhzhFNSxRWuDJ3kDP1liKcLuulXguptNlfdSZRyaIrVwnHHice9zNQ9Eh4OHcFrYOs4vyu2WdLy89/BmD+JsVIBGIKfowj3Aa2MSAR2EOeAu4WL0/qx3GOHl+VgDWjXmGMjcKEBHRwmAJG8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1bbace584so439667339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715649027; x=1716253827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zx2V0pQQ05Sh+gNvaZZexhSOOCwudaLNE/A8Hkrvguw=;
        b=bRcnXaBOk1A+T4WCvanbBsnqghmBv92ZGj3FmG62BaBq4TqSXOOpjg0/nUj49+RZAq
         8MjUjrPGkFYKUccgm8fFvwk069D9kwXZ/jCfLqbIlDLoFiCqWhMvRt290t8oGrYoWKIC
         J35SL9TRz+xW1kGz0RWH0dUrspi4x/+Fz/J+tKVnzWwnMz0zRW/X6fQmeWMtyx440llS
         EdhkUIO6G7axJPbu93glX8GsiGPCNsUHHNi1IAPlKRrxA+UIxqO8LrvxAIOC5Lq9e6Vi
         DGYtke3juNxzO3ULBef+wbVyjVpeMWp9LTYoJT7dKthGo6viOXG0bOUzW5XP6QlA1tpM
         g4jw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GWmbEziNatF0bFxQqX0VLnCCr+DjXfmQ5UdNajJv/i3Iy/wDL16pgwvfgDgaDwf5EqbbpjyeWSExOI85ROWwFKiSbAvUr4Dce9/x
X-Gm-Message-State: AOJu0YyLUGDE4KTOu0GIe0OOZKGewP4LaSkSrZ52FsUSO7EC8zFbQsGZ
	5GQzhrNoNk/U3o0QWyosqiTpNoZ7hLhy+71RbU283o+KqGbN3Td7sX5rt74Dn8pSdMI+ukBe75v
	M1DgojLAf/+xnhjjsUsKmAsl6c5ARmPL0bmQyrJANYhJzMGuz8xhmaS4=
X-Google-Smtp-Source: AGHT+IGlumd0Dr4BMELvckwlS9c7grP1zoxjtV4WcQZdUVX94UCZJG5AtlcpJN+jVA89uH/tgY3rBr6YewUDF1q1dTRVqsFEFpck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150b:b0:488:dd9c:2483 with SMTP id
 8926c6da1cb9f-4895912b334mr905078173.5.1715649027090; Mon, 13 May 2024
 18:10:27 -0700 (PDT)
Date: Mon, 13 May 2024 18:10:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1bc1e06185faac7@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_invalid
From: syzbot <syzbot+84fa6fb8c7f98b93cdea@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131d2c00980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=84fa6fb8c7f98b93cdea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152df3bc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130d8f88980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/232e7c2a73a5/disk-45db3ab7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e9bf7c936ab/vmlinux-45db3ab7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e8f98ee02d8/bzImage-45db3ab7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec73bbe3e40c/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84fa6fb8c7f98b93cdea@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_dirent_name_bytes fs/bcachefs/dirent.c:24 [inline]
BUG: KMSAN: uninit-value in bch2_dirent_get_name fs/bcachefs/dirent.c:34 [inline]
BUG: KMSAN: uninit-value in bch2_dirent_invalid+0x1ea/0xa30 fs/bcachefs/dirent.c:105
 bch2_dirent_name_bytes fs/bcachefs/dirent.c:24 [inline]
 bch2_dirent_get_name fs/bcachefs/dirent.c:34 [inline]
 bch2_dirent_invalid+0x1ea/0xa30 fs/bcachefs/dirent.c:105
 bch2_bkey_val_invalid+0x24f/0x380 fs/bcachefs/bkey_methods.c:140
 bset_key_invalid fs/bcachefs/btree_io.c:831 [inline]
 validate_bset_keys+0x12d8/0x25d0 fs/bcachefs/btree_io.c:904
 validate_bset_for_write+0x1dd/0x340 fs/bcachefs/btree_io.c:1945
 __bch2_btree_node_write+0x5383/0x67c0 fs/bcachefs/btree_io.c:2155
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 __bch2_journal_reclaim+0xd88/0x1610 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:727
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:511 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:46 [inline]
 bch2_sort_keys+0x2051/0x2cb0 fs/bcachefs/bkey_sort.c:194
 __bch2_btree_node_write+0x3acd/0x67c0 fs/bcachefs/btree_io.c:2100
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 __bch2_journal_reclaim+0xd88/0x1610 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:727
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
 btree_bounce_alloc fs/bcachefs/btree_io.c:118 [inline]
 bch2_btree_node_read_done+0x4e68/0x75e0 fs/bcachefs/btree_io.c:1185
 btree_node_read_work+0x8a5/0x1eb0 fs/bcachefs/btree_io.c:1324
 bch2_btree_node_read+0x3d42/0x4b50
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
 bch2_btree_root_read+0xa6c/0x13d0 fs/bcachefs/btree_io.c:1772
 read_btree_roots+0x454/0xee0 fs/bcachefs/recovery.c:457
 bch2_fs_recovery+0x7b6a/0x93e0 fs/bcachefs/recovery.c:785
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1043
 bch2_fs_open+0x152a/0x15f0 fs/bcachefs/super.c:2105
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

CPU: 0 PID: 5037 Comm: bch-reclaim/loo Not tainted 6.9.0-rc7-syzkaller-00056-g45db3ab70092 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

