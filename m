Return-Path: <linux-kernel+bounces-342661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95291989162
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7E0B23999
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BA167271;
	Sat, 28 Sep 2024 20:44:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF114A0B8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727556268; cv=none; b=jMY8623uGlcTrmW9m1dRexCEiuk5RIROuO/OTq0Ya2FW6SclXKF0rYQI6SodzrivZv1LcYOat6hQMQuCP3k2gR4c5g5FivhEmojw+Xm/DNiCXRZXCIYDj8aCdb3uwEXgN1ddZDB1UQXWsajglciraBFjA/UsgnUcqGpxym07ub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727556268; c=relaxed/simple;
	bh=xK92XJKpvl2jznIpsqasxgaiZMbexEahTGhd22IAd+0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YZUMwNin8WOpluZE5Hd1KeJGN3eKy9ZmqHjz07k5PPV5sx1rN/ENfjobXwfTb1De6bJ9ZW4ygFN6gOLYIvzqJFE7j7UMEo4V2LqqvW/KvVU1911widVhxCNPYFPzfPuDnTOkC6dH6reMDP8ohcjDgrjfUS6pnjblPWhwVFgg2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342620f50so29442565ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727556266; x=1728161066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9DhHbIR63gmvOumtrcegz/GcZHaECsxMzy9DdG8O6Y=;
        b=X2M3QA8y9ieBOPL9A/WOfrt5Os/TegJV6zmU8OMijQ3qj8tUy3ZxUH5uuCwh/T3i1K
         ZuJcFGG13QuI1jT1QxHXyicn/X9wJ3GjrOMLIti42wbndslEMXJwQ53Y3ZAvMZFqOQCM
         YPh7oXEOTryMG5iO3NMNb1uporUt96/0Su86KvQBnIWaxeIGI9NTnBLfRUMHAZ+21AfF
         6TpSaM/EUXSqCGBNlk5+ucRaCuIvtyP0e+atcmLCJZpUPeAyuUad5cuOuHUpd7VkcyXD
         pCmtas0WcbjUQjSCPlwCeMVPVaMuceB8YmWoD1KfUhCVf3+DwVxgEOmuiX9kPPN/piN8
         tR0g==
X-Forwarded-Encrypted: i=1; AJvYcCX9V2zdVhBPKZG3raSHOd5EbtoDuidDFWaWp7GpT3/pTSga1mcTEB4T75P5u1PKG6AyePveS0asftXfq/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxznzkC2YszchzCn9obnE3GYlJlwJpPF4OfQot2xeTuvxoiet
	Wbe+teEYa+naIWSqmUDZkaVVv0mXjP2tse0C+9Y4hKeCXAyPbr2r3fbGt2PvT/m5/ik5HX2Duey
	nnG1S2sOr2a9uwTnUOqPpdTHGlmDyJFZejzxpD9WYnFIpKvCjhRLd9e0=
X-Google-Smtp-Source: AGHT+IH9uy43cE84OGkK4+G7+6S+jrXHy7Ngr4SCn/n87lL0UH3lbuPaT/7/vfnruhVrQZPq7Ku79nf3YcR2E4xYE9xStjeZ2mAS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ca:b0:39d:4ef6:b36d with SMTP id
 e9e14a558f8ab-3a345166ea6mr58883555ab.7.1727556266161; Sat, 28 Sep 2024
 13:44:26 -0700 (PDT)
Date: Sat, 28 Sep 2024 13:44:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f86aaa.050a0220.4a974.000e.GAE@google.com>
Subject: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1603b107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1507aa27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d2c99f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2179ebeade58/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f05289b5cf7c/bzImage-abf2050f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fd7a8b92de34/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ocfs2_replay_truncate_records fs/ocfs2/alloc.c:5959 [inline]
BUG: KASAN: use-after-free in __ocfs2_flush_truncate_log+0x824/0x1250 fs/ocfs2/alloc.c:6054
Read of size 4 at addr ffff888045e6fac0 by task kworker/u4:3/41

CPU: 0 UID: 0 PID: 41 Comm: kworker/u4:3 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ocfs2_wq ocfs2_truncate_log_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ocfs2_replay_truncate_records fs/ocfs2/alloc.c:5959 [inline]
 __ocfs2_flush_truncate_log+0x824/0x1250 fs/ocfs2/alloc.c:6054
 ocfs2_flush_truncate_log fs/ocfs2/alloc.c:6076 [inline]
 ocfs2_truncate_log_worker+0xa2/0x1b0 fs/ocfs2/alloc.c:6089
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x4d pfn:0x45e6f
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001179b88 ffffea0001179c08 0000000000000000
raw: 000000000000004d 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5109, tgid 5109 (syz-executor412), ts 88738057363, free_ts 88913146991
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 folio_alloc_mpol_noprof+0x36/0x50 mm/mempolicy.c:2283
 shmem_alloc_folio mm/shmem.c:1774 [inline]
 shmem_alloc_and_add_folio+0x49b/0x13d0 mm/shmem.c:1813
 shmem_get_folio_gfp+0x5a9/0x20a0 mm/shmem.c:2335
 shmem_get_folio mm/shmem.c:2441 [inline]
 shmem_write_begin+0x17e/0x460 mm/shmem.c:3046
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4050
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5109 tgid 5109 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x64c/0x1cf0 mm/shmem.c:1032
 shmem_truncate_range mm/shmem.c:1144 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1272
 evict+0x4e8/0x9b0 fs/inode.c:723
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 __fput+0x5d2/0x880 fs/file_table.c:439
 __do_sys_close fs/open.c:1565 [inline]
 __se_sys_close fs/open.c:1550 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1550
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888045e6f980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888045e6fa00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888045e6fa80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff888045e6fb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888045e6fb80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

