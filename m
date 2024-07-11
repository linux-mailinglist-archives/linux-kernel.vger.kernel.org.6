Return-Path: <linux-kernel+bounces-249035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D692E553
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D86283002
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD50158DBF;
	Thu, 11 Jul 2024 11:00:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FE156F5D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695631; cv=none; b=cc1UthblVLc9+TNFE5TnIOsi68YvYzsXd95exwmBJgTpDpoS/TqCVBBOy03xogG4IxCKEiO8yAjGsRfuk+023M6fUxUww2QDwFWQSpDQCi7RU50Yb70PQF3uvgJReRJ2j4nrKkenxwfdizct32vc+vQCZ7bfV1NLijp/G2UHKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695631; c=relaxed/simple;
	bh=ddmT7oyJ9piBmQXTe+lQG/PT9XyFxoMrK72nBn2P9ko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rq93ASwyc3WZ6EEyPEDKbK8ErERzv9Ef12WlGcFjdAWq0LMiYmY//OZyITMMBsGORB8S3MwnzuLOWoBICaUtcpAW8DfrLYE6rQxeqYmoLDI16YXPYwcnfbQufO99gN005ikhB3no1BAYHvFjk0mHZl7/c5vc9xpUQFo/rqmzKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso85223639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720695629; x=1721300429;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tw2zfpiKXVI0VSbegHndyINqj2Ifk+/lWPppaUlLXFY=;
        b=E8zcytwT2NhXpyfKqHMqe/jpXYGCpj9AefCH0AUw2ZI1FmndJGcZ/1kNlSqlf35bNG
         UviqTSj6yZIcv2XRsee2x+5PvFK7tq9TGmSTFC//dJwjoSS8QtBucWx74sUHxnB1x+qT
         URpwx9tscCQFXv+SYw7PVBSOlmM0vZt6t/iWK6aEq5/eqfD5ZHTmWKGItY93HTGsriE7
         +xGT1Ij0wyN6FW1bfVGwC4u1tk8RjwOmv+QE/Z0GKv8IW1ULPfC66MGs8heuqBoCP6Ei
         xWcdJecpqSEaM8Z7yWLxtgGkW8a23JrgxSOJAOp3ATKDYoc5cXYwzyBXdPA4IdHnCwO+
         szFA==
X-Forwarded-Encrypted: i=1; AJvYcCWEoBKplNmMv6J5oOiHmruaJqFTNWkq/BQcL+rNU/VES7fG8Ojp5Hm279HkwigUepwdyRpgiAme0q/z4TBoUbT7YGTrEPvo+iuR2oNR
X-Gm-Message-State: AOJu0YwJ0WUk+FQxhyBpntVXf2bcQsZOEFDbzWFmHx01bvdPQxX6RqED
	ppB4eV083yaxQY5c10t4b4ib4k/r24E9oxoF6jFsYwxHGQ/qkWycax99JZmsFyDSZftVpaBaiBu
	vm/OSZ3SC9bLD7fG3ga7bwS0pDfoWmKFgBGqjRNvJcfrleZL3KyqemFU=
X-Google-Smtp-Source: AGHT+IHOxxQhZi4HG8jvCUKVTrJYz3gRiIkAfJQXjaKxRsvCaBDC+5V1xZOVe4pjQD0Kox9zl/lusYWRJFoceUBSMMI8wuJbA5Bs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc7:b0:809:488:97f with SMTP id
 ca18e2360f4ac-80904880adcmr26239f.4.1720695628955; Thu, 11 Jul 2024 04:00:28
 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:00:28 -0700
In-Reply-To: <0000000000002501960619e2366b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb1365061cf6ab5b@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
From: syzbot <syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=100b427e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16907bb9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ce66a5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345bcd25ed2f/disk-523b23f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4508962d345/vmlinux-523b23f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ba5eb555639/bzImage-523b23f0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/65bde6695704/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com

list_del corruption, ffff88801e354410->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5777 Comm: syz-executor410 Not tainted 6.10.0-rc7-next-20240710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__list_del_entry_valid_or_report+0x106/0x140 lib/list_debug.c:59
Code: e8 af 5f d8 06 90 0f 0b 48 c7 c7 80 a0 20 8c 4c 89 fe e8 9d 5f d8 06 90 0f 0b 48 c7 c7 e0 a0 20 8c 4c 89 fe e8 8b 5f d8 06 90 <0f> 0b 48 c7 c7 40 a1 20 8c 4c 89 fe 48 89 d9 e8 76 5f d8 06 90 0f
RSP: 0018:ffffc9000912f928 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 710a8d5645865200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11005f41d00 R08: ffffffff8173e319 R09: 1ffff92001225ec0
R10: dffffc0000000000 R11: fffff52001225ec1 R12: dffffc0000000000
R13: ffff88801e354400 R14: ffff88802c12a810 R15: ffff88801e354410
FS:  00007fcd932e66c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555827377f8 CR3: 000000002046e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 destroy_workqueue+0x7b3/0xc40 kernel/workqueue.c:5847
 gfs2_fill_super+0x128a/0x2500 fs/gfs2/ops_fstype.c:1310
 get_tree_bdev+0x3f7/0x570 fs/super.c:1624
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1329
 vfs_get_tree+0x90/0x2a0 fs/super.c:1789
 do_new_mount+0x2be/0xb40 fs/namespace.c:3471
 do_mount fs/namespace.c:3811 [inline]
 __do_sys_mount fs/namespace.c:4019 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3996
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd9335b60a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 ee 08 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcd932e5fd8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcd932e5ff0 RCX: 00007fcd9335b60a
RDX: 00000000200124c0 RSI: 0000000020012500 RDI: 00007fcd932e5ff0
RBP: 0000000000000005 R08: 00007fcd932e6030 R09: 00000000000124a5
R10: 0000000000000800 R11: 0000000000000282 R12: 00007fcd932e6030
R13: 0000000000000800 R14: 0000000000000004 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x106/0x140 lib/list_debug.c:59
Code: e8 af 5f d8 06 90 0f 0b 48 c7 c7 80 a0 20 8c 4c 89 fe e8 9d 5f d8 06 90 0f 0b 48 c7 c7 e0 a0 20 8c 4c 89 fe e8 8b 5f d8 06 90 <0f> 0b 48 c7 c7 40 a1 20 8c 4c 89 fe 48 89 d9 e8 76 5f d8 06 90 0f
RSP: 0018:ffffc9000912f928 EFLAGS: 00010246

RAX: 000000000000004e RBX: dead000000000122 RCX: 710a8d5645865200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11005f41d00 R08: ffffffff8173e319 R09: 1ffff92001225ec0
R10: dffffc0000000000 R11: fffff52001225ec1 R12: dffffc0000000000
R13: ffff88801e354400 R14: ffff88802c12a810 R15: ffff88801e354410
FS:  00007fcd932e66c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555827377f8 CR3: 000000002046e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

