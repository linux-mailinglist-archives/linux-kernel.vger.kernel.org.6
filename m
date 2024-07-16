Return-Path: <linux-kernel+bounces-253239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E982F931E79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955591F21DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18BB653;
	Tue, 16 Jul 2024 01:24:21 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37576AB6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093061; cv=none; b=PvIYx6Ah7YDaSDxJyUo8GHfBzz1BsblMld4jYnUj8q7HiQEG76fzHhFNV65aNZyk+ggLNYmUZQvfJ3jsY5Tpk0J8C8/KjHa9YJAuAox5PkD9ybLoT4mkC5sZCA0AX9flps1U39kU9x7vXJTKEqliMxbBLIVrPKRDEKkJygE52IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093061; c=relaxed/simple;
	bh=W9TsPOaNOpeLCT4P/6Yy58r2D5pyjibtiOyZDxaI2Ec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KfEjyBCSMTYq5BOJWtWJPN0yYgQ6UYev7w9Zx1vEuoAM+B3dLzYGPISkzFRC9TUIFwnTWt07bK1vF7VCEy+vlGSPWE9OrmuUX4uAynZYKYrvZiNTgw/+ZopIA59IxSccfGfx57rmky0tYb7Eg28yQfrTYx9ha9l+/LuRNEXh1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8148c1e1b93so126584739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093059; x=1721697859;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1jdDRholM9EepsL+0xg7kaxNq62fGRtensDICnpZM0=;
        b=WfrlVcbnflmxg0iuqzCNIcEtgzLHBvvsE+TVnBMxz0PP5FiIXL86AqLLCzm+V9wqnN
         l9Sgm+k/umTTp2VlZSSjLe/az79QGfKBnnLEeEJp6duyO+9TKLf35PENQwrYEh3d+Sjf
         IMeixsSTVQ6mI7PV3MtfXXP4L9cG2iHznsacOxaTMtxJsSr12ksHLYEg9BXe0KHpfUex
         XYBogrF6iBltJveATJooYrmH/vb+mFP3s8N4deDWTk9sIrh/EMX07ilmk7jRhuhXwKzF
         fs3ZwOMEYgrsjfKuak5kQWc4amZw1Jag+NdPOuBRa6Gf5FXXl4pPBQ+YRXB3O31b9MDU
         C6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmtryhrO961cFHaQGSheHOuU2tYmd6R3OZGqZDxuiG/MFCzf+V/IwnjPE7J2EUk5EpDHjBJcOv/9ItB0daf7wNbGYxyddbVKKonvvu
X-Gm-Message-State: AOJu0Yy+Q2tc/R3L65bb1bymwgxqCiLvABNYHiCVNpxTsaXzmxwhFiRM
	x3gVVND4bMxiH/fZ9zVizPofXspd0B6tLW9oPKJWQarGJwrC/U47EnyBBEwIWFsJqyot2P8Z2ch
	slXkb7w0clSHUfr+J68lyq6a/THd+KqcOS/8HS6pR+pZr0k4R1Z6UZaI=
X-Google-Smtp-Source: AGHT+IGf16D/B4Kjka1OQkTHk05/YFIT4L+PoN2xb/acIFvBPs+Z4b7wncMr4Qgam08fUwdz0vLVD3k3jkPrmbU8GMM3h0seOoA1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8602:b0:4bb:5dc8:5a77 with SMTP id
 8926c6da1cb9f-4c204401ce6mr59427173.0.1721093059093; Mon, 15 Jul 2024
 18:24:19 -0700 (PDT)
Date: Mon, 15 Jul 2024 18:24:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069b4ee061d5334e4@google.com>
Subject: [syzbot] [mm?] BUG: sleeping function called from invalid context in vma_alloc_folio_noprof
From: syzbot <syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aleksandr.mikhalitsyn@canonical.com, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ba9149980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=a3e82ae343b26b4d2335
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144c4b66980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163c28f6980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz

The issue was bisected to:

commit ca567df74a28a9fb368c6b2d93e864113f73f5c2
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Jun 7 20:47:08 2020 +0000

    nsfs: add pid translation ioctls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1073805e980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1273805e980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1473805e980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com
Fixes: ca567df74a28 ("nsfs: add pid translation ioctls")

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5092, name: syz-executor156
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 5092 Comm: syz-executor156 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8526
 might_alloc include/linux/sched/mm.h:337 [inline]
 prepare_alloc_pages+0x1c9/0x5d0 mm/page_alloc.c:4503
 __alloc_pages_noprof+0x166/0x6c0 mm/page_alloc.c:4721
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 folio_alloc_mpol_noprof mm/mempolicy.c:2281 [inline]
 vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2312
 folio_prealloc+0x31/0x170
 wp_page_copy mm/memory.c:3342 [inline]
 do_wp_page+0x11cc/0x52f0 mm/memory.c:3734
 handle_pte_fault+0x1138/0x6eb0 mm/memory.c:5545
 __handle_mm_fault mm/memory.c:5672 [inline]
 handle_mm_fault+0xff1/0x19a0 mm/memory.c:5837
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f3a8171eb80
Code: 84 dd fe ff ff 4c 89 e7 e8 ed 90 00 00 e9 d0 fe ff ff 0f 1f 84 00 00 00 00 00 49 8b 06 48 89 45 00 48 85 c0 0f 85 85 00 00 00 <c6> 05 49 25 0a 00 01 31 c0 87 05 19 21 0a 00 83 f8 01 0f 8f 84 00
RSP: 002b:00007ffc347a4150 EFLAGS: 00010246


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

