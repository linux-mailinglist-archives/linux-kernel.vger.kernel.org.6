Return-Path: <linux-kernel+bounces-224772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6DE9126B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F0B28A559
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9E157492;
	Fri, 21 Jun 2024 13:29:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31D155C84
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976568; cv=none; b=PvArPdyBOIYYZOw243PhlqJP/al2w8k0szo8cUiov1FLpcWDa9L6pGCf/NrVCshDQvwNUobVBNvWesMmXMpiNrmKO5am8y8wiuTEtjNRS4GjR1vdVcVES/De7Tav6ZNckUYKpeaXAnA8gAYhihhtvovLkicTCHGn/J9HKMd+Im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976568; c=relaxed/simple;
	bh=khNKJsLz/RH/pfJ31TuLczD0XuPVntlTUwfDBUs/Ugs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BiZfIphFrcAHQ3F91rnO+1Za+4rPIfg7/UQGFAhGDEMhnkVNLHPYAij1PmqgyxWcpRF0dL5cNmbOf/jI60S+jSUYT2VFQiTLEQSDoXaWhnuUbVB51lONQvSUdjaMb+xnSQGBgAE8fldW/piSu+oL1dNiD80WrxRJqjQBqr2cQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3761dc437a8so20751855ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718976565; x=1719581365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvdA/SsRXrE6xVdQFqhRxTBWjGtXBJoDBpmL/pnaR+I=;
        b=PeI21T+Uc2QCiWmfaQLpgyICdrSYXYUgctaj+1M6sO9/DgSj0z4tpMT2IfuG03mtIr
         nE+3jfkx3FvSDAzGZ8RWwXyAgQnV/BE7ZswUCF3pjfgNboSu+YlHDTB39f4Io9g++N09
         B8aGhFulgqX7HlIQ59iq7MXeMiACnyiVWdz2SE3Cr2A/TEjzZe602zy1A7EhX47A7rrE
         cJICtXN2tpbqCl9dypKiuYyqrCCmSX0yyjC8Oq6n253OG/1cyc/tgH2RYH8byP0UXGX7
         NdVySVgjmRR/M9z+o0uIZrt4lFmaidKoIRKA3B6c2q9zdvFWPmaJpZWuGEHOj9NA7eJM
         oz1w==
X-Forwarded-Encrypted: i=1; AJvYcCXuLVeXIeYJwzOUHdLW5AXZ3PXcCX0Rsxfsgl+GL2Joz97ygFgvwuV+7dzAQws80IDLz66Ws4ZPmaftbf+GyhU24jl8m5oJyOHXzant
X-Gm-Message-State: AOJu0Yy7b7B0oemgiSIO6sLSFlaIYyeIjg3hJDR99Y0IoHOmW9o8ZzeD
	1o33QyqgbbV/2M9bUHDTGikOwPrGU7GAE2hsf4v6/9FGG6/CwmNNky0/opU0B+Fxaek9uc02wUP
	iVC9XBocqOJUMutQLMp78EPGrRZ17dgD7D/ATo5IaW1mbhsKbHnAnQC0=
X-Google-Smtp-Source: AGHT+IEaplbKZYeKrfy8nBz2m4IvWfYI/08J7F6gUpB9MJC0ToY7qxs9tzKO9XAlmBjtUQI6K5ru4/a2bQslJ70DwmIUfog8Food
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd85:0:b0:375:a535:f7ad with SMTP id
 e9e14a558f8ab-3761d4d7889mr4274335ab.0.1718976565283; Fri, 21 Jun 2024
 06:29:25 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d1e5a061b666b11@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in mtree_range_walk /
 rcu_segcblist_enqueue (2)
From: syzbot <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164ec02a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704451bc2941bcb0
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb7d0f2fdb4229b9d67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4cbed12fec1/disk-50736169.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d50b5dcae4cd/vmlinux-50736169.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2c14c5fcce2/bzImage-50736169.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mtree_range_walk / rcu_segcblist_enqueue

write to 0xffff888104077308 of 8 bytes by task 12265 on cpu 1:
 rcu_segcblist_enqueue+0x67/0xb0 kernel/rcu/rcu_segcblist.c:345
 rcutree_enqueue kernel/rcu/tree.c:2940 [inline]
 call_rcu_core kernel/rcu/tree.c:2957 [inline]
 __call_rcu_common kernel/rcu/tree.c:3093 [inline]
 call_rcu+0x1bd/0x430 kernel/rcu/tree.c:3176
 ma_free_rcu lib/maple_tree.c:197 [inline]
 mas_free lib/maple_tree.c:1304 [inline]
 mas_replace_node+0x2f8/0x440 lib/maple_tree.c:1741
 mas_wr_node_store lib/maple_tree.c:3956 [inline]
 mas_wr_modify+0x2bc3/0x3c90 lib/maple_tree.c:4189
 mas_wr_store_entry+0x250/0x390 lib/maple_tree.c:4229
 mas_store_prealloc+0x151/0x2b0 lib/maple_tree.c:5485
 vma_iter_store mm/internal.h:1398 [inline]
 vma_complete+0x3a7/0x760 mm/mmap.c:535
 __split_vma+0x623/0x690 mm/mmap.c:2440
 split_vma mm/mmap.c:2466 [inline]
 vma_modify+0x198/0x1f0 mm/mmap.c:2507
 vma_modify_flags include/linux/mm.h:3347 [inline]
 mprotect_fixup+0x335/0x610 mm/mprotect.c:637
 do_mprotect_pkey+0x673/0x9a0 mm/mprotect.c:820
 __do_sys_mprotect mm/mprotect.c:841 [inline]
 __se_sys_mprotect mm/mprotect.c:838 [inline]
 __x64_sys_mprotect+0x48/0x60 mm/mprotect.c:838
 x64_sys_call+0x26f5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:11
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888104077308 of 8 bytes by task 12266 on cpu 0:
 mtree_range_walk+0x140/0x460 lib/maple_tree.c:2774
 mas_state_walk lib/maple_tree.c:3678 [inline]
 mas_walk+0x16e/0x320 lib/maple_tree.c:4909
 lock_vma_under_rcu+0x84/0x260 mm/memory.c:5840
 do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 12266 Comm: syz-executor.3 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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

