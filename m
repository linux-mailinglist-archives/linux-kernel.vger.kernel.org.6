Return-Path: <linux-kernel+bounces-351498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C20B99121E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1450B20A79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAC1487F6;
	Fri,  4 Oct 2024 22:06:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205E83CDA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079566; cv=none; b=uXLivCW2bmAdUEkmu04qnx7dZia0mbPzq3blN8vlvG59C9qM6asjHKESaAZ8MlZVRq/wrtMJEgLGAjDvgE0e6HOX7Op1g0aZKvw4qpU9DlSMtGpC9zjatWahjsccRekj9OvWEq3qJil78+eiVuYj/wHefJVpK+dsIlg2lQY/mmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079566; c=relaxed/simple;
	bh=s/k0LhG9eQLiIP0vnFrQuO6HuCREVKOjBAOEjKPsmy4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tno9q499Ugu5idkM75MtiiRZtyMTg40TI2ZcwWQYF+m6+5qVNfOonVidIyHpHWw03gTJOyBYR7z/pQy96A8UOlPimJ+21/jcjNHrp0UBqsx3uFclFs9kGnUxdcWo8sjYGGyuiAX8/RHCXgaH3afwX9Ws81fynP1aOqjEqMUNZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a348ebb940so28208565ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728079564; x=1728684364;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne3qkX31jNAK2Awcej8Zad+3R5lfqP/HZDWYCXhJFf4=;
        b=tt7Nr7wK62zasmBI0Gfm+2I3ehMjL7emLzSA0JHF4soKLVk3zyg2lDp+Pyt18/DvS/
         YkMzkWmaNQa0622/raLHIV0TAzq+r1ndD2LCCk4vCSQtQ8/5NiKcd7MwvWP3NLgl3LvN
         Qyhj1tKtw7gr1gcn4CcQGHgixpNJv+FTKaDxixLBUexbWigr3c/c4zmFMfhnQycD6lZw
         BkgwUlGcsJxWLXQf5s7G+7BsatpvTOsXq02AmFMbVmAKLYaDW1RyPjQe3V5OeufQKd2i
         iKwQuO1ZkExOgEReuwCwyTe75nM+FCrkgFpDmpGsdTgxrnjHariRz1hFC4SLcaChZWmo
         2iJQ==
X-Gm-Message-State: AOJu0YzaqBLVuKWV5m7TRPYDQ7FCCpCEj2Xb4Y5GA3oYCusbRo5U2Qn8
	6dbBpVx7hYI1/aTTomCd9AGWBL7EIx+0JEJf0/xRLSetZilNMuj3dhKFqOicJYPnqynL7bZCe3p
	+tD+LOFshvJQmn1GB/jaxHrRY+yAeleNFShowkclqjisBJBCExAHpens=
X-Google-Smtp-Source: AGHT+IGMdtO5rucI9UYMuSynfJO+m9G9lfu5xdrkw1YxuXfeOl1dIP+eLT+T6XozPnWoBB2ucTQfub2yAQaDCvghpL84h8nosfam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a375999ebcmr44627015ab.8.1728079563815; Fri, 04 Oct 2024
 15:06:03 -0700 (PDT)
Date: Fri, 04 Oct 2024 15:06:03 -0700
In-Reply-To: <4f140375-6873-4ad6-984a-b8075708b2a4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670066cb.050a0220.49194.04a3.GAE@google.com>
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
syz.0.15/5646 is trying to acquire lock:
ffff88804a600908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_replicas_entry_validat=
e+0x2a/0x80 fs/bcachefs/replicas.c:101

but task is already holding lock:
ffff88804a600908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_read_superblock_clean+=
0x36/0x520 fs/bcachefs/sb-clean.c:149

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&c->sb_lock);
  lock(&c->sb_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5646:
 #0: ffff88804a600278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_start+0x45/=
0x5b0 fs/bcachefs/super.c:1007
 #1: ffff88804a600908 (&c->sb_lock){+.+.}-{3:3}, at: bch2_read_superblock_c=
lean+0x36/0x520 fs/bcachefs/sb-clean.c:149

stack backtrace:
CPU: 0 UID: 0 PID: 5646 Comm: syz.0.15 Not tainted 6.12.0-rc1-syzkaller-002=
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
RIP: 0033:0x7f035137f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0352155e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0352155ef0 RCX: 00007f035137f79a
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 00007f0352155eb0
RBP: 0000000020000180 R08: 00007f0352155ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000140
R13: 00007f0352155eb0 R14: 00000000000058f7 R15: 00000000200001c0
 </TASK>


Tested on:

commit:         ac308609 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15484d80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df95955e3f7b5790=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9f41e4b255897d99d=
4e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D104c1bd05800=
00


