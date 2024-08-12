Return-Path: <linux-kernel+bounces-282982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FE94EB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A13282577
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097B170A2B;
	Mon, 12 Aug 2024 10:54:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34939170A22
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460062; cv=none; b=rH+/T4OEgo/Ic9zFHLIIpNgZCwfcXaZ4OQ0KIlc1eDmRF4tBIKWQqougeQx8plzkifZzFEqLOvCpmXuSBVpTLOLqXdd++GIINwk/1ddJKPxopBWABCUarYmJNigPT1OmW4XAfULhTbKXcrMNXGUAx9az5/Zd/SCfHADRYxAfxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460062; c=relaxed/simple;
	bh=G/lZ9ombagatQ35vOvVExPEWrHkr42hFmbyMRdiiiak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JspdtFKyoVNcYkxnD5zHLZ43nixR9ezwFMm1OUhLh/arTJJgOCRpKWIJJ44J9OGmgSnCPjrb4EsBeWmOGRljBuKm/CpkkcqNk27HXMOeX8T5Go5qNmm4yKy+M8A6V4CsTe8MKdaAjhUzZgQOwe9I1qY4HoA6FmfvYRqDB1HNcME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8edd731cso562629539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723460060; x=1724064860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg0oqJUjqzU4IhYLYe96BvNYUcfYgAO0WzHeXvUbP1A=;
        b=JNJTE7Xrs2BXd+VusOR9L/3ezcXFuKb1SEsyk5JSRe5ItDZAVH8xsENsq2em15owJe
         XRYIFAemolRsj4doz5caJaY2uGxlgKl+YaWRSqR7eUMdFnJLWvwoS6CxufGf8z3qZl6V
         +MGcq6PZgVybL4wnw/YBYXMxPgCULh9YVKtnZYgMbOShKiXQXVnLbSMy5vtAytQ0N626
         czJ229DcARw+hAfX6r1v9cgDFj/d02DHyd4yGydKegePEb443tCwrKrt4HXb/DrSDcYQ
         x5qon4IqGDep9OaGCl6H8YaiIEwR5AqAPU03qTjPV+TQ+H+492gbE5RvHCENi3a8rDvb
         bEag==
X-Forwarded-Encrypted: i=1; AJvYcCVFbD4m6yeLPP1ruCuZTzWJUFzx3yCO4bkyokufKmOgI4ysYoV5YiJH33VqTXyHM5FbXk22T39yvSpYVPbMXU7cifakuSYZe5aQrh6E
X-Gm-Message-State: AOJu0Yw4PnJ39YDyZv5WS6+okEwBwNZiZYsQ/uhvNGyB8RLKxf3DypVb
	dijKsoyyyxAWq5tBQ1w55qmE4xAocUsmvbRY3OPQJZbqJba6bDxwkZe3wIFtvqmUlGaatSrUka0
	6JerQ245FMsmcP/HN4A3NHTKqYzbYrRe6w1Xl7LaqfecJPMpYrn+9Lec=
X-Google-Smtp-Source: AGHT+IGqcP1s4Nr5m2Ta+vao0KWZN47zSEbkXNg+GcASwcyUe7/SAKll12zBDhX7D7S/cuS2irtm1CYMJ7CKc88yt+VouDhv9deg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411b:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4ca6eba4580mr422795173.0.1723460060188; Mon, 12 Aug 2024
 03:54:20 -0700 (PDT)
Date: Mon, 12 Aug 2024 03:54:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac2392061f7a501b@google.com>
Subject: [syzbot] [mm?] kernel panic: System is deadlocked on memory (2)
From: syzbot <syzbot+c61d6962d0b7e698439e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c626ce4bae1 Linux 6.11-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1494eced980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aeb08bd34fa0ed18
dashboard link: https://syzkaller.appspot.com/bug?extid=c61d6962d0b7e698439e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7c626ce4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9ff45c7e113/vmlinux-7c626ce4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f51045fd7afd/bzImage-7c626ce4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c61d6962d0b7e698439e@syzkaller.appspotmail.com

kmalloc-96              2344KB       2376KB
kmem_cache_node          225KB        228KB
kmem_cache               203KB        203KB
Out of memory and no killable processes...
Kernel panic - not syncing: System is deadlocked on memory
CPU: 1 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.11.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x3d/0x1f0 lib/dump_stack.c:119
 panic+0x6f5/0x7a0 kernel/panic.c:348
 out_of_memory+0x15de/0x16b0 mm/oom_kill.c:1170
 __alloc_pages_may_oom mm/page_alloc.c:3614 [inline]
 __alloc_pages_slowpath mm/page_alloc.c:4376 [inline]
 __alloc_pages_noprof+0x1d89/0x2460 mm/page_alloc.c:4713
 alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2263
 get_free_pages_noprof+0xc/0x40 mm/page_alloc.c:4747
 kasan_populate_vmalloc_pte+0x2d/0x160 mm/kasan/shadow.c:304
 apply_to_pte_range mm/memory.c:2797 [inline]
 apply_to_pmd_range mm/memory.c:2841 [inline]
 apply_to_pud_range mm/memory.c:2877 [inline]
 apply_to_p4d_range mm/memory.c:2913 [inline]
 __apply_to_page_range+0x795/0xdd0 mm/memory.c:2947
 alloc_vmap_area+0x93e/0x2a70 mm/vmalloc.c:2035
 __get_vm_area_node+0x17e/0x2d0 mm/vmalloc.c:3119
 __vmalloc_node_range_noprof+0x276/0x1520 mm/vmalloc.c:3801
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct kernel/fork.c:1113 [inline]
 copy_process+0x29f5/0x6f50 kernel/fork.c:2204
 kernel_clone+0xfd/0x980 kernel/fork.c:2781
 kernel_thread+0xc0/0x100 kernel/fork.c:2843
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x4ef/0x7d0 kernel/kthread.c:765
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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

