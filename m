Return-Path: <linux-kernel+bounces-297645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE895BBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CE2818F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622151CDA01;
	Thu, 22 Aug 2024 16:30:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A937708
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344224; cv=none; b=Het090JJ+JIi2y+6l/cnByVBHFV93tgP0EcW0yGMAqpkEcYT7VKd5tR56KJWAOmXpLX9FkChauqSRj7/+McYCvJ5i0wlJy9CadLTGVpTwpEdEaEjDQr4UwR0V+lq8VtRPnEXbUoqfo5kisCdG/8l5jOK3B//B+zHv7lg185Imio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344224; c=relaxed/simple;
	bh=BWdXtAcNwxzBNo16ZJtlU2rVrR/1hE9KXxAeaNMs/5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WpB1/hFoj7/mT9/WUSDI2gGwrnl+73zUvTCNYUEPikFatYDi3WHryuN6rmv+GQP5onsuBd2oVxwbwo1O/SEdkw8XI9EIwEA8fWcjbdWxICbx26hArmE3uvpWiwSzUr+Xr8X3/nDUP8UrpwmKHJvzyQK+OoO4s92itkbOu1TIdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d5537a62dso12189155ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344222; x=1724949022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qif1MudHsyBAV5aHIOp6JFKSCGppEIb74zgdeN0q9UQ=;
        b=KrIFfupASuyo1ZsifPC7YV7Y1rmJZrGXdqi1zmpwtrIpt/CdJo1ZBJr+fV9h+iXJl6
         L5PmKec4TZSdc22PYAknvlmGvCE7+jARDuXZd8nEyEdhF7ODsVfqbgchcgRKqlnOU/S1
         X3a9/OxigUdLlKSAHUpWxeuZzZTROIvHilVDJxsH2OVi+9voKoJssqSBbNZ9OQslCRP9
         h9LVZq04G1UtBg1/ttm7eCGgOS2q+tSm4QgldNbhD55Wf7VOSCRhiG2qRLIFpRgGkG65
         59BnVnciWC1x0OC0cjzchwrsa65oHrwgPZ9tUM8VY+fEoaDYiHjrM65P1RKsfUgarfLH
         nW6A==
X-Gm-Message-State: AOJu0YyBx7LayrEiMyE+hN3hGLNPbgW+je08lM/dhiJuerex7qegarAO
	RGJYVsB4/pUaBIcIstCUaRxjV53HjxBRso20Dy1dfhdXPuR9Zv8miO1mGqtG+MGRImqFJO2spdJ
	24F1zMigLllYRvoOAuB27AH/Wymj2MmNZYBJSfL+dGsvKzpmcCqe2pC0=
X-Google-Smtp-Source: AGHT+IH8EF9IDNcGlfrtK4R9MNHNZv+CoEMQ8NTiZOei98+9Yzo8NmwGrLgGRxYZ8qVYpGq7Rg0fmBQJBmNV7w48ArXZN+36BLKU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:39d:1d50:e6f9 with SMTP id
 e9e14a558f8ab-39e3a8adc24mr65235ab.4.1724344222145; Thu, 22 Aug 2024 09:30:22
 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:30:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4f46a0620482c7e@google.com>
Subject: [syzbot] [kernel?] KASAN: stack-out-of-bounds Write in __unwind_start
From: syzbot <syzbot+3fce94ba68be647848da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f2d783a459 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b0ddcb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=3fce94ba68be647848da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f2d783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d927f7c3cfd/vmlinux-c3f2d783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea54bdfad24b/bzImage-c3f2d783.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3fce94ba68be647848da@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
==================================================================
BUG: KASAN: stack-out-of-bounds in __unwind_start+0x3e/0x7c0 arch/x86/kernel/unwind_orc.c:688
Write of size 96 at addr ffffc900018373c0 by task syz.0.0/5109

CPU: 0 UID: 0 PID: 5109 Comm: syz.0.0 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 __unwind_start+0x3e/0x7c0 arch/x86/kernel/unwind_orc.c:688
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 vm_area_dup+0x27/0x290 kernel/fork.c:486
 dup_mmap kernel/fork.c:695 [inline]
 dup_mm kernel/fork.c:1672 [inline]
 copy_mm+0xc7b/0x1f30 kernel/fork.c:1721
 copy_process+0x187c/0x3e10 kernel/fork.c:2387
 kernel_clone+0x226/0x8f0 kernel/fork.c:2800
 __do_sys_clone3 kernel/fork.c:3104 [inline]
 __se_sys_clone3+0x2cb/0x350 kernel/fork.c:3083
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff7f27799b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff7f358ef08 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007ff7f27799b9
RDX: 00007ff7f358ef20 RSI: 0000000000000058 RDI: 00007ff7f358ef20
RBP: 00007ff7f27e78d8 R08: 0000000000000000 R09: 0000000000000058
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff7f2915f80 R15: 00007ffc51f8f378
 </TASK>

The buggy address belongs to stack of task syz.0.0/5109

The buggy address belongs to the virtual mapping at
 [ffffc90001830000, ffffc90001839000) created by:
 copy_process+0x5d1/0x3e10 kernel/fork.c:2217

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x45dba
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5108, tgid 5108 (syz.0.0), ts 82537916190, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
 __vmalloc_area_node mm/vmalloc.c:3653 [inline]
 __vmalloc_node_range_noprof+0xa40/0x1400 mm/vmalloc.c:3834
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1113
 copy_process+0x5d1/0x3e10 kernel/fork.c:2217
 kernel_clone+0x226/0x8f0 kernel/fork.c:2800
 __do_sys_clone3 kernel/fork.c:3104 [inline]
 __se_sys_clone3+0x2cb/0x350 kernel/fork.c:3083
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc90001837280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001837300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90001837380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f2
                                                                ^
 ffffc90001837400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001837480: f1 f1 f1 f1 00 00 00 f3 f3 f3 f3 f3 00 00 00 00
==================================================================


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

