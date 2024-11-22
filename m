Return-Path: <linux-kernel+bounces-417860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF59D59EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E21B22FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7563170A03;
	Fri, 22 Nov 2024 07:22:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66016849F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260147; cv=none; b=sNiP/kLVj7AvbMinJKtdUKQtOLnp7gzZ2ZyvRJrOQ8GlIWzyWfon9i0lxEyiF+jZrk84nw8Js4+d3VnzyAChyo93uJX6DxMI+E5XWJGxi+3MWV4NXl2JFwQSottvjdOF2JBOEypyfAzIGOTEW5Tm9VOCinoviB/sX++erW/jw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260147; c=relaxed/simple;
	bh=4dKua7LPma30IvOSBKXaZ7Ub2N1Od4NAMsomTlD2gY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tj3JhKXBMu0Z03qwL2kIkkUOfxiU6pY792IR9cNEBxNhdNXxCOaeAk2uVv77F/uRPrZoGdyPA15bcUQHIBoaBWHkr+S1GPvv8aBqqfYOAnVkFLMGRxcIcD0qTpkhZBVKPfVBafzrlCP4q15NeAf2XWtR5yGRGxonM9tgwBuHiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so22741255ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732260144; x=1732864944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6ZGyE87cCNHS6XlBd2eJHvaAndp876wAxmNd8wvXQc=;
        b=K3jO7pb6BeHFdmSG1GMc5ApH9wuIWOFlJqJxv5+oGMBnbK/X23ocM9BIrEeAVihQ9O
         FWfR1hKvkbm4VNsjf9iQ5khLHAL5FA8Iu/v8tl2sXkNLzOAfO9KR86gVXCDjvE972ZR0
         wM4ZUa+I1CXEgHWcK0s6r1tO9AYH9VoxnanGnrM0M+Fn18ZfnSZ5yODv9pISxZcm4Ahw
         Ar6XdFsb9gE7UdENxEwkCeWLLdchTAIIk07l13PoghqD8YVyZREd7yC9Dvq+HydAiSQN
         y4D5y50zYny2OtBPDUh7hUBgUERoCauqGDxLfqua3G9nThAN7cURGKTeUaUKXnEwH+EL
         4hiw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Fq+OhQkqp4U748EGrTawgniJFuBtS77A74JptM0RQ/q9UxltF3D76edq6L46Ck2KjPvZB/IS19UXeQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImdrukAgjkWx7TNs5zwHhB/V+SvbOrgKtvrLCR6nrNnFwvZVf
	h3Wxy+HoH82gyuq33F7htwpNpbYrJ7WphsMAE+1w3blXB5cUmBshsTc1enJqgmAVAtL5EOcJ6JO
	8BNTqlAWfdE/pi1yNerpt2dytT+kuThK8SZifqX3PXt+65OFqlTiekE0=
X-Google-Smtp-Source: AGHT+IETxpL5H1tyxccOBRQbfvw+DynHW5o6GowzulfcstykPExY3+C2uhIo+E53g87+xCBlKeK93CUUZHhWhxQ88puZUb3tQKNV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3a7:6dde:c78b with SMTP id
 e9e14a558f8ab-3a79ae24732mr26448975ab.8.1732260144759; Thu, 21 Nov 2024
 23:22:24 -0800 (PST)
Date: Thu, 21 Nov 2024 23:22:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67403130.050a0220.3c9d61.018b.GAE@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_fs_read_write_early (2)
From: syzbot <syzbot+61a8a372d9269e5c9c6d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f66d6acccbc0 Merge tag 'x86_urgent_for_v6.12' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171d3378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b7d4b29182ed62
dashboard link: https://syzkaller.appspot.com/bug?extid=61a8a372d9269e5c9c6d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f66d6acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4b910af2286/vmlinux-f66d6acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a72e7698c7be/bzImage-f66d6acc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61a8a372d9269e5c9c6d@syzkaller.appspotmail.com

bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 3812 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 3570 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 3328 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 3086 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 2844 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 2602 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 2360 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 2118 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 1876 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 1634 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 1392 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 1150 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 908 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 666 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 424 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): error validating btree node at btree extents level 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c6c25c03258c59c5 written 1032 min_key POS_MIN durability: 1 ptr: 0:27:0 gen 0  
  node offset 0/1032 bset u64s 182 bset byte offset 160: bad k->u64s 0 (min 3 max 253), fixing
bcachefs (loop0): btree_node_read_work: rewriting btree node at btree=extents level=0 SPOS_MAX due to error
------------[ cut here ]------------
WARNING: CPU: 0 PID: 37 at fs/bcachefs/super.c:526 bch2_fs_read_write_early+0x7f/0xb0 fs/bcachefs/super.c:526
Modules linked in:
CPU: 0 UID: 0 PID: 37 Comm: kworker/0:1H Not tainted 6.12.0-rc7-syzkaller-00216-gf66d6acccbc0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bcachefs_btree_read_complete btree_node_read_work
RIP: 0010:bch2_fs_read_write_early+0x7f/0xb0 fs/bcachefs/super.c:526
Code: e8 46 74 48 fd 85 ed 74 1b e8 fd 6f 48 fd eb 05 e8 f6 6f 48 fd 48 89 df be 01 00 00 00 5b 5d e9 07 fc ff ff e8 e2 6f 48 fd 90 <0f> 0b 90 eb e6 48 c7 c1 4c 40 1d 90 80 e1 07 80 c1 03 38 c1 7c 96
RSP: 0018:ffffc9000057f8f8 EFLAGS: 00010293
RAX: ffffffff844c7a2e RBX: ffff888050100000 RCX: ffff88801ddb0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff844c7a0a R09: 1ffff1100a020035
R10: dffffc0000000000 R11: ffffed100a020036 R12: ffff88803664b300
R13: 1ffff1100a020035 R14: ffff8880501001a8 R15: ffff888050100000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555777f85f8 CR3: 0000000040778000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_node_rewrite_async+0x3df/0x6a0 fs/bcachefs/btree_update_interior.c:2287
 btree_node_read_work+0xf59/0x1260 fs/bcachefs/btree_io.c:1350
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

