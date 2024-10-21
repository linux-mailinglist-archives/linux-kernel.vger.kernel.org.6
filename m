Return-Path: <linux-kernel+bounces-373716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79C9A5A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7081D281443
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E801D0142;
	Mon, 21 Oct 2024 06:44:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CF1CFEA7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493070; cv=none; b=gED9e2q+8fDiPkvU0iGyYNegH6V7WPxuXC7XkDi21KVVVq5OXeyXvFkL833p7rB6oS91MIK3mj+M9iUE1rl79VvVkcyLB8iwvCWY5BJh7PRhSlLy6vs9z9Zy8w3ZRLqjyb+MbSGhHZZ1+tW4xRBQFUsYyLdfuHXhX6C/cjcDrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493070; c=relaxed/simple;
	bh=pPqt3RugRon24hNfN+Wo0Qd2b7xX+v0scX0th/xtPVk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mgehdq9gu4Vn5CDPSdKLVV3eTbabuuIu93/RM/r/R3HDyFiUwnMvZwi+N7I6Al0Wi7bAUwICg5daCFbbxc9tyi4SCvzwHup1PP+mFAQYcC2VxKsjW+HwNZv5/as5btlyH1GL2FVk+LzI4puG6HBnLAHzOOxwYZjUzZz13LAFYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so38828985ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729493068; x=1730097868;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoBkKRTOllHFi8zTnZEUwNteyoiy7CSSHa8XM1jHGKE=;
        b=n9046YL5i00KzIv8OX0JCKO/tjasttcq1PPTczZHsBxw4zMwKNPQdCt4p1sk1oNEph
         hkOlvLL0Artnc+G81fRJo/JNLu8ApRH2METJBI+zqOYk8919VnVLaR1CJVl2pB6ZbVVg
         6iH00gAAek6Ros43OoP2LaFB+hrPwo9dEMIJsTBUqr6x//WRVzj0HHmvgQupA5KuSrVm
         QHZLbDmsQ34bBHk/sSgv8iAq5o0wGkSVtK2N5Xo86J7vq/6eXGFRinxr0hHL0OrsUXXj
         z85N5apGJOQ+hlEJIz6sF9lHYO+0bL3HXWJ80I+YMeVknAi09MT2kZ15vUxc+FSW3lWx
         992A==
X-Forwarded-Encrypted: i=1; AJvYcCW7AIwPQ+a0xJMLMAy3Wh5b1wldeIGiRvnt/SYIRVoNwSx1hFHnaQjElCKuPjKNOZjxeGxW2FMUSd4C7Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK23OGyWw/t22cvk53Lh17Y9jgNd/vvJZaMa1FvOr6B/FxqD/2
	K1P6/NJdJauVthT318L0rR28VNq3Wla18JyE8EsHSTQf2JCClGqhGj8V3zQNgKJ8gLAWASCjJKV
	HsRz03yUSM+3fsyyAgkvqOx7ooiKaxBDNMDk2vzgorgf04Wh7Od3P7NQ=
X-Google-Smtp-Source: AGHT+IEDdJroIBNPT80drRkeuVN/w+F8f240nebGk8Hd5ZyrQnwZcTdIC1pgng7jRcNQ2RP83LQ78irISg30pkvTMyCT/laljQ4b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a3f404ff3amr86757085ab.2.1729493067862; Sun, 20 Oct 2024
 23:44:27 -0700 (PDT)
Date: Sun, 20 Oct 2024 23:44:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6715f84b.050a0220.10f4f4.003e.GAE@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_alloc_to_text
From: syzbot <syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d9745f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=7f45fa9805c40db3f108
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12637887980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1e830580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e937ef58569a/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1df9880ca4b/bzImage-c964ced7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/00439b875347/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com

bcachefs (loop0): fatal error - emergency read only
bcachefs (loop0): insufficient writeable journal devices available: have 0, need 1
rw journal devs: loop0
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/alloc_background.h:165:13
shift exponent 129 is too large for 32-bit type 'unsigned int'
CPU: 0 UID: 0 PID: 5104 Comm: syz-executor159 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 data_type_movable fs/bcachefs/alloc_background.h:165 [inline]
 alloc_lru_idx_fragmentation fs/bcachefs/alloc_background.h:171 [inline]
 bch2_alloc_to_text+0xc79/0xce0 fs/bcachefs/alloc_background.c:369
 __bch2_bkey_fsck_err+0x1c8/0x280 fs/bcachefs/error.c:454
 bch2_alloc_v4_validate+0x931/0xef0 fs/bcachefs/alloc_background.c:259
 bch2_btree_node_read_done+0x3e7e/0x5e90 fs/bcachefs/btree_io.c:1223
 btree_node_read_work+0x68b/0x1260 fs/bcachefs/btree_io.c:1327
 bch2_btree_node_read+0x2433/0x2a10
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1753 [inline]
 bch2_btree_root_read+0x617/0x7a0 fs/bcachefs/btree_io.c:1775
 read_btree_roots+0x296/0x840 fs/bcachefs/recovery.c:524
 bch2_fs_recovery+0x2585/0x39c0 fs/bcachefs/recovery.c:854
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b61a11dea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff7f9a888 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffff7f9a8a0 RCX: 00007f7b61a11dea
RDX: 00000000200058c0 RSI: 0000000020000100 RDI: 00007ffff7f9a8a0
RBP: 0000000000000004 R08: 00007ffff7f9a8e0 R09: 00000000000058c6
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffff7f9a8e0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
---[ end trace ]---


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

