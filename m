Return-Path: <linux-kernel+bounces-255868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CC9345D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB981F23EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F629422;
	Thu, 18 Jul 2024 01:31:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEC1DA2F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266287; cv=none; b=W8pK5JfE1mSWuKe+YHJ5Vb0CbGyQCzErbKGLWWoEMOr/RbunBKWBnFRvh5RRRcC14X4VFGg5DXD5aWSjEjU31TH+IYkwhtB/rwLtDtTWByFfllbLVDr728Wzs/jvMxM9CVwX+gCgbvUC6faEZDK5gBodWarvqYcrYHY1CM2wzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266287; c=relaxed/simple;
	bh=H6421hUWgOHPk8Prphd4QoomoEFVL8l1nu8WD7kqbKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IUDIJi0kTEIYe/A4e+dcmBSapRiWMWp03y+KZHVeLZeYy0z4rcft5v6kMdb/Tfc6dyCIbkjiLx2Wcqq+5YFMcqWEkueQyuXbJpkHu1vf3EdaY2elDyFkz2DwsYXv0Q4DFQKFW2+tY8OtiLHKZ0uKo4iwnRfmdN9RD8gb9nUvcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-803aad60527so38478639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721266285; x=1721871085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3m39QGuDbE/4hBGkcK6Bm82mAdr7LA9r1OCWNKU0i8=;
        b=kaEwSDRas8U0QeIkyOYYvmO1FZfMAYb35ZIG9CB0Gx1uN7F8QbzIcq6Ek/L61WRLUb
         Od4KeJiWcqUKXMU0hlMsK7jJzvh1zib+h4eq5x9wvJQbByB28Bk6FzLuijQbRj+zuiLG
         FD8isY4qOy0iy6HeBdrHt6+kHs/6aJZlYHeHYCP/HlUiKdQLVZ+njAUVX7NX9KTb9ZhO
         wzt+7rRG/AEjfE215sbsymWzJFPiblLCOqaLXdVHPqU1KFruFK+TgPZ3VuflRDbrI59e
         XtC3DwyaAkoHGn6T/0pWH7V2clTlCndnRLhcJtHj/YYrBi5KYthZTRugeECU1FSuiAtA
         GSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoTiqAnv8idzAEqxIhuzgIn6gSa6R2CIBbSy93svpao4CoPS11t9fYi0C2MkG0sHRi+x+/6f8zk+2RC+ZSUEWRK6Qr8vE+4red1PME
X-Gm-Message-State: AOJu0Yw7FEMT5J2yJBJ4uZzGByzp8mHHtKv/zvf7zIUW6N43FyQRPHO9
	uRBZtNjMGwP5HvGWA/O9NRIlFvx78Tbqj06lRkeUL1PjgHTCcWZM4qtY+0D9s/IVKLlzS4p509Q
	wv3MHPrTrdSXPEImIqJ2hG7b41bM5FBYlcpYdlGoZpBlg16gpmI7Naag=
X-Google-Smtp-Source: AGHT+IH9ObtESPAwXLA53Gf1PWGg7p22AvMYtLUWoKG4seIvV4ymWDufQYECfSECFGJvAAp+GY5uBs0SREFeIfNIf+mBy64qqcNk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:381:7075:6911 with SMTP id
 e9e14a558f8ab-3955523de17mr2555315ab.1.1721266285003; Wed, 17 Jul 2024
 18:31:25 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:31:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b5313061d7b897d@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __replicas_deltas_realloc
From: syzbot <syzbot+50bcc3c92dc2516c4ca7@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10fa3b6e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
dashboard link: https://syzkaller.appspot.com/bug?extid=50bcc3c92dc2516c4ca7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121892e9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e6054e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fea69a9d153c/disk-c912bf70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be06762a72ef/vmlinux-c912bf70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c8e58b4215d/Image-c912bf70.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/26bfb87318b0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50bcc3c92dc2516c4ca7@syzkaller.appspotmail.com

bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6286 at fs/bcachefs/buckets.c:395 __replicas_deltas_realloc+0x16c/0x2a4 fs/bcachefs/buckets.c:395
Modules linked in:
CPU: 1 PID: 6286 Comm: syz-executor316 Not tainted 6.10.0-rc7-syzkaller-gc912bf709078 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __replicas_deltas_realloc+0x16c/0x2a4 fs/bcachefs/buckets.c:395
lr : __replicas_deltas_realloc+0x16c/0x2a4 fs/bcachefs/buckets.c:395
sp : ffff80009bb26650
x29: ffff80009bb26650 x28: 000000000001ffa0 x27: 1fffe0001abe3025
x26: dfff800000000000 x25: 1fffe0001c4c8000 x24: 000000000001ffd0
x23: 0000000000000000 x22: ffff0000e2640000 x21: ffff0000d5f18000
x20: 0000000000002800 x19: ffff0000d5f18128 x18: ffff80009bb25c80
x17: 000000000000d4f8 x16: ffff80008af00270 x15: 0000000000000003
x14: 1ffff00013764d12 x13: 0000000040000000 x12: 0000000000000080
x11: ffff700013764d15 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d6f2bc80 x7 : 0000000002200000 x6 : ffff0000d62bd6d0
x5 : ffff0000d62bd6a8 x4 : ffff80009bb268a8 x3 : 0000000002200000
x2 : 0000000000002800 x1 : 000000000001ffd0 x0 : 0000000000010000
Call trace:
 __replicas_deltas_realloc+0x16c/0x2a4 fs/bcachefs/buckets.c:395
 bch2_replicas_deltas_realloc fs/bcachefs/buckets.c:427 [inline]
 __trigger_reservation+0x100/0x424 fs/bcachefs/buckets.c:1280
 bch2_trigger_reservation+0xec/0x148 fs/bcachefs/buckets.c:1312
 bch2_key_trigger fs/bcachefs/bkey_methods.h:88 [inline]
 bch2_key_trigger_new fs/bcachefs/bkey_methods.h:116 [inline]
 run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:517 [inline]
 run_btree_triggers+0x680/0xc18 fs/bcachefs/btree_trans_commit.c:544
 bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:576 [inline]
 __bch2_trans_commit+0x30c/0x592c fs/bcachefs/btree_trans_commit.c:1022
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_extent_update+0x3d0/0x9b4 fs/bcachefs/io_write.c:326
 bch2_extent_fallocate+0x7c0/0x1a28 fs/bcachefs/io_misc.c:111
 __bchfs_fallocate fs/bcachefs/fs-io.c:673 [inline]
 bchfs_fallocate fs/bcachefs/fs-io.c:736 [inline]
 bch2_fallocate_dispatch+0x19b8/0x2d50 fs/bcachefs/fs-io.c:783
 vfs_fallocate+0x480/0x5bc fs/open.c:330
 ioctl_preallocate+0x21c/0x2a0 fs/ioctl.c:291
 do_vfs_ioctl+0x1b88/0x2404 fs/ioctl.c:886
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0xe4/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 67842
hardirqs last  enabled at (67841): [<ffff8000809b3374>] lruvec_stat_mod_folio include/linux/vmstat.h:561 [inline]
hardirqs last  enabled at (67841): [<ffff8000809b3374>] __kmalloc_large_node+0x124/0x200 mm/slub.c:4071
hardirqs last disabled at (67842): [<ffff80008afc1964>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (67088): [<ffff80008003067c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (67086): [<ffff800080030648>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

