Return-Path: <linux-kernel+bounces-415405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A79D3599
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A604282F89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE316DEB5;
	Wed, 20 Nov 2024 08:37:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CB155C87
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091849; cv=none; b=cYx/Onms5A60b74K8qGRpQFeeYKsglVmGWe2X8RRQM7VveTgcjjRdM7gs6VaGGgIYUtnGyThvk7bLiKxZUhHwISaFr9q3Y5+vWukaT8o6uRyI7wuFxriS1F7miAc2nz1/avh2rpOhDdRRkHBMpxGJec/AbkPb5LFAOSVAfQ8Yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091849; c=relaxed/simple;
	bh=JaZCZfEk3wTLnAMVI8HQ6TVQ/TvaU+i+9t4sSDvhhXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IFKg/nsmCIXYtXItsljjxvX9m9GxDk2fNk6R1lmhVOk/1gQ30iq0Q3ubEg6hCgxdbNghgh+KbVf0mQq5fiFZ9+QQB1PFBqAEhx0kYvV2wfoB4b2s9XOor9BmhN7hTd82h2QonJDKWWBd4GGGSI7Q9Sh5AH8y41UHMWcUk1ck0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abd63a132so61224439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732091845; x=1732696645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1mNTdFWlNxgVTdZTN2bRARQ5uLY1/kHWs5hG3UNv2E=;
        b=APj9CkiDRCr8pe43Ey8jwipJjlgWswQnWMz24vuuYROyI7GP2LEAOghHhBcW4Rif/R
         1BvJHE/o9R0vNRX4fHKOSo2uw7YpgHrwhBTTnS02hGLZBIT8YyucuZWn+GfesufGf1Ck
         rR8RPAp3H2zY15IKz+m30yk6lahzit6sxpSEiaEp/yKxE/mqS9r0j7H59Z3A5fCemldb
         3WFLTOYCrtasusT4vx4AL6r36EbSd6e2RmIIU7pwSltJFXS3yVpPe8kG5htrThXqXTSs
         pd5j/XTBhej0rxNYy0YVhIhvkxed9Q2wdm3ODoQZa3ZX7L6tx0XC2PNlyyVVjShHzMQs
         v9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWaSLSmHUj0EYsmX/VoNgq+HLkhGpMSmfNJ73Qu1SLirX2DVX9M010xySaafML3XMdyUlmHR6kcBls0fbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMHLw9L23d7ERRMN/wP7dtxFkoapMw14Fd/a2I1HQBSEnRsIg
	M3K2jAxYFB/WtO2i5h8kqX/gBpPHiOg/65R7xBijeq5sxrZBG+X4UAg+BxYktAagKkUrc+TPkKQ
	FPRoemd5qjB2cubQaDVOYvXwzuBlm0cKtMDvcjpsA8zWSToJc9yX+pEE=
X-Google-Smtp-Source: AGHT+IHN/V9+zJmv1ojDAp54BJW3WpRbBHtasqnX/39khI0JTuEZGuIQJi8N6keIHvHs45o2qBcP5Otqx7e5+6yiehNjxKlEn8Eb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:3a7:81bc:e3a with SMTP id
 e9e14a558f8ab-3a7857833f0mr25753065ab.10.1732091845280; Wed, 20 Nov 2024
 00:37:25 -0800 (PST)
Date: Wed, 20 Nov 2024 00:37:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673d9fc5.050a0220.363a1b.0007.GAE@google.com>
Subject: [syzbot] [mm?] BUG: Bad page state in iomap_write_begin
From: syzbot <syzbot+c317c107c68f8bc257d9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8bdb3c8be08 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1644d2c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=c317c107c68f8bc257d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1144d2c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176252e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e8bdb3c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcae16ff0e0f/vmlinux-e8bdb3c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/758973beace8/bzImage-e8bdb3c8.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/a097a300c8a9/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/36b9fff6ab5e/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c317c107c68f8bc257d9@syzkaller.appspotmail.com

