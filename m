Return-Path: <linux-kernel+bounces-337686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD661984D84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112B9B22DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1714B06E;
	Tue, 24 Sep 2024 22:18:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291B768FD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216304; cv=none; b=pDSU/aUk+KJWP36feh3JmixnIuPGNj4j2mYwP9PrAX95KzHjw7RogiEYdJuRdD2147ST6PGchdsxQYDCSFHMQwfvN96Zk0uMLHETnzRx5yyu9A7TR5kuvqPDynRTcysGmavSz69+36f2g67Xyc5ZQgfptA4JXCidFQ6HYRAMrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216304; c=relaxed/simple;
	bh=mbMNaWBxsNf9sXQScznBlrSR9obFZSdoeRo1DCMhusY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/N1qb/MjiETxBig3og/iwd8Yzv9/IRnDZWlyRA1OZ//z1+5LxT8wcDAhh3RrlPXufjtMrYeyZoe7ulRV5FKbM/C9fiFJZRWGZ95mq1J7LN7gmQuNPB/JtnElOHgYnccZAUY94rbAio4pe2aOm/Bho2DG8ieh8aIV6//vpeB6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cc71ca7aso41074025ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727216302; x=1727821102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMuTEepIq0t9B9L7ttWRYuUpbo1Juj0UT6RiKDkd2Ao=;
        b=sd9bbVtq9eIx71oHytt6L33nS2lxIjUIXK0xx3pi/L1BTkjPPxH1oqkiIBCMVoxSwb
         Avsn6OBLWZQ71mORrsSkc8kKF+1mcjH247+CHBLIuZ9fB63bdDhqGvMQIrnML5u2jkV1
         TyGOQqkid+nIF/OyDTwPB+VHzPFUNgIkA/1Tr6mJ+VLTLofST67yXOY1ww5FjdmoDHsu
         NPxBUDqhOoD4jmp1gHTV1Jw9aV7YPxMfdXFv8sJL7+2SVuC9C2SNP+K93M+6/P+eL/lF
         DrypXJJOXRz1pqNr7d1TJsQESu2vhdTDpB92djbBcrE70egv/pmysrO+eGnxTL3ngQfH
         anoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSFowVaMhclWxECY1VYrr49U+7HMM+WLPoko6TzpSwGVjkLqyPXizIowt4RE1nPYq54YW8cRWyNUQnsmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGfBCIV5+VAkQFPH7XrF/0iwpiU12FgmDJfV4fAZ8dfcYMmQj
	PxexaCDaMlPTmTyeTiqlJ81E5zNpyU4z32w1hp2ftZQBKsZrKL0npWDAg7BjFWywrGD4YPesp2X
	mu5ZwxYkGUm1Pbol1jCzlQrld7GYE0ke4ap7VCI0wk+3GGChwQNlpYXw=
X-Google-Smtp-Source: AGHT+IEwidmnpzqHY8uI1Q6InGxNzhTsDc/xpIR11yJ0X1O8dHgN2WdhgNEiqQIxWY/49qLA2FnqohH1UDdCFqJAw27T1wgHR0ZY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8c:b0:3a0:922f:8e9a with SMTP id
 e9e14a558f8ab-3a26d7be171mr11592935ab.17.1727216301945; Tue, 24 Sep 2024
 15:18:21 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:18:21 -0700
In-Reply-To: <000000000000dbda9806203851ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f33aad.050a0220.457fc.0030.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f08a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fad2a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b7b107980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2179ebeade58/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f05289b5cf7c/bzImage-abf2050f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/326532b68b88/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com

bcachefs: bch2_fs_get_tree() error: EPERM
Filesystem bcachefs get_tree() didn't set fc->root, returned 1
------------[ cut here ]------------
kernel BUG at fs/super.c:1810!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5200 Comm: syz-executor203 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 22 b3 ae 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc9000b457d08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef58520 RCX: 12995cb9c2040600
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11008249016 R08: ffffffff81746c8c R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 0000000000000001
R13: dffffc0000000000 R14: ffff888041248098 R15: ffff8880412480b0
FS:  0000555567b69480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555567b72918 CR3: 000000004ebe6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4a950680a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb635bea8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdb635bec0 RCX: 00007ff4a950680a
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007ffdb635bec0
RBP: 0000000000000004 R08: 00007ffdb635bf00 R09: 0000000000005dc5
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffdb635bf00 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 22 b3 ae 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc9000b457d08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef58520 RCX: 12995cb9c2040600
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11008249016 R08: ffffffff81746c8c R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 0000000000000001
R13: dffffc0000000000 R14: ffff888041248098 R15: ffff8880412480b0
FS:  0000555567b69480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff4a1141000 CR3: 000000004ebe6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

