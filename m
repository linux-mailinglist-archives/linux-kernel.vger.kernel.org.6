Return-Path: <linux-kernel+bounces-563090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A7A636E4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89244188F275
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66F1DDA15;
	Sun, 16 Mar 2025 18:05:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABF14A4F0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742148331; cv=none; b=nM7VRJ4wR14yRHaGWaTlwwJkZojzi0iuBDvnTvWnqs2vgtNN0oKfcgjsQd2ZtwpwPeZ/tW5K2h3IwVAlThWod5JIwKDCuvRtgXVRQrdp2gXJqldhQnxvOPH0jZLxAa29RoY2KZV4EOT+dRx/+IUBohsyAeGCgFuJiSXDyGKLgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742148331; c=relaxed/simple;
	bh=wSenMd7JE2bKBNwtBWn+AV+6AQ/4QGmL5Kj5woZLk+k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rhHNlPp5JV/AOdjXayII/0uaOhOsG8xwsnIVDXTwH3ztNRZVNm7TCW0QPHVn18z3QFOkCFJmfE7xwYZIv7lDwqzhhYlpQf+/TVKTMVh0uzIYOAhQQr4dTIkM/VHBmhJYubXAS+/GT9e3vAn9m0WOIw6l2IYuTE9Um7GIMW2U1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b3b781313so791423439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 11:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742148329; x=1742753129;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KAG5K4bfCIVHIXppjmJThpHWvzF7Fm7+i+OemRn1ng=;
        b=VPPSqsQexwZalDdGsT2s33LudiTBOy7E0LRT+kCRHg/sV2szidMA02Nk1CG5YmE9KS
         9IMr3nknZt653K4STt5fM/CIq4b/0eoIpxxMZFl7S476qxK2DnLen2tlwzw24NwWJDys
         Qo0DQ9rovvIWjnyaEh4eQBZFbs6FoEzlDp3+YtQP1i53jukszM7BANvQtfNaI7Z+w043
         hHQ0JOsd7jcL4xr2B6pftGVUPZ9OdpVOBboOdryERRAR3txqYy1/cHBvX9MygJIB6jok
         hXABk0coiyxq+jmq8CxDGtUMawGULssTuIAnfjvzTihtbYfL0L67Ctros9It87gDlTxp
         86rg==
X-Forwarded-Encrypted: i=1; AJvYcCWnx3XAI+bkzTOxCvTHg9VCFXDlOvvD0ohVXa7gf/NAFp33K9WvJhR3zXuojI/ZmcUfawCd4PJujHUHbzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKN6+nSOvP3jSdHdlUsw4EzWwEMD/NjiU/HIESmMLFlrDKKjI
	PnOVj5gc4+Du5Gx3YrN5ShnF7Fg9bbinqxO6dHpUOX+6jlBli9JZtbPJpJn8ivTPpNElncdTl2A
	72N99OagCN7nWErEP4TlxDjqfddKRNO8/LZqBd1tniS68xY0HxGNC+lM=
X-Google-Smtp-Source: AGHT+IFcRMN7lXg2XCJXA5zNF34/K2/fxovFLJNrG8asO69HI0vXiJMMDBcs8UkdyuTn59hX91eHZBhXd1PiiLgCOBQoqecMGo1k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3787:b0:3d4:341a:441d with SMTP id
 e9e14a558f8ab-3d483a32c7amr88155445ab.10.1742148329160; Sun, 16 Mar 2025
 11:05:29 -0700 (PDT)
