Return-Path: <linux-kernel+bounces-181695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB508C7FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A422840B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754E8479;
	Fri, 17 May 2024 02:19:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918379CC
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912345; cv=none; b=sG404FMTnIWdHribOYC7ulGGZgdVdgc0Bqhm19T4x14XIuIIlON6feJ+nvLTX/sH3kw2C/QIPD+trSnfi8nB/r+MvGb3QyKx0o8HqXAAKVuH39CKEtn0bvI7A7MitFOL0GUyD1kYccz/60EFBHPzPNnS2SL8wba9XfntXVm84ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912345; c=relaxed/simple;
	bh=GGRy+cjfetsaBJ23i7SfoU896koCisAxdkrCsxNqrPI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q7IlwzDwp5COLUTebZ2EJmpqlTjk1HyrD8rylxXsGMIc5xfWBLZfvBW7ZsUpIzXFA3REet9Eh0hVwhygLP0uK9DOArbwegqPommUjbYQ6HMedEqxH/MZiNGeHsytmV9VYo1c486ihPa3RLa38Lckjl4u/dx/R9AKGsMDaQFFgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so675547939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715912343; x=1716517143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcN1cV+tgpvBKDhznmDzaqGzE/2sUMkIEd2nbtaLxPo=;
        b=S+Mx3IwT+2riSHWJi/ivU/ChRlF7KVL+K8ZmLdE8v6vFLzWHL3blywQp6STVtTSgDn
         Ua7Zsm3mQTvfYxeSPFaFgaTN9YTZtIc34nyJt3OSvtm0L/1tImGS+nr/WJJq6LUno/OF
         wEVoQKieNvrSV9LRYZ+OUhFn1StC7bmsupKAADMlkI8RmdiB34hbyUoEBuhYith++8E7
         hF2DNzWTFglpPZWJn2YBufuizkJ2B6BkiRodoTQJgZqguuzSatNzxlVMnN08FTu75DuB
         tMKgodY9Jbx8b0NbvT6HvpSKKfkpMcDlrkLvQkSQqAg+//S9f7v0zg9tOkbH8W7yWgS4
         R3aQ==
X-Gm-Message-State: AOJu0YyLx3hUDGDcPwCTYGJR020VRWFxpAdRJnCHc+v/PukeIccZyhCq
	ttRMzD5Q7QT/KkHdoch9uQCsEdzFJJV49tKwP2yi0iWsaYgKuV+twlIA3GY85d39aXFQ5LrfoDX
	tgsqE5LEdCFYVZXolKx+nGBNJrzSOnCKY4nSE+P30p2XcOZXusXCVZEs=
X-Google-Smtp-Source: AGHT+IFCW5GoHocn6Q9sdas1DjNZZZyzqXLIvZ6+ntpd3abwwOfUOWWY7ePow6qV9jc8svGUrYccLWR/CmTIH1rWUky1JEchYNS4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:488:5ceb:9533 with SMTP id
 8926c6da1cb9f-48957ec306dmr1267884173.0.1715912342917; Thu, 16 May 2024
 19:19:02 -0700 (PDT)
Date: Thu, 16 May 2024 19:19:02 -0700
In-Reply-To: <20240517020336.158640-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa66a806189cf969@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
From: syzbot <syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in jfs_readdir

loop0: detected capacity change from 0 to 32768
lv: ffffc900028520b0 offset:0 diWrite
lv: ffffc900028520b2 offset:6 diWrite
lv: ffffc900028520b4 offset:0 diWrite
lv: ffffc900028520b6 offset:0 diWrite
==================================================================
BUG: KASAN: slab-out-of-bounds in jfs_readdir+0x1b79/0x4660 fs/jfs/jfs_dtree.c:2894
Read of size 1 at addr ffff888076df3d15 by task syz-executor.0/5492

CPU: 0 PID: 5492 Comm: syz-executor.0 Not tainted 6.9.0-rc5-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 jfs_readdir+0x1b79/0x4660 fs/jfs/jfs_dtree.c:2894
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8966e7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f89669ff0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f8966fabf80 RCX: 00007f8966e7dea9
RDX: 000000000000005d RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007f8966eca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8966fabf80 R15: 00007ffe3b2048e8
 </TASK>

The buggy address belongs to the object at ffff888076df3780
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 1429 bytes inside of
 allocated 2240-byte region [ffff888076df3780, ffff888076df4040)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76df0
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802aef9f01
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff8880197418c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800d000d 00000001ffffffff ffff88802aef9f01
head: 00fff80000000840 ffff8880197418c0 dead000000000122 0000000000000000
head: 0000000000000000 00000000800d000d 00000001ffffffff ffff88802aef9f01
head: 00fff80000000003 ffffea0001db7c01 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5490, tgid 1905245577 (syz-executor.0), ts 5492, free_ts 87323640300
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x253/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 jfs_fill_super+0x408/0xc50 fs/jfs/super.c:544
 mount_bdev+0x20a/0x2d0 fs/super.c:1658
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
page last free pid 4525 tgid 4525 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 lsm_file_alloc security/security.c:649 [inline]
 security_file_alloc+0x28/0x130 security/security.c:2709
 init_file+0x99/0x200 fs/file_table.c:152
 alloc_empty_file+0xb8/0x1d0 fs/file_table.c:206
 path_openat+0xfb/0x3240 fs/namei.c:3785
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432

Memory state around the buggy address:
 ffff888076df3c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888076df3c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888076df3d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff888076df3d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888076df3e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         ed30a4a5 Linux 6.9-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ba37b8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=aa6df9d3b383bf5f047f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a532e0980000


