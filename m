Return-Path: <linux-kernel+bounces-296918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D743E95B09C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F4B27027
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E8165F11;
	Thu, 22 Aug 2024 08:33:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A68184538
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315608; cv=none; b=NLcSaOQZF/8Yb05yTM6RRagS4CHWIedwHiSptefAp2elBW0JWLR6PKaLCag/VdYIFPijyKRZpufVFQNUkCJMIQg3m5eZTViud51JB62DGzVuuBOpYU/hTEeUXALVN7l8J5uwQkBuiTM1TRZIwsn4zS8dOId0kqNawbGPfBKy7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315608; c=relaxed/simple;
	bh=S9LqJbUue2NmI27P20+JtZLnz5o0LiiCjLon4DQXcRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WTPz6wzuYLKOfpwPQvgylvY1d9jz/fen8Bguw/S04eLnryFmcxBGdhsH/8fxwcERhlGIR63OdWT0R0T5EExm2CamJx2T389+uwTskxpCRhyBACzS0m1ZWQpQZWdM+vwu13Bon9zHVkr1rZ5eQwXFnXArMnSnpaMN7F2jiuDpz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so6400075ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315604; x=1724920404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AXC5XHZThFajyn2Wh0sKPHHef6MxuiBJh0u0wO5Ttk=;
        b=s3I3RA9KucMW786Q76bLShKHd3DUehw2+xanVIocI1M3zG3r4RoKFpTqYs9Uz45I8o
         YAIu73Jw9auCGhiu662O9vnYTvLT1Hup5Xr6SwetY3TUJftVOODuUDFgMcItXYR+n41T
         DhFKek1ufgSpTqX7jBEZhP8rogvAiHfN1xf0CIlQckiI7n4ScAi+kcAd5CrJmBkcPTIr
         nAM47RI1OToU+i/FdbAwLjT/ddAUwV1KPORvcwSn2E7SOSoD82GIL9XPL8g78PcTaBme
         /S/86a0pNek0wNuLf68PzmeRKSXYmWsMDuv7UT8R9KLtr0xZJtPBvTwqPKug3vNOI4tT
         hPMg==
X-Forwarded-Encrypted: i=1; AJvYcCXkaGwOiHfsXrC67CpQ3ug5sm0/8/14BTJyJO0PkK4uO5ZJT6mPmETs/xEs/19cDHFgA5WC/IosG6+jJ9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ed6Z/VumetFvSOsQr18XkoMGtCwaTqjzkUnbQjyFrAVZj40w
	mgo/go0r8MJvq6WruTrIdaNtp2kFoVjNvpsH+P9OquHpw5nLqVBgHBZfq2KZe5biORCMJmrRS0R
	80RAc5fmPfIsY1oMRVPnls4xCgH1tbeVv6Qgcz6VxHmSQG9F31MQ44uI=
X-Google-Smtp-Source: AGHT+IE5ybtdLEnlV4DeQ6iz0cvn1pcpAcGxp4GMBZOpdSaSFD0DtGHNiO1cgcsWrQMk3fOS7aeX/vFq/w/scTtOk+yDPuci33j+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39d6c34c312mr4356805ab.1.1724315604539; Thu, 22 Aug 2024
 01:33:24 -0700 (PDT)
Date: Thu, 22 Aug 2024 01:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016f0070620418323@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_alloc_v4_validate
From: syzbot <syzbot+5c0423c85f295891c7f7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e4436539ae1 Merge tag 'hid-for-linus-2024081901' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17cc9387980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62f882de896675a6
dashboard link: https://syzkaller.appspot.com/bug?extid=5c0423c85f295891c7f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338058d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d0f7f3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75208f1b057a/disk-6e443653.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eeb34e49cb7e/vmlinux-6e443653.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd6b9e2947c8/bzImage-6e443653.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/80d0f45895f2/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c0423c85f295891c7f7@syzkaller.appspotmail.com

bcachefs (loop0): recovering from clean shutdown, journal seq 8
bcachefs (loop0): Doing compatible version upgrade from 1.7: mi_btree_bitmap to 1.11: disk_accounting_inum
  running recovery passes: check_allocations
=====================================================
BUG: KMSAN: uninit-value in alloc_data_type fs/bcachefs/alloc_background.h:135 [inline]
BUG: KMSAN: uninit-value in bch2_alloc_v4_validate+0x80a/0x1c10 fs/bcachefs/alloc_background.c:256
 alloc_data_type fs/bcachefs/alloc_background.h:135 [inline]
 bch2_alloc_v4_validate+0x80a/0x1c10 fs/bcachefs/alloc_background.c:256
 bch2_bkey_val_validate+0x2ac/0x470 fs/bcachefs/bkey_methods.c:143
 bch2_btree_node_read_done+0x5be1/0x7790 fs/bcachefs/btree_io.c:1219
 btree_node_read_work+0x973/0x1960 fs/bcachefs/btree_io.c:1323
 bch2_btree_node_read+0x2e6b/0x36e0
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1749 [inline]
 bch2_btree_root_read+0xa81/0x13f0 fs/bcachefs/btree_io.c:1773
 read_btree_roots+0x51c/0x1250 fs/bcachefs/recovery.c:516
 bch2_fs_recovery+0x422c/0x5c60 fs/bcachefs/recovery.c:844
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0x13e8/0x22d0 fs/bcachefs/fs.c:1946
 vfs_get_tree+0xa7/0x570 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3472
 path_mount+0x742/0x1f10 fs/namespace.c:3799
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:3997
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3997
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4113
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4130
 __do_kmalloc_node mm/slub.c:4146 [inline]
 __kmalloc_node_noprof+0x9d6/0xf50 mm/slub.c:4164
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:650
 btree_bounce_alloc fs/bcachefs/btree_io.c:124 [inline]
 bch2_btree_node_read_done+0x52a9/0x7790 fs/bcachefs/btree_io.c:1192
 btree_node_read_work+0x973/0x1960 fs/bcachefs/btree_io.c:1323
 bch2_btree_node_read+0x2e6b/0x36e0
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1749 [inline]
 bch2_btree_root_read+0xa81/0x13f0 fs/bcachefs/btree_io.c:1773
 read_btree_roots+0x51c/0x1250 fs/bcachefs/recovery.c:516
 bch2_fs_recovery+0x422c/0x5c60 fs/bcachefs/recovery.c:844
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0x13e8/0x22d0 fs/bcachefs/fs.c:1946
 vfs_get_tree+0xa7/0x570 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3472
 path_mount+0x742/0x1f10 fs/namespace.c:3799
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:3997
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3997
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5177 Comm: syz-executor142 Not tainted 6.11.0-rc4-syzkaller-00008-g6e4436539ae1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

