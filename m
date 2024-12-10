Return-Path: <linux-kernel+bounces-439457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D81E9EAF93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9967F28862D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F622331C;
	Tue, 10 Dec 2024 11:12:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD862153C4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829125; cv=none; b=oTtOtcyD3Ndk8IXlcmj/w5KkbMAhwoicmEErgg+WPlTI/WESDXe4rDybDjsITHhn+qgYs0GB6aYredrh0KPHmVtNm6GBwRHYL6Tietc9HKpR51c2btKdV04/7jfFJg3CEB1DhVH5DPtej709xDnNSM7vdPX8OGIx5knOrNX1PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829125; c=relaxed/simple;
	bh=BmzoH1M10+FFRkbLtdYn106smTBNy8U1h3uup8KBlgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OX9lxnq2Sr9gMuKyE2briZIU8UAuAkbD4nwxBNuak323B5TxvCQqieaMvRji/wvtUgnwQBzD6wfI16j2dpy5N+J3De4N+DW5ncfXgvZ2VIs36WH6dBheFiEAW3F4sWoUhp6F/QIAHgSZ2d2Uf9kAVFXk6dAZ0i/VoqH+kZBw7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so57562775ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829123; x=1734433923;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0vZeA6LrehhBKYMPBA1rUywOznFzo6QHFxVxjqhmoE=;
        b=CPYz/9bDsArGkr/Fch4wW/7qmAtKQ7SuiDOiB6yXyd6sxHZVPQpjfbkw+uJ4lRm/Cy
         3y42/5I6IGiZu/SUOqKeynKV/8frTpZJbgu88QiMTOW2geW4k/NgDiAaXHtoJTF86wBq
         txVuOXVUF/eKUiVkEsD9xOW63XHg5KY8/0V6AO5e3hFONDeJ2DyUf1yyOooas1cssoto
         huihdaWExUtwZA4Gdy3S6InI54yjI3anpRcPYDGXgyvaXLAybCEeuc+Nsi36MoCTa2TX
         lXeS7dkjVqDbw56mSvRUvvtSx3gjb6DgtTq7CXYVCZ0MbistmgWB2w0eOBfpoocgWdwA
         Luhg==
X-Forwarded-Encrypted: i=1; AJvYcCV/5/o6/o+r340VW018e2lw8XXoByvl2Zu4KYPav0dvrGNk9P09zE8ffWlwU+d+UEg+wKMOC4PBy8A6H6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUKew8YbzKlATem0lwUZvZVK7S1FgG84vPE4cHC1gIWiH1iwj
	gJG+6Vz/SvTDPafZZmRVy8xcEAJ1QCTKOrdEvPzClwOkK5kwSc61N4sr86s2ozeCTGETYsE8vh6
	wwxWYx+pvATv23L9fI18RqobW/+IP+uxLdu+4KQ4lu/6VuHsipZNFkiY=
X-Google-Smtp-Source: AGHT+IGPv3zmRuGp6rUmUq4ZsB7nuvBRi7Cy0gtN27fIqaf71MI4xeesvbt5TClDiKwXKBcgtMhJhE19e6gJuRRk4bD/i0iJK1Lz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3a811dbaedamr127676175ab.13.1733829122943; Tue, 10 Dec 2024
 03:12:02 -0800 (PST)
Date: Tue, 10 Dec 2024 03:12:02 -0800
In-Reply-To: <20241210104439.1770-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67582202.050a0220.a30f1.01cb.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
From: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
possible deadlock in __submit_bio

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00011-gc018ec9dd144 #0 Not tainted
------------------------------------------------------
syz.0.15/7623 is trying to acquire lock:
ffff0000ca7b1de8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: __submit_bio=
+0x1a0/0x4f8 block/blk-core.c:629

