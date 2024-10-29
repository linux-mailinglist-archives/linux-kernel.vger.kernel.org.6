Return-Path: <linux-kernel+bounces-387434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F529B514C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E41C225BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667171D8E0F;
	Tue, 29 Oct 2024 17:49:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40A2F56
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224163; cv=none; b=arULs5LJTOEGqmZv5uRz6aR44L1ar5SBA8kgrQW6AUkU6EH9L28R1Z5hwhZMdeHKpx8LzjARYVbTSP9EbL46spUIVD5bghwhRZDKBaFGFA54E3PYl5RTM/uYe/u2yaVd55PvphfdbEfLufgEU50vXozNqSPz0oK6ID3/f78Dit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224163; c=relaxed/simple;
	bh=v9FcYbdc8oNUuLYBmqu+05VscTa0cr3dZnDMafd9WCc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LJEIvPUA2D/P2TWUNNSL1V6E8W4wPTnyUNBm7O05TezXJz5STShx/O77pUrT/WbSjkQx63CQAMfTfw5ih1Ilw2ii50FTfkw4+kqoouyebzar7/gQQH3S78E1k5Kej9cbOICpiP/eSfcj0yimgLNily+IAW1XiYSIkX8Sh0Ijxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a5b2ec15a9so4835475ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224161; x=1730828961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQrusRNJf38zUHFOuTpNiEov4y+QOY79xt1z6RqcII=;
        b=Flrk4y+WS/1D3g9KOosat2dxyETYrL9XsezkslarjfDhdbOSZNMzsx4ftMfntGS5Bp
         KMOnG8iZOgMf2hTOw38Nvym0Khw3V8356Bv+vDtN6WNCvKQIxfWiNs2gwDWYMILMVYEA
         3spL6opI1hyTXYCC/KVOZmFRVQUA7e0T+B2Q7ym04nuSWgCoaoxq7fhI6tfr/d1XD52l
         I54PiFP5iC4DebVt4WlOeXtcmMa3NO/OyJ+c/SYwfYliXqyOiI7R1xgQ2gtqmmAAUq46
         MS4s7nL0BdOJjO1nrqXL+SmbjcThZk7JgSWNTxqZxIfmOhG/6JdzqlRhXmRqNfxtvIHE
         xn7w==
X-Forwarded-Encrypted: i=1; AJvYcCUKfo36Eb3UHnm0OhiR0yFfJ1XFCTX5Bj+Xh0dmfMVo9Wbef0LsfkzNoPlheNWEZRkXYGCHPQ+ajFN78Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDAx8MFORYMS1MsPyGl9EsR8IVxzx49dE8l1fgEVZcgZzCpOH
	W2IGt82J/k42iN3l4KPC9ykbsawghkeFEvDDzKSwtlWHcH5SzgME4XvmyZ94AYpFlQ22SvOs+cb
	VFemk0LSn7GB8VtqA3iNVQGJlwjkZjYcUYZ8HjsqJgiHSciNYwaExfvY=
X-Google-Smtp-Source: AGHT+IExR9jQugmuJZ8ciAXnBAqg6k0PWbBbV+h/n6DjFo47ur9I5gL7bxe/jnCs+87FpMxOquNdOcvZ5t9VE+ULDhiScv2U7hNx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3a2:7651:9867 with SMTP id
 e9e14a558f8ab-3a4ed2b28damr128429795ab.13.1730224160879; Tue, 29 Oct 2024
 10:49:20 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:49:20 -0700
In-Reply-To: <66f6bfa7.050a0220.38ace9.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67212020.050a0220.11b624.04c4.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170b064b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108b064b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a5f0e7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e2253169da8/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9d2f5008f24/bzImage-e42b1a9a.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/1da7d3546e21/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/019e0246868a/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com

(kworker/u4:4,1025,0):ocfs2_read_blocks_sync:112 ERROR: status = -12
(kworker/u4:4,1025,0):ocfs2_read_locked_inode:521 ERROR: status = -12
==================================================================
BUG: KASAN: slab-out-of-bounds in ocfs2_check_dir_entry fs/ocfs2/dir.c:321 [inline]
BUG: KASAN: slab-out-of-bounds in ocfs2_dir_foreach_blk_id fs/ocfs2/dir.c:1784 [inline]
BUG: KASAN: slab-out-of-bounds in ocfs2_dir_foreach_blk+0x1ab6/0x1b20 fs/ocfs2/dir.c:1912
Read of size 8 at addr ffff888040701778 by task kworker/u4:4/1025

CPU: 0 UID: 0 PID: 1025 Comm: kworker/u4:4 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ocfs2_wq ocfs2_complete_recovery
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ocfs2_check_dir_entry fs/ocfs2/dir.c:321 [inline]
 ocfs2_dir_foreach_blk_id fs/ocfs2/dir.c:1784 [inline]
 ocfs2_dir_foreach_blk+0x1ab6/0x1b20 fs/ocfs2/dir.c:1912
 ocfs2_dir_foreach+0xb4/0x100 fs/ocfs2/dir.c:1923
 ocfs2_queue_orphans fs/ocfs2/journal.c:2186 [inline]
 ocfs2_recover_orphans fs/ocfs2/journal.c:2270 [inline]
 ocfs2_complete_recovery+0xcf1/0x25c0 fs/ocfs2/journal.c:1351
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 __kernfs_new_node+0xd8/0x870 fs/kernfs/dir.c:624
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 __kernfs_create_file+0x49/0x2e0 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
 create_files fs/sysfs/group.c:76 [inline]
 internal_create_group+0x7a7/0x11d0 fs/sysfs/group.c:180
 sysfs_slab_add+0x157/0x290 mm/slub.c:7104
 slab_sysfs_init+0x66/0x170 mm/slub.c:7184
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888040701690
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 56 bytes to the right of
 allocated 176-byte region [ffff888040701690, ffff888040701740)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40701
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff888030407dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 22332972406, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 __kernfs_new_node+0xd8/0x870 fs/kernfs/dir.c:624
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 __kernfs_create_file+0x49/0x2e0 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
 create_files fs/sysfs/group.c:76 [inline]
 internal_create_group+0x7a7/0x11d0 fs/sysfs/group.c:180
 sysfs_slab_add+0x157/0x290 mm/slub.c:7104
 slab_sysfs_init+0x66/0x170 mm/slub.c:7184
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888040701600: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff888040701680: fc fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888040701700: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                                ^
 ffff888040701780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888040701800: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