Date: Sun, 16 Mar 2025 11:05:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d712e9.050a0220.3d01d1.013d.GAE@google.com>
Subject: [syzbot] [mm?] [bcachefs?] general protection fault in xas_create
From: syzbot <syzbot+85a56f124ac1ea0ac0cb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fed89a961ea Merge tag 'hyperv-fixes-signed-20250311' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ea1874580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31c94a07ddad0b00
dashboard link: https://syzkaller.appspot.com/bug?extid=85a56f124ac1ea0ac0cb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16124c78580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0fed89a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e4d0fd4258e/vmlinux-0fed89a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea186f3b1240/bzImage-0fed89a9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2c3be83f8b9f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85a56f124ac1ea0ac0cb@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0x7d0034f00001880: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5719 Comm: syz.4.37 Not tainted 6.14.0-rc6-syzkaller-00016-g0fed89a961ea #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_freepointer mm/slub.c:504 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:532 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3993 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:4152 [inline]
RIP: 0010:kmem_cache_alloc_lru_noprof+0xed/0x390 mm/slub.c:4183
Code: 0f 84 8e 01 00 00 41 83 f8 ff 74 1a 48 8b 03 48 83 f8 ff 0f 84 97 02 00 00 48 c1 e8 3a 41 39 c0 0f 85 6e 01 00 00 41 8b 47 28 <4a> 8b 1c 20 49 8d 4d 08 49 8b 37 4c 89 e0 4c 89 ea 65 48 0f c7 0e
RSP: 0018:ffffc9000d037478 EFLAGS: 00010046
RAX: 0000000000000240 RBX: ffffea0000ecb880 RCX: 0000000000043ba0
RDX: 0000000000000001 RSI: 0000000000000240 RDI: ffffffff8ec54460
RBP: ffffffff8c06a1c0 R08: 00000000ffffffff R09: fffff52001a06ea8
R10: dffffc0000000000 R11: fffff52001a06ea8 R12: 07d0034f00001640
R13: 0000000000016220 R14: 0000000000402800 R15: ffff88801b04fdc0
FS:  00007fd8409fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa6ac013000 CR3: 0000000012b64000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xas_alloc lib/xarray.c:377 [inline]
 xas_create+0x10d0/0x1ae0 lib/xarray.c:684
 xas_store+0x96/0x1870 lib/xarray.c:794
 shmem_add_to_page_cache+0x89d/0xcc0 mm/shmem.c:897
 shmem_alloc_and_add_folio+0x968/0x1090 mm/shmem.c:1928
 shmem_get_folio_gfp+0x621/0x1840 mm/shmem.c:2545
 shmem_get_folio mm/shmem.c:2651 [inline]
 shmem_write_begin+0x165/0x350 mm/shmem.c:3301
 generic_perform_write+0x346/0x990 mm/filemap.c:4188
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3477
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xacf/0xd10 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd84178bc1f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007fd8409fddf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007fd84178bc1f
RDX: 0000000001000000 RSI: 00007fd838400000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000590c
R10: 0000000000000002 R11: 0000000000000293 R12: 0000000000000003
R13: 00007fd8409fdef0 R14: 00007fd8409fdeb0 R15: 00007fd838400000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:get_freepointer mm/slub.c:504 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:532 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3993 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:4152 [inline]
RIP: 0010:kmem_cache_alloc_lru_noprof+0xed/0x390 mm/slub.c:4183
Code: 0f 84 8e 01 00 00 41 83 f8 ff 74 1a 48 8b 03 48 83 f8 ff 0f 84 97 02 00 00 48 c1 e8 3a 41 39 c0 0f 85 6e 01 00 00 41 8b 47 28 <4a> 8b 1c 20 49 8d 4d 08 49 8b 37 4c 89 e0 4c 89 ea 65 48 0f c7 0e
RSP: 0018:ffffc9000d037478 EFLAGS: 00010046
RAX: 0000000000000240 RBX: ffffea0000ecb880 RCX: 0000000000043ba0
RDX: 0000000000000001 RSI: 0000000000000240 RDI: ffffffff8ec54460
RBP: ffffffff8c06a1c0 R08: 00000000ffffffff R09: fffff52001a06ea8
R10: dffffc0000000000 R11: fffff52001a06ea8 R12: 07d0034f00001640
R13: 0000000000016220 R14: 0000000000402800 R15: ffff88801b04fdc0
FS:  00007fd8409fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa6ac013000 CR3: 0000000012b64000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 84 8e 01 00 00    	je     0x194
   6:	41 83 f8 ff          	cmp    $0xffffffff,%r8d
   a:	74 1a                	je     0x26
   c:	48 8b 03             	mov    (%rbx),%rax
   f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  13:	0f 84 97 02 00 00    	je     0x2b0
  19:	48 c1 e8 3a          	shr    $0x3a,%rax
  1d:	41 39 c0             	cmp    %eax,%r8d
  20:	0f 85 6e 01 00 00    	jne    0x194
  26:	41 8b 47 28          	mov    0x28(%r15),%eax
* 2a:	4a 8b 1c 20          	mov    (%rax,%r12,1),%rbx <-- trapping instruction
  2e:	49 8d 4d 08          	lea    0x8(%r13),%rcx
  32:	49 8b 37             	mov    (%r15),%rsi
  35:	4c 89 e0             	mov    %r12,%rax
  38:	4c 89 ea             	mov    %r13,%rdx
  3b:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)


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