but task is already holding lock:
ffff0000d771a0b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x14=
4/0x1bc fs/hfsplus/bfind.c:28

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&tree->tree_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x218/0x28f4 kernel/locking/mutex.c:585
       __mutex_lock kernel/locking/mutex.c:735 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:787
       hfsplus_find_init+0x144/0x1bc fs/hfsplus/bfind.c:28
       hfsplus_cat_write_inode+0x1a4/0xd48 fs/hfsplus/inode.c:589
       hfsplus_write_inode+0x15c/0x4dc fs/hfsplus/super.c:161
       write_inode fs/fs-writeback.c:1525 [inline]
       __writeback_single_inode+0x5a0/0x15a4 fs/fs-writeback.c:1745
       writeback_single_inode+0x18c/0x554 fs/fs-writeback.c:1801
       sync_inode_metadata+0xc4/0x12c fs/fs-writeback.c:2871
       hfsplus_file_fsync+0xe4/0x4c8 fs/hfsplus/inode.c:316
       vfs_fsync_range fs/sync.c:187 [inline]
       vfs_fsync+0x154/0x18c fs/sync.c:201
       __loop_update_dio+0x248/0x420 drivers/block/loop.c:204
       loop_set_status+0x538/0x7f4 drivers/block/loop.c:1289
       lo_ioctl+0xf10/0x1c48
       blkdev_ioctl+0x3a8/0xa8c block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #1 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       hfsplus_file_fsync+0xd8/0x4c8 fs/hfsplus/inode.c:311
       vfs_fsync_range fs/sync.c:187 [inline]
       vfs_fsync+0x154/0x18c fs/sync.c:201
       __loop_update_dio+0x248/0x420 drivers/block/loop.c:204
       loop_set_status+0x538/0x7f4 drivers/block/loop.c:1289
       lo_ioctl+0xf10/0x1c48
       blkdev_ioctl+0x3a8/0xa8c block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #0 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x34f0/0x7904 kernel/locking/lockdep.c:5226
       lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1254/0x2070 block/blk-mq.c:3093
       __submit_bio+0x1a0/0x4f8 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x3bc/0xcbc block/blk-core.c:739
       submit_bio_noacct+0xc6c/0x166c block/blk-core.c:868
       submit_bio+0x374/0x564 block/blk-core.c:910
       submit_bh_wbc+0x3f8/0x4c8 fs/buffer.c:2814
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x7d0/0x950 fs/buffer.c:2446
       hfsplus_read_folio+0x28/0x38 fs/hfsplus/inode.c:28
       filemap_read_folio+0x108/0x318 mm/filemap.c:2366
       do_read_cache_folio+0x368/0x5c0 mm/filemap.c:3826
       do_read_cache_page mm/filemap.c:3892 [inline]
       read_cache_page+0x6c/0x15c mm/filemap.c:3901
       read_mapping_page include/linux/pagemap.h:1005 [inline]
       __hfs_bnode_create+0x3dc/0x6d4 fs/hfsplus/bnode.c:440
       hfsplus_bnode_find+0x200/0xe60 fs/hfsplus/bnode.c:486
       hfsplus_brec_find+0x134/0x4a0 fs/hfsplus/bfind.c:172
       hfsplus_brec_read+0x38/0x128 fs/hfsplus/bfind.c:211
       hfsplus_find_cat+0x140/0x4a0 fs/hfsplus/catalog.c:202
       hfsplus_iget+0x34c/0x584 fs/hfsplus/super.c:83
       hfsplus_fill_super+0xa5c/0x16f8 fs/hfsplus/super.c:504
       get_tree_bdev_flags+0x38c/0x494 fs/super.c:1636
       get_tree_bdev+0x2c/0x3c fs/super.c:1659
       hfsplus_get_tree+0x28/0x38 fs/hfsplus/super.c:640
       vfs_get_tree+0x90/0x28c fs/super.c:1814
       do_new_mount+0x278/0x900 fs/namespace.c:3507
       path_mount+0x590/0xe04 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount fs/namespace.c:4034 [inline]
       __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

other info that might help us debug this:

Chain exists of:
  &q->q_usage_counter(io)#17 --> &sb->s_type->i_mutex_key#20 --> &tree->tre=
