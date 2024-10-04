Return-Path: <linux-kernel+bounces-351396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A6991061
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6860D28329E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCEC1DD526;
	Fri,  4 Oct 2024 20:12:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE01DBB28
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072726; cv=none; b=JyM3U668/FJQ6hti6iP19+uojt2k+hLIdWse1RLjWemVir4Q4R3gTuQvseVjr7b4E02usp5gNNUJc/TDPcggIAbnkFstG3mQjenBtrpKXJCKh7EQ6YneDIs+IyPUStGvKx9VbQYJq9D7jCZGq2QoEptSKiAxQJtGgG3xqgJj8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072726; c=relaxed/simple;
	bh=X88w8RQ6K+zQ4wt5kN0vDXSD8cgMQUB+4DsQpTmFR2U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C+RYVvevCbE3GCqbOMwt0h7bu4pFf7C4GWXOtzcy7ttOiEM6ZI4sz6X4B0L6ACnHph6C3uFQcAOACjaa6qEgBardTssDfDiHqKBMZlo7wOdjNNnGRBGYJsVddDlAPUXnI7LSNugJg5PNmQQi00HzgxNCPpf5wBaJLTxSde4Alvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so317854739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728072724; x=1728677524;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmIt0HQ28ig9VW5dszp7clB7AW2MI/mu9GCWmof2RM4=;
        b=b+DGSPaW1HXDNSzGjnW/RlfEd0gxJIe+fC/YjRXc4qyCriZhClXFYDluV21j5V4Xoa
         g8Knr+t9OdH4K7OF4+55dll3p/LPCSIxxvTvcghRDPqmf1Kvx/4MHzAeWeXh8xUN72uD
         Jj9MzVpL/y1H7cZu89MgSBo/IrWjdzVwFH0LrGRwHVHpMXAJh4P6Y/aywCbTikiSXVY3
         2qRmifONE7zHI9F353Blpbw5JPvtePd7sJbjw/HE1GsiWWduy04GTlEUYStS0N83rRjT
         UyIxSeOMOCjV9cWWDFmEGTjEPvHraD8tjrIj41C8Osbwoz2dQLboTlNS4yCQzbxAzj9T
         VB/Q==
X-Gm-Message-State: AOJu0YzdA2dkbAbHNaxQByhGqvB3jTj/kZSgPSsMr1auwJDgsO3WwJI/
	xOzAyEInv7703pXcbUhJJXE3ZvJ6kmy2/fWbvrW+RtrD9CCEax+OE6u4PZmbW8WvvdLxc2wE87u
	1ZqcEBUsBoLlZ4aCQq/izsuZM38itmBK0vGFX429T5chLlPcA4lU2IYM=
X-Google-Smtp-Source: AGHT+IGn+QyCuRUz6EJ+XaFa1JON8LXN5DiH40F5yzy8VJAK57KGJtNdotEE2coyRoqsESt7U0sa9lrGGyEGX9D8NagB0f3LUJNh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e02:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a3757d4e76mr47209875ab.0.1728072723712; Fri, 04 Oct 2024
 13:12:03 -0700 (PDT)
Date: Fri, 04 Oct 2024 13:12:03 -0700
In-Reply-To: <860bbf96-65f1-4afd-a117-18cfb3542ef8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67004c13.050a0220.49194.049d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __btree_node_pinned
From: syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, niharchaithanya@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
possible deadlock in bch2_replicas_entry_validate

bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=3Derrors=3Dcon=
tinue,metadata_checksum=3Dnone,data_checksum=3Dnone,compression=3Dlz4,metad=
ata_target=3Dinvalid device 255,noshard_inode_numbers,noinodes_use_key_cach=
e,journal_flush_delay=3D1001,nojournal_transaction_names
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: possible recursive locking detected
6.12.0-rc1-syzkaller-00296-gac308609567d-dirty #0 Not tainted
--------------------------------------------
syz.0.15/5554 is trying to acquire lock:
ffff88804b880908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_replicas_entry_validat=
e+0x2a/0x80 fs/bcachefs/replicas.c:101

but task is already holding lock:
ffff88804b880908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_read_superblock_clean+=
0x36/0x520 fs/bcachefs/sb-clean.c:149

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&c->sb_lock);
  lock(&c->sb_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5554:
 #0: ffff88804b880278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_start+0x45/=
0x5b0 fs/bcachefs/super.c:1007
 #1: ffff88804b880908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_read_superblock_c=
lean+0x36/0x520 fs/bcachefs/sb-clean.c:149

stack backtrace:
CPU: 0 UID: 0 PID: 5554 Comm: syz.0.15 Not tainted 6.12.0-rc1-syzkaller-002=
96-gac308609567d-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
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
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2071
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffafa97f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffafb710e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffafb710ef0 RCX: 00007ffafa97f79a
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 00007ffafb710eb0
RBP: 0000000020000180 R08: 00007ffafb710ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000140
R13: 00007ffafb710eb0 R14: 00000000000058f7 R15: 00000000200001c0
 </TASK>


Tested on:

commit:         ac308609 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D153b8d80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df95955e3f7b5790=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9f41e4b255897d99d=
4e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D155c8d279800=
00


