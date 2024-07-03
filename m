Return-Path: <linux-kernel+bounces-240021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E324926807
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74D41F247AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78283186E32;
	Wed,  3 Jul 2024 18:22:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704E187570
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030943; cv=none; b=jFT67wKPpezm/xisPib5EpaOIhmPMOCICgCfUVvAg50dgxfaGiY4PdT2VTa3+jZ3D20dd02xnCJDPXKjw7m6sIkgL9/0ihvywjMzaHNYZbJWINyeJgcn8lcSvUmkPLg8kbJGw7hBpS9EzdLwYc7lc5byZ4wWfp0VQKqP5ORLfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030943; c=relaxed/simple;
	bh=uKe2F9rNZyZEwj9FHDYjNqNJvzOsUDBrDuDHcq0+jb4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DHevrVANtlfsyFqyJX7Da1NyamMHmsbiahKziuhfpohCTGktYU2U1QaSxxkxqIN4Yig/bE+GWJX5hBI/oXprTYRJmoCXT3ncJX6Y9iQTSQmacjOrxAFQ23F9sjcNeY52eAXbZnx0mfJWaWVV3cXSUxqbWZfKhRcB2TglIAjiBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2d068abso640539739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030941; x=1720635741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KyXFXhAyuwtLud71f6xhy8+CPePm2HmjgI8P3IuNcg=;
        b=CIdtWOaBwI3XxXVu+C26K3YfVUt8cQSRJFIXe4J7Lw5QXWapTxVCS+B5DTwN5thIs5
         vHXsqabKzdBPaDbWVC/1AGrVijb7JBBtCwR/DAn3oIRrEQeoE83HThJqdHxU6uBB+jzC
         BkVjOU9q3IKUJtFaIlQwW8mhKVEv6/0cQtGn61tO3TMK7EcCX1CMtACq0ADBeO6B3x5r
         NjEOBYo96BS3gJQMTd+tEpWyYljrcWUKyz+EwyO8DF8HBOpBpABtmCib9B20pNwQDrw1
         pH8FdGRUzyGWP9o86698INA2DGmpHDqtJ8kfPr0cjiO4W5wwIyMWPWh3LSLNxiNkLCO1
         3sTw==
X-Forwarded-Encrypted: i=1; AJvYcCUhVLl7NmAfJG91OZ718HZrgdUTeeE3teZAHi2azd1k8XugnhBA8xdPtmtvXM5SAsDpmg5Kgl1MVer1Sj8bKY2yvMaC8Am/sGwJmHbH
X-Gm-Message-State: AOJu0Yzm6o30AhiloLmDU9BTFEBcYmg6wKSizRcoKxb1BfmsNrqAj0uE
	EMgSYF7bMgPbMwbSz/ftPhVhBSZyMyFD0hHRWbozR3rM2aBmYMIUZcaptwocrm2/SD4cVRnzQCd
	Qkug4m3frmwuSuCNhCxu3zcROyMVZOB5kMMAvVDp3ngZSPyJtOvSGYx4=
X-Google-Smtp-Source: AGHT+IF6QDGX/2PiuaF8lOvDYLyIalDjaAbJ26qZ/xkpl/LX+YzZZObwkNwiHE4x9V3wn9xizNXvlZxcmV00wqaRgRuX9N1mGnk5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c2:b0:7eb:80e5:b5ca with SMTP id
 ca18e2360f4ac-7f62ee763camr93639339f.2.1720030941658; Wed, 03 Jul 2024
 11:22:21 -0700 (PDT)
Date: Wed, 03 Jul 2024 11:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047cef3061c5be92d@google.com>
Subject: [syzbot] [kernel?] WARNING in follow_pte
From: syzbot <syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    734610514cb0 Merge tag 'erofs-for-6.10-rc7-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d97066980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c21fa9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16008dc6980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-73461051.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d390d5c7156f/vmlinux-73461051.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b56ef48ffa7e/bzImage-73461051.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:5980
Modules linked in:
CPU: 3 PID: 5192 Comm: syz-executor340 Not tainted 6.10.0-rc6-syzkaller-00055-g734610514cb0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rwsem_assert_held include/linux/rwsem.h:195 [inline]
RIP: 0010:mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
RIP: 0010:follow_pte+0x414/0x4c0 mm/memory.c:5980
Code: bf 98 01 00 00 be ff ff ff ff e8 e7 76 15 09 31 ff 41 89 c4 89 c6 e8 1b 0c bc ff 45 85 e4 0f 85 80 fc ff ff e8 0d 11 bc ff 90 <0f> 0b 90 e9 72 fc ff ff e8 ff 10 bc ff 90 0f 0b 48 c7 c7 d8 73 e4
RSP: 0018:ffffc900032af4d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00007f9c68e60000 RCX: ffffffff81d1d2f5
RDX: ffff88802306a440 RSI: ffffffff81d1d303 RDI: 0000000000000005
RBP: ffff8880209db5d0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000010a R12: 0000000000000000
R13: ffffc900032af530 R14: ffffc900032af550 R15: ffff88802abf1c80
FS:  00005555908da380(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000c80 CR3: 000000002cfae000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
 get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
 untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
 unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
 zap_page_range_single+0x326/0x560 mm/memory.c:1920
 unmap_mapping_range_vma mm/memory.c:3684 [inline]
 unmap_mapping_range_tree mm/memory.c:3701 [inline]
 unmap_mapping_pages mm/memory.c:3767 [inline]
 unmap_mapping_range+0x1ee/0x280 mm/memory.c:3804
 truncate_pagecache+0x53/0x90 mm/truncate.c:731
 simple_setattr+0xf2/0x120 fs/libfs.c:886
 notify_change+0xec6/0x11f0 fs/attr.c:499
 do_truncate+0x15c/0x220 fs/open.c:65
 handle_truncate fs/namei.c:3308 [inline]
 do_open fs/namei.c:3658 [inline]
 path_openat+0x2860/0x2e50 fs/namei.c:3813
 do_filp_open+0x1dc/0x430 fs/namei.c:3840
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f31b1f21859
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4ff07208 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f31b1f6a0de RCX: 00007f31b1f21859
RDX: 0000000000000300 RSI: 0000000020000c80 RDI: ffffffffffffff9c
RBP: 00007f31b1f6a0bc R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f31b1f6f07c
R13: 00007f31b1f6a07c R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