e_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock);
                               lock(&sb->s_type->i_mutex_key#20);
                               lock(&tree->tree_lock);
  rlock(&q->q_usage_counter(io)#17);

 *** DEADLOCK ***

2 locks held by syz.0.15/7623:
 #0: ffff0000cb7e60e0 (&type->s_umount_key#51/1){+.+.}-{4:4}, at: alloc_sup=
er+0x1b0/0x834 fs/super.c:344
 #1: ffff0000d771a0b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init=
+0x144/0x1bc fs/hfsplus/bfind.c:28

stack backtrace:
CPU: 1 UID: 0 PID: 7623 Comm: syz.0.15 Not tainted 6.13.0-rc1-syzkaller-000=
11-gc018ec9dd144 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:484 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x154/0x1c0 kernel/locking/lockdep.c:2074
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x34f0/0x7904 kernel/locking/lockdep.c:5226
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
 bio_queue_enter block/blk.h:75 [inline]
 blk_mq_submit_bio+0x1254/0x2070 block/blk-mq.c:3093
 __submit_bio+0x1a0/0x4f8 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x3bc/0xcbc block/blk-core.c:739
 submit_bio_noacct+0xc6c/0x166c block/blk-core.c:868
 submit_bio+0x374/0x564 block/blk-core.c:910
 submit_bh_wbc+0x3f8/0x4c8 fs/buffer.c:2814
 submit_bh fs/buffer.c:2819 [inline]
 block_read_full_folio+0x7d0/0x950 fs/buffer.c:2446
 hfsplus_read_folio+0x28/0x38 fs/hfsplus/inode.c:28
 filemap_read_folio+0x108/0x318 mm/filemap.c:2366
 do_read_cache_folio+0x368/0x5c0 mm/filemap.c:3826
 do_read_cache_page mm/filemap.c:3892 [inline]
 read_cache_page+0x6c/0x15c mm/filemap.c:3901
 read_mapping_page include/linux/pagemap.h:1005 [inline]
 __hfs_bnode_create+0x3dc/0x6d4 fs/hfsplus/bnode.c:440
 hfsplus_bnode_find+0x200/0xe60 fs/hfsplus/bnode.c:486
 hfsplus_brec_find+0x134/0x4a0 fs/hfsplus/bfind.c:172
 hfsplus_brec_read+0x38/0x128 fs/hfsplus/bfind.c:211
 hfsplus_find_cat+0x140/0x4a0 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x34c/0x584 fs/hfsplus/super.c:83
 hfsplus_fill_super+0xa5c/0x16f8 fs/hfsplus/super.c:504
 get_tree_bdev_flags+0x38c/0x494 fs/super.c:1636
 get_tree_bdev+0x2c/0x3c fs/super.c:1659
 hfsplus_get_tree+0x28/0x38 fs/hfsplus/super.c:640
 vfs_get_tree+0x90/0x28c fs/super.c:1814
 do_new_mount+0x278/0x900 fs/namespace.c:3507
 path_mount+0x590/0xe04 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
loop0: detected capacity change from 1024 to 3
Dev loop0: unable to read RDB block 3
 loop0: unable to read partition table
loop0: partition table beyond EOD, truncated
loop_reread_partitions: partition scan of loop0 (=EF=BF=BDRt=EF=BF=BD=0B*=
=EF=BF=BD3=0C!6{=06bO=EF=BF=BD0=EF=BF=BD=7F=EF=BF=BD=17.=EF=BF=BDQ=CA=9D=EF=
=BF=BD=03=EF=BF=BD	H=EF=BF=BD"Uqd\=EF=BF=BD'=EF=BF=BDLz=EF=BF=BD8=EF=BF=BD=
=08=EF=BF=BD=EF=BF=BD=EF=BF=BDw1=EF=BF=BDA=08H=EF=BF=BD=EF=BF=BD=10=EF=BF=
=BD=19=EF=BF=BD=EF=BF=BD) failed (rc=3D-5)


Tested on:

commit:         c018ec9d block: rnull: Initialize the module in place
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux=
-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=3D124c68f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbd60186d08e947a=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5218c85078236fc46=
227
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64

Note: no patches were applied.

