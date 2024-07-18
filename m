Return-Path: <linux-kernel+bounces-256819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402499370DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCBB1F223D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0F14658B;
	Thu, 18 Jul 2024 22:51:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB17E0E9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343089; cv=none; b=cpYnJ6OypW0VojTMR7aykLr8tje280pJNC/JJD0j3Z8LJfiiCpp/1cjb4cNkDz7mRiA61UohlqEfUodsW7RYhNe0x8XY3r0ds7K2eW6+6oFOaekpLhSAIpzTdlXAS6ieSQEqxQkUYFc4mWHYFco6Cmin5b/EOQwjHXbh3b+S3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343089; c=relaxed/simple;
	bh=5daDY4S7ANMBPsGS/xMwwnyXgASaYogZ2JGyljoF2jk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fay1YqUq9kYpyTEkJQ0TXUFRg08rPgQqCu7UntGrfCmtAPf6MFHJfzddkJyIjdIYx1CiLcGNGCeNUJUtIYd+fjFdQjIIsUVsdzYsHOBbz8OnnWNlxnSPxwjMoBOJFD1EL4veyO+J6f7ID3LKXghpvSdUQAfzz0+7SWcGfsTuVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f92912a614so204497239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721343086; x=1721947886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLOMDoX3/n4YhSJy3kXGSwCuyRrO+KyDK5eQ4HHpqAg=;
        b=oTQo4RzzlsWkvzXMtkrNzEhfBKYdj+od7EitTNq/frBQTs2PjqUe4px6fSsonBrnf5
         p3apER+IHQRx762dy+vV3uykytfqJPUYyWQnQYWZOQ3ZmECe/JdwpfqwAxUSoRpq8KEz
         oQs5/aSygogi7f6kJPvODKEInV1v5R7r748M/XP/QUtxViBrRBdGQhZEcJZtoESwOqMk
         XOoPgkQbQAsjvrO4I7vBIIM5u5laXfLB+iU5HcrUx0R3bT0ZiAzycnt/FKH5fmHHk1Bk
         2nLTolkIeo1psv+D+VdEm4d82L0B1znYQMkB4RRZcdyVO/rkF/2IQzOZdx2ca5A2STUp
         vyHA==
X-Forwarded-Encrypted: i=1; AJvYcCWan+GEtwZygRxQnVFw5MQiI0qzoBCiI2dw/lO7egroVVePjxJTe9RqSebdul1I2Djf0l971O1G90c+jo9KVHXq03WXS3m00LR1CGPm
X-Gm-Message-State: AOJu0YxagEuDBu1QgyeHFMg96VHxAHkViTwH2p6wWEXtrNHcvRobHVZy
	TbrRjZTOBa1SwuHPq3FXwlyfrj4oZoNpMdD5K5qDAO8JKhENlalq5f49lu5xFLqVHEPb6umjzZM
	kfHaHpvhx5KQghmoaChW10BRA2tXcgMy46/5nA48owizAGXI5G7VLJe4=
X-Google-Smtp-Source: AGHT+IF0s4dojWYc+De78j1F4r25m5KjlrSLHELcPAgFaPF1q/dfz8FR0NiyG6IZX5Wc56OKMvBNobTnZygqHPj5g3R3MEbw37nP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:4c0:73d0:3d77 with SMTP id
 8926c6da1cb9f-4c215d03b50mr403814173.5.1721343086426; Thu, 18 Jul 2024
 15:51:26 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:51:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000341f5f061d8d6bcb@google.com>
Subject: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11321495980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e054e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1366ab85980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4d145e3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28dead26b828/vmlinux-4d145e3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/079a7ff04a12/Image-4d145e3f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com

