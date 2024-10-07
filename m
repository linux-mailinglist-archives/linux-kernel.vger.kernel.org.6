Return-Path: <linux-kernel+bounces-353985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E829A9935AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250D01C2150C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9291DDC0F;
	Mon,  7 Oct 2024 18:07:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F731DDA3A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324425; cv=none; b=oN7nJjaSfoTTBXE685Kfd/Xzvk4WGbT8X0H6YnluD/zu/DvoUd+21fUh+FHY+J8A1W2AcFZXYgBuasZ+fFGAmhQ4mnMBJM4N/T/Fa7QXosJcgtOUh6FIqI1OTA0J4Mn/kxC7QssvYfRbny4Ju+Rf4U6BtvUMcvWQ1G+ER7TGxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324425; c=relaxed/simple;
	bh=e8+n9cGbUGstcFUaQTB+CjwWxPOH01uMINPDKCIhDQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CQRrRSEvZpQYQhY0IYL+buW8uzV1bc/kgGeZHQCNpSGW/YONkcjWTjWrjgl8e4PU5CsBAQt4x8GKcG8XFGmgq94CQts+Nxkw0DYcUYn17R5tgJC6pDfdUYlywluoO8R7UnrtubVsJR6F8oobvs2abKQjFcjVs/7BSBqEBcPdT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a36a8fa836so31491275ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 11:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728324423; x=1728929223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWGlz1+dP3+q0GGa0vgHOaQ4HqS51hWjLR5JeRNcI9Y=;
        b=G5RECkE1HEO7FHD3K/Z5hd4o0LdDXvja+o8LvTDYlJAc0Z7X4EhJEABLkQazc7fKUL
         V3KKGOyRFl5/6zyNZ+jSFkWOymRnyi1/mnOmFRV+mcEpyl/DNAyLb1UHJzx1px0ikO7w
         6uyJ0PZ6dzV0IY08zzKl0XBJk2HK853WD6Rly+Mw1RXk+ixcCJcqNeookaq26iecXFap
         fSQH5nTD3JTle3miqXJqJAgeHHZOA8OlOQ1UdY8oAaT+JaIeSWBtbwnzMKx2YIp/xEwD
         pPvk2NuBYFEgFro58fg2gGnsyGfRz3WJCSxQAcCPhlj1pdTsqnNXYmad5wfhgdxds/US
         0tZA==
X-Gm-Message-State: AOJu0YwqrhRjEgeOdg61YD2+YorYUwbROJMU2MDuZ/Gh0j5KX42vljuK
	qGi6iTd4yr5C4+pt7DdwUM+GCv/CJ/SW5uj8v9JnTCBb6GYW3FGAhfuA5zyd9Tdu/D+d4nIbK93
	IWH3AQWxbu1jyzNg9rXXEL+S98WwVRdwxs2w9+rjEnGBU81Sw48yGc7g=
X-Google-Smtp-Source: AGHT+IFGzDplagKRCumf02YsIDlRzu+jNYJq3VESbvbkIw3gzm5F/0SptWfpR2xuC9VCc2Qv+eRtSfrIJhOeqtiyU5BviftaPOfd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4b:b0:3a0:8c5f:90d8 with SMTP id
 e9e14a558f8ab-3a37599495fmr111180055ab.6.1728324423005; Mon, 07 Oct 2024
 11:07:03 -0700 (PDT)
Date: Mon, 07 Oct 2024 11:07:02 -0700
In-Reply-To: <40o4_hLyLj7txTgT658M3JrfBr7tb3ybseSVJTVtzBywUcQiX0OSjTJitzVHVm-y6VHAZvny1PQqfo2l4iUANRfeMHtM0hQf0m9pN7lkYd4=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67042346.050a0220.49194.0515.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in bch2_alloc_read
From: syzbot <syzbot+a1b59c8e1a3f022fd301@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in bch2_replicas_entry_validate

bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=none,compression=lz4,usrquota,nojournal_transaction_names
============================================
WARNING: possible recursive locking detected
6.12.0-rc2-syzkaller-g8cf0b93919e1 #0 Not tainted
--------------------------------------------
syz.0.15/5549 is trying to acquire lock:
ffff888054c00908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_replicas_entry_validate+0x2a/0x80 fs/bcachefs/replicas.c:101

but task is already holding lock:
ffff888054c00908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_read_superblock_clean+0x36/0x520 fs/bcachefs/sb-clean.c:149

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&c->sb_lock);
  lock(&c->sb_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5549:
 #0: ffff888054c00278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_start+0x45/0x5b0 fs/bcachefs/super.c:1007
 #1: ffff888054c00908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_read_superblock_clean+0x36/0x520 fs/bcachefs/sb-clean.c:149

stack backtrace:
CPU: 0 UID: 0 PID: 5549 Comm: syz.0.15 Not tainted 6.12.0-rc2-syzkaller-g8cf0b93919e1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 bch2_replicas_entry_validate+0x2a/0x80 fs/bcachefs/replicas.c:101
 journal_entry_data_usage_validate+0x2b6/0x690 fs/bcachefs/journal_io.c:608
 bch2_sb_clean_validate_late fs/bcachefs/sb-clean.c:40 [inline]
 bch2_read_superblock_clean+0x207/0x520 fs/bcachefs/sb-clean.c:168
 bch2_fs_recovery+0x1f4/0x39c0 fs/bcachefs/recovery.c:639
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2080
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd37f97f69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd3806ffe68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd3806ffef0 RCX: 00007fd37f97f69a
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007fd3806ffeb0
RBP: 00000000200058c0 R08: 00007fd3806ffef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005900
R13: 00007fd3806ffeb0 R14: 00000000000058cd R15: 0000000020000000
 </TASK>


Tested on:

commit:         8cf0b939 Linux 6.12-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12d72707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74c522fa0761706b
dashboard link: https://syzkaller.appspot.com/bug?extid=a1b59c8e1a3f022fd301
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

