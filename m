Return-Path: <linux-kernel+bounces-197809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930558D6F79
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A4D2841F2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C282876;
	Sat,  1 Jun 2024 11:28:33 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AA22081
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717241313; cv=none; b=TdVE0wB+dgNJ529N7mvY89bA1jZeSAGintqLR0aMHlxMeP/vtSmWQUCrOUjBVkLhgLB9So84clo1fYYBLKUFKe24zX85dGSGl4tL5zQ+j88J3+JqINqw03ZD3QA/QipjPmt/E/yZrZ00WnnZRlPxqDzecsOU9+vvIKmsbblM4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717241313; c=relaxed/simple;
	bh=KJ92Oc9PjxGJMQzb5SHHTnBXUatu39hQDfFdnjqr8OI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XXtHc6sN7OwV9nG5LNuis/BgxNq2HaEB2gZLBWkzfHA9BaBD94MGXiUoO7aZMoxZnnah00yipGBBRbae8a5f62uj0y09OXV69i4bmPncw66mJV3cJXc6oLWEXeonXcP9IXNR41vQEnSw2AXHMhvMu1MoPMeNcEHuB0OZak8Om7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3748f2cfdabso11149305ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 04:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717241311; x=1717846111;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En2iqL+LLgk7tp/ubjPEhkxL7xgNrkURqF9kOhTOYFk=;
        b=Nhb8b0FKEPqGdr2aqN6TfT4zln2GTVd5QJHBqlqe8v0S2Xcfsd3zUy4SaPK6YWUSRs
         JqLqdEAUxfHDzojKq8oePY3guggIRSKXSwNFi3Xxfv27wswN2KMxj2YariEFGgWoXBun
         ttUk0/X6RNSM1MTIQTEJnml2PRCD99vqRMyw68WMOXGtqT4sP+9He6CCcgs14wqhVzoa
         7Z6sSt3bOTqgRSD0aYcSeyyYsg0ZHjv4hbEV1csf6YW90ft3GiVz4kErsOuHPdz8ke8p
         hQmPyIS3oxPIzkkPCjJm82PmPdcS2tU7D/oewrIA7bx7f7OJh1rUuuciP7aAK0PPYjD9
         eJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWUCzmw2geRzaOonu5TEZN4ol16OvSpV3p7ZPGhhZlBQYQQBGVQRydRrnUTdzvhMxGhTEM+zKSrWKqhAW3LCi+MSommg79xoMP57bMh
X-Gm-Message-State: AOJu0YzgV7qWh/AZzcseYmP6eOXJcnWbWn1f1v3aDF+dXvX05rZ2hCbD
	quqEZ6zWRwAl3RWtK6r18aIZREBpp6y3Oh5Yg0lQTdfWrlwkhgogskJOW0jzHY5cW7nUMydXIwM
	1e+cCKnsG1qKXqv9GrhhTKhcBl9u14Ib4nQrwC1Waovm7nBVjiHHIIwA=
X-Google-Smtp-Source: AGHT+IGPbnUrJhSB5DJ8KCCYe+7oMpGqs34F4zsVNjADmy6/yvlDzcjG6mWistYI14R35//24/wmVmtWsppg1uKToeQ3GamxFGwo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d951:0:b0:374:968e:7ee3 with SMTP id
 e9e14a558f8ab-374968e8336mr130025ab.3.1717241310978; Sat, 01 Jun 2024
 04:28:30 -0700 (PDT)
Date: Sat, 01 Jun 2024 04:28:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055ad7c0619d266c8@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in free_unref_page
From: syzbot <syzbot+e2402985c6e53d251f8c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15eb1026980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=e2402985c6e53d251f8c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131db3ec980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2402985c6e53d251f8c@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address fef0000006705000
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047, ISS2 = 0x00000000
  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=0000000042650000
[fef0000006705000] pgd=18000000bfdff003, p4d=18000000bfdfe003, pud=18000000bfdfd003, pmd=18000000bfdda003, pte=0068000046705406
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3644 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: linux,dummy-virt (DT)
pstate: 21400009 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __stg_post arch/arm64/include/asm/mte-kasan.h:120 [inline]
pc : mte_set_mem_tag_range arch/arm64/include/asm/mte-kasan.h:196 [inline]
pc : kasan_poison.constprop.0+0x80/0x104 mm/kasan/kasan.h:478
lr : __kasan_poison_pages+0x50/0x80 mm/kasan/common.c:141
sp : ffff800089163b10
x29: ffff800089163b10 x28: 0000000000000000 x27: 0000000000100dc2
x26: 0000000000100cc2 x25: 0000000000000000 x24: faf0000006decbb8
x23: 00000000000000f9 x22: 0000000040000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffffc1ffc019c140 x18: 0000000000000001
x17: 0000000000000000 x16: 1e9e000000c8e3c1 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000000 x12: 00000000000702d1
x11: 0000000000000000 x10: ffff800081e3d1e8 x9 : 00000000000000f9
x8 : 0000000000000038 x7 : 0000000000000000 x6 : fef0000006706000
x5 : fef000000670503f x4 : 0000000000000040 x3 : fef0000006706000
x2 : 0000000000000000 x1 : 0000000000001000 x0 : fef0000006705000
Call trace:
 mte_set_mem_tag_range arch/arm64/include/asm/mte-kasan.h:196 [inline]
 kasan_poison.constprop.0+0x80/0x104 mm/kasan/kasan.h:478
 kasan_poison_pages include/linux/kasan.h:114 [inline]
 free_pages_prepare mm/page_alloc.c:1110 [inline]
 free_unref_page+0x10c/0x488 mm/page_alloc.c:2565
 __folio_put+0xb0/0x104 mm/swap.c:129
 folio_put include/linux/mm.h:1508 [inline]
 secretmem_fault+0x1e8/0x23c mm/secretmem.c:87
 __do_fault+0x3c/0x214 mm/memory.c:4562
 do_read_fault mm/memory.c:4926 [inline]
 do_fault+0x310/0x650 mm/memory.c:5056
 do_pte_missing mm/memory.c:3903 [inline]
 handle_pte_fault mm/memory.c:5380 [inline]
 __handle_mm_fault+0x4d0/0xc20 mm/memory.c:5523
 handle_mm_fault+0x68/0x27c mm/memory.c:5688
 do_page_fault+0x168/0x480 arch/arm64/mm/fault.c:613
 do_translation_fault+0xac/0xbc arch/arm64/mm/fault.c:690
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:826
 el0_da+0x6c/0xb8 arch/arm64/kernel/entry-common.c:580
 el0t_64_sync_handler+0xb8/0x12c arch/arm64/kernel/entry-common.c:733
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: b5000247 eb04043f 54000203 d503201f (d9201400) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b5000247 	cbnz	x7, 0x48
   4:	eb04043f 	cmp	x1, x4, lsl #1
   8:	54000203 	b.cc	0x48  // b.lo, b.ul, b.last
   c:	d503201f 	nop
* 10:	d9201400 	stg	x0, [x0], #16 <-- trapping instruction


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

