Return-Path: <linux-kernel+bounces-183439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3248C9913
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401A22818AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73C18AF4;
	Mon, 20 May 2024 07:00:47 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111E179BF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188447; cv=none; b=j6s40ZjdiaNzIJ8br0hTo97n9HVuXUlAiPwITOW+SnDW3pK3Ea4Dq0U3yyrgOF5nabvMz2hOje8w9tScVStJGOluS/wL28/vKhYAiUViok5LiG9lSWzRRyZyRxm8/BhidehWU7+rl4Fi8esnapUORM0rp4MmZCyjT4MZ6Q8lDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188447; c=relaxed/simple;
	bh=8ZRMC5Uly6jS5R8KABa2COBukEnIXeczTynUW9gTJRg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZIKBQ4wgqhjb25/nBYvOI1N8A/98+ftN1KZmH+bqaxEl9tTB2Fkh/3EaoRN+rplAalQ7BPVeG+0qZz0TCdffCTQqI/jtq47jsqk8/jHq51+m9q2N84yvZvglWbcgufrMDobiiZWrRywYwikUGimgfmyZTXYTF0/F5fZ/x/zrVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1eb98f144so779257539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716188445; x=1716793245;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZQa9KdsEtFL8F8GUFXuRdDELKL6g4qjVouGfdg9xxo=;
        b=VqzhGTZ7qRXQkjfBquOtf0jFfNj/+Sp4n6lv9Wa3bc025lLqLMm9I45kI44dH6JULe
         V8fIO92qDhDb57RpSisFTv3MwL8UjdKZrla63zdIdqVrHkCgn8F5Kb0w466hCnBfYD09
         4KMhVHPURAdvnnFX13Z+5Z/iU+VTSdY+Nt4+V8zkpoTr7RYY30JWgQsYwEO8hYx89/pE
         ou6ZpGHCFTrnovJDKs0YfRgsB2v3ILmof41Z5yQ8CSu2PdKqguc9+GpqwoaHhrzlHElw
         DKIMwak4wZqJwBXr5h9+NCIEk1krVtduUKzzpRyYtt2R24AVP3ypaZlzDo+wbBHW6kip
         ygpw==
X-Forwarded-Encrypted: i=1; AJvYcCUxuoqNhSrJpLXFo+6oxPQPL5EMu0LbNt4JxjGwU8XgnOkkwzx8HPdbSGqeRUICR1P3V595umUANUwVvx7vi7kUvVyaa/jc2zi+Tsfz
X-Gm-Message-State: AOJu0YzK7mIARrEw8vS80SeM0EqreFJkq5pLxegg0ALmBSi04Nk8cBGe
	QEWJY4H6BNc/3gRjEDPEMzgP1Pomsxc5UyRra27rY6Xyf1nzV6FRqCA387M/kq8tvmoQUzEaTHd
	qar2EgwDQv0S8V42pp0Ld9GCsovTFFNX0Iyq+PRd9zuZ3u1tSmawweUk=
X-Google-Smtp-Source: AGHT+IERcERSXL1cjB/QB367p7YJ6hxUshBjeTt+wMhwl+DdfAmd+wRw0vOVDLma2ZVyvzwck6XAhf0yVkDwPCksEJVbnpwe8VIa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c1:b0:7d6:5f6:831b with SMTP id
 ca18e2360f4ac-7e1b51aaa1amr90593039f.1.1716188443485; Mon, 20 May 2024
 00:00:43 -0700 (PDT)
Date: Mon, 20 May 2024 00:00:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ab82a0618dd429f@google.com>
Subject: [syzbot] [block?] WARNING: locking bug in mempool_alloc
From: syzbot <syzbot+ed9ea019381af2e78b60@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120186d0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39878f1ce91ccfda
dashboard link: https://syzkaller.appspot.com/bug?extid=ed9ea019381af2e78b60
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a7597d9cd2b5/vmlinux-33e02dc6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93cadb45c580/bzImage-33e02dc6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed9ea019381af2e78b60@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "c->lock" with key __key.0, but found a different class "&c->lock" with the same key
WARNING: CPU: 2 PID: 8623 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 2 PID: 8623 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 80 bd 2c 8b e8 7c 13 75 f6 90 0f 0b 90 90 90 31 db eb be c6 05 9f 47 ef 04 01 90 48 c7 c7 a0 c0 2c 8b e8 5e 13 75 f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900033772c8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff941e3900 RCX: ffffc900078a1000
RDX: 0000000000040000 RSI: ffffffff81516566 RDI: 0000000000000001
RBP: ffffffff94ad7a10 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000006b6f6f4c R12: ffffe8ffad234c20
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94abfba0
FS:  0000000000000000(0000) GS:ffff88802c200000(0063) knlGS:00000000f5f19b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000209fd000 CR3: 000000000062a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 ___slab_alloc+0x73b/0x1810 mm/slub.c:3641
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3682
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 kmem_cache_alloc+0x2f3/0x330 mm/slub.c:3925
 mempool_alloc+0x176/0x390 mm/mempool.c:408
 bio_alloc_bioset+0x480/0x8b0 block/bio.c:554
 bch2_direct_write+0x629/0x4310 fs/bcachefs/fs-io-direct.c:624
 bch2_write_iter+0x10c/0x3180 fs/bcachefs/fs-io-buffered.c:1143
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1120 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7327579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f195ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000020000200
RDX: 0000000000044000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