BUG: Bad page state in process syz-executor315  pfn:49e01
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x49e01
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001278001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001278001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5313, tgid 5313 (syz-executor315), ts 64129995228, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Not tainted 6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x237/0x460
 free_pages_prepare mm/page_alloc.c:1103 [inline]
 free_unref_page+0x805/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
BUG: Bad page state in process syz-executor315  pfn:49e00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49e00
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5313, tgid 5313 (syz-executor315), ts 64129995228, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x105e/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor315  pfn:49c01
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x49c01
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001270001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001270001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5323, tgid 5323 (syz-executor315), ts 64839944572, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x237/0x460
 free_pages_prepare mm/page_alloc.c:1103 [inline]
 free_unref_page+0x805/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
BUG: Bad page state in process syz-executor315  pfn:49c00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49c00
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5323, tgid 5323 (syz-executor315), ts 64839944572, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x105e/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor315  pfn:49601
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x49601
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001258001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001258001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5332, tgid 5332 (syz-executor315), ts 65574250861, free_ts 65305696974
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x64c/0x1cf0 mm/shmem.c:1032
 shmem_truncate_range mm/shmem.c:1144 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1274
 evict+0x4e8/0x9b0 fs/inode.c:725
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 __fput+0x5d2/0x880 fs/file_table.c:439
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x237/0x460
 free_pages_prepare mm/page_alloc.c:1103 [inline]
 free_unref_page+0x805/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
BUG: Bad page state in process syz-executor315  pfn:49600
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49600
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5332, tgid 5332 (syz-executor315), ts 65574250861, free_ts 65305701576
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x64c/0x1cf0 mm/shmem.c:1032
 shmem_truncate_range mm/shmem.c:1144 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1274
 evict+0x4e8/0x9b0 fs/inode.c:725
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 __fput+0x5d2/0x880 fs/file_table.c:439
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x105e/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor315  pfn:4aa01
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x4aa01
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00012a8001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea00012a8001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5341, tgid 5341 (syz-executor315), ts 66297529696, free_ts 65289952304
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x237/0x460
 free_pages_prepare mm/page_alloc.c:1103 [inline]
 free_unref_page+0x805/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
BUG: Bad page state in process syz-executor315  pfn:4aa00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4aa00
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5341, tgid 5341 (syz-executor315), ts 66297529696, free_ts 65289952304
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x105e/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor315  pfn:4a401
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x4a401
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001290001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001290001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5350, tgid 5350 (syz-executor315), ts 67030622284, free_ts 66809006649
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x237/0x460
 free_pages_prepare mm/page_alloc.c:1103 [inline]
 free_unref_page+0x805/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
BUG: Bad page state in process syz-executor315  pfn:4a400
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4a400
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5350, tgid 5350 (syz-executor315), ts 67030622284, free_ts 66809006649
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x105e/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor315  pfn:4a601
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x4a601
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001298001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001298001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5359, tgid 5359 (syz-executor315), ts 67750523655, free_ts 67529968020
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x237/0x460
 free_pages_prepare mm/page_alloc.c:1103 [inline]
 free_unref_page+0x805/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
BUG: Bad page state in process syz-executor315  pfn:4a600
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4a600
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5359, tgid 5359 (syz-executor315), ts 67750523655, free_ts 67529968020
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor315 Tainted: G    B              6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:923 [inline]
 free_pages_prepare mm/page_alloc.c:1119 [inline]
 free_unref_page+0x105e/0x1140 mm/page_alloc.c:2657
 __folio_put+0x2c7/0x440 mm/swap.c:112
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd10ac807
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c2a8d88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007febd10ac807
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1c2a8e40
RBP: 00007ffd1c2a8e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd1c2a9eb0
R13: 000055558d5376c0 R14: 431bde82d7b634db R15: 00007ffd1c2a9ed0
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor315  pfn:4b401
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x4b401
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00012d0001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea00012d0001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5368, tgid 5368 (syz-executor315), ts 68466402985, free_ts 68270900026
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:993
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/

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

