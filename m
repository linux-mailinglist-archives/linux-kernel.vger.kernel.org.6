Return-Path: <linux-kernel+bounces-214878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E877908B70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263A61F2AA74
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94613199247;
	Fri, 14 Jun 2024 12:16:24 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D4194A52
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367383; cv=none; b=OCR6diEkYjbzQH2MKMmDap8EnKqCYQFSsB/gmDsxZLBtMuK9LFXZ0nqbCHHgNq7cJlD0aBnF99YKBB9NowQ6kJkXD3HGTtz/aEffglnDxmrTzxQSXPhFNC8Q+z5YbibovESLFF5FhSeDfrLNqW3WXnJPDzN548Eh7aS0owVFcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367383; c=relaxed/simple;
	bh=5ZIn50QEuy5g8lTS/39KTj9ViTp4Wd65hQrJIkAqswg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N5nJRliTBnI/Tx/AkpldzKhmW1HBVkpNTF0ODNUeuhIGU7LTc014HWyhWcQBo9CJXNSMqoi0XJmwL7Cb4eFK1RRBZDrFsIi+8xxcAftQylqCTWNyX2apaIbZMoOJLIU3nQiJOa+Wto6ph0L2abAY4vfpYxAeENW4wxhAM8+QfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-375a1820034so19255865ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367381; x=1718972181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnaqLvxNVbenZpNomvA557TtJVQBg60d0JVc0dY9pqA=;
        b=rAwF8FPq7XyVjF9jPw+fCnkSRFx/AXmh2kzxFQ2K6/iP02LK5hhIfbqJmVuR2DG8Ei
         NWhC/G8BBUkXxWuBjUdfXAxucUeg6QSrSd1bYh5riTZwveI7Tc/9KEeuTF/rqlCi6Ujx
         6v5AbYdWkr9LRdWk+5g/txRqMcbtPVQGHpu9nLdvyUPBXJVUMmJudEnqZSaB1uYZDZMm
         TiHc5OO3Z6QHHGOfPPyopqd9bbx87y63AyrL5BBeQtY8PRi7qt1YX9B6o4YX9JcCxwQ+
         n3A8gtciTuefUpZceH6d9z28fgZYRBVJCB0bVS6H2Sl5NJBbUV/Axe0F0Yl0T/cM/B8K
         y+6w==
X-Forwarded-Encrypted: i=1; AJvYcCWObMBFwpghujR4c2km0q9VZPe97w35DMmY3cNbDrkFfHhg9ftEpf9qnkxPVxL/PoOWpfDaomQKlaDF33MMyiBfdYIAXZRjuivJ3c48
X-Gm-Message-State: AOJu0Yw64rlZ8C0bGO8kbCxaDXGft22gFLFuZdEccDQ52qEUNzPue2nt
	XryWIFh1XO1elkv5PAL6/raRw8fHwGmvV3NW0H4WBelv/Jd8wvGg/ZdZ/7A1ctfidg8vIo2zy2n
	fvkp4vvk24wKCXIxAmsVtPFw3DqlKPSFM4TzndcH2UlGgMJSySONrilc=
X-Google-Smtp-Source: AGHT+IHhS6uhql/A02Jf4l/sNpOlYSyfkRpXg5RTgcD76sn9YH+d72myYw/ODhvtksdoaD2TMMTFeQoswbg47/Dej+W7qrDuudV6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:acd3:31b6 with SMTP id
 e9e14a558f8ab-375e0e3558emr1502975ab.2.1718367381318; Fri, 14 Jun 2024
 05:16:21 -0700 (PDT)
Date: Fri, 14 Jun 2024 05:16:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b7bce061ad89550@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_invalid (2)
From: syzbot <syzbot+f24f0d68e1a0dc1b8ec9@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17880156980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=f24f0d68e1a0dc1b8ec9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f24f0d68e1a0dc1b8ec9@syzkaller.appspotmail.com

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
 __bch2_btree_node_write+0x4777/0x67c0 fs/bcachefs/btree_io.c:2138
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 __bch2_journal_reclaim+0xd88/0x1610 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:727
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:511 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:46 [inline]
 bch2_sort_keys+0x1b4d/0x2cb0 fs/bcachefs/bkey_sort.c:194
 __bch2_btree_node_write+0x3acd/0x67c0 fs/bcachefs/btree_io.c:2100
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 __bch2_journal_reclaim+0xd88/0x1610 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:727
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3994
 __do_kmalloc_node mm/slub.c:4027 [inline]
 __kmalloc_node+0xb10/0x10c0 mm/slub.c:4046
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
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1906
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

CPU: 0 PID: 15565 Comm: bch-reclaim/loo Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
=====================================================


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

