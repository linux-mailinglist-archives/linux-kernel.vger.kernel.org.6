Return-Path: <linux-kernel+bounces-412050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF69D02EF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D721F231BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00183A17;
	Sun, 17 Nov 2024 10:42:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF906AA7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731840150; cv=none; b=F7UFeCMjfzfLsFUjVLjxhILd8Zm5MJI8FZ9ekdFra052TnVhalzjT08mYvCvUGnADMx6rEXmme0wAVdP7Q0AmspuvfWr24qe4/hNAHXSgyPZLH0jo7nApbpzG537RvRlIf3efIkaEdSKuEPzcD944oNIhgu664HRw/M296P+iHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731840150; c=relaxed/simple;
	bh=fS6gIs2YCMjvaf4VemXxajdOUZbC5s0Lv1DwaGdGvTA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V5TgdUak0ZVf9jwjYIs8/gRjktAGnkBNvdAl5DZHr+Udse119idDvVBjjN5Cti8KElvfmjPYYzLC90E3rgegRNhFoT43m2f5myDtMYeJmYAY3o8IyJ4HEnh/za+AmzlkINr5sNw5edn5viWB6+02ca/xeBKuqn94ck4JYqcTEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so39972755ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 02:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731840146; x=1732444946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3/ZEbNaozp/zY0eVRNkJ49WlBbJWzBHW/i3fEBE/+4=;
        b=bQMeRbJeg9PBMYChGFreMr1Fbsl5L8n1FMAzpAIJsXhv9gqfS5UItED8qmGeDQjiXZ
         NjowZe30cGE+62zzIKDVwowrofe+D+ulk04xdRZnTGhDZ938W4pwn87u345kUWn/4ICO
         n0tfnUykgd7p/J1OvpLEpfq1QsjhAbq8Fh0FHi7RtfPB334gVFMdahRMhvwMRWaVI3uh
         0o/1qzLwav/fAFS+FZoBDIrQOypJxPJC1f/2Td7/h/JUomuySfW0rjK24Pc/7bxRA8jw
         hAWEmXOpKG0NmVGTEPl26A0yexoiDdMqndwOK29tUO+bbvSXrSgnsaWdMm9v3w1cyYSr
         uNNA==
X-Forwarded-Encrypted: i=1; AJvYcCWAE1goL8TOQpiI3P3kxJNuuxrmckFnGj4l07s8O9AqGWn+1+Wmio2qhcMUW8FV3ri1fXTWPM56boKckSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGZj/H5Aq9YB9/qZDurGT8n9+I7a9V516LpWRZn7IEJk6uN1p
	KoU1ZP7wwTbOxOG/RkYGjH6FvFlcYqXiEvBc5ozF6ckgQpwcuRmZkDJpz2UhKucSGwKXpsHJL2X
	aCeTAfE4hX3QhvEsZ8M09fgfnrcf9iReYw8gJ3lWhMUOHc2a6ZlTNh0s=
X-Google-Smtp-Source: AGHT+IFUj2UzBSpTz9bbSqlwNzkk030sVmgy32lJl42dIJbYxIRD7vT3borjPPI8N7R8IIKMHficXk11WSsAK9PG6CJVn1TEL8q8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3a74800e1a5mr107440455ab.3.1731840146691; Sun, 17 Nov 2024
 02:42:26 -0800 (PST)
Date: Sun, 17 Nov 2024 02:42:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739c892.050a0220.e1c64.0013.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in mas_store_prealloc
From: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147521a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e14c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0a2/disk-8e9a54d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/vmlinux-8e9a54d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50315382fefb/Image-8e9a54d7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com

 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6421 Comm: syz-executor374 Not tainted 6.12.0-rc7-syzkaller-g8e9a54d7181b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mt_slot_locked lib/maple_tree.c:795 [inline]
pc : mas_slot_locked lib/maple_tree.c:808 [inline]
pc : mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514
lr : mt_slot_locked lib/maple_tree.c:795 [inline]
lr : mas_slot_locked lib/maple_tree.c:808 [inline]
lr : mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514
sp : ffff8000a3e57440
x29: ffff8000a3e57560 x28: ffff8000a3e574c0 x27: dfff800000000000
x26: ffff7000147cae94 x25: 0000000000000008 x24: 0000000000000000
x23: 0000000000000008 x22: ffff0000daed1040 x21: 0000000000000008
x20: ffff8000a3e578e0 x19: 0000000000000000 x18: 0000000000000008
x17: 0000000000000000 x16: ffff800080585ea8 x15: 0000000000000009
x14: 1ffff000147cae99 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000147caea2 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000001
x5 : ffff8000a3e565f8 x4 : 0000000000000008 x3 : ffff80008b4208f0
x2 : ffffffffffffffc0 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 mt_slot_locked lib/maple_tree.c:795 [inline] (P)
 mas_slot_locked lib/maple_tree.c:808 [inline] (P)
 mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514 (P)
 mt_slot_locked lib/maple_tree.c:795 [inline] (L)
 mas_slot_locked lib/maple_tree.c:808 [inline] (L)
 mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514 (L)
 vma_iter_store+0x2e8/0x81c mm/vma.h:476
 __mmap_region mm/mmap.c:1513 [inline]
 mmap_region+0x1650/0x1d44 mm/mmap.c:1603
 do_mmap+0x8c4/0xfac mm/mmap.c:496
 vm_mmap_pgoff+0x1a0/0x38c mm/util.c:588
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:542
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 393b2668 972c43de 8b180ef5 d343fea8 (387b6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	393b2668 	strb	w8, [x19, #3785]
   4:	972c43de 	bl	0xfffffffffcb10f7c
   8:	8b180ef5 	add	x21, x23, x24, lsl #3
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	387b6908 	ldrb	w8, [x8, x27] <-- trapping instruction


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

