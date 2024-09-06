Return-Path: <linux-kernel+bounces-319444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFED196FCAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3381C22AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2FB1D7980;
	Fri,  6 Sep 2024 20:28:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EB1D6792
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654484; cv=none; b=f9r7eycDYqkZ3XIq3h3A+xxX/73dSguZQGsdFYY/zS8LRjy9z3jCvCd3qFAL8daU1vUd4TpOrg828kQ6gcpf1zU1lu6eYgNOexmaKukeoPHk8SWbAMC5E3kmJGo2LXbRyitJQsJPWa45eSQbMcir/wo1T+GZ0wqh2E7H5h9F25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654484; c=relaxed/simple;
	bh=PRtIgTaApbHgW0YpkcoBjNU0lEonAW2utLCnljFB370=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nFV9KJsQuaUsv/TJQE/xiigo8eQC3LjrB8XKDt5VQRbP3YmUTN6dlTqhp1TDDX+MMRlC1dqlgLxMVvIpyldaJ80qGWThDR2O5NCau9fzx2cqC/9um5SzAyjT1e6d2QEtTWrnogfqdz+IRnNf4lPTBIkHNA/CHLa1fwtfQvDMFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0541f519dso15450985ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654482; x=1726259282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3d4eRsYtuHR/RGk0tI3MLQQyTxxdH3GGvC8Z5gCQHIc=;
        b=Q0llRztjl70dkLuntPMqO5fVOqQWH1SDZAYzecjCZZ0T5Ih8vvGxj4J2+5/cZAGyvD
         0JFcM/XFnJ9nAtXGwJrnCdE0WE98DbfR8HE5YUam2MUQZHdI4m00u54VER02YuRY1Jr0
         JHh3qFfKZECAj1oQw8PAowuZ21wuMCxG7z93Vz9dhbMWCzSQlIbASajZOjAc+cwYZXgT
         XW13b4GSVVUOXluK5gN2BdYY4w3aDI8V4BKUIhv6/Pxtulz5b3pYejjxTFVqWHSGwBx7
         kzmd2qy+3MVuhBJmircYyKIKhUwxEeg7PGzK4Q8Pb+eMVxEPKDnnQl/K2HT0bG8N+MXo
         9igg==
X-Forwarded-Encrypted: i=1; AJvYcCU695WyYw0diWAjpMk8Trziy9MJLtlP8wgh6UfGe03qjELLQqtrnChzeYQM0BaRnWDQb4Qr2p3CSs8k218=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxFJEpNY4GNEbLPsKEqJVTBppzC8zp7I0kJFymwOERt9zwdH0
	omw1Ld2RTdxNDxD244F0hvnyaz2DqN7UWlZW7kjEhoTSntpRjGSZMarpT9d/iGWnC4gQsDswlqb
	JdyKfaPWIxCe4MvaADTpcEJqFlRYi1zpau4nY2jSDoymPR6NQwdlttHs=
X-Google-Smtp-Source: AGHT+IEnVdpkLvMBZ++QJb0A79YVSw6nnAJsedJd4PIh5qKGyXW3JyFEv1hlh37MzThTbkolrG2xRQjAKIPDvYpUkx4fDxsgJJbe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:4ee1:1ac4 with SMTP id
 e9e14a558f8ab-3a04f070751mr2033745ab.1.1725654482161; Fri, 06 Sep 2024
 13:28:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 13:28:02 -0700
In-Reply-To: <CAG-BmofKVU4RwYFLz8LqvK4H9X_E+h-wPpzo7WEOcGR6guAPvQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a247f0621793eb9@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_buffer_cached
From: syzbot <syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in ocfs2_read_blocks

loop0: detected capacity change from 0 to 32768
(syz.0.15,5612,0):ocfs2_read_blocks:240 ERROR: status = -12
=====================================
WARNING: bad unlock balance detected!
6.11.0-rc6-syzkaller-g788220eee30d-dirty #0 Not tainted
-------------------------------------
syz.0.15/5612 is trying to release lock (&oi->ip_io_mutex) at:
[<ffffffff837f5e56>] ocfs2_read_blocks+0x11c6/0x1620 fs/ocfs2/buffer_head_io.c:394
but there are no more locks to release!

other info that might help us debug this:
2 locks held by syz.0.15/5612:
 #0: ffff8880166e00e0 (&type->s_umount_key#53/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:344
 #1: ffff8880434fd5a8 (&osb->system_file_mutex){+.+.}-{3:3}, at: ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101

stack backtrace:
CPU: 0 UID: 0 PID: 5612 Comm: syz.0.15 Not tainted 6.11.0-rc6-syzkaller-g788220eee30d-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5199
 __lock_release kernel/locking/lockdep.c:5436 [inline]
 lock_release+0x5cb/0xa30 kernel/locking/lockdep.c:5780
 __mutex_unlock_slowpath+0xe2/0x750 kernel/locking/mutex.c:912
 ocfs2_read_blocks+0x11c6/0x1620 fs/ocfs2/buffer_head_io.c:394
 ocfs2_read_virt_blocks+0x4c8/0xa50 fs/ocfs2/extent_map.c:1010
 ocfs2_read_dir_block fs/ocfs2/dir.c:508 [inline]
 ocfs2_find_entry_el fs/ocfs2/dir.c:715 [inline]
 ocfs2_find_entry+0x43b/0x2780 fs/ocfs2/dir.c:1080
 ocfs2_find_files_on_disk+0xff/0x360 fs/ocfs2/dir.c:1980
 ocfs2_lookup_ino_from_name+0xb1/0x1e0 fs/ocfs2/dir.c:2002
 _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:136 [inline]
 ocfs2_get_system_file_inode+0x305/0x7b0 fs/ocfs2/sysfile.c:112
 ocfs2_init_global_system_inodes+0x32c/0x730 fs/ocfs2/super.c:457
 ocfs2_initialize_super fs/ocfs2/super.c:2250 [inline]
 ocfs2_fill_super+0x3068/0x5880 fs/ocfs2/super.c:994
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66b2b7b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f66b38efe68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f66b38efef0 RCX: 00007f66b2b7b0ba
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007f66b38efeb0
RBP: 0000000020004480 R08: 00007f66b38efef0 R09: 0000000002800400
R10: 0000000002800400 R11: 0000000000000246 R12: 00000000200044c0
R13: 00007f66b38efeb0 R14: 0000000000004475 R15: 00000000200001c0
 </TASK>
(syz.0.15,5612,0):ocfs2_read_virt_blocks:1013 ERROR: status = -12
(syz.0.15,5612,0):ocfs2_read_dir_block:511 ERROR: status = -12
(syz.0.15,5612,0):ocfs2_init_global_system_inodes:461 ERROR: status = -22
(syz.0.15,5612,0):ocfs2_init_global_system_inodes:463 ERROR: Unable to load system inode 1, possibly corrupt fs?
(syz.0.15,5612,0):ocfs2_init_global_system_inodes:472 ERROR: status = -22
(syz.0.15,5612,0):ocfs2_initialize_super:2252 ERROR: status = -22
(syz.0.15,5612,0):ocfs2_fill_super:1178 ERROR: status = -22


Tested on:

commit:         788220ee Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16802200580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14f90d959c4a3f08
dashboard link: https://syzkaller.appspot.com/bug?extid=adfd64e93c46b99c957e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115a6567980000