BUG: Bad page cache in process syz-executor356  pfn:ba081
page: refcount:4 mapcount:1 mapping:000000000e551739 index:0x0 pfn:0xba081
memcg:f7f0000002c3a000
aops:shmem_aops ino:3
flags: 0x1ffc0000004002d(locked|referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002d ffffc1ffc01cd7c8 ffffc1ffc1e86288 f9f000000749ba50
raw: 0000000000000000 0000000000000000 0000000400000000 f7f0000002c3a000
page dumped because: still mapped when deleted
CPU: 0 PID: 3196 Comm: syz-executor356 Not tainted 6.10.0-rc7-syzkaller-00266-g4d145e3f830b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 filemap_unaccount_folio+0x118/0x278 mm/filemap.c:167
 __filemap_remove_folio+0x3c/0x178 mm/filemap.c:231
 filemap_remove_folio+0x48/0xa8 mm/filemap.c:264
 truncate_inode_folio+0x30/0x4c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 __fput_sync+0x50/0x5c fs/file_table.c:507
 __do_sys_close fs/open.c:1563 [inline]
 __se_sys_close fs/open.c:1548 [inline]
 __arm64_sys_close+0x38/0x7c fs/open.c:1548
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page cache in process syz-executor356  pfn:ba18a
page: refcount:4 mapcount:1 mapping:000000000e551739 index:0x1 pfn:0xba18a
memcg:f7f0000002c3a000
aops:shmem_aops ino:3
flags: 0x1ffc0000004002d(locked|referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002d ffffc1ffc1e82048 ffffc1ffc028a2c8 f9f000000749ba50
raw: 0000000000000001 0000000000000000 0000000400000000 f7f0000002c3a000
page dumped because: still mapped when deleted
CPU: 0 PID: 3196 Comm: syz-executor356 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 filemap_unaccount_folio+0x118/0x278 mm/filemap.c:167
 __filemap_remove_folio+0x3c/0x178 mm/filemap.c:231
 filemap_remove_folio+0x48/0xa8 mm/filemap.c:264
 truncate_inode_folio+0x30/0x4c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 __fput_sync+0x50/0x5c fs/file_table.c:507
 __do_sys_close fs/open.c:1563 [inline]
 __se_sys_close fs/open.c:1548 [inline]
 __arm64_sys_close+0x38/0x7c fs/open.c:1548
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page map in process syz-executor356  pte:600000ba0818c3 pmd:800000047670003
page: refcount:1 mapcount:-1 mapping:0000000000000000 index:0x0 pfn:0xba081
memcg:f7f0000002c3a000
flags: 0x1ffc0000004002c(referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002c ffffc1ffc028c708 ffffc1ffc1e86288 0000000000000000
raw: 0000000000000000 0000000000000000 00000001fffffffe f7f0000002c3a000
page dumped because: bad pte
addr:00000000209a0000 vm_flags:400000f9 anon_vma:0000000000000000 mapping:f3f0000006dcee48 index:0
file:dmabuf fault:udmabuf_vm_fault mmap:dma_buf_mmap_internal read_folio:0x0
CPU: 0 PID: 3196 Comm: syz-executor356 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 print_bad_pte+0x1c8/0x258 mm/memory.c:538
 zap_present_folio_ptes mm/memory.c:1508 [inline]
 zap_present_ptes mm/memory.c:1564 [inline]
 zap_pte_range mm/memory.c:1606 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0x904/0x1190 mm/memory.c:1795
 unmap_single_vma.constprop.0+0x4c/0x84 mm/memory.c:1841
 unmap_vmas+0x7c/0x170 mm/memory.c:1885
 exit_mmap+0xc0/0x288 mm/mmap.c:3341
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page map in process syz-executor356  pte:600000ba18a8c3 pmd:800000047670003
page: refcount:1 mapcount:-1 mapping:0000000000000000 index:0x1 pfn:0xba18a
memcg:f7f0000002c3a000
flags: 0x1ffc0000004002c(referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002c ffffc1ffc1e82048 ffffc1ffc028a2c8 0000000000000000
raw: 0000000000000001 0000000000000000 00000001fffffffe f7f0000002c3a000
page dumped because: bad pte
addr:00000000209a1000 vm_flags:400000f9 anon_vma:0000000000000000 mapping:f3f0000006dcee48 index:1
file:dmabuf fault:udmabuf_vm_fault mmap:dma_buf_mmap_internal read_folio:0x0
CPU: 0 PID: 3196 Comm: syz-executor356 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 print_bad_pte+0x1c8/0x258 mm/memory.c:538
 zap_present_folio_ptes mm/memory.c:1508 [inline]
 zap_present_ptes mm/memory.c:1564 [inline]
 zap_pte_range mm/memory.c:1606 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0x904/0x1190 mm/memory.c:1795
 unmap_single_vma.constprop.0+0x4c/0x84 mm/memory.c:1841
 unmap_vmas+0x7c/0x170 mm/memory.c:1885
 exit_mmap+0xc0/0x288 mm/mmap.c:3341
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page state in process syz-executor356  pfn:ba081
page: refcount:0 mapcount:-1 mapping:0000000000000000 index:0x0 pfn:0xba081
flags: 0x1ffc0000004000c(referenced|uptodate|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004000c dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 3196 Comm: syz-executor356 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 bad_page+0x84/0x11c mm/page_alloc.c:498
 free_page_is_bad_report+0x98/0xa4 mm/page_alloc.c:904
 free_page_is_bad mm/page_alloc.c:914 [inline]
 free_pages_prepare mm/page_alloc.c:1085 [inline]
 free_unref_folios+0x4c0/0x624 mm/page_alloc.c:2637
 folios_put_refs+0x108/0x284 mm/swap.c:1024
 free_pages_and_swap_cache+0x14c/0x164 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0x4c/0xdc mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x84/0x200 mm/mmu_gather.c:465
 exit_mmap+0x13c/0x288 mm/mmap.c:3354
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page state in process syz-executor356  pfn:ba18a
page: refcount:0 mapcount:-1 mapping:0000000000000000 index:0x1 pfn:0xba18a
flags: 0x1ffc0000004000c(referenced|uptodate|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004000c dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 3196 Comm: syz-executor356 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 bad_page+0x84/0x11c mm/page_alloc.c:498
 free_page_is_bad_report+0x98/0xa4 mm/page_alloc.c:904
 free_page_is_bad mm/page_alloc.c:914 [inline]
 free_pages_prepare mm/page_alloc.c:1085 [inline]
 free_unref_folios+0x4c0/0x624 mm/page_alloc.c:2637
 folios_put_refs+0x108/0x284 mm/swap.c:1024
 free_pages_and_swap_cache+0x14c/0x164 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0x4c/0xdc mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x84/0x200 mm/mmu_gather.c:465
 exit_mmap+0x13c/0x288 mm/mmap.c:3354
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598


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

