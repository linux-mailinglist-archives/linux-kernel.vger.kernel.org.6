Return-Path: <linux-kernel+bounces-418226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034149D5ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBEC1F2397C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673D1DED78;
	Fri, 22 Nov 2024 12:30:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E01DE89E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278624; cv=none; b=obvO38ZbNM27YSnhni0YebEKZ192XHPD2KE7vHDofT71fVc4Fajr+GzXo94NtF/0y21vMxjYN2E7lL165V1+vCGJW0NtRJhMwsLK9pOcCFG80sIz4K8+/XjBG6x0Q1utYMbpMITC+XakUwRakiQ7rlfRKTrWUieHTAJCefazIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278624; c=relaxed/simple;
	bh=Ta4LWOAYmifgEgMEpvzPSbDgK5H/wnnf6jus3O2cwyA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MeH4GVWneauIB25sVCggYTlLnx1bJtHNO1jROqfmAcG7h+qPkwgWjIfpbdLZdHPbvgtWwZ9+yBj6Y2LNvKcICJO3lRXA+s2ZSAOWrnmr0/xNQBg0S8120v2L9ROF65IhS6M6XJC3yFRl6wAiEZGHq/Tz6f+yMbMUzxcixgpsj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so2268705ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732278621; x=1732883421;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOqc/c5AtZFJGOLYdxxC2IQ5MuNIHBaBOFpERzjyHnM=;
        b=lEzLLR8EkLtoSXpo+RedaG6mEzWnMKw4Ib+Yh9so2BYFs6BSk0v1yrCMgLoGrNa3yP
         BCSEoSKJjh4L30h/rvTD+mp07lex04QQPjIVukMLdPFdoB8NEU29qf8vEFE+fB4pt5E0
         WSGw7GIHbWxl7TyWl4jzBE7OWRyIFELCztWo5wTNg5PoaEGx2drhk/WRO6JRkU74/Gvv
         jXjOY2Dej6LqigG8r67v9m/H1jdiklQzW/A4h45tKxCZo8/DfYoW4ql/rT5ntqbxia9z
         YsfgIkewYIuVP7uCOMGiz/zqsqKmGAKX/GkQdW9d47BuuE6fFbiBZ6NV8MS4gXKW1Sv8
         Ovrw==
X-Forwarded-Encrypted: i=1; AJvYcCUyH/20EjHiXdrbAczV0uadwjzFtVDsA0gVofpaHE49ms8DlxcL6vZpnyQ84IKFyxHrM0NqIcrh/CksJTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCEW9FW7mfwEJzJkgqmF8ldQD7r9SMb9UKApAtRn/jM5Nu8IY
	HdofdT8W/Iel5zNCu8LWwWsFx7B3RcOuuH/BUhllf5Rorl9ARRwVK6gLc7bWjLuX2dRucRZA/rq
	ezSbc/uCYxELMimxwjaWbrr1SzCMhhZJgMMC4ju+qHfrPcAu8xgQ8szc=
X-Google-Smtp-Source: AGHT+IGHPAsldXCtvX4W7WDhmkeCyYZZs7TjqDgWhD8URAa13Ba9UxGxrmmfNRM+uUxdjZa9pxpeBI/TDBzJ8UNMaYuZi4q2fA/y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:3a7:708b:da28 with SMTP id
 e9e14a558f8ab-3a79afd9eb8mr29993325ab.21.1732278621239; Fri, 22 Nov 2024
 04:30:21 -0800 (PST)
Date: Fri, 22 Nov 2024 04:30:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740795d.050a0220.363a1b.013a.GAE@google.com>
Subject: [syzbot] [bcachefs?] [mm?] BUG: corrupted list in list_lru_add
From: syzbot <syzbot+092ef2e75c24d23f33c4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    adc218676eef Linux 6.12
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f6bb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31661728c1a4027
dashboard link: https://syzkaller.appspot.com/bug?extid=092ef2e75c24d23f33c4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132fb2e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-adc21867.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9304ecc29d43/vmlinux-adc21867.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a42cc9054b58/bzImage-adc21867.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1a34900bae57/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+092ef2e75c24d23f33c4@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (ffff88801f2a12c0), but was 0000000000000000. (prev=ffff88804264f098).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:34!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 79 Comm: kswapd1 Not tainted 6.12.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__list_add_valid_or_report+0xeb/0xf0 lib/list_debug.c:32
Code: 0f 0b 48 c7 c7 60 0e 61 8c 4c 89 e6 4c 89 f1 e8 8b b9 00 07 90 0f 0b 48 c7 c7 e0 0e 61 8c 4c 89 f6 4c 89 e1 e8 76 b9 00 07 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0000:ffffc90000e467d8 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff88801f2a12c8 RCX: b5af2eed7d4c4700
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: ffff88801f2a12c0 R08: ffffffff8174b13c R09: 1ffffffff1d02680
R10: dffffc0000000000 R11: fffffbfff1d02681 R12: ffff88804264f098
R13: dffffc0000000000 R14: ffff88801f2a12c0 R15: ffff8880426e0dd8
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91a5b18000 CR3: 0000000011d94000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 list_lru_add+0x1d2/0x390 mm/list_lru.c:98
 list_lru_add_obj+0x17b/0x250 mm/list_lru.c:118
 workingset_update_node+0x1af/0x230 mm/workingset.c:644
 xas_update lib/xarray.c:355 [inline]
 update_node lib/xarray.c:758 [inline]
 xas_store+0xb8f/0x1890 lib/xarray.c:845
 __delete_from_swap_cache+0x514/0xe20 mm/swap_state.c:159
 __remove_mapping+0x889/0x1390 mm/vmscan.c:764
 shrink_folio_list+0x2c50/0x8cc0 mm/vmscan.c:1467
 evict_folios+0x549b/0x7b50 mm/vmscan.c:4589
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4784
 shrink_one+0x3b9/0x850 mm/vmscan.c:4822
 shrink_many mm/vmscan.c:4885 [inline]
 lru_gen_shrink_node mm/vmscan.c:4963 [inline]
 shrink_node+0x3791/0x3e20 mm/vmscan.c:5943
 kswapd_shrink_node mm/vmscan.c:6771 [inline]
 balance_pgdat mm/vmscan.c:6963 [inline]
 kswapd+0x1ca9/0x3700 mm/vmscan.c:7232
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xeb/0xf0 lib/list_debug.c:32
Code: 0f 0b 48 c7 c7 60 0e 61 8c 4c 89 e6 4c 89 f1 e8 8b b9 00 07 90 0f 0b 48 c7 c7 e0 0e 61 8c 4c 89 f6 4c 89 e1 e8 76 b9 00 07 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0000:ffffc90000e467d8 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff88801f2a12c8 RCX: b5af2eed7d4c4700
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: ffff88801f2a12c0 R08: ffffffff8174b13c R09: 1ffffffff1d02680
R10: dffffc0000000000 R11: fffffbfff1d02681 R12: ffff88804264f098
R13: dffffc0000000000 R14: ffff88801f2a12c0 R15: ffff8880426e0dd8
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91a5b18000 CR3: 0000000011d94000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

