Return-Path: <linux-kernel+bounces-335617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7697E81A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA221C20CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD11946C4;
	Mon, 23 Sep 2024 09:04:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729F433D5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082265; cv=none; b=i7n3yZnUvR2jVxnOgKW0rM91Czztyq+iNP+VsIxb0Osdg3phdKHt9tVIexYzfw/d+DsL/LJQoVhf4/iacg6hfG3L2Fhtgdd5K1qWtnpLYrzn9tRce/qMTrh+xT49jdng3okpaENNZsjTh8AgXOPRHdb8i6Ixdft/PBScpDEWJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082265; c=relaxed/simple;
	bh=4SOtOMHRiPPLQwfLzNtHh+eKsRjt/WO55THE9mWirJE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rKsb3TX+T9YxdXYGAuFd/TBW37oZPHCuEL+Z6Hvdv6xupZ/Z0BJ9N+4HWGytmw6ElY5nNuI78LzIzXgR3jU+ddMV2v9eVDoYPP/Oi6wOJmfmWQ5rjhpCCmoILlM59ae3C6lzEiLdVB9QOCY/tTgLz9ZgU2ZX6Do6L2aDM/MURto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso46931755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082263; x=1727687063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3XR/KQVBqx5XPBRNaThL/HSWPR06wpijJ0YxxBlRD8=;
        b=T4j0bPrJtuvOByaDsr0jDdp7diyCDKhwoGM9hTcNtbbVbyub1JQAgXO53BwZWIySEa
         vTpwgTdqa63eE4nvLovo93VFqpGF5ijn1qrDqV8wwcLswYE3vkk8CkJBfDfJcYiJjG2n
         JnZKAn35UgHEz59CRCzFO5J13GtVP3ciUtN4t9AhQRXeI710upA/F7Eoq54jDj3s+2jL
         A9r9+DGG4wR91AH71PDnLdGwVrBrA37Xe5MrWW+050BffjkGqIcZhpPOsXJ9ih8VJdfL
         84NmMgHuYLOCVLbXPOwDzssDwu7bXa4pu9gXNsg0C8T/5qpHzldxK2uHFPR5Da0q5258
         +DzA==
X-Forwarded-Encrypted: i=1; AJvYcCVtxyv4Lrn4WT+Dbwp4HNMn6Jl3DaLA+9PgVtTEkjpIyD3X3aTre4klRL8+R8gOUQLiXuBg/eR1F9b3/E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrzz4p52zVaAzu1HuuV6LhygJX2a9a5JqG5L3Tm7QOR/slcRdr
	d791ecmH9q+8fPWhwQ4P0EaDyE74LNx1QCVAg616gwypyAWX/8lhz2OilPI8HQizc8PHAiHyqGr
	wPzlzaCn9Ya+xJ2ZR3wYQOwSUlAllIVvad4gKjRM+eSWD20gi4QWNpd8=
X-Google-Smtp-Source: AGHT+IE2MfuhBEO+96vpFxQsIfSsYLm/JIKNgKYBj+kD1X0L2ABf02gvI6RIJpT2Q9Cc9B4us2q/9IrU+IUymUuSu6pXwqidttMl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:b0:3a0:933d:d307 with SMTP id
 e9e14a558f8ab-3a0c9cfc785mr96358385ab.8.1727082263594; Mon, 23 Sep 2024
 02:04:23 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:04:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12f17.050a0220.3eed3.000b.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in mas_wr_store_entry / mtree_range_walk
From: syzbot <syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1237ec27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6702f5f2b8ed242
dashboard link: https://syzkaller.appspot.com/bug?extid=e01fa33e67abb0b3b3bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95bba355b2ed/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75966f4e5286/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f1578876250/bzImage-88264981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mas_wr_store_entry / mtree_range_walk

write to 0xffff888114555710 of 8 bytes by task 9573 on cpu 1:
 mas_wr_slot_store lib/maple_tree.c:3889 [inline]
 mas_wr_store_entry+0x146b/0x2d00 lib/maple_tree.c:4075
 mas_store_prealloc+0x6bf/0x960 lib/maple_tree.c:5520
 vma_iter_store mm/vma.h:470 [inline]
 commit_merge+0x441/0x740 mm/vma.c:609
 vma_expand+0x211/0x360 mm/vma.c:1024
 vma_merge_new_range+0x2cf/0x3e0 mm/vma.c:963
 mmap_region+0x887/0x16e0 mm/mmap.c:1416
 do_mmap+0x718/0xb60 mm/mmap.c:496
 vm_mmap_pgoff+0x133/0x290 mm/util.c:588
 ksys_mmap_pgoff+0xd0/0x330 mm/mmap.c:542
 x64_sys_call+0x1884/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:10
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888114555710 of 8 bytes by task 9574 on cpu 0:
 mtree_range_walk+0x1b4/0x460 lib/maple_tree.c:2779
 mas_state_walk lib/maple_tree.c:3601 [inline]
 mas_walk+0x16e/0x320 lib/maple_tree.c:4948
 lock_vma_under_rcu+0x95/0x260 mm/memory.c:6224
 do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

value changed: 0x00007f8311576fff -> 0xffffffff8529a680

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 9574 Comm: syz.0.2084 Tainted: G        W          6.11.0-syzkaller-08481-g88264981f208 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

