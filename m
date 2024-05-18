Return-Path: <linux-kernel+bounces-182962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2920C8C9246
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C1B213EC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27681626DF;
	Sat, 18 May 2024 20:43:39 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373B53E11
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716065018; cv=none; b=PeEHxzVll0BtxqE9jsO4BiCdR2j+UAdWavC6eslA7OXNAgcMlcodu6DcTQN/gYCQeT2AXwLa8DMI6CYdLp0HpfuJUM+cRmlHOsdGfxv6g3XurMymI28D3LnPqFpuWJmEZbKQ00RU713sC9AGE0/A3Cwke2LSUJ3XHhAWUCF8NLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716065018; c=relaxed/simple;
	bh=XayhhKs5W56XNIS/yiISSy/ifrpRIakexWRL0yJ8DNM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YVNpAc3niTIvq0/ilB5lwNbKLS5qVa/YUJe5ksDe65lMZbkHIT/mMgX/vAPnbtJjW1Gt/TEg5rSymRmuZvJf0cn6oMyqSGs3uP39lGnaOUH0ji2A86nIFzVMxar8GTMJhop3brvjtCHF1cQahqzPsFnq7ssH68IYhVvmYFY7R4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ddf0219685so1245470939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716065016; x=1716669816;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/tRi7J9Dk1JIeQHPlU6XLpuklGtL7VCr0iD1LdQxwk=;
        b=kKA3ZKsI53BrcvpIzIl2Emb2w7w/uwmjjSfOFdJwWbsCwsQgvjprXInNx4Nd3Gxp6X
         a5aXnFwUdY4deOdImdUANcem3D+rZ7s0Jpm2a+N8TxxKeeF+yJ1Qd1AVtURsElAhiD9h
         ZybXELCaRGqS9bvjiMeT8HZY+nq6eiRe7cftsbRt9TPAGo15QaJduKJH1rh1OIyGEUSR
         Vgg5RGO9sr7WjmUBGHgdj9frHynYdfjxWWyXpFxiVcft6lx9iv3SJj4gNjsTmmwIgmQV
         RK7iBb/16pZATfNFyVa9++Tfmuz2sDZ67F83IudIgUuwHBBKSJJq1lOL0AQq3CZRdMOV
         FN8A==
X-Forwarded-Encrypted: i=1; AJvYcCVU2KuSK9eD1S8pY23igROxRqXnyq8hV2xMt1x36KBYMyj2RTN3ICSsByJAmu+z6dL+2INVg1Y87JauZpe78HJKXSDygnJQi6EbRTdG
X-Gm-Message-State: AOJu0YxqCQQXtJafLLIxq4tVr1Yhw4n8iPU+SErlsHcTxO6WztU+8Y2y
	Z6ry+nXQVew7Y4IMf8ZrOJqA1rvG6jL2/Oxhk4390baYPO0wZWRdO0LALve08kYjc9AyPAU5lzN
	1bCNGOp2424/Y2cXPOIERuKgCalyJD1+5KZkRwj72KxfzxOACBOuhsjw=
X-Google-Smtp-Source: AGHT+IHfQe6H1WxHzTcehDR08YuRfc5uMFj3ir5DUP7gq/GTcUz5zqTQKe56rzCHfy2wF2NqT3n3sNksVKk7Iw+DoxvJOwIS4z2o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3ca:b0:7de:e175:fd2d with SMTP id
 ca18e2360f4ac-7e1b521f29dmr204930539f.3.1716065016481; Sat, 18 May 2024
 13:43:36 -0700 (PDT)
Date: Sat, 18 May 2024 13:43:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b81e880618c085e7@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bset_fix_lookup_table
From: syzbot <syzbot+097987693500c9e31552@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5131c3fdf26 Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16133182980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e100d74625a6a5
dashboard link: https://syzkaller.appspot.com/bug?extid=097987693500c9e31552
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81edac548743/disk-a5131c3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/42f67aa888e5/vmlinux-a5131c3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e5cf5b3704d/bzImage-a5131c3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+097987693500c9e31552@syzkaller.appspotmail.com

bcachefs (loop0): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in bch2_bset_fix_lookup_table+0x15e1/0x1e90 fs/bcachefs/bset.c:986
 bch2_bset_fix_lookup_table+0x15e1/0x1e90 fs/bcachefs/bset.c:986
 bch2_bset_insert+0x1617/0x19f0 fs/bcachefs/bset.c:1042
 bch2_btree_bset_insert_key+0xf56/0x2b70 fs/bcachefs/btree_trans_commit.c:194
 bch2_btree_insert_key_leaf+0x276/0x1050 fs/bcachefs/btree_trans_commit.c:277
 bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:744 [inline]
 do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:854 [inline]
 __bch2_trans_commit+0x98e6/0xab10 fs/bcachefs/btree_trans_commit.c:1093
 bch2_trans_commit fs/bcachefs/btree_update.h:168 [inline]
 __bch2_create+0xe93/0x15d0 fs/bcachefs/fs.c:327
 bch2_mknod fs/bcachefs/fs.c:451 [inline]
 bch2_create+0xdd/0x1e0 fs/bcachefs/fs.c:465
 lookup_open fs/namei.c:3505 [inline]
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x2d74/0x5b00 fs/namei.c:3804
 do_filp_open+0x20e/0x590 fs/namei.c:3834
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1432
 x64_sys_call+0x3a64/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

CPU: 0 PID: 6538 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

